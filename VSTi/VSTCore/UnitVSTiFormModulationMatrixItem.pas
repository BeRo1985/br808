(* Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * Licensed under the terms of the LGPL V3 or later, see LGPLv3.txt or
 * http://www.gnu.org/licenses/lgpl.html for details
 *)
unit UnitVSTiFormModulationMatrixItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, UnitVSTiGUI, StdCtrls, Synth, BeRoCriticalSection;

type
  TFormModulationMatrixItem = class(TForm)
    SGTK0Panel45: TSGTK0Panel;
    SGTK0Panel1: TSGTK0Panel;
    Label1: TLabel;
    ComboBoxSource: TSGTK0ComboBox;
    ComboBoxSourceIndex: TSGTK0ComboBox;
    SGTK0Panel2: TSGTK0Panel;
    Label2: TLabel;
    ComboBoxTarget: TSGTK0ComboBox;
    ComboBoxTargetIndex: TSGTK0ComboBox;
    ScrollbarAmount: TSGTK0Scrollbar;
    ListBoxPolarity: TSGTK0ListBox;
    PanelNr: TSGTK0Panel;
    ButtonDelete: TSGTK0Button;
    SGTK0ComboBoxSourceMode: TSGTK0ComboBox;
    SGTK0CheckBoxInverse: TSGTK0CheckBox;
    SGTK0CheckBoxRamping: TSGTK0CheckBox;
    SGTK0ButtonUp: TSGTK0Button;
    SGTK0ButtonDown: TSGTK0Button;
    procedure FormCreate(Sender: TObject);
    procedure ScrollbarAmountScroll(Sender: TObject; ScrollPos: Integer);
    procedure ListBoxPolarityClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ComboBoxSourceChange(Sender: TObject);
    procedure ComboBoxSourceIndexChange(Sender: TObject);
    procedure ComboBoxTargetChange(Sender: TObject);
    procedure ComboBoxTargetIndexChange(Sender: TObject);
    procedure SGTK0ComboBoxSourceModeChange(Sender: TObject);
    procedure SGTK0CheckBoxInverseClick(Sender: TObject);
    procedure SGTK0CheckBoxRampingClick(Sender: TObject);
    procedure SGTK0ButtonUpClick(Sender: TObject);
    procedure SGTK0ButtonDownClick(Sender: TObject);
  private
    { Private declarations }
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public declarations }
    ModulationMatrixItem:PSynthInstrumentModulationMatrixItem;
    Nr:INTEGER;
    InChange:BOOLEAN;
    AudioCriticalSection:TBeRoCriticalSection;
    DataCriticalSection:TBeRoCriticalSection;
    HostEditorUpdate:PROCEDURE OF OBJECT;
    DeleteModulationMatrixItem:PROCEDURE(Index:INTEGER) OF OBJECT;
    DoUp:procedure(Sender: TObject) OF OBJECT;
    DoDown:procedure(Sender: TObject) OF OBJECT;
    PROCEDURE EditorUpdate;
  end;

var
  FormModulationMatrixItem: TFormModulationMatrixItem;

implementation

{$R *.DFM}

procedure TFormModulationMatrixItem.FormCreate(Sender: TObject);
begin
 ModulationMatrixItem:=NIL;
 InChange:=FALSE;
 AudioCriticalSection:=nil;
 DataCriticalSection:=nil;
 DeleteModulationMatrixItem:=NIL;
 DoUp:=nil;
 DoDown:=nil;
end;

PROCEDURE TFormModulationMatrixItem.EditorUpdate;
VAR Counter:INTEGER;
    S:STRING;
