(* Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * Licensed under the terms of the LGPL V3 or later, see LGPLv3.txt or
 * http://www.gnu.org/licenses/lgpl.html for details
 *)
unit UnitVSTiPlugin;
{$ifdef cpu64}
 {$align 8}
{$else}
 {$align 1}
{$endif}

interface

uses Windows,SysUtils,Graphics,Classes,MMSystem,UnitMIDIEvent,UnitMIDIEventList,
     BeRoUtils,UnitVSTiEditor,BeRoCriticalSection,BeRoStream,Functions,
     Synth,LZBRX,BeRoTinyFlexibleDataStorage,MIDIConstants,DateUtils,VersionInfo;

const wmInstrument=0;
      wmFilter=1;

{$ifdef MultiOutput}
      Software='BR808 (multi output)';
{$else}
      Software='BR808';
{$endif}

      Vendor='Benjamin Rosseaux';

      OscilBufferSize=1024;
      OscilBufferMask=OscilBufferSize-1;

      OscilBufferMasterSize=512;
      OscilBufferMasterMask=OscilBufferMasterSize-1;

      VSTiNumParams=0;
      VSTiNumPrograms=MaxInstruments;

      VSTiNumInputs=2;

{$ifdef MultiOutput}
      VSTiNumOutputs=34;
{$else}
      VSTiNumOutputs=2;
{$endif}

{$ifdef MultiOutput}
      VSTiID='BR8M';
      VSTiID2='BR8S';
{$else}
      VSTiID='BR8S';
      VSTiID2='BR8M';
{$endif}

      VSTiLabel='BR808';

{

Information sources:

http://sourceforge.net/projects/delphiasiovst/
http://www.kvraudio.com/forum/viewtopic.php?p=1905347
http://www.kvraudio.com/forum/printview.php?t=143587&start=0
http://asseca.com/vst-24-specs/

}

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

type TVSTiSignature=array[1..4] of char;
     TVSTiString=array[0..255] of char;

     PVSTEffect=^TVSTEffect;

     PPSingle=^psingle;
     PPDouble=^pdouble;

     TAudioMasterCallbackFunc=function(Effect:PVSTEffect;Opcode,index:longint;Value:ptrint;Ptr:pointer;Opt:single):ptrint; cdecl;
     TDispatcherFunc=function(Effect:PVSTEffect;Opcode,index:longint;Value:ptrint;Ptr:pointer;Opt:single):ptrint; cdecl;
     TProcessProc=procedure(Effect:PVSTEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
     TProcessDoubleProc=procedure(Effect:PVSTEffect;Inputs,Outputs:PPDouble;SampleFrames:longint); cdecl;
     TSetParameterProc=procedure(Effect:PVSTEffect;index:longint;Parameter:single); cdecl;
     TGetParameterFunc=function(Effect:PVSTEffect;index:longint):single; cdecl;
     TMainProc=function(audioMaster:TAudioMasterCallbackFunc):PVSTEffect; cdecl;

     TVSTEffect=record
      Magic:longint;
      Dispatcher:TDispatcherFunc;
      Process:TProcessProc;
      SetParameter:TSetParameterProc;
      GetParameter:TGetParameterFunc;
      NumPrograms,NumParams,NumInputs,NumOutputs,Flags:longint;
      ReservedForHost:pointer;
      Resvd2:ptrint;
      InitialDelay,RealQualities,OffQualities:longint;
      IORatio:single;
      vObject,User:pointer;
      UniqueID,Version:longint;
      ProcessReplacing:TProcessProc;
      ProcessDoubleReplacing:TProcessDoubleProc;
      Future:array[0..55] of byte;
     end;

     TVSTKeyCode=record
      CharacterCode:longint;
      VirtualCode,ModifierCode:byte;
     end;

     TFXChunkSet=packed record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumPrograms:longint;
      PrgName:array[0..27] of ansichar;
      ChunkSize:longint;
      Chunk:pointer;
     end;

     TFXChunkBank=packed record
      ChunkMagic,ByteSize,fxMagic,Version,FXID,FXVersion,NumPrograms:longint;
      ReservedForFuture:array[0..127] of byte;
      ChunkSize:longint;
      Chunk:pointer;
     end;

     PVSTEvent=^TVSTEvent;
     TVSTEvent=record
      VType,ByteSize,DeltaFrames,Flags:longint;
      Data:array[0..15] of byte;
     end;

     PVSTEvents=^TVSTEvents;
     TVSTEvents=record
      NumEvents:longint;
      Reserved:ptrint;
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
      Resvd1:ptrint;
      SysExDump:pbyte;
      Resv2:ptrint;
     end;

     PVSTPinProperties=^TVSTPinProperties;
     TVSTPinProperties=record
      vLabel:array[0..63] of char;
      Flags,ArrangementType:longint;
      ShortLabel:array[0..7] of char;
      Future:array[0..47] of byte;
     end;

     PPERect=^PERect;
     PERect=^TERect;
     TERect=record
      Top,Left,Bottom,Right:smallint;
     end;

     TVSTiProgram=packed record
      Dummy:byte;
     end;
     TVSTiPrograms=array[0..VSTiNumPrograms-1] of TVSTiProgram;

     TVSTiChannelRPN=packed record
      Parameter:integer;
      Data:integer;
     end;

     TVSTEnvelopeADSRSettings=record
      Attack:string;
      Decay:string;
      SustainHold:string;
      Release:string;
      Amplify:string;
      SustainLevel:string;
      Sustain:boolean;
     end;

     TVSTEnvelopeTranceGateSettings=record
      Steps:array[0..15] of boolean;
      OnAmp:string;
      OffAmp:string;
      BPM:string;
      NoteLength:integer;
      Dots:string;
     end;

     TVSTEnvelopeAmpliferSettings=record
      Amplify:string;
     end;

     TVSTEnvelopeSettings=record
      ADSR:TVSTEnvelopeADSRSettings;
      TranceGate:TVSTEnvelopeTranceGateSettings;
      Amplifer:TVSTEnvelopeAmpliferSettings;
     end;

     TVSTEnvelopesSettings=array[0..MaxInstruments-1,0..MaxInstrumentEnvelopes-1] of TVSTEnvelopeSettings;

     TVSTiPluginEditor=class;

     TOscilBuffer=array[0..1,0..OscilBufferMask] of single;

     TSynthEvents=array of TSynthEvent;

     TVSTiPlugin=class
      private
       function GetPluginEditor:TVSTiPluginEditor;
      public
       VSTAudioMaster:TAudioMasterCallbackFunc;
       VSTEditor:TVSTiPluginEditor;
       VSTSampleRate:single;
       VSTBlockSize:longint;
       VSTNumPrograms:longint;
       VSTNumParams:longint;
       VSTCurProgram:longint;
       VSTEffect:TVSTEffect;

       ProgramNames:array[0..VSTiNumPrograms-1] of string;
       EnvelopeNames:array[0..MaxInstruments-1,0..MaxInstrumentEnvelopes-1] of string;
       SampleNames:array[0..MaxInstruments-1,0..MaxSamples-1] of string;
       SampleScripts:array[0..MaxInstruments-1,0..MaxSamples-1] of string;
       SampleScriptLanguages:array[0..MaxInstruments-1,0..MaxSamples-1] of byte;
       SpeechTextNames:array[0..MaxInstruments-1,0..MaxSpeechTexts-1] of string;
       SpeechTexts:array[0..MaxInstruments-1,0..MaxSpeechTexts-1] of string;
       EnvelopeSettings:TVSTEnvelopeSettings;
       EnvelopesSettings:TVSTEnvelopesSettings;
       ExportMIDIEventList:TMIDIEventList;
       ExportMIDIDoRecord:boolean;
       ExportMIDIPosition:int64;
       ExportMIDITicksPerQuarterNote:integer;
       ExportMIDITempo:integer;
       ExportMIDISampleRate:integer;
       ExportMIDIID:int64;
       ExportMIDIStartPosition:int64;
       MIDIID:int64;
       ExportTrackName:string;
       ExportAuthor:string;
       ExportComments:string;
       Buffer:psingle;
       InputBuffer:PSynthBufferSample;
       SampleRate:single;
       InvSampleRate:extended;
       BufferSize:longint;
       OldSampleRate:single;
       OldBufferSize:longint;
       AudioChannels:integer;
       VSTiPluginEditor:TVSTiPluginEditor;
       Done:boolean;
       Pause:boolean;
       MIDIDelta:integer;
       AudioCriticalSection:TBeRoCriticalSection;
       DataCriticalSection:TBeRoCriticalSection;
       CurrentProgram:integer;
       ChunkData:pointer;
       OmniMode:boolean;
       PeaksEx:array[0..1] of single;
       Peaks:array[0..1] of single;
       Track:TSynthTrack;
       ColorBack:TColor;
       ColorTrackBack:TColor;
       ColorFocusedHighlight:TColor;
       ColorDown:TColor;
       ColorBorder:TColor;
       ColorBorderCache:TColor;
       ColorEditListBack:TColor;
       ColorEditListFocused:TColor;
       ColorFont:TColor;
       ColorPeakOffA:TColor;
       ColorPeakOffB:TColor;
       ColorPeakOffC:TColor;
       ColorPeakOnA:TColor;
       ColorPeakOnB:TColor;
       ColorPeakOnC:TColor;
       ColorRFactor:integer;
       ColorGFactor:integer;
       ColorBFactor:integer;
       CPUTime:extended;
       DoOutputAudio:boolean;

       OscilBufferEx:TOscilBuffer;
       OscilBuffer:array[0..OscilBufferMasterMask] of TOscilBuffer;
       OscilBufferIndex:integer;
       OscilBufferMasterIndex:integer;
       OscilBufferReadyIndex:integer;

       constructor CreatePlugin(AAudioMaster:TAudioMasterCallbackFunc);
       destructor Destroy; override;
       function Dispatcher(Opcode,index:longint;Value:ptrint;Ptr:pointer;Opt:single):ptrint;
       procedure ChangeProgramText(ProgramNr:integer);
       procedure ChangeProgram(ChannelIndex,ProgramNr:integer);
       procedure ProcessEx(Input,Output:pointer;Samples:longint;Replace,UseDoubles:boolean);
       procedure Process(Input,Output:PPSINGLE;Samples:longint);
       procedure ProcessReplacing(Input,Output:PPSINGLE;Samples:longint);
       procedure ProcessDoubleReplacing(Input,Output:PPDouble;Samples:longint);
       procedure SetProgram(AProgram:longint);
       function GetProgram:longint;
       procedure SetProgramName(name:pchar);
       procedure GetProgramName(name:pchar);
       procedure SetParameterEx(index:longint;Value:byte);
       procedure SetParameter(index:longint;Value:single);
       function GetParameter(index:longint):single;
       function ProcessEvents(Events:PVSTEvents):longint;
       procedure Resume;
       procedure Suspend;
       function GetProgramNameIndexed(Category,index:longint;Text:pchar):boolean;
       procedure SetSampleRate(ASampleRate:single);
       procedure SetBlockSize(ABlockSize:longint);
       procedure SetBlockSizeAndSampleRate(ABlockSize:longint;ASampleRate:single);
       function GetChunk(var Data:pointer;IsPreset:boolean):longint;
       function SetChunk(Data:pointer;ByteSize:longint;IsPreset:boolean):longint;
       procedure RecordMIDIStart(Sender:TVSTiPlugin=nil);
       procedure RecordMIDIStop(Sender:TVSTiPlugin=nil);
       function ReadMIDIStream(Data:pbyte;DataSize:longword):boolean; overload;
       function ReadMIDIStream(Stream:TBeRoStream):boolean; overload;
       function GenerateBMF(BMFStream,BankStream:TBeRoStream;Sender:TVSTiPlugin=nil):boolean;
       function GenerateBank(BankStream:TBeRoStream;WithTrack:boolean):boolean;
       function GenerateBMFWithBank(Stream:TBeRoStream):boolean;
       function GenerateSynthConfigINC(Stream:TBeRoStream;WithTrack:boolean):boolean;
       function UpdateDisplay:boolean;
       property PluginEditor:TVSTiPluginEditor read GetPluginEditor;
     end;

     TVSTiPluginEditor=class
      private
       R:TERect;
       UseCount:longint;
       Editor:TVSTiEditor;
       SystemWindow:HWnd;
       FirstIdle:boolean;
       Effect:TVSTiPlugin;
       function GetPlugin:TVSTiPlugin;
      public
       constructor Create(AEffect:TVSTiPlugin);
       destructor Destroy; override;
       function GetRect(var Rect:PERect):longint;
       function Open(Ptr:pointer):longint;
       procedure Close;
       procedure Idle;
       procedure Update;
       procedure UpdateEx;
       property Plugin:TVSTiPlugin read GetPlugin;
     end;

     PInstanceInfo=^TInstanceInfo;
     TInstanceInfo=packed record
      Instance:THandle;
      InstanceID:int64;
      ProcessID:longword;
      NumberOfVSTiPluginInstances:integer;
      VSTiPluginInstancesList:TList;
      VSTiPluginInstancesCriticalSection:TBeRoCriticalSection;
      AddVSTiPlugin:procedure(VSTiPlugin:TVSTiPlugin); register;
      RemoveVSTiPlugin:procedure(VSTiPlugin:TVSTiPlugin); register;
     end;

var InstanceInfo:PInstanceInfo=nil;
    InstanceID:int64=0;
    ProcessID:longword=0;

function FourCharToLong(C1,C2,C3,C4:char):longint;

implementation

function FourCharToLong(C1,C2,C3,C4:char):longint;
begin
 result:=ord(C4)+(ord(C3) shl 8)+(ord(C2) shl 16)+(ord(C1) shl 24);
end;

function DispatchEffectClass(Effect:PVSTEffect;Opcode,index:longint;Value:ptrint;Ptr:pointer;Opt:single):ptrint; cdecl;
var VSTiPlugin:TVSTiPlugin;
begin
 VSTiPlugin:=Effect^.vObject;
 if Opcode=effClose then begin
  VSTiPlugin.Dispatcher(Opcode,index,Value,Ptr,Opt);
  VSTiPlugin.Free;
  result:=1;
 end else begin
  result:=VSTiPlugin.Dispatcher(Opcode,index,Value,Ptr,Opt);
 end;
end;

function GetParameterClass(Effect:PVSTEffect;index:longint):single; cdecl;
begin
 result:=TVSTiPlugin(Effect^.vObject).GetParameter(index);
end;

procedure SetParameterClass(Effect:PVSTEffect;index:longint;Value:single); cdecl;
begin
 TVSTiPlugin(Effect^.vObject).SetParameter(index,Value);
end;

procedure ProcessClass(Effect:PVSTEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
begin
 TVSTiPlugin(Effect^.vObject).Process(Inputs,Outputs,SampleFrames);
end;

procedure ProcessClassReplacing(Effect:PVSTEffect;Inputs,Outputs:PPSingle;SampleFrames:longint); cdecl;
begin
 TVSTiPlugin(Effect^.vObject).ProcessReplacing(Inputs,Outputs,SampleFrames);
end;

procedure ProcessClassDoubleReplacing(Effect:PVSTEffect;Inputs,Outputs:PPDouble;SampleFrames:longint); cdecl;
begin
 TVSTiPlugin(Effect^.vObject).ProcessDoubleReplacing(Inputs,Outputs,SampleFrames);
end;

constructor TVSTiPlugin.CreatePlugin(AAudioMaster:TAudioMasterCallbackFunc);
var P:array[0..4096] of char;
    Counter,SubCounter:integer;
begin
 inherited Create;

 VSTAudioMaster:=AAudioMaster;
 VSTEditor:=nil;
 VSTSampleRate:=44100;
 VSTBlockSize:=1024;
 VSTNumPrograms:=VSTiNumPrograms;
 VSTNumParams:=VSTiNumParams;
 VSTCurProgram:=0;

 FillChar(VSTEffect,sizeof(TVSTEffect),#0);

 VSTEffect.Magic:=FourCharToLong('V','s','t','P');
 VSTEffect.Dispatcher:=DispatchEffectClass;
 VSTEffect.Process:=ProcessClass;
 VSTEffect.SetParameter:=SetParameterClass;
 VSTEffect.GetParameter:=GetParameterClass;
 VSTEffect.NumPrograms:=VSTNumPrograms;
 VSTEffect.NumParams:=VSTNumParams;
 VSTEffect.NumInputs:=VSTiNumInputs;
 VSTEffect.NumOutputs:=VSTiNumOutputs;
 VSTEffect.IORatio:=1.0;
 VSTEffect.vObject:=self;
 VSTEffect.UniqueID:=FourCharToLong('N','o','E','f');
 VSTEffect.Version:=1;
 VSTEffect.UniqueID:=FourCharToLong(VSTiID[1],VSTiID[2],VSTiID[3],VSTiID[4]);
 VSTEffect.Flags:=effFlagsHasEditor or effFlagsCanReplacing or effFlagsProgramChunks or effFlagsIsSynth or effFlagsCanDoubleReplacing;
 VSTEffect.ProcessReplacing:=ProcessClassReplacing;
 VSTEffect.ProcessDoubleReplacing:=ProcessClassDoubleReplacing;

 DoOutputAudio:=true;//RunForever or (Now<EncodeDateTime(RunUntilYear,RunUntilMonth,RunUntilDay,0,0,0,0));

{if not DoOutputAudio then begin
  MessageBox(0,pchar('Beta build trial period has expired, so it will output only silence now! Please download a new beta build.'),pchar(Software),MB_ICONINFORMATION or MB_OK);
 end;}

 Buffer:=nil;
 ChunkData:=nil;
 InputBuffer:=nil;

 BufferSize:=2048;
 SampleRate:=44100;
 InvSampleRate:=1/SampleRate;
 OldBufferSize:=2048;
 OldSampleRate:=44100;
 SynthInit(@Track,SoftTRUNC(SampleRate),BufferSize);

 getmem(InputBuffer,BufferSize*4*sizeof(TSynthBufferSample));

 AudioChannels:=2;

 CurrentProgram:=0;

 FillChar(OscilBufferEx,sizeof(TOscilBuffer),#0);
 FillChar(OscilBuffer,sizeof(OscilBuffer),#0);
 OscilBufferIndex:=0;
 OscilBufferMasterIndex:=0;
 OscilBufferReadyIndex:=0;

 OmniMode:=true;

 AudioCriticalSection:=TBeRoCriticalSection.Create;
 DataCriticalSection:=TBeRoCriticalSection.Create;

 VSTiPluginEditor:=TVSTiPluginEditor.Create(self);
 VSTEditor:=VSTiPluginEditor;

 ExportMIDIEventList:=TMIDIEventList.Create;
 ExportMIDIDoRecord:=false;
 ExportMIDIPosition:=0;
 ExportMIDITicksPerQuarterNote:=1;
 ExportMIDITempo:=500000;
 ExportMIDISampleRate:=44100;
 ExportMIDIID:=0;
 ExportMIDIStartPosition:=0;
 MIDIID:=0;

 Pause:=false;

 if assigned(VSTAudioMaster) then begin
  VSTAudioMaster(@VSTEffect,audioMasterGetVendorString,0,0,@p,0);
  VSTAudioMaster(@VSTEffect,audioMasterGetProductString,0,0,@p,0);
 end;

 Suspend;

 CurrentProgram:=0;

 for Counter:=0 to VSTiNumPrograms-1 do begin
  ProgramNames[Counter]:='';
 end;

 for Counter:=0 to MaxInstruments-1 do begin
  for SubCounter:=0 to MaxInstrumentEnvelopes-1 do begin
   EnvelopeNames[Counter,SubCounter]:='';
  end;
 end;

 for Counter:=0 to MaxInstruments-1 do begin
  for SubCounter:=0 to MaxSamples-1 do begin
   SampleNames[Counter,SubCounter]:='';
   SampleScripts[Counter,SubCounter]:='';
   SampleScriptLanguages[Counter,SubCounter]:=0;
  end;
 end;

 for Counter:=0 to MaxInstruments-1 do begin
  for SubCounter:=0 to MaxSpeechTexts-1 do begin
   SpeechTextNames[Counter,SubCounter]:='';
   SpeechTexts[Counter,SubCounter]:='';
  end;
 end;

 EnvelopesSettings[0,0].ADSR.Attack:='50';
 EnvelopesSettings[0,0].ADSR.Decay:='100';
 EnvelopesSettings[0,0].ADSR.SustainHold:='0';
 EnvelopesSettings[0,0].ADSR.Release:='150';
 EnvelopesSettings[0,0].ADSR.Amplify:='100';
 EnvelopesSettings[0,0].ADSR.SustainLevel:='32';
 EnvelopesSettings[0,0].ADSR.Sustain:=true;
 EnvelopesSettings[0,0].TranceGate.Steps[0]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[1]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[2]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[3]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[4]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[5]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[6]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[7]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[8]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[9]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[10]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[11]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[12]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[13]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[14]:=false;
 EnvelopesSettings[0,0].TranceGate.Steps[15]:=false;
 EnvelopesSettings[0,0].TranceGate.OnAmp:='90';
 EnvelopesSettings[0,0].TranceGate.OffAmp:='10';
 EnvelopesSettings[0,0].TranceGate.BPM:='125';
 EnvelopesSettings[0,0].TranceGate.NoteLength:=3;
 EnvelopesSettings[0,0].TranceGate.Dots:='0';
 EnvelopesSettings[0,0].Amplifer.Amplify:='100';
 EnvelopeSettings:=EnvelopesSettings[0,0];
 for Counter:=0 to MaxInstruments-1 do begin
  for SubCounter:=0 to MaxInstrumentEnvelopes-1 do begin
   EnvelopesSettings[Counter,SubCounter]:=EnvelopesSettings[0,0];
  end;
 end;

 PeaksEx[0]:=0;
 PeaksEx[1]:=0;
 Peaks[0]:=0;
 Peaks[1]:=0;

 MIDIDelta:=0;

 ExportTrackName:='';
 ExportAuthor:='';
 ExportComments:='';

 ColorBack:=$00202020;
 ColorTrackBack:=$00383838;
 ColorFocusedHighlight:=$007f7f7f;
 ColorDown:=$00606060;
 ColorBorder:=$00ffffff;
 ColorEditListBack:=$00404040;
 ColorEditListFocused:=$00303030;
 ColorFont:=$00ffffff;
 ColorPeakOffA:=$3f3f3f;
 ColorPeakOffB:=$5f5f5f;
 ColorPeakOffC:=$7f7f7f;
 ColorPeakOnA:=$9f9f9f;
 ColorPeakOnB:=$cfcfcf;
 ColorPeakOnC:=$ffffff;
 ColorRFactor:=72;
 ColorGFactor:=160;
 ColorBFactor:=240;

 if assigned(InstanceInfo) and assigned(InstanceInfo^.AddVSTiPlugin) then begin
  InstanceInfo^.AddVSTiPlugin(self);
 end;
end;

destructor TVSTiPlugin.Destroy;
begin
 try
  if assigned(InstanceInfo) and assigned(InstanceInfo^.RemoveVSTiPlugin) then begin
   InstanceInfo^.RemoveVSTiPlugin(self);
  end;
  if assigned(VSTEditor) then begin
   VSTEditor.Free;
   VSTEditor:=nil;
  end;
  if assigned(Buffer) then begin
   FreeMem(Buffer);
  end;
  ExportMIDIEventList.Destroy;
  AudioCriticalSection.Destroy;
  DataCriticalSection.Destroy;
  if assigned(ChunkData) then begin
   FreeMem(ChunkData);
  end;
  SynthDone(@Track);
  if assigned(InputBuffer) then begin
   freemem(InputBuffer);
  end;
 except
 end;
 inherited Destroy;
end;

function TVSTiPlugin.Dispatcher(Opcode,index:longint;Value:ptrint;Ptr:pointer;Opt:single):ptrint;
var pe:PERect;
    KeyCode:TVSTKeyCode;
begin
 result:=0;
 case Opcode of
  effOpen:begin
// Open;
  end;
  effClose:begin
// Close;
  end;
  effSetProgram:begin
   if Value<VSTNumPrograms then begin
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
   StrCopy(Ptr,'');
  end;
  effGetParamDisplay:begin
   StrCopy(Ptr,'');
  end;
  effGetParamName:begin
   StrCopy(Ptr,'');
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
   result:=0;
  end;
  effEditGetRect:begin
   if assigned(VSTEditor) then begin
    pe:=PPERect(Ptr)^;
    result:=VSTEditor.GetRect(pe);
    PPERect(Ptr)^:=pe;
   end;
  end;
  effEditOpen:begin
   if assigned(VSTEditor) then begin
    result:=VSTEditor.Open(Ptr);
   end;
  end;
  effEditClose:begin
   if assigned(VSTEditor) then begin
    VSTEditor.Close;
   end;
  end;
  effEditIdle:begin
   if assigned(VSTEditor) then begin
    VSTEditor.Idle;
   end;
  end;
  effIdentify:begin
   result:=FourCharToLong('N','v','E','f');
  end;
  effGetChunk:begin
   result:=GetChunk(ppointer(Ptr)^,(index<>0));
  end;
  effSetChunk:begin
   result:=SetChunk(Ptr,Value,(index<>0));
  end;
  effProcessEvents:begin
   result:=ProcessEvents(Ptr);
  end;
  effCanBeAutomated:begin
   result:=1;
  end;
  effString2Parameter:begin
   result:=0;
  end;
  effGetProgramNameIndexed:begin
   result:=ord(GetProgramNameIndexed(Value,index,Ptr));
  end;
  effGetNumProgramCategories:begin
   result:=1;
  end;
  effCopyProgram:begin
   result:=0;
  end;
  effConnectInput:begin
   result:=1;
  end;
  effConnectOutput:begin
   result:=1;
  end;
  effGetInputProperties:begin
   try
    if (index>=0) and (index<VSTEffect.NumOutputs) then begin
     case Index of
      0:begin
       StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' master sum left'));
       StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'MSL'));
      end;
      1:begin
       StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' master sum right'));
       StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'MSR'));
      end;
      else begin
       if (Index and 1)=0 then begin
        StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' channel #'+IntToStr(index shr 1)+' left'));
        StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'C'+IntToStr(index shr 1)+'L'));
       end else begin
        StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' channel #'+IntToStr(index shr 1)+' right'));
        StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'C'+IntToStr(index shr 1)+'R'));
       end;
      end;
     end;
     PVSTPinProperties(Ptr)^.Flags:=1{Active};
     if index<2 then begin
      PVSTPinProperties(Ptr)^.Flags:=PVSTPinProperties(Ptr)^.Flags or 2{Stereo};
     end;
     PVSTPinProperties(Ptr)^.ArrangementType:=1; // Stereo
     result:=1;
    end else begin
     result:=0;
    end;
   except
    result:=0;
   end;
  end;
  effGetOutputProperties:begin
   try
    if (index>=0) and (index<VSTEffect.NumOutputs) then begin
     case Index of
      0:begin
       StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' master sum left'));
       StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'MSL'));
      end;
      1:begin
       StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' master sum right'));
       StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'MSR'));
      end;
      else begin
       if (Index and 1)=0 then begin
        StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' channel #'+IntToStr(index shr 1)+' left'));
        StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'C'+IntToStr(index shr 1)+'L'));
       end else begin
        StrCopy(PVSTPinProperties(Ptr)^.vLabel,pchar(VSTiLabel+' channel #'+IntToStr(index shr 1)+' right'));
        StrCopy(PVSTPinProperties(Ptr)^.ShortLabel,pchar(VSTiID+'C'+IntToStr(index shr 1)+'R'));
       end;
      end;
     end;
     PVSTPinProperties(Ptr)^.Flags:=1{Active};
     if index<2 then begin
      PVSTPinProperties(Ptr)^.Flags:=PVSTPinProperties(Ptr)^.Flags or 2{Stereo};
     end;
     PVSTPinProperties(Ptr)^.ArrangementType:=1; // Stereo
     result:=1;
    end else begin
     result:=0;
    end;
   except
    result:=0;
   end;
  end;
  effGetPlugCategory:begin
   result:=2; // Synth
  end;
  effGetCurrentPosition:begin
   result:=0;
  end;
  effGetDestinationBuffer:begin
   result:=0;
  end;
  effOfflineNotify:begin
   result:=0;
  end;
  effOfflinePrepare:begin
   result:=0;
  end;
  effOfflineRun:begin
   result:=0;
  end;
  effSetSpeakerArrangement:begin
   result:=0;
  end;
  effProcessVarIo:begin
   result:=0;
  end;
  effSetBlockSizeAndSampleRate:begin
   SetBlockSizeAndSampleRate(Value,Opt);
   result:=1;
  end;
  effSetBypass:begin
   result:=0;
  end;
  effGetEffectName:begin
   StrCopy(ptr,pansichar(Software));
   result:=1;
  end;
  effGetVendorString:begin
   StrCopy(ptr,pansichar(Vendor));
   result:=1;
  end;
  effGetProductString:begin
   StrCopy(ptr,pansichar(Software));
   result:=1;
  end;
  effGetVendorVersion:begin
   result:=1;
  end;
  effVendorSpecific:begin
   result:=0;
  end;
  effCanDo:begin
   try
    if pansichar(Ptr)='receiveVstEvents' then begin
     result:=1;
    end else if pansichar(Ptr)='receiveVstMidiEvent' then begin
     result:=1;
    end else if pansichar(Ptr)='sendVstEvents' then begin
     result:=1;
    end else if pansichar(Ptr)='sendVstMidiEvent' then begin
     result:=1;
    end else begin
     result:=0;
    end;
   except
    result:=-1;
   end;
  end;
  effGetTailSize:begin
   result:=0;
  end;
  effGetErrorText:begin
   result:=0;
  end;
  effGetIcon:begin
   result:=0;
  end;
  effSetViewPosition:begin
   result:=0;
  end;
  effIdle:begin
   result:=0;
  end;
  effKeysRequired:begin
   result:=1;
  end;
  effGetParameterProperties:begin
   result:=0;
  end;
  effGetVstVersion:begin
   result:=2400;
  end;
  effEditKeyDown:begin
   if assigned(VSTEditor) then begin
    KeyCode.CharacterCode:=index;
    KeyCode.VirtualCode:=Value;
    KeyCode.ModifierCode:=Round(Opt);
    result:=0;
   end;
  end;
  effEditKeyUp:begin
   if assigned(VSTEditor) then begin
    KeyCode.CharacterCode:=index;
    KeyCode.VirtualCode:=Value;
    KeyCode.ModifierCode:=Round(Opt);
    result:=0;
   end;
  end;
  effSetEditKnobMode:begin
   if assigned(VSTEditor) then begin
    result:=0;
   end;
  end;
  effGetMidiProgramName:begin
   result:=0;
  end;
  effGetCurrentMidiProgram:begin
   result:=-1;
  end;
  effGetMidiProgramCategory:begin
   result:=0;
  end;
  effHasMidiProgramsChanged:begin
   result:=0;
  end;
  effGetMidiKeyName:begin
   result:=0;
  end;
  effBeginSetProgram:begin
   result:=0;
  end;
  effEndSetProgram:begin
   result:=0;
  end;
  effGetSpeakerArrangement:begin
   PPointer(Value)^:=nil;
   PPointer(Ptr)^:=nil;
   result:=0;
  end;
  effSetTotalSampleToProcess:begin
   result:=Value;
  end;
  effShellGetNextPlugin:begin
   StrCopy(Ptr,'');
   result:=0;
  end;
  effStartProcess:begin
   result:=0;
  end;
  effStopProcess:begin
   result:=0;
  end;
  effSetPanLaw:begin
   result:=0;
  end;
  effBeginLoadBank:begin
   result:=0;
  end;
  effBeginLoadProgram:begin
   result:=0;
  end;
  effSetProcessPrecision:begin
   result:=0;
  end;
  effGetNumMidiInputChannels:begin
   result:=0;
  end;
  effGetNumMidiOutputChannels:begin
   result:=0;
  end;
 end;
