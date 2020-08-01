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
unit BeRoPascalScript;
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
 {$ifdef FPC_LITTLE_ENDIAN}
  {$define LITTLE_ENDIAN}
 {$else}
  {$ifdef FPC_BIG_ENDIAN}
   {$define BIG_ENDIAN}
  {$endif}
 {$endif}
 {$pic off}
 {$define caninline}
 {$ifdef FPC_HAS_TYPE_EXTENDED}
  {$define HAS_TYPE_EXTENDED}
 {$else}
  {$undef HAS_TYPE_EXTENDED}
 {$endif}
 {$ifdef FPC_HAS_TYPE_DOUBLE}
  {$define HAS_TYPE_DOUBLE}
 {$else}
  {$undef HAS_TYPE_DOUBLE}
 {$endif}
 {$ifdef FPC_HAS_TYPE_SINGLE}
  {$define HAS_TYPE_SINGLE}
 {$else}
  {$undef HAS_TYPE_SINGLE}
 {$endif}
{$else}
 {$realcompatibility off}
 {$localsymbols on}
 {$define LITTLE_ENDIAN}
 {$ifndef cpu64}
  {$define cpu32}
 {$endif}
 {$define HAS_TYPE_EXTENDED}
 {$define HAS_TYPE_DOUBLE}
 {$define HAS_TYPE_SINGLE}
{$endif}
{$ifdef win32}
 {$define windows}
{$endif}
{$ifdef win64}
 {$define windows}
{$endif}
{$ifdef wince}
 {$define windows}
{$endif}
{$rangechecks off}
{$extendedsyntax on}
{$writeableconst on}
{$hints off}
{$booleval off}
{$typedaddress off}
{$stackframes off}
{$varstringchecks on}
{$typeinfo on}
{$overflowchecks off}
{$longstrings on}
{$openstrings on}

interface

uses SysUtils,Math;

const OPNone=-1;
      OPAdd=0;
      OPSub=1;
      OPNeg=2;
      OPMul=3;
      OPDiv=4;
      OPMod=5;
      OPDiv2=6;
      OPMod2=7;
      OPEql=8;
      OPNEq=9;
      OPLss=10;
      OPLeq=11;
      OPGtr=12;
      OPGEq=13;
      OPDupl=14;
      OPSwap=15;
      OPAndB=16;
      OPOrB=17;
      OPXorB=18;
      OPAnd=19;
      OPOr=20;
      OPXor=21;
      OPLoad=22;
      OPStore=23;
      OPHalt=24;
      OPWrI=25;
      OPWrF=26;
      OPWrC=27;
      OPWrB=28;
      OPWrL=29;
      OPRdI=30;
      OPRdF=31;
      OPRdC=32;
      OPRdB=33;
      OPRdL=34;
      OPEOF=35;
      OPEOL=36;
      OPMulF=37;
      OPDivF=38;
      OPAddF=39;
      OPSubF=40;
      OPNegF=41;
      OPEqlF=42;
      OPNEqF=43;
      OPLssF=44;
      OPLeqF=45;
      OPGtrF=46;
      OPGEqF=47;
      OPTRUNC=48;
      OPROUND=49;
      OPABS=50;
      OPABSF=51;
      OPSQR=52;
      OPSQRF=53;
      OPSQRTF=54;
      OPSINF=55;
      OPCOSF=56;
      OPEXPF=57;
      OPLNF=58;
      OPFRACF=59;
      OPODD=60;
      OPTANF=61;
      OPISNANF=62;
      OPISINFF=63;
      OPCEILF=64;
      OPFLOORF=65;
      OPARCTANF=66;
      OPARCTAN2F=67;
      OPARCSINF=68;
      OPARCCOSF=69;
      OPHYPOTF=70;
      OPLOG2F=71;
      OPLOG10F=72;
      OPLOGNF=73;
      OPCOSHF=74;
      OPSINHF=75;
      OPTANHF=76;
      OPARCCOSHF=77;
      OPARCSINHF=78;
      OPARCTANHF=79;
      OPPOWERF=80;
      OPCOTANHF=81;
      OPSECANTHF=82;
      OPCOSECANTHF=83;
      OPARCCOTANF=84;
      OPARCSECANTF=85;
      OPARCCOSECANTF=86;
      OPARCCOTANHF=87;
      OPARCSECANTHF=88;
      OPARCCOSECANTHF=89;
      OPRANDOMF=90;
      OPRANDOM=91;
      OPRANDOMIZE=92;
      OPSHL=93;
      OPSHR=94;
      OPSAR=95;
      OPSETSAMPLELENGTH=96;
      OPSETSAMPLECHANNELS=97;
      OPSETSAMPLERATE=98;
      OPSETSAMPLE=99;
      OPNot=100;
      OPLdC=200;
      OPLdA=201;
      OPLdLA=202;
      OPLdL=203;
      OPLdG=204;
      OPStL=205;
      OPStG=206;
      OPMove=207;
      OPCopy=208;
      OPAddC=209;
      OPMulC=210;
      OPJmp=211;
      OPJZ=212;
      OPCall=213;
      OPAdjS=214;
      OPLeave=215;
      OPINTTOFLOAT=216;

      TokIdent=0;
      TokNumber=1;
      TokFloatNumber=2;
      TokStrC=3;
      TokPlus=4;
      TokMinus=5;
      TokMul=6;
      TokLBracket=7;
      TokRBracket=8;
      TokColon=9;
      TokDots=10;
      TokEql=11;
      TokNEq=12;
      TokLss=13;
      TokLEq=14;
      TokGtr=15;
      TokGEq=16;
      TokLParent=17;
      TokRParent=18;
      TokComma=19;
      TokSemi=20;
      TokPeriod=21;
      TokAssign=22;
      TokDivFloat=23;
      SymBEGIN=50;
      SymEND=51;
      SymIF=52;
      SymTHEN=53;
      SymELSE=54;
      SymWHILE=55;
      SymDO=56;
      SymCASE=57;
      SymREPEAT=58;
      SymUNTIL=59;
      SymFOR=60;
      SymTO=61;
      SymDOWNTO=62;
      SymNOT=63;
      SymDIV=64;
      SymMOD=65;
      SymAND=66;
      SymOR=67;
      SymXOR=68;
      SymCONST=69;
      SymVAR=70;
      SymTYPE=71;
      SymARRAY=72;
      SymOF=73;
      SymPACKED=74;
      SymRECORD=75;
      SymPROGRAM=76;
      SymFORWARD=77;
      SymHALT=78;
      SymFUNC=79;
      SymPROC=80;
      SymBREAK=81;
      SymCONTINUE=82;
      SymRESULT=83;
      SymABSOLUTE=84;
      SymEXIT=85;
      SymSHL=86;
      SymSHR=87;
      SymLAST=SymSHR;

      IdCONST=0;
      IdVAR=1;
      IdFIELD=2;
      IdTYPE=3;
      IdFUNC=4;

      KindSIMPLE=0;
      KindARRAY=1;
      KindRECORD=2;

      TypeINT=1;
      TypeBOOL=2;
      TypeCHAR=3;
      TypeFLOAT=4;
      TypeSTR=5;

      FunctionCHR=0;
      FunctionORD=1;
      FunctionWRITE=2;
      FunctionWRITELN=3;
      FunctionREAD=4;
      FunctionREADLN=5;
      FunctionEOF=6;
      FunctionEOFLN=7;
      FunctionDEC=8;
      FunctionINC=9;
      FunctionTRUNC=10;
      FunctionROUND=11;
      FunctionABS=12;
      FunctionSQR=13;
      FunctionSQRT=14;
      FunctionSIN=15;
      FunctionCOS=16;
      FunctionEXP=17;
      FunctionLN=18;
      FunctionFRAC=19;
      FunctionODD=20;
      FunctionSUCC=21;
      FunctionPRED=22;
      FunctionTAN=23;
      FunctionISNAN=24;
      FunctionISINF=25;
      FunctionCEIL=26;
      FunctionFLOOR=27;
      FunctionARCTAN=28;
      FunctionARCTAN2=29;
      FunctionARCSIN=30;
      FunctionARCCOS=31;
      FunctionHYPOT=32;
      FunctionLOG2=33;
      FunctionLOG10=34;
      FunctionLOGN=35;
      FunctionCOSH=36;
      FunctionSINH=37;
      FunctionTANH=38;
      FunctionARCCOSH=39;
      FunctionARCSINH=40;
      FunctionARCTANH=41;
      FunctionPOWER=42;
      FunctionCOTANH=43;
      FunctionSECANTH=44;
      FunctionCOSECANTH=45;
      FunctionARCCOTAN=46;
      FunctionARCSECANT=47;
      FunctionARCCOSECANT=48;
      FunctionARCCOTANH=49;
      FunctionARCSECANTH=50;
      FunctionARCCOSECANTH=51;
      FunctionRANDOM=52;
      FunctionRANDOMIZE=53;
      FunctionSARLONGINT=54;
      FunctionSETSAMPLELENGTH=55;
      FunctionSETSAMPLECHANNELS=56;
      FunctionSETSAMPLERATE=57;
      FunctionSETSAMPLE=58;

type TIdent=record
      name:ansistring;
      Link:longint;
      TypeDef:longint;
      Kind:longint;
      Value:longint;
      VLevel:longint;
      VAdr:longint;
      RefPar:boolean;
      Offset:longint;
      FLevel:longint;
      FAdr:longint;
      LastParameter:longint;
      ReturnAddress:longint;
      Inside:boolean;
     end;

     TType=record
      Size:longint;
      Kind:longint;
      StartIndex:longint;
      EndIndex:longint;
      SubType:longint;
      Fields:longint;
     end;

     TTermValue=record
      case ValueType:longint of
       TypeINT:(IntegerValue:longint);
       TypeBOOL:(BooleanValue:longbool);
       TypeCHAR:(CharValue:ansichar);
       TypeFLOAT:(FloatValue:single);
     end;

     PLoopStackItem=^TLoopStackItem;
     TLoopStackItem=record
      Breaks:array of longint;
      Continues:array of longint;
      BreakCount,ContinueCount:longint;
     end;

     TLoopStack=array of TLoopStackItem;

     TLexerState=record
      SourcePosition:longint;
      CurrentChar:ansichar;
      LinePosition:longint;
      LineNumber:longint;
      CurrentSymbol:longint;
      CurrentIdent:ansistring;
      CurrentNumber:longint;
      CurrentFloatNumber:single;
      CurrentString:string[255];
      CurrentStringLength:longint;
     end;

     TLexerStates=array of TLexerState;

     TBeRoPascalScript=class
      private
       FileName:ansistring;
       Source:ansistring;
       SourcePosition:longint;
       CurrentChar:ansichar;
       LinePosition:longint;
       LineNumber:longint;
       CurrentSymbol:longint;
       CurrentIdent:ansistring;
       CurrentNumber:longint;
       CurrentFloatNumber:single;
       CurrentString:string[255];
       CurrentStringLength:longint;
       LexerStates:TLexerStates;
       LexerStatePos:longint;
       FuncDecl:longint;
       CurrentFunctionIdent:longint;
       FuncStackPosition:longint;
       FuncEndJmp:longint;
       Keywords:array[SymBEGIN..SymLAST] of ansistring;
       LastOpcode:longint;
       CurrentLevel:longint;
       IsLabeled:boolean;
       SymNameList:array of longint;
       IdentPos:longint;
       TypePos:longint;
       IdentTab:array of TIdent;
       TypeTab:array of TType;
       Code:array of longint;
       CodePosition:longint;
       StackPosition:longint;
       MinimumStackPosition:longint;
       LoopStack:TLoopStack;
       LoopStackCount:longint;
       procedure Error(N:longint);
       procedure ReadChar;
       function ReadNumber:longint;
       procedure PushLexerState;
       procedure PopLexerState;
       procedure RestoreLexerState;
       procedure GetSymbol;
       procedure Check(s:longint);
       procedure Expect(s:longint);
       procedure EnterSymbol(CurrentIdent:ansistring;k,t:longint);
       function Position(RaiseError:boolean=true):longint;
       procedure GenOp(Opcode,a:longint);
       procedure GenOp2(Opcode:longint);
       function CodeLabel:longint;
       procedure GenAddress(Level,Address:longint);
       procedure GenAddressVar(IdentNr:longint);
       procedure MustBe(x,y:longint);
       procedure MustBeOrdinal(x:longint);
       procedure Selector(var t,IdentNr:longint);
       procedure VarPar(var t:longint);
       function InternalFunction(N:longint;var Optimizable:boolean):TTermValue;
       function FunctionCall(I:longint;var Optimizable:boolean):TTermValue;
       function Factor(var t:longint;var Optimizable:boolean):TTermValue;
       function Term(var x:longint;var Optimizable:boolean):TTermValue;
       function SimpleExpression(var x:longint;var Optimizable:boolean):TTermValue;
       function Expression(var x:longint;var Optimizable:boolean):TTermValue;
       procedure ResizeLoopStack;
       procedure AdjustLoop(BreakLabel,ContinueLabel:longint);
       procedure AddLoopBreak;
       procedure AddLoopContinue;
       procedure Statement;
       procedure Constant(var c,t:longint);
       procedure ConstDeclaration;
       procedure ArrayType(var t:longint);
       procedure TypeDef(var t:longint);
       procedure TypeDeclaration;
       procedure VarDeclaration;
       procedure NewParameter(var p,ps:longint);
       procedure FunctionDeclaration(IsFunction:boolean);
       procedure Block(l:longint);
      public
       Errors:longint;
       SampleLength:longint;
       SampleChannels:longint;
       SampleRate:longint;
       Sample:array of single;
       constructor Create;
       destructor Destroy; override;
       function Compile(ASource:ansistring):boolean;
       function CompileFile(ASourceFile:ansistring):boolean;
       procedure Run;
     end;

implementation

const vmEPSILON=1e-18;
      vmINF=1/0;
      vmNEGINF=-1/0;

      VMFCW:word=$27f;

{$ifndef fpc}
function SARLongint(Value,Shift:longint):longint;
{$ifdef cpu386}
{$ifdef fpc} assembler; inline;
asm
 mov ecx,edx
 sar eax,cl
end ['eax','edx','ecx'];
{$else} assembler; register;
asm
 mov ecx,edx
 sar eax,cl
end;
{$endif}
{$else}
{$ifdef cpuarm} assembler; inline;
asm
 mov r0,r0,asr R1
end ['r0','R1'];
{$else}
begin
 result:=(Value shr Shift) or (($ffffffff+(1-((Value and (1 shl 31)) shr 31) and ord(Shift<>0))) shl (32-Shift));
end;
{$endif}
{$endif}
{$endif}

function SoftTRUNC(FloatValue:single):longint;
type plongword=^longword;
const MaskMantissa=(1 shl 23)-1;
var Exponent,Mantissa,Sig,SigExtra,Signed,IsDenormalized:longword;
    value,Shift:longint;
begin
 Exponent:=(plongword(@FloatValue)^ and $7fffffff) shr 23;
 Mantissa:=plongword(@FloatValue)^ and MaskMantissa;
 Shift:=Exponent-$96;
 Sig:=Mantissa or $00800000;
 SigExtra:=Sig shl (Shift and 31);
 IsDenormalized:=0-ord(0<=Shift);
 Value:=(((-ord(Exponent>=$7e)) and (Sig shr (32-Shift))) and not IsDenormalized) or (SigExtra and IsDenormalized);
 Signed:=0-ord((plongword(@FloatValue)^ and $80000000)<>0);
 result:=(((0-Value) and Signed) or (Value and not Signed)) and (0-ord($9e>Exponent));
end;

function SoftROUND(FloatValue:single):longint;
begin
 result:=SoftTRUNC(FloatValue+0.5);
end;

function fmod(x,y:single):single; {$ifdef cpu386} assembler; stdcall;
asm
 fld dword ptr x
 fld dword ptr y
 fxch st(1)
 fprem
 fxch st(1)
 fstp st(0)
end;
{$else}
begin
 result:=x-(SoftTRUNC(x/y)*y);
end;
{$endif}

function frac(x:single):single; {$ifdef cpu386} assembler; stdcall;
asm
 fld dword ptr x
 fld1
 fxch st(1)
 fprem
 fxch st(1)
 fstp st(0)
end;
{$else}
begin
 result:=x-SoftTRUNC(x);
end;
{$endif}

function power(Number,Exponent:single):single; {$ifdef cpu386} assembler; stdcall;
asm
 fld Exponent
 fld Number
 fyl2x
 fld1
 fld st(1)
 fprem
 f2xm1
 faddp st(1),st
 fscale
 fstp st(1)
end;
{$else}
begin
 result:=exp(ln(Number)*Exponent);
end;
{$endif}

function tan(x:single):single; {$ifdef cpu386} assembler; stdcall;
asm
 fld dword ptr x
 fptan
 fstp st(0)
end;
{$else}
begin
 result:=sin(x)/cos(x);
end;
{$endif}

function cotan(x:single):single; {$ifdef cpu386} assembler; stdcall;
asm
 fld dword ptr x
 fptan
 fdivrp
 fstp st(0)
end;
{$else}
begin
 result:=cos(x)/sin(x);
end;
{$endif}

function SoftFLOOR(FloatValue:single):longint;
begin
 result:=SoftTRUNC(FloatValue);
 if frac(FloatValue)<0 then begin
  dec(result);
 end;

end;
function SoftCEIL(FloatValue:single):longint;
begin
 result:=SoftTRUNC(FloatValue);
 if frac(FloatValue)>0 then begin
  inc(result);
 end;
