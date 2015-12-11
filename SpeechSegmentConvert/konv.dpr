program KONV;
{$APPTYPE CONSOLE}

type TChars=set of char;

var D:file;
    Z:TEXTFILE;
    C:char;
    Zaehler:word;
    Ende:boolean;

function HoleZeichnen:char;
begin
 if not EOF(D) then begin
  BLOCKREAD(D,C,1);
 end else C:=#0;
 result:=C;
end;

procedure Holen;
begin
 HoleZeichnen;
 while C in [#8,#9,#13,#10,#32] do HoleZeichnen;
end;

function Hole(Bis:TChars):string;
var S:string;
begin
 S:='';
 Holen;
 while not (C in Bis) do begin
  S:=S+C;
  HoleZeichnen;
 end;
 result:=S;
end;

procedure OutStr(S:string);
begin
 WRITELN(Z,S);
end;

function ZStr:string;
begin
 STR(Zaehler,result);
end;

function St(I:integer):string;
begin
 STR(I,result);
end;

procedure Level3(I:integer);
var S:string;
    B,BC:boolean;
begin
 BC:=true;//NOT (I IN [0,7,16,18]);
 S:=Hole([',']);
 if BC then OutStr('   (Steady:'+S+';');
 S:=Hole([',']);
 if BC then OutStr('    Fixed:'+S+';');
 S:=Hole([',']);
 if BC then OutStr('    Prop:'+S+';');
 S:=Hole([',']);
 if BC then OutStr('    Extern:'+S+';');
 S:=Hole(['}']);
 if BC then OutStr('    Intern:'+S+';');
 if BC then begin
  if (I<18{18}) then begin
   OutStr('   ),');
  end else begin
   OutStr('   )');
  end;
 end;

 Holen;
 if C=',' then Holen;
 S:='';
 if C='/' then begin
  Holen;
  if C='*' then begin
   B:=true;
   while B do begin
    HoleZeichnen;
    if C='*' then begin
     HoleZeichnen;
     if C='/' then begin
      B:=false;
     end else begin
      S:=S+'*'+C;
     end;
    end else begin
     S:=S+C;
    end;
   end;
  end;
 end;
 while POS(' ',S)=1 do DELETE(S,1,1);
 while POS(' ',S)=length(S) do DELETE(S,length(S),1);
//OutStr(' {Segments['+ZStr+'].p['+ST(I)+'] = '+S+'}');
//OutStr(' {Segments['+ZStr+'].p['+ST(I)+'] = '+S+'}');
end;

procedure Level2;
var B:boolean;
    I:integer;
begin
 B:=true;
 I:=0;
 while B do begin
  Holen;
  if C='{' then begin
   Level3(I);
   I:=I+1;
   if C='}' then begin
   end;
  end else B:=false;
 end;
end;

procedure Level1;
var S,J:string;
    I:integer;
begin
 S:='';
 Holen;
 if C='{' then begin

  Holen;
  write(Z,' (');
  if C='"' then begin
   S:=Hole(['"']);
  end else begin
   S:='';
  end;
  write(Z,'Name:'''+S+'''');
  for I:=1 to (4-length(S)) do write(Z,'#0');
  WRITELN(Z,';');
  Holen;
  if C=',' then;

  S:=Hole([',']);
  WRITELN(Z,'  Rank:'+S+';');

  S:=Hole([',']);
  WRITELN(Z,'  Duration:'+S+';');

  S:=Hole([',']);
  WRITELN(Z,'  AdditionalDuration:'+S+';');

  S:=Hole([',']);
  if POS('0x',S)=1 then begin
   DELETE(S,1,2);
   S:='$'+S;
  end;
//WRITELN(Z,'  font:'+S+';');

  S:=Hole([',']);
  if S='NULL' then S:='';
  if length(S)>0 then begin
   if S[1]='"' then S:=COPY(S,2,length(S)-1);
   if length(S)>0 then begin
    if S[length(S)]='"' then S:=COPY(S,1,length(S)-1);
   end;
  end;
//WRITELN(Z,'  dict:'''+S+''';');

  S:=Hole([',']);
  if S='NULL' then S:='';
  if length(S)>0 then begin
   if S[1]='"' then S:=COPY(S,2,length(S)-1);
   if length(S)>0 then begin
    if S[length(S)]='"' then S:=COPY(S,1,length(S)-1);
   end;
  end;
//WRITELN(Z,'  ipa:'''+S+''';');

  S:=Hole([',']);
  J:='';
  for I:=1 to length(S) do begin
   case S[I] of
    '|':J:=J+' OR ';
    else J:=J+S[I];
   end;
  end;
  WRITELN(Z,'  Features:'+J+';');

  Holen;
  if C='{' then begin
   WRITELN(Z,'  Parameters:(');
   Level2;

   WRITELN(Z,'  )');
  end;

  Holen;
  if C='}' then Holen;
  if C<>',' then begin
   WRITELN(Z,' )');
   Ende:=true;
  end else begin
   WRITELN(Z,' ),');
  end;
 end else begin
  HoleZeichnen;
 end;
end;

begin
 Zaehler:=0;
 ASSIGNFILE(D,'Segments.def');
 RESET(D,1);

 ASSIGNFILE(Z,'SpeechSegments.pas');
 REWRITE(Z);
 WRITELN(Z,'UNIT SpeechSegments;');
 WRITELN(Z,'');
 WRITELN(Z,'INTERFACE');
 WRITELN(Z,'');
 WRITELN(Z,'CONST alv=$1;');
 WRITELN(Z,'      apr=$2;');
 WRITELN(Z,'      bck=$4;');
 WRITELN(Z,'      blb=$8;');
 WRITELN(Z,'      cnt=$10;');
 WRITELN(Z,'      dnt=$20;');
 WRITELN(Z,'      fnt=$40;');
 WRITELN(Z,'      frc=$80;');
 WRITELN(Z,'      glt=$100;');
 WRITELN(Z,'      hgh=$200;');
 WRITELN(Z,'      lat=$400;');
 WRITELN(Z,'      lbd=$800;');
 WRITELN(Z,'      lbv=$1000;');
 WRITELN(Z,'      lmd=$2000;');
 WRITELN(Z,'      low=$4000;');
 WRITELN(Z,'      mdl=$8000;');
 WRITELN(Z,'      nas=$10000;');
 WRITELN(Z,'      pal=$20000;');
 WRITELN(Z,'      pla=$40000;');
 WRITELN(Z,'      rnd=$80000;');
 WRITELN(Z,'      rzd=$100000;');
 WRITELN(Z,'      smh=$200000;');
 WRITELN(Z,'      stp=$400000;');
 WRITELN(Z,'      umd=$800000;');
 WRITELN(Z,'      unr=$1000000;');
 WRITELN(Z,'      vcd=$2000000;');
 WRITELN(Z,'      vel=$4000000;');
 WRITELN(Z,'      vls=$8000000;');
 WRITELN(Z,'      vwl=$10000000;');
 WRITELN(Z,'');
{WRITELN(Z,'      SPf1=0;');
 WRITELN(Z,'      SPf2=1;');
 WRITELN(Z,'      SPf3=2;');
 WRITELN(Z,'      SPb1=3;');
 WRITELN(Z,'      SPb2=4;');
 WRITELN(Z,'      SPb3=5;');
 WRITELN(Z,'      SPa1=6;');
 WRITELN(Z,'      SPa2=7;');
 WRITELN(Z,'      SPa3=8;');
 WRITELN(Z,'      SPa4=9;');
 WRITELN(Z,'      SPa5=10;');
 WRITELN(Z,'      SPa6=11;');
 WRITELN(Z,'      SPab=12;');
 WRITELN(Z,'      SPav=13;');
 WRITELN(Z,'      SPasp=14;');
 WRITELN(Z,'      NumberOfSegmentParameters=15;');}
 WRITELN(Z,'');
 WRITELN(Z,'      SPfn=0;');
 WRITELN(Z,'      SPf1=1;');
 WRITELN(Z,'      SPf2=2;');
 WRITELN(Z,'      SPf3=3;');
 WRITELN(Z,'      SPb1=4;');
 WRITELN(Z,'      SPb2=5;');
 WRITELN(Z,'      SPb3=6;');
 WRITELN(Z,'      SPan=7;');
 WRITELN(Z,'      SPa1=8;');
 WRITELN(Z,'      SPa2=9;');
 WRITELN(Z,'      SPa3=10;');
 WRITELN(Z,'      SPa4=11;');
 WRITELN(Z,'      SPa5=12;');
 WRITELN(Z,'      SPa6=13;');
 WRITELN(Z,'      SPab=14;');
 WRITELN(Z,'      SPav=15;');
 WRITELN(Z,'      SPavc=16;');
 WRITELN(Z,'      SPasp=17;');
 WRITELN(Z,'      SPaf=18;');
 WRITELN(Z,'      NumberOfSegmentParameters=19;');
 WRITELN(Z,'');
 WRITELN(Z,'      NumberOfSegments=69;');
 WRITELN(Z,'');
 WRITELN(Z,'TYPE TSpeechSegmentName=ARRAY[1..4] OF CHAR;');
 WRITELN(Z,'');
 WRITELN(Z,'     PSpeechSegmentParameter=^TSpeechSegmentParameter;');
 WRITELN(Z,'     TSpeechSegmentParameter=PACKED RECORD');
 WRITELN(Z,'      Steady,Fixed:SINGLE;');
 WRITELN(Z,'      Prop,Extern,Intern:BYTE;');
 WRITELN(Z,'     END;');
 WRITELN(Z,'');
 WRITELN(Z,'     PSpeechSegment=^TSpeechSegment;');
 WRITELN(Z,'     TSpeechSegment=PACKED RECORD');
 WRITELN(Z,'      Name:TSpeechSegmentName;');
 WRITELN(Z,'      Rank,Duration,AdditionalDuration:BYTE;');
 WRITELN(Z,'      Features:LONGWORD;');
 WRITELN(Z,'      Parameters:ARRAY[0..NumberOfSegmentParameters-1] OF TSpeechSegmentParameter;');
 WRITELN(Z,'     END;');
 WRITELN(Z,'');
 WRITELN(Z,'     PSpeechSegments=^TSpeechSegments;');
 WRITELN(Z,'     TSpeechSegments=ARRAY[0..NumberOfSegments-1] OF TSpeechSegment;');
 WRITELN(Z,'');
 WRITELN(Z,'CONST SpeechSegmentsArray:TSpeechSegments=(');
 Ende:=false;
 while not (EOF(D) or Ende) do begin
  Level1;
  inc(Zaehler);
  write(#13,TRUNC(FILEPOS(D)*100/FILESIZE(D)),' %');
 end;
 WRITELN(Z,');');
 WRITELN(Z,'');
 WRITELN(Z,'IMPLEMENTATION');
 WRITELN(Z,'');
 WRITELN(Z,'END.');
 CLOSEFILE(Z);

 CLOSEFILE(D);
//READLN;
end.
