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
program bmf2wav;
{$APPTYPE CONSOLE}
uses
  Synth in '..\Synth.pas';

var f,wf:file;
    i,j,Bytes:integer;
    p:pointer;
    Track:PSynthTrack;
    ps:^single;
    psi:^smallint;

PROCEDURE FileHandler;
VAR Dummy:LONGWORD;
    W:WORD;
BEGIN
 Seek(wf,0);
 BlockWrite(wf,'RIFF',4);
 Dummy:=Bytes+36;
 BlockWrite(wf,Dummy,4);
 BlockWrite(wf,'WAVE',4);
 BlockWrite(wf,'fmt ',4);
 Dummy:=16;
 BlockWrite(wf,Dummy,4);

 W:=1;//1;//3;
 BlockWrite(wf,W,2);

 W:=2;
 BlockWrite(wf,W,2);

 Dummy:=Track^.SampleRate;
 BlockWrite(wf,Dummy,4);

 Dummy:=Track^.SampleRate*2*2;
 BlockWrite(wf,Dummy,4);

 W:=2*2;
 BlockWrite(wf,W,2);

 W:=16;
 BlockWrite(wf,W,2);

 BlockWrite(wf,'data',4);
 BlockWrite(wf,Bytes,4);
END;

var SoundBuf:array[1..512*2] of smallint;
begin
 writeln('BMF2WAV - Copyright (C) 2008, Benjamin ''BeRo'' Rosseaux');
 if paramcount<>2 then begin
  writeln('Usage: bmf2wav [in.bmf] [out.wav]');
 end else begin
  Track:=SynthCreate(44100,512,false,false);
  assignfile(f,paramstr(1));
  {$i-}reset(f,1);{$i+}
  if ioresult=0 then begin
   i:=filesize(f);
   getmem(p,i);
   blockread(f,p^,i);
   closefile(f);
   SynthReadBMF(Track,p,i);
   freemem(p);
  end else begin
   writeln('Error at opening "'+paramstr(1)+'"');
   SynthDestroy(Track);
   halt;
  end;
  assignfile(wf,paramstr(2));
  {$i-}rewrite(wf,1);{$i+}
  if ioresult<>0 then begin
   writeln('Error at creating "'+paramstr(2)+'"');
   SynthDestroy(Track);
   halt;
  end;
  writeln('Exporting! Please wait... ');
  FileHandler;
  SynthReset(Track);
  SynthPlay(Track);
  while assigned(Track^.CurrentEvent) do begin
   SynthFillBuffer(Track,512);
   ps:=pointer(Track^.Buffer);
   psi:=pointer(@SoundBuf);
   for j:=1 to 512*2 do begin
    i:=round(ps^*32767);
    if i<-32767 then begin
     i:=-32767;
    end else if i>32767 then begin
     i:=32767;
    end;
    psi^:=i;
    inc(ps);
    inc(psi);
   end;
   blockwrite(wf,SoundBuf,512*4);
   inc(Bytes,512*4);
  end;
  FileHandler;
  seek(wf,filesize(wf));
  closefile(wf);
  SynthDestroy(Track);
  writeln('done...');
 end;
end.