end;

procedure TVSTiPlugin.ChangeProgramText(ProgramNr:integer);
begin
{CriticalSection.Enter;
 SpeechConvertPhonemsToSegmentList(Programs[ProgramNr AND $7F].SegmentList,SpeechConvertTextToPhonems(@SpeechGermanRules,Programs[ProgramNr AND $7F].Text,Programs[ProgramNr AND $7F].TextLanguage=1));
 CriticalSection.Leave;}
end;

procedure TVSTiPlugin.ChangeProgram(ChannelIndex,ProgramNr:integer);
begin
{CriticalSection.Enter;
 try
  ChangeProgramText(ProgramNr);
//SpeechReset(Channels[ChannelIndex].SpeechInstance);
 except
 end;
 CriticalSection.Leave;}
end;

procedure TVSTiPlugin.ProcessEx(Input,Output:pointer;Samples:longint;Replace,UseDoubles:boolean);
var ChannelCounter,SampleCounter:integer;
    Buffer:PSynthBufferSample;
    SrcSample,DestSample:psingle;
    SrcSample64,DestSample64:pdouble;
    Value,ibs:single;
    t1,t2,tf:int64;
    OldFCW:word;
begin
 asm
  fstcw word Ptr OldFCW
  fldcw word Ptr SynthFCW
 end;
 try
  AudioCriticalSection.Enter;
  try
   begin
    if assigned(VSTEditor) and assigned(VSTEditor.Editor) then begin
     Track.ScanPeaks:=VSTEditor.Editor.PanelTopViewMode=1;
    end;
    if ExportMIDIDoRecord then begin
     inc(ExportMIDIPosition,Samples);
    end;
    if (OldSampleRate<>SampleRate) or (OldBufferSize<>BufferSize) then begin
     OldSampleRate:=SampleRate;
     OldBufferSize:=BufferSize;
     SynthReinit(@Track,SoftTRUNC(SampleRate),BufferSize*2);
     if assigned(InputBuffer) then begin
      freemem(InputBuffer);
     end;
     getmem(InputBuffer,BufferSize*2*sizeof(TSynthBufferSample));
    end;
    if BufferSize>0 then begin
     ibs:=1.0-exp(-1.0/BufferSize);
     if Track.OversamplingFactor>1 then begin
      Track.ScanPeakFactor:=1.0-exp(-1.0/(BufferSize*Track.OversamplingFactor));
     end else begin
      Track.ScanPeakFactor:=ibs;
     end;
    end else begin
     ibs:=1.0;
     Track.ScanPeakFactor:=1;
    end;
    try
     if UseDoubles then begin
      for ChannelCounter:=0 to 1 do begin
       Buffer:=InputBuffer;
       SrcSample64:=pointer(PPDouble(longword(longword(Input)+longword(sizeof(pdouble)*ChannelCounter)))^);
       if assigned(SrcSample64) then begin
        for SampleCounter:=1 to Samples do begin
         Value:=SrcSample64^;
         longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
         Buffer^.Channel[ChannelCounter]:=Value;
         inc(Buffer);
         inc(SrcSample64);
        end;
       end else begin
        for SampleCounter:=1 to Samples do begin
         Buffer^.Channel[ChannelCounter]:=0;
         inc(Buffer);
        end;
       end;
      end;
     end else begin
      for ChannelCounter:=0 to 1 do begin
       Buffer:=InputBuffer;
       SrcSample:=pointer(PPSINGLE(longword(longword(Input)+longword(sizeof(psingle)*ChannelCounter)))^);
       if assigned(SrcSample) then begin
        for SampleCounter:=1 to Samples do begin
         Value:=SrcSample^;
         longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
         Buffer^.Channel[ChannelCounter]:=Value;
         inc(Buffer);
         inc(SrcSample);
        end;
       end else begin
        for SampleCounter:=1 to Samples do begin
         Buffer^.Channel[ChannelCounter]:=0;
         inc(Buffer);
        end;
       end;
      end;
     end;
    except
     fillchar(InputBuffer^,Samples*2*sizeof(single),#0);
    end;
   end;
   try
    Track.DoAudioProcessing:=DoOutputAudio;
    QueryPerformanceFrequency(tf);
    QueryPerformanceCounter(t1);
    Track.Master:=TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0])=self;
    SynthFillBuffer(@Track,Samples,InputBuffer);
    QueryPerformanceCounter(t2);
    if tf=0 then begin
     tf:=1;
    end;
    CPUTime:=((abs(t2-t1)/tf)*100)/(Samples*InvSampleRate);
   except
   end;
  finally
   AudioCriticalSection.Leave;
  end;
  begin
   if not DoOutputAudio then begin
    fillchar(Track.Buffer^,Samples*2*sizeof(single),#0);
   end;
   if UseDoubles then begin
    for ChannelCounter:=0 to 1 do begin
     Buffer:=Track.Buffer;
     DestSample64:=pointer(PPDOUBLE(longword(longword(Output)+longword(sizeof(pdouble)*ChannelCounter)))^);
     if Replace then begin
      for SampleCounter:=1 to Samples do begin
       Value:=Buffer^.Channel[ChannelCounter];
       longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       PeaksEx[ChannelCounter]:=PeaksEx[ChannelCounter]+((sqr(Value)-PeaksEx[ChannelCounter])*ibs);
       longword(pointer(@PeaksEx[ChannelCounter])^):=longword(pointer(@PeaksEx[ChannelCounter])^) and longword($ffffffff+longword(((((longword(pointer(@PeaksEx[ChannelCounter])^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       DestSample64^:=Value;
       inc(Buffer);
       inc(DestSample64);
      end;
     end else begin
      for SampleCounter:=1 to Samples do begin
       Value:=Buffer^.Channel[ChannelCounter];
       longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       PeaksEx[ChannelCounter]:=PeaksEx[ChannelCounter]+((sqr(Value)-PeaksEx[ChannelCounter])*ibs);
       longword(pointer(@PeaksEx[ChannelCounter])^):=longword(pointer(@PeaksEx[ChannelCounter])^) and longword($ffffffff+longword(((((longword(pointer(@PeaksEx[ChannelCounter])^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       DestSample64^:=DestSample64^+Value;
       inc(Buffer);
       inc(DestSample64);
      end;
     end;
    end;
{$ifdef MultiOutput}
    for ChannelCounter:=2 to VSTEffect.NumOutputs-1 do begin
     if ((ChannelCounter-2) shr 1) in [0..15] then begin
      DestSample64:=pointer(PPDOUBLE(longword(longword(Output)+longword(sizeof(pdouble)*ChannelCounter)))^);
      if Track.Channels[(ChannelCounter-2) shr 1].HasBuffer then begin
       Buffer:=Track.ChannelBuffer[(ChannelCounter-2) shr 1];
       if Replace then begin
        for SampleCounter:=1 to Samples do begin
         Value:=Buffer^.Channel[(ChannelCounter-2) and 1];
         longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
         DestSample64^:=Value;
         inc(Buffer);
         inc(DestSample64);
        end;
       end else begin
        for SampleCounter:=1 to Samples do begin
         Value:=Buffer^.Channel[(ChannelCounter-2) and 1];
         longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
         DestSample64^:=DestSample64^+Value;
         inc(Buffer);
         inc(DestSample64);
        end;
       end;
      end else begin
       if Replace then begin
        for SampleCounter:=1 to Samples do begin
         DestSample64^:=0;
         inc(DestSample64);
        end;
       end;
      end;
     end;
    end;
{$endif}
   end else begin
    for ChannelCounter:=0 to 1 do begin
     Buffer:=Track.Buffer;
     DestSample:=pointer(PPSINGLE(longword(longword(Output)+longword(sizeof(psingle)*ChannelCounter)))^);
     if Replace then begin
      for SampleCounter:=1 to Samples do begin
       Value:=Buffer^.Channel[ChannelCounter];
       longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       PeaksEx[ChannelCounter]:=PeaksEx[ChannelCounter]+((sqr(Value)-PeaksEx[ChannelCounter])*ibs);
       longword(pointer(@PeaksEx[ChannelCounter])^):=longword(pointer(@PeaksEx[ChannelCounter])^) and longword($ffffffff+longword(((((longword(pointer(@PeaksEx[ChannelCounter])^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       DestSample^:=Value;
       inc(Buffer);
       inc(DestSample);
      end;
     end else begin
      for SampleCounter:=1 to Samples do begin
       Value:=Buffer^.Channel[ChannelCounter];
       longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       PeaksEx[ChannelCounter]:=PeaksEx[ChannelCounter]+((sqr(Value)-PeaksEx[ChannelCounter])*ibs);
       longword(pointer(@PeaksEx[ChannelCounter])^):=longword(pointer(@PeaksEx[ChannelCounter])^) and longword($ffffffff+longword(((((longword(pointer(@PeaksEx[ChannelCounter])^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       DestSample^:=DestSample^+Value;
       longword(pointer(@DestSample)^):=longword(pointer(@DestSample)^) and longword($ffffffff+longword(((((longword(pointer(@DestSample)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
       inc(Buffer);
       inc(DestSample);
      end;
     end;
    end;
{$ifdef MultiOutput}
    for ChannelCounter:=2 to VSTEffect.NumOutputs-1 do begin
     if ((ChannelCounter-2) shr 1)<NumberOfChannels then begin
      DestSample:=pointer(PPSINGLE(longword(longword(Output)+longword(sizeof(psingle)*ChannelCounter)))^);
      if Track.Channels[(ChannelCounter-2) shr 1].HasBuffer then begin
       Buffer:=Track.ChannelBuffer[(ChannelCounter-2) shr 1];
       if Replace then begin
        for SampleCounter:=1 to Samples do begin
         DestSample^:=Buffer^.Channel[(ChannelCounter-2) and 1];
         longword(pointer(DestSample)^):=longword(pointer(DestSample)^) and longword($ffffffff+longword(((((longword(pointer(DestSample)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
         inc(Buffer);
         inc(DestSample);
        end;
       end else begin
        for SampleCounter:=1 to Samples do begin
         Value:=Buffer^.Channel[(ChannelCounter-2) and 1];
         longword(pointer(@Value)^):=longword(pointer(@Value)^) and longword($ffffffff+longword(((((longword(pointer(@Value)^) and $7f800000)+$800000) and $7f800000)-$1000000) shr 31));
         DestSample^:=DestSample^+Value;
         inc(Buffer);
         inc(DestSample);
        end;
       end;
      end else begin
       if Replace then begin
        for SampleCounter:=1 to Samples do begin
         DestSample^:=0;
         inc(DestSample);
        end;
       end;
      end;
     end;
    end;
{$endif}
   end;
  end;
  InterlockedExchange(longint(pointer(@Peaks[0])^),longint(pointer(@PeaksEx[0])^));
  InterlockedExchange(longint(pointer(@Peaks[1])^),longint(pointer(@PeaksEx[1])^));
  if (assigned(VSTEditor) and assigned(VSTEditor.Editor)) and (VSTEditor.Editor.PanelTopViewMode in [2..6]) then begin
   OscilBufferMasterIndex:=OscilBufferMasterIndex and OscilBufferMasterMask;
   OscilBufferIndex:=OscilBufferIndex and OscilBufferMask;
   for SampleCounter:=0 to Samples-1 do begin
    OscilBufferEx[0,OscilBufferIndex]:=PSynthBufferSamples(Track.Buffer)^[SampleCounter].Left;
    OscilBufferEx[1,OscilBufferIndex]:=PSynthBufferSamples(Track.Buffer)^[SampleCounter].Right;
    OscilBufferIndex:=(OscilBufferIndex+1) and OscilBufferMask;
    if OscilBufferIndex=0 then begin
     OscilBuffer[OscilBufferMasterIndex]:=OscilBufferEx;
     InterlockedExchange(OscilBufferReadyIndex,OscilBufferMasterIndex);
     OscilBufferMasterIndex:=(OscilBufferMasterIndex+1) and OscilBufferMasterMask;
     break;
    end;
   end;
  end;
 finally
  asm
   fldcw word Ptr OldFCW
  end;
 end;
end;

procedure TVSTiPlugin.Process(Input,Output:PPSINGLE;Samples:longint);
begin
 ProcessEx(Input,Output,Samples,false,false);
end;

procedure TVSTiPlugin.ProcessReplacing(Input,Output:PPSINGLE;Samples:longint);
begin
 ProcessEx(Input,Output,Samples,true,false);
end;

procedure TVSTiPlugin.ProcessDoubleReplacing(Input,Output:PPDouble;Samples:longint);
begin
 ProcessEx(Input,Output,Samples,true,true);
end;

procedure TVSTiPlugin.SetProgram(AProgram:longint);
begin
 try
  if (AProgram>=0) and (AProgram<VSTiNumPrograms) then begin
   DataCriticalSection.Enter;
   try
    CurrentProgram:=AProgram;
    ChangeProgram(0,CurrentProgram);
   finally
    DataCriticalSection.Leave;
   end;
   VSTEditor.Update;
  end;
 except
 end;
end;

function TVSTiPlugin.GetProgram:longint;
begin
 try
  result:=CurrentProgram;
 except
  result:=0;
 end;
end;

procedure TVSTiPlugin.SetProgramName(name:pchar);
begin
 try
  ProgramNames[CurrentProgram and $7f]:=name;
  VSTEditor.Update;
 except
 end;
end;

procedure TVSTiPlugin.GetProgramName(name:pchar);
begin
 try
  StrCopy(name,pchar(ProgramNames[CurrentProgram and $7f]));
 except
 end;
end;

procedure TVSTiPlugin.SetParameterEx(index:longint;Value:byte);
begin
 {}
end;

procedure TVSTiPlugin.SetParameter(index:longint;Value:single);
begin
 try
  if (index>=0) and (index<VSTiNumPrograms) then begin
   SetParameterEx(index,FTRUNC(Value*127));
  end;
 except
 end;
end;

function TVSTiPlugin.GetParameter(index:longint):single;
begin
 result:=0;
end;

function TVSTiPlugin.ProcessEvents(Events:PVSTEvents):longint;
var EventCounter:integer;
    Event:PVSTMIDIEvent;
    SysExEvent:PVSTMIDISysExEvent;
    SynthEvent:TSynthEvent;
    MIDIEventItem:TMIDIEvent;
    p:int64;
begin
 AudioCriticalSection.Enter;
 try
  for EventCounter:=0 to Events^.numEvents-1 do begin
   case Events^.events[EventCounter].vtype of
    1{MIDIType}:begin
     Event:=PVSTMIDIEvent(Events^.events[EventCounter]);
     if not (Event^.mididata[0] in [$f0,$f7]) then begin
      FILLCHAR(SynthEvent,sizeof(TSynthEvent),#0);
      SynthEvent.Time:=Event^.deltaFrames;
      SynthEvent.ID:=MIDIID;
      SynthEvent.Command:=Event^.mididata[0];
      SynthEvent.Data[1]:=Event^.mididata[1];
      SynthEvent.Data[2]:=Event^.mididata[2];
      SynthEvent.Data[3]:=Event^.mididata[3];
      SynthEvent.Data[4]:=0;
      SynthEvent.SysEx:=nil;
      SynthEvent.SysExLen:=0;
      SynthAddEvent(@Track,@SynthEvent);
      inc(MIDIID);
      if ExportMIDIDoRecord then begin
       MIDIEventItem:=TMIDIEvent.Create;
       p:=ExportMIDIPosition+Event^.deltaFrames;
       if ExportMIDISampleRate<>SoftTRUNC(SampleRate+0.5) then begin
        p:=(p*ExportMIDISampleRate) div SoftTRUNC(SampleRate+0.5);
       end;
       MIDIEventItem.DeltaFrames:=p;
       MIDIEventItem.ID:=ExportMIDIID;
       MIDIEventItem.MIDIData[0]:=Event^.mididata[0];
       MIDIEventItem.MIDIData[1]:=Event^.mididata[1];
       MIDIEventItem.MIDIData[2]:=Event^.mididata[2];
       MIDIEventItem.MIDIData[3]:=Event^.mididata[3];
       MIDIEventItem.MIDIData[4]:=0;
       MIDIEventItem.SysEx:=nil;
       MIDIEventItem.SysExLen:=0;
       ExportMIDIEventList.Add(MIDIEventItem);
       inc(ExportMIDIID);
      end;
     end;
    end;
    6{SysExType}:begin
     SysExEvent:=PVSTMIDISysExEvent(Events^.events[EventCounter]);
     FILLCHAR(SynthEvent,sizeof(TSynthEvent),#0);
     SynthEvent.Time:=SysExEvent^.deltaFrames;
     SynthEvent.ID:=MIDIID;
     SynthEvent.Command:=$f0;
     if assigned(SysExEvent^.SysExDump) and (SysExEvent^.DumpBytes>0) then begin
      SynthEvent.SysEx:=SysExEvent.SysExDump;
      SynthEvent.SysExLen:=SysExEvent^.DumpBytes;
     end else begin
      SynthEvent.SysEx:=nil;
      SynthEvent.SysExLen:=0;
     end;
     SynthAddEvent(@Track,@SynthEvent);
     inc(MIDIID);
     if ExportMIDIDoRecord then begin
      MIDIEventItem:=TMIDIEvent.Create;
      p:=ExportMIDIPosition+SysExEvent^.deltaFrames;
      if ExportMIDISampleRate<>SoftTRUNC(SampleRate+0.5) then begin
       p:=(p*ExportMIDISampleRate) div SoftTRUNC(SampleRate+0.5);
      end;
      MIDIEventItem.DeltaFrames:=p;
      MIDIEventItem.ID:=ExportMIDIID;
      MIDIEventItem.MIDIData[0]:=$f0;
      MIDIEventItem.MIDIData[1]:=0;
      MIDIEventItem.MIDIData[2]:=0;
      MIDIEventItem.MIDIData[3]:=0;
      MIDIEventItem.MIDIData[4]:=0;
      if assigned(SysExEvent^.SysExDump) and (SysExEvent^.DumpBytes>0) then begin
       MIDIEventItem.SysEx:=nil;
       MIDIEventItem.SysExLen:=SysExEvent^.DumpBytes;
       GetMem(MIDIEventItem.SysEx,MIDIEventItem.SysExLen);
       Move(SysExEvent.SysExDump^,MIDIEventItem.SysEx^,MIDIEventItem.SysExLen);
      end else begin
       MIDIEventItem.SysEx:=nil;
       MIDIEventItem.SysExLen:=0;
      end;
      ExportMIDIEventList.Add(MIDIEventItem);
      inc(ExportMIDIID);
     end;
    end;
   end;
  end;
 finally
  AudioCriticalSection.Leave;
 end;
 result:=1;
end;

procedure TVSTiPlugin.Resume;
begin
 try
  PeaksEx[0]:=0;
  PeaksEx[1]:=0;
  Peaks[0]:=0;
  Peaks[1]:=0;
  if assigned(VSTAudioMaster) then begin
   VSTAudioMaster(@VSTEffect,audioMasterWantMidi,0,1,nil,0);
  end;
  MIDIID:=0;
 except
 end;
end;

procedure TVSTiPlugin.Suspend;
begin
end;

function TVSTiPlugin.GetProgramNameIndexed(Category,index:longint;Text:pchar):boolean;
begin
 try
  if index in [$00..VSTiNumPrograms-1] then begin
   StrCopy(Text,''{PCHAR(Programs[Index].Name)});
   result:=true;
  end else begin
   StrCopy(Text,'');
   result:=false;
  end;
 except
  result:=false;
 end;
end;

procedure TVSTiPlugin.SetSampleRate(ASampleRate:single);
begin
 VSTSampleRate:=ASampleRate;
 AudioCriticalSection.Enter;
 try
  SampleRate:=ASampleRate;
  if SampleRate>1 then begin
   InvSampleRate:=1/SampleRate;
  end else begin
   InvSampleRate:=1;
  end;
  if (OldSampleRate<>SampleRate) or (OldBufferSize<>BufferSize) then begin
   OldSampleRate:=SampleRate;
   OldBufferSize:=BufferSize;
   SynthReinit(@Track,SoftTRUNC(SampleRate+0.5),BufferSize*2);
   if assigned(InputBuffer) then begin
    FreeMem(InputBuffer);
   end;
   GetMem(InputBuffer,BufferSize*2*sizeof(TSynthBufferSample));
  end;
 finally
  AudioCriticalSection.Leave;
 end;
end;

procedure TVSTiPlugin.SetBlockSize(ABlockSize:longint);
begin
 VSTBlockSize:=ABlockSize;
 AudioCriticalSection.Enter;
 try
  BufferSize:=ABlockSize;
  if (OldSampleRate<>SampleRate) or (OldBufferSize<>BufferSize) then begin
   OldSampleRate:=SampleRate;
   OldBufferSize:=BufferSize;
   SynthReinit(@Track,SoftTRUNC(SampleRate+0.5),BufferSize*2);
   if assigned(InputBuffer) then begin
    FreeMem(InputBuffer);
   end;
   GetMem(InputBuffer,BufferSize*2*sizeof(TSynthBufferSample));
  end;
 finally
  AudioCriticalSection.Leave;
 end;
end;

procedure TVSTiPlugin.SetBlockSizeAndSampleRate(ABlockSize:longint;ASampleRate:single);
begin
 VSTSampleRate:=ASampleRate;
 VSTBlockSize:=ABlockSize;
 AudioCriticalSection.Enter;
 try
  BufferSize:=ABlockSize;
  SampleRate:=ASampleRate;
  if (OldSampleRate<>SampleRate) or (OldBufferSize<>BufferSize) then begin
   OldSampleRate:=SampleRate;
   OldBufferSize:=BufferSize;
   SynthReinit(@Track,SoftTRUNC(SampleRate+0.5),BufferSize*2);
   if assigned(InputBuffer) then begin
    freemem(InputBuffer);
   end;
   getmem(InputBuffer,BufferSize*2*sizeof(TSynthBufferSample));
  end;
 finally
  AudioCriticalSection.Leave;
 end;
end;

function TVSTiPlugin.GetPluginEditor:TVSTiPluginEditor;
begin
 result:=VSTEditor;
end;

function TVSTiPlugin.GetChunk(var Data:pointer;IsPreset:boolean):longint;
var Stream:TBeRoMemoryStream;
    MainStorage,MainSubStorage,
    MainSubSubStorage:TBeRoTinyFlexibleDataStorageList;
    ChunkDataEx,ChunkDataEx2:pointer;
    CompressionAlgo:byte;
    Size,NewSize,NewNewSize:longint;
 procedure WriteProgram(ProgramNr:byte);
 var PrgStorage,SubStorage,SubSubStorage,
     SubSubSubStorage:TBeRoTinyFlexibleDataStorageList;
     HarmonicsStream:TBeRoStream;
     Instrument:PSynthInstrument;
     Counter:integer;
     p:pointer;
 begin
  Instrument:=@Track.Instruments[ProgramNr];

  PrgStorage:=TBeRoTinyFlexibleDataStorageList.Create;

  PrgStorage.Add('NAME',STRINGToStorageValue(ProgramNames[ProgramNr]));

  PrgStorage.Add('VOLU',BYTEToStorageValue(Instrument^.Volume));
  PrgStorage.Add('TRPO',SHORTINTToStorageValue(Instrument^.Transpose));

  PrgStorage.Add('C7BF',UINTToStorageValue(Instrument^.Controller7BitFlags));

  PrgStorage.Add('CHVO',BYTEToStorageValue(Instrument^.ChannelVolume));
  PrgStorage.Add('MAPO',BYTEToStorageValue(Instrument^.MaxPolyphony));
  PrgStorage.Add('GLOU',BYTEToStorageValue(Instrument^.GlobalOutput));
  PrgStorage.Add('GLRE',BYTEToStorageValue(Instrument^.GlobalReverb));
  PrgStorage.Add('GLDE',BYTEToStorageValue(Instrument^.GlobalDelay));
  PrgStorage.Add('GLCF',BYTEToStorageValue(Instrument^.GlobalChorusFlanger));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('MOMA',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ICNT',BYTEToStorageValue(Instrument^.ModulationMatrixItems));
  for Counter:=0 to Instrument^.ModulationMatrixItems-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
   SubSubStorage.Add('SRCM',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].Source));
   SubSubStorage.Add('SRCI',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].SourceIndex));
   SubSubStorage.Add('SRFL',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].SourceFlags));
   SubSubStorage.Add('SRMO',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].SourceMode));
   SubSubStorage.Add('TRGM',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].Target));
   SubSubStorage.Add('TRGI',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].TargetIndex));
   SubSubStorage.Add('POLA',BYTEToStorageValue(Instrument^.ModulationMatrix[Counter].Polarity));
   SubSubStorage.Add('AMOU',SHORTINTToStorageValue(Instrument^.ModulationMatrix[Counter].Amount));
   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('TUTA',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('USEI',BOOLEANToStorageValue(Instrument^.UseTuningTable));
  getmem(p,sizeof(TSynthTuningTable));
  move(Instrument^.TuningTable,p^,sizeof(TSynthTuningTable));
  SubStorage.Add('DATA',DATATOStorageValue(p,sizeof(TSynthTuningTable)));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('OSCI',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentOscillator-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
   SubSubStorage.Add('NOBE',BYTEToStorageValue(Instrument^.Oscillator[Counter].NoteBegin));
   SubSubStorage.Add('NOEN',BYTEToStorageValue(Instrument^.Oscillator[Counter].NoteEnd));
   SubSubStorage.Add('WAFO',BYTEToStorageValue(Instrument^.Oscillator[Counter].WaveForm));
   SubSubStorage.Add('FEBA',SMALLINTToStorageValue(Instrument^.Oscillator[Counter].FeedBack));
   SubSubStorage.Add('COLO',SHORTINTToStorageValue(Instrument^.Oscillator[Counter].Color));
   SubSubStorage.Add('TRPO',SHORTINTToStorageValue(Instrument^.Oscillator[Counter].Transpose));
   SubSubStorage.Add('FITU',SHORTINTToStorageValue(Instrument^.Oscillator[Counter].FineTune));
   SubSubStorage.Add('PHST',BYTEToStorageValue(Instrument^.Oscillator[Counter].PhaseStart));
   SubSubStorage.Add('SYTY',BYTEToStorageValue(Instrument^.Oscillator[Counter].SynthesisType));
   SubSubStorage.Add('VOLU',BYTEToStorageValue(Instrument^.Oscillator[Counter].Volume));
   SubSubStorage.Add('HASY',BOOLEANToStorageValue(Instrument^.Oscillator[Counter].HardSync));
   SubSubStorage.Add('GLID',BYTEToStorageValue(Instrument^.Oscillator[Counter].Glide));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.Oscillator[Counter].Carry));
   SubSubStorage.Add('PFEM',BOOLEANToStorageValue(Instrument^.Oscillator[Counter].PMFMExtendedMode));
   SubSubStorage.Add('RAPA',BOOLEANToStorageValue(Instrument^.Oscillator[Counter].RandomPhase));
   SubSubStorage.Add('USPA',BOOLEANToStorageValue(Instrument^.Oscillator[Counter].UsePanning));
   SubSubStorage.Add('PANN',SHORTINTToStorageValue(Instrument^.Oscillator[Counter].Panning));
   SubSubStorage.Add('OUPU',BOOLEANToStorageValue(Instrument^.Oscillator[Counter].Output));
   SubSubStorage.Add('INPU',SHORTINTToStorageValue(Instrument^.Oscillator[Counter].Input));
   SubSubStorage.Add('HSIP',SHORTINTToStorageValue(Instrument^.Oscillator[Counter].HardSyncInput));
   SubSubStorage.Add('PSDM',BYTEToStorageValue(Instrument^.Oscillator[Counter].PluckedStringDelayLineMode));
   SubSubStorage.Add('PSDW',BYTEToStorageValue(Instrument^.Oscillator[Counter].PluckedStringDelayLineWidth));
   SubSubStorage.Add('PSRE',BYTEToStorageValue(Instrument^.Oscillator[Counter].PluckedStringReflection));
   SubSubStorage.Add('PSPI',BYTEToStorageValue(Instrument^.Oscillator[Counter].PluckedStringPick));
   SubSubStorage.Add('PSPU',BYTEToStorageValue(Instrument^.Oscillator[Counter].PluckedStringPickUp));
   SubSubStorage.Add('SOWF',BYTEToStorageValue(Instrument^.Oscillator[Counter].SuperOscWaveform));
   SubSubStorage.Add('SOMO',BYTEToStorageValue(Instrument^.Oscillator[Counter].SuperOscMode));
   SubSubStorage.Add('SOCO',BYTEToStorageValue(Instrument^.Oscillator[Counter].SuperOscCount));
   SubSubStorage.Add('SODT',BYTEToStorageValue(Instrument^.Oscillator[Counter].SuperOscDetune));
   SubSubStorage.Add('SOMX',BYTEToStorageValue(Instrument^.Oscillator[Counter].SuperOscMix));
   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('ADSR',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentADSR-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
   SubSubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ADSR[Counter].Active));

   SubSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
   SubSubStorage.Add('MODE',STORAGEToStorageValue(SubSubSubStorage));
   SubSubSubStorage.Add('ATTA',BYTEToStorageValue(Instrument^.ADSR[Counter].Modes[esATTACK]));
   SubSubSubStorage.Add('DECA',BYTEToStorageValue(Instrument^.ADSR[Counter].Modes[esDECAY]));
   SubSubSubStorage.Add('SUST',BYTEToStorageValue(Instrument^.ADSR[Counter].Modes[esSUSTAIN]));
   SubSubSubStorage.Add('RELE',BYTEToStorageValue(Instrument^.ADSR[Counter].Modes[esRELEASE]));

   SubSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
   SubSubStorage.Add('TIME',STORAGEToStorageValue(SubSubSubStorage));
   SubSubSubStorage.Add('ATTA',BYTEToStorageValue(Instrument^.ADSR[Counter].Times[esATTACK]));
   SubSubSubStorage.Add('DECA',BYTEToStorageValue(Instrument^.ADSR[Counter].Times[esDECAY]));
   SubSubSubStorage.Add('SUST',BYTEToStorageValue(Instrument^.ADSR[Counter].Times[esSUSTAIN]));
   SubSubSubStorage.Add('RELE',BYTEToStorageValue(Instrument^.ADSR[Counter].Times[esRELEASE]));

   SubSubStorage.Add('DELE',BYTEToStorageValue(Instrument^.ADSR[Counter].TargetDecayLevel));
   SubSubStorage.Add('AMPL',BYTEToStorageValue(Instrument^.ADSR[Counter].Amplify));

   SubSubStorage.Add('ACCH',BOOLEANToStorageValue(Instrument^.ADSR[Counter].ActiveCheck));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.ADSR[Counter].Carry));
   SubSubStorage.Add('CENT',BOOLEANToStorageValue(Instrument^.ADSR[Counter].Centerise));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('ENVE',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentEnvelopes-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.Envelope[Counter].Active));
   SubSubStorage.Add('AMPL',BYTEToStorageValue(Instrument^.Envelope[Counter].Amplify));
   SubSubStorage.Add('ACCH',BOOLEANToStorageValue(Instrument^.Envelope[Counter].ActiveCheck));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.Envelope[Counter].Carry));
   SubSubStorage.Add('CENT',BOOLEANToStorageValue(Instrument^.Envelope[Counter].Centerise));

   begin
    SubSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    SubSubStorage.Add('DATA',STORAGEToStorageValue(SubSubSubStorage));
    SubSubSubStorage.Add('NAME',STRINGToStorageValue(EnvelopeNames[ProgramNr,Counter]));
    SubSubSubStorage.Add('NOCO',WORDTOStorageValue(Track.Envelopes[ProgramNr,Counter].NodesCount));
    if Track.Envelopes[ProgramNr,Counter].NodesCount>0 then begin
     SubSubSubStorage.Add('NODE',FIXEDDATATOStorageValue(Track.Envelopes[ProgramNr,Counter].Nodes,Track.Envelopes[ProgramNr,Counter].NodesCount*sizeof(TSynthEnvelopeNode)));
    end;
    SubSubSubStorage.Add('NEGV',BYTETOStorageValue(Track.Envelopes[ProgramNr,Counter].NegValue));
    SubSubSubStorage.Add('POSV',BYTETOStorageValue(Track.Envelopes[ProgramNr,Counter].PosValue));
    SubSubSubStorage.Add('LOST',SHORTINTTOStorageValue(Track.Envelopes[ProgramNr,Counter].LoopStart));
    SubSubSubStorage.Add('LOEN',SHORTINTTOStorageValue(Track.Envelopes[ProgramNr,Counter].LoopEnd));
    SubSubSubStorage.Add('SLST',SHORTINTTOStorageValue(Track.Envelopes[ProgramNr,Counter].SustainLoopStart));
    SubSubSubStorage.Add('SLEN',SHORTINTTOStorageValue(Track.Envelopes[ProgramNr,Counter].SustainLoopEnd));
    SubSubSubStorage.Add('GAAT',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.Attack));
    SubSubSubStorage.Add('GADE',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.Decay));
    SubSubSubStorage.Add('GASH',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.SustainHold));
    SubSubSubStorage.Add('GARE',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.Release));
    SubSubSubStorage.Add('GAEA',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.Amplify));
    SubSubSubStorage.Add('GASL',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.SustainLevel));
    SubSubSubStorage.Add('GASU',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].ADSR.Sustain));
    SubSubSubStorage.Add('GTS0',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[0]));
    SubSubSubStorage.Add('GTS1',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[1]));
    SubSubSubStorage.Add('GTS2',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[2]));
    SubSubSubStorage.Add('GTS3',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[3]));
    SubSubSubStorage.Add('GTS4',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[4]));
    SubSubSubStorage.Add('GTS5',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[5]));
    SubSubSubStorage.Add('GTS6',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[6]));
    SubSubSubStorage.Add('GTS7',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[7]));
    SubSubSubStorage.Add('GTS8',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[8]));
    SubSubSubStorage.Add('GTS9',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[9]));
    SubSubSubStorage.Add('GTSA',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[10]));
    SubSubSubStorage.Add('GTSB',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[11]));
    SubSubSubStorage.Add('GTSC',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[12]));
    SubSubSubStorage.Add('GTSD',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[13]));
    SubSubSubStorage.Add('GTSE',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[14]));
    SubSubSubStorage.Add('GTSF',BOOLEANTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Steps[15]));
    SubSubSubStorage.Add('GTON',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.OnAmp));
    SubSubSubStorage.Add('GTOF',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.OffAmp));
    SubSubSubStorage.Add('GTBP',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.BPM));
    SubSubSubStorage.Add('GTNL',INTTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.NoteLength));
    SubSubSubStorage.Add('GTDO',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].TranceGate.Dots));
    SubSubSubStorage.Add('GAAM',STRINGTOStorageValue(EnvelopesSettings[ProgramNr,Counter].Amplifer.Amplify));

    SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
   end;
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('LFOS',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentLFO-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('WAFO',BYTEToStorageValue(Instrument^.LFO[Counter].WaveForm));
   SubSubStorage.Add('SAMP',BYTEToStorageValue(Instrument^.LFO[Counter].Sample));
   SubSubStorage.Add('RATE',BYTEToStorageValue(Instrument^.LFO[Counter].Rate));
   SubSubStorage.Add('DEPT',BYTEToStorageValue(Instrument^.LFO[Counter].Depth));
   SubSubStorage.Add('MIDD',SHORTINTToStorageValue(Instrument^.LFO[Counter].Middle));
   SubSubStorage.Add('SWEE',BYTEToStorageValue(Instrument^.LFO[Counter].Sweep));
   SubSubStorage.Add('PHST',BYTEToStorageValue(Instrument^.LFO[Counter].PhaseStart));
   SubSubStorage.Add('AMPL',BOOLEANToStorageValue(Instrument^.LFO[Counter].Amp));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.LFO[Counter].Carry));
   SubSubStorage.Add('PHSY',BYTEToStorageValue(Instrument^.LFO[Counter].PhaseStart));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('FILT',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentFilter-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('MODE',BYTEToStorageValue(Instrument^.Filter[Counter].Mode));
   SubSubStorage.Add('CUTO',BYTEToStorageValue(Instrument^.Filter[Counter].CutOff));
   SubSubStorage.Add('RESO',BYTEToStorageValue(Instrument^.Filter[Counter].Resonance));
   SubSubStorage.Add('VOLU',BYTEToStorageValue(Instrument^.Filter[Counter].Volume));
   SubSubStorage.Add('AMPL',SHORTINTToStorageValue(Instrument^.Filter[Counter].Amplify));
   SubSubStorage.Add('CASC',BOOLEANToStorageValue(Instrument^.Filter[Counter].Cascaded));
   SubSubStorage.Add('CHAI',BOOLEANToStorageValue(Instrument^.Filter[Counter].Chain));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.Filter[Counter].Carry));
   SubSubStorage.Add('MIHZ',WORDToStorageValue(Instrument^.Filter[Counter].MinHz));
   SubSubStorage.Add('MAHZ',WORDToStorageValue(Instrument^.Filter[Counter].MaxHz));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('VODS',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentDistortion-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('MODE',BYTEToStorageValue(Instrument^.VoiceDistortion[Counter].Mode));
   SubSubStorage.Add('GAIN',BYTEToStorageValue(Instrument^.VoiceDistortion[Counter].Gain));
   SubSubStorage.Add('DIST',BYTEToStorageValue(Instrument^.VoiceDistortion[Counter].Dist));
   SubSubStorage.Add('RATE',BYTEToStorageValue(Instrument^.VoiceDistortion[Counter].Rate));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.VoiceDistortion[Counter].Carry));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHDS',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentDistortion-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('MODE',BYTEToStorageValue(Instrument^.ChannelDistortion[Counter].Mode));
   SubSubStorage.Add('GAIN',BYTEToStorageValue(Instrument^.ChannelDistortion[Counter].Gain));
   SubSubStorage.Add('DIST',BYTEToStorageValue(Instrument^.ChannelDistortion[Counter].Dist));
   SubSubStorage.Add('RATE',BYTEToStorageValue(Instrument^.ChannelDistortion[Counter].Rate));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.ChannelDistortion[Counter].Carry));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHFS',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentFilter-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('MODE',BYTEToStorageValue(Instrument^.ChannelFilter[Counter].Mode));
   SubSubStorage.Add('CUTO',BYTEToStorageValue(Instrument^.ChannelFilter[Counter].CutOff));
   SubSubStorage.Add('RESO',BYTEToStorageValue(Instrument^.ChannelFilter[Counter].Resonance));
   SubSubStorage.Add('VOLU',BYTEToStorageValue(Instrument^.ChannelFilter[Counter].Volume));
   SubSubStorage.Add('AMPL',SHORTINTToStorageValue(Instrument^.ChannelFilter[Counter].Amplify));
   SubSubStorage.Add('CASC',BOOLEANToStorageValue(Instrument^.ChannelFilter[Counter].Cascaded));
   SubSubStorage.Add('CHAI',BOOLEANToStorageValue(Instrument^.ChannelFilter[Counter].Chain));
   SubSubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.ChannelFilter[Counter].Carry));
   SubSubStorage.Add('MIHZ',WORDToStorageValue(Instrument^.ChannelFilter[Counter].MinHz));
   SubSubStorage.Add('MAHZ',WORDToStorageValue(Instrument^.ChannelFilter[Counter].MaxHz));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CDES',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxInstrumentDelay-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   SubSubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ChannelDelay[Counter].Active));
   SubSubStorage.Add('CLSY',BOOLEANToStorageValue(Instrument^.ChannelDelay[Counter].ClockSync));
   SubSubStorage.Add('WETV',BYTEToStorageValue(Instrument^.ChannelDelay[Counter].Wet));
   SubSubStorage.Add('DRYV',BYTEToStorageValue(Instrument^.ChannelDelay[Counter].Dry));
   SubSubStorage.Add('TILE',BYTEToStorageValue(Instrument^.ChannelDelay[Counter].TimeLeft));
   SubSubStorage.Add('FBLE',SHORTINTToStorageValue(Instrument^.ChannelDelay[Counter].FeedBackLeft));
   SubSubStorage.Add('TIRI',BYTEToStorageValue(Instrument^.ChannelDelay[Counter].TimeRight));
   SubSubStorage.Add('FBRI',SHORTINTToStorageValue(Instrument^.ChannelDelay[Counter].FeedBackRight));
   SubSubStorage.Add('FINE',BOOLEANToStorageValue(Instrument^.ChannelDelay[Counter].Fine));
   SubSubStorage.Add('RECU',BOOLEANToStorageValue(Instrument^.ChannelDelay[Counter].Recursive));

   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHCF',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ChannelChorusFlanger.Active));
  SubStorage.Add('WETV',BYTEToStorageValue(Instrument^.ChannelChorusFlanger.Wet));
  SubStorage.Add('DRYV',BYTEToStorageValue(Instrument^.ChannelChorusFlanger.Dry));
  SubStorage.Add('TILE',BYTEToStorageValue(Instrument^.ChannelChorusFlanger.TimeLeft));
  SubStorage.Add('FBLE',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.FeedBackLeft));
  SubStorage.Add('LFRL',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.LFORateLeft));
  SubStorage.Add('LFDL',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.LFODepthLeft));
  SubStorage.Add('LFPL',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.LFOPhaseLeft));
  SubStorage.Add('TIRI',BYTEToStorageValue(Instrument^.ChannelChorusFlanger.TimeRight));
  SubStorage.Add('FBRI',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.FeedBackRight));
  SubStorage.Add('LFRR',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.LFORateRight));
  SubStorage.Add('LFDR',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.LFODepthRight));
  SubStorage.Add('LFPR',SHORTINTToStorageValue(Instrument^.ChannelChorusFlanger.LFOPhaseRight));
  SubStorage.Add('CARR',BOOLEANToStorageValue(Instrument^.ChannelChorusFlanger.Carry));
  SubStorage.Add('FINE',BOOLEANToStorageValue(Instrument^.ChannelChorusFlanger.Fine));
  SubStorage.Add('CONT',BYTEToStorageValue(Instrument^.ChannelChorusFlanger.Count));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHCO',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('MODE',BYTEToStorageValue(Instrument^.ChannelCompressor.Mode));
  SubStorage.Add('THHO',WORDToStorageValue(Instrument^.ChannelCompressor.Threshold));
  SubStorage.Add('RATI',BYTEToStorageValue(Instrument^.ChannelCompressor.Ratio));
  SubStorage.Add('WISZ',WORDToStorageValue(Instrument^.ChannelCompressor.WindowSize));
  SubStorage.Add('SHKN',BYTEToStorageValue(Instrument^.ChannelCompressor.SoftHardKnee));
  SubStorage.Add('ATTA',WORDToStorageValue(Instrument^.ChannelCompressor.Attack));
  SubStorage.Add('RELE',WORDToStorageValue(Instrument^.ChannelCompressor.Release));
  SubStorage.Add('OUGA',SMALLINTToStorageValue(Instrument^.ChannelCompressor.OutGain));
  SubStorage.Add('AUGA',BOOLEANToStorageValue(Instrument^.ChannelCompressor.AutoGain));
  SubStorage.Add('SDCI',BYTEToStorageValue(Instrument^.ChannelCompressor.SideIn));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHSP',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ChannelSpeech.Active));
  SubStorage.Add('FRLE',BYTEToStorageValue(Instrument^.ChannelSpeech.FrameLength));
  SubStorage.Add('SPEE',BYTEToStorageValue(Instrument^.ChannelSpeech.Speed));
  SubStorage.Add('TEXT',BYTEToStorageValue(Instrument^.ChannelSpeech.TextNumber));
  SubStorage.Add('COLO',SHORTINTToStorageValue(Instrument^.ChannelSpeech.Color));
  SubStorage.Add('NOGA',BYTEToStorageValue(Instrument^.ChannelSpeech.NoiseGain));
  SubStorage.Add('GAIN',BYTEToStorageValue(Instrument^.ChannelSpeech.Gain));
  SubStorage.Add('F4  ',WORDToStorageValue(Instrument^.ChannelSpeech.F4));
  SubStorage.Add('F5  ',WORDToStorageValue(Instrument^.ChannelSpeech.F5));
  SubStorage.Add('F6  ',WORDToStorageValue(Instrument^.ChannelSpeech.F6));
  SubStorage.Add('B4  ',WORDToStorageValue(Instrument^.ChannelSpeech.B4));
  SubStorage.Add('B5  ',WORDToStorageValue(Instrument^.ChannelSpeech.B5));
  SubStorage.Add('B6  ',WORDToStorageValue(Instrument^.ChannelSpeech.B6));
  SubStorage.Add('CAGA',BYTEToStorageValue(Instrument^.ChannelSpeech.CascadeGain));
  SubStorage.Add('PAGA',BYTEToStorageValue(Instrument^.ChannelSpeech.ParallelGain));
  SubStorage.Add('ASGA',BYTEToStorageValue(Instrument^.ChannelSpeech.AspirationGain));
  SubStorage.Add('FRGA',BYTEToStorageValue(Instrument^.ChannelSpeech.FricationGain));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHPS',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ChannelPitchShifter.Active));
  SubStorage.Add('TUNE',SHORTINTToStorageValue(Instrument^.ChannelPitchShifter.Tune));
  SubStorage.Add('FITU',SHORTINTToStorageValue(Instrument^.ChannelPitchShifter.FineTune));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHEQ',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ChannelEQ.Active));
  SubStorage.Add('MODE',BYTEToStorageValue(Instrument^.ChannelEQ.Mode));
  SubStorage.Add('PRAM',BYTEToStorageValue(Instrument^.ChannelEQ.PreAmp));
  SubStorage.Add('OCTA',INTToStorageValue(Instrument^.ChannelEQ.Octave));
  SubStorage.Add('CASC',BOOLEANToStorageValue(Instrument^.ChannelEQ.Cascaded));
  SubStorage.Add('ACAS',BOOLEANToStorageValue(Instrument^.ChannelEQ.AddCascaded));
  SubStorage.Add('BH00',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[0]));
  SubStorage.Add('BH01',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[1]));
  SubStorage.Add('BH02',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[2]));
  SubStorage.Add('BH03',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[3]));
  SubStorage.Add('BH04',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[4]));
  SubStorage.Add('BH05',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[5]));
  SubStorage.Add('BH06',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[6]));
  SubStorage.Add('BH07',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[7]));
  SubStorage.Add('BH08',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[8]));
  SubStorage.Add('BH09',WORDToStorageValue(Instrument^.ChannelEQ.BandHz[9]));
  SubStorage.Add('GA00',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[0]));
  SubStorage.Add('GA01',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[1]));
  SubStorage.Add('GA02',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[2]));
  SubStorage.Add('GA03',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[3]));
  SubStorage.Add('GA04',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[4]));
  SubStorage.Add('GA05',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[5]));
  SubStorage.Add('GA06',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[6]));
  SubStorage.Add('GA07',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[7]));
  SubStorage.Add('GA08',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[8]));
  SubStorage.Add('GA09',BYTEToStorageValue(Instrument^.ChannelEQ.Gain[9]));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHLF',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.ChannelLFO.Active));
  SubStorage.Add('RATE',BYTEToStorageValue(Instrument^.ChannelLFO.Rate));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('LINK',STORAGEToStorageValue(SubStorage));
  SubStorage.Add('ACTI',BOOLEANToStorageValue(Instrument^.Link.Active));
  SubStorage.Add('CHNR',SHORTINTToStorageValue(Instrument^.Link.Channel));
  SubStorage.Add('PRNR',SHORTINTToStorageValue(Instrument^.Link.ProgramNr));

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('VOOR',STORAGEToStorageValue(SubStorage));
  for Counter:=low(TSynthInstrumentVoiceOrder) to high(TSynthInstrumentVoiceOrder) do begin
   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),BYTEToStorageValue(Instrument^.VoiceOrder[Counter]));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('CHOR',STORAGEToStorageValue(SubStorage));
  for Counter:=low(TSynthInstrumentChannelOrder) to high(TSynthInstrumentChannelOrder) do begin
   SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),BYTEToStorageValue(Instrument^.ChannelOrder[Counter]));
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('SAMP',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxSamples-1 do begin
   SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   if ((assigned(Track.Samples[ProgramNr,Counter].Data) and
       (Track.Samples[ProgramNr,Counter].Header.Samples>0)) or (length(SampleNames[ProgramNr,Counter])>0) or
       (length(SampleScripts[ProgramNr,Counter])>0)) or Track.Samples[ProgramNr,Counter].PadSynth.Active then begin
    SubSubStorage.Add('NAME',STRINGToStorageValue(SampleNames[ProgramNr,Counter]));

    if length(SampleScripts[ProgramNr,Counter])>0 then begin
     SubSubStorage.Add('SCCO',STRINGToStorageValue(SampleScripts[ProgramNr,Counter]));
     SubSubStorage.Add('SCLA',BYTEToStorageValue(SampleScriptLanguages[ProgramNr,Counter]));
    end;

    SubSubStorage.Add('LENG',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.Samples));
    SubSubStorage.Add('CHAN',BYTEToStorageValue(Track.Samples[ProgramNr,Counter].Header.Channels));
    SubSubStorage.Add('SART',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.SampleRate));
    SubSubStorage.Add('PHSA',UINTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.PhaseSamples));
    SubSubStorage.Add('NOTE',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.Note));
    SubSubStorage.Add('FITU',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.FineTune));

    SubSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    SubSubStorage.Add('PASY',STORAGETOStorageValue(SubSubSubStorage));
    SubSubSubStorage.Add('ACTI',BOOLEANTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.Active));
    SubSubSubStorage.Add('TOGE',BOOLEANTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.ToGenerate));
    SubSubSubStorage.Add('WTSZ',INTTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.WavetableSize));
    SubSubSubStorage.Add('SARA',INTTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.SampleRate));
    SubSubSubStorage.Add('PROF',BYTETOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.Profile));
    SubSubSubStorage.Add('FREQ',FLOATTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.Frequency));
    SubSubSubStorage.Add('BAWI',FLOATTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.Bandwidth));
    SubSubSubStorage.Add('BWSC',FLOATTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.BandwidthScale));
    SubSubSubStorage.Add('NUHA',INTTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.NumHarmonics));
    SubSubSubStorage.Add('EXAL',BOOLEANTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.ExtendedAlgorithm));
    SubSubSubStorage.Add('CUMO',BYTETOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.CurveMode));
    SubSubSubStorage.Add('CUST',BYTETOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.CurveSteepness));
    SubSubSubStorage.Add('STER',BOOLEANTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.Stereo));
    SubSubSubStorage.Add('EXBA',BOOLEANTOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.ExtendedBalance));
    SubSubSubStorage.Add('BALA',BYTETOStorageValue(Track.Samples[ProgramNr,Counter].PadSynth.Balance));
    HarmonicsStream:=TBeRoStream.Create;
    HarmonicsStream.Write(Track.Samples[ProgramNr,Counter].PadSynth.Harmonics,sizeof(Track.Samples[ProgramNr,Counter].PadSynth.Harmonics));
    HarmonicsStream.Seek(0);
    SubSubSubStorage.Add('HARM',StreamToStorageValue(HarmonicsStream));

    SubSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    SubSubStorage.Add('LOOP',STORAGETOStorageValue(SubSubSubStorage));
    SubSubSubStorage.Add('MODE',BYTETOStorageValue(Track.Samples[ProgramNr,Counter].Header.Loop.Mode));
    SubSubSubStorage.Add('STSA',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.Loop.StartSample));
    SubSubSubStorage.Add('ENSA',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.Loop.EndSample));

    SubSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    SubSubStorage.Add('SULO',STORAGETOStorageValue(SubSubSubStorage));
    SubSubSubStorage.Add('MODE',BYTETOStorageValue(Track.Samples[ProgramNr,Counter].Header.SustainLoop.Mode));
    SubSubSubStorage.Add('STSA',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.SustainLoop.StartSample));
    SubSubSubStorage.Add('ENSA',INTTOStorageValue(Track.Samples[ProgramNr,Counter].Header.SustainLoop.EndSample));

    SubSubStorage.Add('RASP',BOOLEANTOStorageValue(Track.Samples[ProgramNr,Counter].Header.RandomStartPosition));

    if assigned(Track.Samples[ProgramNr,Counter].Data) and not Track.Samples[ProgramNr,Counter].PadSynth.Active then begin
     getmem(p,Track.Samples[ProgramNr,Counter].Header.Samples*Track.Samples[ProgramNr,Counter].Header.Channels*sizeof(single));
     move(Track.Samples[ProgramNr,Counter].Data^,p^,Track.Samples[ProgramNr,Counter].Header.Samples*Track.Samples[ProgramNr,Counter].Header.Channels*sizeof(single));
     SubSubStorage.Add('DATA',DATATOStorageValue(p,Track.Samples[ProgramNr,Counter].Header.Samples*Track.Samples[ProgramNr,Counter].Header.Channels*sizeof(single)));
    end;
    SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));

   end;
  end;

  SubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
  PrgStorage.Add('SPEE',STORAGEToStorageValue(SubStorage));
  for Counter:=0 to MaxSpeechTexts-1 do begin
   if (length(SpeechTextNames[ProgramNr,Counter])>0) or (length(SpeechTexts[ProgramNr,Counter])>0) then begin
    SubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    SubSubStorage.Add('NAME',STRINGToStorageValue(SpeechTextNames[ProgramNr,Counter]));
    SubSubStorage.Add('TEXT',STRINGToStorageValue(SpeechTexts[ProgramNr,Counter]));
    SubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),STORAGEToStorageValue(SubSubStorage));
   end;
  end;

  MainSubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(ProgramNr)),STORAGEToStorageValue(PrgStorage));
 end;
