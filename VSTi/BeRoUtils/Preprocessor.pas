(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2010-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * 
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * 
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgement in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 * 
 *)
unit Preprocessor;
{$IFDEF FPC}
 {$MODE DELPHI}
 {$WARNINGS OFF}
 {$HINTS OFF}
 {$OVERFLOWCHECKS OFF}
 {$RANGECHECKS OFF}
 {$IFDEF CPUI386}
  {$DEFINE CPU386}
  {$ASMMODE INTEL}
 {$ENDIF}
 {$IFDEF FPC_LITTLE_ENDIAN}
  {$DEFINE LITTLE_ENDIAN}
 {$ELSE}
  {$IFDEF FPC_BIG_ENDIAN}
   {$DEFINE BIG_ENDIAN}
  {$ENDIF}
 {$ENDIF}
{$ELSE}
 {$DEFINE LITTLE_ENDIAN}
 {$IFNDEF CPU64}
  {$DEFINE CPU32}
 {$ENDIF}
 {$OPTIMIZATION ON}
{$ENDIF}

interface

uses Classes,SysUtils,UCS4,UTF8,StringTree,PreprocessorGlobals;

function GetFileContent(fn:string):string;
procedure ProcessPreprocessor(var Instance:TInstance);

implementation

{$hints off}
function GetFileContent(fn:string):string;
var fm:byte;
    f:file;
begin
 result:='';
 fm:=filemode;
 filemode:=0;
 assignfile(f,fn);
 {$i-}reset(f,1);{$i+};
 if ioresult=0 then begin
  setlength(result,filesize(f));
  if length(result)>0 then begin
   {$i-}blockread(f,result[1],length(result));{$i+}
   if ioresult<>0 then begin
    {$i-}closefile(f);{$i+}
    filemode:=fm;
    exit;
   end;
  end;
  {$i-}closefile(f);{$i+}
 end;
 filemode:=fm;
end;
{$hints on}

procedure ProcessPreprocessor(var Instance:TInstance);
type //TChars=set of char;
     TToken=(tCHAR,tNUMBER,tNAME,tSTRING,TSTRINGLONG);
     TInputStackItem=record
      Source:integer;
      Buffer:TUCS4STRING;
      BufferPosition,BufferLine:integer;
     end;
     TInputStack=array of TInputStackItem;
     TMacroFunction=(mfNONE,mfFILE,mfLINE,mfTIME,mfDATE,mfPRAGMA);
     TMacroBodyItemKind=(mbikTEXT,mbikPARAMETER,mbikVAARGS,mbikSPLITTER);
     TMacroBodyItem=record
      Kind:TMacroBodyItemKind;
      Value:integer;
      Text:TUCS4STRING;
      Quote:boolean;
     end;
     TMacroBody=array of TMacroBodyItem;
     TMacro=record
      Defined:boolean;
      name:TUCS4STRING;
      Body:TMacroBody;
      Parameters:integer;
      VaArgs:boolean;
      MacroFunction:TMacroFunction;
     end;
     TMacros=array of TMacro;
