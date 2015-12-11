(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoUtils;
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

{$IFDEF WIN32}
uses Windows;
{$ELSE}
uses SysUtils;
{$ENDIF}

type TCharSet=set of char;
     TAlphabet=array['A'..'Z'] of char;

     TFileName=string;

     dword=longword;

     Int64Rec=packed record
      Lo,Hi:dword;
     end;

     LongRec=packed record
      Lo,Hi:word;
     end;

{$IFDEF WIN32}
     TSearchRec=record
      Time,Size,Attr:integer;
      name:TFileName;
      ExcludeAttr:integer;
      FindHandle:THandle;
      FindData:TWin32FindData;
     end;
{$ELSE}
     TSearchRec=SysUtils.TSearchRec;
{$ENDIF}

const Alphabet:TCharSet=['A'..'Z'];
      SmallCaps:TAlphabet=('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
      SentenceChars:TCharSet=['.',',',';','!','?'];
      SearchSentenceChars:TCharSet=['.','!','?'];
      SpaceChars:TCharSet=[#0..#32];

      DirSplashChar={$IFDEF unixversion}'/'{$ELSE}'\'{$ENDIF};
      DirSplashNotChar={$IFNDEF unixversion}'/'{$ELSE}'\'{$ENDIF};

      fmOpenRead=$0000;
      fmOpenWrite=$0001;
      fmOpenReadWrite=$0002;
      fmShareCompat=$0000;
      fmShareExclusive=$0010;
      fmShareDenyWrite=$0020;
      fmShareDenyRead=$0030;
      fmShareDenyNone=$0040;

      faReadOnly=$00000001;
      faHidden=$00000002;
      faSysFile=$00000004;
      faVolumeID=$00000008;
      faDirectory=$00000010;
      faArchive=$00000020;
      faAnyFile=$0000003f;

function Parse(var S:string;C:TCharSet;Continuous:boolean=false):string; overload;
function Parse(var S:string;C:char;Continuous:boolean=false):string; overload;
function STRTOINT(S:string):int64;
function INTTOSTR(I:int64):string;
function STRTOFLOAT(S:string):extended;
function FLOATTOSTR(F:extended):string;
function StrLCopy(Dest:pchar;const Source:pchar;MaxLen:longword):pchar; assembler;
function StrPCopy(Dest:pchar;const Source:string):pchar;
function FindNext(var F:TSearchRec):integer;
procedure FindClose(var F:TSearchRec);
function FindFirst(const Path:string;Attr:integer;var F:TSearchRec):integer;
function FILEEXISTS(S:string):boolean;
function ExtractFileExt(S:string):string;
function ExtractFileName(S:string):string;
function ExtractFilePath(S:string):string;
function ChangeFileExt(S,E:string):string;
function TRIM(const S:string):string;
function UPPERCASE(const S:string):string;
function LOWERCASE(const S:string):string;
function UPCASE(const C:char):char;
function LOCASE(const C:char):char;
function StringReplace(var S:string;const FindStr,RepStr:string):boolean;
function StringReplaceAll(var S:string;const FindStr,RepStr:string):boolean;
function MatchPattern(Input,Pattern:pchar):boolean;
function StrToAddr(S:string):integer;
function AddrToStr(Address:integer):string;
procedure FastFillChar(var Dest;Count:integer;Value:char);
function AreBytesEqual(const A,B;Count:integer):boolean;
function GetNoteDuration(NoteType,ShortestTime:integer;Dots:integer=0):integer;
function GCD(A,B:integer):integer;
function Swap16(const Value:word):word;
function Swap32(const Value:longword):longword; 
function SwapWordLittleEndian(Value:word):word; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
function SwapDWordLittleEndian(Value:longword):longword; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
function SwapWordBigEndian(Value:word):word; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
function SwapDWordBigEndian(Value:longword):longword; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
procedure SwapLittleEndianData16(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
procedure SwapLittleEndianData32(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
procedure SwapBigEndianData16(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
procedure SwapBigEndianData32(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
function DecToHex(Value:int64):string;
function HexToDec(Value:string):int64;
function ByteToHex(Value:byte):string;
function HexToByte(Value:string):byte;
function WordToHex(Value:word):string;
function HexToWord(Value:string):word;
function LongWordToHex(Value:longword):string;
function HexToLongWord(Value:string):longword;
function FABS(Value:single):single;

implementation

const HexNumbers:array[0..$f] of char='0123456789ABCDEF';

function Parse(var S:string;C:TCharSet;Continuous:boolean=false):string; overload;
var Counter,index:integer;
begin
 index:=0;
 for Counter:=1 to length(S) do begin
  if S[Counter] in C then begin
   index:=Counter;
   break;
  end;
 end;
 if index<>0 then begin
  result:=COPY(S,1,index-1);
  DELETE(S,1,index);
 end else begin
  result:=S;
  S:='';
 end;
 if Continuous then while (length(S)>0) and (S[1] in C) do DELETE(S,1,1);
end;

function Parse(var S:string;C:char;Continuous:boolean=false):string; overload;
var index:integer;
begin
 index:=POS(C,S);;
 if index<>0 then begin
  result:=COPY(S,1,index-1);
  DELETE(S,1,index);
 end else begin
  result:=S;
  S:='';
 end;
 if Continuous then while (length(S)>0) and (S[1]=C) do DELETE(S,1,1);
end;

function STRTOINT(S:string):int64;
var Code:integer;
begin
 VAL(S,result,Code);
end;

function INTTOSTR(I:int64):string;
begin
 STR(I,result);
end;

function STRTOFLOAT(S:string):extended;
var Code:integer;
begin
 VAL(S,result,Code);
end;

function FLOATTOSTR(F:extended):string;
begin
 if F=TRUNC(F) then begin
  result:=INTTOSTR(TRUNC(F));
 end else begin
  STR(F,result);
  result:=TRIM(result);
 end;
end;

function StrLCopy(Dest:pchar;const Source:pchar;MaxLen:longword):pchar; assembler;
asm
 PUSH EDI
 PUSH ESI
 PUSH EBX
 MOV ESI,EAX
 MOV EDI,EDX
 MOV EBX,ECX
 xor AL,AL
 TEST ECX,ECX
 JZ @@1
 REPNE SCASB
 JNE @@1
 inc ECX
@@1:
 SUB EBX,ECX
 MOV EDI,ESI
 MOV ESI,EDX
 MOV EDX,EDI
 MOV ECX,EBX
 shr ECX,2
 REP MOVSD
 MOV ECX,EBX
 and ECX,3
 REP MOVSB
 STOSB
 MOV EAX,EDX
 POP EBX
 POP ESI
 POP EDI
end;

function StrPCopy(Dest:pchar;const Source:string):pchar;
begin
 result:=StrLCopy(Dest,pchar(Source),length(Source));
end;

{$IFDEF WIN32}
function FindMatchingFile(var F:TSearchRec):integer;
var LocalFileTime:TFileTime;
begin
 with F do begin
  while (FindData.dwFileAttributes and ExcludeAttr)<>0 do begin
   if not Windows.FindNextFile(FindHandle,FindData) then begin
    result:=GetLastError;
    exit;
   end;
  end;
  FileTimeToLocalFileTime(FindData.ftLastWriteTime,LocalFileTime);
  FileTimeToDosDateTime(LocalFileTime,LongRec(Time).Hi,LongRec(Time).Lo);
  Size:=FindData.nFileSizeLow;
  Attr:=FindData.dwFileAttributes;
  name:=FindData.cFileName;
 end;
 result:=0;
end;
{$ENDIF}

function FindNext(var F:TSearchRec):integer;
begin
{$IFDEF WIN32}
 if Windows.FindNextFile(F.FindHandle,F.FindData) then begin
  result:=FindMatchingFile(F);
 end else begin
  result:=GetLastError;
 end;
{$ELSE}
 result:=SysUtils.FindNext(F);
{$ENDIF}
end;

procedure FindClose(var F:TSearchRec);
begin
{$IFDEF WIN32}
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  Windows.FindClose(F.FindHandle);
  F.FindHandle:=INVALID_HANDLE_VALUE;
 end;
{$ELSE}
 SysUtils.FindClose(F);
{$ENDIF}
end;

function FindFirst(const Path:string;Attr:integer;var F:TSearchRec):integer;
{$IFDEF WIN32}
const faSpecial=faHidden or faSysFile or faVolumeID or faDirectory;
{$ENDIF}
begin
{$IFDEF WIN32}
 F.ExcludeAttr:=not Attr and faSpecial;
 F.FindHandle:=Windows.FindFirstFile(pchar(Path),F.FindData);
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  result:=FindMatchingFile(F);
  if result<>0 then FindClose(F);
 end else begin
  result:=GetLastError;
 end;
{$ELSE}
 result:=SysUtils.FindFirst(Path,Attr,F);
{$ENDIF}
end;

function FILEEXISTS(S:string):boolean;
var F:file;
begin
 result:=false;
 ASSIGNFILE(F,S);
 {$I-}RESET(F,1);{$I+}
 if IOResult=0 then begin
  CLOSEFILE(F);
  result:=true;
 end;
end;

function ExtractFileExt(S:string):string;
var I,J,K:integer;
begin
 result:='';
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='.') or (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if (K>0) and (S[K]='.') then result:=COPY(S,K,J-K+1);
end;

function ExtractFileName(S:string):string;
var I,J,K:integer;
begin
 result:=S;
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if K>0 then result:=COPY(S,K+1,J-K+1);
end;

function ExtractFilePath(S:string):string;
var I,J,K:integer;
begin
 result:=S;
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if K>0 then result:=COPY(S,1,K);
end;

function ChangeFileExt(S,E:string):string;
var I,J,K:integer;
begin
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='.') or (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if (K>0) and (S[K]='.') then begin
  result:=COPY(S,1,K-1)+E;
 end else begin
  result:=S+E;
 end;
end;

function TRIM(const S:string):string;
var StartPosition,LengthCount:integer;
begin
 LengthCount:=length(S);
 if LengthCount>0 then begin
  while (LengthCount>0) and (S[LengthCount] in [#0..#32]) do dec(LengthCount);
  StartPosition:=1;
  while (StartPosition<=LengthCount) and (S[StartPosition] in [#0..#32]) do inc(StartPosition);
  result:=COPY(S,StartPosition,LengthCount-StartPosition+1);
 end else begin
  result:='';
 end;
end;

function UPPERCASE(const S:string):string;
var I,L:integer;
begin
 result:='';
 L:=length(S);
 I:=1;
 while I<=L do begin
  if S[I] in ['a'..'z'] then begin
   result:=result+char(byte(S[I])-32);
  end else begin
   result:=result+S[I];
  end;
  inc(I);
 end;
end;

function LOWERCASE(const S:string):string;
var I,L:integer;
begin
 result:='';
 L:=length(S);
 I:=1;
 while I<=L do begin
  if S[I] in ['A'..'Z'] then begin
   result:=result+char(byte(S[I])+32);
  end else begin
   result:=result+S[I];
  end;
  inc(I);
 end;
end;

function UPCASE(const C:char):char;
begin
 if C in ['a'..'z'] then begin
  result:=char(byte(C)-32);
 end else begin
  result:=C;
 end;
end;

function LOCASE(const C:char):char;
begin
 if C in ['A'..'Z'] then begin
  result:=char(byte(C)+32);
 end else begin
  result:=C;
 end;
end;

function StringReplace(var S:string;const FindStr,RepStr:string):boolean;
var index:integer;
begin
 result:=false;
 if POS(FindStr,RepStr)=0 then begin
  index:=POS(FindStr,S);
  if index<>0 then begin
   S:=COPY(S,1,index-1)+RepStr+COPY(S,index+length(FindStr),length(S));
   result:=true;
  end;
 end;
end;

function StringReplaceAll(var S:string;const FindStr,RepStr:string):boolean;
begin
 result:=false;
 while StringReplace(S,FindStr,RepStr) do result:=true;
end;

function MatchPattern(Input,Pattern:pchar):boolean;
begin
 result:=true;
 while true do begin
  case Pattern[0] of
   #0:begin
    result:=Input[0]=#0;
    exit;
   end;
   '*':begin
    inc(Pattern);
    if Pattern[0]=#0 then begin
     result:=true;
     exit;
    end;
    while Input[0]<>#0 do begin
     if MatchPattern(Input,Pattern) then begin
      result:=true;
      exit;
     end;
     inc(Input);
    end;
   end;
   '?':begin
    if Input[0]=#0 then begin
     result:=false;
     exit;
    end;
    inc(Input);
    inc(Pattern);
   end;
   '[':begin
    if Pattern[1] in [#0,'[',']'] then begin
     result:=false;
     exit;
    end;
    if Pattern[1]='^' then begin
     inc(Pattern,2);
     result:=true;
     while Pattern[0]<>']' do begin
      if Pattern[1]='-' then begin
       if (Input[0]>=Pattern[0]) and (Input[0]<=Pattern[2]) then begin
        result:=false;
        break;
       end else begin
        inc(Pattern,3);
       end;
      end else begin
       if Input[0]=Pattern[0] then begin
        result:=false;
        break;
       end else begin
        inc(Pattern);
       end;
      end;
     end;
    end else begin
     inc(Pattern);
     result:=false;
     while Pattern[0]<>']' do begin
      if Pattern[1]='-' then begin
       if (Input[0]>=Pattern[0]) and (Input[0]<=Pattern[2]) then begin
        result:=true;
        break;
       end else begin
        inc(Pattern,3);
       end;
      end else begin
       if Input[0]=Pattern[0] then begin
        result:=true;
        break;
       end else begin
        inc(Pattern);
       end;
      end;
     end;
    end;
    if result then begin
     inc(Input);
     while not (Pattern[0] in [']',#0]) do inc(Pattern);
     if Pattern[0]=#0 then begin
      result:=false;
      exit;
     end else begin
      inc(Pattern);
     end;
    end else begin
     exit;
    end;
   end;
   else begin
    if Input[0]<>Pattern[0] then begin
     result:=false;
     break;
    end;
    inc(Input);
    inc(Pattern);
   end;
  end;
 end;
end;

function StrToAddr(S:string):integer;
var R,I,P,C:integer;
    T:string;
begin
 result:=0;
 R:=0;
 for I:=0 to 3 do begin
  P:=POS('.',S);
  if P=0 then P:=length(S)+1;
  if P<=1 then exit;
  T:=COPY(S,1,P-1);
  DELETE(S,1,P);
  VAL(T,P,C);
  if (C<>0) or (P<0) or (P>255) then exit;
  R:=R or P shl (I*8);
 end;
 result:=R;
end;

function AddrToStr(Address:integer):string;
var R,S:string;
    I:integer;
begin
 R:='';
 for I:=0 to 3 do begin
  STR(Address shr (I*8) and $ff,S);
  R:=R+S;
  if I<3 then R:=R+'.';
 end;
 result:=R;
end;

type pinteger=^integer;
     PIntegerArray=^TIntegerArray;
     TIntegerArray=array[0..($7fffffff div sizeof(integer))-1] of integer;

     pbyte=^byte;
     PByteArray=^TByteArray;
     TByteArray=array[0..($7fffffff div sizeof(byte))-1] of byte;

procedure FastFillChar(var Dest;Count:integer;Value:char);
label P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12;
var I,J,K:integer;
    P:pointer;
begin
 if Count>0 then begin
  P:=@Dest;
  if Count>=12 then begin
   J:=byte(Value);
   J:=J or (J shl 8);
   J:=J or (J shl 16);
   pinteger(P)^:=J;
   pinteger(integer(P)+Count-4)^:=J;
   I:=Count shr 2;
   if Count>=256 then begin
    if Count<448 then begin
     PIntegerArray(P)[1]:=J;
     PIntegerArray(P)[2]:=J;
     PIntegerArray(P)[3]:=J;
     repeat
      dec(I,4);
      PIntegerArray(P)[I]:=J;
      PIntegerArray(P)[I+1]:=J;
      PIntegerArray(P)[I+2]:=J;
      PIntegerArray(P)[I+3]:=J;
     until I<4;
    end else begin
     I:=Count;
     K:=(integer(P) and 3)-4;
     dec(I,16);
     dec(pbyte(P),K);
     inc(I,K);
     inc(pbyte(P),I);
     PIntegerArray(P)[0] := J;
     PIntegerArray(P)[1] := J;
     PIntegerArray(P)[2] := J;
     PIntegerArray(P)[3] := J;
     repeat
      PIntegerArray(integer(P)-I)[0]:=J;
      PIntegerArray(integer(P)-I)[1]:=J;
      PIntegerArray(integer(P)-I)[2]:=J;
      PIntegerArray(integer(P)-I)[3]:=J;
      dec(I,16);
     until I<=0;
    end;
   end else begin
    repeat
     dec(I,2);
     PIntegerArray(P)[I]:=J;
     PIntegerArray(P)[I+1]:=J;
    until I<2;
   end;
  end else begin
   case Count of
    1:goto P01;
    2:goto P02;
    3:goto P03;
    4:goto P04;
    5:goto P05;
    6:goto P06;
    7:goto P07;
    8:goto P08;
    9:goto P09;
    10:goto P10;
    11:goto P11;
    12:goto P12;
   end;
   P12:PByteArray(P)[11]:=byte(Value);
   P11:PByteArray(P)[10]:=byte(Value);
   P10:PByteArray(P)[09]:=byte(Value);
   P09:PByteArray(P)[08]:=byte(Value);
   P08:PByteArray(P)[07]:=byte(Value);
   P07:PByteArray(P)[06]:=byte(Value);
   P06:PByteArray(P)[05]:=byte(Value);
   P05:PByteArray(P)[04]:=byte(Value);
   P04:PByteArray(P)[03]:=byte(Value);
   P03:PByteArray(P)[02]:=byte(Value);
   P02:PByteArray(P)[01]:=byte(Value);
   P01:PByteArray(P)[00]:=byte(Value);
  end;
 end;
end;

function AreBytesEqual(const A,B;Count:integer):boolean;
var FirstComparePointer,SecondComparePointer:pbyte;
    Counter:integer;
begin
 try
  result:=true;
  FirstComparePointer:=@A;
  SecondComparePointer:=@B;
  for Counter:=1 to Count do begin
   if FirstComparePointer^<>SecondComparePointer^ then begin
    result:=false;
    exit;
   end;
   inc(FirstComparePointer);
   inc(SecondComparePointer);
  end;
 except
  result:=false;
 end;
end;

function GetNoteDuration(NoteType,ShortestTime:integer;Dots:integer=0):integer;
var Duration,Extra,DotCouunter:integer;
begin
 Duration:=ShortestTime*(1 shl NoteType);
 if Dots<>0 then begin
  Extra:=Duration div 2;
  for DotCouunter:=1 to Dots do begin
   inc(Duration,Extra);
   Extra:=Extra div 2;
  end;
 end;
 result:=Duration;
end;

function GCD(A,B:integer):integer;
begin
 if A=0 then B:=A;
 if B=0 then A:=B;
 while A<>B do begin
  if A>B then dec(A,B);
  if B>A then dec(B,A);
 end;
 if A=0 then A:=1;
 result:=A;
end;

function Swap16(const Value:word):word;
begin
{$IFDEF CPU386}
 result:=((Value and $ff) shl 8) or ((Value and $ff00) shr 8);
{$ELSE}
 result:=Value;
{$ENDIF}
end;

function Swap32(const Value:longword):longword;
begin
{$IFDEF CPU386}
 result:=((Value and $ff) shl 24) or (((Value and $ff00) shr 8) shl 16) or (((Value and $ff0000) shr 16) shl 8) or ((Value and $ff000000) shr 24);
{$ELSE}
 result:=Value;
{$ENDIF}
end;

function SwapWordLittleEndian(Value:word):word; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
begin
{$IFDEF BIG_ENDIAN}
 result:=((Value and $ff00) shr 8) or ((Value and $ff) shl 8);
{$ELSE}
 result:=Value;
{$ENDIF}
end;

function SwapDWordLittleEndian(Value:longword):longword; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
begin
{$IFDEF BIG_ENDIAN}
 result:=((Value and $ff000000) shr 24) or ((Value and $00ff0000) shr 8) or
         ((Value and $0000ff00) shl 8) or ((Value and $000000ff) shl 24);
{$ELSE}
 result:=Value;
{$ENDIF}
end;

function SwapWordBigEndian(Value:word):word; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
begin
{$IFDEF LITTLE_ENDIAN}
 result:=((Value and $ff00) shr 8) or ((Value and $ff) shl 8);
{$ELSE}
 result:=Value;
{$ENDIF}
end;

function SwapDWordBigEndian(Value:longword):longword; {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
begin
{$IFDEF LITTLE_ENDIAN}
 result:=((Value and $ff000000) shr 24) or ((Value and $00ff0000) shr 8) or
         ((Value and $0000ff00) shl 8) or ((Value and $000000ff) shl 24);
{$ELSE}
 result:=Value;
{$ENDIF}
end;

procedure SwapLittleEndianData16(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
{$IFDEF BIG_ENDIAN}
var Value:word absolute Data;
begin
 Value:=((Value and $ff00) shr 8) or ((Value and $ff) shl 8);
{$ELSE}
begin
{$ENDIF}
end;

procedure SwapLittleEndianData32(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
{$IFDEF BIG_ENDIAN}
var Value:longword absolute Data;
begin
 Value:=((Value and $ff000000) shr 24) or ((Value and $00ff0000) shr 8) or
        ((Value and $0000ff00) shl 8) or ((Value and $000000ff) shl 24);
{$ELSE}
begin
{$ENDIF}
end;

procedure SwapBigEndianData16(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
{$IFDEF LITTLE_ENDIAN}
var Value:word absolute Data;
begin
 Value:=((Value and $ff00) shr 8) or ((Value and $ff) shl 8);
{$ELSE}
begin
 result:=Value;
{$ENDIF}
end;

procedure SwapBigEndianData32(var Data); {$IFDEF FPC}{INLINE;}{$ELSE}register;{$ENDIF}
{$IFDEF LITTLE_ENDIAN}
var Value:longword absolute Data;
begin
 Value:=((Value and $ff000000) shr 24) or ((Value and $00ff0000) shr 8) or
        ((Value and $0000ff00) shl 8) or ((Value and $000000ff) shl 24);
{$ELSE}
begin
{$ENDIF}
end;

function DecToHex(Value:int64):string;
begin
 result:='';
 while Value<>0 do begin
  result:=HexNumbers[Value and $f]+result;
  Value:=Value shr 4;
 end;
end;

function HexToDec(Value:string):int64;
var Counter:integer;
    Nibble:byte;
begin
 result:=0;
 for Counter:=length(Value) downto 1 do begin
  Nibble:=byte(Value[Counter]);
  if (Nibble>=byte('0')) and (Nibble<=byte('9')) then begin
   Nibble:=Nibble-byte('0');
  end else if (Nibble>=byte('A')) and (Nibble<=byte('F')) then begin
   Nibble:=Nibble-byte('A')+$a;
  end else if (Nibble>=byte('a')) and (Nibble<=byte('f')) then begin
   Nibble:=Nibble-byte('a')+$a;
  end else begin
   Nibble:=0;
  end;
  result:=(result shl 4) or Nibble;
 end;
end;

function ByteToHex(Value:byte):string;
begin
 result:='';
 while Value<>0 do begin
  result:=HexNumbers[Value and $f]+result;
  Value:=Value shr 4;
 end;
 while length(result)<2 do result:='0'+result;
end;

function HexToByte(Value:string):byte;
var Counter:integer;
    Nibble:byte;
begin
 result:=0;
 for Counter:=length(Value) downto 1 do begin
  Nibble:=byte(Value[Counter]);
  if (Nibble>=byte('0')) and (Nibble<=byte('9')) then begin
   Nibble:=Nibble-byte('0');
  end else if (Nibble>=byte('A')) and (Nibble<=byte('F')) then begin
   Nibble:=Nibble-byte('A')+$a;
  end else if (Nibble>=byte('a')) and (Nibble<=byte('f')) then begin
   Nibble:=Nibble-byte('a')+$a;
  end else begin
   Nibble:=0;
  end;
  result:=(result shl 4) or Nibble;
 end;
end;

function WordToHex(Value:word):string;
begin
 result:='';
 while Value<>0 do begin
  result:=HexNumbers[Value and $f]+result;
  Value:=Value shr 4;
 end;
 while length(result)<4 do result:='0'+result;
end;

function HexToWord(Value:string):word;
var Counter:integer;
    Nibble:byte;
begin
 result:=0;
 for Counter:=length(Value) downto 1 do begin
  Nibble:=byte(Value[Counter]);
  if (Nibble>=byte('0')) and (Nibble<=byte('9')) then begin
   Nibble:=Nibble-byte('0');
  end else if (Nibble>=byte('A')) and (Nibble<=byte('F')) then begin
   Nibble:=Nibble-byte('A')+$a;
  end else if (Nibble>=byte('a')) and (Nibble<=byte('f')) then begin
   Nibble:=Nibble-byte('a')+$a;
  end else begin
   Nibble:=0;
  end;
  result:=(result shl 4) or Nibble;
 end;
end;

function LongWordToHex(Value:longword):string; register;
begin
 result:='';
 while Value<>0 do begin
  result:=HexNumbers[Value and $f]+result;
  Value:=Value shr 4;
 end;
 while length(result)<8 do result:='0'+result;
end;

function HexToLongWord(Value:string):longword; register;
var Counter:integer;
    Nibble:byte;
begin
 result:=0;
 for Counter:=length(Value) downto 1 do begin
  Nibble:=byte(Value[Counter]);
  if (Nibble>=byte('0')) and (Nibble<=byte('9')) then begin
   Nibble:=Nibble-byte('0');
  end else if (Nibble>=byte('A')) and (Nibble<=byte('F')) then begin
   Nibble:=Nibble-byte('A')+$a;
  end else if (Nibble>=byte('a')) and (Nibble<=byte('f')) then begin
   Nibble:=Nibble-byte('a')+$a;
  end else begin
   Nibble:=0;
  end;
  result:=(result shl 4) or Nibble;
 end;
end;

function FABS(Value:single):single;
var L:longword absolute Value;
begin
 L:=L and $7fffffff;
 result:=Value;
end;

end.

