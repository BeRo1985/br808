program BIN2PAS;
var Quelle:file;
    Ziel:TEXT;
    B,C:byte;
    S:string;
begin
 ASSIGNFILE(Quelle,'Segments.bin');
 {$I-}RESET(Quelle,1);{$I+}
 if IOResult=0 then begin
  ASSIGNFILE(Ziel,'SynthSpeechSegmentsData.inc');
  {$I-}REWRITE(Ziel);{$I+}
  if IOResult=0 then begin
   WRITELN(Ziel,'CONST SynthSpeechSegmentsDataSize=',FILESIZE(Quelle),';');
   write(Ziel,'      SynthSpeechSegmentsDataData:ARRAY[1..SynthSpeechSegmentsDataSize] OF BYTE=(');
   C:=0;
   while not EOF(Quelle) do begin
    BLOCKREAD(Quelle,B,1);
    STR(B,S);
    if FILESIZE(Quelle)<>FILEPOS(Quelle) then S:=S+',';
    C:=C+length(S);
    write(Ziel,S);
    if C>40 then begin
     if FILESIZE(Quelle)<>FILEPOS(Quelle) then begin
      WRITELN(Ziel);
      write(Ziel,'                                             ');
     end;
     C:=0;
    end;
   end;
   WRITELN(Ziel,');');
   WRITELN(Ziel,'');
   WRITELN(Ziel,'VAR SynthSpeechSegmentsStream:TSynthSpeechSegmentsStream ABSOLUTE SynthSpeechSegmentsDataData;');
   CLOSEFILE(Ziel);
  end;
  CLOSEFILE(Quelle);
 end;
end.
