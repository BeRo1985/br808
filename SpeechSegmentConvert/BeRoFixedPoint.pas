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
unit BeRoFixedPoint;
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
{$IFDEF CPU32}
 {$IFDEF CPU386}
  {$DEFINE USE64BIT}
 {$ENDIF}
{$ENDIF}

interface

type TFixedPoint=integer;

{$IFDEF CPU386}
     FixedPointFloat=extended;
{$ELSE}
     FixedPointFloat=single;
{$ENDIF}

function FixedPointToFloatingPoint(Value:TFixedPoint):FixedPointFloat; register;
function FloatingPointToFixedPoint(Value:FixedPointFloat):TFixedPoint register;
function FloatingPoint(Value:TFixedPoint):FixedPointFloat; register;
function FixedPoint(Value:FixedPointFloat):TFixedPoint; register; overload;
function FixedPoint(Value:integer):TFixedPoint; register; overload;
function FixedPointNEG(Value:TFixedPoint):TFixedPoint; register;
function FixedPointADD(A,B:TFixedPoint):TFixedPoint; register;
function FixedPointSUB(A,B:TFixedPoint):TFixedPoint; register;
function FixedPointMUL(A,B:TFixedPoint):TFixedPoint; register;
function FixedPointDIV(A,B:TFixedPoint):TFixedPoint; register;
function FixedPointFRAC(Value:TFixedPoint):TFixedPoint; register;
function FixedPointSQRT(Value:TFixedPoint):TFixedPoint; register;
function FixedPointSQR(Value:TFixedPoint):TFixedPoint; register;
function FixedPointSQRTFast(Value:TFixedPoint):TFixedPoint; register;
function FixedPointABS(Value:TFixedPoint):TFixedPoint; register;
function FixedPointSIN(Value:TFixedPoint):TFixedPoint; register;
function FixedPointCOS(Value:TFixedPoint):TFixedPoint; register;
function FixedPointTAN(Value:TFixedPoint):TFixedPoint; register;
function FixedPointTRUNC(Value:TFixedPoint):TFixedPoint; register;
function FixedPointROUND(Value:TFixedPoint):TFixedPoint; register;
function FixedPointFLOOR(Value:TFixedPoint):TFixedPoint; register;
function FixedPointCEIL(Value:TFixedPoint):TFixedPoint; register;

implementation

type TSinCos=array[0..$fff] of TFixedPoint;

var Sine,Cosine:TSinCos;

function FixedPointToFloatingPoint(Value:TFixedPoint):FixedPointFloat; register;
begin
 result:=Value/(1 shl 16);
end;

function FloatingPointToFixedPoint(Value:FixedPointFloat):TFixedPoint register;
begin
 result:=ROUND(Value*(1 shl 16));
end;

function FloatingPoint(Value:TFixedPoint):FixedPointFloat; register;
begin
 result:=Value/(1 shl 16);
end;

function FixedPoint(Value:FixedPointFloat):TFixedPoint; register; overload;
begin
 result:=ROUND(Value*(1 shl 16));
end;

{$IFDEF CPU386}
function FixedPoint(Value:integer):TFixedPoint; assembler; register; overload;
asm
 SAL EAX,16
end;

function FixedPointNEG(Value:TFixedPoint):TFixedPoint; assembler; register;
asm
 NEG EAX
end;

function FixedPointADD(A,B:TFixedPoint):TFixedPoint; assembler; register;
asm
 ADD EAX,EDX
end;

function FixedPointSUB(A,B:TFixedPoint):TFixedPoint; assembler; register;
asm
 SUB EAX,EDX
end;

function FixedPointMUL(A,B:TFixedPoint):TFixedPoint; assembler; register;
asm
{$IFDEF USE64BIT}
 IMUL EDX
 SHRD EAX,EDX,16
{$ELSE}
 SAR EAX,6
 SAR EDX,6
 IMUL EDX
 SAR EAX,4
{$ENDIF}
end;

