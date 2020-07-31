(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2007, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit LZBRX;
{$ifdef fpc}
 {$mode delphi}
 {$ifdef cpui386}
  {$define cpu386}
 {$endif}
 {$ifdef cpu386}
  {$asmmode intel}
 {$endif}
 {$ifdef cpuamd64}
  {$asmmode intel}
 {$endif}
 {$define caninline}
{$endif}

// LZBRX compression algorithm by BeRo
// Copyright (C) 2007, Benjamin 'BeRo' Rosseaux
// Give CREDITS, if you use it ! ;-)

interface

type TLZBRXCompressStatusHook=function(Current,Total:integer):boolean; stdcall;

function CompressLZBRX(SourcePointer:pointer;var DestinationPointer:pointer;SourceSize:longword;StatusHook:TLZBRXCompressStatusHook):longword;
function DecompressLZBRX(SourcePointer:pointer;var DestinationPointer:pointer;SourceSize:longword;StatusHook:TLZBRXCompressStatusHook):longword;

implementation

{$ifndef fpc}
type ptrint=longint;
     ptruint=longword;
{$endif}

const HashBits=16;
      HashSize=1 shl HashBits;
      HashMask=HashSize-1;

      rcLiteralShift=5;
      rcLengthShift=5;
      rcFlagShift=5;

      rcFlagContextBits=5;
      rcFlagContextSize=1 shl rcFlagContextBits;
      rcFlagContextMask=rcFlagContextSize-1;
      
      RangeCoderLengthLevels:array[0..15] of longword=(3,4,5,6,7,8,10,12,16,20,28,36,52,68,100,100);
      RangeCoderLengthExtraBits:array[0..15] of longword=(0,0,0,0,0,0,1,1,2,2,3,3,4,4,5,0);

type ppchar=^pchar;
     pword=^word;
     plongword=^longword;

     PHashNodes=^THashNodes;
     THashNodes=array[0..HashSize-1] of pchar;

     PWordArray=^TWordArray;
     TWordArray=array[0..($7fffffff div sizeof(word))-1] of word;

     PLongwordArray=^TLongwordArray;
     TLongwordArray=array[0..($7fffffff div sizeof(Longword))-1] of longword;

     TRangeCoderLiteralProbabilities=array[0..256,0..255] of longword;

     TRangeCoderLengthProbabilities=array[0..15] of longword;

     TRangeCoderFlagProbabilities=array[0..rcFlagContextMask] of longword;

     PRangeCoder=^TRangeCoder;
     TRangeCoder=record
      Buffer:ppansichar;
      BufferPosition,BufferSize:plongword;
      Value,Low,High,Middle,Bytes,LiteralContext,FlagContext:longword;
      LiteralProbabilities:TRangeCoderLiteralProbabilities;
      LengthProbabilities:TRangeCoderLengthProbabilities;
      FlagProbabilities:TRangeCoderFlagProbabilities;
     end;

function RangeCoderRead(var rc:TRangeCoder):byte;
begin
 if rc.BufferPosition^<rc.BufferSize^ then begin
  result:=byte(rc.Buffer^[rc.BufferPosition^]);
  inc(rc.BufferPosition^);
 end else begin
  result:=0;
 end;
end;

procedure RangeCoderWrite(var rc:TRangeCoder;b:byte);
begin
 if rc.BufferPosition^>=rc.BufferSize^ then begin
  inc(rc.BufferSize^,65536);
  reallocmem(rc.Buffer^,rc.BufferSize^);
 end;
 byte(rc.Buffer^[rc.BufferPosition^]):=b;
 inc(rc.BufferPosition^);
end;

procedure RangeCoderInit(var rc:TRangeCoder;Decoder:boolean); {$ifdef caninline}inline;{$endif}
var i,j:longword;
begin
 rc.Value:=0;
 rc.Low:=0;
 rc.High:=$ffffffff;
 rc.Bytes:=0;
 rc.LiteralContext:=256;
 rc.FlagContext:=0;
 if Decoder then begin
  for i:=1 to 4 do begin
   rc.Value:=(rc.Value shl 8) or RangeCoderRead(rc);
   inc(rc.Bytes);
  end;
 end;
 for i:=0 to 256 do begin
  for j:=0 to 255 do begin
   rc.LiteralProbabilities[i,j]:=1 shl 11;
  end;
 end;
 for i:=0 to 15 do begin
  rc.LengthProbabilities[i]:=1 shl 11;
 end;
 for i:=0 to rcFlagContextMask do begin
  rc.FlagProbabilities[i]:=1 shl 11;
 end;
end;

procedure RangeCoderFlush(var rc:TRangeCoder); {$ifdef caninline}inline;{$endif}
var i:longword;
begin
 for i:=1 to 4 do begin
  RangeCoderWrite(rc,rc.High shr 24);
  rc.High:=rc.High shl 8;
  inc(rc.Bytes);
 end;
end;

procedure RangeCoderEncodeNormalize(var rc:TRangeCoder); {$ifdef caninline}inline;{$endif}
begin
 while ((rc.Low xor rc.High) and $ff000000)=0 do begin
  RangeCoderWrite(rc,rc.High shr 24);
  rc.Low:=rc.Low shl 8;
  rc.High:=(rc.High shl 8) or $ff;
  inc(rc.Bytes);
 end;
end;

procedure RangeCoderEncodeBit(var rc:TRangeCoder;var Probability:longword;BitValue:longword;Shift:longword); {$ifdef caninline}inline;{$endif}
begin
 rc.Middle:=rc.Low+(((rc.High-rc.Low) shr 12)*Probability);
 if BitValue<>0 then begin
  inc(Probability,($fff-Probability) shr Shift);
  rc.High:=rc.Middle;
 end else begin
  dec(Probability,Probability shr Shift);
  rc.Low:=rc.Middle+1;
 end;
 RangeCoderEncodeNormalize(rc);
end;

procedure RangeCoderEncodeBitWithoutProbability(var rc:TRangeCoder;BitValue:longword); {$ifdef caninline}inline;{$endif}
begin
 rc.Middle:=rc.Low+((rc.High-rc.Low) shr 1);
 if BitValue<>0 then begin
  rc.High:=rc.Middle;
 end else begin
  rc.Low:=rc.Middle+1;
 end;
 RangeCoderEncodeNormalize(rc);
end;

procedure RangeCoderDecodeNormalize(var rc:TRangeCoder); {$ifdef caninline}inline;{$endif}
begin
 while ((rc.Low xor rc.High) and $ff000000)=0 do begin
  rc.Low:=rc.Low shl 8;
  rc.High:=(rc.High shl 8) or $ff;
  rc.Value:=(rc.Value shl 8) or RangeCoderRead(rc);
  inc(rc.Bytes);
 end;
end;

function RangeCoderDecodeBit(var rc:TRangeCoder;var Probability:longword;Shift:longword):longword; {$ifdef caninline}inline;{$endif}
begin
 rc.Middle:=rc.Low+(((rc.High-rc.Low) shr 12)*Probability);
 if rc.Value<=rc.Middle then begin
  inc(Probability,($fff-Probability) shr Shift);
  rc.High:=rc.Middle;
  result:=1;
 end else begin
  dec(Probability,Probability shr Shift);
  rc.Low:=rc.Middle+1;
  result:=0;
 end;
 RangeCoderDecodeNormalize(rc);
end;

function RangeCoderDecodeBitWithoutProbability(var rc:TRangeCoder):longword; {$ifdef caninline}inline;{$endif}
begin
 rc.Middle:=rc.Low+((rc.High-rc.Low) shr 1);
 if rc.Value<=rc.Middle then begin
  rc.High:=rc.Middle;
  result:=1;
 end else begin
  rc.Low:=rc.Middle+1;
  result:=0;
 end;
 RangeCoderDecodeNormalize(rc);
end;

procedure RangeCoderEncodeDirectBits(var rc:TRangeCoder;Value,Bits:longword); {$ifdef caninline}inline;{$endif}
begin
 while Bits>0 do begin
  dec(Bits);
  RangeCoderEncodeBitWithoutProbability(rc,(Value shr Bits) and 1);
 end;
end;

function RangeCoderDecodeDirectBits(var rc:TRangeCoder;Bits:longword):longword; {$ifdef caninline}inline;{$endif}
begin
 result:=0;
 while Bits>0 do begin
  dec(Bits);
  inc(result,result+RangeCoderDecodeBitWithoutProbability(rc));
 end;
end;

procedure RangeCoderResetLiteral(var rc:TRangeCoder); {$ifdef caninline}inline;{$endif}
begin
 rc.LiteralContext:=256;
end;

procedure RangeCoderEncodeLiteral(var rc:TRangeCoder;Literal:longword); {$ifdef caninline}inline;{$endif}
var i,j:longword;
begin
 i:=1;

 j:=(Literal shr 7) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=(Literal shr 6) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=(Literal shr 5) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=(Literal shr 4) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=(Literal shr 3) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=(Literal shr 2) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=(Literal shr 1) and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);
 inc(i,i+j);

 j:=Literal and 1;
 RangeCoderEncodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],j,rcLiteralShift);

 rc.LiteralContext:=Literal;
