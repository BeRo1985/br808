(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2004, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit PEUtilsEx;
// By Benjamin Rosseaux - http://bero.0ok.de/

interface

uses Windows;

const ImageBase:longword=$00400000;

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

      PE_SCN_TYPE_REG=$00000000;
      PE_SCN_TYPE_DSECT=$00000001;
      PE_SCN_TYPE_NOLOAD=$00000002;
      PE_SCN_TYPE_GROUP=$00000004;
      PE_SCN_TYPE_NO_PAD=$00000008;
      PE_SCN_TYPE_COPY=$00000010;
      PE_SCN_CNT_CODE=$00000020;
      PE_SCN_CNT_INITIALIZED_DATA=$00000040;
      PE_SCN_CNT_UNINITIALIZED_DATA=$00000080;
      PE_SCN_LNK_OTHER=$00000100;
      PE_SCN_LNK_INFO=$00000200;
      PE_SCN_TYPE_OVER=$0000400;
      PE_SCN_LNK_REMOVE=$00000800;
      PE_SCN_LNK_COMDAT=$00001000;
      PE_SCN_MEM_PROTECTED=$00004000;
      PE_SCN_MEM_FARDATA=$00008000;
      PE_SCN_MEM_SYSHEAP=$00010000;
      PE_SCN_MEM_PURGEABLE=$00020000;
      PE_SCN_MEM_16BIT=$00020000;
      PE_SCN_MEM_LOCKED=$00040000;
      PE_SCN_MEM_PRELOAD=$00080000;
      PE_SCN_ALIGN_1BYTES=$00100000;
      PE_SCN_ALIGN_2BYTES=$00200000;
      PE_SCN_ALIGN_4BYTES=$00300000;
      PE_SCN_ALIGN_8BYTES=$00400000;
      PE_SCN_ALIGN_16BYTES=$00500000;
      PE_SCN_ALIGN_32BYTES=$00600000;
      PE_SCN_ALIGN_64BYTES=$00700000;
      PE_SCN_LNK_NRELOC_OVFL=$01000000;
      PE_SCN_MEM_DISCARDABLE=$02000000;
      PE_SCN_MEM_NOT_CACHED=$04000000;
      PE_SCN_MEM_NOT_PAGED=$08000000;
      PE_SCN_MEM_SHARED=$10000000;
      PE_SCN_MEM_EXECUTE=$20000000;
      PE_SCN_MEM_READ=$40000000;
      PE_SCN_MEM_WRITE=longword($80000000);

      SignMZEXE=$5a4d;
      SignNEEXE=$454e;
      SignLEEXE=$454c;
      SignPE=$00004550;

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
 
type pword=^word;
     PPWORD=^pword;

     plongword=^longword;
     PPLONGWORD=^plongword;

     LongRec=packed record
      Lo,Hi:word;
     end;

     PImageDOSStandardHeader=^TImageDOSStandardHeader;
     TImageDOSStandardHeader=packed record
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
     end;

     PImageDOSExtendedHeader=^TImageDOSExtendedHeader;
     TImageDOSExtendedHeader=packed record
      Reserved:packed array[0..3] of word;
      OEMID:word;
      OEMInfo:word;
      Reserved2:packed array[0..9] of word;
      LFAOffset:longword;
     end;

     PImageDOSHeader=^TImageDOSHeader;
     TImageDOSHeader=packed record
      StandardHeader:TImageDOSStandardHeader;
      ExtendedHeader:TImageDOSExtendedHeader;
     end;

     PImageSignature=^TImageSignature;
     TImageSignature=longword;

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

     TImageSectionHeaderName=packed array[0..IMAGE_SIZEOF_SHORT_NAME-1] of char;

     PImageSectionHeader=^TImageSectionHeader;
     TImageSectionHeader=packed record
      name:TImageSectionHeaderName;
      Misc:TISHMisc;
      VirtualAddress:longword;
      SizeOfRawData:longword;
      PointerToRawData:longword;
      PointerToRelocations:longword;
      PointerToLineNumbers:longword;
      NumberOfRelocations:word;
      NumberOfLineNumbers:word;
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
      Signature:TImageSignature;
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

     TProcInfo=packed record
      BaseAddr:longword;
      ImageSize:longword;
     end;

     TFixUpBlock=packed record
      PageRVA:longint;
      BlockSize:longint;
     end;

const AppendedDataSection:TImageSectionHeaderName='track   ';

function WritePEEXEChecksum(DataPointer:pointer;DataSize:longword):boolean;
function WritePEEXEChecksumFile(var F:file):boolean;
function WriteEXEWithAppendedData(DestFile:string;AppendDataPointer:pointer;AppendDataSize:longword):boolean;

implementation

uses BMFPlayerStubFile;

function WritePEEXEChecksum(DataPointer:pointer;DataSize:longword):boolean;
var Image:pointer;
    ImageNTHeaders:PImageNTHeaders;
    Counter,Checksum:longword;
    PW:pword;
begin
 result:=false;
 Image:=pointer(DataPointer);
 ImageNTHeaders:=pointer(longword(Image)+longword(PImageDOSHeader(Image).ExtendedHeader.LFAOffset));
 if PImageDOSHeader(Image).ExtendedHeader.LFAOffset<DataSize then begin
  if ImageNTHeaders^.Signature=SignPE then begin
   ImageNTHeaders^.OptionalHeader.CheckSum:=0;
   Checksum:=0;
   try
    PW:=DataPointer;
    for Counter:=1 to DataSize div 2 do begin
     try
      inc(CheckSum,PW^);
     except
     end;
     inc(PW);
     CheckSum:=((CheckSum and $ffff)+(CheckSum shr 16)) and $ffff;
    end;
    if (DataSize mod 2)<>0 then begin
     try
      inc(CheckSum,pbyte(PW)^);
     except
     end;
     CheckSum:=((CheckSum and $ffff)+(CheckSum shr 16)) and $ffff;
    end;
   except
   end;
   inc(CheckSum,DataSize);
   ImageNTHeaders^.OptionalHeader.CheckSum:=CheckSum;
   result:=true;
  end;
 end;
end;

function WritePEEXEChecksumFile(var F:file):boolean;
var DataPointer:pointer;
    DataSize:longword;
begin
 try
  DataSize:=FILESIZE(F);
  GETMEM(DataPointer,DataSize);
  SEEK(F,0);
  BLOCKREAD(F,DataPointer^,DataSize);
  result:=WritePEEXEChecksum(DataPointer,DataSize);
  SEEK(F,0);
  BLOCKWRITE(F,DataPointer^,DataSize);
 except
  result:=false;
 end;
end;

function DoAlign(Value,Alignment:longword):longword;
begin
 result:=Value;
 if (result mod Alignment)<>0 then inc(result,Alignment-(result mod Alignment));
end;

function WriteEXEWithAppendedData(DestFile:string;AppendDataPointer:pointer;AppendDataSize:longword):boolean;
var Image,SrcData,DestData,NullData:pointer;
    Value,VirtualAddress,PointerToRawData,SrcSize,DestSize,ImageSize,
    DataSize,I:longword;
    ImageNTHeaders:PImageNTHeaders;
    ImageSections:PImageSectionHeaders;
    Counter,SectionIndex:integer;
    Dst:file;
    P:pchar;
    BA,BB:boolean;
begin
 if (AppendDataSize=0) or not assigned(AppendDataPointer) then begin
  result:=false;
 end else begin
  result:=false;
  try
   DestSize:=AppendDataSize;
   GETMEM(DestData,DestSize);
   MOVE(AppendDataPointer^,DestData^,DestSize);

   // Read file with stub code
   FileMode:=0;
   SrcSize:=BMFPlayerStubSize;
   GETMEM(SrcData,SrcSize);
   MOVE(BMFPlayerStubData,SrcData^,SrcSize);
   Image:=pointer(SrcData);
   ImageNTHeaders:=pointer(longword(Image)+longword(PImageDOSHeader(Image).ExtendedHeader.LFAOffset));
   ImageSections:=pointer(longword(@ImageNTHeaders^.OptionalHeader)+ImageNTHeaders^.FileHeader.SizeOfOptionalHeader);
   SectionIndex:=-1;
   for Counter:=0 to ImageNTHeaders^.FileHeader.NumberOfSections-1 do begin
    if ImageSections^[Counter].name=AppendedDataSection then begin
     SectionIndex:=Counter;
     break;
    end;
   end;
   if SectionIndex<0 then begin
    VirtualAddress:=0;
    for Counter:=0 to ImageNTHeaders^.FileHeader.NumberOfSections-1 do begin
     Value:=DoAlign(ImageSections^[Counter].VirtualAddress+ImageSections^[Counter].Misc.VirtualSize,ImageNTHeaders^.OptionalHeader.SectionAlignment);
     if VirtualAddress<Value then VirtualAddress:=Value;
    end;
    PointerToRawData:=0;
    for Counter:=0 to ImageNTHeaders^.FileHeader.NumberOfSections-1 do begin
     Value:=DoAlign(ImageSections^[Counter].PointerToRawData+ImageSections^[Counter].SizeOfRawData,ImageNTHeaders^.OptionalHeader.FileAlignment);
     if PointerToRawData<Value then PointerToRawData:=Value;
    end;
    inc(ImageNTHeaders^.FileHeader.NumberOfSections);
    SectionIndex:=ImageNTHeaders^.FileHeader.NumberOfSections-1;
    FILLCHAR(ImageSections^[SectionIndex],sizeof(TImageSectionHeader),#0);
    ImageSections^[SectionIndex].name:=AppendedDataSection;
    ImageSections^[SectionIndex].Characteristics:=IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_WRITE;
    ImageSections^[SectionIndex].VirtualAddress:=VirtualAddress;
    ImageSections^[SectionIndex].PointerToRawData:=PointerToRawData;
   end else begin
    PointerToRawData:=ImageSections^[SectionIndex].PointerToRawData;
   end;
   ImageSections^[SectionIndex].Misc.VirtualSize:=DestSize;
   ImageSections^[SectionIndex].SizeOfRawData:=DestSize;

   // Calculate new image size
   ImageSize:=DoAlign(ImageNTHeaders^.OptionalHeader.SizeOfHeaders,ImageNTHeaders^.OptionalHeader.SectionAlignment);
   for Counter:=0 to ImageNTHeaders^.FileHeader.NumberOfSections-1 do begin
    if ImageSections^[Counter].Misc.VirtualSize<>0 then begin
     Value:=DoAlign(ImageSections^[Counter].VirtualAddress+ImageSections^[Counter].Misc.VirtualSize,ImageNTHeaders^.OptionalHeader.SectionAlignment);
     if ImageSize<Value then ImageSize:=Value;
    end;
   end;
   ImageNTHeaders^.OptionalHeader.SizeOfImage:=ImageSize;

   // Calculate new file size
   DataSize:=DoAlign(ImageNTHeaders^.OptionalHeader.SizeOfHeaders,ImageNTHeaders^.OptionalHeader.FileAlignment);
   for Counter:=0 to ImageNTHeaders^.FileHeader.NumberOfSections-1 do begin
    Value:=DoAlign(ImageSections^[Counter].PointerToRawData+ImageSections^[Counter].SizeOfRawData,ImageNTHeaders^.OptionalHeader.FileAlignment);
    if DataSize<Value then DataSize:=Value;
   end;

   // Write file with appended data
   SetFileAttributes(pchar(DestFile),0);
   DELETEFILE(pchar(DestFile));
   FileMode:=2;
   ASSIGNFILE(Dst,DestFile);
   {$I-}REWRITE(Dst,1);{$I+}if IOResult<>0 then exit;
   GETMEM(NullData,DataSize);
   FILLCHAR(NullData^,DataSize,#0);
   BLOCKWRITE(Dst,NullData^,DataSize);
   FREEMEM(NullData);
   SEEK(Dst,0);
   BLOCKWRITE(Dst,SrcData^,ImageNTHeaders^.OptionalHeader.SizeOfHeaders);
   SEEK(Dst,PImageDOSHeader(Image).ExtendedHeader.LFAOffset);
   BLOCKWRITE(Dst,ImageNTHeaders^,sizeof(TImageSignature)+sizeof(TImageFileHeader)+ImageNTHeaders^.FileHeader.SizeOfOptionalHeader);
   BLOCKWRITE(Dst,ImageSections^,sizeof(TImageSectionHeader)*ImageNTHeaders^.FileHeader.NumberOfSections);
   BA:=false;
   BB:=false;
   P:=Image;
   I:=0;
   while I<(SrcSize-4) do begin
    if (P[0]='T') and (P[1]='R') and (P[2]='D') and (P[3]='A') then begin
     longword(pointer(P)^):=ImageNTHeaders^.OptionalHeader.ImageBase+ImageSections^[SectionIndex].VirtualAddress;
     BA:=true;
     inc(P,3);
    end else if (P[0]='T') and (P[1]='R') and (P[2]='S') and (P[3]='I') then begin
     longword(pointer(P)^):=AppendDataSize;
     BB:=true;
     inc(P,3);
    end else if BA and BB then begin
     break;
    end;
    inc(P);
    inc(I);
   end;
   for Counter:=0 to ImageNTHeaders^.FileHeader.NumberOfSections-1 do begin
    if Counter<>SectionIndex then begin
     SEEK(Dst,ImageSections^[Counter].PointerToRawData);
     BLOCKWRITE(Dst,pointer(longword(longword(Image)+ImageSections^[Counter].PointerToRawData))^,ImageSections^[Counter].SizeOfRawData);
    end;
   end;
   SEEK(Dst,PointerToRawData);
   BLOCKWRITE(Dst,DestData^,DestSize);
   WritePEEXEChecksumFile(Dst);
   CLOSEFILE(Dst);
   FREEMEM(SrcData);
   FREEMEM(DestData);
   result:=true;
  except
  end;
 end;
end;

end.