BEGIN
 IF NOT ASSIGNED(ModulationMatrixItem) THEN EXIT;

 ComboBoxSource.ItemIndex:=ModulationMatrixItem^.Source;

 ComboBoxSourceIndex.Items.BeginUpdate;
 ComboBoxSourceIndex.Items.Clear;
 CASE ModulationMatrixItem^.Source OF
  mmiADSR,mmiENV,mmiLFO,mmiMEMORY:BEGIN
   FOR Counter:=1 TO 8 DO BEGIN
    ComboBoxSourceIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.SourceIndex>7 THEN BEGIN
    ModulationMatrixItem^.SourceIndex:=7;
   END;
  END;
  mmiVALUE,mmiNRPN:BEGIN
   FOR Counter:=0 TO 255 DO BEGIN
    S:=INTTOSTR(Counter);
    WHILE LENGTH(S)<3 DO BEGIN
     S:='0'+S;
    END;
    ComboBoxSourceIndex.Items.Add(S);
   END;
  END;
  mmiCONTROLLER:BEGIN
   FOR Counter:=0 TO 127 DO BEGIN
    S:=INTTOSTR(Counter);
    WHILE LENGTH(S)<3 DO BEGIN
     S:='0'+S;
    END;
    ComboBoxSourceIndex.Items.Add(S);
   END;
  END;
  mmiVALUEEXT:BEGIN
   FOR Counter:=0 TO 255 DO BEGIN
    S:=INTTOSTR(Counter);
    WHILE LENGTH(S)<3 DO BEGIN
     S:='0'+S;
    END;
    ComboBoxSourceIndex.Items.Add(S);
   END;
  END;
  mmiRESCALE:BEGIN
   FOR Counter:=0 TO 255 DO BEGIN
    S:=INTTOSTR(Counter);
    WHILE LENGTH(S)<3 DO BEGIN
     S:='0'+S;
    END;
    ComboBoxSourceIndex.Items.Add(S);
   END;
  END;
  mmiINVRESCALE:BEGIN
   FOR Counter:=0 TO 255 DO BEGIN
    S:=INTTOSTR(Counter);
    WHILE LENGTH(S)<3 DO BEGIN
     S:='0'+S;
    END;
    ComboBoxSourceIndex.Items.Add(S);
   END;
  END;
  ELSE BEGIN
   ModulationMatrixItem^.SourceIndex:=0;
   ComboBoxSourceIndex.Items.Add('-');
  END;
 END;
 ComboBoxSourceIndex.Items.EndUpdate;

 ComboBoxSourceIndex.ItemIndex:=ModulationMatrixItem^.SourceIndex;

 SGTK0CheckBoxInverse.Checked:=(ModulationMatrixItem^.SourceFlags and 1)<>0;
 SGTK0CheckBoxRamping.Checked:=(ModulationMatrixItem^.SourceFlags and 2)<>0;

 SGTK0ComboBoxSourceMode.ItemIndex:=ModulationMatrixItem^.SourceMode;

 CASE ModulationMatrixItem^.Target OF
  mmoGlobalChannelVolume:ComboBoxTarget.ItemIndex:=0;
  mmoGlobalOutput:ComboBoxTarget.ItemIndex:=1;
  mmoGlobalReverb:ComboBoxTarget.ItemIndex:=2;
  mmoGlobalDelay:ComboBoxTarget.ItemIndex:=3;
  mmoGlobalChorusFlanger:ComboBoxTarget.ItemIndex:=4;
  mmoVolume:ComboBoxTarget.ItemIndex:=5;
  mmoPanning:ComboBoxTarget.ItemIndex:=6;
  mmoTranspose:ComboBoxTarget.ItemIndex:=7;
  mmoPitch:ComboBoxTarget.ItemIndex:=8;
  mmoOscTranspose:ComboBoxTarget.ItemIndex:=9;
  mmoOscPitch:ComboBoxTarget.ItemIndex:=10;
  mmoOscFeedBack:ComboBoxTarget.ItemIndex:=11;
  mmoOscColor:ComboBoxTarget.ItemIndex:=12;
  mmoOscVolume:ComboBoxTarget.ItemIndex:=13;
  mmoOscHardSync:ComboBoxTarget.ItemIndex:=14;
  mmoOscGlide:ComboBoxTarget.ItemIndex:=15;
  mmoOscSmpPos:ComboBoxTarget.ItemIndex:=16;
  mmoOscPluckedStringReflection:ComboBoxTarget.ItemIndex:=17;
  mmoOscPluckedStringPick:ComboBoxTarget.ItemIndex:=18;
  mmoOscPluckedStringPickUp:ComboBoxTarget.ItemIndex:=19;
  mmoOscSuperOscDetune:ComboBoxTarget.ItemIndex:=20;
  mmoOscSuperOscMix:ComboBoxTarget.ItemIndex:=21;
  mmoFilterCutOff:ComboBoxTarget.ItemIndex:=22;
  mmoFilterResonance:ComboBoxTarget.ItemIndex:=23;
  mmoFilterVolume:ComboBoxTarget.ItemIndex:=24;
  mmoFilterAmplify:ComboBoxTarget.ItemIndex:=25;
  mmoADSRAttack:ComboBoxTarget.ItemIndex:=26;
  mmoADSRDecay:ComboBoxTarget.ItemIndex:=27;
  mmoADSRSustain:ComboBoxTarget.ItemIndex:=28;
  mmoADSRRelease:ComboBoxTarget.ItemIndex:=29;
  mmoADSRDecayLevel:ComboBoxTarget.ItemIndex:=30;
  mmoADSRAmplify:ComboBoxTarget.ItemIndex:=31;
  mmoEnvelopeAmplify:ComboBoxTarget.ItemIndex:=32;
  mmoLFORate:ComboBoxTarget.ItemIndex:=33;
  mmoLFOPhase:ComboBoxTarget.ItemIndex:=34;
  mmoLFODepth:ComboBoxTarget.ItemIndex:=35;
  mmoLFOMiddle:ComboBoxTarget.ItemIndex:=36;
  mmoVoiceDistortionGain:ComboBoxTarget.ItemIndex:=37;
  mmoVoiceDistortionDist:ComboBoxTarget.ItemIndex:=38;
  mmoVoiceDistortionRate:ComboBoxTarget.ItemIndex:=39;
  mmoChannelDistortionGain:ComboBoxTarget.ItemIndex:=40;
  mmoChannelDistortionDist:ComboBoxTarget.ItemIndex:=41;
  mmoChannelDistortionRate:ComboBoxTarget.ItemIndex:=42;
  mmoChannelFilterCutOff:ComboBoxTarget.ItemIndex:=43;
  mmoChannelFilterResonance:ComboBoxTarget.ItemIndex:=44;
  mmoChannelFilterVolume:ComboBoxTarget.ItemIndex:=45;
  mmoChannelFilterAmplify:ComboBoxTarget.ItemIndex:=46;
  mmoChannelDelayTimeLeft:ComboBoxTarget.ItemIndex:=47;
  mmoChannelDelayFeedBackLeft:ComboBoxTarget.ItemIndex:=48;
  mmoChannelDelayTimeRight:ComboBoxTarget.ItemIndex:=49;
  mmoChannelDelayFeedBackRight:ComboBoxTarget.ItemIndex:=50;
  mmoChannelDelayWet:ComboBoxTarget.ItemIndex:=51;
  mmoChannelDelayDry:ComboBoxTarget.ItemIndex:=52;
  mmoChannelChorusFlangerTimeLeft:ComboBoxTarget.ItemIndex:=53;
  mmoChannelChorusFlangerFeedBackLeft:ComboBoxTarget.ItemIndex:=54;
  mmoChannelChorusFlangerLFORateLeft:ComboBoxTarget.ItemIndex:=55;
  mmoChannelChorusFlangerLFODepthLeft:ComboBoxTarget.ItemIndex:=56;
  mmoChannelChorusFlangerLFOPhaseLeft:ComboBoxTarget.ItemIndex:=57;
  mmoChannelChorusFlangerTimeRight:ComboBoxTarget.ItemIndex:=58;
  mmoChannelChorusFlangerFeedBackRight:ComboBoxTarget.ItemIndex:=59;
  mmoChannelChorusFlangerLFORateRight:ComboBoxTarget.ItemIndex:=60;
  mmoChannelChorusFlangerLFODepthRight:ComboBoxTarget.ItemIndex:=61;
  mmoChannelChorusFlangerLFOPhaseRight:ComboBoxTarget.ItemIndex:=62;
  mmoChannelChorusFlangerWet:ComboBoxTarget.ItemIndex:=63;
  mmoChannelChorusFlangerDry:ComboBoxTarget.ItemIndex:=64;
  mmoChannelCompressorWindowSize:ComboBoxTarget.ItemIndex:=65;
  mmoChannelCompressorSoftHardKnee:ComboBoxTarget.ItemIndex:=66;
  mmoChannelCompressorThreshold:ComboBoxTarget.ItemIndex:=67;
  mmoChannelCompressorRatio:ComboBoxTarget.ItemIndex:=68;
  mmoChannelCompressorAttack:ComboBoxTarget.ItemIndex:=69;
  mmoChannelCompressorRelease:ComboBoxTarget.ItemIndex:=70;
  mmoChannelCompressorOutGain:ComboBoxTarget.ItemIndex:=71;
  mmoChannelSpeechTextNumber:ComboBoxTarget.ItemIndex:=72;
  mmoChannelSpeechSpeed:ComboBoxTarget.ItemIndex:=73;
  mmoChannelSpeechColor:ComboBoxTarget.ItemIndex:=74;
  mmoChannelSpeechNoiseGain:ComboBoxTarget.ItemIndex:=75;
  mmoChannelSpeechGain:ComboBoxTarget.ItemIndex:=76;
  mmoChannelSpeechPosition:ComboBoxTarget.ItemIndex:=77;
  mmoChannelSpeechCascadeGain:ComboBoxTarget.ItemIndex:=78;
  mmoChannelSpeechParallelGain:ComboBoxTarget.ItemIndex:=79;
  mmoChannelSpeechAspirationGain:ComboBoxTarget.ItemIndex:=80;
  mmoChannelSpeechFricationGain:ComboBoxTarget.ItemIndex:=81;
  mmoChannelPitchShifterTune:ComboBoxTarget.ItemIndex:=82;
  mmoChannelPitchShifterFineTune:ComboBoxTarget.ItemIndex:=83;
  mmoChannelEQGain0:ComboBoxTarget.ItemIndex:=84;
  mmoChannelEQGain1:ComboBoxTarget.ItemIndex:=85;
  mmoChannelEQGain2:ComboBoxTarget.ItemIndex:=86;
  mmoChannelEQGain3:ComboBoxTarget.ItemIndex:=87;
  mmoChannelEQGain4:ComboBoxTarget.ItemIndex:=88;
  mmoChannelEQGain5:ComboBoxTarget.ItemIndex:=89;
  mmoChannelEQGain6:ComboBoxTarget.ItemIndex:=90;
  mmoChannelEQGain7:ComboBoxTarget.ItemIndex:=91;
  mmoChannelEQGain8:ComboBoxTarget.ItemIndex:=92;
  mmoChannelEQGain9:ComboBoxTarget.ItemIndex:=93;
  mmoMEMORY:ComboBoxTarget.ItemIndex:=94;
  ELSE ComboBoxTarget.ItemIndex:=0;
 END;

 ComboBoxTargetIndex.Items.BeginUpdate;
 ComboBoxTargetIndex.Items.Clear;
 CASE ModulationMatrixItem^.Target OF
   mmoOscTranspose,mmoOscPitch,mmoOscFeedBack,mmoOscColor,mmoOscVolume,
   mmoOscHardSync,mmoOscGlide,mmoOscPluckedStringReflection,mmoOscPluckedStringPick,mmoOscPluckedStringPickUp,
   mmoOscSuperOscDetune,mmoOscSuperOscMix:BEGIN
   FOR Counter:=1 TO MaxInstrumentOscillator DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentOscillator THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentOscillator-1;
   END;
  END;
  mmoFilterCutOff,mmoFilterResonance,mmoFilterVolume,mmoFilterAmplify,
  mmoChannelFilterCutOff,mmoChannelFilterResonance,mmoChannelFilterVolume,
  mmoChannelFilterAmplify:BEGIN
   FOR Counter:=1 TO MaxInstrumentFilter DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentFilter THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentFilter-1;
   END;
  END;
  mmoChannelDelayTimeLeft,mmoChannelDelayFeedBackLeft,mmoChannelDelayTimeRight,mmoChannelDelayFeedBackRight,
  mmoChannelDelayWet,mmoChannelDelayDry:begin
   FOR Counter:=1 TO MaxInstrumentDelay DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentDelay THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentDelay-1;
   END;
  end;
  mmoADSRAttack,mmoADSRDecay,mmoADSRSustain,mmoADSRRelease,mmoADSRDecayLevel,
  mmoADSRAmplify:BEGIN
   FOR Counter:=1 TO MaxInstrumentADSR DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentADSR THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentADSR-1;
   END;
  END;
  mmoEnvelopeAmplify:BEGIN
   FOR Counter:=1 TO MaxInstrumentEnvelopes DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentEnvelopes THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentEnvelopes-1;
   END;
  END;
  mmoLFORate,mmoLFOPhase,mmoLFODepth,mmoLFOMiddle:BEGIN
   FOR Counter:=1 TO MaxInstrumentLFO DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentLFO THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentLFO-1;
   END;
  END;
  mmoVoiceDistortionGain,mmoVoiceDistortionDist,mmoVoiceDistortionRate,
  mmoChannelDistortionGain,mmoChannelDistortionDist,mmoChannelDistortionRate:begin
   FOR Counter:=1 TO MaxInstrumentDistortion DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxInstrumentDistortion THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxInstrumentDistortion-1;
   END;
  end;
  mmoMEMORY:BEGIN
   FOR Counter:=1 TO MaxModulationMatrixMemory DO BEGIN
    ComboBoxTargetIndex.Items.Add(INTTOSTR(Counter));
   END;
   IF ModulationMatrixItem^.TargetIndex>=MaxModulationMatrixMemory THEN BEGIN
    ModulationMatrixItem^.TargetIndex:=MaxModulationMatrixMemory-1;
   END;
  END;
  ELSE BEGIN
   ModulationMatrixItem^.TargetIndex:=0;
   ComboBoxTargetIndex.Items.Add('-');
  END;
 END;
 ComboBoxTargetIndex.Items.EndUpdate;
 ComboBoxTargetIndex.ItemIndex:=ModulationMatrixItem^.TargetIndex;

 ListBoxPolarity.ItemIndex:=ModulationMatrixItem^.Polarity;
 ScrollbarAmount.Position:=ModulationMatrixItem^.Amount;
 ScrollbarAmountScroll(NIL,ScrollbarAmount.Position);
