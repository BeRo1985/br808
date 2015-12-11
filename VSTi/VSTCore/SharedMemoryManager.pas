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
unit SharedMemoryManager;

interface

uses Windows,Messages;

const WM_TRACKERSTARTED=WM_USER+$1200;
      WM_TRACKEREXITED=WM_USER+$1201;

type PSharedMemoryBlock=^TSharedMemoryBlock;
     TSharedMemoryBlock=packed record
      VSTiWindowHandle:HWND;
      VSTiWindowTrackerControlHandle:HWND;
      TrackerWindowHandle:HWND;
      TrackerWindowBounds:TRect;
      FileName:shortstring;
     end;

     TSharedMemory=class
      private
       MappingHandle:THandle;
      public
       Memory:pointer;
       Size:longint;
       Exists:boolean;
       name:string;
       constructor Create;
       destructor Destroy; override;
       procedure GetMemory;
       procedure FreeMemory;
       procedure SetSize(ASize:longint);
       procedure SetName(const AName:string);
     end;

function LongWordToHex(Value:longword):string; register;
function HexToLongWord(Value:string):longword; register;

implementation

constructor TSharedMemory.Create;
begin
 inherited Create;
 Memory:=nil;
 MappingHandle:=0;
 Size:=0;
 name:='';
 Exists:=false;
end;

destructor TSharedMemory.Destroy;
begin
 inherited Destroy;
end;

procedure TSharedMemory.GetMemory;
begin
 if (Size>0) and (length(name)>0) then begin
  MappingHandle:=CreateFileMapping($ffffffff,nil,PAGE_READWRITE,0,Size,pchar(name));
  Exists:=GetLastError=ERROR_ALREADY_EXISTS;
  if MappingHandle<>0 then begin
   Memory:=MapViewOfFile(MappingHandle,FILE_MAP_WRITE,0,0,0);
  end else begin
   Memory:=nil;
  end;
 end;
end;

procedure TSharedmemory.FreeMemory;
begin
 Exists:=false;
 if Memory<>nil then begin
  UnmapViewOfFile(Memory);
  Memory:=nil;
 end;
 if MappingHandle<>0 then begin
  CloseHandle(MappingHandle);
  MappingHandle:=0;
 end;
end;

procedure TSharedMemory.SetSize(ASize:longint);
begin
 FreeMemory;
 Size:=ASize;
 GetMemory;
end;

procedure TSharedMemory.SetName(const AName:string);
begin
 FreeMemory;
 name:=AName;
 GetMemory;
end;

function LongWordToHex(Value:longword):string; register;
const Digits:array[0..$f] of char='0123456789ABCDEF';
begin
 result:='';
 while Value<>0 do begin
  result:=Digits[Value and $f]+result;
  Value:=Value shr 4;
 end;
end;

function HexToLongWord(Value:string):longword; register;
var Counter,Position:integer;
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

end.
