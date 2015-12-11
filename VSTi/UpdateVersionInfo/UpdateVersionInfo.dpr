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
program compile;
{$APPTYPE CONSOLE}
{$UNDEF Release}

uses SysUtils,Windows;

const fmOpenRead=$0000;
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

type TDateiBuffer=packed array[1..16384] of char;

     TChars=set of char;

     Int64Rec=packed record
      Lo,Hi:dword;
     end;

     LongRec=packed record
      Lo,Hi:word;
     end;

     TFileName=string;

     TSearchRec=record
      Time,Size,Attr:integer;
      name:TFileName;
      ExcludeAttr:integer;
      FindHandle:THandle;
      FindData:TWin32FindData;
     end;

var AktuellesVerzeichnis,AusgabeBinaerVerzeichnis,
    EingabeQuellenVerzeichnis:string;

function INTTOSTR(I:integer):string;
begin
 STR(I,result);
end;

function TRIM(const S:string):string;
var StartPos,Laenge:integer;
begin
 Laenge:=length(S);
 if Laenge>0 then begin
  while (Laenge>0) and (S[Laenge] in [#0..#32]) do dec(Laenge);
  StartPos:=1;
  while (StartPos<=Laenge) and (S[StartPos] in [#0..#32]) do inc(StartPos);
  result:=COPY(S,StartPos,Laenge-StartPos+1);
 end else result:='';
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
  end else result:=result+S[I];
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
  end else result:=result+S[I];
  inc(I);
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
 end else result:=S+E;
end;

function Finde(const S:string;C:TChars):integer;
var I,L:integer;
begin
 result:=0;
 L:=length(S);
 for I:=1 to L do if S[I] in C then begin
  result:=I;
  break;
 end;
end;

function LeseToken(var Zeile:string;T:TChars):string;
var S:string;
    I:integer;
begin
 result:='';
 I:=Finde(Zeile,T);
 if I>0 then begin
  S:=TRIM(COPY(Zeile,1,I-1));
  if S<>'' then begin
   Zeile:=TRIM(COPY(Zeile,I+1,length(Zeile)-I));
   result:=S;
  end;
 end else begin
  result:=TRIM(Zeile);
  Zeile:='';
 end;
end;

function LeseTokenString(var Zeile:string;T:TChars):string;
var S:string;
    I,J,L:integer;
    A,B:boolean;
begin
 result:='';
 A:=false;
 B:=false;
 I:=0;
 L:=length(Zeile);
 J:=1;
 while J<=L do begin
  if (Zeile[J]='"') and not B then begin
   A:=not A;
  end else if (Zeile[J]='''') and not A then begin
   B:=not B;
  end else if (Zeile[J] in T) and not (A or B) then begin
   I:=J;
   break;
  end;
  inc(J);
 end;
 if I>0 then begin
  S:=TRIM(COPY(Zeile,1,I-1));
  if S<>'' then begin
   Zeile:=TRIM(COPY(Zeile,I+1,length(Zeile)-I));
   result:=S;
  end;
 end else begin
  result:=TRIM(Zeile);
  Zeile:='';
 end;
end;

function LeseBezeichner(var Zeile:string):string;
begin
 result:='';
 if length(Zeile)>0 then begin
  if Zeile[1] in ['a'..'z','A'..'Z'] then begin
   while length(Zeile)>0 do begin
    if Zeile[1] in ['a'..'z','A'..'Z','0'..'9','_'] then begin
     result:=result+Zeile[1];
     Zeile:=COPY(Zeile,2,length(Zeile)-1);
    end else begin
     break;
    end;
   end;
  end;
 end;
 Zeile:=TRIM(Zeile);
end;

function StringErsetzenEx(Wo,Von,Mit:string):string;
var I,J:integer;
    N,M:string;
    Ok:boolean;
 function MeinePosition(Wo,Was:string;AbWo:integer):integer;
 var I,K,J,H,G,L,O,M,N:integer;
  procedure Checken;
  begin
   if Wo[J] in ['A'..'Z','a'..'z','0'..'9','_','@'] then L:=0;
  end;
 begin
  O:=0;
  I:=AbWo;
  M:=length(Was);
  N:=length(Wo);
  K:=N-M+1;
  while I<=K do begin
   J:=I;
   H:=J+M;
   G:=1;
   L:=0;
   while J<H do begin
    if Wo[J]=Was[G] then begin
     inc(L);
    end else break;
    inc(J);
    inc(G);
   end;
   if L<>M then L:=0;
   if L>0 then begin
    J:=I-1;
    if J>0 then Checken;
    J:=H;
    if J<=N then Checken;
    if L>0 then begin
     O:=I;
     break;
    end;
   end;
   inc(I);
  end;
  result:=O;
 end;
begin
 Ok:=true;
 N:=Wo;
 J:=1;
 while Ok do begin
  Ok:=false;
  I:=MeinePosition(N,Von,J);
  if I>0 then begin
   M:=COPY(N,1,I-1);
   M:=M+Mit;
   M:=M+COPY(N,I+length(Von),length(N)-I-length(Von)+1);
   N:=M;
   J:=I+length(Mit);
   if J<1 then J:=1;
   Ok:=true;
  end;
 end;
 result:=N;
end;

function StringErsetzen(Wo,Von,Mit:string):string;
var I,J:integer;
    N,M:string;
    Ok:boolean;
 function MeinePosition(Wo,Was:string;AbWo:integer):integer;
 var I,K,J,H,G,L,O,M,N:integer;
  procedure Checken;
  begin
   if Wo[J] in ['A'..'Z','a'..'z','0'..'9','_','@'] then L:=0;
  end;
 begin
  O:=0;
  I:=AbWo;
  M:=length(Was);
  N:=length(Wo);
  K:=N-M+1;
  while I<=K do begin
   J:=I;
   H:=J+M;
   G:=1;
   L:=0;
   while J<H do begin
    if UPCASE(Wo[J])=UPCASE(Was[G]) then begin
     inc(L);
    end else break;
    inc(J);
    inc(G);
   end;
   if L<>M then L:=0;
   if L>0 then begin
    J:=I-1;
    if J>0 then Checken;
    J:=H;
    if J<=N then Checken;
    if L>0 then begin
     O:=I;
     break;
    end;
   end;
   inc(I);
  end;
  result:=O;
 end;
begin
 Ok:=true;
 N:=Wo;
 J:=1;
 while Ok do begin
  Ok:=false;
  I:=MeinePosition(N,Von,J);
  if I>0 then begin
   M:=COPY(N,1,I-1);
   M:=M+Mit;
   M:=M+COPY(N,I+length(Von),length(N)-I-length(Von)+1);
   N:=M;
   J:=I+length(Mit);
   if J<1 then J:=1;
   Ok:=true;
  end;
 end;
 result:=N;
end;

function PFindMatchingFile(var F:TSearchRec):integer;
var LocalFileTime:TFileTime;
begin
 with F do begin
  while (FindData.dwFileAttributes and ExcludeAttr)<>0 do begin
   if not FindNextFile(FindHandle,FindData) then begin
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

function PFindNext(var F:TSearchRec):integer;
begin
 if FindNextFile(F.FindHandle,F.FindData) then begin
  result:=PFindMatchingFile(F);
 end else result:=GetLastError;
end;

procedure PFindClose(var F:TSearchRec);
begin
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  FindClose(F.FindHandle);
  F.FindHandle:=INVALID_HANDLE_VALUE;
 end;
end;

function PFindFirst(const Path:string;Attr:integer;var F:TSearchRec):integer;
const faSpecial=faHidden or faSysFile or faVolumeID or faDirectory;
begin
 F.ExcludeAttr:=not Attr and faSpecial;
 F.FindHandle:=FindFirstFile(pchar(Path),F.FindData);
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  result:=PFindMatchingFile(F);
  if result<>0 then PFindClose(F);
 end else result:=GetLastError;
end;

function FILESETATTR(const Dateiname:string;Attr:integer):integer;
begin
 result:=0;
 if not SetFileAttributes(pchar(Dateiname),Attr) then result:=GetLastError;
end;

procedure LoescheDatei(const Datei:string);
begin
 if not DELETEFILE(pchar(Datei)) then begin
  FILESETATTR(Datei,0); {Alle Dateiattribute löschen}
  DELETEFILE(pchar(Datei));
 end;
end;

procedure LoescheDateien(const Path,Mask:string;SubDirectories:boolean);
var SR:TSearchRec;
begin
 if PFindFirst(Path+Mask,faAnyFile-faDirectory,SR)=0 then begin
  repeat
   LoescheDatei(Path+SR.name);
  until PFindNext(SR)<>0;
  PFindClose(SR);
 end;
 if SubDirectories then begin
  if PFindFirst(Path+'*.*',faDirectory,SR)=0 then begin
   repeat
    if (SR.name<>'.') and (SR.name<>'..') then begin
     FILESETATTR(Path+SR.name,faDirectory);
     LoescheDateien(Path+SR.name+'\',Mask,true);
     FILESETATTR(Path+SR.name,faDirectory); {Alle Dateiattribute löschen}
     {$I-}
     RMDIR(Path+SR.name); {Leeres Verzsichnis löschen}
     {$I+}
     if IOResult<>0 then begin
     end;
    end;
   until PFindNext(SR)<>0;
   PFindClose(SR);
  end;
 end;
end;

function EntpackeDateiPath(Dateiname:string):string;
var I,L:integer;
begin
 result:='';
 I:=length(Dateiname);
 L:=0;
 while I>0 do begin
  if (Dateiname[I]='\') or (Dateiname[I]='/') then begin
   L:=I;
   break;
  end;
  dec(I);
 end;
 if L>0 then result:=COPY(Dateiname,1,L);
end;

function EntpackeDateiName(Dateiname:string):string;
var I,L:integer;
begin
 result:='';
 I:=length(Dateiname);
 L:=0;
 while I>0 do begin
  if (Dateiname[I]='\') or (Dateiname[I]='/') then begin
   L:=I;
   break;
  end;
  dec(I);
 end;
 if L>0 then result:=COPY(Dateiname,L+1,length(Dateiname)-L+1);
end;

function GetCurrentDir:string;
var Buffer:array[0..MAX_PATH-1] of char;
begin
 setstring(result,Buffer,GetCurrentDirectory(sizeof(Buffer),Buffer));
 if length(result)>0 then if result[length(result)]<>'\' then result:=result+'\';
end;

function Starten(const Dateiname,Parameter:string;FensterStatus:word):boolean;
var SUInfo:TStartupInfo;
    ProcInfo:TProcessInformation;
    Befehlszeile:string;
begin
 if length(Dateiname)>0 then begin
  Befehlszeile:='"'+Dateiname+'" '+Parameter;
 end else begin
  Befehlszeile:='"cmd" /C '+Parameter;
 end;
 FILLCHAR(SUInfo,sizeof(SUInfo),#0);
 FILLCHAR(ProcInfo,sizeof(ProcInfo),#0);
 with SUInfo do begin
  CB:=sizeof(SUInfo);
  dwFlags:=STARTF_USESHOWWINDOW;
  wShowWindow:=FensterStatus;
 end;
 result:=CreateProcess(nil,pchar(Befehlszeile),nil,nil,false,NORMAL_PRIORITY_CLASS,nil,pchar(GetCurrentDir),SUInfo,ProcInfo);
 if result then begin
  WaitForSingleObject(ProcInfo.hProcess,INFINITE);
 end;
end;

function Ausfuehren(Dateiname,Parameter:string):boolean;
begin
 result:=Starten(Dateiname,Parameter,SW_SHOWNORMAL);
end;

function DateiGroesse(Dateiname:string):longword;
var F:file;
begin
 ASSIGNFILE(F,Dateiname);
 {$I-}RESET(F,1);{$I+}if IOResult=0 then begin
  result:=FILESIZE(F);
  CLOSEFILE(F);
 end else result:=0;
end;

procedure FuegeDatei(DateiQuelle,DateiZiel:string;Erstellen,CRLF:boolean);
var FQuelle,FZiel:file;
    DateiBuffer:TDateiBuffer;
    Gelesen,Geschrieben:longword;
begin
 ASSIGNFILE(FZiel,DateiZiel);
 if Erstellen then begin
  {$I-}REWRITE(FZiel,1);{$I+}if IOResult<>0 then begin end;
  SEEK(FZiel,0);
 end else begin
  {$I-}RESET(FZiel,1);{$I+}if IOResult<>0 then begin
   {$I-}REWRITE(FZiel,1);{$I+}if IOResult<>0 then begin end;
  end;
  SEEK(FZiel,FILESIZE(FZiel));
 end;
 ASSIGNFILE(FQuelle,DateiQuelle);
 {$I-}RESET(FQuelle,1);{$I+}if IOResult<>0 then begin
  CLOSEFILE(FZiel);
  exit;
 end;
 {$I-}SEEK(FQuelle,0);{$I+}if IOResult<>0 then begin
  CLOSEFILE(FZiel);
  exit;
 end;
 Geschrieben:=1;
 while Geschrieben>0 do begin
  {$I-}BLOCKREAD(FQuelle,DateiBuffer,sizeof(TDateiBuffer),Gelesen);{$I+}if IOResult<>0 then begin end;
  {$I-}BLOCKWRITE(FZiel,DateiBuffer,Gelesen,Geschrieben);{$I+}if IOResult<>0 then begin end;
 end;
 if CRLF then BLOCKWRITE(FZiel,#13#10,2);
 CLOSEFILE(FQuelle);
 CLOSEFILE(FZiel);
end;

procedure Bearbeiten(Dateiname:string;Von,Nach:string);
var F:file;
    DateiBuffer:TDateiBuffer;
    Gelesen:longword;
    S,NeuS:string;
    I,IL:integer;
begin
 ASSIGNFILE(F,Dateiname);
 {$I-}RESET(F,1);{$I+}if IOResult<>0 then begin exit; end;
 S:='';
 Gelesen:=1;
 while Gelesen>0 do begin
  {$I-}BLOCKREAD(F,DateiBuffer,sizeof(TDateiBuffer),Gelesen);{$I+}if IOResult<>0 then begin end;
  if Gelesen>0 then S:=S+COPY(DateiBuffer,1,Gelesen);
 end;
 CLOSEFILE(F);
 I:=POS(Von,S);
 IL:=0;
 while I>0 do begin
  if I=IL then break;
  NeuS:=COPY(S,1,I-1)+Nach+COPY(S,I+length(Von),length(S)-(I+length(Von))+1);
  S:=NeuS;
  IL:=I;
  I:=POS(Von,S);
 end;
 ASSIGNFILE(F,Dateiname);
 {$I-}REWRITE(F,1);{$I+}if IOResult<>0 then begin exit; end;
 BLOCKWRITE(F,S[1],length(S));
 CLOSEFILE(F);
end;

procedure PascalCompiler(Datei,EXEName,ICOName:string);
var Parameter:string;
    DateiAusgabe:string;
    I:integer;
begin
 I:=POS('.',Datei);
 if I>0 then begin
  DateiAusgabe:=COPY(Datei,1,I-1);
 end else begin
  DateiAusgabe:=Datei;
 end;
 Parameter:='-B '+EingabeQuellenVerzeichnis+Datei;
//Parameter:=Parameter+' -E'+AusgabeBinaerVerzeichnis;
 Ausfuehren('dcc32',Parameter);
 Datei:=ChangeFileExt(Datei,'.exe');
//Ausfuehren('t0dlc',AusgabeBinaerVerzeichnis+EXEName+' '+EingabeQuellenVerzeichnis+Datei+' '+EingabeQuellenVerzeichnis+ICOName);
 Ausfuehren('bep',EingabeQuellenVerzeichnis+Datei+' '+AusgabeBinaerVerzeichnis+EXEName+' +srt +sd +so +ca=lzmau');
 CopyFile(pchar(AusgabeBinaerVerzeichnis+EXEName),pchar(EingabeQuellenVerzeichnis+EXEName),false);
end;

procedure PascalCompilerDLL(Datei:string);
var Parameter:string;
    DateiAusgabe:string;
    I:integer;
begin
 I:=POS('.',Datei);
 if I>0 then begin
  DateiAusgabe:=COPY(Datei,1,I-1);
 end else begin
  DateiAusgabe:=Datei;
 end;
 Parameter:='-B '+EingabeQuellenVerzeichnis+Datei;
//Parameter:=Parameter+' -E'+AusgabeBinaerVerzeichnis;
 Ausfuehren('dcc32',Parameter);
end;

procedure Initialisierung;
begin
 RandSeed:=GetTickCount;
 RANDOMIZE;
 AktuellesVerzeichnis:=EntpackeDateiPath(PARAMSTR(0));
 AusgabeBinaerVerzeichnis:=AktuellesVerzeichnis+'bin\';
 EingabeQuellenVerzeichnis:=AktuellesVerzeichnis;
// {$I-}MKDIR(AusgabeBinaerVerzeichnis);{$I-}IF IOResult<>0 THEN BEGIN END;
// {$I-}MKDIR(EingabeQuellenVerzeichnis);{$I-}IF IOResult<>0 THEN BEGIN END;

 WRITELN('Version information updater ool');
 WRITELN('Copyright (C) 2007, Benjamin Rosseaux');
 WRITELN;
end;

function INTTOSTRPADDING(I,P:integer):string;
begin
 STR(I,result);
 while length(result)<P do result:='0'+result;
end;

procedure WinMain;
var F:TEXT;
    T:TEXT;
    SystemTime:TSystemTime;
    BuildNumber:int64;
    Year,Month,Day:word;
begin
 GetLocalTime(SystemTime);
 Initialisierung;
 WRITELN('Generating version info unit...');
 ASSIGNFILE(t,'buildnumber');
 RESET(T);
 System.read(T,BuildNumber);
 CLOSEFILE(T);
 inc(BuildNumber);
 ASSIGNFILE(t,'buildnumber');
 REWRITE(T);
 System.WRITELN(T,BuildNumber);
 CLOSEFILE(T);
 ASSIGNFILE(F,'..\VersionInfo.pas');
 REWRITE(F);
 WRITELN(F,'unit VersionInfo;');
 WRITELN(F);
 WRITELN(F,'interface');
 WRITELN(F);
//WRITELN(F,'CONST CompileDate='''+INTTOSTRPADDING(SystemTime.wYear,4)+'.'+INTTOSTRPADDING(SystemTime.wMonth,2)+'.'+INTTOSTRPADDING(SystemTime.wDay,2)+'.'+INTTOSTRPADDING(SystemTime.wHour,2)+'.'+INTTOSTRPADDING(SystemTime.wMinute,2)+'.'+INTTOSTRPADDING(SystemTime.wSecond,2)+''';');
 WRITELN(F,'const CompileDate='''+INTTOSTRPADDING(SystemTime.wYear,4)+'.'+INTTOSTRPADDING(SystemTime.wMonth,2)+'.'+INTTOSTRPADDING(SystemTime.wDay,2)+''';');
 WRITELN(F,'      BuildNumber='''+INTTOSTRPADDING(BuildNumber,0)+''';');
 WRITELN(F,'      BuildNumberValue='+INTTOSTRPADDING(BuildNumber,0)+';');
 WRITELN(F);
 DecodeDate(Now+30,Year,Month,Day);
 WRITELN(F,'      RunForever=true;');
 WRITELN(F,'      RunUntilYear=',Year,';');
 WRITELN(F,'      RunUntilMonth=',Month,';');
 WRITELN(F,'      RunUntilDay=',Day,';');
 WRITELN(F);
 WRITELN(F,'implementation');
 WRITELN(F);
 WRITELN(F,'end.');
 CLOSEFILE(F);
end;

begin
 WinMain;
end.