var Counter:integer;
begin
 DataCriticalSection.Enter;
 try
  try
   Stream:=TBeRoMemoryStream.Create;
   MainStorage:=TBeRoTinyFlexibleDataStorageList.Create;

   MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
   MainStorage.Add('INST',STORAGEToStorageValue(MainSubStorage));
   if IsPreset then begin
    MainSubStorage.Add('INNR',BYTEToStorageValue(CurrentProgram));
    WriteProgram(CurrentProgram);
   end else begin
    for Counter:=0 to VSTiNumPrograms-1 do begin
     WriteProgram(Counter);
    end;

    MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainStorage.Add('GLOB',STORAGEToStorageValue(MainSubStorage));

    MainSubStorage.Add('OVSA',BYTEToStorageValue(Track.Global.Oversample));
    MainSubStorage.Add('FIOS',BOOLEANToStorageValue(Track.Global.FineOversample));
    MainSubStorage.Add('FSOS',BOOLEANToStorageValue(Track.Global.FineSincOversample));
    MainSubStorage.Add('OSOR',BYTEToStorageValue(Track.Global.OversampleOrder));

    MainSubStorage.Add('RAML',WORDToStorageValue(Track.Global.RampingLen));
    MainSubStorage.Add('RAMM',BYTEToStorageValue(Track.Global.RampingMode));

    MainSubStorage.Add('CLIP',BOOLEANToStorageValue(Track.Global.Clipping));

    MainSubStorage.Add('USMT',BOOLEANToStorageValue(Track.UseMultithreading));
    MainSubStorage.Add('USSE',BOOLEANToStorageValue(Track.UseSSE));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('REVE',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('ACTI',BOOLEANToStorageValue(Track.Global.Reverb.Active));
    MainSubSubStorage.Add('PRDE',BYTEToStorageValue(Track.Global.Reverb.PreDelay));
    MainSubSubStorage.Add('CFSE',BYTEToStorageValue(Track.Global.Reverb.CombFilterSeparation));
    MainSubSubStorage.Add('ROSI',BYTEToStorageValue(Track.Global.Reverb.RoomSize));
    MainSubSubStorage.Add('FEBA',BYTEToStorageValue(Track.Global.Reverb.FeedBack));
    MainSubSubStorage.Add('ABSO',BYTEToStorageValue(Track.Global.Reverb.Absortion));
    MainSubSubStorage.Add('DRYO',BYTEToStorageValue(Track.Global.Reverb.Dry));
    MainSubSubStorage.Add('WETO',BYTEToStorageValue(Track.Global.Reverb.Wet));
    MainSubSubStorage.Add('NAPF',BYTEToStorageValue(Track.Global.Reverb.NumberOfAllPassFilters));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('DELA',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('ACTI',BOOLEANToStorageValue(Track.Global.Delay.Active));
    MainSubSubStorage.Add('CLSY',BOOLEANToStorageValue(Track.Global.Delay.ClockSync));
    MainSubSubStorage.Add('WETV',BYTEToStorageValue(Track.Global.Delay.Wet));
    MainSubSubStorage.Add('DRYV',BYTEToStorageValue(Track.Global.Delay.Dry));
    MainSubSubStorage.Add('TILE',BYTEToStorageValue(Track.Global.Delay.TimeLeft));
    MainSubSubStorage.Add('FBLE',SHORTINTToStorageValue(Track.Global.Delay.FeedBackLeft));
    MainSubSubStorage.Add('TIRI',BYTEToStorageValue(Track.Global.Delay.TimeRight));
    MainSubSubStorage.Add('FBRI',SHORTINTToStorageValue(Track.Global.Delay.FeedBackRight));
    MainSubSubStorage.Add('FINE',BOOLEANToStorageValue(Track.Global.Delay.Fine));
    MainSubSubStorage.Add('RECU',BOOLEANToStorageValue(Track.Global.Delay.Recursive));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('CHFL',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('ACTI',BOOLEANToStorageValue(Track.Global.ChorusFlanger.Active));
    MainSubSubStorage.Add('WETV',BYTEToStorageValue(Track.Global.ChorusFlanger.Wet));
    MainSubSubStorage.Add('DRYV',BYTEToStorageValue(Track.Global.ChorusFlanger.Dry));
    MainSubSubStorage.Add('TILE',BYTEToStorageValue(Track.Global.ChorusFlanger.TimeLeft));
    MainSubSubStorage.Add('FBLE',SHORTINTToStorageValue(Track.Global.ChorusFlanger.FeedBackLeft));
    MainSubSubStorage.Add('LFRL',SHORTINTToStorageValue(Track.Global.ChorusFlanger.LFORateLeft));
    MainSubSubStorage.Add('LFDL',SHORTINTToStorageValue(Track.Global.ChorusFlanger.LFODepthLeft));
    MainSubSubStorage.Add('LFPL',SHORTINTToStorageValue(Track.Global.ChorusFlanger.LFOPhaseLeft));
    MainSubSubStorage.Add('TIRI',BYTEToStorageValue(Track.Global.ChorusFlanger.TimeRight));
    MainSubSubStorage.Add('FBRI',SHORTINTToStorageValue(Track.Global.ChorusFlanger.FeedBackRight));
    MainSubSubStorage.Add('LFRR',SHORTINTToStorageValue(Track.Global.ChorusFlanger.LFORateRight));
    MainSubSubStorage.Add('LFDR',SHORTINTToStorageValue(Track.Global.ChorusFlanger.LFODepthRight));
    MainSubSubStorage.Add('LFPR',SHORTINTToStorageValue(Track.Global.ChorusFlanger.LFOPhaseRight));
    MainSubSubStorage.Add('CARR',BOOLEANToStorageValue(Track.Global.ChorusFlanger.Carry));
    MainSubSubStorage.Add('FINE',BOOLEANToStorageValue(Track.Global.ChorusFlanger.Fine));
    MainSubSubStorage.Add('CONT',BYTEToStorageValue(Track.Global.ChorusFlanger.Count));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('ENFI',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('ACTI',BOOLEANToStorageValue(Track.Global.EndFilter.Active));
    MainSubSubStorage.Add('LOCU',BYTEToStorageValue(Track.Global.EndFilter.LowCut));
    MainSubSubStorage.Add('HICU',BYTEToStorageValue(Track.Global.EndFilter.HighCut));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('COMP',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('MODE',BYTEToStorageValue(Track.Global.Compressor.Mode));
    MainSubSubStorage.Add('THHO',WORDToStorageValue(Track.Global.Compressor.Threshold));
    MainSubSubStorage.Add('RATI',BYTEToStorageValue(Track.Global.Compressor.Ratio));
    MainSubSubStorage.Add('WISZ',WORDToStorageValue(Track.Global.Compressor.WindowSize));
    MainSubSubStorage.Add('SHKN',BYTEToStorageValue(Track.Global.Compressor.SoftHardKnee));
    MainSubSubStorage.Add('ATTA',WORDToStorageValue(Track.Global.Compressor.Attack));
    MainSubSubStorage.Add('RELE',WORDToStorageValue(Track.Global.Compressor.Release));
    MainSubSubStorage.Add('OUGA',SMALLINTToStorageValue(Track.Global.Compressor.OutGain));
    MainSubSubStorage.Add('AUGA',BOOLEANToStorageValue(Track.Global.Compressor.AutoGain));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('PISH',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('ACTI',BOOLEANToStorageValue(Track.Global.PitchShifter.Active));
    MainSubSubStorage.Add('TUNE',SHORTINTToStorageValue(Track.Global.PitchShifter.Tune));
    MainSubSubStorage.Add('FITU',SHORTINTToStorageValue(Track.Global.PitchShifter.FineTune));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('EQUA',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('ACTI',BOOLEANToStorageValue(Track.Global.EQ.Active));
    MainSubSubStorage.Add('MODE',BYTEToStorageValue(Track.Global.EQ.Mode));
    MainSubSubStorage.Add('PRAM',BYTEToStorageValue(Track.Global.EQ.PreAmp));
    MainSubSubStorage.Add('OCTA',INTToStorageValue(Track.Global.EQ.Octave));
    MainSubSubStorage.Add('CASC',BOOLEANToStorageValue(Track.Global.EQ.Cascaded));
    MainSubSubStorage.Add('ACAS',BOOLEANToStorageValue(Track.Global.EQ.AddCascaded));
    MainSubSubStorage.Add('BH00',WORDToStorageValue(Track.Global.EQ.BandHz[0]));
    MainSubSubStorage.Add('BH01',WORDToStorageValue(Track.Global.EQ.BandHz[1]));
    MainSubSubStorage.Add('BH02',WORDToStorageValue(Track.Global.EQ.BandHz[2]));
    MainSubSubStorage.Add('BH03',WORDToStorageValue(Track.Global.EQ.BandHz[3]));
    MainSubSubStorage.Add('BH04',WORDToStorageValue(Track.Global.EQ.BandHz[4]));
    MainSubSubStorage.Add('BH05',WORDToStorageValue(Track.Global.EQ.BandHz[5]));
    MainSubSubStorage.Add('BH06',WORDToStorageValue(Track.Global.EQ.BandHz[6]));
    MainSubSubStorage.Add('BH07',WORDToStorageValue(Track.Global.EQ.BandHz[7]));
    MainSubSubStorage.Add('BH08',WORDToStorageValue(Track.Global.EQ.BandHz[8]));
    MainSubSubStorage.Add('BH09',WORDToStorageValue(Track.Global.EQ.BandHz[9]));
    MainSubSubStorage.Add('GA00',BYTEToStorageValue(Track.Global.EQ.Gain[0]));
    MainSubSubStorage.Add('GA01',BYTEToStorageValue(Track.Global.EQ.Gain[1]));
    MainSubSubStorage.Add('GA02',BYTEToStorageValue(Track.Global.EQ.Gain[2]));
    MainSubSubStorage.Add('GA03',BYTEToStorageValue(Track.Global.EQ.Gain[3]));
    MainSubSubStorage.Add('GA04',BYTEToStorageValue(Track.Global.EQ.Gain[4]));
    MainSubSubStorage.Add('GA05',BYTEToStorageValue(Track.Global.EQ.Gain[5]));
    MainSubSubStorage.Add('GA06',BYTEToStorageValue(Track.Global.EQ.Gain[6]));
    MainSubSubStorage.Add('GA07',BYTEToStorageValue(Track.Global.EQ.Gain[7]));
    MainSubSubStorage.Add('GA08',BYTEToStorageValue(Track.Global.EQ.Gain[8]));
    MainSubSubStorage.Add('GA09',BYTEToStorageValue(Track.Global.EQ.Gain[9]));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('GLOR',STORAGEToStorageValue(MainSubSubStorage));
    for Counter:=low(TSynthGlobalOrder) to high(TSynthGlobalOrder) do begin
     MainSubSubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),BYTEToStorageValue(Track.Global.Order[Counter]));
    end;

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('CLOC',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('CBPM',BYTEToStorageValue(Track.Global.Clock.BPM));
    MainSubSubStorage.Add('CTPB',BYTEToStorageValue(Track.Global.Clock.TPB));

    MainSubSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainSubStorage.Add('FICO',STORAGEToStorageValue(MainSubSubStorage));
    MainSubSubStorage.Add('MODE',BYTEToStorageValue(Track.Global.FinalCompressor.Mode));
    MainSubSubStorage.Add('THHO',WORDToStorageValue(Track.Global.FinalCompressor.Threshold));
    MainSubSubStorage.Add('RATI',BYTEToStorageValue(Track.Global.FinalCompressor.Ratio));
    MainSubSubStorage.Add('WISZ',WORDToStorageValue(Track.Global.FinalCompressor.WindowSize));
    MainSubSubStorage.Add('SHKN',BYTEToStorageValue(Track.Global.FinalCompressor.SoftHardKnee));
    MainSubSubStorage.Add('ATTA',WORDToStorageValue(Track.Global.FinalCompressor.Attack));
    MainSubSubStorage.Add('RELE',WORDToStorageValue(Track.Global.FinalCompressor.Release));
    MainSubSubStorage.Add('OUGA',SMALLINTToStorageValue(Track.Global.FinalCompressor.OutGain));
    MainSubSubStorage.Add('AUGA',BOOLEANToStorageValue(Track.Global.FinalCompressor.AutoGain));

    MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainStorage.Add('WATA',STORAGEToStorageValue(MainSubStorage));

    MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainStorage.Add('DCPS',STORAGEToStorageValue(MainSubStorage));
    for Counter:=0 to 15 do begin
     MainSubStorage.Add(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)),BYTEToStorageValue(Track.Channels[Counter].Patch));
    end;

    MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainStorage.Add('INFO',STORAGEToStorageValue(MainSubStorage));
    MainSubStorage.Add('NAME',STRINGToStorageValue(ExportTrackName));
    MainSubStorage.Add('AUTH',STRINGToStorageValue(ExportAuthor));
    MainSubStorage.Add('COMM',STRINGToStorageValue(ExportComments));

    MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainStorage.Add('COLO',STORAGEToStorageValue(MainSubStorage));
    MainSubStorage.Add('RED ',INTToStorageValue(ColorRFactor));
    MainSubStorage.Add('GREE',INTToStorageValue(ColorGFactor));
    MainSubStorage.Add('BLUE',INTToStorageValue(ColorBFactor));

    if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
     InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
    end;
    try
     MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
     MainStorage.Add('BRIN',STORAGEToStorageValue(MainSubStorage));
     if assigned(InstanceInfo) then begin
      MainSubStorage.Add('MAST',BOOLEANToStorageValue(((InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self)) or ((InstanceInfo.VSTiPluginInstancesList.Count<2))));
     end else begin
      MainSubStorage.Add('MAST',BOOLEANToStorageValue(true));
     end;
    except
    end;
    if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
     InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
    end;

    MainSubStorage:=TBeRoTinyFlexibleDataStorageList.Create;
    MainStorage.Add('VOCO',STORAGEToStorageValue(MainSubStorage));
    MainSubStorage.Add('VALU',INTToStorageValue(Track.Global.Voices.Count));

   end;

   MainStorage.SaveToStream(Stream);

   Size:=Stream.Size;

   if assigned(ChunkData) then begin
    freemem(ChunkData);
    ChunkData:=nil;
   end;
   GETMEM(ChunkData,Size);
   Stream.Seek(0);
   Stream.read(ChunkData^,Size);

   CompressionAlgo:=0;

   ChunkDataEx:=nil;
   ChunkDataEx2:=nil;
   try
    try
     NewSize:=CompressLZBRX(ChunkData,ChunkDataEx,Stream.Size,nil);
     if assigned(ChunkDataEx) then begin
      if NewSize>0 then begin
       NewNewSize:=DecompressLZBRX(ChunkDataEx,ChunkDataEx2,NewSize,nil);
       if (NewNewSize=Stream.Size) and AreBytesEqual(ChunkData^,ChunkDataEx2^,NewSize) then begin
        FreeMem(ChunkData);
        ChunkData:=ChunkDataEx;
        ChunkDataEx:=nil;
        CompressionAlgo:=1;
        Size:=NewSize;
       end;
      end;
     end;
    finally
     if assigned(ChunkDataEx) then begin
      FreeMem(ChunkDataEx);
      ChunkDataEx:=nil;
     end;
     if assigned(ChunkDataEx2) then begin
      FreeMem(ChunkDataEx2);
      ChunkDataEx2:=nil;
     end;
    end;
   except
    CompressionAlgo:=0;
   end;

   GetMem(ChunkDataEx,Size+1);
   byte(ChunkDataEx^):=CompressionAlgo;
   Move(ChunkData^,pansichar(ChunkDataEx)[1],Size);
   inc(Size);
   FreeMem(ChunkData);
   ChunkData:=ChunkDataEx;

   Data:=ChunkData;

   result:=Size;
   try
    Stream.Destroy;
    MainStorage.Destroy;
   except
   end;
  except
   result:=0;
  end;
 finally
  DataCriticalSection.Leave;
 end;
end;

function TVSTiPlugin.SetChunk(Data:pointer;ByteSize:longint;IsPreset:boolean):longint;
var Stream:TBeRoMemoryStream;
    MainStorage,MainSubStorage,
    MainSubSubStorage:TBeRoTinyFlexibleDataStorageList;
    ChunkDataEx:pointer;
    CompressionAlgo:byte;
    Size:longint;
 procedure ReadProgram(ProgramNr,DestProgramNr:byte);
 var Instrument:PSynthInstrument;
     Counter,Count:integer;
     PrgStorage,SubStorage,SubSubStorage,
     SubSubSubStorage:TBeRoTinyFlexibleDataStorageList;
     s:TBeRoStream;
 begin
  Instrument:=@Track.Instruments[DestProgramNr];

  PrgStorage:=MainStorage.Values['INST'].ValueSTORAGE;
  if not assigned(PrgStorage) then exit;
  PrgStorage:=PrgStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(ProgramNr))].ValueSTORAGE;
  if not assigned(PrgStorage) then exit;

  try
   ProgramNames[DestProgramNr]:=PrgStorage.Values['NAME'].ValueSTRING;

   Instrument^.Volume:=PrgStorage.Values['VOLU'].ValueBYTE;
   Instrument^.Transpose:=PrgStorage.Values['TRPO'].ValueSHORTINT;

   if PrgStorage.IndexOf('C7BF')>=0 then begin
    Instrument^.Controller7BitFlags:=PrgStorage.Values['C7BF'].ValueUINT;
   end else begin
    Instrument^.Controller7BitFlags:=$ffffffff;
   end;

   Instrument^.ChannelVolume:=PrgStorage.Values['CHVO'].ValueBYTE;
   Instrument^.MaxPolyphony:=PrgStorage.Values['MAPO'].ValueBYTE;
   Instrument^.GlobalOutput:=PrgStorage.Values['GLOU'].ValueBYTE;
   Instrument^.GlobalReverb:=PrgStorage.Values['GLRE'].ValueBYTE;
   Instrument^.GlobalDelay:=PrgStorage.Values['GLDE'].ValueBYTE;
   Instrument^.GlobalChorusFlanger:=PrgStorage.Values['GLCF'].ValueBYTE;

   SubStorage:=PrgStorage.Values['MOMA'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Count:=SubStorage.Values['ICNT'].ValueBYTE;
    Instrument^.ModulationMatrixItems:=Count;
    for Counter:=0 to Count-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.ModulationMatrix[Counter].Source:=SubSubStorage.Values['SRCM'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].SourceIndex:=SubSubStorage.Values['SRCI'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].SourceFlags:=SubSubStorage.Values['SRFL'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].SourceMode:=SubSubStorage.Values['SRMO'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].Target:=SubSubStorage.Values['TRGM'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].TargetIndex:=SubSubStorage.Values['TRGI'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].Polarity:=SubSubStorage.Values['POLA'].ValueBYTE;
     Instrument^.ModulationMatrix[Counter].Amount:=SubSubStorage.Values['AMOU'].ValueSHORTINT;
    end;
   end;

   SubStorage:=PrgStorage.Values['TUTA'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.UseTuningTable:=SubStorage.Values['USEI'].ValueBOOL;
    if (SubStorage.IndexOf('DATA')>=0) and (assigned(SubStorage.Values['DATA'].ValueDATA) and (SubStorage.Values['DATA'].ValueDATASize=sizeof(TSynthTuningTable))) then begin
     Move(SubStorage.Values['DATA'].ValueDATA^,Instrument^.TuningTable,SubStorage.Values['DATA'].ValueDATASize);
    end else begin
     Instrument^.UseTuningTable:=false;
     for Counter:=0 to 127 do begin
      Instrument^.TuningTable[Counter]:=Counter;
     end;
    end;
   end else begin
    Instrument^.UseTuningTable:=false;
    for Counter:=0 to 127 do begin
     Instrument^.TuningTable[Counter]:=Counter;
    end;
   end;

   SubStorage:=PrgStorage.Values['OSCI'].ValueSTORAGE;
   if assigned(SubStorage) then begin;
    for Counter:=0 to MaxInstrumentOscillator-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.Oscillator[Counter].NoteBegin:=SubSubStorage.Values['NOBE'].ValueBYTE;
     Instrument^.Oscillator[Counter].NoteEnd:=SubSubStorage.Values['NOEN'].ValueBYTE;
     Instrument^.Oscillator[Counter].WaveForm:=SubSubStorage.Values['WAFO'].ValueBYTE;
     Instrument^.Oscillator[Counter].FeedBack:=SubSubStorage.Values['FEBA'].ValueSMALLINT;
     Instrument^.Oscillator[Counter].Color:=SubSubStorage.Values['COLO'].ValueSHORTINT;
     Instrument^.Oscillator[Counter].Transpose:=SubSubStorage.Values['TRPO'].ValueSHORTINT;
     Instrument^.Oscillator[Counter].FineTune:=SubSubStorage.Values['FITU'].ValueSHORTINT;
     Instrument^.Oscillator[Counter].PhaseStart:=SubSubStorage.Values['PHST'].ValueBYTE;
     Instrument^.Oscillator[Counter].SynthesisType:=SubSubStorage.Values['SYTY'].ValueBYTE;
     Instrument^.Oscillator[Counter].Volume:=SubSubStorage.Values['VOLU'].ValueBYTE;
     Instrument^.Oscillator[Counter].HardSync:=SubSubStorage.Values['HASY'].ValueBOOL;
     Instrument^.Oscillator[Counter].Glide:=SubSubStorage.Values['GLID'].ValueBYTE;
     Instrument^.Oscillator[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
     Instrument^.Oscillator[Counter].PMFMExtendedMode:=SubSubStorage.Values['PFEM'].ValueBOOL;
     Instrument^.Oscillator[Counter].RandomPhase:=SubSubStorage.Values['RAPA'].ValueBOOL;
     Instrument^.Oscillator[Counter].UsePanning:=SubSubStorage.Values['USPA'].ValueBOOL;
     Instrument^.Oscillator[Counter].Panning:=SubSubStorage.Values['PANN'].ValueSHORTINT;
     if SubSubStorage.IndexOf('OUPU')>=0 then begin
      Instrument^.Oscillator[Counter].Output:=SubSubStorage.Values['OUPU'].ValueBOOL;
     end else begin
      Instrument^.Oscillator[Counter].Output:=false;
     end;
     if SubSubStorage.IndexOf('INPU')>=0 then begin
      Instrument^.Oscillator[Counter].Input:=SubSubStorage.Values['INPU'].ValueSHORTINT;
     end else begin
      Instrument^.Oscillator[Counter].Input:=-1;
     end;
     if SubSubStorage.IndexOf('HSIP')>=0 then begin
      Instrument^.Oscillator[Counter].HardSyncInput:=SubSubStorage.Values['HSIP'].ValueSHORTINT;
     end else begin
      Instrument^.Oscillator[Counter].HardSyncInput:=-1;
     end;
     Instrument^.Oscillator[Counter].PluckedStringDelayLineMode:=SubSubStorage.Values['PSDM'].ValueBYTE;
     Instrument^.Oscillator[Counter].PluckedStringDelayLineWidth:=SubSubStorage.Values['PSDW'].ValueBYTE;
     Instrument^.Oscillator[Counter].PluckedStringReflection:=SubSubStorage.Values['PSRE'].ValueBYTE;
     Instrument^.Oscillator[Counter].PluckedStringPick:=SubSubStorage.Values['PSPI'].ValueBYTE;
     Instrument^.Oscillator[Counter].PluckedStringPickUp:=SubSubStorage.Values['PSPU'].ValueBYTE;
     Instrument^.Oscillator[Counter].SuperOscWaveform:=SubSubStorage.Values['SOWF'].ValueBYTE;
     Instrument^.Oscillator[Counter].SuperOscMode:=SubSubStorage.Values['SOMO'].ValueBYTE;
     Instrument^.Oscillator[Counter].SuperOscCount:=SubSubStorage.Values['SOCO'].ValueBYTE;
     Instrument^.Oscillator[Counter].SuperOscDetune:=SubSubStorage.Values['SODT'].ValueBYTE;
     Instrument^.Oscillator[Counter].SuperOscMix:=SubSubStorage.Values['SOMX'].ValueBYTE;
    end;
   end;

   SubStorage:=PrgStorage.Values['ADSR'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentADSR-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;

     Instrument^.ADSR[Counter].Active:=SubSubStorage.Values['ACTI'].ValueBOOL;

     SubSubSubStorage:=SubSubStorage.Values['MODE'].ValueSTORAGE;
     if assigned(SubSubSubStorage) then begin
      Instrument^.ADSR[Counter].Modes[esATTACK]:=SubSubSubStorage.Values['ATTA'].ValueBYTE;
      Instrument^.ADSR[Counter].Modes[esDECAY]:=SubSubSubStorage.Values['DECA'].ValueBYTE;
      Instrument^.ADSR[Counter].Modes[esSUSTAIN]:=SubSubSubStorage.Values['SUST'].ValueBYTE;
      Instrument^.ADSR[Counter].Modes[esRELEASE]:=SubSubSubStorage.Values['RELE'].ValueBYTE;
     end;

     SubSubSubStorage:=SubSubStorage.Values['TIME'].ValueSTORAGE;
     if assigned(SubSubSubStorage) then begin
      Instrument^.ADSR[Counter].Times[esATTACK]:=SubSubSubStorage.Values['ATTA'].ValueBYTE;
      Instrument^.ADSR[Counter].Times[esDECAY]:=SubSubSubStorage.Values['DECA'].ValueBYTE;
      Instrument^.ADSR[Counter].Times[esSUSTAIN]:=SubSubSubStorage.Values['SUST'].ValueBYTE;
      Instrument^.ADSR[Counter].Times[esRELEASE]:=SubSubSubStorage.Values['RELE'].ValueBYTE;
     end;

     Instrument^.ADSR[Counter].TargetDecayLevel:=SubSubStorage.Values['DELE'].ValueBYTE;
     Instrument^.ADSR[Counter].Amplify:=SubSubStorage.Values['AMPL'].ValueBYTE;

     Instrument^.ADSR[Counter].ActiveCheck:=SubSubStorage.Values['ACCH'].ValueBOOL;
     Instrument^.ADSR[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
     Instrument^.ADSR[Counter].Centerise:=SubSubStorage.Values['CENT'].ValueBOOL;
    end;
   end;

   SubStorage:=PrgStorage.Values['ENVE'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentEnvelopes-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if assigned(SubSubStorage) then begin
      Instrument^.Envelope[Counter].Active:=SubSubStorage.Values['ACTI'].ValueBOOL;
      Instrument^.Envelope[Counter].ActiveCheck:=SubSubStorage.Values['ACCH'].ValueBOOL;
      Instrument^.Envelope[Counter].Amplify:=SubSubStorage.Values['AMPL'].ValueBYTE;
      Instrument^.Envelope[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
      Instrument^.Envelope[Counter].Centerise:=SubSubStorage.Values['CENT'].ValueBOOL;

      SubSubSubStorage:=SubSubStorage.Values['DATA'].ValueSTORAGE;
      if assigned(SubSubSubStorage) then begin
       EnvelopeNames[DestProgramNr,Counter]:=SubSubSubStorage.Values['NAME'].ValueSTRING;

       Track.Envelopes[DestProgramNr,Counter].NodesCount:=SubSubSubStorage.Values['NOCO'].ValueWORD;

       if assigned(SubSubSubStorage.Values['NODE'].ValueDATA) and
          (SubSubSubStorage.Values['NODE'].ValueDATASize<=(MaxEnvelopeNodes*sizeof(TSynthEnvelopeNode))) then begin
        GetMemAligned(Track.Envelopes[DestProgramNr,Counter].Nodes,sizeof(TSynthEnvelopeNode)*(Track.Envelopes[DestProgramNr,Counter].NodesCount+1)*2);
        Track.Envelopes[DestProgramNr,Counter].NodesAllocated:=(Track.Envelopes[DestProgramNr,Counter].NodesCount+1)*2;
        MOVE(SubSubSubStorage.Values['NODE'].ValueDATA^,Track.Envelopes[DestProgramNr,Counter].Nodes^,Track.Envelopes[DestProgramNr,Counter].NodesCount*sizeof(TSynthEnvelopeNode));
       end;

       Track.Envelopes[DestProgramNr,Counter].NegValue:=SubSubSubStorage.Values['NEGV'].ValueBYTE;
       Track.Envelopes[DestProgramNr,Counter].PosValue:=SubSubSubStorage.Values['POSV'].ValueBYTE;
       Track.Envelopes[DestProgramNr,Counter].LoopStart:=SubSubSubStorage.Values['LOST'].ValueSHORTINT;
       Track.Envelopes[DestProgramNr,Counter].LoopEnd:=SubSubSubStorage.Values['LOEN'].ValueSHORTINT;
       Track.Envelopes[DestProgramNr,Counter].SustainLoopStart:=SubSubSubStorage.Values['SLST'].ValueSHORTINT;
       Track.Envelopes[DestProgramNr,Counter].SustainLoopEnd:=SubSubSubStorage.Values['SLEN'].ValueSHORTINT;

       EnvelopesSettings[DestProgramNr,Counter].ADSR.Attack:=SubSubSubStorage.Values['GAAT'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].ADSR.Decay:=SubSubSubStorage.Values['GADE'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].ADSR.SustainHold:=SubSubSubStorage.Values['GASH'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].ADSR.Release:=SubSubSubStorage.Values['GARE'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].ADSR.Amplify:=SubSubSubStorage.Values['GAEA'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].ADSR.SustainLevel:=SubSubSubStorage.Values['GASL'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].ADSR.Sustain:=SubSubSubStorage.Values['GASU'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[0]:=SubSubSubStorage.Values['GTS0'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[1]:=SubSubSubStorage.Values['GTS1'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[2]:=SubSubSubStorage.Values['GTS2'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[3]:=SubSubSubStorage.Values['GTS3'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[4]:=SubSubSubStorage.Values['GTS4'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[5]:=SubSubSubStorage.Values['GTS5'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[6]:=SubSubSubStorage.Values['GTS6'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[7]:=SubSubSubStorage.Values['GTS7'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[8]:=SubSubSubStorage.Values['GTS8'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[9]:=SubSubSubStorage.Values['GTS9'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[10]:=SubSubSubStorage.Values['GTSA'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[11]:=SubSubSubStorage.Values['GTSB'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[12]:=SubSubSubStorage.Values['GTSC'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[13]:=SubSubSubStorage.Values['GTSD'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[14]:=SubSubSubStorage.Values['GTSE'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Steps[15]:=SubSubSubStorage.Values['GTSF'].ValueBOOL;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.OnAmp:=SubSubSubStorage.Values['GTON'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.OffAmp:=SubSubSubStorage.Values['GTOF'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.BPM:=SubSubSubStorage.Values['GTBP'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.NoteLength:=SubSubSubStorage.Values['GTNL'].ValueINT;
       EnvelopesSettings[DestProgramNr,Counter].TranceGate.Dots:=SubSubSubStorage.Values['GTDO'].ValueSTRING;
       EnvelopesSettings[DestProgramNr,Counter].Amplifer.Amplify:=SubSubSubStorage.Values['GAAM'].ValueSTRING;

      end;

     end;

    end;
   end;

   SubStorage:=PrgStorage.Values['LFOS'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentLFO-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.LFO[Counter].WaveForm:=SubSubStorage.Values['WAFO'].ValueBYTE;
     Instrument^.LFO[Counter].Sample:=SubSubStorage.Values['SAMP'].ValueBYTE;
     Instrument^.LFO[Counter].Rate:=SubSubStorage.Values['RATE'].ValueBYTE;
     Instrument^.LFO[Counter].Depth:=SubSubStorage.Values['DEPT'].ValueBYTE;
     Instrument^.LFO[Counter].Middle:=SubSubStorage.Values['MIDD'].ValueSHORTINT;
     Instrument^.LFO[Counter].Sweep:=SubSubStorage.Values['SWEE'].ValueBYTE;
     Instrument^.LFO[Counter].PhaseStart:=SubSubStorage.Values['PHST'].ValueBYTE;
     Instrument^.LFO[Counter].Amp:=SubSubStorage.Values['AMPL'].ValueBOOL;
     Instrument^.LFO[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
     Instrument^.LFO[Counter].PhaseSync:=SubSubStorage.Values['PHSY'].ValueBYTE;
    end;
   end;

   SubStorage:=PrgStorage.Values['FILT'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentFilter-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.Filter[Counter].Mode:=SubSubStorage.Values['MODE'].ValueBYTE;
     Instrument^.Filter[Counter].CutOff:=SubSubStorage.Values['CUTO'].ValueBYTE;
     Instrument^.Filter[Counter].Resonance:=SubSubStorage.Values['RESO'].ValueBYTE;
     Instrument^.Filter[Counter].Volume:=SubSubStorage.Values['VOLU'].ValueBYTE;
     Instrument^.Filter[Counter].Amplify:=SubSubStorage.Values['AMPL'].ValueSHORTINT;
     Instrument^.Filter[Counter].Cascaded:=SubSubStorage.Values['CASC'].ValueBOOL;
     Instrument^.Filter[Counter].Chain:=SubSubStorage.Values['CHAI'].ValueBOOL;
     Instrument^.Filter[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
     Instrument^.Filter[Counter].MinHz:=SubSubStorage.Values['MIHZ'].ValueWORD;
     Instrument^.Filter[Counter].MaxHz:=SubSubStorage.Values['MAHZ'].ValueWORD;
    end;
   end;

   SubStorage:=PrgStorage.Values['VODS'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentDistortion-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.VoiceDistortion[Counter].Mode:=SubSubStorage.Values['MODE'].ValueBYTE;
     Instrument^.VoiceDistortion[Counter].Gain:=SubSubStorage.Values['GAIN'].ValueBYTE;
     Instrument^.VoiceDistortion[Counter].Dist:=SubSubStorage.Values['DIST'].ValueBYTE;
     Instrument^.VoiceDistortion[Counter].Rate:=SubSubStorage.Values['RATE'].ValueBYTE;
     Instrument^.VoiceDistortion[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
    end;
   end;

   SubStorage:=PrgStorage.Values['CHDS'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentDistortion-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.ChannelDistortion[Counter].Mode:=SubSubStorage.Values['MODE'].ValueBYTE;
     Instrument^.ChannelDistortion[Counter].Gain:=SubSubStorage.Values['GAIN'].ValueBYTE;
     Instrument^.ChannelDistortion[Counter].Dist:=SubSubStorage.Values['DIST'].ValueBYTE;
     Instrument^.ChannelDistortion[Counter].Rate:=SubSubStorage.Values['RATE'].ValueBYTE;
     Instrument^.ChannelDistortion[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
    end;
   end;

   SubStorage:=PrgStorage.Values['CHFS'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentFilter-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.ChannelFilter[Counter].Mode:=SubSubStorage.Values['MODE'].ValueBYTE;
     Instrument^.ChannelFilter[Counter].CutOff:=SubSubStorage.Values['CUTO'].ValueBYTE;
     Instrument^.ChannelFilter[Counter].Resonance:=SubSubStorage.Values['RESO'].ValueBYTE;
     Instrument^.ChannelFilter[Counter].Volume:=SubSubStorage.Values['VOLU'].ValueBYTE;
     Instrument^.ChannelFilter[Counter].Amplify:=SubSubStorage.Values['AMPL'].ValueSHORTINT;
     Instrument^.ChannelFilter[Counter].Cascaded:=SubSubStorage.Values['CASC'].ValueBOOL;
     Instrument^.ChannelFilter[Counter].Chain:=SubSubStorage.Values['CHAI'].ValueBOOL;
     Instrument^.ChannelFilter[Counter].Carry:=SubSubStorage.Values['CARR'].ValueBOOL;
     Instrument^.ChannelFilter[Counter].MinHz:=SubSubStorage.Values['MIHZ'].ValueWORD;
     Instrument^.ChannelFilter[Counter].MaxHz:=SubSubStorage.Values['MAHZ'].ValueWORD;
    end;
   end;

   SubStorage:=PrgStorage.Values['CDES'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxInstrumentDelay-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if not assigned(SubSubStorage) then continue;
     Instrument^.ChannelDelay[Counter].Active:=SubSubStorage.Values['ACTI'].ValueBOOL;
     Instrument^.ChannelDelay[Counter].ClockSync:=SubSubStorage.Values['CLSY'].ValueBOOL;
     Instrument^.ChannelDelay[Counter].Wet:=SubSubStorage.Values['WETV'].ValueBYTE;
     Instrument^.ChannelDelay[Counter].Dry:=SubSubStorage.Values['DRYV'].ValueBYTE;
     Instrument^.ChannelDelay[Counter].TimeLeft:=SubSubStorage.Values['TILE'].ValueBYTE;
     Instrument^.ChannelDelay[Counter].FeedBackLeft:=SubSubStorage.Values['FBLE'].ValueSHORTINT;
     Instrument^.ChannelDelay[Counter].TimeRight:=SubSubStorage.Values['TIRI'].ValueBYTE;
     Instrument^.ChannelDelay[Counter].FeedBackRight:=SubSubStorage.Values['FBRI'].ValueSHORTINT;
     Instrument^.ChannelDelay[Counter].Fine:=SubSubStorage.Values['FINE'].ValueBOOL;
     if SubSubStorage.Find('RECU')>=0 then begin
      Instrument^.ChannelDelay[Counter].Recursive:=SubSubStorage.Values['RECU'].ValueBOOL;
     end else begin
      Instrument^.ChannelDelay[Counter].Recursive:=true;
     end;
    end;
   end;

   SubStorage:=PrgStorage.Values['CHDE'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelDelay[0].Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.ChannelDelay[0].ClockSync:=SubStorage.Values['CLSY'].ValueBOOL;
    Instrument^.ChannelDelay[0].Wet:=SubStorage.Values['WETV'].ValueBYTE;
    Instrument^.ChannelDelay[0].Dry:=SubStorage.Values['DRYV'].ValueBYTE;
    Instrument^.ChannelDelay[0].TimeLeft:=SubStorage.Values['TILE'].ValueBYTE;
    Instrument^.ChannelDelay[0].FeedBackLeft:=SubStorage.Values['FBLE'].ValueSHORTINT;
    Instrument^.ChannelDelay[0].TimeRight:=SubStorage.Values['TIRI'].ValueBYTE;
    Instrument^.ChannelDelay[0].FeedBackRight:=SubStorage.Values['FBRI'].ValueSHORTINT;
    Instrument^.ChannelDelay[0].Fine:=SubStorage.Values['FINE'].ValueBOOL;
    if SubStorage.Find('RECU')>=0 then begin
     Instrument^.ChannelDelay[0].Recursive:=SubStorage.Values['RECU'].ValueBOOL;
    end else begin
     Instrument^.ChannelDelay[0].Recursive:=true;
    end;
   end;

   SubStorage:=PrgStorage.Values['CHCF'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelChorusFlanger.Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.ChannelChorusFlanger.Wet:=SubStorage.Values['WETV'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.Dry:=SubStorage.Values['DRYV'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.TimeLeft:=SubStorage.Values['TILE'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.FeedBackLeft:=SubStorage.Values['FBLE'].ValueSHORTINT;
    Instrument^.ChannelChorusFlanger.LFORateLeft:=SubStorage.Values['LFRL'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.LFODepthLeft:=SubStorage.Values['LFDL'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.LFOPhaseLeft:=SubStorage.Values['LFPL'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.TimeRight:=SubStorage.Values['TIRI'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.FeedBackRight:=SubStorage.Values['FBRI'].ValueSHORTINT;
    Instrument^.ChannelChorusFlanger.LFORateRight:=SubStorage.Values['LFRR'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.LFODepthRight:=SubStorage.Values['LFDR'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.LFOPhaseRight:=SubStorage.Values['LFPR'].ValueBYTE;
    Instrument^.ChannelChorusFlanger.Carry:=SubStorage.Values['CARR'].ValueBOOL;
    Instrument^.ChannelChorusFlanger.Fine:=SubStorage.Values['FINE'].ValueBOOL;
    Instrument^.ChannelChorusFlanger.Count:=SubStorage.Values['CONT'].ValueBYTE;
   end;

   SubStorage:=PrgStorage.Values['CHCO'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelCompressor.Mode:=SubStorage.Values['MODE'].ValueBYTE;
    Instrument^.ChannelCompressor.Threshold:=SubStorage.Values['THHO'].ValueWORD;
    Instrument^.ChannelCompressor.Ratio:=SubStorage.Values['RATI'].ValueBYTE;
    Instrument^.ChannelCompressor.WindowSize:=SubStorage.Values['WISZ'].ValueWORD;
    Instrument^.ChannelCompressor.SoftHardKnee:=SubStorage.Values['SHKN'].ValueBYTE;
    Instrument^.ChannelCompressor.Attack:=SubStorage.Values['ATTA'].ValueWORD;
    Instrument^.ChannelCompressor.Release:=SubStorage.Values['RELE'].ValueWORD;
    Instrument^.ChannelCompressor.OutGain:=SubStorage.Values['OUGA'].ValueSMALLINT;
    Instrument^.ChannelCompressor.AutoGain:=SubStorage.Values['AUGA'].ValueBOOL;
    if SubStorage.Find('SDCI')>=0 then begin
     Instrument^.ChannelCompressor.SideIn:=SubStorage.Values['SDCI'].ValueBYTE;
    end else begin
     Instrument^.ChannelCompressor.SideIn:=0;
    end;
   end;

   SubStorage:=PrgStorage.Values['CHSP'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelSpeech.Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.ChannelSpeech.FrameLength:=SubStorage.Values['FRLE'].ValueBYTE;
    Instrument^.ChannelSpeech.Speed:=SubStorage.Values['SPEE'].ValueBYTE;
    Instrument^.ChannelSpeech.TextNumber:=SubStorage.Values['TEXT'].ValueBYTE;
    Instrument^.ChannelSpeech.Color:=SubStorage.Values['COLO'].ValueSHORTINT;
    Instrument^.ChannelSpeech.NoiseGain:=SubStorage.Values['NOGA'].ValueBYTE;
    Instrument^.ChannelSpeech.Gain:=SubStorage.Values['GAIN'].ValueBYTE;
    Instrument^.ChannelSpeech.F4:=SubStorage.Values['F4  '].ValueWORD;
    Instrument^.ChannelSpeech.F5:=SubStorage.Values['F5  '].ValueWORD;
    Instrument^.ChannelSpeech.F6:=SubStorage.Values['F6  '].ValueWORD;
    Instrument^.ChannelSpeech.B4:=SubStorage.Values['B4  '].ValueWORD;
    Instrument^.ChannelSpeech.B5:=SubStorage.Values['B5  '].ValueWORD;
    Instrument^.ChannelSpeech.B6:=SubStorage.Values['B6  '].ValueWORD;
    Instrument^.ChannelSpeech.CascadeGain:=SubStorage.Values['CAGA'].ValueBYTE;
    Instrument^.ChannelSpeech.ParallelGain:=SubStorage.Values['PAGA'].ValueBYTE;
    Instrument^.ChannelSpeech.AspirationGain:=SubStorage.Values['ASGA'].ValueBYTE;
    Instrument^.ChannelSpeech.FricationGain:=SubStorage.Values['FRGA'].ValueBYTE;
   end;

   SubStorage:=PrgStorage.Values['CHPS'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelPitchShifter.Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.ChannelPitchShifter.Tune:=SubStorage.Values['TUNE'].ValueSHORTINT;
    Instrument^.ChannelPitchShifter.FineTune:=SubStorage.Values['FITU'].ValueSHORTINT;
   end;

   SubStorage:=PrgStorage.Values['CHEQ'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelEQ.Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.ChannelEQ.Mode:=SubStorage.Values['MODE'].ValueBYTE;
    Instrument^.ChannelEQ.PreAmp:=SubStorage.Values['PRAM'].ValueBYTE;
    Instrument^.ChannelEQ.Octave:=SubStorage.Values['OCTA'].ValueINT;
    Instrument^.ChannelEQ.Cascaded:=SubStorage.Values['CASC'].ValueBOOL;
    Instrument^.ChannelEQ.AddCascaded:=SubStorage.Values['ACAS'].ValueBOOL;
    Instrument^.ChannelEQ.BandHz[0]:=SubStorage.Values['BH00'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[1]:=SubStorage.Values['BH01'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[2]:=SubStorage.Values['BH02'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[3]:=SubStorage.Values['BH03'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[4]:=SubStorage.Values['BH04'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[5]:=SubStorage.Values['BH05'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[6]:=SubStorage.Values['BH06'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[7]:=SubStorage.Values['BH07'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[8]:=SubStorage.Values['BH08'].ValueWORD;
    Instrument^.ChannelEQ.BandHz[9]:=SubStorage.Values['BH09'].ValueWORD;
    Instrument^.ChannelEQ.Gain[0]:=SubStorage.Values['GA00'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[1]:=SubStorage.Values['GA01'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[2]:=SubStorage.Values['GA02'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[3]:=SubStorage.Values['GA03'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[4]:=SubStorage.Values['GA04'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[5]:=SubStorage.Values['GA05'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[6]:=SubStorage.Values['GA06'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[7]:=SubStorage.Values['GA07'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[8]:=SubStorage.Values['GA08'].ValueBYTE;
    Instrument^.ChannelEQ.Gain[9]:=SubStorage.Values['GA09'].ValueBYTE;
   end;

   SubStorage:=PrgStorage.Values['CHLF'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.ChannelLFO.Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.ChannelLFO.Rate:=SubStorage.Values['RATE'].ValueBYTE;
   end;

   SubStorage:=PrgStorage.Values['LINK'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    Instrument^.Link.Active:=SubStorage.Values['ACTI'].ValueBOOL;
    Instrument^.Link.Channel:=SubStorage.Values['CHNR'].ValueSHORTINT;
    Instrument^.Link.ProgramNr:=SubStorage.Values['PRNR'].ValueSHORTINT;
   end;

   SubStorage:=PrgStorage.Values['VOOR'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=low(TSynthInstrumentVoiceOrder) to high(TSynthInstrumentVoiceOrder) do begin
     if SubStorage.Find(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)))<0 then continue;
     Instrument^.VoiceOrder[Counter]:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueBYTE;
    end;
   end;

   SubStorage:=PrgStorage.Values['CHOR'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=low(TSynthInstrumentChannelOrder) to high(TSynthInstrumentChannelOrder) do begin
     if SubStorage.Find(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)))<0 then continue;
     Instrument^.ChannelOrder[Counter]:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueBYTE;
    end;
   end;

   SubStorage:=PrgStorage.Values['SAMP'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxSamples-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if assigned(SubSubStorage) then begin

      SampleNames[DestProgramNr,Counter]:=SubSubStorage.Values['NAME'].ValueSTRING;

      if SubSubStorage.IndexOf('SCCO')>=0 then begin
       SampleScripts[DestProgramNr,Counter]:=SubSubStorage.Values['SCCO'].ValueSTRING;
       SampleScriptLanguages[DestProgramNr,Counter]:=SubSubStorage.Values['SCLA'].ValueBYTE;
      end else begin
       SampleScripts[DestProgramNr,Counter]:='';
       SampleScriptLanguages[DestProgramNr,Counter]:=0;
      end;

      Track.Samples[DestProgramNr,Counter].Header.Samples:=SubSubStorage.Values['LENG'].ValueINT;
      Track.Samples[DestProgramNr,Counter].Header.Channels:=SubSubStorage.Values['CHAN'].ValueBYTE;
      Track.Samples[DestProgramNr,Counter].Header.SampleRate:=SubSubStorage.Values['SART'].ValueINT;
      Track.Samples[DestProgramNr,Counter].Header.PhaseSamples:=SubSubStorage.Values['PHSA'].ValueUINT;
      Track.Samples[DestProgramNr,Counter].Header.Note:=SubSubStorage.Values['NOTE'].ValueINT;
      Track.Samples[DestProgramNr,Counter].Header.FineTune:=SubSubStorage.Values['FITU'].ValueINT;

      SubSubSubStorage:=SubSubStorage.Values['PASY'].ValueSTORAGE;
      if assigned(SubSubSubStorage) then begin
       Track.Samples[DestProgramNr,Counter].PadSynth.Active:=SubSubSubStorage.Values['ACTI'].ValueBOOL;
       Track.Samples[DestProgramNr,Counter].PadSynth.ToGenerate:=SubSubSubStorage.Values['TOGE'].ValueBOOL;
       Track.Samples[DestProgramNr,Counter].PadSynth.WavetableSize:=SubSubSubStorage.Values['WTSZ'].ValueINT;
       Track.Samples[DestProgramNr,Counter].PadSynth.SampleRate:=SubSubSubStorage.Values['SARA'].ValueINT;
       Track.Samples[DestProgramNr,Counter].PadSynth.Profile:=SubSubSubStorage.Values['PROF'].ValueBYTE;
       Track.Samples[DestProgramNr,Counter].PadSynth.Frequency:=SubSubSubStorage.Values['FREQ'].ValueFLOAT;
       Track.Samples[DestProgramNr,Counter].PadSynth.Bandwidth:=SubSubSubStorage.Values['BAWI'].ValueFLOAT;
       Track.Samples[DestProgramNr,Counter].PadSynth.BandwidthScale:=SubSubSubStorage.Values['BWSC'].ValueFLOAT;
       Track.Samples[DestProgramNr,Counter].PadSynth.NumHarmonics:=SubSubSubStorage.Values['NUHA'].ValueINT;
       Track.Samples[DestProgramNr,Counter].PadSynth.ExtendedAlgorithm:=SubSubSubStorage.Values['EXAL'].ValueBOOL;
       Track.Samples[DestProgramNr,Counter].PadSynth.CurveMode:=SubSubSubStorage.Values['CUMO'].ValueBYTE;
       Track.Samples[DestProgramNr,Counter].PadSynth.CurveSteepness:=SubSubSubStorage.Values['CUST'].ValueBYTE;
       Track.Samples[DestProgramNr,Counter].PadSynth.Stereo:=SubSubSubStorage.Values['STER'].ValueBOOL;
       Track.Samples[DestProgramNr,Counter].PadSynth.ExtendedBalance:=SubSubSubStorage.Values['EXBA'].ValueBOOL;
       Track.Samples[DestProgramNr,Counter].PadSynth.Balance:=SubSubSubStorage.Values['BALA'].ValueBYTE;
       s:=SubSubSubStorage.Values['HARM'].ValueSTREAM;
       if assigned(s) then begin
        s.Seek(0);
        s.read(Track.Samples[DestProgramNr,Counter].PadSynth.Harmonics,sizeof(Track.Samples[DestProgramNr,Counter].PadSynth.Harmonics));
       end;

       Track.Samples[DestProgramNr,Counter].PadSynth.ToGenerate:=Track.Samples[DestProgramNr,Counter].PadSynth.Active;

      end;

      SubSubSubStorage:=SubSubStorage.Values['LOOP'].ValueSTORAGE;
      if assigned(SubSubSubStorage) then begin
       Track.Samples[DestProgramNr,Counter].Header.Loop.Mode:=SubSubSubStorage.Values['MODE'].ValueBYTE;
       Track.Samples[DestProgramNr,Counter].Header.Loop.StartSample:=SubSubSubStorage.Values['STSA'].ValueINT;
       Track.Samples[DestProgramNr,Counter].Header.Loop.EndSample:=SubSubSubStorage.Values['ENSA'].ValueINT;
      end;

      SubSubSubStorage:=SubSubStorage.Values['SULO'].ValueSTORAGE;
      if assigned(SubSubSubStorage) then begin
       Track.Samples[DestProgramNr,Counter].Header.SustainLoop.Mode:=SubSubSubStorage.Values['MODE'].ValueBYTE;
       Track.Samples[DestProgramNr,Counter].Header.SustainLoop.StartSample:=SubSubSubStorage.Values['STSA'].ValueINT;
       Track.Samples[DestProgramNr,Counter].Header.SustainLoop.EndSample:=SubSubSubStorage.Values['ENSA'].ValueINT;
      end;

      Track.Samples[DestProgramNr,Counter].Header.RandomStartPosition:=SubSubStorage.Values['RASP'].ValueBOOL;

      if assigned(SubSubStorage.Values['DATA'].ValueDATA) and
         (SubSubStorage.Values['DATA'].ValueDATASize>0) then begin
       if assigned(Track.Samples[DestProgramNr,Counter].Data) then begin
        FREEMEMALIGNED(Track.Samples[DestProgramNr,Counter].Data);
        Track.Samples[DestProgramNr,Counter].Data:=nil;
       end;
       GETMEMALIGNED(Track.Samples[DestProgramNr,Counter].Data,SubSubStorage.Values['DATA'].ValueDATASize);
       MOVE(SubSubStorage.Values['DATA'].ValueDATA^,Track.Samples[DestProgramNr,Counter].Data^,SubSubStorage.Values['DATA'].ValueDATASize);
      end;

      SynthInitSample(@Track,@Track.Samples[DestProgramNr,Counter]);

     end;

    end;
   end;

   SubStorage:=PrgStorage.Values['SPEE'].ValueSTORAGE;
   if assigned(SubStorage) then begin
    for Counter:=0 to MaxSpeechTexts-1 do begin
     SubSubStorage:=SubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueSTORAGE;
     if assigned(SubSubStorage) then begin

      SpeechTextNames[DestProgramNr,Counter]:=SubSubStorage.Values['NAME'].ValueSTRING;
      SpeechTexts[DestProgramNr,Counter]:=SubSubStorage.Values['TEXT'].ValueSTRING;

      SynthSpeechConvertSpeechText(@Track,DestProgramNr,Counter,SpeechTexts[DestProgramNr,Counter]);
     end;
    end;
   end;

  except
  end;

  ChangeProgramText(DestProgramNr and $7f);
 end;
var Counter,i:integer;
    Entered:longword;
begin
 while true do begin
  Entered:=0;
  if AudioCriticalSection.TryEnter then begin
   Entered:=Entered or 1;
  end;
  if DataCriticalSection.TryEnter then begin
   Entered:=Entered or 2;
  end;
  if Entered=(1 or 2) then begin
   break;
  end else begin
   if (Entered and 1)<>0 then begin
    AudioCriticalSection.Leave;
   end;
   if (Entered and 2)<>0 then begin
    DataCriticalSection.Leave;
   end;
   Sleep(0);
  end;
 end;
 try
  try
   try
    if ByteSize>1 then begin
     CompressionAlgo:=byte(Data^);
     Stream:=TBeRoMemoryStream.Create;
     case CompressionAlgo of
      1:begin
       try
        Size:=DecompressLZBRX(@pansichar(Data)[1],ChunkDataEx,ByteSize-1,nil);
        if assigned(ChunkDataEx) then begin
         if Size>0 then begin
          Stream.Write(ChunkDataEx^,Size);
         end;
         FreeMem(ChunkDataEx);
        end;
       except
        result:=0;
        exit;
       end;
      end;
      else begin
       Stream.Write(pansichar(Data)[1],ByteSize-1);
      end;
     end;
     Stream.Seek(0);
     MainStorage:=TBeRoTinyFlexibleDataStorageList.Create;
     MainStorage.LoadFromStream(Stream);
     if IsPreset then begin
      if assigned(MainStorage.Values['INST'].ValueSTORAGE) then begin
       ReadProgram(MainStorage.Values['INST'].ValueSTORAGE.Values['INNR'].ValueBYTE,CurrentProgram);
      end;
     end else begin
      for Counter:=0 to VSTiNumPrograms-1 do begin
       ReadProgram(Counter,Counter);
      end;

      MainSubStorage:=MainStorage.Values['GLOB'].ValueSTORAGE;
      if assigned(MainSubStorage) then begin

       Track.Global.Oversample:=MainSubStorage.Values['OVSA'].ValueBYTE;

       if MainSubStorage.IndexOf('FIOS')>=0 then begin
        Track.Global.FineOversample:=MainSubStorage.Values['FIOS'].ValueBOOL;
       end else begin
        Track.Global.FineOversample:=false;
       end;

       if MainSubStorage.IndexOf('FSOS')>=0 then begin
        Track.Global.FineSincOversample:=MainSubStorage.Values['FSOS'].ValueBOOL;
       end else begin
        Track.Global.FineSincOversample:=false;
       end;

       if MainSubStorage.IndexOf('OSOR')>=0 then begin
        Track.Global.OversampleOrder:=MainSubStorage.Values['OSOR'].ValueBYTE;
       end else begin
        Track.Global.OversampleOrder:=4;
       end;

       if MainSubStorage.IndexOf('RAML')>=0 then begin
        Track.Global.RampingLen:=MainSubStorage.Values['RAML'].ValueWORD;
       end;
       if MainSubStorage.IndexOf('RAMM')>=0 then begin
        Track.Global.RampingMode:=MainSubStorage.Values['RAMM'].ValueBYTE;
       end;

       Track.Global.Clipping:=MainSubStorage.Values['CLIP'].ValueBOOL;

       Track.UseMultithreading:=MainSubStorage.Values['USMT'].ValueBOOL and (Track.JobManager.CountThreads>1);

       Track.UseSSE:=MainSubStorage.Values['USSE'].ValueBOOL and SSEExt;

       MainSubSubStorage:=MainSubStorage.Values['REVE'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.Reverb.Active:=MainSubSubStorage.Values['ACTI'].ValueBOOL;
        Track.Global.Reverb.PreDelay:=MainSubSubStorage.Values['PRDE'].ValueBYTE;
        Track.Global.Reverb.CombFilterSeparation:=MainSubSubStorage.Values['CFSE'].ValueBYTE;
        Track.Global.Reverb.RoomSize:=MainSubSubStorage.Values['ROSI'].ValueBYTE;
        Track.Global.Reverb.FeedBack:=MainSubSubStorage.Values['FEBA'].ValueBYTE;
        Track.Global.Reverb.Absortion:=MainSubSubStorage.Values['ABSO'].ValueBYTE;
        Track.Global.Reverb.Dry:=MainSubSubStorage.Values['DRYO'].ValueBYTE;
        Track.Global.Reverb.Wet:=MainSubSubStorage.Values['WETO'].ValueBYTE;
        Track.Global.Reverb.NumberOfAllPassFilters:=MainSubSubStorage.Values['NAPF'].ValueBYTE;
       end;

       MainSubSubStorage:=MainSubStorage.Values['DELA'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.Delay.Active:=MainSubSubStorage.Values['ACTI'].ValueBOOL;
        Track.Global.Delay.ClockSync:=MainSubSubStorage.Values['CLSY'].ValueBOOL;
        Track.Global.Delay.Wet:=MainSubSubStorage.Values['WETV'].ValueBYTE;
        Track.Global.Delay.Dry:=MainSubSubStorage.Values['DRYV'].ValueBYTE;
        Track.Global.Delay.TimeLeft:=MainSubSubStorage.Values['TILE'].ValueBYTE;
        Track.Global.Delay.FeedBackLeft:=MainSubSubStorage.Values['FBLE'].ValueSHORTINT;
        Track.Global.Delay.TimeRight:=MainSubSubStorage.Values['TIRI'].ValueBYTE;
        Track.Global.Delay.FeedBackRight:=MainSubSubStorage.Values['FBRI'].ValueSHORTINT;
        Track.Global.Delay.Fine:=MainSubSubStorage.Values['FINE'].ValueBOOL;
        if MainSubSubStorage.Find('RECU')>=0 then begin
         Track.Global.Delay.Recursive:=MainSubSubStorage.Values['RECU'].ValueBOOL;
        end else begin
         Track.Global.Delay.Recursive:=true;
        end;
       end;

       MainSubSubStorage:=MainSubStorage.Values['CHFL'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.ChorusFlanger.Active:=MainSubSubStorage.Values['ACTI'].ValueBOOL;
        Track.Global.ChorusFlanger.Wet:=MainSubSubStorage.Values['WETV'].ValueBYTE;
        Track.Global.ChorusFlanger.Dry:=MainSubSubStorage.Values['DRYV'].ValueBYTE;
        Track.Global.ChorusFlanger.TimeLeft:=MainSubSubStorage.Values['TILE'].ValueBYTE;
        Track.Global.ChorusFlanger.FeedBackLeft:=MainSubSubStorage.Values['FBLE'].ValueSHORTINT;
        Track.Global.ChorusFlanger.LFORateLeft:=MainSubSubStorage.Values['LFRL'].ValueBYTE;
        Track.Global.ChorusFlanger.LFODepthLeft:=MainSubSubStorage.Values['LFDL'].ValueBYTE;
        Track.Global.ChorusFlanger.LFOPhaseLeft:=MainSubSubStorage.Values['LFPL'].ValueBYTE;
        Track.Global.ChorusFlanger.TimeRight:=MainSubSubStorage.Values['TIRI'].ValueBYTE;
        Track.Global.ChorusFlanger.FeedBackRight:=MainSubSubStorage.Values['FBRI'].ValueSHORTINT;
        Track.Global.ChorusFlanger.LFORateRight:=MainSubSubStorage.Values['LFRR'].ValueBYTE;
        Track.Global.ChorusFlanger.LFODepthRight:=MainSubSubStorage.Values['LFDR'].ValueBYTE;
        Track.Global.ChorusFlanger.LFOPhaseRight:=MainSubSubStorage.Values['LFPR'].ValueBYTE;
        Track.Global.ChorusFlanger.Carry:=MainSubSubStorage.Values['CARR'].ValueBOOL;
        Track.Global.ChorusFlanger.Fine:=MainSubSubStorage.Values['FINE'].ValueBOOL;
        Track.Global.ChorusFlanger.Count:=MainSubSubStorage.Values['CONT'].ValueBYTE;
       end;

       MainSubSubStorage:=MainSubStorage.Values['ENFI'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.EndFilter.Active:=MainSubSubStorage.Values['ACTI'].ValueBOOL;
        Track.Global.EndFilter.LowCut:=MainSubSubStorage.Values['LOCU'].ValueBYTE;
        Track.Global.EndFilter.HighCut:=MainSubSubStorage.Values['HICU'].ValueBYTE;
       end;

       MainSubSubStorage:=MainSubStorage.Values['COMP'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.Compressor.Mode:=MainSubSubStorage.Values['MODE'].ValueBYTE;
        Track.Global.Compressor.Threshold:=MainSubSubStorage.Values['THHO'].ValueWORD;
        Track.Global.Compressor.Ratio:=MainSubSubStorage.Values['RATI'].ValueBYTE;
        Track.Global.Compressor.WindowSize:=MainSubSubStorage.Values['WISZ'].ValueWORD;
        Track.Global.Compressor.SoftHardKnee:=MainSubSubStorage.Values['SHKN'].ValueBYTE;
        Track.Global.Compressor.Attack:=MainSubSubStorage.Values['ATTA'].ValueWORD;
        Track.Global.Compressor.Release:=MainSubSubStorage.Values['RELE'].ValueWORD;
        Track.Global.Compressor.OutGain:=MainSubSubStorage.Values['OUGA'].ValueSMALLINT;
        Track.Global.Compressor.AutoGain:=MainSubSubStorage.Values['AUGA'].ValueBOOL;
       end;

       MainSubSubStorage:=MainSubStorage.Values['PISH'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.PitchShifter.Active:=MainSubSubStorage.Values['ACTI'].ValueBOOL;
        Track.Global.PitchShifter.Tune:=MainSubSubStorage.Values['TUNE'].ValueSHORTINT;
        Track.Global.PitchShifter.FineTune:=MainSubSubStorage.Values['FITU'].ValueSHORTINT;
       end;

       MainSubSubStorage:=MainSubStorage.Values['EQUA'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.EQ.Active:=MainSubSubStorage.Values['ACTI'].ValueBOOL;
        Track.Global.EQ.Mode:=MainSubSubStorage.Values['MODE'].ValueBYTE;
        Track.Global.EQ.PreAmp:=MainSubSubStorage.Values['PRAM'].ValueBYTE;
        Track.Global.EQ.Octave:=MainSubSubStorage.Values['OCTA'].ValueINT;
        Track.Global.EQ.Cascaded:=MainSubSubStorage.Values['CASC'].ValueBOOL;
        Track.Global.EQ.AddCascaded:=MainSubSubStorage.Values['ACAS'].ValueBOOL;
        Track.Global.EQ.BandHz[0]:=MainSubSubStorage.Values['BH00'].ValueWORD;
        Track.Global.EQ.BandHz[1]:=MainSubSubStorage.Values['BH01'].ValueWORD;
        Track.Global.EQ.BandHz[2]:=MainSubSubStorage.Values['BH02'].ValueWORD;
        Track.Global.EQ.BandHz[3]:=MainSubSubStorage.Values['BH03'].ValueWORD;
        Track.Global.EQ.BandHz[4]:=MainSubSubStorage.Values['BH04'].ValueWORD;
        Track.Global.EQ.BandHz[5]:=MainSubSubStorage.Values['BH05'].ValueWORD;
        Track.Global.EQ.BandHz[6]:=MainSubSubStorage.Values['BH06'].ValueWORD;
        Track.Global.EQ.BandHz[7]:=MainSubSubStorage.Values['BH07'].ValueWORD;
        Track.Global.EQ.BandHz[8]:=MainSubSubStorage.Values['BH08'].ValueWORD;
        Track.Global.EQ.BandHz[9]:=MainSubSubStorage.Values['BH09'].ValueWORD;
        Track.Global.EQ.Gain[0]:=MainSubSubStorage.Values['GA00'].ValueBYTE;
        Track.Global.EQ.Gain[1]:=MainSubSubStorage.Values['GA01'].ValueBYTE;
        Track.Global.EQ.Gain[2]:=MainSubSubStorage.Values['GA02'].ValueBYTE;
        Track.Global.EQ.Gain[3]:=MainSubSubStorage.Values['GA03'].ValueBYTE;
        Track.Global.EQ.Gain[4]:=MainSubSubStorage.Values['GA04'].ValueBYTE;
        Track.Global.EQ.Gain[5]:=MainSubSubStorage.Values['GA05'].ValueBYTE;
        Track.Global.EQ.Gain[6]:=MainSubSubStorage.Values['GA06'].ValueBYTE;
        Track.Global.EQ.Gain[7]:=MainSubSubStorage.Values['GA07'].ValueBYTE;
        Track.Global.EQ.Gain[8]:=MainSubSubStorage.Values['GA08'].ValueBYTE;
        Track.Global.EQ.Gain[9]:=MainSubSubStorage.Values['GA09'].ValueBYTE;
       end;

       MainSubSubStorage:=MainSubStorage.Values['GLOR'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        for Counter:=low(TSynthGlobalOrder) to high(TSynthGlobalOrder) do begin
         if MainSubSubStorage.Find(TBeRoTinyFlexibleDataStorageItemName(longword(Counter)))<0 then continue;
         Track.Global.Order[Counter]:=MainSubSubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueBYTE;
        end;
       end;

       MainSubSubStorage:=MainSubStorage.Values['CLOC'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.Clock.BPM:=MainSubSubStorage.Values['CBPM'].ValueBYTE;
        Track.Global.Clock.TPB:=MainSubSubStorage.Values['CTPB'].ValueBYTE;
       end;

       MainSubSubStorage:=MainSubStorage.Values['FICO'].ValueSTORAGE;
       if assigned(MainSubSubStorage) then begin
        Track.Global.FinalCompressor.Mode:=MainSubSubStorage.Values['MODE'].ValueBYTE;
        Track.Global.FinalCompressor.Threshold:=MainSubSubStorage.Values['THHO'].ValueWORD;
        Track.Global.FinalCompressor.Ratio:=MainSubSubStorage.Values['RATI'].ValueBYTE;
        Track.Global.FinalCompressor.WindowSize:=MainSubSubStorage.Values['WISZ'].ValueWORD;
        Track.Global.FinalCompressor.SoftHardKnee:=MainSubSubStorage.Values['SHKN'].ValueBYTE;
        Track.Global.FinalCompressor.Attack:=MainSubSubStorage.Values['ATTA'].ValueWORD;
        Track.Global.FinalCompressor.Release:=MainSubSubStorage.Values['RELE'].ValueWORD;
        Track.Global.FinalCompressor.OutGain:=MainSubSubStorage.Values['OUGA'].ValueSMALLINT;
        Track.Global.FinalCompressor.AutoGain:=MainSubSubStorage.Values['AUGA'].ValueBOOL;
       end;

      end;

      MainSubStorage:=MainStorage.Values['DCPS'].ValueSTORAGE;
      if assigned(MainSubStorage) then begin
       for Counter:=0 to 15 do begin
        SynthProgramChange(@Track,@Track.Channels[Counter],MainSubStorage.Values[TBeRoTinyFlexibleDataStorageItemName(longword(Counter))].ValueBYTE);
       end;
      end;

      MainSubStorage:=MainStorage.Values['INFO'].ValueSTORAGE;
      if assigned(MainSubStorage) then begin
       ExportTrackName:=MainSubStorage.Values['NAME'].ValueSTRING;
       ExportAuthor:=MainSubStorage.Values['AUTH'].ValueSTRING;
       ExportComments:=MainSubStorage.Values['COMM'].ValueSTRING;
      end;

      SynthInitSamples(@Track);

      MainSubStorage:=MainStorage.Values['COLO'].ValueSTORAGE;
      if assigned(MainSubStorage) then begin
       ColorRFactor:=MainSubStorage.Values['RED '].ValueINT;
       ColorGFactor:=MainSubStorage.Values['GREE'].ValueINT;
       ColorBFactor:=MainSubStorage.Values['BLUE'].ValueINT;
      end;

      MainSubStorage:=MainStorage.Values['BRIN'].ValueSTORAGE;
      if assigned(MainSubStorage) then begin
       if MainSubStorage.Values['MAST'].ValueBOOL then begin
        if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
         InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
         try
          if TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0])<>self then begin
           i:=InstanceInfo.VSTiPluginInstancesList.IndexOf(self);
           if i>=0 then begin
            InstanceInfo.VSTiPluginInstancesList.Exchange(0,i);
           end;
          end;
         except
         end;
         InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
        end;
       end;
      end;

      MainSubStorage:=MainStorage.Values['VOCO'].ValueSTORAGE;
      if assigned(MainSubStorage) then begin
       Track.Global.Voices.Count:=MainSubStorage.Values['VALU'].ValueINT;
       if Track.Global.Voices.Count<1 then begin
        Track.Global.Voices.Count:=1;
       end else if Track.Global.Voices.Count>NumberOfVoices then begin
        Track.Global.Voices.Count:=NumberOfVoices;
       end;
       for i:=0 to NumberOfVoices-1 do begin
        Track.Voices[i].Active:=false;
       end;
      end;

     end;
     MainStorage.Destroy;
     Stream.Destroy;
     result:=ByteSize;
    end else begin
     result:=0;
    end;
    SynthCheckDelayBuffers(@Track);
    if assigned(VSTEditor) then begin
     TVSTiPluginEditor(VSTEditor).UpdateEx;
    end;
   except
    result:=0;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 finally
  AudioCriticalSection.Leave;
 end;
end;

procedure TVSTiPlugin.RecordMIDIStart(Sender:TVSTiPlugin=nil);
var i:integer;
begin
 if assigned(InstanceInfo) then begin
  if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
  end;
  try
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and ((InstanceInfo.VSTiPluginInstancesList[0]<>self) and (InstanceInfo.VSTiPluginInstancesList[0]<>Sender)) then begin
    TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0]).RecordMIDIStart(self);
    if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
     InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
    end;
    exit;
   end;
   if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
   end;
  except
   if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
   end;
  end;
  if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
  end;
 end;
 try
  ExportMIDIEventList.Clear;
  ExportMIDISampleRate:=SoftTRUNC(SampleRate+0.5);
  ExportMIDITicksPerQuarterNote:=ExportMIDISampleRate;
  ExportMIDITempo:=1000000;
  ExportMIDIDoRecord:=true;
  ExportMIDIID:=0;
{$ifdef textdebug}
  Track.DebugWait:=true;
  Track.TimeDebug:=0;
{$endif}
 except
 end;
 if assigned(InstanceInfo) then begin
  if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
   for i:=1 to InstanceInfo.VSTiPluginInstancesList.Count-1 do begin
    TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).RecordMIDIStart(self);
   end;
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiPlugin.RecordMIDIStop(Sender:TVSTiPlugin=nil);
var i,j:integer;
    p:int64;
    MIDIEventItem:TMIDIEvent;
begin
 if assigned(InstanceInfo) then begin
  if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
  end;
  try
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and ((InstanceInfo.VSTiPluginInstancesList[0]<>self) and (InstanceInfo.VSTiPluginInstancesList[0]<>Sender)) then begin
    TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0]).RecordMIDIStop(self);
    if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
     InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
    end;
    exit;
   end;
   if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
   end;
  except
   if assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
   end;
  end;
  if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
   for i:=1 to InstanceInfo.VSTiPluginInstancesList.Count-1 do begin
    TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).RecordMIDIStop(self);
   end;
  end;
 end;
 try
  ExportMIDIDoRecord:=false;
  ExportMIDIEventList.SortPerID;
  p:=-1;
  for i:=0 to ExportMIDIEventList.Count-1 do begin
   MIDIEventItem:=ExportMIDIEventList[i];
   if not assigned(MIDIEventItem) then continue;
   case MIDIEventItem.MIDIData[0] and $f0 of
    MIDI_NOTEON:begin
     p:=MIDIEventItem.DeltaFrames;
     break;
    end;
    MIDI_CONTROLCHANGE:begin
     if (MIDIEventItem.MIDIData[1]=$5f) and (MIDIEventItem.MIDIData[2]=$5f) then begin
      p:=MIDIEventItem.DeltaFrames;
      break;
     end;
    end;
   end;
  end;
  if assigned(InstanceInfo) then begin
   ExportMIDIStartPosition:=p;
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
    for i:=1 to InstanceInfo.VSTiPluginInstancesList.Count-1 do begin
     p:=TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).ExportMIDIStartPosition;
     if (p>=0) and (p<ExportMIDIStartPosition) then begin
      ExportMIDIStartPosition:=p;
     end;
    end;
    for i:=0 to InstanceInfo.VSTiPluginInstancesList.Count-1 do begin
     for j:=0 to TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).ExportMIDIEventList.Count-1 do begin
      MIDIEventItem:=TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).ExportMIDIEventList[j];
      if not assigned(MIDIEventItem) then continue;
      if MIDIEventItem.DeltaFrames>ExportMIDIStartPosition then begin
       dec(MIDIEventItem.DeltaFrames,ExportMIDIStartPosition);
      end else begin
       MIDIEventItem.DeltaFrames:=0;
      end;
     end;
    end;
   end else if InstanceInfo.VSTiPluginInstancesList.Count<2 then begin
    if p<0 then begin
     p:=0;
    end;
    for i:=0 to ExportMIDIEventList.Count-1 do begin
     MIDIEventItem:=ExportMIDIEventList[i];
     if not assigned(MIDIEventItem) then continue;
     if MIDIEventItem.DeltaFrames>p then begin
      dec(MIDIEventItem.DeltaFrames,p);
     end else begin
      MIDIEventItem.DeltaFrames:=0;
     end;
    end;
   end;
  end else begin
   if p<0 then begin
    p:=0;
   end;
   for i:=0 to ExportMIDIEventList.Count-1 do begin
    MIDIEventItem:=ExportMIDIEventList[i];
    if not assigned(MIDIEventItem) then continue;
    if MIDIEventItem.DeltaFrames>p then begin
     dec(MIDIEventItem.DeltaFrames,p);
    end else begin
     MIDIEventItem.DeltaFrames:=0;
    end;
   end;
  end;
 except
 end;
 if assigned(InstanceInfo) then begin
  if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
  end;
 end;
end;

function TVSTiPlugin.ReadMIDIStream(Data:pbyte;DataSize:longword):boolean;
type TImportMIDIEventData=array[1..4] of byte;

     PImportMIDIEvent=^TImportMIDIEvent;
     TImportMIDIEvent=record
      Previous,Next:PImportMIDIEvent;
      Position:int64;
      Command:byte;
      Data:TImportMIDIEventData;
      SysExLength:integer;
      SysEx:pchar;
     end;

     PMIDITrack=^TMIDITrack;
     TMIDITrack=record
      Previous,Next:PMIDITrack;
      EventFirst,EventLast,CurrentEvent:PImportMIDIEvent;
     end;

     TRIFFSignature=array[1..4] of ansichar;

     TRIFFChunk=packed record
      Signature:TRIFFSignature;
      Size:longword;
     end;

     TRIFFHeaderChunk=packed record
      Chunk:TRIFFChunk;
      ID:TRIFFSignature;
     end;

     TMIDIFile=record
      TrackFirst,TrackLast:PMIDITrack;
      Position:int64;
      TicksPerQuarterNote:integer;
      Tempo:integer;
     end;

var MIDIFile:TMIDIFile;

const EventSizes:array[0..$f] of byte=(0,0,0,0,0,0,0,0,2,2,2,2,1,1,2,0);

 function Swap32Big(const Value:longword):longword; {$IFDEF CPU386}assembler; register; {$IFDEF FPC}inline; NOSTACKFRAME;{$ENDIF}
 asm
  bswap eax
 end;
 {$ELSE}
 begin
 {$IFDEF CPU386}
  result:=((Value and $ff) shl 24) or (((Value and $ff00) shr 8) shl 16) or (((Value and $ff0000) shr 16) shl 8) or ((Value and $ff000000) shr 24);
 {$ELSE}
  result:=Value;
 {$ENDIF}
 end;
 {$ENDIF}

 function Swap16Big(const Value:word):word; {$IFDEF CPU386}assembler; register; {$IFDEF FPC}inline; NOSTACKFRAME;{$ENDIF}
 asm
  xchg ah,al
 end;
 {$ELSE}
 begin
 {$IFDEF CPU386}
  result:=((Value and $ff) shl 8) or ((Value and $ff00) shr 8);
 {$ELSE}
  result:=Value;
 {$ENDIF}
 end;
 {$ENDIF}

 function Swap32Little(const Value:longword):longword; {$IFDEF CPU386}assembler; register; {$IFDEF FPC}inline; NOSTACKFRAME;{$ENDIF}
 asm
  mov eax,eax
 end;
 {$ELSE}
 begin
 {$IFDEF CPU386}
  result:=Value;
 {$ELSE}
  result:=((Value and $ff) shl 24) or (((Value and $ff00) shr 8) shl 16) or (((Value and $ff0000) shr 16) shl 8) or ((Value and $ff000000) shr 24);
 {$ENDIF}
 end;
 {$ENDIF}

 function Swap16Little(const Value:word):word; {$IFDEF CPU386}assembler; register; {$IFDEF FPC}inline; NOSTACKFRAME;{$ENDIF}
 asm
  mov eax,eax
 end;
 {$ELSE}
 begin
 {$IFDEF CPU386}
  result:=Value;
 {$ELSE}
  result:=((Value and $ff) shl 8) or ((Value and $ff00) shr 8);
 {$ENDIF}
 end;
 {$ENDIF}

 procedure EventInsertBefore(var MIDIFile:TMIDITrack;NewEvent,OldEvent:PImportMIDIEvent);
 begin
  NewEvent^.Next:=OldEvent;
  NewEvent^.Previous:=OldEvent^.Previous;
  if assigned(OldEvent^.Previous) then begin
   OldEvent^.Previous^.Next:=NewEvent;
  end;
  OldEvent^.Previous:=NewEvent;
  if OldEvent=MIDIFile.EventFirst then begin
   MIDIFile.EventFirst:=NewEvent;
  end;
 end;

 procedure EventInsertAfter(var MIDIFile:TMIDITrack;OldEvent,NewEvent:PImportMIDIEvent);
 begin
  NewEvent^.Next:=OldEvent^.Next;
  NewEvent^.Previous:=OldEvent;
  if assigned(OldEvent^.Next) then begin
   OldEvent^.Next^.Previous:=NewEvent;
  end;
  OldEvent^.Next:=NewEvent;
  if OldEvent=MIDIFile.EventLast then begin
   MIDIFile.EventLast:=NewEvent;
  end;
 end;

 procedure EventInsert(var MIDIFile:TMIDITrack;NewEvent:PImportMIDIEvent);
 var OldEvent:PImportMIDIEvent;
 begin
  if assigned(MIDIFile.EventFirst) and assigned(MIDIFile.EventLast) then begin
   if MIDIFile.EventLast^.Position<=NewEvent^.Position then begin
    EventInsertAfter(MIDIFile,MIDIFile.EventLast,NewEvent);
   end else begin
    OldEvent:=MIDIFile.EventFirst;
    while assigned(OldEvent) and (OldEvent^.Position<=NewEvent^.Position) do begin
     OldEvent:=OldEvent^.next;
    end;
    if assigned(OldEvent) then begin
     EventInsertBefore(MIDIFile,NewEvent,OldEvent);
    end else begin
     EventInsertAfter(MIDIFile,MIDIFile.EventLast,NewEvent);
    end;
   end;
  end else begin
   MIDIFile.EventFirst:=NewEvent;
   MIDIFile.EventLast:=NewEvent;
  end;
 end;

 procedure AddEventToLinkList(var MIDIFile:TMIDITrack;const NewEvent:TImportMIDIEvent);
 var EventToAdd:PImportMIDIEvent;
 begin
  new(EventToAdd);
  EventToAdd^:=NewEvent;
  EventToAdd^.Previous:=nil;
  EventToAdd^.Next:=nil;
  EventInsert(MIDIFile,EventToAdd);
 end;

 function ReadMIDIDataStream(Data:pbyte;DataSize:longword):boolean;
 const cMThd:array[1..4] of ansichar='MThd';
       cMTrk:array[1..4] of ansichar='MTrk';
 type TFileHeader=packed record
       Signature:array[1..4] of ansichar;
       HeaderSize:longword;
       FileFormat,CountOfTracks,TicksPerQuarterNote:word;
      end;
      TTrackHeader=packed record
       Signature:array[1..4] of ansichar;
       TrackSize:longword;
      end;
 var SourcePointer:pbyte;
     FileHeader:TFileHeader;
     TrackHeader:TTrackHeader;
     TrackCounter:integer;
     DataPosition:longword;
     TrackPosition,Position,MetaLength:longword;
     TrackData,TrackByte:pbyte;
     Command,LastCommand,Meta:byte;
     Event:TImportMIDIEvent;
     Track:PMIDITrack;
  function read(var Buffer;LengthCounter:longword):longword;
  var DestPointer:pbyte;
  begin
   result:=0;
   DestPointer:=@Buffer;
   while (DataPosition<DataSize) and (result<LengthCounter) do begin
    DestPointer^:=SourcePointer^;
    inc(SourcePointer);
    inc(DestPointer);
    inc(DataPosition);
    inc(result);
   end;
  end;
  function GetVariableLengthEncodingValue:longword;
  var B:byte;
  begin
   result:=0;
   B:=$ff;
   while ((B and $80)<>0) and (TrackPosition<TrackHeader.TrackSize) do begin
    B:=TrackByte^;
    inc(TrackByte);
    inc(TrackPosition);
    result:=(result shl 7) or (B and $7f);
   end;
  end;
 begin
  result:=false;
  SourcePointer:=Data;
  DataPosition:=0;
  read(FileHeader,sizeof(TFileHeader));
  FileHeader.HeaderSize:=Swap32Big(FileHeader.HeaderSize);
  FileHeader.FileFormat:=Swap16Big(FileHeader.FileFormat);
  FileHeader.CountOfTracks:=Swap16Big(FileHeader.CountOfTracks);
  FileHeader.TicksPerQuarterNote:=Swap16Big(FileHeader.TicksPerQuarterNote);
  if (FileHeader.TicksPerQuarterNote and $8000)<>0 then begin
   FileHeader.TicksPerQuarterNote:=($100-(FileHeader.TicksPerQuarterNote div $100))*(FileHeader.TicksPerQuarterNote and $ff);
  end;
  MIDIFile.TicksPerQuarterNote:=FileHeader.TicksPerQuarterNote;
  if longword(FileHeader.Signature)=longword(cMThd) then begin
   for TrackCounter:=0 to FileHeader.CountOfTracks-1 do begin
    new(Track);
    fillchar(Track^,sizeof(TMIDITrack),#0);
    if assigned(MIDIFile.TrackLast) then begin
     MIDIFile.TrackLast^.Next:=Track;
     Track^.Previous:=MIDIFile.TrackLast;
    end else begin
     MIDIFile.TrackFirst:=Track;
    end;
    MIDIFile.TrackLast:=Track;
    read(TrackHeader,sizeof(TTrackHeader));
    TrackHeader.TrackSize:=Swap32(TrackHeader.TrackSize);
    if longword(TrackHeader.Signature)=longword(cMTrk) then begin
     getmem(TrackData,TrackHeader.TrackSize);
     read(TrackData^,TrackHeader.TrackSize);
     TrackByte:=TrackData;
     TrackPosition:=0;
     LastCommand:=0;
     Position:=0;
     while TrackPosition<TrackHeader.TrackSize do begin
      Position:=Position+GetVariableLengthEncodingValue;
      Event.Position:=Position;
      Command:=TrackByte^;
      if (Command and $80)=0 then begin
       Command:=LastCommand;
      end else begin
       inc(TrackByte);
       inc(TrackPosition);
      end;
      LastCommand:=Command;
      Event.SysExLength:=0;
      Event.SysEx:=nil;
      Event.Command:=Command;
      Event.Data[1]:=0;
      Event.Data[2]:=0;
      Event.Data[3]:=0;
      Event.Data[4]:=0;
      if (Command and $f0)=$f0 then begin
       case Command of
        $f0,$f7:begin
         MetaLength:=GetVariableLengthEncodingValue;
         Event.SysExLength:=MetaLength;
         getmem(Event.SysEx,Event.SysExLength);
         move(TrackByte^,Event.SysEx^,Event.SysExLength);
         Event.Data[1]:=0;
         inc(TrackByte,MetaLength);
         inc(TrackPosition,MetaLength);
        end;
        $f1:begin
         Event.Data[1]:=TrackByte^;
         inc(TrackByte);
         inc(TrackPosition);
        end;
        $f2:begin
         Event.Data[1]:=TrackByte^;
         inc(TrackByte);
         inc(TrackPosition);
         Event.Data[2]:=TrackByte^;
         inc(TrackByte);
         inc(TrackPosition);
        end;
        $f3:begin
         Event.Data[1]:=TrackByte^;
         inc(TrackByte);
         inc(TrackPosition);
        end;
        $ff:begin
         Meta:=TrackByte^;
         inc(TrackByte);
         inc(TrackPosition);
         MetaLength:=GetVariableLengthEncodingValue;
         Event.SysExLength:=MetaLength;
         getmem(Event.SysEx,Event.SysExLength);
         move(TrackByte^,Event.SysEx^,Event.SysExLength);
         Event.Data[1]:=Meta;
         case Meta of
          $2f:TrackPosition:=TrackHeader.TrackSize;
          $51:begin
           Event.Data[2]:=TrackByte^;
           inc(TrackByte);
           inc(TrackPosition);
           Event.Data[3]:=TrackByte^;
           inc(TrackByte);
           inc(TrackPosition);
           Event.Data[4]:=TrackByte^;
           inc(TrackByte);
           inc(TrackPosition);
          end;
          else begin
           inc(TrackByte,MetaLength);
           inc(TrackPosition,MetaLength);
          end;
         end;
        end;
       end;
      end else if EventSizes[Command shr 4]>0 then begin
       Event.Data[1]:=TrackByte^;
       inc(TrackByte);
       inc(TrackPosition);
       if EventSizes[Command shr 4]>1 then begin
        Event.Data[2]:=TrackByte^;
        inc(TrackByte);
        inc(TrackPosition);
       end;
      end;
      AddEventToLinkList(Track^,Event);
     end;
     freemem(TrackData);
     result:=true;
    end;
   end;
  end;
 end;

 procedure FreeTracks;
 var Track,NextTrack:PMIDITrack;
     Event,LastMIDIEvent:PImportMIDIEvent;
 begin
  Track:=MIDIFile.TrackFirst;
  while assigned(Track) do begin
   NextTrack:=Track^.Next;
   Event:=Track^.EventFirst;
   while assigned(Event) do begin
    LastMIDIEvent:=Event;
    Event:=LastMIDIEvent^.Next;
    if assigned(LastMIDIEvent^.SysEx) then begin
     freemem(LastMIDIEvent^.SysEx);
    end;
    dispose(LastMIDIEvent);
   end;
   dispose(Track);
   Track:=NextTrack;
  end;
  MIDIFile.TrackFirst:=nil;
  MIDIFile.TrackLast:=nil;
 end;

 procedure EventReset;
 var Track:PMIDITrack;
 begin
  MIDIFile.Position:=0;
  Track:=MIDIFile.TrackFirst;
  while assigned(Track) do begin
   Track^.CurrentEvent:=Track^.EventFirst;
   Track:=Track^.Next;
  end;
 end;

 function EventNext:PImportMIDIEvent;
 var Track:PMIDITrack;
     CurrentEvent:PImportMIDIEvent;
     BestPosition:int64;
 begin
  result:=nil;
  while not assigned(result) do begin
   Track:=MIDIFile.TrackFirst;
   while assigned(Track) do begin
    CurrentEvent:=Track^.CurrentEvent;
    if assigned(CurrentEvent) then begin
     if CurrentEvent^.Position<=MIDIFile.Position then begin
      result:=CurrentEvent;
      Track^.CurrentEvent:=CurrentEvent^.Next;
      break;
     end;
    end;
    Track:=Track^.Next;
   end;
   if assigned(result) then begin
    break;
   end;
   BestPosition:=-1;
   Track:=MIDIFile.TrackFirst;
   while assigned(Track) do begin
    CurrentEvent:=Track^.CurrentEvent;
    if assigned(CurrentEvent) then begin
     if (BestPosition<0) or (CurrentEvent^.Position<BestPosition) then begin
      BestPosition:=CurrentEvent^.Position;
     end;
    end;
    Track:=Track^.Next;
   end;
   if BestPosition<0 then begin
    break;
   end;
   MIDIFile.Position:=BestPosition;
  end;
 end;

 procedure ProcessEvents;
 var Event:PImportMIDIEvent;
     ID:int64;
     MIDIEventItem:TMIDIEvent;
 begin
  EventReset;
  Event:=EventNext;
  ID:=0;
  while assigned(Event) do begin
   if (Event^.Command in [$80..$f0]) or ((Event^.Command=$ff) and (Event^.Data[1]=$51)) then begin
    MIDIEventItem:=TMIDIEvent.Create;
    MIDIEventItem.DeltaFrames:=Event^.Position;
    MIDIEventItem.ID:=ID;
    MIDIEventItem.MIDIData[0]:=Event^.Command;
    MIDIEventItem.MIDIData[1]:=Event^.Data[1];
    MIDIEventItem.MIDIData[2]:=Event^.Data[2];
    MIDIEventItem.MIDIData[3]:=Event^.Data[3];
    MIDIEventItem.MIDIData[4]:=Event^.Data[4];
    if (Event^.Command=$ff) and (Event^.Data[1]=$51) then begin
     Event^.Command:=$f7;
     MIDIEventItem.SysEx:=nil;
     MIDIEventItem.SysExLen:=0;
    end else if assigned(Event^.SysEx) and (Event^.SysExLength>0) then begin
     MIDIEventItem.SysEx:=nil;
     MIDIEventItem.SysExLen:=Event^.SysExLength;
     GetMem(MIDIEventItem.SysEx,Event^.SysExLength);
     Move(Event^.SysEx^,MIDIEventItem.SysEx^,Event^.SysExLength);
    end else begin
     MIDIEventItem.SysEx:=nil;
     MIDIEventItem.SysExLen:=0;
    end;
    ExportMIDIEventList.Add(MIDIEventItem);
    inc(ID);
   end;
   Event:=EventNext;
  end;
 end;

const cRIFF:array[1..4] of ansichar='RIFF';
      cRMID:array[1..4] of ansichar='RMID';
      cdata:array[1..4] of ansichar='data';
var RIFFHeader:TRIFFHeaderChunk;
    RIFFChunk:TRIFFChunk;
    SourcePointer:pbyte;
    DataPosition:longword;
 function read(var Buffer;LengthCounter:longword):longword;
 var DestPointer:pbyte;
 begin
  result:=0;
  DestPointer:=@Buffer;
  while (DataPosition<DataSize) and (result<LengthCounter) do begin
   DestPointer^:=SourcePointer^;
   inc(SourcePointer);
   inc(DestPointer);
   inc(DataPosition);
   inc(result);
  end;
 end;
begin
 try
  ExportMIDIEventList.Clear;
  DataPosition:=0;
  SourcePointer:=pointer(Data);
  if read(RIFFHeader,sizeof(TRIFFHeaderChunk))=sizeof(TRIFFHeaderChunk) then begin
   RIFFHeader.Chunk.Size:=Swap32Little(RIFFHeader.Chunk.Size);
   if (longword(RIFFHeader.Chunk.Signature)=longword(cRIFF)) and
      (longword(RIFFHeader.ID)=longword(cRMID)) then begin
    while (DataPosition<DataSize) and (DataPosition<RIFFHeader.Chunk.Size) do begin
     if read(RIFFChunk,sizeof(TRIFFChunk))<>sizeof(TRIFFChunk) then begin
      break;
     end;
     RIFFChunk.Size:=Swap32Little(RIFFChunk.Size);
     if longword(RIFFChunk.Signature)=longword(cdata) then begin
      result:=ReadMIDIStream(SourcePointer,RIFFChunk.Size);
      exit;
     end else begin
      inc(SourcePointer,RIFFChunk.Size);
      inc(DataPosition,RIFFChunk.Size);
     end;
    end;
   end;
  end;
  fillchar(MIDIFile,sizeof(TMIDIFile),#0);
  result:=ReadMIDIDataStream(Data,DataSize);
  if result then begin
   ProcessEvents;
   FreeTracks;
   ExportMIDITicksPerQuarterNote:=MIDIFile.TicksPerQuarterNote;
   ExportMIDITempo:=500000;
  end;
 except
  result:=false;
 end;
end;

function TVSTiPlugin.ReadMIDIStream(Stream:TBeRoStream):boolean;
var p:pointer;
    ps:integer;
begin
 try
  result:=false;
  ps:=Stream.Size;
  getmem(p,ps);
  Stream.Seek(0);
  if Stream.read(p^,ps)=ps then begin
   result:=ReadMIDIStream(p,ps);
  end;
  freemem(p);
 except
  result:=false;
 end;
end;

const MIDI_ALLNOTESOFF=$7b;
      MIDI_NOTEOFF=$80;
      MIDI_NOTEON=$90;
      MIDI_KEYAFTERTOUCH=$a0;
      MIDI_CONTROLCHANGE=$b0;
      MIDI_PROGRAMCHANGE=$c0;
      MIDI_CHANNELAFTERTOUCH=$d0;
      MIDI_PITCHBEND=$e0;
      MIDI_SYSTEMMESSAGE=$f0;
      MIDI_BEGINSYSEX=$f0;
      MIDI_MTCQUARTERFRAME=$f1;
      MIDI_TRACKPOSPTR=$f2;
      MIDI_TRACKSELECT=$f3;
      MIDI_ENDSYSEX=$f7;
      MIDI_TIMINGCLOCK=$f8;
      MIDI_START=$fa;
      MIDI_CONTINUE=$fb;
      MIDI_STOP=$fc;
      MIDI_ACTIVESENSING=$fe;
      MIDI_SYSTEMRESET=$ff;

function TVSTiPlugin.GenerateBMF(BMFStream,BankStream:TBeRoStream;Sender:TVSTiPlugin=nil):boolean;
type TEventData=array[1..4] of byte;

     PBR808Event=^TBR808Event;
     TBR808Event=record
      Time:int64;
      ID:int64;
      Command:byte;
      Data:TEventData;
      SysEx:pointer;
      SysExLen:longint;
      Next:PBR808Event;
     end;

     TBR808Track=record
      EventQuery:PBR808Event;
      CurrentEvent:PBR808Event;
      LastEvent:PBR808Event;
      TicksPerQuarterNote:integer;
     end;

     TBMFMIDIEvent=record
      Time:int64;
      ID:int64;
      Command:byte;
      Data:TEventData;
     end;
     TBMFMIDIEvents=array of TBMFMIDIEvent;

var Track:TBR808Track;
    MIDIEvents:TBMFMIDIEvents;

const EventSizes:array[0..$f] of byte=(0,0,0,0,0,0,0,0,2,2,2,2,1,1,2,0);

 function Swap32(const Value:longword):longword; {$IFDEF CPU386}assembler; register; {$IFDEF FPC}inline; NOSTACKFRAME;{$ENDIF}
 asm
  BSWAP EAX
 end;
 {$ELSE}
 begin
 {$IFDEF CPU386}
  result:=((Value and $ff) shl 24) or (((Value and $ff00) shr 8) shl 16) or (((Value and $ff0000) shr 16) shl 8) or ((Value and $ff000000) shr 24);
 {$ELSE}
  result:=Value;
 {$ENDIF}
 end;
 {$ENDIF}

 function Swap16(const Value:word):word; {$IFDEF CPU386}assembler; register; {$IFDEF FPC}inline; NOSTACKFRAME;{$ENDIF}
 asm
  XCHG AH,AL
 end;
 {$ELSE}
 begin
 {$IFDEF CPU386}
  result:=((Value and $ff) shl 8) or ((Value and $ff00) shr 8);
 {$ELSE}
  result:=Value;
 {$ENDIF}
 end;
 {$ENDIF}

 procedure AddEvent(const NewEvent:TBR808Event);
 var Event,LastEvent,EventToAdd:PBR808Event;
 begin
  NEW(EventToAdd);
  EventToAdd^:=NewEvent;
  if assigned(NewEvent.SysEx) and (NewEvent.SysExLen>0) then begin
   EventToAdd^.SysEx:=nil;
   EventToAdd^.SysExLen:=NewEvent.SysExLen;
   GetMemAligned(EventToAdd^.SysEx,EventToAdd^.SysExLen);
   Move(NewEvent.SysEx^,EventToAdd^.SysEx^,EventToAdd^.SysExLen);
  end else begin
   EventToAdd^.SysEx:=nil;
   EventToAdd^.SysExLen:=0;
  end;
  EventToAdd^.Next:=nil;
  if assigned(Track.LastEvent) and ((EventToAdd.Time>=Track.LastEvent^.Time) or ((EventToAdd^.Time=Track.LastEvent^.Time) and (EventToAdd^.ID>=Track.LastEvent^.ID))) then begin
   Event:=Track.LastEvent;
  end else begin
   Event:=Track.EventQuery;
  end;
  LastEvent:=Event;
  while assigned(Event) and ((EventToAdd^.Time>Event^.Time) or ((EventToAdd^.Time=Event^.Time) and (EventToAdd^.ID>=Event^.ID))) do begin
   LastEvent:=Event;
   Event:=Event^.Next;
  end;
  if assigned(LastEvent) then begin
   if (EventToAdd^.Time<LastEvent^.Time) or ((EventToAdd^.Time=LastEvent^.Time) and (EventToAdd^.ID<LastEvent^.ID)) then begin
    if LastEvent=Track.EventQuery then begin
     Track.EventQuery:=EventToAdd;
     Track.CurrentEvent:=EventToAdd;
    end;
    EventToAdd^.Next:=LastEvent;
   end else begin
    EventToAdd^.Next:=LastEvent^.Next;
    LastEvent^.Next:=EventToAdd;
    if LastEvent=Track.LastEvent then begin
     Track.LastEvent:=EventToAdd;
    end;
   end;
  end else begin
   Track.EventQuery:=EventToAdd;
   Track.CurrentEvent:=EventToAdd;
   Track.LastEvent:=EventToAdd;
  end;
 end;

 procedure FreeTrack;
 var Event,LastEvent:PBR808Event;
 begin
  Event:=Track.EventQuery;
  while assigned(Event) do begin
   if assigned(Event^.SysEx) then begin
    FreeMem(Event^.SysEx);
    Event^.SysEx:=nil;
   end;
   LastEvent:=Event;
   Event:=LastEvent^.Next;
   FREEMEM(LastEvent);
  end;
 end;

 procedure AddEvents;
 var i:integer;
     MIDIEventItem:TMIDIEvent;
     Event:TBR808Event;
 begin
  for i:=0 to ExportMIDIEventList.Count-1 do begin
   MIDIEventItem:=ExportMIDIEventList[i];
   if not assigned(MIDIEventItem) then continue;
   Event.Time:=MIDIEventItem.DeltaFrames;
   Event.ID:=MIDIEventItem.ID;
   Event.Command:=MIDIEventItem.MIDIData[0];
   Event.Data[1]:=MIDIEventItem.MIDIData[1];
   Event.Data[2]:=MIDIEventItem.MIDIData[2];
   Event.Data[3]:=MIDIEventItem.MIDIData[3];
   Event.Data[4]:=MIDIEventItem.MIDIData[4];
   Event.SysEx:=MIDIEventItem.SysEx;
   Event.SysExLen:=MIDIEventItem.SysExLen;
   AddEvent(Event);
  end;
 end;

 procedure PreprocessEvents;
 var Event:PBR808Event;
     SysExOfs:longword;
 begin
  SysExOfs:=0;
  Event:=Track.EventQuery;
  while assigned(Event) do begin
   case Event^.Command and $f0 of
    MIDI_NOTEOFF:begin
     if Event^.Data[2]=$7f then begin
      // Convert noteoff to noteon-off events (-> higher compression ratio)
      Event^.Command:=MIDI_NOTEON or (Event^.Command and $0f);
      Event^.Data[2]:=0;
     end;
    end;
    MIDI_BEGINSYSEX:begin
     Event^.Data[1]:=SysExOfs and $ff;
     Event^.Data[2]:=(SysExOfs shr 8) and $ff;
     Event^.Data[3]:=(SysExOfs shr 16) and $ff;
     Event^.Data[4]:=(SysExOfs shr 24) and $ff;
     inc(SysExOfs,4+Event^.SysExLen);
    end;
   end;
   Event:=Event^.Next;
  end;
 end;

 procedure ConvertEventsToArray;
 var Event:PBR808Event;
     Count,Counter:integer;
 begin
  Count:=0;
  Event:=Track.EventQuery;
  while assigned(Event) do begin
   inc(Count,ord((Event^.Command<=$f0) or ((Event^.Command=$f7) and (Event^.Data[1]=$51))));
   Event:=Event^.Next;
  end;
  setlength(MIDIEvents,Count);
  Counter:=0;
  Event:=Track.EventQuery;
  while assigned(Event) do begin
   if (Event^.Command<=$f0) or ((Event^.Command=$f7) and (Event^.Data[1]=$51)) then begin
    MIDIEvents[Counter].Time:=Event^.Time;
    MIDIEvents[Counter].ID:=Event^.ID;
    MIDIEvents[Counter].Command:=Event^.Command;
    MIDIEvents[Counter].Data:=Event^.Data;
    inc(Counter);
   end;
   Event:=Event^.Next;
  end;
 end;

var Counter,DataCounter,ChannelCounter,CommandCounter,ControllerCounter,
    i,EventCount,TimeDataCount,IDDataCount,DataStart,DataCount,Position:integer;
    UsedStreams,SubTrackOffset,SubTrackOffsetValue,SubTrackLength:longword;
    MemoryStream,SubBMFStream,SubBankStream:TBeRoMemoryStream;
    CurrentByte,LastByte,CommandByte:byte;
    LastTime:int64;
    LastID:int64;
    Event:PBR808Event;
begin
 try
  if assigned(InstanceInfo) then begin
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and ((InstanceInfo.VSTiPluginInstancesList[0]<>self) and (InstanceInfo.VSTiPluginInstancesList[0]<>Sender)) then begin
    result:=TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0]).GenerateBMF(BMFStream,BankStream,self);
    exit;
   end;
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
   end;
  end;

  FILLCHAR(Track,sizeof(TBR808Track),#0);

  MIDIEvents:=nil;
  AddEvents;
  PreprocessEvents;
  ConvertEventsToArray;

  Track.TicksPerQuarterNote:=ExportMIDITicksPerQuarterNote;

  MemoryStream:=TBeRoMemoryStream.Create;
  MemoryStream.WriteDWord(BR808SynthesizerVersion);   // 0

  MemoryStream.WriteDWord(0);                         // 4

  MemoryStream.WriteDWord(0);                         // 8

  MemoryStream.WriteDWord(round(SampleRate));         // 12

  MemoryStream.WriteDWord(Track.TicksPerQuarterNote); // 16

  MemoryStream.WriteDWord(ExportMIDITempo);           // 20

  MemoryStream.WriteDWord(0);                         // 24

  UsedStreams:=0;
  for CommandCounter:=$9 to $f do begin
   for ChannelCounter:=0 to $f do begin
    CommandByte:=(CommandCounter shl 4) or ChannelCounter;
    for ControllerCounter:=0 to 127 do begin
     EventCount:=0;
     for Counter:=0 to length(MIDIEvents)-1 do begin
      if (MIDIEvents[Counter].Command=CommandByte) and
         (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
          (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
       inc(EventCount);
      end;
     end;
     if EventCount>0 then begin
      inc(UsedStreams);
     end;
     if (CommandByte and $f0)<>MIDI_CONTROLCHANGE then begin
      break;
     end;
    end;
   end;
  end;

  MemoryStream.WriteDWord(UsedStreams);               // 32

  for CommandCounter:=$9 to $f do begin
   for ChannelCounter:=0 to $f do begin
    CommandByte:=(CommandCounter shl 4) or ChannelCounter;
    for ControllerCounter:=0 to 127 do begin

     EventCount:=0;
     for Counter:=0 to length(MIDIEvents)-1 do begin
      if (MIDIEvents[Counter].Command=CommandByte) and
         (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
          (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
       inc(EventCount);
      end;
     end;

     if EventCount>0 then begin
      MemoryStream.WriteDWord(EventCount);
      MemoryStream.WriteByte(CommandByte);
      if (CommandByte and $f0)=MIDI_CONTROLCHANGE then begin
       MemoryStream.WriteByte(ControllerCounter);
      end;

      TimeDataCount:=1;
      for DataCounter:=1 to 4 do begin
       LastTime:=0;
       for Counter:=0 to length(MIDIEvents)-1 do begin
        if (MIDIEvents[Counter].Command=CommandByte) and
           (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
            (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
         CurrentByte:=(((MIDIEvents[Counter].Time-LastTime)) shr ((DataCounter-1) shl 3)) and $ff;
         LastTime:=MIDIEvents[Counter].Time;
         if CurrentByte<>0 then begin
          if TimeDataCount<DataCounter then TimeDataCount:=DataCounter;
          if TimeDataCount=4 then break;
         end;
        end;
       end;
      end;

      IDDataCount:=1;
      for DataCounter:=1 to 4 do begin
       LastID:=0;
       for Counter:=0 to length(MIDIEvents)-1 do begin
        if (MIDIEvents[Counter].Command=CommandByte) and
           (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
            (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
         CurrentByte:=(((MIDIEvents[Counter].ID-LastID)) shr ((DataCounter-1) shl 3)) and $ff;
         LastID:=MIDIEvents[Counter].ID;
         if CurrentByte<>0 then begin
          if IDDataCount<DataCounter then IDDataCount:=DataCounter;
          if IDDataCount=4 then break;
         end;
        end;
       end;
      end;

      MemoryStream.WriteByte(TimeDataCount);
      MemoryStream.WriteByte(IDDataCount);

      for DataCounter:=1 to TimeDataCount do begin
       LastTime:=0;
       for Counter:=0 to length(MIDIEvents)-1 do begin
        if (MIDIEvents[Counter].Command=CommandByte) and
           (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
            (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
         CurrentByte:=(((MIDIEvents[Counter].Time-LastTime)) shr ((DataCounter-1) shl 3)) and $ff;
         LastTime:=MIDIEvents[Counter].Time;
         MemoryStream.WriteByte(CurrentByte);
        end;
       end;
      end;

      for DataCounter:=1 to IDDataCount do begin
       LastID:=0;
       for Counter:=0 to length(MIDIEvents)-1 do begin
        if (MIDIEvents[Counter].Command=CommandByte) and
           (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
            (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
         CurrentByte:=(((MIDIEvents[Counter].ID-LastID)) shr ((DataCounter-1) shl 3)) and $ff;
         LastID:=MIDIEvents[Counter].ID;
         MemoryStream.WriteByte(CurrentByte);
        end;
       end;
      end;

      if (CommandByte and $f0)=MIDI_CONTROLCHANGE then begin
       DataStart:=2;
      end else begin
       DataStart:=1;
      end;
              
      if CommandCounter=$f then begin
       case CommandByte of
        $f0,$f7:begin
         DataCount:=4;
        end;
        $f1,$f3:begin
         DataCount:=1;
        end;
        $f2:begin
         DataCount:=2;
        end;
        else begin
         DataCount:=0;
        end;
       end;
      end else begin
       DataCount:=EventSizes[CommandCounter];
      end;

      for DataCounter:=DataStart to DataCount do begin
       LastByte:=0;
       for Counter:=0 to length(MIDIEvents)-1 do begin
        if (MIDIEvents[Counter].Command=CommandByte) and
           (((CommandByte and $f0)<>MIDI_CONTROLCHANGE) or
            (MIDIEvents[Counter].Data[1]=ControllerCounter)) then begin
         MemoryStream.WriteByte(MIDIEvents[Counter].Data[DataCounter]-LastByte);
         LastByte:=MIDIEvents[Counter].Data[DataCounter];
        end;
       end;
      end;
     end;

     if (CommandByte and $f0)<>MIDI_CONTROLCHANGE then begin
      break;
     end;
    end;
   end;
  end;

  Position:=MemoryStream.Position;
  MemoryStream.Seek(24);
  MemoryStream.WriteDWord(Position);
  MemoryStream.Seek(MemoryStream.Size);
  Event:=Track.EventQuery;
  while assigned(Event) do begin
   case Event^.Command and $f0 of
    MIDI_BEGINSYSEX:begin
     MemoryStream.WriteDWord(Event^.SysExLen);
     if Event^.SysExLen>0 then begin
      MemoryStream.Write(Event^.SysEx^,Event^.SysExLen);
     end;
    end;
   end;
   Event:=Event^.Next;
  end;

  FreeTrack;

  if assigned(BankStream) then begin
   Position:=MemoryStream.Position;
   MemoryStream.Append(BankStream);
   MemoryStream.Seek(4);
   MemoryStream.WriteDWord(Position);
   MemoryStream.Seek(MemoryStream.Size);
  end;

  if assigned(InstanceInfo) then begin
   SubTrackOffset:=8;
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
    for i:=1 to InstanceInfo.VSTiPluginInstancesList.Count-1 do begin
     SubBMFStream:=TBeRoMemoryStream.Create;
     SubBankStream:=TBeRoMemoryStream.Create;
     if TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).GenerateBank(SubBankStream,true) then begin
      if not TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]).GenerateBMF(SubBMFStream,SubBankStream,self) then begin
       result:=false;
       MemoryStream.Destroy;
       exit;
      end;
     end else begin
      result:=false;
      MemoryStream.Destroy;
      exit;
     end;
     SubBankStream.Destroy;
     SubTrackOffsetValue:=MemoryStream.Size;
     SubTrackLength:=SubBMFStream.Size;
     MemoryStream.Seek(SubTrackOffset);
     MemoryStream.WriteDWord(SubTrackOffsetValue);
     MemoryStream.Seek(SubTrackOffsetValue);
     SubTrackOffset:=SubTrackOffsetValue;
     MemoryStream.WriteDWord(0);
     MemoryStream.WriteDWord(SubTrackLength);
     SubBMFStream.Seek(0);
     MemoryStream.Append(SubBMFStream);
     SubBMFStream.Destroy;
    end;
   end;
  end;

  BMFStream.Assign(MemoryStream);
  MemoryStream.Destroy;

  setlength(MIDIEvents,0);

  if assigned(InstanceInfo) then begin
   if (InstanceInfo.VSTiPluginInstancesList.Count>0) and (InstanceInfo.VSTiPluginInstancesList[0]=self) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
   end;
  end;
  result:=true;
 except
  result:=false;
 end;
end;

function TVSTiPlugin.GenerateBank(BankStream:TBeRoStream;WithTrack:boolean):boolean;
var InstrumentsUsed:array[byte] of bytebool;
    i,j,k,h,g:integer;
    MIDIEventItem:TMIDIEvent;
    ChannelPrograms:array[0..$f] of byte;
    PadSynth:TSynthSamplePadSynth;
    si:smallint;
    b:byte;
    DoFlush,UsedAll,Used:boolean;
    ADPCMIMAState:TSynthADPCMIMAState;
begin
 try
  if not assigned(BankStream) then begin
   result:=false;
   exit;
  end;

  // Analyse part
  fillchar(InstrumentsUsed,sizeof(InstrumentsUsed),#$0);
  fillchar(ChannelPrograms,sizeof(ChannelPrograms),#$0);
  if WithTrack then begin
   for i:=0 to ExportMIDIEventList.Count-1 do begin
    MIDIEventItem:=ExportMIDIEventList[i];
    if not assigned(MIDIEventItem) then continue;
    case MIDIEventItem.MIDIData[0] and $f0 of
     MIDI_PROGRAMCHANGE:begin
      ChannelPrograms[MIDIEventItem.MIDIData[0] and $0f]:=MIDIEventItem.MIDIData[1];
     end;
     MIDI_NOTEON:begin
      InstrumentsUsed[ChannelPrograms[MIDIEventItem.MIDIData[0] and $0f] and $7f]:=true;
     end;
    end;
   end;
  end else begin
   for i:=0 to MaxInstruments-1 do begin
    InstrumentsUsed[i]:=true;
   end;
  end;

  for i:=0 to NumberOfChannels-1 do begin
   InstrumentsUsed[Track.Channels[i].Patch and $7f]:=true;
  end;

  // Write to stream part
  BankStream.WriteDWord(BR808SynthesizerVersion);
  BankStream.WriteDWord(length(ExportTrackName)+1);
  if length(ExportTrackName)>0 then begin
   BankStream.Write(ExportTrackName[1],length(ExportTrackName));
  end;
  BankStream.WriteByte(0);
  BankStream.WriteDWord(length(ExportAuthor)+1);
  if length(ExportAuthor)>0 then begin
   BankStream.Write(ExportAuthor[1],length(ExportAuthor));
  end;
  BankStream.WriteByte(0);
  BankStream.WriteDWord(length(ExportComments)+1);
  if length(ExportComments)>0 then begin
   BankStream.Write(ExportComments[1],length(ExportComments));
  end;
  BankStream.WriteByte(0);

  if BankStream.Write(Track.Global,sizeof(TSynthGlobal))<>sizeof(TSynthGlobal) then begin
   result:=false;
   exit;
  end;

  for i:=0 to NumberOfChannels-1 do begin
   BankStream.WriteByte(Track.Channels[i].Patch and $7f);
  end;

  for i:=0 to MaxInstruments-1 do begin
   if InstrumentsUsed[i] then begin
    BankStream.WriteByte(1);

    begin
     j:=longword(@Track.Instruments[i].ModulationMatrixItems)-longword(@Track.Instruments[i].Volume)+1;
     if BankStream.Write(Track.Instruments[i],j)<>j then begin
      result:=false;
      exit;
     end;
     for j:=0 to Track.Instruments[i].ModulationMatrixItems-1 do begin
      if BankStream.Write(Track.Instruments[i].ModulationMatrix[j],sizeof(TSynthInstrumentModulationMatrixItem))<>sizeof(TSynthInstrumentModulationMatrixItem) then begin
       result:=false;
       exit;
      end;
     end;
     if Track.Instruments[i].UseTuningTable then begin
      if BankStream.Write(Track.Instruments[i].TuningTable,sizeof(TSynthTuningTable))<>sizeof(TSynthTuningTable) then begin
       result:=false;
       exit;
      end;
     end;
    end;

    begin
     for j:=0 to MaxInstrumentEnvelopes-1 do begin
      if Track.Instruments[i].Envelope[j].Active then begin
       BankStream.WriteByte(1);
       if Track.Envelopes[i,j].NodesCount>MaxEnvelopeNodes then begin
        Track.Envelopes[i,j].NodesCount:=MaxEnvelopeNodes;
       end;
       if BankStream.Write(Track.Envelopes[i,j].NodesCount,2)<>2 then begin
        result:=false;
        exit;
       end;
       if BankStream.Write(Track.Envelopes[i,j].NegValue,1)<>1 then begin
        result:=false;
        exit;
       end;
       if BankStream.Write(Track.Envelopes[i,j].PosValue,1)<>1 then begin
        result:=false;
        exit;
       end;
       if BankStream.Write(Track.Envelopes[i,j].LoopStart,1)<>1 then begin
        result:=false;
        exit;
       end;
       if BankStream.Write(Track.Envelopes[i,j].LoopEnd,1)<>1 then begin
        result:=false;
        exit;
       end;
       if BankStream.Write(Track.Envelopes[i,j].SustainLoopStart,1)<>1 then begin
        result:=false;
        exit;
       end;
       if BankStream.Write(Track.Envelopes[i,j].SustainLoopEnd,1)<>1 then begin
        result:=false;
        exit;
       end;
       if Track.Envelopes[i,j].NodesCount>0 then begin
        if BankStream.Write(Track.Envelopes[i,j].Nodes^,sizeof(TSynthEnvelopeNode)*Track.Envelopes[i,j].NodesCount)<>(sizeof(TSynthEnvelopeNode)*Track.Envelopes[i,j].NodesCount) then begin
         result:=false;
         exit;
        end;
       end;
      end else begin
       BankStream.WriteByte(0);
      end;
     end;
    end;

    begin
     UsedAll:=false;
     for j:=0 to MaxModulationMatrixItems-1 do begin
      case Track.Instruments[i].ModulationMatrix[j].Target of
       mmoOscColor:begin
        if Track.Instruments[i].Oscillator[Track.Instruments[i].ModulationMatrix[j].TargetIndex and 3].WaveForm=wfSAMPLE then begin
         UsedAll:=true;
         break;
        end;
       end;
      end;
     end;
     for j:=0 to MaxSamples-1 do begin
      Used:=UsedAll;
      if not Used then begin
       for k:=0 to MaxInstrumentOscillator-1 do begin
        if (Track.Instruments[i].Oscillator[k].WaveForm=wfSAMPLE) and (((Track.Instruments[i].Oscillator[k].Color+64) and $7f)=j) then begin
         Used:=true;
         break;
        end;
       end;
      end;
      if Used then begin
       BankStream.WriteByte(1);
       if BankStream.Write(Track.Samples[i,j].Header,sizeof(TSynthSampleHeader))<>sizeof(TSynthSampleHeader) then begin
        result:=false;
        exit;
       end;
       PadSynth:=Track.Samples[i,j].PadSynth;
       PadSynth.ToGenerate:=true;
       if BankStream.Write(PadSynth,sizeof(TSynthSamplePadSynth))<>sizeof(TSynthSamplePadSynth) then begin
        result:=false;
        exit;
       end;
       if (Track.Samples[i,j].Header.Samples>0) and assigned(Track.Samples[i,j].Data) and not Track.Samples[i,j].PadSynth.Active then begin
        for g:=0 to Track.Samples[i,j].Header.Channels-1 do begin
         ADPCMIMAState.PrevSample:=0;
         ADPCMIMAState.StepIndex:=0;
         DoFlush:=false;
         for h:=0 to Track.Samples[i,j].Header.Samples-1 do begin
          k:=SoftTrunc((psingles(Track.Samples[i,j].Data)^[(h*Track.Samples[i,j].Header.Channels)+g]*32768)+0.5);
          if k<-32768 then begin
           k:=-32768;
          end else if k>32767 then begin
           k:=32767;
          end;
          if h=0 then begin
           ADPCMIMAState.PrevSample:=k;
           ADPCMIMAState.StepIndex:=0;
           si:=k;
           if BankStream.Write(si,sizeof(smallint))<>sizeof(smallint) then begin
            result:=false;
            exit;
           end;
          end;
          if (h and 1)=0 then begin
           b:=SynthADPCMIMACompressSample(ADPCMIMAState,k);
           DoFlush:=true;
          end else begin
           DoFlush:=false;
           b:=b or (SynthADPCMIMACompressSample(ADPCMIMAState,k) shl 4);
           if BankStream.Write(b,sizeof(byte))<>sizeof(byte) then begin
            result:=false;
            exit;
           end;
          end;
         end;
         if DoFlush then begin
          if BankStream.Write(b,sizeof(byte))<>sizeof(byte) then begin
           result:=false;
           exit;
          end;
         end;
        end;
       end;
      end else begin
       BankStream.WriteByte(0);
      end;
     end;
    end;

    begin
     UsedAll:=false;
     for j:=0 to MaxModulationMatrixItems-1 do begin
      case Track.Instruments[i].ModulationMatrix[j].Target of
       mmoChannelSpeechTextNumber:begin
        UsedAll:=true;
        break;
       end;
      end;
     end;
     for j:=0 to MaxSpeechTexts-1 do begin
      Used:=UsedAll;
      if not Used then begin
       if Track.Instruments[i].ChannelSpeech.Active and ((Track.Instruments[i].ChannelSpeech.TextNumber and $7f)=j) then begin
        Used:=true;
       end;
      end;
      if Used then begin
       BankStream.WriteByte(1);
       BankStream.WriteDWord(Track.SpeechSegmentLists[i,j].ItemCount);
       for k:=0 to Track.SpeechSegmentLists[i,j].ItemCount-1 do begin
        if BankStream.Write(Track.SpeechSegmentLists[i,j].Items^[k],sizeof(TSynthSpeechSegmentItem))<>sizeof(TSynthSpeechSegmentItem) then begin
         result:=false;
         exit;
        end;
       end;
      end else begin
       BankStream.WriteByte(0);
      end;
     end;
    end;

   end else begin
    BankStream.WriteByte(0);
   end;
  end;

  result:=true;
 except
  result:=false;
 end;
end;

function TVSTiPlugin.GenerateBMFWithBank(Stream:TBeRoStream):boolean;
var BankStream:TBeRoStream;
begin
 try
  BankStream:=TBeRoStream.Create;
  if GenerateBank(BankStream,true) then begin
   result:=GenerateBMF(Stream,BankStream);
  end else begin
   result:=false;
  end;
  BankStream.Destroy;
 except
  result:=false;
 end;
end;

function TVSTiPlugin.GenerateSynthConfigINC(Stream:TBeRoStream;WithTrack:boolean):boolean;
var InstrumentsUsed,SamplesUsed,SpeechTextsUsed:array[byte] of boolean;
    i,j,k:integer;
    MIDIEventItem:TMIDIEvent;
    ChannelPrograms:array[0..$f] of byte;
    b:boolean;
begin
 try
  if not assigned(Stream) then begin
   result:=false;
   exit;
  end;

  fillchar(InstrumentsUsed,sizeof(InstrumentsUsed),#$0);
  fillchar(SamplesUsed,sizeof(SamplesUsed),#$0);
  fillchar(SpeechTextsUsed,sizeof(SpeechTextsUsed),#$0);
  fillchar(ChannelPrograms,sizeof(ChannelPrograms),#$0);
  if WithTrack then begin
   for i:=0 to ExportMIDIEventList.Count-1 do begin
    MIDIEventItem:=ExportMIDIEventList[i];
    if not assigned(MIDIEventItem) then continue;
    case MIDIEventItem.MIDIData[0] and $f0 of
     MIDI_PROGRAMCHANGE:begin
      ChannelPrograms[MIDIEventItem.MIDIData[0] and $0f]:=MIDIEventItem.MIDIData[1];
     end;
     MIDI_NOTEON:begin
      InstrumentsUsed[ChannelPrograms[MIDIEventItem.MIDIData[0] and $0f] and $7f]:=true;
     end;
    end;
   end;
  end else begin
   for i:=0 to MaxInstruments-1 do begin
    InstrumentsUsed[i]:=true;
   end;
  end;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentOscillator-1 do begin
    if Track.Instruments[i].Oscillator[j].WaveForm=wfSAMPLE then begin
     SamplesUsed[(Track.Instruments[i].Oscillator[j].Color+64) and $7f]:=true;
    end;
   end;
   if Track.Instruments[i].ChannelSpeech.Active then begin
    SpeechTextsUsed[Track.Instruments[i].ChannelSpeech.TextNumber and $7f]:=true;
   end;
   for j:=0 to MaxModulationMatrixItems-1 do begin
    case Track.Instruments[i].ModulationMatrix[j].Target of
     mmoOscColor:begin
     if Track.Instruments[i].Oscillator[Track.Instruments[i].ModulationMatrix[j].TargetIndex and 3].WaveForm=wfSAMPLE then begin
       for k:=0 to MaxSamples-1 do begin
        SamplesUsed[k]:=true;
       end;
      end;
     end;
     mmoChannelSpeechTextNumber:begin
      for k:=0 to MaxSpeechTexts-1 do begin
       SpeechTextsUsed[k]:=true;
      end;
     end;
    end;
   end;
  end;

  b:=false;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentADSR-1 do begin
    if Track.Instruments[i].ADSR[j].Active then begin
     b:=true;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808ADSR}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808ADSR}');
  end;

  b:=false;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentLFO-1 do begin
    if Track.Instruments[i].LFO[j].WaveForm<>lwfNONE then begin
     b:=true;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808LFO}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808LFO}');
  end;

  b:=false;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentLFO-1 do begin
    if Track.Instruments[i].Filter[j].Mode<>fmNONE then begin
     b:=true;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808VOICEFILTER}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808VOICEFILTER}');
  end;

  b:=false;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentDistortion-1 do begin
    if Track.Instruments[i].VoiceDistortion[j].Mode<>dmNONE then begin
     b:=true;
     break;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808VOICEDISTORTION}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808VOICEDISTORTION}');
  end;

  b:=false;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentDistortion-1 do begin
    if Track.Instruments[i].CHannelDistortion[j].Mode<>dmNONE then begin
     b:=true;
     break;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808CHANNELDISTORTION}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808CHANNELDISTORTION}');
  end;

  b:=false;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentFilter-1 do begin
    if Track.Instruments[i].ChannelFilter[j].Mode<>fmNONE then begin
     b:=true;
     break;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808CHANNELFILTER}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808CHANNELFILTER}');
  end;

  b:=Track.Global.Delay.Active;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   for j:=0 to MaxInstrumentDelay-1 do begin
    if Track.Instruments[i].ChannelDelay[j].Active then begin
     b:=true;
     break;
    end;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808DELAY}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808DELAY}');
  end;

  b:=Track.Global.ChorusFlanger.Active;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   if Track.Instruments[i].ChannelChorusFlanger.Active then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808CHORUSFLANGER}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808CHORUSFLANGER}');
  end;

  b:=Track.Global.Compressor.Mode<>cmNONE;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   if Track.Instruments[i].ChannelCompressor.Mode<>cmNONE then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808COMPRESSOR}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808COMPRESSOR}');
  end;

  b:=Track.Global.PitchShifter.Active;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   if Track.Instruments[i].ChannelPitchShifter.Active then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808PITCHSHIFTER}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808PITCHSHIFTER}');
  end;

  b:=Track.Global.EQ.Active;
  for i:=0 to MaxInstruments-1 do begin
   if not InstrumentsUsed[i] then continue;
   if Track.Instruments[i].ChannelEQ.Active then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808EQ}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808EQ}');
  end;

  b:=Track.Global.Reverb.Active;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808REVERB}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808REVERB}');
  end;

  b:=Track.Global.EndFilter.Active;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808ENDFILTER}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808ENDFILTER}');
  end;

(*  b:=false;
  for i:=0 to MaxEnvelopes-1 do begin
   if EnvelopesUsed[i] then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808ENVELOPES}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808ENVELOPES}');
  end;*)
  Stream.WriteLine('{$DEFINE BR808ENVELOPES}');

  b:=true;
  for i:=0 to MaxSamples-1 do begin
   if SamplesUsed[i] then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808SAMPLES}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808SAMPLES}');
  end;

  b:=true;
  for i:=0 to MaxSpeechTexts-1 do begin
   if SpeechTextsUsed[i] then begin
    b:=true;
    break;
   end;
  end;
  if b then begin
   Stream.WriteLine('{$DEFINE BR808SPEECH}');
  end else begin
   Stream.WriteLine('{$UNDEF BR808SPEECH}');
  end;

  result:=true;
 except
  result:=false;
 end;
end;

function TVSTiPlugin.UpdateDisplay:boolean;
begin
 if assigned(VSTAudioMaster) then begin
  result:=VSTAudioMaster(@VSTEffect,audioMasterUpdateDisplay,0,0,nil,0)<>0;
 end else begin
  result:=false;
 end;
end;

constructor TVSTiPluginEditor.Create(AEffect:TVSTiPlugin);
begin
 inherited Create;
 Effect:=AEffect;
 UseCount:=0;
 Editor:=nil;
 FirstIdle:=true;
end;

destructor TVSTiPluginEditor.Destroy;
begin
 try
  if assigned(Editor) then begin
   Plugin.Done:=true;
   Editor.Free;
   Editor:=nil;
   SystemWindow:=0;
  end;
 except
 end;
 inherited Destroy;
end;

function TVSTiPluginEditor.GetRect(var Rect:PERect):longint;
begin
 try
  R.Top:=0;
  R.Left:=0;
  if assigned(Editor) then begin
   R.Bottom:=Editor.ClientHeight;
   R.Right:=Editor.ClientWidth;
   result:=1;
  end else begin
   R.Bottom:=507;
   R.Right:=1005;
   result:=0;
  end;
  Rect:=@R;
 except
  result:=0;
 end;
end;

function TVSTiPluginEditor.Open(Ptr:pointer):longint;
begin
 try
{$IFDEF DisabledGUI}
  result:=0;
  exit;
{$ENDIF}
  SystemWindow:=HWnd(Ptr);
  inc(UseCount);
  if (UseCount=1) or not assigned(Editor) then begin
   Editor:=TVSTiEditor.CreateParented(SystemWindow);
   Editor.AudioCriticalSection:=Plugin.AudioCriticalSection;
   Editor.DataCriticalSection:=Plugin.DataCriticalSection;
   Editor.Plugin:=Plugin;
   Editor.SetBounds(0,0,Editor.Width,Editor.Height);
  end;
  Plugin.Done:=false;
  Editor.Update;
  Editor.UpdateColorsControls;
  Editor.UpdateColors;
  Update;
  result:=1;
 except
  result:=0;
 end;
end;

procedure TVSTiPluginEditor.Close;
begin
 dec(UseCount);
 if UseCount<0 then UseCount:=0;
 if (UseCount=0) and assigned(Editor) then begin
  Plugin.Done:=true;
  Editor.Free;
  Editor:=nil;
  SystemWindow:=0;
 end;
end;

procedure TVSTiPluginEditor.Idle;
begin
 try
  if assigned(Editor) and not Plugin.Done then begin
   if FirstIdle then begin
    FirstIdle:=false;
    Update;
   end;
  end;
 except
 end;
end;

procedure TVSTiPluginEditor.Update;
begin
 if assigned(Editor) and not Plugin.Done then begin
  Editor.OldPatchNr:=-1;
  Editor.BankWasChanged:=true;
  Editor.EditorUpdate;
 end;
end;

procedure TVSTiPluginEditor.UpdateEx;
begin
 try
  if assigned(Editor) and not Plugin.Done then begin
   Editor.OldPatchNr:=-1;
   Editor.BankWasChanged:=true;
   Editor.EditorUpdate;
   Editor.UpdateColorsControls;
   Editor.UpdateColors;
  end;
 except
 end;
end;

function TVSTiPluginEditor.GetPlugin:TVSTiPlugin;
begin
 result:=Effect;
end;

procedure AddVSTiPlugin(VSTiPlugin:TVSTiPlugin); register;
begin
 try
  if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) and assigned(InstanceInfo^.VSTiPluginInstancesList) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
   try
    InstanceInfo^.VSTiPluginInstancesList.Add(VSTiPlugin);
    inc(InstanceInfo^.NumberOfVSTiPluginInstances);
   except
   end;
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
  end;
 except
 end;
end;

procedure RemoveVSTiPlugin(VSTiPlugin:TVSTiPlugin); register;
begin
 try
  if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) and assigned(InstanceInfo^.VSTiPluginInstancesList) then begin
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
   try
    dec(InstanceInfo^.NumberOfVSTiPluginInstances);
    InstanceInfo^.VSTiPluginInstancesList.Remove(VSTiPlugin);
   except
   end;
   InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
  end;
 except
 end;
end;

var MappingHandle:THandle;
    MappingName:string;

procedure AddInstance;
begin
 try
  InstanceInfo:=nil;
  QueryPerformanceCounter(InstanceID);
  ProcessID:=GetCurrentProcessId;
  MappingName:='br808instancesonprocess'+inttostr(ProcessID);
  MappingHandle:=CreateFileMapping($ffffffff,nil,PAGE_READWRITE,0,sizeof(TInstanceInfo),pchar(MappingName));
  if MappingHandle<>0 then begin
   if GetLastError<>ERROR_ALREADY_EXISTS then begin
    InstanceInfo:=MapViewOfFile(MappingHandle,FILE_MAP_ALL_ACCESS,0,0,sizeof(TInstanceInfo));
    fillchar(InstanceInfo^,sizeof(TInstanceInfo),#0);
    InstanceInfo^.ProcessID:=not ProcessID;
   end else begin
    MappingHandle:=OpenFileMapping(FILE_MAP_ALL_ACCESS,false,pchar(MappingName));
    if MappingHandle<>0 then begin
     InstanceInfo:=MapViewOfFile(MappingHandle,FILE_MAP_ALL_ACCESS,0,0,sizeof(TInstanceInfo));
    end;
   end;
   if InstanceInfo^.ProcessID<>ProcessID then begin
    InstanceInfo^.Instance:=hInstance;
    InstanceInfo^.InstanceID:=InstanceID;
    InstanceInfo^.ProcessID:=ProcessID;
    InstanceInfo^.NumberOfVSTiPluginInstances:=0;
    InstanceInfo^.VSTiPluginInstancesCriticalSection:=TBeRoCriticalSection.Create;
    InstanceInfo^.VSTiPluginInstancesList:=TList.Create;
    InstanceInfo^.AddVSTiPlugin:=AddVSTiPlugin;
    InstanceInfo^.RemoveVSTiPlugin:=RemoveVSTiPlugin;
   end;
  end;
 except
 end;
end;

procedure RemoveInstance;
begin
 try
  MappingHandle:=OpenFileMapping(FILE_MAP_ALL_ACCESS,false,pchar(MappingName));
  if MappingHandle<>0 then begin
   InstanceInfo:=MapViewOfFile(MappingHandle,FILE_MAP_ALL_ACCESS,0,0,sizeof(TInstanceInfo));
   if InstanceInfo^.Instance=hInstance then begin
    if InstanceInfo^.InstanceID=InstanceID then begin
     if InstanceInfo^.ProcessID=ProcessID then begin
      InstanceInfo^.VSTiPluginInstancesCriticalSection.Destroy;
      InstanceInfo^.VSTiPluginInstancesCriticalSection:=nil;
      InstanceInfo^.VSTiPluginInstancesList.Destroy;
      InstanceInfo^.VSTiPluginInstancesList:=nil;
      InstanceInfo^.AddVSTiPlugin:=nil;
      InstanceInfo^.RemoveVSTiPlugin:=nil;
      fillchar(InstanceInfo^,sizeof(TInstanceInfo),#0);
     end;
    end;
   end;
  end;
  if assigned(InstanceInfo) then begin
   UnmapViewOfFile(InstanceInfo);
  end;
  if MappingHandle<>0 then begin
   CloseHandle(MappingHandle);
  end;
 except
 end;
end;

initialization
 AddInstance;
finalization
 RemoveInstance;
end.
