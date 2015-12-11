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

interface

uses Windows;

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

     TSearchRec=record
      Time,Size,Attr:integer;
      name:TFileName;
      ExcludeAttr:integer;
      FindHandle:THandle;
      FindData:TWin32FindData;
     end;

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

function Parse(var S:string;C:TCharSet):string; overload;
function Parse(var S:string;C:char):string; overload;
function STRTOINT(S:string):int64;
function INTTOSTR(I:int64):string;
function STRTOFLOAT(S:string):extended;
function FLOATTOSTR(F:extended):string;
function StrLCopy(Dest:pchar;const Source:pchar;MaxLen:longword):pchar; assembler;
function StrPCopy(Dest:pchar;const Source:string):pchar;
function FindMatchingFile(var F:TSearchRec):integer;
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
function StringReplace(var S:string;const FindStr,RepStr:string):boolean;
function StringReplaceAll(var S:string;const FindStr,RepStr:string):boolean;
function MatchPattern(Input,Pattern:pchar):boolean;
function StrToAddr(S:string):integer;
function AddrToStr(Address:integer):string;

implementation

function Parse(var S:string;C:TCharSet):string; overload;
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
end;

function Parse(var S:string;C:char):string; overload;
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

function FindNext(var F:TSearchRec):integer;
begin
 if Windows.FindNextFile(F.FindHandle,F.FindData) then begin
  result:=FindMatchingFile(F);
 end else begin
  result:=GetLastError;
 end;
end;

procedure FindClose(var F:TSearchRec);
begin
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  Windows.FindClose(F.FindHandle);
  F.FindHandle:=INVALID_HANDLE_VALUE;
 end;
end;

function FindFirst(const Path:string;Attr:integer;var F:TSearchRec):integer;
const faSpecial=faHidden or faSysFile or faVolumeID or faDirectory;
begin
 F.ExcludeAttr:=not Attr and faSpecial;
 F.FindHandle:=Windows.FindFirstFile(pchar(Path),F.FindData);
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  result:=FindMatchingFile(F);
  if result<>0 then FindClose(F);
 end else begin
  result:=GetLastError;
 end;
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
  R:=R or P shl (I * 8);
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

end.
