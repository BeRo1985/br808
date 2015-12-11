program KONVPASS2;
{$APPTYPE CONSOLE}

uses
  SpeechSegments in 'SpeechSegments.pas',
  BeRoSort in 'BeRoSort.pas',
  BeRoFixedPoint in 'BeRoFixedPoint.pas',
  BeRoUtils in 'BeRoUtils.pas';

const Segments=69;

type TSpeechSegmentsStream=packed record
//    Name:ARRAY[0..Segments-1] OF TSpeechSegmentName;
      Rank:array[0..Segments-1] of byte;
      Duration:array[0..Segments-1] of byte;
//    AdditionalDuration:ARRAY[0..Segments-1] OF BYTE;
      Features:array[0..Segments-1] of longword;
      Prop:array[0..NumberOfSegmentParameters-1,0..Segments-1] of byte;
      Extern:array[0..NumberOfSegmentParameters-1,0..Segments-1] of byte;
      Intern:array[0..NumberOfSegmentParameters-1,0..Segments-1] of byte;
      Steady:array[0..NumberOfSegmentParameters-1,0..Segments-1] of single;
      Fixed:array[0..NumberOfSegmentParameters-1,0..Segments-1] of single;
     end;

type TSpeechPhtoelm=record
      name:string;
      Data:array of string;
     end;
     TSpeechPhtoelms=array of TSpeechPhtoelm;

var SpeechSegmentsStream:TSpeechSegmentsStream;
    Phtoelms:TSpeechPhtoelms;

procedure SpeechEnterPhtoelm(name:string;D1:string='';D2:string='';D3:string='';D4:string='';D5:string='');
var index,SubIndex:integer;
begin
 index:=length(Phtoelms);
 setlength(Phtoelms,index+1);
 Phtoelms[index].name:=name;
 Phtoelms[index].Data:=nil;
 if length(D1)<>0 then begin
  SubIndex:=length(Phtoelms[index].Data);
  setlength(Phtoelms[index].Data,SubIndex+1);
  Phtoelms[index].Data[SubIndex]:=D1;
 end;
 if length(D2)<>0 then begin
  SubIndex:=length(Phtoelms[index].Data);
  setlength(Phtoelms[index].Data,SubIndex+1);
  Phtoelms[index].Data[SubIndex]:=D2;
 end;
 if length(D3)<>0 then begin
  SubIndex:=length(Phtoelms[index].Data);
  setlength(Phtoelms[index].Data,SubIndex+1);
  Phtoelms[index].Data[SubIndex]:=D3;
 end;
 if length(D4)<>0 then begin
  SubIndex:=length(Phtoelms[index].Data);
  setlength(Phtoelms[index].Data,SubIndex+1);
  Phtoelms[index].Data[SubIndex]:=D4;
 end;
 if length(D5)<>0 then begin
  SubIndex:=length(Phtoelms[index].Data);
  setlength(Phtoelms[index].Data,SubIndex+1);
  Phtoelms[index].Data[SubIndex]:=D5;
 end;
end;

function CompareSpeechSegments(const A,B:pointer):integer;
var EA:PSpeechSegment absolute A;
    EB:PSpeechSegment absolute B;
begin
 if EA^.Rank<EB^.Rank then begin
  result:=-1;
 end else if EA^.Rank>EB^.Rank then begin
  result:=1;
 end else begin
  result:=0;
 end;
end;

