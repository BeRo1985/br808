(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2001-2002, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoStream;
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

const bsoFromBeginning=0;
      bsoFromCurrent=1;
      bsoFromEnd=2;

type PBeRoStreamData=^TBeRoStreamData;
     TBeRoStreamData=packed array[0..$7ffffffe] of byte;

     PBeRoStreamBuffer=^TBeRoStreamBuffer;
     TBeRoStreamBuffer=packed array[1..4096] of byte;

     PBeRoStream=^TBeRoStream;
     TBeRoStream=class
      private
       fPosition,fSize,fInMemorySize:integer;
       fData:PBeRoStreamData;
       fBitBuffer:longword;
       fBitBufferSize:byte;
       procedure Realloc(NewInMemorySize:integer);
       procedure Resize(NewSize:integer);
       function GetString:string;
       procedure setstring(Value:string);
       function GetByte(BytePosition:integer):byte;
       procedure SetByte(BytePosition:integer;Value:byte);
      public
       constructor Create;
       destructor Destroy; override;
       function Assign(Src:TBeRoStream):integer;
       function Append(Src:TBeRoStream):integer;
       function AppendFrom(Src:TBeRoStream;Counter:integer):integer;
       procedure Clear; virtual;
       function read(var Buf;Count:integer):integer; virtual;
       function ReadAt(Position:integer;var Buf;Count:integer):integer; virtual;
       function write(const Buf;Count:integer):integer; virtual;
       function SeekEx(APosition:integer):integer; virtual;
       function Seek(APosition:integer):integer; overload;
       function Seek(APosition,Origin:integer):integer; overload;
       function Position:integer; virtual;
       function Size:integer; virtual;
       procedure SetSize(NewSize:integer);
       function ReadByte:byte;
       function ReadWord:word;
       function ReadDWord:longword;
       function ReadLine:string;
       function ReadString:string;
       procedure WriteByte(Value:byte);
       function WriteByteCount(Value:byte;Count:integer):integer;
       procedure WriteWord(Value:word);
       procedure WriteDWord(Value:longword);
       procedure WriteShortInt(Value:shortint);
       procedure WriteSmallInt(Value:smallint);
       procedure WriteLongInt(Value:longint);
       procedure WriteInt64(Value:int64);
       procedure WriteBoolean(Value:boolean);
       procedure WriteLine(Line:string);
       procedure WriteString(S:string);
       procedure WriteDataString(S:string);
       procedure ResetBits;
       function ReadBit:boolean;
       function ReadBits(BitsCount:byte):longword;
       function ReadBitsSigned(BitsCount:byte):longint;
       procedure WriteBit(Value:boolean);
       procedure WriteBits(Value:longword;BitsCount:byte);
       procedure WriteBitsSigned(Value:longint;BitsCount:byte);
       procedure FlushBits;
       property Text:string read GetString write setstring;
       property Bytes[BytePosition:integer]:byte read GetByte write SetByte; default;
       property BitsInBuffer:byte read fBitBufferSize;
     end;

     PBeRoDatenStream=^TBeRoDatenStream;
     TBeRoDatenStream=TBeRoStream;

     PBeRoMemoryStream=^TBeRoMemoryStream;
     TBeRoMemoryStream=TBeRoStream;

     PBeRoFileStream=^TBeRoFileStream;
     TBeRoFileStream=class(TBeRoStream)
      private
       fFile:file;
      public
       constructor Create(FileName:string);
       constructor CreateNew(FileName:string);
       destructor Destroy; override;
       function read(var Buf;Count:integer):integer; override;
       function write(const Buf;Count:integer):integer; override;
       function SeekEx(APosition:integer):integer; override;
       function Position:integer; override;
       function Size:integer; override;
     end;

implementation

type pbyte=^byte;

const MemoryDelta=1 shl 16;
      MemoryDeltaMask=MemoryDelta-1;

constructor TBeRoStream.Create;
begin
 inherited Create;
 fData:=nil;
 REALLOCMEM(fData,0);
 fPosition:=0;
 fSize:=0;
 fInMemorySize:=0;
 ResetBits;
end;

destructor TBeRoStream.Destroy;
begin
 REALLOCMEM(fData,0);
 fPosition:=0;
 fSize:=0;
 fInMemorySize:=0;
 inherited Destroy;
end;

function TBeRoStream.Assign(Src:TBeRoStream):integer;
var Remain,Count:integer;
    Buf:TBeRoStreamBuffer;
begin
 Clear;
 result:=0;
 Remain:=Src.Size;
 if (Seek(0)<>0) or (Src.Seek(0)<>0) then exit;
 while Remain>=sizeof(TBeRoStreamBuffer) do begin
  Count:=Src.read(Buf,sizeof(TBeRoStreamBuffer));
  write(Buf,Count);
  inc(result,Count);
  dec(Remain,sizeof(TBeRoStreamBuffer));
 end;
 Count:=Src.read(Buf,Remain);
 write(Buf,Count);
 inc(result,Count);
end;

function TBeRoStream.Append(Src:TBeRoStream):integer;
var Remain,Count:integer;
    Buf:TBeRoStreamBuffer;
begin
 result:=0;
 Remain:=Src.Size;
 if Src.Seek(0)<>0 then exit;
 while Remain>=sizeof(TBeRoStreamBuffer) do begin
  Count:=Src.read(Buf,sizeof(TBeRoStreamBuffer));
  write(Buf,Count);
  inc(result,Count);
  dec(Remain,sizeof(TBeRoStreamBuffer));
 end;
 Count:=Src.read(Buf,Remain);
 write(Buf,Count);
 inc(result,Count);
end;

function TBeRoStream.AppendFrom(Src:TBeRoStream;Counter:integer):integer;
var Remain,Count:integer;
    Buf:TBeRoStreamBuffer;
begin
 result:=0;
 Remain:=Counter;
 while Remain>=sizeof(TBeRoStreamBuffer) do begin
  Count:=Src.read(Buf,sizeof(TBeRoStreamBuffer));
  write(Buf,Count);
  inc(result,Count);
  dec(Remain,sizeof(TBeRoStreamBuffer));
 end;
 Count:=Src.read(Buf,Remain);
 write(Buf,Count);
 inc(result,Count);
end;

procedure TBeRoStream.Clear;
begin
 REALLOCMEM(fData,0);
 fPosition:=0;
 fSize:=0;
 fInMemorySize:=0;
end;

procedure TBeRoStream.Realloc(NewInMemorySize:integer);
var OldInMemorySize,Count:integer;
begin
 if NewInMemorySize>0 then begin
  NewInMemorySize:=(NewInMemorySize+MemoryDeltaMask) and not MemoryDeltaMask;
 end;
 if fInMemorySize<>NewInMemorySize then begin
  OldInMemorySize:=fInMemorySize;
  fInMemorySize:=NewInMemorySize;
  REALLOCMEM(fData,fInMemorySize);
  Count:=NewInMemorySize-OldInMemorySize;
  if Count>0 then begin
   FILLCHAR(fData^[OldInMemorySize],Count,#0);
  end;
 end;
end;

procedure TBeRoStream.Resize(NewSize:integer);
begin
 fSize:=NewSize;
 if fPosition>fSize then fPosition:=fSize;
 Realloc(fSize);
end;

function TBeRoStream.read(var Buf;Count:integer):integer;
begin
 if (fPosition>=0) and (Count>0) then begin
  result:=fSize-fPosition;
  if result>0 then begin
   if result>Count then result:=Count;
   MOVE(fData^[fPosition],Buf,result);
   inc(fPosition,result);
   exit;
  end;
 end;
 result:=0;
end;

function TBeRoStream.ReadAt(Position:integer;var Buf;Count:integer):integer;
begin
 if Seek(Position)=Position then begin
  result:=read(Buf,Count);
 end else begin
  result:=0;
 end;
end;

function TBeRoStream.write(const Buf;Count:integer):integer;
var EndPosition:integer;
begin
if (fPosition>=0) and (Count>0) then begin
  EndPosition:=fPosition+Count;
  if EndPosition>fSize then Resize(EndPosition);
  MOVE(Buf,fData^[fPosition],Count);
  fPosition:=EndPosition;
  result:=Count;
  exit;
 end;
 result:=0;
end;

function TBeRoStream.SeekEx(APosition:integer):integer;
var AltePos,RemainSize:integer;
begin
 fPosition:=APosition;
 if fPosition<0 then fPosition:=0;
 if fPosition>fSize then begin
  AltePos:=fSize;
  RemainSize:=fPosition-fSize;
  if RemainSize>0 then begin
   Resize(fSize+RemainSize);
   FILLCHAR(fData^[AltePos],RemainSize,#0);
  end;
  result:=fPosition;
 end else begin
  result:=fPosition;
 end;
end;

function TBeRoStream.Seek(APosition:integer):integer;
begin
 result:=SeekEx(APosition);
end;

function TBeRoStream.Seek(APosition,Origin:integer):integer;
begin
 case Origin of
  bsoFromBeginning:result:=SeekEx(APosition);
  bsoFromCurrent:result:=SeekEx(Position+APosition);
  bsoFromEnd:result:=SeekEx(Size+APosition);
  else result:=SeekEx(APosition);
 end;
end;

function TBeRoStream.Position:integer;
begin
 result:=fPosition;
end;

function TBeRoStream.Size:integer;
begin
 result:=fSize;
end;

procedure TBeRoStream.SetSize(NewSize:integer);
begin
 fSize:=NewSize;
 if fPosition>fSize then fPosition:=fSize;
 REALLOCMEM(fData,fSize);
end;

function TBeRoStream.ReadByte:byte;
var B:byte;
begin
 if read(B,1)<>1 then begin
  result:=0;
 end else begin
  result:=B;
 end;
end;

function TBeRoStream.ReadWord:word;
begin
 result:=ReadByte or (ReadByte shl 8);
end;

function TBeRoStream.ReadDWord:longword;
begin
 result:=ReadWord or (ReadWord shl 16);
end;

function TBeRoStream.ReadLine:string;
var C:char;
begin
 result:='';
 while Position<Size do begin
  read(C,1);
  case C of
   #10,#13:begin
    while (Position<Size) and (Bytes[Position] in [10,13]) do begin
     read(C,1);
    end;
    break;
   end;
   else result:=result+C;
  end;
 end;
end;

function TBeRoStream.ReadString:string;
var L:longword;
begin
 L:=ReadDWord;
 setlength(result,L);
 if L>0 then read(result[1],L);
end;

procedure TBeRoStream.WriteByte(Value:byte);
begin
 write(Value,sizeof(byte));
end;

function TBeRoStream.WriteByteCount(Value:byte;Count:integer):integer;
var Counter:integer;
begin
 result:=0;
 for Counter:=1 to Count do inc(result,write(Value,sizeof(byte)));
end;

procedure TBeRoStream.WriteWord(Value:word);
begin
 write(Value,sizeof(word));
end;

procedure TBeRoStream.WriteDWord(Value:longword);
begin
 write(Value,sizeof(longword));
end;

procedure TBeRoStream.WriteShortInt(Value:shortint);
begin
 write(Value,sizeof(shortint));
end;

procedure TBeRoStream.WriteSmallInt(Value:smallint);
begin
 write(Value,sizeof(smallint));
end;

procedure TBeRoStream.WriteLongInt(Value:longint);
begin
 write(Value,sizeof(longint));
end;

procedure TBeRoStream.WriteInt64(Value:int64);
begin
 write(Value,sizeof(int64));
end;

procedure TBeRoStream.WriteBoolean(Value:boolean);
begin
 if Value then begin
  WriteByte(1);
 end else begin
  WriteByte(0);
 end;
end;

procedure TBeRoStream.WriteLine(Line:string);
const CRLF:array[1..2] of char=#13#10;
begin
 if length(Line)>0 then write(Line[1],length(Line));
 write(CRLF,2);
end;

procedure TBeRoStream.WriteString(S:string);
var L:longword;
begin
 L:=length(S);
 if L>0 then write(S[1],L);
end;

procedure TBeRoStream.WriteDataString(S:string);
var L:longword;
begin
 L:=length(S);
 WriteDWord(L);
 if L>0 then write(S[1],L);
end;

procedure TBeRoStream.ResetBits;
begin
 fBitBuffer:=0;
 fBitBufferSize:=0;
end;

function TBeRoStream.ReadBit:boolean;
begin
 result:=(ReadBits(1)<>0);
end;

function TBeRoStream.ReadBits(BitsCount:byte):longword;
begin
 while fBitBufferSize<BitsCount do begin
  fBitBuffer:=(fBitBuffer shl 8) or ReadByte;
  inc(fBitBufferSize,8);
 end;
 result:=(fBitBuffer shr (fBitBufferSize-BitsCount)) and ((1 shl BitsCount)-1);
 dec(fBitBufferSize,BitsCount);
end;

function TBeRoStream.ReadBitsSigned(BitsCount:byte):longint;
begin
 result:=0;
 if BitsCount>1 then begin
  if ReadBits(1)<>0 then begin
   result:=-ReadBits(BitsCount-1);
  end else begin
   result:=ReadBits(BitsCount-1);
  end;
 end;
end;

procedure TBeRoStream.WriteBit(Value:boolean);
begin
 if Value then begin
  WriteBits(1,1);
 end else begin
  WriteBits(0,1);
 end;
end;

procedure TBeRoStream.WriteBits(Value:longword;BitsCount:byte);
begin
 fBitBuffer:=(fBitBuffer shl BitsCount) or Value;
 inc(fBitBufferSize,BitsCount);
 while fBitBufferSize>=8 do begin
  WriteByte((fBitBuffer shr (fBitBufferSize-8)) and $ff);
  dec(fBitBufferSize,8);
 end;
end;

procedure TBeRoStream.WriteBitsSigned(Value:longint;BitsCount:byte);
begin
 if BitsCount>1 then begin
  if Value<0 then begin
   WriteBits(1,1);
   WriteBits(longword(0-Value),BitsCount-1);
  end else begin
   WriteBits(0,1);
   WriteBits(longword(Value),BitsCount-1);
  end;
 end;
end;

procedure TBeRoStream.FlushBits;
begin
 if fBitBufferSize>0 then begin
  WriteByte(fBitBuffer shl (8-fBitBufferSize));
 end;
 fBitBuffer:=0;
 fBitBufferSize:=0;
end;

function TBeRoStream.GetString:string;
begin
 Seek(0);
 if Size>0 then begin
  setlength(result,Size);
  read(result[1],Size);
 end else begin
  result:='';
 end;
end;

procedure TBeRoStream.setstring(Value:string);
begin
 Clear;
 if length(Value)>0 then begin
  write(Value[1],length(Value));
 end;
end;

function TBeRoStream.GetByte(BytePosition:integer):byte;
var AltePosition:integer;
begin
 AltePosition:=Position;
 Seek(BytePosition);
 read(result,sizeof(byte));
 Seek(AltePosition);
end;

procedure TBeRoStream.SetByte(BytePosition:integer;Value:byte);
var AltePosition:integer;
begin
 AltePosition:=Position;
 Seek(BytePosition);
 write(Value,sizeof(byte));
 Seek(AltePosition);
end;

constructor TBeRoFileStream.Create(FileName:string);
var Alt:byte;
begin
 inherited Create;
 Alt:=FileMode;
 FileMode:=0;
 ASSIGNFILE(fFile,FileName);
 {$I-}RESET(fFile,1);{$I+}
 FileMode:=Alt;
 if IOResult<>0 then {$I-}REWRITE(fFile,1);{$I+}
 if IOResult<>0 then begin
 end;
end;

constructor TBeRoFileStream.CreateNew(FileName:string);
var Alt:byte;
begin
 inherited Create;
 Alt:=FileMode;
 FileMode:=2;
 ASSIGNFILE(fFile,FileName);
 {$I-}REWRITE(fFile,1);{$I+}
 FileMode:=Alt;
 if IOResult<>0 then begin
 end;
end;

destructor TBeRoFileStream.Destroy;
begin
 {$I-}CLOSEFILE(fFile);{$I+}
 if IOResult<>0 then begin
 end;
 inherited Destroy;
end;

function TBeRoFileStream.read(var Buf;Count:integer):integer;
var I:integer;
begin
 {$I-}BLOCKREAD(fFile,Buf,Count,I);{$I+}
 if IOResult<>0 then begin
  result:=0;
  exit;
 end;
 {$I-}fPosition:=FILEPOS(fFile);{$I+}
 if IOResult<>0 then begin
  result:=0;
  exit;
 end;
 result:=I;
end;

function TBeRoFileStream.write(const Buf;Count:integer):integer;
var I:integer;
begin
 {$I-}BLOCKWRITE(fFile,Buf,Count,I);{$I+}
 if IOResult<>0 then begin
  result:=0;
  exit;
 end;
 {$I-}fPosition:=FILEPOS(fFile);{$I+}
 if IOResult<>0 then begin
  result:=0;
  exit
 end;
 result:=I;
end;

function TBeRoFileStream.SeekEx(APosition:integer):integer;
begin
 if APosition<=Size then begin
  {$I-}System.SEEK(fFile,APosition);{$I+}
  if IOResult<>0 then begin
   result:=0;
   exit;
  end;
 end;
 {$I-}result:=FILEPOS(fFile);{$I+}
 if IOResult<>0 then begin
  result:=0;
 end;
end;

function TBeRoFileStream.Position:integer;
begin
 {$I-}result:=FILEPOS(fFile);{$I+}
 if IOResult<>0 then begin
  result:=0;
 end;
end;

function TBeRoFileStream.Size:integer;
begin
 {$I-}result:=FILESIZE(fFile);{$I+}
 if IOResult<>0 then begin
  result:=0;
 end;
end;

end.