end;

{function arctan(const x:single):single; assembler; stdcall;
asm
 fld dword ptr x
 fld1
 fpatan
end;

function arctan2(const x,y:single):single; assembler; stdcall;
asm
 fld dword ptr y
 fld dword ptr x
 fpatan
end;}

function arcsin(const x:single):single;
begin
 result:=arctan2(x,sqrt(1-sqr(x)));
end;

function arccos(const x:single):single;
begin
 result:=arctan2(sqrt(1-sqr(x)),x);
end;

function hypot(x,y:single):single;
var t:single;
begin
 x:=abs(x);
 Y:=abs(y);
 if x>y then begin
  t:=x;
  x:=y;
  y:=t;
 end;
 if x=0 then begin
  result:=y;
 end else begin
  result:=y*sqrt(1.0+sqr(x/y));
 end;
end;

{function log2(const x:single):single; assembler; stdcall;
asm
 fld1
 fld dword ptr x
 fyl2x
end;

function log10(const x:single):single; assembler; stdcall;
asm
 fldlg2
 fld dword ptr x
 fyl2x
end;

function logn(const x,y:single):single; assembler; stdcall;
asm
 fld1
 fld dword ptr y
 fyl2x
 fld1
 fld dword ptr x
 fyl2x
 fdiv
end;   }