end;

function RangeCoderDecodeLiteral(var rc:TRangeCoder):longword; {$ifdef caninline}inline;{$endif}
var i:longword;
begin
 i:=1;
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 inc(i,i+RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift));
 result:=((i and $7f) shl 1) or RangeCoderDecodeBit(rc,rc.LiteralProbabilities[rc.LiteralContext,i],rcLiteralShift);
 rc.LiteralContext:=result;
end;

procedure RangeCoderEncodeLength(var rc:TRangeCoder;Len:longword); {$ifdef caninline}inline;{$endif}
var v,i,j:longword;
begin
 i:=1;
 while Len>100 do begin
  dec(Len,98);
  RangeCoderEncodeBit(rc,rc.LengthProbabilities[1],1,rcLengthShift);
  RangeCoderEncodeBit(rc,rc.LengthProbabilities[3],1,rcLengthShift);
  RangeCoderEncodeBit(rc,rc.LengthProbabilities[7],1,rcLengthShift);
  RangeCoderEncodeBit(rc,rc.LengthProbabilities[15],1,rcLengthShift);
 end;
 v:=0;
 while v<15 do begin
  if Len<=RangeCoderLengthLevels[v] then begin
   break;
  end;
  inc(v);
 end;
 j:=(v shr 3) and 1;
 RangeCoderEncodeBit(rc,rc.LengthProbabilities[i],j,rcLengthShift);
 inc(i,i+j);
 j:=(v shr 2) and 1;
 RangeCoderEncodeBit(rc,rc.LengthProbabilities[i],j,rcLengthShift);
 inc(i,i+j);
 j:=(v shr 1) and 1;
 RangeCoderEncodeBit(rc,rc.LengthProbabilities[i],j,rcLengthShift);
 inc(i,i+j);
 j:=v and 1;
 RangeCoderEncodeBit(rc,rc.LengthProbabilities[i],j,rcLengthShift);
 if RangeCoderLengthExtraBits[v]>0 then begin
  RangeCoderEncodeDirectBits(rc,Len-(RangeCoderLengthLevels[v-1]+1),RangeCoderLengthExtraBits[v]);
 end;
