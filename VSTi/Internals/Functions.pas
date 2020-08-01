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
unit Functions;

interface

{function FEXP(S:single):single; assembler; pascal;
function FPOWER(Number,Exponent:single):single; assembler; stdcall;
function FTRUNC(X:single):integer; pascal;
function FMOD(A,B:single):single; assembler; pascal;
function FFRAC(X:single):single; pascal;
function FSIN(Angle:single):single;
function FCOS(Angle:single):single;}
function WhiteNoiseRandom:single;
{$IFDEF CPU386}
function Clip(Value,Min,Max:single):single; assembler; pascal;
{$ELSE}
function Clip(Value,Min,Max:single):single;
{$ENDIF}
function GenOsc(WaveForm:integer;Phase:single):single;
function ConvertByteToExpValue(Value:byte;BaseShift:integer):integer;
function ConvertEnvelopeTimeToSamples(EnvTime:byte;SampleRate:single):integer;
function ConvertVibratoRate(Rate:byte):single;
function ConvertVibratoDepth(Depth:byte):single;
function ConvertVibratoDelay(Delay:byte;SampleRate:single):single;
procedure FastFillChar(var Dest;Count:integer;Value:char);
function AreBytesEqual(const A,B;Count:integer):boolean;

implementation

{function FEXP(S:single):single; assembler; pascal;
asm
 FLD dword PTR S
 FLDL2E
 FMULP ST(1),ST

 FLD1
 FLD ST(1)
 FPREM
 F2XM1
 FADDP ST(1),ST
 FSCALE

 FSTP ST(1)
 FSTP dword PTR result
end;

function FPOWER(Number,Exponent:single):single; assembler; stdcall;
asm
 FLD Exponent
 FLD Number
 FYL2X
 FLD1
 FLD ST(1)
 FPREM
 F2XM1
 FADDP ST(1),ST
 FSCALE
 FSTP ST(1)
end;

function FTRUNC(X:single):integer; pascal;
const Half:double=0.5-(1.0e-16);
begin
 asm
  FLD dword PTR X
  FSUB QWORD PTR Half
  FISTP dword PTR result
 end;
end;

function FMOD(A,B:single):single; assembler; pascal;
asm
 FLD dword PTR B
 FLD dword PTR A
 FPREM
 FSTP ST(1)
 FSTP dword PTR result
end;

function FFRAC(X:single):single; pascal;
begin
 result:=FMOD(X,1);
end;

function FSIN(Angle:single):single;
var AngleSquare:single;
begin
 AngleSquare:=Angle*Angle;
 result:=(((((7.61e-03)*AngleSquare)-1.6605e-01)*AngleSquare)+1)*Angle;
end;

function FCOS(Angle:single):single;
var AngleSquare:single;
begin
 AngleSquare:=Angle*Angle;
 result:=(((((3.705e-02)*AngleSquare)-4.967e-01)*AngleSquare)+1)*Angle;
end;}

const WhiteNoiseSeed:longword=$12345678;
function WhiteNoiseRandom:single;
var WhiteNoiseValue:longword;
begin
 WhiteNoiseSeed:=(WhiteNoiseSeed*$524281)+$3133731;
 WhiteNoiseValue:=(WhiteNoiseSeed and $7fffff) or $40000000;
 result:=single(pointer(@WhiteNoiseValue)^)-3;
end;

{$IFDEF CPU386}
function Clip(Value,Min,Max:single):single; assembler; pascal;
const Constant0Dot5:single=0.5;
asm
 FLD dword PTR Value
 FLD dword PTR Min
 FLD dword PTR Max

 // Temp1:=ABS(Value-Min);
 FLD ST(2)
 FSUBR ST(0),ST(1)
 FABS

 // Temp2:=ABS(Value-Max);
 FLD ST(3)
 FSUBR ST(0),ST(3)
 FABS

 // RESULT:=((Temp1+(Min+Max))-Temp2)*0.5;
 FADD ST(0),ST(3)
 FADD ST(0),ST(2)
 FSUB ST(0),ST(1)
 FMUL dword PTR Constant0Dot5

 FFREE ST(4)
 FFREE ST(3)
 FFREE ST(2)
 FFREE ST(1)
end;
{$ELSE}
function Clip(Value,Min,Max:single):single;
var Temp1,Temp2:single;
begin
 Temp1:=ABS(Value-Min);
 Temp2:=ABS(Value-Max);
 result:=((Temp1+(Min+Max))-Temp2)*0.5;
end;
{$ENDIF}

function GenOsc(WaveForm:integer;Phase:single):single;
var PhaseCasted:longword absolute Phase;
begin
 case WaveForm of
  0:result:=SIN(Phase*2*PI); // Sinus
  1:result:=ABS((Phase-0.5)*4)-1; // Triangle
  2:begin // Square
   Phase:=Phase-0.5;
   result:=longword((PhaseCasted shr 31) shl 1);
   result:=1-result;
  end;
  3,4:result:=((Phase-0.5)*2)*integer(1-((WaveForm-3)*2)); // Sawtooth Up/Down
  5:result:=WhiteNoiseRandom; // White Noise
  else result:=0; // Nothing ;-)
 end;