procedure Convert;
var SubCounter,Counter:integer;
begin
//QuickSort(@SpeechSegmentsArray,LENGTH(SpeechSegmentsArray),SIZEOF(TSpeechSegment),CompareSpeechSegments);
 FILLCHAR(SpeechSegmentsStream,sizeof(TSpeechSegmentsStream),#0);
 for Counter:=0 to Segments-1 do begin
//SpeechSegmentsStream.Name[Counter]:=SpeechSegmentsArray[Counter].Name;
  SpeechSegmentsStream.Rank[Counter]:=SpeechSegmentsArray[Counter].Rank;
  SpeechSegmentsStream.Duration[Counter]:=SpeechSegmentsArray[Counter].Duration+SpeechSegmentsArray[Counter].AdditionalDuration div 2;
//SpeechSegmentsStream.AdditionalDuration[Counter]:=;
  SpeechSegmentsStream.Features[Counter]:=SpeechSegmentsArray[Counter].Features;
  for SubCounter:=0 to NumberOfSegmentParameters-1 do begin
   SpeechSegmentsStream.Prop[SubCounter,Counter]:=SpeechSegmentsArray[Counter].Parameters[SubCounter].Prop;
   SpeechSegmentsStream.Extern[SubCounter,Counter]:=SpeechSegmentsArray[Counter].Parameters[SubCounter].Extern;
   SpeechSegmentsStream.Intern[SubCounter,Counter]:=SpeechSegmentsArray[Counter].Parameters[SubCounter].Intern;
   SpeechSegmentsStream.Steady[SubCounter,Counter]:=SpeechSegmentsArray[Counter].Parameters[SubCounter].Steady;
   SpeechSegmentsStream.Fixed[SubCounter,Counter]:=SpeechSegmentsArray[Counter].Parameters[SubCounter].Fixed;
  end;
 end;
 SpeechEnterPhtoelm(' ','Q');
 SpeechEnterPhtoelm('p','P','PY','PZ');
 SpeechEnterPhtoelm('t','T','TY','TZ');
 SpeechEnterPhtoelm('k','K','KY','KZ');
 SpeechEnterPhtoelm('b','B','BY','BZ');
 SpeechEnterPhtoelm('d','D','DY','DZ');
 SpeechEnterPhtoelm('g','G','GY','GZ');
 SpeechEnterPhtoelm('m','M');
 SpeechEnterPhtoelm('n','N');
 SpeechEnterPhtoelm('N','NG');
 SpeechEnterPhtoelm('9','NG');
 SpeechEnterPhtoelm('f','F');
 SpeechEnterPhtoelm('T','TH');
 SpeechEnterPhtoelm('s','S');
 SpeechEnterPhtoelm('S','SH');
 SpeechEnterPhtoelm('h','H');
 SpeechEnterPhtoelm('v','V','QQ','V');
 SpeechEnterPhtoelm('D','DH','QQ','DI');
 SpeechEnterPhtoelm('z','Z','QQ','ZZ');
 SpeechEnterPhtoelm('Z','ZH','QQ','ZH');
 SpeechEnterPhtoelm('tS','CH','CI');
 SpeechEnterPhtoelm('dZ','J','JY','QQ','JY');
 SpeechEnterPhtoelm('l','L');
 SpeechEnterPhtoelm('r','R');
 SpeechEnterPhtoelm('rr','R','QQ','R');
 SpeechEnterPhtoelm('R','RX');
 SpeechEnterPhtoelm('w','W');
 SpeechEnterPhtoelm('x','X');
 SpeechEnterPhtoelm('%','QQ'); // stop-ness - not quite glottal stop
 SpeechEnterPhtoelm('j','Y');
 SpeechEnterPhtoelm('I','I');
 SpeechEnterPhtoelm('e','E');
 SpeechEnterPhtoelm('&','AA');
 SpeechEnterPhtoelm('V','U');
 SpeechEnterPhtoelm('0','O');
 SpeechEnterPhtoelm('U','OO');
 SpeechEnterPhtoelm('@','A');
 SpeechEnterPhtoelm('i','EE');
 SpeechEnterPhtoelm('3','ER');
 SpeechEnterPhtoelm('A','AR');
 SpeechEnterPhtoelm('O','AW');
 SpeechEnterPhtoelm('u','UU');
 SpeechEnterPhtoelm('o','OI');
 SpeechEnterPhtoelm('eI','AI','I');
 SpeechEnterPhtoelm('aI','IE','I');
 SpeechEnterPhtoelm('oI','OI','I');
 SpeechEnterPhtoelm('aU','OU','OV');
 SpeechEnterPhtoelm('@U','OA','OV');
 SpeechEnterPhtoelm('I@','IA','IB');
 SpeechEnterPhtoelm('e@','AIR','IB');
 SpeechEnterPhtoelm('U@','OOR','IB');
 SpeechEnterPhtoelm('O@','OR','IB');
 SpeechEnterPhtoelm('oU','OI','OV');
end;

var F:file;
    Z:TEXTFILE;
    Counter,SubCounter:integer;
begin
 Phtoelms:=nil;
 Convert;

 ASSIGNFILE(F,'Segments.bin');
 REWRITE(F,1);
 BLOCKWRITE(F,SpeechSegmentsStream,sizeof(SpeechSegmentsStream));
 CLOSEFILE(F);

 ASSIGNFILE(Z,'SynthSpeechSegmentsIndices.inc');
 REWRITE(Z);
 WRITELN(Z,'CONST ssiNONE=-1;');
 for Counter:=0 to Segments-1 do begin
  WRITELN(Z,'      ssi',TRIM(SpeechSegmentsArray[Counter].name),'=',Counter,';');
//SpeechSegmentsStream.Name[Counter]:=SpeechSegmentsArray[Counter].Name;
 end;
 CLOSEFILE(Z);

 ASSIGNFILE(Z,'SynthSpeechSegmentsPhonemsData.inc');
 REWRITE(Z);
 WRITELN(Z,'TYPE TSynthSpeechSegmentsPhonem=RECORD');
 WRITELN(Z,'      Phonem:STRING[2];');
 WRITELN(Z,'      SegmentCount:INTEGER;');
 WRITELN(Z,'      Segments:ARRAY[0..3] OF SHORTINT;');
 WRITELN(Z,'     END;');
 WRITELN(Z,'');
 WRITELN(Z,'CONST SynthSpeechSegmentsPhonems:ARRAY[0..',length(Phtoelms)-1,'] OF TSynthSpeechSegmentsPhonem=');
 WRITELN(Z,'(');
 for Counter:=0 to length(Phtoelms)-1 do begin
  WRITELN(Z,' (');
  WRITELN(Z,'  Phonem:''',Phtoelms[Counter].name,''';');
  WRITELN(Z,'  SegmentCount:',length(Phtoelms[Counter].Data),';');
  WRITELN(Z,'  Segments:');
  WRITELN(Z,'   (');
  for SubCounter:=0 to 3 do begin
   if SubCounter<length(Phtoelms[Counter].Data) then begin
    write(Z,'    ssi',UPPERCASE(Phtoelms[Counter].Data[SubCounter]));
   end else begin
    write(Z,'    ssiNONE');
   end;
   if SubCounter<>3 then write(Z,',');
   WRITELN(Z);
  end;
  WRITELN(Z,'   );');
  if Counter<(length(Phtoelms)-1) then begin
   WRITELN(Z,' ),');
  end else begin
   WRITELN(Z,' )');
  end;
 end;
 WRITELN(Z,');');
 CLOSEFILE(Z);
 setlength(Phtoelms,0);
end.