end;

function RangeCoderDecodeLength(var rc:TRangeCoder):longword; {$ifdef caninline}inline;{$endif}
var i,c:longword;
begin
 result:=0;
 c:=15;
 while (c=15) and (rc.BufferPosition^<=rc.BufferSize^) do begin
  inc(result,98);
  i:=1;
  inc(i,i+RangeCoderDecodeBit(rc,rc.LengthProbabilities[i],rcLengthShift));
  inc(i,i+RangeCoderDecodeBit(rc,rc.LengthProbabilities[i],rcLengthShift));
  inc(i,i+RangeCoderDecodeBit(rc,rc.LengthProbabilities[i],rcLengthShift));
  c:=((i and 7) shl 1) or RangeCoderDecodeBit(rc,rc.LengthProbabilities[i],rcLengthShift);
 end;
 if c>0 then begin
  dec(result,0);
 end;
 dec(result,98);
 if RangeCoderLengthExtraBits[c]>0 then begin
  inc(result,RangeCoderLengthLevels[c-1]+RangeCoderDecodeDirectBits(rc,RangeCoderLengthExtraBits[c])+1);
 end else begin
  inc(result,RangeCoderLengthLevels[c]);
 end;
end;

procedure RangeCoderEncodeFlag(var rc:TRangeCoder;BitValue:longword); {$ifdef caninline}inline;{$endif}
begin
 RangeCoderEncodeBit(rc,rc.FlagProbabilities[rc.FlagContext and rcFlagContextMask],BitValue,rcFlagShift);
 rc.FlagContext:=((rc.FlagContext shl 1)+BitValue) and rcFlagContextMask;
 if BitValue<>0 then begin
  RangeCoderResetLiteral(rc);
 end;