function FixedPointDIV(A,B:TFixedPoint):TFixedPoint; assembler; register;
asm
 XCHG ECX,EDX
 xor EDX,EDX
{$IFDEF USE64BIT}
 SHLD EDX,EAX,16
 SAL EAX,16
 IDIV ECX
{$ELSE}
 SAL EAX,6
 SAR ECX,6
 IDIV ECX
 SAL EAX,4
{$ENDIF}
end;

function FixedPointFRAC(Value:TFixedPoint):TFixedPoint; assembler; register;
asm
 TEST EAX,EAX
 JL @NegIt
 and EAX,$ffff
 JMP @Done
 @NegIt:
 NEG EAX
 and EAX,$ffff
 NEG EAX
 @Done:
end;

function FixedPointTRUNC(Value:TFixedPoint):TFixedPoint; assembler; register;
asm
 TEST EAX,EAX
 JNL @Positive
 TEST AX,AX
 JZ @FracIsNull
  SAR EAX,16
  inc EAX
  JMP @Done
 @FracIsNull:
 @Positive:
 SAR EAX,16
 @Done:
end;

function FixedPointROUND(Value:TFixedPoint):TFixedPoint; assembler; register;
asm
 ADD EAX,$8000
 SAR EAX,16
end;

function FixedPointSQRT(Value:TFixedPoint):TFixedPoint; assembler; register;
asm
 PUSH EBX
 PUSH ESI
 PUSH EDI
 PUSH EBP
 MOV EDI,EAX
 MOV EBX,EDI
 SAR EBX,2     
 CMP EDI,$10000
 JZ @Done
 xor EBP,EBP
 MOV dword PTR [ESP],EBP
@Loop:
 CMP EBX,EBP
 JZ @LoopDone
 MOV EBP,dword PTR [ESP]
 MOV dword PTR [ESP],EBX
 MOV ESI,EBX
 MOV ECX,EBX
 MOV EAX,EDI
 xor EDX,EDX
{$IFDEF USE64BIT}
 SHLD EDX,EAX,16
 SAL EAX,16
 IDIV ECX
{$ELSE}
 SAL EAX,6
 SAR ECX,6
 IDIV ECX
 SAL EAX,4
{$ENDIF}
 ADD EBX,EAX
 SAR EBX,1
 CMP EBX,ESI
 JNZ @Loop
@LoopDone:
 MOV EAX,ESI
@Done:
 POP EBP
 POP EDI
 POP ESI
 POP EBX
end;
{$ELSE}
function FixedPoint(Value:integer):TFixedPoint; register; overload;
begin
 result:=Value*(1 shl 16);
end;

