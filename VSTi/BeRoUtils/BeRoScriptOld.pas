(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2004-2006, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoScript;
{$HINTS OFF}

interface

uses Windows,BeRoStream;

const BeRoScriptArchive='BeRoScriptArchive';
      BeRoScriptBuild=1;

      fmOpenRead=$0000;
      fmOpenWrite=$0001;
      fmOpenReadWrite=$0002;
      fmShareCompat=$0000;
      fmShareExclusive=$0010;
      fmShareDenyWrite=$0020;
      fmShareDenyRead=$0030;
      fmShareDenyNone=$0040;

      faReadOnly=$00000001;
      faHidden=$00000002;
      faSysFile=$00000004;
      faVolumeID=$00000008;
      faDirectory=$00000010;
      faArchive=$00000020;
      faAnyFile=$0000003f;

      IMPORTED_NAME_OFFSET=$00000002;
      IMAGE_ORDINAL_FLAG32=$80000000;
      IMAGE_ORDINAL_MASK32=$0000ffff;

      RTL_CRITSECT_TYPE=0;
      RTL_RESOURCE_TYPE=1;

      DLL_PROCESS_ATTACH=1;
      DLL_THREAD_ATTACH=2;
      DLL_THREAD_DETACH=3;
      DLL_PROCESS_DETACH=0;

      IMAGE_SizeHeader=20;

      IMAGE_FILE_RELOCS_STRIPPED=$0001;
      IMAGE_FILE_EXECUTABLE_IMAGE=$0002;
      IMAGE_FILE_LINE_NUMS_STRIPPED=$0004;
      IMAGE_FILE_LOCAL_SYMS_STRIPPED=$0008;
      IMAGE_FILE_AGGRESIVE_WS_TRIM=$0010;
      IMAGE_FILE_BYTES_REVERSED_LO=$0080;
      IMAGE_FILE_32BIT_MACHINE=$0100;
      IMAGE_FILE_DEBUG_STRIPPED=$0200;
      IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP=$0400;
      IMAGE_FILE_NET_RUN_FROM_SWAP=$0800;
      IMAGE_FILE_SYSTEM=$1000;
      IMAGE_FILE_DLL=$2000;
      IMAGE_FILE_UP_SYSTEM_ONLY=$4000;
      IMAGE_FILE_BYTES_REVERSED_HI=$8000;

      IMAGE_FILE_MACHINE_UNKNOWN=0;
      IMAGE_FILE_MACHINE_I386=$14c;
      IMAGE_FILE_MACHINE_R3000=$162;
      IMAGE_FILE_MACHINE_R4000=$166;
      IMAGE_FILE_MACHINE_R10000=$168;
      IMAGE_FILE_MACHINE_ALPHA=$184;
      IMAGE_FILE_MACHINE_POWERPC=$1f0;

      IMAGE_NUMBEROF_DIRECTORY_ENTRIES=16;

      IMAGE_SUBSYSTEM_UNKNOWN=0;
      IMAGE_SUBSYSTEM_NATIVE=1;
      IMAGE_SUBSYSTEM_WINDOWS_GUI=2;
      IMAGE_SUBSYSTEM_WINDOWS_CUI=3;
      IMAGE_SUBSYSTEM_OS2_CUI=5;
      IMAGE_SUBSYSTEM_POSIX_CUI=7;
      IMAGE_SUBSYSTEM_RESERVED=8;

      IMAGE_DIRECTORY_ENTRY_EXPORT=0;
      IMAGE_DIRECTORY_ENTRY_IMPORT=1;
      IMAGE_DIRECTORY_ENTRY_RESOURCE=2;
      IMAGE_DIRECTORY_ENTRY_EXCEPTION=3;
      IMAGE_DIRECTORY_ENTRY_SECURITY=4;
      IMAGE_DIRECTORY_ENTRY_BASERELOC=5;
      IMAGE_DIRECTORY_ENTRY_DEBUG=6;
      IMAGE_DIRECTORY_ENTRY_COPYRIGHT=7;
      IMAGE_DIRECTORY_ENTRY_GLOBALPTR=8;
      IMAGE_DIRECTORY_ENTRY_TLS=9;
      IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG=10;
      IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT=11;
      IMAGE_DIRECTORY_ENTRY_IAT=12;

      IMAGE_SIZEOF_SHORT_NAME=8;

      IMAGE_SCN_TYIMAGE_REG=$00000000;
      IMAGE_SCN_TYIMAGE_DSECT=$00000001;
      IMAGE_SCN_TYIMAGE_NOLOAD=$00000002;
      IMAGE_SCN_TYIMAGE_GROUP=$00000004;
      IMAGE_SCN_TYIMAGE_NO_PAD=$00000008;
      IMAGE_SCN_TYIMAGE_COPY=$00000010;
      IMAGE_SCN_CNT_CODE=$00000020;
      IMAGE_SCN_CNT_INITIALIZED_DATA=$00000040;
      IMAGE_SCN_CNT_UNINITIALIZED_DATA=$00000080;
      IMAGE_SCN_LNK_OTHER=$00000100;
      IMAGE_SCN_LNK_INFO=$00000200;
      IMAGE_SCN_TYIMAGE_OVER=$0000400;
      IMAGE_SCN_LNK_REMOVE=$00000800;
      IMAGE_SCN_LNK_COMDAT=$00001000;
      IMAGE_SCN_MEM_PROTECTED=$00004000;
      IMAGE_SCN_MEM_FARDATA=$00008000;
      IMAGE_SCN_MEM_SYSHEAP=$00010000;
      IMAGE_SCN_MEM_PURGEABLE=$00020000;
      IMAGE_SCN_MEM_16BIT=$00020000;
      IMAGE_SCN_MEM_LOCKED=$00040000;
      IMAGE_SCN_MEM_PRELOAD=$00080000;
      IMAGE_SCN_ALIGN_1BYTES=$00100000;
      IMAGE_SCN_ALIGN_2BYTES=$00200000;
      IMAGE_SCN_ALIGN_4BYTES=$00300000;
      IMAGE_SCN_ALIGN_8BYTES=$00400000;
      IMAGE_SCN_ALIGN_16BYTES=$00500000;
      IMAGE_SCN_ALIGN_32BYTES=$00600000;
      IMAGE_SCN_ALIGN_64BYTES=$00700000;
      IMAGE_SCN_LNK_NRELOC_OVFL=$01000000;
      IMAGE_SCN_MEM_DISCARDABLE=$02000000;
      IMAGE_SCN_MEM_NOT_CACHED=$04000000;
      IMAGE_SCN_MEM_NOT_PAGED=$08000000;
      IMAGE_SCN_MEM_SHARED=$10000000;
      IMAGE_SCN_MEM_EXECUTE=$20000000;
      IMAGE_SCN_MEM_READ=$40000000;
      IMAGE_SCN_MEM_WRITE=longword($80000000);

      IMAGE_REL_BASED_ABSOLUTE=0;
      IMAGE_REL_BASED_HIGH=1;
      IMAGE_REL_BASED_LOW=2;
      IMAGE_REL_BASED_HIGHLOW=3;
      IMAGE_REL_BASED_HIGHADJ=4;
      IMAGE_REL_BASED_MIPS_JMPADDR=5;
      IMAGE_REL_BASED_SECTION=6;
      IMAGE_REL_BASED_REL32=7;

      IMAGE_REL_BASED_MIPS_JMPADDR16=9;
      IMAGE_REL_BASED_IA64_IMM64=9;
      IMAGE_REL_BASED_DIR64=10;
      IMAGE_REL_BASED_HIGH3ADJ=11;

      PAGE_NOACCESS=1;
      PAGE_READONLY=2;
      PAGE_READWRITE=4;
      PAGE_WRITECOPY=8;
      PAGE_EXECUTE=$10;
      PAGE_EXECUTE_READ=$20;
      PAGE_EXECUTE_READWRITE=$40;
      PAGE_EXECUTE_WRITECOPY=$80;
      PAGE_GUARD=$100;
      PAGE_NOCACHE=$200;
      MEM_COMMIT=$1000;
      MEM_RESERVE=$2000;
      MEM_DECOMMIT=$4000;
      MEM_RELEASE=$8000;
      MEM_FREE=$10000;
      MEM_PRIVATE=$20000;
      MEM_MAPPED=$40000;
      MEM_RESET=$80000;
      MEM_TOP_DOWN=$100000;
      SEC_FILE=$800000;
      SEC_IMAGE=$1000000;
      SEC_RESERVE=$4000000;
      SEC_COMMIT=$8000000;
      SEC_NOCACHE=$10000000;
      MEM_IMAGE=SEC_IMAGE;

      ftNul=0;
      ftFile=1;

      ceUndefErr=4;
      ceLParenExp=5;
      ceRParenExp=6;
      ceThenExp=7;
      ceErrInExpr=8;
      ceExpectEql=9;
      ceExpectSet=10;
      ceUnexpectedEOF=11;
      ceVarNotDef=12;
      ceVarDoppelDefiniert=13;
      ceZahlenWertErwartet=14;
      ceKRParentErwartet=15;
      ceKeinArray=16;
      ceBezeichnerErwartet=17;
      ceFuncParamDefFehler=18;
      ceFuncParamNumFehler=19;
      ceFuncParamSetError=20;
      ceWhileErwartet=21;
      ceSemiColonErwartet=22;
      ceBeginErwartet=23;
      ceEndErwartet=24;
      ceNativeProcNichtGefunden=25;
      ceNativeProcIsNull=26;
      ceCaseErwartet=27;
      ceDoppelPunktErwartet=28;
      ceFixUpFehler=29;
      ceStructNotDefined=30;
      ceTypeExpected=31;
      ceNotStruct=32;
      ceWrongType=33;
      ceFloatTypeExpected=34;
      ceFloatOperationError=35;
      ceFloatInHexError=36;
      cePreprocessorError=37;
      ceLabelDoppelDefiniert=38;
      ceLabelNotFound=39;
      ceLabelNameVariableDefiniert=40;
      ceENumAlreadyDefined=41;
      ceENumStructAlreadyUsed=42;
      ceStringTypeExpected=43;
      ceStringExpected=44;
      CeIllegalStringOperation=45;
      ceStructExpected=46;
      ceIllegalStructOperation=47;
      ceStructOrUnionOrObjectStatementExpected=48;
      ceStructOrUnionOrObjectDoppelDefiniert=49;
      ceOnlyInMethodAllowed=50;
      ceNoInheritedCallPossible=51;
      ceCommaExp=52;
      ceImportProcNichtGefunden=53;
      ceImportProcIsNull=54;

      _keyword=0;
      _ident=1;
      _type=100;
      _enumstruct=150;
      _enumvalue=151;
      _label=200;
      _labelident=201;

      _lparent=2;
      _rparent=3;
      _integer=4;
      _unknow=9;
      _or=10;
      _plus=11;
      _minus=12;
      _mul=13;
      _div=14;
      _mod=15;
      _comma=16;
      _semicolon=17;
      _plusplus=18;
      _minusminus=19;
      _and=20;
      _eql=21;
      _neg=22;
      _lss=23;
      _lea=24;
      _gre=25;
      _gra=26;
      _doublepoint=27;
      _doubledoublepoint=28;
      _shortif=29;
      _do=30;
      _begin=31;
      _if=32;
      _switch=33;
      _case=34;
      _default=35;
      _else=36;
      _while=37;
      _end=38;
      _printf=39;
      _print=40;
      _set=41;
      _isnot=42;
      _shortint=43;
      _void=44;
      _char=45;
      _float=46;
      _for=47;
      _call=48;
      _int=49;
      _byte=50;
      _unsigned=51;
      _signed=52;
      _stringtype=53;
      _not=54;
      _klparent=55;
      _krparent=56;
      _static=57;
      _shl=58;
      _shr=59;
      _xor=60;
      _struct=61;
      _union=62;
      _object=63;
      _import=65;
      _break=70;
      _continue=71;
      _return=72;
      _native=75;
      _stdcall=76;
      _goto=77;
      _enum=78;
      _string=80;
      _packed=81;
      _inherited=82;
      _notbitwise=85;
      _dot=90;
      _usepointer=91;
      _floatnum=92;
      _asm=93;
      _outputblock=94;
      _sizeof=95;
      _breakpoint=96;

      tufutDifferenz=0;
      tufutAbsolut=1;
      tufutJump=2;
      tufutNative=3;
      tufutNativeRelative=4;
      tufutImport=4;
      tufutImportRelative=5;
      tufutClassPointer=6;

      tnttNative=0;
      tnttImport=1;

      tnFunctionResult='?FR!';
      tnFunctionObjectPointer='this';

type pbyte=^byte;
     plongword=^longword;
     plongint=^longint;
     PPOINTER=^pointer;
     PPLONGWORD=^plongword;

     pword=^word;
     PPWORD=^pword;

     HINST=longword;
     HMODULE=HINST;

     PWordArray=^TWordArray;
     TWordArray=array[0..(2147483647 div sizeof(word))-1] of word;

     PLongWordArray=^TLongWordArray;
     TLongWordArray=array [0..(2147483647 div sizeof(longword))-1] of longword;

     PImageDOSHeader=^TImageDOSHeader;
     TImageDOSHeader=packed record
      Signature:word;
      PartPag:word;
      PageCnt:word;
      ReloCnt:word;
      HdrSize:word;
      MinMem:word;
      MaxMem:word;
      ReloSS:word;
      ExeSP:word;
      ChkSum:word;
      ExeIP:word;
      ReloCS:word;
      TablOff:word;
      Overlay:word;
      Reserved:packed array[0..3] of word;
      OEMID:word;
      OEMInfo:word;
      Reserved2:packed array[0..9] of word;
      LFAOffset:longword;
     end;

     TISHMisc=packed record
      case integer of
       0:(PhysicalAddress:longword);
       1:(VirtualSize:longword);
     end;

     PImageExportDirectory=^TImageExportDirectory;
     TImageExportDirectory=packed record
      Characteristics:longword;
      TimeDateStamp:longword;
      MajorVersion:word;
      MinorVersion:word;
      name:longword;
      Base:longword;
      NumberOfFunctions:longword;
      NumberOfNames:longword;
      AddressOfFunctions:PPLONGWORD;
      AddressOfNames:PPLONGWORD;
      AddressOfNameOrdinals:PPWORD;
     end;

     PImageSectionHeader=^TImageSectionHeader;
     TImageSectionHeader=packed record
      name:packed array[0..IMAGE_SIZEOF_SHORT_NAME-1] of byte;
      Misc:TISHMisc;
      VirtualAddress:longword;
      SizeOfRawData:longword;
      PointerToRawData:longword;
      PointerToRelocations:longword;
      PointerToLinenumbers:longword;
      NumberOfRelocations:word;
      NumberOfLinenumbers:word;
      Characteristics:longword;
     end;

     PImageSectionHeaders=^TImageSectionHeaders;
     TImageSectionHeaders=array[0..(2147483647 div sizeof(TImageSectionHeader))-1] of TImageSectionHeader;

     PImageDataDirectory=^TImageDataDirectory;
     TImageDataDirectory=packed record
      VirtualAddress:longword;
      Size:longword;
     end;

     PImageFileHeader=^TImageFileHeader;
     TImageFileHeader=packed record
      Machine:word;
      NumberOfSections:word;
      TimeDateStamp:longword;
      PointerToSymbolTable:longword;
      NumberOfSymbols:longword;
      SizeOfOptionalHeader:word;
      Characteristics:word;
     end;

     PImageOptionalHeader=^TImageOptionalHeader;
     TImageOptionalHeader=packed record
      Magic:word;
      MajorLinkerVersion:byte;
      MinorLinkerVersion:byte;
      SizeOfCode:longword;
      SizeOfInitializedData:longword;
      SizeOfUninitializedData:longword;
      AddressOfEntryPoint:longword;
      BaseOfCode:longword;
      BaseOfData:longword;
      ImageBase:longword;
      SectionAlignment:longword;
      FileAlignment:longword;
      MajorOperatingSystemVersion:word;
      MinorOperatingSystemVersion:word;
      MajorImageVersion:word;
      MinorImageVersion:word;
      MajorSubsystemVersion:word;
      MinorSubsystemVersion:word;
      Win32VersionValue:longword;
      SizeOfImage:longword;
      SizeOfHeaders:longword;
      CheckSum:longword;
      Subsystem:word;
      DllCharacteristics:word;
      SizeOfStackReserve:longword;
      SizeOfStackCommit:longword;
      SizeOfHeapReserve:longword;
      SizeOfHeapCommit:longword;
      LoaderFlags:longword;
      NumberOfRvaAndSizes:longword;
      DataDirectory:packed array[0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES-1] of TImageDataDirectory;
     end;

     PImageNTHeaders=^TImageNTHeaders;
     TImageNTHeaders=packed record
      Signature:longword;
      FileHeader:TImageFileHeader;
      OptionalHeader:TImageOptionalHeader;
     end;

     PImageImportDescriptor=^TImageImportDescriptor;
     TImageImportDescriptor=packed record
      OriginalFirstThunk:longword;
      TimeDateStamp:longword;
      ForwarderChain:longword;
      name:longword;
      FirstThunk:longword;
     end;

     PImageBaseRelocation=^TImageBaseRelocation;
     TImageBaseRelocation=packed record
      VirtualAddress:longword;
      SizeOfBlock:longword;
     end;

     PImageThunkData=^TImageThunkData;
     TImageThunkData=packed record
      ForwarderString:longword;
      Funktion:longword;
      Ordinal:longword;
      AddressOfData:longword;
     end;

     PSection=^TSection;
     TSection=packed record
      Base:pointer;
      RVA:longword;
      Size:longword;
      Characteristics:longword;
     end;

     TSections=array of TSection;

     TDLLEntryProc=function(hinstDLL:HMODULE;dwReason:longword;lpvReserved:pointer):boolean; stdcall;

     TNameOrID=(niName,niID);

     TExternalLibrary=record
      LibraryName:string;
      LibraryHandle:HINST;
     end;

     TExternalLibrarys=array of TExternalLibrary;

     PDLLFunctionImport=^TDLLFunctionImport;
     TDLLFunctionImport=record
      NameOrID:TNameOrID;
      name:string;
      ID:integer;
     end;

     PDLLImport=^TDLLImport;
     TDLLImport=record
      LibraryName:string;
      LibraryHandle:HINST;
      Entries:array of TDLLFunctionImport;
     end;

     TImports=array of TDLLImport;

     PDLLFunctionExport=^TDLLFunctionExport;
     TDLLFunctionExport=record
      name:string;
      index:longword;
      FunctionPointer:pointer;
     end;

     TExports=array of TDLLFunctionExport;

     TExportTreeLink=pointer;

     PExportTreeNode=^TExportTreeNode;
     TExportTreeNode=record
      TheChar:char;
      Link:TExportTreeLink;
      LinkExist:boolean;
      Prevoius,Next,Up,Down:PExportTreeNode;
     end;

     TExportTree=class
      private
       Root:PExportTreeNode;
      public
       constructor Create;
       destructor Destroy; override;
       procedure Dump;
       function Add(FunctionName:string;Link:TExportTreeLink):boolean;
       function Delete(FunctionName:string):boolean;
       function Find(FunctionName:string;var Link:TExportTreeLink):boolean;
     end;

     TDynamicLinkLibrary=class
      private
       ImageBase:pointer;
       ImageBaseDelta:integer;
       DLLName:string;
       DLLProc:TDLLEntryProc;
       DLLHandle:HINST;
       ExternalLibraryArray:TExternalLibrarys;
       ImportArray:TImports;
       ExportArray:TExports;
       Sections:TSections;
       ExportTree:TExportTree;
       function FindExternalLibrary(LibraryName:string):integer;
       function LoadExternalLibrary(LibraryName:string):integer;
       function GetExternalLibraryHandle(LibraryName:string):HINST;
      public
       constructor Create(DynamicLinkLibraryName:string='');
       destructor Destroy; override;
       function Load(Stream:TBeRoStream):boolean;
       function LoadFile(FileName:string):boolean;
       function Unload:boolean;
       function FindExport(FunctionName:string):pointer;
       property name:string read DLLName;
     end;

     TDynamicLinkLibrarys=array of TDynamicLinkLibrary;

     Int64Rec=packed record
      Lo,Hi:longword;
     end;

     LongRec=packed record
      Lo,Hi:word;
     end;

     TFileName=string;

     TSearchRec=record
      Time,Size,Attr:integer;
      name:TFileName;
      ExcludeAttr:integer;
      FindHandle:THandle;
      FindData:TWin32FindData;
     end;

     PBeRoCompressCompressionDataArray=^TBeRoCompressCompressionDataArray;
     TBeRoCompressCompressionDataArray=array[0..2147483647-1] of byte;

     TBeRoScriptSign=packed array[1..4] of char;

     TBeRoArchiveSign=packed array[0..length(BeRoScriptArchive)-1] of char;
     TBeRoArchiveBuf=packed array[1..8192] of char;

     TBeRoArchiveHeader=packed record
      Sign:TBeRoArchiveSign;
      KeyHash:longword;
     end;

     TBeRoArchiveFile=packed record
      FileNameLength:word;
      FileType:byte;
      Size:longword;
      KeyHash:longword;
     end;

     TBeRoArchiveFileParam=packed record
      FileName:string;
      Data:TBeRoArchiveFile;
     end;

     TBeRoArchive=class
      private
       fOpen:boolean;
       fInitSearch:boolean;
       fStream:TBeRoStream;
       fKey:TBeRoStream;
       fSubKey:TBeRoStream;
       fHeader:TBeRoArchiveHeader;
       procedure EncodeBuffer(var B:TBeRoArchiveBuf);
       procedure DecodeBuffer(var B:TBeRoArchiveBuf);
       function FindNextEx:TBeRoArchiveFileParam;
      protected
      public
       FastCompression:boolean;
       constructor Create;
       destructor Destroy; override;
       procedure SetKey(AStream:TBeRoStream); overload;
       procedure SetKey(AKey:string); overload;
       procedure SetSubKey(AStream:TBeRoStream); overload;
       procedure SetSubKey(AKey:string); overload;
       function IsArchive(AStream:TBeRoStream):boolean;
       function IsCrypted(AStream:TBeRoStream):boolean;
       function CreateArchive(AStream:TBeRoStream):boolean;
       function OpenArchive(AStream:TBeRoStream):boolean;
       procedure CloseArchive;
       function Add(FileNameInArchive:string;AStream:TBeRoStream):boolean;
       function AddString(FileNameInArchive:string;AString:string):boolean;
       procedure InitSearch;
       function FindNext:TBeRoArchiveFileParam;
       function EndOfArchive:boolean;
       function IsFileCrypted(FileNameInArchive:string):boolean;
       function Extract(FileNameInArchive:string;AStream:TBeRoStream):boolean;
       function GetString(FileNameInArchive:string):string;
       procedure Delete(FileNameInArchive:string);
      published
     end;

     TWert=integer;
     TTyp=(tNichts,tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt,tuInt,tInt,tFloat,tVoid,tString,tType);
     TArt=(aGlobal,aLokal,aStatic,aParam,aShadowParam,aStructVar);

     PNameTabelleEintrag=^TNameTabelleEintrag;
     TNameTabelleEintrag=record
      name,StructName,Proc,AsmVarName:string[255];
      Obj:byte;
      Typ:TTyp;
      TypLink:integer;
      InTypLink:integer;
      Zeiger,IstArray:boolean;
      Art:TArt;
      storage,StackPtr,symptr,StackAlloc,Bytes2Pass,SubNum,ProcNr,
      ParamNum,ShadowParamNum,TotalParamNum,ArrayDim,Size,BTyp,
      Feld_Offset:integer;
      EinTyp,InTyp:boolean;
      Wert:integer;
      native:boolean;
      import:boolean;
      isstdcall:boolean;
      Param:array of integer;
      Adr:TWert;
      Tok:byte;
     end;

     TNameTabelle=array of TNameTabelleEintrag;

     TTypTabelleEintrag=record
      name:string[255];
      IsPacked:boolean;
      StackAlloc,Bytes2Pass,Size,Felder:integer;
      VariableNum:integer;
      Variable:array of integer;
      Extends:array of integer;
      ExtendsOffsets:array of integer;
     end;

     TTypTabelle=array of TTypTabelleEintrag;

     TNativeTabelleEintrag=packed record
      name:string[255];
      AsmVarName:string[255];
      Proc:pointer;
     end;
     TNativeTabelle=array of TNativeTabelleEintrag;

     TImportTabelleEintrag=packed record
      name:string[255];
      AsmVarName:string[255];
      LibraryName:string[255];
      LibraryFunction:string[255];
     end;
     TImportTabelle=array of TImportTabelleEintrag;

     TBlock=packed array[1..8192] of char;

     TStringHandling=record
      IstZeiger:boolean;
     end;

     TMethod=procedure of object;

     TLabelFixUpEintrag=packed record
      name:string[255];
      Offset:longint;
     end;

     TUseFixUpEintrag=packed record
      Typ:byte;
      name:string[255];
      Offset:longint;
      AddOffset:longint;
     end;

     TProcEintrag=packed record
      name:string[255];
      Offset:longword;
     end;

     TVariableEintrag=packed record
      name:string[255];
      Offset:longword;
     end;

     TDefine=record
      name:string[255];
      Lines:string;
      Parameter:array of string[255];
     end;

     PBeRoScriptString=^TBeRoScriptString;
     TBeRoScriptString=packed record
{$IFDEF FPC}
      MaxLength:longword;
      length:longword;
      Reference:longint;
{$ELSE}
      Reference:longint;
      length:longword;
{$ENDIF}
      FirstChar:char;
     end;

     PPBeRoScriptString=^PBeRoScriptString;

     BeRoString=pointer;

     TBeRoScript=class;

     TBeRoScriptStringEvent=function(ABeRoScript:TBeRoScript):string;
     TBeRoScriptEvent=procedure(ABeRoScript:TBeRoScript);

     TBeRoLine=record
      LineNumber:integer;
      FileIndex:integer;
     end;

     TBeRoLineInfo=record
      PreparsedLines:array of TBeRoLine;
      Lines:array of TBeRoLine;
      Files:array of string;
     end;

     TBeRoScript=class
      private
       fOnOwnPreCode:TBeRoScriptStringEvent;
       fOnOwnNativesPointers:TBeRoScriptEvent;
       fOnOwnNativesDefinitions:TBeRoScriptEvent;
       CacheDir:string;
       AktProc,AktSymPtr,AktTypPtr:integer;
       AktProcName:string;
       AktTyp:TTyp;
       ferror,frunning,feof,inmain:boolean;
       Level,VarSize:integer;
       UseOutputBlock,UseWrtSTR,UseWrtAXSigned,UseWrtAXUnsigned,
       UseWrtChar,UseWrtPCharString,UseWrtFloat,UseStrNew,UseStrAssign,
       UseStrLength,UseStrSetLength,UseStrUnique,UseStrCharConvert,UseStrGet,
       UseStrConcat,UseStrSelfConcat,UseStrCompare:boolean;
       ContinueLabel,BreakLabel:array of string[255];
       LabelArray:array of string;
       LinesInfo:TBeRoLineInfo;
       SBuf:string;
       QuelltextPos,QuelltextZeile,QuelltextSpalte:integer;
       ch:char;
       DP,p,StrWert:longword;
       fTok:single;
       iTok:int64;
       tTok:byte;
       tnZaehler,ttZaehler,tnpZaehler,tnSubZaehler:integer;
       GeneratiereLabelNr,AsmVarNr:integer;
       NameTabelle:array of TNameTabelleEintrag;
       TypTabelle:array of TTypTabelleEintrag;
       NativeTabelle:array of TNativeTabelleEintrag;
       ImportTabelle:array of TImportTabelleEintrag;
       LabelFixUpTabelle:array of TLabelFixUpEintrag;
       UseFixUpTabelle:array of TUseFixUpEintrag;
       ProcTabelle:array of TProcEintrag;
       VariableTabelle:array of TVariableEintrag;
       Defines:array of TDefine;
       sTok,AktStr:string;
       QuellStream:TBeRoMemoryStream;
       StringHandling:TStringHandling;
       Fehler:boolean;
       IsCompiled:boolean;
       CodeStream:TBeRoMemoryStream;
       CodeProc:procedure;
       IsStringTerm:boolean;
       MustBeStringTerm:boolean;
       StringLevel:integer;
       IsFloatExpression:boolean;
       CodeFileName:string;
       CodeName:string;
       SourceChecksumme:longword;
       IsTermSigned:boolean;
       BSSGroesse:longword;
       DynamicLinkLibrarys:TDynamicLinkLibrarys;
       function MTRIM(S:string):string;
       function MUPPERCASE(S:string):string;
       function MeinePosition(Wo,Was:string;AbWo:integer):integer;
       function StringErsetzen(Wo,Von,Mit:string):string;
       procedure CompilerCreate;
       procedure IncLevel;
       procedure DecLevel;
       procedure SetError(err:integer);
       procedure ByteHinzufuegen(B:byte);
       procedure WordHinzufuegen(W:word);
       procedure DWordHinzufuegen(DW:longword);
       procedure ProcHinzufuegen(S,SO:string);
       procedure VariableHinzufuegen(S,SO:string);
       procedure DifferenzLabelFixUpHinzufuegen(S:string);
       procedure JumpLabelFixUpHinzufuegen(S:string);
       procedure LabelFixUpHinzufuegen(S:string;Offset:longint);
       procedure LabelAdresseHinzufuegen(S:string);
       procedure LabelAdresseOffsetHinzufuegen(S:string;Offset:longint);
       procedure LabelHinzufuegen(S:string);
       procedure NativeFixUpHinzufuegen(NativeName:string);
       procedure NativeRelativeFixUpHinzufuegen(NativeName:string);
       procedure ImportFixUpHinzufuegen(ImportName:string);
       procedure ImportRelativeFixUpHinzufuegen(ImportName:string);
       procedure ClassPointerFixUpHinzufuegen;
       procedure CodeFixen(CodeOffset:longword);
       procedure CallLabel(S:string);
       procedure JZLabel(S:string);
       procedure JNZLabel(S:string);
       procedure JumpLabel(S:string);
       function GeneratiereLabel:string;
       function AsmVar:string;
       function GetLabelName(S:string):string;
       function GetStructTempVariableName(TypLink:integer):string;
       function GetObjectTempVariableName(TypLink:integer):string;
       function GetStringTempVariableName(Nummer:integer):string;
       function GetStringLevelVariableName:string;
       function GetStringVariableName:string;
       function AddObjekt(name,StructName:string;Obj:byte;Typ:TTyp;Adr:TWert;ArrayDim:integer;Art:TArt;Zeiger,InTyp:boolean;TypLink,Wert:integer):word;
       function Find(name,StructName:string;Ident:boolean;var ENT:TNameTabelleEintrag;var SymNr:integer;TypLink:integer):boolean;
       function LockKey(name:string):byte;
       function LockVar(name,StructName:string;var AsmVarName:string;var Adr:TWert;define:boolean;TypLink:integer):boolean;
       procedure OutJmp(S:string);
       procedure OutLabel(S:string);
       procedure OutRet;
       procedure OutRetEx;
       procedure OutRetValue(I:longword);
       procedure OutOutputBlock;
       procedure OutWrtAXSigned;
       procedure OutWrtAXUnsigned;
       procedure OutWrtFloatAX;
       procedure OutWrtStr;
       procedure OutWrtPCharString;
       procedure OutWrtChar;
       procedure OutStrNew;
       procedure OutStrIncrease;
       procedure OutStrDecrease;
       procedure OutStrAssign;
       procedure OutStrLength;
       procedure OutStrSetLength;
       procedure OutStrUnique;
       procedure OutStrCharConvert;
       procedure OutStrGet;
       procedure OutStrConcat;
       procedure OutStrSelfConcat;
       procedure OutStrCompare;
       procedure OutClrESPStr;
       procedure OutLeaESPStr;
       procedure OutMovESPStr;
       procedure OutLeaESPStruct;
       procedure OutMovESPStruct;
       procedure OutMovEAXStruct(Size:longword);
       procedure OutMovEBXEAXStruct(Size:longword);
       procedure OutJzIf(S:string);
       procedure OutJzIfBx(S:string);
       procedure OutEql;
       procedure OutNe;
       procedure OutLss;
       procedure OutLea;
       procedure OutGre;
       procedure OutGra;
       procedure OutStrBXTest;
       procedure OutStrEql;
       procedure OutStrNe;
       procedure OutStrLss;
       procedure OutStrLea;
       procedure OutStrGre;
       procedure OutStrGra;
       procedure OutNotAxBoolean;
       procedure OutNotAxBitwise;
       procedure OutNegAx;
       procedure OutPushSi;
       procedure OutPopSi;
       procedure OutPushDi;
       procedure OutPopDi;
       procedure OutMovCxSp;
       procedure OutMovSpCx;
       procedure OutMovBpSp;
       procedure OutMovSpBp;
       procedure OutMovSiAx;
       procedure OutMovBxSi;
       procedure OutMoveFromEBXToStack(Size:longword;Position:longint);
       procedure OutMoveFromEBXToEAX(Size:longword);
       procedure OutPush32(I:longword);
       procedure OutPushClassPointer;
       procedure OutPushAx32;
       procedure OutPushAx16;
       procedure OutPushAx8;
       procedure OutPushAx;
       procedure OutPushBx;
       procedure OutPopAx;
       procedure OutPopBx;
       procedure OutPushCx;
       procedure OutPushDx;
       procedure OutPopCx;
       procedure OutPopDx;
       procedure OutPushBp;
       procedure OutPopBp;
       procedure OutMulDx;
       procedure OutMulBx;
       procedure OutDivBx;
       procedure OutModBx;
       procedure OutIMulBx;
       procedure OutIDivBx;
       procedure OutIModBx;
       procedure OutAndBx;
       procedure OutOrBx;
       procedure OutShlCx(I:byte);
       procedure OutShlBx;
       procedure OutShrBx;
       procedure OutSalBx;
       procedure OutSarBx;
       procedure OutXorBx;
       procedure OutXorAxAx;
       procedure OutXorBxBx;
       procedure OutXorCxCx;
       procedure OutAddAxBx;
       procedure OutAddAxCx;
       procedure OutAddBxAx;
       procedure OutAddBxCx;
       procedure OutSubAxBx;
       procedure OutMovBxAx;
       procedure OutLeaBxAxPlusOne;
       procedure OutMovAxBx;
       procedure OutMovCxAx;
       procedure OutMovCxBx;
       procedure OutMovBxFromBx;
       procedure OutMovCxFromBx;
       procedure OutMovBxCx;
       procedure OutMovDxImmSigned(S:longint);
       procedure OutMovDxImmUnsigned(S:longword);
       procedure OutMovAxImmSigned(S:longint);
       procedure OutMulAxImmSigned(S:longint);
       procedure OutMovAxImmUnsigned(S:longword);
       procedure OutMovAxImmLabel(S:string);
       procedure OutMovAxVar32(S:string);
       procedure OutMovAxVarLabel(S:string;Size:byte);
       procedure OutMovsxAxVarLabel(S:string;Size:byte);
       procedure OutMovAxVarEBXLabel(S:string;Size:byte);
       procedure OutMovsxAxVarEBXLabel(S:string;Size:byte);
       procedure OutMovESPAx(Offset:integer;Size:byte);
       procedure OutMovAxVarEBP(Offset:integer;Size:byte);
       procedure OutMovsxAxVarEBP(Offset:integer;Size:byte);
       procedure OutMovAxVarEBX(Offset:integer;Size:byte);
       procedure OutMovsxAxVarEBX(Offset:integer;Size:byte);
       procedure OutMovBxVarLabel(S:string;Size:byte);
       procedure OutMovBxVarEBP(Offset:integer;Size:byte);
       procedure OutMovCxVarEBP(Offset:integer;Size:byte);
       procedure OutMovVarLabelAx(S:string;Size:byte);
       procedure OutMovVarEBPAx(Offset:integer;Size:byte);
       procedure OutMovVarEBXAx(Offset:integer;Size:byte);
       procedure OutMovVarEBXLabelAx(S:string;Size:byte);
       procedure OutIncVarEBX(Offset:integer;Size:byte);
       procedure OutDecVarEBX(Offset:integer;Size:byte);
       procedure OutIncVarEBP(Offset:integer;Size:byte);
       procedure OutDecVarEBP(Offset:integer;Size:byte);
       procedure OutIncVarLabel(S:string;Size:byte);
       procedure OutDecVarLabel(S:string;Size:byte);
       procedure OutIncVarLabelEBX(S:string;Size:byte);
       procedure OutDecVarLabelEBX(S:string;Size:byte);
       procedure OutAddVarLabel(S:string;Size:byte;Value:longword);
       procedure OutSubVarLabel(S:string;Size:byte;Value:longword);
       procedure OutAddVarEBP(Offset:integer;Size:byte;Value:longword);
       procedure OutSubVarEBP(Offset:integer;Size:byte;Value:longword);
       procedure OutMovEAXEBP;
       procedure OutLeaEAXEBP(Offset:integer);
       procedure OutLeaEAXEBPECX(Offset:integer;Size:byte);
       procedure OutLeaEAXImmLabelECX(S:string;Size:byte);
       procedure OutLeaEAXEBPEBX(Offset:integer;Size:byte);
       procedure OutLeaEAXImmLabelEBX(S:string;Size:byte);
       procedure OutLeaEBXEBP(Offset:integer);
       procedure OutSubESP(I:longword);
       procedure OutAddESP(I:longword);
       procedure OutSubEAX(I:longword);
       procedure OutAddEAX(I:longword);
       procedure OutMovBxImmSigned(S:longint);
       procedure OutMovBxImmUnsigned(S:longword);
       procedure OutMovBxImmLabel(S:string);
       procedure OutMovBxImmLabelOffset(S:string;Offset:integer);
       procedure OutMovEBXEBP;
       procedure OutMovzxEAXAL;
       procedure OutSubEBX(I:longword);
       procedure OutAddEBX(I:longword);
       procedure OutAddECX(I:longword);
       procedure OutMovAxVarAdr(S:string;index:integer;Zeiger,UseArray:boolean);
       procedure OutMovAxVar(S:string;index:integer;Zeiger,UseArray:boolean);
       procedure OutMovVarAx(S:string;index:integer;Zeiger,UseArray:boolean);
       procedure OutIncVar(S:string;Zeiger,UseArray:boolean);
       procedure OutDecVar(S:string;Zeiger,UseArray:boolean);
       procedure OutIncStructVar;
       procedure OutDecStructVar;
       procedure OutIncFPU;
       procedure OutDecFPU;
       procedure OutMovToStructVar(Variable:integer);
       procedure OutMovFromStructVar(Variable:integer);
       procedure OutCall(S,SO:string);
       procedure OutCallAx;
       procedure OutCallBx;
       procedure OutCallNative(name:string);
       procedure OutCallImport(name:string);
       function HexB(B:byte):string;
       function HexW(W:word):string;
       function FlagIsSet(Flags:byte;FlagMask:byte):boolean;
       function LeseNaechstesZeichen:char;
       procedure Get;
       procedure OutXChgAxBx;
       procedure OutFPULD1;
       procedure OutIntAXtoFPU;
       procedure OutFPUToIntAX;
       procedure OutAXtoFPU;
       procedure OutFPUtoAX;
       procedure OutAXtoStack;
       procedure OutStacktoAX;
       procedure OutFPUAddEx;
       procedure OutFPUSubEx;
       procedure OutFPUAdd;
       procedure OutFPUSub;
       procedure OutFPUMul;
       procedure OutFPUDiv;
       procedure OutFPUWait;
       procedure OutFPULss;
       procedure OutFPULea;
       procedure OutFPUGre;
       procedure OutFPUGra;
       procedure FloatFactor;
       procedure FloatTerm;
       procedure FloatExpression;
       procedure FloatBoolExpression;
       procedure FloatBoolExpressionEx;
       function Factor:boolean;
       function Term:boolean;
       function Expression:boolean;
       function BoolExpression:boolean;
       procedure StringFactor;
       procedure StringTerm;
       procedure StringExpression(Standalone:boolean);
       procedure StringBoolExpression(Standalone:boolean);
       procedure StructFactor;
       procedure DoExpression;
       procedure DoExpressionEx;
       procedure PrntStatement;
       procedure ASMStatement;
       procedure ReturnStatement;
       procedure Assignment;
       function LookDLL(name:string):integer;
       function LookNative(name:string):integer;
       function LookImport(name:string):integer;
       function LookNativeAsmVar(name:string):integer;
       function LookImportAsmVar(name:string):integer;
       function IsStruct(name:string):boolean;
       function LookStruct(name:string):integer;
       function LookStructVar(name:string):integer;
       function LookVarStruct(SymPtr:integer):integer;
       function VarStruct(StartLevel:boolean):boolean;
       procedure AddImportProc(name,LibraryName,FunctionName:string);
       procedure AssignmentOrVarStruct;
       procedure WhileState;
       procedure DoWhileState;
       procedure ForState;
       procedure IfState;
       procedure SwitchState;
       function CallState(Selbststaendig,UseEBX,Klammern:boolean):integer;
       procedure BeginState;
       function StructAssignment(IstZeiger,StringWrite,IsObjectVar,NoCode:boolean):boolean;
       procedure StructStatement(StartLevel,IsUnion,IsObject:boolean);
       function AreInThatStrings(SymPtr:integer):boolean;
       function FunctionStringFree(SymPtr:integer;Art:TArt;Offset,SubOffset:integer):integer;
       procedure VarDefStatement(StartLevel,FuncParam,Struct:boolean;Typ:integer;IsStructStatement:boolean);
       procedure LabelStatement;
       procedure GotoStatement;
       procedure enumStatement(Art:TArt);
       procedure BreakPointStatement;
       procedure OutputBlockStatement;
       procedure SizeOfStatement;
       procedure InheritedStatement;
       procedure IdentStatement;
       procedure Statement(Semicolon:boolean);
       procedure FirstStatement;
       procedure Init;
       procedure OutRTL;
       procedure DoCompile;
       procedure Preprocessor;
       function LoadCode:boolean;
       procedure SaveCode;
       procedure CopyCode;
       procedure RunProc(S:string);
      public
       CacheCompression:boolean;
       FastCacheCompression:boolean;
       Alignment:boolean;
       OutDirect:boolean;
       Debug:boolean;
       CodePointer:pointer;
       CodeLength:integer;
       LineDifference:integer;
       Errors:string;
       Output:string;
       BeginBlock:integer;
       EndBlock:integer;
       Blocks:array of string;
       Archive:TBeRoArchive;
       constructor Create(TheCacheDir:string;SubCacheDir:string='BeRoScriptCache');
       destructor Destroy; override;
       procedure ClearBlocks;
       procedure Clear;
       procedure AddNativeProc(name:string;Proc:pointer);
       procedure AddDefine(name:string);
       procedure AddString(const S:string);
       procedure AddNativePointers;
       procedure AddNativeDefinitions;
       function Compile(Source:string;name:string=''):boolean;
       function CompileFile(SourceFile:string):boolean;
       procedure RunStart;
       procedure RunMain;
       procedure RunEnd;
       procedure Run;
       function GetProcPointer(name:string):pointer;
       function GetVariablePointer(name:string):pointer;
       procedure OutputBlock(BlockNummer:integer);
       function ParseWebScript(FileName:string):string;
       function RunWebScript(FileName:string):boolean;
       function RunArchive(Stream:TBeRoStream;name:string=''):boolean;
       function RunArchiveFile(FileName:string):boolean;
       property Compiled:boolean read IsCompiled;
       property OnOwnPreCode:TBeRoScriptStringEvent read fOnOwnPreCode write fOnOwnPreCode;
       property OnOwnNativesPointers:TBeRoScriptEvent read fOnOwnNativesPointers write fOnOwnNativesPointers;
       property OnOwnNativesDefinitions:TBeRoScriptEvent read fOnOwnNativesDefinitions write fOnOwnNativesDefinitions;
     end;

var RandomSeed:longword;
    RandomFactor:longword;
    RandomIncrement:longword;

procedure RegisterExtensions;
function RandomValue:longword;
function RandomFloatValue:single;
function CountActiveBits(Wert:longword):longword;
function CountBits(Wert:longword):byte; overload;
function SlowCountBits(Wert:longword):byte; overload;
function CountBitsSigned(Wert:longint):byte; overload;
function SlowCountBitsSigned(Wert:longint):byte; overload;
function CountBits(Wert:longword;MinBits:byte):byte; overload;
function SlowCountBits(Wert:longword;MinBits:byte):byte; overload;
function CountBitsSigned(Wert:longint;MinBits:byte):byte; overload;
function SlowCountBitsSigned(Wert:longint;MinBits:byte):byte; overload;
function MinInt(A,B:longint):longint;
function Min(A,B:longword):longword; overload;
function Min(A,B:single):single; overload;
function MaxInt(A,B:longint):longint;
function Max(A,B:longword):longword; overload;
function Max(A,B:single):single; overload;
function FixedCast(A:single):longint;
function ExtractFileExt(S:string):string;
function ExtractFileName(S:string):string;
function ExtractFilePath(S:string):string;
function ChangeFileExt(S,E:string):string;
function GetApplicationDir:string;
function GetCurrentDir:string;
function GetTempDir:string;
function GetWinDir:string;
function GetSystemDir:string;
function GetTemp:string;
function FILEEXISTS(S:string):boolean;
function FILESETATTR(const Dateiname:string;Attr:integer):integer;
function PFindMatchingFile(var F:TSearchRec):integer;
function PFindNext(var F:TSearchRec):integer;
procedure PFindClose(var F:TSearchRec);
function PFindFirst(const Path:string;Attr:integer;var F:TSearchRec):integer;
procedure LoescheDatei(const Datei:string);
procedure LoescheDateien(const Path,Mask:string;SubDirectories:boolean);
function ConvertFromBeRoString(Src:BeRoString):string;
function ConvertToBeRoString(Src:string):BeRoString;
function LOG2(I:integer):integer;
function ReadFileAsString(SourceFile:string):string;
function INTTOSTR(I:integer):string;
function TRIM(const S:string):string;
function UPPERCASE(const S:string):string;
function LOWERCASE(const S:string):string;
function CRC32(Data:TBeRoStream):longword; overload;
function CRC32(Data:string):longword; overload;
function ProcessCompress(var SourcePointer,DestinationPointer:pointer;Size:longword):longword;
function ProcessDecompress(var SourcePointer,DestinationPointer:pointer;Size:longword):longword;
procedure Compression(Source,Destination:TBeRoStream;Fast:boolean); overload;
procedure Decompression(Source,Destination:TBeRoStream); overload;
procedure Encode(Data,Key:TBeRoStream); overload;
procedure Decode(Data,Key:TBeRoStream); overload;
function Encode(Data:string;Key:TBeRoStream):string; overload;
function Decode(Data:string;Key:TBeRoStream):string; overload;
function Encode(Data,Key:string):string; overload;
function Decode(Data,Key:string):string; overload;
procedure Encode(var Data;DataLength:longword;Key:TBeRoStream); overload;
procedure Decode(var Data;DataLength:longword;Key:TBeRoStream); overload;
procedure Encode(var Data;DataLength:longword;Key:string); overload;
procedure Decode(var Data;DataLength:longword;Key:string); overload;
function Starten(const Dateiname,Parameter:string;FensterStatus:word):boolean;
function Ausfuehren(Dateiname,Parameter:string):boolean;
function Int64ToBase(Value,Base:int64):string; register;
function Int64ToHex(Value:int64):string; register;
function IntToBase(Value,Base:integer):string; register;
function IntToHex(Value:integer):string; register;
function LongWordToBase(Value,Base:longword):string; register;
function LongWordToHex(Value:longword):string; register;

implementation

const strRecordLength=sizeof(TBeRoScriptString);
      strStartOffset=strRecordLength-1;
      MySign:TBeRoArchiveSign=BeRoScriptArchive;
      MyCacheSign:TBeRoScriptSign='BSCF';

var CRCTabelle:array[0..255] of longword;

procedure RegisterExtension(Extension:string);
var Key:HKEY;
    S:string;
begin
 if RegCreateKeyEx(HKEY_CLASSES_ROOT,pchar(Extension),0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Key,nil)=ERROR_SUCCESS then begin
  S:='BeRoScript';
  if RegSetValueEx(Key,'',0,REG_SZ,pchar(S),length(S))=ERROR_SUCCESS then begin
   if RegSetValueEx(Key,'Content Type',0,REG_SZ,pchar(S),length(S))=ERROR_SUCCESS then begin
   end;
  end;
  RegCloseKey(Key);
 end;
end;

procedure RegisterEnginePart;
var Key,Key2:HKEY;
    S:string;
begin
 if RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Key,nil)=ERROR_SUCCESS then begin
  S:='BeRoScript File';
  if RegSetValueEx(Key,'',0,REG_SZ,pchar(S),length(S))=ERROR_SUCCESS then begin
   if RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\DefaultIcon',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Key2,nil)=ERROR_SUCCESS then begin
    S:=PARAMSTR(0)+',0';
    if RegSetValueEx(Key2,'',0,REG_SZ,pchar(S),length(S))=ERROR_SUCCESS then begin
    end;
    RegCloseKey(Key2);
   end;
   if RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\shell',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Key2,nil)=ERROR_SUCCESS then begin
    RegCloseKey(Key2);
   end;
   if RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\shell\open',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Key2,nil)=ERROR_SUCCESS then begin
    RegCloseKey(Key2);
   end;
   if RegCreateKeyEx(HKEY_CLASSES_ROOT,'BeRoScript\shell\open\command',0,'',REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Key2,nil)=ERROR_SUCCESS then begin
    S:='"'+PARAMSTR(0)+'" "%1"';
    if RegSetValueEx(Key2,'',0,REG_SZ,pchar(S),length(S))=ERROR_SUCCESS then begin
    end;
    RegCloseKey(Key2);
   end;
  end;
  RegCloseKey(Key);
 end;
end;

procedure RegisterExtensions;
begin
 RegisterExtension('.bs');
 RegisterExtension('.bsa');
 RegisterExtension('.bws');
 RegisterEnginePart;
end;

function RandomValue:longword;
begin
 RandomSeed:=(RandomSeed*RandomFactor)+RandomIncrement;
 result:=RandomSeed*RandomSeed;
end;

function RandomFloatValue:single;
var Value:longword;
begin
 Value:=(RandomValue and $7fffff) or $40000000;
 result:=ABS(single(pointer(@Value)^)-3);
end;                                    

function Starten(const Dateiname,Parameter:string;FensterStatus:word):boolean;
var SUInfo:TStartupInfo;
    ProcInfo:TProcessInformation;
    Befehlszeile:string;
begin
 if length(Dateiname)>0 then begin
  Befehlszeile:='"'+Dateiname+'" '+Parameter;
 end else begin
  Befehlszeile:='"cmd" /C '+Parameter;
 end;
 FILLCHAR(SUInfo,sizeof(SUInfo),#0);
 FILLCHAR(ProcInfo,sizeof(ProcInfo),#0);
 with SUInfo do begin
  CB:=sizeof(SUInfo);
  dwFlags:=STARTF_USESHOWWINDOW;
  wShowWindow:=FensterStatus;
 end;
 result:=CreateProcess(nil,pchar(Befehlszeile),nil,nil,false,NORMAL_PRIORITY_CLASS,nil,pchar(GetCurrentDir),SUInfo,ProcInfo);
 if result then begin
  WaitForSingleObject(ProcInfo.hProcess,INFINITE);
 end;
end;

function Ausfuehren(Dateiname,Parameter:string):boolean;
begin
 result:=Starten(Dateiname,Parameter,SW_SHOWNORMAL);
end;

function Int64ToBase(Value,Base:int64):string; register;
const Digits:array[0..35] of char='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var Negative:boolean;
begin
 result:='';
 if (Base>1) and (Base<37) then begin
  Negative:=Value<0;
  Value:=ABS(Value);
  while Value<>0 do begin
   result:=Digits[Value mod Base]+result;
   Value:=Value div Base;
  end;
  if Negative then result:='-'+result;
 end;
end;

function Int64ToHex(Value:int64):string; register;
const Digits:array[0..$f] of char='0123456789ABCDEF';
var Negative:boolean;
begin
 result:='';
 Negative:=Value<0;
 Value:=ABS(Value);
 while Value<>0 do begin
  result:=Digits[Value and $f]+result;
  Value:=Value shr 4;
 end;
 if Negative then result:='-'+result;
end;

function IntToBase(Value,Base:integer):string; register;
const Digits:array[0..35] of char='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var Negative:boolean;
begin
 result:='';
 if (Base>1) and (Base<37) then begin
  Negative:=Value<0;
  Value:=ABS(Value);
  while Value<>0 do begin
   result:=Digits[Value mod Base]+result;
   Value:=Value div Base;
  end;
  if Negative then result:='-'+result;
 end;
end;

function IntToHex(Value:integer):string; register;
const Digits:array[0..$f] of char='0123456789ABCDEF';
var Negative:boolean;
begin
 result:='';
 Negative:=Value<0;
 Value:=ABS(Value);
 while Value<>0 do begin
  result:=Digits[Value and $f]+result;
  Value:=Value shr 4;
 end;
 if Negative then result:='-'+result;
end;

function LongWordToBase(Value,Base:longword):string; register;
const Digits:array[0..35] of char='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
begin
 result:='';
 if (Base>1) and (Base<37) then begin
  while Value<>0 do begin
   result:=Digits[Value mod Base]+result;
   Value:=Value div Base;
  end;
 end;
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

function CountActiveBits(Wert:longword):longword;
begin
 result:=((Wert and $aaaaaaaa) shr 1)+(Wert and $55555555);
 result:=((result and $cccccccc) shr 2)+(result and $33333333);
 result:=((result and $f0f0f0f0) shr 4)+(result and $0f0f0f0f);
 result:=((result and $ff00ff00) shr 8)+(result and $00ff00ff);
 result:=((result and $ffff0000) shr 16)+(result and $0000ffff);
end;

function CountBits(Wert:longword):byte;
var DerWert:longword;
begin
 result:=0;
 DerWert:=Wert;
 while DerWert<>0 do begin
  DerWert:=DerWert shr 1;
  inc(result);
 end;
end;

function SlowCountBits(Wert:longword):byte;
var DerWert:longword;
begin
 result:=0;
 DerWert:=Wert;
 if DerWert>0 then begin
  result:=32;
  while ((DerWert and (1 shl 31))=0) do begin
   DerWert:=DerWert shl 1;
   dec(result);
  end;
 end;
end;

function CountBitsSigned(Wert:longint):byte;
begin
 result:=CountBits(ABS(Wert))+1;
 if result>32 then result:=32;
end;

function SlowCountBitsSigned(Wert:longint):byte;
begin
 result:=SlowCountBits(ABS(Wert))+1;
 if result>32 then result:=32;
end;

function CountBits(Wert:longword;MinBits:byte):byte;
begin
 result:=CountBits(Wert);
 if result<MinBits then result:=MinBits;
end;

function SlowCountBits(Wert:longword;MinBits:byte):byte;
begin
 result:=SlowCountBits(Wert);
 if result<MinBits then result:=MinBits;
end;

function CountBitsSigned(Wert:longint;MinBits:byte):byte;
begin
 result:=CountBitsSigned(Wert);
 if result<MinBits then result:=MinBits;
end;

function SlowCountBitsSigned(Wert:longint;MinBits:byte):byte;
begin
 result:=SlowCountBitsSigned(Wert);
 if result<MinBits then result:=MinBits;
end;

function MinInt(A,B:longint):longint;
begin
 result:=B;
 if A<B then result:=A;
end;

function Min(A,B:longword):longword;
begin
 result:=B;
 if A<B then result:=A;
end;

function Min(A,B:single):single;
begin
 result:=B;
 if A<B then result:=A;
end;

function MaxInt(A,B:longint):longint;
begin
 result:=A;
 if A<B then result:=B;
end;

function Max(A,B:longword):longword;
begin
 result:=A;
 if A<B then result:=B;
end;

function Max(A,B:single):single;
begin
 result:=A;
 if A<B then result:=B;
end;

function FixedCast(A:single):longint;
var B:single;
begin
 B:=A*(1 shl 16);
 result:=TRUNC(B);
 if FRAC(B)<0 then dec(result);
end;

function ExtractFileExt(S:string):string;
var I,J,K:integer;
begin
 result:='';
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='.') or (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if (K>0) and (S[K]='.') then result:=COPY(S,K,J-K+1);
end;

function ExtractFileName(S:string):string;
var I,J,K:integer;
begin
 result:=S;
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if K>0 then result:=COPY(S,K+1,J-K+1);
end;

function ExtractFilePath(S:string):string;
var I,J,K:integer;
begin
 result:=S;
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if K>0 then result:=COPY(S,1,K);
end;

function ChangeFileExt(S,E:string):string;
var I,J,K:integer;
begin
 K:=0;
 J:=length(S);
 for I:=J downto 1 do if (S[I]='.') or (S[I]='\') or (S[I]='/') or (S[I]=':') then begin
  K:=I;
  break;
 end;
 if (K>0) and (S[K]='.') then begin
  result:=COPY(S,1,K-1)+E;
 end else begin
  result:=S+E;
 end;
end;

function GetApplicationDir:string;
begin
 result:=ExtractFilePath(PARAMSTR(0));
 if length(result)>0 then if result[length(result)]<>'\' then result:=result+'\';
end;

function GetCurrentDir:string;
var Buffer:array[0..MAX_PATH-1] of char;
begin
 setstring(result,Buffer,GetCurrentDirectory(sizeof(Buffer),Buffer));
 if length(result)>0 then if result[length(result)]<>'\' then result:=result+'\';
end;

function GetTempDir:string;
var Buffer:array[0..MAX_PATH-1] of char;
begin
 setstring(result,Buffer,GetTempPath(sizeof(Buffer),Buffer));
 if length(result)>0 then if result[length(result)]<>'\' then result:=result+'\';
end;

function GetWinDir:string;
var Buffer:array[0..MAX_PATH-1] of char;
begin
 setstring(result,Buffer,GetWindowsDirectory(Buffer,sizeof(Buffer)));
 if length(result)>0 then if result[length(result)]<>'\' then result:=result+'\';
end;

function GetSystemDir:string;
var Buffer:array[0..MAX_PATH-1] of char;
begin
 setstring(result,Buffer,GetSystemDirectory(Buffer,sizeof(Buffer)));
 if length(result)>0 then if result[length(result)]<>'\' then result:=result+'\';
end;

function GetTemp:string;
var Path,PathDatei:array[0..MAX_PATH-1] of char;
begin
 GetTempPath(sizeof(Path),@Path);
 GetTempFileName(@Path,'BSA',0,@PathDatei);
 result:=pchar(@PathDatei);
end;

function FILEEXISTS(S:string):boolean;
var F:file;
begin
 result:=false;
 FILESETATTR(S,0); {Alle Dateiattribute löschen}
 ASSIGNFILE(F,S);
 {$I-}RESET(F,1);{$I+}
 if IOResult=0 then begin
  CLOSEFILE(F);
  result:=true;
 end;
end;

function PFindMatchingFile(var F:TSearchRec):integer;
var LocalFileTime:TFileTime;
begin
 with F do begin
  while (FindData.dwFileAttributes and ExcludeAttr)<>0 do begin
   if not FindNextFile(FindHandle,FindData) then begin
    result:=GetLastError;
    exit;
   end;
  end;
  FileTimeToLocalFileTime(FindData.ftLastWriteTime,LocalFileTime);
  FileTimeToDosDateTime(LocalFileTime,LongRec(Time).Hi,LongRec(Time).Lo);
  Size:=FindData.nFileSizeLow;
  Attr:=FindData.dwFileAttributes;
  name:=FindData.cFileName;
 end;
 result:=0;
end;

function PFindNext(var F:TSearchRec):integer;
begin
 if FindNextFile(F.FindHandle,F.FindData) then begin
  result:=PFindMatchingFile(F);
 end else begin
  result:=GetLastError;
 end;
end;

procedure PFindClose(var F:TSearchRec);
begin
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  FindClose(F.FindHandle);
  F.FindHandle:=INVALID_HANDLE_VALUE;
 end;
end;

function PFindFirst(const Path:string;Attr:integer;var F:TSearchRec):integer;
const faSpecial=faHidden or faSysFile or faVolumeID or faDirectory;
begin
 F.ExcludeAttr:=not Attr and faSpecial;
 F.FindHandle:=FindFirstFile(pchar(Path),F.FindData);
 if F.FindHandle<>INVALID_HANDLE_VALUE then begin
  result:=PFindMatchingFile(F);
  if result<>0 then PFindClose(F);
 end else begin
  result:=GetLastError;
 end;
end;

function FILESETATTR(const Dateiname:string;Attr:integer):integer;
begin
 result:=0;
 if not SetFileAttributes(pchar(Dateiname),Attr) then result:=GetLastError;
end;

procedure LoescheDatei(const Datei:string);
begin
 if not DELETEFILE(pchar(Datei)) then begin
  FILESETATTR(Datei,0); {Alle Dateiattribute löschen}
  DELETEFILE(pchar(Datei));
 end;
end;

procedure LoescheDateien(const Path,Mask:string;SubDirectories:boolean);
var SR:TSearchRec;
begin
 if PFindFirst(Path+Mask,faAnyFile-faDirectory,SR)=0 then begin
  repeat
   LoescheDatei(Path+SR.name);
  until PFindNext(SR)<>0;
  PFindClose(SR);
 end;
 if SubDirectories then begin
  if PFindFirst(Path+'*.*',faDirectory,SR)=0 then begin
   repeat
    if (SR.name<>'.') and (SR.name<>'..') then begin
     FILESETATTR(Path+SR.name,faDirectory);
     LoescheDateien(Path+SR.name+'\',Mask,true);
     FILESETATTR(Path+SR.name,faDirectory); {Alle Dateiattribute löschen}
     {$I-}
     RMDIR(Path+SR.name); {Leeres Verzsichnis löschen}
     {$I+}
     if IOResult<>0 then begin
     end;
    end;
   until PFindNext(SR)<>0;
   PFindClose(SR);
  end;
 end;
end;

function LOG2(I:integer):integer;
begin
 if I<=0 then begin
  result:=-1;
 end else begin
  result:=LOG2(I div 2)+1;
 end;
end;

function ReadFileAsString(SourceFile:string):string;
var F:TBeRoFileStream;
begin
 F:=TBeRoFileStream.Create(SourceFile);
 if F.Size>0 then begin
  setlength(result,F.Size);
  F.read(result[1],F.Size);
 end else begin
  result:='';
 end;
 F.Free;
end;

function INTTOSTR(I:integer):string;
begin
 STR(I,result);
end;

function TRIM(const S:string):string;
var StartPos,Laenge:integer;
begin
 Laenge:=length(S);
 if Laenge>0 then begin
  while (Laenge>0) and (S[Laenge] in [#0..#32]) do dec(Laenge);
  StartPos:=1;
  while (StartPos<=Laenge) and (S[StartPos] in [#0..#32]) do inc(StartPos);
  result:=COPY(S,StartPos,Laenge-StartPos+1);
 end else begin
  result:='';
 end;
end;

function UPPERCASE(const S:string):string;
var I,L:integer;
begin
 result:='';
 L:=length(S);
 I:=1;
 while I<=L do begin
  if S[I] in ['a'..'z'] then begin
   result:=result+char(byte(S[I])-32);
  end else begin
   result:=result+S[I];
  end;
  inc(I);
 end;
end;

function LOWERCASE(const S:string):string;
var I,L:integer;
begin
 result:='';
 L:=length(S);
 I:=1;
 while I<=L do begin
  if S[I] in ['A'..'Z'] then begin
   result:=result+char(byte(S[I])+32);
  end else begin
   result:=result+S[I];
  end;
  inc(I);
 end;
end;

function StrToInt(S:string):integer;
var C:integer;
begin
 VAL(S,result,C);
end;

procedure ErzeugeTabelle;
const GenerationWert=$edb88320;
var I,J:longword;
    Wert:longword;
begin
 I:=0;
 while I<256 do begin
  Wert:=I;
  J:=8;
  while J>0 do begin
   if (Wert and 1)<>0 then begin
    Wert:=(Wert shr 1) xor GenerationWert;
   end else begin
    Wert:=Wert shr 1;
   end;
   dec(J);
  end;
  CRCTabelle[I]:=Wert;
  inc(I);
 end;
end;

function CRC32(Data:TBeRoStream):longword;
var I,J:longword;
    Wert:longword;
    B:byte;
begin
 Wert:=$ffffffff;
 Data.Seek(0);
 J:=Data.Size;
 I:=0;
 while I<J do begin
  B:=Data.ReadByte;
  Wert:=((Wert shr 8) and $00ffffff) xor CRCTabelle[(Wert xor B) and $ff];
  inc(I);
 end;
 Data.Seek(0);
 result:=Wert xor $ffffffff;
end;

function CRC32(Data:string):longword;
var Stream:TBeRoMemoryStream;
begin
 Stream:=TBeRoMemoryStream.Create;
 Stream.Text:=Data;
 result:=CRC32(Stream);
 Stream.Free;
end;

function ProcessCompress(var SourcePointer,DestinationPointer:pointer;Size:longword):longword;
const MethodLiteral=0;
      MethodShortLiteralMatch=1;
      MethodLastIndexPhrase=2;
      MethodShortMatch=3;
      MethodMatch=4;
      MethodNullByte=5;
      CheckMethodsStart=MethodShortLiteralMatch;
      CheckMethodsEnd=MethodMatch;
type pbyte=^byte;
     pword=^word;
     plongword=^longword;
     PByteArray=^TByteArray;
     TByteArray=array[0..$7ffffffe] of byte;
     PNode=^TNode;
     TNode=record
      DataPointer:pointer;
      Previous,Next:PNode;
     end;
     PNodes=^TNodes;
     TNodes=array[0..($7fffffff div sizeof(TNode))-1] of TNode;
     PRecentNodes=^TRecentNodes;
     TRecentNodes=array[0..$ffff] of PNode;
var Source,Destination,EndPointer,LastHashedPointer,TagPointer:pbyte;
    Tag,BitCount,BestFoundPhraseIndex,BestFoundPhraseLength,
    LastIndexUsed:longword;
    BestMethod:byte;
    LastWasMatch:boolean;
    NodesSize:longword;
    NodePosition:longword;
    Nodes:PNodes;
    RecentNodes:PRecentNodes;
 function AddNode(Data:pointer):boolean;
 var Prefix:word;
     LastNode:PNode;
     NewNode:PNode;
 begin
  result:=NodePosition<(Size-1);
  if result then begin
   Prefix:=pword(Data)^;
   LastNode:=RecentNodes^[Prefix];
   NewNode:=@Nodes^[NodePosition];
   with NewNode^ do begin
    DataPointer:=Data;
    Previous:=LastNode;
    Next:=nil;
   end;
   if assigned(LastNode) then LastNode^.Next:=NewNode;
   RecentNodes^[Prefix]:=NewNode;
   inc(NodePosition);
  end;
 end;
 procedure PutBits(Value,Bits:longword);
 var RemainValue,RemainBits:longword;
 begin
  if Bits>1 then begin
   RemainValue:=Value;
   RemainBits:=Bits;
   while RemainBits>0 do begin
    PutBits((RemainValue shr (RemainBits-1)) and 1,1);
    dec(RemainBits);
   end;
  end else begin
   if BitCount=0 then begin
    TagPointer^:=Tag;
    TagPointer:=Destination;
    inc(Destination);
    BitCount:=8;
   end;
   dec(BitCount);
   Tag:=(Tag shl Bits) or Value;
  end;
 end;
 procedure PutBit(Bit:boolean);
 begin
  if Bit then begin
   PutBits(1,1);
  end else begin
   PutBits(0,1);
  end;
 end;
 procedure PutGamma(Value:longword);
 var Mask:longword;
 begin
  Mask:=Value shr 1;
  while (Mask and (Mask-1))<>0 do Mask:=Mask and (Mask-1);
  PutBit((Value and Mask)<>0);
  Mask:=Mask shr 1;
  while Mask<>0 do begin
   PutBit(true);
   PutBit((Value and Mask)<>0);
   Mask:=Mask shr 1;
  end;
  PutBit(false);
 end;
 function GetGammaSize(Value:longword):longword;
 var Mask:longword;
 begin
  Mask:=Value shr 1;
  while (Mask and (Mask-1))<>0 do Mask:=Mask and (Mask-1);
  result:=2;
  Mask:=Mask shr 1;
  while Mask<>0 do begin
   inc(result,2);
   Mask:=Mask shr 1;
  end;
 end;
 procedure PutByte(Value:byte);
 begin
  Destination^:=Value;
  inc(Destination);
 end;
 procedure PutLongWord(Value:longword);
 begin
  plongword(Destination)^:=Value;
  inc(Destination,sizeof(longword));
 end;
 function CheckBitLength(PhraseIndex,PhraseLength:longword;Method:byte):longword; register;
 var Value:longword;
 begin
  result:=0;
  case Method of
   MethodShortLiteralMatch:begin
    if (PhraseLength=1) and (PhraseIndex<=$f) then begin
     result:=3+4;
    end;
   end;
   MethodLastIndexPhrase:begin
    if (PhraseIndex=LastIndexUsed) and (PhraseLength>=2) and not LastWasMatch then begin
     result:=2+GetGammaSize(2)+GetGammaSize(PhraseLength);
    end;
   end;
   MethodShortMatch:begin
    if (PhraseLength in [2,3]) and (PhraseIndex<128) then begin
     result:=3+8;
    end;
   end;
   MethodMatch:begin
    if ((PhraseLength>=4) or
        ((PhraseIndex>=128) and (PhraseIndex<1280) and (PhraseLength>=2)) or
        ((PhraseIndex>=1280) and (PhraseIndex<32000) and (PhraseLength>=3))) then begin
     result:=2;
     Value:=PhraseIndex;
     if LastWasMatch then begin
      inc(result,GetGammaSize((Value shr 8)+2));
     end else begin
      inc(result,GetGammaSize((Value shr 8)+3));
     end;
     inc(result,8);
     Value:=PhraseLength;
     if PhraseIndex<128 then begin
      dec(Value,2);
     end else begin
      if PhraseIndex>=1280 then dec(Value);
      if PhraseIndex>=32000 then dec(Value);
     end;
     inc(result,GetGammaSize(Value));
    end;
   end;
  end;
 end;
 function CompareBytes(FirstComparePointer,SecondComparePointer:pbyte):longword; register;
 begin
  result:=0;
  while (longword(SecondComparePointer)<longword(EndPointer)) and
        (FirstComparePointer^=SecondComparePointer^) do begin
   inc(result);
   inc(FirstComparePointer);
   inc(SecondComparePointer);
  end;
 end;
 function SearchForPhrase(Source:pbyte;var BestPhraseIndex,BestPhraseLength:longword;var Node:PNode;var Mode:byte):boolean; register;
 var SearchPointer:pbyte;
     FoundLength:longword;
 begin
  result:=false;
  BestPhraseLength:=0;
  BestPhraseIndex:=0;
  case Mode of
   0:begin
    if not assigned(Node) then Node:=RecentNodes^[pword(Source)^];
    if assigned(Node) then begin
     if longword(Source)<(longword(EndPointer)-1) then begin
      SearchPointer:=Node^.DataPointer;
      FoundLength:=CompareBytes(SearchPointer,Source);
      if FoundLength>0 then begin
       BestPhraseLength:=FoundLength;
       BestPhraseIndex:=longword(Source)-longword(SearchPointer);
       result:=true;
      end;
     end;
     Node:=Node^.Previous;
    end;
    if not assigned(Node) then begin
     if (longword(Source)-longword(SourcePointer))>0 then begin
      inc(Mode);
     end else begin
      inc(Mode,2);
     end;
    end;
   end;
   1:begin
    if (longword(Source)-longword(SourcePointer))>0 then begin
     SearchPointer:=Source;
     dec(SearchPointer);
     FoundLength:=CompareBytes(SearchPointer,Source);
     if FoundLength>0 then begin
      BestPhraseLength:=FoundLength;
      BestPhraseIndex:=longword(Source)-longword(SearchPointer);
      result:=true;
     end;
    end;
    inc(Mode);
   end;
   2..16:begin
    if (longword(Source)-longword(SourcePointer))>=longword(Mode-1) then begin
     SearchPointer:=Source;
     dec(SearchPointer,(Mode-1));
    end else begin
     SearchPointer:=SourcePointer;
     Mode:=18;
    end;
    if SearchPointer^=Source^ then begin
     BestPhraseLength:=1;
     BestPhraseIndex:=longword(Source)-longword(SearchPointer);
     result:=true;
    end;
    inc(Mode);
   end;
  end;
 end;
 procedure SearchForLongestPhrase(Source:pbyte;var BestPhraseIndex,BestPhraseLength:longword;var BestPhraseMethod:byte); register;
 var PhraseIndex,PhraseLength,PhraseSaves:longword;
     BestPhraseSaves,Bits:longword;
     PhraseMethod,Mode:byte;
     Node:PNode;
 begin
  BestPhraseIndex:=0;
  BestPhraseLength:=1;
  if Source^=0 then begin
   BestPhraseMethod:=MethodNullByte;
   BestPhraseSaves:=1;
  end else begin
   BestPhraseMethod:=MethodLiteral;
   BestPhraseSaves:=0;
  end;
  Node:=nil;
  if Source^=0 then begin
   Node:=nil;
  end;
  Mode:=0;
  while Mode<17 do begin
   if SearchForPhrase(Source,PhraseIndex,PhraseLength,Node,Mode) then begin
    if (PhraseIndex>0) and (PhraseLength>0) then begin
     for PhraseMethod:=CheckMethodsStart to CheckMethodsEnd do begin
      Bits:=CheckBitLength(PhraseIndex,PhraseLength,PhraseMethod);
      if Bits<>0 then begin
       PhraseSaves:=(PhraseLength shl 3)-Bits;
       if PhraseSaves>BestPhraseSaves then begin
        BestPhraseIndex:=PhraseIndex;
        BestPhraseLength:=PhraseLength;
        BestPhraseSaves:=PhraseSaves;
        BestPhraseMethod:=PhraseMethod;
       end;
      end;
     end;
    end;
   end;
  end;
 end;
 procedure PutResult(var Source:pbyte); register;
 var Value:longword;
 begin
  case BestMethod of
   MethodLiteral:begin
    PutBit(false);
    PutByte(Source^);
    inc(Source);
    LastWasMatch:=false;
   end;
   MethodShortLiteralMatch:begin
    PutBit(true);
    PutBit(true);
    PutBit(true);
    PutBits(BestFoundPhraseIndex,4);
    inc(Source);
    LastWasMatch:=false;
   end;
   MethodLastIndexPhrase:begin
    PutBit(true);
    PutBit(false);
    PutGamma(2);
    PutGamma(BestFoundPhraseLength);
    inc(Source,BestFoundPhraseLength);
    LastIndexUsed:=BestFoundPhraseIndex;
    LastWasMatch:=true;
   end;
   MethodShortMatch:begin
    PutBit(true);
    PutBit(true);
    PutBit(false);
    PutByte((BestFoundPhraseIndex shl 1)+(BestFoundPhraseLength-2));
    inc(Source,BestFoundPhraseLength);
    LastIndexUsed:=BestFoundPhraseIndex;
    LastWasMatch:=true;
   end;
   MethodMatch:begin
    PutBit(true);
    PutBit(false);
    Value:=BestFoundPhraseIndex;
    if LastWasMatch then begin
     PutGamma((Value shr 8)+2);
    end else begin
     PutGamma((Value shr 8)+3);
    end;
    PutByte(Value and $ff);
    Value:=BestFoundPhraseLength;
    if BestFoundPhraseIndex<128 then begin
     dec(Value,2);
    end else begin
     if BestFoundPhraseIndex>=1280 then dec(Value);
     if BestFoundPhraseIndex>=32000 then dec(Value);
    end;
    PutGamma(Value);
    inc(Source,BestFoundPhraseLength);
    LastIndexUsed:=BestFoundPhraseIndex;
    LastWasMatch:=true;
   end;
   MethodNullByte:begin
    PutBit(true);
    PutBit(true);
    PutBit(true);
    PutBits(0,4);
    inc(Source);
    LastWasMatch:=false;
   end;
  end;
 end;
 procedure DoHash(var Source:pbyte); register;
 begin
  while longword(LastHashedPointer)<(longword(Source)-1) do begin
   AddNode(LastHashedPointer);
   inc(LastHashedPointer);
  end;
 end;
 procedure PutEndCode;
 begin
  PutBit(true);
  PutBit(true);
  PutBit(false);
  Destination^:=0;
 end;
 procedure DoMainLoop(var Source:pbyte); register;
 begin
  PutLongWord(Size);
  Destination^:=Source^;
  inc(Source);
  inc(Destination);
  DoHash(Source);
  TagPointer:=Destination;
  inc(Destination);
  Tag:=0;
  BitCount:=8;
  LastIndexUsed:=0;
  LastWasMatch:=false;
  while longword(Source)<longword(EndPointer) do begin
   SearchForLongestPhrase(Source,BestFoundPhraseIndex,BestFoundPhraseLength,BestMethod);
   PutResult(Source);
   DoHash(Source);
  end;
  PutEndCode;
  if BitCount<7 then TagPointer^:=Tag shl BitCount;
 end;
begin
 result:=0;
 if Size>0 then begin
  NodesSize:=sizeof(TNode)*Size;
  GETMEM(Nodes,NodesSize);
  FILLCHAR(Nodes^,NodesSize,#0);
  GETMEM(RecentNodes,sizeof(TRecentNodes));
  GETMEM(RecentNodes,sizeof(TRecentNodes));
  FILLCHAR(RecentNodes^,sizeof(TRecentNodes),#0);
  NodePosition:=0;
  GETMEM(DestinationPointer,Size*16);
  Source:=SourcePointer;
  Destination:=DestinationPointer;
  EndPointer:=Source;
  inc(EndPointer,Size);
  LastHashedPointer:=SourcePointer;
  DoMainLoop(Source);
  FREEMEM(Nodes);
  FREEMEM(RecentNodes);
  result:=longword(Destination)-longword(DestinationPointer);
 end;
end;

function ProcessDecompress(var SourcePointer,DestinationPointer:pointer;Size:longword):longword;
type pbyte=^byte;
     plongword=^longword;
     TSignature=array[1..4] of char;
     THeader=packed record
      Signature:TSignature;
      HeaderSize:longword;
     end;
     THeaderExt=packed record
      PackedSize:longword;
      PackedCRC:longword;
      UncompressedSize:longword;
      UncompressedCRC:longword;
     end;
var Source,Destination,EndPointer,CopySource:pbyte;
    Tag,BitCount,LengthCount,SourceOffset,DestSize:longword;
    LastMatchOffset:longword;
    LastWasMatch:boolean;
    Header:THeader;
    HeaderExt:THeaderExt;
 function GetBits(Bits:longword):longword;
 begin
  if Bits=1 then begin
   if BitCount=0 then begin
    Tag:=Source^;
    inc(Source);
    BitCount:=8;
   end;
   dec(BitCount);
   result:=(Tag shr 7) and 1;
   Tag:=Tag shl 1;
  end else begin
   result:=0;
   while Bits>0 do begin
    result:=(result shl 1)+GetBits(1);
    dec(Bits);
   end;
  end;
 end;
 function GetBit:boolean;
 begin
  result:=GetBits(1)<>0;
 end;
 function GetByte:longword;
 begin
  result:=Source^;
  inc(Source);
 end;
 function GetData(var Data;Size:longword):longword;
 begin
  MOVE(Source^,Data,Size);
  inc(Source,Size);
  result:=Size;
 end;
 function GetLongWord:longword;
 begin
  result:=plongword(Source)^;
  inc(Source,sizeof(longword));
 end;
 function GetGamma:longword;
 begin
  result:=1;
  repeat
   result:=(result shl 1)+GetBits(1);
  until not GetBit;
 end;
 procedure DoMove(Src,Dst:pbyte;Counter:longword);
 begin
  while Counter>0 do begin
   Dst^:=Src^;
   inc(Src);
   inc(Dst);
   dec(Counter);
  end;
 end;
 procedure MainLoop;
 var Value:longword;
 begin
  LastMatchOffset:=0;
  LastWasMatch:=false;
  Destination^:=GetByte;
  inc(Destination);
  while longword(Destination)<longword(EndPointer) do begin
   if GetBit then begin
    if GetBit then begin
     if GetBit then begin
      SourceOffset:=GetBits(4);
      if SourceOffset<>0 then begin
       CopySource:=Destination;
       dec(CopySource,SourceOffset);
       Destination^:=CopySource^;
      end else begin
       Destination^:=0;
      end;
      inc(Destination);
      LastWasMatch:=false;
     end else begin
      Value:=GetByte;
      SourceOffset:=Value shr 1;
      LengthCount:=(Value and 1)+2;
      if SourceOffset<>0 then begin
       CopySource:=Destination;
       dec(CopySource,SourceOffset);
       DoMove(CopySource,Destination,LengthCount);
       inc(Destination,LengthCount);
       LastMatchOffset:=SourceOffset;
       LastWasMatch:=true;
      end else begin
       break;
      end;
     end;
    end else begin
     SourceOffset:=GetGamma;
     if (SourceOffset=2) and not LastWasMatch then begin
      SourceOffset:=LastMatchOffset;
      LengthCount:=GetGamma;
      CopySource:=Destination;
      dec(CopySource,SourceOffset);
      DoMove(CopySource,Destination,LengthCount);
      inc(Destination,LengthCount);
     end else begin
      if LastWasMatch then begin
       dec(SourceOffset,2);
      end else begin
       dec(SourceOffset,3);
      end;
      SourceOffset:=(SourceOffset shl 8) or GetByte;
      LengthCount:=GetGamma;
      if SourceOffset<128 then begin
       inc(LengthCount,2);
      end else begin
       if SourceOffset>=32000 then inc(LengthCount);
       if SourceOffset>=1280 then inc(LengthCount);
      end;
      CopySource:=Destination;
      dec(CopySource,SourceOffset);
      DoMove(CopySource,Destination,LengthCount);
      inc(Destination,LengthCount);
      LastMatchOffset:=SourceOffset;
     end;
     LastWasMatch:=true;
    end;
   end else begin
    Destination^:=GetByte;
    inc(Destination);
    LastWasMatch:=false;
   end;
  end;
 end;
begin
 result:=0;
 if Size>0 then begin
  Source:=SourcePointer;
  GetData(Header,sizeof(THeader));
  if Header.Signature='AP32' then begin
   dec(Header.HeaderSize,sizeof(THeader));
   if Header.HeaderSize<=sizeof(THeaderExt) then begin
    GetData(HeaderExt,Header.HeaderSize);
   end else begin
    GetData(HeaderExt,sizeof(THeaderExt));
    inc(Source,Header.HeaderSize-sizeof(THeaderExt));
   end;
   DestSize:=HeaderExt.UncompressedSize;
  end else begin
   Source:=SourcePointer;
   DestSize:=GetLongWord;
  end;
  if DestSize>0 then begin
   GETMEM(DestinationPointer,DestSize);
   Destination:=DestinationPointer;
   EndPointer:=Destination;
   inc(EndPointer,DestSize);
   Tag:=0;
   BitCount:=0;
   MainLoop;
   result:=longword(Destination)-longword(DestinationPointer);
  end;
 end;
end;

procedure Compression(Source,Destination:TBeRoStream;Fast:boolean); overload;
var SourcePointer,DestinationPointer:pointer;
    SourceSize,DestinationSize:longword;
begin
 if assigned(Source) and assigned(Destination) then begin
  DestinationSize:=0;
  DestinationPointer:=nil;
  SourceSize:=Source.Size;
  GETMEM(SourcePointer,SourceSize);
  Source.Seek(0);
  Source.read(SourcePointer^,SourceSize);
  DestinationSize:=ProcessCompress(SourcePointer,DestinationPointer,SourceSize);
  Destination.Clear;
  Destination.write(DestinationPointer^,DestinationSize);
  FREEMEM(DestinationPointer);
  FREEMEM(SourcePointer);
 end;
end;

procedure Decompression(Source,Destination:TBeRoStream); overload;
var SourcePointer,DestinationPointer:pointer;
    SourceSize,DestinationSize:longword;
begin
 if assigned(Source) and assigned(Destination) then begin
  DestinationSize:=0;
  DestinationPointer:=nil;
  SourceSize:=Source.Size;
  GETMEM(SourcePointer,SourceSize);
  Source.Seek(0);
  Source.read(SourcePointer^,SourceSize);
  DestinationSize:=ProcessDecompress(SourcePointer,DestinationPointer,SourceSize);
  Destination.Clear;
  Destination.write(DestinationPointer^,DestinationSize);
  FREEMEM(DestinationPointer);
  FREEMEM(SourcePointer);
 end;
end;

function CreateExportTreeNode(AChar:char):PExportTreeNode;
begin
 GETMEM(result,sizeof(TExportTreeNode));
 result^.TheChar:=AChar;
 result^.Link:=nil;
 result^.LinkExist:=false;
 result^.Prevoius:=nil;
 result^.Next:=nil;
 result^.Up:=nil;
 result^.Down:=nil;
end;

procedure DestroyExportTreeNode(Node:PExportTreeNode);
begin
 if assigned(Node) then begin
  DestroyExportTreeNode(Node^.Next);
  DestroyExportTreeNode(Node^.Down);
  FREEMEM(Node);
 end;
end;

constructor TExportTree.Create;
begin
 inherited Create;
 Root:=nil;
end;

destructor TExportTree.Destroy;
begin
 DestroyExportTreeNode(Root);
 inherited Destroy;
end;

procedure TExportTree.Dump;
var Ident:integer;
 procedure DumpNode(Node:PExportTreeNode);
 var SubNode:PExportTreeNode;
     IdentCounter,IdentOld:integer;
 begin
  for IdentCounter:=1 to Ident do write(' ');
  write(Node^.TheChar);
  IdentOld:=Ident;
  SubNode:=Node^.Next;
  while assigned(SubNode) do begin
   write(SubNode.TheChar);
   if not assigned(SubNode^.Next) then break;
   inc(Ident);
   SubNode:=SubNode^.Next;
  end;
  WRITELN;
  inc(Ident);
  while assigned(SubNode) and (SubNode<>Node) do begin
   if assigned(SubNode^.Down) then DumpNode(SubNode^.Down);
   SubNode:=SubNode^.Prevoius;
   dec(Ident);
  end;
  Ident:=IdentOld;
  if assigned(Node^.Down) then DumpNode(Node^.Down);
 end;
begin
 Ident:=0;
 DumpNode(Root);
end;

function TExportTree.Add(FunctionName:string;Link:TExportTreeLink):boolean;
var StringLength,Position,PositionCounter:integer;
    NewNode,LastNode,Node:PExportTreeNode;
    StringChar,NodeChar:char;
begin
 result:=false;
 StringLength:=length(FunctionName);
 if StringLength>0 then begin
  LastNode:=nil;
  Node:=Root;
  for Position:=1 to StringLength do begin
   StringChar:=FunctionName[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    if NodeChar=StringChar then begin
     LastNode:=Node;
     Node:=Node^.Next;
   end else begin
     while (NodeChar<StringChar) and assigned(Node^.Down) do begin
      Node:=Node^.Down;
      NodeChar:=Node^.TheChar;
     end;
     if NodeChar=StringChar then begin
      LastNode:=Node;
      Node:=Node^.Next;
     end else begin
      NewNode:=CreateExportTreeNode(StringChar);
      if NodeChar<StringChar then begin
       NewNode^.Down:=Node^.Down;
       NewNode^.Up:=Node;
       if assigned(NewNode^.Down) then begin
        NewNode^.Down^.Up:=NewNode;
       end;
       NewNode^.Prevoius:=Node^.Prevoius;
       Node^.Down:=NewNode;
      end else if NodeChar>StringChar then begin
       NewNode^.Down:=Node;
       NewNode^.Up:=Node^.Up;
       if assigned(NewNode^.Up) then begin
        NewNode^.Up^.Down:=NewNode;
       end;
       NewNode^.Prevoius:=Node^.Prevoius;
       if not assigned(NewNode^.Up) then begin
        if assigned(NewNode^.Prevoius) then begin
         NewNode^.Prevoius^.Next:=NewNode;
        end else begin
         Root:=NewNode;
        end;
       end;
       Node^.Up:=NewNode;
      end;
      LastNode:=NewNode;
      Node:=LastNode^.Next;
     end;
    end;
   end else begin
    for PositionCounter:=Position to StringLength do begin
     NewNode:=CreateExportTreeNode(FunctionName[PositionCounter]);
     if assigned(LastNode) then begin
      NewNode^.Prevoius:=LastNode;
      LastNode^.Next:=NewNode;
      LastNode:=LastNode^.Next;
     end else begin
      if not assigned(Root) then begin
       Root:=NewNode;
       LastNode:=Root;
      end;
     end;
    end;
    break;
   end;
  end;
  if assigned(LastNode) then begin
   if not LastNode^.LinkExist then begin
    LastNode^.Link:=Link;
    LastNode^.LinkExist:=true;
    result:=true;
   end;
  end;
 end;
end;

function TExportTree.Delete(FunctionName:string):boolean;
var StringLength,Position:integer;
    Node:PExportTreeNode;
    StringChar,NodeChar:char;
begin
 result:=false;
 StringLength:=length(FunctionName);
 if StringLength>0 then begin
  Node:=Root;
  for Position:=1 to StringLength do begin
   StringChar:=FunctionName[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    while (NodeChar<>StringChar) and assigned(Node^.Down) do begin
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=StringLength) and Node^.LinkExist then begin
      Node^.LinkExist:=false;
      result:=true;
      break;
     end;
     Node:=Node^.Next;
    end;
   end else begin
    break;
   end;
  end;
 end;
end;

function TExportTree.Find(FunctionName:string;var Link:TExportTreeLink):boolean;
var StringLength,Position:integer;
    Node:PExportTreeNode;
    StringChar,NodeChar:char;
begin
 result:=false;
 StringLength:=length(FunctionName);
 if StringLength>0 then begin
  Node:=Root;
  for Position:=1 to StringLength do begin
   StringChar:=FunctionName[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    while (NodeChar<>StringChar) and assigned(Node^.Down) do begin
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=StringLength) and Node^.LinkExist then begin
      Link:=Node^.Link;
      result:=true;
      break;
     end;
     Node:=Node^.Next;
    end;
   end else begin
    break;
   end;
  end;
 end;
end;

constructor TDynamicLinkLibrary.Create(DynamicLinkLibraryName:string='');
begin
 inherited Create;
 ImageBase:=nil;
 DLLName:=DynamicLinkLibraryName;
 DLLProc:=nil;
 DLLHandle:=0;
 ExternalLibraryArray:=nil;
 ImportArray:=nil;
 ExportArray:=nil;
 Sections:=nil;
 ExportTree:=nil;
end;

destructor TDynamicLinkLibrary.Destroy;
begin
 if @DLLProc<>nil then Unload;
 if assigned(ExportTree) then ExportTree.Destroy;
 inherited Destroy;
end;

function TDynamicLinkLibrary.FindExternalLibrary(LibraryName:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to length(ExternalLibraryArray)-1 do begin
  if ExternalLibraryArray[I].LibraryName=LibraryName then begin
   result:=I;
   exit;
  end;
 end;
end;

function TDynamicLinkLibrary.LoadExternalLibrary(LibraryName:string):integer;
begin
 result:=FindExternalLibrary(LibraryName);
 if result<0 then begin
  result:=length(ExternalLibraryArray);
  setlength(ExternalLibraryArray,length(ExternalLibraryArray)+1);
  ExternalLibraryArray[result].LibraryName:=LibraryName;
  ExternalLibraryArray[result].LibraryHandle:=LoadLibrary(pchar(LibraryName));
 end;
end;

function TDynamicLinkLibrary.GetExternalLibraryHandle(LibraryName:string):longword;
var I:integer;
begin
 result:=0;
 for I:=0 to length(ExternalLibraryArray)-1 do begin
  if ExternalLibraryArray[I].LibraryName=LibraryName then begin
   result:=ExternalLibraryArray[I].LibraryHandle;
   exit;
  end;
 end;
end;

function TDynamicLinkLibrary.Load(Stream:TBeRoStream):boolean;
var ImageDOSHeader:TImageDOSHeader;
    ImageNTHeaders:TImageNTHeaders;
    OldProtect:longword;
 function ConvertPointer(RVA:longword):pointer;
 var I:integer;
 begin
  result:=nil;
  for I:=0 to length(Sections)-1 do begin
   if (RVA<(Sections[I].RVA+Sections[I].Size)) and (RVA>=Sections[I].RVA) then begin
    result:=pointer(longword((RVA-longword(Sections[I].RVA))+longword(Sections[I].Base)));
    exit;
   end;
  end;
 end;
 function ReadImageHeaders:boolean;
 begin
  result:=false;
  if Stream.Size>0 then begin
   FILLCHAR(ImageNTHeaders,sizeof(TImageNTHeaders),#0);
   if Stream.read(ImageDOSHeader,sizeof(TImageDOSHeader))<>sizeof(TImageDOSHeader) then exit;
   if ImageDOSHeader.Signature<>$5a4d then exit;
   if Stream.Seek(ImageDOSHeader.LFAOffset)<>longint(ImageDOSHeader.LFAOffset) then exit;
   if Stream.read(ImageNTHeaders.Signature,sizeof(longword))<>sizeof(longword) then exit;
   if ImageNTHeaders.Signature<>$00004550 then exit;
   if Stream.read(ImageNTHeaders.FileHeader,sizeof(TImageFileHeader))<>sizeof(TImageFileHeader) then exit;
   if ImageNTHeaders.FileHeader.Machine<>$14c then exit;
   if Stream.read(ImageNTHeaders.OptionalHeader,ImageNTHeaders.FileHeader.SizeOfOptionalHeader)<>ImageNTHeaders.FileHeader.SizeOfOptionalHeader then exit;
   result:=true;
  end;
 end;
 function InitializeImage:boolean;
 var SectionBase:pointer;
     OldPosition:integer;
 begin
  result:=false;
  if ImageNTHeaders.FileHeader.NumberOfSections>0 then begin
   ImageBase:=VirtualAlloc(nil,ImageNTHeaders.OptionalHeader.SizeOfImage,MEM_RESERVE,PAGE_NOACCESS);
   ImageBaseDelta:=longword(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase;
   SectionBase:=VirtualAlloc(ImageBase,ImageNTHeaders.OptionalHeader.SizeOfHeaders,MEM_COMMIT,PAGE_READWRITE);
   OldPosition:=Stream.Position;
   Stream.Seek(0);
   Stream.read(SectionBase^,ImageNTHeaders.OptionalHeader.SizeOfHeaders);
   VirtualProtect(SectionBase,ImageNTHeaders.OptionalHeader.SizeOfHeaders,PAGE_READONLY,OldProtect);
   Stream.Seek(OldPosition);
   result:=true;
  end;
 end;
 function ReadSections:boolean;
 var I:integer;
     Section:TImageSectionHeader;
     SectionHeaders:PImageSectionHeaders;
 begin
  result:=false;
  if ImageNTHeaders.FileHeader.NumberOfSections>0 then begin
   GETMEM(SectionHeaders,ImageNTHeaders.FileHeader.NumberOfSections*sizeof(TImageSectionHeader));
   if Stream.read(SectionHeaders^,(ImageNTHeaders.FileHeader.NumberOfSections*sizeof(TImageSectionHeader)))<>(ImageNTHeaders.FileHeader.NumberOfSections*sizeof(TImageSectionHeader)) then exit;
   setlength(Sections,ImageNTHeaders.FileHeader.NumberOfSections);
   for I:=0 to ImageNTHeaders.FileHeader.NumberOfSections-1 do begin
    Section:=SectionHeaders^[I];
    Sections[I].RVA:=Section.VirtualAddress;
    Sections[I].Size:=Section.SizeOfRawData;
    if Sections[I].Size<Section.Misc.VirtualSize then begin
     Sections[I].Size:=Section.Misc.VirtualSize;
    end;
    Sections[I].Characteristics:=Section.Characteristics;
    Sections[I].Base:=VirtualAlloc(pointer(longword(Sections[I].RVA+longword(ImageBase))),Sections[I].Size,MEM_COMMIT,PAGE_READWRITE);
    FILLCHAR(Sections[I].Base^,Sections[I].Size,#0);
    if Section.PointerToRawData<>0 then begin
     Stream.Seek(Section.PointerToRawData);
     if Stream.read(Sections[I].Base^,Section.SizeOfRawData)<>longint(Section.SizeOfRawData) then exit;
    end;
   end;
   FREEMEM(SectionHeaders);
   result:=true;
  end;
 end;
 function ProcessRelocations:boolean;
 var Relocations:pchar;
     Position:longword;
     BaseRelocation:PImageBaseRelocation;
     Base:pointer;
     NumberOfRelocations:longword;
     Relocation:PWordArray;
     RelocationCounter:longint;
     RelocationPointer:pointer;
     RelocationType:longword;
 begin
  if ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress<>0 then begin
   result:=false;
   Relocations:=ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress);
   Position:=0;
   while assigned(Relocations) and (Position<ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size) do begin
    BaseRelocation:=PImageBaseRelocation(Relocations);
    Base:=ConvertPointer(BaseRelocation^.VirtualAddress);
    if not assigned(Base) then exit;
    NumberOfRelocations:=(BaseRelocation^.SizeOfBlock-sizeof(TImageBaseRelocation)) div sizeof(word);
    Relocation:=pointer(longword(longword(BaseRelocation)+sizeof(TImageBaseRelocation)));
    for RelocationCounter:=0 to NumberOfRelocations-1 do begin
     RelocationPointer:=pointer(longword(longword(Base)+(Relocation^[RelocationCounter] and $fff)));
     RelocationType:=Relocation^[RelocationCounter] shr 12;
     case RelocationType of
      IMAGE_REL_BASED_ABSOLUTE:begin
      end;
      IMAGE_REL_BASED_HIGH:begin
       pword(RelocationPointer)^:=(longword(((longword(pword(RelocationPointer)^+longword(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase)))) shr 16) and $ffff;
      end;
      IMAGE_REL_BASED_LOW:begin
       pword(RelocationPointer)^:=longword(((longword(pword(RelocationPointer)^+longword(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase)))) and $ffff;
      end;
      IMAGE_REL_BASED_HIGHLOW:begin
       PPOINTER(RelocationPointer)^:=pointer((longword(longword(PPOINTER(RelocationPointer)^)+longword(ImageBase)-ImageNTHeaders.OptionalHeader.ImageBase)));
      end;
      IMAGE_REL_BASED_HIGHADJ:begin
       // ???
      end;
      IMAGE_REL_BASED_MIPS_JMPADDR:begin
       // Only for MIPS CPUs ;)
      end;
     end;
    end;
    Relocations:=pointer(longword(longword(Relocations)+BaseRelocation^.SizeOfBlock));
    inc(Position,BaseRelocation^.SizeOfBlock);
   end;
  end;
  result:=true;
 end;
 function ProcessImports:boolean;
 var ImportDescriptor:PImageImportDescriptor;
     ThunkData:plongword;
     name:pchar;
     DLLImport:PDLLImport;
     DLLFunctionImport:PDLLFunctionImport;
     FunctionPointer:pointer;
 begin
  if ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress<>0 then begin
   ImportDescriptor:=ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress);
   if assigned(ImportDescriptor) then begin
    setlength(ImportArray,0);
    while ImportDescriptor^.name<>0 do begin
     name:=ConvertPointer(ImportDescriptor^.name);
     setlength(ImportArray,length(ImportArray)+1);
     LoadExternalLibrary(name);
     DLLImport:=@ImportArray[length(ImportArray)-1];
     DLLImport^.LibraryName:=name;
     DLLImport^.LibraryHandle:=GetExternalLibraryHandle(name);
     DLLImport^.Entries:=nil;
     if ImportDescriptor^.TimeDateStamp=0 then begin
      ThunkData:=ConvertPointer(ImportDescriptor^.FirstThunk);
     end else begin
      ThunkData:=ConvertPointer(ImportDescriptor^.OriginalFirstThunk);
     end;
     while ThunkData^<>0 do begin
      setlength(DLLImport^.Entries,length(DLLImport^.Entries)+1);
      DLLFunctionImport:=@DLLImport^.Entries[length(DLLImport^.Entries)-1];
      if (ThunkData^ and IMAGE_ORDINAL_FLAG32)<>0 then begin
       DLLFunctionImport^.NameOrID:=niID;
       DLLFunctionImport^.ID:=ThunkData^ and IMAGE_ORDINAL_MASK32;
       DLLFunctionImport^.name:='';
       FunctionPointer:=GetProcAddress(DLLImport^.LibraryHandle,pchar(ThunkData^ and IMAGE_ORDINAL_MASK32));
      end else begin
       name:=ConvertPointer(longword(ThunkData^)+IMPORTED_NAME_OFFSET);
       DLLFunctionImport^.NameOrID:=niName;
       DLLFunctionImport^.ID:=0;
       DLLFunctionImport^.name:=name;
       FunctionPointer:=GetProcAddress(DLLImport^.LibraryHandle,name);
      end;
      PPOINTER(Thunkdata)^:=FunctionPointer;
      inc(ThunkData);
     end;
     inc(ImportDescriptor);
    end;
   end;
  end;
  result:=true;
 end;
 function ProtectSections:boolean;
 var I:integer;
     Characteristics:longword;
     Flags:longword;
 begin
  result:=false;
  if ImageNTHeaders.FileHeader.NumberOfSections>0 then begin
   for I:=0 to ImageNTHeaders.FileHeader.NumberOfSections-1 do begin
    Characteristics:=Sections[I].Characteristics;
    Flags:=0;
    if (Characteristics and IMAGE_SCN_MEM_EXECUTE)<>0 then begin
     if (Characteristics and IMAGE_SCN_MEM_READ)<>0 then begin
      if (Characteristics and IMAGE_SCN_MEM_WRITE)<>0 then begin
       Flags:=Flags or PAGE_EXECUTE_READWRITE;
      end else begin
       Flags:=Flags or PAGE_EXECUTE_READ;
      end;
     end else if (Characteristics and IMAGE_SCN_MEM_WRITE)<>0 then begin
      Flags:=Flags or PAGE_EXECUTE_WRITECOPY;
     end else begin
      Flags:=Flags or PAGE_EXECUTE;
     end;
    end else if (Characteristics and IMAGE_SCN_MEM_READ)<>0 then begin
     if (Characteristics and IMAGE_SCN_MEM_WRITE)<>0 then begin
      Flags:=Flags or PAGE_READWRITE;
     end else begin
      Flags:=Flags or PAGE_READONLY;
     end;
    end else if (Characteristics and IMAGE_SCN_MEM_WRITE)<>0 then begin
     Flags:=Flags or PAGE_WRITECOPY;
    end else begin
     Flags:=Flags or PAGE_NOACCESS;
    end;
    if (Characteristics and IMAGE_SCN_MEM_NOT_CACHED)<>0 then begin
     Flags:=Flags or PAGE_NOCACHE;
    end;
    VirtualProtect(Sections[I].Base,Sections[I].Size,Flags,OldProtect);
   end;
   result:=true;
  end;
 end;
 function InitializeLibrary:boolean;
 begin
  result:=false;
  @DLLProc:=ConvertPointer(ImageNTHeaders.OptionalHeader.AddressOfEntryPoint);
  if DLLProc(CARDINAL(ImageBase),DLL_PROCESS_ATTACH,nil) then begin
   result:=true;
  end;
 end;
 function ProcessExports:boolean;
 var I:integer;
     ExportDirectory:PImageExportDirectory;
     ExportDirectorySize:longword;
     FunctionNamePointer:pointer;
     FunctionName:pchar;
     FunctionIndexPointer:pointer;
     FunctionIndex:longword;
     FunctionPointer:pointer;
     ForwarderCharPointer:pchar;
     ForwarderString:string;
     ForwarderLibrary:string;
     ForwarderLibraryHandle:HINST;
  function ParseStringToNumber(AString:string):longword;
  var CharCounter:integer;
  begin
   result:=0;
   for CharCounter:=0 to length(AString)-1 do begin
    if AString[CharCounter] in ['0'..'9'] then begin
     result:=(result*10)+byte(byte(AString[CharCounter])-byte('0'));
    end else begin
     exit;
    end;
   end;
  end;
 begin
  if ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress<>0 then begin
   ExportTree:=TExportTree.Create;
   ExportDirectory:=ConvertPointer(ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress);
   if assigned(ExportDirectory) then begin
    ExportDirectorySize:=ImageNTHeaders.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size;
    setlength(ExportArray,ExportDirectory^.NumberOfNames);
    for I:=0 to ExportDirectory^.NumberOfNames-1 do begin
     FunctionNamePointer:=ConvertPointer(longword(ExportDirectory^.AddressOfNames));
     FunctionNamePointer:=ConvertPointer(PLongWordArray(FunctionNamePointer)^[I]);
     FunctionName:=FunctionNamePointer;
     FunctionIndexPointer:=ConvertPointer(longword(ExportDirectory^.AddressOfNameOrdinals));
     FunctionIndex:=PWordArray(FunctionIndexPointer)^[I];
     FunctionPointer:=ConvertPointer(longword(ExportDirectory^.AddressOfFunctions));
     FunctionPointer:=ConvertPointer(PLongWordArray(FunctionPointer)^[FunctionIndex]);
     ExportArray[I].name:=FunctionName;
     ExportArray[I].index:=FunctionIndex;
     if (longword(ExportDirectory)<longword(FunctionPointer)) and (longword(FunctionPointer)<(longword(ExportDirectory)+ExportDirectorySize)) then begin
      ForwarderCharPointer:=FunctionPointer;
      ForwarderString:=ForwarderCharPointer;
      while ForwarderCharPointer^<>'.' do inc(ForwarderCharPointer);
      ForwarderLibrary:=COPY(ForwarderString,1,POS('.',ForwarderString)-1);
      LoadExternalLibrary(ForwarderLibrary);
      ForwarderLibraryHandle:=GetExternalLibraryHandle(ForwarderLibrary);
      if ForwarderCharPointer^='#' then begin
       inc(ForwarderCharPointer);
       ForwarderString:=ForwarderCharPointer;
       ForwarderCharPointer:=ConvertPointer(ParseStringToNumber(ForwarderString));
       ForwarderString:=ForwarderCharPointer;
      end else begin
       ForwarderString:=ForwarderCharPointer;
       ExportArray[I].FunctionPointer:=GetProcAddress(ForwarderLibraryHandle,pchar(ForwarderString));
      end;
     end else begin
      ExportArray[I].FunctionPointer:=FunctionPointer;
     end;
     ExportTree.Add(ExportArray[I].name,ExportArray[I].FunctionPointer);
    end;
   end;
  end;
  result:=true;
 end;
begin
 result:=false;
 if assigned(Stream) then begin
  Stream.Seek(0);
  if Stream.Size>0 then begin
   if ReadImageHeaders then begin
    if InitializeImage then begin
     if ReadSections then begin
      if ProcessRelocations then begin
       if ProcessImports then begin
        if ProtectSections then begin
         if InitializeLibrary then begin
          if ProcessExports then begin
           result:=true;
          end;
         end;
        end;
       end;
      end;
     end;
    end;
   end;
  end;
 end;
end;

function TDynamicLinkLibrary.LoadFile(FileName:string):boolean;
begin
 if DLLHandle<>0 then begin
  DLLHandle:=0;
  FreeLibrary(DLLHandle);
 end;
 DLLHandle:=LoadLibrary(pchar(FileName));
 result:=DLLHandle<>0;
end;

function TDynamicLinkLibrary.Unload:boolean;
var I,J:integer;
begin
 result:=false;
 if DLLHandle<>0 then begin
  DLLHandle:=0;
  FreeLibrary(DLLHandle);
 end else begin
  if @DLLProc<>nil then begin
   DLLProc(longword(ImageBase),DLL_PROCESS_DETACH,nil);
  end;
  for I:=0 to length(Sections)-1 do begin
   if assigned(Sections[I].Base) then begin
    VirtualFree(Sections[I].Base,0,MEM_RELEASE);
   end;
  end;
  setlength(Sections,0);
  for I:=0 to length(ExternalLibraryArray)-1 do begin
   ExternalLibraryArray[I].LibraryName:='';
   FreeLibrary(ExternalLibraryArray[I].LibraryHandle);
  end;
  setlength(ExternalLibraryArray,0);
  for I:=0 to length(ImportArray)-1 do begin
   for J:=0 to length(ImportArray[I].Entries)-1 do begin
    ImportArray[I].Entries[J].name:='';
   end;
   setlength(ImportArray[I].Entries,0);
  end;
  setlength(ImportArray,0);
  for I:=0 to length(ExportArray)-1 do ExportArray[I].name:='';
  setlength(ExportArray,0);
  VirtualFree(ImageBase,0,MEM_RELEASE);
 end;
 if assigned(ExportTree) then begin
  ExportTree.Destroy;
  ExportTree:=nil;
 end;
end;

function TDynamicLinkLibrary.FindExport(FunctionName:string):pointer;
var I:integer;
begin
 result:=nil;
 if DLLHandle<>0 then begin
  result:=GetProcAddress(DLLHandle,pchar(FunctionName));
 end else begin
  if assigned(ExportTree) then begin
   ExportTree.Find(FunctionName,result);
  end else begin
   for I:=0 to length(ExportArray)-1 do begin
    if ExportArray[I].name=FunctionName then begin
     result:=ExportArray[I].FunctionPointer;
     exit;
    end;
   end;
  end;
 end;
end;

const PrimZahlen:array[0..255] of longword=(2,3,5,7,11,13,17,19,23,29,31,37,41,
                                            43,47,53,59,61,67,71,73,79,83,89,97,
                                            101,103,107,109,113,127,131,137,139,
                                            149,151,157,163,167,173,179,181,191,
                                            193,197,199,211,223,227,229,233,239,
                                            241,251,257,263,269,271,277,281,283,
                                            293,307,311,313,317,331,337,347,349,
                                            353,359,367,373,379,383,389,397,401,
                                            409,419,421,431,433,439,443,449,457,
                                            461,463,467,479,487,491,499,503,509,
                                            521,523,541,547,557,563,569,571,577,
                                            587,593,599,601,607,613,617,619,631,
                                            641,643,647,653,659,661,673,677,683,
                                            691,701,709,719,727,733,739,743,751,
                                            757,761,769,773,787,797,809,811,821,
                                            823,827,829,839,853,857,859,863,877,
                                            881,883,887,907,911,919,929,937,941,
                                            947,953,967,971,977,983,991,997,1009,
                                            1013,1019,1021,1031,1033,1039,1049,
                                            1051,1061,1063,1069,1087,1091,1093,
                                            1097,1103,1109,1117,1123,1129,1151,
                                            1153,1163,1171,1181,1187,1193,1201,
                                            1213,1217,1223,1229,1231,1237,1249,
                                            1259,1277,1279,1283,1289,1291,1297,
                                            1301,1303,1307,1319,1321,1327,1361,
                                            1367,1373,1381,1399,1409,1423,1427,
                                            1429,1433,1439,1447,1451,1453,1459,
                                            1471,1481,1483,1487,1489,1493,1499,
                                            1511,1523,1531,1543,1549,1553,1559,
                                            1567,1571,1579,1583,1597,1601,1607,
                                            1609,1613,1619);

      GenerationWert=$edb88320;

procedure Encode(Data,Key:TBeRoStream);
var DasLetztesByte:byte;
    LetztesByte:byte;
    NeuesByte:byte;
    HashWert:longword;
    KeyLaenge:longword;
    CRCWert:longword;
    Hash:longword;
    PrimHash:longword;
    Zaehler:longword;
    ByteHash:longword;
begin
 if (Data.Size>0) and (Key.Size>0) then begin
  LetztesByte:=Key.Size and $ff;
  KeyLaenge:=Key.Size;
  CRCWert:=CRC32(Key);
  Hash:=$ffffffff-CRCWert;
  PrimHash:=((Data.Size and $ffff) shl 16) or (Data.Size shr 16);
  PrimHash:=PrimHash xor CRCWert;
  for Zaehler:=1 to Key.Size do begin
   Hash:=Hash xor (byte(Key[Zaehler-1]) shl ((Zaehler*8) and $1f));
   PrimHash:=(PrimHash xor (PrimZahlen[(((Hash shr ((Zaehler*8) and $1f)) and $ff)) and $ff]) shl ((Zaehler*8) and $1f)) and $00ffffff;
  end;
  ByteHash:=((CRCWert and $ffff) shl 16) or (CRCWert shr 16);
  HashWert:=0;
  for Zaehler:=1 to Data.Size do begin
   HashWert:=HashWert xor (Hash shr ((Zaehler*8) and $1f));
   PrimHash:=(PrimHash*PrimZahlen[((HashWert and $ff) xor LetztesByte) and $ff]) and $00ffffff;
   PrimHash:=PrimHash xor PrimZahlen[(LetztesByte xor ((CRCWert shr ((Zaehler*4) and $1f)))) and $ff];
   DasLetztesByte:=byte(Data[Zaehler-1]);
   NeuesByte:=byte(Data[Zaehler-1]);
   NeuesByte:=NeuesByte xor (((PrimHash shr ((Zaehler*8) and $1f))) and $ff);
   NeuesByte:=NeuesByte xor (((CRCWert shr ((Zaehler*8) and $1f))) and $ff);
   NeuesByte:=NeuesByte xor (((ByteHash shr ((Zaehler*8) and $1f))) and $ff);
   NeuesByte:=NeuesByte xor byte(Key[Zaehler mod KeyLaenge]);
   NeuesByte:=NeuesByte xor (((((GenerationWert shr (LetztesByte and $1f))) and $ff)) and $ff);
   Data[Zaehler-1]:=NeuesByte;
   LetztesByte:=DasLetztesByte;
   ByteHash:=(ByteHash shl 1) xor LetztesByte;
  end;
 end;
end;

procedure Decode(Data,Key:TBeRoStream);
var LetztesByte:byte;
    NeuesByte:byte;
    HashWert:longword;
    KeyLaenge:longword;
    CRCWert:longword;
    Hash:longword;
    PrimHash:longword;
    Zaehler:longword;
    ByteHash:longword;
begin
 if (Data.Size>0) and (Key.Size>0) then begin
  LetztesByte:=Key.Size and $ff;
  KeyLaenge:=Key.Size;
  CRCWert:=CRC32(Key);
  Hash:=$ffffffff-CRCWert;
  PrimHash:=((Data.Size and $ffff) shl 16) or (Data.Size shr 16);
  PrimHash:=PrimHash xor CRCWert;
  for Zaehler:=1 to Key.Size do begin
   Hash:=Hash xor (byte(Key[Zaehler-1]) shl ((Zaehler*8) and $1f));
   PrimHash:=(PrimHash xor (PrimZahlen[(((Hash shr ((Zaehler*8) and $1f)) and $ff)) and $ff]) shl ((Zaehler*8) and $1f)) and $00ffffff;
  end;
  ByteHash:=((CRCWert and $ffff) shl 16) or (CRCWert shr 16);
  HashWert:=0;
  for Zaehler:=1 to Data.Size do begin
   HashWert:=HashWert xor (Hash shr ((Zaehler*8) and $1f));
   PrimHash:=(PrimHash*PrimZahlen[((HashWert and $ff) xor LetztesByte) and $ff]) and $00ffffff;
   PrimHash:=PrimHash xor PrimZahlen[(LetztesByte xor ((CRCWert shr ((Zaehler*4) and $1f)))) and $ff];
   NeuesByte:=byte(Data[Zaehler-1]);
   NeuesByte:=NeuesByte xor (((PrimHash shr ((Zaehler*8) and $1f))) and $ff);
   NeuesByte:=NeuesByte xor (((CRCWert shr ((Zaehler*8) and $1f))) and $ff);
   NeuesByte:=NeuesByte xor (((ByteHash shr ((Zaehler*8) and $1f))) and $ff);
   NeuesByte:=NeuesByte xor byte(Key[Zaehler mod KeyLaenge]);
   NeuesByte:=NeuesByte xor (((((GenerationWert shr (LetztesByte and $1f))) and $ff)) and $ff);
   Data[Zaehler-1]:=NeuesByte;
   LetztesByte:=NeuesByte;
   ByteHash:=(ByteHash shl 1) xor LetztesByte;
  end;
 end;
end;

function Encode(Data:string;Key:TBeRoStream):string;
var DataStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 Encode(DataStream,Key);
 result:=DataStream.Text;
 DataStream.Free;
end;

function Decode(Data:string;Key:TBeRoStream):string;
var DataStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 Decode(DataStream,Key);
 result:=DataStream.Text;
 DataStream.Free;
end;

function Encode(Data,Key:string):string; overload;
var DataStream,KeyStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 KeyStream.Text:=Key;
 Encode(DataStream,KeyStream);
 result:=DataStream.Text;
 DataStream.Free;
 KeyStream.Free;
end;

function Decode(Data,Key:string):string; overload;
var DataStream,KeyStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Text:=Data;
 KeyStream.Text:=Key;
 Decode(DataStream,KeyStream);
 result:=DataStream.Text;
 DataStream.Free;
 KeyStream.Free;
end;

procedure Encode(var Data;DataLength:longword;Key:TBeRoStream);
var DataStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.write(Data,DataLength);
 Encode(DataStream,Key);
 DataStream.Seek(0);
 DataStream.read(Data,DataLength);
 DataStream.Free;
end;

procedure Decode(var Data;DataLength:longword;Key:TBeRoStream);
var DataStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.write(Data,DataLength);
 Decode(DataStream,Key);
 DataStream.Seek(0);
 DataStream.read(Data,DataLength);
 DataStream.Free;
end;

procedure Encode(var Data;DataLength:longword;Key:string);
var DataStream,KeyStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.write(Data,DataLength);
 KeyStream.Text:=Key;
 Encode(DataStream,KeyStream);
 DataStream.Seek(0);
 DataStream.read(Data,DataLength);
 DataStream.Free;
 KeyStream.Free;
end;

procedure Decode(var Data;DataLength:longword;Key:string);
var DataStream,KeyStream:TBeRoMemoryStream;
begin
 DataStream:=TBeRoMemoryStream.Create;
 KeyStream:=TBeRoMemoryStream.Create;
 DataStream.Clear;
 DataStream.write(Data,DataLength);
 KeyStream.Text:=Key;
 Decode(DataStream,KeyStream);
 DataStream.Seek(0);
 DataStream.read(Data,DataLength);
 DataStream.Free;
 KeyStream.Free;
end;

constructor TBeRoArchive.Create;
begin
 inherited Create;
 fKey:=TBeRoMemoryStream.Create;
 fSubKey:=TBeRoMemoryStream.Create;
 fOpen:=false;
 fInitSearch:=false;
 FastCompression:=true;
 SetKey('');
 SetSubKey('');
end;

destructor TBeRoArchive.Destroy;
begin
 if fOpen then begin
  fStream:=nil;
  fOpen:=false;
 end;
 fSubKey.Free;
 fKey.Free;
 inherited Destroy;
end;

procedure TBeRoArchive.EncodeBuffer(var B:TBeRoArchiveBuf);
begin
end;

procedure TBeRoArchive.DecodeBuffer(var B:TBeRoArchiveBuf);
begin
end;

procedure TBeRoArchive.SetKey(AStream:TBeRoStream);
begin
 fKey.Clear;
 fKey.Assign(AStream);
end;

procedure TBeRoArchive.SetKey(AKey:string);
begin
 fKey.Clear;
 fKey.Text:=AKey;
end;

procedure TBeRoArchive.SetSubKey(AStream:TBeRoStream);
begin
 fSubKey.Clear;
 fSubKey.Assign(AStream);
end;

procedure TBeRoArchive.SetSubKey(AKey:string);
begin
 fSubKey.Clear;
 fSubKey.Text:=AKey;
end;

function TBeRoArchive.IsArchive(AStream:TBeRoStream):boolean;
var Header:TBeRoArchiveHeader;
begin
 result:=false;
 AStream.Seek(0);
 AStream.read(Header,sizeof(TBeRoArchiveHeader));
 if Header.Sign=MySign then result:=true;
end;

function TBeRoArchive.IsCrypted(AStream:TBeRoStream):boolean;
var Header:TBeRoArchiveHeader;
begin
 result:=false;
 AStream.Seek(0);
 AStream.read(Header,sizeof(TBeRoArchiveHeader));
 if (Header.Sign=MySign) and (Header.KeyHash<>CRC32('')) then result:=true;
end;

function TBeRoArchive.CreateArchive(AStream:TBeRoStream):boolean;
begin
 if fOpen then begin
  fStream:=nil;
  fOpen:=false;
 end;
 fInitSearch:=false;
 fStream:=AStream;
 fStream.Clear;
 fHeader.Sign:=MySign;
 fHeader.KeyHash:=CRC32(fKey);
 fStream.Seek(0);
 fStream.write(fHeader,sizeof(TBeRoArchiveHeader));
 if fHeader.Sign<>MySign then begin
  fStream:=nil;
  fOpen:=false;
 end else begin
  fOpen:=true;
 end;
 result:=fOpen;
end;

function TBeRoArchive.OpenArchive(AStream:TBeRoStream):boolean;
begin
 if fOpen then begin
  fStream:=nil;
  fOpen:=false;
 end;
 fInitSearch:=false;
 fStream:=AStream;
 fStream.Seek(0);
 fStream.read(fHeader,sizeof(TBeRoArchiveHeader));
 if fHeader.Sign<>MySign then begin
  fStream:=nil;
  fOpen:=false;
 end else if fHeader.KeyHash<>CRC32(fKey) then begin
  fStream:=nil;
  fOpen:=false;
 end else begin
  fOpen:=true;
 end;
 result:=fOpen;
end;

procedure TBeRoArchive.CloseArchive;
begin
 if fOpen then begin
  fStream:=nil;
  fOpen:=false;
 end;
end;

function TBeRoArchive.Add(FileNameInArchive:string;AStream:TBeRoStream):boolean;
var fAStream:TBeRoMemoryStream;
    Gelesen:longword;
    fFile:TBeRoArchiveFile;
    fBuf:TBeRoArchiveBuf;
begin
 result:=false;
 if fOpen then begin
  fAStream:=TBeRoMemoryStream.Create;
  Compression(AStream,fAStream,FastCompression);
  Encode(fAStream,fSubKey);
  Encode(fAStream,fKey);

  fStream.Seek(fStream.Size);

  fFile.FileNameLength:=length(FileNameInArchive);
  fFile.FileType:=ftFile;
  fFile.Size:=fAStream.Size;
  fFile.KeyHash:=CRC32(fSubKey);

  Encode(fFile,sizeof(TBeRoArchiveFile),fKey);
  fStream.write(fFile,sizeof(TBeRoArchiveFile));
  Decode(fFile,sizeof(TBeRoArchiveFile),fKey);
  fStream.WriteString(Encode(FileNameInArchive,fKey));

  fAStream.Seek(0);
  Gelesen:=fFile.Size;
  while Gelesen>0 do begin
   Gelesen:=fAStream.read(fBuf,sizeof(TBeRoArchiveBuf));
   EncodeBuffer(fBuf);
   fStream.write(fBuf,Gelesen);
  end;
  fAStream.Free;
  result:=true;
 end;
end;

function TBeRoArchive.AddString(FileNameInArchive:string;AString:string):boolean;
var StringStream:TBeRoMemoryStream;
begin
 StringStream:=TBeRoMemoryStream.Create;
 StringStream.Text:=AString;
 result:=Add(FileNameInArchive,StringStream);
 StringStream.Free;
end;

procedure TBeRoArchive.InitSearch;
begin
 if fOpen then begin
  fStream.Seek(0);
  fStream.read(fHeader,sizeof(TBeRoArchiveHeader));
  if fHeader.Sign<>MySign then begin
   fStream:=nil;
   fOpen:=false;
  end else begin
   fOpen:=true;
  end;
  fInitSearch:=fOpen;
 end;
end;

function TBeRoArchive.FindNextEx:TBeRoArchiveFileParam;
var fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
begin
 if fOpen and fInitSearch and not EndOfArchive then begin
  fStream.read(fFile,sizeof(TBeRoArchiveFile));
  Decode(fFile,sizeof(TBeRoArchiveFile),fKey);
  fFileParam.FileName:=Decode(fStream.ReadString,fKey);
  fFileParam.Data:=fFile;
  result:=fFileParam;
 end;
end;

function TBeRoArchive.FindNext:TBeRoArchiveFileParam;
var Next:longword;
    fFileParam:TBeRoArchiveFileParam;
begin
 if fOpen and fInitSearch and not EndOfArchive then begin
  fFileParam:=FindNextEx;
  Next:=longword(fStream.Position)+fFileParam.Data.Size;
  fStream.Seek(Next);
  result:=fFileParam;
 end;
end;

function TBeRoArchive.EndOfArchive:boolean;
begin
 if fOpen then begin
  result:=fStream.Position>=fStream.Size;
 end else begin
  result:=true;
 end;
end;

function TBeRoArchive.IsFileCrypted(FileNameInArchive:string):boolean;
var Next:longword;
    fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
begin
 result:=false;
 if fOpen then begin
  InitSearch;
  while fStream.Position<fStream.Size do begin
   fFileParam:=FindNextEx;
   fFile:=fFileParam.Data;

   Next:=longword(fStream.Position)+fFile.Size;
   if (fFileParam.FileName=FileNameInArchive) and (fFile.FileType=ftFile) then begin
    if fFile.KeyHash<>CRC32('') then begin
     result:=true;
    end;
    break;
   end else begin
    fStream.Seek(Next);
   end;
  end;
 end;
end;

function TBeRoArchive.Extract(FileNameInArchive:string;AStream:TBeRoStream):boolean;
var fAStream:TBeRoMemoryStream;
    Nc,Nr,Next,Gelesen:longword;
    fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
    fBuf:TBeRoArchiveBuf;
begin
 result:=false;
 if fOpen then begin
  InitSearch;
  while fStream.Position<fStream.Size do begin
   fFileParam:=FindNextEx;
   fFile:=fFileParam.Data;

   Next:=longword(fStream.Position)+fFile.Size;
   if (fFileParam.FileName=FileNameInArchive) and (fFile.FileType=ftFile) then begin
    if fFile.KeyHash=CRC32(fSubKey) then begin
     fAStream:=TBeRoMemoryStream.Create;
     fAStream.Clear;
     Nc:=fFile.Size div sizeof(fBuf);
     Nr:=fFile.Size-(Nc*sizeof(fBuf));
     while Nc>0 do begin
      Gelesen:=fStream.read(fBuf,sizeof(fBuf));
      DecodeBuffer(fBuf);
      fAStream.write(fBuf,Gelesen);
      dec(Nc);
     end;
     Gelesen:=fStream.read(fBuf,Nr);
     DecodeBuffer(fBuf);
     fAStream.write(fBuf,Gelesen);
     Decode(fAStream,fKey);
     Decode(fAStream,fSubKey);
     Decompression(fAStream,AStream);
     fAStream.Free;
     result:=true;
    end;
    break;
   end else begin
    fStream.Seek(Next);
   end;
  end;
 end;
end;

function TBeRoArchive.GetString(FileNameInArchive:string):string;
var StringStream:TBeRoMemoryStream;
begin
 StringStream:=TBeRoMemoryStream.Create;
 Extract(FileNameInArchive,StringStream);
 result:=StringStream.Text;
 StringStream.Free;
end;

procedure TBeRoArchive.Delete(FileNameInArchive:string);
var Nc,Nr,Next,Gelesen:longword;
    F:TBeRoMemoryStream;
    fFile:TBeRoArchiveFile;
    fFileParam:TBeRoArchiveFileParam;
    fBuf:TBeRoArchiveBuf;
begin
 if fOpen then begin
  F:=TBeRoMemoryStream.Create;

  fStream.Seek(0);
  F.Seek(0);

  fStream.read(fHeader,sizeof(TBeRoArchiveHeader));
  F.write(fHeader,sizeof(TBeRoArchiveHeader));

  InitSearch;
  while fStream.Position<fStream.Size do begin
   fFileParam:=FindNextEx;
   fFile:=fFileParam.Data;

   Next:=longword(fStream.Position)+fFile.Size;
   if (fFileParam.FileName=FileNameInArchive) and (fFile.FileType=ftFile) then begin
    fStream.Seek(Next);
   end else begin
    Encode(fFile,sizeof(TBeRoArchiveFile),fKey);
    F.write(fFile,sizeof(TBeRoArchiveFile));
    Decode(fFile,sizeof(TBeRoArchiveFile),fKey);
    F.WriteString(Encode(fFileParam.FileName,fKey));

    Nc:=fFile.Size div sizeof(fBuf);
    Nr:=fFile.Size-(Nc*sizeof(fBuf));
    while Nc>0 do begin
     Gelesen:=fStream.read(fBuf,sizeof(fBuf));
     F.write(fBuf,Gelesen);
     dec(Nc);
    end;
    Gelesen:=fStream.read(fBuf,Nr);
    F.write(fBuf,Gelesen);
   end;
  end;

  fStream.Clear;
  fStream.Assign(F);

  F.Free;
 end;
end;

procedure RTL_OUTPUTBLOCK(Klasse:pointer;BlockNummer:integer); pascal;
var S:string;
begin
 if assigned(Klasse) then begin
  if (BlockNummer>=0) and (BlockNummer<length(TBeRoScript(Klasse).Blocks)) then begin
   TBeRoScript(Klasse).OutputBlock(BlockNummer);
  end;
 end;
end;

procedure RTL_PRINTF_FIXEDSTRING(Klasse,Zeiger:pointer;Laenge:longword); pascal;
var S:string;
begin
 if assigned(Klasse) then begin
  if assigned(Zeiger) then begin
   setlength(S,Laenge);
   MOVE(Zeiger^,S[1],Laenge);
   TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
   if TBeRoScript(Klasse).OutDirect then write(S);
  end;
 end;
end;

procedure RTL_PRINTF_STRING(Klasse,Zeiger:pointer); pascal;
var S:string;
    Laenge:longword;
begin
 if assigned(Klasse) then begin
  if assigned(Zeiger) then begin
   Laenge:=PBeroScriptString(longword(longword(Zeiger)-strStartOffset))^.length;
   setlength(S,Laenge);
   MOVE(Zeiger^,S[1],Laenge);
   TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
   if TBeRoScript(Klasse).OutDirect then write(S);
  end;
 end;
end;

procedure RTL_PRINTF_NUMBER_SIGNED(Klasse:pointer;Number:longint); pascal;
var S:string;
begin
 if assigned(Klasse) then begin
  STR(Number,S);
  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
  if TBeRoScript(Klasse).OutDirect then write(S);
 end;
end;

procedure RTL_PRINTF_NUMBER_UNSIGNED(Klasse:pointer;Number:longword); pascal;
var S:string;
begin
 if assigned(Klasse) then begin
  STR(Number,S);
  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
  if TBeRoScript(Klasse).OutDirect then write(S);
 end;
end;

procedure RTL_PRINTF_PCHAR(Klasse:pointer;Zeiger:pchar); pascal;
var S:string;
begin
 if assigned(Klasse) then begin
  if assigned(Zeiger) then begin
   S:=Zeiger;
   TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
   if TBeRoScript(Klasse).OutDirect then write(S);
  end;
 end;
end;

procedure RTL_PRINTF_CHAR(Klasse:pointer;Zeichen:longword); pascal;
begin
 if assigned(Klasse) then begin
  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+CHR(Zeichen);
  if TBeRoScript(Klasse).OutDirect then write(CHR(Zeichen));
 end;
end;

procedure RTL_PRINTF_FLOAT(Klasse:pointer;Number:single); pascal;
var S:string;
begin
 if assigned(Klasse) then begin
  STR(Number,S);
  TBeRoScript(Klasse).Output:=TBeRoScript(Klasse).Output+S;
  if TBeRoScript(Klasse).OutDirect then write(S);
 end;
end;

procedure ThreadSafeDecrease(S:pointer); pascal; assembler;
asm
 MOV EDX,dword PTR S
 TEST EDX,EDX
 JE @exit
 LOCK dec dword PTR [EDX]
 @exit:
end;

procedure ThreadSafeIncrease(S:pointer); pascal; assembler;
asm
 MOV EDX,dword PTR S
 TEST EDX,EDX
 JE @exit
 LOCK inc dword PTR [EDX]
 @exit:
end;

function RTL_STRING_NEW(MyLength:longword):pointer; pascal;
var S:PBeRoScriptString;
begin
 result:=nil;
 GETMEM(S,strRecordLength+MyLength);
 FILLCHAR(S^,strRecordLength+MyLength,#0);
{$IFDEF FPC}
 S^.MaxLength:=MyLength;
 S^.length:=0;
{$ELSE}
 S^.length:=MyLength;
{$ENDIF}
 S^.Reference:=1;
 S^.FirstChar:=#0;
 result:=pointer(longword(longword(S)+strStartOffset));
end;

procedure RTL_STRING_DISPOSE(var S:pointer); pascal;
begin
 if assigned(S) then begin
  S:=pointer(longword(longword(S)-strStartOffset));
  FREEMEM(S);
  S:=nil;
 end;
end;

function RTL_STRING_DECREASE(S:pointer):pointer; pascal;
var MySrc:PBeRoScriptString;
    L:plongint;
begin
 result:=S;
 if assigned(S) then begin
  MySrc:=pointer(longword(longword(S)-strStartOffset));
  L:=@MySrc^.Reference;
  if L^>=0 then begin
   ThreadSafeDecrease(L);
   if L^=0 then FREEMEM(MySrc);
   result:=nil;
  end;
 end;
end;

function RTL_STRING_INCREASE(S:pointer):pointer; pascal;
var MySrc:PBeRoScriptString;
    L:plongint;
begin
 result:=S;
 if assigned(S) then begin
  MySrc:=pointer(longword(longword(S)-strStartOffset));
  L:=@MySrc^.Reference;
  if L^>=0 then begin
   ThreadSafeIncrease(L);
  end;
 end;
end;

function RTL_STRING_ASSIGN(Src,Dst:pointer):pointer; pascal;
var S:PBeRoScriptString;
begin
 if assigned(Src) then begin
  S:=pointer(longword(longword(Src)-strStartOffset));
  ThreadSafeIncrease(@S^.Reference);
 end;
 RTL_STRING_DECREASE(Dst);
 result:=Src;
end;

function RTL_STRING_LENGTH(S:pointer):longword; pascal;
begin
 result:=0;
 if assigned(S) then begin
  result:=PBeRoScriptString(longword(longword(S)-strStartOffset))^.length;
 end;
end;

procedure RTL_STRING_SETLENGTH(var S:pointer;NewLength:longword); pascal;
var MyStr,TempStr:PBeRoScriptString;
    TempPointer:pointer;
    CopyLength:longword;
begin
 if NewLength>0 then begin
  if assigned(S) then begin
   MyStr:=pointer(longword(longword(S)-strStartOffset));
{$IFDEF FPC}
   if (MyStr^.MaxLength<NewLength) or (MyStr^.Reference<>1) then begin
{$ELSE}
   if (MyStr^.length<>NewLength) or (MyStr^.Reference<>1) then begin
{$ENDIF}
    TempPointer:=RTL_STRING_NEW(NewLength);
    TempStr:=pointer(longword(longword(TempPointer)-strStartOffset));
    if MyStr^.length>0 then begin
     if NewLength<=MyStr^.length then begin
      CopyLength:=NewLength;
     end else begin
      CopyLength:=MyStr^.length+1;
     end;
     MOVE(S^,TempPointer^,CopyLength);
    end;
    RTL_STRING_DECREASE(S);
    S:=TempPointer;
   end;
  end else begin
   S:=RTL_STRING_NEW(NewLength);
  end;
  pbyte(longword(longword(S)+NewLength))^:=0;
  PBeroScriptString(longword(longword(S)-strStartOffset))^.length:=NewLength;
 end else begin
  if assigned(S) then begin
   RTL_STRING_DECREASE(S);
  end;
  S:=nil;
 end;
end;

function RTL_STRING_UNIQUE(S:pointer):pointer; pascal;
var N:pointer;
    L:longword;
begin
 result:=S;
 if assigned(S) then begin
  if PBeRoScriptString(longword(longword(S)-strStartOffset))^.Reference<>1 then begin
   L:=RTL_STRING_LENGTH(S);
   N:=RTL_STRING_NEW(L);
   MOVE(S^,N^,L+1);
   RTL_STRING_DECREASE(S);
   result:=N;
  end;
 end;
end;

function RTL_STRING_CHARCONVERT(Value:longword):pointer; pascal;
begin
 result:=nil;
 RTL_STRING_SETLENGTH(result,1);
 byte(result^):=Value;
end;

function RTL_STRING_GET(Src,Dst:pointer):pointer; pascal;
var L:longword;
begin
 L:=RTL_STRING_LENGTH(Src);
 RTL_STRING_DECREASE(Dst);
 result:=RTL_STRING_NEW(L);
 RTL_STRING_SETLENGTH(result,L);
 MOVE(Src^,result^,L);
end;

function RTL_STRING_CONCAT(Src1,Src2,Dst:pointer):pointer; pascal;
var Size1,Size2:longword;
begin
 result:=Dst;
 if not assigned(Src1) then begin
  result:=RTL_STRING_ASSIGN(Src2,result);
 end else if not assigned(Src2) then begin
  result:=RTL_STRING_ASSIGN(Src1,result);
 end else begin
  if assigned(result) then begin
   result:=RTL_STRING_DECREASE(result);
  end;
  Size1:=RTL_STRING_LENGTH(Src1);
  Size2:=RTL_STRING_LENGTH(Src2);
  RTL_STRING_SETLENGTH(result,Size1+Size2);
  if Size2>0 then begin
   if Size1>0 then begin
    MOVE(Src1^,result^,Size1);
    MOVE(Src2^,pointer(longword(longword(result)+Size1))^,Size2+1);
   end else begin
    MOVE(Src2^,result^,Size2);
   end;
  end else if Size1>0 then begin
   MOVE(Src1^,result^,Size1);
  end;
 end;
end;

function RTL_STRING_SELF_CONCAT(SrcDst,Src:pointer):pointer; pascal;
var Size1,Size2:longword;
begin
 result:=SrcDst;
 if not assigned(SrcDst) then begin
  result:=RTL_STRING_ASSIGN(Src,result);
 end else if not assigned(Src) then begin
  result:=RTL_STRING_ASSIGN(SrcDst,result);
 end else begin
  Size1:=RTL_STRING_LENGTH(SrcDst);
  Size2:=RTL_STRING_LENGTH(Src);
  RTL_STRING_SETLENGTH(result,Size1+Size2);
  if Size2>0 then begin
   MOVE(Src^,pointer(longword(longword(result)+Size1))^,Size2+1);
  end;
 end;
end;

function RTL_STRING_COMPARE(Src1,Src2:pointer):integer; pascal;
var Size1,Size2:longint;
    Size,Position:longint;
    B1,B2:pbyte;
begin
 result:=0;
 Size1:=RTL_STRING_LENGTH(Src1);
 Size2:=RTL_STRING_LENGTH(Src2);
 if Size1<Size2 then begin
  Size:=Size1;
 end else begin
  Size:=Size2;
 end;
 Position:=0;
 B1:=Src1;
 B2:=Src2;
 while (Position<Size) and (result=0) do begin
  result:=B1^-B2^;
  inc(B1);
  inc(B2);
  inc(Position);
 end;
 if result=0 then begin
  result:=Size1-Size2;
 end;
end;

function RTL_ROUND(Value:single):integer; pascal;
begin
 result:=ROUND(Value);
end;

function RTL_TRUNC(Value:single):integer; pascal;
begin
 result:=TRUNC(Value);
end;

function RTL_SIN(Value:single):single; pascal;
begin
 result:=SIN(Value);
end;

function RTL_COS(Value:single):single; pascal;
begin
 result:=COS(Value);
end;

function RTL_ABS(Value:single):single; pascal;
begin
 result:=ABS(Value);
end;

function RTL_FRAC(Value:single):single; pascal;
begin
 result:=FRAC(Value);
end;

function RTL_EXP(Value:single):single; pascal;
begin
 result:=EXP(Value);
end;

function RTL_LN(Value:single):single; pascal;
begin
 result:=LN(Value);
end;

function RTL_SQR(Value:single):single; pascal;
begin
 result:=SQR(Value);
end;

function RTL_SQRT(Value:single):single; pascal;
begin
 result:=SQRT(Value);
end;

function RTL_RANDOM:single; pascal;
begin
 result:=RandomFloatValue;
end;

function RTL_PI:single; pascal;
begin
 result:=PI;
end;

function RTL_READFLOAT:single; pascal;
begin
 read(result);
end;

function RTL_READINT:longint; pascal;
begin
 read(result);
end;

function RTL_READUINT:longword; pascal;
begin
 read(result);
end;

function RTL_READSTRING:pointer; pascal;
var S:string;
    L:longword;
begin
 read(S);
 L:=length(S);
 result:=nil;
 RTL_STRING_SETLENGTH(result,L);
 if L>0 then MOVE(S[1],result^,L);
end;

function RTL_READCHAR:char; pascal;
begin
 read(result);
end;

procedure RTL_READLN; pascal;
begin
 READLN;
end;

procedure RTL_FLUSHIN; pascal;
begin
 FLUSH(INPUT);
end;

procedure RTL_FLUSH; pascal;
begin
 FLUSH(OUTPUT);
end;

procedure RTL_FLUSHOUT; pascal;
begin
 FLUSH(OUTPUT);
end;

function RTL_TRIM(Src:pointer):pointer; pascal;
var StartPos,Laenge:integer;
    S:pbyte;
begin
 result:=nil;
 Laenge:=RTL_STRING_LENGTH(Src);
 if Laenge>0 then begin
  S:=pbyte(longword(longword(Src)+longword(Laenge)-1));
  while (Laenge>0) and (S^ in [0..32]) do begin
   dec(Laenge);
   dec(S);
  end;
  StartPos:=0;
  S:=Src;
  while (StartPos<Laenge) and (S^ in [0..32]) do begin
   inc(StartPos);
   inc(S);
  end;
  Laenge:=Laenge-StartPos;
  RTL_STRING_SETLENGTH(result,Laenge);
  S:=pbyte(longword(longword(Src)+longword(StartPos)));
  MOVE(S^,result^,Laenge);
 end;
end;

function RTL_COPY(Src:pointer;index,Count:longint):pointer; pascal;
var Start,Laenge,CopyCount:integer;
begin
 result:=nil;
 Laenge:=RTL_STRING_LENGTH(Src);
 if Laenge>0 then begin
  Start:=index;
  if Start<0 then Start:=0;
  CopyCount:=Count;
  if (CopyCount>Laenge) or ((Start+CopyCount)>Laenge) then begin
   CopyCount:=Laenge-Start;
  end;
  if CopyCount>0 then begin
   RTL_STRING_SETLENGTH(result,CopyCount);
   MOVE(pbyte(longword(longword(Src)+longword(Start)))^,result^,CopyCount);
  end;
 end;
end;

function RTL_LENGTH(Src:pointer):integer; pascal;
begin
 result:=0;
 if assigned(Src) then begin
  result:=PBeRoScriptString(longword(longword(Src)-strStartOffset))^.length;
 end;
end;

function RTL_CHARAT(Src:pointer;index:longword):byte; pascal;
begin
 result:=0;
 if index<RTL_STRING_LENGTH(Src) then begin
  result:=pbyte(longword(longword(Src)+index))^;
 end;
end;

function RTL_CHARPOINTERAT(Src:pointer;index:longword):pointer; pascal;
begin
 result:=nil;
 if index<RTL_STRING_LENGTH(Src) then begin
  result:=pbyte(longword(longword(Src)+index));
 end;
end;

function ConvertFromBeRoString(Src:BeRoString):string;
var Laenge:longword;
begin
 Laenge:=RTL_STRING_LENGTH(Src);
 setlength(result,Laenge);
 MOVE(Src^,result[1],Laenge);
end;

function ConvertToBeRoString(Src:string):BeRoString;
var Laenge:longword;
begin
 result:=nil;
 Laenge:=length(Src);
 RTL_STRING_SETLENGTH(result,Laenge);
 MOVE(Src[1],result^,Laenge);
 Src:='';
end;

function RTL_DELETE(Src:pointer;index,Count:longint):pointer; pascal;
var Laenge,CopyCount:integer;
begin
 result:=nil;
 Laenge:=RTL_STRING_LENGTH(Src);
 if Laenge>0 then begin
  if (index>=Laenge) or (index<0) or (Count<=0) then begin
   result:=RTL_STRING_ASSIGN(Src,result);
  end else begin
   result:=RTL_STRING_UNIQUE(Src);
   CopyCount:=Count;
   if (index+CopyCount)>Laenge then CopyCount:=Laenge-index+2;
   if CopyCount<=(Laenge-index) then begin
    MOVE(pbyte(longword(longword(result)+longword(index+CopyCount)))^,pbyte(longword(longword(result)+longword(index)))^,Laenge-index-CopyCount+1);
    RTL_STRING_SETLENGTH(result,Laenge-CopyCount);
   end;
  end;
 end;
end;

function RTL_INSERT(Src,Dst:pointer;index:longint):pointer; pascal;
var SourceLaenge,Laenge,CopyCount:integer;
begin
 result:=nil;
 SourceLaenge:=RTL_STRING_LENGTH(Src);
 Laenge:=RTL_STRING_LENGTH(Dst);
 if SourceLaenge>0 then begin
  if Laenge>0 then begin
   if index<0 then index:=0;
   if index>=Laenge then index:=Laenge;
   result:=nil;
   RTL_STRING_SETLENGTH(result,SourceLaenge+Laenge);
   FILLCHAR(result^,SourceLaenge+Laenge,#0);
   MOVE(Dst^,result^,index);
   MOVE(Src^,pbyte(longword(longword(result)+longword(index)))^,SourceLaenge);
   if (Laenge-index)>0 then begin
    MOVE(pbyte(longword(longword(Dst)+longword(index)))^,pbyte(longword(longword(result)+longword(index)+longword(SourceLaenge)))^,Laenge-index);
   end;
  end else begin
   result:=RTL_STRING_ASSIGN(Src,result);
  end;
 end else begin
  if Laenge>0 then begin
   result:=RTL_STRING_ASSIGN(Dst,result);
  end;
 end;
end;

function RTL_SETSTRING(Src:pointer;Laenge:longint):pointer; pascal;
begin
 result:=nil;
 if Laenge>0 then begin
  RTL_STRING_SETLENGTH(result,Laenge);
  MOVE(Src^,result^,Laenge);
 end;
end;

function RTL_LOWERCASE(Src:pointer):pointer; pascal;
var Laenge,Position:integer;
    B:pbyte;
begin
 result:=nil;
 Laenge:=RTL_STRING_LENGTH(Src);
 if Laenge>0 then begin
  result:=RTL_STRING_UNIQUE(Src);
  B:=result;
  for Position:=1 to Laenge do begin
   if char(B^) in ['A'..'Z'] then inc(B^,ord('a')-ord('A'));
   inc(B);
  end;
 end;
end;

function RTL_UPPERCASE(Src:pointer):pointer; pascal;
var Laenge,Position:integer;
    B:pbyte;
begin
 result:=nil;
 Laenge:=RTL_STRING_LENGTH(Src);
 if Laenge>0 then begin
  result:=RTL_STRING_UNIQUE(Src);
  B:=result;
  for Position:=1 to Laenge do begin
   if char(B^) in ['a'..'z'] then dec(B^,ord('a')-ord('A'));
   inc(B);
  end;
 end;
end;

function RTL_LOCASE(Src:longword):char; pascal;
begin
 result:=CHR(Src);
 if result in ['A'..'Z'] then inc(byte(result),ord('a')-ord('A'));
end;

function RTL_UPCASE(Src:longword):char; pascal;
begin
 result:=CHR(Src);
 if result in ['a'..'z'] then dec(byte(result),ord('a')-ord('A'));
end;

function RTL_POS(SubStr,Str:pointer;First:longint):longint; pascal;
var SubLaenge,Laenge,Position,SubPosition:integer;
    PositionByte,ScanByte,SubScanByte:pbyte;
begin
 result:=-1;
 SubLaenge:=RTL_STRING_LENGTH(SubStr);
 Laenge:=RTL_STRING_LENGTH(Str);
 if (First<Laenge) and ((First+SubLaenge)<=Laenge) then begin
  PositionByte:=Str;
  inc(PositionByte,First);
  Position:=First;
  while Position<Laenge do begin
   ScanByte:=PositionByte;
   SubScanByte:=SubStr;
   SubPosition:=0;
   if ((Position+SubPosition)<Laenge) and (SubPosition<SubLaenge) then begin
    while ((Position+SubPosition)<Laenge) and (SubPosition<SubLaenge) and (ScanByte^=SubScanByte^) do begin
     inc(ScanByte);
     inc(SubScanByte);
     inc(SubPosition);
    end;
    if SubPosition=SubLaenge then begin
     result:=Position;
     exit;
    end;
   end;
   inc(PositionByte);
   inc(Position);
  end;
 end;
end;

function RTL_POSEX(SubStr,Str:pointer;First:longint):longint; pascal;
var SubLaenge,Laenge,Position,SubPosition:integer;
    PositionByte,ScanByte,SubScanByte:pbyte;
    A,B:byte;
begin
 result:=-1;
 SubLaenge:=RTL_STRING_LENGTH(SubStr);
 Laenge:=RTL_STRING_LENGTH(Str);
 if (First<Laenge) and ((First+SubLaenge)<=Laenge) then begin
  PositionByte:=Str;
  inc(PositionByte,First);
  Position:=First;
  while Position<Laenge do begin
   ScanByte:=PositionByte;
   SubScanByte:=SubStr;
   SubPosition:=0;
   if ((Position+SubPosition)<Laenge) and (SubPosition<SubLaenge) then begin
    A:=ScanByte^;
    B:=SubScanByte^;
    if char(A) in ['A'..'Z'] then inc(A,ord('a')-ord('A'));
    if char(B) in ['A'..'Z'] then inc(B,ord('a')-ord('A'));
    while ((Position+SubPosition)<Laenge) and (SubPosition<SubLaenge) and (A=B) do begin
     inc(ScanByte);
     inc(SubScanByte);
     inc(SubPosition);
     A:=ScanByte^;
     B:=SubScanByte^;
     if char(A) in ['A'..'Z'] then inc(A,ord('a')-ord('A'));
     if char(B) in ['A'..'Z'] then inc(B,ord('a')-ord('A'));
    end;
    if SubPosition=SubLaenge then begin
     result:=Position;
     exit;
    end;
   end;
   inc(PositionByte);
   inc(Position);
  end;
 end;
end;

function RTL_INTTOSTR(Number,Digits:longint):pointer; pascal;
var S:string;
    I:integer;
begin
 STR(Number:Digits,S);
 for I:=1 to length(S) do if byte(S[I])<=32 then S[I]:='0';
 result:=ConvertToBeRoString(S);
 S:='';
end;

function RTL_GETMEM(Size:longint):pointer; pascal;
begin
 GETMEM(result,Size);
end;

procedure RTL_FREEMEM(S:pointer); pascal;
begin
 FREEMEM(S);
end;

function RTL_MALLOC(Size:longint):pointer; pascal;
begin
 GETMEM(result,Size);
end;

procedure RTL_FREE(S:pointer); pascal;
begin
 FREEMEM(S);
end;

function RTL_FILEOPEN(FileName:BeRoString):pointer; pascal;
var S:TBeRoFileStream;
begin
 S:=TBeRoFileStream.Create(ConvertFromBeRoString(FileName));
 result:=pointer(S);
end;

function RTL_FILECREATE(FileName:BeRoString):pointer; pascal;
var S:TBeRoFileStream;
begin
 S:=TBeRoFileStream.CreateNew(ConvertFromBeRoString(FileName));
 result:=pointer(S);
end;

procedure RTL_FILECLOSE(S:pointer); pascal;
begin
 TBeRoFileStream(S).Free;
end;

function RTL_FILESEEK(S:pointer;Position:integer):integer; pascal;
begin
 result:=TBeRoFileStream(S).Seek(Position);
end;

function RTL_FILEPOSITION(S:pointer):integer; pascal;
begin
 result:=TBeRoFileStream(S).Position;
end;

function RTL_FILESIZE(S:pointer):integer; pascal;
begin
 result:=TBeRoFileStream(S).Size;
end;

function RTL_FILEEOF(S:pointer):integer; pascal;
begin
 if TBeRoFileStream(S).Position<TBeRoFileStream(S).Size then begin
  result:=0;
 end else begin
  result:=1;
 end;
end;

function RTL_FILEREAD(S,Buffer:pointer;Counter:integer):integer; pascal;
begin
 result:=TBeRoFileStream(S).read(Buffer^,Counter);
end;

function RTL_FILEWRITE(S,Buffer:pointer;Counter:integer):integer; pascal;
begin
 result:=TBeRoFileStream(S).write(Buffer^,Counter);
end;

function RTL_FILEREADLINE(S:pointer):BeRoString; pascal;
begin
 result:=ConvertToBeRoString(TBeRoFileStream(S).ReadLine);
end;

procedure RTL_FILEWRITELINE(S:pointer;Str:BeRoString); pascal;
begin
 TBeRoFileStream(S).WriteLine(ConvertFromBeRoString(Str));
end;

function RTL_GETTICKCOUNT:longword; pascal;
begin
 result:=GetTickCount();
end;

function RTL_EXEC(FileName,Parameter:BeRoString):integer; pascal;
begin
 if Ausfuehren(ConvertFromBeRoString(FileName),ConvertFromBeRoString(Parameter)) then begin
  result:=1;
 end else begin
  result:=0;
 end;
end;

function RTL_INTTOBASE(Value,Base:integer):BeRoString; pascal;
begin
 result:=ConvertToBeRoString(IntToBase(Value,Base));
end;

function RTL_INTTOHEX(Value:integer):BeRoString; pascal;
begin
 result:=ConvertToBeRoString(IntToHex(Value));
end;

function RTL_UINTTOBASE(Value,Base:longword):BeRoString; pascal;
begin
 result:=ConvertToBeRoString(LongWordToBase(Value,Base));
end;

function RTL_UINTTOHEX(Value:longword):BeRoString; pascal;
begin
 result:=ConvertToBeRoString(LongWordToHex(Value));
end;

constructor TBeRoScript.Create(TheCacheDir:string;SubCacheDir:string='BeRoScriptCache');
begin
 inherited Create;
 CacheCompression:=true;
 FastCacheCompression:=true;
 Alignment:=true;
 OutDirect:=false;
 Debug:=false;
 fOnOwnPreCode:=nil;
 fOnOwnNativesPointers:=nil;
 fOnOwnNativesDefinitions:=nil;
 CacheDir:=TheCacheDir;
 if length(CacheDir)>0 then begin
  if CacheDir[length(CacheDir)]<>'\' then CacheDir:=CacheDir+'\';
  if length(SubCacheDir)>0 then CacheDir:=CacheDir+SubCacheDir+'\';
  {$I-}MKDIR(CacheDir);{$I+}IOResult;
 end;
 LineDifference:=0;
 NameTabelle:=nil;
 TypTabelle:=nil;
 NativeTabelle:=nil;
 ImportTabelle:=nil;
 LabelFixUpTabelle:=nil;
 UseFixUpTabelle:=nil;
 ProcTabelle:=nil;
 VariableTabelle:=nil;
 Defines:=nil;
 ContinueLabel:=nil;
 BreakLabel:=nil;
 LabelArray:=nil;
 LinesInfo.PreparsedLines:=nil;
 LinesInfo.Lines:=nil;
 LinesInfo.Files:=nil;
 QuellStream:=TBeRoMemoryStream.Create;
 QuellStream.Clear;
 CodeStream:=TBeRoMemoryStream.Create;
 CodePointer:=nil;
 CodeProc:=nil;
 CodeLength:=0;
 BSSGroesse:=0;
 DynamicLinkLibrarys:=nil;
 Errors:='';
 BeginBlock:=-1;
 EndBlock:=-1;
 Blocks:=nil;
 Archive:=nil;
 Clear;
end;

destructor TBeRoScript.Destroy;
begin
 Clear;
 QuellStream.Free;
 CodeStream.Free;
 inherited Destroy;
end;

procedure TBeRoScript.ClearBlocks;
var Counter:integer;
begin
 BeginBlock:=-1;
 EndBlock:=-1;
 for Counter:=0 to length(Blocks)-1 do Blocks[Counter]:='';
 setlength(Blocks,0);
end;

procedure TBeRoScript.Clear;
var I,J:integer;
begin
 if CodePointer<>nil then begin
  VirtualFree(CodePointer,0,MEM_RELEASE);
  CodePointer:=nil;
 end;
 if assigned(NameTabelle) then begin
  for I:=0 to tnZaehler do begin
   NameTabelle[I].name:='';
   NameTabelle[I].StructName:='';
   NameTabelle[I].Proc:='';
   NameTabelle[I].AsmVarName:='';
   setlength(NameTabelle[I].Param,0);
  end;
  setlength(NameTabelle,0);
 end;
 if assigned(TypTabelle) then begin
  for I:=0 to ttZaehler-1 do begin
   TypTabelle[I].name:='';
   setlength(TypTabelle[I].Variable,0);
   setlength(TypTabelle[I].Extends,0);
   setlength(TypTabelle[I].ExtendsOffsets,0);
  end;
  setlength(TypTabelle,0);
 end;
 if assigned(NativeTabelle) then begin
  for I:=0 to tnpZaehler-1 do begin
   NativeTabelle[I].name:='';
   NativeTabelle[I].AsmVarName:='';
  end;
  setlength(NativeTabelle,0);
 end;
 if assigned(ImportTabelle) then begin
  for I:=0 to length(ImportTabelle)-1 do begin
   ImportTabelle[I].name:='';
   ImportTabelle[I].AsmVarName:='';
   ImportTabelle[I].LibraryName:='';
   ImportTabelle[I].LibraryFunction:='';
  end;
  setlength(ImportTabelle,0);
 end;
 if assigned(LabelFixUpTabelle) then begin
  for I:=0 to length(LabelFixUpTabelle)-1 do LabelFixUpTabelle[I].name:='';
  setlength(LabelFixUpTabelle,0);
 end;
 if assigned(UseFixUpTabelle) then begin
  for I:=0 to length(UseFixUpTabelle)-1 do UseFixUpTabelle[I].name:='';
  setlength(UseFixUpTabelle,0);
 end;
 if assigned(ProcTabelle) then begin
  for I:=0 to length(ProcTabelle)-1 do ProcTabelle[I].name:='';
  setlength(ProcTabelle,0);
 end;
 if assigned(VariableTabelle) then begin
  for I:=0 to length(VariableTabelle)-1 do VariableTabelle[I].name:='';
  setlength(VariableTabelle,0);
 end;
 if assigned(Defines) then begin
  for I:=0 to length(Defines)-1 do begin
   Defines[I].name:='';
   Defines[I].Lines:='';
   for J:=0 to length(Defines[I].Parameter)-1 do Defines[I].Parameter[J]:='';
   setlength(Defines[I].Parameter,0);
  end;
  setlength(Defines,0);
 end;
 if assigned(LabelArray) then begin
  for I:=0 to length(LabelArray)-1 do LabelArray[I]:='';
  setlength(LabelArray,0);
 end;
 if assigned(DynamicLinkLibrarys) then begin
  for I:=0 to length(DynamicLinkLibrarys)-1 do DynamicLinkLibrarys[I].Free;
  setlength(DynamicLinkLibrarys,0);
 end;
 if assigned(LinesInfo.PreparsedLines) then begin
  setlength(LinesInfo.PreparsedLines,0);
 end;
 if assigned(LinesInfo.Lines) then begin
  setlength(LinesInfo.Lines,0);
 end;
 if assigned(LinesInfo.Files) then begin
  for I:=0 to length(LinesInfo.Files)-1 do LinesInfo.Files[I]:='';
  setlength(LinesInfo.Files,0);
 end;
 ClearBlocks;
 IsCompiled:=false;
 Output:='';
 tnZaehler:=0;
 ttZaehler:=0;
 tnpZaehler:=0;
 tnSubZaehler:=0;
 CodeStream.Clear;
 CodePointer:=nil;
 CodeProc:=nil;
 CodeLength:=0;
 BSSGroesse:=0;
 CodeFileName:='';
 CodeName:='';
 SourceChecksumme:=0;
 IsTermSigned:=false;
 Fehler:=false;
end;

function TBeRoScript.MTRIM(S:string):string;
var StartPos,Laenge:integer;
begin
 Laenge:=length(S);
 if Laenge>0 then begin
  while (Laenge>0) and (S[Laenge] in [#0..#32]) do dec(Laenge);
  StartPos:=1;
  while (StartPos<=Laenge) and (S[StartPos] in [#0..#32]) do inc(StartPos);
  result:=COPY(S,StartPos,Laenge-StartPos+1);
 end else begin
  result:='';
 end;
end;

function TBeRoScript.MUPPERCASE(S:string):string;
var I,L:integer;
begin
 result:='';
 L:=length(S);
 I:=1;
 while I<=L do begin
  if S[I] in ['a'..'z'] then begin
   result:=result+char(byte(S[I])-32);
  end else begin
   result:=result+S[I];
  end;
  inc(I);
 end;
end;

function TBeRoScript.MeinePosition(Wo,Was:string;AbWo:integer):integer;
var I,K,J,H,G,L,O,M,N:integer;
 procedure Checken;
 begin
  if (J>0) and (J<=length(Wo)) then if Wo[J] in ['A'..'Z','a'..'z','0'..'9','_'] then L:=0;
 end;
begin
 O:=0;
 if AbWo<1 then begin
  I:=1;
 end else begin
  I:=AbWo;
 end;
 M:=length(Was);
 N:=length(Wo);
 K:=N-M+1;
 while I<=K do begin
  J:=I;
  H:=J+M;
  G:=1;
  L:=0;
  while (J<H) and (J<=length(Wo)) and (G<=length(Was)) do begin
   if Wo[J]=Was[G] then begin
    inc(L);
   end else begin
    break;
   end;
   inc(J);
   inc(G);
  end;
  if L<>M then L:=0;
  if L>0 then begin
   J:=I-1;
   if J>0 then Checken;
   J:=H;
   if J<=N then Checken;
   if L>0 then begin
    O:=I;
    break;
   end;
  end;
  inc(I);
 end;
 result:=O;
end;

function TBeRoScript.StringErsetzen(Wo,Von,Mit:string):string;
var I,J:integer;
    N,M:string;
    Ok:boolean;
begin
 result:='';
 Ok:=true;
 N:=Wo;
 J:=1;
 while Ok do begin
  Ok:=false;
  I:=MeinePosition(N,Von,J);
  if I>0 then begin
   M:=COPY(N,1,I-1);
   M:=M+Mit;
   M:=M+COPY(N,I+length(Von),length(N)-I-length(Von)+1);
   N:=M;
   J:=I+length(Mit);
   if J<1 then J:=1;
   Ok:=true;
  end;
 end;
 if MUPPERCASE(N)<>'' then result:=N;
end;

procedure TBeRoScript.CompilerCreate;
begin
 Init;
 GeneratiereLabelNr:=0;
 AsmVarNr:=0;
 SBuf:='';
end;

procedure TBeRoScript.IncLevel;
begin
 inc(Level);
 setlength(BreakLabel,Level+1);
 setlength(ContinueLabel,Level+1);
end;

procedure TBeRoScript.DecLevel;
begin
 BreakLabel[Level]:='';
 ContinueLabel[Level]:='';
 dec(Level);
 setlength(BreakLabel,Level+1);
 setlength(ContinueLabel,Level+1);
end;

procedure TBeRoScript.SetError(err:integer);
var S,Zeile,Spalte,Datei:string;
    Line,LineNumber,FileIndex:integer;
begin
 case err of
  ceUndefErr:S:='Unknown error';
  ceLParenExp:S:='''('' expected';
  ceRParenExp:S:=''')'' expected';
  ceThenExp:S:='THEN expected';
  ceErrInExpr:S:='Error in expression';
  ceExpectEql:S:='''=='' expected';
  ceExpectSet:S:='''='' expected';
  ceUnexpectedEOF:S:='Unexpected file END';
  ceVarNotDef:S:='Variable not defined';
  ceVarDoppelDefiniert:S:='Variable already defined';
  ceZahlenWertErwartet:S:='Number value expected';
  ceKRParentErwartet:S:=''']'' expected';
  ceKeinArray:S:='Variable isn''t a array';
  ceBezeichnerErwartet:S:='Identifier expected';
  ceFuncParamDefFehler:S:='Error in function parameter definition';
  ceFuncParamNumFehler:S:='Invalid function parameters';
  ceFuncParamSetError:S:='Invalid function parameters';
  ceWhileErwartet:S:='''WHILE'' expected';
  ceSemiColonErwartet:S:=''';'' expected';
  ceBeginErwartet:S:='''{'' expected';
  ceEndErwartet:S:='''}'' expected';
  ceNativeProcNichtGefunden:S:='Native function/procedure not found';
  ceNativeProcIsNull:S:='Native function/procedure is a null pointer';
  ceCaseErwartet:S:='''case'' expected';
  ceDoppelPunktErwartet:S:=''':'' expected';
  ceFixUpFehler:S:='Code fix up error';
  ceStructNotDefined:S:='Struct not defined';
  ceTypeExpected:S:='Type expected';
  ceNotStruct:S:='No struct';
  ceWrongType:S:='Wrong type';
  ceFloatTypeExpected:S:='Float type expected';
  ceFloatOperationError:S:='Invalid float operation';
  ceFloatInHexError:S:='A float number cann''t be heximal';
  cePreprocessorError:S:='Preprocessor error';
  ceLabelDoppelDefiniert:S:='Label already defined';
  ceLabelNotFound:S:='Label not found';
  ceLabelNameVariableDefiniert:S:='Label name as a variable already defined';
  ceENumAlreadyDefined:S:='enum already defined';
  ceENumStructAlreadyUsed:S:='enum object name already used';
  ceStringTypeExpected:S:='string type expected';
  ceStringExpected:S:='string expected';
  ceIllegalStringOperation:S:='Illegal string operation';
  ceStructExpected:S:='Struct expected';
  ceIllegalStructOperation:S:='Illegal struct operation';
  ceStructOrUnionOrObjectStatementExpected:S:='Struct, union or object statement expected';
  ceStructOrUnionOrObjectDoppelDefiniert:S:='Struct, union or object already defined';
  ceOnlyInMethodAllowed:S:='Only in a method allowed';
  ceNoInheritedCallPossible:S:='No inherited call possible';
  ceCommaExp:S:=''','' expected';
  ceImportProcNichtGefunden:S:='Import function/procedure not found';
  ceImportProcIsNull:S:='Import function/procedure is a null pointer';
  else S:='Unknown error';
 end;
 if QuelltextZeile<LineDifference then begin
  STR(QuelltextZeile+LineDifference,Zeile);
  STR(QuelltextSpalte,Spalte);
  Errors:=Errors+'OwnPreCode('+Zeile+','+Spalte+')';
 end else if QuelltextZeile=LineDifference then begin
  STR(QuelltextZeile+LineDifference,Zeile);
  STR(QuelltextSpalte,Spalte);
  Errors:=Errors+'NativePart('+Zeile+','+Spalte+')';
 end else if QuelltextZeile>LineDifference then begin
  Line:=QuelltextZeile-LineDifference;
  if Line<length(LinesInfo.Lines) then begin
   LineNumber:=LinesInfo.Lines[Line].LineNumber;
   FileIndex:=LinesInfo.Lines[Line].FileIndex;
   if FileIndex<length(LinesInfo.Files) then begin
    Datei:=LinesInfo.Files[FileIndex];
   end else begin
    Datei:='-';
   end;
   STR(LineNumber,Zeile);
   STR(QuelltextSpalte,Spalte);
   Errors:=Errors+'['+Datei+']('+Zeile+','+Spalte+')';
  end else begin
   Errors:=Errors+'[?]';
  end;
 end;
 Errors:=Errors+' Error: '+S+#13#10;
 ferror:=true;
end;

procedure TBeRoScript.ByteHinzufuegen(B:byte);
begin
 CodeStream.write(B,sizeof(byte));
end;

procedure TBeRoScript.WordHinzufuegen(W:word);
begin
 CodeStream.write(W,sizeof(word));
end;

procedure TBeRoScript.DWordHinzufuegen(DW:longword);
begin
 CodeStream.write(DW,sizeof(longword));
end;

procedure TBeRoScript.ProcHinzufuegen(S,SO:string);
var I:integer;
begin
 I:=length(ProcTabelle);
 setlength(ProcTabelle,I+1);
 if length(SO)>0 then begin
  ProcTabelle[I].name:=SO+'.'+S;
 end else begin
  ProcTabelle[I].name:=S;
 end;
 ProcTabelle[I].Offset:=CodeStream.Position;
end;

procedure TBeRoScript.VariableHinzufuegen(S,SO:string);
var I:integer;
begin
 I:=length(VariableTabelle);
 setlength(VariableTabelle,I+1);
 if length(SO)>0 then begin
  VariableTabelle[I].name:=SO+'.'+S;
 end else begin
  VariableTabelle[I].name:=S;
 end;
 VariableTabelle[I].Offset:=CodeStream.Position;
end;

procedure TBeRoScript.DifferenzLabelFixUpHinzufuegen(S:string);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutAbsolut;
 UseFixUpTabelle[I].name:=S;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.JumpLabelFixUpHinzufuegen(S:string);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutJump;
 UseFixUpTabelle[I].name:=S;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.LabelFixUpHinzufuegen(S:string;Offset:longint);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutAbsolut;
 UseFixUpTabelle[I].name:=S;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=Offset;
end;

procedure TBeRoScript.LabelAdresseHinzufuegen(S:string);
begin
 LabelFixUpHinzufuegen(S,0);
 DWordHinzufuegen(0);
end;

procedure TBeRoScript.LabelAdresseOffsetHinzufuegen(S:string;Offset:longint);
begin
 LabelFixUpHinzufuegen(S,Offset);
 DWordHinzufuegen(0);
end;

procedure TBeRoScript.LabelHinzufuegen(S:string);
var I:integer;
begin
 I:=length(LabelFixUpTabelle);
 setlength(LabelFixUpTabelle,I+1);
 LabelFixUpTabelle[I].name:=S;
 LabelFixUpTabelle[I].Offset:=CodeStream.Position;
end;

procedure TBeRoScript.NativeFixUpHinzufuegen(NativeName:string);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutNative;
 UseFixUpTabelle[I].name:=NativeName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.NativeRelativeFixUpHinzufuegen(NativeName:string);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutNativeRelative;
 UseFixUpTabelle[I].name:=NativeName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.ImportFixUpHinzufuegen(ImportName:string);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutImport;
 UseFixUpTabelle[I].name:=ImportName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.ImportRelativeFixUpHinzufuegen(ImportName:string);
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutImportRelative;
 UseFixUpTabelle[I].name:=ImportName;
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.ClassPointerFixUpHinzufuegen;
var I:integer;
begin
 I:=length(UseFixUpTabelle);
 setlength(UseFixUpTabelle,I+1);
 UseFixUpTabelle[I].Typ:=tufutClassPointer;
 UseFixUpTabelle[I].name:='';
 UseFixUpTabelle[I].Offset:=CodeStream.Position;
 UseFixUpTabelle[I].AddOffset:=0;
end;

procedure TBeRoScript.CodeFixen(CodeOffset:longword);
var I,J,L,K,M,N,O:integer;
    LibraryStream:TBeRoStream;
    Proc:pointer;
begin
 for I:=0 to length(UseFixUpTabelle)-1 do begin
  if UseFixUpTabelle[I].Typ=tufutClassPointer then begin
   CodeStream.Seek(UseFixUpTabelle[I].Offset);
   DWordHinzufuegen(longword(pointer(self)));
  end else if UseFixUpTabelle[I].Typ in [tufutNative,tufutNativeRelative] then begin
   K:=-1;
   for J:=0 to length(NativeTabelle)-1 do begin
    if UseFixUpTabelle[I].name=NativeTabelle[J].name then begin
     K:=J;
     break;
    end;
   end;
   if K>=0 then begin
    if NativeTabelle[K].Proc=nil then begin
     SetError(ceNativeProcIsNull);
     continue;
    end;
    CodeStream.Seek(UseFixUpTabelle[I].Offset);
    case UseFixUpTabelle[I].Typ of
     tufutNative:DWordHinzufuegen(longword(NativeTabelle[K].Proc));
     tufutNativeRelative:begin
      L:=longint(NativeTabelle[K].Proc)-(UseFixUpTabelle[I].Offset+longint(CodeOffset))-4;
      DWordHinzufuegen(longword(L));
     end;
    end;
   end else begin
    SetError(ceFixUpFehler);
   end;
  end else if UseFixUpTabelle[I].Typ in [tufutImport,tufutImportRelative] then begin
   K:=-1;
   for J:=0 to length(ImportTabelle)-1 do begin
    if UseFixUpTabelle[I].name=ImportTabelle[J].name then begin
     K:=J;
     break;
    end;
   end;
   if K>=0 then begin
    Proc:=nil;
    if (length(ImportTabelle[K].LibraryName)>0) and (length(ImportTabelle[K].LibraryFunction)>0) then begin
     M:=LookDLL(ImportTabelle[K].LibraryName);
     if M<0 then begin
      M:=length(DynamicLinkLibrarys);
      setlength(DynamicLinkLibrarys,M+1);
      DynamicLinkLibrarys[M]:=TDynamicLinkLibrary.Create(ImportTabelle[K].LibraryName);
      if not DynamicLinkLibrarys[M].LoadFile(ImportTabelle[K].LibraryName) then begin
       if assigned(Archive) then begin
        LibraryStream:=TBeRoMemoryStream.Create;
        Archive.Extract(ImportTabelle[K].LibraryName,LibraryStream);
        if not DynamicLinkLibrarys[M].Load(LibraryStream) then begin
         LibraryStream.Free;
         SetError(ceFixUpFehler);
         continue;
        end else begin
         LibraryStream.Free;
        end;
       end else begin
        SetError(ceFixUpFehler);
       end;
      end;
     end;
     Proc:=DynamicLinkLibrarys[M].FindExport(ImportTabelle[K].LibraryFunction);
     if Proc=nil then begin
      SetError(ceFixUpFehler);
      continue;
     end;
    end else begin
     SetError(ceFixUpFehler);
     continue;
    end;
    if Proc=nil then begin
     SetError(ceImportProcIsNull);
     continue;
    end;
    CodeStream.Seek(UseFixUpTabelle[I].Offset);
    case UseFixUpTabelle[I].Typ of
     tufutImport:DWordHinzufuegen(longword(Proc));
     tufutImportRelative:begin
      L:=longint(Proc)-(UseFixUpTabelle[I].Offset+longint(CodeOffset))-4;
      DWordHinzufuegen(longword(L));
     end;
    end;
   end else begin
    SetError(ceFixUpFehler);
   end;
  end else begin
   K:=-1;
   Proc:=nil;
   O:=LookImport(UseFixUpTabelle[I].name);
   if O>=0 then begin
    if (length(ImportTabelle[O].LibraryName)>0) and (length(ImportTabelle[O].LibraryFunction)>0) then begin
     M:=LookDLL(ImportTabelle[O].LibraryName);
     if M<0 then begin
      M:=length(DynamicLinkLibrarys);
      setlength(DynamicLinkLibrarys,M+1);
      DynamicLinkLibrarys[M]:=TDynamicLinkLibrary.Create(ImportTabelle[O].LibraryName);
      if not DynamicLinkLibrarys[M].LoadFile(ImportTabelle[O].LibraryName) then begin
       if assigned(Archive) then begin
        LibraryStream:=TBeRoMemoryStream.Create;
        Archive.Extract(ImportTabelle[K].LibraryName,LibraryStream);
        if not DynamicLinkLibrarys[M].Load(LibraryStream) then begin
         LibraryStream.Free;
         SetError(ceFixUpFehler);
         continue;
        end else begin
         LibraryStream.Free;
        end;
       end else begin
        SetError(ceFixUpFehler);
       end;
      end;
     end;
     Proc:=DynamicLinkLibrarys[M].FindExport(ImportTabelle[O].LibraryFunction);
     if Proc=nil then begin
      SetError(ceFixUpFehler);
      continue;
     end;
    end else begin
     SetError(ceFixUpFehler);
     continue;
    end;
   end else begin
    O:=LookNative(UseFixUpTabelle[I].name);
    if O>=0 then begin
     Proc:=NativeTabelle[I].Proc;
    end else begin
     for J:=0 to length(LabelFixUpTabelle)-1 do begin
      if UseFixUpTabelle[I].name=LabelFixUpTabelle[J].name then begin
       K:=LabelFixUpTabelle[J].Offset;
       break;
      end;
     end;
    end;
   end;
   if (K<0) and assigned(Proc) then K:=longword(Proc)-CodeOffset;
   if K>=0 then begin
    case UseFixUpTabelle[I].Typ of
     tufutDifferenz:begin
      L:=K-UseFixUpTabelle[I].Offset+UseFixUpTabelle[I].AddOffset;
      CodeStream.Seek(UseFixUpTabelle[I].Offset);
      DWordHinzufuegen(longword(L));
     end;
     tufutAbsolut:begin
      L:=K+UseFixUpTabelle[I].AddOffset;
      CodeStream.Seek(UseFixUpTabelle[I].Offset);
      DWordHinzufuegen(longword(L)+CodeOffset);
     end;
     tufutJump:begin
      L:=K-UseFixUpTabelle[I].Offset-4+UseFixUpTabelle[I].AddOffset;
      CodeStream.Seek(UseFixUpTabelle[I].Offset);
      DWordHinzufuegen(longword(L));
     end;
    end;
   end else begin
    SetError(ceFixUpFehler);
   end;
  end;
 end;
 for I:=0 to length(ProcTabelle)-1 do begin
  inc(ProcTabelle[I].Offset,CodeOffset);
 end;
 for I:=0 to length(VariableTabelle)-1 do begin
  inc(VariableTabelle[I].Offset,CodeOffset);
 end;
 CodeStream.Seek(CodeStream.Size);
end;

procedure TBeRoScript.CallLabel(S:string);
begin
 ByteHinzufuegen($e8);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
end;

procedure TBeRoScript.JZLabel(S:string);
begin
 ByteHinzufuegen($0f);
 ByteHinzufuegen($84);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
end;

procedure TBeRoScript.JNZLabel(S:string);
begin
 ByteHinzufuegen($0f);
 ByteHinzufuegen($85);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
end;

procedure TBeRoScript.JumpLabel(S:string);
begin
 ByteHinzufuegen($e9);
 JumpLabelFixUpHinzufuegen(S);
 DWordHinzufuegen(0);
end;

function TBeRoScript.GeneratiereLabel:string;
var S:string;
begin
 STR(GeneratiereLabelnr,S);
 result:='GL@'+S;
 inc(GeneratiereLabelnr);
end;

function TBeRoScript.AsmVar:string;
var S:string;
begin
 STR(AsmVarNr,S);
 result:='AV@'+S;
 inc(AsmVarNr);
end;

function TBeRoScript.GetLabelName(S:string):string;
begin
 result:='UL!'+AktProcName+'@'+S;
end;

function TBeRoScript.GetStructTempVariableName(TypLink:integer):string;
var S,A:string;
    Adr:TWert;
begin
 S:='STVN!'+AktProcName+'@'+TypTabelle[TypLink].name+'?'+GeneratiereLabel;
 if not LockVar(S,'',A,Adr,false,-1) then begin
  adr:=AddObjekt(S,'',_ident,tType,0,0,aLokal,false,false,TypLink,0);
 end;
 result:=S;
end;

function TBeRoScript.GetObjectTempVariableName(TypLink:integer):string;
var S,A:string;
    Adr:TWert;
begin
 S:='OBJTEMP?'+GeneratiereLabel;
 if not LockVar(S,'',A,Adr,false,-1) then begin
  adr:=AddObjekt(S,'',_ident,tType,0,0,aLokal,true,false,TypLink,0);
 end;
 result:=S;
end;

function TBeRoScript.GetStringTempVariableName(Nummer:integer):string;
var S,A:string;
    Adr:TWert;
begin
 S:='TEMPSTR!'+AktProcName+'@'+INTTOSTR(Nummer)+'?'+GeneratiereLabel;
 if not LockVar(S,'',A,Adr,false,-1) then begin
  adr:=AddObjekt(S,'',_ident,tString,0,0,aLokal,false,false,0,0);
  OutPushAx;
  OutXorAxAx;
  OutMovVarAx(S,0,false,false);
  OutPopAx;
 end;
 result:=S;
end;

function TBeRoScript.GetStringLevelVariableName:string;
var S,A:string;
    Adr:TWert;
begin
 S:='TEMPLEVELSTR!'+AktProcName+'@'+INTTOSTR(StringLevel)+'?'+GeneratiereLabel;
 if not LockVar(S,'',A,Adr,false,-1) then begin
  adr:=AddObjekt(S,'',_ident,tString,0,0,aLokal,false,false,0,0);
  OutPushAx;
  OutXorAxAx;
  OutMovVarAx(S,0,false,false);
  OutPopAx;
 end;
 result:=S;
end;

function TBeRoScript.GetStringVariableName:string;
var S,A:string;
    Adr:TWert;
begin
 S:='STRTEMP!'+AktProcName+'?'+GeneratiereLabel;
 if not LockVar(S,'',A,Adr,false,-1) then begin
  adr:=AddObjekt(S,'',_ident,tString,0,0,aLokal,false,false,0,0);
  OutPushAx;
  OutXorAxAx;
  OutMovVarAx(S,0,false,false);
  OutPopAx;
 end;
 result:=S;
end;

function TBeRoScript.AddObjekt(name,StructName:string;Obj:byte;Typ:TTyp;Adr:TWert;ArrayDim:integer;Art:TArt;Zeiger,InTyp:boolean;TypLink,Wert:integer):word;
var A,B:integer;
begin
 inc(tnZaehler);
 setlength(NameTabelle,tnZaehler+1);
 NameTabelle[tnZaehler].name:=name;
 NameTabelle[tnZaehler].StructName:=StructName;
 NameTabelle[tnZaehler].Proc:=AktProcName;
 NameTabelle[tnZaehler].AsmVarName:='';
 if Obj in [_ident,_call,_type] then NameTabelle[tnZaehler].AsmVarName:=AsmVar;
 NameTabelle[tnZaehler].Obj:=Obj;
 NameTabelle[tnZaehler].Typ:=Typ;
 NameTabelle[tnZaehler].TypLink:=TypLink;
 NameTabelle[tnZaehler].InTypLink:=-1;
 NameTabelle[tnZaehler].Zeiger:=Zeiger;
 NameTabelle[tnZaehler].IstArray:=ArrayDim<>0;
 NameTabelle[tnZaehler].ArrayDim:=ArrayDim;
 NameTabelle[tnZaehler].storage:=0;
 NameTabelle[tnZaehler].StackPtr:=0;
 NameTabelle[tnZaehler].symptr:=0;
 NameTabelle[tnZaehler].StackAlloc:=0;
 NameTabelle[tnZaehler].Bytes2Pass:=0;
 NameTabelle[tnZaehler].ProcNr:=-1;
 NameTabelle[tnZaehler].ParamNum:=0;
 NameTabelle[tnZaehler].ShadowParamNum:=0;
 NameTabelle[tnZaehler].TotalParamNum:=0;
 NameTabelle[tnZaehler].SubNum:=0;
 NameTabelle[tnZaehler].Size:=0;
 NameTabelle[tnZaehler].BTyp:=-1;
 NameTabelle[tnZaehler].Feld_Offset:=0;
 NameTabelle[tnZaehler].native:=false;
 NameTabelle[tnZaehler].import:=false;
 NameTabelle[tnZaehler].isstdcall:=false;
 NameTabelle[tnZaehler].EinTyp:=TypLink>=0;
 NameTabelle[tnZaehler].InTyp:=InTyp;
 NameTabelle[tnZaehler].Art:=Art;
 NameTabelle[tnZaehler].Param:=nil;
 NameTabelle[tnZaehler].Wert:=Wert;
 A:=NameTabelle[tnZaehler].ArrayDim;
 if A=0 then A:=1;
 VarSize:=0;
 B:=0;
 case Obj of
  _ident:begin
   Adr:=DP;
   inc(DP,sizeof(TWert));
   NameTabelle[tnZaehler].Adr:=Adr;
   if NameTabelle[tnZaehler].Zeiger then begin
    NameTabelle[tnZaehler].Size:=4;
   end else begin
    case NameTabelle[tnZaehler].Typ of
     tuChar,tChar,tByte,tuByte:NameTabelle[tnZaehler].Size:=1;
     tuShortInt,tShortInt:NameTabelle[tnZaehler].Size:=2;
     tuInt,tInt,tFloat,tString,tVoid:NameTabelle[tnZaehler].Size:=4;
     tType:NameTabelle[tnZaehler].Size:=TypTabelle[TypLink].Size;
    end;
   end;
   VarSize:=NameTabelle[tnZaehler].Size;
   if (AktProc>=0) and (NameTabelle[tnZaehler].Art=aLokal) and not InTyp then begin
    if NameTabelle[tnZaehler].Zeiger then begin
     inc(NameTabelle[AktProc].StackAlloc,4);
    end else begin
     case NameTabelle[tnZaehler].Typ of
      tuChar,tChar,tByte,tuByte:B:=A;
      tuShortInt,tShortInt:B:=2*A;
      tuInt,tInt,tFloat,tString,tVoid:B:=4*A;
      tType:B:=TypTabelle[TypLink].Size*A;
     end;
     if Alignment then if (B mod 4)<>0 then B:=B+(4-(B mod 4));
     inc(NameTabelle[AktProc].StackAlloc,B);
    end;
    NameTabelle[tnZaehler].StackPtr:=NameTabelle[AktProc].StackAlloc;
   end;
   if (AktProc>=0) and (NameTabelle[tnZaehler].Art in [aParam,aShadowParam]) and not InTyp then begin
    NameTabelle[tnZaehler].ProcNr:=AktProc;
    inc(NameTabelle[AktProc].TotalParamNum);
    case NameTabelle[tnZaehler].Art of
     aParam:inc(NameTabelle[AktProc].ParamNum);
     aShadowParam:inc(NameTabelle[AktProc].ShadowParamNum);
    end;
    if NameTabelle[tnZaehler].Zeiger then begin
     inc(NameTabelle[tnZaehler].Bytes2Pass,4);
    end else begin
     case NameTabelle[tnZaehler].Typ of
      tuChar,tChar,tByte,tuByte:B:=A;
      tuShortInt,tShortInt:B:=2*A;
      tuInt,tInt,tFloat,tString,tVoid:B:=4*A;
      tType:B:=TypTabelle[TypLink].Size*A;
     end;
     if Alignment then if (B mod 4)<>0 then B:=B+(4-(B mod 4));
     inc(NameTabelle[tnZaehler].Bytes2Pass,B);
    end;
    inc(NameTabelle[AktProc].Bytes2Pass,NameTabelle[tnZaehler].Bytes2Pass);
    NameTabelle[tnZaehler].StackPtr:=NameTabelle[AktProc].Bytes2Pass;
    setlength(NameTabelle[AktProc].Param,NameTabelle[AktProc].TotalParamNum);
    NameTabelle[AktProc].Param[NameTabelle[AktProc].TotalParamNum-1]:=tnZaehler;
   end;
   if NameTabelle[tnZaehler].Art=aStructVar then begin
    NameTabelle[tnZaehler].InTypLink:=ttZaehler;
    inc(TypTabelle[ttZaehler].VariableNum);
    if NameTabelle[tnZaehler].Zeiger then begin
     inc(TypTabelle[ttZaehler].StackAlloc,4);
     inc(TypTabelle[ttZaehler].Size,4);
     inc(TypTabelle[ttZaehler].Bytes2Pass,4);
    end else begin
     case NameTabelle[tnZaehler].Typ of
      tuChar,tChar,tByte,tuByte:B:=A;
      tuShortInt,tShortInt:B:=2*A;
      tuInt,tInt,tFloat,tString,tVoid:B:=4*A;
      tType:B:=TypTabelle[TypLink].Size*A;
     end;
     if Alignment and not TypTabelle[ttZaehler].IsPacked then begin
      if (B mod 4)<>0 then begin
       B:=B+(4-(B mod 4));
      end;
     end;
     inc(NameTabelle[tnZaehler].Bytes2Pass,B);
     NameTabelle[tnZaehler].StackPtr:=NameTabelle[tnZaehler].Bytes2Pass;
     inc(TypTabelle[ttZaehler].StackAlloc,NameTabelle[tnZaehler].Bytes2Pass);
     inc(TypTabelle[ttZaehler].Size,NameTabelle[tnZaehler].Bytes2Pass);
     inc(TypTabelle[ttZaehler].Bytes2Pass,NameTabelle[tnZaehler].Bytes2Pass);
    end;
    NameTabelle[tnZaehler].StackPtr:=TypTabelle[ttZaehler].Bytes2Pass;
    setlength(TypTabelle[ttZaehler].Variable,TypTabelle[ttZaehler].VariableNum);
    TypTabelle[ttZaehler].Variable[TypTabelle[ttZaehler].VariableNum-1]:=tnZaehler;
   end;
  end;
  _keyword:NameTabelle[tnZaehler].Tok:=byte(Adr);
  _call:begin
   Adr:=0;
   NameTabelle[tnZaehler].Adr:=Adr;
  end;
 end;
 result:=Adr;
end;

function TBeRoScript.Find(name,StructName:string;Ident:boolean;var ENT:TNameTabelleEintrag;var SymNr:integer;TypLink:integer):boolean;
var B:boolean;
 function MeinFind(MeineProc:string):boolean;
 var I,J:longword;
     c:boolean;
 begin
  result:=true;
  J:=0;
  for I:=1 to tnZaehler do begin
   if Ident then begin
    if NameTabelle[I].Obj in [_ident,_call,_enumstruct,_enumvalue,_labelident] then begin
     c:=true;
    end else begin
     c:=false;
    end;
   end else begin
    c:=true;
   end;
   if (NameTabelle[I].name=name) and (NameTabelle[I].StructName=StructName) then begin
    if NameTabelle[I].Art in [aParam,aShadowParam] then begin
     if NameTabelle[I].ProcNr<>AktProc then begin
      continue;
     end;
    end;
    if not NameTabelle[I].InTyp then begin
     if MTRIM(NameTabelle[I].Proc)=MeineProc then begin
      if c then begin
       J:=I;
       SymNr:=J;
       break;
      end;
     end;
    end;
   end;
  end;
  ENT:=NameTabelle[J];
  if J=0 then result:=false;
 end;
 function TypFind:boolean;
 var I,J:longword;
     c:boolean;
 begin
  result:=true;
  J:=0;
  for I:=tnZaehler downto 1 do begin
   if Ident then begin
    if NameTabelle[I].Obj in [_ident,_call,_enumstruct,_enumvalue,_labelident] then begin
     c:=true;
    end else begin
     c:=false;
    end;
   end else begin
    c:=true;
   end;
   if (NameTabelle[I].name=name) and (NameTabelle[I].StructName=StructName) and (NameTabelle[I].InTypLink=TypLink) then begin
    if NameTabelle[I].Art in [aParam,aShadowParam] then begin
     if NameTabelle[I].ProcNr<>AktProc then begin
      continue;
     end;
    end;
    if NameTabelle[I].BTyp=TypLink then begin
     if c then begin
      J:=I;
      SymNr:=J;
      break;
     end;
    end;
   end;
  end;
  ENT:=NameTabelle[J];
  if J=0 then result:=false;
 end;
begin
 SymNr:=0;
 NameTabelle[0].name:='';
 NameTabelle[0].StructName:='';
 NameTabelle[0].Proc:='';
 if TypLink>=0 then begin
  result:=TypFind;
 end else if length(MTRIM(AktProcName))>0 then begin
  B:=MeinFind(MTRIM(AktProcName));
  if not B then B:=MeinFind('');
  result:=B;
 end else begin
  result:=MeinFind('');
 end;
end;

function TBeRoScript.LockKey(name:string):byte;
var ENT:TNameTabelleEintrag;
    I:integer;
begin
 LockKey:=_ident;
 if Find(name,'',false,ENT,I,-1) then begin
  if ENT.Obj=_keyword then LockKey:=ENT.Tok;
  if ENT.Obj in [_call,_enumstruct,_enumvalue,_labelident] then LockKey:=ENT.Obj;
 end;
end;

function TBeRoScript.LockVar(name,StructName:string;var AsmVarName:string;var Adr:TWert;define:boolean;TypLink:integer):boolean;
var ENT:TNameTabelleEintrag;
    B:boolean;
    I:integer;
begin
 AktSymPtr:=-1;
 B:=Find(name,StructName,true,ENT,I,TypLink);
 if (I>=0) and (I<=tnZaehler) then AktSymPtr:=I;
 if define then begin
  if (length(MTRIM(ENT.Proc))=0) and (length(MTRIM(AktProcName))<>0) then begin
   result:=false;
  end else begin
   result:=B;
  end;
 end else begin
  result:=B;
 end;
 Adr:=ENT.Adr;
 AsmVarName:=ENT.AsmVarName;
 AktTyp:=ENT.Typ;
end;

procedure TBeRoScript.OutJmp(S:string);
begin
 JumpLabel(S);
end;

procedure TBeRoScript.OutLabel(S:string);
begin
 LabelHinzufuegen(S);
end;

procedure TBeRoScript.OutRet;
begin
{IF inmain THEN BEGIN
  JumpLabel('C_exit');
 END ELSE BEGIN}
  OutRetEx;
{END;}
end;

procedure TBeRoScript.OutRetEx;
begin
 ByteHinzufuegen($c3);
end;

procedure TBeRoScript.OutRetValue(I:longword);
begin
 if I=0 then begin
  OutRetEx;
 end else if I<=$ffff then begin
  ByteHinzufuegen($c2);
  WordHinzufuegen(I);
 end else begin
  OutAddESP(I);
  OutRetEx;
 end;
end;

procedure TBeRoScript.OutOutputBlock;
begin
 UseOutputBlock:=true;
 CallLabel('C_OutputBlock');
end;

procedure TBeRoScript.OutWrtAXSigned;
begin
 UseWrtAXSigned:=true;
 CallLabel('C_WRITENUMSIGNED');
 ByteHinzufuegen($31); ByteHinzufuegen($c0); // XOR EAX,EAX
 ByteHinzufuegen($31); ByteHinzufuegen($db); // XOR EBX,EBX
end;

procedure TBeRoScript.OutWrtAXUnsigned;
begin
 UseWrtAXUnsigned:=true;
 CallLabel('C_WRITENUMUNSIGNED');
 ByteHinzufuegen($31); ByteHinzufuegen($c0); // XOR EAX,EAX
 ByteHinzufuegen($31); ByteHinzufuegen($db); // XOR EBX,EBX
end;

procedure TBeRoScript.OutWrtFloatAX;
begin
 UseWrtFloat:=true;
 CallLabel('C_PrintFloat');
 ByteHinzufuegen($31); ByteHinzufuegen($c0); // XOR EAX,EAX
 ByteHinzufuegen($31); ByteHinzufuegen($db); // XOR EBX,EBX
end;

procedure TBeRoScript.OutWrtStr;
begin
 UseWrtSTR:=true;
 CallLabel('C_PrintString');
end;

procedure TBeRoScript.OutWrtPCharString;
begin
 UseWrtPCharString:=true;
 CallLabel('C_PrintPCharString');
end;

procedure TBeRoScript.OutWrtChar;
begin
 UseWrtChar:=true;
 CallLabel('C_PrintChar');
end;

procedure TBeRoScript.OutStrNew;
begin
 UseStrNew:=true;
 CallLabel('C_StrNew');
end;

procedure TBeRoScript.OutStrIncrease;
begin
 OutPushAx;
 OutCallNative('RTL_STRING_INCREASE');
end;

procedure TBeRoScript.OutStrDecrease;
begin
 OutPushAx;
 OutCallNative('RTL_STRING_DECREASE');
end;

procedure TBeRoScript.OutStrAssign;
begin
 UseStrAssign:=true;
 CallLabel('C_StrAssign');
end;

procedure TBeRoScript.OutStrLength;
begin
 UseStrLength:=true;
 CallLabel('C_StrLength');
end;

procedure TBeRoScript.OutStrSetLength;
begin
 UseStrSetLength:=true;
 CallLabel('C_StrSetLength');
end;

procedure TBeRoScript.OutStrUnique;
begin
 UseStrUnique:=true;
 CallLabel('C_StrUnique');
end;

procedure TBeRoScript.OutStrCharConvert;
begin
 UseStrCharConvert:=true;
 CallLabel('C_StrCharConvert');
end;

procedure TBeRoScript.OutStrGet;
begin
 UseStrGet:=true;
 CallLabel('C_StrGet');
end;

procedure TBeRoScript.OutStrConcat;
begin
 UseStrConcat:=true;
 CallLabel('C_StrConcat');
end;

procedure TBeRoScript.OutStrSelfConcat;
begin
 UseStrSelfConcat:=true;
 CallLabel('C_StrSelfConcat');
end;

procedure TBeRoScript.OutStrCompare;
begin
 UseStrCompare:=true;
 CallLabel('C_StrCompare');
end;

procedure TBeRoScript.OutClrESPStr;
begin
 ByteHinzufuegen($c7); // MOV DWORD PTR [ESP-4],0
 ByteHinzufuegen($44);
 ByteHinzufuegen($24);
 ByteHinzufuegen($fc);
 DWordHinzufuegen($00);
end;

procedure TBeRoScript.OutLeaESPStr;
begin
 ByteHinzufuegen($8d); // LEA EAX,[ESP-4]
 ByteHinzufuegen($44);
 ByteHinzufuegen($24);
 ByteHinzufuegen($fc);
end;

procedure TBeRoScript.OutMovESPStr;
begin
 ByteHinzufuegen($8b); // MOV EAX,[ESP-4]
 ByteHinzufuegen($44);
 ByteHinzufuegen($24);
 ByteHinzufuegen($fc);
end;

procedure TBeRoScript.OutLeaESPStruct;
begin
 ByteHinzufuegen($8d); // LEA EAX,[ESP]
 ByteHinzufuegen($04);
 ByteHinzufuegen($24);
end;

procedure TBeRoScript.OutMovESPStruct;
begin
 ByteHinzufuegen($8b); // MOV EAX,[ESP]
 ByteHinzufuegen($04);
 ByteHinzufuegen($24);
end;

procedure TBeRoScript.OutMovEAXStruct(Size:longword);
begin
 case Size of
  1:begin
   // MOV AL,[EAX]
   ByteHinzufuegen($8a);
   ByteHinzufuegen($00);
   ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
  end;
  2:begin
   // MOV AX,[EAX]
   ByteHinzufuegen($66);
   ByteHinzufuegen($8b);
   ByteHinzufuegen($00);
   ByteHinzufuegen($25); DWordHinzufuegen($ffff); // AND EAX,$FFFF
  end;
  4:begin
   // MOV EAX,[EAX]
   ByteHinzufuegen($8b);
   ByteHinzufuegen($00);
  end;
 end;
end;

procedure TBeRoScript.OutMovEBXEAXStruct(Size:longword);
begin
 case Size of    
  1:begin
   // MOV [EAX],BL
   ByteHinzufuegen($88);
   ByteHinzufuegen($18);
  end;
  2:begin
   // MOV [EAX],BX
   ByteHinzufuegen($66);
   ByteHinzufuegen($89);
   ByteHinzufuegen($18);
  end;
  4:begin
   // MOV [EAX],EBX
   ByteHinzufuegen($89);
   ByteHinzufuegen($18);
  end;
 end;
end;

procedure TBeRoScript.OutJzIf(S:string);
begin
 ByteHinzufuegen($85); ByteHinzufuegen($c0); // TEST EAX,EAX
 JZLabel(S);
end;

procedure TBeRoScript.OutJzIfBx(S:string);
begin
 ByteHinzufuegen($85); ByteHinzufuegen($db); // TEST EBX,EBX
 JZLabel(S);
end;

procedure TBeRoScript.OutEql;
begin
 ByteHinzufuegen($39); ByteHinzufuegen($d8); // CMP EAX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($94); ByteHinzufuegen($c0); // SETZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutNe;
begin
 ByteHinzufuegen($39); ByteHinzufuegen($d8); // CMP EAX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($95); ByteHinzufuegen($c0); // SETNZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutLss;
begin
 ByteHinzufuegen($39); ByteHinzufuegen($d8); // CMP EAX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($9c); ByteHinzufuegen($c0); // SETL AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutLea;
begin
 ByteHinzufuegen($39); ByteHinzufuegen($d8); // CMP EAX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($9e); ByteHinzufuegen($c0); // SETLE AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutGre;
begin
 ByteHinzufuegen($39); ByteHinzufuegen($d8); // CMP EAX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($9f); ByteHinzufuegen($c0); // SETG AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutGra;
begin
 ByteHinzufuegen($39); ByteHinzufuegen($d8); // CMP EAX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($9d); ByteHinzufuegen($c0); // SETGE AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrBXTest;
begin
 ByteHinzufuegen($85); ByteHinzufuegen($db); // TEST EBX,EBX
 ByteHinzufuegen($0f); ByteHinzufuegen($94); ByteHinzufuegen($c0); // SETZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrEql;
begin
 OutStrCompare;
 ByteHinzufuegen($85); ByteHinzufuegen($c0); // TEST EAX,EAX
 ByteHinzufuegen($0f); ByteHinzufuegen($94); ByteHinzufuegen($c0); // SETZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrNe;
begin
 OutStrCompare;
 ByteHinzufuegen($85); ByteHinzufuegen($c0); // TEST EAX,EAX
 ByteHinzufuegen($0f); ByteHinzufuegen($95); ByteHinzufuegen($c0); // SETNZ AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrLss;
begin
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($f8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0f); ByteHinzufuegen($9c); ByteHinzufuegen($c0); // SETL AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrLea;
begin
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($f8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0f); ByteHinzufuegen($9e); ByteHinzufuegen($c0); // SETLE AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrGre;
begin
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($f8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0f); ByteHinzufuegen($9f); ByteHinzufuegen($c0); // SETG AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutStrGra;
begin
 OutStrCompare;
 ByteHinzufuegen($83); ByteHinzufuegen($f8); ByteHinzufuegen($00); // CMP EAX,0
 ByteHinzufuegen($0f); ByteHinzufuegen($9d); ByteHinzufuegen($c0); // SETGE AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutNotAxBoolean;
var S1,S2:string;
begin
 S1:=GeneratiereLabel;
 S2:=GeneratiereLabel;
 ByteHinzufuegen($85); ByteHinzufuegen($c0); // TEST EAX,EAX
 JZLabel(S1);
 ByteHinzufuegen($33); ByteHinzufuegen($c0); // XOR EAX,EAX
 JumpLabel(S2);
 OutLabel(S1);
 ByteHinzufuegen($33); ByteHinzufuegen($c0); // XOR EAX,EAX
 ByteHinzufuegen($40); // INC EAX
 OutLabel(S2);
end;

procedure TBeRoScript.OutNotAxBitwise;
begin
 ByteHinzufuegen($f7); ByteHinzufuegen($d0); // NOT EAX
end;

procedure TBeRoScript.OutNegAx;
begin
 ByteHinzufuegen($f7); ByteHinzufuegen($d8); // NEG EAX
end;

procedure TBeRoScript.OutPushSi;
begin
 ByteHinzufuegen($56); // PUSH ESI
end;

procedure TBeRoScript.OutPopSi;
begin
 ByteHinzufuegen($5e); // POP ESI
end;

procedure TBeRoScript.OutPushDi;
begin
 ByteHinzufuegen($57); // PUSH EDI
end;

procedure TBeRoScript.OutPopDi;
begin
 ByteHinzufuegen($5f); // POP EDI
end;

procedure TBeRoScript.OutMovCxSp;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($cc); // MOV ECX,ESP
end;

procedure TBeRoScript.OutMovSpCx;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($e1); // MOV ESP,ECX
end;

procedure TBeRoScript.OutMovBpSp;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($e5); // MOV EBP,ESP
end;

procedure TBeRoScript.OutMovSpBp;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($ec); // MOV ESP,EBP
end;

procedure TBeRoScript.OutMovSiAx;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($f0); // MOV ESI,EAX
end;

procedure TBeRoScript.OutMovBxSi;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($de); // MOV EBX,ESI
end;

procedure TBeRoScript.OutMoveFromEBXToStack(Size:longword;Position:longint);
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($f3); // MOV ESI,EBX
 OutSubESP(Size);
 ByteHinzufuegen($8b); ByteHinzufuegen($fc); // MOV EDI,ESP
 if Position<>0 then begin
  ByteHinzufuegen($81); ByteHinzufuegen($c7); // ADD EDI,Position
  DWordHinzufuegen(longword(Position));
 end;
 OutMovBxCx;
 if (Size mod 4)=0 then begin
  ByteHinzufuegen($b9); DWordHinzufuegen(Size shr 2); // MOV ECX,Size>>2
  ByteHinzufuegen($f3); ByteHinzufuegen($a5); // REP MOVSD
 end else if (Size mod 2)=0 then begin
  ByteHinzufuegen($b9); DWordHinzufuegen(Size shr 1); // MOV ECX,Size>>1
  ByteHinzufuegen($66); ByteHinzufuegen($f3); ByteHinzufuegen($a5); // REP MOVSW
 end else begin
  ByteHinzufuegen($b9); DWordHinzufuegen(Size); // MOV ECX,Size
  ByteHinzufuegen($f3); ByteHinzufuegen($a4); // REP MOVSD
 end;
 OutMovCxBx;
end;

procedure TBeRoScript.OutMoveFromEBXToEAX(Size:longword);
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($f3); // MOV ESI,EBX
 ByteHinzufuegen($89); ByteHinzufuegen($c7); // MOV EDI,EAX
 OutMovBxCx;
 if (Size mod 4)=0 then begin
  ByteHinzufuegen($b9); DWordHinzufuegen(Size shr 2); // MOV ECX,Size>>2
  ByteHinzufuegen($f3); ByteHinzufuegen($a5); // REP MOVSD
 end else if (Size mod 2)=0 then begin
  ByteHinzufuegen($b9); DWordHinzufuegen(Size shr 1); // MOV ECX,Size>>1
  ByteHinzufuegen($66); ByteHinzufuegen($f3); ByteHinzufuegen($a5); // REP MOVSW
 end else begin
  ByteHinzufuegen($b9); DWordHinzufuegen(Size); // MOV ECX,Size
  ByteHinzufuegen($f3); ByteHinzufuegen($a4); // REP MOVSD
 end;
 OutMovCxBx;
end;

procedure TBeRoScript.OutPush32(I:longword);
begin
 ByteHinzufuegen($68); // PUSH I
 DWordHinzufuegen(I);
end;

procedure TBeRoScript.OutPushClassPointer;
begin
 ByteHinzufuegen($68); // PUSH POINTER(SELF)
 ClassPointerFixUpHinzufuegen;
 DWordHinzufuegen(0);
end;

procedure TBeRoScript.OutPushAx32;
begin
 ByteHinzufuegen($50); // PUSH EAX
end;

procedure TBeRoScript.OutPushAx16;
begin
 ByteHinzufuegen($66); ByteHinzufuegen($50); // PUSH EAX
end;

procedure TBeRoScript.OutPushAx8;
begin
 ByteHinzufuegen($4c); // DEC ESP
 ByteHinzufuegen($88); ByteHinzufuegen($04); ByteHinzufuegen($24); // MOV [ESP],AL
end;

procedure TBeRoScript.OutPushAx;
begin
 ByteHinzufuegen($50); // PUSH EAX
end;

procedure TBeRoScript.OutPushBx;
begin
 ByteHinzufuegen($53); // PUSH EBX
end;

procedure TBeRoScript.OutPopAx;
begin
 ByteHinzufuegen($58); // POP EAX
end;

procedure TBeRoScript.OutPopBx;
begin
 ByteHinzufuegen($5b); // POP EBX
end;

procedure TBeRoScript.OutPushCx;
begin
 ByteHinzufuegen($51); // PUSH ECX
end;

procedure TBeRoScript.OutPushDx;
begin
 ByteHinzufuegen($52); // PUSH EDX
end;

procedure TBeRoScript.OutPopCx;
begin
 ByteHinzufuegen($59); // POP ECX
end;

procedure TBeRoScript.OutPopDx;
begin
 ByteHinzufuegen($5a); // POP EDX
end;

procedure TBeRoScript.OutPushBp;
begin
 ByteHinzufuegen($55); // PUSH EEP
end;

procedure TBeRoScript.OutPopBp;
begin
 ByteHinzufuegen($5d); // PUSH EEP
end;

procedure TBeRoScript.OutMulDx;
begin
 ByteHinzufuegen($f7); ByteHinzufuegen($e2); // MUL EDX
end;

procedure TBeRoScript.OutMulBx;
begin
 ByteHinzufuegen($f7); ByteHinzufuegen($e3); // MUL EBX
end;

procedure TBeRoScript.OutDivBx;
begin
 ByteHinzufuegen($31); ByteHinzufuegen($d2); // XOR EDX,EDX
 ByteHinzufuegen($f7); ByteHinzufuegen($f3); // DIV EBX
end;

procedure TBeRoScript.OutModBx;
begin
 ByteHinzufuegen($31); ByteHinzufuegen($d2); // XOR EDX,EDX
 ByteHinzufuegen($f7); ByteHinzufuegen($f3); // DIV EBX
 ByteHinzufuegen($89); ByteHinzufuegen($d0); // MOV EAX,EDX
end;

procedure TBeRoScript.OutIMulBx;
begin
 ByteHinzufuegen($f7); ByteHinzufuegen($eb); // IMUL EBX
end;

procedure TBeRoScript.OutIDivBx;
begin
 ByteHinzufuegen($99); // CDQ
 ByteHinzufuegen($f7); ByteHinzufuegen($fb); // IDIV EBX
end;

procedure TBeRoScript.OutIModBx;
begin
 ByteHinzufuegen($99); // CDQ
 ByteHinzufuegen($f7); ByteHinzufuegen($fb); // IDIV EBX
 ByteHinzufuegen($89); ByteHinzufuegen($d0); // MOV EAX,EDX
end;

procedure TBeRoScript.OutAndBx;
begin
 ByteHinzufuegen($21); ByteHinzufuegen($d8); // AND EAX,EBX
end;

procedure TBeRoScript.OutOrBx;
begin
 ByteHinzufuegen($09); ByteHinzufuegen($d8); // OR EAX,EBX
end;

procedure TBeRoScript.OutShlCx(I:byte);
begin
 if I=1 then begin
  ByteHinzufuegen($d1); ByteHinzufuegen($e1); // SHL ECX,1
 end else if I>1 then begin
  ByteHinzufuegen($c1); ByteHinzufuegen($e1); ByteHinzufuegen(I); // SHL ECX,I
 end;
end;

procedure TBeRoScript.OutShlBx;
begin
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($d9); // MOV ECX,EBX
 ByteHinzufuegen($d3); ByteHinzufuegen($e0); // SHL EAX,CL
 OutPopCx;
end;

procedure TBeRoScript.OutShrBx;
begin
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($d9); // MOV ECX,EBX
 ByteHinzufuegen($d3); ByteHinzufuegen($e8); // SHR EAX,CL
 OutPopCx;
end;

procedure TBeRoScript.OutSalBx;
begin
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($d9); // MOV ECX,EBX
 ByteHinzufuegen($d3); ByteHinzufuegen($e0); // SHL EAX,CL (SHL=SAL!)
 OutPopCx;
end;

procedure TBeRoScript.OutSarBx;
begin
 OutPushCx;
 ByteHinzufuegen($89); ByteHinzufuegen($d9); // MOV ECX,EBX
 ByteHinzufuegen($d3); ByteHinzufuegen($f8); // SAR EAX,CL
 OutPopCx;
end;

procedure TBeRoScript.OutXorBx;
begin
 ByteHinzufuegen($31); ByteHinzufuegen($d8); // XOR EAX,EBX
end;

procedure TBeRoScript.OutXorAxAx;
begin
 ByteHinzufuegen($31); ByteHinzufuegen($c0); // XOR EAX,EAX
end;

procedure TBeRoScript.OutXorBxBx;
begin
 ByteHinzufuegen($31); ByteHinzufuegen($db); // XOR EBX,EBX
end;

procedure TBeRoScript.OutXorCxCx;
begin
 ByteHinzufuegen($31); ByteHinzufuegen($c9); // XOR ECX,ECX
end;

procedure TBeRoScript.OutAddAxBx;
begin
 ByteHinzufuegen($01); ByteHinzufuegen($d8); // ADD EAX,EBX
end;

procedure TBeRoScript.OutAddAxCx;
begin
 ByteHinzufuegen($01); ByteHinzufuegen($c8); // ADD EAX,ECX
end;

procedure TBeRoScript.OutAddBxAx;
begin
 ByteHinzufuegen($01); ByteHinzufuegen($c3); // ADD EBX,EAX
end;

procedure TBeRoScript.OutAddBxCx;
begin
 ByteHinzufuegen($01); ByteHinzufuegen($cb); // ADD EBX,ECX
end;

procedure TBeRoScript.OutSubAxBx;
begin
 ByteHinzufuegen($29); ByteHinzufuegen($d8); // SUB EAX,EBX
end;

procedure TBeRoScript.OutMovBxAx;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($c3); // MOV EBX,EAX
end;

procedure TBeRoScript.OutLeaBxAxPlusOne;
begin
 // LEA EBX,[EAX+1]
 ByteHinzufuegen($8d);
 ByteHinzufuegen($58);
 ByteHinzufuegen($01);
end;

procedure TBeRoScript.OutMovAxBx;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($d8); // MOV EAX,EBX
end;

procedure TBeRoScript.OutMovCxAx;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($c1); // MOV ECX,EAX
end;

procedure TBeRoScript.OutMovCxBx;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($d9); // MOV ECX,EBX
end;

procedure TBeRoScript.OutMovBxFromBx;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($1b); // MOV EBX,[EBX]
end;

procedure TBeRoScript.OutMovCxFromBx;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($0b); // MOV ECX,[EBX]
end;

procedure TBeRoScript.OutMovBxCx;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($d9); // MOV EBX,ECX
end;

procedure TBeRoScript.OutMovDxImmSigned(S:longint);
begin
 ByteHinzufuegen($ba); DWordHinzufuegen(longword(S)); // MOV EAX,S
end;

procedure TBeRoScript.OutMovDxImmUnsigned(S:longword);
begin
 ByteHinzufuegen($ba); DWordHinzufuegen(S); // MOV EAX,S
end;

procedure TBeRoScript.OutMovAxImmSigned(S:longint);
begin
 ByteHinzufuegen($b8); DWordHinzufuegen(longword(S)); // MOV EAX,S
end;

procedure TBeRoScript.OutMulAxImmSigned(S:longint);
var SI:shortint;
    Bit,BitValue:longword;
    Done:boolean;
begin
 Done:=false;
 if S=1 then begin
  Done:=true;
 end else if S=0 then begin
  OutXorAxAx;
  Done:=true;
 end else if (S and (S-1))=0 then begin
  BitValue:=0;
  for Bit:=0 to 31 do begin
   if (S and ((1 shl (Bit+1))-1))<>0 then begin
    BitValue:=Bit;
    break;
   end;
  end;
  if BitValue=1 then begin
   ByteHinzufuegen($d1);
   ByteHinzufuegen($e0);
   Done:=true;
  end else begin
   if BitValue>0 then begin
    ByteHinzufuegen($c1);
    ByteHinzufuegen($e0);
    ByteHinzufuegen(BitValue);
    Done:=true;
   end;
  end;
 end;
 if not Done then begin
  if (S>=-128) and (S<=127) then begin
   ByteHinzufuegen($6b);
   ByteHinzufuegen($c0);
   SI:=S;
   ByteHinzufuegen(byte(SI));
  end else begin
   ByteHinzufuegen($69);
   ByteHinzufuegen($c0);
   DWordHinzufuegen(longword(S));
  end;
 end;
end;

procedure TBeRoScript.OutMovAxImmUnsigned(S:longword);
begin
 ByteHinzufuegen($b8); DWordHinzufuegen(S); // MOV EAX,S
end;

procedure TBeRoScript.OutMovAxImmLabel(S:string);
begin
 // MOV EAX,OFFSET S
 ByteHinzufuegen($b8);
 LabelAdresseHinzufuegen(S);
end;

procedure TBeRoScript.OutMovAxVar32(S:string);
begin
 // MOV EAX,[S]
 ByteHinzufuegen($8b);
 ByteHinzufuegen($05);
 LabelAdresseHinzufuegen(S);
end;

procedure TBeRoScript.OutMovAxVarLabel(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($a0);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($8b);
   ByteHinzufuegen($05);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutMovsxAxVarLabel(S:string;Size:byte);
begin
 if Size=4 then begin
  OutMovAxVarLabel(S,Size);
 end else if (Size=1) or (Size=2) then begin
  ByteHinzufuegen($0f);
  if Size=1 then begin
   ByteHinzufuegen($be);
  end else if Size=2 then begin
   ByteHinzufuegen($bf);
  end;
  ByteHinzufuegen($05);
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutMovAxVarEBXLabel(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($8a);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($8b);
  end;
  ByteHinzufuegen($83);
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutMovsxAxVarEBXLabel(S:string;Size:byte);
begin
 if Size=4 then begin
  OutMovAxVarEBXLabel(S,Size);
 end else if (Size=1) or (Size=2) then begin
  ByteHinzufuegen($0f);
  if Size=1 then begin
   ByteHinzufuegen($be);
  end else if Size=2 then begin
   ByteHinzufuegen($bf);
  end;
  ByteHinzufuegen($83);
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutMovESPAx(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Offset=0 then begin
   if Size=1 then begin
    ByteHinzufuegen($88);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
   end;
   ByteHinzufuegen($04);
   ByteHinzufuegen($24);
  end else if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($88);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
   end;
   ByteHinzufuegen($44);
   ByteHinzufuegen($24);
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($88);
    ByteHinzufuegen($84);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($84);
   end;
   ByteHinzufuegen($24);
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovAxVarEBP(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
   end;
   ByteHinzufuegen($45);
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
   end;
   ByteHinzufuegen($85);
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovsxAxVarEBP(Offset:integer;Size:byte);
var SI:shortint;
begin
 if Size=4 then begin
  OutMovAxVarEBP(Offset,Size);
 end else if (Size=1) or (Size=2) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   ByteHinzufuegen($0f);
   if Size=1 then begin
   ByteHinzufuegen($be);
   end else if Size=2 then begin
    ByteHinzufuegen($bf);
   end;
   ByteHinzufuegen($45);
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   ByteHinzufuegen($0f);
   if Size=1 then begin
   ByteHinzufuegen($be);
   end else if Size=2 then begin
    ByteHinzufuegen($bf);
   end;
   ByteHinzufuegen($85);
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovAxVarEBX(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Offset=0 then begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
   end;
   ByteHinzufuegen($03);
  end else if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
   end;
   ByteHinzufuegen($43);
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
   end;
   ByteHinzufuegen($83);
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovsxAxVarEBX(Offset:integer;Size:byte);
var SI:shortint;
begin
 if Size=4 then begin
  OutMovAxVarEBX(Offset,Size);
 end else if (Size=1) or (Size=2) then begin
  if Offset=0 then begin
   ByteHinzufuegen($0f);
   if Size=1 then begin
    ByteHinzufuegen($be);
   end else if Size=2 then begin
    ByteHinzufuegen($bf);
   end;
   ByteHinzufuegen($03);
  end else if (Offset>=-128) and (Offset<=127) then begin
   ByteHinzufuegen($0f);
   if Size=1 then begin
    ByteHinzufuegen($be);
   end else if Size=2 then begin
    ByteHinzufuegen($bf);
   end;
   ByteHinzufuegen($43);
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   ByteHinzufuegen($0f);
   if Size=1 then begin
    ByteHinzufuegen($be);
   end else if Size=2 then begin
    ByteHinzufuegen($bf);
   end;
   ByteHinzufuegen($83);
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovBxVarLabel(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($8a);
   ByteHinzufuegen($1d);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($8b);
   ByteHinzufuegen($1d);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutMovBxVarEBP(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
    ByteHinzufuegen($5d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
    ByteHinzufuegen($5d);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
    ByteHinzufuegen($9d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
    ByteHinzufuegen($9d);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovCxVarEBP(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
    ByteHinzufuegen($4d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
    ByteHinzufuegen($4d);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($8a);
    ByteHinzufuegen($8d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($8b);
    ByteHinzufuegen($8d);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovVarLabelAx(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($a2);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($89);
   ByteHinzufuegen($05);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutMovVarEBPAx(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($88);
    ByteHinzufuegen($45);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($45);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($88);
    ByteHinzufuegen($85);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($85);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovVarEBXAX(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Offset=0 then begin
   if Size=1 then begin
    ByteHinzufuegen($88);
    ByteHinzufuegen($03);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($03);
   end;
  end else if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($88);
    ByteHinzufuegen($43);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($43);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($88);
    ByteHinzufuegen($83);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($89);
    ByteHinzufuegen($83);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutMovVarEBXLabelAx(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($88);
   ByteHinzufuegen($83);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($89);
   ByteHinzufuegen($83);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutIncVarEBX(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Offset=0 then begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($03);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($03);
   end;
  end else if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($43);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($43);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($83);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($83);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutDecVarEBX(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Offset=0 then begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($0b);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($0b);
   end;
  end else if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($4b);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($4b);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($8b);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($8b);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutIncVarEBP(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($45);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($45);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($85);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($85);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutDecVarEBP(Offset:integer;Size:byte);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if (Offset>=-128) and (Offset<=127) then begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($4d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($4d);
   end;
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($fe);
    ByteHinzufuegen($8d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($ff);
    ByteHinzufuegen($8d);
   end;
   DWordHinzufuegen(longword(Offset));
  end;
 end;
end;

procedure TBeRoScript.OutIncVarLabel(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($fe);
   ByteHinzufuegen($05);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($ff);
   ByteHinzufuegen($05);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutDecVarLabel(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($fe);
   ByteHinzufuegen($0d);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($ff);
   ByteHinzufuegen($0d);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutIncVarLabelEBX(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($fe);
   ByteHinzufuegen($83);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($ff);
   ByteHinzufuegen($83);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutDecVarLabelEBX(S:string;Size:byte);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Size=1 then begin
   ByteHinzufuegen($fe);
   ByteHinzufuegen($8b);
  end else if (Size=2) or (Size=4) then begin
   if Size=2 then ByteHinzufuegen($66);
   ByteHinzufuegen($ff);
   ByteHinzufuegen($8b);
  end;
  LabelAdresseHinzufuegen(S);
 end;
end;

procedure TBeRoScript.OutAddVarLabel(S:string;Size:byte;Value:longword);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Value<=$ff then begin
   if Size=1 then begin
    ByteHinzufuegen($80);
    ByteHinzufuegen($05);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($83);
    ByteHinzufuegen($05);
   end;
   LabelAdresseHinzufuegen(S);
   ByteHinzufuegen(Value);
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($80);
    ByteHinzufuegen($05);
    ByteHinzufuegen(Value and $ff);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($81);
    ByteHinzufuegen($05);
    LabelAdresseHinzufuegen(S);
    if Size=2 then begin
     WordHinzufuegen(Value and $ffff);
    end else if Size=4 then begin
     DWordHinzufuegen(Value);
    end;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutSubVarLabel(S:string;Size:byte;Value:longword);
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Value<=$ff then begin
   if Size=1 then begin
    ByteHinzufuegen($80);
    ByteHinzufuegen($2d);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($83);
    ByteHinzufuegen($2d);
   end;
   LabelAdresseHinzufuegen(S);
   ByteHinzufuegen(Value);
  end else begin
   if Size=1 then begin
    ByteHinzufuegen($80);
    ByteHinzufuegen($2d);
    ByteHinzufuegen(Value and $ff);
   end else if (Size=2) or (Size=4) then begin
    if Size=2 then ByteHinzufuegen($66);
    ByteHinzufuegen($81);
    ByteHinzufuegen($2d);
    LabelAdresseHinzufuegen(S);
    if Size=2 then begin
     WordHinzufuegen(Value and $ffff);
    end else if Size=4 then begin
     DWordHinzufuegen(Value);
    end;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutAddVarEBP(Offset:integer;Size:byte;Value:longword);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Value<=$ff then begin
   if (Offset>=-128) and (Offset<=127) then begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($45);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($45);
    end;
   end else begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($85);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($85);
    end;
   end;
  end else begin
   if (Offset>=-128) and (Offset<=127) then begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($45);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($45);
    end;
   end else begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($45);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($85);
    end;
   end;
  end;
  if (Offset>=-128) and (Offset<=127) then begin
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   DWordHinzufuegen(longword(Offset));
  end;
  if Value<=$ff then begin
   ByteHinzufuegen(Value);
  end else begin
   if Size=1 then begin
    ByteHinzufuegen(Value and $ff);
   end else if Size=2 then begin
    WordHinzufuegen(Value and $ffff);
   end else if Size=4 then begin
    DWordHinzufuegen(Value);
   end;
  end;
 end;
end;

procedure TBeRoScript.OutSubVarEBP(Offset:integer;Size:byte;Value:longword);
var SI:shortint;
begin
 if (Size=1) or (Size=2) or (Size=4) then begin
  if Value<=$ff then begin
   if (Offset>=-128) and (Offset<=127) then begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($6d);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($6d);
    end;
   end else begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($ad);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($83);
     ByteHinzufuegen($ad);
    end;
   end;
  end else begin
   if (Offset>=-128) and (Offset<=127) then begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($6d);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($6d);
    end;
   end else begin
    if Size=1 then begin
     ByteHinzufuegen($80);
     ByteHinzufuegen($ad);
    end else if (Size=2) or (Size=4) then begin
     if Size=2 then ByteHinzufuegen($66);
     ByteHinzufuegen($81);
     ByteHinzufuegen($ad);
    end;
   end;
  end;
  if (Offset>=-128) and (Offset<=127) then begin
   SI:=Offset;
   ByteHinzufuegen(byte(SI));
  end else begin
   DWordHinzufuegen(longword(Offset));
  end;
  if Value<=$ff then begin
   ByteHinzufuegen(Value);
  end else begin
   if Size=1 then begin
    ByteHinzufuegen(Value and $ff);
   end else if Size=2 then begin
    WordHinzufuegen(Value and $ffff);
   end else if Size=4 then begin
    DWordHinzufuegen(Value);
   end;
  end;
 end;
end;

procedure TBeRoScript.OutMovEAXEBP;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($e8); // MOV EAX,EBP
end;

procedure TBeRoScript.OutLeaEAXEBP(Offset:integer);
var SI:shortint;
begin
 ByteHinzufuegen($8d);
 if (Offset>=-128) and (Offset<=127) then begin
  ByteHinzufuegen($45);
  SI:=Offset;
  ByteHinzufuegen(byte(SI));
 end else begin
  ByteHinzufuegen($85);
  DWordHinzufuegen(longword(Offset));
 end;
end;

procedure TBeRoScript.OutLeaEAXEBPECX(Offset:integer;Size:byte);
var SI:shortint;
begin
 ByteHinzufuegen($8d);
 if (Offset>=-128) and (Offset<=127) then begin
  ByteHinzufuegen($44);
 end else begin
  ByteHinzufuegen($84);
 end;
 case Size of
  1:ByteHinzufuegen($0d);
  2:ByteHinzufuegen($4d);
  4:ByteHinzufuegen($8d);
  8:ByteHinzufuegen($cd);
 end;
 if (Offset>=-128) and (Offset<=127) then begin
  SI:=Offset;
  ByteHinzufuegen(byte(SI));
 end else begin
  DWordHinzufuegen(longword(Offset));
 end;
end;

procedure TBeRoScript.OutLeaEAXImmLabelECX(S:string;Size:byte);
begin
 ByteHinzufuegen($8d);
 if Size=1 then begin
  ByteHinzufuegen($81);
 end else begin
  ByteHinzufuegen($04);
  case Size of
   1:ByteHinzufuegen($0d);
   2:ByteHinzufuegen($4d);
   4:ByteHinzufuegen($8d);
   8:ByteHinzufuegen($cd);
  end;
 end;
 LabelAdresseHinzufuegen(S);
end;

procedure TBeRoScript.OutLeaEAXEBPEBX(Offset:integer;Size:byte);
var SI:shortint;
begin
 ByteHinzufuegen($8d);
 if (Offset>=-128) and (Offset<=127) then begin
  ByteHinzufuegen($44);
 end else begin
  ByteHinzufuegen($84);
 end;
 case Size of
  1:ByteHinzufuegen($1d);
  2:ByteHinzufuegen($5d);
  4:ByteHinzufuegen($9d);
  8:ByteHinzufuegen($dd);
 end;
 if (Offset>=-128) and (Offset<=127) then begin
  SI:=Offset;
  ByteHinzufuegen(byte(SI));
 end else begin
  DWordHinzufuegen(longword(Offset));
 end;
end;

procedure TBeRoScript.OutLeaEAXImmLabelEBX(S:string;Size:byte);
begin
 ByteHinzufuegen($8d);
 if Size=1 then begin
  ByteHinzufuegen($83);
 end else begin
  ByteHinzufuegen($04);
  case Size of
   1:ByteHinzufuegen($1d);
   2:ByteHinzufuegen($5d);
   4:ByteHinzufuegen($9d);
   8:ByteHinzufuegen($dd);
  end;
 end;
 LabelAdresseHinzufuegen(S);
end;

procedure TBeRoScript.OutLeaEBXEBP(Offset:integer);
var SI:shortint;
begin
 ByteHinzufuegen($8d);
 if (Offset>=-128) and (Offset<=127) then begin
  ByteHinzufuegen($5d);
  SI:=Offset;
  ByteHinzufuegen(byte(SI));
 end else begin
  ByteHinzufuegen($9d);
  DWordHinzufuegen(longword(Offset));
 end;
end;

procedure TBeRoScript.OutSubESP(I:longword);
begin
 ByteHinzufuegen($81); ByteHinzufuegen($ec); // SUB ESP,I
 DWordHinzufuegen(I);
end;

procedure TBeRoScript.OutAddESP(I:longword);
begin
 if I<>0 then begin
  ByteHinzufuegen($81); ByteHinzufuegen($c4); // ADD ESP,I
  DWordHinzufuegen(I);
 end
end;

procedure TBeRoScript.OutSubEAX(I:longword);
begin
 if I<>0 then begin
  if I<=$ff then begin
   ByteHinzufuegen($83);
   ByteHinzufuegen($e8);
   ByteHinzufuegen(I);
  end else begin
   ByteHinzufuegen($2d);
   DWordHinzufuegen(I);
  end;
 end;
end;

procedure TBeRoScript.OutAddEAX(I:longword);
begin
 if I<>0 then begin
  if I<=$ff then begin
   ByteHinzufuegen($83);
   ByteHinzufuegen($c0);
   ByteHinzufuegen(I);
  end else begin
   ByteHinzufuegen($05);
   DWordHinzufuegen(I);
  end;
 end;
end;

procedure TBeRoScript.OutMovBxImmSigned(S:longint);
begin
 ByteHinzufuegen($bb); DWordHinzufuegen(longword(S)); // MOV EBX,S
end;

procedure TBeRoScript.OutMovBxImmUnsigned(S:longword);
begin
 ByteHinzufuegen($bb); DWordHinzufuegen(S); // MOV EBX,S
end;

procedure TBeRoScript.OutMovBxImmLabel(S:string);
begin
 // MOV EBX,OFFSET S
 ByteHinzufuegen($bb);
 LabelAdresseHinzufuegen(S);
end;

procedure TBeRoScript.OutMovBxImmLabelOffset(S:string;Offset:integer);
begin
 // MOV EBX,OFFSET S+Offset
 ByteHinzufuegen($bb);
 LabelAdresseOffsetHinzufuegen(S,Offset);
end;

procedure TBeRoScript.OutMovEBXEBP;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($eb); // MOV EBX,EBP
end;

procedure TBeRoScript.OutMovzxEAXAL;
begin
 ByteHinzufuegen($0f); ByteHinzufuegen($b6); ByteHinzufuegen($c0); // MOVZX EAX,AL
end;

procedure TBeRoScript.OutSubEBX(I:longword);
begin
 if I<=$ff then begin
  ByteHinzufuegen($83);
  ByteHinzufuegen($eb);
  ByteHinzufuegen(I);
 end else begin
  ByteHinzufuegen($81);
  ByteHinzufuegen($eb);
  ByteHinzufuegen($05);
  DWordHinzufuegen(I);
 end;
end;

procedure TBeRoScript.OutAddEBX(I:longword);
begin
 if I<=$ff then begin
  ByteHinzufuegen($83);
  ByteHinzufuegen($c3);
  ByteHinzufuegen(I);
 end else begin
  ByteHinzufuegen($81);
  ByteHinzufuegen($c3);
  DWordHinzufuegen(I);
 end;
end;

procedure TBeRoScript.OutAddECX(I:longword);
begin
 if I<=$ff then begin
  ByteHinzufuegen($83);
  ByteHinzufuegen($c1);
  ByteHinzufuegen(I);
 end else begin
  ByteHinzufuegen($81);
  ByteHinzufuegen($c1);
  DWordHinzufuegen(I);
 end;
end;

procedure TBeRoScript.OutMovAxVarAdr(S:string;index:integer;Zeiger,UseArray:boolean);
var Adr,Size:integer;
    A:string;
begin
 if LockVar(S,'',a,Adr,false,-1) then begin
  if not NameTabelle[AktSymPtr].Zeiger then begin
   if not (NameTabelle[AktSymPtr].IstArray and UseArray) then begin
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovAxImmLabel(a);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutLeaEAXEBP(-NameTabelle[AktSymPtr].StackPtr);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutLeaEAXEBP(NameTabelle[AktSymPtr].StackPtr);
    end;
   end else begin
    OutPushBx;
    Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovBxCx;
    end;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutLeaEAXImmLabelEBX(a,size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutLeaEAXEBPEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutLeaEAXEBPEBX(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
    OutPopBx;
   end;
  end else begin
   if Zeiger then begin
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovAxVar32(a);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovAxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    end;
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutAddAxCx;
    end;
   end else begin
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     Size:=1;
     if AktTyp in [tuShortInt,tShortInt] then Size:=2;
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutLeaEAXImmLabelECX(a,size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutLeaEAXEBPECX(-NameTabelle[AktSymPtr].StackPtr,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutLeaEAXEBPECX(NameTabelle[AktSymPtr].StackPtr,Size);
     end;
    end else begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovAxImmLabel(a);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutLeaEAXEBP(-NameTabelle[AktSymPtr].StackPtr);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutLeaEAXEBP(NameTabelle[AktSymPtr].StackPtr);
     end;
    end;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutMovAxVar(S:string;index:integer;Zeiger,UseArray:boolean);
var Adr:integer;
    a:string;
    Size:byte;
begin
 if LockVar(S,'',a,Adr,false,-1) then begin
  if not NameTabelle[AktSymPtr].Zeiger then begin
   if AktTyp in [tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt] then OutXorAxAx;
   if not (NameTabelle[AktSymPtr].IstArray and UseArray) then begin
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if AktTyp in [tByte,tChar,tShortInt,tInt] then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovsxAxVarLabel(a,Size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutMovsxAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutMovsxAxVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
     end;
    end else begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovAxVarLabel(a,Size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutMovAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutMovAxVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
     end;
    end;            
   end else begin
    OutPushBx;
    if not (NameTabelle[AktSymPtr].Art in [aGlobal,aStatic]) then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    end else begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if AktTyp in [tByte,tChar,tShortInt,tInt] then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovsxAxVarEBXLabel(a,Size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutMovsxAxVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutMovsxAxVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
     end;
    end else begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovAxVarEBXLabel(a,Size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutMovAxVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutMovAxVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
     end;
    end;
    OutPopBx;
   end;
  end else begin
   if Zeiger then begin
    OutPushBx;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovBxVarLabel(a,4);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    end;
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutAddBxCx;
    end;
    if AktTyp in [tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt] then OutXorAxAx;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if AktTyp in [tByte,tChar,tShortInt,tInt] then begin
     OutMovsxAxVarEBX(0,Size);
    end else begin
     OutMovAxVarEBX(0,Size);
    end;
    OutPopBx;
   end else begin
    if AktTyp in [tByte,tChar,tShortInt,tInt] then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovsxAxVarLabel(a,4);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutMovsxAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutMovsxAxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     end;
    end else begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutMovAxVarLabel(a,4);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutMovAxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutMovAxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     end;
    end;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutMovVarAx(S:string;index:integer;Zeiger,UseArray:boolean);
var Adr:integer;
    a:string;
    Size:byte;
begin
 if LockVar(S,'',a,Adr,false,-1) then begin
  if not NameTabelle[AktSymPtr].Zeiger then begin
   if not (NameTabelle[AktSymPtr].IstArray and UseArray) then begin
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovVarLabelAX(a,Size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovVarEBPAX(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovVarEBPAX(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
   end else begin
    OutPushBx;
    if not (NameTabelle[AktSymPtr].Art in [aGlobal,aStatic]) then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    end else begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovVarEBXLabelAx(a,Size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovVarEBXAx(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovVarEBXAx(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
    OutPopBx;
   end;
  end else begin
   if Zeiger then begin
    OutPushBx;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovBxVarLabel(a,4);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    end;
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutAddBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    OutMovVarEBXAx(0,Size);
    OutPopBx;
   end else begin
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovVarLabelAX(a,4);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovVarEBPAX(-NameTabelle[AktSymPtr].StackPtr,4);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovVarEBPAX(NameTabelle[AktSymPtr].StackPtr,4);
    end;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutIncVar(S:string;Zeiger,UseArray:boolean);
var Adr:integer;
    a:string;
    Size:byte;
begin
 if LockVar(S,'',a,Adr,false,-1) then begin
  if NameTabelle[AktSymPtr].Zeiger then begin
   if Zeiger then begin
    OutPushBx;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovBxVarLabel(a,4);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    end;
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutAddBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    OutIncVarEBX(0,Size);
    OutPopBx;
   end else begin
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if Size>1 then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutAddVarLabel(a,4,Size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutAddVarEBP(-NameTabelle[AktSymPtr].StackPtr,4,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutAddVarEBP(NameTabelle[AktSymPtr].StackPtr,4,Size);
     end;
    end else if Size=1 then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutIncVarLabel(a,4);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutIncVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutIncVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     end;
    end;
   end;
  end else begin
   if not (NameTabelle[AktSymPtr].IstArray and UseArray) then begin
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutIncVarLabel(a,Size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutIncVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutIncVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
   end else begin
    OutPushBx;
    if not (NameTabelle[AktSymPtr].Art in [aGlobal,aStatic]) then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    end else begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutIncVarLabelEBX(a,Size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutIncVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutIncVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
    OutPopBx;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutDecVar(S:string;Zeiger,UseArray:boolean);
var Adr,Size:integer;
    a:string;
begin
 if LockVar(S,'',a,Adr,false,-1) then begin
  if NameTabelle[AktSymPtr].Zeiger then begin
   if Zeiger then begin
    OutPushBx;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutMovBxVarLabel(a,4);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutMovBxVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutMovBxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
    end;
    if NameTabelle[AktSymPtr].IstArray and UseArray then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutAddBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    OutDecVarEBX(0,Size);
    OutPopBx;
   end else begin
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if Size>1 then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutSubVarLabel(a,4,Size);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutSubVarEBP(-NameTabelle[AktSymPtr].StackPtr,4,Size);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutSubVarEBP(NameTabelle[AktSymPtr].StackPtr,4,Size);
     end;
    end else if Size=1 then begin
     if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
      OutDecVarLabel(a,4);
     end else if NameTabelle[AktSymPtr].Art=aLokal then begin
      OutDecVarEBP(-NameTabelle[AktSymPtr].StackPtr,4);
     end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
      OutDecVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
     end;
    end;
   end;
  end else begin
   if not (NameTabelle[AktSymPtr].IstArray and UseArray) then begin
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutDecVarLabel(a,Size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutDecVarEBP(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutDEcVarEBP(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
   end else begin
    OutPushBx;
    if not (NameTabelle[AktSymPtr].Art in [aGlobal,aStatic]) then begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovEBXEBP;
     OutAddBxCx;
    end else begin
     if AktTyp in [tuShortInt,tShortInt] then OutShlCx(1);
     if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then OutShlCx(2);
     OutMovBxCx;
    end;
    Size:=0;
    if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
    if AktTyp in [tuShortInt,tShortInt] then Size:=2;
    if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
    if NameTabelle[AktSymPtr].Art in [aGlobal,aStatic] then begin
     OutDecVarLabelEBX(a,Size);
    end else if NameTabelle[AktSymPtr].Art=aLokal then begin
     OutDecVarEBX(-NameTabelle[AktSymPtr].StackPtr,Size);
    end else if NameTabelle[AktSymPtr].Art in [aParam,aShadowParam] then begin
     OutDecVarEBX(NameTabelle[AktSymPtr].StackPtr,Size);
    end;
    OutPopBx;
   end;
  end;
 end;
end;

procedure TBeRoScript.OutIncStructVar;
var Size:integer;
begin
 Size:=0;
 if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
 if AktTyp in [tuShortInt,tShortInt] then Size:=2;
 if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
 if Size=0 then begin
  SetError(ceWrongType);
 end else begin
  OutIncVarEBX(0,Size);
 end;
end;

procedure TBeRoScript.OutDecStructVar;
var Size:integer;
begin
 Size:=0;
 if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
 if AktTyp in [tuShortInt,tShortInt] then Size:=2;
 if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
 if Size=0 then begin
  SetError(ceWrongType);
 end else begin
  OutDecVarEBX(0,Size);
 end;
end;

procedure TBeRoScript.OutIncFPU;
begin
 OutAXToStack;
 OutFPULD1;
 OutFPUAddEx;
 OutFPUToAX;
end;

procedure TBeRoScript.OutDecFPU;
begin
 OutMovBxAx;
 OutFPULD1;
 OutFPUToAX;
 OutXChgAxBx;
 OutAxToFPU;
 OutXChgAxBx;
 OutAXToStack;
 OutFPUSubEx;
 OutFPUToAX;
end;

procedure TBeRoScript.OutMovToStructVar(Variable:integer);
var Size:integer;
begin
 AktTyp:=NameTabelle[Variable].Typ;
 if NameTabelle[Variable].Zeiger then begin
  Size:=4;
 end else begin
  Size:=0;
  if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
  if AktTyp in [tuShortInt,tShortInt] then Size:=2;
  if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
 end;
 if Size=0 then begin
  SetError(ceWrongType);
 end else begin
  OutMovVarEBXAx(0,Size);
 end;
end;

procedure TBeRoScript.OutMovFromStructVar(Variable:integer);
var Size:integer;
begin
 AktTyp:=NameTabelle[Variable].Typ;
 if NameTabelle[Variable].Zeiger then begin
  Size:=4;
 end else begin
  Size:=0;
  if AktTyp in [tuByte,tByte,tuChar,tChar,tuShortInt,tShortInt] then OutXorAxAx;
  if AktTyp in [tuByte,tByte,tuChar,tChar] then Size:=1;
  if AktTyp in [tuShortInt,tShortInt] then Size:=2;
  if AktTyp in [tuInt,tInt,tFloat,tString,tVoid] then Size:=4;
 end;
 if Size=0 then begin
  SetError(ceWrongType);
 end else begin
  if AktTyp in [tByte,tChar,tShortInt,tInt] then begin
   OutMovsxAxVarEBX(0,Size);
  end else begin
   OutMovAxVarEBX(0,Size);
  end;
 end;
end;

procedure TBeRoScript.OutCall(S,SO:string);
var Adr:TWert;
    a:string;
begin
 if LockVar(S,SO,a,Adr,false,-1) then CallLabel(a);
end;

procedure TBeRoScript.OutCallAx;
begin
 ByteHinzufuegen($ff);
 ByteHinzufuegen($d0);
end;

procedure TBeRoScript.OutCallBx;
begin
 ByteHinzufuegen($ff);
 ByteHinzufuegen($d3);
end;

procedure TBeRoScript.OutCallNative(name:string);
var I,J:integer;
begin
 J:=-1;
 for I:=0 to tnpZaehler-1 do begin
  if NativeTabelle[I].name=name then begin
   J:=I;
   break;
  end;
 end;
 if J>=0 then begin
  ByteHinzufuegen($e8);
  NativeRelativeFixUpHinzufuegen(name);
  DWordHinzufuegen(0); // CALL Relative NativeAdresse
 end else begin
  SetError(ceNativeProcNichtGefunden);
 end;
end;

procedure TBeRoScript.OutCallImport(name:string);
var I,J:integer;
begin
 J:=-1;
 for I:=0 to tnpZaehler-1 do begin
  if ImportTabelle[I].name=name then begin
   J:=I;
   break;
  end;
 end;
 if J>=0 then begin
  ByteHinzufuegen($e8);
  ImportRelativeFixUpHinzufuegen(name);
  DWordHinzufuegen(0); // CALL Relative NativeAdresse
 end else begin
  SetError(ceImportProcNichtGefunden);
 end;
end;

function TBeRoScript.HexB(B:byte):string;
const Hex:array[0..$f] of char='0123456789ABCDEF';
begin
 result:=Hex[B shr 4]+Hex[B and $f];
end;

function TBeRoScript.HexW(W:word):string;
begin
 HexW:=HexB(W shr 8)+HexB(W and $ff);
end;

function TBeRoScript.FlagIsSet(Flags:byte;FlagMask:byte):boolean;
begin
 FlagIsSet:=(Flags and FlagMask)<>0;
end;

function TBeRoScript.LeseNaechstesZeichen:char;
var MeinNaechstesZeichen:char;
begin
 if QuellStream.Position<QuellStream.Size then begin
  if QuellStream.read(MeinNaechstesZeichen,sizeof(char))=sizeof(char) then begin
   SBuf:=SBuf+MeinNaechstesZeichen;
   if MeinNaechstesZeichen>#32 then inc(QuelltextSpalte);
  end else begin
   feof:=true;
   MeinNaechstesZeichen:=#32;
  end;
 end else begin
  feof:=true;
  MeinNaechstesZeichen:=#32;
 end;
 if not feof then inc(QuelltextPos);
 LeseNaechstesZeichen:=MeinNaechstesZeichen;
end;

procedure TBeRoScript.Get;
var sch:char;
 procedure GetIdent;
 begin
  sTok:='';
  while (UPCASE(ch) in ['A'..'Z','0'..'9','_']) and not feof do begin
   sTok:=sTok+ch;
   ch:=LeseNaechstesZeichen;
  end;
  if ch=':' then begin
   tTok:=LockKey(sTok);
   if (tTok=_ident) and not IsStruct(sTok) then begin
    tTok:=_label;
    ch:=LeseNaechstesZeichen;
   end;
  end else begin
   tTok:=LockKey(sTok);
  end;
 end;
 procedure GetNum;
 var e:int64;
     Basis:integer;
     a:byte;
     f,fp:single;
     UseFloat:boolean;
 begin
  Basis:=10;
  sTok:='';
  e:=0;
  UseFloat:=false;
  while (ch in ['0'..'9','A'..'F','a'..'f','x','X','.']) and not feof do begin
   if ch in ['x','X'] then begin
    Basis:=16;
   end else begin
    if Basis=10 then begin
     if ch in ['0'..'9'] then begin
      a:=byte(ch)-byte('0');
      e:=(e*10)+a;
     end else if ch='.' then begin
      UseFloat:=true;
      break;
     end;
    end else if Basis=16 then begin
     if ch in ['0'..'9'] then begin
      a:=byte(ch)-byte('0');
     end else if ch in ['A'..'F'] then begin
      a:=byte(ch)-byte('A')+10;
     end else if ch in ['a'..'f'] then begin
      a:=byte(ch)-byte('A')+10;
     end else if ch='.' then begin
      SetError(ceFloatInHexError);
      a:=0;
     end else begin
      a:=0;
     end;
     e:=(e*16)+a;
    end;
    sTok:=sTok+ch;
   end;
   ch:=LeseNaechstesZeichen;
  end;
  if useFloat then begin
   f:=e;
   fp:=10;
   ch:=LeseNaechstesZeichen;
   while (ch in ['0'..'9']) and not feof do begin
    if ch in ['0'..'9'] then begin
     a:=byte(ch)-byte('0');
     f:=f+(a/fp);
     fp:=fp*10;
    end;
    ch:=LeseNaechstesZeichen;
   end;
   fTok:=f;
   iTok:=e;
   tTok:=_floatnum;
  end else begin
   fTok:=e;
   iTok:=e;
   tTok:=_integer;
  end;
 end;
 procedure GetStr;
 var a,e:byte;
 begin
  AktStr:='';
  StrWert:=0;
  while (ch<>sch) and not feof do begin
   if (ch='\') and not feof then begin
    ch:=LeseNaechstesZeichen;
    if ch='r' then ch:=#13;
    if ch='n' then ch:=#10;
    if ch='\' then ch:='\';
    if ch='''' then ch:='''';
    if ch='"' then ch:='"';
    if ch='B' then ch:=#7;
    if ch='u' then ch:=#8;
    if ch='t' then ch:=#9;
    if ch='0' then ch:=#0;
    if ch='x' then begin
     if not feof then begin
      ch:=LeseNaechstesZeichen;
     end else begin
      ch:='0';
     end;
     if ch in ['0'..'9'] then begin
      a:=byte(ch)-byte('0');
     end else if ch in ['A'..'F'] then begin
      a:=byte(ch)-byte('A')+10;
     end else if ch in ['a'..'f'] then begin
      a:=byte(ch)-byte('A')+10;
     end else begin
      a:=0;
     end;
     e:=a;
     if not feof then begin
      ch:=LeseNaechstesZeichen;
     end else begin
      ch:='0';
     end;
     if ch in ['0'..'9'] then begin
      a:=byte(ch)-byte('0');
     end else if ch in ['A'..'F'] then begin
      a:=byte(ch)-byte('A')+10;
     end else if ch in ['a'..'f'] then begin
      a:=byte(ch)-byte('A')+10;
     end else begin
      a:=0;
     end;
     e:=(e shl 4)+a;
     ch:=char(e);
    end;
   end;
   StrWert:=(StrWert shl 8)+byte(ch);
   AktStr:=AktStr+ch;
   ch:=LeseNaechstesZeichen;
  end;
  tTok:=_string;
 end;
begin
 AktStr:='';
 while (ch in [#9,#32,#10,#13]) and not feof do begin
  if ch=#10 then begin
   inc(QuelltextZeile);
   QuelltextSpalte:=0;
  end;
  ch:=LeseNaechstesZeichen;
 end;
 stok:=ch;
 case UPCASE(ch) of
  '_':GetIdent;
  'A'..'Z':GetIdent;
  '0'..'9':GetNum;
  ',':begin
   tTok:=_comma;
   ch:=LeseNaechstesZeichen;
  end;
  '"','''':begin
   sch:=ch;
   ch:=LeseNaechstesZeichen;
   GetStr;
   ch:=LeseNaechstesZeichen;
  end;
  '{':begin
   tTok:=_begin;
   ch:=LeseNaechstesZeichen;
  end;
  '}':begin
   tTok:=_end;
   ch:=LeseNaechstesZeichen;
  end;
  ';':begin
   tTok:=_semicolon;
   ch:=LeseNaechstesZeichen;
  end;
  '+':begin
   tTok:=_plus;
   ch:=LeseNaechstesZeichen;
   if ch='+' then begin
    tTok:=_plusplus;
    ch:=LeseNaechstesZeichen;
   end;
  end;
  '-':begin
   tTok:=_minus;
   ch:=LeseNaechstesZeichen;
   if ch='-' then begin
    tTok:=_minusminus;
    ch:=LeseNaechstesZeichen;
   end else if ch='>' then begin
    tTok:=_usepointer;
    ch:=LeseNaechstesZeichen;
   end;
  end;
  '*':begin
   tTok:=_mul;
   ch:=LeseNaechstesZeichen;
  end;
  '.':begin
   tTok:=_dot;
   ch:=LeseNaechstesZeichen;
  end;
  '/':begin
   ch:=LeseNaechstesZeichen;
   if ch='*' then begin
    sch:='*';
    ch:=LeseNaechstesZeichen;
    while not (((sch='*') and (ch='/')) or feof) do begin
     if ch=#10 then begin
      inc(QuelltextZeile);
      QuelltextSpalte:=0;
     end;
     sch:=ch;
     ch:=LeseNaechstesZeichen;
    end;
    ch:=LeseNaechstesZeichen;
    Get;
   end else if ch='/' then begin
    ch:=LeseNaechstesZeichen;
    while not ((ch=#10) or feof) do ch:=LeseNaechstesZeichen;
    if ch=#10 then begin
     inc(QuelltextZeile);
     QuelltextSpalte:=0;
    end;
    ch:=LeseNaechstesZeichen;
    Get;
   end else begin
    tTok:=_div;
   end;
  end;
  '%':begin
   tTok:=_mod;
   ch:=LeseNaechstesZeichen;
  end;
  '&':begin
   tTok:=_and;
   ch:=LeseNaechstesZeichen;
   if ch='&' then ch:=LeseNaechstesZeichen;
  end;
  '|':begin
   tTok:=_or;
   ch:=LeseNaechstesZeichen;
   if ch='|' then ch:=LeseNaechstesZeichen;
  end;
  '(': begin
   tTok:=_lparent;
   ch:=LeseNaechstesZeichen;
  end;
  ')':begin
   tTok:=_rparent;
   ch:=LeseNaechstesZeichen;
  end;
  '[':begin
   tTok:=_klparent;
   ch:=LeseNaechstesZeichen;
  end;
  ']':begin
   tTok:=_krparent;
   ch:=LeseNaechstesZeichen;
  end;
  '^':begin
   tTok:=_xor;
   ch:=LeseNaechstesZeichen;
  end;
  '!':begin
   tTok:=_not;
   ch:=LeseNaechstesZeichen;
   if ch='=' then begin
    tTok:=_isnot;
    ch:=LeseNaechstesZeichen;
   end;
  end;
  '~':begin
   tTok:=_notbitwise;
   ch:=LeseNaechstesZeichen;
  end;
  '=':begin
   tTok:=_set;
   ch:=LeseNaechstesZeichen;
   if ch='=' then begin
    tTok:=_eql;
    ch:=LeseNaechstesZeichen;
   end;
  end;
  '<':begin
   ch:=LeseNaechstesZeichen;
   if ch='=' then begin
    tTok:=_lea;
    ch:=LeseNaechstesZeichen;
   end else if ch= '>' then begin
    tTok:=_neg;
    ch:=LeseNaechstesZeichen;
   end else if ch= '<' then begin
    tTok:=_shl;
    ch:=LeseNaechstesZeichen;
   end else begin
    tTok:=_lss;
   end;
  end;
  '>':begin
   ch:=LeseNaechstesZeichen;
   if ch='=' then begin
    tTok:=_gra;
    ch:=LeseNaechstesZeichen;
   end else if ch= '>' then begin
    tTok:=_shr;
    ch:=LeseNaechstesZeichen;
   end else begin
    tTok:=_gre;
   end;
  end;
  ':':begin
   tTok:=_doublepoint;
   ch:=LeseNaechstesZeichen;
   if ch=':' then begin
    tTok:=_doubledoublepoint;
    ch:=LeseNaechstesZeichen;
   end;
  end;
  '?':begin
   tTok:=_shortif;
   ch:=LeseNaechstesZeichen;
  end;
  #26:SetError(ceUnexpectedEOF);
  else begin
   tTok:=_unknow;
  end;
 end;
end;

procedure TBeRoScript.OutXChgAxBx;
begin
 ByteHinzufuegen($93); // XCHG EAX,EBX
end;

procedure TBeRoScript.OutFPULD1;
begin
 ByteHinzufuegen($d9); ByteHinzufuegen($e8); // FLD1
end;

procedure TBeRoScript.OutIntAXtoFPU;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // MOV [ESP-4],EAX
 ByteHinzufuegen($db); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // FILD [ESP-4]
end;

procedure TBeRoScript.OutFPUToIntAX;
begin
 ByteHinzufuegen($db); ByteHinzufuegen($5c); ByteHinzufuegen($24); ByteHinzufuegen($fc); // FISTP [ESP-4]
 ByteHinzufuegen($8b); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // MOV EAX,[ESP-4]
end;

procedure TBeRoScript.OutAXtoFPU;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // MOV [ESP-4],EAX
 ByteHinzufuegen($d9); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // FLD [ESP-4]
end;

procedure TBeRoScript.OutFPUtoAX;
begin
 ByteHinzufuegen($d9); ByteHinzufuegen($5c); ByteHinzufuegen($24); ByteHinzufuegen($fc); // FSTP [ESP-4]
 ByteHinzufuegen($8b); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // MOV EAX,[ESP-4]
end;

procedure TBeRoScript.OutAXtoStack;
begin
 ByteHinzufuegen($89); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // MOV [ESP-4],EAX
end;

procedure TBeRoScript.OutStacktoAX;
begin
 ByteHinzufuegen($8b); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // MOV EAX,[ESP-4]
end;

procedure TBeRoScript.OutFPUAddEx;
begin
 ByteHinzufuegen($d8); ByteHinzufuegen($44); ByteHinzufuegen($24); ByteHinzufuegen($fc); // FADD [ESP-4]
end;

procedure TBeRoScript.OutFPUSubEx;
begin
 ByteHinzufuegen($d8); ByteHinzufuegen($64); ByteHinzufuegen($24); ByteHinzufuegen($fc); // FSUB [ESP-4]
end;

procedure TBeRoScript.OutFPUAdd;
begin
 ByteHinzufuegen($d8); ByteHinzufuegen($04); ByteHinzufuegen($24); // FADD [ESP]
end;

procedure TBeRoScript.OutFPUSub;
begin
 ByteHinzufuegen($d8); ByteHinzufuegen($24); ByteHinzufuegen($24); // FSUB [ESP]
end;

procedure TBeRoScript.OutFPUMul;
begin
 ByteHinzufuegen($d8); ByteHinzufuegen($0c); ByteHinzufuegen($24); // FMUL [ESP]
end;

procedure TBeRoScript.OutFPUDiv;
begin
 ByteHinzufuegen($d8); ByteHinzufuegen($34); ByteHinzufuegen($24); // FDIV [ESP]
end;

procedure TBeRoScript.OutFPUWait;
begin
 ByteHinzufuegen($9b); // FWAIT
end;

procedure TBeRoScript.OutFPULss;
begin
 OutXorAxAx;
 ByteHinzufuegen($d8); ByteHinzufuegen($1c); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($df); ByteHinzufuegen($e0); // FSTSW AX
 ByteHinzufuegen($9e); // SAHF
 ByteHinzufuegen($0f); ByteHinzufuegen($92); ByteHinzufuegen($c0); // SETB AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutFPULea;
begin
 OutXorAxAx;
 ByteHinzufuegen($d8); ByteHinzufuegen($1c); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($df); ByteHinzufuegen($e0); // FSTSW AX
 ByteHinzufuegen($9e); // SAHF
 ByteHinzufuegen($0f); ByteHinzufuegen($96); ByteHinzufuegen($c0); // SETBE AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutFPUGre;
begin
 OutXorAxAx;
 ByteHinzufuegen($d8); ByteHinzufuegen($1c); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($df); ByteHinzufuegen($e0); // FSTSW AX
 ByteHinzufuegen($9e); // SAHF
 ByteHinzufuegen($0f); ByteHinzufuegen($97); ByteHinzufuegen($c0); // SETA AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.OutFPUGra;
begin
 OutXorAxAx;
 ByteHinzufuegen($d8); ByteHinzufuegen($1c); ByteHinzufuegen($24); // FCOMP [ESP]
 ByteHinzufuegen($df); ByteHinzufuegen($e0); // FSTSW AX
 ByteHinzufuegen($9e); // SAHF
 ByteHinzufuegen($0f); ByteHinzufuegen($93); ByteHinzufuegen($c0); // SETAE AL
 ByteHinzufuegen($25); DWordHinzufuegen($ff); // AND EAX,$FF
end;

procedure TBeRoScript.FloatFactor;
var Adr:TWert;
    S,a:string;
    I,AltTok:integer;
    Zeiger,HoleZeiger,UseArray,StringArray,ObjectVar:boolean;
    AltStringHandling:TStringHandling;
    UseEBX:boolean;
    AltSymPtr,AltAktSymPtr:integer;
begin
 IsFloatExpression:=true;
 Zeiger:=false;
 HoleZeiger:=false;
 UseArray:=false;
 ObjectVar:=false;
 AltTok:=0;
 if tTok in [_plusplus,_minusminus] then begin
  AltTok:=tTok;
  Get;
 end;
 if tTok in [_mul] then begin
  Zeiger:=true;
  Get;
 end;
 if tTok in [_and] then begin
  HoleZeiger:=true;
  Get;
 end;
 if tTok=_not then begin
  Get;
  Factor;
  OutNotAxBoolean;
 end else if tTok=_notbitwise then begin
  Get;
  Factor;
  OutNotAxBitwise;
 end else if tTok=_sizeof then begin
  SizeOfStatement;
  OutIntAxToFPU;
  OutFPUToAx;
 end else if tTok=_inherited then begin
  InheritedStatement;
  if (NameTabelle[AktSymPtr].Typ<>tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
   OutIntAxToFPU;
   OutFPUToAx;
  end;
 end else if tTok=_ident then begin
  if LockVar(sTok,'',A,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end else begin
     ObjectVar:=true;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end else begin
    ObjectVar:=true;
   end;
  end;
  if ObjectVar then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,true,false);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  end else if NameTabelle[AktSymPtr].EinTyp then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,false,false);
   AltSymPtr:=AktSymPtr;
   if (NameTabelle[AltSymPtr].Obj=_call) and (tTok=_lparent) and not HoleZeiger then begin
    I:=CallState(false,true,true);
    if (NameTabelle[I].Typ=tFloat) and not NameTabelle[I].Zeiger then begin
     OutFPUToAX;
    end;
    if (NameTabelle[I].Typ<>tFloat) and not NameTabelle[I].Zeiger then begin
     OutIntAxToFPU;
     OutFPUToAx;
    end;
    IsFloatExpression:=true;
    exit;
   end;
   S:=stok;
  end else begin
   UseEBX:=false;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  end;
  if (tTok=_klparent) and not UseEBX then begin
   UseArray:=true;
   if NameTabelle[AktSymPtr].IstArray then begin
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    if tTok=_krparent then begin
     OutMovCxAx;
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
   end else begin
    SetError(ceKeinArray);
   end;
  end;
  if AltTok in [_plusplus,_minusminus] then begin
   if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
    if UseEBX then begin
     case AltTok of
      _plusplus:begin
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      end;
      _minusminus:begin
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      end;
     end;
    end else begin
     case AltTok of
      _plusplus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
      _minusminus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
     end;
    end;
   end else begin
    if UseEBX then begin
     case AltTok of
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     end;
    end else begin
     case AltTok of
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     end;
    end;
   end;
  end;
  if UseEBX then begin
   if HoleZeiger then begin
    SetError(ceFloatTypeExpected);
   end else begin
    OutMovFromStructVar(AltSymPtr);
    if (NameTabelle[AktSymPtr].Typ<>tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
     OutIntAxToFPU;
     OutFPUToAx;
    end;
   end;
  end else begin
   if HoleZeiger then begin
    SetError(ceFloatTypeExpected);
   end else begin
    OutMovAxVar(S,0,Zeiger,UseArray);
    if (NameTabelle[AktSymPtr].Typ<>tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
     OutIntAxToFPU;
     OutFPUToAx;
    end;
   end;
  end;
  if tTok in [_plusplus,_minusminus] then begin
   if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
    if UseEBX then begin
     case tTok of
      _plusplus:begin
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      end;
      _minusminus:begin
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      end;
     end;
    end else begin
     case tTok of
      _plusplus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
      _minusminus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
     end;
    end;
   end else begin
    if UseEBX then begin
     case tTok of
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     end;
    end else begin
     case tTok of
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     end;
    end;
   end;
   Get;
  end;
  if UseEBX then OutPopBx;
 end else if tTok=_call then begin
  if HoleZeiger then begin
   SetError(ceFloatTypeExpected);
  end else begin
   I:=CallState(true,false,true);
   if (NameTabelle[I].Typ=tFloat) and not NameTabelle[I].Zeiger then begin
    OutFPUToAX;
   end;
   if (NameTabelle[I].Typ<>tFloat) and not NameTabelle[I].Zeiger then begin
    OutIntAxToFPU;
    OutFPUToAx;
   end;
  end;
 end else if tTok=_string then begin
  SetError(ceFloatTypeExpected);
 end else begin
  case tTok of
   _enumvalue:begin
    if LockVar(sTok,'',a,Adr,false,-1) then begin
     OutMovAxImmSigned(NameTabelle[AktSymPtr].Wert);
    end else begin
     SetError(ceVarNotDef);
    end;
    OutIntAxToFPU;
    OutFPUToAx;
   end;
   _integer:begin
    OutMovAxImmSigned(iTok);
    OutIntAxToFPU;
    OutFPUToAx;
   end;
   _floatnum:begin
    OutMovAxImmSigned(longword(pointer(@fTok)^));
   end;
   _lparent:begin
    Get;
    FloatBoolExpression;
    if tTok<>_rparent then SetError(ceRParenExp);
   end;
   else SetError(ceErrInExpr);
  end;
  Get;
 end;
end;

procedure TBeRoScript.FloatTerm;
var op:byte;
begin
 IsFloatExpression:=true;
 FloatFactor;
 while (tTok in [_mul,_div,_mod,_and,_or,_shl,_shr,_xor]) and not (feof or ferror) do begin
  op:=tTok;
  OutPushAx;
  Get;
  FloatFactor;
  case op of
   _mul:begin
    OutPopBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUMul;
    OutPopBx;
    OutFPUToAx;
   end;
   _div:begin
    OutPopBx;
    OutXChgAxBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUDiv;
    OutPopBx;
    OutFPUToAx;
   end;
   _mod:begin
    SetError(ceFloatOperationError);
   end;
   _and:begin
    SetError(ceFloatOperationError);
   end;
   _or:begin
    SetError(ceFloatOperationError);
   end;
   _shl:begin
    SetError(ceFloatOperationError);
   end;
   _shr:begin
    SetError(ceFloatOperationError);
   end;
   _xor:begin
    SetError(ceFloatOperationError);
   end;
  end;
  OutFPUWait;
 end;
end;

procedure TBeRoScript.FloatExpression;
var op:byte;
begin
 IsFloatExpression:=true;
 if tTok in [_plus,_minus] then begin
  OutXorAxAx;
  OutIntAxToFPU;
  OutFPUToAx;
 end else begin
  FloatTerm;
 end;
 while (tTok in [_plus,_minus]) and not (feof or ferror) do begin
  op:=tTok;
  OutPushAx;
  Get;
  FloatTerm;
  case op of
   _plus:begin
    OutPopBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUAdd;
    OutPopBx;
    OutFPUToAx;
   end;
   _minus:begin
    OutPopBx;
    OutXChgAxBx;
    OutAXToFPU;
    OutPushBx;
    OutFPUSub;
    OutPopBx;
    OutFPUToAx;
   end;
  end;
  OutFPUWait;
 end;
end;

procedure TBeRoScript.FloatBoolExpression;
var op:byte;
    SNO,SE:string;
begin
 IsFloatExpression:=true;
 FloatExpression;
 if tTok=_shortif then begin
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutFPUToIntAX;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  FloatBoolExpression;
  OutJMP(SE);
  if tTok=_doublepoint then begin
   Get;
  end else begin
   SetError(ceDoppelPunktErwartet);
  end;
  OutLabel(SNO);
  FloatBoolExpression;
  OutLabel(SE);
 end else if tTok in [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] then begin
  op:=tTok;
  OutPushAx;
  Get;
  FloatExpression;
  OutMovBxAx;
  OutPopAx;
  case op of
   _eql:begin
    OutEql;
    IsFloatExpression:=false;
   end;
   _neg,_isnot:begin
    OutNe;
    IsFloatExpression:=false;
   end;
   _lss:begin
    OutAXToFPU;
    OutPushBx;
    OutFPULss;
    OutPopBx;
    IsFloatExpression:=false;
   end;
   _lea:begin
    OutAXToFPU;
    OutPushBx;
    OutFPULea;
    OutPopBx;
    IsFloatExpression:=false;
   end;
   _gre:begin
    OutAXToFPU;
    OutPushBx;
    OutFPUGre;
    OutPopBx;
    IsFloatExpression:=false;
   end;
   _gra:begin
    OutAXToFPU;
    OutPushBx;
    OutFPUGra;
    OutPopBx;
    IsFloatExpression:=false;
   end;
  end;
  OutFPUWait;
 end;
end;

procedure TBeRoScript.FloatBoolExpressionEx;
var op:byte;
    SNO,SE:string;
begin
 IsFloatExpression:=true;
 if tTok=_shortif then begin
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutFPUToIntAX;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  FloatBoolExpression;
  OutJMP(SE);
  if tTok=_doublepoint then begin
   Get;
  end else begin
   SetError(ceDoppelPunktErwartet);
  end;
  OutLabel(SNO);
  FloatBoolExpression;
  OutLabel(SE);
 end else if tTok in [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] then begin
  op:=tTok;
  OutPushAx;
  Get;
  FloatExpression;
  OutMovBxAx;
  OutPopAx;
  case op of
   _eql:begin
    OutEql;
    IsFloatExpression:=false;
   end;
   _neg,_isnot:begin
    OutNe;
    IsFloatExpression:=false;
   end;
   _lss:begin
    OutAXToFPU;
    OutPushBx;
    OutFPULss;
    OutPopBx;
    IsFloatExpression:=false;
   end;
   _lea:begin
    OutAXToFPU;
    OutPushBx;
    OutFPULea;
    OutPopBx;
    IsFloatExpression:=false;
   end;
   _gre:begin
    OutAXToFPU;
    OutPushBx;
    OutFPUGre;
    OutPopBx;
    IsFloatExpression:=false;
   end;
   _gra:begin
    OutAXToFPU;
    OutPushBx;
    OutFPUGra;
    OutPopBx;
    IsFloatExpression:=false;
   end;
  end;
  OutFPUWait;
 end;
end;

function TBeRoScript.Factor:boolean;
var Adr:TWert;
    S,a,S1,S2:string;
    AltTok:integer;
    Zeiger,HoleZeiger,UseArray,StringArray,ObjectVar:boolean;
    B,LB:longword;
    AltStringHandling:TStringHandling;
    UseEBX:boolean;
    I,AltSymPtr,AltAktSymPtr:integer;
begin
 UseEBX:=false;
 if tTok=_ident then begin
  if LockVar(sTok,'',A,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end;
  end;
  if fError then begin
  end else if not NameTabelle[AktSymPtr].Zeiger then begin
   if NameTabelle[AktSymPtr].Typ=tFloat then begin
    FloatBoolExpression;
    result:=IsFloatExpression;
    exit;
   end;
   if NameTabelle[AktSymPtr].Typ=tString then begin
    IsStringTerm:=true;
    MustBeStringTerm:=false;
    StringLevel:=0;
    StringBoolExpression(true);
    result:=IsFloatExpression;
    exit;
   end;
  end;
 end else if tTok=_floatnum then begin
  FloatBoolExpression;
  result:=IsFloatExpression;
  exit;
 end;
 Zeiger:=false;
 HoleZeiger:=false;
 UseArray:=false;
 ObjectVar:=false;
 AltTok:=0;
 if tTok in [_plusplus,_minusminus] then begin
  AltTok:=tTok;
  Get;
 end;
 if tTok in [_mul] then begin
  Zeiger:=true;
  Get;
 end;
 if tTok in [_and] then begin
  HoleZeiger:=true;
  Get;
 end;
 if tTok=_not then begin
  Get;
  Factor;
  OutNotAxBoolean;
 end else if tTok=_notbitwise then begin
  Get;
  Factor;
  OutNotAxBitwise;
 end else if tTok=_sizeof then begin
  SizeOfStatement;
  if IsFloatExpression then begin
   OutIntAxToFPU;
   OutFPUToAx;
  end;
 end else if tTok=_inherited then begin
  InheritedStatement;
 end else if (tTok=_ident) or ((tTok=_call) and HoleZeiger) then begin
  if LockVar(sTok,'',A,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end else begin
     ObjectVar:=true;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end else begin
    ObjectVar:=true;
   end;
  end;
  if ObjectVar then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,true,false);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  end else if NameTabelle[AktSymPtr].EinTyp then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,false,false);
   AltSymPtr:=AktSymPtr;
   if (NameTabelle[AltSymPtr].Obj=_call) and (tTok=_lparent) and not HoleZeiger then begin
    I:=CallState(false,true,true);
    if NameTabelle[AktSymPtr].Typ=tString then begin
     if NameTabelle[I].Typ<>tString then begin
      SetError(ceStringTypeExpected);
     end;
     IsStringTerm:=true;
     MustBeStringTerm:=false;
     StringLevel:=0;
     StringBoolExpression(true);
     result:=IsFloatExpression;
     exit;
    end else begin
     IsTermSigned:=IsTermSigned or (NameTabelle[I].Typ in [tByte,tChar,tShortInt,tInt]);
     if (NameTabelle[I].Typ=tFloat) and not NameTabelle[I].Zeiger then begin
      OutFPUToAX;
      IsFloatExpression:=true;
     end;
     if IsFloatExpression then begin
      if (NameTabelle[I].Typ<>tFloat) and not NameTabelle[I].Zeiger then begin
       OutIntAxToFPU;
       OutFPUToAx;
      end;
     end else begin
      if (NameTabelle[I].Typ=tFloat) and not NameTabelle[I].Zeiger then begin
       IsFloatExpression:=true;
      end;
     end;
    end;
    result:=IsFloatExpression;
    exit;
   end;
   S:=stok;
  end else begin
   UseEBX:=false;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  end;
  if (tTok=_klparent) and not UseEBX then begin
   UseArray:=true;
   if NameTabelle[AktSymPtr].IstArray then begin
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    if tTok=_krparent then begin
     OutMovCxAx;
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
   end else begin
    SetError(ceKeinArray);
   end;
  end;
  IsTermSigned:=IsTermSigned or (NameTabelle[AltSymPtr].Typ in [tByte,tChar,tShortInt,tInt]);
  if AltTok in [_plusplus,_minusminus] then begin
   if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
    if UseEBX then begin
     case AltTok of
      _plusplus:begin
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      end;
      _minusminus:begin
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      end;
     end;
    end else begin
     case AltTok of
      _plusplus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
      _minusminus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
     end;
    end;
   end else begin
    if UseEBX then begin
     case AltTok of
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     end;
    end else begin
     case AltTok of
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     end;
    end;
   end;
  end;             
  if UseEBX then begin
   if HoleZeiger then begin
    OutMovAxBx;
   end else begin
    OutMovFromStructVar(AltSymPtr);
   end;
  end else begin
   if HoleZeiger then begin
    OutMovAxVarAdr(S,0,Zeiger,UseArray);
   end else begin
    OutMovAxVar(S,0,Zeiger,UseArray);
   end;
  end;
  if (NameTabelle[AktSymPtr].Typ=tString) and not NameTabelle[AktSymPtr].Zeiger then begin
   IsStringTerm:=true;
   MustBeStringTerm:=false;
   StringLevel:=0;
   StringBoolExpression(false);
   result:=IsFloatExpression;
   exit;
  end;
  if tTok in [_plusplus,_minusminus] then begin
   if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
    if UseEBX then begin
     case tTok of
      _plusplus:begin
       OutMovFromStructVar(AltSymPtr);
       OutIncFPU;
       OutMovToStructVar(AltSymPtr);
      end;
      _minusminus:begin
       OutMovFromStructVar(AltSymPtr);
       OutDecFPU;
       OutMovToStructVar(AltSymPtr);
      end;
     end;
    end else begin
     case tTok of
      _plusplus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutIncFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
      _minusminus:begin
       OutMovAxVar(S,0,Zeiger,UseArray);
       OutDecFPU;
       OutMovVarAx(S,0,Zeiger,UseArray);
      end;
     end;
    end;
   end else begin
    if UseEBX then begin
     case tTok of
      _plusplus:OutIncStructVar;
      _minusminus:OutDecStructVar;
     end;
    end else begin
     case tTok of
      _plusplus:OutIncVar(S,Zeiger,UseArray);
      _minusminus:OutDecVar(S,Zeiger,UseArray);
     end;
    end;
   end;
   Get;
  end;
  if UseEBX then OutPopBx;
 end else if tTok=_call then begin
  if not UseEBX then begin
   if LockVar(sTok,'',A,Adr,false,-1) then begin
    if NameTabelle[AktSymPtr].Art=aGlobal then begin
     AltAktSymPtr:=AktSymPtr;
     if LookStructVar(sTok)<0 then begin
      AktSymPtr:=AltAktSymPtr;
     end;
    end;
   end else begin
    if LookStructVar(sTok)<0 then begin
     SetError(ceVarNotDef);
    end;
   end;
  end;
  if HoleZeiger then begin
   OutMovAxVarAdr(S,0,Zeiger,UseArray);
  end else begin
   if NameTabelle[AktSymPtr].Typ=tString then begin
    I:=CallState(true,false,true);
    if NameTabelle[I].Typ<>tString then begin
     SetError(ceStringTypeExpected);
    end;
    IsStringTerm:=true;
    MustBeStringTerm:=false;
    StringLevel:=0;
    StringBoolExpression(true);
    result:=IsFloatExpression;
    exit;
   end else begin
    I:=CallState(true,false,true);
    IsTermSigned:=IsTermSigned or (NameTabelle[I].Typ in [tByte,tChar,tShortInt,tInt]);
    if (NameTabelle[I].Typ=tFloat) and not NameTabelle[I].Zeiger then begin
     OutFPUToAX;
     IsFloatExpression:=true;
    end;
    if IsFloatExpression then begin
     if (NameTabelle[I].Typ<>tFloat) and not NameTabelle[I].Zeiger then begin
      OutIntAxToFPU;
      OutFPUToAx;
     end;
    end else begin
     if (NameTabelle[I].Typ=tFloat) and not NameTabelle[I].Zeiger then begin
      IsFloatExpression:=true;
     end;
    end;
   end;
  end;
 end else if tTok=_string then begin
  if StringHandling.IstZeiger then begin
   StringFactor;
  end else begin
   B:=0;
   LB:=length(AktStr);
   if LB>4 then LB:=4;
   if LB>0 then MOVE(AktStr[1],B,LB);
   OutMovAxImmSigned(B);
   Get;
  end;
 end else begin
  case tTok of
   _enumvalue:begin
    if LockVar(sTok,'',a,Adr,false,-1) then begin
     OutMovAxImmSigned(NameTabelle[AktSymPtr].Wert);
    end else begin
     SetError(ceVarNotDef);
    end;
   end;
   _integer:begin
    OutMovAxImmSigned(iTok);
    IsTermSigned:=IsTermSigned or (iTok<0);
    if IsFloatExpression then begin
     OutIntAXToFPU;
     OutFPUToAX;
    end;
   end;
   _lparent:begin
    Get;
    BoolExpression;
    if tTok<>_rparent then SetError(ceRParenExp);
   end;
   else SetError(ceErrInExpr);
  end;
  Get;
 end;
 result:=IsFloatExpression;
end;

function TBeRoScript.Term:boolean;
var op:byte;
    S:string;
    Adr:TWert;
    BA,BB:boolean;
    AltAktSymPtr:integer;
begin
 if tTok=_ident then begin
  if LockVar(sTok,'',S,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end;
  end;
  if fError then begin
  end else if not NameTabelle[AktSymPtr].Zeiger then begin
   if NameTabelle[AktSymPtr].Typ=tFloat then begin
    FloatBoolExpression;
    result:=IsFloatExpression;
    exit;
   end;
   if NameTabelle[AktSymPtr].Typ=tString then begin
    IsStringTerm:=true;
    MustBeStringTerm:=false;
    StringLevel:=0;
    StringBoolExpression(true);
    result:=IsFloatExpression;
    exit;
   end;
  end;
 end else if tTok=_floatnum then begin
  FloatBoolExpression;
  result:=IsFloatExpression;
  exit;
 end;
 BA:=Factor;
 while (tTok in [_mul,_div,_mod,_and,_or,_shl,_shr,_xor]) and not (feof or ferror) do begin
  op:=tTok;
  OutPushAx;
  Get;
  BB:=Factor;
  if IsFloatExpression then begin
   if not BA then begin
    OutPopBx;
    OutXChgAxBx;
    OutIntAXToFPU;
    OutFPUToAX;
    OutXChgAxBx;
    OutPushBx;
   end;
   if not BB then begin
    OutIntAXToFPU;
    OutFPUToAX;
   end;
   case op of
    _mul:begin
     OutPopBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUMul;
     OutPopBx;
     OutFPUToAx;
    end;
    _div:begin
     OutPopBx;
     OutXChgAxBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUDiv;
     OutPopBx;
     OutFPUToAx;
    end;
    _mod:begin
     SetError(ceFloatOperationError);
    end;
    _and:begin
     SetError(ceFloatOperationError);
    end;
    _or:begin
     SetError(ceFloatOperationError);
    end;
    _shl:begin
     SetError(ceFloatOperationError);
    end;
    _shr:begin
     SetError(ceFloatOperationError);
    end;
    _xor:begin
     SetError(ceFloatOperationError);
    end;
   end;
   OutFPUWait;
  end else begin
   case op of
    _mul:begin
     OutPopBx;
     if IsTermSigned then begin
      OutIMulBx;
     end else begin
      OutMulBx;
     end;
    end;
    _div:begin
     OutMovBxAx;
     OutPopAx;
     if IsTermSigned then begin
      OutIDivBx;
     end else begin
      OutDivBx;
     end;
    end;
    _mod:begin
     OutMovBxAx;
     OutPopAx;
     if IsTermSigned then begin
      OutIModBx;
     end else begin
      OutModBx;
     end;
    end;
    _and:begin
     OutMovBxAx;
     OutPopAx;
     OutAndBx;
    end;
    _or:begin
     OutMovBxAx;
     OutPopAx;
     OutOrBx;
    end;
    _shl:begin
     OutMovBxAx;
     OutPopAx;
     OutShlBx;
    end;
    _shr:begin
     OutMovBxAx;
     OutPopAx;
     OutShrBx;
    end;
    _xor:begin
     OutMovBxAx;
     OutPopAx;
     OutXorBx;
    end;
   end;
  end;
 end;
 result:=IsFloatExpression;
end;

function TBeRoScript.Expression:boolean;
var op:byte;
    S:string;
    Adr:TWert;
    BA,BB:boolean;
    AltAktSymPtr:integer;
begin
 if tTok=_ident then begin
  if LockVar(sTok,'',S,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end;
  end;
  if fError then begin
  end else if not NameTabelle[AktSymPtr].Zeiger then begin
   if NameTabelle[AktSymPtr].Typ=tFloat then begin
    FloatBoolExpression;
    result:=IsFloatExpression;
    exit;
   end;
   if NameTabelle[AktSymPtr].Typ=tString then begin
    IsStringTerm:=true;
    MustBeStringTerm:=false;
    StringLevel:=0;
    StringBoolExpression(true);
    result:=IsFloatExpression;
    exit;
   end;
  end;
 end else if tTok=_floatnum then begin
  FloatBoolExpression;
  result:=IsFloatExpression;
  exit;
 end;
 if tTok in [_plus,_minus] then begin
  OutXorAxAx;
  BA:=false;
  IsTermSigned:=IsTermSigned or (tTok=_minus);
 end else begin
  BA:=Term;
 end;
 while (tTok in [_plus,_minus]) and not (feof or ferror) do begin
  op:=tTok;
  OutPushAx;
  Get;
  BB:=Term;
  if IsFloatExpression then begin
   if not BA then begin
    OutPopBx;
    OutXChgAxBx;
    OutIntAXToFPU;
    OutFPUToAX;
    OutXChgAxBx;
    OutPushBx;
   end;
   if not BB then begin
    OutIntAXToFPU;
    OutFPUToAX;
   end;
   case op of
    _plus:begin
     OutPopBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUAdd;
     OutPopBx;
     OutFPUToAx;
    end;
    _minus:begin
     OutPopBx;
     OutXChgAxBx;
     OutAXToFPU;
     OutPushBx;
     OutFPUSub;
     OutPopBx;
     OutFPUToAx;
    end;
   end;
   OutFPUWait;
  end else begin
   case op of
    _plus:begin
     OutPopBx;
     OutAddAxBx;
    end;
    _minus:begin
     OutMovBxAx;
     OutPopAx;
     OutSubAxBx;
    end;
   end;
  end;
 end;
 result:=IsFloatExpression;
end;

function TBeRoScript.BoolExpression:boolean;
var op:byte;
    S,SNO,SE:string;
    Adr:TWert;
    Skip,BA,BB:boolean;
    AltAktSymPtr:integer;
begin
 Skip:=false;
 if tTok=_ident then begin
  if LockVar(sTok,'',S,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end;
  end;
  if fError then begin
  end else if not NameTabelle[AktSymPtr].Zeiger then begin
   if NameTabelle[AktSymPtr].Typ=tFloat then begin
    FloatBoolExpression;
    result:=IsFloatExpression;
    exit;
   end;
   if NameTabelle[AktSymPtr].Typ=tString then begin
    IsStringTerm:=true;
    MustBeStringTerm:=false;
    StringLevel:=0;
    StringBoolExpression(true);
    if IsStringTerm then begin
     result:=IsFloatExpression;
     exit;
    end;
    Skip:=true;
   end;
  end;
 end else if tTok=_floatnum then begin
  FloatBoolExpression;
  result:=IsFloatExpression;
  exit;
 end;
 if Skip then begin
  BA:=IsFloatExpression;
 end else begin
  BA:=Expression;
 end;
 if IsFloatExpression and (tTok in [_eql,_neg,_lss,_lea,_gre,_gra,_isnot]) then begin
  FloatBoolExpressionEx;
  result:=IsFloatExpression;
  exit;
 end;
 if tTok=_shortif then begin
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  BoolExpression;
  OutJMP(SE);
  if tTok=_doublepoint then begin
   Get;
  end else begin
   SetError(ceDoppelPunktErwartet);
  end;
  OutLabel(SNO);
  BoolExpression;
  OutLabel(SE);
 end else if tTok in [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] then begin
  op:=tTok;
  OutPushAx;
  Get;
  BB:=Expression;
  OutMovBxAx;
  OutPopAx;
  if IsFloatExpression then begin
   if not BA then begin
    OutPopBx;
    OutXChgAxBx;
    OutIntAXToFPU;
    OutFPUToAX;
    OutXChgAxBx;
    OutPushBx;
   end;
   if not BB then begin
    OutIntAXToFPU;
    OutFPUToAX;
   end;
   case op of
    _eql:OutEql;
    _neg,_isnot:OutNe;
    _lss:begin
     OutAXToFPU;
     OutPushBx;
     OutFPULss;
     OutPopBx;
    end;
    _lea:begin
     OutAXToFPU;
     OutPushBx;
     OutFPULea;
     OutPopBx;
    end;
    _gre:begin
     OutAXToFPU;
     OutPushBx;
     OutFPUGre;
     OutPopBx;
    end;
    _gra:begin
     OutAXToFPU;
     OutPushBx;
     OutFPUGra;
     OutPopBx;
    end;
   end;
   OutFPUWait;
  end else begin
   case op of
    _eql:OutEql;
    _neg,_isnot:OutNe;
    _lss:OutLss;
    _lea:OutLea;
    _gre:OutGre;
    _gra:OutGra;
   end;
  end;
 end;
 result:=IsFloatExpression;
end;

procedure TBeRoScript.StringFactor;
var Adr:TWert;
    S,a,S1,S2:string;
    AltTok:integer;
    Zeiger,HoleZeiger,UseArray,StringArray:boolean;
    B,LB:longword;
    AltStringHandling:TStringHandling;
    UseEBX:boolean;
    I,AltSymPtr,AltAktSymPtr:integer;
    AltMustBeStringTerm,ObjectVar:boolean;
begin
 IsStringTerm:=true;
 Zeiger:=false;
 HoleZeiger:=false;
 UseArray:=false;
 StringArray:=false;
 ObjectVar:=false;
 AltTok:=0;
 if tTok in [_plusplus,_minusminus] then begin
  AltTok:=tTok;
  Get;
 end;
 if tTok in [_mul] then begin
  Zeiger:=true;
  Get;
 end;
 if tTok in [_and] then begin
  HoleZeiger:=true;
  Get;
 end;
 if tTok=_not then begin
  Get;
  StringFactor;
  SetError(ceIllegalStringOperation);
 end else if tTok=_notbitwise then begin
  Get;
  StringFactor;
  OutNotAxBitwise;
  SetError(ceIllegalStringOperation);
 end else if tTok=_inherited then begin
  InheritedStatement;
  if NameTabelle[AktSymPtr].Typ=tChar then begin
   OutStrCharConvert;
  end else if NameTabelle[AktSymPtr].Typ<>tString then begin
   SetError(ceStringTypeExpected);
  end else begin
   OutStrIncrease;
   IsStringTerm:=true;
  end;
 end else if (tTok=_ident) or ((tTok=_call) and HoleZeiger) then begin
  if LockVar(sTok,'',A,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end else begin
     ObjectVar:=true;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end else begin
    ObjectVar:=true;
   end;
  end;
  if ObjectVar then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,true,false);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  end else if NameTabelle[AktSymPtr].EinTyp then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,false,false);
   AltSymPtr:=AktSymPtr;
   if (NameTabelle[AltSymPtr].Obj=_call) and (tTok=_lparent) and not HoleZeiger then begin
    I:=CallState(false,true,true);
    if NameTabelle[I].Typ=tChar then begin
     OutStrCharConvert;
    end else if NameTabelle[I].Typ<>tString then begin
     SetError(ceStringTypeExpected);
    end else begin
     OutStrIncrease;
     IsStringTerm:=true;
    end;
    exit;
   end;
   S:=stok;
  end else begin
   UseEBX:=false;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  end;
  if (tTok=_klparent) and not UseEBX then begin
   UseArray:=true;
   if NameTabelle[AktSymPtr].IstArray then begin
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    if tTok=_krparent then begin
     OutMovCxAx;
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
   end else if (NameTabelle[AktSymPtr].Typ=tString) and not HoleZeiger then begin
    if UseEBX then begin
     OutMovAxBx;
    end else begin
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
    end;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    if tTok=_krparent then begin
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
    OutMovEAXStruct(4);
    OutPushAx;
    OutPushBx;
    OutCallNative('charat');
    StringArray:=true;
    if MustBeStringTerm then begin
     OutStrCharConvert;
    end else begin
     IsStringTerm:=false;
    end;
   end else begin
    SetError(ceKeinArray);
   end;
  end;
  IsTermSigned:=IsTermSigned or (NameTabelle[AltSymPtr].Typ in [tByte,tChar,tShortInt,tInt]);
  if AltTok in [_plusplus,_minusminus] then begin
   SetError(ceIllegalStringOperation);
  end;
  if not StringArray then begin
   if UseEBX then begin
    if HoleZeiger then begin
     OutMovAxBx;
    end else begin
     OutMovFromStructVar(AltSymPtr);
    end;
   end else begin
    if HoleZeiger then begin
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
    end else begin
     OutMovAxVar(S,0,Zeiger,UseArray);
    end;
   end;
   if NameTabelle[AltSymPtr].Typ=tChar then begin
    OutStrCharConvert;
   end else if NameTabelle[AltSymPtr].Typ<>tString then begin
    SetError(ceStringTypeExpected);
   end else begin
    OutStrIncrease;
   end;
  end;
  if tTok in [_plusplus,_minusminus] then begin
   SetError(ceIllegalStringOperation);
   Get;
  end;
  if UseEBX then OutPopBx;
 end else if tTok=_call then begin
  if HoleZeiger then begin
   SetError(ceStringTypeExpected);
  end else begin
   I:=CallState(true,false,true);
   if NameTabelle[I].Typ=tChar then begin
    OutStrCharConvert;
   end else if NameTabelle[I].Typ<>tString then begin
    SetError(ceStringTypeExpected);
   end else begin
    OutStrIncrease;
    IsStringTerm:=true;
   end;
  end;
 end else if tTok=_string then begin
  S1:=GeneratiereLabel;
  S2:=GeneratiereLabel;
  OutJmp(S1);
  DWordHinzufuegen(length(AktStr));
{$IFDEF FPC}
  DWordHinzufuegen(length(AktStr));
  DWordHinzufuegen($ffffffff);
{$ELSE}
  DWordHinzufuegen($ffffffff);
  DWordHinzufuegen(length(AktStr));
{$ENDIF}
  OutLabel(S2);
  for LB:=1 to length(AktStr) do ByteHinzufuegen(byte(AktStr[LB]));
  ByteHinzufuegen(0);
  OutLabel(S1);
  OutMovAxImmLabel(S2);
  Get;
 end else begin
  case tTok of
   _enumvalue:begin
    SetError(ceStringExpected);
   end;
   _integer:begin
    SetError(ceStringExpected);
   end;
   _lparent:begin
    Get;
    StringLevel:=0;
    MustBeStringTerm:=true;
    StringExpression(true);
    if tTok<>_rparent then SetError(ceRParenExp);
   end;
   else SetError(ceErrInExpr);
  end;
  Get;
 end;
end;

procedure TBeRoScript.StringTerm;
var op:byte;
    S:string;
    Adr:integer;
begin
 IsStringTerm:=true;
 StringFactor;
 if IsStringTerm then begin
  while (tTok in [_mul,_div,_mod,_and,_or,_shl,_shr,_xor]) and not (feof or ferror) do begin
   MustBeStringTerm:=true;
   op:=tTok;
   OutPushAx;
   Get;
   StringFactor;
   SetError(ceIllegalStringOperation);
  end;
 end;
end;

procedure TBeRoScript.StringExpression(Standalone:boolean);
var op:byte;
    S:string;
    Adr:integer;
begin
 IsStringTerm:=true;
 inc(StringLevel);
 if Standalone then begin
  if tTok in [_plus,_minus] then begin
   OutXorAxAx;
  end else begin
   StringTerm;
  end;
 end;
 if IsStringTerm then begin
  while (tTok in [_plus,_minus]) and not (feof or ferror) do begin
   op:=tTok;
   OutPushAx;
   Get;
   MustBeStringTerm:=true;
   StringTerm;
   case op of
    _plus:begin
     OutPopBx;
     OutPushAx;
     S:=GetStringLevelVariableName;
     OutMovAxVar(S,0,false,false);
     OutStrDecrease;
     OutMovVarAx(S,0,false,false);
     OutPushAx;
     OutPopCx;
     OutPopAx;
     OutStrConcat;
    end;
    _minus:begin
     SetError(ceIllegalStringOperation);
    end;
   end;
  end;
 end;
end;

procedure TBeRoScript.StringBoolExpression(Standalone:boolean);
var op:byte;
    S,SNO,SE:string;
    Adr:TWert;
    ShortIfOk,BA,BB:boolean;
    AltAktSymPtr:integer;
begin
 ShortIfOk:=false;
 if Standalone then begin
  if tTok=_integer then begin
   ShortIfOk:=true;
  end else if tTok=_ident then begin
   if LockVar(sTok,'',S,Adr,false,-1) then begin
    if NameTabelle[AktSymPtr].Art=aGlobal then begin
     AltAktSymPtr:=AktSymPtr;
     if LookStructVar(sTok)<0 then begin
      AktSymPtr:=AltAktSymPtr;
     end;
    end;
    if not NameTabelle[AktSymPtr].Zeiger then begin
     if NameTabelle[AktSymPtr].Typ=tFloat then begin
      DoExpressionEx;
      ShortIfOk:=true;
     end;
    end;
   end else begin
    if LookStructVar(sTok)<0 then begin
     SetError(ceVarNotDef);
    end;
   end;
  end;
 end;
 if not ShortIfOk then StringExpression(Standalone);
 if (tTok=_shortif) and ShortIfOk then begin
  Get;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  StringExpression(true);
  OutJMP(SE);
  if tTok=_doublepoint then begin
   Get;
  end else begin
   SetError(ceDoppelPunktErwartet);
  end;
  OutLabel(SNO);
  StringExpression(true);
  OutLabel(SE);
 end else if tTok in [_eql,_neg,_lss,_lea,_gre,_gra,_isnot] then begin
  op:=tTok;
  OutPushAx;
  Get;
  StringExpression(true);
  IsStringTerm:=false;
  OutMovBxAx;
  OutPopAx;
  case op of
   _eql:OutStrEql;
   _neg,_isnot:OutStrNe;
   _lss:OutStrLss;
   _lea:OutStrLea;
   _gre:OutStrGre;
   _gra:OutStrGra;
  end;
 end;
end;

procedure TBeRoScript.StructFactor;
var Adr:TWert;
    S,a,S1,S2:string;
    AltTok:integer;
    Zeiger,HoleZeiger,UseArray,StringArray,ObjectVar:boolean;
    B,LB:longword;
    AltStringHandling:TStringHandling;
    UseEBX:boolean;
    I,AltSymPtr,AltAktSymPtr:integer;
begin
 Zeiger:=false;
 HoleZeiger:=false;
 UseArray:=false;
 ObjectVar:=false;
 AltTok:=0;
 if tTok in [_plusplus,_minusminus] then begin
  AltTok:=tTok;
  Get;
 end;
 if tTok in [_mul] then begin
  Zeiger:=true;
  Get;
 end;
 if tTok in [_and] then begin
  SetError(ceIllegalStructOperation);
  HoleZeiger:=true;
  Get;
 end;
 if tTok=_not then begin
  Get;
  StringFactor;
  SetError(ceIllegalStructOperation);
 end else if tTok=_notbitwise then begin
  Get;
  StringFactor;
  OutNotAxBitwise;
  SetError(ceIllegalStructOperation);
 end else if tTok=_inherited then begin
  InheritedStatement;
  if NameTabelle[AktSymPtr].Typ<>tType then begin
   SetError(ceStructExpected);
  end;
 end else if (tTok=_ident) or ((tTok=_call) and HoleZeiger) then begin
  if LockVar(sTok,'',A,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Art=aGlobal then begin
    AltAktSymPtr:=AktSymPtr;
    if LookStructVar(sTok)<0 then begin
     AktSymPtr:=AltAktSymPtr;
    end else begin
     ObjectVar:=true;
    end;
   end;
  end else begin
   if LookStructVar(sTok)<0 then begin
    SetError(ceVarNotDef);
   end else begin
    ObjectVar:=true;
   end;
  end;
  if ObjectVar then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,true,false);
   AltSymPtr:=AktSymPtr;
   S:=stok;
  end else if NameTabelle[AktSymPtr].EinTyp then begin
   OutPushBx;
   UseEBX:=true;
   StringArray:=StructAssignment(Zeiger,false,false,false);
   AltSymPtr:=AktSymPtr;
   if (NameTabelle[AltSymPtr].Obj=_call) and (tTok=_lparent) and not HoleZeiger then begin
    I:=CallState(false,true,true);
    if NameTabelle[I].Typ<>tType then begin
     SetError(ceStructExpected);
    end;
    exit;
   end;
   S:=stok;
  end else begin
   UseEBX:=false;
   AltSymPtr:=AktSymPtr;
   S:=stok;
   Get;
  end;
  if (tTok=_klparent) and not UseEBX then begin
   UseArray:=true;
   if NameTabelle[AktSymPtr].IstArray then begin
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    if tTok=_krparent then begin
     OutMovCxAx;
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
   end else begin
    SetError(ceKeinArray);
   end;
  end;
  IsTermSigned:=IsTermSigned or (NameTabelle[AltSymPtr].Typ in [tByte,tChar,tShortInt,tInt]);
  if AltTok in [_plusplus,_minusminus] then begin
   SetError(ceIllegalStructOperation);
  end;
  if UseEBX then begin
   OutMovAxBx;
   OutPopBx;
  end else begin
   OutMovAxVarAdr(S,0,Zeiger,UseArray);
  end;
  if TypTabelle[NameTabelle[AktProc].TypLink].Size in [1,2,4] then begin
   OutMovEAXStruct(TypTabelle[NameTabelle[AktProc].TypLink].Size);
  end;
  if tTok in [_plusplus,_minusminus] then begin
   SetError(ceIllegalStringOperation);
   Get;
  end;
 end else if tTok=_call then begin
  if HoleZeiger then begin
   SetError(ceStringTypeExpected);
  end else begin
   I:=CallState(true,false,true);
   if NameTabelle[I].Typ<>tType then begin
    SetError(ceStructExpected);
   end;
  end;
 end else if tTok=_string then begin
  SetError(ceIllegalStructOperation);
  Get;
 end else begin
  case tTok of
   _enumvalue:begin
    SetError(ceStructExpected);
   end;
   _integer:begin
    SetError(ceStructExpected);
   end;
   _lparent:begin
    SetError(ceIllegalStructOperation);
   end;
   else SetError(ceErrInExpr);
  end;
  Get;
 end;
end;

procedure TBeRoScript.PrntStatement;
 procedure Teil;
 var S,a:string;
     Adr:TWert;
     CharVerarbeiten,StringVerarbeiten,LongStringVerarbeiten:boolean;
     AltAktSymPtr:integer;
 begin
  Get;
  if tTok=_string then begin
   StringFactor;
   OutWrtStr;
  end else begin
   CharVerarbeiten:=false;
   StringVerarbeiten:=false;
   LongStringVerarbeiten:=false;
   if tTok in [_ident,_call] then begin
    if not LockVar(sTok,'',a,Adr,false,-1) then begin
     if LookStructVar(sTok)<0 then begin
      SetError(ceVarNotDef);
     end;
    end else begin
     if NameTabelle[AktSymPtr].Art=aGlobal then begin
      AltAktSymPtr:=AktSymPtr;
      if LookStructVar(sTok)<0 then begin
       AktSymPtr:=AltAktSymPtr;
      end;
     end;
    end;
    S:=sTok;
    if (NameTabelle[AktSymPtr].Typ in [tuChar,tChar]) and not NameTabelle[AktSymPtr].Zeiger then CharVerarbeiten:=true;
    if NameTabelle[AktSymPtr].Zeiger and (NameTabelle[AktSymPtr].Typ in [tuChar,tChar]) then StringVerarbeiten:=true;
    if NameTabelle[AktSymPtr].Typ=tString then LongStringVerarbeiten:=true;
   end;
   MustBeStringTerm:=false;
   if LongStringVerarbeiten then begin
    IsStringTerm:=true;
    StringLevel:=0;
    StringBoolExpression(true);
    if IsStringTerm then begin
     OutWrtStr;
    end else begin
     OutWrtChar;
    end;
   end else if StringVerarbeiten then begin
    StringHandling.IstZeiger:=true;
    IsTermSigned:=false;
    DoExpressionEx;
    OutWrtPCharString;
   end else if CharVerarbeiten then begin
    IsTermSigned:=false;
    DoExpressionEx;
    OutWrtChar;
   end else begin
    StringHandling.IstZeiger:=true;
    IsTermSigned:=false;
    IsStringTerm:=false;
    DoExpression;
    if tTok=_ident then begin
     if IsStringTerm then begin
      OutWrtStr;
     end else if (NameTabelle[AktSymPtr].Typ=tString) and not NameTabelle[AktSymPtr].Zeiger then begin
      OutWrtStr;
     end else if NameTabelle[AktSymPtr].Zeiger and (NameTabelle[AktSymPtr].Typ in [tuChar,tChar]) then begin
      OutWrtPCharString;
     end else if NameTabelle[AktSymPtr].Typ in [tuChar,tChar] then begin
      OutWrtChar;
     end else begin
      if IsStringTerm then begin
       OutWrtStr;
      end else begin
       if IsFloatExpression then begin
        OutWrtFloatAX;
       end else begin
        if IsTermSigned then begin
         OutWrtAXSigned;
        end else begin
         OutWrtAXUnsigned;
        end;
       end;
      end;
     end;
    end else begin
     if IsStringTerm then begin
      OutWrtStr;
     end else begin
      if IsFloatExpression then begin
       OutWrtFloatAX;
      end else begin
       if IsTermSigned then begin
        OutWrtAXSigned;
       end else begin
        OutWrtAXUnsigned;
       end;
      end;
     end;
    end;
   end;
  end;
 end;
begin
 Get;
 if tTok=_lparent then begin
  Teil;
  while (tTok=_comma) and not (feof or ferror) do begin
   Teil;
  end;
  if tTok=_rparent then begin
   Get;
  end else begin
   SetError(ceRParenExp);
  end;
 end else begin
  SetError(ceLParenExp);
 end;
end;

procedure TBeRoScript.DoExpression;
begin
 IsStringTerm:=false;
 MustBeStringTerm:=false;
 IsFloatExpression:=false;
 BoolExpression;
end;

procedure TBeRoScript.DoExpressionEx;
var StringHandlingIstZeigerAlt,IsStringTermAlt,MustBeStringTermAlt,
    IsFloatExpressionAlt:boolean;
begin
 StringHandlingIstZeigerAlt:=StringHandling.IstZeiger;
 IsStringTermAlt:=IsStringTerm;
 MustBeStringTermAlt:=MustBeStringTerm;
 IsFloatExpressionAlt:=IsFloatExpression;
 DoExpression;
 StringHandling.IstZeiger:=StringHandlingIstZeigerAlt;
 IsStringTerm:=IsStringTermAlt;
 MustBeStringTerm:=MustBeStringTermAlt;
 IsFloatExpression:=IsFloatExpressionAlt;
end;

procedure TBeRoScript.ASMStatement;
var l:ansistring;
    ch:char;
begin
 Get;
 if tTok=_begin then begin
  l:='';
  ch:=LeseNaechstesZeichen;
  while (ch<>'}') and not (feof or ferror) do begin
   if ch=#10 then begin
    inc(QuelltextZeile);
    QuelltextSpalte:=0;
//  SchreibeZeileAssembler(l,TRUE);
    l:='';
   end else if ch=#13 then begin
   end else begin
    l:=l+ch;
    inc(QuelltextSpalte);
   end;
   ch:=LeseNaechstesZeichen;
  end;
// SchreibeZeileAssembler(l,TRUE);
  Get;
 end;
end;

procedure TBeRoScript.ReturnStatement;
begin
 Get;
 StringHandling.IstZeiger:=false;
 if tTok<>_semicolon then begin
  if (NameTabelle[AktProc].Typ=tString) and not NameTabelle[AktProc].Zeiger then begin
   StringLevel:=0;
   MustBeStringTerm:=true;
   StringBoolExpression(true);
   OutStrUnique;
   OutMovVarAx(tnFunctionResult,0,true,false);
  end else if (NameTabelle[AktProc].Typ=tType) and not NameTabelle[AktProc].Zeiger then begin
   StructFactor;
   if not (TypTabelle[NameTabelle[AktProc].TypLink].Size in [1,2,4]) then begin
    OutMovBxAx;
    OutMovAxVar(tnFunctionResult,0,false,false);
    OutMoveFromEBXToEAX(TypTabelle[NameTabelle[AktProc].TypLink].Size);
    OutAddESP(TypTabelle[NameTabelle[AktProc].TypLink].Size);
   end;
  end else begin
   IsFloatExpression:=false;
   IsTermSigned:=NameTabelle[AktProc].Typ in [tByte,tChar,tShortInt,tInt];
   DoExpression;
   if (NameTabelle[AktProc].Typ=tFloat) and not NameTabelle[AktProc].Zeiger then begin
    if not IsFloatExpression then begin
     OutIntAXToFPU;
     OutFPUToAX;
    end
   end else begin
    if IsFloatExpression then begin
     SetError(ceWrongType);
    end;
   end;
  end;
 end;
 if AktProc>=0 then begin
  OutJmp('Return'+NameTabelle[AktProc].AsmVarName);
 end else begin
  OutRet;
 end;
end;

procedure TBeRoScript.Assignment;
var adr:TWert;
    I,AltTok,OldTok:integer;
    B,c,Zeiger,UseArray:boolean;
    S,a,SNO,SE,S1,S2:string;
    AltStringHandling:TStringHandling;
    AltSymPtr,AltAktSymPtr:integer;
    UseEBX:boolean;
    EBXZeiger,StringArray,AltMustBeStringTerm,ObjectVar:boolean;
begin
 AltTok:=0;
 OldTok:=0;
 B:=false;
 c:=false;
 StringHandling.IstZeiger:=false;
 Zeiger:=false;
 UseArray:=false;
 EBXZeiger:=false;
 StringArray:=false;
 ObjectVar:=false;
 if tTok in [_plusplus,_minusminus] then begin
  AltTok:=tTok;
  Get;
 end;
 if tTok=_mul then begin
  Zeiger:=true;
  Get;
  StringHandling.IstZeiger:=true;
 end;
 if LockVar(sTok,'',A,Adr,false,-1) then begin
  if NameTabelle[AktSymPtr].Art=aGlobal then begin
   AltAktSymPtr:=AktSymPtr;
   if LookStructVar(sTok)<0 then begin
    AktSymPtr:=AltAktSymPtr;
   end else begin
    ObjectVar:=true;
   end;
  end;
 end else begin
  if LookStructVar(sTok)<0 then begin
   SetError(ceVarNotDef);
  end else begin
   ObjectVar:=true;
  end;
 end;
 if fError then exit;
 if ObjectVar then begin
  OutPushBx;
  UseEBX:=true;
  StringArray:=StructAssignment(Zeiger,false,true,false);
  AltSymPtr:=AktSymPtr;
  S:=stok;
 end else if NameTabelle[AktSymPtr].EinTyp then begin
  UseEBX:=true;
  StringArray:=StructAssignment(Zeiger,true,false,false);
  AltSymPtr:=AktSymPtr;
  S:=stok;
  EBXZeiger:=NameTabelle[AltSymPtr].Zeiger;
 end else begin
  UseEBX:=false;
  AltSymPtr:=AktSymPtr;
  S:=stok;
  Get;
 end;
 if (NameTabelle[AltSymPtr].Obj=_call) and (tTok=_lparent) then begin
  if NameTabelle[AltSymPtr].Zeiger then begin
   if Zeiger then begin
    if UseEBX then begin
     OutMovFromStructVar(AltSymPtr);
    end else begin
     OutMovAxVar(S,0,false,UseArray);
     OutMovBxAx;
    end;
    I:=CallState(false,true,true);
    exit;
   end;
  end else begin
   I:=CallState(false,UseEBX,true);
   exit;
  end;
 end else if NameTabelle[AltSymPtr].Zeiger and (NameTabelle[AltSymPtr].Typ in [tuChar,tChar]) then begin
  if not Zeiger then begin
   StringHandling.IstZeiger:=true;
  end else begin
   StringHandling.IstZeiger:=false;
  end;
 end;
 if tTok=_klparent then begin
  if NameTabelle[AltSymPtr].Zeiger and (NameTabelle[AltSymPtr].Typ in [tuChar,tChar]) then begin
   StringHandling.IstZeiger:=false;
   if not Zeiger then Zeiger:=true;
  end;
  if not UseEBX then begin
   if NameTabelle[AktSymPtr].IstArray then begin
    UseArray:=true;
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    DoExpressionEx;
    StringHandling:=AltStringHandling;
    if tTok=_krparent then begin
     OutMovCxAx;
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
   end else if NameTabelle[AktSymPtr].Typ=tString then begin
    if UseEBX then begin
     OutMovAxBx;
    end else begin
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
    end;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    if tTok=_krparent then begin
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
    OutMovEAXStruct(4);
    OutPushAx;
    OutPushBx;
    OutCallNative('charpointerat');
    OutMovBxAx;
    StringArray:=true;
   end else begin
    SetError(ceKeinArray);
   end;
  end else begin
   SetError(ceKeinArray);
  end;
 end;
 if tTok=_set then begin
  Get;
  B:=true;
 end else if tTok=_shortif then begin
  Get;
  if UseEBX then begin
   OutMovFromStructVar(AltSymPtr);
  end else begin
   OutMovAxVar(S,0,Zeiger,UseArray);
  end;
  SNO:=GeneratiereLabel;
  SE:=GeneratiereLabel;
  OutXorBxBx;
  OutNe;
  OutJZIF(SNO);
  Statement(false);
  OutJMP(SE);
  if tTok=_doublepoint then begin
   Get;
  end else begin
   SetError(ceDoppelPunktErwartet);
  end;
  OutLabel(SNO);
  Statement(false);
  OutLabel(SE);
  B:=false;
 end else if tTok in [_plus,_minus,_mul,_div,_and,_or,_mod,_shl,_shr,_xor] then begin
  OldTok:=tTok;
  Get;
  if tTok=_set then begin
   Get;
   B:=true;
   c:=true;
  end else begin
   SetError(ceExpectSet);
  end;
 end else if tTok in [_plusplus,_minusminus] then begin
  if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
   if UseEBX then begin
    case tTok of
     _plusplus:begin
      OutMovFromStructVar(AltSymPtr);
      OutIncFPU;
      OutMovToStructVar(AltSymPtr);
     end;
     _minusminus:begin
      OutMovFromStructVar(AltSymPtr);
      OutDecFPU;
      OutMovToStructVar(AltSymPtr);
     end;
    end;
   end else begin
    case tTok of
     _plusplus:begin
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutIncFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     end;
     _minusminus:begin
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutDecFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     end;
    end;
   end;
  end else begin
   if UseEBX then begin
    case tTok of
     _plusplus:OutIncStructVar;
     _minusminus:OutDecStructVar;
    end;
   end else begin
    case tTok of
     _plusplus:OutIncVar(S,Zeiger,UseArray);
     _minusminus:OutDecVar(S,Zeiger,UseArray);
    end;
   end;
  end;
  Get;
 end else if AltTok in [_plusplus,_minusminus] then begin
  if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
   if UseEBX then begin
    case AltTok of
     _plusplus:begin
      OutMovFromStructVar(AltSymPtr);
      OutIncFPU;
      OutMovToStructVar(AltSymPtr);
     end;
     _minusminus:begin
      OutMovFromStructVar(AltSymPtr);
      OutDecFPU;
      OutMovToStructVar(AltSymPtr);
     end;
    end;
   end else begin
    case AltTok of
     _plusplus:begin
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutIncFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     end;
     _minusminus:begin
      OutMovAxVar(S,0,Zeiger,UseArray);
      OutDecFPU;
      OutMovVarAx(S,0,Zeiger,UseArray);
     end;
    end;
   end;
  end else begin
   if UseEBX then begin
    case AltTok of
     _plusplus:OutIncStructVar;
     _minusminus:OutDecStructVar;
    end;
   end else begin
    case AltTok of
     _plusplus:OutIncVar(S,Zeiger,UseArray);
     _minusminus:OutDecVar(S,Zeiger,UseArray);
    end;
   end;
  end;
 end else begin
  SetError(ceExpectSet);
 end;
 if B and StringArray then begin
  IsTermSigned:=false;
  if UseArray then OutPushCX;
  DoExpression;
  if UseArray then OutPopCX;
  S1:=GeneratiereLabel;
  S2:=GeneratiereLabel;
  OutJzIfBx(S2);
  OutJmp(S1);
  OutLabel(S1);
  OutMovVarEBXAx(0,1);
  OutLabel(S2);
 end else if B and (NameTabelle[AltSymPtr].Typ=tType) and not NameTabelle[AltSymPtr].Zeiger then begin
  if UseEBX then OutPushBX;
  if UseArray then OutPushCX;
  StructFactor;
  if UseArray then OutPopCX;
  if c then begin
   SetError(ceIllegalStructOperation);
  end else begin
   if TypTabelle[NameTabelle[AltSymPtr].TypLink].Size in [1,2,4] then begin
    if UseEBX then begin
     OutPopBX;
     OutXChgAxBx;
    end else begin
     OutMovBxAx;
     if UseArray then OutPushCX;
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
     if UseArray then OutPopCX;
    end;
    OutMovEBXEAXStruct(NameTabelle[AltSymPtr].Size);
   end else begin
    if UseEBX then begin
     OutPopBX;
     OutXChgAxBx;
    end else begin
     OutMovBxAx;
     if UseArray then OutPushCX;
     OutMovAxVarAdr(S,0,Zeiger,UseArray);
     if UseArray then OutPopCX;
    end;
    OutMoveFromEBXtoEAX(NameTabelle[AltSymPtr].Size);
   end;
  end;
 end else if B and (NameTabelle[AltSymPtr].Typ=tString) then begin
  if UseEBX then OutPushBX;
  StringLevel:=0;
  MustBeStringTerm:=true;
  if UseArray then OutPushCX;
  StringBoolExpression(true);
  if UseArray then OutPopCX;
  if c then begin
   if UseEBX then begin
    case OldTok of
     _plus:begin
      OutMovCxBx;
      OutMovBxAx;
      OutPushBx;
      OutMovBxCx;
      OutMovFromStructVar(AltSymPtr);
      OutPopBx;
      OutPushCx;
      OutStrSelfConcat;
      OutPopCx;
      OutMovBxCx;
      OutMovToStructVar(AltSymPtr);
     end;
     else SetError(ceIllegalStringOperation);
    end;
   end else begin
    case OldTok of
     _plus:begin
      OutMovBxAx;
      if UseArray then OutPushCX;
      OutMovAxVar(S,0,Zeiger,UseArray);
      if UseArray then OutPopCX;
      if UseArray then OutPushCX;
      OutStrSelfConcat;
      if UseArray then OutPopCX;
      if UseArray then OutPushCX;
      OutMovVarAx(S,0,Zeiger,UseArray);
      if UseArray then OutPopCX;
     end;
     else SetError(ceIllegalStringOperation);
    end;
   end;
  end else begin
   if UseEBX then begin
    OutPopBx;
    OutPushBx;
    OutPushAx;
    OutMovFromStructVar(AltSymPtr);
    OutPushBx;
    OutStrDecrease;
    OutPopBx;
    OutPopAx;
    OutMovToStructVar(AltSymPtr);
   end else begin
    OutPushAx;
    if UseArray then OutPushCX;
    OutMovAxVar(S,0,Zeiger,UseArray);
    if UseArray then OutPopCX;
    if UseArray then OutPushCX;
    OutStrDecrease;
    if UseArray then OutPopCX;
    OutPopAx;
    if UseArray then OutPushCX;
    OutMovVarAx(S,0,Zeiger,UseArray);
    if UseArray then OutPopCX;
   end;
  end;
 end else if B then begin
  if UseEBX then OutPushBX;
  if UseArray then OutPushCX;
  if (not NameTabelle[AltSymPtr].Zeiger) and (NameTabelle[AltSymPtr].Typ=tFloat) then begin
   FloatBoolExpression;
  end else begin
   IsTermSigned:=NameTabelle[AltSymPtr].Typ in [tByte,tChar,tShortInt,tInt];
   DoExpression;
  end;
  if UseArray then OutPopCX;
  if c then begin
   if (NameTabelle[AktSymPtr].Typ=tFloat) and not NameTabelle[AktSymPtr].Zeiger then begin
    if UseEBX then begin
     case OldTok of
      _plus:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUAdd;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _minus:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUSub;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _mul:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUMul;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _div:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAXToFPU;
       OutPushBx;
       OutFPUDiv;
       OutPopBx;
       OutFPUToAx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      else SetError(ceFloatOperationError);
     end;
    end else begin
     case OldTok of
      _plus:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUAdd;
       OutPopBx;
       OutFPUToAx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _minus:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUSub;
       OutPopBx;
       OutFPUToAx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _mul:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUMul;
       OutPopBx;
       OutFPUToAx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _div:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutAXToFPU;
       OutPushBx;
       OutFPUDiv;
       OutPopBx;
       OutFPUToAx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      else SetError(ceFloatOperationError);
     end;
    end;
   end else begin
    if UseEBX then begin
     case OldTok of
      _plus:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAddAxBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _minus:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutSubAxBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _mul:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       if IsTermSigned then begin
        OutIMulBx;
       end else begin
        OutMulBx;
       end;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _div:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       if IsTermSigned then begin
        OutIDivBx;
       end else begin
        OutDivBx;
       end;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _mod:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       if IsTermSigned then begin
        OutIModBx;
       end else begin
        OutModBx;
       end;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _and:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutAndBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _or:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutOrBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _shl:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutShlBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _shr:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutShrBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
      _xor:begin
       OutMovCxBx;
       OutMovBxAx;
       OutPushBx;
       OutMovBxCx;
       OutMovFromStructVar(AltSymPtr);
       OutPopBx;
       OutXorBx;
       OutMovBxCx;
       OutMovToStructVar(AltSymPtr);
      end;
     end;
    end else begin
     case OldTok of
      _plus:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutAddAxBx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _minus:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutSubAxBx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _mul:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       if IsTermSigned then begin
        OutIMulBx;
       end else begin
        OutMulBx;
       end;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _div:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       if IsTermSigned then begin
        OutIDivBx;
       end else begin
        OutDivBx;
       end;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _mod:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       if IsTermSigned then begin
        OutIModBx;
       end else begin
        OutModBx;
       end;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _and:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutAndBx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _or:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutOrBx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _shl:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       if UseArray then OutPushCX;
       OutShlBx;
       if UseArray then OutPopCX;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _shr:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       if UseArray then OutPushCX;
       OutShrBx;
       if UseArray then OutPopCX;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
      _xor:begin
       OutMovBxAx;
       if UseArray then OutPushCX;
       OutMovAxVar(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
       OutXorBx;
       if UseArray then OutPushCX;
       OutMovVarAx(S,0,Zeiger,UseArray);
       if UseArray then OutPopCX;
      end;
     end;
    end;
   end;
  end else begin
   if UseEBX then begin
    OutPopBX;
    OutMovToStructVar(AltSymPtr);
   end else begin
    if UseArray then OutPushCX;
    OutMovVarAx(S,0,Zeiger,UseArray);
    if UseArray then OutPopCX;
   end;
  end;
 end;
end;

function TBeRoScript.LookDLL(name:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to length(DynamicLinkLibrarys)-1 do begin
  if DynamicLinkLibrarys[I].name=name then begin
   result:=I;     
   exit;
  end;
 end;
end;

function TBeRoScript.LookNative(name:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to length(NativeTabelle)-1 do begin
  if NativeTabelle[I].AsmVarName=name then begin
   result:=I;
   exit;
  end;
 end;
end;

function TBeRoScript.LookImport(name:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to length(ImportTabelle)-1 do begin
  if ImportTabelle[I].AsmVarName=name then begin
   result:=I;
   exit;
  end;
 end;
end;

function TBeRoScript.LookNativeAsmVar(name:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to length(NameTabelle)-1 do begin
  if (NameTabelle[I].AsmVarName=name) and NameTabelle[I].native then begin
   result:=I;
   exit;
  end;
 end;
end;

function TBeRoScript.LookImportAsmVar(name:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to length(NameTabelle)-1 do begin
  if (NameTabelle[I].AsmVarName=name) and NameTabelle[I].import then begin
   result:=I;
   exit;
  end;
 end;
end;

function TBeRoScript.IsStruct(name:string):boolean;
var I:integer;
begin
 result:=false;
 for I:=0 to ttZaehler-1 do begin
  if TypTabelle[I].name=name then begin
   result:=true;
   exit;
  end;
 end;
end;

function TBeRoScript.LookStruct(name:string):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to ttZaehler-1 do begin
  if TypTabelle[I].name=name then begin
   result:=I;
   exit;
  end;
 end;
end;

function TBeRoScript.LookStructVar(name:string):integer;
var I,J,K:integer;
    Gefunden:boolean;
    S:string;
    Adr:TWert;
begin
 Gefunden:=false;
 if AktProc>=0 then begin
  I:=LookStruct(NameTabelle[AktProc].StructName);
  if I>=0 then begin
   if LockVar(name,'',S,Adr,false,I) then begin
    Gefunden:=true;
   end;
  end;
 end;
 if Gefunden then begin
  result:=AktSymPtr;
 end else begin
  result:=-1;
 end;
end;

function TBeRoScript.LookVarStruct(SymPtr:integer):integer;
var I,J,K:integer;
    Gefunden:boolean;
    S:string;
    Adr:TWert;
begin
 Gefunden:=false;
 I:=0;
 if AktProc>=0 then begin
  I:=LookStruct(NameTabelle[AktProc].StructName);
  if I>=0 then begin
   if LockVar(NameTabelle[SymPtr].name,'',S,Adr,false,I) then begin
    Gefunden:=true;
   end;
  end;
 end;
 if Gefunden then begin
  result:=I;
 end else begin
  result:=-1;
 end;
end;

function TBeRoScript.VarStruct(StartLevel:boolean):boolean;
var J:integer;
begin
 result:=false;
 J:=LookStruct(sTok);
 if J>=0 then begin
  result:=true;
  VarDefStatement(StartLevel,false,false,J,false);
 end else if not StartLevel then begin
  SetError(ceStructNotDefined);
 end;
end;

procedure TBeRoScript.AddImportProc(name,LibraryName,FunctionName:string);
var I:integer;
begin
 I:=length(ImportTabelle);
 setlength(ImportTabelle,I+1);
 ImportTabelle[I].name:=name;
 ImportTabelle[I].LibraryName:=LibraryName;
 ImportTabelle[I].LibraryFunction:=FunctionName;
end;

procedure TBeRoScript.AssignmentOrVarStruct;
begin
 if IsStruct(sTok) then begin
  VarStruct(false);
 end else begin
  Assignment;
 end;
end;

procedure TBeRoScript.WhileState;
var S1,S2:string;
begin
 IncLevel;
 BreakLabel[Level]:=GeneratiereLabel;
 ContinueLabel[Level]:=GeneratiereLabel;

 S1:=GeneratiereLabel;
 OutLabel(S1);

 OutLabel(ContinueLabel[Level]);

 Get;
 if tTok=_lparent then begin
  Get;
  if tTok=_rparent then begin
   Get;
  end else begin
   StringHandling.IstZeiger:=false;
   IsTermSigned:=false;
   DoExpression;
   if tTok=_rparent then begin
    Get;
   end else begin
    SetError(ceRParenExp);
   end;
  end;
 end else begin
  SetError(ceLParenExp);
 end;

 S2:=GeneratiereLabel;
 OutJzIf(S2);

 if tTok=_semicolon then begin
  Get;
 end else if tTok=_end then begin
 end else begin
  Statement(true);
 end;

 OutJmp(S1);
 OutLabel(S2);
 OutLabel(BreakLabel[Level]);
 DecLevel;
end;

procedure TBeRoScript.DoWhileState;
var S1,S2:string;
begin
 IncLevel;
 BreakLabel[Level]:=GeneratiereLabel;
 ContinueLabel[Level]:=GeneratiereLabel;

 Get;
 S1:=GeneratiereLabel;
 OutLabel(S1);

 Statement(false);

 if tTok=_while then begin
  OutLabel(ContinueLabel[Level]);
  Get;
  if tTok=_lparent then begin
   Get;
   if tTok=_rparent then begin
    Get;
   end else begin
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    DoExpression;
    if tTok=_rparent then begin
     Get;
    end else begin
     SetError(ceRParenExp);
    end;
   end;
  end else begin
   SetError(ceLParenExp);
  end;

  S2:=GeneratiereLabel;
  OutJzIf(S2);

  OutJmp(S1);
  OutLabel(S2);
  OutLabel(BreakLabel[Level]);

  if tTok=_semicolon then begin
   Get;
  end else begin
   SetError(ceSemiColonErwartet);
  end;
 end else begin
  SetError(ceWhileErwartet);
 end;

 DecLevel;
end;

procedure TBeRoScript.ForState;
var S1,S2,s3,s4,s5:string;
begin
 Get;
 if tTok=_lparent then begin
  IncLevel;
  BreakLabel[Level]:=GeneratiereLabel;
  ContinueLabel[Level]:=GeneratiereLabel;

  Get;
  if tTok=_semicolon then begin
   Get;
  end else begin
   while not (feof or ferror) do begin
    Statement(false);
    if tTok=_comma then begin
     Get;
    end else begin
     break;
    end;
   end;
   if tTok=_semicolon then begin
    Get;
   end else begin
    SetError(ceSemiColonErwartet);
   end;
  end;

  S1:=GeneratiereLabel;
  OutLabel(S1);

  StringHandling.IstZeiger:=false;
  IsTermSigned:=false;
  if tTok=_semicolon then begin
   Get;
  end else begin
   DoExpression;
   if tTok=_semicolon then begin
    Get;
   end else begin
    SetError(ceSemiColonErwartet);
   end;
  end;
  S2:=GeneratiereLabel;
  OutJzIf(S2);

  s3:=GeneratiereLabel;
  OutJmp(s3);

  s4:=GeneratiereLabel;
  OutLabel(s4);

  OutLabel(ContinueLabel[Level]);

  if tTok=_rparent then begin
   Get;
  end else begin
   while not (feof or ferror) do begin
    Statement(false);
    if tTok=_comma then begin
     Get;
    end else begin
     break;
    end;
   end;
   if tTok=_rparent then begin
    Get;
   end else begin
   SetError(ceRParenExp);
   end;
  end;

  s5:=GeneratiereLabel;
  OutJmp(s5);

  OutLabel(s3);

  if tTok=_semicolon then begin
   Get;
  end else if tTok=_end then begin
  end else begin
   Statement(true);
  end;

  OutJmp(s4);

  OutLabel(s5);
  OutJmp(S1);
  OutLabel(S2);
  OutLabel(BreakLabel[Level]);
  DecLevel;
 end else begin
  SetError(ceLParenExp);
 end;
end;

procedure TBeRoScript.IfState;
var S1,S2:string;
begin
 Get;
 if tTok=_lparent then begin
  Get;
  if tTok=_rparent then begin
   Get;
  end else begin
   StringHandling.IstZeiger:=false;
   IsTermSigned:=false;
   DoExpression;
   if tTok=_rparent then begin
    Get;
   end else begin
    SetError(ceRParenExp);
   end;
  end;
 end else begin
  SetError(ceLParenExp);
 end;

 S1:=GeneratiereLabel;
 OutJzIf(S1);
 if tTok=_semicolon then begin
  Get;
 end else if tTok=_end then begin
 end else if tTok=_begin then begin
  BeginState;
 end else begin
  Statement(true);
 end;
 if TTok<>_else then begin
  OutLabel(S1);
 end else begin
  Get;
  S2:=GeneratiereLabel;
  OutJmp(S2);
  OutLabel(S1);
  Statement(true);
  OutLabel(S2);
 end;
end;

procedure TBeRoScript.SwitchState;
var SE,SOK,SNO,SNEXT:string;
    default:boolean;
begin
 Get;
 if tTok=_lparent then begin
  Get;
  IncLevel;
  StringHandling.IstZeiger:=false;
  IsTermSigned:=false;
  DoExpression;

  SE:=GeneratiereLabel;
  BreakLabel[Level]:=SE;

  if tTok=_rparent then begin
   Get;
   OutPushSi;
   OutMovSiAx;
   if tTok=_begin then begin
    Get;
    if tTok in [_case,_default] then begin
     SOK:='';
     SNEXT:=GeneratiereLabel;
     default:=false;
     while (not ((tTok=_end) or feof or ferror)) and (not default) do begin
      if length(SOK)=0 then begin
       SOK:=SNEXT;
       SNEXT:=GeneratiereLabel;
      end else begin
       SOK:=SNEXT;
      end;
      ContinueLabel[Level]:=SNEXT;
      if tTok=_case then begin
       default:=false;
       Get;
       OutPushSi;
       StringHandling.IstZeiger:=false;
       IsTermSigned:=false;
       DoExpression;
       OutPopSi;
       OutMovBxSi;
       OutEql;
       SNO:=GeneratiereLabel;
       OutJZIf(SNO);
      end else if tTok=_default then begin
       default:=true;
       Get;
      end;
      OutLabel(SOK);
      if tTok=_doublepoint then begin
       Get;
       while not ((tTok in [_case,_default,_end]) or feof or ferror) do begin
        if not (tTok in [_case,_default,_end]) then Statement(true);
       end;
      end else begin
       SetError(ceDoppelPunktErwartet);
      end;
      SNEXT:=GeneratiereLabel;
      OutJmp(SNEXT);
      OutLabel(SNO);
     end;
     Get;
     OutLabel(SNEXT);
     SOK:=GeneratiereLabel;
     SNO:=GeneratiereLabel;
     SNEXT:=GeneratiereLabel;
    end else begin
     SetError(ceCaseErwartet);
    end;
   end else begin
    SetError(ceBeginErwartet);
   end;
   OutLabel(SOK);
   OutLabel(SE);
   OutPopSi;
   DecLevel;
  end else begin
   SetError(ceRParenExp);
  end;
 end else begin
  SetError(ceLParenExp);
 end;
end;

function TBeRoScript.CallState(Selbststaendig,UseEBX,Klammern:boolean):integer;
var adr:TWert;
    a,S:string;
    TempStructVariable:string;
    TempObjectVariable:string;
    TempStringVariables:array of string;
    I,J,K,L,U,Z,B,SC,NSC:integer;
    AktProcPtr,AltAktSymPtr:integer;
    OK,Verarbeiten:boolean;
 procedure StoreParameter;
 begin
  if (I>0) and (I<=length(NameTabelle[AktProcPtr].Param)) and Verarbeiten then begin
   if NameTabelle[AktProcPtr].Param[I-1]>=0 then begin
    if NameTabelle[AktProcPtr].isstdcall then begin
     if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger then begin
      OutMovESPAx(J,4);
      inc(J,4);
      inc(L,4);
     end else begin
      if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].TypLink>=0 then begin
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size,J);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size;
       if Alignment then if (B mod 4)<>0 then B:=B+(4-(B mod 4));
       inc(J,B);
       inc(L,B);
      end else if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].IstArray then begin
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim,J);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim;
       if Alignment then if (B mod 4)<>0 then B:=B+(4-(B mod 4));
       inc(J,B);
       inc(L,B);
      end else begin
       if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuByte,tByte,tuChar,tChar] then begin
        if Alignment then begin
         OutMovESPAx(J,4);
         inc(J,4);
         inc(L,4);
        end else begin
         OutMovESPAx(J,1);
         inc(J);
         inc(L);
        end;
       end;
       if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuShortInt,tShortInt] then begin
        if Alignment then begin
         OutMovESPAx(J,4);
         inc(J,4);
         inc(L,4);
        end else begin
         OutMovESPAx(J,2);
         inc(J,2);
         inc(L,2);
        end;
       end;
       if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuInt,tInt,tFloat,tString,tVoid] then begin
        OutMovESPAx(J,4);
        inc(J,4);
        inc(L,4);
       end;
      end;
     end;
    end else begin
     if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger then begin
      OutPushAx;
      inc(L,4);
     end else begin
      if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].TypLink>=0 then begin
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size,0);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size;
       inc(L,B);
       if Alignment then begin
        if (B mod 4)<>0 then begin
         OutSubESP(4-(B mod 4));
         inc(L,4-(B mod 4));
        end;
       end;
      end else if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].IstArray then begin
       OutMoveFromEBXToStack(NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim,0);
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].ArrayDim;
       inc(L,B);
       if Alignment then begin
        if (B mod 4)<>0 then begin
         OutSubESP(4-(B mod 4));
         inc(L,4-(B mod 4));
        end;
       end;
      end else begin
       if Alignment then begin
        OutPushAx32;
        inc(L,4);
       end else begin
        if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuByte,tByte,tuChar,tChar] then begin
         OutPushAx8;
         inc(L);
        end;
        if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuShortInt,tShortInt] then begin
         OutPushAx16;
         inc(L,2);
        end;
        if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuInt,tInt,tFloat,tString,tVoid] then begin
         OutPushAx32;
         inc(L,4);
        end;
       end;
      end;
     end;
    end;
   end;
  end;
 end;
begin
 OK:=false;
 if Selbststaendig then begin
  if LockVar(sTok,'',a,Adr,false,-1) then begin
   if NameTabelle[AktSymPtr].Obj=_call then begin
    OK:=true;
   end;
  end;
 end else begin
  if NameTabelle[AktSymPtr].Obj=_call then begin
   OK:=true;
  end;
 end;
 if OK then begin
  S:=sTok;
  result:=AktSymPtr;
  AktProcPtr:=AktSymPtr;
  if Selbststaendig then Get;
  if NameTabelle[AktProcPtr].TypLink>=0 then begin
   if not (TypTabelle[NameTabelle[AktProcPtr].TypLink].Size in [1,2,4]) then begin
    TempStructVariable:=GetStructTempVariableName(NameTabelle[AktProcPtr].TypLink);
   end else begin
    TempStructVariable:='';
   end;
  end else begin
   TempStructVariable:='';
  end;
  if NameTabelle[AktProcPtr].StructName<>'' then begin
   TempObjectVariable:=GetObjectTempVariableName(LookStruct(NameTabelle[AktProcPtr].StructName));
   OutPushAx;
   OutPushCx;
   OutPopAx;
   OutMovVarAx(TempObjectVariable,0,false,false);
   OutPopAx;
  end else begin
   TempObjectVariable:='';
  end;
  TempStringVariables:=nil;
  AktSymPtr:=AktProcPtr;
  L:=0;
  SC:=0;
  for J:=0 to length(NameTabelle[AktProcPtr].Param)-1 do begin
   if NameTabelle[NameTabelle[AktProcPtr].Param[J]].Art=aParam then begin
    if NameTabelle[NameTabelle[AktProcPtr].Param[J]].Typ=tString then begin
     setlength(TempStringVariables,length(TempStringVariables)+1);
     TempStringVariables[length(TempStringVariables)-1]:=GetStringTempVariableName(SC);
     inc(SC);
     inc(L,4);
    end;
   end;
  end;
  I:=0;
  Z:=0;
  if tTok=_lparent then begin
   K:=0;
   if NameTabelle[AktProcPtr].isstdcall then begin
    J:=0;
    for I:=0 to length(NameTabelle[AktProcPtr].Param)-1 do begin
     if NameTabelle[NameTabelle[AktProcPtr].Param[I]].Zeiger then begin
      inc(J,4);
     end else begin
      B:=0;
      if NameTabelle[NameTabelle[AktProcPtr].Param[I]].TypLink>=0 then begin
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I]].Size;
      end else if NameTabelle[NameTabelle[AktProcPtr].Param[I]].IstArray then begin
       B:=NameTabelle[NameTabelle[AktProcPtr].Param[I]].Size*NameTabelle[NameTabelle[AktProcPtr].Param[I]].ArrayDim;
      end else begin
       if NameTabelle[NameTabelle[AktProcPtr].Param[I]].Typ in [tuByte,tByte,tuChar,tChar] then B:=1;
       if NameTabelle[NameTabelle[AktProcPtr].Param[I]].Typ in [tuShortInt,tShortInt] then B:=2;
       if NameTabelle[NameTabelle[AktProcPtr].Param[I]].Typ in [tuInt,tInt,tFloat,tString,tVoid] then B:=4;
      end;
      if Alignment then if (B mod 4)<>0 then B:=B+(4-(B mod 4));
      inc(J,B);
     end;
    end;
    OutSubESP(J);
    Z:=J;
    K:=J;
   end;
   I:=0;
   J:=0;
   L:=0;
   U:=0;
   NSC:=0;
   while (tTok<>_rparent) and not (feof or ferror) do begin
    Get;
    if tTok=_comma then begin
     inc(I);
     Verarbeiten:=false;
    end else if tTok=_rparent then begin
     Verarbeiten:=false;
    end else begin
     inc(I);
     if (I>0) and (I<=length(NameTabelle[AktProcPtr].Param)) then begin
      if NameTabelle[AktProcPtr].Param[I-1]>=0 then begin
       if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tuChar,tChar] then begin
        StringHandling.IstZeiger:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger;
       end else begin
        StringHandling.IstZeiger:=false;
       end;
       if (NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].TypLink>=0) and not NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger then begin
        if LockVar(sTok,'',a,Adr,false,-1) then begin
         if NameTabelle[AktSymPtr].Art=aGlobal then begin
          AltAktSymPtr:=AktSymPtr;
          if LookStructVar(sTok)<0 then begin
           AktSymPtr:=AltAktSymPtr;
           StructAssignment(false,false,false,false);
         end else begin
           StructAssignment(false,false,true,false);
          end;
         end else begin
          StructAssignment(false,false,false,false);
         end;
        end else begin
         if LookStructVar(sTok)<0 then begin
          SetError(ceVarNotDef);
         end else begin
          StructAssignment(false,false,true,false);
         end;
        end;
       end else if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].IstArray and not NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger then begin
        if LockVar(sTok,'',a,Adr,false,-1) then begin
         if NameTabelle[AktSymPtr].Art=aGlobal then begin
          AltAktSymPtr:=AktSymPtr;
          if LookStructVar(sTok)<0 then begin
           AktSymPtr:=AltAktSymPtr;
           StructAssignment(false,false,false,false);
         end else begin
           StructAssignment(false,false,true,false);
          end;
         end else begin
          StructAssignment(false,false,false,false);
         end;
        end else begin
         if LookStructVar(sTok)<0 then begin
          SetError(ceVarNotDef);
         end else begin
          StructAssignment(false,false,true,false);
         end;
        end;
       end else if NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ=tString then begin
        StringLevel:=0;
        MustBeStringTerm:=true;
        StringBoolExpression(true);
        if NSC<length(TempStringVariables) then begin
         OutStrIncrease;
         OutMovVarAx(TempStringVariables[NSC],0,false,false);
         inc(NSC);
        end;
       end else begin
        IsTermSigned:=NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ in [tByte,tChar,tShortInt,tInt];
        DoExpression;
        if not IsFloatExpression then begin
         if (NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ=tFloat) and not NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger then begin
          OutIntAxToFPU;
          OutFPUToAx;
         end;
        end else begin
         if (NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Typ<>tFloat) and not NameTabelle[NameTabelle[AktProcPtr].Param[I-1]].Zeiger then begin
          SetError(ceWrongType);
         end;
        end;
        IsFloatExpression:=false;
       end;
      end else begin
       OutXorAxAx;
      end;
     end else begin
      OutXorAxAx;
     end;
     Verarbeiten:=true;
    end;
    if tTok=_rparent then begin
    end else if tTok=_comma then begin
    end else begin
     SetError(ceFuncParamSetError);
    end;
    StoreParameter;
   end;
   if tTok=_rparent then begin
    Get;
   end else begin
    SetError(ceRParenExp);
   end;
  end else if Klammern then begin
   SetError(ceLParenExp);
  end;
  if I<>NameTabelle[AktProcPtr].TotalParamNum then begin
   if NameTabelle[AktProcPtr].StructName<>'' then begin
    Verarbeiten:=true;
    inc(I);
    OutMovAxVarAdr(TempObjectVariable,0,true,false);
    StoreParameter;
   end;
   if not NameTabelle[AktProcPtr].Zeiger then begin
    if NameTabelle[AktProcPtr].Typ=tType then begin
     if not (TypTabelle[NameTabelle[AktProcPtr].TypLink].Size in [1,2,4]) then begin
      Verarbeiten:=true;
      inc(I);
      OutMovAxVarAdr(TempStructVariable,0,false,false);
      StoreParameter;
     end;
    end;
   end;
  end;
  if NameTabelle[AktProcPtr].native then begin
   OutCallNative(NameTabelle[AktProcPtr].name);
  end else if NameTabelle[AktProcPtr].import then begin
   OutCallImport(NameTabelle[AktProcPtr].name);
  end else begin
   if UseEBX then begin
    OutCallBx;
   end else begin
    OutCall(NameTabelle[AktProcPtr].name,'');
   end;
  end;
  if NameTabelle[AktProcPtr].TypLink>=0 then begin
   if not (TypTabelle[NameTabelle[AktProcPtr].TypLink].Size in [1,2,4]) then begin
    if length(TempStructVariable)>0 then begin
     OutMovAxVarAdr(TempStructVariable,0,false,false);
    end;
   end;
  end;
  if SC>0 then begin
   NSC:=0;
   OutPushAx;
   for J:=0 to length(NameTabelle[AktProcPtr].Param)-1 do begin
    if NameTabelle[NameTabelle[AktProcPtr].Param[J]].Art=aParam then begin
     if NameTabelle[NameTabelle[AktProcPtr].Param[J]].Typ=tString then begin
      OutMovAxVar(TempStringVariables[NSC],0,false,false);
      OutStrDecrease;
      inc(NSC);
     end;
    end;
   end;
   OutPopAx;
  end;
  setlength(TempStringVariables,0);
  if I<>NameTabelle[AktProcPtr].TotalParamNum then SetError(ceFuncParamNumFehler);
 end else begin
  result:=0;
 end;
end;

procedure TBeRoScript.BeginState;
begin
 Get;
 while not ((tTok=_end) or feof or ferror) do begin
  if tTok<>_end then Statement(true);
 end;
 Get;
end;

function TBeRoScript.StructAssignment(IstZeiger,StringWrite,IsObjectVar,NoCode:boolean):boolean;
var Adr:TWert;
    T,I,J,K,O:integer;
    UsePointer,UseArray,UseZeiger,Start,Schleife,AltMustBeStringTerm,
    Gefunden:boolean;
    S,LastS:string;
    AltStringHandling:TStringHandlinG;
    TypLink,LastSymPtr:integer;
    BufferStart:boolean;
    BufferStartSymbol:integer;
    BufferOffset:boolean;
    BufferOffsetValue:integer;
 procedure WriteBufferStart;
 var S:string;
 begin
  if BufferStart and not NoCode then begin
   S:=NameTabelle[BufferStartSymbol].AsmVarName;
   if BufferOffset then begin
    if NameTabelle[BufferStartSymbol].Art in [aGlobal,aStatic] then begin
     OutMovBxImmLabelOffset(S,BufferOffsetValue);
    end else if NameTabelle[BufferStartSymbol].Art=aLokal then begin
     if NameTabelle[BufferStartSymbol].StackPtr>0 then begin
      OutLeaEBXEBP(-NameTabelle[BufferStartSymbol].StackPtr+BufferOffsetValue);
     end else begin
      OutLeaEBXEBP(BufferOffsetValue);
     end;
    end else if NameTabelle[BufferStartSymbol].Art in [aParam,aShadowParam] then begin
     if NameTabelle[BufferStartSymbol].StackPtr>0 then begin
      OutLeaEBXEBP(NameTabelle[BufferStartSymbol].StackPtr+BufferOffsetValue);
     end else begin
      OutLeaEBXEBP(BufferOffsetValue);
     end;
    end;
    BufferOffset:=false;
    BufferOffsetValue:=0;
   end else begin
    if NameTabelle[BufferStartSymbol].Art in [aGlobal,aStatic] then begin
     OutMovBxImmLabel(S);
    end else if NameTabelle[BufferStartSymbol].Art=aLokal then begin
     if NameTabelle[BufferStartSymbol].StackPtr>0 then begin
      OutLeaEBXEBP(-NameTabelle[BufferStartSymbol].StackPtr);
     end else begin
      OutMovEBXEBP;
     end;
    end else if NameTabelle[BufferStartSymbol].Art in [aParam,aShadowParam] then begin
     if NameTabelle[BufferStartSymbol].StackPtr>0 then begin
      OutLeaEBXEBP(NameTabelle[BufferStartSymbol].StackPtr);
     end else begin
      OutMovEBXEBP;
     end;
    end;
   end;
  end;
  BufferStart:=false;
  BufferStartSymbol:=0;
 end;
 procedure WriteBufferOffset;
 var S:string;
 begin
  if BufferOffset and not NoCode then begin
   OutAddEBX(BufferOffsetValue);
  end;
  BufferOffset:=false;
  BufferOffsetValue:=0;
 end;
begin
 result:=false;
 UseZeiger:=IstZeiger;
 Schleife:=true;
 Start:=true;
 BufferStart:=false;
 BufferStartSymbol:=0;
 BufferOffset:=false;
 BufferOffsetValue:=0;
 TypLink:=-1;
 LastS:='';
 LastSymPtr:=-1;
 if IsObjectVar then begin
  if not NoCode then begin
   OutPushAx;
   OutMovAxVar(tnFunctionObjectPointer,0,false,false);
   OutMovBxAx;
   OutPopAx;
  end;
  BufferStart:=false;
  BufferStartSymbol:=AktSymPtr;
  TypLink:=LookStruct(NameTabelle[AktProc].StructName);
  Start:=false;
 end;
 while Schleife and not (feof or ferror) do begin
  Schleife:=false;
  UseArray:=false;
  UsePointer:=false;
  if not Start then UseZeiger:=false;
  if tTok=_mul then begin
   UseZeiger:=true;
   Get;
  end;
  if not LockVar(sTok,'',S,Adr,false,TypLink) then begin
   I:=LookStruct(LastS);
   if (I<0) and (LastSymPtr>=0) then begin
    I:=NameTabelle[LastSymPtr].TypLink;
   end;
   if I>=0 then begin
    Gefunden:=false;
    if not LockVar(sTok,TypTabelle[I].name,S,Adr,false,-1) then begin
     for J:=length(TypTabelle[I].Extends)-1 downto 0 do begin
      K:=TypTabelle[I].Extends[J];
      if LockVar(sTok,TypTabelle[K].name,S,Adr,false,-1) then begin
       O:=TypTabelle[I].ExtendsOffsets[J];
       if O>0 then begin
        if BufferOffset then begin
         inc(BufferOffsetValue,O);
        end else begin
         BufferOffsetValue:=O;
        end;
        BufferOffset:=true;
       end;
       Gefunden:=true;
       break;
      end;
     end;
     if not Gefunden then begin
      SetError(ceVarNotDef);
     end;
    end else begin
     Gefunden:=true;
    end;
    if Gefunden and not NoCode then begin
     if BufferStart or BufferOffset then begin
      OutPushAx;
      WriteBufferStart;
      WriteBufferOffset;
      OutMovCxBx;
      OutMovAxImmLabel(S);
      OutMovBxAx;
      OutPopAx;
     end else begin
      OutMovCxBx;
      OutPushAx;
      OutMovAxImmLabel(S);
      OutMovBxAx;
      OutPopAx;
     end;
    end;
   end else begin
    SetError(ceVarNotDef);
    break;
   end;
  end;
  LastS:=sTok;
  LastSymPtr:=AktSymPtr;
  if (NameTabelle[LastSymPtr].Typ=tFloat) and not NameTabelle[LastSymPtr].Zeiger then begin
   IsFloatExpression:=true;
  end;
  T:=NameTabelle[LastSymPtr].BTyp;
  TypLink:=NameTabelle[LastSymPtr].TypLink;
  Get;
  if tTok=_klparent then begin
   UseArray:=true;
   if NameTabelle[LastSymPtr].IstArray then begin
    Get;
    AltStringHandling:=StringHandling;
    StringHandling.IstZeiger:=false;
    IsTermSigned:=false;
    if not NoCode then begin
     OutPushAx;
     OutPushBx;
     OutPushCx;
     DoExpression;
     OutPopCx;
     OutPopBx;
    end;
    StringHandling:=AltStringHandling;
    if tTok=_krparent then begin
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
   end else if (NameTabelle[LastSymPtr].Typ=tString) and not StringWrite then begin
    result:=true;
    if not NoCode then OutMovAxBx;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    if tTok=_krparent then begin
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
    if not NoCode then begin
     OutMovEAXStruct(4);
     OutPushAx;
     OutPushBx;
     OutCallNative('charat');
    end;
    if MustBeStringTerm then begin
     if not NoCode then begin
      OutStrCharConvert;
     end;
    end else begin
     IsStringTerm:=false;
    end;
   end else if (NameTabelle[LastSymPtr].Typ=tString) and StringWrite then begin
    result:=true;
    if not NoCode then OutMovAxBx;
    Get;
    OutPushAx;
    AltMustBeStringTerm:=MustBeStringTerm;
    DoExpressionEx;
    MustBeStringTerm:=AltMustBeStringTerm;
    OutMovBxAx;
    OutPopAx;
    if tTok=_krparent then begin
     Get;
    end else begin
     SetError(ceKRParentErwartet);
    end;
    if not NoCode then begin
     OutMovEAXStruct(4);
     OutPushAx;
     OutPushBx;
     OutCallNative('charpointerat');
    end;
   end else begin
    SetError(ceKeinArray);
   end;
  end;
  if tTok=_usepointer then begin
   UsePointer:=true;
   UseZeiger:=true;
   Get;
  end;
  if Start then begin
   BufferStart:=true;
   BufferStartSymbol:=LastSymPtr;
  end else if NameTabelle[LastSymPtr].Feld_Offset>0 then begin
   BufferOffset:=true;
   BufferOffsetValue:=NameTabelle[LastSymPtr].Feld_Offset;
  end;
  if UseZeiger then begin
   WriteBufferStart;
   WriteBufferOffset;
   if not NoCode then OutMovBxFromBx;
  end;
  if UseArray then begin
   if BufferStart or BufferOffset then begin
    if not NoCode then begin
     OutPushAx;
     OutPushCx;
     WriteBufferStart;
     WriteBufferOffset;
     OutPopCx;
     OutPopAx;
    end;
   end;
   if not NoCode then begin
    if NameTabelle[LastSymPtr].BTyp>0 then begin
     OutMulAxImmSigned(TypTabelle[T].Size);
    end else begin
     OutMulAxImmSigned(NameTabelle[LastSymPtr].Size);
    end;
    OutAddBxAx;
    OutPopAx;
   end;
  end;
  if UsePointer then begin
   if TypLink>=0 then begin
    Schleife:=true;
   end else begin
    SetError(ceNotStruct);
   end;
  end else if tTok=_dot then begin
   if TypLink>=0 then begin
    Schleife:=true;
    Get;
   end else begin
    SetError(ceNotStruct);
   end;
  end;
  if Schleife and NameTabelle[LastSymPtr].Zeiger and not UseZeiger then begin
   if not NoCode then begin
    OutPushAx;
    OutPushCx;
    WriteBufferStart;
    WriteBufferOffset;
    OutPopCx;
    OutPopAx;
    OutMovBxFromBx;
   end;
  end;
  Start:=false;
 end;
 if not NoCode then begin
  OutPushAx;
  OutPushCx;
  WriteBufferStart;
  WriteBufferOffset;
  OutPopCx;
  OutPopAx;
 end;
end;

procedure TBeRoScript.StructStatement(StartLevel,IsUnion,IsObject:boolean);
var name,S,A:string;
    SZ,I,J,K,H,B,Von,bis:integer;
    ExtendStructs:array of integer;
    IsPacked:boolean;
    Adr:TWert;
    Src,Dst:PNameTabelleEintrag;
begin
 IsPacked:=false;
 ExtendStructs:=nil;
 S:='';
 if tTok=_packed then begin
  IsPacked:=true;
  Get;
  if not (tTok in [_struct,_union,_object]) then begin
   SetError(ceStructOrUnionOrObjectStatementExpected);
  end;
  if tTok=_union then begin
   IsUnion:=true;
  end else if tTok=_object then begin
   IsObject:=true;
  end;
 end;
 Get;
 if (tTok=_ident) and not fError then begin
  name:=sTok;
  if IsStruct(sTok) then begin
   SetError(ceStructOrUnionOrObjectDoppelDefiniert);
  end;
  Get;
  if tTok=_lparent then begin
   while not (feof or ferror) do begin
    Get;
    I:=LookStruct(sTok);
    if I>=0 then begin
     J:=length(ExtendStructs);
     setlength(ExtendStructs,J+1);
     ExtendStructs[J]:=I;
    end else begin
     SetError(ceStructExpected);
    end;
    Get;
    if tTok<>_comma then break;
   end;
   if ferror then exit;
   if tTok=_rparent then begin
    Get;
   end else begin
    SetError(ceRParenExp);
   end;
  end;
  if tTok=_begin then begin
   setlength(TypTabelle,ttZaehler+1);
   TypTabelle[ttZaehler].name:=name;
   TypTabelle[ttZaehler].IsPacked:=IsPacked;
   TypTabelle[ttZaehler].StackAlloc:=0;
   TypTabelle[ttZaehler].Bytes2Pass:=0;
   TypTabelle[ttZaehler].VariableNum:=0;
   TypTabelle[ttZaehler].Variable:=nil;
   TypTabelle[ttZaehler].Extends:=nil;
   TypTabelle[ttZaehler].ExtendsOffsets:=nil;
   TypTabelle[ttZaehler].Size:=0;
   Von:=tnZaehler+1;
   setlength(TypTabelle[ttZaehler].Extends,length(ExtendStructs));
   setlength(TypTabelle[ttZaehler].ExtendsOffsets,length(ExtendStructs));
   for J:=0 to length(ExtendStructs)-1 do begin
    TypTabelle[ttZaehler].Extends[J]:=ExtendStructs[J];
    TypTabelle[ttZaehler].ExtendsOffsets[J]:=TypTabelle[ttZaehler].Bytes2Pass;
    for K:=0 to TypTabelle[ExtendStructs[J]].VariableNum-1 do begin
     inc(tnZaehler);
     setlength(NameTabelle,tnZaehler+1);
     Src:=@NameTabelle[TypTabelle[ExtendStructs[J]].Variable[K]];
     Dst:=@NameTabelle[tnZaehler];
     FILLCHAR(Dst^,sizeof(TNameTabelleEintrag),#0);
     Dst^.name:=Src^.name;
     Dst^.Proc:=Src^.Proc;
     Dst^.AsmVarName:=Src^.AsmVarName;
     Dst^.Obj:=Src^.Obj;
     Dst^.Typ:=Src^.Typ;
     Dst^.TypLink:=Src^.TypLink;
     if Src^.Art in [aGlobal,aLokal,aStatic,aStructVar] then begin
      Dst^.InTypLink:=ttZaehler;
     end else begin
      Dst^.InTypLink:=Src^.InTypLink;
     end;
     Dst^.Zeiger:=Src^.Zeiger;
     Dst^.IstArray:=Src^.IstArray;
     Dst^.Art:=Src^.Art;
     Dst^.storage:=Src^.storage;
     Dst^.StackPtr:=Src^.StackPtr+TypTabelle[ttZaehler].ExtendsOffsets[J];
     Dst^.symptr:=Src^.symptr;
     Dst^.StackAlloc:=Src^.StackAlloc+TypTabelle[ttZaehler].ExtendsOffsets[J];
     Dst^.Bytes2Pass:=Src^.Bytes2Pass+TypTabelle[ttZaehler].ExtendsOffsets[J];
     Dst^.SubNum:=Src^.SubNum;
     Dst^.ProcNr:=Src^.ProcNr;
     Dst^.ParamNum:=Src^.ParamNum;
     Dst^.ShadowParamNum:=Src^.ShadowParamNum;
     Dst^.TotalParamNum:=Src^.TotalParamNum;
     Dst^.ArrayDim:=Src^.ArrayDim;
     Dst^.Size:=Src^.Size;
     if Src^.Art in [aGlobal,aLokal,aStatic,aStructVar] then begin
      Dst^.BTyp:=ttZaehler;
     end else begin
      Dst^.BTyp:=Src^.BTyp;
     end;
     Dst^.Feld_Offset:=Src^.Feld_Offset;
     Dst^.EinTyp:=Src^.EinTyp;
     Dst^.InTyp:=Src^.InTyp;
     Dst^.Wert:=Src^.Wert;
     Dst^.native:=Src^.native;
     Dst^.import:=Src^.import;
     Dst^.isstdcall:=Src^.isstdcall;
     setlength(Dst^.Param,length(Src^.Param));
     for H:=0 to length(Src^.Param)-1 do Dst^.Param[H]:=Src^.Param[H];
     Dst^.Adr:=Src^.Adr;
     Dst^.Tok:=Src^.Tok;
     inc(TypTabelle[ttZaehler].VariableNum);
     setlength(TypTabelle[ttZaehler].Variable,TypTabelle[ttZaehler].VariableNum);
     TypTabelle[ttZaehler].Variable[TypTabelle[ttZaehler].VariableNum-1]:=tnZaehler;
    end;
    B:=TypTabelle[ExtendStructs[J]].Size;
    if Alignment and not TypTabelle[ttZaehler].IsPacked then begin
     if (B mod 4)<>0 then begin
      B:=B+(4-(B mod 4));
     end;
    end;
    inc(TypTabelle[ttZaehler].Size,B);
    B:=TypTabelle[ExtendStructs[J]].Bytes2Pass;
    if Alignment and not TypTabelle[ttZaehler].IsPacked then begin
     if (B mod 4)<>0 then begin
      B:=B+(4-(B mod 4));
     end;
    end;
    inc(TypTabelle[ttZaehler].Bytes2Pass,B);
    B:=TypTabelle[ExtendStructs[J]].StackAlloc;
    if Alignment and not TypTabelle[ttZaehler].IsPacked then begin
     if (B mod 4)<>0 then begin
      B:=B+(4-(B mod 4));
     end;
    end;
    inc(TypTabelle[ttZaehler].StackAlloc,B);
   end;
   while (tTok<>_end) and not (feof or ferror) do begin
    Get;
    if tTok<>_end then begin
     VarDefStatement(false,false,true,-1,false);
     NameTabelle[tnZaehler].InTypLink:=ttZaehler;
     NameTabelle[tnZaehler].BTyp:=ttZaehler;
    end;
   end;
   Bis:=tnZaehler;
   SZ:=0;
   J:=0;
   for I:=Von to Bis do begin
    if NameTabelle[I].Obj in [_ident,_call] then begin
     if NameTabelle[I].Art in [aGlobal,aLokal,aStatic,aStructVar] then begin
      NameTabelle[I].InTypLink:=ttZaehler;
      NameTabelle[I].BTyp:=ttZaehler;
     end;
    end;
    if NameTabelle[I].Obj=_ident then begin
     if IsUnion then begin
      NameTabelle[I].Feld_Offset:=0;
      if NameTabelle[I].Zeiger then begin
       if SZ<4 then SZ:=4;
      end else begin
       if NameTabelle[I].IstArray then begin
        B:=NameTabelle[I].Size*NameTabelle[I].ArrayDim;
       end else begin
        B:=NameTabelle[I].Size;
       end;
       if Alignment and not IsPacked then begin
        if (B mod 4)<>0 then begin
         B:=B+(4-(B mod 4));
        end;
       end;
       if SZ<B then SZ:=B;
      end;
     end else begin
      NameTabelle[I].Feld_Offset:=SZ;
      if NameTabelle[I].Zeiger then begin
       SZ:=SZ+4;
      end else begin
       if NameTabelle[I].IstArray then begin
        B:=NameTabelle[I].Size*NameTabelle[I].ArrayDim;
       end else begin
        B:=NameTabelle[I].Size;
       end;
       if Alignment and not IsPacked then begin
        if (B mod 4)<>0 then begin
         B:=B+(4-(B mod 4));
        end;
       end;
       SZ:=SZ+B;
      end;
     end;
     inc(J);
    end;
   end;
   TypTabelle[ttZaehler].Size:=SZ;
   TypTabelle[ttZaehler].Felder:=J;
   if tTok=_end then begin
    Get;
   end else begin
    SetError(ceEndErwartet);
   end;
   inc(ttZaehler);
   VarDefStatement(StartLevel,false,false,ttZaehler-1,true);
  end else begin
   SetError(ceBeginErwartet);
  end;
 end else begin
  SetError(ceBezeichnerErwartet);
 end;
 setlength(ExtendStructs,0);
end;

function TBeRoScript.AreInThatStrings(SymPtr:integer):boolean;
var I,J,T:integer;
begin
 if NameTabelle[SymPtr].Zeiger then begin
  result:=false;
 end else if NameTabelle[SymPtr].Typ=tString then begin
  result:=true;
 end else if NameTabelle[SymPtr].EinTyp then begin
  T:=NameTabelle[SymPtr].TypLink;
  J:=TypTabelle[T].VariableNum;
  result:=false;
  for I:=0 to J-1 do begin
   result:=result or AreInThatStrings(TypTabelle[T].Variable[I]);
  end;
 end else begin
  result:=false;
 end;
end;

function TBeRoScript.FunctionStringFree(SymPtr:integer;Art:TArt;Offset,SubOffset:integer):integer;
var I,J,T,B,O,SO:integer;
begin
 if AreInThatStrings(SymPtr) then begin
  O:=Offset;
  SO:=SubOffset;
  if (NameTabelle[SymPtr].name<>tnFunctionResult) and not NameTabelle[SymPtr].Zeiger then begin
   if NameTabelle[SymPtr].Typ=tString then begin
    OutMovAxVarEBX(-Offset+SO,NameTabelle[SymPtr].Size);
    OutStrDecrease;    
    result:=NameTabelle[SymPtr].Size;
   end else if NameTabelle[SymPtr].EinTyp then begin
    T:=NameTabelle[SymPtr].TypLink;
    J:=TypTabelle[T].VariableNum;
    for I:=0 to J-1 do begin
     FunctionStringFree(TypTabelle[T].Variable[I],Art,O,SO+NameTabelle[TypTabelle[T].Variable[I]].Feld_Offset);
    end;
    result:=NameTabelle[SymPtr].Size;
   end else begin
    result:=0;
   end;
  end else begin
   result:=0;
  end;
 end else begin
  result:=0;
 end;
end;

procedure TBeRoScript.VarDefStatement(StartLevel,FuncParam,Struct:boolean;Typ:integer;IsStructStatement:boolean);
var T:TTyp;
    A,S,SO,SA,SL,LibName,LibFunc:string;
    Adr:TWert;
    Schleife:boolean;
    P1,P2,m,n,B,ArrayDim:integer;
    unsigned,IstArray,static,native,import,isstdcall,Zeiger:boolean;
    I,J,P,O1,O2,O3,O4,O5:integer;
    OK,KeinGET:boolean;
begin
 ArrayDim:=0;
 unsigned:=false;
 IstArray:=false;
 static:=false;
 native:=false;
 import:=false;
 isstdcall:=false;
 KeinGET:=false;
 SO:='';
 if IsStructStatement then begin
  T:=tType;
  if StartLevel then begin
   if tTok=_semicolon then begin
    Get;
    exit;
   end;
  end;
  KeinGET:=true;
 end else begin
  Schleife:=true;
  while Schleife and not (feof or ferror) do begin
   Schleife:=false;
   if tTok=_signed then begin
    Schleife:=true;
    unsigned:=false;
    Get;
   end;
   if tTok=_unsigned then begin
    Schleife:=true;
    unsigned:=true;
    Get;
   end;
   if tTok=_static then begin
    Schleife:=true;
    static:=true;
    Get;
   end;
   if tTok=_native then begin
    Schleife:=true;
    native:=true;
    import:=false;
    Get;
   end;
   if tTok=_import then begin
    Schleife:=true;
    native:=false;
    import:=true;
    Get;
   end;
   if tTok=_stdcall then begin
    Schleife:=true;
    isstdcall:=true;
    Get;
   end;
  end;
  if Typ>=0 then begin
   T:=tType;
  end else if tTok=_ident then begin
   Typ:=LookStruct(sTok);
   if Typ>=0 then begin
    T:=tType;
   end else begin
    SetError(ceTypeExpected);
    exit;
   end;
  end else if unsigned then begin
   case tTok of
    _int:T:=tuInt;
    _shortint:T:=tuShortInt;
    _void:T:=tVoid;
    _byte:T:=tuByte;
    _char:T:=tuChar;
    _float:T:=tFloat;
    _stringtype:T:=tString;
    else begin
     SetError(ceTypeExpected);
     exit;
    end;
   end;
  end else begin
   case tTok of
    _int:T:=tInt;
    _shortint:T:=tShortInt;
    _void:T:=tVoid;
    _byte:T:=tByte;
    _char:T:=tChar;
    _float:T:=tFloat;
    _stringtype:T:=tString;
    else begin
     SetError(ceTypeExpected);
     exit;
    end;
   end;
  end;
 end;
 Schleife:=true;
 while Schleife and not (feof or ferror) do begin
  IstArray:=false;
  Zeiger:=false;
  Schleife:=false;
  if not KeinGET then begin
   Get;
   KeinGET:=false;
  end;
  if tTok=_mul then begin
   Zeiger:=true;
   Get;
  end;
  if tTok=_ident then begin
   S:=sTok;
   Get;
   if (tTok=_doubledoublepoint) or (tTok=_dot) then begin
    SO:=S;
    Get;
    if tTok=_ident then begin
     S:=sTok;
     Get;
    end else begin
     SetError(ceBezeichnerErwartet);
    end;
   end;
  end else begin
   SetError(ceBezeichnerErwartet);
  end;
  if (tTok=_lparent) and (StartLevel or Struct) then begin
   if native or import then begin
    if LockVar(S,'',A,adr,true,-1) then begin
     SetError(ceVarDoppelDefiniert);
    end else begin
     adr:=AddObjekt(S,'',_call,T,0,0,aGlobal,Zeiger,Struct,Typ,0);
    end;
    if LockVar(S,'',A,adr,true,-1) then begin
    end;

    AktProc:=AktSymPtr;
    AktProcName:=S;

    NameTabelle[AktProc].isstdcall:=isstdcall;

    if tTok=_lparent then begin
     while (tTok<>_rparent) and not (feof or ferror) do begin
      Get;
      if tTok<>_rparent then VarDefStatement(false,true,false,-1,false);
      if tTok=_comma then begin
      end else if tTok=_rparent then begin
      end else begin
       SetError(ceFuncParamDefFehler);
      end;
     end;
     if tTok=_rparent then begin
      Get;
     end else begin
      SetError(ceRParenExp);
     end;
    end else begin
     SetError(ceLParenExp);
    end;

    if import then begin
     if tTok=_lparent then begin
      Get;
      if tTok=_string then begin
       LibName:=AktStr;
       Get;
       if tTok=_comma then begin
        Get;
        if tTok=_string then begin
         LibFunc:=AktStr;
         Get;
         AddImportProc(AktProcName,LibName,LibFunc);
        end else begin
         SetError(ceStringExpected);
        end;
       end else begin
        SetError(ceCommaExp);
       end;
      end else begin
       SetError(ceStringExpected);
      end;
      if tTok=_rparent then begin
       Get;
      end else begin
       SetError(ceRParenExp);
      end;
     end else begin
      SetError(ceLParenExp);
     end;
    end;

    if NameTabelle[AktProc].StructName<>'' then begin
     adr:=AddObjekt(tnFunctionObjectPointer,'',_ident,tType,0,0,aShadowParam,true,false,LookStruct(NameTabelle[AktProc].StructName),0);
    end;
    if not NameTabelle[AktProc].Zeiger then begin
     if NameTabelle[AktProc].Typ=tType then begin
      if not (TypTabelle[NameTabelle[AktProc].TypLink].Size in [1,2,4]) then begin
       adr:=AddObjekt(tnFunctionResult,'',_ident,tType,0,0,aShadowParam,true,false,NameTabelle[AktProc].TypLink,0);
      end;
     end;
    end;

    if AktProc>=0 then begin
     m:=4;
     for n:=NameTabelle[AktProc].TotalParamNum downto 1 do begin
      NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=4+M;
      B:=NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass;
      m:=m+B;
     end;
     if isstdcall then begin
      for n:=NameTabelle[AktProc].TotalParamNum downto 1 do begin
       NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=M;
       dec(M,NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass);
      end;
     end;
    end;

    NameTabelle[AktProc].native:=native;
    NameTabelle[AktProc].import:=import;
    if native then begin
     J:=-1;
     for I:=0 to tnpZaehler-1 do begin
      if NativeTabelle[I].name=S then begin
       J:=I;
       break;
      end;
     end;
     if J>=0 then begin
      NativeTabelle[I].AsmVarName:=A;
     end else begin
      SetError(ceNativeProcNichtGefunden);
     end;
    end else begin
     J:=-1;
     for I:=0 to length(ImportTabelle)-1 do begin
      if ImportTabelle[I].name=S then begin
       J:=I;
       break;
      end;
     end;
     if J>=0 then begin
      ImportTabelle[I].AsmVarName:=A;
     end else begin
      SetError(ceImportProcNichtGefunden);
     end;
    end;

    AktProcName:='';
    AktProc:=-1;
    inmain:=false;
   end else begin
    if not Struct then begin
     SL:=GeneratiereLabel;
     OutJmp(SL);
    end;
    OK:=true;
    if Struct then begin
     if LockVar(S,'',A,adr,true,ttZaehler) then begin
      SetError(ceVarDoppelDefiniert);
      OK:=false;
     end;
    end else if LockVar(S,SO,A,adr,true,-1) then begin
     SetError(ceVarDoppelDefiniert);
     OK:=false;
    end;
    if OK then begin
     adr:=AddObjekt(S,SO,_call,T,0,0,aGlobal,Zeiger,Struct,Typ,0);
    end;
    if Struct then begin
     NameTabelle[tnZaehler].InTypLink:=ttZaehler;
     NameTabelle[tnZaehler].BTyp:=ttZaehler;
     if LockVar(S,'',A,adr,true,ttZaehler) then begin
     end;
    end else if LockVar(S,SO,A,adr,true,-1) then begin
     OutLabel(A);
    end;
    if not Struct then begin
     ProcHinzufuegen(S,SO);
     if S='main' then inmain:=true;
    end;

    AktProc:=AktSymPtr;
    AktProcName:=S;

    NameTabelle[AktProc].isstdcall:=isstdcall;
    if Struct then begin
     NameTabelle[AktProc].InTypLink:=ttZaehler;
     NameTabelle[AktProc].BTyp:=ttZaehler;
    end;

    if tTok=_lparent then begin
     while (tTok<>_rparent) and not (feof or ferror) do begin
      Get;
      if tTok<>_rparent then VarDefStatement(false,true,false,-1,false);
      if tTok=_comma then begin
      end else if tTok=_rparent then begin
      end else begin
       SetError(ceFuncParamDefFehler);
      end;
     end;
     if tTok=_rparent then begin
      Get;
     end else begin
      SetError(ceRParenExp);
     end;
    end;

    if NameTabelle[AktProc].StructName<>'' then begin
     adr:=AddObjekt(tnFunctionObjectPointer,'',_ident,tType,0,0,aShadowParam,true,false,LookStruct(NameTabelle[AktProc].StructName),0);
    end;
    if not NameTabelle[AktProc].Zeiger then begin
     if NameTabelle[AktProc].Typ=tType then begin
      if not (TypTabelle[NameTabelle[AktProc].TypLink].Size in [1,2,4]) then begin
       adr:=AddObjekt(tnFunctionResult,'',_ident,tType,0,0,aShadowParam,true,false,NameTabelle[AktProc].TypLink,0);
      end;
     end;
    end;

    if AktProc>=0 then begin
     m:=4;
     for n:=NameTabelle[AktProc].TotalParamNum downto 1 do begin
      NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=4+M;
      B:=NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass;
      m:=m+B;
     end;
     if isstdcall then begin
      for n:=NameTabelle[AktProc].TotalParamNum downto 1 do begin
       NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr:=M;
       dec(M,NameTabelle[NameTabelle[AktProc].Param[n-1]].Bytes2Pass);
      end;
     end;
    end;

    if not Struct then begin
     inc(Level);
     setlength(BreakLabel,Level+1);
     setlength(ContinueLabel,Level+1);
     BreakLabel[Level]:='Return'+A;
     ContinueLabel[Level]:='Return'+A;

     OutPushBp;
     OutMovBpSp;
     OutSubESP(0);
     P1:=CodeStream.Position-4;
     OutPushBX;
     OutPushCX;
     OutPushDX;
     OutPushDI;
     OutPushSI;

     ByteHinzufuegen($eb);
     O1:=CodeStream.Position;
     ByteHinzufuegen($00);

     ByteHinzufuegen($b9); // MOV ECX,Laenge
     O2:=CodeStream.Position;
     DWordHinzufuegen($00);

     ByteHinzufuegen($89); ByteHinzufuegen($ef); // MOV EDI,EBP

     ByteHinzufuegen($81); // SUB EDI,NegOffset
     ByteHinzufuegen($ef); //  Laenge
     O3:=CodeStream.Position;
     DWordHinzufuegen($00);

     ByteHinzufuegen($f3); ByteHinzufuegen($aa); // REP STOSB

     O4:=CodeStream.Position;

     CodeStream.Seek(O1);
     ByteHinzufuegen(O4-O1-1);
     CodeStream.Seek(O4);

     for n:=1 to NameTabelle[AktProc].TotalParamNum do begin
      if NameTabelle[NameTabelle[AktProc].Param[n-1]].Art=aParam then begin
       if NameTabelle[NameTabelle[AktProc].Param[n-1]].Typ=tString then begin
        P:=NameTabelle[NameTabelle[AktProc].Param[n-1]].StackPtr;
        OutMovAxVarEBP(P,4);
//      OutStrGet;
        OutMovVarEBPAx(P,4);
       end;
      end;
     end;

     if tTok=_begin then BeginState;

     OutLabel('Return'+A);

     N:=0;
     for I:=1 to tnZaehler do begin
      if NameTabelle[I].Obj=_ident then begin
       if NameTabelle[I].Art=aLokal then begin
        if NameTabelle[I].Proc=AktProcName then begin
         if AreInThatStrings(I) then begin
          inc(N);
         end;
        end;
       end;
      end;
     end;

     if N>0 then begin
      OutPushAx;
      for I:=1 to tnZaehler do begin
       if NameTabelle[I].Obj=_ident then begin
        if NameTabelle[I].Art=aLokal then begin
         if NameTabelle[I].Proc=AktProcName then begin
          if AreInThatStrings(I) then begin
           OutLeaEBXEBP(-NameTabelle[I].StackPtr);
           FunctionStringFree(I,NameTabelle[I].Art,0,0);
          end;
         end;
        end;
       end;
      end;
      OutPopAx;
     end;

     OutPopSI;
     OutPopDI;
     OutPopDX;
     OutPopCX;
     OutPopBX;
     OutMovSpBp;
     OutPopBp;

     if AktProc>=0 then begin
      if (NameTabelle[AktProc].Typ=tFloat) and not NameTabelle[AktProc].Zeiger then begin
       OutAXToFPU;
      end;
      if NameTabelle[AktProc].Bytes2Pass>0 then begin
       OutRetValue(NameTabelle[AktProc].Bytes2Pass);
      end else begin
       OutRetEx;
      end;
     end else begin
      OutRetEx;
     end;

     P2:=CodeStream.Position;
     CodeStream.Seek(P1);
     DWordHinzufuegen(NameTabelle[AktProc].StackAlloc);
     CodeStream.Seek(P2);

     if NameTabelle[AktProc].StackAlloc>0 then begin
      O5:=CodeStream.Position;
      CodeStream.Seek(O1-1);
      ByteHinzufuegen($31); ByteHinzufuegen($c0); // XOR EAX,EAX
      CodeStream.Seek(O2);
      DWordHinzufuegen(NameTabelle[AktProc].StackAlloc);
      CodeStream.Seek(O3);
      DWordHinzufuegen(NameTabelle[AktProc].StackAlloc);
      CodeStream.Seek(O5);
     end;

     OutLabel(SL);
     dec(Level);
     setlength(BreakLabel,Level+1);
     setlength(ContinueLabel,Level+1);
    end;
    AktProcName:='';
    AktProc:=-1;
    inmain:=false;
   end;
  end else if (tTok=_lparent) and not StartLevel then begin
  end else begin
   if tTok=_klparent then begin
    Get;
    if tTok=_integer then begin
     ArrayDim:=iTok;
     Get;
     if tTok=_krparent then begin
      IstArray:=true;
      Get;
     end else begin
      SetError(ceKRParentErwartet);
     end;
    end else begin
     SetError(ceZahlenWertErwartet);
    end;
   end;
   if not IstArray then ArrayDim:=0;
   OK:=true;
   if Struct then begin
    if LockVar(S,'',A,adr,true,ttZaehler) then begin
     SetError(ceVarDoppelDefiniert);
     OK:=false;
    end;
   end else if LockVar(S,'',A,adr,true,-1) then begin
    SetError(ceVarDoppelDefiniert);
    OK:=false;
   end;
   if OK then begin
    if Struct then begin
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aStructVar,Zeiger,Struct,Typ,0);
    end else if length(MTRIM(AktProcName))=0 then begin
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aGlobal,Zeiger,Struct,Typ,0);
    end else if FuncParam then begin
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aParam,Zeiger,Struct,Typ,0);
    end else if static then begin
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aStatic,Zeiger,Struct,Typ,0);
    end else begin
     adr:=AddObjekt(S,'',_ident,T,0,ArrayDim,aLokal,Zeiger,Struct,Typ,0);
    end;
   end;
   if (tTok=_set) and IstArray and (T in [tChar,tuChar]) and Zeiger then begin
    Get;
    StringHandling.IstZeiger:=true;
    IsTermSigned:=false;
    DoExpression;
    OutMovVarAx(S,0,false,false);
   end else if (tTok=_set) and (T=tString) and not (Zeiger or IstArray) then begin
    Get;
    IsStringTerm:=true;
    MustBeStringTerm:=true;
    StringLevel:=0;
    StringBoolExpression(true);
    OutStrUnique;
    OutMovVarAx(S,0,false,false);
   end else if (tTok=_set) and not IstArray then begin
    Get;
    if T in [tChar,tuChar] then begin
     StringHandling.IstZeiger:=Zeiger;
    end else begin
     StringHandling.IstZeiger:=false;
    end;
    IsTermSigned:=NameTabelle[tnZaehler].Typ in [tByte,tChar,tShortInt,tInt];
    DoExpression;
    if (NameTabelle[tnZaehler].Typ=tFloat) and not NameTabelle[tnZaehler].Zeiger then begin
     if not IsFloatExpression then begin
      OutIntAxToFPU;
      OutFPUToAx;
     end;
    end;
    if StringHandling.IstZeiger then begin
     OutMovVarAx(S,0,false,false);
    end else begin
     OutMovVarAx(S,0,Zeiger,false);
    end;
   end;
   if (tTok=_comma) and not FuncParam then begin
    Schleife:=true;
    KeinGET:=false;
   end;
  end;
 end;
 if StartLevel then if tTok=_semicolon then Get;
end;

procedure TBeRoScript.LabelStatement;
var S:string;
    I,J:integer;
    Adr:integer;
    A:string;
begin
 S:=GetLabelName(sTok);
 if LockVar(sTok,'',a,Adr,false,-1) then begin
  SetError(ceLabelNameVariableDefiniert);
 end else begin
  J:=-1;
  for I:=0 to length(LabelArray)-1 do begin
   if LabelArray[I]=S then begin
    J:=I;
    break;
   end;
  end;
  if J<0 then begin
   AddObjekt(sTok,'',_labelident,tNichts,0,0,aLokal,false,false,-1,0);
   setlength(LabelArray,length(LabelArray)+1);
   LabelArray[length(LabelArray)-1]:=S;
   OutLabel(S);
  end else begin
   SetError(ceLabelDoppelDefiniert);
  end;
 end;
 Get;
end;

procedure TBeRoScript.GotoStatement;
var S:string;
    I,J:integer;
begin
 Get;
 if tTok=_labelident then begin
  S:=GetLabelName(sTok);
  J:=-1;
  for I:=0 to length(LabelArray)-1 do begin
   if LabelArray[I]=S then begin
    J:=I;
    break;
   end;
  end;
  if J>=0 then begin
   OutJmp(S);
  end else begin
   SetError(ceLabelNotFound);
  end;
  Get;
 end;
end;

procedure TBeRoScript.enumStatement(Art:TArt);
var S,a:string;
    I,J,Adr:integer;
    WertArray:array of integer;
    Wert,LetzterWert:integer;
begin
 Get;
 if tTok=_ident then begin
  S:=sTok;
  if not LockVar(S,'',a,Adr,false,-1) then begin
   AddObjekt(S,'',_enumstruct,tInt,0,0,Art,false,false,-1,0);
  end else begin
   SetError(ceENumStructAlreadyUsed);
  end;
  Get;
 end else if tTok=_enumstruct then begin
  SetError(ceENumStructAlreadyUsed);
  Get;
 end;
 if not ferror then begin
  if tTok=_begin then begin
   WertArray:=nil;
   Wert:=0;
   LetzterWert:=-1;
   Get;
   while not ((tTok=_end) or feof or ferror) do begin
    if tTok=_ident then begin
     S:=sTok;
     Get;
     if tTok=_set then begin
      Get;
      if tTok=_integer then begin
       Wert:=iTok;
       Get;
      end else begin
       SetError(ceZahlenWertErwartet);
      end;
     end else begin
      Wert:=LetzterWert;
      J:=0;
      while J>=0 do begin
       inc(Wert);
       J:=-1;
       for I:=0 to length(WertArray)-1 do begin
        if WertArray[I]=Wert then begin
         J:=I;
         break;
        end;
       end;
      end;
     end;
     J:=-1;
     for I:=0 to length(WertArray)-1 do begin
      if WertArray[I]=Wert then begin
       J:=I;
       break;
      end;
     end;
     if J<0 then begin
      setlength(WertArray,length(WertArray)+1);
      WertArray[length(WertArray)-1]:=Wert;
     end;
     LetzterWert:=Wert;
     if not LockVar(S,'',a,Adr,false,-1) then begin
      AddObjekt(S,'',_enumvalue,tInt,0,0,Art,false,false,-1,Wert);
     end else begin
      SetError(ceENumAlreadyDefined);
     end;
    end else if tTok=_enumvalue then begin
     SetError(ceENumAlreadyDefined);
     Get;
    end else begin
     SetError(ceBezeichnerErwartet);
     Get;
    end;
    if tTok=_comma then begin
     Get;
    end;
   end;
   if tTok=_end then begin
    Get;
   end else begin
    SetError(ceEndErwartet);
   end;
   setlength(WertArray,0);
  end else begin
   SetError(ceBeginErwartet);
  end;
 end;
end;

procedure TBeRoScript.BreakPointStatement;
begin
 Get;
 if Debug then ByteHinzufuegen($cc);
end;

procedure TBeRoScript.OutputBlockStatement;
begin
 Get;
 if tTok=_lparent then begin
  Get;
  IsTermSigned:=true;
  DoExpression;
  OutOutputBlock;
  if tTok=_rparent then begin
   Get;
  end else begin
   SetError(ceRParenExp);
  end;
 end else begin
  SetError(ceLParenExp);
 end;
end;

procedure TBeRoScript.SizeOfStatement;
var A:string;
    Adr:TWert;
    I:integer;
    Zeiger,HoleZeiger:boolean;
    AltAktSymPtr:integer;
begin
 Get;
 if tTok=_lparent then begin
  Get;
  Zeiger:=false;
  HoleZeiger:=false;
  while not (feof or ferror) do begin
   if tTok=_mul then begin
    Zeiger:=true;
    HoleZeiger:=false;
    Get;
   end else if tTok=_and then begin
    Zeiger:=false;
    HoleZeiger:=true;
    Get;
   end else begin
    break;
   end;
  end;
  if HoleZeiger then begin
   OutMovAxImmUnsigned(4);
  end else if tTok in [_int,_stringtype,_float,_void] then begin
   OutMovAxImmUnsigned(4);
  end else if tTok=_shortint then begin
   OutMovAxImmUnsigned(2);
  end else if tTok in [_byte,_char] then begin
   OutMovAxImmUnsigned(1);
  end else if tTok=_ident then begin
   I:=LookStruct(sTok);
   if I>=0 then begin
    OutMovAxImmUnsigned(TypTabelle[I].Size);
   end else begin
    if LockVar(sTok,'',a,Adr,false,-1) then begin
     if NameTabelle[AktSymPtr].Art=aGlobal then begin
      AltAktSymPtr:=AktSymPtr;
      if LookStructVar(sTok)<0 then begin
       AktSymPtr:=AltAktSymPtr;
       StructAssignment(false,false,false,true);
      end else begin
       StructAssignment(false,false,true,true);
      end;
     end else begin
      StructAssignment(false,false,false,true);
     end;
    end else begin
     if LookStructVar(sTok)<0 then begin
      SetError(ceVarNotDef);
     end else begin
      StructAssignment(false,false,true,true);
     end;
    end;
    if not fError then begin
     if NameTabelle[AktSymPtr].Zeiger and not Zeiger then begin
      OutMovAxImmUnsigned(4);
     end else if NameTabelle[AktSymPtr].EinTyp then begin
      if NameTabelle[AktSymPtr].IstArray then begin
       OutMovAxImmUnsigned(TypTabelle[NameTabelle[AktSymPtr].TypLink].Size*NameTabelle[AktSymPtr].ArrayDim);
      end else begin
       OutMovAxImmUnsigned(TypTabelle[NameTabelle[AktSymPtr].TypLink].Size);
      end;
     end else if NameTabelle[AktSymPtr].IstArray then begin
      OutMovAxImmUnsigned(NameTabelle[AktSymPtr].Size*NameTabelle[AktSymPtr].ArrayDim);
     end else begin
      OutMovAxImmUnsigned(NameTabelle[AktSymPtr].Size);
     end;
    end else begin
     SetError(ceVarNotDef);
    end;
   end;
  end else begin
   SetError(ceBezeichnerErwartet);
  end;
  if tTok<>_rparent then Get;
  if tTok=_rparent then begin
   Get;
  end else begin
   SetError(ceRParenExp);
  end;
 end else begin
  SetError(ceLParenExp);
 end;
end;

procedure TBeRoScript.InheritedStatement;
var S,SO,SS,A,SA:string;
    I,J,K,L,M:integer;
    Ident,Gefunden:boolean;
    Adr:TWert;
    AltAktSymPtr:integer;
begin
 Get;
 if AktProc>=0 then begin
  if length(NameTabelle[AktProc].StructName)>0 then begin
   S:=NameTabelle[AktProc].name;
   SO:='';
   Ident:=true;
   if tTok=_ident then begin
    SS:=sTok;
    Get;
    if IsStruct(SS) then begin
     SO:=SS;
     if tTok=_dot then begin
      Get;
      if tTok=_ident then begin
       Ident:=true;
       S:=sTok;
       Get;
      end else begin
       SetError(ceBezeichnerErwartet);
      end;
     end;
    end else begin
     Ident:=true;
     S:=SS;
    end;
   end;
   I:=LookStruct(NameTabelle[AktProc].StructName);
   if I>=0 then begin
    AltAktSymPtr:=0;
    K:=length(TypTabelle[I].Extends);
    Gefunden:=false;
    if K>0 then begin
     M:=0;
     for J:=K-1 downto 0 do begin
      L:=TypTabelle[I].Extends[J];
      if (SO=TypTabelle[L].name) or (SO='') then begin
       if LockVar(S,TypTabelle[L].name,A,Adr,false,-1) then begin
        M:=J;
        AltAktSymPtr:=AktSymPtr;
        Gefunden:=true;
        break;
       end;
      end;
     end;
     if Gefunden then begin
      if LockVar(tnFunctionObjectPointer,'',SA,Adr,false,-1) then begin
       OutMovCxVarEBP(NameTabelle[AktSymPtr].StackPtr,4);
      end;
      OutAddECX(TypTabelle[I].ExtendsOffsets[M]);
      OutMovBxImmLabel(a);
      AktSymPtr:=AltAktSymPtr;
      CallState(false,true,Ident);
     end else begin
      SetError(ceNoInheritedCallPossible);
     end;
    end else begin
     SetError(ceNoInheritedCallPossible);
    end;
   end else begin
    SetError(ceOnlyInMethodAllowed);
   end;
  end else begin
   SetError(ceOnlyInMethodAllowed);
  end;
 end else begin
  SetError(ceOnlyInMethodAllowed);
 end;
end;

procedure TBeRoScript.IdentStatement;
begin
 if not VarStruct(true) then Statement(true);
end;

procedure TBeRoScript.Statement(Semicolon:boolean);
var OldTok:integer;
begin
 OldTok:=tTok;
 case tTok of
  _begin:BeginState;
  _while:WhileState;
  _do:DoWhileState;
  _for:ForState;
  _if:IfState;
  _switch:SwitchState;
  _printf,_print:PrntStatement;
  _asm:ASMStatement;
  _ident:AssignmentOrVarStruct;
  _mul:Assignment;
  _break:begin
   OutJmp(BreakLabel[Level]);
   Get;
  end;
  _continue:begin
   OutJmp(ContinueLabel[Level]);
   Get;
  end;
  _call:AssignmentOrVarStruct;
  _shortint,_void,_int,_byte,_char,_float,_stringtype,_unsigned,_signed,_static,_native,_import,_stdcall:VarDefStatement(false,false,false,-1,false);
  _return:ReturnStatement;
  _packed,_struct:StructStatement(false,false,false);
  _union:StructStatement(false,true,false);
  _object:StructStatement(false,false,true);
  _label:LabelStatement;
  _goto:GotoStatement;
  _enum:enumStatement(aLokal);
  _breakpoint:BreakPointStatement;
  _outputblock:OutputBlockStatement;
  _sizeof:SizeOfStatement;
  _inherited:InheritedStatement;
  _semicolon:Get;
  else begin
   SetError(ceUndefErr);
  end;
 end;
 if Semicolon and not fError then begin
  case OldTok of
   _printf,_print,_ident,_mul,_call, _shortint,_void,_int,_byte,_char,_float,_stringtype,_unsigned,_signed,_static,_break,_continue,_return,_packed,_struct,_union,_native,_import,_stdcall,_goto,_breakpoint,_outputblock,_sizeof,_inherited:begin
    if tTok=_semicolon then begin
     Get;
    end else if tTok=_end then begin
    end else begin
     SetError(ceSemiColonErwartet);
    end;
   end;
   else begin
   end;
  end;
 end;
end;

procedure TBeRoScript.FirstStatement;
begin
 while not (feof or ferror) do begin
  case tTok of
   _shortint,_void,_int,_byte,_char,_float,_stringtype,_unsigned,_signed,_static,_native,_import,_stdcall:VarDefStatement(true,false,false,-1,false);
   _ident:IdentStatement;
   _packed,_struct:StructStatement(true,false,false);
   _union:StructStatement(true,true,false);
   _object:StructStatement(true,false,true);
   _enum:enumStatement(aGlobal);
   _semicolon:Get;
   else Statement(true);
  end;
 end;
end;

procedure TBeRoScript.Init;
begin
 IsCompiled:=false;
 UseOutputBlock:=false;
 UseWrtSTR:=false;
 UseWrtAXSigned:=false;
 UseWrtAXUnsigned:=false;
 UseWrtChar:=false;
 UseWrtPCharString:=false;
 UseWrtFloat:=false;
 UseStrNew:=false;
 UseStrAssign:=false;
 UseStrLength:=false;
 UseStrSetLength:=false;
 UseStrUnique:=false;
 UseStrCharConvert:=false;
 UseStrGet:=false;
 UseStrConcat:=false;
 UseStrSelfConcat:=false;
 UseStrCompare:=false;
 AktSymPtr:=-1;
 AktTypPtr:=-1;
 AktProc:=-1;
 AktProcName:='';
 QuelltextPos:=1;
 QuelltextZeile:=0;
 QuelltextSpalte:=0;
 feof:=false;
 p:=0;
 Level:=0;
 setlength(BreakLabel,Level+1);
 setlength(ContinueLabel,Level+1);
 BreakLabel[Level]:='C_exit';
 ContinueLabel[Level]:='C_exit';
 DP:=0;
 tnZaehler:=0;
 ttZaehler:=0;
 tnSubZaehler:=0;
 ferror:=true;
 frunning:=false;
 inmain:=false;
 SBuf:='';
 AddObjekt('{','',_keyword,tNichts,_begin,0,aGlobal,false,false,-1,0);
 AddObjekt('else','',_keyword,tNichts,_else,0,aGlobal,false,false,-1,0);
 AddObjekt('}','',_keyword,tNichts,_end,0,aGlobal,false,false,-1,0);
 AddObjekt('asm','',_keyword,tNichts,_asm,0,aGlobal,false,false,-1,0);
 AddObjekt('if','',_keyword,tNichts,_if,0,aGlobal,false,false,-1,0);
 AddObjekt('switch','',_keyword,tNichts,_switch,0,aGlobal,false,false,-1,0);
 AddObjekt('case','',_keyword,tNichts,_case,0,aGlobal,false,false,-1,0);
 AddObjekt('default','',_keyword,tNichts,_default,0,aGlobal,false,false,-1,0);
 AddObjekt('while','',_keyword,tNichts,_while,0,aGlobal,false,false,-1,0);
 AddObjekt('do','',_keyword,tNichts,_do,0,aGlobal,false,false,-1,0);
 AddObjekt('for','',_keyword,tNichts,_for,0,aGlobal,false,false,-1,0);
 AddObjekt('printf','',_keyword,tNichts,_printf,0,aGlobal,false,false,-1,0);
 AddObjekt('print','',_keyword,tNichts,_print,0,aGlobal,false,false,-1,0);
 AddObjekt('echo','',_keyword,tNichts,_print,0,aGlobal,false,false,-1,0);
 AddObjekt('shortint','',_keyword,tNichts,_shortint,0,aGlobal,false,false,-1,0);
 AddObjekt('void','',_keyword,tNichts,_void,0,aGlobal,false,false,-1,0);
 AddObjekt('file','',_keyword,tNichts,_void,0,aGlobal,false,false,-1,0);
 AddObjekt('int','',_keyword,tNichts,_int,0,aGlobal,false,false,-1,0);
 AddObjekt('long','',_keyword,tNichts,_int,0,aGlobal,false,false,-1,0);
 AddObjekt('byte','',_keyword,tNichts,_byte,0,aGlobal,false,false,-1,0);
 AddObjekt('char','',_keyword,tNichts,_char,0,aGlobal,false,false,-1,0);
 AddObjekt('float','',_keyword,tNichts,_float,0,aGlobal,false,false,-1,0);
 AddObjekt('string','',_keyword,tNichts,_stringtype,0,aGlobal,false,false,-1,0);
 AddObjekt('unsigned','',_keyword,tNichts,_unsigned,0,aGlobal,false,false,-1,0);
 AddObjekt('signed','',_keyword,tNichts,_signed,0,aGlobal,false,false,-1,0);
 AddObjekt('break','',_keyword,tNichts,_break,0,aGlobal,false,false,-1,0);
 AddObjekt('continue','',_keyword,tNichts,_continue,0,aGlobal,false,false,-1,0);
 AddObjekt('static','',_keyword,tNichts,_static,0,aGlobal,false,false,-1,0);
 AddObjekt('return','',_keyword,tNichts,_return,0,aGlobal,false,false,-1,0);
 AddObjekt('struct','',_keyword,tNichts,_struct,0,aGlobal,false,false,-1,0);
 AddObjekt('packed','',_keyword,tNichts,_packed,0,aGlobal,false,false,-1,0);
 AddObjekt('inherited','',_keyword,tNichts,_inherited,0,aGlobal,false,false,-1,0);
 AddObjekt('union','',_keyword,tNichts,_union,0,aGlobal,false,false,-1,0);
 AddObjekt('object','',_keyword,tNichts,_object,0,aGlobal,false,false,-1,0);
 AddObjekt('native','',_keyword,tNichts,_native,0,aGlobal,false,false,-1,0);
 AddObjekt('import','',_keyword,tNichts,_import,0,aGlobal,false,false,-1,0);
 AddObjekt('stdcall','',_keyword,tNichts,_stdcall,0,aGlobal,false,false,-1,0);
 AddObjekt('goto','',_keyword,tNichts,_goto,0,aGlobal,false,false,-1,0);
 AddObjekt('enum','',_keyword,tNichts,_enum,0,aGlobal,false,false,-1,0);
 AddObjekt('breakpoint','',_keyword,tNichts,_breakpoint,0,aGlobal,false,false,-1,0);
 AddObjekt('outputblock','',_keyword,tNichts,_outputblock,0,aGlobal,false,false,-1,0);
 AddObjekt('sizeof','',_keyword,tNichts,_sizeof,0,aGlobal,false,false,-1,0);
 AddObjekt('bool','',_keyword,tNichts,_int,0,aGlobal,false,false,-1,0);
 AddObjekt('BOOL','',_keyword,tNichts,_int,0,aGlobal,false,false,-1,0);
 AddObjekt('boolean','',_keyword,tNichts,_char,0,aGlobal,false,false,-1,0);
 AddObjekt('false','',_enumvalue,tNichts,_int,0,aGlobal,false,false,-1,0);
 AddObjekt('true','',_enumvalue,tNichts,_int,0,aGlobal,false,false,-1,1);
 AddObjekt('FALSE','',_enumvalue,tNichts,_int,0,aGlobal,false,false,-1,0);
 AddObjekt('TRUE','',_enumvalue,tNichts,_int,0,aGlobal,false,false,-1,1);
 AddObjekt('NULL','',_enumvalue,tNichts,_int,0,aGlobal,false,false,-1,0);
end;

procedure TBeRoScript.OutRTL;
begin
 if UseOutputBlock then begin
  OutLabel('C_OutputBlock');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_OUTPUTBLOCK');
  OutRetEx;
 end;
 if UseWrtSTR then begin
  OutLabel('C_PrintString');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_STRING');
  OutRetEx;
 end;
 if UseWrtAXSigned then begin
  OutLabel('C_WRITENUMSIGNED');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_NUMBER_SIGNED');
  OutRetEx;
 end;
 if UseWrtAXUnsigned then begin
  OutLabel('C_WRITENUMUNSIGNED');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_NUMBER_UNSIGNED');
  OutRetEx;
 end;
 if UseWrtChar then begin
  OutLabel('C_PrintChar');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_CHAR');
  OutRetEx;
 end;
 if UseWrtPCharString then begin
  OutLabel('C_PrintPCharString');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_PCHAR');
  OutRetEx;
 end;
 if UseWrtFloat then begin
  OutLabel('C_PrintFloat');
  OutPushClassPointer;
  OutPushAx;
  OutCallNative('RTL_PRINTF_FLOAT');
  OutRetEx;
 end;
 if UseStrNew then begin
  OutLabel('C_StrNew');
  OutCallNative('RTL_STRING_NEW');
  OutRetEx;
 end;
 if UseStrAssign then begin
  OutLabel('C_StrAssign');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_ASSIGN');
  OutRetEx;
 end;
 if UseStrLength then begin
  OutLabel('C_StrLength');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_LENGTH');
  OutRetEx;
 end;
 if UseStrSetLength then begin
  OutLabel('C_StrSetLength');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_SETLENGTH');
  OutRetEx;
 end;
 if UseStrUnique then begin
  OutLabel('C_StrUnique');
  OutPushAx;
  OutCallNative('RTL_STRING_UNIQUE');
  OutRetEx;
 end;
 if UseStrCharConvert then begin
  OutLabel('C_StrCharConvert');
  OutPushAx;
  OutCallNative('RTL_STRING_CHARCONVERT');
  OutRetEx;
 end;
 if UseStrGet then begin
  OutLabel('C_StrGet');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_GET');
  OutRetEx;
 end;
 if UseStrConcat then begin
  OutLabel('C_StrConcat');
  OutPushBx;
  OutPushAx;
  OutPushCx;
  OutCallNative('RTL_STRING_CONCAT');
  OutRetEx;
 end;
 if UseStrSelfConcat then begin
  OutLabel('C_StrSelfConcat');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_SELF_CONCAT');
  OutRetEx;
 end;
 if UseStrCompare then begin
  OutLabel('C_StrCompare');
  OutPushAx;
  OutPushBx;
  OutCallNative('RTL_STRING_COMPARE');
  OutRetEx;
 end;
end;

procedure TBeRoScript.DoCompile;
var I,J,K:integer;
    Adr:TWert;
    a:string;
begin
 AktSymPtr:=-1;
 AktTypPtr:=-1;
 AktProc:=-1;
 AktProcName:='';
 QuelltextPos:=1;
 QuelltextZeile:=0;
 QuelltextSpalte:=0;
 feof:=false;
 ferror:=false;
 ch:=LeseNaechstesZeichen;
 Get;               

 ProcHinzufuegen('$start','');
 ByteHinzufuegen($60); // PUSHAD
 OutPushBp;
 OutMovBpSp;
 FirstStatement;
 OutMovSpBp;
 OutPopBp;
 ByteHinzufuegen($61); // POPAD
 ByteHinzufuegen($c3); // RET

 ProcHinzufuegen('$main','');
 ByteHinzufuegen($60); // PUSHAD
 OutPushBp;
 OutMovBpSp;
 if LockVar('main','',a,Adr,false,-1) then CallLabel(a);
 OutMovSpBp;
 OutPopBp;
 ByteHinzufuegen($61); // POPAD
 ByteHinzufuegen($c3); // RET

 ProcHinzufuegen('$end','');
 ByteHinzufuegen($60); // PUSHAD
 OutPushBp;
 OutMovBpSp;
 tnSubZaehler:=0;
 for I:=1 to tnZaehler do if NameTabelle[I].Obj=_ident then inc(tnSubZaehler);
 LabelHinzufuegen('C_Exit');
 for I:=1 to tnZaehler do begin
  if NameTabelle[I].Obj=_ident then begin
   if NameTabelle[I].Art in [aGlobal,aStatic] then begin
    if AreInThatStrings(I) then begin
     OutMovBxImmLabel(NameTabelle[I].AsmVarName);
     FunctionStringFree(I,NameTabelle[I].Art,0,0);
    end;
   end;
  end;
 end;
 OutMovSpBp;
 OutPopBp;
 ByteHinzufuegen($61); // POPAD
 ByteHinzufuegen($c3); // RET

 OutRTL;

 LabelHinzufuegen('CodeEnd');
 BSSGroesse:=0;
 if tnSubZaehler>0 then begin
  for I:=1 to tnZaehler do begin
   if NameTabelle[I].Obj=_ident then begin
    if NameTabelle[I].Art in [aGlobal,aStatic] then begin
     if NameTabelle[I].Art=aGlobal then begin
      VariableHinzufuegen(NameTabelle[I].name,'');
     end else if NameTabelle[I].Art=aStatic then begin
      VariableHinzufuegen(NameTabelle[I].name,NameTabelle[I].Proc);
     end;
     if NameTabelle[I].Zeiger then begin
      LabelHinzufuegen(NameTabelle[I].AsmVarName);
      DWordHinzufuegen(0);
      inc(BSSGroesse,4);
     end else if NameTabelle[I].IstArray then begin
      LabelHinzufuegen(NameTabelle[I].AsmVarName);
      inc(BSSGroesse,NameTabelle[I].Size*NameTabelle[I].ArrayDim);
      for J:=1 to NameTabelle[I].ArrayDim do begin
       if NameTabelle[I].Typ in [tChar,tuChar,tByte,tuByte] then ByteHinzufuegen(0);
       if NameTabelle[I].Typ in [tShortInt,tuShortInt] then WordHinzufuegen(0);
       if NameTabelle[I].Typ in [tInt,tuInt,tFloat,tString,tVoid] then DWordHinzufuegen(0);
       if NameTabelle[I].Typ=tType then begin
        for K:=1 to NameTabelle[I].Size do ByteHinzufuegen(0);
       end;
      end;
     end else begin
      LabelHinzufuegen(NameTabelle[I].AsmVarName);
      inc(BSSGroesse,NameTabelle[I].Size);
      if NameTabelle[I].Typ in [tChar,tuChar,tByte,tuByte] then ByteHinzufuegen(0);
      if NameTabelle[I].Typ in [tShortInt,tuShortInt] then WordHinzufuegen(0);
      if NameTabelle[I].Typ in [tInt,tuInt,tFloat,tString,tVoid] then DWordHinzufuegen(0);
      if NameTabelle[I].Typ=tType then begin
       for K:=1 to NameTabelle[I].Size do ByteHinzufuegen(0);
      end;
     end;
    end;
   end;
  end;
 end;
 Errors:=TRIM(Errors);
 Fehler:=length(Errors)>0;
end;

procedure TBeRoScript.AddNativeProc(name:string;Proc:pointer);
begin
 setlength(NativeTabelle,tnpZaehler+1);
 NativeTabelle[tnpZaehler].name:=name;
 NativeTabelle[tnpZaehler].Proc:=Proc;
 inc(tnpZaehler);
end;

procedure TBeRoScript.AddDefine(name:string);
 function ExistDefine(name:string):boolean;
 var I:integer;
 begin
  result:=false;
  if length(name)>0 then begin
   for I:=0 to length(Defines)-1 do begin
    if Defines[I].name=name then begin
     result:=true;
     exit;
    end;
   end;
  end;
 end;
begin
 if not ExistDefine(name) then begin
  setlength(Defines,length(Defines)+1);
  Defines[length(Defines)-1].name:=name;
 end;
end;

procedure TBeRoScript.Preprocessor;
var OutStream:TBeRoMemoryStream;
    OutLineNumber:integer;
    PreprocessorDefines:array of TDefine;
    I,J:integer;
  function ExistDefine(name:string):boolean;
  var I:integer;
  begin
  result:=false;
  if length(name)>0 then begin
   for I:=0 to length(PreprocessorDefines)-1 do begin
    if PreprocessorDefines[I].name=name then begin
     result:=true;
     exit;
    end;
   end;
  end;
 end;
 procedure AddPreprocessorDefine(name:string);
 begin
  if not ExistDefine(name) then begin
   setlength(PreprocessorDefines,length(PreprocessorDefines)+1);
   PreprocessorDefines[length(PreprocessorDefines)-1].name:=name;
   PreprocessorDefines[length(PreprocessorDefines)-1].Parameter:=nil;
  end;
 end;
 function DeleteDefine(name:string):boolean;
 var I:integer;
 begin
  result:=false;
  if length(name)>0 then begin
   for I:=0 to length(PreprocessorDefines)-1 do begin
    if PreprocessorDefines[I].name=name then begin
     PreprocessorDefines[I].name:='';
     PreprocessorDefines[I].Lines:='';
     setlength(PreprocessorDefines[I].Parameter,0);;
     result:=true;
     exit;
    end;
   end;
  end;
 end;
 procedure AddLine(Line:string;LineNumber,FileIndex:integer);
 begin
  OutStream.WriteLine(Line);
  inc(OutLineNumber);
  if OutLineNumber>0 then begin
   setlength(LinesInfo.Lines,OutLineNumber);
   if LineNumber<=length(LinesInfo.PreparsedLines) then begin
    LinesInfo.Lines[OutLineNumber-1]:=LinesInfo.PreparsedLines[LineNumber-1];
   end else begin
    LinesInfo.Lines[OutLineNumber-1].LineNumber:=LineNumber;
    LinesInfo.Lines[OutLineNumber-1].FileIndex:=FileIndex;
   end;
  end;
 end;
 procedure ProcessFile(InputSource,FileName:string;LineSub:integer);
 var Lines:TBeRoMemoryStream;
     Line:string;
     LineNumber:integer;
     FileIndex:integer;
  procedure NextLine;
  begin
   Line:=Lines.ReadLine;
   inc(LineNumber);
  end;
  procedure RunLevel(Level,SkipLevel:integer);
  var S,SA,name,Parameter,MacroLine,TheFile:string;
      I,J,K,H:integer;
      Schleife,IstOnce,IncludeInOrdnung:boolean;
      MacroParameter:array of string;
   procedure GetName;
   begin
    name:='';
    while length(S)>0 do begin
     if S[1] in ['a'..'z','A'..'Z','0'..'9','_'] then begin
      name:=name+S[1];
      DELETE(S,1,1);
     end else begin
      break;
     end;
    end;
   end;
   procedure GetParameter;
   begin
    Parameter:='';
    while length(S)>0 do begin
     if S[1] in ['a'..'z','A'..'Z','0'..'9','_'] then begin
      Parameter:=Parameter+S[1];
      DELETE(S,1,1);
     end else begin
      break;
     end;
    end;
   end;
  begin
   MacroParameter:=nil;
   while Lines.Position<Lines.Size do begin
    NextLine;
    S:=TRIM(Line);
    if (SkipLevel>=0) and (Level>SkipLevel) then begin
     if POS('#ifdef',S)=1 then RunLevel(Level+1,SkipLevel);
     if POS('#ifndef',S)=1 then RunLevel(Level+1,SkipLevel);
     if POS('#else',S)=1 then begin
      if SkipLevel=(Level-1) then begin
       SkipLevel:=-1;
      end;
     end;
     if POS('#endif',S)=1 then break;
    end else begin
     if POS('#',S)=1 then begin
      if POS('#define',S)=1 then begin
       DELETE(S,1,length('#define'));
       S:=TRIM(S);
       GetName;
       S:=TRIM(S);
       if length(S)>0 then begin
        if not ExistDefine(name) then begin
         setlength(PreprocessorDefines,length(PreprocessorDefines)+1);
         PreprocessorDefines[length(PreprocessorDefines)-1].name:=name;
         PreprocessorDefines[length(PreprocessorDefines)-1].Parameter:=nil;
         if S[1]='(' then begin
          DELETE(S,1,1);
          S:=TRIM(S);
          while true do begin
           if length(S)>0 then begin
            GetParameter;
            if length(Parameter)>0 then begin
             setlength(PreprocessorDefines[length(PreprocessorDefines)-1].Parameter,length(PreprocessorDefines[length(PreprocessorDefines)-1].Parameter)+1);
             PreprocessorDefines[length(PreprocessorDefines)-1].Parameter[length(PreprocessorDefines[length(PreprocessorDefines)-1].Parameter)-1]:=Parameter;
            end else begin
             break;
            end;
            S:=TRIM(S);
            if length(S)>0 then begin
             if S[1]=')' then begin
              DELETE(S,1,1);
              S:=TRIM(S);
              break;
             end else if S[1]=',' then begin
              DELETE(S,1,1);
              S:=TRIM(S);
             end else begin
              SetError(cePreprocessorError);
              break;
             end;
            end;
           end else begin
            SetError(cePreprocessorError);
            break;
           end;
          end;
         end;
         if S[length(S)]='\' then begin
          S:=COPY(S,1,length(S)-1);
          PreprocessorDefines[length(PreprocessorDefines)-1].Lines:=S;
          while true do begin
           NextLine;
           S:=Line;
           if length(S)>0 then begin
            PreprocessorDefines[length(PreprocessorDefines)-1].Lines:=PreprocessorDefines[length(PreprocessorDefines)-1].Lines+S+#13#10;
            if S[length(S)]<>'\' then exit;
           end else begin
            break;
           end;
          end;
         end else begin
          PreprocessorDefines[length(PreprocessorDefines)-1].Lines:=S;
         end;
        end;
       end else begin
        AddPreprocessorDefine(name);
       end;
      end;
      if POS('#undef',S)=1 then begin
       DELETE(S,1,length('#undef'));
       S:=TRIM(S);
       GetName;
       DeleteDefine(name);
      end;
      if POS('#ifdef',S)=1 then begin
       DELETE(S,1,length('#ifdef'));
       S:=TRIM(S);
       GetName;
       if ExistDefine(name) then begin
        RunLevel(Level+1,-1);
       end else begin
        RunLevel(Level+1,Level);
       end;
      end;
      if POS('#ifndef',S)=1 then begin
       DELETE(S,1,length('#ifndef'));
       S:=TRIM(S);
       GetName;
       if not ExistDefine(name) then begin
        RunLevel(Level+1,-1);
       end else begin
        RunLevel(Level+1,Level);
       end;
      end;
      if POS('#else',S)=1 then begin
       SkipLevel:=Level-1;
      end;
      if POS('#include',S)=1 then begin
       if POS('#includeonce',S)=1 then begin
        DELETE(S,1,length('#includeonce'));
        IstOnce:=true;
       end else begin
        DELETE(S,1,length('#include'));
        IstOnce:=false;
       end;
       TheFile:=TRIM(S);
       if length(TheFile)>0 then begin
        if TheFile[1]='<' then begin
         DELETE(TheFile,1,1);
         if length(TheFile)>0 then begin
          if TheFile[length(TheFile)]='>' then begin
           DELETE(TheFile,length(TheFile),1);
          end;
         end;
        end;
       end;
       if length(TheFile)>0 then begin
        if TheFile[1]='"' then begin
         DELETE(TheFile,1,1);
         if length(TheFile)>0 then begin
          if TheFile[length(TheFile)]='"' then begin
           DELETE(TheFile,length(TheFile),1);
          end;
         end;
        end;
       end;
       if length(TheFile)>0 then begin
        AddLine('',LineNumber,FileIndex);
        IncludeInOrdnung:=true;
        if IstOnce then begin
         for J:=0 to length(LinesInfo.Files)-1 do begin
          if LinesInfo.Files[J]=TheFile then begin
           IncludeInOrdnung:=false;
           break;
          end;
         end;
        end;
        if IncludeInOrdnung then begin
         ProcessFile(ReadFileAsString(TheFile),TheFile,0);
        end;
       end;
      end;
     end else begin
      Schleife:=true;
      while Schleife do begin
       Schleife:=false;
       for I:=0 to length(PreprocessorDefines)-1 do begin
        if length(PreprocessorDefines[I].Lines)>0 then begin
         if length(PreprocessorDefines[I].Parameter)>0 then begin
          MacroLine:=PreprocessorDefines[I].Lines;
          S:=Line;
          J:=1;
          while true do begin
           K:=MeinePosition(Line,PreprocessorDefines[I].name,J);
           if K<=0 then break;
           J:=K;
           DELETE(Line,K,length(PreprocessorDefines[I].name));
           if (length(Line)-K)>0 then begin
            setlength(MacroParameter,0);
            if Line[K]='(' then begin
             S:=COPY(Line,K,length(Line)-K+1);
             SA:=S;
             if S[1]='(' then begin
              DELETE(S,1,1);
              S:=TRIM(S);
              while true do begin
               if length(S)>0 then begin
                Parameter:=S;
                for H:=1 to length(Parameter) do begin
                 if Parameter[H] in [',',')'] then begin
                  Parameter:=COPY(Parameter,1,H-1);
                  DELETE(S,1,H-1);
                  break;
                 end;
                end;
                if length(Parameter)>0 then begin
                 setlength(MacroParameter,length(MacroParameter)+1);
                 MacroParameter[length(MacroParameter)-1]:=Parameter;
                end;
                S:=TRIM(S);
                if length(S)>0 then begin
                 if S[1]=')' then begin
                  DELETE(S,1,1);
                  S:=TRIM(S);
                  break;
                 end else if S[1]=',' then begin
                  DELETE(S,1,1);
                  S:=TRIM(S);
                 end else begin
                  SetError(cePreprocessorError);
                  break;
                 end;
                end;
               end else begin
                SetError(cePreprocessorError);
                break;
               end;
              end;
             end;
             if length(MacroParameter)=length(PreprocessorDefines[I].Parameter) then begin
              Schleife:=true;
              for H:=0 to length(PreprocessorDefines[I].Parameter)-1 do begin
               MacroLine:=StringErsetzen(MacroLine,PreprocessorDefines[I].Parameter[H],MacroParameter[H]);
              end;
              DELETE(Line,K,length(SA)-length(S));
              INSERT(MacroLine,Line,K);
             end else begin
              SetError(cePreprocessorError);
              break;
             end;
            end else begin
             SetError(cePreprocessorError);
             break;
            end;
           end else begin
            SetError(cePreprocessorError);
            break;
           end;
          end;
         end else begin
          if MeinePosition(Line,PreprocessorDefines[I].name,0)>0 then begin
           Line:=StringErsetzen(Line,PreprocessorDefines[I].name,PreprocessorDefines[I].Lines);
           Schleife:=true;
          end;
         end;
        end;
       end;
      end;
      AddLine(Line,LineNumber,FileIndex);
     end;
    end;
   end;
   setlength(MacroParameter,0);
  end;
 begin
  FileIndex:=length(LinesInfo.Files);
  setlength(LinesInfo.Files,FileIndex+1);
  LinesInfo.Files[FileIndex]:=FileName;
  LineNumber:=-LineSub;
  Lines:=TBeRoMemoryStream.Create;
  Lines.Text:=InputSource;
  Lines.Seek(0);
  RunLevel(0,-1);
  Lines.Destroy;
 end;
begin
 PreprocessorDefines:=nil;
 for I:=0 to length(Defines)-1 do begin
  if not ExistDefine(Defines[I].name) then begin
   setlength(PreprocessorDefines,length(PreprocessorDefines)+1);
   PreprocessorDefines[length(PreprocessorDefines)-1]:=Defines[I];
  end;
 end;
 if QuellStream.Size>0 then begin
  OutLineNumber:=-LineDifference;
  OutStream:=TBeRoMemoryStream.Create;
  ProcessFile(QuellStream.Text,CodeFileName,LineDifference);
  QuellStream.Assign(OutStream);
  QuellStream.Seek(0);
  OutStream.Destroy;
 end;
 for I:=0 to length(PreprocessorDefines)-1 do begin
  PreprocessorDefines[I].name:='';
  PreprocessorDefines[I].Lines:='';
  for J:=0 to length(PreprocessorDefines[I].Parameter)-1 do PreprocessorDefines[I].Parameter[J]:='';
  setlength(PreprocessorDefines[I].Parameter,0);
 end;
 setlength(PreprocessorDefines,0);
 setlength(LinesInfo.PreparsedLines,0);
end;

procedure TBeRoScript.AddString(const S:string);
begin
 if length(S)>0 then QuellStream.write(S[1],length(S));
end;

procedure TBeRoScript.AddNativePointers;
begin
 // RTL Routinen definieren
 AddNativeProc('RTL_OUTPUTBLOCK',@RTL_OUTPUTBLOCK);
 AddNativeProc('RTL_PRINTF_STRING',@RTL_PRINTF_STRING);
 AddNativeProc('RTL_PRINTF_NUMBER_SIGNED',@RTL_PRINTF_NUMBER_SIGNED);
 AddNativeProc('RTL_PRINTF_NUMBER_UNSIGNED',@RTL_PRINTF_NUMBER_UNSIGNED);
 AddNativeProc('RTL_PRINTF_PCHAR',@RTL_PRINTF_PCHAR);
 AddNativeProc('RTL_PRINTF_CHAR',@RTL_PRINTF_CHAR);
 AddNativeProc('RTL_PRINTF_FLOAT',@RTL_PRINTF_FLOAT);
 AddNativeProc('RTL_STRING_NEW',@RTL_STRING_NEW);
 AddNativeProc('RTL_STRING_INCREASE',@RTL_STRING_INCREASE);
 AddNativeProc('RTL_STRING_DECREASE',@RTL_STRING_DECREASE);
 AddNativeProc('RTL_STRING_ASSIGN',@RTL_STRING_ASSIGN);
 AddNativeProc('RTL_STRING_LENGTH',@RTL_STRING_LENGTH);
 AddNativeProc('RTL_STRING_SETLENGTH',@RTL_STRING_SETLENGTH);
 AddNativeProc('RTL_STRING_UNIQUE',@RTL_STRING_UNIQUE);
 AddNativeProc('RTL_STRING_CHARCONVERT',@RTL_STRING_CHARCONVERT);
 AddNativeProc('RTL_STRING_GET',@RTL_STRING_GET);
 AddNativeProc('RTL_STRING_CONCAT',@RTL_STRING_CONCAT);
 AddNativeProc('RTL_STRING_SELF_CONCAT',@RTL_STRING_SELF_CONCAT);
 AddNativeProc('RTL_STRING_COMPARE',@RTL_STRING_COMPARE);
 AddNativeProc('round',@RTL_ROUND);
 AddNativeProc('trunc',@RTL_TRUNC);
 AddNativeProc('sin',@RTL_SIN);
 AddNativeProc('cos',@RTL_COS);
 AddNativeProc('abs',@RTL_ABS);
 AddNativeProc('frac',@RTL_FRAC);
 AddNativeProc('exp',@RTL_EXP);
 AddNativeProc('ln',@RTL_LN);
 AddNativeProc('sqr',@RTL_SQR);
 AddNativeProc('sqrt',@RTL_SQRT);
 AddNativeProc('random',@RTL_RANDOM);
 AddNativeProc('rand',@RTL_RANDOM);
 AddNativeProc('pi',@RTL_PI);
 AddNativeProc('readfloat',@RTL_READFLOAT);
 AddNativeProc('readint',@RTL_READINT);
 AddNativeProc('readuint',@RTL_READUINT);
 AddNativeProc('readstring',@RTL_READSTRING);
 AddNativeProc('readchar',@RTL_READCHAR);
 AddNativeProc('readln',@RTL_READLN);
 AddNativeProc('flushin',@RTL_FLUSHIN);
 AddNativeProc('flush',@RTL_FLUSH);
 AddNativeProc('flushout',@RTL_FLUSHOUT);
 AddNativeProc('trim',@RTL_TRIM);
 AddNativeProc('copy',@RTL_COPY);
 AddNativeProc('length',@RTL_LENGTH);
 AddNativeProc('charat',@RTL_CHARAT);
 AddNativeProc('charpointerat',@RTL_CHARPOINTERAT);
 AddNativeProc('delete',@RTL_DELETE);
 AddNativeProc('insert',@RTL_INSERT);
 AddNativeProc('setstring',@RTL_SETSTRING);
 AddNativeProc('lowercase',@RTL_LOWERCASE);
 AddNativeProc('uppercase',@RTL_UPPERCASE);
 AddNativeProc('locase',@RTL_LOCASE);
 AddNativeProc('upcase',@RTL_UPCASE);
 AddNativeProc('pos',@RTL_POS);
 AddNativeProc('posex',@RTL_POSEX);
 AddNativeProc('inttostr',@RTL_INTTOSTR);
 AddNativeProc('getmem',@RTL_GETMEM);
 AddNativeProc('freemem',@RTL_FREEMEM);
 AddNativeProc('malloc',@RTL_MALLOC);
 AddNativeProc('free',@RTL_FREE);
 AddNativeProc('fileopen',@RTL_FILEOPEN);
 AddNativeProc('filecreate',@RTL_FILECREATE);
 AddNativeProc('fileclose',@RTL_FILECLOSE);
 AddNativeProc('fileseek',@RTL_FILESEEK);
 AddNativeProc('fileposition',@RTL_FILEPOSITION);
 AddNativeProc('filesize',@RTL_FILESIZE);
 AddNativeProc('fileeof',@RTL_FILEEOF);
 AddNativeProc('fileread',@RTL_FILEREAD);
 AddNativeProc('filewrite',@RTL_FILEWRITE);
 AddNativeProc('filereadline',@RTL_FILEREADLINE);
 AddNativeProc('filewriteline',@RTL_FILEWRITELINE);
 AddNativeProc('gettickcount',@RTL_GETTICKCOUNT);
 AddNativeProc('exec',@RTL_EXEC);
 AddNativeProc('inttobase',@RTL_INTTOBASE);
 AddNativeProc('inttohex',@RTL_INTTOHEX);
 AddNativeProc('uinttobase',@RTL_UINTTOBASE);
 AddNativeProc('uinttohex',@RTL_UINTTOHEX);
 if assigned(fOnOwnNativesPointers) then fOnOwnNativesPointers(self);
end;

procedure TBeRoScript.AddNativeDefinitions;
begin
 AddString('native int round(float number);');
 AddString('native int trunc(float number);');
 AddString('native float sin(float number);');
 AddString('native float cos(float number);');
 AddString('native float abs(float number);');
 AddString('native float frac(float number);');
 AddString('native float exp(float number);');
 AddString('native float ln(float number);');
 AddString('native float sqr(float number);');
 AddString('native float sqrt(float number);');
 AddString('native float random();');
 AddString('native float rand();');
 AddString('native float pi();');
 AddString('native float readfloat();');
 AddString('native int readint();');
 AddString('native unsigned int readuint();');
 AddString('native string readstring();');
 AddString('native unsigned char readchar();');
 AddString('native void readln();');
 AddString('native void flushin();');
 AddString('native void flush();');
 AddString('native void flushout();');
 AddString('native string trim(string src);');
 AddString('native string copy(string src,int index,int count);');
 AddString('native int length(string src);');
 AddString('native unsigned char charat(string src,int index);');
 AddString('native unsigned int charpointerat(string src,int index);');
 AddString('native string delete(string src,int index,int count);');
 AddString('native string insert(string src,string dst,int index);');
 AddString('native string setstring(char *src,int srclength);');
 AddString('native string lowercase(string src);');
 AddString('native string uppercase(string src);');
 AddString('native unsigned char locase(unsigned int src);');
 AddString('native unsigned char upcase(unsigned int src);');
 AddString('native int pos(string substr,string str,int first);');
 AddString('native int posex(string substr,string str,int first);');
 AddString('native string inttostr(int number,int digits);');
 AddString('native unsigned int getmem(int size);');
 AddString('native void freemem(void *datapointer);');
 AddString('native unsigned int malloc(int size);');
 AddString('native void free(void *datapointer);');
 AddString('native unsigned int fileopen(string filename);');
 AddString('native unsigned int filecreate(string filename);');
 AddString('native void fileclose(void *filepointer);');
 AddString('native int fileseek(void *filepointer,int position);');
 AddString('native int fileposition(void *filepointer);');
 AddString('native int filesize(void *filepointer);');
 AddString('native int fileeof(void *filepointer);');
 AddString('native int fileread(void *filepointer,char *buffer,int counter);');
 AddString('native int filewrite(void *filepointer,char *buffer,int counter);');
 AddString('native string filereadline(void *filepointer);');
 AddString('native void filewriteline(void *filepointer,string str);');
 AddString('native unsigned int gettickcount();');
 AddString('native int exec(string filename,string parameter);');
 AddString('native string inttobase(int value,int base);');
 AddString('native string inttohex(int value);');
 AddString('native string uinttobase(unsigned int value,unsigned int base);');
 AddString('native string uinttohex(unsigned int value);');
 if assigned(fOnOwnNativesDefinitions) then fOnOwnNativesDefinitions(self);
end;

function TBeRoScript.LoadCode:boolean;
var Stream,OldStream:TBeRoStream;
    SD,DD:pointer;
    SDS,DDS:longword;
    CheckSumme,Build,CodeGroesse,CountNatives:longword;
    I,J:integer;
    name,AsmVarName:string;
    P:pointer;
    Gefunden,Fehler,Compressed:boolean;
    Sign:TBeRoScriptSign;
 function LeseByte:byte;
 begin
  Stream.read(result,sizeof(byte));
 end;
 function LeseBoolean:boolean;
 begin
  result:=LeseByte<>0;
 end;
 function LeseDWord:longword;
 begin
  Stream.read(result,sizeof(longword));
 end;
 function LeseDWordSigned:longint;
 begin
  Stream.read(result,sizeof(longint));
 end;
 function LeseString:string;
 var L:longword;
 begin
  L:=LeseDWord;
  if L>0 then begin
   setlength(result,L);
   Stream.read(result[1],L);
  end else begin
   result:='';
  end;
 end;
 function LeseSignatur:TBeRoScriptSign;
 begin
  Stream.read(result,sizeof(TBeRoScriptSign));
 end;
begin
 result:=false;
 if (length(CacheDir)>0) and (length(CodeName)>0) then begin
  if FILEEXISTS(CacheDir+CodeName) then begin
   OldStream:=nil;
   Stream:=TBeRoFileStream.Create(CacheDir+CodeName);
   Sign:=LeseSignatur;
   if Sign=MyCacheSign then begin
    Build:=LeseDWord;
    if Build=BeRoScriptBuild then begin
     CheckSumme:=LeseDWord;
     if CheckSumme=SourceChecksumme then begin
      Fehler:=false;
      Compressed:=LeseBoolean;
      if Compressed then begin
       SDS:=LeseDWord;
       OldStream:=Stream;
       Stream:=TBeRoMemoryStream.Create;
       GETMEM(SD,SDS);
       OldStream.read(SD^,SDS);
       DD:=nil;
       DDS:=ProcessDecompress(SD,DD,SDS);
       Stream.write(DD^,DDS);
       Stream.Seek(0);
       FREEMEM(DD);
       FREEMEM(SD);
      end;
      CodeGroesse:=LeseDWord;
      BSSGroesse:=LeseDWord;
      setlength(ProcTabelle,LeseDWord);
      setlength(VariableTabelle,LeseDWord);
      setlength(LabelFixUpTabelle,LeseDWord);
      setlength(UseFixUpTabelle,LeseDWord);
      CountNatives:=LeseDWord;
      if length(NativeTabelle)<>longint(CountNatives) then Fehler:=true;
      setlength(ImportTabelle,LeseDWord);
      setlength(Blocks,LeseDWord);
      BeginBlock:=LeseDWordSigned;
      EndBlock:=LeseDWordSigned;
      CodeStream.Clear;
      CodeStream.AppendFrom(Stream,CodeGroesse);
      if BSSGroesse>0 then begin
       GETMEM(P,BSSGroesse);
       FILLCHAR(P^,BSSGroesse,0);
       CodeStream.Seek(CodeStream.Size);
       CodeStream.write(P^,BSSGroesse);
       FREEMEM(P);
      end;
      for I:=0 to length(ProcTabelle)-1 do begin
       ProcTabelle[I].name:=LeseString;
       ProcTabelle[I].Offset:=LeseDWord;
      end;
      for I:=0 to length(VariableTabelle)-1 do begin
       VariableTabelle[I].name:=LeseString;
       VariableTabelle[I].Offset:=LeseDWord;
      end;
      for I:=0 to length(LabelFixUpTabelle)-1 do begin
       LabelFixUpTabelle[I].name:=LeseString;
       LabelFixUpTabelle[I].Offset:=LeseDWordSigned;
      end;
      for I:=0 to length(UseFixUpTabelle)-1 do begin
       UseFixUpTabelle[I].Typ:=LeseByte;
       UseFixUpTabelle[I].name:=LeseString;
       UseFixUpTabelle[I].Offset:=LeseDWordSigned;
       UseFixUpTabelle[I].AddOffset:=LeseDWordSigned;
      end;
      for I:=0 to CountNatives-1 do begin
       name:=LeseString;
       AsmVarName:=LeseString;
       Gefunden:=false;
       for J:=0 to length(NativeTabelle)-1 do begin
        if NativeTabelle[J].name=name then begin
         NativeTabelle[J].AsmVarName:=AsmVarName;
         Gefunden:=true;
         break;
        end;
       end;
       if not Gefunden then begin
        Fehler:=true;
        break;
       end;
      end;
      for I:=0 to length(ImportTabelle)-1 do begin
       ImportTabelle[I].name:=LeseString;
       ImportTabelle[I].AsmVarName:=LeseString;
       ImportTabelle[I].LibraryName:=LeseString;
       ImportTabelle[I].LibraryFunction:=LeseString;
      end;
      for I:=0 to length(Blocks)-1 do begin
       Blocks[I]:=LeseString;
      end;
      if Compressed then begin
       Stream.Free;
       Stream:=OldStream;
      end;
      if Fehler then begin
       setlength(ProcTabelle,0);
       setlength(VariableTabelle,0);
       setlength(LabelFixUpTabelle,0);
       setlength(UseFixUpTabelle,0);
       setlength(ImportTabelle,0);
       setlength(Blocks,0);
      end;
      result:=not Fehler;
     end;
    end;
   end;
   Stream.Free;
  end;
 end;
end;

procedure TBeRoScript.SaveCode;
var Stream,OldStream:TBeRoStream;
    SD,DD:pointer;
    SDS,DDS:longword;
    I:integer;
 procedure SchreibeByte(Wert:byte);
 begin
  Stream.write(Wert,sizeof(byte));
 end;
 procedure SchreibeBoolean(Wert:boolean);
 begin
  if Wert then begin
   SchreibeByte(1);
  end else begin
   SchreibeByte(0);
  end;
 end;
 procedure SchreibeDWord(Wert:longword);
 begin
  Stream.write(Wert,sizeof(longword));
 end;
 procedure SchreibeDWordSigned(Wert:longint);
 begin
  Stream.write(Wert,sizeof(longint));
 end;
 procedure SchreibeString(S:string);
 begin
  SchreibeDWord(length(S));
  if length(S)>0 then Stream.write(S[1],length(S));
 end;
 procedure SchreibeSignatur(Wert:TBeRoScriptSign);
 begin
  Stream.write(Wert,sizeof(TBeRoScriptSign));
 end;
begin
 if (length(CacheDir)>0) and (length(CodeName)>0) then begin
  OldStream:=nil;
  Stream:=TBeRoFileStream.CreateNew(CacheDir+CodeName);
  SchreibeSignatur(MyCacheSign);
  SchreibeDWord(BeRoScriptBuild);
  SchreibeDWord(SourceChecksumme);
  SchreibeBoolean(CacheCompression);
  if CacheCompression then begin
   OldStream:=Stream;
   Stream:=TBeRoMemoryStream.Create;
  end;
  SchreibeDWord(CodeStream.Size-longint(BSSGroesse));
  SchreibeDWord(BSSGroesse);
  SchreibeDWord(length(ProcTabelle));
  SchreibeDWord(length(VariableTabelle));
  SchreibeDWord(length(LabelFixUpTabelle));
  SchreibeDWord(length(UseFixUpTabelle));
  SchreibeDWord(length(NativeTabelle));
  SchreibeDWord(length(ImportTabelle));
  SchreibeDWord(length(Blocks));
  SchreibeDWordSigned(BeginBlock);
  SchreibeDWordSigned(EndBlock);
  CodeStream.Seek(0);
  Stream.AppendFrom(CodeStream,CodeStream.Size-longint(BSSGroesse));
  for I:=0 to length(ProcTabelle)-1 do begin
   SchreibeString(ProcTabelle[I].name);
   SchreibeDWord(ProcTabelle[I].Offset);
  end;
  for I:=0 to length(VariableTabelle)-1 do begin
   SchreibeString(VariableTabelle[I].name);
   SchreibeDWord(VariableTabelle[I].Offset);
  end;
  for I:=0 to length(LabelFixUpTabelle)-1 do begin
   SchreibeString(LabelFixUpTabelle[I].name);
   SchreibeDWordSigned(LabelFixUpTabelle[I].Offset);
  end;
  for I:=0 to length(UseFixUpTabelle)-1 do begin
   SchreibeByte(UseFixUpTabelle[I].Typ);
   SchreibeString(UseFixUpTabelle[I].name);
   SchreibeDWordSigned(UseFixUpTabelle[I].Offset);
   SchreibeDWordSigned(UseFixUpTabelle[I].AddOffset);
  end;
  for I:=0 to length(NativeTabelle)-1 do begin
   SchreibeString(NativeTabelle[I].name);
   SchreibeString(NativeTabelle[I].AsmVarName);
  end;
  for I:=0 to length(ImportTabelle)-1 do begin
   SchreibeString(ImportTabelle[I].name);
   SchreibeString(ImportTabelle[I].AsmVarName);
   SchreibeString(ImportTabelle[I].LibraryName);
   SchreibeString(ImportTabelle[I].LibraryFunction);
  end;
  for I:=0 to length(Blocks)-1 do begin
   SchreibeString(Blocks[I]);
  end;
  if CacheCompression then begin
   SDS:=Stream.Size;
   GETMEM(SD,SDS);
   Stream.Seek(0);
   Stream.read(SD^,SDS);
   DD:=nil;
   DDS:=ProcessCompress(SD,DD,SDS);
   Stream.Clear;
   SchreibeDWord(DDS);
   Stream.write(DD^,DDS);
   OldStream.Append(Stream);
   FREEMEM(DD);
   FREEMEM(SD);
   Stream.Free;
   Stream:=OldStream;
  end;
  Stream.Free;
 end;
end;

procedure TBeRoScript.CopyCode;
begin
 CodeLength:=CodeStream.Size;
 CodePointer:=VirtualAlloc(nil,CodeLength,MEM_COMMIT,PAGE_EXECUTE_READWRITE);
 CodeFixen(longword(CodePointer));
 CodeStream.Seek(0);
 CodeStream.read(CodePointer^,CodeStream.Size);
end;

function TBeRoScript.Compile(Source:string;name:string=''):boolean;
var CompileNew:boolean;
    Quelltext,OwnPreCode:string;
    Counter:integer;
begin
 // Alten Code freigeben
 if CodePointer<>nil then begin
  VirtualFree(CodePointer,0,MEM_RELEASE);
  CodePointer:=nil;
 end;

 // Name merken
 CodeFileName:=ExtractFileName(name);
 if length(name)>0 then begin
  CodeName:=ChangeFileExt(CodeFileName,'.bsc');
 end else begin
  CodeName:='';
 end;

 // Alte Fehler löschen
 Errors:='';

 // Quelltext vorbereiten
 LineDifference:=0;
 Quelltext:='';
 if assigned(fOnOwnPreCode) then begin
  OwnPreCode:=fOnOwnPreCode(self);
  Quelltext:=Quelltext+OwnPreCode;
  // Zeilen zusammmenzählen
  for Counter:=1 to length(OwnPreCode) do begin
   if OwnPreCode[Counter]=#10 then begin
    inc(LineDifference);
   end;
  end;
 end;
 Quelltext:=Quelltext+Source;

 // RTL Routinen definieren
 AddNativePointers;

 // Standard Definitionen definieren
 AddDefine('BeRoScript');
 AddDefine('BeRoWebScript');
 AddDefine('BS');
 AddDefine('BWS');

 // Quelltext in den Quell Buffer kopieren
 QuellStream.Clear;
 AddNativeDefinitions;
 AddString(#13#10);
 inc(LineDifference);
 AddString(Quelltext);

 // Preprocessor ausführen
 Preprocessor;

 // Checksumme berechnen
 SourceChecksumme:=CRC32(QuellStream);

 CompileNew:=true;
 if not Debug then begin
  if LoadCode then begin
   CompileNew:=false;
   CopyCode;
  end;
 end;
 if CompileNew then begin
  // Compiler resetten
  CompilerCreate;
  Init;

  // Quelltext kompilieren
  if length(Errors)=0 then begin
   DoCompile;
  end;

  inc(LineDifference);

  if length(Errors)=0 then begin
   // Code sichern
   SaveCode;

   // Code kopieren
   CopyCode;
  end else begin
   CodePointer:=nil;
   CodeLength:=0;
   BSSGroesse:=0;
  end;
 end;

 // Code Zeiger zum einem Procedure Zeiger umwandeln
 CodeProc:=CodePointer;

 // Code Grösse merken

 // Fehlerstatus zurückgeben
 result:=length(Errors)=0;
 IsCompiled:=not result;
 Output:='';
end;

function TBeRoScript.CompileFile(SourceFile:string):boolean;
begin
 result:=Compile(ReadFileAsString(SourceFile),SourceFile);
end;

procedure TBeRoScript.RunProc(S:string);
var P:procedure(); pascal;
begin
 if assigned(CodeProc) and not Fehler then begin
  P:=GetProcPointer(S);
  if assigned(P) then P();
 end;
end;

procedure TBeRoScript.RunStart;
begin
 RunProc('$start');
end;

procedure TBeRoScript.RunMain;
begin
 RunProc('$main');
end;

procedure TBeRoScript.RunEnd;
begin
 RunProc('$end');
end;

procedure TBeRoScript.Run;
begin
 Output:='';
 RunStart;
 RunMain;
 RunEnd;
end;

function TBeRoScript.GetProcPointer(name:string):pointer;
var I:integer;
begin
 result:=nil;
 for I:=0 to length(ProcTabelle)-1 do begin
  if TRIM(ProcTabelle[I].name)=TRIM(name) then begin
   result:=pointer(ProcTabelle[I].Offset);
   exit;
  end;
 end;
end;

function TBeRoScript.GetVariablePointer(name:string):pointer;
var I:integer;
begin
 result:=nil;
 for I:=0 to length(VariableTabelle)-1 do begin
  if TRIM(VariableTabelle[I].name)=TRIM(name) then begin
   result:=pointer(VariableTabelle[I].Offset);
   exit;
  end;
 end;
end;

procedure TBeRoScript.OutputBlock(BlockNummer:integer);
begin
 if (BlockNummer>=0) and (BlockNummer<length(Blocks)) then begin
  if OutDirect then begin
   write(Blocks[BlockNummer]);
  end else begin
   Output:=Output+Blocks[BlockNummer];
  end;
 end;
end;

function TBeRoScript.ParseWebScript(FileName:string):string;
var Source:string;
    OutLineNumber:integer;
    Files:array of string;
    FirstBlock:boolean;
 procedure ClearFiles;
 var Counter:integer;
 begin
  for Counter:=0 to length(Files)-1 do Files[Counter]:='';
  setlength(Files,0);
 end;
 procedure AddFile(FileName:string);
 var MyFile:integer;
 begin
  MyFile:=length(Files);
  setlength(Files,MyFile+1);
  Files[MyFile]:=FileName;
 end;
 function CheckFile(FileName:string):boolean;
 var Counter:integer;
 begin
  result:=false;
  for Counter:=0 to length(Files)-1 do begin
   if Files[Counter]=FileName then begin
    result:=true;
    break;
   end;
  end;
 end;
 function AddBlock(DataBlock:string):integer;
 begin
  result:=length(Blocks);
  setlength(Blocks,result+1);
  Blocks[result]:=DataBlock;
 end;            
 function ParseFile(FileName:string):string;
 var Stream:TBeRoFileStream;
     C,LC,CM:char;
     DataBlock:string;
     MyBlock:integer;
     OldPos:integer;
     Signature:string;
     TheFile:string;
     FileIndex:integer;
     LineNumber:integer;
  function ReadString(LengthToRead:integer):string;
  var Counter:integer;
  begin
   result:='';
   for Counter:=1 to LengthToRead do result:=result+CHR(Stream.ReadByte);
  end;
  procedure AddLine;
  begin
   inc(OutLineNumber);
   if OutLineNumber>0 then begin
    setlength(LinesInfo.PreparsedLines,OutLineNumber);
    LinesInfo.PreparsedLines[OutLineNumber-1].LineNumber:=LineNumber;
    LinesInfo.PreparsedLines[OutLineNumber-1].FileIndex:=FileIndex;
   end;
   inc(LineNumber);
  end;
 begin
  FileIndex:=length(LinesInfo.Files);
  setlength(LinesInfo.Files,FileIndex+1);
  LinesInfo.Files[FileIndex]:=FileName;
  LineNumber:=1;
  Stream:=TBeRoFileStream.Create(FileName);
  DataBlock:='';
  LC:=#0;
  C:=#0;
  while Stream.Position<Stream.Size do begin
   C:=CHR(Stream.ReadByte);
   if C='<' then begin
    C:=CHR(Stream.ReadByte);
    if C='?' then begin
     OldPos:=Stream.Position;
     Signature:=ReadString(3);
     if Signature<>'bws' then Stream.Seek(OldPos);
     if length(DataBlock)>0 then begin
      if FirstBlock then begin
       BeginBlock:=AddBlock(DataBlock);
       FirstBlock:=false;
      end else begin
       Source:=Source+'outputblock('+INTTOSTR(AddBlock(DataBlock))+');';
      end;
      DataBlock:='';
     end;
     C:=CHR(Stream.ReadByte);
     if C='=' then begin
      Source:=Source+'print(';
      while Stream.Position<Stream.Size do begin
       C:=CHR(Stream.ReadByte);
       if C='?' then begin
        C:=CHR(Stream.ReadByte);
        if C='>' then begin
         break;
        end else begin
         Source:=Source+C;
        end;
       end else begin
        Source:=Source+C;
       end;
      end;
      Source:=Source+');';
     end else begin
      LC:=#10;
      CM:=#0;
      while Stream.Position<Stream.Size do begin
       if CM=#0 then begin
        if C='?' then begin
         OldPos:=Stream.Position;
         C:=CHR(Stream.ReadByte);
         if C='>' then begin
          break;
         end else begin
          Stream.Seek(OldPos);
          Source:=Source+'?';
         end;
        end else if C='b' then begin
         OldPos:=Stream.Position;
         Signature:=ReadString(4);
         if Signature='ws?>' then begin
          break;
         end else begin
          Stream.Seek(OldPos);
          Source:=Source+'b';
         end;
        end else if (LC=#10) and (C='#') then begin
         OldPos:=Stream.Position;
         Signature:=ReadString(11);
         if Signature='includeonce' then begin
          C:=#0;
          TheFile:='';
          while (Stream.Position<Stream.Size) and not (C=#10) do begin
           TheFile:=TheFile+C;
           C:=CHR(Stream.ReadByte);
          end;
          TheFile:=TRIM(TheFile);
          if length(TheFile)>0 then begin
           if TheFile[1]='<' then begin
            DELETE(TheFile,1,1);
            if length(TheFile)>0 then begin
             if TheFile[length(TheFile)]='>' then begin
              DELETE(TheFile,length(TheFile),1);
             end;
            end;
           end;
          end;
          if length(TheFile)>0 then begin
           if TheFile[1]='"' then begin
            DELETE(TheFile,1,1);
            if length(TheFile)>0 then begin
             if TheFile[length(TheFile)]='"' then begin
              DELETE(TheFile,length(TheFile),1);
             end;
            end;
           end;
          end;
          if not CheckFile(TheFile) then begin
           AddFile(TheFile);
           DataBlock:=DataBlock+ParseFile(TheFile);
           if length(DataBlock)>0 then begin
            MyBlock:=length(Blocks);
            setlength(Blocks,MyBlock+1);
            Blocks[MyBlock]:=DataBlock;
            Source:=Source+'outputblock('+INTTOSTR(MyBlock)+');';
            DataBlock:='';
           end;
          end;
          Source:=Source+#10;
          AddLine;
         end else begin
          Stream.Seek(OldPos);
          Signature:=ReadString(7);
          if Signature='include' then begin
           C:=#0;
           TheFile:='';
           while (Stream.Position<Stream.Size) and not (C=#10) do begin
            TheFile:=TheFile+C;
            C:=CHR(Stream.ReadByte);
           end;
           TheFile:=TRIM(TheFile);
           if length(TheFile)>0 then begin
            if TheFile[1]='<' then begin
             DELETE(TheFile,1,1);
             if length(TheFile)>0 then begin
              if TheFile[length(TheFile)]='>' then begin
               DELETE(TheFile,length(TheFile),1);
              end;
             end;
            end;
           end;
           if length(TheFile)>0 then begin
            if TheFile[1]='"' then begin
             DELETE(TheFile,1,1);
             if length(TheFile)>0 then begin
              if TheFile[length(TheFile)]='"' then begin
               DELETE(TheFile,length(TheFile),1);
              end;
             end;
            end;
           end;
           DataBlock:=DataBlock+ParseFile(TheFile);
           if length(DataBlock)>0 then begin
            MyBlock:=length(Blocks);
            setlength(Blocks,MyBlock+1);
            Blocks[MyBlock]:=DataBlock;
            Source:=Source+'outputblock('+INTTOSTR(MyBlock)+');';
            DataBlock:='';
           end;
           Source:=Source+#10;
           AddLine;
          end else begin
           Stream.Seek(OldPos);
           Source:=Source+'#';
          end;
         end;
        end else if C='/' then begin
         OldPos:=Stream.Position;
         C:=CHR(Stream.ReadByte);
         if C='*' then begin
          Source:=Source+'/*';
          LC:=#0;
          C:=#0;
          while (Stream.Position<Stream.Size) and not ((LC='*') and (C='/')) do begin
           LC:=C;
           C:=CHR(Stream.ReadByte);
           Source:=Source+C;
           if C=#10 then AddLine;
          end;
         end else if C='/' then begin
          Source:=Source+'//';
          while (Stream.Position<Stream.Size) and not (C=#10) do begin
           C:=CHR(Stream.ReadByte);
           Source:=Source+C;
          end;
          AddLine;
         end else begin
          Stream.Seek(OldPos);
          Source:=Source+'/';
         end;
        end else if (C='''') and (CM in [#0,'''']) then begin
         Source:=Source+C;
         if CM=#0 then begin
          CM:=C;
         end else if CM='''' then begin
          CM:=#0;
         end;
        end else if (C='"') and (CM in [#0,'"']) then begin
         Source:=Source+C;
         if CM=#0 then begin
          CM:=C;
         end else if CM='"' then begin
          CM:=#0;
         end;
        end else begin
         Source:=Source+C;
         if C=#10 then AddLine;
        end;
        LC:=C;
       end else if (C='''') and (CM in [#0,'''']) then begin
        Source:=Source+C;
        if CM=#0 then begin
         CM:=C;
        end else if CM='''' then begin
         CM:=#0;
        end;
       end else if (C='"') and (CM in [#0,'"']) then begin
        Source:=Source+C;
        if CM=#0 then begin
         CM:=C;
        end else if CM='"' then begin
         CM:=#0;
        end;
       end else begin
        Source:=Source+C;
        if C=#10 then AddLine;
        LC:=#0;
       end;
       C:=CHR(Stream.ReadByte);
      end;
     end;
    end else begin
     if C in [#13,#10] then Source:=Source+C;
     if C=#10 then AddLine;
     DataBlock:=DataBlock+'<'+C;
    end;
   end else begin
    if C in [#13,#10] then Source:=Source+C;
    if C=#10 then AddLine;
    DataBlock:=DataBlock+C;
   end;
  end;
  if C<>#10 then Source:=Source+#10;
  AddLine;
  Stream.Free;
  result:=DataBlock;
 end;
var DataBlock:string;
begin
 Files:=nil;
 ClearBlocks;
 OutLineNumber:=0; 
 Source:='';
 FirstBlock:=true;
 DataBlock:=ParseFile(FileName);
 if length(DataBlock)>0 then begin
  EndBlock:=AddBlock(DataBlock);
 end;
 ClearFiles;
 result:=Source;
end;

function TBeRoScript.RunWebScript(FileName:string):boolean;
var S:string;
begin
 Clear;
 S:=ParseWebScript(FileName);
 if Compile(S,FileName) then begin
  Output:='';
  OutputBlock(BeginBlock);
  RunStart;
  RunEnd;
  OutputBlock(EndBlock);
  result:=true;
 end else begin
  result:=false;
 end;
end;

function TBeRoScript.RunArchive(Stream:TBeRoStream;name:string=''):boolean;
var ScriptStream:TBeRoMemoryStream;
    FileStream:TBeRoFileStream;
    AFile:TBeRoArchiveFileParam;
    Dir,OldDir:string;
    Files:array of string;
    I:integer;
    Fehler,OK,BWS:boolean;
begin
 result:=false;
 Clear;
 ScriptStream:=TBeRoMemoryStream.Create;
 Archive:=TBeRoArchive.Create;
 if Archive.IsArchive(Stream) and not Archive.IsCrypted(Stream) then begin
  Archive.OpenArchive(Stream);
  Fehler:=false;
  OK:=false;
  BWS:=false;
  if Archive.Extract('main.bs',ScriptStream) then OK:=true;
  if Archive.Extract('main.bws',ScriptStream) then begin
   BWS:=true;
   OK:=true;
  end;
  if OK then begin     
   Dir:=GetTemp;
   Dir:=ExtractFilePath(Dir)+'BeRoScript%'+ExtractFileName(Dir);
   Dir:=ChangeFileExt(Dir,'')+'_tmp';
   {$I-}MKDIR(Dir);{$I+}IOResult;
   Dir:=Dir+'\';
   OldDir:=GetCurrentDir;
   Files:=nil;
   Archive.InitSearch;
   while not Archive.EndOfArchive do begin
    AFile:=Archive.FindNext;
    setlength(Files,length(Files)+1);
    Files[length(Files)-1]:=AFile.FileName;
    if POS('\',AFile.FileName)>0 then begin
     {$I-}MKDIR(Dir+ExtractFilePath(AFile.FileName));{$I+}IOResult;
    end;
   end;
   if length(Files)>0 then begin
    for I:=0 to length(Files)-1 do begin
     FileStream:=TBeRoFileStream.CreateNew(Dir+Files[I]);
     if not Archive.Extract(Files[I],FileStream) then begin
      Fehler:=true;
     end;
     FileStream.Free;
     Files[I]:='';
    end;
    {$I-}CHDIR(Dir);{$I+}IOResult;
   end;
   if not Fehler then begin
    if BWS then begin
     result:=RunWebScript(Dir+'main.bws');
    end else begin
     if Compile(ScriptStream.Text,name) then begin
      Run;
      result:=true;
     end;
    end;
   end;
   {$I-}CHDIR(OldDir);{$I+}IOResult;
   LoescheDateien(Dir,'*.*',true);
   {$I-}RMDIR(Dir);{$I+}IOResult;
   setlength(Files,0);
  end;
  Archive.CloseArchive;
 end;
 Archive.Free;
 ScriptStream.Free;
end;

function TBeRoScript.RunArchiveFile(FileName:string):boolean;
var FileStream:TBeRoFileStream;
begin
 FileStream:=TBeRoFileStream.Create(FileName);
 result:=RunArchive(FileStream,FileName);
 FileStream.Free;
end;

initialization
 RandomSeed:=GetTickCount;
 RandomFactor:=$08088405;
 RandomIncrement:=1;
 ErzeugeTabelle;
end.
