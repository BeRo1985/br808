(* Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * Licensed under the terms of the LGPL V3 or later, see LGPLv3.txt or
 * http://www.gnu.org/licenses/lgpl.html for details
 *)
unit UnitMIDIEvent;

interface

type TMIDIEvent=class
      public
       DeltaFrames:int64;
       id:int64;
       MIDIData:array[0..4] of byte;
       SysEx:pointer;
       SysExLen:longint;
       constructor Create;
       destructor Destroy; override;
     end;

implementation

constructor TMidiEvent.Create;
begin
 inherited Create;
 SysEx:=nil;
 SysExLen:=0;
end;

destructor TMidiEvent.Destroy;
begin
 if assigned(SysEx) then begin
  FreeMem(SysEx);
  SysEx:=nil;
 end;
 inherited Destroy;
end;

end.