function cosh(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=1.0;
 end else begin
  result:=(exp(x)+exp(-x))*0.5;
 end;
end;

function sinh(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=0.0;
 end else begin
  result:=(exp(x)-exp(-x))*0.5;
 end;
end;

function tanh(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=1.0;
 end else begin
  result:=sinh(x)/cosh(x);
 end;
end;

function arccosh(const x:single):single;
begin
 result:=ln(x+sqrt((x-1)/(x+1))*(x+1));
end;

function arcsinh(const x:single):single;
begin
 result:=ln(x+sqrt(sqr(x)+1));
end;

function arctanh(const x:single):single;
begin
 result:=0.5*ln((1+x)/(1-x));
end;

function cotanh(const x:single):single;
begin
 result:=1/tanh(x);
end;

function secanth(const x:single):single;
begin
 result:=1/cosh(x);
end;

function cosecanth(const x:single):single;
begin
 result:=1/sinh(x);
end;

function arccotan(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=pi*0.5;
 end else begin
  result:=arctan(1/x);
 end;
end;

function arcsecant(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=vmINF;
 end else begin
  result:=arccos(1/x);
 end;
end;

function arccosecant(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=vmINF;
 end else begin
  result:=arcsin(1/x);
 end;
end;

function arccotanh(const x:single):single;
begin
 if abs(1-x)<vmEPSILON then begin
  result:=vmINF;
 end else if abs((-1)-x)<vmEPSILON then begin
  result:=vmNEGINF;
 end else begin
  result:=0.5*ln((x+1)/(x-1));
 end;
end;

function arcsecanth(const x:single):single;
begin
 if abs(x)<vmEPSILON then begin
  result:=vmINF;
 end else if abs(x)<vmEPSILON then begin
  result:=0;
 end else begin
  result:=ln((sqrt(1-sqr(x))+1)/x);
 end;
end;

function arccosecanth(const x:single):single;
begin
 result:=ln(sqrt(1+(1/sqr(X))+(1/x)));
end;

function IsNAN(const x:single):boolean;
begin
 result:=((longword(pointer(@x)^) and $7f800000)=$7f800000) and ((longword(pointer(@x)^) and $007fffff)<>$00000000);
end;

function IsINF(const x:single):boolean;
begin
 result:=((longword(pointer(@x)^) and $7f800000)=$7f800000) and ((longword(pointer(@x)^) and $007fffff)=$00000000);
end;

constructor TBeRoPascalScript.Create;
begin
 inherited Create;
 Code:=nil;
 IdentTab:=nil;
 TypeTab:=nil;
 SymNameList:=nil;
 LexerStates:=nil;
 LexerStatePos:=0;
 FileName:='';
 Source:='';
 SampleLength:=0;
 SampleChannels:=1;
 SampleRate:=44100;
 Sample:=nil;
end;

destructor TBeRoPascalScript.Destroy;
begin
 setlength(Source,0);
 setlength(Code,0);
 setlength(IdentTab,0);
 setlength(TypeTab,0);
 setlength(SymNameList,0);
 setlength(LexerStates,0);
 setlength(Sample,0);
 inherited Destroy;
end;

procedure TBeRoPascalScript.Error(N:longint);
var s:ansistring;
begin
 inc(Errors);
 case n of
  100:s:='Invalid number';
  101:s:='Unexpected line end inside string';
  102:s:='Unexpected end of string';
  103:s:='Invalid token';
  104:s:='Wrong token';
  105:s:='Function/procedure expected';
  106:s:='Function/procedure already defined';
  107:s:='Identifier not found';
  108:s:='Types mismatch';
  109:s:='Type must be ordinal';
  110:s:='Type must be a record';
  111:s:='Identifier in record not found';
  112:s:='Type must be a array';
  113:s:='Unsupported data type for write/writeln';
  114:s:='Unsupported data type for read/readln';
  115:s:='Simple type expected';
  116:s:='Too many parameter arguments';
  117:s:='Parameter by reference with string literal forbidden';
  118:s:='Array parameter for string literal expected';
  119:s:='Char data type of the array parameter for string literal expected';
  120:s:='Char array length does not match the string literal length';
  121:s:='Too few parameter arguments';
  122:s:='Procedures are in expressions uncallable';
  123:s:='Types are in expressions uncallable';
  124:s:='Result-symbol are usable only inside functions';
  125:s:='Factor expected';
  126:s:='Strings not allowed here';
  127:s:='Result-symbol are usable only inside functions';
  128:s:='Return-value-asssignments are usable only inside functions';
  129:s:='Variable expected';
  130:s:='Constant expected';
  131:s:='Constant value expected';
  132:s:='Colon expected';
  133:s:='Variable expected';
  134:s:='Simple variable expected';
  135:s:='TO/DOWNTO expected';
  137:s:='Constant value expected';
  138:s:='Array start index must be less than or equal array end index';
  139:s:='Constant value expected';
  140:s:='Type expected';
  141:s:='Absolute link variable from same nested level expected';
  142:s:='Absolute link variable from same minimum type expected';
  143:s:='Simple function type expected';
  144:s:='To much parameter count than the forward declaration';
  145:s:='Parameter name mismatch to the forward declaration';
  146:s:='Parameter type mismatch to the forward declaration';
  147:s:='Parameter reference type mismatch to the forward declaration';
  148:s:='Less Parameter count than the forward declaration';
  149:s:='Function already defined';
  150:s:='Forwared function undefined';
  else s:='Unknown error';
 end;
 s:='Error['+inttostr(LineNumber)+']: '+s;
 raise Exception.Create(s);
end;

procedure TBeRoPascalScript.ReadChar;
begin
 if SourcePosition<length(Source) then begin
  CurrentChar:=Source[SourcePosition+1];
  inc(SourcePosition);
  LinePosition:=LinePosition+1;
  if CurrentChar=#10 then begin
   LineNumber:=LineNumber+1;
   LinePosition:=0;
  end;
 end else begin
  CurrentChar:=#0;
 end;
end;

function TBeRoPascalScript.ReadNumber:longint;
var Num:longint;
begin
 Num:=0;
 if ('0'<=CurrentChar) and (CurrentChar<='9') then begin
  while ('0'<=CurrentChar) and (CurrentChar<='9') do begin
   Num:=(Num*10)+(ord(CurrentChar)-ord('0'));
   ReadChar;
  end;
 end else if CurrentChar='$' then begin
  ReadChar;
  while (('0'<=CurrentChar) and (CurrentChar<='9')) or
        (('A'<=CurrentChar) and (CurrentChar<='F')) or
        (('a'<=CurrentChar) and (CurrentChar<='f')) do begin
   if ('0'<=CurrentChar) and (CurrentChar<='9') then begin
    Num:=(Num*16)+(ord(CurrentChar)-ord('0'));
   end else if ('A'>=CurrentChar) and (CurrentChar<='F') then begin
    Num:=(Num*16)+(ord(CurrentChar)-ord('A')+10);
   end else if ('a'>=CurrentChar) and (CurrentChar<='f') then begin
    Num:=(Num*16)+(ord(CurrentChar)-ord('a')+10);
   end;
   ReadChar;
  end;
 end;
 result:=Num;
end;

procedure TBeRoPascalScript.PushLexerState;
begin
 inc(LexerStatePos);
 if LexerStatePos>=length(LexerStates) then begin
  setlength(LexerStates,(LexerStatePos+2)*2);
 end;
 LexerStates[LexerStatePos].SourcePosition:=SourcePosition;
 LexerStates[LexerStatePos].CurrentChar:=CurrentChar;
 LexerStates[LexerStatePos].LinePosition:=LinePosition;
 LexerStates[LexerStatePos].LineNumber:=LineNumber;
 LexerStates[LexerStatePos].CurrentSymbol:=CurrentSymbol;
 LexerStates[LexerStatePos].CurrentIdent:=CurrentIdent;
 LexerStates[LexerStatePos].CurrentNumber:=CurrentNumber;
 LexerStates[LexerStatePos].CurrentFloatNumber:=CurrentFloatNumber;
 LexerStates[LexerStatePos].CurrentString:=CurrentString;
 LexerStates[LexerStatePos].CurrentStringLength:=CurrentStringLength;
end;

procedure TBeRoPascalScript.PopLexerState;
begin
 dec(LexerStatePos);
end;

procedure TBeRoPascalScript.RestoreLexerState;
begin
 SourcePosition:=LexerStates[LexerStatePos].SourcePosition;
 CurrentChar:=LexerStates[LexerStatePos].CurrentChar;
 LinePosition:=LexerStates[LexerStatePos].LinePosition;
 LineNumber:=LexerStates[LexerStatePos].LineNumber;
 CurrentSymbol:=LexerStates[LexerStatePos].CurrentSymbol;
 CurrentIdent:=LexerStates[LexerStatePos].CurrentIdent;
 CurrentNumber:=LexerStates[LexerStatePos].CurrentNumber;
 CurrentFloatNumber:=LexerStates[LexerStatePos].CurrentFloatNumber;
 CurrentString:=LexerStates[LexerStatePos].CurrentString;
 CurrentStringLength:=LexerStates[LexerStatePos].CurrentStringLength;
 dec(LexerStatePos);
end;

procedure TBeRoPascalScript.GetSymbol;
var s,OldLineNumber,OldLinePosition,OldSourcePos:longint;
    StrEnd,InStr:boolean;
    LastChar,OldCurrentChar:ansichar;
    ss:ansistring;
begin
 while (CurrentChar>#0) and (CurrentChar<=' ') do ReadChar;
 if (('a'<=CurrentChar) and (CurrentChar<='z')) or (('A'<=CurrentChar) and (CurrentChar<='Z')) then begin
  CurrentIdent:='';
  while ((('a'<=CurrentChar) and (CurrentChar<='z')) or (('A'<=CurrentChar) and (CurrentChar<='Z')) or (('0'<=CurrentChar) and (CurrentChar<='9'))) or (CurrentChar='_') do begin
   if ('a'<=CurrentChar) and (CurrentChar<='z') then begin
    dec(CurrentChar,32);
   end;
   CurrentIdent:=CurrentIdent+CurrentChar;
   ReadChar;
  end;
  CurrentSymbol:=TokIdent;
  s:=SymBEGIN;
  while s<=SymLAST do begin
   if Keywords[s]=CurrentIdent then begin
    CurrentSymbol:=s;
   end;
   inc(s);
  end;
 end else if CurrentChar='$' then begin
  CurrentSymbol:=TokNumber;
  CurrentNumber:=ReadNumber;
 end else if ('0'<=CurrentChar) and (CurrentChar<='9') then begin
  s:=0;
  ss:='';
  CurrentNumber:=0;
  CurrentSymbol:=TokNumber;
  while ('0'<=CurrentChar) and (CurrentChar<='9') do begin
   ss:=ss+CurrentChar;
   ReadChar;
  end;
  OldSourcePos:=SourcePosition;
  OldLineNumber:=LineNumber;
  OldLinePosition:=LinePosition;
  OldCurrentChar:=CurrentChar;
  if CurrentChar='.' then begin
   ReadChar;
   if CurrentChar='.' then begin
    SourcePosition:=OldSourcePos;
    LineNumber:=OldLineNumber;
    LinePosition:=OldLinePosition;
    CurrentChar:=OldCurrentChar;
    val(ss,CurrentNumber,s);
   end else begin
    ss:=ss+'.';
    CurrentSymbol:=TokFloatNumber;
    while ('0'<=CurrentChar) and (CurrentChar<='9') do begin
     ss:=ss+CurrentChar;
     ReadChar;
    end;
    if CurrentChar in ['e','E'] then begin
     ReadChar;
     ss:=ss+'e';
     if CurrentChar in ['-','+'] then begin
      ss:=ss+CurrentChar;
      ReadChar;
     end;
     while ('0'<=CurrentChar) and (CurrentChar<='9') do begin
      ss:=ss+CurrentChar;
      ReadChar;
     end;
    end;
    val(ss,CurrentFloatNumber,s);
   end;
  end else begin
   if CurrentChar in ['e','E'] then begin
    ReadChar;
    ss:=ss+'e';
    if CurrentChar in ['-','+'] then begin
     ss:=ss+CurrentChar;
     ReadChar;
    end;
    while ('0'<=CurrentChar) and (CurrentChar<='9') do begin
     ss:=ss+CurrentChar;
     ReadChar;
    end;
    val(ss,CurrentFloatNumber,s);
    CurrentSymbol:=TokFloatNumber;
   end else begin
    val(ss,CurrentNumber,s);
   end;
  end;
  if s<>0 then begin
   Error(100);
  end;     
 end else if CurrentChar=':' then begin
  ReadChar;
  if CurrentChar='=' then begin
   ReadChar;
   CurrentSymbol:=TokAssign;
  end else begin
   CurrentSymbol:=TokColon;
  end;
 end else if CurrentChar='>' then begin
  ReadChar;
  if CurrentChar='=' then begin
   ReadChar;
   CurrentSymbol:=TokGEq;
  end else begin
   CurrentSymbol:=TokGtr;
  end;
 end else if CurrentChar='<' then begin
  ReadChar;
  if CurrentChar='=' then begin
   ReadChar;
   CurrentSymbol:=TokLEq;
  end else if CurrentChar='>' then begin
   ReadChar;
   CurrentSymbol:=TokNEq;
  end else begin
   CurrentSymbol:=TokLss;
  end;
 end else if CurrentChar='.' then begin
  ReadChar;
  if CurrentChar='.' then begin
   ReadChar;
   CurrentSymbol:=TokDots;
  end else begin
   CurrentSymbol:=TokPeriod;
  end;
 end else if (CurrentChar='''') or (CurrentChar='#') then begin
  CurrentStringLength:=0;
  StrEnd:=false;
  InStr:=false;
  CurrentSymbol:=TokStrC;
  while not StrEnd do begin
   if InStr then begin
    if CurrentChar='''' then begin
     ReadChar;
     if CurrentChar='''' then begin
      CurrentStringLength:=CurrentStringLength+1;
      CurrentString[CurrentStringLength]:=CurrentChar;
      ReadChar;
     end else begin
      InStr:=false;
     end;
    end else if (CurrentChar=#13) or (CurrentChar=#10) then begin
     Error(101);
     StrEnd:=true;
    end else begin
     CurrentStringLength:=CurrentStringLength+1;
     CurrentString[CurrentStringLength]:=CurrentChar;
     ReadChar;
    end;
   end else begin
    if CurrentChar='''' then begin
     InStr:=true;
     ReadChar;
    end else if CurrentChar='#' then begin
     ReadChar;
     CurrentStringLength:=CurrentStringLength+1;
     CurrentString[CurrentStringLength]:=ansichar(byte(ReadNumber));
    end else begin
     StrEnd:=true;
    end;
   end;
  end;
  if CurrentStringLength=0 then begin
   Error(102);
  end;
 end else if CurrentChar='+' then begin
  ReadChar;
  CurrentSymbol:=TokPlus;
 end else if CurrentChar='-' then begin
  ReadChar;
  CurrentSymbol:=TokMinus;
 end else if CurrentChar='*' then begin
  ReadChar;
  CurrentSymbol:=TokMul;
 end else if CurrentChar='(' then begin
  ReadChar;
  if CurrentChar='*' then begin
   ReadChar;
   LastChar:='-';
   while not ((CurrentChar=')') and (LastChar='*')) do begin
    LastChar:=CurrentChar;
    ReadChar;
   end;
   ReadChar;
   GetSymbol;
  end else begin
   CurrentSymbol:=TokLParent;
  end;
 end else if CurrentChar=')' then begin
  ReadChar;
  CurrentSymbol:=TokRParent;
 end else if CurrentChar='[' then begin
  ReadChar;
  CurrentSymbol:=TokLBracket;
 end else if CurrentChar=']' then begin
  ReadChar;
  CurrentSymbol:=TokRBracket;
 end else if CurrentChar='=' then begin
  ReadChar;
  CurrentSymbol:=TokEql;
 end else if CurrentChar=',' then begin
  ReadChar;
  CurrentSymbol:=TokComma;
 end else if CurrentChar=';' then begin
  ReadChar;
  CurrentSymbol:=TokSemi;
 end else if CurrentChar='{' then begin
  while (CurrentChar<>'}') and (CurrentChar<>#0) do ReadChar;
  ReadChar;
  GetSymbol;
 end else if CurrentChar='/' then begin
  ReadChar;
  if CurrentChar='/' then begin
   while (CurrentChar<>#13) and (CurrentChar<>#10) and (CurrentChar<>#0) do ReadChar;
   ReadChar;
   GetSymbol;
  end else begin
   CurrentSymbol:=TokDivFloat;
  end;
 end else begin
  Error(103);
 end;
end;

procedure TBeRoPascalScript.Check(s:longint);
begin
 if CurrentSymbol<>s then begin
  Error(104);
 end;
end;

procedure TBeRoPascalScript.Expect(s:longint);
begin
 Check(s);
 GetSymbol;
end;

procedure TBeRoPascalScript.EnterSymbol(CurrentIdent:ansistring;k,t:longint);
var J:longint;
begin
 inc(IdentPos);
 if IdentPos>=length(IdentTab) then begin
  setlength(IdentTab,(IdentPos+2)*2);
 end;
 IdentTab[0].name:=CurrentIdent;
 J:=SymNameList[CurrentLevel+1];
 while IdentTab[J].name<>CurrentIdent do J:=IdentTab[J].Link;
 if J<>0 then begin
  if IdentTab[J].Kind<>IdFUNC then begin
   Error(105);
  end;
  if (Code[IdentTab[J].FAdr]<>OPJmp) or (Code[IdentTab[J].FAdr+1]>0) then begin
   Error(106);
  end;
  IdentTab[J].name[1]:='$';
  if (IdentTab[J].FAdr+1)>=length(Code) then begin
   setlength(Code,(IdentTab[J].FAdr+1)*2);
  end;
  Code[IdentTab[J].FAdr+1]:=CodePosition;
  FuncDecl:=J;
 end;
 IdentTab[IdentPos].name:=CurrentIdent;
 IdentTab[IdentPos].Link:=SymNameList[CurrentLevel+1];
 IdentTab[IdentPos].TypeDef:=t;
 IdentTab[IdentPos].Kind:=k;
 SymNameList[CurrentLevel+1]:=IdentPos;
end;

function TBeRoPascalScript.Position(RaiseError:boolean=true):longint;
var I,J:longint;
begin
 IdentTab[0].name:=CurrentIdent;
 I:=CurrentLevel;
 repeat
  J:=SymNameList[I+1];
  while IdentTab[J].name<>CurrentIdent do begin
   J:=IdentTab[J].Link;
  end;
  dec(I);
 until (I<-1) or (J<>0);
 if (J=0) and RaiseError then begin
  Error(107);
 end;
 result:=J;
end;

procedure TBeRoPascalScript.GenOp(Opcode,a:longint);
begin
 case Opcode of
  OPDupl,OPEOF,OPEOL,OPRANDOMF,OPLdC,OPLdA,OPLdLA,OPLdL,OPLdG:begin
   dec(StackPosition,4);
  end;
  OPNot,OPNeg,OPDiv2,OPMod2,OPSwap,OPLoad,OPHalt,OPWrL,OPRdL,OPAddC,OPMulC,
  OPJmp,OPCall,OPLeave,OPNegF,OPINTTOFLOAT,OPTRUNC,OPROUND,OPABS,OPABSF,OPSQR,
  OPSQRF,OPSQRTF,OPSINF,OPCOSF,OPEXPF,OPLNF,OPFRACF,OPODD,OPTANF,OPISNANF,OPISINFF,
  OPCEILF,OPFLOORF,OPARCTANF,OPARCSINF,OPARCCOSF,OPLOG2F,OPLOG10F,OPCOSHF,
  OPSINHF,OPTANHF,OPARCCOSHF,OPARCSINHF,OPARCTANHF,OPCOTANHF,OPSECANTHF,OPCOSECANTHF,
  OPARCCOTANF,OPARCSECANTF,OPARCCOSECANTF,OPARCCOTANHF,OPARCSECANTHF,OPARCCOSECANTHF,
  OPRANDOM,OPRANDOMIZE:begin
  end;
  OPAdd,OpSub,OPMul,OPDiv,OPMod,OPEql,OPNEq,OPLss,OPLeq,OPGtr,OPGEq,OPAndB,
  OPOrB,OPXorB,OPAnd,OPOr,OPXor,OPWrC,OPWrB,OPRdI,OPRdC,OPRdB,OPStL,OPStG,OPJZ,OPMulF,OPDivF,OPAddF,OPSubF,
  OPEqlF,OPNEqF,OPLssF,OPLeqF,OPGtrF,OPGEqF,OPARCTAN2F,OPPOWERF,OPLOGNF,OPHYPOTF,
  OPSHL,OPSHR,OPSAR,OPSETSAMPLELENGTH,OPSETSAMPLECHANNELS,OPSETSAMPLERATE:begin
   inc(StackPosition,4);
  end;
  OPStore,OPWrI,OPMove,OPSETSAMPLE:begin
   inc(StackPosition,8);
  end;
  OPWrF:begin
   inc(StackPosition,12);
  end;
  OPCopy:begin
   dec(StackPosition,a-4);
  end;
  OPAdjS:begin
   inc(StackPosition,a);
  end;
 end;
 if StackPosition<MinimumStackPosition then begin
  MinimumStackPosition:=StackPosition;
 end;
 if not ((((Opcode=OPAddC) or (Opcode=OPAdjS)) and (a=0)) or ((Opcode=OPMulC) and (a=1))) then begin
  if IsLabeled then begin
   if (CodePosition+2)>=length(Code) then begin
    setlength(Code,(CodePosition+2)*2);
   end;
   Code[CodePosition]:=Opcode;
   CodePosition:=CodePosition+1;
   if Opcode>=OPLdC then begin
    Code[CodePosition]:=a;
    CodePosition:=CodePosition+1;
   end;
   IsLabeled:=false;
  end else if (LastOpcode=OPLdC) and (Opcode=OPAdd) then begin
   Code[CodePosition-2]:=OPAddC;
  end else if (LastOpcode=OPLdC) and (Opcode=OPSub) then begin
   Code[CodePosition-2]:=OPAddC;
   Code[CodePosition-1]:=-Code[CodePosition-1];
  end else if (LastOpcode=OPLdC) and (Opcode=OPMul) then begin
   Code[CodePosition-2]:=OPMulC;
  end else if (LastOpcode=OPLdC) and (Opcode=OPNeg) then begin
   Code[CodePosition-1]:=-Code[CodePosition-1];
   Opcode:=LastOpcode;
  end else if (LastOpcode=OPLdC) and (Opcode=OPNot) then begin
   Code[CodePosition-1]:=not Code[CodePosition-1];
   Opcode:=LastOpcode;
  end else if (LastOpcode=OPLdC) and (Code[CodePosition-1]=2) and (Opcode=OPDiv) then begin
   Code[CodePosition-2]:=OPDiv2;
   CodePosition:=CodePosition-1;
  end else if (LastOpcode=OPLdC) and (Code[CodePosition-1]=2) and (Opcode=OPMod) then begin
   Code[CodePosition-2]:=OPMod2;
   CodePosition:=CodePosition-1;
  end else if (LastOpcode=OPLdA) and (Opcode=OPStore) then begin
   Code[CodePosition-2]:=OPStG;
  end else if (LastOpcode=OPLdA) and (Opcode=OPLoad) then begin
   Code[CodePosition-2]:=OPLdG;
  end else if (LastOpcode=OPLdLA) and (Opcode=OPStore) then begin
   Code[CodePosition-2]:=OPStL;
  end else if (LastOpcode=OPLdLA) and (Opcode=OPLoad) then begin
   Code[CodePosition-2]:=OPLdL;
  end else begin
   if (CodePosition+2)>=length(Code) then begin
    setlength(Code,(CodePosition+2)*2);
   end;
   Code[CodePosition]:=Opcode;
   CodePosition:=CodePosition+1;
   if Opcode>=OPLdC then begin
    Code[CodePosition]:=a;
    CodePosition:=CodePosition+1;
   end;
  end;
  LastOpcode:=Opcode;
 end;
end;

procedure TBeRoPascalScript.GenOp2(Opcode:longint);
begin
 GenOp(Opcode,0);
end;

function TBeRoPascalScript.CodeLabel:longint;
begin
 result:=CodePosition;
 IsLabeled:=true;
end;

procedure TBeRoPascalScript.GenAddress(Level,Address:longint);
begin
 if Level=0 then begin
  GenOp(OPLdA,Address);
 end else if Level=CurrentLevel then begin
  GenOp(OPLdLA,Address-StackPosition);
 end else begin
  GenOp(OPLdL,-StackPosition);
  while Level+1<>CurrentLevel do begin
   GenOp2(OPLoad);
   Level:=Level+1;
  end;
  GenOp(OPAddC,Address);
 end;
end;

procedure TBeRoPascalScript.GenAddressVar(IdentNr:longint);
begin
 GenAddress(IdentTab[IdentNr].VLevel,IdentTab[IdentNr].VAdr);
 if IdentTab[IdentNr].RefPar then GenOp2(OPLoad);
end;

procedure TBeRoPascalScript.MustBe(x,y:longint);
begin
 if x<>y then begin
  if ((x>=0) and (x<length(TypeTab))) and ((y>=0) and (y<=length(TypeTab))) and ((TypeTab[x].Kind=KindARRAY) and (TypeTab[y].Kind=KindARRAY) and (TypeTab[x].StartIndex=TypeTab[y].StartIndex) and (TypeTab[x].EndIndex=TypeTab[y].EndIndex)) then begin
   MustBe(TypeTab[x].SubType,TypeTab[y].SubType);
  end else begin
   Error(108);
  end;
 end;
end;

procedure TBeRoPascalScript.MustBeOrdinal(x:longint);
begin
 if not (x in [TypeINT,TypeCHAR,TypeBOOL]) then begin
  Error(109);
 end;
end;

procedure TBeRoPascalScript.Selector(var t,IdentNr:longint);
var J,x,OldCodePosition,OldStackPosition:longint;
    Optimizable:boolean;
    v:TTermValue;
begin
 t:=IdentTab[IdentNr].TypeDef;
 GetSymbol;
 if (CurrentSymbol=TokPeriod) or (CurrentSymbol=TokLBracket) then begin
  GenAddressVar(IdentNr);
  IdentNr:=0;
  while (CurrentSymbol=TokPeriod) or (CurrentSymbol=TokLBracket) do begin
   case CurrentSymbol of
    TokPeriod:begin
     if TypeTab[t].Kind<>KindRECORD then begin
      Error(110);
     end;
     GetSymbol;
     Check(TokIdent);
     J:=TypeTab[t].Fields;
     IdentTab[0].name:=CurrentIdent;
     while IdentTab[J].name<>CurrentIdent do begin
      J:=IdentTab[J].Link;
     end;
     if J=0 then begin
      Error(111);
     end;
     GenOp(OPAddC,IdentTab[J].Offset);
     t:=IdentTab[J].TypeDef;
     GetSymbol;
    end;
    TokLBracket:begin
     repeat
      if TypeTab[t].Kind<>KindARRAY then begin
       Error(112);
      end;
      GetSymbol;
      Optimizable:=true;
      OldCodePosition:=CodePosition;
      OldStackPosition:=StackPosition;
      v:=Expression(x,Optimizable);
      MustBe(TypeINT,x);
      if Optimizable then begin
       CodePosition:=OldCodePosition;
       StackPosition:=OldStackPosition;
       GenOp(OPLdC,(v.IntegerValue-TypeTab[t].StartIndex)*TypeTab[TypeTab[t].SubType].Size);
       t:=TypeTab[t].SubType;
      end else begin
       GenOp(OPAddC,-TypeTab[t].StartIndex);
       t:=TypeTab[t].SubType;
       GenOp(OPMulC,TypeTab[t].Size);
      end;
      GenOp2(OPAdd);
     until CurrentSymbol<>TokComma;
     Expect(TokRBracket)
    end;
   end;
  end;
 end;
end;

procedure TBeRoPascalScript.VarPar(var t:longint);
var J:longint;
begin
 Check(TokIdent);
 J:=Position;
 Selector(t,J);
 if J<>0 then GenAddressVar(J);
end;

function TBeRoPascalScript.InternalFunction(N:longint;var Optimizable:boolean):TTermValue;
var x,y,t,i,m,OldCodePosition,OldStackPosition,OldCodePosition2,OldStackPosition2:longint;
    v:TTermValue;
    Optimizable2:boolean;
begin
 result.ValueType:=-1;
 case N of
  FunctionCHR:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   result.ValueType:=TypeCHAR;
  end;
  FunctionORD:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeBOOL then begin
    MustBe(TypeCHAR,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   result.ValueType:=TypeINT;
  end;
  FunctionWRITE,FunctionWRITELN:begin
   if N=FunctionWRITE then Check(TokLParent);
   if CurrentSymbol=TokLParent then begin
    repeat
     GetSymbol;
     if CurrentSymbol=TokStrC then begin
      x:=1;
      while x<=CurrentStringLength do begin
       GenOp(OPLdC,ord(CurrentString[x]));
       GenOp2(OPWrC);
       x:=x+1;
      end;
      GetSymbol;
     end else begin
      Optimizable:=true;
      OldCodePosition:=CodePosition;
      OldStackPosition:=StackPosition;
      result:=Expression(x,Optimizable);
      if Optimizable then begin
       CodePosition:=OldCodePosition;
       StackPosition:=OldStackPosition;
       GenOp(OPLdC,result.IntegerValue);
      end;
      if CurrentSymbol=TokColon then begin
       if x=TypeINT then begin
        GetSymbol;
        Optimizable:=true;
        OldCodePosition:=CodePosition;
        OldStackPosition:=StackPosition;
        result:=Expression(x,Optimizable);
        MustBe(TypeINT,x);
        if Optimizable then begin
         CodePosition:=OldCodePosition;
         StackPosition:=OldStackPosition;
         GenOp(OPLdC,result.IntegerValue);
        end;
        GenOp2(OPWrI);
       end else if x=TypeFLOAT then begin
        GetSymbol;
        Optimizable:=true;
        OldCodePosition:=CodePosition;
        OldStackPosition:=StackPosition;
        result:=Expression(x,Optimizable);
        MustBe(TypeINT,x);
        if Optimizable then begin
         CodePosition:=OldCodePosition;
         StackPosition:=OldStackPosition;
         GenOp(OPLdC,result.IntegerValue);
        end;
        if CurrentSymbol=TokColon then begin
         GetSymbol;
         Optimizable:=true;
         OldCodePosition:=CodePosition;
         OldStackPosition:=StackPosition;
         result:=Expression(x,Optimizable);
         MustBe(TypeINT,x);
         if Optimizable then begin
          CodePosition:=OldCodePosition;
          StackPosition:=OldStackPosition;
          GenOp(OPLdC,result.IntegerValue);
         end;
        end else begin
         GenOp(OPLdC,1);
        end;
        GenOp2(OPWrF);
       end else begin
        MustBe(TypeINT,x);
       end;
      end else if x=TypeINT then begin
       GenOp(OPLdC,1);
       GenOp2(OPWrI);
      end else if x=TypeFLOAT then begin
       GenOp(OPLdC,-1);
       GenOp(OPLdC,-1);
       GenOp2(OPWrF);
      end else if x=TypeCHAR then begin
       GenOp2(OPWrC);
      end else if x=TypeBOOL then begin
       GenOp2(OPWrB);
      end else begin
       Error(113);
      end;
     end;
    until CurrentSymbol<>TokComma;
    Expect(TokRParent);
   end;
   if N=FunctionWRITELN then GenOp2(OPWrL);
   Optimizable:=false;
  end;
  FunctionREAD,FunctionREADLN:begin
   if N=FunctionREAD then begin
    Check(TokLParent);
   end;
   if CurrentSymbol=TokLParent then begin
    repeat
     GetSymbol;
     VarPar(x);
     if x=TypeINT then begin
      GenOp2(OPRdI);
     end else if x=TypeFLOAT then begin
      GenOp2(OPRdF);
     end else if x=TypeCHAR then begin
      GenOp2(OPRdC);
     end else if x=TypeBOOL then begin
      GenOp2(OPRdB);
     end else begin
      Error(114);
     end;
    until CurrentSymbol<>TokComma;
    Expect(TokRParent);
   end;
   if N=FunctionREADLN then begin
    GenOp2(OPRdL);
   end;
   Optimizable:=false;
  end;
  FunctionEOF:GenOp2(OPEOF);
  FunctionEOFLN:GenOp2(OPEOL);
  FunctionDEC:begin
   m:=CodePosition;
   Expect(TokLParent);
   i:=Position;
   Selector(t,i);
   if TypeTab[t].Kind<>KindSIMPLE then begin
    Error(115);
   end;
   if i<>0 then begin
    GenAddressVar(i);
   end;
   GenOp2(OPDupl);
   GenOp2(OPLoad);
   if CurrentSymbol=TokComma then begin
    GetSymbol;
    Optimizable:=true;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    x:=t;
    result:=Expression(x,Optimizable);
    MustBe(TypeINT,x);
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPAddC,-result.IntegerValue);
    end else begin
     GenOp2(OPSub);
     result.IntegerValue:=-1;
    end;
   end else begin
    GenOp(OPAddC,-1);
    result.IntegerValue:=-1;
   end;
   GenOp2(OPSwap);
   GenOp2(OPStore);
   Expect(TokRParent);
   if result.IntegerValue=0 then begin
    CodePosition:=m;
   end;
   Optimizable:=false;
  end;
  FunctionINC:begin
   m:=CodePosition;
   Expect(TokLParent);
   i:=Position;
   Selector(t,i);
   if TypeTab[t].Kind<>KindSIMPLE then begin
    Error(115);
   end;
   if i<>0 then begin
    GenAddressVar(i);
   end;
   GenOp2(OPDupl);
   GenOp2(OPLoad);
   if CurrentSymbol=TokComma then begin
    GetSymbol;
    Optimizable:=true;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    x:=t;
    result:=Expression(x,Optimizable);
    MustBe(TypeINT,x);
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPAddC,result.IntegerValue);
    end else begin
     GenOp2(OPAdd);
     result.IntegerValue:=1;
    end;
   end else begin
    GenOp(OPAddC,1);
    result.IntegerValue:=1;
   end;
   GenOp2(OPSwap);
   GenOp2(OPStore);
   Expect(TokRParent);
   if result.IntegerValue=0 then begin
    CodePosition:=m;
   end;
   Optimizable:=false;
  end;
  FunctionTRUNC:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.IntegerValue:=trunc(result.FloatValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    GenOp2(OPTRUNC);
   end;
   result.ValueType:=TypeINT;
  end;
  FunctionROUND:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.IntegerValue:=round(result.FloatValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    GenOp2(OPROUND);
   end;
   result.ValueType:=TypeINT;
  end;
  FunctionABS:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=abs(result.FloatValue);
    end else begin
     result.IntegerValue:=abs(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp2(OPABS);
    end else begin
     GenOp2(OPABSF);
    end;
   end;
   result.ValueType:=x;
  end;
  FunctionSQR:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=result.FloatValue*result.FloatValue;
    end else begin
     result.IntegerValue:=result.IntegerValue*result.IntegerValue;
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp2(OPSQR);
    end else begin
     GenOp2(OPSQRF);
    end;
   end;
   result.ValueType:=x;
  end;
  FunctionSQRT:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=sqrt(result.FloatValue);
    end else begin
     result.FloatValue:=sqrt(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPSQRTF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionSIN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=sin(result.FloatValue);
    end else begin
     result.FloatValue:=sin(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPSINF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionCOS:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=cos(result.FloatValue);
    end else begin
     result.FloatValue:=cos(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPCOSF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionEXP:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=exp(result.FloatValue);
    end else begin
     result.FloatValue:=exp(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPEXPF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionLN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=ln(result.FloatValue);
    end else begin
     result.FloatValue:=ln(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPLNF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionFRAC:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=frac(result.FloatValue);
    end else begin
     result.FloatValue:=frac(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPFRACF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionODD:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.IntegerValue:=ord((result.IntegerValue and 1)<>0);
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    GenOp2(OPODD);
   end;
   result.ValueType:=TypeBOOL;
  end;
  FunctionSUCC:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.IntegerValue:=result.IntegerValue+1;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    GenOp(OPAddC,1);
   end;
   result.ValueType:=TypeINT;
  end;
  FunctionPRED:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.IntegerValue:=result.IntegerValue-1;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    GenOp(OPAddC,-1);
   end;
   result.ValueType:=TypeINT;
  end;
  FunctionTAN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=tan(result.FloatValue);
    end else begin
     result.FloatValue:=tan(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPTANF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionISNAN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.IntegerValue:=ord(IsNAN(result.FloatValue));
    end else begin
     result.IntegerValue:=ord(IsNAN(result.IntegerValue));
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPISNANF);
   end;
   result.ValueType:=TypeBOOL;
  end;
  FunctionISINF:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.IntegerValue:=ord(IsINF(result.FloatValue));
    end else begin
     result.IntegerValue:=ord(IsINF(result.IntegerValue));
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPISINFF);
   end;
   result.ValueType:=TypeBOOL;
  end;
  FunctionCEIL:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=SoftCEIL(result.FloatValue);
    end else begin
     result.FloatValue:=SoftCEIL(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPCEILF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionFLOOR:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=SoftFLOOR(result.FloatValue);
    end else begin
     result.FloatValue:=SoftFLOOR(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPFLOORF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCTAN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arctan(result.FloatValue);
    end else begin
     result.FloatValue:=arctan(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCTANF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCTAN2:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeINT then begin
     result.FloatValue:=result.IntegerValue;
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else if x=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   result.ValueType:=TypeFLOAT;
   x:=TypeFLOAT;
   Expect(TokComma);
   OldCodePosition2:=CodePosition;
   OldStackPosition2:=StackPosition;
   y:=x;
   Optimizable2:=true;
   v:=Expression(y,Optimizable2);
   if y<>TypeINT then begin
    MustBe(TypeFLOAT,y);
   end;
   if Optimizable2 then begin
    CodePosition:=OldCodePosition2;
    StackPosition:=OldStackPosition2;
    if y=TypeINT then begin
     v.FloatValue:=v.IntegerValue;
    end;
    GenOp(OPLdC,v.IntegerValue);
   end else if y=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   v.ValueType:=TypeFLOAT;
   y:=TypeFLOAT;
   Expect(TokRParent);
   if Optimizable and Optimizable2 then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.FloatValue:=arctan2(result.FloatValue,v.FloatValue);
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    Optimizable:=false;
    GenOp2(OPARCTAN2F);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCSIN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arcsin(result.FloatValue);
    end else begin
     result.FloatValue:=arcsin(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCSINF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCCOS:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arccos(result.FloatValue);
    end else begin
     result.FloatValue:=arccos(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCCOSF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionHYPOT:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeINT then begin
     result.FloatValue:=result.IntegerValue;
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else if x=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   result.ValueType:=TypeFLOAT;
   x:=TypeFLOAT;
   Expect(TokComma);
   OldCodePosition2:=CodePosition;
   OldStackPosition2:=StackPosition;
   y:=x;
   Optimizable2:=true;
   v:=Expression(y,Optimizable2);
   if y<>TypeINT then begin
    MustBe(TypeFLOAT,y);
   end;
   if Optimizable2 then begin
    CodePosition:=OldCodePosition2;
    StackPosition:=OldStackPosition2;
    if y=TypeINT then begin
     v.FloatValue:=v.IntegerValue;
    end;
    GenOp(OPLdC,v.IntegerValue);
   end else if y=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   v.ValueType:=TypeFLOAT;
   y:=TypeFLOAT;
   Expect(TokRParent);
   if Optimizable and Optimizable2 then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.FloatValue:=hypot(result.FloatValue,v.FloatValue);
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    Optimizable:=false;
    GenOp2(OPHYPOTF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionLOG2:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=log2(result.FloatValue);
    end else begin
     result.FloatValue:=log2(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPLOG2F);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionLOG10:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=log10(result.FloatValue);
    end else begin
     result.FloatValue:=log10(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPLOG10F);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionLOGN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeINT then begin
     result.FloatValue:=result.IntegerValue;
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else if x=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   result.ValueType:=TypeFLOAT;
   x:=TypeFLOAT;
   Expect(TokComma);
   OldCodePosition2:=CodePosition;
   OldStackPosition2:=StackPosition;
   y:=x;
   Optimizable2:=true;
   v:=Expression(y,Optimizable2);
   if y<>TypeINT then begin
    MustBe(TypeFLOAT,y);
   end;
   if Optimizable2 then begin
    CodePosition:=OldCodePosition2;
    StackPosition:=OldStackPosition2;
    if y=TypeINT then begin
     v.FloatValue:=v.IntegerValue;
    end;
    GenOp(OPLdC,v.IntegerValue);
   end else if y=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   v.ValueType:=TypeFLOAT;
   y:=TypeFLOAT;
   Expect(TokRParent);
   if Optimizable and Optimizable2 then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.FloatValue:=logn(result.FloatValue,v.FloatValue);
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    Optimizable:=false;
    GenOp2(OPLOGNF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionCOSH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=cosh(result.FloatValue);
    end else begin
     result.FloatValue:=cosh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPCOSHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionSINH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=sinh(result.FloatValue);
    end else begin
     result.FloatValue:=sinh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPSINHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionTANH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=tanh(result.FloatValue);
    end else begin
     result.FloatValue:=tanh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPTANHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCCOSH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arccosh(result.FloatValue);
    end else begin
     result.FloatValue:=arccosh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCCOSHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCSINH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arcsinh(result.FloatValue);
    end else begin
     result.FloatValue:=arcsinh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCSINHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCTANH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arctanh(result.FloatValue);
    end else begin
     result.FloatValue:=arctanh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCTANHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionPOWER:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeINT then begin
     result.FloatValue:=result.IntegerValue;
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else if x=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   result.ValueType:=TypeFLOAT;
   x:=TypeFLOAT;
   Expect(TokComma);
   OldCodePosition2:=CodePosition;
   OldStackPosition2:=StackPosition;
   y:=x;
   Optimizable2:=true;
   v:=Expression(y,Optimizable2);
   if y<>TypeINT then begin
    MustBe(TypeFLOAT,y);
   end;
   if Optimizable2 then begin
    CodePosition:=OldCodePosition2;
    StackPosition:=OldStackPosition2;
    if y=TypeINT then begin
     v.FloatValue:=v.IntegerValue;
    end;
    GenOp(OPLdC,v.IntegerValue);
   end else if y=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   v.ValueType:=TypeFLOAT;
   y:=TypeFLOAT;
   Expect(TokRParent);
   if Optimizable and Optimizable2 then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.FloatValue:=power(result.FloatValue,v.FloatValue);
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    Optimizable:=false;
    GenOp2(OPPOWERF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionCOTANH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=cotanh(result.FloatValue);
    end else begin
     result.FloatValue:=cotanh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPCOTANHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionSECANTH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=secanth(result.FloatValue);
    end else begin
     result.FloatValue:=secanth(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPSECANTHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionCOSECANTH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=cosecanth(result.FloatValue);
    end else begin
     result.FloatValue:=cosecanth(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPCOSECANTHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCCOTAN:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arccotan(result.FloatValue);
    end else begin
     result.FloatValue:=arccotan(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCCOTANF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCSECANT:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arcsecant(result.FloatValue);
    end else begin
     result.FloatValue:=arcsecant(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCSECANTF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCCOSECANT:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arccosecant(result.FloatValue);
    end else begin
     result.FloatValue:=arccosecant(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCCOSECANTF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCCOTANH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arccotanh(result.FloatValue);
    end else begin
     result.FloatValue:=arccotanh(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCCOTANHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCSECANTH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arcsecanth(result.FloatValue);
    end else begin
     result.FloatValue:=arcsecanth(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCSECANTHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionARCCOSECANTH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   if x<>TypeINT then begin
    MustBe(TypeFLOAT,x);
   end;
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    if x=TypeFLOAT then begin
     result.FloatValue:=arccosecanth(result.FloatValue);
    end else begin
     result.FloatValue:=arccosecanth(result.IntegerValue);
    end;
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
    end;
    GenOp2(OPARCCOSECANTHF);
   end;
   result.ValueType:=TypeFLOAT;
  end;
  FunctionRANDOM:begin
   if CurrentSymbol=TokLParent then begin
    GetSymbol;
    Optimizable:=true;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    result:=Expression(x,Optimizable);
    MustBe(TypeINT,x);
    Expect(TokRParent);
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end;
    GenOp2(OPRANDOM);
    result.ValueType:=TypeINT;
    t:=TypeINT;
   end else begin
    GenOp2(OPRANDOMF);
    result.ValueType:=TypeFLOAT;
    t:=TypeFLOAT;
   end;
   Optimizable:=false;
  end;
  FunctionRANDOMIZE:begin
   if CurrentSymbol=TokLParent then begin
    GetSymbol;
    Expect(TokRParent);
   end;
   GenOp2(OPRANDOMIZE);
  end;
  FunctionSARLONGINT:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   Expect(TokComma);
   OldCodePosition2:=CodePosition;
   OldStackPosition2:=StackPosition;
   y:=x;
   Optimizable2:=true;
   v:=Expression(y,Optimizable2);
   MustBe(TypeINT,y);
   if Optimizable2 then begin
    CodePosition:=OldCodePosition2;
    StackPosition:=OldStackPosition2;
    GenOp(OPLdC,v.IntegerValue);
   end;
   Expect(TokRParent);
   if Optimizable and Optimizable2 then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    result.IntegerValue:=SARLongint(result.IntegerValue,v.IntegerValue);
    GenOp(OPLdC,result.IntegerValue);
   end else begin
    Optimizable:=false;
    GenOp2(OPSAR);
   end;
   result.ValueType:=TypeINT;
  end;
  FunctionSETSAMPLELENGTH:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   GenOp2(OPSETSAMPLELENGTH);
   result.ValueType:=0;
  end;
  FunctionSETSAMPLECHANNELS:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   GenOp2(OPSETSAMPLECHANNELS);
   result.ValueType:=0;
  end;
  FunctionSETSAMPLERATE:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   Expect(TokRParent);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   GenOp2(OPSETSAMPLERATE);
   result.ValueType:=0;
  end;
  FunctionSETSAMPLE:begin
   Expect(TokLParent);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   result:=Expression(x,Optimizable);
   MustBe(TypeINT,x);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
   Expect(TokComma);
   OldCodePosition2:=CodePosition;
   OldStackPosition2:=StackPosition;
   y:=x;
   Optimizable2:=true;
   v:=Expression(y,Optimizable2);
   if y<>TypeINT then begin
    MustBe(TypeFLOAT,y);
   end;
   if Optimizable2 then begin
    CodePosition:=OldCodePosition2;
    StackPosition:=OldStackPosition2;
    if y=TypeINT then begin
     v.FloatValue:=v.IntegerValue;
    end;
    GenOp(OPLdC,v.IntegerValue);
   end else if y=TypeINT then begin
    GenOp(OPINTTOFLOAT,0);
   end;
   Expect(TokRParent);
   GenOp2(OPSETSAMPLE);
   result.ValueType:=0;
  end;
 end;
end;

function TBeRoPascalScript.FunctionCall(I:longint;var Optimizable:boolean):TTermValue;
var OldStackPos,p,x,OldCodePosition,OldStackPosition:longint;
    v:TTermValue;
begin
 GetSymbol;
 if IdentTab[I].FLevel<0 then begin
  result:=InternalFunction(IdentTab[I].FAdr,Optimizable);
 end else begin
  if IdentTab[I].TypeDef<>0 then begin
   GenOp(OPLdC,0);
   result.ValueType:=IdentTab[I].TypeDef;
  end else begin
   result.ValueType:=-1;
  end;
  p:=I;
  OldStackPos:=StackPosition;
  if CurrentSymbol=TokLParent then begin
   repeat
    GetSymbol;
    if p=IdentTab[I].LastParameter then begin
     Error(116);
    end;
    inc(p);
    if IdentTab[p].RefPar then begin
     VarPar(x);
    end else begin
     Optimizable:=true;
     OldCodePosition:=CodePosition;
     OldStackPosition:=StackPosition;
     v:=Expression(x,Optimizable);
     if Optimizable then begin
      CodePosition:=OldCodePosition;
      StackPosition:=OldStackPosition;
      if (TypeTab[x].Kind=KindSIMPLE) and (x=TypeINT) and (IdentTab[p].TypeDef=TypeFLOAT) then begin
       v.FloatValue:=v.IntegerValue;
       v.ValueType:=TypeFLOAT;
       x:=TypeFLOAT;
      end;
      GenOp(OPLdC,v.IntegerValue);
     end;
     if TypeTab[x].Kind<>KindSIMPLE then begin
      GenOp(OPCopy,TypeTab[x].Size);
     end;
    end;
    if x=TypeSTR then begin
     if IdentTab[p].RefPar then begin
      Error(117);
     end;
     if TypeTab[IdentTab[p].TypeDef].Kind<>KindARRAY then begin
      Error(118);
     end;
     if TypeTab[IdentTab[p].TypeDef].SubType<>TypeCHAR then begin
      Error(119);
     end;
     if ((TypeTab[IdentTab[p].TypeDef].EndIndex-TypeTab[IdentTab[p].TypeDef].StartIndex)+1)<>CurrentStringLength then begin
      Error(120);
     end;
    end else begin
     if (TypeTab[x].Kind=KindSIMPLE) and (x=TypeINT) and (IdentTab[p].TypeDef=TypeFLOAT) then begin
      GenOp(OPINTTOFLOAT,0);
     end else begin
      MustBe(IdentTab[p].TypeDef,x);
     end;
    end;
   until CurrentSymbol<>TokComma;
   Expect(TokRParent);
  end;
  if p<>IdentTab[I].LastParameter then begin
   Error(121);
  end;
  if IdentTab[I].FLevel<>0 then begin
   GenAddress(IdentTab[I].FLevel,0);
  end;
  GenOp(OPCall,IdentTab[I].FAdr);
  StackPosition:=OldStackPos;
  Optimizable:=false;
 end;
end;

function TBeRoPascalScript.Factor(var t:longint;var Optimizable:boolean):TTermValue;
var i,OldCodePosition,OldStackPosition:longint;
    OptimizableEx:boolean;
begin
 result.ValueType:=TypeINT;
 result.IntegerValue:=0;
 if CurrentSymbol=TokIdent then begin
  i:=Position;
  t:=IdentTab[i].TypeDef;
  result.ValueType:=t;
  case IdentTab[i].Kind of
   IdCONST:begin
    GetSymbol;
    GenOp(OPLdC,IdentTab[i].Value);
    result.IntegerValue:=IdentTab[i].Value;
   end;
   IdVAR:begin
    Optimizable:=false;
    Selector(t,i);
    if i<>0 then GenAddressVar(i);
    if TypeTab[t].Kind=KindSIMPLE then GenOp2(OPLoad);
    result.ValueType:=t;
   end;
   IdFUNC:begin
    if t=0 then begin
     Optimizable:=false;
     Error(122);
    end else begin
     if i<>CurrentFunctionIdent then begin
      result:=FunctionCall(i,Optimizable);
      t:=result.ValueType;
     end else begin
      PushLexerState;
      GetSymbol;
      if CurrentSymbol=TokLParent then begin
       RestoreLexerState;
       result:=FunctionCall(i,Optimizable);
       t:=result.ValueType;
      end else begin
       Optimizable:=false;
       PopLexerState;
       GenAddress(IdentTab[CurrentFunctionIdent].FLevel+1,IdentTab[CurrentFunctionIdent].ReturnAddress);
       GenOp2(OPLoad);
       result.ValueType:=IdentTab[CurrentFunctionIdent].TypeDef;
       t:=result.ValueType;
      end;
     end;
    end;
   end;
   IdTYPE:begin
    Error(123);
   end;
  end;
 end else if CurrentSymbol=SymRESULT then begin
  if CurrentFunctionIdent>0 then begin
   GetSymbol;
   Optimizable:=false;
   PopLexerState;
   GenAddress(IdentTab[CurrentFunctionIdent].FLevel+1,IdentTab[CurrentFunctionIdent].ReturnAddress);
   GenOp2(OPLoad);
   result.ValueType:=IdentTab[CurrentFunctionIdent].TypeDef;
   t:=result.ValueType;
  end else begin
   Error(124);
  end;
 end else if CurrentSymbol=TokNumber then begin
  GenOp(OPLdC,CurrentNumber);
  t:=TypeINT;
  result.ValueType:=t;
  result.IntegerValue:=CurrentNumber;
  GetSymbol;
 end else if CurrentSymbol=TokFloatNumber then begin
  t:=TypeFLOAT;
  result.ValueType:=t;
  result.FloatValue:=CurrentFloatNumber;
  GenOp(OPLdC,result.IntegerValue);
  GetSymbol;
 end  else if CurrentSymbol=TokStrC then begin
  I:=CurrentStringLength;
  if CurrentStringLength>1 then begin
   while I>=1 do begin
    GenOp(OPLdC,ord(CurrentString[I]));
    I:=I-1;
   end;
   t:=TypeSTR;
   Optimizable:=false;
  end else begin
   GenOp(OPLdC,ord(CurrentString[1]));
   t:=TypeCHAR;
   result.ValueType:=t;
   result.IntegerValue:=ord(CurrentString[1]);
  end;
  GetSymbol;
 end else if CurrentSymbol=TokLParent then begin
  GetSymbol;
  OptimizableEx:=true;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  result:=Expression(t,OptimizableEx);
  Optimizable:=Optimizable and OptimizableEx;
  if OptimizableEx and (result.ValueType in [TypeINT,TypeBOOL,TypeCHAR,TypeFLOAT]) then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,result.IntegerValue);
  end;
  Expect(TokRParent);
 end else if CurrentSymbol=SymNOT then begin
  GetSymbol;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  result:=Factor(t,Optimizable);
  case t of
   TypeBOOL:begin
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     result.IntegerValue:=(-result.IntegerValue)+1;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     GenOp2(OPNeg);
     GenOp(OPAddC,1);
     Optimizable:=false;
    end;
   end;
   TypeINT:begin
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     result.IntegerValue:=not result.IntegerValue;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     GenOp2(OPNot);
     Optimizable:=false;
    end;
   end;
   else begin
    MustBe(TypeBOOL,t);
   end;
  end;
 end else begin
  Error(125);
 end;
end;

function TBeRoPascalScript.Term(var x:longint;var Optimizable:boolean):TTermValue;
var y,OldCodePosition,OldStackPosition:longint;
    v:TTermValue;
begin
 OldCodePosition:=CodePosition;
 OldStackPosition:=StackPosition;
 result:=Factor(x,Optimizable);
 if Optimizable and (result.ValueType in [TypeINT,TypeBOOL,TypeChar,TypeFloat]) then begin
  CodePosition:=OldCodePosition;
  StackPosition:=OldStackPosition;
  GenOp(OPLdC,result.IntegerValue);
 end;
 while (CurrentSymbol=SymAND) or (CurrentSymbol=TokMul) or (CurrentSymbol=TokDivFloat) or (CurrentSymbol=SymDIV) or (CurrentSymbol=SymMOD) or (CurrentSymbol=SymSHL) or (CurrentSymbol=SymSHR) do begin
  case CurrentSymbol of
   TokMul:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    if Optimizable then begin
     if (result.ValueType=TypeINT) and (v.ValueType=TypeINT) then begin
      result.IntegerValue:=result.IntegerValue*v.IntegerValue;
      result.ValueType:=TypeINT;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      result.FloatValue:=result.IntegerValue*v.FloatValue;
      result.ValueType:=TypeFLOAT;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      result.FloatValue:=result.FloatValue*v.IntegerValue;
      result.ValueType:=TypeFLOAT;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      result.FloatValue:=result.FloatValue*v.FloatValue;
      result.ValueType:=TypeFLOAT;
     end else begin
      Optimizable:=false;
     end;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
     x:=result.ValueType;
     y:=result.ValueType;
    end else begin
     if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      GenOp(OPINTTOFLOAT,0);
      GenOp2(OPMulF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      GenOp(OPINTTOFLOAT,4);
      GenOp2(OPMulF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      GenOp2(OPMulF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else begin
      MustBe(TypeINT,x);
      MustBe(TypeINT,y);
      GenOp2(OPMul);
      result.ValueType:=TypeINT;
     end;
    end;
   end;
   SymDIV:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    MustBe(TypeINT,x);
    MustBe(TypeINT,y);
    if v.IntegerValue<>0 then begin
     result.IntegerValue:=result.IntegerValue div v.IntegerValue;
    end else begin
     Optimizable:=false;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     GenOp2(OPDiv);
    end;
   end;
   SymSHL:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    MustBe(TypeINT,x);
    MustBe(TypeINT,y);
    if v.IntegerValue<>0 then begin
     result.IntegerValue:=result.IntegerValue shl v.IntegerValue;
    end else begin
     Optimizable:=false;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     GenOp2(OPSHL);
    end;
   end;
   SymSHR:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    MustBe(TypeINT,x);
    MustBe(TypeINT,y);
    if v.IntegerValue<>0 then begin
     result.IntegerValue:=result.IntegerValue shr v.IntegerValue;
    end else begin
     Optimizable:=false;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     GenOp2(OPSHR);
    end;
   end;
   TokDivFloat:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    if Optimizable then begin
     if (result.ValueType=TypeINT) and (v.ValueType=TypeINT) then begin
      if v.IntegerValue<>0 then begin
       result.FloatValue:=result.IntegerValue/v.IntegerValue;
       result.ValueType:=TypeFLOAT;
      end else begin
       Optimizable:=false;
      end;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      if abs(v.FloatValue)>1e-18 then begin
       result.FloatValue:=result.IntegerValue/v.FloatValue;
       result.ValueType:=TypeFLOAT;
      end else begin
       Optimizable:=false;
      end;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      if v.IntegerValue<>0 then begin
       result.FloatValue:=result.FloatValue/v.IntegerValue;
       result.ValueType:=TypeFLOAT;
      end else begin
       Optimizable:=false;
      end;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      if abs(v.FloatValue)>1e-18 then begin
       result.FloatValue:=result.FloatValue/v.FloatValue;
       result.ValueType:=TypeFLOAT;
      end else begin
       Optimizable:=false;
      end;
     end else begin
      Optimizable:=false;
     end;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
     x:=result.ValueType;
     y:=result.ValueType;
    end else begin
     if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      GenOp(OPINTTOFLOAT,0);
      GenOp2(OPDivF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      GenOp(OPINTTOFLOAT,4);
      GenOp2(OPDivF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      GenOp2(OPDivF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeINT) then begin
      GenOp(OPINTTOFLOAT,0);
      GenOp(OPINTTOFLOAT,4);
      GenOp2(OPDivF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else begin
      MustBe(TypeFLOAT,x);
      MustBe(TypeFLOAT,y);
      GenOp2(OPDivF);
     end;
    end;
   end;
   SymMOD:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    MustBe(TypeINT,x);
    MustBe(TypeINT,y);
    if v.IntegerValue<>0 then begin
     result.IntegerValue:=result.IntegerValue mod v.IntegerValue;
    end else begin
     Optimizable:=false;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     GenOp2(OPMod);
    end;
   end;
   SymAND:begin
    if x<>TypeBOOL then begin
     MustBe(TypeINT,x);
    end;
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    if y<>TypeBOOL then begin
     MustBe(TypeINT,y);
    end;
    MustBe(x,y);
    if x=TypeBOOL then begin
     result.IntegerValue:=(result.IntegerValue and v.IntegerValue) and 1;
    end else begin
     result.IntegerValue:=result.IntegerValue and v.IntegerValue;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     if x=TypeBOOL then begin
      GenOp2(OPAndB);
     end else begin
      GenOp2(OPAnd);
     end;
    end;
   end;
  end;
  MustBe(x,y);
 end;
end;

function TBeRoPascalScript.SimpleExpression(var x:longint;var Optimizable:boolean):TTermValue;
var y,OldCodePosition,OldStackPosition:longint;
    v:TTermValue;
begin
 if CurrentSymbol=TokPlus then begin
  GetSymbol;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  result:=Term(x,Optimizable);
  if x<>TypeFLOAT then begin
   MustBe(TypeINT,x);
  end;
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,result.IntegerValue);
  end;
 end else if CurrentSymbol=TokMinus then begin
  GetSymbol;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  result:=Term(x,Optimizable);
  if x=TypeFLOAT then begin
   result.FloatValue:=-result.FloatValue;
  end else begin
   MustBe(TypeINT,x);
   result.IntegerValue:=-result.IntegerValue;
  end;
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,result.IntegerValue);
  end else begin
   if x=TypeFLOAT then begin
    GenOp2(OPNegF);
   end else begin
    GenOp2(OPNeg);
   end;
  end;
 end else begin
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  result:=Term(x,Optimizable);
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,result.IntegerValue);
  end;
 end;
 while (CurrentSymbol=SymOR) or (CurrentSymbol=SymXOR) or (CurrentSymbol=TokPlus) or (CurrentSymbol=TokMinus) do begin
  if Errors>0 then exit;
  case CurrentSymbol of
   TokPlus:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Term(y,Optimizable);
    if Optimizable then begin
     if (result.ValueType=TypeINT) and (v.ValueType=TypeINT) then begin
      result.IntegerValue:=result.IntegerValue+v.IntegerValue;
      result.ValueType:=TypeINT;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      result.FloatValue:=result.IntegerValue+v.FloatValue;
      result.ValueType:=TypeFLOAT;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      result.FloatValue:=result.FloatValue+v.IntegerValue;
      result.ValueType:=TypeFLOAT;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      result.FloatValue:=result.FloatValue+v.FloatValue;
      result.ValueType:=TypeFLOAT;
     end else begin
      Optimizable:=false;
     end;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
     x:=result.ValueType;
     y:=result.ValueType;
    end else begin
     if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      GenOp(OPINTTOFLOAT,0);
      GenOp2(OPAddF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      GenOp(OPINTTOFLOAT,4);
      GenOp2(OPAddF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      GenOp2(OPAddF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else begin
      MustBe(TypeINT,x);
      MustBe(TypeINT,y);
      GenOp2(OPAdd);
      result.ValueType:=TypeINT;
     end;
    end;
   end;
   TokMinus:begin
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Term(y,Optimizable);
    if Optimizable then begin
     if (result.ValueType=TypeINT) and (v.ValueType=TypeINT) then begin
      result.IntegerValue:=result.IntegerValue-v.IntegerValue;
      result.ValueType:=TypeINT;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      result.FloatValue:=result.IntegerValue-v.FloatValue;
      result.ValueType:=TypeFLOAT;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      result.FloatValue:=result.FloatValue-v.IntegerValue;
      result.ValueType:=TypeFLOAT;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      result.FloatValue:=result.FloatValue-v.FloatValue;
      result.ValueType:=TypeFLOAT;
     end else begin
      Optimizable:=false;
     end;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
     x:=result.ValueType;
     y:=result.ValueType;
    end else begin
     if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeINT) then begin
      GenOp(OPINTTOFLOAT,0);
      GenOp2(OPSubF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeINT) and (v.ValueType=TypeFLOAT) then begin
      GenOp(OPINTTOFLOAT,4);
      GenOp2(OPSubF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else if (result.ValueType=TypeFLOAT) and (v.ValueType=TypeFLOAT) then begin
      GenOp2(OPSubF);
      result.ValueType:=TypeFLOAT;
      x:=result.ValueType;
      y:=result.ValueType;
     end else begin
      MustBe(TypeINT,x);
      MustBe(TypeINT,y);
      GenOp2(OPSub);
      result.ValueType:=TypeINT;
     end;
    end;
   end;
   SymOR:begin
    if x<>TypeBOOL then begin
     MustBe(TypeINT,x);
    end;
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    if y<>TypeBOOL then begin
     MustBe(TypeINT,y);
    end;
    MustBe(x,y);
    if x=TypeBOOL then begin
     result.IntegerValue:=(result.IntegerValue or v.IntegerValue) and 1;
    end else begin
     result.IntegerValue:=result.IntegerValue or v.IntegerValue;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     if x=TypeBOOL then begin
      GenOp2(OPOrB);
     end else begin
      GenOp2(OPOr);
     end;
    end;
   end;
   SymXOR:begin
    if x<>TypeBOOL then begin
     MustBe(TypeINT,x);
    end;
    GetSymbol;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    v:=Factor(y,Optimizable);
    if y<>TypeBOOL then begin
     MustBe(TypeINT,y);
    end;
    MustBe(x,y);
    if x=TypeBOOL then begin
     result.IntegerValue:=(result.IntegerValue xor v.IntegerValue) and 1;
    end else begin
     result.IntegerValue:=result.IntegerValue xor v.IntegerValue;
    end;
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     GenOp(OPLdC,result.IntegerValue);
    end else begin
     if x=TypeBOOL then begin
      GenOp2(OPXorB);
     end else begin
      GenOp2(OPXor);
     end;
    end;
   end;
  end;
  MustBe(x,y);
 end;
end;

function TBeRoPascalScript.Expression(var x:longint;var Optimizable:boolean):TTermValue;
var O,y,OldCodePosition,OldStackPosition:longint;
    v:TTermValue;
begin
 OldCodePosition:=CodePosition;
 OldStackPosition:=StackPosition;
 result:=SimpleExpression(x,Optimizable);
 if Optimizable then begin
  CodePosition:=OldCodePosition;
  StackPosition:=OldStackPosition;
  GenOp(OPLdC,result.IntegerValue);
 end;
 if (CurrentSymbol=TokEql) or (CurrentSymbol=TokNEq) or (CurrentSymbol=TokLss) or (CurrentSymbol=TokLEq) or (CurrentSymbol=TokGtr) or (CurrentSymbol=TokGEq) then begin
  if (x=TypeSTR) or (TypeTab[x].Kind<>KindSIMPLE) then begin
   Error(126);
  end;
  O:=CurrentSymbol;
  GetSymbol;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  v:=SimpleExpression(y,Optimizable);
  if (x=TypeSTR) and (y=TypeSTR) then begin
   Error(126);
{  Optimizable:=false;
   case O of
    TokEql:GenOp2(OPEqlString);
    TokNEq:GenOp2(OPNEqString);
    TokLss:GenOp2(OPLssString);
    TokLEq:GenOp2(OPLEqString);
    TokGtr:GenOp2(OPGtrString);
    TokGEq:GenOp2(OPGEqString);
   end;}
   result.ValueType:=y;
   result.IntegerValue:=0;
  end else begin
   if (x in [TypeINT,TypeCHAR,TypeBOOL]) and (y in [TypeINT,TypeCHAR,TypeBOOL]) then begin
    MustBe(x,y);
    case O of
     TokEql:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.IntegerValue=v.IntegerValue);
      end;
      GenOp2(OPEql);
     end;
     TokNEq:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.IntegerValue<>v.IntegerValue);
      end;
      GenOp2(OPNEq);
     end;
     TokLss:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.IntegerValue<v.IntegerValue);
      end;
      GenOp2(OPLss);
     end;
     TokLEq:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.IntegerValue<=v.IntegerValue);
      end;
      GenOp2(OPLeq);
     end;
     TokGtr:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.IntegerValue>v.IntegerValue);
      end;
      GenOp2(OPGtr);
     end;
     TokGEq:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.IntegerValue>=v.IntegerValue);
      end;
      GenOp2(OPGEq);
     end;
    end;
   end else if ((x=TypeFLOAT) or (y=TypeFLOAT)) and ((x in [TypeINT,TypeFLOAT]) and (y in [TypeINT,TypeFLOAT])) then begin
    if x=TypeINT then begin
     GenOp(OPINTTOFLOAT,4);
     result.FloatValue:=result.IntegerValue;
     result.ValueType:=TypeFLOAT;
    end;
    if y=TypeINT then begin
     GenOp(OPINTTOFLOAT,0);
     v.FloatValue:=v.IntegerValue;
     v.ValueType:=TypeFLOAT;
    end;
    case O of
     TokEql:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.FloatValue=v.FloatValue);
      end;
      GenOp2(OPEqlF);
     end;
     TokNEq:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.FloatValue<>v.FloatValue);
      end;
      GenOp2(OPNEqF);
     end;
     TokLss:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.FloatValue<v.FloatValue);
      end;
      GenOp2(OPLssF);
     end;
     TokLEq:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.FloatValue<=v.FloatValue);
      end;
      GenOp2(OPLeqF);
     end;
     TokGtr:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.FloatValue>v.FloatValue);
      end;
      GenOp2(OPGtrF);
     end;
     TokGEq:begin
      if Optimizable then begin
       result.IntegerValue:=ord(result.FloatValue>=v.FloatValue);
      end;
      GenOp2(OPGEqF);
     end;
    end;
   end else begin
    MustBe(x,y);
   end;
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,result.IntegerValue);
   end;
  end;
  x:=TypeBOOL;
  result.ValueType:=x;
 end;
end;

procedure TBeRoPascalScript.ResizeLoopStack;
var i:longint;
begin
 if LoopStackCount>=length(LoopStack) then begin
  setlength(LoopStack,LoopStackCount+128);
  for i:=LoopStackCount to length(LoopStack)-1 do begin
   fillchar(LoopStack[i],sizeof(TLoopStackItem),#0);
  end;
 end;
end;

procedure TBeRoPascalScript.AdjustLoop(BreakLabel,ContinueLabel:longint);
var Item:PLoopStackItem;
    i:longint;
begin
 if LoopStackCount>0 then begin
  ResizeLoopStack;
  Item:=@LoopStack[LoopStackCount-1];
  for i:=0 to Item^.BreakCount-1 do begin
   Code[Item^.Breaks[i]+1]:=BreakLabel;
  end;
  for i:=0 to Item^.ContinueCount-1 do begin
   Code[Item^.Continues[i]+1]:=ContinueLabel;
  end;
  setlength(Item^.Breaks,0);
  setlength(Item^.Continues,0);
 end;
end;

procedure TBeRoPascalScript.AddLoopBreak;
var Item:PLoopStackItem;
begin
 if LoopStackCount>0 then begin
  ResizeLoopStack;
  Item:=@LoopStack[LoopStackCount-1];
  inc(Item^.BreakCount);
  if Item^.BreakCount>=length(Item^.Breaks) then begin
   setlength(Item^.Breaks,Item^.BreakCount+128);
  end;
  Item^.Breaks[Item^.BreakCount-1]:=CodeLabel;
  GenOp(OPJmp,0);
 end;
end;

procedure TBeRoPascalScript.AddLoopContinue;
var Item:PLoopStackItem;
begin
 if LoopStackCount>0 then begin
  ResizeLoopStack;
  Item:=@LoopStack[LoopStackCount-1];
  inc(Item^.ContinueCount);
  if Item^.ContinueCount>=length(Item^.Continues) then begin
   setlength(Item^.Continues,Item^.ContinueCount+128);
  end;
  Item^.Continues[Item^.ContinueCount-1]:=CodeLabel;
  GenOp(OPJmp,0);
 end;
end;

procedure TBeRoPascalScript.Statement;
var l:array of longint;
    M,N,I,J,t,x,R,OldStackPos,VA,VB,V,OldCodePosition,OldStackPosition,cl,bl:longint;
    w:TTermValue;
    Optimizable:boolean;
begin
 l:=nil;
 if CurrentSymbol=SymRESULT then begin
  if (CurrentFunctionIdent<1) or not IdentTab[CurrentFunctionIdent].Inside then begin
   Error(127);
  end;
  GetSymbol;
  Expect(TokAssign);
  Optimizable:=true;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  w:=Expression(x,Optimizable);
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   if (IdentTab[CurrentFunctionIdent].TypeDef=TypeFLOAT) and (x=TypeINT) then begin
    x:=TypeFLOAT;
    w.FloatValue:=w.IntegerValue;
    w.ValueType:=x;
   end;
   GenOp(OPLdC,w.IntegerValue);
  end else begin
   if (IdentTab[CurrentFunctionIdent].TypeDef=TypeFLOAT) and (x=TypeINT) then begin
    GenOp(OpINTTOFLOAT,0);
    x:=TypeFLOAT;
   end;
  end;
  MustBe(IdentTab[CurrentFunctionIdent].TypeDef,x);
  GenAddress(IdentTab[CurrentFunctionIdent].FLevel+1,IdentTab[CurrentFunctionIdent].ReturnAddress);
  GenOp2(OPStore);
 end else if CurrentSymbol=TokIdent then begin
  I:=Position;
  case IdentTab[I].Kind of
   IdVAR:begin
    Selector(t,I);
    Expect(TokAssign);
    Optimizable:=true;
    OldCodePosition:=CodePosition;
    OldStackPosition:=StackPosition;
    w:=Expression(x,Optimizable);
    if Optimizable then begin
     CodePosition:=OldCodePosition;
     StackPosition:=OldStackPosition;
     if (t=TypeFLOAT) and (x=TypeINT) then begin
      x:=TypeFLOAT;
      w.FloatValue:=w.IntegerValue;
      w.ValueType:=x;
     end;
     GenOp(OPLdC,w.IntegerValue);
    end else begin
     if (t=TypeFLOAT) and (x=TypeINT) then begin
      GenOp(OpINTTOFLOAT,0);
      x:=TypeFLOAT;
     end;
    end;
    MustBe(t,x);
    if I=0 then begin
     GenOp2(OPSwap);
    end else begin
     GenAddressVar(I);
    end;
    if TypeTab[t].Kind=KindSIMPLE then begin
     GenOp2(OPStore);
    end else begin
     GenOp(OPMove,TypeTab[t].Size);
    end;
   end;
   IdFUNC:begin
    PushLexerState;
    GetSymbol;
    if CurrentSymbol=TokASSIGN then begin
     PopLexerState;
     if IdentTab[I].Inside then begin
      Expect(TokAssign);
      Optimizable:=true;
      OldCodePosition:=CodePosition;
      OldStackPosition:=StackPosition;
      w:=Expression(x,Optimizable);
      if Optimizable then begin
       CodePosition:=OldCodePosition;
       StackPosition:=OldStackPosition;
       if (IdentTab[I].TypeDef=TypeFLOAT) and (x=TypeINT) then begin
        x:=TypeFLOAT;
        w.FloatValue:=w.IntegerValue;
        w.ValueType:=x;
       end;
       GenOp(OPLdC,w.IntegerValue);
      end else begin
       if (IdentTab[I].TypeDef=TypeFLOAT) and (x=TypeINT) then begin
        GenOp(OpINTTOFLOAT,0);
        x:=TypeFLOAT;
       end;
      end;
      MustBe(IdentTab[I].TypeDef,x);
      GenAddress(IdentTab[I].FLevel+1,IdentTab[I].ReturnAddress);
      GenOp2(OPStore);
     end else begin
      Error(128);
     end;
    end else begin
     RestoreLexerState;
     Optimizable:=true;
     FunctionCall(I,Optimizable);
    end;
   end;
   IdCONST,IdFIELD,IdTYPE:begin
    Error(129);
   end;
  end;
 end else if CurrentSymbol=SymIF then begin
  GetSymbol;
  Optimizable:=true;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  w:=Expression(t,Optimizable);
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,w.IntegerValue);
  end;
  MustBe(TypeBOOL,t);
  Expect(SymTHEN);
  I:=CodeLabel;
  GenOp(OPJZ,0);
  Statement;
  if CurrentSymbol=SymELSE then begin
   GetSymbol;
   J:=CodeLabel;
   GenOp(OPJmp,0);
   Code[I+1]:=CodeLabel;
   I:=J;
   Statement;
  end;
  Code[I+1]:=CodeLabel;
 end else if CurrentSymbol=SymCASE then begin
  GetSymbol;
  Optimizable:=true;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  w:=Expression(t,Optimizable);
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,w.IntegerValue);
  end;
  MustBeOrdinal(t);
  Expect(SymOF);
  J:=0;
  M:=0;
  repeat
   if J<>0 then begin
    Code[J+1]:=CodeLabel;
   end;
   N:=M;
   repeat
    if N<>M then GetSymbol;
    if CurrentSymbol=TokIdent then begin
     I:=Position;
     if IdentTab[I].Kind<>IdCONST then begin
      Error(130);
     end;
     VA:=IdentTab[I].Value;
    end else if CurrentSymbol=TokNumber then begin
     VA:=CurrentNumber;
    end else if (CurrentSymbol=TokStrC) and (CurrentStringLength=1) then begin
     VA:=ord(CurrentString[1]);
    end else begin
     VA:=0;
     Error(131);
    end;
    GetSymbol;
    if CurrentSymbol=TokDots then begin
     GetSymbol;
     if CurrentSymbol=TokIdent then begin
      I:=Position;
      if IdentTab[I].Kind<>IdCONST then begin
       Error(130);
      end;
      VB:=IdentTab[I].Value;
     end else if CurrentSymbol=TokNumber then begin
      VB:=CurrentNumber;
     end else if (CurrentSymbol=TokStrC) and (CurrentStringLength=1) then begin
      VB:=ord(CurrentString[1]);
     end else begin
      VB:=VA;
      Error(131);
     end;
     for V:=VA to VB do begin
      GenOp2(OPDupl);
      GenOp(OPLdC,V);
      GenOp2(OPNEq);
      N:=N+1;
      if N>=length(l) then begin
       setlength(l,N+1);
      end;
      l[N]:=CodeLabel;
      GenOp(OPJZ,0);
     end;
     GetSymbol;
    end else begin
     GenOp2(OPDupl);
     GenOp(OPLdC,VA);
     GenOp2(OPNEq);
     N:=N+1;
     if N>=length(l) then begin
      setlength(l,N+1);
     end;
     setlength(l,N+1);
     l[N]:=CodeLabel;
     GenOp(OPJZ,0);
    end;
   until CurrentSymbol<>TokComma;
   if CurrentSymbol<>TokColon then begin
    Error(132);
   end;
   J:=CodeLabel;
   GenOp(OPJmp,0);
   repeat
    if N>=length(l) then begin
     setlength(l,N+1);
    end;
    Code[l[N]+1]:=CodeLabel;
    N:=N-1;
   until N=M;
   GetSymbol;
   Statement;
   M:=M+1;
   if M>=length(l) then begin
    setlength(l,M+1);
   end;
   l[M]:=CodeLabel;
   GenOp(OPJmp,0);
   if CurrentSymbol=TokSemi then GetSymbol;
  until CurrentSymbol in [SymELSE,SymEND];
  Code[J+1]:=CodeLabel;
  if CurrentSymbol=SymELSE then begin
   GetSymbol;
   Statement;
   if CurrentSymbol=TokSemi then GetSymbol;
   Expect(SymEND);
  end;
  repeat
   if M>=length(l) then begin
    setlength(l,M+1);
   end;
   Code[l[M]+1]:=CodeLabel;
   M:=M-1;
  until M=0;
  GenOp(OPAdjS,4);
  GetSymbol;
  setlength(l,0);
 end else if CurrentSymbol=SymFOR then begin
  GetSymbol;
  if CurrentSymbol=TokIdent then begin
   inc(LoopStackCount);
   ResizeLoopStack;

   OldStackPos:=StackPosition;

   I:=Position;
   if IdentTab[I].Kind<>IdVAR then begin
    Error(133);
   end;
   Selector(t,I);
   Expect(TokAssign);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   w:=Expression(x,Optimizable);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,w.IntegerValue);
   end;
   MustBe(t,x);
   if I=0 then begin
    GenOp2(OPSwap);
   end else begin
    GenAddressVar(I);
   end;
   if TypeTab[t].Kind<>KindSIMPLE then begin
    Error(134);
   end;
   GenOp2(OPStore);

   R:=1;
   if CurrentSymbol=SymTO then begin
    Expect(SymTO);
   end else if CurrentSymbol=SymDOWNTO then begin
    Expect(SymDOWNTO);
    R:=-1;
   end else begin
    Error(135);
   end;

   J:=CodeLabel;
   if I=0 then begin
    GenOp2(OPSwap);
   end else begin
    GenAddressVar(I);
   end;
   GenOp2(OPLoad);
   Optimizable:=true;
   OldCodePosition:=CodePosition;
   OldStackPosition:=StackPosition;
   w:=Expression(x,Optimizable);
   if Optimizable then begin
    CodePosition:=OldCodePosition;
    StackPosition:=OldStackPosition;
    GenOp(OPLdC,w.IntegerValue);
   end;
   MustBe(t,x);
   if R>0 then begin
    GenOp2(OPLeq);
   end else begin
    GenOp2(OPGEq);
   end;
   N:=CodeLabel;
   GenOp(OPJZ,0);

   Expect(SymDO);

   Statement;

   cl:=CodeLabel;

   if I=0 then begin
    GenOp2(OPSwap);
   end else begin
    GenAddressVar(I);
   end;
   GenOp2(OPLoad);

   GenOp(OPAddC,R);

   if I=0 then begin
    GenOp2(OPSwap);
   end else begin
    GenAddressVar(I);
   end;
   GenOp2(OPStore);

   GenOp(OPJmp,J);
   Code[N+1]:=CodeLabel;

   bl:=CodeLabel;

   GenOp(OPAdjS,OldStackPos-StackPosition);

   AdjustLoop(bl,cl);

   dec(LoopStackCount);
  end else begin
   Expect(TokIdent);
  end;
 end else if CurrentSymbol=SymWHILE then begin
  GetSymbol;
  inc(LoopStackCount);
  ResizeLoopStack;
  I:=CodeLabel;
  cl:=CodeLabel;
  Optimizable:=true;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  w:=Expression(t,Optimizable);
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,w.IntegerValue);
  end;
  MustBe(TypeBOOL,t);
  Expect(SymDO);
  J:=CodeLabel;
  GenOp(OPJZ,0);
  Statement;
  GenOp(OPJmp,I);
  Code[J+1]:=CodeLabel;
  bl:=CodeLabel;
  AdjustLoop(bl,cl);
  dec(LoopStackCount);
 end else if CurrentSymbol=SymREPEAT then begin
  inc(LoopStackCount);
  ResizeLoopStack;
  I:=CodeLabel;
  repeat
   GetSymbol;
   Statement;
  until CurrentSymbol<>TokSemi;
  Expect(SymUNTIL);
  cl:=CodeLabel;
  Optimizable:=true;
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  w:=Expression(t,Optimizable);
  if Optimizable then begin
   CodePosition:=OldCodePosition;
   StackPosition:=OldStackPosition;
   GenOp(OPLdC,w.IntegerValue);
  end;
  MustBe(TypeBOOL,t);
  GenOp(OPJZ,I);
  bl:=CodeLabel;
  AdjustLoop(bl,cl);
  dec(LoopStackCount);
 end else if CurrentSymbol=SymBEGIN then begin
  repeat
   GetSymbol;
   Statement;
  until CurrentSymbol<>TokSemi;
  Expect(SymEND);
 end else if CurrentSymbol=SymHALT then begin
  GenOp2(OPHalt);
  GetSymbol;
 end else if CurrentSymbol=SymBREAK then begin
  AddLoopBreak;
  GetSymbol;
 end else if CurrentSymbol=SymCONTINUE then begin
  AddLoopContinue;
  GetSymbol;
 end else if CurrentSymbol=SymEXIT then begin
  GetSymbol;
  if CurrentLevel=0 then begin
   GenOp2(OPHalt);
  end else begin
   GenOp(OPADJS,FuncStackPosition-StackPosition);
   GenOp(OPJMP,FuncEndJmp);
  end;
 end;
end;

procedure TBeRoPascalScript.Constant(var c,t:longint);
var OldCodePosition,OldStackPosition:longint;
    Optimizable:boolean;
    v:TTermValue;
begin
 if (CurrentSymbol=TokStrC) and (CurrentStringLength=1) then begin
  c:=ord(CurrentString[1]);
  t:=TypeCHAR;
  GetSymbol;
 end else begin
  OldCodePosition:=CodePosition;
  OldStackPosition:=StackPosition;
  Optimizable:=true;
  v:=Expression(t,Optimizable);
  c:=v.IntegerValue;
  t:=v.ValueType;
  CodePosition:=OldCodePosition;
  StackPosition:=OldStackPosition;
  if not Optimizable then begin
   Error(137);
  end;
 end;
end;

procedure TBeRoPascalScript.ConstDeclaration;
var a:ansistring;
    t,c:longint;
begin
 a:=CurrentIdent;
 GetSymbol;
 Expect(TokEql);
 Constant(c,t);
 Expect(TokSemi);
 EnterSymbol(a,IdCONST,t);
 IdentTab[IdentPos].Value:=c;
end;

procedure TBeRoPascalScript.ArrayType(var t:longint);
var x:longint;
begin
 TypeTab[t].Kind:=KindARRAY;
 GetSymbol;
 Constant(TypeTab[t].StartIndex,x);
 MustBe(TypeINT,x);
 Expect(TokDots);
 Constant(TypeTab[t].EndIndex,x);
 MustBe(TypeINT,x);
 if TypeTab[t].StartIndex>TypeTab[t].EndIndex then begin
  Error(138);
 end;
 if CurrentSymbol=TokComma then begin
  ArrayType(TypeTab[t].SubType);
 end else begin
  Expect(TokRBracket);
  Expect(SymOF);
  TypeDef(TypeTab[t].SubType);
 end;
 TypeTab[t].Size:=(TypeTab[t].EndIndex-TypeTab[t].StartIndex+1)*TypeTab[TypeTab[t].SubType].Size;
end;

procedure TBeRoPascalScript.TypeDef(var t:longint);
var SZ,FT:longint;
 procedure ParseRecordLevel;
 var OldCodePosition,OldStackPosition,OldSZ,MaxSZ,x,y,i,j:longint;
     Optimizable:boolean;
     V:TTermValue;
 begin
  repeat
   if CurrentSymbol=SymCASE then begin
    GetSymbol;
    Check(TokIdent);
    i:=Position(false);
    if (i<1) or (IdentTab[i].Kind<>IdTYPE) then begin
     EnterSymbol(CurrentIdent,IdFIELD,0);
     I:=IdentPos;
     GetSymbol;
     J:=IdentPos;
     Expect(TokColon);
     TypeDef(y);
     repeat
      IdentTab[I].TypeDef:=y;
      IdentTab[I].Offset:=SZ;
      SZ:=SZ+TypeTab[y].Size;
      inc(I);
     until I>J;
    end else begin
     TypeDef(y);
    end;
    OldSZ:=SZ;
    MaxSZ:=SZ;
    if CurrentSymbol=SymOF then begin
     GetSymbol;
     while Errors=0 do begin
      Optimizable:=true;
      OldCodePosition:=CodePosition;
      OldStackPosition:=StackPosition;
      x:=y;
      v:=Expression(x,Optimizable);
      if not Optimizable then begin
       Error(139);
       break;
      end;
      CodePosition:=OldCodePosition;
      StackPosition:=OldStackPosition;
      MustBe(x,y);
      Expect(TokColon);
      Expect(TokLParent);
      SZ:=OldSZ;
      Check(TokIdent);
      ParseRecordLevel;
      if MaxSZ<SZ then begin
       MaxSZ:=SZ;
      end;
      Expect(TokRParent);
      if CurrentSymbol=TokSemi then begin
       GetSymbol;
       if CurrentSymbol in [SymEND,TokRParent] then begin
        break;
       end;
      end else begin
       if CurrentSymbol<>TokRParent then begin
        Check(SymEND);
        break;
       end;
      end;
     end;
    end else begin
     Check(SymOF);
    end;
    SZ:=MaxSZ;
    break;
   end else begin
    EnterSymbol(CurrentIdent,IdFIELD,0);
    I:=IdentPos;
    GetSymbol;
    while CurrentSymbol=TokComma do begin
     GetSymbol;
     Check(TokIdent);
     EnterSymbol(CurrentIdent,IdFIELD,0);
     GetSymbol;
    end;
    J:=IdentPos;
    Expect(TokColon);
    TypeDef(FT);
    repeat
     IdentTab[I].TypeDef:=FT;
     IdentTab[I].Offset:=SZ;
     SZ:=SZ+TypeTab[FT].Size;
     inc(I);
    until I>J;
    if CurrentSymbol=TokSemi then begin
     GetSymbol;
    end else begin
     if CurrentSymbol<>TokRParent then begin
      Check(SymEND);
     end;
    end;
   end;
  until CurrentSymbol<>TokIdent;
 end;
var i:integer;
begin
 if CurrentSymbol=SymPACKED then GetSymbol;
 if CurrentSymbol=TokIdent then begin
  I:=Position;
  if IdentTab[I].Kind<>IdTYPE then begin
   Error(140);
  end;
  t:=IdentTab[I].TypeDef;
  GetSymbol;
 end else begin
  inc(TypePos);
  if TypePos>=length(TypeTab) then begin
   setlength(TypeTab,(TypePos+2)*2);
  end;
  t:=TypePos;
  if CurrentSymbol=SymARRAY then begin
   GetSymbol;
   Check(TokLBracket);
   ArrayType(t);
  end else begin
   Expect(SymRECORD);
   inc(CurrentLevel);
   if (CurrentLevel+16)>=length(SymNameList) then begin
    setlength(SymNameList,(CurrentLevel+16)*2);
   end;
   SymNameList[CurrentLevel+1]:=0;
   SZ:=0;
   if CurrentSymbol<>SymCASE then begin
    Check(TokIdent);
   end;
   ParseRecordLevel;
   TypeTab[t].Size:=SZ;
   TypeTab[t].Kind:=KindRECORD;
   TypeTab[t].Fields:=SymNameList[CurrentLevel+1];
   dec(CurrentLevel);
   Expect(SymEND);
  end;
 end;
end;

procedure TBeRoPascalScript.TypeDeclaration;
var a:ansistring;
    t:longint;
begin
 a:=CurrentIdent;
 GetSymbol;
 Expect(TokEql);
 TypeDef(t);
 Expect(TokSemi);
 EnterSymbol(a,IdTYPE,t);
end;

procedure TBeRoPascalScript.VarDeclaration;
var p,Q,t,OverrideIdent:longint;
    DoOverrideStackPosition:boolean;
begin
 EnterSymbol(CurrentIdent,IdVAR,0);
 p:=IdentPos;
 GetSymbol;
 while CurrentSymbol=TokComma do begin
  GetSymbol;
  Check(TokIdent);
  EnterSymbol(CurrentIdent,IdVAR,0);
  GetSymbol;
 end;
 Q:=IdentPos;
 Expect(TokColon);
 TypeDef(t);
 DoOverrideStackPosition:=false;
 OverrideIdent:=0;
 if CurrentSymbol=SymABSOLUTE then begin
  GetSymbol;
  Check(TokIdent);
  OverrideIdent:=Position;
  GetSymbol;
  DoOverrideStackPosition:=true;
 end;
 Expect(TokSemi);
 repeat
  IdentTab[p].VLevel:=CurrentLevel;
  if DoOverrideStackPosition then begin
   if IdentTab[OverrideIdent].VLevel<>CurrentLevel then begin
    Error(141);
   end;
   IdentTab[p].VAdr:=IdentTab[OverrideIdent].VAdr;
   IdentTab[p].RefPar:=IdentTab[OverrideIdent].RefPar;
   if TypeTab[t].Size>TypeTab[IdentTab[OverrideIdent].TypeDef].Size then begin
    Error(142);
   end;
  end else begin
   dec(StackPosition,TypeTab[t].Size);
   if StackPosition<MinimumStackPosition then begin
    MinimumStackPosition:=StackPosition;
   end;
   IdentTab[p].VAdr:=StackPosition;
   IdentTab[p].RefPar:=false;
  end;
  IdentTab[p].TypeDef:=t;
  inc(p);
 until p>Q;
end;

procedure TBeRoPascalScript.NewParameter(var p,ps:longint);
var R:boolean;
    t:longint;
begin
 if CurrentSymbol=SymVAR then begin
  R:=true;
  GetSymbol;
 end else begin
  R:=false;
 end;
 Check(TokIdent);
 p:=IdentPos;
 EnterSymbol(CurrentIdent,IdVAR,0);
 GetSymbol;
 while CurrentSymbol=TokComma do begin
  GetSymbol;
  Check(TokIdent);
  EnterSymbol(CurrentIdent,IdVAR,0);
  GetSymbol;
 end;
 Expect(TokColon);
 Check(TokIdent);
 TypeDef(t);
 while p<IdentPos do begin
  p:=p+1;
  IdentTab[p].TypeDef:=t;
  IdentTab[p].RefPar:=R;
  if R then begin
   ps:=ps+4;
  end else begin
   ps:=ps+TypeTab[t].Size;
  end;
 end;
end;

procedure TBeRoPascalScript.FunctionDeclaration(IsFunction:boolean);
var F,p,ps,P1,P2,OldStackPos,OldFuncDecl,OldCurrentFunctionIdent,OldFuncStackPosition,OldFuncEndJmp:longint;
begin
 GetSymbol;
 Check(TokIdent);
 OldFuncDecl:=FuncDecl;
 OldCurrentFunctionIdent:=CurrentFunctionIdent;
 OldFuncStackPosition:=FuncStackPosition;
 OldFuncEndJmp:=FuncEndJmp;
 FuncDecl:=-1;
 EnterSymbol(CurrentIdent,IdFUNC,0);
 GetSymbol;
 F:=IdentPos;
 IdentTab[F].FLevel:=CurrentLevel;
 IdentTab[F].FAdr:=CodeLabel;
 CurrentFunctionIdent:=F;
 GenOp(OPJmp,0);
 inc(CurrentLevel);
 if (CurrentLevel+16)>=length(SymNameList) then begin
  setlength(SymNameList,(CurrentLevel+16)*2);
 end;
 SymNameList[CurrentLevel+1]:=0;
 ps:=4;
 OldStackPos:=StackPosition;
 if CurrentSymbol=TokLParent then begin
  repeat
   GetSymbol;
   NewParameter(p,ps);
  until CurrentSymbol<>TokSemi;
  Expect(TokRParent);
 end;
 if CurrentLevel>1 then begin
  StackPosition:=-4;
  if StackPosition<MinimumStackPosition then begin
   MinimumStackPosition:=StackPosition;
  end;
 end else begin
  StackPosition:=0;
 end;
 IdentTab[F].ReturnAddress:=ps;
 p:=F;
 while p<IdentPos do begin
  p:=p+1;
  if IdentTab[p].RefPar then begin
   ps:=ps-4;
  end else begin
   ps:=ps-TypeTab[IdentTab[p].TypeDef].Size;
  end;
  IdentTab[p].VLevel:=CurrentLevel;
  IdentTab[p].VAdr:=ps;
 end;
 if IsFunction then begin
  Expect(TokColon);
  Check(TokIdent);
  TypeDef(IdentTab[F].TypeDef);
  if TypeTab[IdentTab[F].TypeDef].Kind<>KindSIMPLE then begin
   Error(143);
  end;
 end;
 Expect(TokSemi);
 IdentTab[F].LastParameter:=IdentPos;
 if CurrentSymbol<>SymFORWARD then begin
  if FuncDecl>=0 then begin
   P1:=FuncDecl+1;
   P2:=F+1;
   while P1<=IdentTab[FuncDecl].LastParameter do begin
    if P2>IdentTab[F].LastParameter then begin
     Error(144);
    end;
    if IdentTab[P1].name<>IdentTab[P2].name then begin
     Error(145);
    end;
    if IdentTab[P1].TypeDef<>IdentTab[P2].TypeDef then begin
     Error(146);
    end;
    if IdentTab[P1].RefPar<>IdentTab[P2].RefPar then begin
     Error(147);
    end;
    inc(P1);
    inc(P2);
   end;
   if P2<=IdentTab[F].LastParameter then begin
    Error(148);
   end;
  end;
  P1:=CodePosition;
  FuncEndJmp:=CodePosition;
  GenOp(OPJMP,0);
  IdentTab[F].Inside:=true;
  Block(IdentTab[F].FAdr);
  IdentTab[F].Inside:=false;
  Code[P1+1]:=CodePosition;
  GenOp(OPLeave,IdentTab[F].ReturnAddress-StackPosition);
 end else begin
  if FuncDecl>=0 then begin
   Error(149);
  end;
  GetSymbol;
 end;
 dec(CurrentLevel);
 StackPosition:=OldStackPos;
 FuncDecl:=OldFuncDecl;
 CurrentFunctionIdent:=OldCurrentFunctionIdent;
 FuncStackPosition:=OldFuncStackPosition;
 FuncEndJmp:=OldFuncEndJmp;
 Expect(TokSemi);
end;

procedure TBeRoPascalScript.Block(l:longint);
var I,D,OldStackPos,OldIdentPos:longint;
begin
 OldStackPos:=StackPosition;
 OldIdentPos:=IdentPos;
 while (CurrentSymbol=SymCONST) or (CurrentSymbol=SymTYPE) or (CurrentSymbol=SymVAR) or (CurrentSymbol=SymFUNC) or (CurrentSymbol=SymPROC) do begin
  if CurrentSymbol=SymCONST then begin
   GetSymbol;
   Check(TokIdent);
   while CurrentSymbol=TokIdent do ConstDeclaration;
  end else if CurrentSymbol=SymTYPE then begin
   GetSymbol;
   Check(TokIdent);
   while CurrentSymbol=TokIdent do TypeDeclaration;
  end else if CurrentSymbol=SymVAR then begin
   GetSymbol;
   Check(TokIdent);
   while CurrentSymbol=TokIdent do VarDeclaration;
  end else if (CurrentSymbol=SymFUNC) or (CurrentSymbol=SymPROC) then begin
   FunctionDeclaration(CurrentSymbol=SymFUNC);
  end;
 end;
 if l+1=CodeLabel then begin
  CodePosition:=CodePosition-1;
 end else begin
  Code[l+1]:=CodeLabel;
 end;
 if CurrentLevel=0 then begin
  GenOp(OPAdjS,StackPosition);
 end else begin
  D:=StackPosition-OldStackPos;
  StackPosition:=OldStackPos;
  GenOp(OPAdjS,D);
  FuncStackPosition:=StackPosition;
 end;
 Statement;
 if CurrentLevel<>0 then GenOp(OPAdjS,OldStackPos-StackPosition);
 I:=OldIdentPos+1;
 while I<=IdentPos do begin
  if IdentTab[I].Kind=IdFUNC then begin
   if (Code[IdentTab[I].FAdr]=OPJmp) and (Code[IdentTab[I].FAdr+1]=0) then begin
    Error(150);
   end;
  end;
  I:=I+1;
 end;
 IdentPos:=OldIdentPos;
end;

function TBeRoPascalScript.Compile(ASource:ansistring):boolean;
var i:longint;
{$ifdef cpu386}
    OldFCW:word;
{$endif}
begin
{$ifdef cpu386}
 asm
  fstcw word ptr OldFCW
  fldcw word ptr VMFCW
 end;
{$endif}
 Errors:=0;
 try
  setlength(Code,0);
  setlength(IdentTab,0);
  setlength(SymNameList,4096);

  setlength(LexerStates,0);
  LexerStatePos:=-1;

  Source:=ASource;
  SourcePosition:=0;

  Keywords[SymBEGIN]:='BEGIN';
  Keywords[SymEND]:='END';
  Keywords[SymIF]:='IF';
  Keywords[SymTHEN]:='THEN';
  Keywords[SymELSE]:='ELSE';
  Keywords[SymWHILE]:='WHILE';
  Keywords[SymDO]:='DO';
  Keywords[SymCASE]:='CASE';
  Keywords[SymREPEAT]:='REPEAT';
  Keywords[SymUNTIL]:='UNTIL';
  Keywords[SymFOR]:='FOR';
  Keywords[SymTO]:='TO';
  Keywords[SymDOWNTO]:='DOWNTO';
  Keywords[SymNOT]:='NOT';
  Keywords[SymDIV]:='DIV';
  Keywords[SymMOD]:='MOD';
  Keywords[SymAND]:='AND';
  Keywords[SymOR]:='OR';
  Keywords[SymXOR]:='XOR';
  Keywords[SymCONST]:='CONST';
  Keywords[SymVAR]:='VAR';
  Keywords[SymTYPE]:='TYPE';
  Keywords[SymARRAY]:='ARRAY';
  Keywords[SymOF]:='OF';
  Keywords[SymPACKED]:='PACKED';
  Keywords[SymRECORD]:='RECORD';
  Keywords[SymPROGRAM]:='PROGRAM';
  Keywords[SymFORWARD]:='FORWARD';
  Keywords[SymHALT]:='HALT';
  Keywords[SymFUNC]:='FUNCTION';
  Keywords[SymPROC]:='PROCEDURE';
  Keywords[SymBREAK]:='BREAK';
  Keywords[SymCONTINUE]:='CONTINUE';
  Keywords[SymRESULT]:='RESULT';
  Keywords[SymABSOLUTE]:='ABSOLUTE';
  Keywords[SymEXIT]:='EXIT';
  Keywords[SymSHL]:='SHL';
  Keywords[SymSHR]:='SHR';

  setlength(TypeTab,16);

  TypeTab[TypeINT].Size:=4;
  TypeTab[TypeINT].Kind:=KindSIMPLE;
  TypeTab[TypeCHAR].Size:=4;
  TypeTab[TypeCHAR].Kind:=KindSIMPLE;
  TypeTab[TypeBOOL].Size:=4;
  TypeTab[TypeBOOL].Kind:=KindSIMPLE;
  TypeTab[TypeFLOAT].Size:=4;
  TypeTab[TypeFLOAT].Kind:=KindSIMPLE;
  TypeTab[TypeSTR].Size:=0;
  TypeTab[TypeSTR].Kind:=KindSIMPLE;
  TypePos:=5;

  SymNameList[0]:=0;
  CurrentLevel:=-1;
  IdentPos:=0;
  CurrentFunctionIdent:=-1;
  FuncDecl:=-1;

  EnterSymbol('FALSE',IdCONST,TypeBOOL);
  IdentTab[IdentPos].Value:=ord(false);

  EnterSymbol('TRUE',IdCONST,TypeBOOL);
  IdentTab[IdentPos].Value:=ord(true);

  EnterSymbol('MAXINT',IdCONST,TypeINT);
  IdentTab[IdentPos].Value:=2147483647;

  EnterSymbol('PI',IdCONST,TypeFLOAT);
  single(pointer(@IdentTab[IdentPos].Value)^):=3.1415926535897932385;

  EnterSymbol('E',IdCONST,TypeFLOAT);
  single(pointer(@IdentTab[IdentPos].Value)^):=2.7182818284590452353;

  EnterSymbol('LN2',IdCONST,TypeFLOAT);
  single(pointer(@IdentTab[IdentPos].Value)^):=ln(2);

  EnterSymbol('LN10',IdCONST,TypeFLOAT);
  single(pointer(@IdentTab[IdentPos].Value)^):=ln(10);

  EnterSymbol('LN16',IdCONST,TypeFLOAT);
  single(pointer(@IdentTab[IdentPos].Value)^):=ln(16);

  EnterSymbol('INTEGER',IdTYPE,TypeINT);
  EnterSymbol('LONGINT',IdTYPE,TypeINT);
  EnterSymbol('CHAR',IdTYPE,TypeCHAR);
  EnterSymbol('BOOLEAN',IdTYPE,TypeBOOL);
  EnterSymbol('SINGLE',IdTYPE,TypeFLOAT);
  EnterSymbol('REAL',IdTYPE,TypeFLOAT);

  EnterSymbol('CHR',IdFUNC,TypeCHAR);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionCHR;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ORD',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionORD;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('WRITE',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionWRITE;

  EnterSymbol('WRITELN',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionWRITELN;

  EnterSymbol('READ',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionREAD;

  EnterSymbol('READLN',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionREADLN;

  EnterSymbol('EOF',IdFUNC,TypeBOOL);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionEOF;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('EOLN',IdFUNC,TypeBOOL);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionEOFLN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('DEC',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionDEC;

  EnterSymbol('INC',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionINC;

  EnterSymbol('TRUNC',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionTRUNC;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ROUND',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionROUND;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ABS',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionABS;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SQR',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSQR;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SQRT',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSQRT;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SIN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSIN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('COS',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionCOS;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('EXP',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionEXP;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('LN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionLN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('FRAC',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionFRAC;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ODD',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionODD;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SUCC',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSUCC;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('PRED',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionPRED;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('TAN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionTAN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ISNAN',IdFUNC,TypeBOOL);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionISNAN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ISINF',IdFUNC,TypeBOOL);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionISINF;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('CEIL',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionCEIL;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('FLOOR',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionFLOOR;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCTAN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCTAN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCTAN2',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCTAN2;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCSIN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCSIN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCCOS',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCCOS;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('HYPOT',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionHYPOT;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('LOG2',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionLOG2;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('LOG10',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionLOG10;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('LOGN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionLOGN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('COSH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionCOSH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SINH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSINH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('TANH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionTANH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCCOSH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCCOSH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCSINH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCSINH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCTANH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCTANH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('POWER',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionPOWER;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('POW',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionPOWER;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('COTANH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionCOTANH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SECANTH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSECANTH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('COSECANTH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionCOSECANTH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCCOTAN',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCCOTAN;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCSECANT',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCSECANT;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCCOSECANT',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCCOSECANT;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCCOTANH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCCOTANH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCSECANTH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCSECANTH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('ARCCOSECANTH',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionARCCOSECANTH;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('RANDOM',IdFUNC,TypeFLOAT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionRANDOM;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('RANDOMIZE',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionRANDOMIZE;

  EnterSymbol('SARLONGINT',IdFUNC,TypeINT);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSARLONGINT;
  IdentTab[IdentPos].Inside:=false;

  EnterSymbol('SETSAMPLELENGTH',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSETSAMPLELENGTH;

  EnterSymbol('SETSAMPLECHANNELS',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSETSAMPLECHANNELS;

  EnterSymbol('SETSAMPLERATE',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSETSAMPLERATE;

  EnterSymbol('SETSAMPLE',IdFUNC,0);
  IdentTab[IdentPos].FLevel:=-1;
  IdentTab[IdentPos].FAdr:=FunctionSETSAMPLE;

  SymNameList[1]:=0;
  CurrentLevel:=0;
  LoopStackCount:=0;
  LoopStack:=nil;

  LineNumber:=1;
  LinePosition:=0;

  ReadChar;
  GetSymbol;
  IsLabeled:=true;
  CodePosition:=0;
  LastOpcode:=-1;
  StackPosition:=4;
  MinimumStackPosition:=0;
  Expect(SymPROGRAM);
  Expect(TokIdent);
  Expect(TokSemi);
  GenOp(OPJmp,0);
  Block(0);
  GenOp2(OPHalt);
  Check(TokPeriod);
  result:=Errors=0;
 finally
  for i:=0 to length(LoopStack)-1 do begin
   setlength(LoopStack[i].Continues,0);
   setlength(LoopStack[i].Breaks,0);
  end;
  setlength(LoopStack,0);
  setlength(Code,CodePosition);
  setlength(IdentTab,0);
  setlength(TypeTab,0);
  setlength(SymNameList,0);
  setlength(LexerStates,0);
{$ifdef cpu386}
  asm
   fldcw word ptr OldFCW
  end;
{$endif}
 end;
end;

function TBeRoPascalScript.CompileFile(ASourceFile:ansistring):boolean;
var f:file;
    s:ansistring;
begin
 result:=false;
 try
  FileName:=ASourceFile;
  assignfile(f,ASourceFile);
  {$i-}reset(f,1);{$i+}
  if ioresult=0 then begin
   setlength(s,filesize(f));
   blockread(f,s[1],length(s));
   closefile(f);
   result:=Compile(s);
  end;
 except
 end;
end;

procedure TBeRoPascalScript.Run;
{$ifndef fpc}
type ptruint=NativeUInt;
{$endif}
var DP,SP,PC,i,MaxMemory,MemoryMask,RandomSeed:longint;
    v:longint;
    c:ansichar;
    OriginalMemory,Memory:pansichar;
{$ifdef cpu386}
    OldFCW:word;
{$endif}
begin
{$ifdef cpu386}
 asm
  fstcw word ptr OldFCW
  fldcw word ptr VMFCW
 end;
{$endif}
 SampleLength:=0;
 SampleChannels:=1;
 SampleRate:=44100;
 setlength(Sample,0);
 v:=65536+abs(MinimumStackPosition);
 MaxMemory:=1;
 while MaxMemory<=v do begin
  inc(MaxMemory,MaxMemory);
 end;
 MemoryMask:=MaxMemory-1;
 GetMem(OriginalMemory,MaxMemory+32);
 FillChar(OriginalMemory^,MaxMemory+32,#0);
 RandomSeed:=$1337c0d3 xor MaxMemory;
 ptruint(Memory):=ptruint(ptruint(ptruint(OriginalMemory)+$f) and not $f);
 DP:=MaxMemory;
 SP:=MaxMemory;
 PC:=0;
 i:=0;
 try
  while (PC<CodePosition) and (i<$7fffffff) do begin
   inc(i);
   inc(PC);
   case Code[PC-1] of
    OPAdd:begin
     inc(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPSub:begin
     dec(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPNeg:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=-longint(pointer(@Memory[SP and MemoryMask])^);
    end;
    OPMul:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)*longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPDiv:begin
     if longint(pointer(@Memory[SP and MemoryMask])^)<>0 then begin
      longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) div longint(pointer(@Memory[SP and MemoryMask])^);
     end else begin
      longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=0;
     end;
     inc(SP,sizeof(longint));
    end;
    OPMod:begin
     if longint(pointer(@Memory[SP and MemoryMask])^)<>0 then begin
      longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) mod longint(pointer(@Memory[SP and MemoryMask])^);
     end else begin
      longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=0;
     end;
     inc(SP,sizeof(longint));
    end;
    OPDiv2:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[SP and MemoryMask])^) div 2;
    end;
    OPMod2:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[SP and MemoryMask])^) mod 2;
    end;
    OPEql:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)=longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPNEq:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<>longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPLss:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPLeq:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<=longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPGtr:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)>longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPGEq:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)>=longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPDupl:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^);
    end;
    OPSwap:begin
     v:=longint(pointer(@Memory[SP and MemoryMask])^);
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^);
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=v;
    end;
    OPAndB:begin
     if longint(pointer(@Memory[SP and MemoryMask])^)=0 then begin
      longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=0;
     end;
     inc(SP,sizeof(longint));
    end;
    OPOrB:begin
     if longint(pointer(@Memory[SP and MemoryMask])^)=1 then begin
      longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=1;
     end;
     inc(SP,sizeof(longint));
    end;
    OPXorB:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) xor longint(pointer(@Memory[SP and MemoryMask])^)) and 1;
     inc(SP,sizeof(longint));
    end;
    OPAnd:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) and longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPOr:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) or longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPXor:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) xor longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPLoad:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^);
    end;
    OPStore:begin
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^);
     inc(SP,sizeof(longint)*2);
    end;
    OPHalt:begin
     i:=0;
     break;
    end;
    OPWrI:begin
//   write(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint)*2);
    end;
    OPWrF:begin
{    if (longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<0) and (longint(pointer(@Memory[SP and MemoryMask])^)<0) then begin
      write(single(pointer(@Memory[(SP+(sizeof(longint)*2)) and MemoryMask])^));
     end else begin
      write(single(pointer(@Memory[(SP+(sizeof(longint)*2)) and MemoryMask])^):longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):longint(pointer(@Memory[SP and MemoryMask])^));
     end;}
     inc(SP,sizeof(longint)*3);
    end;
    OPWrC:begin
//    write(chr(longint(pointer(@Memory[SP and MemoryMask])^)));
     inc(SP,sizeof(longint));
    end;
    OPWrB:begin
//    write((longint(pointer(@Memory[SP and MemoryMask])^))<>0);
     inc(SP,sizeof(longint));
    end;
    OPWrL:begin
//   writeln;
    end;
    OPRdI:begin
//   read(longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^));
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=0;
     inc(SP,sizeof(longint));
    end;
    OPRdF:begin
//   read(single(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^));
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=0;
     inc(SP,sizeof(longint));
    end;
    OPRdC:begin
{    read(c);
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=ord(c); }
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=0;
     inc(SP,sizeof(longint));
    end;
    OPRdB:begin
{    read(v);
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=ord(v<>0);}
     longint(pointer(@Memory[longint(pointer(@Memory[SP and MemoryMask])^) and MemoryMask])^):=0;
     inc(SP,sizeof(longint));
    end;
    OPRdL:begin
//   readln;
    end;
    OPEOF:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=0;
    end;
    OPEOL:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=0;
    end;
    OPMulF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)*single(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPDivF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)/single(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPAddF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)+single(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPSubF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)-single(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPNegF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=-single(pointer(@Memory[SP and MemoryMask])^);
    end;
    OPEqlF:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)=single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPNEqF:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<>single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPLssF:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPLeqF:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)<=single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPGtrF:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)>single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPGEqF:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=ord(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)>=single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPTRUNC:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=trunc(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPROUND:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=round(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPABS:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=abs(longint(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPABSF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=abs(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPSQR:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=sqr(longint(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPSQRF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=sqr(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPSQRTF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=sqrt(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPSINF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=sin(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPCOSF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=cos(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPEXPF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=exp(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPLNF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=ln(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPFRACF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=frac(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPODD:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=ord((longint(pointer(@Memory[SP and MemoryMask])^) and 1)<>0);
    end;
    OPTANF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=tan(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPISNANF:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=ord(IsNAN(single(pointer(@Memory[SP and MemoryMask])^)));
    end;
    OPISINFF:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=ord(IsINF(single(pointer(@Memory[SP and MemoryMask])^)));
    end;
    OPCEILF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=SoftCEIL(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPFLOORF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=SoftTRUNC(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCTANF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arctan(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCTAN2F:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=arctan2(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPARCSINF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arcsin(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCCOSF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arccos(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPHYPOTF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=hypot(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPLOG2F:begin
     single(pointer(@Memory[SP and MemoryMask])^):=log2(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPLOG10F:begin
     single(pointer(@Memory[SP and MemoryMask])^):=log10(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPLOGNF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=logn(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPCOSHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=cosh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPSINHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=sinh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPTANHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=tanh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCCOSHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arccosh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCSINHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arcsinh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCTANHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arctanh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPPOWERF:begin
     single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=power(single(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),single(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPCOTANHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=cotanh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPSECANTHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=secanth(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPCOSECANTHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=cosecanth(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCCOTANF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arccotan(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCSECANTF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arcsecant(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCCOSECANTF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arccosecant(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCCOTANHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arccotanh(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCSECANTHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arcsecanth(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPARCCOSECANTHF:begin
     single(pointer(@Memory[SP and MemoryMask])^):=arccosecanth(single(pointer(@Memory[SP and MemoryMask])^));
    end;
    OPRANDOMF:begin
     dec(SP,sizeof(longint));
     RandomSeed:=(RandomSeed*1664525)+1013904223;
     longint(pointer(@Memory[SP and MemoryMask])^):=(((RandomSeed shr 9) and $7fffff)+((RandomSeed shr 8) and 1)) or $3f800000;
     single(pointer(@Memory[SP and MemoryMask])^):=single(pointer(@Memory[SP and MemoryMask])^)-1;
    end;
    OPRANDOM:begin
     RandomSeed:=(RandomSeed*1664525)+1013904223;
     if longint(pointer(@Memory[SP and MemoryMask])^)<>0 then begin
      v:=((RandomSeed shr 1) and $55555555) or ((RandomSeed and $55555555) shl 1);
      v:=((v shr 2) and $33333333) or ((v and $33333333) shl 2);
      v:=((v shr 4) and $0f0f0f0f) or ((v and $0f0f0f0f) shl 4);
      v:=((v shr 8) and $00ff00ff) or ((v and $00ff00ff) shl 8);
      longword(pointer(@Memory[SP and MemoryMask])^):=longword((v shr 16) or (v shl 16)) mod longword(pointer(@Memory[SP and MemoryMask])^);
     end else begin
      longint(pointer(@Memory[SP and MemoryMask])^):=0;
     end;
    end;       
    OPRANDOMIZE:begin
     Randomize;
     RandomSeed:=RandSeed;
    end;
    OPSHL:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) shl longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPSHR:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^) shr longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPSAR:begin
     longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^):=SARLongint(longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^),longint(pointer(@Memory[SP and MemoryMask])^));
     inc(SP,sizeof(longint));
    end;
    OPSETSAMPLELENGTH:begin
     SampleLength:=longint(pointer(@Memory[SP and MemoryMask])^);
     setlength(Sample,SampleLength*SampleChannels);
     inc(SP,sizeof(longint));
    end;
    OPSETSAMPLECHANNELS:begin
     SampleChannels:=longint(pointer(@Memory[SP and MemoryMask])^);
     setlength(Sample,SampleLength*SampleChannels);
     inc(SP,sizeof(longint));
    end;
    OPSETSAMPLERATE:begin
     SampleRate:=longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
    end;
    OPSETSAMPLE:begin
     v:=longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^);
     if (v>=0) and (v<length(Sample)) then begin
      Sample[v]:=single(pointer(@Memory[SP and MemoryMask])^);
     end;
     inc(SP,sizeof(longint)*2);
    end;
    OPNot:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=not longint(pointer(@Memory[SP and MemoryMask])^);
    end;
    OPLdC:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=Code[PC];
     inc(PC);
    end;
    OPLdA:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=DP+Code[PC];
     inc(PC);
    end;
    OPLdLA:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=SP+sizeof(longint)+Code[PC];
     inc(PC);
    end;
    OPLdL:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[(SP+sizeof(longint)+Code[PC]) and MemoryMask])^);
     inc(PC);
    end;
    OPLdG:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[(DP+Code[PC]) and MemoryMask])^);
     inc(PC);
    end;
    OPStL:begin
     longint(pointer(@Memory[(SP+Code[PC]) and MemoryMask])^):=longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
     inc(PC);
    end;
    OPStG:begin
     longint(pointer(@Memory[(DP+Code[PC]) and MemoryMask])^):=longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,sizeof(longint));
     inc(PC);
    end;
    OPMove:begin
     move(Memory[longint(pointer(@Memory[(SP+sizeof(longint)) and MemoryMask])^)],Memory[longint(pointer(@Memory[SP and MemoryMask])^)],Code[PC]);
     inc(SP,sizeof(longint)*2);
     inc(PC);
    end;
    OPCopy:begin
     v:=longint(pointer(@Memory[SP and MemoryMask])^);
     SP:=(SP-Code[PC])+sizeof(longint);
     move(Memory[v and MemoryMask],Memory[SP and MemoryMask],Code[PC]);
     inc(PC);
    end;
    OPAddC:begin
     inc(longint(pointer(@Memory[SP and MemoryMask])^),Code[PC]);
     inc(PC);
    end;
    OPMulC:begin
     longint(pointer(@Memory[SP and MemoryMask])^):=longint(pointer(@Memory[SP and MemoryMask])^)*Code[PC];
     inc(PC);
    end;
    OPJmp:begin
     PC:=Code[PC];
    end;
    OPJZ:begin
     if longint(pointer(@Memory[SP and MemoryMask])^)=0 then begin
      PC:=Code[PC];
     end else begin
      inc(PC);
     end;
     inc(SP,sizeof(longint));
    end;
    OPCall:begin
     dec(SP,sizeof(longint));
     longint(pointer(@Memory[SP and MemoryMask])^):=PC+1;
     PC:=Code[PC];
    end;
    OPAdjS:begin
     inc(SP,Code[PC]);
     inc(PC);
    end;
    OPLeave:begin
     v:=Code[PC];
     PC:=longint(pointer(@Memory[SP and MemoryMask])^);
     inc(SP,v);
    end;
    OPINTTOFLOAT:begin
     single(pointer(@Memory[(SP+Code[PC]) and MemoryMask])^):=longint(pointer(@Memory[(SP+Code[PC]) and MemoryMask])^);
     inc(PC);
    end;
   end;
  end;
 finally
  FreeMem(OriginalMemory);
 {$ifdef cpu386}
  asm
   fldcw word ptr OldFCW
  end;
 {$endif}
 end;
 if i<>0 then begin
  raise Exception.Create('Execution time out');
 end;
end;

end.