const{WhiteSpace:TChars=[#9,#11..#13,#32,#255];
      WhiteSpaceEx:TChars=[#9,#10..#13,#32,#255];}
      UCS4WhiteSpace=[9,11..13,32,255];
      UCS4WhiteSpaceEx=[9,10..13,32,255];
      kwNONE=0;
      kwINCLUDE=1;
      kwINCLUDENEXT=2;
      kwDEFINE=3;
      kwUNDEF=4;
      kwIF=5;
      kwIFDEF=6;
      kwIFNDEF=7;
      kwELIF=8;
      kwELSE=9;
      kwENDIF=10;
      kwLINE=11;
      kwPRAGMA=12;
      kwERROR=13;
      kwWARNING=14;
var InputStack:TInputStack;
    CurrentToken:TToken;
    CurrentTokenChar:TUCS4CHAR;
    CurrentTokenString:TUCS4STRING;
    Macros:TMacros;
    IFNestedLevel,MacroLevel:integer;
    LastSource,LastLine:integer;
    InEval:boolean;
    Trigraphs:boolean;
    MacroStringTree:TStringTreeMemory;
    KeywordStringTree:TStringTreeMemory;
 procedure AddWarning(const s:string); forward;
 function GetInputSourceIndex(Kind:TPreprocessorInputSourceKind;const name:TUCS4STRING):integer; forward;
 function hex2byte(c:TUCS4CHAR):integer;
 begin
  case c of
   ord('0')..ord('9'):begin
    result:=c-byte('0');
   end;
   ord('a')..ord('f'):begin
    result:=c-byte('a')+$a;
   end;
   ord('A')..ord('F'):begin
    result:=c-byte('F')+$a;
   end;
   else begin
    result:=0;
   end;
  end;
 end;
 function ProprocessInputSourceChars(Kind:TPreprocessorInputSourceKind;name:TUCS4STRING;Body:string):TUCS4STRING;
 var i,ls,ll:integer;
     c:TUCS4Char;
     IsUTF8:boolean;
 begin
  ls:=LastSource;
  ll:=LastLine;
  LastSource:=GetInputSourceIndex(Kind,name);
  LastLine:=0;
  IsUTF8:=false;
  if copy(Body,1,3)=#$ef#$bb#$bf then begin
   IsUTF8:=true;
   delete(Body,1,3);
  end;
  if HandleUTF8 or IsUTF8 then begin
   result:=UTF8ToUCS4(Body);
  end else begin
   setlength(result,length(Body));
   for i:=0 to length(result)-1 do begin
    result[i]:=byte(Body[i+1]);
   end;
  end;
  i:=0;
  while i<length(result) do begin
   case result[i] of
    10:begin
     inc(i);
     inc(LastLine);
     if ((i-2)>=0) and (result[i-2]=ord('\')) then begin
      UCS4Delete(result,i-2,2);
      dec(i,2);
     end;
    end;
    13:begin
     if ((i+1)<length(result)) and (result[i+1]=10) then begin
      UCS4Delete(result,i,1);
     end else begin
      result[i]:=10;
     end;
    end;
    ord('\'):begin
     if ((i+1)<length(result)) and (result[i+1]=ord('U')) then begin
      if ((i+9)<length(result)) and
         (result[i+2] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+3] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+4] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+5] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+6] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+7] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+8] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+9] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) then begin
       result[i]:=(hex2byte(result[i+2]) shl 28) or (hex2byte(result[i+3]) shl 24) or (hex2byte(result[i+4]) shl 20) or (hex2byte(result[i+5]) shl 16) or (hex2byte(result[i+6]) shl 12) or (hex2byte(result[i+7]) shl 8) or (hex2byte(result[i+8]) shl 4) or (hex2byte(result[i+9]) shl 0);
       UCS4Delete(result,i+1,9);
      end else begin
       inc(i,2);
      end;
     end else if ((i+1)<length(result)) and (result[i+1]=ord('u')) then begin
      if ((i+5)<length(result)) and
         (result[i+2] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+3] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+4] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
         (result[i+5] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) then begin
       result[i]:=(hex2byte(result[i+2]) shl 12) or (hex2byte(result[i+3]) shl 8) or (hex2byte(result[i+4]) shl 4) or (hex2byte(result[i+5]) shl 0);
       UCS4Delete(result,i+1,5);
      end else begin
       inc(i,2);
      end;
     end else begin
      inc(i,2);
     end;
    end;
    ord('?'):begin
     if HandleTrigraphs and (((i+2)<length(result)) and ((result[i+1]=ord('?')) and ((result[i+2]>=0) and (result[i+2]<=255)) and (chr(result[i+2]) in ['=','/','''','(',')','!','<','>','-']))) then begin
      if WarnTrigraphsMore then begin
       AddWarning('Trigraph');
       Trigraphs:=true;
      end else if WarnTrigraphs then begin
       if not Trigraphs then begin
        AddWarning('Trigraphs');
        Trigraphs:=true;
       end;
      end;
      c:=ord(result[i+2]);
      UCS4Delete(result,i,2);
      case c of
       ord('='):begin
        result[i]:=ord('#');
       end;
       ord('/'):begin
        result[i]:=ord('\');
       end;
       ord(''''):begin
        result[i]:=ord('^');
       end;
       ord('('):begin
        result[i]:=ord('[');
       end;
       ord(')'):begin
        result[i]:=ord(']');
       end;
       ord('!'):begin
        result[i]:=ord('|');
       end;
       ord('<'):begin
        result[i]:=ord('{');
       end;
       ord('>'):begin
        result[i]:=ord('}');
       end;
       ord('-'):begin
        result[i]:=ord('~');
       end;
      end;
     end else begin
      inc(i);
     end;
    end;
    else begin
     inc(i);
    end;
   end;
  end;
  LastSource:=ls;
  LastLine:=ll;
 end;
 function LookUpKeyword(const name:TUCS4STRING):integer;
 var d:TStringTreeData;
 begin
  result:=kwNONE;
  d:=0;
  if KeywordStringTree.Find(name,d) then begin
   result:=integer(d);
  end;
 end;
 function LookUpEx(const name:TUCS4STRING):integer;
 var d:TStringTreeData;
 begin
  result:=-1;
  d:=0;
  if MacroStringTree.Find(name,d) then begin
   result:=integer(d);
  end;
 end;
 function LookUp(const name:TUCS4STRING):integer;
 begin
  result:=LookUpEx(name);
  if result>=0 then begin
   if not Macros[result].Defined then begin
    result:=-1;
   end;
  end;
 end;
 procedure AddDefine(const name:TUCS4STRING;Body:TMacroBody;Parameters:integer;VaArgs:boolean;MacroFunction:TMacroFunction);
 var i:integer;
 begin
  i:=LookUpEx(name);
  if i<0 then begin
   i:=length(Macros);
   setlength(Macros,i+1);
  end;
  Macros[i].Defined:=true;
  Macros[i].name:=copy(name,0,length(name));
  Macros[i].Body:=copy(Body,0,length(Body));
  Macros[i].Parameters:=Parameters;
  Macros[i].VaArgs:=VaArgs;
  Macros[i].MacroFunction:=MacroFunction;
  MacroStringTree.Add(name,i,true);
 end;
 procedure RemoveDefine(const name:TUCS4STRING);
 var i:integer;
 begin
  i:=LookUpEx(name);
  if i>=0 then begin
   Macros[i].Defined:=false;
  end;
 end;
 function GetInputSourceIndex(Kind:TPreprocessorInputSourceKind;const name:TUCS4STRING):integer;
 var i:integer;
 begin
  for i:=0 to length(Instance.Preprocessor.InputSources)-1 do begin
   if (Instance.Preprocessor.InputSources[i].Kind=Kind) and UCS4Compare(Instance.Preprocessor.InputSources[i].name,name) then begin
    result:=i;
    exit;
   end;
  end;
  result:=length(Instance.Preprocessor.InputSources);
  setlength(Instance.Preprocessor.InputSources,result+1);
  if length(Instance.Preprocessor.InputSources)<>(result+1) then begin
   result:=-1;
   exit;
  end;
  Instance.Preprocessor.InputSources[result].Kind:=Kind;
  Instance.Preprocessor.InputSources[result].name:=copy(name,0,length(name));
 end;
 procedure PushInputSource(Kind:TPreprocessorInputSourceKind;name,Text:TUCS4String);
 var i:integer;
 begin
  i:=length(InputStack);
  setlength(InputStack,i+1);
  InputStack[i].Source:=GetInputSourceIndex(Kind,name);
  InputStack[i].Buffer:=copy(Text,0,length(Text));
  InputStack[i].BufferPosition:=0;
  InputStack[i].BufferLine:=0;
 end;
 procedure PopInputSource;
 var i:integer;
 begin
  if length(InputStack)=0 then exit;
  i:=length(InputStack)-1;
  setlength(InputStack,i);
 end;
 function NextChar:TUCS4Char;
 var i:integer;
 begin
  result:=0;
  i:=length(InputStack)-1;
  while i>=0 do begin
   if InputStack[i].BufferPosition<length(InputStack[i].Buffer) then begin
    if (InputStack[i].Source>=0) and (Instance.Preprocessor.InputSources[InputStack[i].Source].Kind=iskFILE) then begin
     LastSource:=InputStack[i].Source;
     LastLine:=InputStack[i].BufferLine;
     Instance.Source:=LastSource;
     Instance.Line:=LastLine;
    end;
    result:=InputStack[i].Buffer[InputStack[i].BufferPosition];
    inc(InputStack[i].BufferPosition);
    if result=10 then begin
     inc(InputStack[i].BufferLine);
    end;
    if InputStack[i].BufferPosition>=length(InputStack[i].Buffer) then begin
     PopInputSource;
    end;
    break;
   end else begin
    PopInputSource;
    i:=length(InputStack)-1;
   end;
  end;
 end;
 function GetCharAt(j:integer=0):TUCS4CHAR;
 var i,jj,k,g:integer;
 begin
  result:=0;
  i:=length(InputStack)-1;
  if i>=0 then begin
   jj:=0;
   while (i>=0) and (j>0) do begin
    g:=length(InputStack[i].Buffer)-InputStack[i].BufferPosition;
    k:=j;
    if k>g then begin
     k:=g;
    end;
    dec(j,k);
    inc(jj,k);
    if j>0 then begin
     dec(i);
    end;
   end;
   if (i>=0) and (j=0) then begin
    if (InputStack[i].BufferPosition+jj)<length(InputStack[i].Buffer) then begin
     result:=InputStack[i].Buffer[InputStack[i].BufferPosition+jj];
    end;
   end;
  end;
 end;
 function GetToken:TToken;
 var lc,c,sc:TUCS4CHAR;
     cc,i:integer;
 begin
  c:=NextChar;
  case c of
   ord('/'):begin
    if MacroLevel=0 then begin
     c:=GetCharAt(0);
     case c of
      ord('/'):begin
       NextChar;
       c:=NextChar;
       while not (c in [0,10]) do begin
        c:=NextChar;
       end;
       result:=tCHAR;
       CurrentToken:=tCHAR;
       CurrentTokenChar:=c;
       setlength(CurrentTokenString,1);
       CurrentTokenString[0]:=c;
      end;
      ord('*'):begin
       NextChar;
       lc:=0;
       c:=NextChar;
       cc:=1;
       while true do begin
        if (lc=ord('/')) and (c=ord('*')) then begin
         inc(cc);
         c:=0;
        end else if (lc=ord('*')) and (c=ord('/')) then begin
         dec(cc);
         if cc=0 then begin
          break;
         end;
        end;
        lc:=c;
        c:=NextChar;
       end;
       c:=ord(' ');
       result:=tCHAR;
       CurrentToken:=tCHAR;
       CurrentTokenChar:=c;
       setlength(CurrentTokenString,1);
       CurrentTokenString[0]:=c;
      end;
      else begin
       c:=ord('/');
       result:=tCHAR;
       CurrentToken:=tCHAR;
       CurrentTokenChar:=c;
       setlength(CurrentTokenString,1);
       CurrentTokenString[0]:=c;
      end;
     end;
    end else begin
     c:=ord('/');
     result:=tCHAR;
     CurrentToken:=tCHAR;
     CurrentTokenChar:=c;
     setlength(CurrentTokenString,1);
     CurrentTokenString[0]:=c;
    end;
   end;
   ord('0')..ord('9'):begin
    result:=tNUMBER;
    CurrentToken:=result;
    setlength(CurrentTokenString,1);
    CurrentTokenString[0]:=c;
    i:=0;
    while GetCharAt(i) in [ord('A')..ord('Z'),ord('a')..ord('z'),ord('_'),ord('0')..ord('9')] do begin
     inc(i);
    end;
    while i>0 do begin
     UCS4AddChar(CurrentTokenString,NextChar);
     dec(i);
    end;
   end;
   ord('"'),ord(''''):begin
    sc:=c;
    setlength(CurrentTokenString,1);
    CurrentTokenString[0]:=sc;
    i:=0;
    while true do begin
     c:=GetCharAt(i);
     if (c=sc) or (c=0) then begin
      inc(i);
      break;
     end else if c=10 then begin
      break;
     end else if c=ord('\') then begin
      inc(i,2);
     end else begin
      inc(i);
     end;
    end;
    while i>0 do begin
     UCS4AddChar(CurrentTokenString,NextChar);
     dec(i);
    end;
    result:=tSTRING;
    CurrentToken:=tSTRING;
   end;
   else begin
    if (c=ord('L')) and (GetCharAt(0) in [ord(''''),ord('"')]) then begin
     c:=NextChar;
     sc:=c;
     setlength(CurrentTokenString,1);
     CurrentTokenString[0]:=sc;
     i:=0;
     while true do begin
      c:=GetCharAt(i);
      if (c=sc) or (c=0) then begin
       inc(i);
       break;
      end else if c=10 then begin
       break;
      end else if c=ord('\') then begin
       inc(i,2);
      end else begin
       inc(i);
      end;
     end;
     while i>0 do begin
      UCS4AddChar(CurrentTokenString,NextChar);
      dec(i);
     end;
     result:=tSTRINGLONG;
     CurrentToken:=tSTRINGLONG;
    end else if (c in [ord('A')..ord('Z'),ord('a')..ord('z'),ord('_')]) or (c>255) then begin
     result:=tNAME;
     CurrentToken:=result;
     setlength(CurrentTokenString,1);
     CurrentTokenString[0]:=c;
     i:=0;
     c:=GetCharAt(i);
     while (c in [ord('A')..ord('Z'),ord('a')..ord('z'),ord('_'),ord('0')..ord('9')]) or (c>255) do begin
      inc(i);
      c:=GetCharAt(i);
     end;
     while i>0 do begin
      UCS4AddChar(CurrentTokenString,NextChar);
      dec(i);
     end;
    end else begin
     result:=tCHAR;
     CurrentToken:=tCHAR;
     CurrentTokenChar:=c;
     setlength(CurrentTokenString,1);
     CurrentTokenString[0]:=c;
    end;
   end;
  end;
 end;
 procedure SkipGetToken; forward;
 procedure SkipExtGetToken; forward;
 procedure AddError(const s:string); forward;
 procedure SkipBlankEx; forward;
 function Destringize(const s:TUCS4STRING):TUCS4STRING;
 var i:integer;
     c:TUCS4CHAR;
 begin
  result:=nil;
  UCS4Clear(result);
  i:=0;
  while i<length(s) do begin
   case s[i] of
    ord('\'):begin
     if (i+1)<length(s) then begin
      case s[i+1] of
       ord('a'):begin
        UCS4AddChar(result,#7);
        inc(i,2);
       end;
       ord('b'):begin
        UCS4AddChar(result,#8);
        inc(i,2);
       end;
       ord('t'):begin
        UCS4AddChar(result,#9);
        inc(i,2);
       end;
       ord('n'):begin
        UCS4AddChar(result,#10);
        inc(i,2);
       end;
       ord('v'):begin
        UCS4AddChar(result,#11);
        inc(i,2);
       end;
       ord('f'):begin
        UCS4AddChar(result,#12);
        inc(i,2);
       end;
       ord('r'):begin
        UCS4AddChar(result,#13);
        inc(i,2);
       end;
       ord('\'):begin
        UCS4AddChar(result,'\');
        inc(i,2);
       end;
       ord(''''):begin
        UCS4AddChar(result,'''');
        inc(i,2);
       end;
       ord('"'):begin
        UCS4AddChar(result,'"');
        inc(i,2);
       end;
       ord('?'):begin
        UCS4AddChar(result,'?');
        inc(i,2);
       end;
       ord('U'):begin
        if ((i+9)<length(s)) and
           (s[i+2] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+3] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+4] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+5] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+6] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+7] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+8] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+9] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) then begin
         c:=(hex2byte(s[i+2]) shl 28) or (hex2byte(s[i+3]) shl 24) or (hex2byte(s[i+4]) shl 20) or (hex2byte(s[i+5]) shl 16) or (hex2byte(s[i+6]) shl 12) or (hex2byte(s[i+7]) shl 8) or (hex2byte(s[i+8]) shl 4) or (hex2byte(s[i+9]) shl 0);
         UCS4AddChar(result,c);
         inc(i,9);
        end else begin
         inc(i);
        end;
       end;
       ord('u'):begin
        if ((i+5)<length(s)) and
           (s[i+2] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+3] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+4] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+5] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) then begin
         c:=(hex2byte(s[i+2]) shl 12) or (hex2byte(s[i+3]) shl 8) or (hex2byte(s[i+4]) shl 4) or (hex2byte(s[i+5]) shl 0);
         UCS4AddChar(result,c);
         inc(i,5);
        end else begin
         inc(i);
        end;
       end;
       ord('x'),ord('X'):begin
        if ((i+3)<length(s)) and
           (s[i+2] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) and
           (s[i+3] in [ord('0')..ord('9'),ord('A')..ord('F'),ord('a')..ord('f')]) then begin
         c:=(hex2byte(s[i+2]) shl 4) or (hex2byte(s[i+3]) shl 0);
         UCS4AddChar(result,c);
         inc(i,3);
        end else begin
         inc(i);
        end;
       end;
       ord('0')..ord('7'):begin
        c:=0;
        while (i<length(s)) and (s[i] in [ord('0')..ord('7')]) do begin
         c:=(c*8)+(s[i]-ord('0'));
         inc(i);
        end;
        UCS4AddChar(result,c);
       end;
       else begin
        UCS4AddChar(result,s[i+1]);
        inc(i,2);
       end;
      end;
     end else begin
      inc(i);
     end;
    end;
    else begin
     UCS4AddChar(result,s[i]);
     inc(i);
    end;
   end;
  end;
 end;
 function Stringize(const s:TUCS4STRING;q:boolean):TUCS4STRING;
 const hexchars:array[0..$f] of char='0123456789ABCDEF';
 var i:integer;
     c:TUCS4CHAR;
 begin
  result:=nil;
  if q then begin
   UCS4Clear(result);
   for i:=0 to length(s)-1 do begin
    c:=s[i];
    case c of
     0:begin
      UCS4AddString(result,'\0');
     end;
     7:begin
      UCS4AddString(result,'\a');
     end;
     8:begin
      UCS4AddString(result,'\b');
     end;
     9:begin
      UCS4AddString(result,'\t');
     end;
     10:begin
      UCS4AddString(result,'\n');
     end;
     11:begin
      UCS4AddString(result,'\v');
     end;
     12:begin
      UCS4AddString(result,'\f');
     end;
     13:begin
      UCS4AddString(result,'\r');
     end;
     ord('\'):begin
      UCS4AddString(result,'\\');
     end;
     ord(''''):begin
      UCS4AddString(result,'\''');
     end;
     ord('"'):begin
      UCS4AddString(result,'\"');
     end;
     ord('?'):begin
      UCS4AddString(result,'\?');
     end;
     else begin
{     if HandleUTF8 then begin
       UCS4AddChar(result,c);
      end else begin}
       if c<128 then begin
        UCS4AddChar(result,c);
       end else if c<=$ffff then begin
        UCS4AddString(result,'\u'+hexchars[(c shr 12) and $f]+hexchars[(c shr 8) and $f]+hexchars[(c shr 4) and $f]+hexchars[c and $f]);
       end else begin
        UCS4AddString(result,'\U'+hexchars[(c shr 28) and $f]+hexchars[(c shr 24) and $f]+hexchars[(c shr 20) and $f]+hexchars[(c shr 16) and $f]+hexchars[(c shr 12) and $f]+hexchars[(c shr 8) and $f]+hexchars[(c shr 4) and $f]+hexchars[c and $f]);
       end;
//    end;
     end;
    end;
   end;
  end else begin
   result:=copy(s,0,length(s));
  end;
 end;
 procedure ExtGetToken;
 var mi,i,j,k,NestedLevel,pc:integer;
     b:TUCS4STRING;
     Parameters:array of TUCS4STRING;
     InputStackItem:TInputStackItem;
 begin
  b:=nil;
  Parameters:=nil;
  repeat
   if length(InputStack)>0 then begin
    InputStackItem:=InputStack[length(InputStack)-1];
   end else begin
    InputStackItem.Source:=-1;
   end;
   if GetToken<>tNAME then begin
    break;
   end;
   mi:=LookUp(CurrentTokenString);
   if mi<0 then begin
    break;
   end;
   if Macros[mi].MacroFunction<>mfNONE then begin
    case Macros[mi].MacroFunction of
     mfFILE:begin
      if InputStackItem.Source>=0 then begin
       UCS4Clear(b);
       UCS4AddChar(b,'"');
       UCS4Add(b,Stringize(Instance.Preprocessor.InputSources[InputStackItem.Source].name,true));
       UCS4AddChar(b,'"');
       PushInputSource(iskMACRO,Macros[mi].name,b);
      end else begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': Unknown file');
       continue;
      end;
     end;
     mfLINE:begin
      if InputStackItem.Source>=0 then begin
       b:=UTF8ToUCS4(inttostr(InputStackItem.BufferLine+1));
       PushInputSource(iskMACRO,Macros[mi].name,b);
      end else begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': Unknown line number');
       continue;
      end;
     end;
     mfTIME:begin
      b:=UTF8ToUCS4('"'+FormatDateTime('hh:nn:ss',Now)+'"');
      PushInputSource(iskMACRO,Macros[mi].name,b);
     end;
     mfDATE:begin
      b:=UTF8ToUCS4('"'+FormatDateTime('mmm dd yyyy',Now)+'"');
      PushInputSource(iskMACRO,Macros[mi].name,b);
     end;
     mfPRAGMA:begin
      SkipGetToken;
      if not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('('))) then begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': missing (');
       exit;
      end;
      SkipGetToken;
      if CurrentToken<>tSTRING then begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': string was expected');
       exit;
      end;
      i:=length(Instance.Preprocessor.PragmaInfo);
      setlength(Instance.Preprocessor.PragmaInfo,i+1);
      Instance.Preprocessor.PragmaInfo[i].CharPos:=length(Instance.Preprocessor.OutputText)+1;
      if length(CurrentTokenString)<2 then begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': string not closed');
       exit;
      end;
      if CurrentTokenString[0]<>CurrentTokenString[length(CurrentTokenString)-1] then begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': invalid string');
       exit;
      end;
      Instance.Preprocessor.PragmaInfo[i].Pragma:=Destringize(copy(CurrentTokenString,1,length(CurrentTokenString)-2));
      SkipGetToken;
      if not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord(')'))) then begin
       AddError(UCS4ToUTF8(Macros[mi].name)+': missing )');
       exit;
      end;
     end;
     else begin
      AddError(UCS4ToUTF8(Macros[mi].name)+': Unknown macro function');
      continue;
     end;
    end;
   end else if (Macros[mi].Parameters=0) and not Macros[mi].VaArgs then begin
    UCS4Clear(b);
    for i:=0 to length(Macros[mi].Body)-1 do begin
     case Macros[mi].Body[i].Kind of
      mbikTEXT:begin
       UCS4Add(b,Stringize(Macros[mi].Body[i].Text,Macros[mi].Body[i].Quote));
      end;
     end;
    end;
    inc(MacroLevel);
    PushInputSource(iskMACRO,Macros[mi].name,b);
    dec(MacroLevel);
   end else if (Macros[mi].Parameters>0) or Macros[mi].VaArgs then begin
    SkipGetToken;
    if (Macros[mi].Parameters>0) and not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('('))) then begin
     AddError(UCS4ToUTF8(Macros[mi].name)+': missing (');
     exit;
    end else if (Macros[mi].Parameters=0) and Macros[mi].VaArgs and not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('('))) then begin
{    exit;}
    end;
    setlength(Parameters,0);
    if (Macros[mi].Parameters>0) or ((Macros[mi].Parameters=0) and ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('(')))) then begin
     SkipGetToken;
     while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,ord(')')])) do begin
      while (CurrentToken=tCHAR) and (CurrentTokenChar in UCS4WhiteSpaceEx) do begin
       GetToken;
      end;
      UCS4Clear(b);
      NestedLevel:=0;
      while true do begin
       if (CurrentToken=tCHAR) and (CurrentTokenChar=0) then begin
        break;
       end else if (NestedLevel=0) and ((CurrentToken=tCHAR) and (CurrentTokenChar in [ord(','),ord(')')])) then begin
        break;
       end else if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('(')) then begin
        UCS4AddChar(b,'(');
        inc(NestedLevel);
       end else if (CurrentToken=tCHAR) and (CurrentTokenChar=ord(')')) then begin
        UCS4AddChar(b,')');
        dec(NestedLevel);
       end else begin
        UCS4Add(b,CurrentTokenString);
       end;
       ExtGetToken;
      end;
      if (CurrentToken=tCHAR) and (CurrentTokenChar=ord(',')) then begin
       SkipGetToken;
      end;
      pc:=length(Parameters);
      setlength(Parameters,pc+1);
      Parameters[pc]:=copy(b,0,length(b));
     end;
     if not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord(')'))) then begin
      AddError(UCS4ToUTF8(Macros[mi].name)+': missing )');
      continue;
     end;
    end;
    if (length(Parameters)<Macros[mi].Parameters) or ((length(Parameters)>Macros[mi].Parameters) and not Macros[mi].VaArgs) then begin
     AddError(UCS4ToUTF8(Macros[mi].name)+': Wrong amount of parameters');
     continue;
    end;
    k:=1;
    UCS4Clear(b);
    for i:=0 to length(Macros[mi].Body)-1 do begin
     if Macros[mi].Body[i].Quote then begin
      UCS4AddChar(b,'"');
     end;
     case Macros[mi].Body[i].Kind of
      mbikTEXT:begin
       if (i>1) and (Macros[mi].Body[i].Kind<>mbikTEXT) then begin
        k:=length(b);
       end;
       UCS4Add(b,Stringize(Macros[mi].Body[i].Text,Macros[mi].Body[i].Quote));
      end;
      mbikPARAMETER:begin
       if Macros[mi].Body[i].Value<length(Parameters) then begin
        UCS4Add(b,Stringize(Parameters[Macros[mi].Body[i].Value],Macros[mi].Body[i].Quote));
        k:=length(b)+1;
       end;
      end;
      mbikVAARGS:begin
       if length(Parameters)<=Macros[mi].Parameters then begin
        for j:=length(b)-1 downto k do begin
         if (b[j] in UCS4WhiteSpaceEx) then begin
         end else begin
          case b[j] of
           ord(','):begin
            b:=copy(b,0,j-1);
            break;
           end;
           else begin
            break;
           end;
          end;
         end;
        end;
       end else begin
        for j:=Macros[mi].Parameters to length(Parameters)-1 do begin
         UCS4Add(b,Stringize(Parameters[j],Macros[mi].Body[i].Quote));
         if ((j+1)<length(Parameters)) then begin
          UCS4AddChar(b,',');
         end;
        end;
        k:=length(b)+1;
       end;
      end;
      mbikSPLITTER:begin
       UCS4AddChar(b,-1);
      end;
     end;
     if Macros[mi].Body[i].Quote then begin
      UCS4AddChar(b,'"');
     end;
    end;
    inc(MacroLevel);
    PushInputSource(iskMACRO,Macros[mi].name,b);
    dec(MacroLevel);
   end;
  until false;
  setlength(Parameters,0);
 end;
 procedure SkipGetToken;
 begin
  repeat
   GetToken;
   if (CurrentToken=tCHAR) and (CurrentTokenChar in UCS4WhiteSpace) then begin
    continue;
   end;
   break;
  until false;
 end;
 procedure SkipEOL;
 var i:integer;
 begin
  i:=0;
  while not (GetCharAt(i) in [0,10]) do begin
   inc(i);
  end;
  while i>0 do begin
   NextChar;
   dec(i);
  end;
 end;
 procedure SkipBlankEx;
 var i:integer;
 begin
  i:=0;
  while GetCharAt(i) in UCS4WhiteSpaceEx do begin
   inc(i);
  end;
  while i>0 do begin
   NextChar;
   dec(i);
  end;
 end;
 procedure SkipBlank;
 var i:integer;
 begin
  i:=0;
  while GetCharAt(i) in UCS4WhiteSpaceEx do begin
   inc(i);
  end;
  while i>0 do begin
   NextChar;
   dec(i);
  end;
 end;
 procedure SkipExtGetToken;
 begin
  repeat
   ExtGetToken;
   if (CurrentToken=tCHAR) and (CurrentTokenChar in UCS4WhiteSpace) then begin
    continue;
   end;
   break;
  until false;
 end;
 procedure AddError(const s:string);
 begin
  PreprocessorGlobals.AddError(Instance,s);
 end;
 procedure AddWarning(const s:string);
 begin
  PreprocessorGlobals.AddWarning(Instance,s);
 end;
 procedure AddToOutput(const s:TUCS4STRING);
 var i:integer;
 begin
  if length(s)=0 then exit;
  if (length(Instance.Preprocessor.OutputInfo)>0) then begin
   if Instance.Preprocessor.OutputInfo[length(Instance.Preprocessor.OutputInfo)-1].LastCharPos<>(length(Instance.Preprocessor.OutputText)-1) then begin
    Instance.Preprocessor.OutputInfo[length(Instance.Preprocessor.OutputInfo)-1].LastCharPos:=(length(Instance.Preprocessor.OutputText)-1);
   end;
   if (Instance.Preprocessor.OutputInfo[length(Instance.Preprocessor.OutputInfo)-1].Source<>LastSource) or
      (Instance.Preprocessor.OutputInfo[length(Instance.Preprocessor.OutputInfo)-1].Line<>LastLine) then begin
    i:=length(Instance.Preprocessor.OutputInfo);
    setlength(Instance.Preprocessor.OutputInfo,i+1);
    Instance.Preprocessor.OutputInfo[i].FirstCharPos:=length(Instance.Preprocessor.OutputText);
    Instance.Preprocessor.OutputInfo[i].LastCharPos:=length(Instance.Preprocessor.OutputText);
    Instance.Preprocessor.OutputInfo[i].Source:=LastSource;
    Instance.Preprocessor.OutputInfo[i].Line:=LastLine;
   end;
  end else begin
   i:=length(Instance.Preprocessor.OutputInfo);
   setlength(Instance.Preprocessor.OutputInfo,i+1);
   Instance.Preprocessor.OutputInfo[i].FirstCharPos:=length(Instance.Preprocessor.OutputText);
   Instance.Preprocessor.OutputInfo[i].LastCharPos:=length(Instance.Preprocessor.OutputText);
   Instance.Preprocessor.OutputInfo[i].Source:=LastSource;
   Instance.Preprocessor.OutputInfo[i].Line:=LastLine;
  end;
  UCS4Add(Instance.Preprocessor.OutputText,s);
 end;
 function ParseNumber(s:TUCS4STRING):integer;
 var i:integer;
     sv:longint;
     b:boolean;
 begin
  b:=false;
  while (length(s)>0) and (s[length(s)-1] in [ord('l'),ord('L'),ord('u'),ord('U')]) do begin
   UCS4Delete(s,length(s)-1,1);
  end;
  if (length(s)>0) and (s[0]=ord('0')) then begin
   if (length(s)>1) and (s[1] in [ord('x'),ord('X')]) then begin
    result:=0;
    for i:=2 to length(s)-1 do begin
     if (not b) and (((result*16) div 16)<>result) then begin
      b:=true;
      AddWarning('TERM: constant too large for destination type');
     end;
     case s[i] of
      ord('0')..ord('9'):begin
       sv:=s[i]-ord('0');
      end;
      ord('a')..ord('f'):begin
       sv:=s[i]-ord('a')+$a;
      end;
      ord('A')..ord('F'):begin
       sv:=s[i]-ord('A')+$a;
      end;
      else begin
       sv:=0;
      end;
     end;
     result:=(result*16)+sv;
    end;
   end else begin
    result:=0;
    for i:=1 to length(s)-1 do begin
     if (not b) and (((result*8) div 8)<>result) then begin
      b:=true;
      AddWarning('TERM: constant too large for destination type');
     end;
     result:=(result*8)+(s[i]-ord('0'));
    end;
   end;
  end else begin
   result:=0;
   for i:=0 to length(s)-1 do begin
    if (not b) and (((result*10) div 10)<>result) then begin
     b:=true;
     AddWarning('TERM: constant too large for destination type');
    end;
    result:=(result*10)+(s[i]-ord('0'));
   end;
  end;
 end;
 procedure DoINCLUDE(DoIncludeNext:boolean);
 var cfn,fn,ffn,d,t2:TUCS4STRING;
     c,m:TUCS4CHAR;
     OK:boolean;
     t:string;
     f:file;
     fm:byte;
     i:integer;
 begin
  cfn:=nil;
  if DoIncludeNext then begin
   AddWarning('#include_next is a GCC extension!');
   if (LastSource>=0) and (LastSource<length(Instance.Preprocessor.InputSources)) then begin
    cfn:=copy(Instance.Preprocessor.InputSources[LastSource].name,0,length(Instance.Preprocessor.InputSources[LastSource].name));
   end;
  end;
  d:=nil;
  t2:=nil;
  fn:=nil;
  ffn:=nil;
  UCS4Clear(d);
  UCS4Clear(t2);
  SkipExtGetToken;
  UCS4Clear(fn);
  if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('<')) then begin
   OK:=false;
   while true do begin
    c:=NextChar;
    if c=ord('>') then begin
     OK:=true;
     break;
    end else if c in [0,10] then begin
     break;
    end else begin
     UCS4AddChar(fn,c);
    end;
   end;
   if not OK then begin
    AddError('#include: missing >');
    exit;
   end;
   m:=ord('<');
  end else if (CurrentToken=tSTRING) and (length(CurrentTokenString)>1) and (CurrentTokenString[0]=ord('"')) then begin
   if CurrentTokenString[length(CurrentTokenString)-1]<>ord('"') then begin
    AddError('#include: missing "');
    exit;
   end;
   fn:=copy(CurrentTokenString,1,length(CurrentTokenString)-2);
   m:=ord('"');
  end else begin
   AddError('#include: missing filename');
   exit;
  end;
  UCS4Clear(ffn);
  if (m=ord('"')) and (length(Instance.Preprocessor.InputSources)>0) and fileexists(ExtractFilePath(UCS4ToUTF8(Instance.Preprocessor.InputSources[0].name))+UCS4ToUTF8(fn)) then begin
   ffn:=UTF8ToUCS4(ExtractFilePath(UCS4ToUTF8(Instance.Preprocessor.InputSources[0].name)));
   UCS4Add(ffn,fn);
   if UCS4Compare(ffn,cfn) then begin
    UCS4Clear(ffn);
   end;
  end;
  if (length(ffn)=0) or not fileexists(UCS4ToUTF8(ffn)) then begin
   for i:=0 to length(Instance.Preprocessor.IncludeDirectories)-1 do begin
    d:=UTF8ToUCS4(Instance.Preprocessor.IncludeDirectories[i]);
    if fileexists(UCS4ToUTF8(d)+UCS4ToUTF8(fn)) then begin
     ffn:=copy(d,0,length(d));
     UCS4Add(ffn,fn);
     if UCS4Compare(ffn,cfn) then begin
      UCS4Clear(ffn);
     end else begin
      break;
     end;
    end;
   end;
  end;
  if (length(ffn)=0) or not fileexists(UCS4ToUTF8(ffn)) then begin                       
   if fileexists(UCS4ToUTF8(fn)) then begin
    ffn:=copy(fn,0,length(fn));
    if UCS4Compare(ffn,cfn) then begin
     UCS4Clear(ffn);
    end;
   end;
  end;
  if (length(ffn)=0) or not fileexists(UCS4ToUTF8(ffn)) then begin
   if m=ord('"') then begin
    AddError('#include: File "'+UCS4ToUTF8(fn)+'" not found');
   end else begin
    AddError('#include: File <'+UCS4ToUTF8(fn)+'> not found');
   end;
   exit;
  end;
  fm:=filemode;
  filemode:=0;
  {$hints off}
  assignfile(f,UCS4ToUTF8(ffn));
  {$hints on}
  {$i-}reset(f,1);{$i+};
  if ioresult=0 then begin
   setlength(t,filesize(f));
   if length(t)>0 then begin
    {$i-}blockread(f,t[1],length(t));{$i+}
    t2:=ProprocessInputSourceChars(iskFILE,fn,t);
    if ioresult<>0 then begin
     if m=ord('"') then begin
      AddError('#include: File "'+UCS4ToUTF8(fn)+'" I/O error');
     end else begin
      AddError('#include: File <'+UCS4ToUTF8(fn)+'> I/O error');
     end;
     {$i-}closefile(f);{$i+}
     filemode:=fm;
     exit;
    end;
   end;
   {$i-}closefile(f);{$i+}
  end else begin
   if m=ord('"') then begin
    AddError('#include: File "'+UCS4ToUTF8(fn)+'" I/O error');
   end else begin
    AddError('#include: File <'+UCS4ToUTF8(fn)+'> I/O error');
   end;
  end;
  filemode:=fm;
  PushInputSource(iskFILE,fn,t2);
 end;
 procedure DoDEFINE;
 var name:TUCS4STRING;
     Parameters:array of TUCS4STRING;
     Body:TMacroBody;
     Quote:boolean;
     i,j,p,b:integer;
     VaArgs:boolean;
 begin
  SkipGetToken;
  if CurrentToken<>tNAME then begin
   AddWarning('#define: missing macro name');
   SkipEOL;
   exit;
  end;
  VaArgs:=false;
  name:=CurrentTokenString;
  GetToken;
  if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('(')) then begin
   Parameters:=nil;
   while true do begin
    SkipGetToken;
    if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('.')) and (GetCharAt(0)=ord('.')) and (GetCharAt(1)=ord('.')) then begin
     GetToken;
     GetToken;
     GetToken;
     VaArgs:=true;
     break;
    end;
    if CurrentToken<>tNAME then begin
     break;
    end;
    p:=length(Parameters);
    setlength(Parameters,p+1);
    Parameters[p]:=copy(CurrentTokenString,0,length(CurrentTokenString));
    GetToken;
    if not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord(','))) then begin
     break;
    end;
   end;
   if not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord(')'))) then begin
    AddWarning('#define: bad macro parameter');
    SkipEOL;
    exit;
   end;
   CurrentToken:=tCHAR;
   CurrentTokenChar:=ord(' ');
  end;
  while (CurrentToken=tCHAR) and (CurrentTokenChar in UCS4WhiteSpace) do begin
   GetToken;
  end;
  Body:=nil;
  Quote:=false;
  while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,10])) do begin
   if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('\')) and (GetCharAt(0) in [0,10]) then begin
    GetToken;
    GetToken;
    b:=length(Body);
    setlength(Body,b+1);
    Body[b].Kind:=mbikTEXT;
    Body[b].Text:=UTF8ToUCS4(#10);
    Body[b].Quote:=false;
{   while (CurrentToken=tCHAR) and (CurrentTokenChar in WhiteSpaceEx) do begin
     GetToken;
    end;}
    continue;
   end else if ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('#'))) or
               ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':'))) then begin
    if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':')) then begin
     NextChar;
    end;
    b:=length(Body);
    setlength(Body,b+1);
    Body[b].Kind:=mbikSPLITTER;
    Body[b].Quote:=false;
    GetToken;
    if ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('#'))) or
       ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':'))) then begin
     if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':')) then begin
      NextChar;
     end;
     GetToken;
     if length(Body)>0 then begin
      if Body[length(Body)-1].Kind=mbikTEXT then begin
       while (length(Body[length(Body)-1].Text)>0) and (Body[length(Body)-1].Text[length(Body[length(Body)-1].Text)-1] in UCS4WhiteSpaceEx) do begin
        UCS4Delete(Body[length(Body)-1].Text,length(Body[length(Body)-1].Text)-1,1);
       end;
      end else if length(Body)>1 then begin
       if Body[length(Body)-1].Kind=mbikSPLITTER then begin
        if Body[length(Body)-2].Kind=mbikTEXT then begin
         while (length(Body[length(Body)-2].Text)>0) and (Body[length(Body)-2].Text[length(Body[length(Body)-2].Text)-1] in UCS4WhiteSpaceEx) do begin
          UCS4Delete(Body[length(Body)-2].Text,length(Body[length(Body)-2].Text)-1,1);
         end;
        end;
       end;
      end;
     end;
    end else begin
     Quote:=true;
    end;
    while (CurrentToken=tCHAR) and (CurrentTokenChar in UCS4WhiteSpaceEx) do begin
     GetToken;
    end;
    continue;
   end;
   if CurrentToken=tNAME then begin
    if UCS4Compare(CurrentTokenString,'__VA_ARGS__') then begin
     if VaArgs then begin
      b:=length(Body);
      setlength(Body,b+1);
      Body[b].Kind:=mbikVAARGS;
      Body[b].Quote:=Quote;
     end else begin
      AddWarning('#define: __VA_ARGS__ not allowed here');
      exit;
     end;
    end else begin
     j:=-1;
     for i:=0 to length(Parameters)-1 do begin
      if UCS4Compare(Parameters[i],CurrentTokenString) then begin
       j:=i;
       break;
      end;
     end;
     if j<0 then begin
      b:=length(Body);
      setlength(Body,b+1);
      Body[b].Kind:=mbikTEXT;
      Body[b].Text:=copy(CurrentTokenString,0,length(CurrentTokenString));
      Body[b].Quote:=Quote;
     end else begin
      b:=length(Body);
      setlength(Body,b+1);
      Body[b].Kind:=mbikParameter;
      Body[b].Value:=i;
      Body[b].Quote:=Quote;
     end;
    end;
   end else begin
    if CurrentToken=tCHAR then begin
     if not (CurrentTokenChar in [13,10]) then begin
      b:=length(Body);
      setlength(Body,b+1);
      Body[b].Kind:=mbikTEXT;
      setlength(Body[b].Text,1);
      Body[b].Text[0]:=CurrentTokenChar;
      Body[b].Quote:=Quote;
     end;
    end else begin
     b:=length(Body);
     setlength(Body,b+1);
     Body[b].Kind:=mbikTEXT;
     Body[b].Text:=copy(CurrentTokenString,0,length(CurrentTokenString));
     Body[b].Quote:=Quote;
    end;
   end;
   Quote:=false;
   GetToken;
  end;
  AddDefine(name,Body,length(Parameters),VaArgs,mfNONE);
 end;
 procedure DoUNDEF;
 begin
  SkipGetToken;
  if CurrentToken<>tNAME then begin
   AddWarning('#undef: missing macro name');
   SkipEOL;
   exit;
  end;
  RemoveDefine(CurrentTokenString);
  SkipEOL;
 end;
 function SearchELSEENDIF(var Keyword:integer):boolean;
 var NestedLevel:integer;
 begin
  Keyword:=kwNONE;
  CurrentToken:=tCHAR;
  CurrentTokenChar:=10;
  NestedLevel:=1;
  while true do begin
   while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,10])) do begin
    GetToken;
   end;
   SkipGetToken;
   if ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('#'))) or
      ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':'))) then begin
    if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':')) then begin
     NextChar;
    end;
    SkipExtGetToken;
    Keyword:=LookUpKeyword(CurrentTokenString);
    if CurrentToken=tNAME then begin
     if Keyword in [kwIF,kwIFDEF,kwIFNDEF] then begin
      inc(NestedLevel);
     end else if Keyword=kwENDIF then begin
      dec(NestedLevel);
      if NestedLevel=0 then begin
       dec(IFNestedLevel);
       result:=false;
       exit;
      end;
     end else if (NestedLevel=1) and (Keyword in [kwELSE,kwELIF]) then begin
      result:=true;
      exit;
     end;
    end;
   end else if (CurrentToken=tCHAR) and (CurrentTokenCHAR=0) then begin
    AddError('missing #endif');
    result:=true;
    exit;
   end;
  end;
 end;
 function EvalString(s:TUCS4STRING):boolean;
 type TEvalToken=(etNONE,etCHAR,etNAME,etNUMBER,etDIV,etMINUS,etPLUS,etLT,
                  etLEQ,etLSH,etGT,etGEQ,etRSH,etEQ,etNOT,etNEQ,etAND,etLAND,
                  etOR,etLOR,etMOD,etMUL,etXOR,etLNOT,etLPAR,etRPAR,etCOMMA,
                  etQUEST,etCOLON,etUMINUS,etUPLUS,etASSIGN);
      TEvalTokenItem=record
       Token:TEvalToken;
       s:TUCS4STRING;
      end;
      TEvalTokenFIFO=record
       Tokens:array of TEvalTokenItem;
       index:integer;
      end;
      TValue=record
       case Sign:boolean of
        false:(us:longword);
        true:(s:longint);
      end;
      TEvalTokenPrecLUT=array[TEvalToken] of integer;
 const TokenUnary=[etLNOT,etNOT,etUPLUS,etUMINUS];
       TokenBinary=[etMUL,etDIV,etMOD,etPLUS,etMINUS,etLSH,etRSH,etLT,etLEQ,etGT,
              etGEQ,etEQ,etNEQ,etAND,etXOR,etOR,etLAND,etLOR,etCOMMA];
       WrongToken=TokenUnary+TokenBinary+[etQUEST,etCOLON];
       OpPrecLUT:TEvalTokenPrecLUT=(666, // etNONE
                                    666, // etCHAR
                                    666, // etNAME
                                    666, // etNUMBER
                                    12,  // etDIV
                                    11,  // etMINUS
                                    11,  // etPLUS
                                    9,   // etLT
                                    9,   // etLEQ
                                    10,  // etLSH
                                    9,   // etGT
                                    9,   // etGEQ
                                    10,  // etRSH
                                    8,   // etEQ
                                    13,  // etNOT
                                    8,   // etNEQ
                                    7,   // etAND,
                                    4,   // etLAND
                                    5,   // etOR
                                    3,   // etLOR
                                    12,  // etMOD
                                    12,  // etMUL
                                    6,   // etXOR
                                    13,  // etLNOT
                                    666, // etLPAR
                                    666, // etRPAR
                                    1,   // etCOMMA
                                    2,   // etQUEST
                                    666, // etCOLON
                                    13,  // etUMINUS
                                    13,  // etUPLUS
                                    666  // etASSIGN
                                   );
 var FIFO:TEvalTokenFIFO;
  procedure AddToken(Token:TEvalToken;const s:TUCS4STRING); overload;
  var i:integer;
  begin
   i:=length(FIFO.Tokens);
   setlength(FIFO.Tokens,i+1);
   FIFO.Tokens[i].Token:=Token;
   FIFO.Tokens[i].s:=copy(s,0,length(s));
  end;
  procedure AddToken(Token:TEvalToken;const s:TUCS4CHAR); overload;
  var i:integer;
  begin
   i:=length(FIFO.Tokens);
   setlength(FIFO.Tokens,i+1);
   FIFO.Tokens[i].Token:=Token;
   setlength(FIFO.Tokens[i].s,1);
   FIFO.Tokens[i].s[0]:=s;
  end;
  procedure AddToken(Token:TEvalToken;const s:string); overload;
  var i:integer;
  begin
   i:=length(FIFO.Tokens);
   setlength(FIFO.Tokens,i+1);
   FIFO.Tokens[i].Token:=Token;
   FIFO.Tokens[i].s:=UTF8ToUCS4(s);
  end;
  procedure Tokenize(s:TUCS4STRING);
  var i:integer;
      c:TUCS4CHAR;
      ns:TUCS4STRING;
  begin
   i:=0;
   while i<length(s) do begin
    c:=s[i];
    case c of
     ord('/'):begin
      AddToken(etDIV,'/');
      inc(i);
     end;
     ord('-'):begin
      AddToken(etMINUS,'-');
      inc(i);
     end;
     ord('+'):begin
      AddToken(etPLUS,'+');
      inc(i);
     end;
     ord('<'):begin
      if ((i+1)<length(s)) and (s[i+1]=ord('=')) then begin
       AddToken(etLEQ,'<=');
       inc(i,2);
      end else if ((i+1)<length(s)) and (s[i+1]=ord('<')) then begin
       AddToken(etLSH,'<<');
       inc(i,2);
      end else begin
       AddToken(etLT,'<');
       inc(i);
      end;
     end;
     ord('>'):begin
      if ((i+1)<length(s)) and (s[i+1]=ord('=')) then begin
       AddToken(etGEQ,'>=');
       inc(i,2);
      end else if ((i+1)<length(s)) and (s[i+1]=ord('>')) then begin
       AddToken(etRSH,'>>');
       inc(i,2);
      end else begin
       AddToken(etGT,'>');
       inc(i);
      end;
     end;
     ord('='):begin
      if ((i+1)<length(s)) and (s[i+1]=ord('=')) then begin
       AddToken(etEQ,'==');
       inc(i,2);
      end else begin
       AddToken(etASSIGN,'=');
       inc(i);
      end;
     end;
     ord('~'):begin
      AddToken(etNOT,'~');
      inc(i);
     end;
     ord('!'):begin
      if ((i+1)<length(s)) and (s[i+1]=ord('=')) then begin
       AddToken(etNEQ,'!=');
       inc(i,2);
      end else begin
       AddToken(etLNOT,'!');
       inc(i);
      end;
     end;
     ord('&'):begin
      if ((i+1)<length(s)) and (s[i+1]=ord('&')) then begin
       AddToken(etLAND,'&&');
       inc(i,2);
      end else begin
       AddToken(etAND,'&');
       inc(i);
      end;
     end;
     ord('|'):begin
      if ((i+1)<length(s)) and (s[i+1]=ord('|')) then begin
       AddToken(etLOR,'||');
       inc(i,2);
      end else begin
       AddToken(etOR,'|');
       inc(i);
      end;
     end;
     ord('%'):begin
      AddToken(etMOD,'%');
      inc(i);
     end;
     ord('*'):begin
      AddToken(etMUL,'*');
      inc(i);
     end;
     ord('^'):begin
      AddToken(etXOR,'^');
      inc(i);
     end;
     ord('('):begin
      AddToken(etLPAR,'(');
      inc(i);
     end;
     ord(')'):begin
      AddToken(etRPAR,')');
      inc(i);
     end;
     ord(','):begin
      AddToken(etCOMMA,',');
      inc(i);
     end;
     ord('?'):begin
      AddToken(etQUEST,'?');
      inc(i);
     end;
     ord(':'):begin
      AddToken(etCOLON,':');
      inc(i);
     end;
     ord('0')..ord('9'):begin
      ns:=nil;
      UCS4Clear(ns);
      while (i<length(s)) and (s[i] in [ord('0')..ord('9'),ord('a')..ord('z'),ord('A')..ord('Z')]) do begin
       UCS4AddChar(ns,s[i]);
       inc(i);
      end;
      AddToken(etNUMBER,ns);
     end;
     else begin
      AddToken(etCHAR,s[i]);
      inc(i);
     end;
    end;
   end;
  end;
  procedure PreprocessTokens;
  var i:integer;
  begin
   i:=0;
   while i<length(FIFO.Tokens) do begin
    if FIFO.Tokens[i].Token=etPLUS then begin
     if (i>0) and not (FIFO.Tokens[i-1].Token in [etNUMBER,etNAME,etCHAR,etRPAR]) then begin
      FIFO.Tokens[i].Token:=etUPLUS;
     end;
    end else if FIFO.Tokens[i].Token=etMINUS then begin
     if (i>0) and not (FIFO.Tokens[i-1].Token in [etNUMBER,etNAME,etCHAR,etRPAR]) then begin
      FIFO.Tokens[i].Token:=etUMINUS;
     end;
    end;
    inc(i);
   end;
  end;
  function OpPrec(Token:TEvalToken):integer;
  begin
   result:=OpPrecLUT[Token];
{  case Token of
    etLNOT,etNOT,etUPLUS,etUMINUS:begin
     result:=13;
    end;
    etMUL,etDIV,etMOD:begin
     result:=12;
    end;
    etPLUS,etMINUS:begin
     result:=11;
    end;
    etLSH,etRSH:begin
     result:=10;
    end;
    etLT,etLEQ,etGT,etGEQ:begin
     result:=9;
    end;
    etEQ,etLNEQ:begin
     result:=8;
    end;
    etAND:begin
     result:=7;
    end;
    etXOR:begin
     result:=6;
    end;
    etOR:begin
     result:=5;
    end;
    etLAND:begin
     result:=4;
    end;
    etLOR:begin
     result:=3;
    end;
    etQUEST:begin
     result:=2;
    end;
    etCOMMA:begin
     result:=1;
    end;
    else begin
     result:=666;
    end;
   end;}
  end;
  function BoolVal(v:TValue):boolean;
  begin
   if v.Sign then begin
    result:=v.s<>0;
   end else begin
    result:=v.us<>0;
   end;
  end;
  function ParseNumber(s:TUCS4STRING):TValue;
  var i:integer;
      sv:longint;
      usv:longword;
      b:boolean;
  begin
   b:=false;
   fillchar(result,sizeof(TValue),#0);
   result.Sign:=true;
   while (length(s)>0) and (s[length(s)-1] in [ord('l'),ord('L'),ord('u'),ord('U')]) do begin
    if (length(s)>0) and (s[length(s)-1] in [ord('u'),ord('U')]) then begin
     result.Sign:=false;
    end;
    UCS4Delete(s,length(s)-1,1);
   end;
   if result.Sign then begin
    if (length(s)>0) and (s[0]=ord('0')) then begin
     if (length(s)>1) and (s[1] in [ord('x'),ord('X')]) then begin
      result.s:=0;
      for i:=2 to length(s)-1 do begin
       if (not b) and (((result.s*16) div 16)<>result.s) then begin
        b:=true;
        AddWarning('TERM: constant too large for destination type');
       end;
       case s[i] of
        ord('0')..ord('9'):begin
         sv:=s[i]-ord('0');
        end;
        ord('a')..ord('f'):begin
         sv:=s[i]-ord('a')+$a;
        end;
        ord('A')..ord('F'):begin
         sv:=s[i]-ord('A')+$a;
        end;
        else begin
         sv:=0;
        end;
       end;
       result.s:=(result.s*16)+sv;
      end;
     end else begin
      result.s:=0;
      for i:=1 to length(s)-1 do begin
       if (not b) and (((result.s*8) div 8)<>result.s) then begin
        b:=true;
        AddWarning('TERM: constant too large for destination type');
       end;
       result.s:=(result.s*8)+(s[i]-ord('0'));
      end;
     end;
    end else begin
     result.s:=0;
     for i:=0 to length(s)-1 do begin
      if (not b) and (((result.s*10) div 10)<>result.s) then begin
       b:=true;
       AddWarning('TERM: constant too large for destination type');
      end;
      result.s:=(result.s*10)+(s[i]-ord('0'));
     end;
    end;
   end else begin
    if (length(s)>0) and (s[0]=ord('0')) then begin
     if (length(s)>1) and (s[1] in [ord('x'),ord('X')]) then begin
      result.us:=0;
      for i:=2 to length(s)-1 do begin
       if (not b) and (((result.us*16) div 16)<>result.us) then begin
        b:=true;
        AddWarning('TERM: constant too large for destination type');
       end;
       case s[i] of
        ord('0')..ord('9'):begin
         usv:=longword(s[i]-ord('0'));
        end;
        ord('a')..ord('f'):begin
         usv:=longword(s[i]-ord('a'))+$a;
        end;
        ord('A')..ord('F'):begin
         usv:=longword(s[i]-ord('A'))+$a;
        end;
        else begin
         usv:=0;
        end;
       end;
       result.us:=(result.us*16)+usv;
      end;
     end else begin
      result.us:=0;
      for i:=1 to length(s)-1 do begin
       if (not b) and (((result.us*8) div 8)<>result.us) then begin
        b:=true;
        AddWarning('TERM: constant too large for destination type');
       end;
       result.us:=(result.us*8)+longword(s[i]-ord('0'));
      end;
     end;
    end else begin
     result.us:=0;
     for i:=0 to length(s)-1 do begin
      if (not b) and (((result.us*10) div 10)<>result.us) then begin
       b:=true;
       AddWarning('TERM: constant too large for destination type');
      end;
      result.us:=(result.us*10)+longword(s[i]-ord('0'));
     end;
    end;
   end;
  end;
  function DoTokenUnary(Token:TEvalToken;v:TValue):TValue;
  begin
   case Token of
    etLNOT:begin
     result.sign:=true;
     result.s:=ord(v.s=0);
    end;
    etNOT:begin
     result.sign:=v.sign;
     if result.sign then begin
      result.s:=not v.s;
     end else begin
      result.us:=not v.us;
     end;
    end;
    etPLUS:begin
     result:=v;
    end;
    etMINUS:begin
     result.sign:=v.sign;
     if result.sign then begin
      result.s:=-v.s;
     end else begin
      result.us:=-v.us;
     end;
    end;
    else begin
     result:=v;
    end;
   end;
  end;
  {$hints off}
  function DoTokenBinary(Token:TEvalToken;v1,v2:TValue):TValue;
  var iv2:integer;
  begin
   fillchar(result,sizeof(TValue),#0);
   iv2:=0;
   case Token of
    etMUL,etDIV,etMOD,etPLUS,etMINUS,etAND,etXOR,etOR:begin
     if (not v1.Sign) or (not v2.Sign) then begin
      if v1.Sign then begin
       v1.Sign:=false;
       v1.us:=v1.s;
      end else if v2.Sign then begin
       v2.Sign:=false;
       v2.us:=v2.s;
      end;
      result.Sign:=false;
     end else begin
      result.Sign:=true;
     end;
    end;
    etLT,etLEQ,etGT,etGEQ,etEQ,etNEQ:begin
     if (not v1.Sign) or (not v2.Sign) then begin
      if v1.Sign then begin
       v1.Sign:=false;
       v1.us:=v1.s;
      end else if v2.Sign then begin
       v2.Sign:=false;
       v2.us:=v2.s;
      end
     end;
     result.Sign:=true;
    end;
    etLAND,etLOR:begin
     result.Sign:=true;
    end;
    etLSH,etRSH:begin
     result.Sign:=v1.Sign;
     if v2.Sign then begin
      iv2:=v2.s;
     end else begin
      iv2:=v2.us;
     end;
    end;
    etCOMMA:begin
     result.Sign:=v2.Sign;
    end;
   end;
   case Token of
    etMUL:begin
     if result.Sign then begin
      result.s:=v1.s*v2.s;
     end else begin
      result.us:=v1.us*v2.us;
     end;
    end;
    etDIV:begin
     if result.Sign then begin
      if v2.s=0 then begin
       AddError('TERM: divide by zero');
       result.s:=0;
      end else begin
       result.s:=v1.s div v2.s;
      end;
     end else begin
      if v2.s=0 then begin
       AddError('TERM: divide by zero');
       result.us:=0;
      end else begin
       result.us:=v1.us div v2.us;
      end;
     end;
    end;
    etMOD:begin
     if result.Sign then begin
      if v2.s=0 then begin
       AddError('TERM: divide by zero');
       result.s:=0;
      end else begin
       result.s:=v1.s mod v2.s;
      end;
     end else begin
      if v2.s=0 then begin
       AddError('TERM: divide by zero');
       result.us:=0;
      end else begin
       result.us:=v1.us mod v2.us;
      end;
     end;
    end;
    etPLUS:begin
     if result.Sign then begin
      result.s:=v1.s+v2.s;
     end else begin
      result.us:=v1.us+v2.us;
     end;
    end;
    etMINUS:begin
     if result.Sign then begin
      result.s:=v1.s-v2.s;
     end else begin
      result.us:=v1.us-v2.us;
     end;
    end;
    etLSH:begin
     if result.Sign then begin
      result.s:=v1.s*(1 shl iv2);
     end else begin
      result.us:=v1.us shl iv2;
     end;
    end;
    etRSH:begin
     if result.Sign then begin
      result.s:=v1.s div (1 shl iv2);
     end else begin
      result.us:=v1.us shr iv2;
     end;
    end;
    etLT:begin
     if v1.Sign then begin
      if v1.s<v2.s then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if v1.us<v2.us then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etLEQ:begin
     if v1.Sign then begin
      if v1.s<=v2.s then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if v1.us<=v2.us then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etGT:begin
     if v1.Sign then begin
      if v1.s>v2.s then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if v1.us>v2.us then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etGEQ:begin
     if v1.Sign then begin
      if v1.s>=v2.s then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if v1.us>=v2.us then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etEQ:begin
     if v1.Sign then begin
      if v1.s=v2.s then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if v1.us=v2.us then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etNEQ:begin
     if v1.Sign then begin
      if v1.s<>v2.s then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if v1.us<>v2.us then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etAND:begin
     if result.Sign then begin
      result.s:=v1.s and v2.s;
     end else begin
      result.us:=v1.us and v2.us;
     end;
    end;
    etXOR:begin
     if result.Sign then begin
      result.s:=v1.s xor v2.s;
     end else begin
      result.us:=v1.us xor v2.us;
     end;
    end;
    etOR:begin
     if result.Sign then begin
      result.s:=v1.s or v2.s;
     end else begin
      result.us:=v1.us or v2.us;
     end;
    end;
    etLAND:begin
     if v1.Sign then begin
      if (v1.s<>0) and (v2.s<>0) then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if (v1.us<>0) and (v2.us<>0) then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etLOR:begin
     if v1.Sign then begin
      if (v1.s<>0) or (v2.s<>0) then begin
       result.s:=1;
      end else begin
       result.s:=0;
      end;
     end else begin
      if (v1.us<>0) or (v2.us<>0) then begin
       result.us:=1;
      end else begin
       result.us:=0;
      end;
     end;
    end;
    etCOMMA:begin
     result:=v2;
    end;
   end;
  end;
  {$hints on}
  function DoLevel(MinPrec:integer;DoEval:boolean):TValue;
  var at:TEvalTokenItem;
      bp:integer;
      r1,r2,tr:TValue;
      qb:boolean;
  begin
   fillchar(result,sizeof(TValue),#0);
   result.Sign:=true;
   if FIFO.index>=length(FIFO.Tokens) then begin
    AddError('TERM: truncated constant integral expression');
    exit;
   end;
   at:=FIFO.Tokens[FIFO.index];
   inc(FIFO.index);
   case at.Token of
    etLPAR:begin
     result:=DoLevel(0,DoEval);
     if FIFO.index>=length(FIFO.Tokens) then begin
      AddError('TERM: truncated constant integral expression');
      exit;
     end;
     at:=FIFO.Tokens[FIFO.index];
     inc(FIFO.index);
     if at.Token<>etRPAR then begin
      AddError('TERM: a right parenthesis was expected');
      exit;
     end;
    end;
    etNUMBER:begin
     result:=ParseNumber(at.s);
    end;
    else begin
     if at.Token in TokenUnary then begin
      result:=DoTokenUnary(at.Token,DoLevel(OpPrec(at.Token),DoEval));
     end else if at.Token in WrongToken then begin
      AddError('TERM: rogue operator '''+UCS4ToUTF8(at.s)+''' in constant integral');
      exit;
     end else begin
      AddError('TERM: invalid token in constant integral expression');
      exit;
     end;
    end;
   end;
   while true do begin
    if FIFO.index>=length(FIFO.Tokens) then begin
     exit;
    end;
    at:=FIFO.Tokens[FIFO.index];
    inc(FIFO.index);
    if at.Token in TokenBinary then begin
     bp:=OpPrec(at.Token);
     if bp>MinPrec then begin
      if ((at.Token=etLOR) and BoolVal(result)) or ((at.Token=etLAND) and not BoolVal(result)) then begin
       tr:=DoLevel(bp,false);
       if DoEval then begin
        result.Sign:=true;
        case at.Token of
         etLOR:result.s:=1;
         etLAND:result.s:=0;
        end;
       end;
      end else begin
       tr:=DoLevel(bp,DoEval);
       result:=DoTokenBinary(at.Token,result,tr);
      end;
      continue;
     end;
    end else if at.Token=etQUEST then begin
     bp:=OpPrec(etQUEST);
     if bp>=MinPrec then begin
      qb:=BoolVal(result);
      r1:=DoLevel(bp,DoEval and qb);
      if FIFO.index>=length(FIFO.Tokens) then begin
       AddError('TERM: truncated constant integral expression');
       exit;
      end;
      at:=FIFO.Tokens[FIFO.index];
      inc(FIFO.index);
      if at.Token<>etCOLON then begin
       AddError('TERM: a colon was expected');
       exit;
      end;
      r2:=DoLevel(bp,DoEval and not qb);
      if DoEval then begin
       if qb then begin
        result:=r1;
       end else begin
        result:=r2;
       end;
      end;
      continue;
     end;
    end;
    dec(FIFO.index);
    break;
   end;
  end;
 var v:TValue;
 begin
  fillchar(FIFO,sizeof(TEvalTokenFIFO),#0);
  Tokenize(s);
  PreprocessTokens;
  v:=DoLevel(0,true);
  result:=v.us<>0;
  setlength(FIFO.Tokens,0);
 end;
 function Eval:boolean;
 var s,mn:TUCS4STRING;
     i,j,l:integer;
     OldInEval:boolean;
 begin
  s:=nil;
  mn:=nil;
  UCS4Clear(mn);
  OldInEval:=InEval;
  InEval:=true;
  result:=false;
  l:=length(InputStack);
  UCS4Clear(s);
  while (length(InputStack)>l) or not (GetCharAt(0) in [0,10]) do begin
   ExtGetToken;
   if CurrentToken=tNAME then begin
    if UCS4Compare(CurrentTokenString,'defined') then begin
     SkipGetToken;
     if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('(')) then begin
      SkipGetToken;
      if CurrentToken<>tNAME then begin
       AddError('TERM: missing macro name');
       SkipEOL;
       exit;
      end;
      mn:=copy(CurrentTokenString,0,length(CurrentTokenString));
      SkipExtGetToken;
      if not ((CurrentToken=tCHAR) and (CurrentTokenChar=ord(')'))) then begin
       AddError('TERM: missing )');
       SkipEOL;
       exit;
      end;
     end else begin
      if CurrentToken<>tNAME then begin
       AddError('TERM: missing macro name');
       SkipEOL;
       exit;
      end;
      mn:=copy(CurrentTokenString,0,length(CurrentTokenString));
     end;
     if LookUp(mn)>=0 then begin
      UCS4AddString(s,'1L');
     end else begin
      UCS4AddString(s,'0L');
     end;
    end else begin
     UCS4AddString(s,'0');
    end;
   end else if CurrentToken in [tSTRING,tSTRINGLONG] then begin
    j:=0;
    for i:=length(CurrentTokenString)-1 downto 0 do begin
     j:=(j*256)+CurrentTokenString[1];
    end;
    UCS4AddString(s,inttostr(j));
    if CurrentToken=tSTRINGLONG then begin
     UCS4AddString(s,'L');
    end;
   end else if CurrentToken=tNUMBER then begin
    UCS4Add(s,CurrentTokenString);
   end else begin
    if not ((CurrentToken=tCHAR) and (CurrentTokenChar in UCS4WhiteSpaceEx)) then begin
     UCS4Add(s,CurrentTokenString);
    end;
   end;
  end;
  result:=EvalString(s);
  InEval:=OldInEval;
 end;
 procedure DoIF;
 var Keyword:integer;
 begin
  inc(IFNestedLevel);
  if not Eval then begin
   repeat
    Keyword:=kwNONE;
    SearchELSEENDIF(Keyword);
    if not ((CurrentToken=tNAME) and (Keyword=kwELIF)) then begin
     SkipEOL;
     exit;
    end;
   until Eval;
  end;
 end;
 procedure DoIFDEF(ShouldResultValue:boolean);
 var Keyword:integer;
 begin
  SkipGetToken;
  if CurrentToken<>tNAME then begin
   if ShouldResultValue then begin
    AddWarning('#ifdef: missing identifier');
   end else begin
    AddWarning('#ifndef: missing identifier');
   end;
   SkipEOL;
   exit;
  end;
  inc(IFNestedLevel);
  if (LookUp(CurrentTokenString)>=0)<>ShouldResultValue then begin
   repeat
    Keyword:=kwNONE;
    SearchELSEENDIF(Keyword);
    if not ((CurrentToken=tNAME) and (Keyword=kwELIF)) then begin
     SkipEOL;
     exit;
    end;
   until Eval;
  end;
 end;
 procedure DoELSEELIF;
 var Keyword:integer;
 begin
  if IFNestedLevel=0 then begin
   AddError('missing #if');
  end else begin
   Keyword:=kwNONE;
   while SearchELSEENDIF(Keyword) do begin
    Keyword:=kwNONE;
   end;
  end;
  SkipEOL;
 end;
 procedure DoENDIF;
 begin
  if IFNestedLevel=0 then begin
   AddError('missing #if');
  end else begin
   dec(IFNestedLevel);
  end;
  SkipEOL;
 end;
 procedure DoLINE;
 var l,s:integer;
 begin
  SkipExtGetToken;
  if CurrentToken<>tNUMBER then begin
   AddWarning('#line: missing number');
   SkipEOL;
   exit;
  end;
//l:=LastLine;
  s:=LastSource;
  l:=ParseNumber(CurrentTokenString);
  SkipExtGetToken;
  if (CurrentToken=tCHAR) and (CurrentTokenChar in [0,10]) then begin
   LastLine:=l;
   if length(InputStack)>0 then begin
    InputStack[length(InputStack)-1].BufferLine:=LastLine-1;
   end;
   PushInputSource(iskNONE,nil,UTF8toUCS4(#10));
   exit;
  end else if CurrentToken=tSTRING then begin
   if length(CurrentTokenString)<2 then begin
    AddError('#line: string not closed');
    exit;
   end;
   if CurrentTokenString[0]<>CurrentTokenString[length(CurrentTokenString)-1] then begin
    AddError('#line: invalid string');
    exit;
   end;
   s:=GetInputSourceIndex(iskFILE,Destringize(copy(CurrentTokenString,1,length(CurrentTokenString)-2)));
  end else if CurrentToken=tNAME then begin
   s:=GetInputSourceIndex(iskFILE,CurrentTokenString);
  end;
  while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,10])) do begin
   GetToken;
  end;
  if length(InputStack)>0 then begin
   LastSource:=s;
   LastLine:=l;
   InputStack[length(InputStack)-1].BufferLine:=LastLine-1;
   InputStack[length(InputStack)-1].Source:=LastSource;
  end;
  PushInputSource(iskNONE,nil,UTF8toUCS4(#10));
 end;
 procedure DoPRAGMA;
 var s:TUCS4STRING;
 begin
  s:=nil;
  UCS4Clear(s);
  while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,10])) do begin
   UCS4AddChar(s,NextChar);
  end;
  setlength(Instance.Preprocessor.PragmaInfo,length(Instance.Preprocessor.PragmaInfo)+1);
  Instance.Preprocessor.PragmaInfo[length(Instance.Preprocessor.PragmaInfo)-1].CharPos:=length(Instance.Preprocessor.OutputText)+1;
  Instance.Preprocessor.PragmaInfo[length(Instance.Preprocessor.PragmaInfo)-1].Pragma:=copy(s,0,length(s));
 end;
 procedure DoERROR;
 var s:TUCS4STRING;
 begin
  s:=nil;
  SkipBlank;
  UCS4Clear(s);
  while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,10])) do begin
   UCS4Add(s,CurrentTokenString);
   GetToken;
  end;
  AddError(UCS4ToUTF8(s));
 end;
 procedure DoWARNING;
 var s:TUCS4STRING;
 begin
  s:=nil;
  SkipBlank;
  UCS4Clear(s);
  while not ((CurrentToken=tCHAR) and (CurrentTokenChar in [0,10])) do begin
   UCS4Add(s,CurrentTokenString);
   GetToken;
  end;
  AddError(UCS4ToUTF8(s));
 end;
var NewLine:boolean;
    MacroBody:TMacroBody;
begin
 MacroStringTree:=TStringTreeMemory.Create;
 MacroStringTree.Hashing:=true;
 KeywordStringTree:=TStringTreeMemory.Create;
 KeywordStringTree.Hashing:=true;
 KeywordStringTree.Add(UTF8ToUCS4('include'),kwINCLUDE);
 KeywordStringTree.Add(UTF8ToUCS4('include_next'),kwINCLUDENEXT);
 KeywordStringTree.Add(UTF8ToUCS4('define'),kwDEFINE);
 KeywordStringTree.Add(UTF8ToUCS4('undef'),kwUNDEF);
 KeywordStringTree.Add(UTF8ToUCS4('if'),kwIF);
 KeywordStringTree.Add(UTF8ToUCS4('ifdef'),kwIFDEF);
 KeywordStringTree.Add(UTF8ToUCS4('ifndef'),kwIFNDEF);
 KeywordStringTree.Add(UTF8ToUCS4('elif'),kwELIF);
 KeywordStringTree.Add(UTF8ToUCS4('else'),kwELSE);
 KeywordStringTree.Add(UTF8ToUCS4('endif'),kwENDIF);
 KeywordStringTree.Add(UTF8ToUCS4('line'),kwLINE);
 KeywordStringTree.Add(UTF8ToUCS4('pragma'),kwPRAGMA);
 KeywordStringTree.Add(UTF8ToUCS4('error'),kwERROR);
 KeywordStringTree.Add(UTF8ToUCS4('warning'),kwWARNING);
 Trigraphs:=false;
 LastSource:=-1;
 LastLine:=-1;
 InEval:=false;
 InputStack:=nil;
 Macros:=nil;
 MacroBody:=nil;
 setlength(MacroBody,0);
 AddDefine(UTF8ToUCS4('__FILE__'),MacroBody,0,false,mfFILE);
 AddDefine(UTF8ToUCS4('__LINE__'),MacroBody,0,false,mfLINE);
 AddDefine(UTF8ToUCS4('__TIME__'),MacroBody,0,false,mfTIME);
 AddDefine(UTF8ToUCS4('__DATE__'),MacroBody,0,false,mfDATE);
 AddDefine(UTF8ToUCS4('_Pragma'),MacroBody,0,false,mfPRAGMA);
 setlength(MacroBody,1);
 MacroBody[0].Kind:=mbikTEXT;
 MacroBody[0].Text:=UTF8ToUCS4('1');
 MacroBody[0].Quote:=false;
 AddDefine(UTF8ToUCS4('__STDC__'),MacroBody,0,false,mfNONE);
 AddDefine(UTF8ToUCS4('__BFCC__'),MacroBody,0,false,mfNONE);
 AddDefine(UTF8ToUCS4('__STDC_HOSTED__'),MacroBody,0,false,mfNONE);
 setlength(MacroBody,1);
 MacroBody[0].Kind:=mbikTEXT;
 MacroBody[0].Text:=UTF8ToUCS4('unsigned int');
 MacroBody[0].Quote:=false;
 AddDefine(UTF8ToUCS4('__SIZE_TYPE__'),MacroBody,0,false,mfNONE);
 setlength(MacroBody,1);
 MacroBody[0].Kind:=mbikTEXT;
 MacroBody[0].Text:=UTF8ToUCS4('int');
 MacroBody[0].Quote:=false;
 AddDefine(UTF8ToUCS4('__PTRDIFF_TYPE__'),MacroBody,0,false,mfNONE);
 AddDefine(UTF8ToUCS4('__WCHAR_TYPE__'),MacroBody,0,false,mfNONE);
 MacroBody[0].Kind:=mbikTEXT;
 MacroBody[0].Text:=UTF8ToUCS4('199901L');
 MacroBody[0].Quote:=false;
 AddDefine(UTF8ToUCS4('__STDC_VERSION__'),MacroBody,0,false,mfNONE);
 setlength(MacroBody,0);
 setlength(Instance.Preprocessor.PragmaInfo,0);
 setlength(Instance.Preprocessor.OutputInfo,0);
 UCS4Clear(Instance.Preprocessor.OutputText);
 PushInputSource(Instance.Preprocessor.InputKind,Instance.Preprocessor.InputName,ProprocessInputSourceChars(Instance.Preprocessor.InputKind,Instance.Preprocessor.InputName,Instance.Preprocessor.InputText));
 NewLine:=true;
 IFNestedLevel:=0;
 MacroLevel:=0;
 while length(InputStack)>0 do begin
  ExtGetToken;
  if (((CurrentToken=tCHAR) and (CurrentTokenChar=ord('#'))) or
      ((CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':')))) and NewLine then begin
   if (CurrentToken=tCHAR) and (CurrentTokenChar=ord('%')) and (GetCharAt(0)=ord(':')) then begin
    NextChar;
   end;
   SkipGetToken;
   case LookUpKeyword(CurrentTokenString) of
    kwINCLUDE:begin
     DoINCLUDE(false);
    end;
    kwINCLUDENEXT:begin
     DoINCLUDE(true);
    end;
    kwDEFINE:begin
     DoDEFINE;
    end;
    kwUNDEF:begin
     DoUNDEF;
    end;
    kwIF:begin
     DoIF;
    end;
    kwIFDEF:begin
     DoIFDEF(true);
    end;
    kwIFNDEF:begin
     DoIFDEF(false);
    end;
    kwELIF:begin
     DoELSEELIF;
    end;
    kwELSE:begin
     DoELSEELIF;
    end;
    kwENDIF:begin
     DoENDIF;
    end;
    kwLINE:begin
     DoLINE;
    end;
    kwPRAGMA:begin
     DoPRAGMA;
    end;
    kwERROR:begin
     DoERROR;
    end;
    kwWARNING:begin
     DoWARNING;
    end;
    else begin
     AddWarning('undefined statement: '+UCS4ToUTF8(CurrentTokenString));
     SkipEOL;
    end;
   end;
  end else begin
   if CurrentToken=tSTRINGLONG then begin
    AddToOutput(STRINGToUCS4('L'));
    AddToOutput(CurrentTokenString);
    NewLine:=false;
   end else if CurrentToken=tCHAR then begin
    if CurrentTokenChar in [0..255] then begin
     case CurrentTokenChar of
      0:begin
       AddToOutput(CurrentTokenString);
      end;
      10:begin
       NewLine:=true;
      end;
      9,11,12,13,32:begin
      end;
      else begin
       NewLine:=false;
      end;
     end;
    end else if CurrentTokenChar<0 then begin
     continue;
    end;
   end else begin
    NewLine:=false;
   end;
   AddToOutput(CurrentTokenString);
  end;
 end;
 if (length(Instance.Preprocessor.OutputInfo)>0) then begin
  if Instance.Preprocessor.OutputInfo[length(Instance.Preprocessor.OutputInfo)-1].LastCharPos<>(length(Instance.Preprocessor.OutputText)-1) then begin
   Instance.Preprocessor.OutputInfo[length(Instance.Preprocessor.OutputInfo)-1].LastCharPos:=(length(Instance.Preprocessor.OutputText)-1);
  end;
 end;
 setlength(InputStack,0);
 setlength(Macros,0);
 setlength(MacroBody,0);
 KeywordStringTree.Destroy;
 MacroStringTree.Destroy;
end;

end.
