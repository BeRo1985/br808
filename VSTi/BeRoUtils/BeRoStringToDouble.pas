(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2011, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoStringToDouble;
{$ifdef fpc}
 {$mode delphi}
 {$h+}
 {$define caninline}
{$endif}
{$warnings off}

interface

const ROUND_TO_NEAREST=0;
      ROUND_TOWARD_ZERO=1;
      ROUND_UPWARD=2;
      ROUND_DOWNWARD=3;

function BeRoConvertStringToDouble(const StringValue:ansistring;RoundingMode:integer=ROUND_TO_NEAREST):double;

implementation

function BeRoConvertStringToDouble(const StringValue:ansistring;RoundingMode:integer=ROUND_TO_NEAREST):double;
type PDoubleCasted=^TDoubleCasted;
     TDoubleCasted=packed record
      case byte of
       0:(Value:double);
       1:({$ifdef BIG_ENDIAN}Hi,Lo{$else}Lo,Hi{$endif}:longword);
     end;
const MantissaWords=12; //6; // 12
      MantissaDigits=52; //28; // 52
      WordTopBit=$8000;
      WordBits=16;
      WordBitShift=4;
      WordBitMask=WordBits-1;
      WordMask=$ffff;
      IEEEFormatBytes=8;
      IEEEFormatBits=IEEEFormatBytes shl 3;
      IEEEFormatExplicit=0;
      IEEEFormatExponent=11;
      IEEEFormatOneMask=WordTopBit shr ((IEEEFormatExponent+IEEEFormatExplicit) and WordBitMask);
      IEEEFormatOnePos=(IEEEFormatExponent+IEEEFormatExplicit) shr WordBitShift;
      IEEEFormatExpMax=1 shl (IEEEFormatExponent-1);
type PWords=^TWords;
     TWords=array[0..MantissaWords] of word;
     PTemp=^TTemp;
     TTemp=array[0..MantissaWords*2] of longword;
     PDigits=^TDigits;
     TDigits=array[0..MantissaDigits] of byte;
var MantissaPosition,Exponent,TenPower,TwoPower,ExtraTwos,Shift,i,p,q,r:integer;
    Bit,Carry:word;
    Negative,ExponentNegative,HasDigits,Started:boolean;
    ResultCasted:PDoubleCasted;
    Temp:PTemp;
    Digits:PDigits;
    MantissaMultiplicator,Mantissa:PWords;
 function MantissaMultiply(vTo,vFrom:PWords):integer;
 var i,j,k:integer;
     v:longword;
     t:PTemp;
 begin
  t:=Temp;
  FillChar(t^,sizeof(TTemp),#0);
  for i:=0 to MantissaWords-1 do begin
   for j:=0 to MantissaWords-1 do begin
    v:=longword(vTo^[i]+0)*longword(vFrom^[j]+0);
    k:=i+j;
    inc(t^[k],v shr WordBits);
    inc(t^[k+1],v and WordMask);
   end;
  end;
  for i:=high(TTemp) downto 1 do begin
   inc(t^[i-1],t^[i] shr WordBits);
   t^[i]:=t^[i] and WordMask;
  end;
  if (t^[0] and WordTopBit)<>0 then begin
   for i:=0 to MantissaWords-1 do begin
    vTo^[i]:=t^[i] and WordMask;
   end;
   result:=0;
  end else begin
   for i:=0 to MantissaWords-1 do begin
    vTo^[i]:=(t^[i] shl 1)+word(ord((t^[i+1] and WordTopBit)<>0));
   end;
   result:=-1;
  end;
 end;
 procedure MantissaShiftRight(var Mantissa:TWords;Shift:integer);
 var Bits,Words,InvBits,Position:integer;
     Carry,Current:longword;
 begin
  Bits:=Shift and WordBitMask;
  Words:=Shift shr WordBitShift;
  InvBits:=WordBits-Bits;
  Position:=high(TWords);
  if Bits=0 then begin
   if Words<>0 then begin
    while Position>=Words do begin
     Mantissa[Position]:=Mantissa[Position-Words];
     dec(Position);
    end;
   end;
  end else begin
   if (high(TWords)-Words)>=0 then begin
    Carry:=Mantissa[high(TWords)-Words] shr Bits;
   end else begin
    Carry:=0;
   end;
   while Position>Words do begin
    Current:=Mantissa[Position-(Words+1)];
    Mantissa[Position]:=(Current shl InvBits) or Carry;
    Carry:=Current shr Bits;
    dec(Position);
   end;
   Mantissa[Position]:=Carry;
   dec(Position);
  end;
  while Position>=0 do begin
   Mantissa[Position]:=0;
   dec(Position);
  end;
 end;
 procedure MantissaSetBit(var Mantissa:TWords;i:integer);
 begin
  Mantissa[i shr WordBitShift]:=Mantissa[i shr WordBitShift] or (WordTopBit shr (i and WordBitMask));
 end;
 function MantissaTestBit(var Mantissa:TWords;i:integer):boolean;
 begin
  result:=(Mantissa[i shr WordBitShift] shr ((not i) and WordBitMask))<>0;
 end;
 function MantissaIsZero(var Mantissa:TWords):boolean;
 var i:integer;
 begin
  result:=true;
  for i:=low(TWords) to high(TWords) do begin
   if Mantissa[i]<>0 then begin
    result:=false;
    break;
   end;
  end;
 end;
 function MantissaRound(Negative:boolean;var Mantissa:TWords;BitPos:integer):boolean;
 var i,p:integer;
     Bit:longword;
  function RoundAbsDown:boolean;
  var j:integer;
  begin
   Mantissa[i]:=Mantissa[i] and not (Bit-1);
   for j:=i+1 to high(TWords) do begin
    Mantissa[j]:=0;
   end;
   result:=false;
  end;
  function RoundAbsUp:boolean;
  var j:integer;
  begin
   Mantissa[i]:=(Mantissa[i] and not (Bit-1))+Bit;
   for j:=i+1 to high(TWords) do begin
    Mantissa[j]:=0;
   end;
   while (i>0) and (Mantissa[i]=0) do begin
    dec(i);
    inc(Mantissa[i]);
   end;
   result:=Mantissa[0]=0;
  end;
  function RoundTowardsInfinity:boolean;
  var j:integer;
      m:longword;
  begin
   m:=Mantissa[i] and ((Bit shl 1)-1);
   for j:=i+1 to high(TWords) do begin
    m:=m or Mantissa[j];
   end;
   if m<>0 then begin
    result:=RoundAbsUp;
   end else begin
    result:=RoundAbsDown;
   end;
  end;
  function RoundNear:boolean;
  var j:integer;
      m:longword;
  begin
   if (Mantissa[i] and Bit)<>0 then begin
    Mantissa[i]:=Mantissa[i] and not Bit;
    m:=Mantissa[i] and ((Bit shl 1)-1);
    for j:=i+1 to high(TWords) do begin
     m:=m or Mantissa[j];
    end;
    Mantissa[i]:=Mantissa[i] or Bit;
    if m<>0 then begin
     result:=RoundAbsUp;
    end else begin
     if MantissaTestBit(Mantissa,BitPos-1) then begin
      result:=RoundAbsUp;
     end else begin
      result:=RoundAbsDown;
     end;
    end;
   end else begin
    result:=RoundAbsDown;
   end;
  end;
 begin
  i:=BitPos shr WordBitShift;
  p:=BitPos and WordBitMask;
  Bit:=WordTopBit shr p;
  case RoundingMode of
   ROUND_TO_NEAREST:begin
    result:=RoundNear;
   end;
   ROUND_TOWARD_ZERO:begin
    result:=RoundAbsDown;
   end;
   ROUND_UPWARD:begin
    if Negative then begin
     result:=RoundAbsDown;
    end else begin
     result:=RoundTowardsInfinity;
    end;
   end;
   ROUND_DOWNWARD:begin
    if Negative then begin
     result:=RoundTowardsInfinity;
    end else begin
     result:=RoundAbsDown;
    end;
   end;
   else begin
    result:=false;
   end;
  end;
 end;
begin
 ResultCasted:=pointer(@result);
 ResultCasted^.Hi:=$7ff80000;
 ResultCasted^.Lo:=$00000000;
 i:=1;
 while (i<=length(StringValue)) and (StringValue[i] in [#0..#32]) do begin
  inc(i);
 end;
 if (i<=length(StringValue)) and ((StringValue[i]='-') or (StringValue[i]='+')) then begin
  Negative:=StringValue[i]='-';
  inc(i);
 end else begin
  Negative:=false;
 end;
 if ((i+7)<=length(StringValue)) and ((StringValue[i]='I') and (StringValue[i+1]='n') and (StringValue[i+2]='f') and (StringValue[i+3]='i') and (StringValue[i+4]='n') and (StringValue[i+5]='i') and (StringValue[i+6]='t') and (StringValue[i+7]='y')) then begin
  if Negative then begin
   ResultCasted^.Hi:=$fff00000;
   ResultCasted^.Lo:=$00000000;
  end else begin
   ResultCasted^.Hi:=$7ff00000;
   ResultCasted^.Lo:=$00000000;
  end;
 end else if ((i+2)<=length(StringValue)) and ((StringValue[i]='N') and (StringValue[i+1]='a') and (StringValue[i+2]='N')) then begin
  ResultCasted^.Hi:=$7ff80000;
  ResultCasted^.Lo:=$00000000;
 end else begin
  New(MantissaMultiplicator);
  New(Mantissa);
  New(Temp);
  New(Digits);
  try
   FillChar(Digits^,sizeof(TDigits),#0);

   p:=0;
   TenPower:=0;
   HasDigits:=false;
   Started:=false;
   ExponentNegative:=false;
   Exponent:=0;
   while i<=length(StringValue) do begin
    case word(widechar(StringValue[i])) of
     ord('0'):begin
      HasDigits:=true;
      inc(i);
     end;
     else begin
      break;
     end;
    end;
   end;
   while i<=length(StringValue) do begin
    case word(widechar(StringValue[i])) of
     ord('0')..ord('9'):begin
      HasDigits:=true;
      Started:=true;
      if p<=high(TDigits) then begin
       Digits^[p]:=word(widechar(StringValue[i]))-ord('0');
       inc(p);
      end;
      inc(TenPower);
      inc(i);
     end;
     else begin
      break;
     end;
    end;
   end;
   if (i<=length(StringValue)) and (StringValue[i]='.') then begin
    inc(i);
    if not Started then begin
     while i<=length(StringValue) do begin
      case word(widechar(StringValue[i])) of
       ord('0'):begin
        HasDigits:=true;
        dec(TenPower);
        inc(i);
       end;
       else begin
        break;
       end;
      end;
     end;
    end;
    while i<=length(StringValue) do begin
     case word(widechar(StringValue[i])) of
      ord('0')..ord('9'):begin
       HasDigits:=true;
       if p<=high(TDigits) then begin
        Digits^[p]:=word(widechar(StringValue[i]))-ord('0');
        inc(p);
       end;
       inc(i);
      end;
      else begin
       break;
      end;
     end;
    end;
   end;
   if HasDigits then begin
    if (i<=length(StringValue)) and ((StringValue[i]='e') or (StringValue[i]='E')) then begin
     inc(i);
     if (i<=length(StringValue)) and ((StringValue[i]='+') or (StringValue[i]='-')) then begin
      ExponentNegative:=StringValue[i]='-';
      inc(i);
     end;
     HasDigits:=false;
     while i<=length(StringValue) do begin
      case word(widechar(StringValue[i])) of
       ord('0')..ord('9'):begin
        Exponent:=(Exponent*10)+integer(word(widechar(StringValue[i]))-ord('0'));
        HasDigits:=true;
        inc(i);
       end;
       else begin
        break;
       end;
      end;
     end;
    end;
    if HasDigits then begin
     if ExponentNegative then begin
      dec(TenPower,Exponent);
     end else begin
      inc(TenPower,Exponent);
     end;

     FillChar(Mantissa^,sizeof(TWords),#0);

     Bit:=WordTopBit;
     q:=0;
     Started:=false;
     TwoPower:=0;
     MantissaPosition:=0;
     while MantissaPosition<MantissaWords do begin
      Carry:=0;
      while (p>q) and (Digits^[p-1]=0) do begin
       dec(p);
      end;
      if p<=q then begin
       break;
      end;
      r:=p;
      while r>q do begin
       dec(r);
       i:=(2*Digits^[r])+Carry;
       if i>=10 then begin
        dec(i,10);
        Carry:=1;
       end else begin
        Carry:=0;
       end;
       Digits^[r]:=i;
      end;
      if Carry<>0 then begin
       Mantissa^[MantissaPosition]:=Mantissa^[MantissaPosition] or Bit;
       Started:=true;
      end;
      if Started then begin
       if Bit=1 then begin
        Bit:=WordTopBit;
        inc(MantissaPosition);
       end else begin
        Bit:=Bit shr 1;
       end;
      end else begin
       dec(TwoPower);
      end;
     end;
     inc(TwoPower,TenPower);

     if TenPower<0 then begin
      for i:=0 to high(TWords)-1 do begin
       MantissaMultiplicator^[i]:=$cccc;
      end;
      MantissaMultiplicator^[high(TWords)]:=$cccd;
      ExtraTwos:=-2;
      TenPower:=-TenPower;
     end else if TenPower>0 then begin
      MantissaMultiplicator^[0]:=$a000;
      for i:=1 to high(TWords) do begin
       MantissaMultiplicator^[i]:=$0000;
      end;
      ExtraTwos:=3;
     end else begin
      ExtraTwos:=0;
     end;
     while TenPower<>0 do begin
      if (TenPower and 1)<>0 then begin
       inc(TwoPower,ExtraTwos+MantissaMultiply(Mantissa,MantissaMultiplicator));
      end;
      inc(ExtraTwos,ExtraTwos+MantissaMultiply(MantissaMultiplicator,MantissaMultiplicator));
      TenPower:=TenPower shr 1;
     end;

     Exponent:=TwoPower;
     if (Mantissa^[0] and WordTopBit)<>0 then begin
      dec(Exponent);

      if (Exponent>=(2-IEEEFormatExpMax)) and (Exponent<=IEEEFormatExpMax) then begin
       inc(Exponent,IEEEFormatExpMax-1);
       MantissaShiftRight(Mantissa^,IEEEFormatExponent+IEEEFormatExplicit);
       MantissaRound(Negative,Mantissa^,IEEEFormatBits);
       if MantissaTestBit(Mantissa^,IEEEFormatExponent+IEEEFormatExplicit-1) then begin
        MantissaShiftRight(Mantissa^,1);
        inc(Exponent);
       end;
       if Exponent>=(IEEEFormatExpMax shl 1)-1 then begin
        ResultCasted^.Hi:=$7ff00000;
        ResultCasted^.Lo:=$00000000;
       end else begin
        ResultCasted^.Hi:=(((Exponent shl 4) or (Mantissa^[0] and $f)) shl 16) or Mantissa^[1];
        ResultCasted^.Lo:=(Mantissa^[2] shl 16) or Mantissa^[3];
       end;
      end else if Exponent>0 then begin
       ResultCasted^.Hi:=$7ff00000;
       ResultCasted^.Lo:=$00000000;
      end else begin
       Shift:=IEEEFormatExplicit-(Exponent+(IEEEFormatExpMax-(2+IEEEFormatExponent)));
       MantissaShiftRight(Mantissa^,Shift);
       MantissaRound(Negative,Mantissa^,IEEEFormatBits);
       if (Mantissa^[IEEEFormatOnePos] and IEEEFormatOneMask)<>0 then begin
        Exponent:=1;
        if IEEEFormatExplicit=0 then begin
         Mantissa^[IEEEFormatOnePos]:=Mantissa^[IEEEFormatOnePos] and not IEEEFormatOneMask;
        end;
        Mantissa^[0]:=Mantissa^[0] or (Exponent shl (WordBitMask-IEEEFormatExponent));
        ResultCasted^.Hi:=(((Exponent shl 4) or (Mantissa^[0] and $f)) shl 16) or Mantissa^[1];
        ResultCasted^.Lo:=(Mantissa^[2] shl 16) or Mantissa^[3];
       end else begin
        if MantissaIsZero(Mantissa^) then begin
         ResultCasted^.Hi:=$00000000;
         ResultCasted^.Lo:=$00000000;
        end else begin
         ResultCasted^.Hi:=(Mantissa^[0] shl 16) or Mantissa^[1];
         ResultCasted^.Lo:=(Mantissa^[2] shl 16) or Mantissa^[3];
        end;
       end;
      end;
      if Negative then begin
       ResultCasted^.Hi:=ResultCasted^.Hi or $80000000;
      end;
     end else begin
      ResultCasted^.Hi:=$00000000;
      ResultCasted^.Lo:=$00000000;
     end;
    end;
   end;
  finally
   Dispose(MantissaMultiplicator);
   Dispose(Mantissa);
   Dispose(Temp);
   Dispose(Digits);
  end;
 end;
end;

end.
 