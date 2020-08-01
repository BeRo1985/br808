(*
 * Independent VST header, implemented based on these information sources:
 *       
 *       http://sourceforge.net/projects/delphiasiovst/
 *       http://www.kvraudio.com/forum/viewtopic.php?p=1905347
 *       http://www.kvraudio.com/forum/printview.php?t=143587&start=0
 *       http://www.asseca.org/vst-24-specs/index.html
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
unit VST;
{$ifdef fpc}
 {$mode delphi}
 {$ifdef cpui386}
  {$define cpu386}
 {$endif}
 {$ifdef cpu386}
  {$asmmode intel}
 {$endif}
 {$ifdef cpuamd64}
  {$define cpux64}
  {$define cpux8664}
  {$asmmode intel}
 {$endif}
 {$ifdef FPC_LITTLE_ENDIAN}
  {$define LITTLE_ENDIAN}
 {$else}
  {$ifdef FPC_BIG_ENDIAN}
   {$define BIG_ENDIAN}
  {$endif}
 {$endif}
 {-$pic off}
 {$define CanInline}
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
 {$if declared(RawByteString)}
  {$define HAS_TYPE_RAWBYTESTRING}
 {$else}
  {$undef HAS_TYPE_RAWBYTESTRING}
 {$ifend}
 {$if declared(UTF8String)}
  {$define HAS_TYPE_UTF8STRING}
 {$else}
  {$undef HAS_TYPE_UTF8STRING}
 {$ifend}
 {$if declared(UnicodeString)}
  {$define HAS_TYPE_UNICODESTRING}
 {$else}
  {$undef HAS_TYPE_UNICODESTRING}
 {$ifend}
{$else}
 {$realcompatibility off}
 {$localsymbols on}
 {$define LITTLE_ENDIAN}
 {$ifdef cpux64}
  {$define cpux8664}
  {$define cpuamd64}
  {$define cpu64}
 {$endif}
 {$ifndef cpu64}
  {$define cpu32}
 {$endif}
 {$define HAS_TYPE_EXTENDED}
 {$define HAS_TYPE_DOUBLE}
 {$define HAS_TYPE_SINGLE}
 {$ifdef conditionalexpressions}
  {$if declared(RawByteString)}
   {$define HAS_TYPE_RAWBYTESTRING}
  {$else}
   {$undef HAS_TYPE_RAWBYTESTRING}
  {$ifend}
  {$if declared(UTF8String)}
   {$define HAS_TYPE_UTF8STRING}
  {$else}
   {$undef HAS_TYPE_UTF8STRING}
  {$ifend}
  {$if declared(UnicodeString)}
   {$define HAS_TYPE_UNICODESTRING}
  {$else}
   {$undef HAS_TYPE_UNICODESTRING}
  {$ifend}
 {$else}
  {$undef HAS_TYPE_RAWBYTESTRING}
  {$undef HAS_TYPE_UTF8STRING}
  {$undef HAS_TYPE_UNICODESTRING}
 {$endif}
 {$ifndef BCB}
  {$ifdef ver120}
   {$define Delphi4or5}
  {$endif}
  {$ifdef ver130}
   {$define Delphi4or5}
  {$endif}
  {$ifdef ver140}
   {$define Delphi6}
  {$endif}
  {$ifdef ver150}
   {$define Delphi7}
  {$endif}
  {$ifdef ver170}
   {$define Delphi2005}
  {$endif}
 {$else}
  {$ifdef ver120}
   {$define Delphi4or5}
   {$define BCB4}
  {$endif}
  {$ifdef ver130}
   {$define Delphi4or5}
  {$endif}
 {$endif}
 {$ifdef conditionalexpressions}
  {$if CompilerVersion>=24}
   {$legacyifend on}
  {$ifend}
  {$if CompilerVersion>=14.0}
   {$if CompilerVersion=14.0}
    {$define Delphi6}
   {$ifend}
   {$define Delphi6AndUp}
  {$ifend}
  {$if CompilerVersion>=15.0}
   {$if CompilerVersion=15.0}
    {$define Delphi7}
   {$ifend}
   {$define Delphi7AndUp}
  {$ifend}
  {$if CompilerVersion>=17.0}
   {$if CompilerVersion=17.0}
    {$define Delphi2005}
   {$ifend}
   {$define Delphi2005AndUp}
  {$ifend}
  {$if CompilerVersion>=18.0}
   {$if CompilerVersion=18.0}
    {$define BDS2006}
    {$define Delphi2006}
   {$ifend}
   {$define Delphi2006AndUp}
  {$ifend}
  {$if CompilerVersion>=18.5}
   {$if CompilerVersion=18.5}
    {$define Delphi2007}
   {$ifend}
   {$define Delphi2007AndUp}
  {$ifend}
  {$if CompilerVersion=19.0}
   {$define Delphi2007Net}
  {$ifend}
  {$if CompilerVersion>=20.0}
   {$if CompilerVersion=20.0}
    {$define Delphi2009}
   {$ifend}
   {$define Delphi2009AndUp}
   {$define CanInline}
  {$ifend}
  {$if CompilerVersion>=21.0}
   {$if CompilerVersion=21.0}
    {$define Delphi2010}
   {$ifend}
   {$define Delphi2010AndUp}
  {$ifend}
  {$if CompilerVersion>=22.0}
   {$if CompilerVersion=22.0}
    {$define DelphiXE}
   {$ifend}
   {$define DelphiXEAndUp}
  {$ifend}
  {$if CompilerVersion>=23.0}
   {$if CompilerVersion=23.0}
    {$define DelphiXE2}
   {$ifend}
   {$define DelphiXE2AndUp}
  {$ifend}
  {$if CompilerVersion>=24.0}
   {$if CompilerVersion=24.0}
    {$define DelphiXE3}
   {$ifend}
   {$define DelphiXE3AndUp}
  {$ifend}
  {$if CompilerVersion>=25.0}
   {$if CompilerVersion=25.0}
    {$define DelphiXE4}
   {$ifend}
   {$define DelphiXE4AndUp}
  {$ifend}
  {$if CompilerVersion>=26.0}
   {$if CompilerVersion=26.0}
    {$define DelphiXE5}
   {$ifend}
   {$define DelphiXE5AndUp}
  {$ifend}
  {$if CompilerVersion>=27.0}
   {$if CompilerVersion=27.0}
    {$define DelphiXE6}
   {$ifend}
   {$define DelphiXE6AndUp}
  {$ifend}
  {$if CompilerVersion>=28.0}
   {$if CompilerVersion=28.0}
    {$define DelphiXE7}
   {$ifend}
   {$define DelphiXE7AndUp}
  {$ifend}
  {$if CompilerVersion>=29.0}
   {$if CompilerVersion=29.0}
    {$define DelphiXE8}
   {$ifend}
   {$define DelphiXE8AndUp}
  {$ifend}
  {$if CompilerVersion>=30.0}
   {$if CompilerVersion=30.0}
    {$define Delphi10Seattle}
   {$ifend}
   {$define Delphi10SeattleAndUp}
  {$ifend}
  {$if CompilerVersion>=31.0}
   {$if CompilerVersion=31.0}
    {$define Delphi10Berlin}
   {$ifend}
   {$define Delphi10BerlinAndUp}
  {$ifend}
 {$endif}
 {$ifndef Delphi4or5}
  {$ifndef BCB}
   {$define Delphi6AndUp}
  {$endif}
   {$ifndef Delphi6}
    {$define BCB6OrDelphi7AndUp}
    {$ifndef BCB}
     {$define Delphi7AndUp}
    {$endif}
    {$ifndef BCB}
     {$ifndef Delphi7}
      {$ifndef Delphi2005}
       {$define BDS2006AndUp}
      {$endif}
     {$endif}
    {$endif}
   {$endif}
 {$endif}
 {$ifdef Delphi6AndUp}
  {$warn symbol_platform off}
  {$warn symbol_deprecated off}
 {$endif}
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
{$ifndef HAS_TYPE_DOUBLE}
 {$error No double floating point precision}
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
{$ifdef cpu64}
 {$align 8}
{$else}
 {$align 1}
{$endif}

interface

uses SysUtils,Classes,Math;

const kVstVersion=2400;

      effFlagsHasEditor=1 shl 0;
      effFlagsHasClip=1 shl 1;
      effFlagsHasVu=1 shl 2;
      effFlagsCanMono=1 shl 3;
      effFlagsCanReplacing=1 shl 4;
      effFlagsProgramChunks=1 shl 5;
      effFlagsIsSynth=1 shl 8;
      effFlagsNoSoundInStop=1 shl 9;
      effFlagsExtIsAsync=1 shl 10;
      effFlagsExtHasBuffer=1 shl 11;
      effFlagsCanDoubleReplacing=1 shl 12;

      effOpen=0;
      effClose=1;
      effSetProgram=2;
      effGetProgram=3;
      effSetProgramName=4;
      effGetProgramName=5;
      effGetParamLabel=6;
      effGetParamDisplay=7;
      effGetParamName=8;
      effGetVu=9;
      effSetSampleRate=10;
      effSetBlockSize=11;
      effMainsChanged=12;
      effEditGetRect=13;
      effEditOpen=14;
      effEditClose=15;
      effEditIdle=19;
      effIdentify=22;
      effGetChunk=23;
      effSetChunk=24;
      effProcessEvents=25;
      effCanBeAutomated=26;
      effString2Parameter=27;
      effGetNumProgramCategories=28;
      effGetProgramNameIndexed=29;
      effCopyProgram=30;
      effConnectInput=31;
      effConnectOutput=32;
      effGetInputProperties=33;
      effGetOutputProperties=34;
      effGetPlugCategory=35;
      effGetCurrentPosition=36;
      effGetDestinationBuffer=37;
      effOfflineNotify=38;
      effOfflinePrepare=39;
      effOfflineRun=40;
      effProcessVarIo=41;
      effSetSpeakerArrangement=42;
      effSetBlockSizeAndSampleRate=43;
      effSetBypass=44;
      effGetEffectName=45;
      effGetErrorText=46;
      effGetVendorString=47;
      effGetProductString=48;
      effGetVendorVersion=49;
      effVendorSpecific=50;
      effCanDo=51;
      effGetTailSize=52;
      effIdle=53;
      effGetIcon=54;
      effSetViewPosition=55;
      effGetParameterProperties=56;
      effKeysRequired=57;
      effGetVstVersion=58;
      effEditKeyDown=59;
      effEditKeyUp=60;
      effSetEditKnobMode=61;
      effGetMidiProgramName=62;
      effGetCurrentMidiProgram=63;
      effGetMidiProgramCategory=64;
      effHasMidiProgramsChanged=65;
      effGetMidiKeyName=66;
      effBeginSetProgram=67;
      effEndSetProgram=68;
      effGetSpeakerArrangement=69;
      effShellGetNextPlugin=70;
      effStartProcess=71;
      effStopProcess=72;
      effSetTotalSampleToProcess=73;
      effSetPanLaw=74;
      effBeginLoadBank=75;
      effBeginLoadProgram=76;
      effSetProcessPrecision=77;
      effGetNumMidiInputChannels=78;
      effGetNumMidiOutputChannels=79;

      audioMasterAutomate=0;
      audioMasterVersion=1;
      audioMasterCurrentId=2;
      audioMasterIdle=3;
      audioMasterPinConnected=4;
      audioMasterWantMidi=6;
      audioMasterGetTime=7;
      audioMasterProcessEvents=8;
      audioMasterSetTime=9;
      audioMasterTempoAt=10;
      audioMasterGetNumAutomatableParameters=11;
      audioMasterGetParameterQuantization=12;
      audioMasterIOChanged=13;
      audioMasterNeedIdle=14;
      audioMasterSizeWindow=15;
      audioMasterGetSampleRate=16;
      audioMasterGetBlockSize=17;
      audioMasterGetInputLatency=18;
      audioMasterGetOutputLatency=19;
      audioMasterGetPreviousPlug=20;
      audioMasterGetNextPlug=21;
      audioMasterWillReplaceOrAccumulate=22;
      audioMasterGetCurrentProcessLevel=23;
      audioMasterGetAutomationState=24;
      audioMasterOfflineStart=25;
      audioMasterOfflineRead=26;
      audioMasterOfflineWrite=27;
      audioMasterOfflineGetCurrentPass=28;
      audioMasterOfflineGetCurrentMetaPass=29;
      audioMasterSetOutputSampleRate=30;
      audioMasterGetOutputSpeakerArrangement=31;
      audioMasterGetSpeakerArrangement=31;
      audioMasterGetVendorString=32;
      audioMasterGetProductString=33;
      audioMasterGetVendorVersion=34;
      audioMasterVendorSpecific=35;
      audioMasterSetIcon=36;
      audioMasterCanDo=37;
      audioMasterGetLanguage=38;
      audioMasterOpenWindow=39;
      audioMasterCloseWindow=40;
      audioMasterGetDirectory=41;
      audioMasterUpdateDisplay=42;
      audioMasterBeginEdit=43;
      audioMasterEndEdit=44;
      audioMasterOpenFileSelector=45;
      audioMasterCloseFileSelector=46;
      audioMasterEditFile=47;
      audioMasterGetChunkFile=48;
      audioMasterGetInputSpeakerArrangement=49;

      kVstMaxProgNameLen=24;
      kVstMaxParamStrLen=8;
      kVstMaxVendorStrLen=64;
      kVstMaxProductStrLen=64;
      kVstMaxEffectNameLen=32;

      kVstMaxNameLen=64;
      kVstMaxLabelLen=64;
      kVstMaxShortLabelLen=8;
      kVstMaxCategLabelLen=24;
      kVstMaxFileNameLen=100;

      kVstMidiType=1;
      kVstSysExType=6;

      kVstAudioType=2;
      kVstVideoType=3;
      kVstParameterType=4;
      kVstTriggerType=5;

      kVstMidiEventIsRealtime=1 shl 0;

      kVstTransportChanged=1;
      kVstTransportPlaying=1 shl 1;
      kVstTransportCycleActive=1 shl 2;
      kVstTransportRecording=1 shl 3;
      kVstAutomationWriting=1 shl 6;
      kVstAutomationReading=1 shl 7;
      kVstNanosValid=1 shl 8;
      kVstPpqPosValid=1 shl 9;
      kVstTempoValid=1 shl 10;
      kVstBarsValid=1 shl 11;
      kVstCyclePosValid=1 shl 12;
      kVstTimeSigValid=1 shl 13;
      kVstSmpteValid=1 shl 14;
      kVstClockValid=1 shl 15;

      kVstSmpte24fps=0;
      kVstSmpte25fps=1;
      kVstSmpte2997fps=2;
      kVstSmpte30fps=3;
      kVstSmpte2997dfps=4;
      kVstSmpte30dfps=5;

      kVstSmpteFilm16mm=6;
      kVstSmpteFilm35mm=7;
      kVstSmpte239fps=10;
      kVstSmpte249fps=11;
      kVstSmpte599fps=12;
      kVstSmpte60fps=13;

      kVstLangEnglish=1;
      kVstLangGerman=2;
      kVstLangFrench=3;
      kVstLangItalian=4;
      kVstLangSpanish=5;
      kVstLangJapanese=6;

      kVstProcessPrecision32=0;
      kVstProcessPrecision64=1;

      kVstParameterIsSwitch=1 shl 0;
      kVstParameterUsesIntegerMinMax=1 shl 1;
      kVstParameterUsesFloatStep=1 shl 2;
      kVstParameterUsesIntStep=1 shl 3;
      kVstParameterSupportsDisplayIndex=1 shl 4;
      kVstParameterSupportsDisplayCategory=1 shl 5;
      kVstParameterCanRamp=1 shl 6;

      kVstPinIsActive=1 shl 0;
      kVstPinIsStereo=1 shl 1;
      kVstPinUseSpeaker=1 shl 2;

      kPlugCategUnknown=0;
      kPlugCategEffect=1;
      kPlugCategSynth=2;
      kPlugCategAnalysis=3;
      kPlugCategMastering=4;
      kPlugCategSpacializer=5;
      kPlugCategRoomFx=6;
      kPlugSurroundFx=7;
      kPlugCategRestoration=8;
      kPlugCategOfflineProcess=9;
      kPlugCategShell=10;
      kPlugCategGenerator=11;

      kPlugCategMaxCount=12;

      kMidiIsOmni=1;

      kSpeakerUndefined=$7FFFFFFF;
      kSpeakerM=0;
      kSpeakerL=1;
      kSpeakerR=2;
      kSpeakerC=3;
      kSpeakerLfe=4;
      kSpeakerLs=5;
      kSpeakerRs=6;
      kSpeakerLc=7;
      kSpeakerRc=8;
      kSpeakerS=9;
      kSpeakerCs=kSpeakerS;
      kSpeakerSl=10;
      kSpeakerSr=11;
      kSpeakerTm=12;
      kSpeakerTfl=13;
      kSpeakerTfc=14;
      kSpeakerTfr=15;
      kSpeakerTrl=16;
      kSpeakerTrc=17;
      kSpeakerTrr=18;
      kSpeakerLfe2=19;

      kSpeakerU32=-32;
      kSpeakerU31=-31;
      kSpeakerU30=-30;
      kSpeakerU29=-29;
      kSpeakerU28=-28;
      kSpeakerU27=-27;
      kSpeakerU26=-26;
      kSpeakerU25=-25;
      kSpeakerU24=-24;
      kSpeakerU23=-23;
      kSpeakerU22=-22;
      kSpeakerU21=-21;
      kSpeakerU20=-20;
      kSpeakerU19=-19;
      kSpeakerU18=-18;
      kSpeakerU17=-17;
      kSpeakerU16=-16;
      kSpeakerU15=-15;
      kSpeakerU14=-14;
      kSpeakerU13=-13;
      kSpeakerU12=-12;
      kSpeakerU11=-11;
      kSpeakerU10=-10;
      kSpeakerU9=-9;
      kSpeakerU8=-8;
      kSpeakerU7=-7;
      kSpeakerU6=-6;
      kSpeakerU5=-5;
      kSpeakerU4=-4;
      kSpeakerU3=-3;
      kSpeakerU2=-2;
      kSpeakerU1=-1;

      kSpeakerArrUserDefined=-2;
      kSpeakerArrEmpty=-1;
      kSpeakerArrMono=0;
      kSpeakerArrStereo=1;
      kSpeakerArrStereoSurround=2;
      kSpeakerArrStereoCenter=3;
      kSpeakerArrStereoSide=4;
      kSpeakerArrStereoCLfe=5;
      kSpeakerArr30Cine=6;
      kSpeakerArr30Music=7;
      kSpeakerArr31Cine=8;
      kSpeakerArr31Music=9;
      kSpeakerArr40Cine=10;
      kSpeakerArr40Music=11;
      kSpeakerArr41Cine=12;
      kSpeakerArr41Music=13;
      kSpeakerArr50=14;
      kSpeakerArr51=15;
      kSpeakerArr60Cine=16;
      kSpeakerArr60Music=17;
      kSpeakerArr61Cine=18;
      kSpeakerArr61Music=19;
      kSpeakerArr70Cine=20;
      kSpeakerArr70Music=21;
      kSpeakerArr71Cine=22;
      kSpeakerArr71Music=23;
      kSpeakerArr80Cine=24;
      kSpeakerArr80Music=25;
      kSpeakerArr81Cine=26;
      kSpeakerArr81Music=27;
      kSpeakerArr102=28;
      kNumSpeakerArr=29;

      kVstOfflineUnvalidParameter=1 shl 0;
      kVstOfflineNewFile=1 shl 1;

      kVstOfflinePlugError=1 shl 10;
      kVstOfflineInterleavedAudio=1 shl 11;
      kVstOfflineTempOutputFile=1 shl 12;
      kVstOfflineFloatOutputFile=1 shl 13;
      kVstOfflineRandomWrite=1 shl 14;
      kVstOfflineStretch=1 shl 15;
      kVstOfflineNoThread=1 shl 16;

      kVstOfflineAudio=0;
      kVstOfflinePeaks=1;
      kVstOfflineParameter=2;
      kVstOfflineMarker=3;
      kVstOfflineCursor=4;
      kVstOfflineSelection=5;
      kVstOfflineQueryFiles=6;

      kVstOfflineReadOnly=1 shl 0;
      kVstOfflineNoRateConversion=1 shl 1;
      kVstOfflineNoChannelChange=1 shl 2;

      kVstOfflineCanProcessSelection=1 shl 10;
      kVstOfflineNoCrossfade=1 shl 11;
      kVstOfflineWantRead=1 shl 12;
      kVstOfflineWantWrite=1 shl 13;
      kVstOfflineWantWriteMarker=1 shl 14;
      kVstOfflineWantMoveCursor=1 shl 15;
      kVstOfflineWantSelect=1 shl 16;

      VKEY_BACK=1;
      VKEY_TAB=2;
      VKEY_CLEAR=3;
      VKEY_RETURN=4;
      VKEY_PAUSE=5;
      VKEY_ESCAPE=6;
      VKEY_SPACE=7;
      VKEY_NEXT=8;
      VKEY_END=9;
      VKEY_HOME=10;

      VKEY_LEFT=11;
      VKEY_UP=12;
      VKEY_RIGHT=13;
      VKEY_DOWN=14;
      VKEY_PAGEUP=15;
      VKEY_PAGEDOWN=16;

      VKEY_SELECT=17;
      VKEY_PRINT=18;
      VKEY_ENTER=19;
      VKEY_SNAPSHOT=20;
      VKEY_INSERT=21;
      VKEY_DELETE=22;
      VKEY_HELP=23;
      VKEY_NUMPAD0=24;
      VKEY_NUMPAD1=25;
      VKEY_NUMPAD2=26;
      VKEY_NUMPAD3=27;
      VKEY_NUMPAD4=28;
      VKEY_NUMPAD5=29;
      VKEY_NUMPAD6=30;
      VKEY_NUMPAD7=31;
      VKEY_NUMPAD8=32;
      VKEY_NUMPAD9=33;
      VKEY_MULTIPLY=34;
      VKEY_ADD=35;
      VKEY_SEPARATOR=36;
      VKEY_SUBTRACT=37;
      VKEY_DECIMAL=38;
      VKEY_DIVIDE=39;
      VKEY_F1=40;
      VKEY_F2=41;
      VKEY_F3=42;
      VKEY_F4=43;
      VKEY_F5=44;
      VKEY_F6=45;
      VKEY_F7=46;
      VKEY_F8=47;
      VKEY_F9=48;
      VKEY_F10=49;
      VKEY_F11=50;
      VKEY_F12=51;
      VKEY_NUMLOCK=52;
      VKEY_SCROLL=53;

      VKEY_SHIFT=54;
      VKEY_CONTROL=55;
      VKEY_ALT=56;

      VKEY_EQUALS=57;

      MODIFIER_SHIFT=1 shl 0;
      MODIFIER_ALTERNATE=1 shl 1;
      MODIFIER_COMMAND=1 shl 2;
      MODIFIER_CONTROL=1 shl 3;

      kVstFileLoad=0;
      kVstFileSave=1;
      kVstMultipleFilesLoad=2;
      kVstDirectorySelect=3;

      kVstFileType=0;

      kLinearPanLaw=0;
      kEqualPowerPanLaw=1;

      kVstProcessLevelUnknown=0;
      kVstProcessLevelUser=1;
      kVstProcessLevelRealtime=2;
      kVstProcessLevelPrefetch=3;
      kVstProcessLevelOffline=4;

      kVstAutomationUnsupported=0;
      kVstAutomationOff=1;
      kVstAutomationRead=2;
      kVstAutomationWrite=3;
      kVstAutomationReadWrite=4;

      canDoSendVstEvents='sendVstEvents';
      canDoSendVstMidiEvent='sendVstMidiEvent';
      canDoSendVstTimeInfo='sendVstTimeInfo';
      canDoReceiveVstEvents='receiveVstEvents';
      canDoReceiveVstMidiEvent='receiveVstMidiEvent';
      canDoReportConnectionChanges='reportConnectionChanges';
      canDoAcceptIOChanges='acceptIOChanges';
      canDoSizeWindow='sizeWindow';
      canDoOffline='offline';
      canDoOpenFileSelector='openFileSelector';
      canDoCloseFileSelector='closeFileSelector';
      canDoStartStopProcess='startStopProcess';
      canDoShellCategory='shellCategory';
      canDoSendVstMidiEventFlagIsRealtime='sendVstMidiEventFlagIsRealtime';
      canDoReceiveVstTimeInfo='receiveVstTimeInfo';
      canDoMidiProgramNames='midiProgramNames';
      canDoBypass='bypass';

      cMagic='CcnK';

      presetMagic='FxCk';
      bankMagic='FxBk';

      chunkPresetMagic='FPCh';
      chunkBankMagic='FBCh';

      chunkGlobalMagic='FxCh';
      fMagic=presetMagic;

type PSmallInt=^smallint;
     PLongInt=^longint;
     PInt64=^int64;

     PNativeSignedInt=^TNativeSignedInt;
     TNativeSignedInt={$ifdef fpc}TNativeSignedInt{$else}{$if CompilerVersion>=23.0}NativeUInt{$else}{$ifdef cpu64}int64{$else}longint{$endif}{$ifend}{$endif};

     PNativeUnsignedInt=^TNativeUnsignedInt;
     TNativeUnsignedInt={$ifdef fpc}PtrUInt{$else}{$if CompilerVersion>=23.0}NativeUInt{$else}{$ifdef cpu64}uint64{$else}longword{$endif}{$ifend}{$endif};

     PEffect=^TEffect;

     PPSingle=^psingle;
     PPDouble=^pdouble;

     TAudioMasterCallbackFunc=function(Effect:PEffect;Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt; cdecl;
     TDispatcherFunc=function(Effect:PEffect;Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt; cdecl;
     TProcessProc=procedure(Effect:PEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
     TProcessDoubleProc=procedure(Effect:PEffect;Inputs,Outputs:PPDouble;SampleFrames:longint); cdecl;
     TSetParameterProc=procedure(Effect:PEffect;Index:longint;Parameter:single); cdecl;
     TGetParameterFunc=function(Effect:PEffect;Index:longint):single; cdecl;
     TMainProc=function(audioMaster:TAudioMasterCallbackFunc):PEffect; cdecl;

     TEffect=record
      Magic:longint;
      Dispatcher:TDispatcherFunc;
      Process:TProcessProc;
      SetParameter:TSetParameterProc;
      GetParameter:TGetParameterFunc;
      NumPrograms,NumParams,NumInputs,NumOutputs,Flags:longint;
      ReservedForHost:pointer;
      Resv2:TNativeSignedInt;
      InitialDelay,RealQualities,OffQualities:longint;
      IORatio:single;
      vObject,User:pointer;
      UniqueID,Version:longint;
      ProcessReplacing:TProcessProc;
      ProcessDoubleReplacing:TProcessDoubleProc;
      ReservedForFuture:array[0..55] of byte;
     end;

     PPERect=^PERect;
     PERect=^TERect;
     TERect=record
      Top,Left,Bottom,Right:smallint;
     end;

     PVSTEvent=^TVSTEvent;
     TVSTEvent=record
      vType,ByteSize,DeltaFrames,Flags:longint;
      data:array[0..15] of byte;
     end;

     PVSTEvents=^TVSTEvents;
     TVSTEvents=record
      NumEvents:longint;
      Reserved:TNativeSignedInt;
      Events:array[0..1] of PVSTEvent;
     end;

     PVSTMIDIEvent=^TVSTMIDIEvent;
     TVSTMIDIEvent=record
      vType,ByteSize,DeltaFrames,Flags,NoteLength,NoteOffset:longint;
      MIDIData:array[0..3] of byte;
      Detune:shortint;
      noteOffVelocity,Reserved1,Reserved2:byte;
     end;

     PVSTMIDISysExEvent=^TVSTMIDISysExEvent;
     TVSTMIDISysExEvent=record
      vType,ByteSize,DeltaFrames,Flags,DumpBytes:longint;
      Resvd1:TNativeSignedInt;
      SysExDump:pbyte;
      Resv2:TNativeSignedInt;
     end;

     PVSTTimeInfo=^TVSTTimeInfo;
     TVSTTimeInfo=record
      SamplePos,SampleRate,NanoSeconds,PPQPos,Tempo,BarStartPos,CycleStartPos,CycleEndPos:double;
      TimeSigNumerator,TimeSigDenominator,SMPTEOffset,SMPTEFrameRate,SamplesToNextClock,Flags:longint;
     end;

     PVSTVariableIo=^TVSTVariableIo;
     TVSTVariableIo=record
      Inputs,Outputs:PPSingle;
      NumSamplesInput,NumSamplesOutput:longint;
      NumSamplesInputProcessed,NumSamplesOutputProcessed:PLongInt;
     end;

     PVSTParameterProperties=^TVSTParameterProperties;
     TVSTParameterProperties=record
      StepFloat,SmallStepFloat,LargelStepFloat:single;
      vLabel:array[0..kVstMaxLabelLen-1] of ansichar;
      Flags,MinInteger,MaxInteger,StepInteger,LargeStepInteger:longint;
      ShortLabel:array[0..kVstMaxShortLabelLen-1] of ansichar;
      DisplayIndex,Category,NumParametersInCategory,Reserved:smallint;
      CategoryLabel:array[0..kVstMaxCategLabelLen-1] of ansichar;
      ReservedForFuture:array[0..15] of ansichar;
     end;

     PVSTPinProperties=^TVSTPinProperties;
     TVSTPinProperties=record
      vLabel:array[0..kVstMaxLabelLen-1] of ansichar;
      Flags,ArrangementType:longint;
      ShortLabel:array[0..kVstMaxShortLabelLen-1] of ansichar;
      ReservedForFuture:array[0..47] of byte;
     end;

     PMIDIProgramName=^TMIDIProgramName;
     TMIDIProgramName=record
      ThisProgramIndex:longint;
      Name:array[0..63] of ansichar;
      MIDIProgram,MIDIBankMSB,MIDIBankLSB:shortint;
      Reserved:byte;
      ParentCategoryIndex,Flags:longint;
     end;

     PMIDIProgramCategory=^TMIDIProgramCategory;
     TMIDIProgramCategory=record
      ThisCategoryIndex:longint;
      Name:array[0..63] of ansichar;
      ParentCategoryIndex,Flags:longint;
     end;

     PMIDIKeyName=^TMIDIKeyName;
     TMIDIKeyName=record
      ThisProgramIndex,ThisKeyNumber:longint;
      KeyName:array[0..63] of ansichar;
      Reserved,Flags:longint;
     end;

     PVSTSpeakerProperties=^TVSTSpeakerProperties;
     TVSTSpeakerProperties=record
      Azimuth,Elevation,Radius,Reserved:single;
      Name:array[0..63] of ansichar;
      vType:longint;
      ReservedForFuture:array[0..27] of byte;
     end;

     PPVSTSpeakerArrangement=^PVSTSpeakerArrangement;
     PVSTSpeakerArrangement=^TVSTSpeakerArrangement;
     TVSTSpeakerArrangement=record
      vType,NumChannels:longint;
      speakers:array[0..7] of TVSTSpeakerProperties;
     end;

     PVSTOfflineTask=^TVSTOfflineTask;
     TVSTOfflineTask=record
      ProcessName:array[0..95] of ansichar;
      ReadPosition,WritePosition:double;
      ReadCount,WriteCount,SizeInputBuffer,SizeOutputBuffer:longint;
      InputBuffer,OutputBuffer:pointer;
      PositionToProcessFrom,NumFramesToProcess,MaxFramesToWrite:double;
      ExtraBuffer:pointer;
      Value,Index:longint;
      NumFramesInSourceFile,SourceSampleRate,DestinationSampleRate:double;
      NumSourceChannels,NumDestinationChannels,SourceFormat,DestinationFormat:longint;
      OutputText:array[0..511] of ansichar;
      Progress:double;
      ProgressMode:longint;
      ProgressText:array[0..99] of ansichar;
      Flags,ReturnValue:longint;
      HostOwned,PlugOwned:pointer;
      ReservedForFuture:array[0..1023] of byte;
     end;

     PVSTAudioFile=^TVSTAudioFile;
     TVSTAudioFile=record
      Flags:longint;
      HostOwned,PlugOwned:pointer;
      Name:array[0..kVstMaxFileNameLen-1] of ansichar;
      UniqueID:longint;
      SampleRate:double;
      NumChannels:longint;
      NumFrames:double;
      Format:longint;
      EditCursorPosition,SelectionStart,SelectionSize:double;
      SelectedChannelsMask,NumMarkers,TimeRulerUnit:longint;
      TimeRulerOffset:double;
      Tempo:double;                                 
      TimeSigNumerator,TimeSigDenominator,ticksPerBlackNote,SMTPEFrameRate:longint;
      ReservedForFuture:array[0..63] of byte;
     end;

     PVSTAudioFileMarker=^TVSTAudioFileMarker;
     TVSTAudioFileMarker=record
      Position:double;
      Name:array[0..31] of ansichar;
      vType,ID,Reserved:longint;
     end;

     PVSTWindow=^TVSTWindow;
     TVSTWindow=record
      Title:array[0..127] of ansichar;
      xPos,yPos,Width,Height:smallint;
      Style:longint;
      Parent,UserHandle,WindowHandle:pointer;
      ReservedForFuture:array[0..103] of byte;
     end;

     PVSTKeyCode=^TVSTKeyCode;
     TVSTKeyCode=record
      CharacterCode:longint;
      VirtualCode,ModifierCode:byte;
     end;

     PVSTFileType=^TVSTFileType;
     TVSTFileType=record
      Name:array[0..127] of ansichar;
      MacType:array[0..7] of ansichar;
      DOSType:array[0..7] of ansichar;
      UnixType:array[0..7] of ansichar;
      MIMEType1:array[0..127] of ansichar;
      MIMEType2:array[0..127] of ansichar;
     end;

     PVSTFileSelect=^TVSTFileSelect;
     TVSTFileSelect=record
      Command,vType,MACCreator,nbFileTypes:longint;
      FileTypes:PVSTFileType;
      Title:array[0..1023] of ansichar;
      InitialPath,ReturnPath:pansichar;
      SizeReturnPath:longint;
      ReturnMultiplePaths:^pansichar;
      NumReturnPaths:longint;
      Reserved:TNativeSignedInt;
      ReservedForFuture:array[0..115] of byte;
     end;

     PVSTPatchChunkInfo=^TVSTPatchChunkInfo;
     TVSTPatchChunkInfo=record
      Version,PluginUniqueID,PluginVersion,NumElements:longint;
      ReservedForFuture:array[0..47] of ansichar;
     end;

     TFXPreset=packed record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumParams:longint;
      PrgName:array[0..27] of ansichar;
      Params:pointer;
     end;

     TFXChunkSet=packed record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumPrograms:longint;
      PrgName:array[0..27] of ansichar;
      ChunkSize:longint;
      Chunk:pointer;
     end;

     TFXSet=packed record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumPrograms:longint;
      ReservedForFuture:array[0..127] of byte;
      Programs:pointer;
     end;

     TFXChunkBank=packed record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumPrograms:longint;
      ReservedForFuture:array[0..127] of byte;
      ChunkSize:longint;
      Chunk:pointer;
     end;

     PFXProgram=^TFXProgram;
     TFXProgram=record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumParams:longint;
      PrgName:array[0..27] of ansichar;
      case integer of
       0:(Params:array[0..0] of single);
       1:(Size:longint;Chunk:array[0..0] of byte);
     end;

     PFXBank=^TFXBank;
     TFXBank=record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumParams,CurrentProgram:longint;
      ReservedForFuture:array[0..123] of byte;
      case integer of
       0:(Programs:array[0..0] of TFXProgram);
       1:(Size:longint;Chunk:array[0..0] of byte);
     end;

     TAudioEffectEditor=class;

     TAudioEffect=class
      private
       procedure SetEditor(newvalue:TAudioEffectEditor);
      protected
       FAudioMaster:TAudioMasterCallbackFunc;   
       FEffect:TEffect;
       FEditor:TAudioEffectEditor;
       FSampleRate:single;
       FBlockSize:longint;
       NumPrograms:longint;
       NumParams:longint;
       CurProgram:longint;
       procedure SetSampleRate(NewValue:single); virtual;          
       procedure SetBlockSize(NewValue:longint); virtual;         
       function GetEffect:PEffect;
      public
       constructor Create(anAudioMaster:TAudioMasterCallbackFunc;aNumPrograms,aNumParams:longint);
       destructor Destroy; override;
       function Dispatcher(Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt; virtual;
       procedure Open; virtual;
       procedure Close; virtual;
       procedure Suspend; virtual;
       procedure Resume; virtual;
       procedure ProcessReplacing(Inputs,Outputs:PPSingle;SampleFrames:longint); virtual; abstract;
       procedure ProcessDoubleReplacing(Inputs,Outputs:PPDouble;SampleFrames:longint); virtual;
       procedure SetParameter(Index:longint;Value:single); virtual;
       function GetParameter(Index:integer):single; virtual;
       procedure SetParameterAutomated(Index:longint;Value:single); virtual;
       function GetProgram:longint; virtual;
       procedure SetProgram(aProgram:longint); virtual;
       procedure SetProgramName(Name:pansichar); virtual;
       procedure GetProgramName(Name:pansichar); virtual;
       procedure GetParameterLabel(Index:longint;aLabel:pansichar); virtual;
       procedure GetParameterDisplay(Index:longint;Text:pansichar); virtual;
       procedure GetParameterName(Index:longint;Text:pansichar); virtual;
       function GetChunk(var Data:pointer;IsPreset:boolean=false):longint; virtual;
       function SetChunk(Data:pointer;ByteSize:longint;IsPreset:boolean=false):longint; virtual;
       procedure SetUniqueID(ID:longint); virtual;
       procedure SetNumInputs(Inputs:longint); virtual;
       procedure SetNumOutputs(Outputs:longint); virtual;
       procedure CanProcessReplacing(State:boolean); virtual;
       procedure CanDoubleReplacing(State:boolean); virtual;
       procedure ProgramsAreChunks(State:boolean); virtual;
       procedure SetInitialDelay(Delay:longint); virtual;
       function GetMasterVersion:longint; virtual;
       function GetCurrentUniqueId:longint; virtual;
       procedure MasterIdle; virtual;
       procedure Process(Inputs,Outputs:ppsingle;SampleFrames:longint); virtual;
       function GetVu:single; virtual;
       procedure HasVu(State:boolean); virtual;
       procedure HasClip(State:boolean); virtual;
       procedure CanMono(State:boolean); virtual;
       procedure SetRealtimeQualities(Qualities:longint); virtual;
       procedure SetOfflineQualities(Qualities:longint); virtual;
       function IsInputConnected(Input:longint):boolean; virtual;
       function IsOutputConnected(Output:longint):boolean; virtual;
       property AudioMaster:TAudioMasterCallbackFunc read FAudioMaster;
       property Effect:PEffect read GetEffect;
       property Editor:TAudioEffectEditor read fEditor write SetEditor;
       property SampleRate:single read fSampleRate write setSampleRate;
       property BlockSize:longint read fBlockSize write setBlockSize;
     end;

     TAudioEffectEditor=class
      protected
       FEffect:TAudioEffect;
       SystemWindow:pointer;
      public
       constructor Create(TEffect:TAudioEffect); virtual;
       function GetRect(var rect:PERect):longint; virtual;
       function Open(Ptr:pointer):longint; virtual;
       procedure Close; virtual;
       function IsOpen:boolean; virtual;
       procedure Idle; virtual;
       procedure Update; virtual;
       function OnKeyDown(var KeyCode:TVSTKeyCode):boolean; virtual;
       function OnKeyUp(var KeyCode:TVSTKeyCode):boolean; virtual;
       function SetKnobMode(Val:longint):boolean; virtual;
       function OnWheel(Distance:single):boolean; virtual;
       property Effect:TAudioEffect read FEffect;
     end;

     TAudioEffectExtended=class(TAudioEffect)
      public
       function CanParameterBeAutomated(Index:longint):boolean; virtual;
       function String2Parameter(Index:longint;Text:pansichar):boolean; virtual;
       function GetParameterProperties(Index:longint;p:PVstParameterProperties):boolean; virtual;
       function BeginEdit(Index:longint):boolean; virtual;
       function EndEdit(Index:longint):boolean; virtual;
       function GetProgramNameIndexed(Category,Index:longint;Text:pansichar):boolean; virtual;
       function BeginSetProgram:boolean; virtual;
       function EndSetProgram:boolean; virtual;
       function BeginLoadBank(Ptr:PVstPatchChunkInfo):longint; virtual;
       function BeginLoadProgram(Ptr:PVstPatchChunkInfo):longint; virtual;
       function IOChanged:boolean; virtual;
       function UpdateSampleRate:double; virtual;
       function UpdateBlockSize:longint; virtual;
       function GetInputLatency:longint; virtual;
       function GetOutputLatency:longint; virtual;
       function GetInputProperties(Index:longint;Properties:PVstPinProperties):boolean; virtual;
       function GetOutputProperties(Index:longint;Properties:PVstPinProperties):boolean; virtual;
       function SetSpeakerArrangement(PluginInput,PluginOutput:PVstSpeakerArrangement):boolean; virtual;
       function GetSpeakerArrangement(PluginInput,PluginOutput:PPVstSpeakerArrangement):boolean; virtual;
       function SetBypass(OnOff:boolean):boolean; virtual;
       function SetPanLaw(vType:longint;Value:single):boolean; virtual;                                     
       function SetProcessPrecision(Precision:longint):boolean; virtual;
       function GetNumMidiInputChannels:longint; virtual;
       function GetNumMidiOutputChannels:longint; virtual;
       function GetTimeInfo(Filter:longint):PVstTimeInfo; virtual;
       function GetCurrentProcessLevel:longint; virtual;
       function GetAutomationState:longint;
       function ProcessEvents(Events:PVstEvents):longint; virtual;
       function SendVstEventsToHost(Events:PVstEvents):boolean; virtual;
       function StartProcess:longint; virtual;
       function StopProcess:longint; virtual;
       function ProcessVariableIO(VarIO:PVstVariableIO):boolean; virtual;
       function SetTotalSampleToProcess(Value:longint):longint; virtual;
       function GetHostVendorString(Text:pansichar):boolean; virtual;
       function GetHostProductString(Text:pansichar):boolean; virtual;
       function GetHostVendorVersion:longint; virtual;
       function HostVendorSpecific(Arg1:longint;Arg2:TNativeSignedInt;PtrArg:pointer;FloatArg:single):TNativeSignedInt; virtual;
       function CanHostDo(Text:pansichar):longint; virtual;                                                                   
       function GetHostLanguage:longint;
       procedure IsSynth(State:boolean); virtual;
       procedure NoTail(State:boolean); virtual;
       function GetTailSize:longint; virtual;
       function GetDirectory:pointer; virtual;
       function GetEffectName(Name:pansichar):boolean; virtual;
       function GetVendorString(Text:pansichar):boolean; virtual;
       function GetProductString(Text:pansichar):boolean; virtual;
       function GetVendorVersion:longint; virtual;
       function VendorSpecific(Arg:longint;Arg2:TNativeSignedInt;PtrArg:pointer;FloatArg:single):TNativeSignedInt; virtual;
       function CanDo(Text:pansichar):longint; virtual;
       function GetVstVersion:longint; virtual;
       function GetPlugCategory:longint; virtual;
       function GetMidiProgramName(Channel:longint;MidiProgramName:PMIDIProgramName):longint; virtual;
       function GetCurrentMidiProgram(Channel:longint;CurrentProgram:PMIDIProgramName):longint; virtual;
       function GetMidiProgramCategory(Channel:longint;Category:PMIDIProgramCategory):longint; virtual;
       function HasMidiProgramsChanged(Channel:longint):boolean; virtual;
       function GetMidiKeyName(Channel:longint;KeyName:PMIDIKeyName):boolean; virtual;
       function UpdateDisplay:boolean; virtual;
       function SizeWindow(Width,Height:longint):boolean; virtual;
       function OpenFileSelector(Ptr:PVstFileSelect):boolean; virtual;
       function CloseFileSelector(Ptr:PVstFileSelect):boolean; virtual;
       function GetNextShellPlugin(Name:pansichar):longint; virtual;
       function AllocateArrangement(var Arrangement:PVstSpeakerArrangement;nbChannels:longint):boolean; virtual;
       function DeallocateArrangement(var Arrangement:PVstSpeakerArrangement):boolean; virtual;                      
       function CopySpeaker(Dest,Source:PVstSpeakerProperties):boolean; virtual;                                    
       function MatchArrangement(var Dest:PVstSpeakerArrangement;Source:PVstSpeakerArrangement):boolean; virtual;  
       function OfflineRead(Offline:PVstOfflineTask;Option:longint;ReadSource:boolean):boolean; virtual;
       function OfflineWrite(Offline:PVstOfflineTask;Option:longint):boolean; virtual;
       function OfflineStart(AudioFiles:PVstAudioFile;NumAudioFiles,NumNewAudioFiles:longint):boolean; virtual;
       function OfflineGetCurrentPass:longint; virtual;
       function OfflineGetCurrentMetaPass:longint; virtual;
       function OfflineNotify(Ptr:PVstAudioFile;NumAudioFiles:longint;Start:boolean):boolean; virtual;
       function OfflinePrepare(Offline:PVstOfflineTask;Count:longint):boolean; virtual;
       function OfflineRun(Offline:PVstOfflineTask;Count:longint):boolean; virtual;
       function OfflineGetNumPasses:longint; virtual;
       function OfflineGetNumMetaPasses:longint; virtual;
       function Dispatcher(Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt; override;
       procedure Resume; override;
       procedure WantEvents(Filter:longint); virtual;
       function TempoAt(Pos:longint):longint; virtual;
       function GetNumAutomatableParameters:longint; virtual;
       function GetParameterQuantization:longint; virtual;
       function GetNumCategories:longint; virtual;
       function CopyProgram(Destination:longint):boolean; virtual;
       function NeedIdle:boolean; virtual;
       function GetPreviousPlug(Input:longint):PEffect; virtual;
       function GetNextPlug(Output:longint):PEffect; virtual;
       procedure InputConnected(Index:longint;State:boolean); virtual;
       procedure OutputConnected(Index:longint;State:boolean); virtual;
       function WillProcessReplacing:longint; virtual;
       procedure WantAsyncOperation(State:boolean); virtual;
       procedure HasExternalBuffer(State:boolean); virtual;
       function ReportCurrentPosition:longint; virtual;
       function ReportDestinationBuffer:psingle; virtual;
       procedure SetOutputSamplerate(SampleRate:single); virtual;
       function GetInputSpeakerArrangement:PVstSpeakerArrangement; virtual;
       function GetOutputSpeakerArrangement:PVstSpeakerArrangement; virtual;
       function OpenWindow(Window:PVstWindow):pointer; virtual;
       function CloseWindow(Window:PVstWindow):boolean; virtual;
       procedure SetBlockSizeAndSampleRate(aBlockSize:longint;aSampleRate:single); virtual;
       function GetErrorText(Text:pansichar):boolean; virtual;
       function GetIcon:pointer; virtual;
       function SetViewPosition(x,y:longint):boolean; virtual;
       function FxIdle:longint; virtual;
       function KeysRequired:boolean; virtual;
       function GetChunkFile(NativePath:pansichar):boolean; virtual;
     end;

function DispatchEffectClass(Effect:PEffect;Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt; cdecl;
function GetParameterClass(Effect:PEffect;Index:longint):single; cdecl;
procedure SetParameterClass(Effect:PEffect;Index:longint;Value:single); cdecl;
procedure processClass(Effect:PEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
procedure ProcessClassReplacing(Effect:PEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
procedure ProcessClassDoubleReplacing(Effect:PEffect;Inputs,Outputs:PPDouble;SampleFrames:longint); cdecl;

function FourCharToLong(C1,C2,C3,C4:ansichar):longint;

implementation

function FourCharToLong(C1,C2,C3,C4:ansichar):longint;
begin
 result:=byte(C4) or (byte(C3) shl 8) or (byte(C2) shl 16) or (byte(C1) shl 24);
end;

function DispatchEffectClass(Effect:PEffect;Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt; cdecl;
var obj:TAudioEffect;
begin
 obj:=Effect^.vObject;
 if Opcode=effClose then begin
  obj.Dispatcher(Opcode,Index,Value,Ptr,Opt);
  obj.Free;
  result:=1;
 end else begin
  result:=obj.Dispatcher(Opcode,Index,Value,Ptr,Opt);
 end;
end;

function GetParameterClass(Effect:PEffect;Index:longint):single; cdecl;
begin
 result:=TAudioEffect(Effect^.vObject).GetParameter(Index);
end;

procedure SetParameterClass(Effect:PEffect;Index:longint;Value:single); cdecl;
begin
 TAudioEffect(Effect^.vObject).SetParameter(Index,Value);
end;

procedure processClass(Effect:PEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
begin
 TAudioEffect(Effect^.vObject).Process(Inputs,Outputs,SampleFrames);
end;

procedure ProcessClassReplacing(Effect:PEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
begin
 TAudioEffect(Effect^.vObject).ProcessReplacing(Inputs,Outputs,SampleFrames);
end;

procedure ProcessClassDoubleReplacing(Effect:PEffect;Inputs,Outputs:PPDouble;SampleFrames:longint); cdecl;
begin
 TAudioEffect(Effect^.vObject).ProcessDoubleReplacing(Inputs,Outputs,SampleFrames);
end;

function TAudioEffect.GetMasterVersion:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,AudioMasterVersion,0,0,nil,0);
  if result=0 then begin
   result:=1;
  end;
 end else begin
  result:=1;
 end;
end;

constructor TAudioEffect.Create(anAudioMaster:TAudioMasterCallbackFunc;aNumPrograms,aNumParams:longint);
begin
 inherited Create;

 FAudioMaster:=anAudioMaster;
 FEditor:=nil;
 FSampleRate:=44100;
 FBlockSize:=1024;
 NumPrograms:=aNumPrograms;
 NumParams:=aNumParams;
 CurProgram:=0;

 FillChar(FEffect,SizeOf(TEffect),#0);

 FEffect.Magic:=FourCharToLong('V','s','t','P');
 FEffect.Dispatcher:=dispatchEffectClass;
 FEffect.Process:=processClass;
 FEffect.SetParameter:=setParameterClass;
 FEffect.GetParameter:=getParameterClass;
 FEffect.NumPrograms:=NumPrograms;
 FEffect.NumParams:=NumParams;
 FEffect.NumInputs:=1;		
 FEffect.NumOutputs:=2;		
 FEffect.IORatio:=1.0;
 FEffect.vObject:=Self;
 FEffect.UniqueID:=FourCharToLong('N','o','E','f'); 
 FEffect.Version:=1;
 FEffect.ProcessReplacing:=processClassReplacing;

 canProcessReplacing(true);
 FEffect.ProcessDoubleReplacing:=processClassDoubleReplacing;
end;

destructor TAudioEffect.Destroy;
begin
 if assigned(FEditor) then begin
  FEditor.Free;
  FEditor:=nil;
 end;
 inherited Destroy;
end;

procedure TAudioEffect.SetSampleRate(NewValue:single);
begin
 FSampleRate:=NewValue;
end;

procedure TAudioEffect.SetBlockSize(NewValue:longint);
begin
 FBlockSize:=NewValue;
end;

procedure TAudioEffect.SetProgram(aProgram:longint);
begin
 CurProgram:=aProgram;
end;

procedure TAudioEffect.SetProgramName(Name:pansichar);
begin
end;

procedure TAudioEffect.MasterIdle;
begin
 if assigned(FAudioMaster) then begin
  FAudioMaster(@FEffect,audioMasterIdle,0,0,nil,0);
 end;
end;

function TAudioEffect.GetChunk(var Data:pointer;IsPreset:boolean):longint;
begin
  result:=0;
end;

function TAudioEffect.SetChunk(Data:pointer;ByteSize:longint;IsPreset:boolean):longint;
begin
 result:=0;
end;

procedure TAudioEffect.Open;
begin
end;

procedure TAudioEffect.Close;
begin
end;

function TAudioEffect.GetEffect:PEffect;
begin
 result:=@FEffect;
end;

procedure TAudioEffect.Resume;
begin
end;

procedure TAudioEffect.Suspend;
begin
end;

procedure TAudioEffect.ProgramsAreChunks(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsProgramChunks;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsProgramChunks;
 end;
end;

function TAudioEffect.GetCurrentUniqueId:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterCurrentId,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffect.IsInputConnected(Input:longint):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterPinConnected,Input,0,nil,0)=0;
 end else begin
  result:=true;
 end;
end;

function TAudioEffect.IsOutputConnected(Output:longint):boolean;
begin
 result:=true;
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterPinConnected,Output,1,nil,0)=0;
 end;
end;

procedure TAudioEffect.SetInitialDelay(Delay:longint);
begin
 FEffect.InitialDelay:=Delay;
end;

procedure TAudioEffect.CanProcessReplacing(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsCanReplacing;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsCanReplacing;
 end;
end;

procedure TAudioEffect.SetNumOutputs(Outputs:longint);
begin
 FEffect.NumOutputs:=Outputs;
end;

function TAudioEffect.Dispatcher(Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt;
var pe:PERect;
begin
 result:=0;
 case Opcode of
  effOpen:begin
   Open;
  end;
  effClose:begin
   Close;
  end;
  effSetProgram:begin
   if int64(Value)<int64(NumPrograms) then begin
    SetProgram(Value);
   end;
  end;
  effGetProgram:begin
   result:=GetProgram;
  end;
  effSetProgramName:begin
   SetProgramName(Ptr);
  end;
  effGetProgramName:begin
   GetProgramName(Ptr);
  end;
  effGetParamLabel:begin
   GetParameterLabel(Index,Ptr);
  end;
  effGetParamDisplay:begin
   GetParameterDisplay(Index,Ptr);
  end;
  effGetParamName:begin
   GetParameterName(Index,Ptr);
  end;
  effSetSampleRate:begin
   SetSampleRate(Opt);
  end;
  effSetBlockSize:begin
   SetBlockSize(Value);
  end;
  effMainsChanged:begin
   if Value=0 then begin
    Suspend;
   end else begin
    Resume;
   end;
  end;
  effGetVu:begin
   result:=round(GetVu*32767);
  end;
  effEditGetRect:begin
   if assigned(FEditor) then begin
    pe:=PPERect(Ptr)^;
    result:=FEditor.GetRect(pe);
    PPERect(Ptr)^:=pe;
   end;
  end;
  effEditOpen:begin
   if assigned(FEditor) then begin
    result:=FEditor.Open(Ptr);
   end;
  end;
  effEditClose:begin
   if assigned(FEditor) then begin
    FEditor.Close;
   end;
  end;
  effEditIdle:begin
   if assigned(FEditor) then begin
    FEditor.Idle;
   end;
  end;
  effIdentify:begin
   result:=FourCharToLong('N','v','E','f');
  end;
  effGetChunk:begin
   result:=GetChunk(ppointer(Ptr)^,(Index<>0));
  end;
  effSetChunk:begin
   result:=SetChunk(Ptr,Value,(Index<>0));
  end;
 end;
end;

procedure TAudioEffect.SetEditor(NewValue:TAudioEffectEditor);
begin
 FEditor:=NewValue;
 if assigned(FEditor) then begin
  FEffect.Flags:=FEffect.Flags or effFlagsHasEditor;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsHasEditor;
 end;
end;

procedure TAudioEffect.SetNumInputs(Inputs:longint);
begin
 FEffect.NumInputs:=Inputs;
end;

procedure TAudioEffect.SetUniqueID(ID:longint);
begin
 FEffect.UniqueID:=ID;
end;

function TAudioEffect.GetParameter(Index:integer):single;
begin
 result:=0;
end;

procedure TAudioEffect.SetParameter(Index:longint;Value:single);
begin
end;

procedure TAudioEffect.SetParameterAutomated(Index:longint;Value:single);
begin
 SetParameter(Index,Value);
 if assigned(FAudioMaster) then begin
  FAudioMaster(@FEffect,audioMasterAutomate,Index,0,nil,Value);
 end;
end;

procedure TAudioEffect.GetParameterName(Index:longint;Text:pansichar);
begin
 StrCopy(Text,'');
end;

procedure TAudioEffect.GetParameterDisplay(Index:longint;Text:pansichar);
begin
 StrCopy(Text,'');
end;

procedure TAudioEffect.GetParameterLabel(Index:longint;aLabel:pansichar);
begin
 StrCopy(aLabel,'');
end;

function TAudioEffect.GetProgram:longint;
begin
 result:=CurProgram;
end;

procedure TAudioEffect.GetProgramName(Name:pansichar);
begin
 StrCopy(Name,'');
end;

procedure TAudioEffect.ProcessDoubleReplacing(Inputs,Outputs:PPDouble;SampleFrames:longint);
begin
end;

procedure TAudioEffect.CanDoubleReplacing(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsCanDoubleReplacing;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsCanDoubleReplacing;
 end;
end;

procedure TAudioEffect.Process(Inputs,Outputs:ppsingle;SampleFrames:longint);
begin
end;

function TAudioEffect.GetVu:single;
begin
 result:=0;
end;

procedure TAudioEffect.HasVu(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsHasVu;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsHasVu;
 end;
end;

procedure TAudioEffect.HasClip(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsHasClip;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsHasClip;
 end;
end;

procedure TAudioEffect.CanMono(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsCanMono;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsCanMono;
 end;
end;

procedure TAudioEffect.SetRealtimeQualities(Qualities:longint);
begin
 FEffect.RealQualities:=Qualities;
end;

procedure TAudioEffect.SetOfflineQualities(Qualities:longint);
begin
 FEffect.OffQualities:=Qualities;
end;

function TAudioEffectEditor.GetRect(var rect:PERect):longint;
begin
 rect:=nil;
 result:=0;
end;

procedure TAudioEffectEditor.Idle;
begin
end;

procedure TAudioEffectEditor.Update;
begin
end;

constructor TAudioEffectEditor.Create(TEffect:TAudioEffect);
begin
 inherited Create;
 FEffect:=TEffect;
 SystemWindow:=nil;
end;

function TAudioEffectEditor.IsOpen:boolean;
begin
 result:=assigned(SystemWindow);
end;

function TAudioEffectEditor.Open(Ptr:pointer):longint;
begin
 SystemWindow:=Ptr;
 result:=0;
end;

procedure TAudioEffectEditor.Close;
begin
 SystemWindow:=nil;
end;

function TAudioEffectEditor.OnKeyDown(var KeyCode:TVSTKeyCode):boolean;
begin
 result:=false;
end;

function TAudioEffectEditor.OnKeyUp(var KeyCode:TVSTKeyCode):boolean;
begin
 result:=false;
end;

function TAudioEffectEditor.SetKnobMode(Val:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectEditor.OnWheel(Distance:single):boolean;
begin
  result:=false;
end;

function TAudioEffectExtended.CanHostDo(Text:pansichar):longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterCanDo,0,0,text,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetAutomationState:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=audioMaster(@FEffect,audioMasterGetAutomationState,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetOutputProperties(Index:longint;Properties:PVstPinProperties):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetOutputLatency:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetOutputLatency,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetHostVendorString(Text:pansichar):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetVendorString,0,0,text,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.ProcessVariableIO(VarIO:PVstVariableIO):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.IOChanged:boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterIOChanged,0,0,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.OfflineGetNumMetaPasses:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.SetSpeakerArrangement(PluginInput,PluginOutput:PVstSpeakerArrangement):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.OfflineStart(AudioFiles:PVstAudioFile;NumAudioFiles,NumNewAudioFiles:longint):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterOfflineStart,NumNewAudioFiles,NumAudioFiles,AudioFiles,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.SizeWindow(Width,Height:longint):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterSizeWindow,Width,Height,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

procedure TAudioEffectExtended.IsSynth(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsIsSynth;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsIsSynth;
 end;
end;

function TAudioEffectExtended.CanDo(Text:pansichar):longint;
begin
 result:=0;
end;

function TAudioEffectExtended.GetHostVendorVersion:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetVendorVersion,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetInputProperties(Index:longint;Properties:PVstPinProperties):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetInputLatency:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetInputLatency,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetVstVersion:longint;
begin
 result:=kVstVersion;
end;

function TAudioEffectExtended.GetVendorString(Text:pansichar):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.UpdateBlockSize:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetBlockSize,0,0,nil,0);
  if result>0 then begin
   FBlockSize:=result;
  end;
 end;
 result:=FBlockSize;
end;

function TAudioEffectExtended.GetParameterProperties(Index:longint;p:PVstParameterProperties):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.OfflineGetNumPasses:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.ProcessEvents(Events:PVstEvents):longint;
begin
 result:=0;
end;

function TAudioEffectExtended.OfflineRun(Offline:PVstOfflineTask;Count:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetProgramNameIndexed(Category,Index:longint;Text:pansichar):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetVendorVersion:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.HostVendorSpecific(Arg1:longint;Arg2:TNativeSignedInt;PtrArg:pointer;FloatArg:single):TNativeSignedInt;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterVendorSpecific,Arg1,Arg2,PtrArg,FloatArg);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.OfflineRead(Offline:PVstOfflineTask;Option:longint;ReadSource:boolean):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterOfflineRead,ord(ReadSource),Option,Offline,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.String2Parameter(Index:longint;Text:pansichar):boolean;
begin
 result:=false;
end;

procedure TAudioEffectExtended.Resume;
begin
 inherited Resume;
 if (FEffect.Flags and effFlagsIsSynth<>0) or (CanDo(canDoReceiveVstMidiEvent)=1) then begin
  WantEvents(1);
 end;
end;

function TAudioEffectExtended.GetEffectName(Name:pansichar):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.SetBypass(OnOff:boolean):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.SendVstEventsToHost(Events:PVstEvents):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterProcessEvents,0,0,Events,0)=1;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.GetHostLanguage:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetLanguage,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.OfflineWrite(Offline:PVstOfflineTask;Option:longint):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterOfflineWrite,0,Option,Offline,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.VendorSpecific(Arg:longint;Arg2:TNativeSignedInt;PtrArg:pointer;FloatArg:single):TNativeSignedInt;
begin
 result:=0;
end;

function TAudioEffectExtended.GetHostProductString(Text:pansichar):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetProductString,0,0,Text,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.GetTailSize:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.GetCurrentProcessLevel:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetCurrentProcessLevel,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.Dispatcher(Opcode,Index:longint;Value:TNativeSignedInt;Ptr:pointer;Opt:single):TNativeSignedInt;
var KeyCode:TVSTKeyCode;
begin
 result:=0;
 case Opcode of
  effProcessEvents:begin
   result:=ProcessEvents(Ptr);
  end;
  effCanBeAutomated:begin
   result:=ord(CanParameterBeAutomated(Index));
  end;
  effString2Parameter:begin
   result:=ord(String2Parameter(Index,Ptr));
  end;
  effGetProgramNameIndexed:begin
   result:=ord(GetProgramNameIndexed(Value,Index,Ptr));
  end;
  effGetNumProgramCategories:begin
   result:=GetNumCategories;
  end;
  effCopyProgram:begin
   result:=ord(CopyProgram(Index));
  end;
  effConnectInput:begin
   InputConnected(Index,Value<>0);
   result:=1;
  end;
  effConnectOutput:begin
   OutputConnected(Index,Value<>0);
   result:=1;
  end;
  effGetInputProperties:begin
   result:=ord(GetInputProperties(Index,Ptr));
  end;
  effGetOutputProperties:begin
   result:=ord(GetOutputProperties(Index,Ptr));
  end;
  effGetPlugCategory:begin
   result:=GetPlugCategory;
  end;
  effGetCurrentPosition:begin
   result:=ReportCurrentPosition;
  end;
  effGetDestinationBuffer:begin
   result:=TNativeSignedInt(ReportDestinationBuffer);
  end;
  effOfflineNotify:begin
   result:=ord(OfflineNotify(Ptr,Value,Index<>0));
  end;
  effOfflinePrepare:begin
   result:=ord(OfflinePrepare(Ptr,Value));
  end;
  effOfflineRun:begin
   result:=ord(OfflineRun(Ptr,Value));
  end;
  effSetSpeakerArrangement:begin
   result:=ord(SetSpeakerArrangement(pointer(Value),Ptr));
  end;
  effProcessVarIo:begin
   result:=ord(ProcessVariableIO(Ptr));
  end;
  effSetBlockSizeAndSampleRate:begin
   SetBlockSizeAndSampleRate(Value,Opt);
   result:=1;
  end;
  effSetBypass:begin
   result:=ord(SetBypass(Value<>0));
  end;
  effGetEffectName:begin
   result:=ord(GetEffectName(Ptr));
  end;
  effGetVendorString:begin
   result:=ord(GetVendorString(Ptr));
  end;
  effGetProductString:begin
   result:=ord(GetProductString(Ptr));
  end;
  effGetVendorVersion:begin
   result:=GetVendorVersion;
  end;
  effVendorSpecific:begin
   result:=VendorSpecific(Index,Value,Ptr,Opt);
  end;
  effCanDo:begin
   result:=CanDo(Ptr);
  end;
  effGetTailSize:begin
   result:=GetTailSize;
  end;
  effGetErrorText:begin
   result:=ord(GetErrorText(Ptr));
  end;
  effGetIcon:begin
   result:=TNativeSignedInt(GetIcon);
  end;
  effSetViewPosition:begin
   result:=ord(SetViewPosition(Index,Value));
  end;
  effIdle:begin
   result:=FxIdle;
  end;
  effKeysRequired:begin
   result:=ord(not KeysRequired);
  end;
  effGetParameterProperties:begin
   result:=ord(GetParameterProperties(Index,Ptr));
  end;
  effGetVstVersion:begin
   result:=GetVstVersion;
  end;
  effEditKeyDown:begin
   if assigned(FEditor) then begin
    KeyCode.CharacterCode:=Index;
    KeyCode.VirtualCode:=Value;
    KeyCode.ModifierCode:=Round(Opt);
    result:=ord(FEditor.onKeyDown(KeyCode));
   end;
  end;
  effEditKeyUp:begin
   if assigned(FEditor) then begin
    KeyCode.CharacterCode:=Index;
    KeyCode.VirtualCode:=Value;
    KeyCode.ModifierCode:=Round(Opt);
    result:=ord(FEditor.onKeyUp(KeyCode));
   end;
  end;
  effSetEditKnobMode:begin
   if assigned(FEditor) then begin
    result:=ord(FEditor.SetKnobMode(Value));
   end;
  end;
  effGetMidiProgramName:begin
   result:=GetMidiProgramName(Index,Ptr);
  end;
  effGetCurrentMidiProgram:begin
   result:=GetCurrentMidiProgram(Index,Ptr);
  end;
  effGetMidiProgramCategory:begin
   result:=GetMidiProgramCategory(Index,Ptr);
  end;
  effHasMidiProgramsChanged:begin
   result:=ord(HasMidiProgramsChanged(Index));
  end;
  effGetMidiKeyName:begin
   result:=ord(GetMidiKeyName(Index,Ptr));
  end;
  effBeginSetProgram:begin
   result:=ord(BeginSetProgram);
  end;
  effEndSetProgram:begin
   result:=ord(EndSetProgram);
  end;
  effGetSpeakerArrangement:begin
   result:=ord(GetSpeakerArrangement(PPVstSpeakerArrangement(Value),PPVstSpeakerArrangement(Ptr)));
  end;
  effSetTotalSampleToProcess:begin
   result:=SetTotalSampleToProcess(Value);
  end;
  effShellGetNextPlugin:begin
   result:=GetNextShellPlugin(Ptr);
  end;
  effStartProcess:begin
   result:=StartProcess;
  end;
  effStopProcess:begin
   result:=StopProcess;
  end;
  effSetPanLaw:begin
   result:=ord(SetPanLaw(Value,Opt));
  end;
  effBeginLoadBank:begin
   result:=BeginLoadBank(Ptr);
  end;
  effBeginLoadProgram:begin
   result:=BeginLoadProgram(Ptr);
  end;
  effSetProcessPrecision:begin
   result:=ord(SetProcessPrecision(Value));
  end;
  effGetNumMidiInputChannels:begin
   result:=GetNumMidiInputChannels;
  end;
  effGetNumMidiOutputChannels:begin
   result:=GetNumMidiOutputChannels;
  end;
  else begin
   result:=inherited Dispatcher(Opcode,Index,Value,Ptr,Opt);
  end;
 end;
end;

function TAudioEffectExtended.OfflineNotify(Ptr:PVstAudioFile;NumAudioFiles:longint;Start:boolean):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetPlugCategory:longint;
begin
 if (FEffect.Flags and effFlagsIsSynth)<>0 then begin
  result:=kPlugCategSynth;
 end else begin
  result:=kPlugCategUnknown;
 end;
end;

procedure TAudioEffectExtended.NoTail(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsNoSoundInStop;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsNoSoundInStop;
 end;
end;

function TAudioEffectExtended.CanParameterBeAutomated(Index:longint):boolean;
begin
 result:=true;
end;

function TAudioEffectExtended.OfflinePrepare(Offline:PVstOfflineTask;Count:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetProductString(Text:pansichar):boolean;
begin
 StrCopy(Text,'');
 result:=false;
end;

function TAudioEffectExtended.GetSpeakerArrangement(PluginInput,PluginOutput:PPVstSpeakerArrangement):boolean;
begin
 PluginInput^:=nil;
 PluginOutput^:=nil;
 result:=false;
end;

function TAudioEffectExtended.OfflineGetCurrentMetaPass:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterOfflineGetCurrentMetaPass,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.UpdateSampleRate:double;
var r:longint;
begin
 if assigned(FAudioMaster) then begin
  r:=FAudioMaster(@FEffect,audioMasterGetSampleRate,0,0,nil,0);
  if r>0 then begin
   FSampleRate:=r;
  end;
 end;
 result:=FSampleRate;
end;

function TAudioEffectExtended.UpdateDisplay:boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterUpdateDisplay,0,0,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.GetDirectory:pointer;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterGetDirectory,0,0,nil,0));
 end else begin
  result:=nil;
 end;
end;

function TAudioEffectExtended.OfflineGetCurrentPass:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterOfflineGetCurrentPass,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetTimeInfo(Filter:longint):PVSTTimeInfo;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterGetTime,0,filter,nil,0));
 end else begin
  result:=nil;
 end;
end;

function TAudioEffectExtended.BeginEdit(Index:longint):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterBeginEdit,Index,0,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.EndEdit(Index:longint):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterEndEdit,Index,0,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.BeginSetProgram:boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.EndSetProgram:boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.BeginLoadBank(Ptr:PVstPatchChunkInfo):longint;
begin
 result:=0;
end;

function TAudioEffectExtended.BeginLoadProgram(Ptr:PVstPatchChunkInfo):longint;
begin
 result:=0;
end;

function TAudioEffectExtended.SetPanLaw(vType:longint;Value:single):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.SetProcessPrecision(Precision:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetNumMidiInputChannels:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.GetNumMidiOutputChannels:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.StartProcess:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.StopProcess:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.SetTotalSampleToProcess(Value:longint):longint;
begin
 result:=Value;
end;
                                                
function TAudioEffectExtended.GetMidiProgramName(Channel:longint;MidiProgramName:PMIDIProgramName):longint;
begin
 result:=0;
end;

function TAudioEffectExtended.GetCurrentMidiProgram(Channel:longint;CurrentProgram:PMIDIProgramName):longint;
begin
 result:=-1;
end;

function TAudioEffectExtended.GetMidiProgramCategory(Channel:longint;Category:PMIDIProgramCategory):longint;
begin
 result:=0;
end;

function TAudioEffectExtended.HasMidiProgramsChanged(Channel:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetMidiKeyName(Channel:longint;KeyName:PMIDIKeyName):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.OpenFileSelector(Ptr:PVstFileSelect):boolean;
begin
 if assigned(FAudioMaster) and assigned(Ptr) then begin
  result:=FAudioMaster(@FEffect,audioMasterOpenFileSelector,0,0,Ptr,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.CloseFileSelector(Ptr:PVstFileSelect):boolean;
begin
 if assigned(FAudioMaster) and assigned(Ptr) then begin
  result:=FAudioMaster(@FEffect,audioMasterCloseFileSelector,0,0,Ptr,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.GetNextShellPlugin(Name:pansichar):longint;
begin
 StrCopy(Name,'');
 result:=0;
end;

function TAudioEffectExtended.AllocateArrangement(var Arrangement:PVstSpeakerArrangement;nbChannels:longint):boolean;
var Size:longint;
begin
 if assigned(Arrangement) then begin
  FreeMem(Arrangement);
 end;
 Size:=2*SizeOf(longint)+(nbChannels*SizeOf(TVSTSpeakerProperties));
 GetMem(Arrangement,Size);
 if not assigned(Arrangement) then begin
  result:=false;
 end else begin
  FillChar(Arrangement,Size,#0);
  Arrangement^.NumChannels:=nbChannels;
	result:=true;
 end;
end;

function TAudioEffectExtended.DeallocateArrangement(var Arrangement:PVstSpeakerArrangement):boolean;
begin
 if assigned(Arrangement) then begin
  FreeMem(Arrangement);
  Arrangement:=nil;
 end;
 result:=true;
end;

function TAudioEffectExtended.CopySpeaker(Dest,Source:PVstSpeakerProperties):boolean;
begin
 if (not assigned(Source)) or (not assigned(Dest)) then begin
  result:=false;
 end else begin
  StrLCopy(Dest^.Name,Source^.Name,63);
  Dest^.vType:=Source^.vType;
  Dest^.Azimuth:=Source^.Azimuth;
  Dest^.Elevation:=Source^.Elevation;
  Dest^.Radius:=Source^.Radius;
  Dest^.Reserved:=Source^.Reserved;
  Move(Source^.ReservedForFuture[0],Dest^.ReservedForFuture[0],28);
  result:=true;
 end;
end;

function TAudioEffectExtended.MatchArrangement(var Dest:PVstSpeakerArrangement;Source:PVstSpeakerArrangement):boolean;
var i:longint;
begin
 result:=false;
 if assigned(Source) and DeAllocateArrangement(Dest) then begin
  if AllocateArrangement(Dest,Source^.NumChannels) then begin
   Dest^.vType:=Source^.vType;
   for i:=0 to Dest^.NumChannels-1 do begin
    if not CopySpeaker(@(Dest^.speakers[i]),@(Source^.speakers[i])) then begin
     exit;
    end;
   end;
   result:=true;
  end;
 end;
end;

procedure TAudioEffectExtended.WantEvents(Filter:longint);
begin
 if assigned(FAudioMaster) then begin
  FAudioMaster(@FEffect,audioMasterWantMidi,0,Filter,nil,0);
 end;
end;

function TAudioEffectExtended.TempoAt(Pos:longint):longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterTempoAt,0,pos,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetNumAutomatableParameters:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetNumAutomatableParameters,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetParameterQuantization:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetParameterQuantization,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

function TAudioEffectExtended.GetNumCategories:longint;
begin
 result:=1;
end;

function TAudioEffectExtended.CopyProgram(Destination:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.NeedIdle:boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterNeedIdle,0,0,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

function TAudioEffectExtended.GetPreviousPlug(Input:longint):PEffect;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterGetPreviousPlug,0,0,nil,0));
 end else begin
  result:=nil;
 end;
end;

function TAudioEffectExtended.GetNextPlug(Output:longint):PEffect;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterGetNextPlug,0,0,nil,0));
 end else begin
  result:=nil;
 end;
end;

procedure TAudioEffectExtended.InputConnected(Index:longint;State:boolean);
begin
end;

procedure TAudioEffectExtended.OutputConnected(Index:longint;State:boolean);
begin
end;

function TAudioEffectExtended.WillProcessReplacing:longint;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterWillReplaceOrAccumulate,0,0,nil,0);
 end else begin
  result:=0;
 end;
end;

procedure TAudioEffectExtended.WantAsyncOperation(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsExtIsAsync;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsExtIsAsync;
 end;
end;

procedure TAudioEffectExtended.HasExternalBuffer(State:boolean);
begin
 if State then begin
  FEffect.Flags:=FEffect.Flags or effFlagsExtHasBuffer;
 end else begin
  FEffect.Flags:=FEffect.Flags and not effFlagsExtHasBuffer;
 end;
end;

function TAudioEffectExtended.ReportCurrentPosition:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.ReportDestinationBuffer:System.psingle;
begin
 result:=nil;
end;

procedure TAudioEffectExtended.SetOutputSamplerate(SampleRate:single);
begin
 if assigned(FAudioMaster) then begin
  FAudioMaster(@FEffect,audioMasterSetOutputSampleRate,0,0,nil,SampleRate);
 end;
end;

function TAudioEffectExtended.GetInputSpeakerArrangement:PVstSpeakerArrangement;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterGetInputSpeakerArrangement,0,0,nil,0));
 end else begin
  result:=nil;
 end;
end;

function TAudioEffectExtended.GetOutputSpeakerArrangement:PVstSpeakerArrangement;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterGetOutputSpeakerArrangement,0,0,nil,0));
 end else begin
  result:=nil;
 end;
end;

function TAudioEffectExtended.OpenWindow(Window:PVstWindow):pointer;
begin
 if assigned(FAudioMaster) then begin
  result:=pointer(FAudioMaster(@FEffect,audioMasterOpenWindow,0,0,window,0));
 end else begin
  result:=nil;
 end;
end;

function TAudioEffectExtended.CloseWindow(Window:PVstWindow):boolean;
begin
 if assigned(FAudioMaster) then begin
  result:=FAudioMaster(@FEffect,audioMasterCloseWindow,0,0,window,0)<>0;
 end else begin
  result:=false;
 end;
end;

procedure TAudioEffectExtended.SetBlockSizeAndSampleRate(aBlockSize:longint;aSampleRate:single);
begin
 FBlockSize:=aBlockSize;
 FSampleRate:=aSampleRate;
end;

function TAudioEffectExtended.GetErrorText(Text:pansichar):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetIcon:pointer;
begin
 result:=nil;
end;

function TAudioEffectExtended.SetViewPosition(x,y:longint):boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.FxIdle:longint;
begin
 result:=0;
end;

function TAudioEffectExtended.KeysRequired:boolean;
begin
 result:=false;
end;

function TAudioEffectExtended.GetChunkFile(NativePath:pansichar):boolean;
begin
 result:=false;
 if assigned(FAudioMaster) and assigned(NativePath) then begin
  result:=FAudioMaster(@FEffect,audioMasterGetChunkFile,0,0,nativePath,0)<>0;
 end;
end;

end.