end;

function ConvertByteToExpValue(Value:byte;BaseShift:integer):integer;
var Shift:integer;
begin
 Shift:=((Value shr 4){ AND $F})+BaseShift;
 result:=((Value and $f) shl Shift)+(($10 shl Shift)-($10 shl BaseShift));
end;

function ConvertEnvelopeTimeToSamples(EnvTime:byte;SampleRate:single):integer;
begin
 result:=TRUNC(ConvertByteToExpValue(EnvTime,1)*SampleRate/1000);
end;

function ConvertVibratoRate(Rate:byte):single;
begin
 result:=((Rate/127)*9.8)+0.2;
end;

function ConvertVibratoDepth(Depth:byte):single;
begin
 result:=Depth/127;
end;

function ConvertVibratoDelay(Delay:byte;SampleRate:single):single;
var MS:double;
begin
 if Delay=0 then begin
  MS:=0;
 end else begin
  MS:=0.2092*EXP(0.0792*Delay);
 end;
 result:=SampleRate*MS*0.001;
end;

type pinteger=^integer;
     PIntegerArray=^TIntegerArray;
     TIntegerArray=array[0..($7fffffff div sizeof(integer))-1] of integer;

     pbyte=^byte;
     PByteArray=^TByteArray;
     TByteArray=array[0..($7fffffff div sizeof(byte))-1] of byte;

procedure FastFillChar(var Dest;Count:integer;Value:char);
label P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12;
var I,J,K:integer;
    P:pointer;
begin
 if Count>0 then begin
  P:=@Dest;
  if Count>=12 then begin
   J:=byte(Value);
   J:=J or (J shl 8);
   J:=J or (J shl 16);
   pinteger(P)^:=J;
   pinteger(integer(P)+Count-4)^:=J;
   I:=Count shr 2;
   if Count>=256 then begin
    if Count<448 then begin
     PIntegerArray(P)[1]:=J;
     PIntegerArray(P)[2]:=J;
     PIntegerArray(P)[3]:=J;
     repeat
      dec(I,4);
      PIntegerArray(P)[I]:=J;
      PIntegerArray(P)[I+1]:=J;
      PIntegerArray(P)[I+2]:=J;
      PIntegerArray(P)[I+3]:=J;
     until I<4;
    end else begin
     I:=Count;
     K:=(integer(P) and 3)-4;
     dec(I,16);
     dec(pbyte(P),K);
     inc(I,K);
     inc(pbyte(P),I);
     PIntegerArray(P)[0] := J;
     PIntegerArray(P)[1] := J;
     PIntegerArray(P)[2] := J;
     PIntegerArray(P)[3] := J;
     repeat
      PIntegerArray(integer(P)-I)[0]:=J;
      PIntegerArray(integer(P)-I)[1]:=J;
      PIntegerArray(integer(P)-I)[2]:=J;
      PIntegerArray(integer(P)-I)[3]:=J;
      dec(I,16);
     until I<=0;
    end;
   end else begin
    repeat
     dec(I,2);
     PIntegerArray(P)[I]:=J;
     PIntegerArray(P)[I+1]:=J;
    until I<2;
   end;
  end else begin
   case Count of
    1:goto P01;
    2:goto P02;
    3:goto P03;
    4:goto P04;
    5:goto P05;
    6:goto P06;
    7:goto P07;
    8:goto P08;
    9:goto P09;
    10:goto P10;
    11:goto P11;
    12:goto P12;
   end;
   P12:PByteArray(P)[11]:=byte(Value);
   P11:PByteArray(P)[10]:=byte(Value);
   P10:PByteArray(P)[09]:=byte(Value);
   P09:PByteArray(P)[08]:=byte(Value);
   P08:PByteArray(P)[07]:=byte(Value);
   P07:PByteArray(P)[06]:=byte(Value);
   P06:PByteArray(P)[05]:=byte(Value);
   P05:PByteArray(P)[04]:=byte(Value);
   P04:PByteArray(P)[03]:=byte(Value);
   P03:PByteArray(P)[02]:=byte(Value);
   P02:PByteArray(P)[01]:=byte(Value);
   P01:PByteArray(P)[00]:=byte(Value);
  end;
 end;
end;

function AreBytesEqual(const A,B;Count:integer):boolean;
var FirstComparePointer,SecondComparePointer:pbyte;
    Counter:integer;
begin
 try
  result:=true;
  FirstComparePointer:=@A;
  SecondComparePointer:=@B;
  for Counter:=1 to Count do begin
   if FirstComparePointer^<>SecondComparePointer^ then begin
    result:=false;
    exit;
   end;
   inc(FirstComparePointer);
   inc(SecondComparePointer);
  end;
 except
  result:=false;
 end;
end;

end.