end;

function RangeCoderDecodeFlag(var rc:TRangeCoder):longword; {$ifdef caninline}inline;{$endif}
begin
 result:=RangeCoderDecodeBit(rc,rc.FlagProbabilities[rc.FlagContext and rcFlagContextMask],rcFlagShift);
 rc.FlagContext:=((rc.FlagContext shl 1)+result) and rcFlagContextMask;
 if result<>0 then begin
  RangeCoderResetLiteral(rc);
 end;
end;

function CompressLZBRX(SourcePointer:pointer;var DestinationPointer:pointer;SourceSize:longword;StatusHook:TLZBRXCompressStatusHook):longword;
var Source,Destination,EndPointer,HashDataPointer:pchar;
    Hash,FoundLength,BufferPosition,BufferSize:longword;
    Counter:integer;
    HashNodes:PHashNodes;
    rc:PRangeCoder;
begin
 if SourceSize>0 then begin
  DestinationPointer:=nil;

  new(HashNodes);
  fillchar(HashNodes^,sizeof(THashNodes),#0);

  Source:=SourcePointer;

  EndPointer:=@Source[SourceSize];

  BufferPosition:=sizeof(longword);
  BufferSize:=SourceSize;
  if BufferSize>262144 then begin
   BufferSize:=262144;
  end;
  getmem(Destination,BufferSize);
  longword(pointer(Destination)^):=SourceSize;

  new(rc);
  rc^.Buffer:=@Destination;
  rc^.BufferPosition:=@BufferPosition;
  rc^.BufferSize:=@BufferSize;
  RangeCoderInit(rc^,false);

  RangeCoderResetLiteral(rc^);
  Counter:=3;
  while (Counter>0) and (ptruint(Source)<ptruint(EndPointer)) do begin
   RangeCoderEncodeLiteral(rc^,byte(Source^));
   inc(Source);
   dec(Counter);
  end;

  while ptruint(Source)<ptruint(EndPointer) do begin
   if assigned(StatusHook) then begin
    StatusHook(ptruint(Source)-ptruint(SourcePointer),SourceSize);
   end;

   Hash:=((byte(Source[-3]) xor (byte(Source[-2]) shl 7)) xor (byte(Source[-1]) shl 11)) and HashMask;
   HashDataPointer:=HashNodes^[Hash];
   HashNodes^[Hash]:=Source;

   if assigned(HashDataPointer) then begin
    FoundLength:=0;
    while (ptruint(Source)<ptruint(EndPointer)) and (HashDataPointer^=Source^) and ((FoundLength and $80000000)=0) do begin
     inc(FoundLength);
     inc(HashDataPointer);
     inc(Source);
    end;
    if FoundLength>2 then begin
     RangeCoderEncodeFlag(rc^,1);
     RangeCoderEncodeLength(rc^,FoundLength);
    end else begin
     RangeCoderEncodeFlag(rc^,0);
     dec(Source,FoundLength);
    end;
   end;

   if ptruint(Source)<ptruint(EndPointer) then begin
    RangeCoderEncodeLiteral(rc^,byte(Source^));
    inc(Source);
   end;

  end;

  if assigned(StatusHook) then begin
   StatusHook(SourceSize,SourceSize);
  end;

  dispose(HashNodes);

  RangeCoderFlush(rc^);
  dispose(rc);

  DestinationPointer:=Destination;

  result:=BufferPosition;
 end else begin
  result:=0;
 end;
end;

function DecompressLZBRX(SourcePointer:pointer;var DestinationPointer:pointer;SourceSize:longword;StatusHook:TLZBRXCompressStatusHook):longword;
var Source,Destination,DestEndPointer,HashDataPointer:pchar;
    LengthCount,DestSize,Hash,BufferPosition:longword;
    Counter:integer;
    HashNodes:PHashNodes;
    rc:PRangeCoder;
begin
 if SourceSize>4 then begin
  result:=plongword(SourcePointer)^;
  getmem(DestinationPointer,result);

  Source:=SourcePointer;
  DestSize:=longword(pointer(Source)^);
  inc(Source,sizeof(longword));

  if DestSize>0 then begin

   new(HashNodes);
   fillchar(HashNodes^,sizeof(THashNodes),#0);

   Destination:=DestinationPointer;
   DestEndPointer:=@Destination[DestSize];

   BufferPosition:=0;

   new(rc);
   rc^.Buffer:=@Source;
   rc^.BufferPosition:=@BufferPosition;
   rc^.BufferSize:=@SourceSize;
   RangeCoderInit(rc^,true);

   RangeCoderResetLiteral(rc^);
   Counter:=3;
   while (Counter>0) and (BufferPosition<=SourceSize) and (ptruint(Destination)<ptruint(DestEndPointer)) do begin
    Destination^:=char(byte(RangeCoderDecodeLiteral(rc^)));
    inc(Destination);
    dec(Counter);
   end;

   while ptruint(Destination)<ptruint(DestEndPointer) do begin
    if assigned(StatusHook) then begin
     StatusHook(ptruint(Destination)-ptruint(DestinationPointer),DestSize);
    end;

    Hash:=((byte(Destination[-3]) xor (byte(Destination[-2]) shl 7)) xor (byte(Destination[-1]) shl 11)) and HashMask;
    HashDataPointer:=HashNodes^[Hash];
    HashNodes^[Hash]:=Destination;

    if assigned(HashDataPointer) then begin

     if RangeCoderDecodeFlag(rc^)<>0 then begin
      if BufferPosition>SourceSize then begin
       break;
      end;

      LengthCount:=RangeCoderDecodeLength(rc^);
      if BufferPosition>SourceSize then begin
       break;
      end;

      while (LengthCount>0) and (ptruint(Destination)<ptruint(DestEndPointer)) do begin
       Destination^:=HashDataPointer^;
       inc(HashDataPointer);
       inc(Destination);
       dec(LengthCount);
      end;

     end;
    end;

    if (BufferPosition<=SourceSize) and (ptruint(Destination)<ptruint(DestEndPointer)) then begin
     Destination^:=char(byte(RangeCoderDecodeLiteral(rc^)));
     inc(Destination);
    end else begin
     break;
    end;

   end;

   if assigned(StatusHook) then begin
    StatusHook(DestSize,DestSize);
   end;

   dispose(rc);
   dispose(HashNodes);
  end;
 end else begin
  result:=0;
  DestinationPointer:=nil;
 end;
end;

end.
