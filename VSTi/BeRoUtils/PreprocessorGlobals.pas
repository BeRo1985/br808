(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2010-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit PreprocessorGlobals;
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

uses Classes,SysUtils,UTF8,UCS4,StringTree;

const HandleTrigraphs:boolean=false;
      WarnTrigraphs:boolean=false;
      WarnTrigraphsMore:boolean=false;
      HandleUTF8:boolean=false;

      tfNONE=$00;
      tfINT=$01;
      tfBYTE=$02;
      tfSHORT=$03;
      tfVOID=$04;
      tfPTR=$05;
      tfENUM=$06;
      tfFUNC=$07;
      tfSTRUCT=$08;
      tfFLOAT=$09;
      tfDOUBLE=$0a;
      tfLDOUBLE=$0b;
      tfBOOL=$0c;
      tfLLONG=$0d;
      tfLONG=$0e;
      tfBASICTYPE=$000f;
      tfUNSIGNED=$0010;
      tfARRAY=$0020;
      tfBITFIELD=$0040;
      tfCONSTANT=$0800;
      tfVOLATILE=$1000;
      tfSIGNED=$2000;
      tfEXTERN=$00000080;
      tfSTATIC=$00000100;
      tfTYPEDEF=$00000200;
      tfINLINE=$00000400;
      tfNATIVE=$00010000;
      tfSTRUCTSHIFT=16;
      tfSTORAGE=tfEXTERN or tfSTATIC or tfTYPEDEF or tfINLINE or tfNATIVE;
      tfTYPE=not tfSTORAGE;

      vfVALMASK=$00ff;
      vfCONST=$00f0;
      vfLLOCAL=$00f1;
      vfLOCAL=$00f2;
      vfCMP=$00f3;
      vfJMP=$00f4;
      vfJMPI=$00f5;
      vfLVAL=$0100;
      vfSYM=$0200;
      vfMULTICAST=$0400;
      vfMUSTBOUND=$0800;
      vfBOUNDED=$8000;
      vfLVALBYTE=$1000;
      vfLVALSHORT=$2000;
      vfLVALUNSIGNED=$4000;
      vfLVALTYPE=vfLVALBYTE or vfLVALSHORT or vfLVALUNSIGNED;

      SYM_STRUCT=$40000000;
      SYM_FIELD=$20000000;
      SYM_FIRST_ANOM=$10000000;
      
      FUNC_NEW=1;
      FUNC_OLD=2;
      FUNC_ELLIPSIS=3;

      FUNC_CDECL=0;
      FUNC_STDCALL=1;
      FUNC_FASTCALL1=2;
      FUNC_FASTCALL2=3;
      FUNC_FASTCALL3=4;

      LABEL_DEFINED=0;
      LABEL_FORWARD=1;
      LABEL_DECLARED=2;

      TYPE_ABSTRACT=1;
      TYPE_DIRECT=2;

      VALUESTACKSIZE=8192;

      ST_NOBITS=8;

type PPSymbol=^PSymbol;
     PSymbol=^TSymbol;
     PSection=^TSection;
     
{$ifndef fpc}
     uint64=type int64;
     ptrint=longint;
     ptruint=longword;
{$endif}

     TPreprocessorInputSourceKind=(iskNONE,iskFILE,iskMACRO);

     TPreprocessorInputSource=record
      Kind:TPreprocessorInputSourceKind;
      name:TUCS4STRING;
     end;

     TPreprocessorInputSources=array of TPreprocessorInputSource;

     TPreprocessorPragmaInfoItem=record
      CharPos:integer;
      Pragma:TUCS4STRING;
     end;

     TPreprocessorPragmaInfo=array of TPreprocessorPragmaInfoItem;

     TPreprocessorOutputInfoItem=record
      FirstCharPos,LastCharPos,Source,Line:integer;
     end;

     TPreprocessorOutputInfo=array of TPreprocessorOutputInfoItem;

     TPreprocessorIncludeDirectories=array of string;

     TPreprocessor=record
      IncludeDirectories:TPreprocessorIncludeDirectories;
      InputKind:TPreprocessorInputSourceKind;
      InputName:TUCS4STRING;
      InputText:string;
      InputSources:TPreprocessorInputSources;
      PragmaInfo:TPreprocessorPragmaInfo;
      OutputInfo:TPreprocessorOutputInfo;
      OutputText:TUCS4STRING;
     end;

     TLexerTokenType=(TOK_NONE,TOK_EOF,TOK_PRAGMA,TOK_PPNUM,TOK_IDENT,TOK_CINT,
                      TOK_CUINT,TOK_CCHAR,TOK_LCHAR,TOK_CFLOAT,TOK_CDOUBLE,
                      TOK_CLDOUBLE,TOK_CLLONG,TOK_CULLONG,TOK_MID,TOK_UDIV,
                      TOK_UMOD,TOK_PDIV,TOK_UMULL,TOK_ADDC1,TOK_ADDC2,TOK_SUBC1,
                      TOK_SUBC2,TOK_ULT,TOK_ULE,TOK_UGT,TOK_UGE,
                      TOK_TWOSHARPS,TOK_SHARP,TOK_LBRK,TOK_RBRK,TOK_LBRA,
                      TOK_RBRA,TOK_LPAR,TOK_RPAR,TOK_LE,TOK_LT,TOK_GE,TOK_GT,
                      TOK_A_SHL,TOK_SHL,TOK_A_SHR,TOK_SHR,TOK_LAND,TOK_A_AND,
                      TOK_AND,TOK_LOR,TOK_A_OR,TOK_OR,TOK_INC,TOK_A_ADD,TOK_ADD,
                      TOK_DEC,TOK_A_SUB,TOK_SUB,TOK_ARROW,TOK_NE,TOK_LNOT,
                      TOK_EQ,TOK_ASSIGN,TOK_A_MUL,TOK_MUL,TOK_A_MOD,TOK_MOD,
                      TOK_A_XOR,TOK_XOR,TOK_A_DIV,TOK_DIV,TOK_COLON,
                      TOK_SEMICOLON,TOK_COMMA,TOK_QUEST,TOK_NOT,TOK_DOTS,
                      TOK_DOT,TOK_STR,TOK_LSTR,TOK_INT,TOK_VOID,TOK_CHAR,TOK_IF,
                      TOK_ELSE,TOK_WHILE,TOK_BREAK,TOK_RETURN,TOK_FOR,
                      TOK_EXTERN,TOK_STATIC,TOK_UNSIGNED,TOK_GOTO,TOK_DO,
                      TOK_CONTINUE,TOK_SWITCH,TOK_CASE,TOK_CONST1,TOK_CONST2,
                      TOK_CONST3,TOK_VOLATILE1,TOK_VOLATILE2,TOK_VOLATILE3,
                      TOK_LONG,TOK_REGISTER,TOK_SIGNED1,TOK_SIGNED2,TOK_SIGNED3,
                      TOK_AUTO,TOK_INLINE1,TOK_INLINE2,TOK_INLINE3,
                      TOK_RESTRICT1,TOK_RESTRICT2,TOK_RESTRICT3,TOK_EXTENSION,
                      TOK_FLOAT,TOK_DOUBLE,TOK_BOOL,TOK_SHORT,TOK_STRUCT,
                      TOK_UNION,TOK_TYPEDEF,TOK_DEFAULT,TOK_ENUM,TOK_SIZEOF,
                      TOK_ATTRIBUTE1,TOK_ATTRIBUTE2,TOK_ALIGNOF1,TOK_ALIGNOF2,
                      TOK_TYPEOF1,TOK_TYPEOF2,TOK_TYPEOF3,TOK_LABEL,TOK_ASM1,
                      TOK_ASM2,TOK_ASM3,TOK___FUNC__,TOK_SECTION1,TOK_SECTION2,
                      TOK_ALIGNED1,TOK_ALIGNED2,TOK_PACKED1,TOK_PACKED2,
                      TOK_UNUSED1,TOK_UNUSED2,TOK_CDECL1,TOK_CDECL2,TOK_CDECL3,
                      TOK_STDCALL1,TOK_STDCALL2,TOK_STDCALL3,TOK_DLLEXPORT,
                      TOK_NORETURN1,TOK_NORETURN2,
                      TOK_builtin_types_compatible_p,TOK_builtin_constant_p,
                      TOK_REGPARM1,TOK_REGPARM2,TOK_PACK,TOK_PUSH,TOK_POP,
                      TOK_memcpy,TOK_memset,TOK_alloca,TOK___divdi3,TOK___moddi3,
                      TOK___udivdi3,TOK___umoddi3,TOK___tcc_int_fpu_control,
                      TOK___tcc_fpu_control,TOK___ulltof,TOK___ulltod,
                      TOK___ulltold,TOK___fixunssfdi,TOK___fixunsdfdi,
                      TOK___fixunsxfdi,TOK___chkstk,TOK___bound_ptr_add,
                      TOK___bound_ptr_indir1,TOK___bound_ptr_indir2,
                      TOK___bound_ptr_indir4,TOK___bound_ptr_indir8,
                      TOK___bound_ptr_indir12,TOK___bound_ptr_indir16,
                      TOK___bound_local_new,TOK___bound_local_delete,
                      TOK_malloc,TOK_free,TOK_realloc,TOK_memalign,
                      TOK_calloc,TOK_memmove,TOK_strlen,TOK_strcpy,
                      TOK_NATIVE1,TOK_NATIVE2,TOK_NATIVE3);

     PCString=^TCString;
     TCString=record
      Data:TUCS4STRING;
     end;

     PCValue=^TCValue;
     TCValue=packed record
      cstr:TCString;
      case integer of
       0:(ld:extended);
       1:(d:double);
       2:(f:single);
       3:(i:longint);
       4:(ui:longword);
       5:(ul:longword);
       6:(ll:int64);
       7:(ull:uint64);
       8:({cstr:TCString});
       9:(ptr:pointer);
       10:(tab:array[0..0] of integer);
     end;

     TLexerToken=record
      TokenType:TLexerTokenType;
      Source,Line,index:integer;
      Constant:TCValue;
      Content:TUCS4STRING;
     end;

     TLexerTokens=array of TLexerToken;

     TLexer=record
      Tokens:TLexerTokens;
      TokenIndex:integer;
     end;

     PCType=^TCType;
     TCType=record
      Flags:integer;
      Ref:PSymbol;
     end;

     TSymbolFunctionInline=record
      AreWeIn:boolean;
      Tokens:TLexerTokens;
     end;

     TSymbol=record
      PreviousToken,Previous,Next:PSymbol;
      TokenSymbolIndex:integer;
      r:integer;
      c:integer;
      SymbolType:TCType;
      ScopeIndex:integer;
      FunctionInline:TSymbolFunctionInline;
     end;

     PAttributeDef=^TAttributeDef;
     TAttributeDef=record
      _aligned:integer;
      _packed:integer;
      Section:PSection;
      func_call:byte;
      dllexport:byte;
     end;

     PStackValue=^TStackValue;
     TStackValue=record
      ValueType:TCType;
      Reg1:cardinal;
      Reg2:cardinal;
      Constant:TCValue;
      Symbol:PSymbol;
     end;

     PStackValues=^TStackValues;
     TStackValues=array[0..0] of TStackValue;

     TValueStack=record
      Stack:array[0..VALUESTACKSIZE-1] of TStackValue;
      Top:PStackValues;
     end;

     PTokenSymbol=^TTokenSymbol;
     TTokenSymbol=record
      name:TUCS4STRING;
      SymbolLabel:PSymbol;
      SymbolStruct:PSymbol;
      SymbolIdentifier:PSymbol;
      index:integer;
     end;

     TSection=record
      DataOffset:integer;
      DataAllocated:integer;
      AddrAlign:integer;
      SectionType:integer;
     end;

     TSections=array of PSection;

     TParser=record
      Dummy:byte;
     end;

     TCompiler=record
      Dummy:byte;
     end;

     TTokenSymbols=record
      TokenSymbols:array of PTokenSymbol;
      StringTree:TStringTreeMemory;
     end;

     TSymbolStacks=record
      GlobalStack:PSymbol;
      LocalStack:PSymbol;
      GlobalLabelStack:PSymbol;
      LocalLabelStack:PSymbol;
     end;

     TTypes=record
      CharPointer:TCType;
      FuncOld:TCType;
      Int:TCType;
     end;

     TInstance=record
      Sections:TSections;
      CurrentCodeSection:PSection;
      DataSection:PSection;
      BSSSection:PSection;
      ValueStack:TValueStack;
      Symbols:array of PSymbol;
      SymbolFreeLinkList:PSymbol;
      TokenSymbols:TTokenSymbols;
      SymbolStacks:TSymbolStacks;
      Types:TTypes;
      Preprocessor:TPreprocessor;
      Lexer:TLexer;
      Parser:TParser;
      Compiler:TCompiler;
      Source:integer;
      Line:integer;
      Loc:integer;
      FunctionName:TUCS4STRING;
      AnonymousSymbolIndex:integer;
      ScopeIndex:integer;
      ScopeIndexStack:array of integer;
      PackStack:array of integer;
     end;

const Errors:string='';

procedure InternalError(var Instance:TInstance;Code:int64);
procedure AddError(var Instance:TInstance;const s:string);
procedure AddWarning(var Instance:TInstance;const s:string);
procedure SectionReallocate(var Instance:TInstance;Section:PSection;NewSize:integer);
function GetSymbolName(var Instance:TInstance;const Symbol:TSymbol):TUCS4STRING; overload;
function GetSymbolName(var Instance:TInstance;i:integer):TUCS4STRING; overload;
function SymbolNew(var Instance:TInstance):PSymbol;
procedure SymbolFree(var Instance:TInstance;Symbol:PSymbol);
function SymbolPushEx(var Instance:TInstance;Stack:PPSymbol;TokenSymbolIndex,TypeFlags,c:integer):PSymbol;
function SymbolPush(var Instance:TInstance;TokenSymbolIndex:integer;var AType:TCType;r,c:integer):PSymbol;
procedure SymbolPop(var Instance:TInstance;Stack:PPSymbol;Symbol:PSymbol);
function GlobalIdentifierPush(var Instance:TInstance;TokenSymbolIndex,TypeFlags,c:integer):PSymbol;
function SymbolFindEx(var Instance:TInstance;Symbol:PSymbol;TokenSymbolIndex:integer):PSymbol;
function StructFind(var Instance:TInstance;TokenSymbolIndex:integer):PSymbol;
function SymbolFind(var Instance:TInstance;TokenSymbolIndex:integer):PSymbol;
function LabelFind(var Instance:TInstance;TokenSymbolIndex:integer):PSymbol;
function LabelPush(var Instance:TInstance;Stack:PPSymbol;TokenSymbolIndex,Flags:integer):PSymbol;
procedure LabelPop(var Instance:TInstance;Stack:PPSymbol;Symbol:PSymbol);
procedure PutExternSymbolEx(var Instance:TInstance;Symbol:PSymbol;Section:PSection;Value:ptruint;Size:longword;CanAddUnderscore:boolean);
procedure PutExternSymbol(var Instance:TInstance;Symbol:PSymbol;Section:PSection;Value:ptruint;Size:longword);
function IsCompatibleFunc(var Instance:TInstance;const t1,t2:TCType):boolean;
function IsCompatibleTypes(var Instance:TInstance;const t1,t2:TCType):boolean;
function ExternalSymbol(var Instance:TInstance;TokenSymbolIndex:integer;var AType:TCType;r:integer):PSymbol;
function GetSymbolReference(var Instance:TInstance;var AType:TCType;Section:PSection;Offset:ptruint;Size:longword):PSymbol;
procedure ValueStackSetC(var Instance:TInstance;const AType:TCType;r:integer;const Value:TCValue);
procedure ValueStackSet(var Instance:TInstance;const AType:TCType;r,v:integer);
procedure ValueStackPushInt(var Instance:TInstance;v:integer);
procedure ValueStackPushTokenConstant(var Instance:TInstance;Flags:integer;const Constant:TCValue);
procedure ValueStackPop(var Instance:TInstance);
procedure MakePointer(var Instance:TInstance;var AType:TCType);
procedure InitInstance(var Instance:TInstance);
procedure DoneInstance(var Instance:TInstance);

implementation

//uses CodeGen;

procedure InternalError(var Instance:TInstance;Code:int64);
begin
 raise Exception.Create('INTERNAL ERROR '+inttostr(Code));
end;

procedure AddError(var Instance:TInstance;const s:string);
var t:string;
begin
 if (Instance.Source>=0) and (Instance.Source<length(Instance.Preprocessor.InputSources)) then begin
  case Instance.Preprocessor.InputSources[Instance.Source].Kind of
   iskFILE:t:='file';
   iskMACRO:t:='macro';
   else t:='unknown';
  end;
  Errors:=Errors+'Error('+t+'['+UCS4ToUTF8(Instance.Preprocessor.InputSources[Instance.Source].name)+']['+inttostr(Instance.Line+1)+']): '+s;
 end else begin
  Errors:=Errors+'Error: '+s;
 end;
 raise Exception.Create('');
end;

procedure AddWarning(var Instance:TInstance;const s:string);
var t:string;
begin
 if (Instance.Source>=0) and (Instance.Source<length(Instance.Preprocessor.InputSources)) then begin
  case Instance.Preprocessor.InputSources[Instance.Source].Kind of
   iskFILE:t:='file';
   iskMACRO:t:='macro';
   else t:='unknown';
  end;
  writeln('Warning('+t+'[',UCS4ToUTF8(Instance.Preprocessor.InputSources[Instance.Source].name),'][',Instance.Line+1,']): ',s);
 end else begin
  writeln('Warning: ',s);
 end;
 raise Exception.Create('');
end;

procedure SectionReallocate(var Instance:TInstance;Section:PSection;NewSize:integer);
begin
end;

function GetSymbolName(var Instance:TInstance;const Symbol:TSymbol):TUCS4STRING; overload;
var i:integer;
    TokenSymbol:PTokenSymbol;
begin
 result:=nil;
 i:=Symbol.TokenSymbolIndex-1;
 if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
  InternalError(Instance,$20070923091200);
 end;
 TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
 if not assigned(TokenSymbol) then begin
  InternalError(Instance,$20070923091201);
 end;
 result:=TokenSymbol^.name;
end;

function GetSymbolName(var Instance:TInstance;i:integer):TUCS4STRING; overload;
var TokenSymbol:PTokenSymbol;
begin
 result:=nil;
 dec(i);
 if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
  InternalError(Instance,$20070923091200);
 end;
 TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
 if not assigned(TokenSymbol) then begin
  InternalError(Instance,$20070923091201);
 end;
 result:=TokenSymbol^.name;
end;

function SymbolNew(var Instance:TInstance):PSymbol;
var i:integer;
begin
 result:=Instance.SymbolFreeLinkList;
 if not assigned(result) then begin
  new(result);
  i:=length(Instance.Symbols);
  setlength(Instance.Symbols,i+1);
  Instance.Symbols[i]:=result;
 end else begin
  Instance.SymbolFreeLinkList:=result^.Next;
 end;
 fillchar(result^,sizeof(TSymbol),#0);
end;

procedure SymbolFree(var Instance:TInstance;Symbol:PSymbol);
begin
 Symbol^.Next:=Instance.SymbolFreeLinkList;
 Instance.SymbolFreeLinkList:=Symbol;
end;

function SymbolPushEx(var Instance:TInstance;Stack:PPSymbol;TokenSymbolIndex,TypeFlags,c:integer):PSymbol;
begin
 result:=SymbolNew(Instance);
 result^.TokenSymbolIndex:=TokenSymbolIndex;
 result^.SymbolType.Flags:=TypeFlags;
 if length(Instance.ScopeIndexStack)>0 then begin
  result^.ScopeIndex:=Instance.ScopeIndexStack[length(Instance.ScopeIndexStack)-1];
 end else begin
  result^.ScopeIndex:=-1;
 end;
 result^.c:=c;
 result^.Previous:=Stack^;
 Stack^:=result;
end;

function SymbolPush(var Instance:TInstance;TokenSymbolIndex:integer;var AType:TCType;r,c:integer):PSymbol;
var Stack:PPSymbol;
    TokenSymbol:PTokenSymbol;
    i:integer;
begin
 if assigned(Instance.SymbolStacks.LocalStack) then begin
  Stack:=@Instance.SymbolStacks.LocalStack;
 end else begin
  Stack:=@Instance.SymbolStacks.GlobalStack;
 end;
 result:=SymbolPushEx(Instance,Stack,TokenSymbolIndex,AType.Flags,c);
 result^.SymbolType.Ref:=AType.Ref;
 result^.r:=r;
 if ((TokenSymbolIndex and SYM_FIELD)=0) and ((TokenSymbolIndex and not SYM_STRUCT)<SYM_FIRST_ANOM) then begin
  i:=(TokenSymbolIndex and not SYM_STRUCT)-1;
  if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
   InternalError(Instance,$20070923075100);
  end;
  TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
  if not assigned(TokenSymbol) then begin
   InternalError(Instance,$20070923075400);
  end;
  if (TokenSymbolIndex and SYM_STRUCT)<>0 then begin
   Stack:=@TokenSymbol^.SymbolStruct;
  end else begin
   Stack:=@TokenSymbol^.SymbolIdentifier;
  end;
  result^.PreviousToken:=Stack^;
  if assigned(result^.PreviousToken) then begin
   if result^.PreviousToken^.ScopeIndex=result^.ScopeIndex then begin
    AddError(Instance,'Invalid redefinition of "'+UCS4TOUTF8(GetSymbolName(Instance,result^))+'"');
   end;
  end;
  Stack^:=result;
 end;
end;

procedure SymbolPop(var Instance:TInstance;Stack:PPSymbol;Symbol:PSymbol);
var CurrentSymbol,PreviousSymbol:PSymbol;
    TokenSambolStack:PPSymbol;
    TokenSymbolIndex:integer;
    TokenSymbol:PTokenSymbol;
    i:integer;
begin
 CurrentSymbol:=Stack^;
 while CurrentSymbol<>Symbol do begin
  PreviousSymbol:=CurrentSymbol^.Previous;
  TokenSymbolIndex:=CurrentSymbol^.TokenSymbolIndex;
  if ((TokenSymbolIndex and SYM_FIELD)=0) and ((TokenSymbolIndex and not SYM_STRUCT)<SYM_FIRST_ANOM) then begin
   i:=(TokenSymbolIndex and not SYM_STRUCT)-1;
   if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
    InternalError(Instance,$20070923084300);
   end;
   TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
   if not assigned(TokenSymbol) then begin
    InternalError(Instance,$20070923084301);
   end;
   if (TokenSymbolIndex and SYM_STRUCT)<>0 then begin
    TokenSambolStack:=@TokenSymbol^.SymbolStruct;
   end else begin
    TokenSambolStack:=@TokenSymbol^.SymbolIdentifier;
   end;
   TokenSambolStack^:=CurrentSymbol^.PreviousToken;
  end;
  SymbolFree(Instance,CurrentSymbol);
  CurrentSymbol:=PreviousSymbol;
 end;
 Stack^:=Symbol;
end;

function GlobalIdentifierPush(var Instance:TInstance;TokenSymbolIndex,TypeFlags,c:integer):PSymbol;
var Stack:PPSymbol;
    TokenSymbol:PTokenSymbol;
    i:integer;
begin
 result:=SymbolPushEx(Instance,@Instance.SymbolStacks.GlobalStack,TokenSymbolIndex,TypeFlags,c);
 if TokenSymbolIndex<SYM_FIRST_ANOM then begin
  i:=TokenSymbolIndex-1;
  if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
   InternalError(Instance,$20070923085200);
  end;
  TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
  if not assigned(TokenSymbol) then begin
   InternalError(Instance,$20070923085201);
  end;
  Stack:=@TokenSymbol^.SymbolIdentifier;
  while assigned(Stack^) do begin
   Stack^:=Stack^^.PreviousToken;
  end;
  result^.PreviousToken:=nil;
  Stack^:=result;
 end;
end;

function SymbolFindEx(var Instance:TInstance;Symbol:PSymbol;TokenSymbolIndex:integer):PSymbol;
begin
 result:=nil;
 while assigned(Symbol) do begin
  if Symbol^.TokenSymbolIndex=TokenSymbolIndex then begin
   result:=Symbol;
   break;
  end;
 end;
end;

function StructFind(var Instance:TInstance;TokenSymbolIndex:integer):PSymbol;
begin
 if (TokenSymbolIndex<=0) or (TokenSymbolIndex>length(Instance.TokenSymbols.TokenSymbols)) then begin
  result:=nil;
 end else begin
  result:=Instance.TokenSymbols.TokenSymbols[TokenSymbolIndex-1].SymbolStruct;
 end;
end;

function SymbolFind(var Instance:TInstance;TokenSymbolIndex:integer):PSymbol;
begin
 if (TokenSymbolIndex<=0) or (TokenSymbolIndex>length(Instance.TokenSymbols.TokenSymbols)) then begin
  result:=nil;
 end else begin
  result:=Instance.TokenSymbols.TokenSymbols[TokenSymbolIndex-1].SymbolIdentifier;
 end;
end;

function LabelFind(var Instance:TInstance;TokenSymbolIndex:integer):PSymbol;
begin
 if (TokenSymbolIndex<=0) or (TokenSymbolIndex>length(Instance.TokenSymbols.TokenSymbols)) then begin
  result:=nil;
 end else begin
  result:=Instance.TokenSymbols.TokenSymbols[TokenSymbolIndex-1].SymbolLabel;
 end;
end;

function LabelPush(var Instance:TInstance;Stack:PPSymbol;TokenSymbolIndex,Flags:integer):PSymbol;
var TokenSymbolStack:PPSymbol;
    TokenSymbol:PTokenSymbol;
    i:integer;
begin
 result:=SymbolPushEx(Instance,@Instance.SymbolStacks.GlobalStack,TokenSymbolIndex,0,0);
 result^.r:=Flags;
 i:=TokenSymbolIndex-1;
 if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
  InternalError(Instance,$20070923090000);
 end;
 TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
 if not assigned(TokenSymbol) then begin
  InternalError(Instance,$20070923090001);
 end;
 TokenSymbolStack:=@TokenSymbol^.SymbolLabel;
 if TokenSymbolStack=@Instance.SymbolStacks.GlobalLabelStack then begin
  while assigned(TokenSymbolStack^) do begin
   TokenSymbolStack^:=TokenSymbolStack^^.PreviousToken;
  end;
 end;
 result^.PreviousToken:=nil;
 TokenSymbolStack^:=result;
end;

procedure LabelPop(var Instance:TInstance;Stack:PPSymbol;Symbol:PSymbol);
var CurrentSymbol,PreviousSymbol:PSymbol;
    TokenSymbolIndex:integer;
    TokenSymbol:PTokenSymbol;
    i:integer;
begin
 CurrentSymbol:=Stack^;
 while CurrentSymbol<>Symbol do begin
  PreviousSymbol:=CurrentSymbol^.Previous;
  case CurrentSymbol^.r of
   LABEL_DECLARED:begin
    AddWarning(Instance,'Label "'+UCS4TOUTF8(GetSymbolName(Instance,CurrentSymbol^))+'" declared but not used');
   end;
   LABEL_FORWARD:begin
    AddError(Instance,'Label "'+UCS4TOUTF8(GetSymbolName(Instance,CurrentSymbol^))+'" used but not defined');
   end;
   else begin
    if CurrentSymbol^.c<>0 then begin
     PutExternSymbol(Instance,CurrentSymbol,Instance.CurrentCodeSection,ptruint(CurrentSymbol^.Next),1);
    end;
   end;
  end;
  TokenSymbolIndex:=CurrentSymbol^.TokenSymbolIndex;
  i:=TokenSymbolIndex-1;
  if (i<0) or (i>=length(Instance.TokenSymbols.TokenSymbols)) then begin
   InternalError(Instance,$20070923091500);
  end;
  TokenSymbol:=Instance.TokenSymbols.TokenSymbols[i];
  if not assigned(TokenSymbol) then begin
   InternalError(Instance,$20070923091501);
  end;
  TokenSymbol^.SymbolLabel:=CurrentSymbol^.PreviousToken;
  SymbolFree(Instance,CurrentSymbol);
  CurrentSymbol:=PreviousSymbol;
 end;
 Stack^:=Symbol;
end;

procedure MakePointer(var Instance:TInstance;var AType:TCType);
var Symbol:PSymbol;
begin
 Symbol:=SymbolPush(Instance,SYM_FIELD,AType,0,-1);
 AType.Flags:=tfPTR or (AType.Flags and not tfTYPE);
 AType.Ref:=Symbol;
end;

procedure PutExternSymbolEx(var Instance:TInstance;Symbol:PSymbol;Section:PSection;Value:ptruint;Size:longword;CanAddUnderscore:boolean);
begin
end;

procedure PutExternSymbol(var Instance:TInstance;Symbol:PSymbol;Section:PSection;Value:ptruint;Size:longword);
begin
 PutExternSymbolEx(Instance,Symbol,Section,Value,Size,true);
end;

function IsCompatibleFunc(var Instance:TInstance;const t1,t2:TCType):boolean;
var s1,s2:PSymbol;
begin
 s1:=t1.Ref;
 s2:=t2.Ref;
 if not IsCompatibleTypes(Instance,s1^.SymbolType,s2^.SymbolType) then begin
  result:=false;
  exit;
 end;
 if s1^.r<>s2^.r then begin
  result:=false;
  exit;
 end;
 if (s1^.c=FUNC_OLD) and (s2^.c=FUNC_OLD) then begin
  result:=true;
  exit;
 end;
 if s1^.c<>s2^.c then begin
  result:=false;
  exit;
 end;
 while assigned(s1) do begin
  if not assigned(s2) then begin
   result:=false;
   exit;
  end;
  if not IsCompatibleTypes(Instance,s1^.SymbolType,s2^.SymbolType) then begin
   result:=false;
   exit;
  end;
  s1:=s1^.Next;
  s2:=s2^.Next;
 end;
 if assigned(s2) then begin
  result:=false;
  exit;
 end;
 result:=true;
end;

function IsCompatibleTypes(var Instance:TInstance;const t1,t2:TCType):boolean;
var bt1,tf1,tf2:integer;
begin
 tf1:=t1.Flags and tfTYPE;
 tf2:=t2.Flags and tfTYPE;
 // TO-DO: Bitfield check
 if tf1<>tf2 then begin
  result:=false;
  exit;
 end;
 bt1:=tf1 and tfBASICTYPE;
 case bt1 of
  tfPTR:begin
   result:=IsCompatibleTypes(Instance,t1.Ref^.SymbolType,t2.Ref^.SymbolType);
  end;
  tfSTRUCT:begin
   result:=t1.Ref=t2.Ref;
  end;
  tfFUNC:begin
   result:=IsCompatibleFunc(Instance,t1,t2);
  end;
  else begin
   result:=true;
  end;
 end;
end;

function ExternalSymbol(var Instance:TInstance;TokenSymbolIndex:integer;var AType:TCType;r:integer):PSymbol;
begin
 result:=SymbolFind(Instance,TokenSymbolIndex);
 if assigned(result) then begin
  if IsCompatibleTypes(Instance,result^.SymbolType,AType) then begin
   AddError(Instance,'Incompatible types for redefinition of "'+UCS4TOUTF8(GetSymbolName(Instance,result^))+'"');
  end;
 end else begin
  result:=SymbolPush(Instance,TokenSymbolIndex,AType,r or vfCONST or vfSYM,0);
  result^.SymbolType.Flags:=result^.SymbolType.Flags or tfEXTERN;
 end;
end;

function GetSymbolReference(var Instance:TInstance;var AType:TCType;Section:PSection;Offset:ptruint;Size:longword):PSymbol;
var TokenSymbolIndex:integer;
begin
 TokenSymbolIndex:=Instance.AnonymousSymbolIndex;
 inc(Instance.AnonymousSymbolIndex);
 result:=GlobalIdentifierPush(Instance,TokenSymbolIndex,AType.Flags or tfSTATIC,0);
 result^.SymbolType.Ref:=AType.Ref;
 result^.r:=vfCONST or vfSYM;
 PutExternSymbol(Instance,result,Section,Offset,Size);
end;

procedure ValueStackSetC(var Instance:TInstance;const AType:TCType;r:integer;const Value:TCValue);
var v:integer;
begin
 if ptruint(PStackValue(Instance.ValueStack.Top))>=ptruint(@Instance.ValueStack.Stack[high(Instance.ValueStack.Stack)]) then begin
  AddError(Instance,'Out of static stack memory range');
 end;
 if ptruint(PStackValue(Instance.ValueStack.Top))>=ptruint(@Instance.ValueStack.Stack[low(Instance.ValueStack.Stack)]) then begin
  v:=Instance.ValueStack.Top^[0].Reg1 and vfVALMASK;
  if (v=vfCMP) or ((v and not 1)=vfJMP) then begin
//   GenerateValue(Instance,RC_INT);
  end;
 end;
 inc(PStackValue(Instance.ValueStack.Top));
 Instance.ValueStack.Top^[0].ValueType:=AType;
 Instance.ValueStack.Top^[0].Reg1:=r;
 Instance.ValueStack.Top^[0].Reg2:=vfCONST;
 Instance.ValueStack.Top^[0].Constant:=Value;
end;

procedure ValueStackSet(var Instance:TInstance;const AType:TCType;r,v:integer);
var Value:TCValue;
begin
 Value.i:=v;
 ValueStackSetC(Instance,AType,r,Value);
end;

procedure ValueStackPushInt(var Instance:TInstance;v:integer);
var c:TCValue;
begin
 c.i:=v;
 ValueStackSetC(Instance,Instance.Types.Int,vfCONST,c);
end;

procedure ValueStackPushTokenConstant(var Instance:TInstance;Flags:integer;const Constant:TCValue);
var t:TCType;
begin
 t.Flags:=Flags;
 ValueStackSetC(Instance,t,vfCONST,Constant);
end;

procedure ValueStackPop(var Instance:TInstance);
///var v:integer;
begin
{v:=Instance.ValueStack.Top^[0].Reg1 and vfVALMASK;
 if v=TREG_FR0 then begin
  //fstp st1
 end else if (v=vfJMP) or (v=vfJMPI) then begin
  GenerateSymbol(Instance,Instance.ValueStack.Top^[0].Constant.ul);
 end;                                      }
 dec(PStackValue(Instance.ValueStack.Top));
end;

procedure InitInstance(var Instance:TInstance);
begin
 fillchar(Instance,sizeof(TInstance),#0);
 Initialize(Instance);
 Instance.TokenSymbols.StringTree:=TStringTreeMemory.Create;
 Instance.TokenSymbols.StringTree.Hashing:=true;
 Instance.Types.Int.Flags:=tfINT;
 Instance.Types.CharPointer.Flags:=tfBYTE;
 MakePointer(Instance,Instance.Types.CharPointer);
 Instance.Types.FuncOld.Flags:=tfFUNC;
 Instance.Types.FuncOld.Ref:=SymbolPush(Instance,SYM_FIELD,Instance.Types.Int,FUNC_CDECL,FUNC_OLD);
 Instance.ValueStack.Top:=pointer(ptruint(ptruint(@Instance.ValueStack.Stack[0])));
//Instance.ValueStack.Top:=pointer(ptruint(ptruint(@Instance.ValueStack.Stack[0])-sizeof(TStackValue)));
 Instance.FunctionName:=nil;
 Instance.AnonymousSymbolIndex:=SYM_FIRST_ANOM;
 Instance.ScopeIndex:=1;
 Instance.ScopeIndexStack:=nil;
 Instance.PackStack:=nil;
end;

procedure DoneInstance(var Instance:TInstance);
var i:integer;
begin
 setlength(Instance.PackStack,0);
 setlength(Instance.ScopeIndexStack,0);
 Instance.SymbolFreeLinkList:=nil;
 for i:=0 to length(Instance.Symbols)-1 do begin
  if assigned(Instance.Symbols[i]) then begin
   Finalize(Instance.Symbols[i]^);
   dispose(Instance.Symbols[i]);
   Instance.Symbols[i]:=nil;
  end;
 end;
 setlength(Instance.Symbols,0);
 for i:=0 to length(Instance.TokenSymbols.TokenSymbols)-1 do begin
  if assigned(Instance.TokenSymbols.TokenSymbols[i]) then begin
   dispose(Instance.TokenSymbols.TokenSymbols[i]);
   Instance.TokenSymbols.TokenSymbols[i]:=nil;
  end;
 end;
 setlength(Instance.TokenSymbols.TokenSymbols,0);
 Instance.TokenSymbols.StringTree.Destroy;
 Instance.TokenSymbols.StringTree:=nil;
 Finalize(Instance);
end;

end.