END;

procedure TFormModulationMatrixItem.ScrollbarAmountScroll(Sender: TObject;
  ScrollPos: Integer);
VAR S:STRING;
begin
 S:=INTTOSTR(ScrollPos);
 IF (LENGTH(S)=2) AND (POS('-',S)=1) THEN BEGIN
  INSERT('0',S,2);
 END;
 WHILE LENGTH(S)<2 DO BEGIN
  S:='0'+S;
 END;
 WHILE LENGTH(S)<3 DO BEGIN
  S:=' '+S;
 END;
 ScrollbarAmount.Track.Caption:=S;
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   ModulationMatrixItem^.Amount:=ScrollPos;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.ListBoxPolarityClick(Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   ModulationMatrixItem^.Polarity:=ListBoxPolarity.ItemIndex;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.ButtonDeleteClick(Sender: TObject);
begin
 IF ASSIGNED(DeleteModulationMatrixItem) AND NOT InChange THEN BEGIN
  DeleteModulationMatrixItem(Nr);
 END;
end;

procedure TFormModulationMatrixItem.ComboBoxSourceChange(Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   ModulationMatrixItem^.Source:=ComboBoxSource.ItemIndex;
   InChange:=TRUE;
   TRY
    EditorUpdate;
   EXCEPT
   END;
   InChange:=FALSE;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.ComboBoxSourceIndexChange(
  Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   ModulationMatrixItem^.SourceIndex:=ComboBoxSourceIndex.ItemIndex;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.ComboBoxTargetChange(Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   CASE ComboBoxTarget.ItemIndex OF
    0:ModulationMatrixItem^.Target:=mmoGlobalChannelVolume;
    1:ModulationMatrixItem^.Target:=mmoGlobalOutput;
    2:ModulationMatrixItem^.Target:=mmoGlobalReverb;
    3:ModulationMatrixItem^.Target:=mmoGlobalDelay;
    4:ModulationMatrixItem^.Target:=mmoGlobalChorusFlanger;
    5:ModulationMatrixItem^.Target:=mmoVolume;
    6:ModulationMatrixItem^.Target:=mmoPanning;
    7:ModulationMatrixItem^.Target:=mmoTranspose;
    8:ModulationMatrixItem^.Target:=mmoPitch;
    9:ModulationMatrixItem^.Target:=mmoOscTranspose;
    10:ModulationMatrixItem^.Target:=mmoOscPitch;
    11:ModulationMatrixItem^.Target:=mmoOscFeedBack;
    12:ModulationMatrixItem^.Target:=mmoOscColor;
    13:ModulationMatrixItem^.Target:=mmoOscVolume;
    14:ModulationMatrixItem^.Target:=mmoOscHardSync;
    15:ModulationMatrixItem^.Target:=mmoOscGlide;
    16:ModulationMatrixItem^.Target:=mmoOscSmpPos;
    17:ModulationMatrixItem^.Target:=mmoOscPluckedStringReflection;
    18:ModulationMatrixItem^.Target:=mmoOscPluckedStringPick;
    19:ModulationMatrixItem^.Target:=mmoOscPluckedStringPickUp;
    20:ModulationMatrixItem^.Target:=mmoOscSuperOscDetune;
    21:ModulationMatrixItem^.Target:=mmoOscSuperOscMix;
    22:ModulationMatrixItem^.Target:=mmoFilterCutOff;
    23:ModulationMatrixItem^.Target:=mmoFilterResonance;
    24:ModulationMatrixItem^.Target:=mmoFilterVolume;
    25:ModulationMatrixItem^.Target:=mmoFilterAmplify;
    26:ModulationMatrixItem^.Target:=mmoADSRAttack;
    27:ModulationMatrixItem^.Target:=mmoADSRDecay;
    28:ModulationMatrixItem^.Target:=mmoADSRSustain;
    29:ModulationMatrixItem^.Target:=mmoADSRRelease;
    30:ModulationMatrixItem^.Target:=mmoADSRDecayLevel;
    31:ModulationMatrixItem^.Target:=mmoADSRAmplify;
    32:ModulationMatrixItem^.Target:=mmoEnvelopeAmplify;
    33:ModulationMatrixItem^.Target:=mmoLFORate;
    34:ModulationMatrixItem^.Target:=mmoLFOPhase;
    35:ModulationMatrixItem^.Target:=mmoLFODepth;
    36:ModulationMatrixItem^.Target:=mmoLFOMiddle;
    37:ModulationMatrixItem^.Target:=mmoVoiceDistortionGain;
    38:ModulationMatrixItem^.Target:=mmoVoiceDistortionDist;
    39:ModulationMatrixItem^.Target:=mmoVoiceDistortionRate;
    40:ModulationMatrixItem^.Target:=mmoChannelDistortionGain;
    41:ModulationMatrixItem^.Target:=mmoChannelDistortionDist;
    42:ModulationMatrixItem^.Target:=mmoChannelDistortionRate;
    43:ModulationMatrixItem^.Target:=mmoChannelFilterCutOff;
    44:ModulationMatrixItem^.Target:=mmoChannelFilterResonance;
    45:ModulationMatrixItem^.Target:=mmoChannelFilterVolume;
    46:ModulationMatrixItem^.Target:=mmoChannelFilterAmplify;
    47:ModulationMatrixItem^.Target:=mmoChannelDelayTimeLeft;
    48:ModulationMatrixItem^.Target:=mmoChannelDelayFeedBackLeft;
    49:ModulationMatrixItem^.Target:=mmoChannelDelayTimeRight;
    50:ModulationMatrixItem^.Target:=mmoChannelDelayFeedBackRight;
    51:ModulationMatrixItem^.Target:=mmoChannelDelayWet;
    52:ModulationMatrixItem^.Target:=mmoChannelDelayDry;
    53:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerTimeLeft;
    54:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerFeedBackLeft;
    55:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerLFORateLeft;
    56:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerLFODepthLeft;
    57:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerLFOPhaseLeft;
    58:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerTimeRight;
    59:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerFeedBackRight;
    60:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerLFORateRight;
    61:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerLFODepthRight;
    62:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerLFOPhaseRight;
    63:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerWet;
    64:ModulationMatrixItem^.Target:=mmoChannelChorusFlangerDry;
    65:ModulationMatrixItem^.Target:=mmoChannelCompressorWindowSize;
    66:ModulationMatrixItem^.Target:=mmoChannelCompressorSoftHardKnee;
    67:ModulationMatrixItem^.Target:=mmoChannelCompressorThreshold;
    68:ModulationMatrixItem^.Target:=mmoChannelCompressorRatio;
    69:ModulationMatrixItem^.Target:=mmoChannelCompressorAttack;
    70:ModulationMatrixItem^.Target:=mmoChannelCompressorRelease;
    71:ModulationMatrixItem^.Target:=mmoChannelCompressorOutGain;
    72:ModulationMatrixItem^.Target:=mmoChannelSpeechTextNumber;
    73:ModulationMatrixItem^.Target:=mmoChannelSpeechSpeed;
    74:ModulationMatrixItem^.Target:=mmoChannelSpeechColor;
    75:ModulationMatrixItem^.Target:=mmoChannelSpeechNoiseGain;
    76:ModulationMatrixItem^.Target:=mmoChannelSpeechGain;
    77:ModulationMatrixItem^.Target:=mmoChannelSpeechPosition;
    78:ModulationMatrixItem^.Target:=mmoChannelPitchShifterTune;
    79:ModulationMatrixItem^.Target:=mmoChannelPitchShifterFineTune;
    80:ModulationMatrixItem^.Target:=mmoChannelSpeechCascadeGain;
    81:ModulationMatrixItem^.Target:=mmoChannelSpeechParallelGain;
    82:ModulationMatrixItem^.Target:=mmoChannelSpeechAspirationGain;
    83:ModulationMatrixItem^.Target:=mmoChannelSpeechFricationGain;
    84:ModulationMatrixItem^.Target:=mmoChannelEQGain0;
    85:ModulationMatrixItem^.Target:=mmoChannelEQGain1;
    86:ModulationMatrixItem^.Target:=mmoChannelEQGain2;
    87:ModulationMatrixItem^.Target:=mmoChannelEQGain3;
    88:ModulationMatrixItem^.Target:=mmoChannelEQGain4;
    89:ModulationMatrixItem^.Target:=mmoChannelEQGain5;
    90:ModulationMatrixItem^.Target:=mmoChannelEQGain6;
    91:ModulationMatrixItem^.Target:=mmoChannelEQGain7;
    92:ModulationMatrixItem^.Target:=mmoChannelEQGain8;
    93:ModulationMatrixItem^.Target:=mmoChannelEQGain9;
    94:ModulationMatrixItem^.Target:=mmoMEMORY;
   END;
   InChange:=TRUE;
   TRY
    EditorUpdate;
   FINALLY
    InChange:=FALSE;
   END;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.ComboBoxTargetIndexChange(
  Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   ModulationMatrixItem^.TargetIndex:=ComboBoxTargetIndex.ItemIndex;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.SGTK0ComboBoxSourceModeChange(
  Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   ModulationMatrixItem^.SourceMode:=SGTK0ComboBoxSourceMode.ItemIndex;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.SGTK0CheckBoxInverseClick(
  Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   if SGTK0CheckBoxInverse.Checked then begin
    ModulationMatrixItem^.SourceFlags:=ModulationMatrixItem^.SourceFlags or 1;
   end else begin
    ModulationMatrixItem^.SourceFlags:=ModulationMatrixItem^.SourceFlags and not 1;
   end;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.Result:=1;
end;

procedure TFormModulationMatrixItem.SGTK0CheckBoxRampingClick(
  Sender: TObject);
begin
 IF ASSIGNED(DataCriticalSection) AND NOT InChange THEN BEGIN
  DataCriticalSection.Enter;
  TRY
   if SGTK0CheckBoxRamping.Checked then begin
    ModulationMatrixItem^.SourceFlags:=ModulationMatrixItem^.SourceFlags or 2;
   end else begin
    ModulationMatrixItem^.SourceFlags:=ModulationMatrixItem^.SourceFlags and not 2;
   end;
  finally
   DataCriticalSection.Leave;
  END;
 END;
end;

procedure TFormModulationMatrixItem.SGTK0ButtonUpClick(Sender: TObject);
begin
 if assigned(DoUp) then begin
  DoUp(self);
 end;
end;

procedure TFormModulationMatrixItem.SGTK0ButtonDownClick(Sender: TObject);
begin
 if assigned(DoDown) then begin
  DoDown(self);
 end;
end;

end.