function FixedPointNEG(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=-Value;
end;

function FixedPointADD(A,B:TFixedPoint):TFixedPoint; register;
begin
 result:=A+B;
end;

function FixedPointSUB(A,B:TFixedPoint):TFixedPoint; register;
begin
 result:=A-B;
end;

function FixedPointMUL(A,B:TFixedPoint):TFixedPoint; register;
begin
 result:=((A div (1 shl 6))*(B div (1 shl 6))) div (1 shl 4);
end;

function FixedPointDIV(A,B:TFixedPoint):TFixedPoint; register;
begin
 result:=((A*(1 shl 6)) div (B div (1 shl 6)))*(1 shl 4);
end;

function FixedPointFRAC(Value:TFixedPoint):TFixedPoint; register;
begin
 if Value<0 then begin
  result:=-((-Value) and $ffff);
 end else begin
  result:=Value and $ffff;
 end;
end;

function FixedPointTRUNC(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=Value div (1 shl 16);
end;

function FixedPointROUND(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=Value div (1 shl 16);
 if Value<0 then begin
  if (Value and $ffff)<$8000 then dec(result);
 end else begin
  if (Value and $ffff)>=$8000 then inc(result);
 end;
end;

function FixedPointSQRT(Value:TFixedPoint):TFixedPoint; register;
var Next,Last,PreviousLast:TFixedPoint;
begin
 result:=Value;
 if Value<>$10000 then begin
  Next:=Value div 4;
  Last:=0;
  PreviousLast:=0;
  while (result<>Next) and (Next<>PreviousLast) do begin PreviousLast:=Last;
   Last:=Next;
   result:=Next;
   Next:=(Next+FixedPointDIV(Value,Next)) div 2;
  end;
 end;
end;
{$ENDIF}

function FixedPointSQR(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=FixedPointMUL(Value,Value);
end;

procedure FixedPointSQRTFastStep(var Value,Root:TFixedPoint;Shift:integer); register;
var ShiftedValue:integer;
begin
 ShiftedValue:=$40000000 shr Shift;
 if (ShiftedValue+Root)<=Value then begin
  dec(Value,ShiftedValue+Root);
  Root:=(Root div 2) or ShiftedValue;
 end else begin
  Root:=Root div 2;
 end;
end;

function FixedPointSQRTFast(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=0;
 FixedPointSQRTFastStep(Value,result,0);
 FixedPointSQRTFastStep(Value,result,2);
 FixedPointSQRTFastStep(Value,result,4);
 FixedPointSQRTFastStep(Value,result,6);
 FixedPointSQRTFastStep(Value,result,8);
 FixedPointSQRTFastStep(Value,result,10);
 FixedPointSQRTFastStep(Value,result,12);
 FixedPointSQRTFastStep(Value,result,14);
 FixedPointSQRTFastStep(Value,result,16);
 FixedPointSQRTFastStep(Value,result,18);
 FixedPointSQRTFastStep(Value,result,20);
 FixedPointSQRTFastStep(Value,result,22);
 FixedPointSQRTFastStep(Value,result,24);
 FixedPointSQRTFastStep(Value,result,26);
 FixedPointSQRTFastStep(Value,result,28);
 FixedPointSQRTFastStep(Value,result,30);
 if result<Value then inc(result);
 result:=result*256;
end;

function FixedPointABS(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=Value;
 if result<0 then result:=-result;
end;

procedure FixedPointInitSinCos;
var Counter:integer;
begin
 for Counter:=0 to $fff do begin
  Sine[Counter]:=FixedPoint(SIN(Counter*2*PI/$1000));
  Cosine[Counter]:=FixedPoint(COS(Counter*2*PI/$1000));
 end;
end;

function FixedPointSIN(Value:TFixedPoint):TFixedPoint; register;
var index:TFixedPoint;
begin
 index:=FixedPointDIV(FixedPointMUL(ABS(Value),$fff),$0006487e);
 if Value<0 then index:=$1000-index;
 result:=Sine[index and $fff];
end;

function FixedPointCOS(Value:TFixedPoint):TFixedPoint; register;
var index:TFixedPoint;
begin
 index:=FixedPointDIV(FixedPointMUL(ABS(Value),$fff),$0006487e);
 if Value<0 then index:=$1000-index;
 result:=Cosine[index and $fff];
end;

function FixedPointTAN(Value:TFixedPoint):TFixedPoint; register;
begin
 result:=FixedPointCOS(Value);
 if result<>0 then begin
  result:=FixedPointDIV(FixedPointSIN(Value),result);
 end;
end;

function FixedPointFLOOR(Value:TFixedPoint):TFixedPoint; register;
begin
 if (Value and $ffff)<>0 then begin
  result:=Value and $ffff0000;
 end else begin
  result:=Value;
 end;
end;

function FixedPointCEIL(Value:TFixedPoint):TFixedPoint; register;
begin
 if (Value and $ffff)<>0 then begin
  result:=(Value and $ffff0000)+$10000;
 end else begin
  result:=Value;
 end;
end;

initialization
 FixedPointInitSinCos;
finalization
end.


