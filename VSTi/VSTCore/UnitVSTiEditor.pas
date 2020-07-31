(* Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * Licensed under the terms of the LGPL V3 or later, see LGPLv3.txt or
 * http://www.gnu.org/licenses/lgpl.html for details
 *)
unit UnitVSTiEditor;

interface

uses PEUtilsEx{,Core},
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImgList, BeRoStream, Registry, Math, BeRoPascalScript,
  BeRoCriticalSection,Spin, ComCtrls, CheckLst, Synth, MMSYSTEM,
  UnitFormEnvelopeEditor, AppEvnts, Menus, UnitVSTiGUI,
  UnitVSTiFormModulationMatrixitem, UnitWaveEditor, BeRoUtils, BeRoFFT,
  BeRoStringToDouble, BeRoDoubleToString, SynEdit;

const Software='BR808';
      RegPath='Software\Benjamin Rosseaux\'+Software+'\';

      MaxVisibleModulationMatrixItems=2;

type
  TVSTiEditor = class(TForm)
    SGTK0Panel1X: TSGTK0Panel;
    TopPanel: TSGTK0Panel;
    PanelTitle: TSGTK0Panel;
    TabSheetSampleLoop: TSGTK0TabSheet;
    TabSheetSampleSustainLoop: TSGTK0TabSheet;
    TabSheetInstrumentChannelLFO: TSGTK0TabSheet;
    TabSheetSamplePadSynthHarmonics: TSGTK0TabSheet;
    TabSheetInstrumentLink: TSGTK0TabSheet;
    TabSheetGlobalsOutput: TSGTK0TabSheet;
    TabSheetGlobalsRamping: TSGTK0TabSheet;
    TabSheetInstrumentController: TSGTK0TabSheet;
    TabSheetInstrumentTunings: TSGTK0TabSheet;
    TabSheetSampleScript: TSGTK0TabSheet;
    LabelTitleVersion: TLabel;
    PanelCopyright: TSGTK0Panel;
    LabelCopyright: TLabel;
    Panel2: TSGTK0Panel;
    Panel3: TSGTK0Panel;
    PaintBoxPeakLeft: TPaintBox;
    PaintBoxPeakRight: TPaintBox;
    Panel10: TSGTK0Panel;
    PanelTop: TSGTK0Panel;
    SGTK0Panel5: TSGTK0Panel;
    SGTK0Panel4: TSGTK0Panel;
    PageControlGlobal: TSGTK0PageControl;
    TabSheetInstruments: TSGTK0TabSheet;
    TabSheetEnvEdit: TSGTK0TabSheet;
    Panel5: TSGTK0Panel;
    Panel7: TSGTK0Panel;
    Panel21: TSGTK0Panel;
    Panel77: TSGTK0Panel;
    Label7: TLabel;
    EditInstrumentName: TSGTK0Edit;
    PanelInstrumentNr: TSGTK0Panel;
    ButtonPreviousInstrument: TSGTK0Button;
    ButtonNextInstrument: TSGTK0Button;
    ButtonSetToChannel: TSGTK0Button;
    ComboBoxInstrumentChannel: TSGTK0ComboBox;
    Panel80: TSGTK0Panel;
    Panel6: TSGTK0Panel;
    Panel8: TSGTK0Panel;
    PanelModulationMatrixItems: TSGTK0Panel;
    Panel9: TSGTK0Panel;
    Panel11: TSGTK0Panel;
    Label5: TLabel;
    ButtonAddModulationMatrixItem: TSGTK0Button;
    SGTK0Panel1: TSGTK0Panel;
    SGTK0Panel2: TSGTK0Panel;
    SGTK0Panel3: TSGTK0Panel;
    TabSheetGlobals: TSGTK0TabSheet;
    TabSheetExport: TSGTK0TabSheet;
    AudioStatusTimer: TTimer;
    RefreshTimer: TTimer;
    SGTK0Panel6: TSGTK0Panel;
    SGTK0Panel8: TSGTK0Panel;
    PageControlInstrument: TSGTK0PageControl;
    TabSheetInstrumentGlobals: TSGTK0TabSheet;
    Panel46: TSGTK0Panel;
    PanelInstrumentGlobalCarry: TSGTK0Panel;
    CheckBoxInstrumentGlobalCarry: TSGTK0CheckBox;
    PanelInstrumentGlobalChannelVolume: TSGTK0Panel;
    LabelTitleInstrumentGlobalChannelVolume: TLabel;
    LabelInstrumentGlobalChannelVolume: TLabel;
    ScrollBarInstrumentGlobalChannelVolume: TSGTK0Scrollbar;
    PanelInstrumentGlobalVolume: TSGTK0Panel;
    LabelTitleInstrumentGlobalVolume: TLabel;
    LabelInstrumentGlobalVolume: TLabel;
    ScrollBarInstrumentGlobalVolume: TSGTK0Scrollbar;
    PanelInstrumentGlobalMaxPolyphony: TSGTK0Panel;
    LabelTitleInstrumentGlobalMaxPolyphony: TLabel;
    LabelInstrumentGlobalMaxPolyphony: TLabel;
    ScrollBarInstrumentGlobalMaxPolyphony: TSGTK0Scrollbar;
    PanelInstrumentGlobalTranspose: TSGTK0Panel;
    LabelTitleInstrumentGlobalTranspose: TLabel;
    LabelInstrumentGlobalTranspose: TLabel;
    ScrollBarInstrumentGlobalTranspose: TSGTK0Scrollbar;
    TabSheetInstrumentVoice: TSGTK0TabSheet;
    TabSheetInstrumentChannel: TSGTK0TabSheet;
    PageControlInstrumentVoice: TSGTK0PageControl;
    TabSheetInstrumentVoiceOscillators: TSGTK0TabSheet;
    TabSheetInstrumentVoiceADSRs: TSGTK0TabSheet;
    TabSheetInstrumentVoiceEnvelopes: TSGTK0TabSheet;
    TabSheetInstrumentVoiceLFOs: TSGTK0TabSheet;
    TabSheetInstrumentVoiceFilters: TSGTK0TabSheet;
    TabSheetVoiceInstrumentDistortion: TSGTK0TabSheet;
    TabSheetVoiceInstrumentGate: TSGTK0TabSheet;
    TabSheetInstrumentVoiceSignalRouteOrder: TSGTK0TabSheet;
    PageControlInstrumentChannel: TSGTK0PageControl;
    TabSheetInstrumentChannelDistortion: TSGTK0TabSheet;
    TabSheetInstrumentChannelFilter: TSGTK0TabSheet;
    TabSheetInstrumentChannelDelay: TSGTK0TabSheet;
    TabSheetInstrumentChannelChorusFlanger: TSGTK0TabSheet;
    TabSheetInstrumentChannelCompressor: TSGTK0TabSheet;
    TabSheetInstrumentChannelSpeech: TSGTK0TabSheet;
    TabSheetInstrumentChannelPitchShifter: TSGTK0TabSheet;
    TabSheetInstrumentChannelEQ: TSGTK0TabSheet;
    TabSheetInstrumentChannelSignalRouteOrder: TSGTK0TabSheet;
    PanelInstrumentGlobalChorusFlanger: TSGTK0Panel;
    LabelTitleInstrumentGlobalChorusFlanger: TLabel;
    LabelInstrumentGlobalChorusFlanger: TLabel;
    ScrollbarInstrumentGlobalChorusFlanger: TSGTK0Scrollbar;
    PanelInstrumentGlobalReverb: TSGTK0Panel;
    LabelTitleInstrumentGlobalReverb: TLabel;
    LabelInstrumentGlobalReverb: TLabel;
    ScrollbarInstrumentGlobalReverb: TSGTK0Scrollbar;
    PanelInstrumentGlobalDelay: TSGTK0Panel;
    LabelTitleInstrumentGlobalDelay: TLabel;
    LabelInstrumentGlobalDelay: TLabel;
    ScrollbarInstrumentGlobalDelay: TSGTK0Scrollbar;
    PanelInstrumentGlobalOutput: TSGTK0Panel;
    LabelTitleInstrumentGlobalOutput: TLabel;
    LabelInstrumentGlobalOutput: TLabel;
    ScrollbarInstrumentGlobalOutput: TSGTK0Scrollbar;
    TabControlInstrumentVoiceOscillators: TSGTK0TabControl;
    TabControlInstrumentVoiceADSRs: TSGTK0TabControl;
    TabControlInstrumentVoiceEnvelopes: TSGTK0TabControl;
    TabControlInstrumentVoiceLFOs: TSGTK0TabControl;
    TabControlInstrumentVoiceFilters: TSGTK0TabControl;
    TabSheetGlobalsOversample: TSGTK0TabSheet;
    P1: TSGTK0Panel;
    P2: TSGTK0Panel;
    P3: TSGTK0Panel;
    P4: TSGTK0Panel;
    SGTK0Panel10: TSGTK0Panel;
    Label6: TLabel;
    ComboBoxInstrumentVoiceOscillatorWaveform: TSGTK0ComboBox;
    SGTK0Panel11: TSGTK0Panel;
    Label8: TLabel;
    ComboBoxInstrumentVoiceOscillatorSynthesisType: TSGTK0ComboBox;
    ScrollbarModulationMatrixItems: TSGTK0Scrollbar;
    SGTK0Panel12: TSGTK0Panel;
    Label9: TLabel;
    ComboBoxInstrumentVoiceOscillatorNoteBegin: TSGTK0ComboBox;
    SGTK0Panel13: TSGTK0Panel;
    SGTK0Panel14: TSGTK0Panel;
    Label11: TLabel;
    SGTK0Panel15: TSGTK0Panel;
    Label12: TLabel;
    ScrollbarInstrumentVoiceOscillatorColor: TSGTK0Scrollbar;
    LabelInstrumentVoiceOscillatorColor: TLabel;
    ScrollBarInstrumentVoiceOscillatorFeedback: TSGTK0Scrollbar;
    LabelInstrumentVoiceOscillatorFeedback: TLabel;
    SGTK0Panel16: TSGTK0Panel;
    Label13: TLabel;
    LabelInstrumentVoiceOscillatorTranspose: TLabel;
    ScrollbarInstrumentVoiceOscillatorTranspose: TSGTK0Scrollbar;
    SGTK0Panel17: TSGTK0Panel;
    Label15: TLabel;
    LabelInstrumentVoiceOscillatorFinetune: TLabel;
    ScrollbarInstrumentVoiceOscillatorFinetune: TSGTK0Scrollbar;
    SGTK0Panel18: TSGTK0Panel;
    Label14: TLabel;
    LabelInstrumentVoiceOscillatorPhaseStart: TLabel;
    ScrollbarInstrumentVoiceOscillatorPhaseStart: TSGTK0Scrollbar;
    SGTK0Panel19: TSGTK0Panel;
    Label17: TLabel;
    LabelInstrumentVoiceOscillatorVolume: TLabel;
    ScrollbarInstrumentVoiceOscillatorVolume: TSGTK0Scrollbar;
    SGTK0Panel20: TSGTK0Panel;
    Label16: TLabel;
    LabelInstrumentVoiceOscillatorGlide: TLabel;
    ScrollbarInstrumentVoiceOscillatorGlide: TSGTK0Scrollbar;
    SGTK0Panel21: TSGTK0Panel;
    CheckBoxInstrumentVoiceOscillatorHardsync: TSGTK0CheckBox;
    SGTK0Panel22: TSGTK0Panel;
    CheckBoxInstrumentVoiceOscillatorCarry: TSGTK0CheckBox;
    SGTK0Panel23: TSGTK0Panel;
    PaintBoxADSR: TPaintBox;
    SGTK0Panel24: TSGTK0Panel;
    SGTK0Panel25: TSGTK0Panel;
    SGTK0Panel26: TSGTK0Panel;
    SGTK0Panel27: TSGTK0Panel;
    SGTK0Panel28: TSGTK0Panel;
    SGTK0Panel29: TSGTK0Panel;
    SGTK0Panel30: TSGTK0Panel;
    ComboBoxInstrumentVoiceADSRAttack: TSGTK0ComboBox;
    SGTK0Panel31: TSGTK0Panel;
    ComboBoxInstrumentVoiceADSRDecay: TSGTK0ComboBox;
    SGTK0Panel32: TSGTK0Panel;
    ComboBoxInstrumentVoiceADSRSustain: TSGTK0ComboBox;
    SGTK0Panel33: TSGTK0Panel;
    ComboBoxInstrumentVoiceADSRRelease: TSGTK0ComboBox;
    SGTK0Panel34: TSGTK0Panel;
    SGTK0Panel35: TSGTK0Panel;
    ScrollBarInstrumentVoiceADSRAttack: TSGTK0Scrollbar;
    LabelInstrumentVoiceADSRAttack: TLabel;
    SGTK0Panel36: TSGTK0Panel;
    LabelInstrumentVoiceADSRDecay: TLabel;
    ScrollBarInstrumentVoiceADSRDecay: TSGTK0Scrollbar;
    SGTK0Panel37: TSGTK0Panel;
    LabelInstrumentVoiceADSRSustain: TLabel;
    ScrollBarInstrumentVoiceADSRSustain: TSGTK0Scrollbar;
    SGTK0Panel38: TSGTK0Panel;
    LabelInstrumentVoiceADSRRelease: TLabel;
    ScrollBarInstrumentVoiceADSRRelease: TSGTK0Scrollbar;
    SGTK0Panel39: TSGTK0Panel;
    CheckBoxInstrumentVoiceADSRActive: TSGTK0CheckBox;
    SGTK0Panel40: TSGTK0Panel;
    CheckBoxInstrumentVoiceADSRActiveCheck: TSGTK0CheckBox;
    SGTK0Panel41: TSGTK0Panel;
    Label18: TLabel;
    ScrollbarInstrumentVoiceADSRAmplify: TSGTK0Scrollbar;
    LabelInstrumentVoiceADSRAmplify: TLabel;
    SGTK0Panel42: TSGTK0Panel;
    Label20: TLabel;
    LabelInstrumentVoiceADSRDecayLevel: TLabel;
    ScrollbarInstrumentVoiceADSRDecayLevel: TSGTK0Scrollbar;
    SGTK0Panel43: TSGTK0Panel;
    CheckBoxInstrumentVoiceADSRCarry: TSGTK0CheckBox;
    LabelModulationMatrixCount: TLabel;
    SGTK0Panel45: TSGTK0Panel;
    CheckBoxInstrumentVoiceEnvelopeCarry: TSGTK0CheckBox;
    SGTK0Panel46: TSGTK0Panel;
    SGTK0Panel49: TSGTK0Panel;
    CheckBoxInstrumentVoiceEnvelopeActive: TSGTK0CheckBox;
    SGTK0Panel50: TSGTK0Panel;
    CheckBoxInstrumentVoiceEnvelopeActiveCheck: TSGTK0CheckBox;
    SGTK0Panel47: TSGTK0Panel;
    Label19: TLabel;
    LabelInstrumentVoiceEnvelopeAmplify: TLabel;
    ScrollbarInstrumentVoiceEnvelopeAmplify: TSGTK0Scrollbar;
    PanelInstrumentVoiceLFOWaveform: TSGTK0Panel;
    LabelNameInstrumentVoiceLFOWaveform: TLabel;
    ComboBoxInstrumentVoiceLFOWaveform: TSGTK0ComboBox;
    PanelInstrumentVoiceLFOWavetable: TSGTK0Panel;
    LabelNameInstrumentVoiceLFOSample: TLabel;
    ComboBoxInstrumentVoiceLFOSample: TSGTK0ComboBox;
    PanelInstrumentVoiceLFORate: TSGTK0Panel;
    LabelNameInstrumentVoiceLFORate: TLabel;
    LabelInstrumentVoiceLFORate: TLabel;
    ScrollbarInstrumentVoiceLFORate: TSGTK0Scrollbar;
    PanelInstrumentVoiceLFODepth: TSGTK0Panel;
    LabelNameInstrumentVoiceLFODepth: TLabel;
    LabelInstrumentVoiceLFODepth: TLabel;
    ScrollbarInstrumentVoiceLFODepth: TSGTK0Scrollbar;
    PanelInstrumentVoiceLFOMiddle: TSGTK0Panel;
    Label28: TLabel;
    LabelInstrumentVoiceLFOMiddle: TLabel;
    ScrollbarInstrumentVoiceLFOMiddle: TSGTK0Scrollbar;
    PanelInstrumentVoiceLFOSweep: TSGTK0Panel;
    LabelNameInstrumentVoiceLFOSweep: TLabel;
    LabelInstrumentVoiceLFOSweep: TLabel;
    ScrollbarInstrumentVoiceLFOSweep: TSGTK0Scrollbar;
    PanelInstrumentVoiceLFOPhaseStart: TSGTK0Panel;
    LabelNameInstrumentVoiceLFOPhaseStart: TLabel;
    LabelInstrumentVoiceLFOPhaseStart: TLabel;
    ScrollBarInstrumentVoiceLFOPhaseStart: TSGTK0Scrollbar;
    PanelInstrumentVoiceLFOOptions: TSGTK0Panel;
    CheckBoxInstrumentVoiceLFOAmp: TSGTK0CheckBox;
    SGTK0Panel61: TSGTK0Panel;
    CheckBoxInstrumentVoiceLFOCarry: TSGTK0CheckBox;
    PanelInstrumentVoiceOscillatorSample: TSGTK0Panel;
    LabelNameInstrumentVoiceOscillatorSample: TLabel;
    ComboBoxInstrumentVoiceOscillatorSample: TSGTK0ComboBox;
    P5: TSGTK0Panel;
    PanelInstrumentVoiceFilterMode: TSGTK0Panel;
    LabelNameInstrumentVoiceFilterMode: TLabel;
    ComboBoxInstrumentVoiceFilterMode: TSGTK0ComboBox;
    PanelInstrumentVoiceFilterVolume: TSGTK0Panel;
    LabelNameInstrumentVoiceFilterVolume: TLabel;
    LabelInstrumentVoiceFilterVolume: TLabel;
    ScrollbarInstrumentVoiceFilterVolume: TSGTK0Scrollbar;
    PanelInstrumentVoiceFilterCutOff: TSGTK0Panel;
    LabelNameInstrumentVoiceFilterCutOff: TLabel;
    LabelInstrumentVoiceFilterCutOff: TLabel;
    ScrollbarInstrumentVoiceFilterCutOff: TSGTK0Scrollbar;
    PanelInstrumentVoiceFilterResonance: TSGTK0Panel;
    LabelNameInstrumentVoiceFilterResonance: TLabel;
    LabelInstrumentVoiceFilterResonance: TLabel;
    ScrollbarInstrumentVoiceFilterResonance: TSGTK0Scrollbar;
    PanelInstrumentVoiceFilterOptionsB: TSGTK0Panel;
    CheckBoxInstrumentVoiceFilterCarry: TSGTK0CheckBox;
    SGTK0Panel67: TSGTK0Panel;
    PanelInstrumentVoiceFilterOptionsA: TSGTK0Panel;
    CheckBoxInstrumentVoiceFilterCascaded: TSGTK0CheckBox;
    SGTK0Panel75: TSGTK0Panel;
    CheckBoxInstrumentVoiceFilterChain: TSGTK0CheckBox;
    PanelInstrumentVoiceFilterAmplify: TSGTK0Panel;
    LabelNameInstrumentVoiceFilterAmplify: TLabel;
    LabelInstrumentVoiceFilterAmplify: TLabel;
    ScrollbarInstrumentVoiceFilterAmplify: TSGTK0Scrollbar;
    ListBoxInstrumentVoiceOrder: TSGTK0ListBox;
    ButtonInstrumentVoiceOrderMoveToUp: TSGTK0Button;
    ButtonInstrumentVoiceOrderMoveToDown: TSGTK0Button;
    PanelInstrumentChannelChorusFlangerFeedBackLeft: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerFeedBackLeft: TLabel;
    LabelInstrumentChannelChorusFlangerFeedBackLeft: TLabel;
    ScrollbarInstrumentChannelChorusFlangerFeedBackLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerOptions: TSGTK0Panel;
    CheckBoxInstrumentChannelChorusFlangerActive: TSGTK0CheckBox;
    SGTK0Panel62: TSGTK0Panel;
    PanelInstrumentChannelChorusFlangerWet: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerWet: TLabel;
    LabelInstrumentChannelChorusFlangerWet: TLabel;
    ScrollbarInstrumentChannelChorusFlangerWet: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerFeedBackRight: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerFeedBackRight: TLabel;
    LabelInstrumentChannelChorusFlangerFeedBackRight: TLabel;
    ScrollbarInstrumentChannelChorusFlangerFeedBackRight: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerLFODepthLeft: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerLFODepthLeft: TLabel;
    LabelInstrumentChannelChorusFlangerLFODepthLeft: TLabel;
    ScrollbarInstrumentChannelChorusFlangerLFODepthLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerLFORateLeft: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerLFORateLeft: TLabel;
    LabelInstrumentChannelChorusFlangerLFORateLeft: TLabel;
    ScrollbarInstrumentChannelChorusFlangerLFORateLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerLFOPhaseLeft: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerLFOPhaseLeft: TLabel;
    LabelInstrumentChannelChorusFlangerLFOPhaseLeft: TLabel;
    ScrollbarInstrumentChannelChorusFlangerLFOPhaseLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerLFOPhaseRight: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerLFOPhaseRight: TLabel;
    LabelInstrumentChannelChorusFlangerLFOPhaseRight: TLabel;
    ScrollbarInstrumentChannelChorusFlangerLFOPhaseRight: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerLFODepthRight: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerLFODepthRight: TLabel;
    LabelInstrumentChannelChorusFlangerLFODepthRight: TLabel;
    ScrollbarInstrumentChannelChorusFlangerLFODepthRight: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerLFORateRight: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerLFORateRight: TLabel;
    LabelInstrumentChannelChorusFlangerLFORateRight: TLabel;
    ScrollbarInstrumentChannelChorusFlangerLFORateRight: TSGTK0Scrollbar;
    CheckBoxInstrumentChannelChorusFlangerCarry: TSGTK0CheckBox;
    PanelInstrumentChannelChorusFlangerDry: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerDry: TLabel;
    LabelInstrumentChannelChorusFlangerDry: TLabel;
    ScrollbarInstrumentChannelChorusFlangerDry: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorMode: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorMode: TLabel;
    ComboBoxInstrumentChannelCompressorMode: TSGTK0ComboBox;
    PanelInstrumentChannelCompressorThreshold: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorThreshold: TLabel;
    LabelInstrumentChannelCompressorThreshold: TLabel;
    ScrollbarInstrumentChannelCompressorThreshold: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerTimeRight: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerTimeRight: TLabel;
    LabelInstrumentChannelChorusFlangerTimeRight: TLabel;
    ScrollbarInstrumentChannelChorusFlangerTimeRight: TSGTK0Scrollbar;
    PanelInstrumentChannelChorusFlangerTimeLeft: TSGTK0Panel;
    LabelNameInstrumentChannelChorusFlangerTimeLeft: TLabel;
    LabelInstrumentChannelChorusFlangerTimeLeft: TLabel;
    ScrollbarInstrumentChannelChorusFlangerTimeLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorLookAhead: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorWindow: TLabel;
    LabelInstrumentChannelCompressorWindow: TLabel;
    ScrollbarInstrumentChannelCompressorWindow: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorRatio: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorRatio: TLabel;
    LabelInstrumentChannelCompressorRatio: TLabel;
    ScrollbarInstrumentChannelCompressorRatio: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorOutGain: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorOutGain: TLabel;
    LabelInstrumentChannelCompressorOutGain: TLabel;
    ScrollbarInstrumentChannelCompressorOutGain: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorSoftHardKnee: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorSoftHardKnee: TLabel;
    LabelInstrumentChannelCompressorSoftHardKnee: TLabel;
    ScrollbarInstrumentChannelCompressorSoftHardKnee: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorAttack: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorAttack: TLabel;
    LabelInstrumentChannelCompressorAttack: TLabel;
    ScrollbarInstrumentChannelCompressorAttack: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorRelease: TSGTK0Panel;
    LabelNameInstrumentChannelCompressorRelease: TLabel;
    LabelInstrumentChannelCompressorRelease: TLabel;
    ScrollbarInstrumentChannelCompressorRelease: TSGTK0Scrollbar;
    PanelInstrumentChannelCompressorOptions: TSGTK0Panel;
    CheckBoxInstrumentChannelCompressorAutoGain: TSGTK0CheckBox;
    SGTK0Panel66: TSGTK0Panel;
    PanelInstrumentChannelSpeechFrameLength: TSGTK0Panel;
    LabelNameInstrumentChannelSpeechFrameLength: TLabel;
    LabelInstrumentChannelSpeechFrameLength: TLabel;
    ScrollbarInstrumentChannelSpeechFrameLength: TSGTK0Scrollbar;
    PanelInstrumentChannelSpeechTextNumber: TSGTK0Panel;
    LabelNameInstrumentChannelSpeechTextNumber: TLabel;
    LabelInstrumentChannelSpeechTextNumber: TLabel;
    ScrollbarInstrumentChannelSpeechTextNumber: TSGTK0Scrollbar;
    PanelInstrumentChannelSpeechSpeed: TSGTK0Panel;
    Label27: TLabel;
    LabelInstrumentChannelSpeechSpeed: TLabel;
    ScrollbarInstrumentChannelSpeechSpeed: TSGTK0Scrollbar;
    PanelInstrumentChannelSpeechOptions: TSGTK0Panel;
    CheckBoxInstrumentChannelSpeechActive: TSGTK0CheckBox;
    SGTK0Panel72: TSGTK0Panel;
    ButtonInstrumentChannelOrderMoveToUp: TSGTK0Button;
    ButtonInstrumentChannelOrderMoveToDown: TSGTK0Button;
    ListBoxInstrumentChannelOrder: TSGTK0ListBox;
    PageControl1: TSGTK0PageControl;
    TabSheetGlobalsReverb: TSGTK0Tabsheet;
    TabSheetGlobalsDelay: TSGTK0Tabsheet;
    TabSheetGlobalsChorusFlanger: TSGTK0Tabsheet;
    TabSheetGlobalsEndFilter: TSGTK0Tabsheet;
    TabSheetGlobalsCompressor: TSGTK0Tabsheet;
    TabSheetGlobalsPitchShifter: TSGTK0Tabsheet;
    TabSheetGlobalsEQ: TSGTK0Tabsheet;
    TabSheetGlobalsOrder: TSGTK0Tabsheet;
    TabSheetGlobalsClock: TSGTK0Tabsheet;
    TabSheetGlobalsVoices: TSGTK0Tabsheet;
    TabSheetGlobalsFinalCompressor: TSGTK0Tabsheet;
    PanelGlobalsDelayWet: TSGTK0Panel;
    LabelNameGlobalsDelayWet: TLabel;
    LabelGlobalsDelayWet: TLabel;
    ScrollbarGlobalsDelayWet: TSGTK0Scrollbar;
    PanelGlobalsDelayDry: TSGTK0Panel;
    LabelNameGlobalsDelayDry: TLabel;
    LabelGlobalsDelayDry: TLabel;
    ScrollbarGlobalsDelayDry: TSGTK0Scrollbar;
    PanelGlobalsDelayTimeRight: TSGTK0Panel;
    LabelNameGlobalsDelayTimeRight: TLabel;
    LabelGlobalsDelayTimeRight: TLabel;
    ScrollbarGlobalsDelayTimeRight: TSGTK0Scrollbar;
    PanelGlobalsDelayTimeLeft: TSGTK0Panel;
    LabelNameGlobalsDelayTimeLeft: TLabel;
    LabelGlobalsDelayTimeLeft: TLabel;
    ScrollbarGlobalsDelayTimeLeft: TSGTK0Scrollbar;
    PanelGlobalsDelayFeedBackLeft: TSGTK0Panel;
    LabelNameGlobalsDelayFeedBackLeft: TLabel;
    LabelGlobalsDelayFeedBackLeft: TLabel;
    ScrollbarGlobalsDelayFeedBackLeft: TSGTK0Scrollbar;
    PanelGlobalsDelayOptions: TSGTK0Panel;
    CheckBoxGlobalsDelayActive: TSGTK0CheckBox;
    SGTK0Panel64: TSGTK0Panel;
    PanelGlobalsChorusFlangerWet: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerWet: TLabel;
    LabelGlobalsChorusFlangerWet: TLabel;
    ScrollbarGlobalsChorusFlangerWet: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerDry: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerDry: TLabel;
    LabelGlobalsChorusFlangerDry: TLabel;
    ScrollbarGlobalsChorusFlangerDry: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerTimeRight: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerTimeRight: TLabel;
    LabelGlobalsChorusFlangerTimeRight: TLabel;
    ScrollbarGlobalsChorusFlangerTimeRight: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerFeedBackRight: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerFeedBackRight: TLabel;
    LabelGlobalsChorusFlangerFeedBackRight: TLabel;
    ScrollbarGlobalsChorusFlangerFeedBackRight: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerLFORateRight: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerLFORateRight: TLabel;
    LabelGlobalsChorusFlangerLFORateRight: TLabel;
    ScrollbarGlobalsChorusFlangerLFORateRight: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerLFODepthRight: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerLFODepthRight: TLabel;
    LabelGlobalsChorusFlangerLFODepthRight: TLabel;
    ScrollbarGlobalsChorusFlangerLFODepthRight: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerLFOPhaseRight: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerLFOPhaseRight: TLabel;
    LabelGlobalsChorusFlangerLFOPhaseRight: TLabel;
    ScrollbarGlobalsChorusFlangerLFOPhaseRight: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerOptions: TSGTK0Panel;
    CheckBoxGlobalsChorusFlangerActive: TSGTK0CheckBox;
    SGTK0Panel68: TSGTK0Panel;
    CheckBoxGlobalsChorusFlangerCarry: TSGTK0CheckBox;
    PanelGlobalsChorusFlangerLFOPhaseLeft: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerLFOPhaseLeft: TLabel;
    LabelGlobalsChorusFlangerLFOPhaseLeft: TLabel;
    ScrollbarGlobalsChorusFlangerLFOPhaseLeft: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerLFODepthLeft: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerLFODepthLeft: TLabel;
    LabelGlobalsChorusFlangerLFODepthLeft: TLabel;
    ScrollbarGlobalsChorusFlangerLFODepthLeft: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerLFORateLeft: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerLFORateLeft: TLabel;
    LabelGlobalsChorusFlangerLFORateLeft: TLabel;
    ScrollbarGlobalsChorusFlangerLFORateLeft: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerFeedBackLeft: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerFeedBackLeft: TLabel;
    LabelGlobalsChorusFlangerFeedBackLeft: TLabel;
    ScrollbarGlobalsChorusFlangerFeedBackLeft: TSGTK0Scrollbar;
    PanelGlobalsChorusFlangerTimeLeft: TSGTK0Panel;
    LabelNameGlobalsChorusFlangerTimeLeft: TLabel;
    LabelGlobalsChorusFlangerTimeLeft: TLabel;
    ScrollbarGlobalsChorusFlangerTimeLeft: TSGTK0Scrollbar;
    PanelGlobalsCompressorMode: TSGTK0Panel;
    LabelNameGlobalsCompressorMode: TLabel;
    ComboBoxGlobalsCompressorMode: TSGTK0ComboBox;
    PanelGlobalsCompressorThreshold: TSGTK0Panel;
    LabelNameGlobalsCompressorThreshold: TLabel;
    LabelGlobalsCompressorThreshold: TLabel;
    ScrollbarGlobalsCompressorThreshold: TSGTK0Scrollbar;
    PanelGlobalsCompressorLookAhead: TSGTK0Panel;
    LabelNameGlobalsCompressorWindow: TLabel;
    LabelGlobalsCompressorWindow: TLabel;
    ScrollbarGlobalsCompressorWindow: TSGTK0Scrollbar;
    PanelGlobalsCompressorOutGain: TSGTK0Panel;
    LabelNameGlobalsCompressorOutGain: TLabel;
    LabelGlobalsCompressorOutGain: TLabel;
    ScrollbarGlobalsCompressorOutGain: TSGTK0Scrollbar;
    PanelGlobalsCompressorRelease: TSGTK0Panel;
    LabelNameGlobalsCompressorRelease: TLabel;
    LabelGlobalsCompressorRelease: TLabel;
    ScrollbarGlobalsCompressorRelease: TSGTK0Scrollbar;
    PanelGlobalsCompressorOptions: TSGTK0Panel;
    CheckBoxGlobalsCompressorAutoGain: TSGTK0CheckBox;
    SGTK0Panel70: TSGTK0Panel;
    PanelGlobalsCompressorAttack: TSGTK0Panel;
    LabelNameGlobalsCompressorAttack: TLabel;
    LabelGlobalsCompressorAttack: TLabel;
    ScrollbarGlobalsCompressorAttack: TSGTK0Scrollbar;
    PanelGlobalsCompressorSoftHardKnee: TSGTK0Panel;
    LabelNameGlobalsCompressorSoftHardKnee: TLabel;
    LabelGlobalsCompressorSoftHardKnee: TLabel;
    ScrollbarGlobalsCompressorSoftHardKnee: TSGTK0Scrollbar;
    PanelGlobalsCompressorRatio: TSGTK0Panel;
    LabelNameGlobalsCompressorRatio: TLabel;
    LabelGlobalsCompressorRatio: TLabel;
    ScrollbarGlobalsCompressorRatio: TSGTK0Scrollbar;
    PanelGlobalsReverbOptions: TSGTK0Panel;
    CheckBoxGlobalsReverbActive: TSGTK0CheckBox;
    SGTK0Panel74: TSGTK0Panel;
    PanelGlobalsReverbPreDelay: TSGTK0Panel;
    LabelNameGlobalsReverbPreDelay: TLabel;
    LabelGlobalsReverbPreDelay: TLabel;
    ScrollbarGlobalsReverbPreDelay: TSGTK0Scrollbar;
    PanelGlobalsReverbRoomSize: TSGTK0Panel;
    LabelNameGlobalsReverbRoomSize: TLabel;
    LabelGlobalsReverbRoomSize: TLabel;
    ScrollbarGlobalsReverbRoomSize: TSGTK0Scrollbar;
    PanelGlobalsReverbCombFilterSeparation: TSGTK0Panel;
    LabelNameGlobalsReverbCombFilterSeparation: TLabel;
    LabelGlobalsReverbCombFilterSeparation: TLabel;
    ScrollbarGlobalsReverbCombFilterSeparation: TSGTK0Scrollbar;
    PanelGlobalsReverbFeedBack: TSGTK0Panel;
    LabelNameGlobalsReverbFeedBack: TLabel;
    LabelGlobalsReverbFeedBack: TLabel;
    ScrollbarGlobalsReverbFeedBack: TSGTK0Scrollbar;
    PanelGlobalsReverbAbsortion: TSGTK0Panel;
    LabelNameGlobalsReverbAbsortion: TLabel;
    LabelGlobalsReverbAbsortion: TLabel;
    ScrollbarGlobalsReverbAbsortion: TSGTK0Scrollbar;
    PanelGlobalsReverbDry: TSGTK0Panel;
    LabelNameGlobalsReverbDry: TLabel;
    LabelGlobalsReverbDry: TLabel;
    ScrollbarGlobalsReverbDry: TSGTK0Scrollbar;
    PanelGlobalsReverbWet: TSGTK0Panel;
    LabelNameGlobalsReverbWet: TLabel;
    LabelGlobalsReverbWet: TLabel;
    ScrollbarGlobalsReverbWet: TSGTK0Scrollbar;
    PanelGlobalsReverbNumberOfAllPassFilters: TSGTK0Panel;
    LabelNameGlobalsReverbNumberOfAllPassFilters: TLabel;
    LabelGlobalsReverbNumberOfAllPassFilters: TLabel;
    ScrollbarGlobalsReverbNumberOfAllPassFilters: TSGTK0Scrollbar;
    PanelGlobalsEndFilterOptions: TSGTK0Panel;
    CheckBoxGlobalsEndFilterActive: TSGTK0CheckBox;
    SGTK0Panel85: TSGTK0Panel;
    PanelGlobalsEndFilterLowCut: TSGTK0Panel;
    LabelNameGlobalsEndFilterCutOff: TLabel;
    LabelGlobalsEndFilterLowCut: TLabel;
    ScrollbarGlobalsEndFilterLowCut: TSGTK0Scrollbar;
    PanelGlobalsEndFilterHighCut: TSGTK0Panel;
    LabelNameGlobalsEndFilterHighCut: TLabel;
    LabelGlobalsEndFilterHighCut: TLabel;
    ScrollbarGlobalsEndFilterHighCut: TSGTK0Scrollbar;
    PanelGlobalsDelayFeedBackRight: TSGTK0Panel;
    LabelNameGlobalsDelayFeedBackRight: TLabel;
    LabelGlobalsDelayFeedBackRight: TLabel;
    ScrollbarGlobalsDelayFeedBackRight: TSGTK0Scrollbar;
    TimerSize: TTimer;
    SGTK0Panel79: TSGTK0Panel;
    Label24: TLabel;
    LabelGlobalsClockBPM: TLabel;
    ScrollbarGlobalsClockBPM: TSGTK0Scrollbar;
    SGTK0Panel80: TSGTK0Panel;
    Label29: TLabel;
    LabelGlobalsClockTPB: TLabel;
    ScrollbarGlobalsClockTPB: TSGTK0Scrollbar;
    CheckBoxGlobalsDelayClockSync: TSGTK0CheckBox;
    SaveDialogWAV: TSaveDialog;
    OpenDialogWAV: TOpenDialog;
    SGTK0Panel108: TSGTK0Panel;
    CheckBoxInstrumentVoiceOscillatorPMFMExtendedMode: TSGTK0CheckBox;
    CheckBoxInstrumentVoiceEnvelopeCenterise: TSGTK0CheckBox;
    CheckBoxInstrumentVoiceADSRCenterise: TSGTK0CheckBox;
    SGTK0Panel109: TSGTK0Panel;
    CheckBoxInstrumentChannelPitchShifterActive: TSGTK0CheckBox;
    SGTK0Panel110: TSGTK0Panel;
    SGTK0Panel111: TSGTK0Panel;
    Label50: TLabel;
    LabelInstrumentChannelPitchShifterTune: TLabel;
    ScrollbarInstrumentChannelPitchShifterTune: TSGTK0Scrollbar;
    SGTK0Panel112: TSGTK0Panel;
    Label52: TLabel;
    LabelInstrumentChannelPitchShifterFineTune: TLabel;
    ScrollbarInstrumentChannelPitchShifterFineTune: TSGTK0Scrollbar;
    SGTK0Panel113: TSGTK0Panel;
    Label51: TLabel;
    LabelGlobalPitchShifterTune: TLabel;
    ScrollbarGlobalPitchShifterTune: TSGTK0Scrollbar;
    SGTK0Panel114: TSGTK0Panel;
    CheckBoxGlobalPitchShifterActive: TSGTK0CheckBox;
    SGTK0Panel115: TSGTK0Panel;
    SGTK0Panel116: TSGTK0Panel;
    Label54: TLabel;
    LabelGlobalPitchShifterFineTune: TLabel;
    ScrollbarGlobalPitchShifterFineTune: TSGTK0Scrollbar;
    SGTK0Panel117: TSGTK0Panel;
    Label53: TLabel;
    LabelInstrumentChannelSpeechColor: TLabel;
    ScrollbarInstrumentChannelSpeechColor: TSGTK0Scrollbar;
    SGTK0Panel118: TSGTK0Panel;
    Label55: TLabel;
    LabelInstrumentChannelSpeechNoiseGain: TLabel;
    ScrollbarInstrumentChannelSpeechNoiseGain: TSGTK0Scrollbar;
    SGTK0Panel119: TSGTK0Panel;
    Label56: TLabel;
    LabelInstrumentChannelSpeechGain: TLabel;
    ScrollbarInstrumentChannelSpeechGain: TSGTK0Scrollbar;
    SGTK0Panel120: TSGTK0Panel;
    Label57: TLabel;
    Label58: TLabel;
    EditInstrumentChannelSpeechF4: TSGTK0Edit;
    EditInstrumentChannelSpeechF5: TSGTK0Edit;
    EditInstrumentChannelSpeechF6: TSGTK0Edit;
    Label59: TLabel;
    EditInstrumentChannelSpeechB6: TSGTK0Edit;
    EditInstrumentChannelSpeechB5: TSGTK0Edit;
    EditInstrumentChannelSpeechB4: TSGTK0Edit;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    SGTK0Panel121: TSGTK0Panel;
    CheckBoxInstrumentChannelEQActive: TSGTK0CheckBox;
    SGTK0Panel122: TSGTK0Panel;
    SGTK0Panel124: TSGTK0Panel;
    SGTK0Panel123: TSGTK0Panel;
    SGTK0Panel125: TSGTK0Panel;
    EditInstrumentChannelEQBandHz1: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain1: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain1: TSGTK0Panel;
    EditInstrumentChannelEQBandHz2: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain2: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain2: TSGTK0Panel;
    EditInstrumentChannelEQBandHz3: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain3: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain3: TSGTK0Panel;
    EditInstrumentChannelEQBandHz4: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain4: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain4: TSGTK0Panel;
    EditInstrumentChannelEQBandHz5: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain5: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain5: TSGTK0Panel;
    EditInstrumentChannelEQBandHz6: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain6: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain6: TSGTK0Panel;
    EditInstrumentChannelEQBandHz7: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain7: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain7: TSGTK0Panel;
    EditInstrumentChannelEQBandHz8: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain8: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain8: TSGTK0Panel;
    EditInstrumentChannelEQBandHz9: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain9: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain9: TSGTK0Panel;
    EditInstrumentChannelEQBandHz10: TSGTK0Edit;
    ScrollbarInstrumentChannelEQGain10: TSGTK0Scrollbar;
    PanelInstrumentChannelEQGain10: TSGTK0Panel;
    SGTK0Panel126: TSGTK0Panel;
    SGTK0Panel127: TSGTK0Panel;
    SGTK0Panel128: TSGTK0Panel;
    SGTK0Panel129: TSGTK0Panel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    ComboBoxInstrumentChannelEQMode: TSGTK0ComboBox;
    ButtonInstrumentChannelEQReset: TSGTK0Button;
    SGTK0Panel130: TSGTK0Panel;
    CheckBoxGlobalEQActive: TSGTK0CheckBox;
    SGTK0Panel131: TSGTK0Panel;
    ComboBoxGlobalEQMode: TSGTK0ComboBox;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    SGTK0Panel132: TSGTK0Panel;
    SGTK0Panel133: TSGTK0Panel;
    SGTK0Panel134: TSGTK0Panel;
    EditGlobalEQBandHz1: TSGTK0Edit;
    ScrollbarGlobalEQGain1: TSGTK0Scrollbar;
    PanelGlobalEQGain1: TSGTK0Panel;
    EditGlobalEQBandHz2: TSGTK0Edit;
    ScrollbarGlobalEQGain2: TSGTK0Scrollbar;
    PanelGlobalEQGain2: TSGTK0Panel;
    EditGlobalEQBandHz3: TSGTK0Edit;
    ScrollbarGlobalEQGain3: TSGTK0Scrollbar;
    PanelGlobalEQGain3: TSGTK0Panel;
    EditGlobalEQBandHz4: TSGTK0Edit;
    ScrollbarGlobalEQGain4: TSGTK0Scrollbar;
    PanelGlobalEQGain4: TSGTK0Panel;
    EditGlobalEQBandHz5: TSGTK0Edit;
    ScrollbarGlobalEQGain5: TSGTK0Scrollbar;
    PanelGlobalEQGain5: TSGTK0Panel;
    EditGlobalEQBandHz6: TSGTK0Edit;
    ScrollbarGlobalEQGain6: TSGTK0Scrollbar;
    PanelGlobalEQGain6: TSGTK0Panel;
    EditGlobalEQBandHz7: TSGTK0Edit;
    ScrollbarGlobalEQGain7: TSGTK0Scrollbar;
    PanelGlobalEQGain7: TSGTK0Panel;
    EditGlobalEQBandHz8: TSGTK0Edit;
    ScrollbarGlobalEQGain8: TSGTK0Scrollbar;
    PanelGlobalEQGain8: TSGTK0Panel;
    EditGlobalEQBandHz9: TSGTK0Edit;
    ScrollbarGlobalEQGain9: TSGTK0Scrollbar;
    PanelGlobalEQGain9: TSGTK0Panel;
    EditGlobalEQBandHz10: TSGTK0Edit;
    ScrollbarGlobalEQGain10: TSGTK0Scrollbar;
    PanelGlobalEQGain10: TSGTK0Panel;
    SGTK0Panel135: TSGTK0Panel;
    SGTK0Panel136: TSGTK0Panel;
    SGTK0Panel137: TSGTK0Panel;
    SGTK0Panel138: TSGTK0Panel;
    ButtonGlobalEQReset: TSGTK0Button;
    SGTK0Panel139: TSGTK0Panel;
    Label81: TLabel;
    LabelInstrumentChannelEQPreAmp: TLabel;
    SGTK0Panel140: TSGTK0Panel;
    Label82: TLabel;
    LabelGlobalEQPreAmp: TLabel;
    ScrollbarGlobalEQPreAmp: TSGTK0Scrollbar;
    SGTK0Panel141: TSGTK0Panel;
    CheckBoxInstrumentChannelEQCascaded: TSGTK0CheckBox;
    SGTK0Panel142: TSGTK0Panel;
    Label83: TLabel;
    EditInstrumentChannelEQOctaveFactor: TSGTK0Edit;
    SGTK0Panel143: TSGTK0Panel;
    CheckBoxGlobalEQCascaded: TSGTK0CheckBox;
    SGTK0Panel144: TSGTK0Panel;
    Label84: TLabel;
    EditGlobalEQOctaveFactor: TSGTK0Edit;
    CheckBoxInstrumentChannelEQAddCascaded: TSGTK0CheckBox;
    CheckBoxGlobalEQAddCascaded: TSGTK0CheckBox;
    ButtonInstrumentChannelEQLoadEQF: TSGTK0Button;
    OpenDialogEQF: TOpenDialog;
    ButtonGlobalEQLoadEQF: TSGTK0Button;
    ButtonInstrumentChannelEQSaveEQF: TSGTK0Button;
    SaveDialogEQF: TSaveDialog;
    ButtonGlobalEQSaveEQF: TSGTK0Button;
    ButtonGlobalEQResetISO: TSGTK0Button;
    ButtonInstrumentChannelEQResetISO: TSGTK0Button;
    SGTK0Panel145: TSGTK0Panel;
    SGTK0Panel146: TSGTK0Panel;
    SGTK0Panel147: TSGTK0Panel;
    SGTK0Panel148: TSGTK0Panel;
    ButtonExportMIDILoad: TSGTK0Button;
    SGTK0Panel149: TSGTK0Panel;
    SGTK0Panel150: TSGTK0Panel;
    ButtonExportMIDIRecordStop: TSGTK0Button;
    SGTK0Panel151: TSGTK0Panel;
    PanelExportMIDIEvents: TSGTK0Panel;
    OpenDialogMIDI: TOpenDialog;
    SGTK0Panel152: TSGTK0Panel;
    SGTK0Panel153: TSGTK0Panel;
    SGTK0Panel154: TSGTK0Panel;
    SGTK0Panel155: TSGTK0Panel;
    ButtonExportExportPAS: TSGTK0Button;
    SGTK0Panel156: TSGTK0Panel;
    ButtonExportSaveBMF: TSGTK0Button;
    SGTK0Panel157: TSGTK0Panel;
    SGTK0Panel158: TSGTK0Panel;
    SGTK0Panel159: TSGTK0Panel;
    ButtonExportGenerateSynthconfigINC: TSGTK0Button;
    SGTK0Panel160: TSGTK0Panel;
    SGTK0Panel161: TSGTK0Panel;
    SGTK0Panel162: TSGTK0Panel;
    Label85: TLabel;
    EditExportTrackName: TSGTK0Edit;
    EditExportAuthor: TSGTK0Edit;
    Label86: TLabel;
    Label87: TLabel;
    MemoExportComments: TSGTK0Memo;
    SaveDialogBMF: TSaveDialog;
    ButtonExportClear: TSGTK0Button;
    SaveDialogBBF: TSaveDialog;
    SaveDialogSynthConfigINC: TSaveDialog;
    SaveDialogPAS: TSaveDialog;
    LabelTitleAuthor: TLabel;
    SaveDialogEXE: TSaveDialog;
    ButtonExportExportH: TSGTK0Button;
    SaveDialogH: TSaveDialog;
    SGTK0Panel163: TSGTK0Panel;
    Label88: TLabel;
    LabelInstrumentChannelSpeechCascadeGain: TLabel;
    ScrollbarInstrumentChannelSpeechCascadeGain: TSGTK0Scrollbar;
    SGTK0Panel164: TSGTK0Panel;
    Label89: TLabel;
    LabelInstrumentChannelSpeechParallelGain: TLabel;
    ScrollbarInstrumentChannelSpeechParallelGain: TSGTK0Scrollbar;
    SGTK0Panel165: TSGTK0Panel;
    Label91: TLabel;
    LabelInstrumentChannelSpeechAspirationGain: TLabel;
    ScrollbarInstrumentChannelSpeechAspirationGain: TSGTK0Scrollbar;
    SGTK0Panel166: TSGTK0Panel;
    Label107: TLabel;
    LabelInstrumentChannelSpeechFricationGain: TLabel;
    ScrollbarInstrumentChannelSpeechFricationGain: TSGTK0Scrollbar;
    SGTK0Panel168: TSGTK0Panel;
    Label106: TLabel;
    SGTK0ComboBoxVoiceOscTarget: TSGTK0ComboBox;
    SGTK0ButtonVoiceOscSwap: TSGTK0Button;
    SGTK0ButtonVoiceOscCopy: TSGTK0Button;
    SGTK0ButtonGlobalOrderDown: TSGTK0Button;
    SGTK0ButtonGlobalOrderUp: TSGTK0Button;
    SGTK0ListBoxGlobalOrder: TSGTK0ListBox;
    ScrollbarInstrumentChannelEQPreAmp: TSGTK0Scrollbar;
    SGTK0PanelInstrumentVoiceFilterRange: TSGTK0Panel;
    SGTK0EditInstrumentVoiceFilterHzMin: TSGTK0Edit;
    SGTK0EditInstrumentVoiceFilterHzMax: TSGTK0Edit;
    Label109: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    SaveDialogFXP: TSaveDialog;
    OpenDialogFXP: TOpenDialog;
    SaveDialogFXB: TSaveDialog;
    OpenDialogFXB: TOpenDialog;
    SGTK0Panel172: TSGTK0Panel;
    Label116: TLabel;
    LabelGlobalsVoicesCount: TLabel;
    SGTK0ScrollbarGlobalsVoicesCount: TSGTK0Scrollbar;
    SGTK0ButtonConvertOldToNewUnits: TSGTK0Button;
    PanelGlobalsFinalCompressorMode: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorMode: TLabel;
    ComboBoxGlobalsFinalCompressorMode: TSGTK0ComboBox;
    PanelGlobalsFinalCompressorThreshold: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorThreshold: TLabel;
    LabelGlobalsFinalCompressorThreshold: TLabel;
    ScrollbarGlobalsFinalCompressorThreshold: TSGTK0Scrollbar;
    PanelGlobalsFinalCompressorLookAhead: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorWindow: TLabel;
    LabelGlobalsFinalCompressorWindow: TLabel;
    ScrollbarGlobalsFinalCompressorWindow: TSGTK0Scrollbar;
    PanelGlobalsFinalCompressorOutGain: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorOutGain: TLabel;
    LabelGlobalsFinalCompressorOutGain: TLabel;
    ScrollbarGlobalsFinalCompressorOutGain: TSGTK0Scrollbar;
    PanelGlobalsFinalCompressorRelease: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorRelease: TLabel;
    LabelGlobalsFinalCompressorRelease: TLabel;
    ScrollbarGlobalsFinalCompressorRelease: TSGTK0Scrollbar;
    PanelGlobalsFinalCompressorOptions: TSGTK0Panel;
    CheckBoxGlobalsFinalCompressorAutoGain: TSGTK0CheckBox;
    SGTK0Panel173: TSGTK0Panel;
    PanelGlobalsFinalCompressorAttack: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorAttack: TLabel;
    LabelGlobalsFinalCompressorAttack: TLabel;
    ScrollbarGlobalsFinalCompressorAttack: TSGTK0Scrollbar;
    PanelGlobalsFinalCompressorSoftHardKnee: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorSoftHardKnee: TLabel;
    LabelGlobalsFinalCompressorSoftHardKnee: TLabel;
    ScrollbarGlobalsFinalCompressorSoftHardKnee: TSGTK0Scrollbar;
    PanelGlobalsFinalCompressorRatio: TSGTK0Panel;
    LabelNameGlobalsFinalCompressorRatio: TLabel;
    LabelGlobalsFinalCompressorRatio: TLabel;
    ScrollbarGlobalsFinalCompressorRatio: TSGTK0Scrollbar;
    SGTK0Panel44: TSGTK0Panel;
    SGTK0Panel175: TSGTK0Panel;
    SGTK0Panel176: TSGTK0Panel;
    SGTK0PanelMasterSlave: TSGTK0Panel;
    SGTK0PanelInstanceCount: TSGTK0Panel;
    SGTK0ButtonImportFXP: TSGTK0Button;
    SGTK0ButtonExportFXP: TSGTK0Button;
    SGTK0ButtonImportFXB: TSGTK0Button;
    SGTK0ButtonExportFXB: TSGTK0Button;
    ColorTimer: TTimer;
    SGTK0ScrollbarColorR: TSGTK0Scrollbar;
    LabelColorR: TLabel;
    Label90: TLabel;
    Label108: TLabel;
    Label110: TLabel;
    SGTK0ScrollbarColorG: TSGTK0Scrollbar;
    LabelColorG: TLabel;
    SGTK0ScrollbarColorB: TSGTK0Scrollbar;
    LabelColorB: TLabel;
    SGTK0TabControlVoiceDistortion: TSGTK0TabControl;
    PanelInstrumentVoiceDistortionMode: TSGTK0Panel;
    LabelNamelInstrumentVoiceDistortionMode: TLabel;
    ComboBoxInstrumentVoiceDistortionMode: TSGTK0ComboBox;
    PanelInstrumentVoiceDistortionDist: TSGTK0Panel;
    LabelNameInstrumentVoiceDistortionDist: TLabel;
    LabelInstrumentVoiceDistortionDist: TLabel;
    ScrollbarInstrumentVoiceDistortionDist: TSGTK0Scrollbar;
    PanelInstrumentVoiceDistortionRate: TSGTK0Panel;
    Label35: TLabel;
    LabelInstrumentVoiceDistortionRate: TLabel;
    ScrollbarInstrumentVoiceDistortionRate: TSGTK0Scrollbar;
    PanelInstrumentVoiceDistortionGain: TSGTK0Panel;
    LabelNameInstrumentVoiceDistortionGain: TLabel;
    LabelInstrumentVoiceDistortionGain: TLabel;
    ScrollbarInstrumentVoiceDistortionGain: TSGTK0Scrollbar;
    PanelInstrumentVoiceDistortionOptions: TSGTK0Panel;
    CheckBoxInstrumentVoiceDistortionCarry: TSGTK0CheckBox;
    SGTK0TabControlChannelDistortion: TSGTK0TabControl;
    PanelInstrumentChannelDistortionMode: TSGTK0Panel;
    LabelNamInstrumentChannelDistortionMode: TLabel;
    ComboBoxInstrumentChannelDistortionMode: TSGTK0ComboBox;
    PanelInstrumentChannelDistortionDist: TSGTK0Panel;
    LabelNamInstrumentChannelDistortionDist: TLabel;
    LabelInstrumentChannelDistortionDist: TLabel;
    ScrollbarInstrumentChannelDistortionDist: TSGTK0Scrollbar;
    PanelInstrumentChannelDistortionRate: TSGTK0Panel;
    Label25: TLabel;
    LabelInstrumentChannelDistortionRate: TLabel;
    ScrollbarInstrumentChannelDistortionRate: TSGTK0Scrollbar;
    PanelInstrumentChannelDistortionGain: TSGTK0Panel;
    LabelNameInstrumentChannelDistortionGain: TLabel;
    LabelInstrumentChannelDistortionGain: TLabel;
    ScrollBarInstrumentChannelDistortionGain: TSGTK0Scrollbar;
    PanelInstrumentChannelDistortionOptions: TSGTK0Panel;
    CheckBoxInstrumentChannelDistortionCarry: TSGTK0CheckBox;
    SGTK0Panel65: TSGTK0Panel;
    SGTK0Panel9: TSGTK0Panel;
    SGTK0TabControlChannelFilter: TSGTK0TabControl;
    PanelInstrumentChannelFilterMode: TSGTK0Panel;
    LabelNameInstrumentChannelFilterMode: TLabel;
    ComboBoxInstrumentChannelFilterMode: TSGTK0ComboBox;
    PanelInstrumentChannelFilterCutOff: TSGTK0Panel;
    LabelNameInstrumentChannelFilterCutOff: TLabel;
    LabelInstrumentChannelFilterCutOff: TLabel;
    ScrollbarInstrumentChannelFilterCutOff: TSGTK0Scrollbar;
    PanelInstrumentChannelFilterAmplify: TSGTK0Panel;
    LabelNameInstrumentChannelFilterAmplify: TLabel;
    LabelInstrumentChannelFilterAmplify: TLabel;
    ScrollbarInstrumentChannelFilterAmplify: TSGTK0Scrollbar;
    PanelInstrumentChannelFilterVolume: TSGTK0Panel;
    LabelNameInstrumentChannelFilterVolume: TLabel;
    LabelInstrumentChannelFilterVolume: TLabel;
    ScrollbarInstrumentChannelFilterVolume: TSGTK0Scrollbar;
    PanelInstrumentChannelFilterResonance: TSGTK0Panel;
    LabelNameInstrumentChannelFilterResonance: TLabel;
    LabelInstrumentChannelFilterResonance: TLabel;
    ScrollbarInstrumentChannelFilterResonance: TSGTK0Scrollbar;
    PanelInstrumentChannelFilterOptions: TSGTK0Panel;
    CheckBoxInstrumentChannelFilterCascaded: TSGTK0CheckBox;
    SGTK0Panel73: TSGTK0Panel;
    CheckBoxInstrumentChannelFilterChain: TSGTK0CheckBox;
    SGTK0Panel170: TSGTK0Panel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    SGTK0EditInstrumentChannelFilterMinHz: TSGTK0Edit;
    SGTK0EditInstrumentChannelFilterMaxHz: TSGTK0Edit;
    SGTK0Panel69: TSGTK0Panel;
    SGTK0CheckBoxChannelFilterCarry: TSGTK0CheckBox;
    SGTK0Panel167: TSGTK0Panel;
    SGTK0Panel169: TSGTK0Panel;
    Label117: TLabel;
    LabelOversample: TLabel;
    SGTK0ScrollbarOversample: TSGTK0Scrollbar;
    SGTK0Panel171: TSGTK0Panel;
    SGTK0CheckBoxInstrumentChannelChorusFlangerFine: TSGTK0CheckBox;
    SGTK0Panel177: TSGTK0Panel;
    SGTK0Panel178: TSGTK0Panel;
    CheckBoxGlobalsChorusFlangerFine: TSGTK0CheckBox;
    SGTK0Panel179: TSGTK0Panel;
    SGTK0Panel180: TSGTK0Panel;
    LabelInstrumentChannelChorusFlangerCountTitle: TLabel;
    LabelInstrumentChannelChorusFlangerCount: TLabel;
    ScrollbarInstrumentChannelChorusFlangerCount: TSGTK0Scrollbar;
    SGTK0Panel181: TSGTK0Panel;
    Label118: TLabel;
    LabelGlobalsChorusFlangerCount: TLabel;
    ScrollbarGlobalsChorusFlangerCount: TSGTK0Scrollbar;
    SGTK0Panel184: TSGTK0Panel;
    CheckBoxGlobalsDelayFine: TSGTK0CheckBox;
    SGTK0Panel185: TSGTK0Panel;
    PageControl3: TSGTK0PageControl;
    TabSheetEnvADSR: TSGTK0TabSheet;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    SpinEditEnvADSRAttack: TSGTK0Edit;
    SpinEditEnvADSRDecay: TSGTK0Edit;
    SpinEditEnvADSRSustainTime: TSGTK0Edit;
    SpinEditEnvADSRRelease: TSGTK0Edit;
    CheckBoxEnvADSRSustain: TSGTK0CheckBox;
    SpinEditEnvADSRAmplify: TSGTK0Edit;
    SpinEditEnvADSRSustainLevel: TSGTK0Edit;
    ButtonEnvADSRGenerate: TSGTK0Button;
    TabSheetEnvTranceGate: TSGTK0TabSheet;
    Label102: TLabel;
    Label103: TLabel;
    GroupBox29: TSGTK0Panel;
    Label75: TLabel;
    CheckBoxEnvTranceGateStep1: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep2: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep3: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep4: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep5: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep6: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep7: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep8: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep9: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep10: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep11: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep12: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep13: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep14: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep15: TSGTK0CheckBox;
    CheckBoxEnvTranceGateStep16: TSGTK0CheckBox;
    ButtonEnvTranceGateGenerate: TSGTK0Button;
    GroupBox30: TSGTK0Panel;
    Label76: TLabel;
    SpinEditEnvTranceGateOnAmp: TSGTK0Edit;
    GroupBox31: TSGTK0Panel;
    Label77: TLabel;
    SpinEditEnvTranceGateOffAmp: TSGTK0Edit;
    GroupBox32: TSGTK0Panel;
    Label78: TLabel;
    SpinEditEnvTranceGateBPM: TSGTK0Edit;
    ComboBoxEnvTranceGateNoteLength: TSGTK0ComboBox;
    SpinEditEnvTranceGateDots: TSGTK0Edit;
    TabSheetEnvAmplifer: TSGTK0TabSheet;
    Label104: TLabel;
    Label105: TLabel;
    SpinEditEnvAmpliferAmplify: TSGTK0Edit;
    ButtonEnvAmpiferAmplify: TSGTK0Button;
    PanelFreedrawnEnvelopeEditor: TSGTK0Panel;
    ButtonFreedrawnEnvelopeNormalize: TSGTK0Button;
    ButtonFreedrawnEnvelopeReverse: TSGTK0Button;
    ButtonFreedrawnEnvelopeInvert: TSGTK0Button;
    ButtonFreedrawnEnvelopeClear: TSGTK0Button;
    EditEnvelopeName: TSGTK0Edit;
    Label22: TLabel;
    TabSheetInstrumentSamples: TSGTK0TabSheet;
    TabSheetInstrumentSpeech: TSGTK0TabSheet;
    SGTK0Panel71: TSGTK0Panel;
    SGTK0Panel84: TSGTK0Panel;
    ComboBoxSamples: TSGTK0ComboBox;
    EditSampleName: TSGTK0Edit;
    SGTK0Panel89: TSGTK0Panel;
    ButtonSamplesClear: TSGTK0Button;
    ButtonSamplesInvert: TSGTK0Button;
    ButtonSamplesReverse: TSGTK0Button;
    ButtonSamplesNormalize: TSGTK0Button;
    PanelSamplesLengthSamples: TSGTK0Panel;
    SGTK0Panel90: TSGTK0Panel;
    SGTK0Panel91: TSGTK0Panel;
    SGTK0Panel92: TSGTK0Panel;
    GroupBox4: TSGTK0Panel;
    Panel1: TSGTK0Panel;
    ButtonLoadSample: TSGTK0Button;
    ButtonSaveSample: TSGTK0Button;
    ButtonOscSampleCopy: TSGTK0Button;
    ButtonOscSampleCut: TSGTK0Button;
    ButtonOscSamplePaste: TSGTK0Button;
    ButtonOscSampleSetLoop: TSGTK0Button;
    ButtonOscSampleDelLoop: TSGTK0Button;
    ButtonOscSampleDelSustainLoop: TSGTK0Button;
    ButtonOscSampleSetSustainLoop: TSGTK0Button;
    ButtonOscSampleFixLoops: TSGTK0Button;
    ButtonOscSampleZoomPlus: TSGTK0Button;
    ButtonOscSampleZoomMinus: TSGTK0Button;
    ButtonOscSampleDel: TSGTK0Button;
    ButtonOscSampleResetZoom: TSGTK0Button;
    ButtonOscSampleClear: TSGTK0Button;
    PanelOscSampleWaveEditor: TSGTK0Panel;
    ScrollBarSample: TSGTK0Scrollbar;
    SGTK0Panel93: TSGTK0Panel;
    SGTK0Panel94: TSGTK0Panel;
    SGTK0Panel95: TSGTK0Panel;
    PageControlInstrumentSample: TSGTK0PageControl;
    TabSheetSampleGeneralSettings: TSGTK0TabSheet;
    SGTK0Panel81: TSGTK0Panel;
    Label26: TLabel;
    Label30: TLabel;
    EditSamplesSampleRate: TSGTK0Edit;
    SGTK0Panel82: TSGTK0Panel;
    Label31: TLabel;
    EditSamplesPhaseSamples: TSGTK0Edit;
    ButtonSamplesPhaseSamplesCalc: TSGTK0Button;
    SGTK0Panel83: TSGTK0Panel;
    Label32: TLabel;
    ComboBoxSamplesNote: TSGTK0ComboBox;
    SGTK0Panel86: TSGTK0Panel;
    Label33: TLabel;
    LabelSamplesFineTune: TLabel;
    ScrollbarSamplesFineTune: TSGTK0Scrollbar;
    SGTK0Panel51: TSGTK0Panel;
    CheckBoxSamplesRandomStartPosition: TSGTK0CheckBox;
    TabSheetSamplePadSynth: TSGTK0TabSheet;
    SGTK0Panel52: TSGTK0Panel;
    CheckBoxSamplesPadSynthActive: TSGTK0CheckBox;
    SGTK0Panel107: TSGTK0Panel;
    CheckBoxSamplesPadSynthExtended: TSGTK0CheckBox;
    SGTK0Panel54: TSGTK0Panel;
    Label43: TLabel;
    EditSamplesPadSynthWaveTableSize: TSGTK0Edit;
    SGTK0Panel55: TSGTK0Panel;
    Label44: TLabel;
    EditSamplesPadSynthSampleRate: TSGTK0Edit;
    SGTK0Panel56: TSGTK0Panel;
    Label45: TLabel;
    EditSamplesPadSynthFrequency: TSGTK0Edit;
    SGTK0Panel57: TSGTK0Panel;
    Label46: TLabel;
    EditSamplesPadSynthBandwidth: TSGTK0Edit;
    SGTK0Panel58: TSGTK0Panel;
    Label47: TLabel;
    EditSamplesPadSynthBandwidthScale: TSGTK0Edit;
    SGTK0Panel59: TSGTK0Panel;
    Label48: TLabel;
    EditSamplesPadSynthNumberOfHarmonics: TSGTK0Edit;
    SGTK0Panel60: TSGTK0Panel;
    Label49: TLabel;
    ComboBoxSamplesPadSynthProfile: TSGTK0ComboBox;
    SGTK0Panel96: TSGTK0Panel;
    SGTK0Panel97: TSGTK0Panel;
    ComboBoxSpeechTexts: TSGTK0ComboBox;
    EditSpeechTextName: TSGTK0Edit;
    SGTK0Panel99: TSGTK0Panel;
    SGTK0Panel100: TSGTK0Panel;
    SGTK0Panel101: TSGTK0Panel;
    SGTK0Panel102: TSGTK0Panel;
    MemoSpeechText: TSGTK0Memo;
    MemoSpeechTextPhonems: TSGTK0Memo;
    SGTK0Panel76: TSGTK0Panel;
    GroupBoxTextToPhonemConverter: TSGTK0Panel;
    LabelAlvey: TLabel;
    Label21: TLabel;
    EditSpeechTextInput: TSGTK0Edit;
    EditSpeechPhonemOutput: TSGTK0Edit;
    ComboBoxConverterSource: TSGTK0ComboBox;
    SGTK0Panel78: TSGTK0Panel;
    ComboBoxSpeechConvertLanguage: TSGTK0ComboBox;
    SGTK0Panel77: TSGTK0Panel;
    SGTK0Panel103: TSGTK0Panel;
    SGTK0Panel104: TSGTK0Panel;
    SGTK0Panel105: TSGTK0Panel;
    Label23: TLabel;
    MemoSpeechHelp: TSGTK0Memo;
    Label34: TLabel;
    ComboBoxSamplesLoopMode: TSGTK0ComboBox;
    Label36: TLabel;
    EditSamplesLoopStart: TSGTK0Edit;
    EditSamplesLoopEnd: TSGTK0Edit;
    Label37: TLabel;
    ComboBoxSamplesSustainLoopMode: TSGTK0ComboBox;
    Label38: TLabel;
    Label39: TLabel;
    EditSamplesSustainLoopStart: TSGTK0Edit;
    EditSamplesSustainLoopEnd: TSGTK0Edit;
    Label40: TLabel;
    CheckBoxInstrumentVoiceOscillatorRandomPhase: TSGTK0CheckBox;
    SGTK0Panel7: TSGTK0Panel;
    SGTK0Panel174: TSGTK0Panel;
    Label41: TLabel;
    Label42: TLabel;
    ScrollbarInstrumentVoiceOscillatorPluckedStringReflection: TSGTK0Scrollbar;
    LabelInstrumentVoiceOscillatorPluckedStringReflection: TLabel;
    Label120: TLabel;
    ScrollbarInstrumentVoiceOscillatorPluckedStringPick: TSGTK0Scrollbar;
    LabelInstrumentVoiceOscillatorPluckedStringPick: TLabel;
    Label122: TLabel;
    ScrollbarInstrumentVoiceOscillatorPluckedStringPickUp: TSGTK0Scrollbar;
    LabelInstrumentVoiceOscillatorPluckedStringPickUp: TLabel;
    Label124: TLabel;
    ScrollbarInstrumentVoiceOscillatorPluckedStringDelayLineWidth: TSGTK0Scrollbar;
    LabelInstrumentVoiceOscillatorPluckedStringDelayLineWidth: TLabel;
    Label126: TLabel;
    ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineMode: TSGTK0ComboBox;
    SGTK0Panel48: TSGTK0Panel;
    SGTK0Panel53: TSGTK0Panel;
    Label119: TLabel;
    Label125: TLabel;
    LabelInstrumentVoiceOscillatorSuperOscCount: TLabel;
    Label128: TLabel;
    LabelInstrumentVoiceOscillatorSuperOscDetune: TLabel;
    Label130: TLabel;
    LabelInstrumentVoiceOscillatorSuperOscMix: TLabel;
    Label132: TLabel;
    ScrollbarInstrumentVoiceOscillatorSuperOscCount: TSGTK0Scrollbar;
    ScrollbarInstrumentVoiceOscillatorSuperOscDetune: TSGTK0Scrollbar;
    ScrollbarInstrumentVoiceOscillatorSuperOscMix: TSGTK0Scrollbar;
    ComboBoxInstrumentVoiceOscillatorSuperOscWaveform: TSGTK0ComboBox;
    SGTK0Panel87: TSGTK0Panel;
    Label121: TLabel;
    ComboBoxInstrumentVoiceOscillatorSuperOscMode: TSGTK0ComboBox;
    SGTK0Panel88: TSGTK0Panel;
    LabelInstrumentVoiceOscillatorPanning: TLabel;
    ScrollbarInstrumentVoiceOscillatorPanning: TSGTK0Scrollbar;
    CheckBoxInstrumentVoiceOscillatorPanning: TSGTK0CheckBox;
    PopupMenuInstruments: TPopupMenu;
    SGTK0Panel98: TSGTK0Panel;
    Label123: TLabel;
    ComboBoxInstrumentVoiceLFOPhaseSync: TSGTK0ComboBox;
    SGTK0Panel106: TSGTK0Panel;
    CheckBoxChannelLFOActive: TSGTK0CheckBox;
    SGTK0Panel186: TSGTK0Panel;
    SGTK0Panel187: TSGTK0Panel;
    Label127: TLabel;
    LabelChannelLFORate: TLabel;
    ScrollbarChannelLFORate: TSGTK0Scrollbar;
    SGTK0Panel188: TSGTK0Panel;
    Label129: TLabel;
    ComboBoxSamplesPadSynthCurveMode: TSGTK0ComboBox;
    SGTK0Panel189: TSGTK0Panel;
    Label131: TLabel;
    LabelSamplesPadSynthCurveSteepness: TLabel;
    ScrollbarSamplesPadSynthCurveSteepness: TSGTK0Scrollbar;
    SGTK0Panel190: TSGTK0Panel;
    Label134: TLabel;
    LabelSamplesPadSynthBalance: TLabel;
    ScrollbarSamplesPadSynthBalance: TSGTK0Scrollbar;
    SGTK0Panel191: TSGTK0Panel;
    CheckBoxSamplesPadSynthExtendedBalance: TSGTK0CheckBox;
    ButtonSamplesPadSynthGenIt1: TSGTK0Button;
    SGTK0Button1: TSGTK0Button;
    SGTK0Panel192: TSGTK0Panel;
    CheckBoxSamplesPadSynthStereo: TSGTK0CheckBox;
    SGTK0Panel195: TSGTK0Panel;
    CheckBoxSSE: TSGTK0CheckBox;
    SGTK0Panel193: TSGTK0Panel;
    CheckBoxMultithreading: TSGTK0CheckBox;
    CheckBoxGlobalsDelayRecursive: TSGTK0CheckBox;
    SGTK0Panel194: TSGTK0Panel;
    CheckBoxGlobalsClipping: TSGTK0CheckBox;
    SGTK0Panel196: TSGTK0Panel;
    SGTK0Panel197: TSGTK0Panel;
    Label133: TLabel;
    ComboBoxInstrumentChannelCompressorSideIn: TSGTK0ComboBox;
    SGTK0TabControlChannelDelay: TSGTK0TabControl;
    SGTK0Panel182: TSGTK0Panel;
    CheckBoxInstrumentChannelDelayFine: TSGTK0CheckBox;
    SGTK0Panel183: TSGTK0Panel;
    CheckBoxInstrumentChannelDelayRecursive: TSGTK0CheckBox;
    PanelInstrumentChannelDelayOptions: TSGTK0Panel;
    CheckBoxInstrumentChannelDelayActive: TSGTK0CheckBox;
    SGTK0Panel63: TSGTK0Panel;
    CheckBoxInstrumentChannelDelayClockSync: TSGTK0CheckBox;
    PanelInstrumentChannelDelayFeedBackLeft: TSGTK0Panel;
    LabelNameInstrumentChannelDelayFeedBackLeft: TLabel;
    LabelInstrumentChannelDelayFeedBackLeft: TLabel;
    ScrollbarInstrumentChannelDelayFeedBackLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelDelayTimeLeft: TSGTK0Panel;
    LabelNameInstrumentChannelDelayTimeLeft: TLabel;
    LabelInstrumentChannelDelayTimeLeft: TLabel;
    ScrollbarInstrumentChannelDelayTimeLeft: TSGTK0Scrollbar;
    PanelInstrumentChannelDelayWet: TSGTK0Panel;
    LabelNameInstrumentChannelDelayWet: TLabel;
    LabelInstrumentChannelDelayWet: TLabel;
    ScrollbarInstrumentChannelDelayWet: TSGTK0Scrollbar;
    PanelInstrumentChannelDelayDry: TSGTK0Panel;
    LabelNameInstrumentChannelDelayDry: TLabel;
    LabelInstrumentChannelDelayDry: TLabel;
    ScrollbarInstrumentChannelDelayDry: TSGTK0Scrollbar;
    PanelInstrumentChannelDelayTimeRight: TSGTK0Panel;
    LabelNameInstrumentChannelDelayTimeRight: TLabel;
    LabelInstrumentChannelDelayTimeRight: TLabel;
    ScrollbarInstrumentChannelDelayTimeRight: TSGTK0Scrollbar;
    PanelInstrumentChannelDelayFeedBackRight: TSGTK0Panel;
    LabelNameInstrumentChannelDelayFeedBackRight: TLabel;
    LabelInstrumentChannelDelayFeedBackRight: TLabel;
    ScrollbarInstrumentChannelDelayFeedBackRight: TSGTK0Scrollbar;
    SGTK0Panel198: TSGTK0Panel;
    CheckBoxInstrumentLinkActive: TSGTK0CheckBox;
    SGTK0Panel199: TSGTK0Panel;
    SGTK0Panel200: TSGTK0Panel;
    Label135: TLabel;
    LabelInstrumentLinkChannel: TLabel;
    ScrollbarInstrumentLinkChannel: TSGTK0Scrollbar;
    SGTK0Panel201: TSGTK0Panel;
    Label137: TLabel;
    LabelInstrumentLinkProgram: TLabel;
    ScrollbarInstrumentLinkProgram: TSGTK0Scrollbar;
    SGTK0Menu1: TSGTK0Menu;
    PanelTopViewChnStates: TSGTK0Panel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PanelGlobalPoly: TSGTK0Panel;
    SGTK0PanelCPUTime: TSGTK0Panel;
    PanelTopViewGraphics: TSGTK0Panel;
    ImageTopViewGraphics: TImage;
    SGTK0Panel202: TSGTK0Panel;
    Label136: TLabel;
    LabelGlobalsRampingLen: TLabel;
    ScrollbarGlobalsRampingLen: TSGTK0Scrollbar;
    SGTK0Panel203: TSGTK0Panel;
    Label138: TLabel;
    ComboBoxGlobalsRampingMode: TSGTK0ComboBox;
    ButtonSaveBBFFile: TSGTK0Button;
    ButtonExportExportEXE: TSGTK0Button;
    ComboBoxInstrumentVoiceOscillatorNoteEnd: TSGTK0ComboBox;
    Label10: TLabel;
    SGTK0Panel204: TSGTK0Panel;
    SGTK0Panel205: TSGTK0Panel;
    CheckBoxInstrumentVoiceOscillatorOutput: TSGTK0CheckBox;
    ComboBoxInstrumentVoiceOscillatorInput: TSGTK0ComboBox;
    Label139: TLabel;
    ComboBoxInstrumentVoiceOscillatorHardSyncInput: TSGTK0ComboBox;
    SGTK0PanelInstrumentController: TSGTK0Panel;
    Label140: TLabel;
    CheckBoxInstrumentUseTuningTable: TSGTK0CheckBox;
    SGTK0MemoTuningTable: TSGTK0Memo;
    SGTK0ButtonImportScaleFile: TSGTK0Button;
    OpenDialogScaleFile: TOpenDialog;
    SGTK0ButtonInstrumentTuningParse: TSGTK0Button;
    SGTK0ButtonScaleExport: TSGTK0Button;
    SaveDialogTuning: TSaveDialog;
    SGTK0ButtonInstrumentSampleScriptGenerate: TSGTK0Button;
    SGTK0ComboBoxInstrumentSampleScriptLanguage: TSGTK0ComboBox;
    SGTK0ButtonInstrumentSampleGetExample: TSGTK0Button;
    PopupMenuEditor: TPopupMenu;
    Undo2: TMenuItem;
    Redo2: TMenuItem;
    N5: TMenuItem;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Delete2: TMenuItem;
    N6: TMenuItem;
    Selectall2: TMenuItem;
    Unselectall2: TMenuItem;
    SGTK0Panel206: TSGTK0Panel;
    SGTK0CheckBoxFineOversample: TSGTK0CheckBox;
    SGTK0CheckBoxFineSincOversample: TSGTK0CheckBox;
    SGTK0Panel207: TSGTK0Panel;
    Label141: TLabel;
    LabelOversampleOrder: TLabel;
    SGTK0ScrollbarOversampleOrder: TSGTK0Scrollbar;
    SGTK0Panel208: TSGTK0Panel;
    SGTK0ButtonSampleMultiLoad: TSGTK0Button;
    SGTK0ButtonInstrumentClear: TSGTK0Button;
    procedure FormCreate(Sender: TObject);
    procedure EditSpeechTextInputChange(Sender: TObject);
    procedure ComboBoxConverterSourceChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AudioStatusTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PanelTitleDblClick(Sender: TObject);
    procedure PanelCopyrightDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: boolean);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure EditInstrumentNameChange(Sender: TObject);
    procedure ButtonPreviousInstrumentClick(Sender: TObject);
    procedure ButtonNextInstrumentClick(Sender: TObject);
    procedure PanelInstrumentNrClick(Sender: TObject);
    procedure SelectIns1Click(Sender: TObject);
    procedure PopupMenuInstrumentsPopup(Sender: TObject);
    procedure CheckBoxInstrumentGlobalCarryClick(Sender: TObject);
    procedure ButtonSetToChannelClick(Sender: TObject);
    procedure ScrollBarInstrumentGlobalVolumeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollBarInstrumentGlobalTransposeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollBarInstrumentGlobalChannelVolumeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollBarInstrumentGlobalMaxPolyphonyScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentGlobalOutputScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentGlobalReverbScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentGlobalDelayScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentGlobalChorusFlangerScroll(Sender: TObject;
      ScrollPos: integer);
    procedure TabControlInstrumentVoiceOscillatorsTabChanged(
      Sender: TObject);
    procedure PageControlInstrumentVoiceTabChanged(Sender: TObject);
    procedure TabControlInstrumentVoiceEnvelopesTabChanged(Sender: TObject);
    procedure TabControlInstrumentVoiceLFOsTabChanged(Sender: TObject);
    procedure TabControlInstrumentVoiceFiltersTabChanged(Sender: TObject);
    procedure ScrollbarModulationMatrixItemsScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ComboBoxInstrumentVoiceOscillatorSynthesisTypeChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorWaveformChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorNoteEndChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorNoteBeginChange(
      Sender: TObject);
    procedure ScrollbarInstrumentVoiceOscillatorColorScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollBarInstrumentVoiceOscillatorFeedbackScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorTransposeScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorFinetuneScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorPhaseStartScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorVolumeScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorGlideScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentVoiceOscillatorHardsyncClick(
      Sender: TObject);
    procedure CheckBoxInstrumentVoiceOscillatorCarryClick(Sender: TObject);
    procedure ComboBoxInstrumentVoiceADSRAttackChange(Sender: TObject);
    procedure ComboBoxInstrumentVoiceADSRDecayChange(Sender: TObject);
    procedure ComboBoxInstrumentVoiceADSRSustainChange(Sender: TObject);
    procedure ComboBoxInstrumentVoiceADSRReleaseChange(Sender: TObject);
    procedure TabControlInstrumentVoiceADSRsTabChanged(Sender: TObject);
    procedure ScrollBarInstrumentVoiceADSRAttackScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollBarInstrumentVoiceADSRDecayScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollBarInstrumentVoiceADSRSustainScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollBarInstrumentVoiceADSRReleaseScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceADSRAmplifyScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceADSRDecayLevelScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxInstrumentVoiceADSRActiveClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceADSRActiveCheckClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceADSRCarryClick(Sender: TObject);
    procedure PaintBoxADSRPaint(Sender: TObject);
    procedure ButtonAddModulationMatrixItemClick(Sender: TObject);
    procedure PageControlInstrumentTabChanged(Sender: TObject);
    procedure CheckBoxInstrumentVoiceEnvelopeActiveClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceEnvelopeActiveCheckClick(
      Sender: TObject);
    procedure CheckBoxInstrumentVoiceEnvelopeCarryClick(Sender: TObject);
    procedure ScrollbarInstrumentVoiceEnvelopeAmplifyScroll(
      Sender: TObject; ScrollPos: integer);
    procedure EditEnvelopeNameChange(Sender: TObject);
    procedure ComboBoxEnvelopesChange(Sender: TObject);
    procedure ComboBoxInstrumentVoiceLFOWaveformChange(Sender: TObject);
    procedure ComboBoxInstrumentVoiceLFOSampleChange(Sender: TObject);
    procedure ScrollbarInstrumentVoiceLFORateScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceLFODepthScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceLFOMiddleScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceLFOSweepScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollBarInstrumentVoiceLFOPhaseStartScroll(Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentVoiceLFOAmpClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceLFOCarryClick(Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorSampleChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceFilterModeChange(Sender: TObject);
    procedure ScrollbarInstrumentVoiceFilterCutOffScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceFilterResonanceScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceFilterVolumeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceFilterAmplifyScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxInstrumentVoiceFilterCascadedClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceFilterChainClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceFilterCarryClick(Sender: TObject);
    procedure ComboBoxInstrumentVoiceDistortionModeChange(
      Sender: TObject);
    procedure ScrollbarInstrumentVoiceDistortionGainScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceDistortionDistScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceDistortionRateScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxInstrumentVoiceDistortionCarryClick(Sender: TObject);
    procedure ButtonInstrumentVoiceOrderMoveToUpClick(Sender: TObject);
    procedure ButtonInstrumentVoiceOrderMoveToDownClick(Sender: TObject);
    procedure ComboBoxInstrumentChannelDistortionModeChange(
      Sender: TObject);
    procedure ScrollBarInstrumentChannelDistortionGainScroll(Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelDistortionDistScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelDistortionRateScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentChannelDistortionCarryClick(
      Sender: TObject);
    procedure ComboBoxInstrumentChannelFilterModeChange(Sender: TObject);
    procedure ScrollbarInstrumentChannelFilterCutOffScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelFilterResonanceScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelFilterVolumeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelFilterAmplifyScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentChannelFilterCascadedClick(
      Sender: TObject);
    procedure CheckBoxInstrumentChannelFilterChainClick(Sender: TObject);
    procedure CheckBoxInstrumentChannelDelayActiveClick(Sender: TObject);
    procedure ScrollbarInstrumentChannelDelayWetScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelDelayTimeLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelDelayTimeRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelDelayFeedBackLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelDelayFeedBackRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentChannelChorusFlangerActiveClick(
      Sender: TObject);
    procedure ScrollbarInstrumentChannelChorusFlangerWetScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerTimeLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerTimeRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerFeedBackLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerFeedBackRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerLFORateLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerLFORateRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerLFODepthLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerLFODepthRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerLFOPhaseLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerLFOPhaseRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentChannelChorusFlangerCarryClick(
      Sender: TObject);
    procedure ScrollbarInstrumentChannelDelayDryScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelChorusFlangerDryScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ComboBoxInstrumentChannelCompressorModeChange(
      Sender: TObject);
    procedure ScrollbarInstrumentChannelCompressorThresholdScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelCompressorRatioScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelCompressorWindowScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelCompressorSoftHardKneeScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelCompressorOutGainScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelCompressorAttackScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelCompressorReleaseScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentChannelCompressorAutoGainClick(
      Sender: TObject);
    procedure CheckBoxInstrumentChannelSpeechActiveClick(Sender: TObject);
    procedure ScrollbarInstrumentChannelSpeechFrameLengthScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechSpeedScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechTextNumberScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ButtonInstrumentChannelOrderMoveToUpClick(Sender: TObject);
    procedure ButtonInstrumentChannelOrderMoveToDownClick(Sender: TObject);
    procedure ButtonFreedrawnEnvelopeClearClick(Sender: TObject);
    procedure CheckBoxGlobalsReverbActiveClick(Sender: TObject);
    procedure ScrollbarGlobalsReverbPreDelayScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsReverbCombFilterSeparationScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsReverbRoomSizeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsReverbFeedBackScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsReverbAbsortionScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsReverbDryScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsReverbWetScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsReverbNumberOfAllPassFiltersScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsDelayWetScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsDelayDryScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsDelayTimeLeftScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsDelayTimeRightScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsDelayFeedBackLeftScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsDelayFeedBackRightScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxGlobalsDelayActiveClick(Sender: TObject);
    procedure ScrollbarGlobalsChorusFlangerWetScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerDryScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerTimeLeftScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerTimeRightScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerFeedBackLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerLFORateLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerFeedBackRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerLFORateRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerLFODepthLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerLFODepthRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerLFOPhaseLeftScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerLFOPhaseRightScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxGlobalsChorusFlangerActiveClick(Sender: TObject);
    procedure CheckBoxGlobalsChorusFlangerCarryClick(Sender: TObject);
    procedure CheckBoxGlobalsEndFilterActiveClick(Sender: TObject);
    procedure ScrollbarGlobalsEndFilterLowCutScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsEndFilterHighCutScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ComboBoxGlobalsCompressorModeChange(Sender: TObject);
    procedure ScrollbarGlobalsCompressorThresholdScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsCompressorRatioScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsCompressorWindowScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsCompressorSoftHardKneeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsCompressorOutGainScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsCompressorAttackScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsCompressorReleaseScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxGlobalsCompressorAutoGainClick(Sender: TObject);
    procedure ComboBoxGlobalsFinalCompressorModeChange(Sender: TObject);
    procedure ScrollbarGlobalsFinalCompressorThresholdScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsFinalCompressorRatioScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsFinalCompressorWindowScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsFinalCompressorSoftHardKneeScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsFinalCompressorOutGainScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsFinalCompressorAttackScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsFinalCompressorReleaseScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxGlobalsFinalCompressorAutoGainClick(Sender: TObject);
    procedure TimerSizeTimer(Sender: TObject);
    procedure ComboBoxSpeechTextsChange(Sender: TObject);
    procedure EditSpeechTextNameChange(Sender: TObject);
    procedure MemoSpeechTextChange(Sender: TObject);
    procedure ComboBoxSpeechConvertLanguageChange(Sender: TObject);
    procedure ButtonFreedrawnEnvelopeInvertClick(Sender: TObject);
    procedure ButtonFreedrawnEnvelopeReverseClick(Sender: TObject);
    procedure ButtonFreedrawnEnvelopeNormalizeClick(Sender: TObject);
    procedure ScrollbarGlobalsClockBPMScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalsClockTPBScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxGlobalsDelayClockSyncClick(Sender: TObject);
    procedure CheckBoxInstrumentChannelDelayClockSyncClick(
      Sender: TObject);
    procedure ComboBoxSamplesChange(Sender: TObject);
    procedure EditSampleNameChange(Sender: TObject);
    procedure ButtonOscSampleZoomPlusClick(Sender: TObject);
    procedure ButtonOscSampleZoomMinusClick(Sender: TObject);
    procedure ButtonOscSampleResetZoomClick(Sender: TObject);
    procedure ButtonLoadSampleClick(Sender: TObject);
    procedure ButtonSaveSampleClick(Sender: TObject);
    procedure ScrollbarSamplesFineTuneScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ButtonOscSampleClearClick(Sender: TObject);
    procedure ButtonOscSampleCopyClick(Sender: TObject);
    procedure ButtonOscSampleCutClick(Sender: TObject);
    procedure ButtonOscSamplePasteClick(Sender: TObject);
    procedure ButtonOscSampleDelClick(Sender: TObject);
    procedure ButtonOscSampleSetLoopClick(Sender: TObject);
    procedure ButtonOscSampleDelLoopClick(Sender: TObject);
    procedure ButtonOscSampleSetSustainLoopClick(Sender: TObject);
    procedure ButtonOscSampleDelSustainLoopClick(Sender: TObject);
    procedure ButtonOscSampleFixLoopsClick(Sender: TObject);
    procedure ComboBoxSamplesLoopModeChange(Sender: TObject);
    procedure ComboBoxSamplesSustainLoopModeChange(Sender: TObject);
    procedure EditSamplesLoopStartChange(Sender: TObject);
    procedure EditSamplesLoopEndChange(Sender: TObject);
    procedure EditSamplesSustainLoopStartChange(Sender: TObject);
    procedure EditSamplesSustainLoopEndChange(Sender: TObject);
    procedure EditSamplesSampleRateChange(Sender: TObject);
    procedure EditSamplesPhaseSamplesChange(Sender: TObject);
    procedure ComboBoxSamplesNoteChange(Sender: TObject);
    procedure ButtonSamplesClearClick(Sender: TObject);
    procedure ButtonSamplesPhaseSamplesCalcClick(Sender: TObject);
    procedure ButtonSamplesInvertClick(Sender: TObject);
    procedure ButtonSamplesReverseClick(Sender: TObject);
    procedure ButtonSamplesNormalizeClick(Sender: TObject);
    procedure CheckBoxSamplesRandomStartPositionClick(Sender: TObject);
    procedure CheckBoxSamplesPadSynthActiveClick(Sender: TObject);
    procedure CheckBoxSamplesPadSynthExtendedClick(Sender: TObject);
    procedure EditSamplesPadSynthWaveTableSizeChange(Sender: TObject);
    procedure EditSamplesPadSynthSampleRateChange(Sender: TObject);
    procedure EditSamplesPadSynthFrequencyChange(Sender: TObject);
    procedure EditSamplesPadSynthBandwidthChange(Sender: TObject);
    procedure EditSamplesPadSynthBandwidthScaleChange(Sender: TObject);
    procedure EditSamplesPadSynthNumberOfHarmonicsChange(Sender: TObject);
    procedure ComboBoxSamplesPadSynthProfileChange(Sender: TObject);
    procedure CheckBoxInstrumentVoiceOscillatorPMFMExtendedModeClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceEnvelopeCenteriseClick(
      Sender: TObject);
    procedure CheckBoxInstrumentVoiceADSRCenteriseClick(Sender: TObject);
    procedure TabSheetSamplesShow(Sender: TObject);
    procedure CheckBoxInstrumentChannelPitchShifterActiveClick(Sender: TObject);
    procedure ScrollbarInstrumentChannelPitchShifterTuneScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelPitchShifterFineTuneScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxGlobalPitchShifterActiveClick(Sender: TObject);
    procedure ScrollbarGlobalPitchShifterTuneScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalPitchShifterFineTuneScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechColorScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechNoiseGainScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechGainScroll(Sender: TObject;
      ScrollPos: integer);
    procedure EditInstrumentChannelSpeechF4Change(Sender: TObject);
    procedure EditInstrumentChannelSpeechF5Change(Sender: TObject);
    procedure EditInstrumentChannelSpeechF6Change(Sender: TObject);
    procedure EditInstrumentChannelSpeechB4Change(Sender: TObject);
    procedure EditInstrumentChannelSpeechB5Change(Sender: TObject);
    procedure EditInstrumentChannelSpeechB6Change(Sender: TObject);
    procedure ComboBoxInstrumentChannelEQModeChange(Sender: TObject);
    procedure CheckBoxInstrumentChannelEQActiveClick(Sender: TObject);
    procedure ScrollbarInstrumentChannelEQGain1Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain2Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain3Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain4Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain5Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain6Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain7Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain9Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain8Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarInstrumentChannelEQGain10Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure EditInstrumentChannelEQBandHz1Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz2Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz3Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz4Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz5Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz6Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz7Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz8Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz9Change(Sender: TObject);
    procedure EditInstrumentChannelEQBandHz10Change(Sender: TObject);
    procedure ButtonInstrumentChannelEQResetClick(Sender: TObject);
    procedure ComboBoxGlobalEQModeChange(Sender: TObject);
    procedure CheckBoxGlobalEQActiveClick(Sender: TObject);
    procedure ScrollbarGlobalEQGain1Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain2Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain3Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain4Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain5Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain6Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain7Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain9Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain8Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQGain10Scroll(Sender: TObject;
      ScrollPos: integer);
    procedure EditGlobalEQBandHz1Change(Sender: TObject);
    procedure EditGlobalEQBandHz2Change(Sender: TObject);
    procedure EditGlobalEQBandHz3Change(Sender: TObject);
    procedure EditGlobalEQBandHz4Change(Sender: TObject);
    procedure EditGlobalEQBandHz5Change(Sender: TObject);
    procedure EditGlobalEQBandHz6Change(Sender: TObject);
    procedure EditGlobalEQBandHz7Change(Sender: TObject);
    procedure EditGlobalEQBandHz8Change(Sender: TObject);
    procedure EditGlobalEQBandHz9Change(Sender: TObject);
    procedure EditGlobalEQBandHz10Change(Sender: TObject);
    procedure ButtonGlobalEQResetClick(Sender: TObject);
    procedure ButtonEnvADSRGenerateClick(Sender: TObject);
    procedure ButtonEnvTranceGateGenerateClick(Sender: TObject);
    procedure ButtonEnvAmpiferAmplifyClick(Sender: TObject);
    procedure SpinEditEnvADSRAttackChange(Sender: TObject);
    procedure SpinEditEnvADSRDecayChange(Sender: TObject);
    procedure SpinEditEnvADSRSustainTimeChange(Sender: TObject);
    procedure SpinEditEnvADSRReleaseChange(Sender: TObject);
    procedure SpinEditEnvADSRAmplifyChange(Sender: TObject);
    procedure SpinEditEnvADSRSustainLevelChange(Sender: TObject);
    procedure CheckBoxEnvADSRSustainClick(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep1Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep2Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep3Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep4Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep5Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep6Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep7Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep8Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep9Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep10Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep11Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep12Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep13Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep14Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep15Click(Sender: TObject);
    procedure CheckBoxEnvTranceGateStep16Click(Sender: TObject);
    procedure SpinEditEnvTranceGateOnAmpChange(Sender: TObject);
    procedure SpinEditEnvTranceGateOffAmpChange(Sender: TObject);
    procedure SpinEditEnvTranceGateBPMChange(Sender: TObject);
    procedure ComboBoxEnvTranceGateNoteLengthChange(Sender: TObject);
    procedure SpinEditEnvTranceGateDotsChange(Sender: TObject);
    procedure SpinEditEnvAmpliferAmplifyChange(Sender: TObject);
    procedure ScrollbarInstrumentChannelEQPreAmpScroll(Sender: TObject;
      ScrollPos: integer);
    procedure ScrollbarGlobalEQPreAmpScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxGlobalEQCascadedClick(Sender: TObject);
    procedure EditGlobalEQOctaveFactorChange(Sender: TObject);
    procedure CheckBoxInstrumentChannelEQCascadedClick(Sender: TObject);
    procedure EditInstrumentChannelEQOctaveFactorChange(Sender: TObject);
    procedure CheckBoxGlobalEQAddCascadedClick(Sender: TObject);
    procedure CheckBoxInstrumentChannelEQAddCascadedClick(Sender: TObject);
    procedure ButtonInstrumentChannelEQLoadEQFClick(Sender: TObject);
    procedure ButtonGlobalEQLoadEQFClick(Sender: TObject);
    procedure ButtonInstrumentChannelEQSaveEQFClick(Sender: TObject);
    procedure ButtonGlobalEQSaveEQFClick(Sender: TObject);
    procedure ButtonGlobalEQResetISOClick(Sender: TObject);
    procedure ButtonInstrumentChannelEQResetISOClick(Sender: TObject);
    procedure ButtonExportMIDILoadClick(Sender: TObject);
    procedure ButtonExportMIDIRecordStopClick(Sender: TObject);
    procedure EditExportTrackNameChange(Sender: TObject);
    procedure EditExportAuthorChange(Sender: TObject);
    procedure MemoExportCommentsChange(Sender: TObject);
    procedure ButtonExportSaveBMFClick(Sender: TObject);
    procedure ButtonExportClearClick(Sender: TObject);
    procedure ButtonSaveBBFFileClick(Sender: TObject);
    procedure ButtonExportGenerateSynthconfigINCClick(Sender: TObject);
    procedure ButtonExportExportPASClick(Sender: TObject);
    procedure ButtonExportExportEXEClick(Sender: TObject);
    procedure ButtonExportExportHClick(Sender: TObject);
    procedure ScrollbarInstrumentChannelSpeechCascadeGainScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechParallelGainScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechAspirationGainScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentChannelSpeechFricationGainScroll(
      Sender: TObject; ScrollPos: integer);
    procedure SGTK0CheckBoxColorInverseClick(Sender: TObject);
    procedure SGTK0ScrollbarColorBScroll(Sender: TObject;
      ScrollPos: integer);
    procedure SGTK0ScrollbarColorGScroll(Sender: TObject; ScrollPos: integer);
    procedure SGTK0ScrollbarColorRScroll(Sender: TObject;
      ScrollPos: integer);
    procedure SGTK0PanelMasterSlaveClick(Sender: TObject);
    procedure SGTK0ButtonVoiceOscSwapClick(Sender: TObject);
    procedure SGTK0ButtonVoiceOscCopyClick(Sender: TObject);
    procedure SGTK0ButtonGlobalOrderUpClick(Sender: TObject);
    procedure SGTK0ButtonGlobalOrderDownClick(Sender: TObject);
    procedure SGTK0EditInstrumentVoiceFilterHzMinChange(Sender: TObject);
    procedure SGTK0EditInstrumentVoiceFilterHzMaxChange(Sender: TObject);
    procedure SGTK0EditInstrumentChannelFilterMinHzChange(Sender: TObject);
    procedure SGTK0EditInstrumentChannelFilterMaxHzChange(Sender: TObject);
    procedure SGTK0ButtonExportFXPClick(Sender: TObject);
    procedure SGTK0ButtonImportFXPClick(Sender: TObject);
    procedure SGTK0ButtonExportFXBClick(Sender: TObject);
    procedure SGTK0ButtonImportFXBClick(Sender: TObject);
    procedure SGTK0ScrollbarGlobalsVoicesCountScroll(Sender: TObject;
      ScrollPos: integer);
    procedure SGTK0ButtonConvertOldToNewUnitsClick(Sender: TObject);
    procedure ColorTimerTimer(Sender: TObject);
    procedure SGTK0TabControlVoiceDistortionTabChanged(Sender: TObject);
    procedure SGTK0TabControlChannelDistortionTabChanged(Sender: TObject);
    procedure SGTK0CheckBoxChannelFilterCarryClick(Sender: TObject);
    procedure SGTK0TabControlChannelFilterTabChanged(Sender: TObject);
    procedure SGTK0ScrollbarOversampleScroll(Sender: TObject;
      ScrollPos: integer);
    procedure SGTK0CheckBoxInstrumentChannelChorusFlangerFineClick(
      Sender: TObject);
    procedure CheckBoxGlobalsChorusFlangerFineClick(Sender: TObject);
    procedure ScrollbarInstrumentChannelChorusFlangerCountScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarGlobalsChorusFlangerCountScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxInstrumentChannelDelayFineClick(Sender: TObject);
    procedure CheckBoxGlobalsDelayFineClick(Sender: TObject);
    procedure CheckBoxInstrumentVoiceOscillatorRandomPhaseClick(
      Sender: TObject);
    procedure ScrollbarInstrumentVoiceOscillatorPluckedStringReflectionScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorPluckedStringPickScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorPluckedStringPickUpScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorPluckedStringDelayLineWidthScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineModeChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorSuperOscWaveformChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorSuperOscModeChange(
      Sender: TObject);
    procedure ScrollbarInstrumentVoiceOscillatorSuperOscCountScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorSuperOscDetuneScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorSuperOscMixScroll(
      Sender: TObject; ScrollPos: integer);
    procedure ScrollbarInstrumentVoiceOscillatorPanningScroll(
      Sender: TObject; ScrollPos: integer);
    procedure CheckBoxInstrumentVoiceOscillatorPanningClick(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceLFOPhaseSyncChange(Sender: TObject);
    procedure ScrollbarChannelLFORateScroll(Sender: TObject;
      ScrollPos: integer);
    procedure CheckBoxChannelLFOActiveClick(Sender: TObject);
    procedure ComboBoxSamplesPadSynthCurveModeChange(Sender: TObject);
    procedure ScrollbarSamplesPadSynthCurveSteepnessScroll(Sender: TObject; ScrollPos: integer);
    procedure CheckBoxSamplesPadSynthExtendedBalanceClick(Sender: TObject);
    procedure ScrollbarSamplesPadSynthBalanceScroll(Sender: TObject; ScrollPos: integer);
    procedure ButtonSamplesPadSynthGenIt1Click(Sender: TObject);
    procedure CheckBoxSamplesPadSynthStereoClick(Sender: TObject);
    procedure CheckBoxMultithreadingClick(Sender: TObject);
    procedure CheckBoxSSEClick(Sender: TObject);
    procedure CheckBoxInstrumentChannelDelayRecursiveClick(Sender: TObject);
    procedure CheckBoxGlobalsDelayRecursiveClick(Sender: TObject);
    procedure CheckBoxGlobalsClippingClick(Sender: TObject);
    procedure ComboBoxInstrumentChannelCompressorSideInChange(
      Sender: TObject);
    procedure SGTK0TabControlChannelDelayTabChanged(Sender: TObject);
    procedure CheckBoxInstrumentLinkActiveClick(Sender: TObject);
    procedure ScrollbarInstrumentLinkChannelScroll(Sender: TObject;
      ScrollPos: Integer);
    procedure ScrollbarInstrumentLinkProgramScroll(Sender: TObject;
      ScrollPos: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure SGTK0PanelCPUTimeClick(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure PanelGlobalPolyClick(Sender: TObject);
    procedure PanelTopViewChnStatesClick(Sender: TObject);
    procedure PanelTopViewGraphicsClick(Sender: TObject);
    procedure ImageTopViewGraphicsClick(Sender: TObject);
    procedure EditSamplesPadSynthWaveTableSizeExit(Sender: TObject);
    procedure SGTK0Panel92Resize(Sender: TObject);
    procedure ScrollbarGlobalsRampingLenScroll(Sender: TObject;
      ScrollPos: Integer);
    procedure ComboBoxGlobalsRampingModeChange(Sender: TObject);
    procedure CheckBoxInstrumentVoiceOscillatorOutputClick(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorInputChange(
      Sender: TObject);
    procedure ComboBoxInstrumentVoiceOscillatorHardSyncInputChange(
      Sender: TObject);
    procedure SGTK0ButtonImportScaleFileClick(Sender: TObject);
    procedure SGTK0ButtonInstrumentTuningParseClick(Sender: TObject);
    procedure CheckBoxInstrumentUseTuningTableClick(Sender: TObject);
    procedure SGTK0ButtonScaleExportClick(Sender: TObject);
    procedure SGTK0ButtonInstrumentSampleScriptGenerateClick(
      Sender: TObject);
    procedure SGTK0ButtonInstrumentSampleGetExampleClick(Sender: TObject);
    procedure Undo2Click(Sender: TObject);
    procedure Redo2Click(Sender: TObject);
    procedure Cut2Click(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure Paste2Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure Selectall2Click(Sender: TObject);
    procedure Unselectall2Click(Sender: TObject);
    procedure PopupMenuEditorPopup(Sender: TObject);
    procedure SynMemoInstrumentSampleScriptCodeChange(Sender: TObject);
    procedure SGTK0ComboBoxInstrumentSampleScriptLanguageChange(
      Sender: TObject);
    procedure SynMemoInstrumentSampleScriptCodeEnter(Sender: TObject);
    procedure SynMemoInstrumentSampleScriptCodeExit(Sender: TObject);
    procedure SGTK0Panel84Click(Sender: TObject);
    procedure PanelSamplesLengthSamplesClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure SGTK0Panel91Click(Sender: TObject);
    procedure SGTK0Panel94Click(Sender: TObject);
    procedure TabSheetSampleScriptShow(Sender: TObject);
    procedure TabSheetSampleScriptHide(Sender: TObject);
    procedure Panel9Click(Sender: TObject);
    procedure Panel11Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure LabelModulationMatrixCountClick(Sender: TObject);
    procedure SGTK0Panel71Click(Sender: TObject);
    procedure SGTK0CheckBoxFineOversampleClick(Sender: TObject);
    procedure SGTK0CheckBoxFineSincOversampleClick(Sender: TObject);
    procedure SGTK0ScrollbarOversampleOrderScroll(Sender: TObject;
      ScrollPos: Integer);
    procedure SGTK0ButtonSampleMultiLoadClick(Sender: TObject);
    procedure SGTK0ButtonInstrumentClearClick(Sender: TObject);
  private
    { Private-Deklarationen }
    OldWidth,OldHeight:integer;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public-Deklarationen }
    AudioCriticalSection:TBeRoCriticalSection;
    DataCriticalSection:TBeRoCriticalSection;
    OldInstanceCount:integer;
    InstanceMode:integer;
    APluginExportMIDIDoRecord:boolean;
    Plugin:TObject;
    DummyEnvelope:TSynthEnvelope;
    Peaks:array[0..1] of single;
    PanelChnNr:array[0..$f] of TSGTK0Panel;
    PanelChnPrg:array[0..$f] of TSGTK0Panel;
    PanelChnPoly:array[0..$f] of TSGTK0Panel;
    InChange:boolean;
    CurrentParameter:integer;
    CurrentTick,OldTick:int64;
    VUOnBitmap,VUOffBitmap,VUBufferBitmap:TBitmap;
    EnvelopeForm:TEnvelopeForm;
    ADSRBitmap:TBitmap;
    FormModulationMatrixItems:array[0..MaxVisibleModulationMatrixItems-1] of TFormModulationMatrixItem;
    MaxModulationMatrixItemsHeight:integer;
    OldScrollBoxModulationMatrixItemsScrollPos:integer;
    OldPatchNr,OldOscTab,OldADSRTab,OldEnvTab,OldLFOTab,OldFilterTab,
    OldVoiceDistTab,OldChannelDistTab,OldChannelFilterTab,OldChannelDelayTab,
    OldModulationMatrix:integer;
    BankWasChanged:boolean;
    WaveEditor:TWaveEditor;
    WaveClipboardPointer:PSINGLES;
    WaveClipboardBytes:integer;
    WaveClipboardRate:integer;
    WaveClipboardChannels:integer;
    CPEnvelopeOk:boolean;
    CPEnvelope:TSynthEnvelope;
    ColorDirty:boolean;
    ColorUpdating:boolean;
    PanelTopViewMode:integer;
    ImageTopViewGraphicsBuffer:TBitmap;
    CheckBoxInstrumentControllerResolutionResolutionCheck:array[0..31] of TSGTK0CheckBox;
    FFTBuffer:array[0..1,0..4095] of TBeRoFFTValue;
    FFTWindow:array[0..1023] of single;
    FFT:TBeRoFFT;
    OscilBufferReadyIndex:integer;
    DoSynMemoInstrumentSampleScriptCodeSelLength:boolean;
    procedure DummyOld;
    procedure ClearSample(SampleSlot:integer);
    function LoadWAVSample(Daten:TBeRoStream;SampleSlot:integer;WSMPOffset:plongword=nil):boolean;
    function SaveWAVSample(Daten:TBeRoStream):boolean;
    procedure CalculatePhaseSamples;
    procedure DrawADSR;
    procedure ExportMIDIUpdate;
    procedure EnvelopesUpdate;
    procedure SamplesUpdate;
    procedure SpeechTextsUpdate;
    procedure VoiceOrderUpdate;
    procedure ChannelOrderUpdate;
    procedure GlobalOrderUpdate;
    procedure EditorUpdate;
    procedure DeleteModulationMatrixItem(index:integer);
    function TranslateColor(Color:TColor):TColor;
    procedure UpdateColors;
    procedure UpdateColorsControls;
    procedure TopViewModeClick(Sender: TObject);
    procedure ImageTopViewGraphicsPaint(Sender: TObject);
    procedure DoModulationMatrixItemUp(Sender: TObject);
    procedure DoModulationMatrixItemDown(Sender: TObject);
    procedure CheckBoxInstrumentControllerResolutionResolutionCheckClick(Sender: TObject);
    procedure UpdateInstrumentTuning;
  end;

var
  VSTiEditor: TVSTiEditor;

implementation

uses UnitVSTiPlugin,SpeechRules,SpeechTools,VersionInfo;

{$R *.DFM}

const VUMeterWidth=16;
      VUMeterHeight=48;

function NextOfPowerTwo(x:longword):longword;
begin
 dec(x);
 x:=x or (x shr 1);
 x:=x or (x shr 2);
 x:=x or (x shr 4);
 x:=x or (x shr 8);
 x:=x or (x shr 16);
 result:=x+1;
end;

function Clip(Value,Min,Max:single):single; stdcall;
var Temp1,Temp2:single;
begin
 Temp1:=ABS(Value-Min);
 Temp2:=ABS(Value-Max);
 result:=((Temp1+(Min+Max))-Temp2)*0.5;
end;

function Note3C(I:byte):string;
const Hex:array[0..15] of char='0123456789ABCDEF';
var S:string;
    J:byte;
begin
 if I<120 then begin
  J:=I mod 12;
  case J of
   0:S:='C-';
   1:S:='C#';
   2:S:='D-';
   3:S:='D#';
   4:S:='E-';
   5:S:='F-';
   6:S:='F#';
   7:S:='G-';
   8:S:='G#';
   9:S:='A-';
   10:S:='A#';
   11:S:='B-';
   else S:='?-';
  end;
  S:=S+HEX[(I div 12) and $f];
 end else begin
  S:='';
 end;
 result:=S;
end;

function SoftSQRT(Value:single):single; stdcall;
asm
 SUB dword PTR Value,$3f800000
 SAR dword PTR Value,1
 ADD dword PTR Value,$3f800000
 FLD dword PTR Value
end;

function FastSQRT(Value:single):single;
const f0d5:single=0.5;
var Casted:longword absolute result;
begin
 result:=Value;
 Casted:=($be6eb50c-Casted) shr 1;
 result:=Value*(f0d5*(result*(3-(Value*sqr(result)))));
end;

function POWEX:single; assembler; register; {$IFDEF FPC}NOSTACKFRAME;{$ENDIF}
asm
 FYL2X
 FLD1
 FLD ST(1)
 FPREM
 F2XM1
 FADDP ST(1),ST
 FSCALE
 FSTP ST(1)
end;

function POW(Number,Exponent:single):single; assembler; stdcall;
asm
 FLD dword PTR Exponent
 FLD dword PTR Number
 CALL POWEX
end;

function LOG10(X:single):single;
const DivLN10:single=0.4342944819;
begin
 result:=LN(X)*DivLN10;
end;

procedure TVSTiEditor.TopViewModeClick(Sender: TObject);
begin
 PanelTop.SetFocus;
 PanelTopViewMode:=abs(PanelTopViewMode+1);
 if PanelTopViewMode>=6 then begin
  PanelTopViewMode:=0;
 end;
 case PanelTopViewMode of
  1..5:begin
   PanelTopViewGraphics.Visible:=true;
   PanelTopViewChnStates.Visible:=false;
   ImageTopViewGraphicsPaint(nil);
  end;
  else begin
   PanelTopViewGraphics.Visible:=false;
   PanelTopViewChnStates.Visible:=true;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentControllerResolutionResolutionCheckClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if TSGTK0CheckBox(Sender).Checked then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].Controller7BitFlags:=APlugin.Track.Instruments[APlugin.CurrentProgram].Controller7BitFlags or (longword(1) shl longword(TSGTK0CheckBox(Sender).Tag));
   end else begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].Controller7BitFlags:=APlugin.Track.Instruments[APlugin.CurrentProgram].Controller7BitFlags and not (longword(1) shl longword(TSGTK0CheckBox(Sender).Tag));
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.FormCreate(Sender: TObject);
const CCNames:array[0..31] of string=('Bank Select',
                                      'Modulation Wheel',
                                      'Breath controller',
                                      '',
                                      'Foot Pedal',
                                      'Portamento Time',
                                      'Data Entry',
                                      'Volume',
                                      'Balance',
                                      '',
                                      'Pan position',
                                      'Expression',
                                      'Effect Control 1',
                                      'Effect Control 2',
                                      '',
                                      '',
                                      'General Purpose Slider 1',
                                      'General Purpose Slider 2',
                                      'General Purpose Slider 3',
                                      'General Purpose Slider 4',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '');
var Counter,i:integer;
    S:string;
    MenuItem:TMenuItem;
begin
 DoSynMemoInstrumentSampleScriptCodeSelLength:=false;
 FFT:=TBeRoFFT.Create(OscilBufferSize);
 for i:=0 to length(FFTWindow)-1 do begin
  FFTWindow[i]:=0.54-(0.46*cos((2*pi*i)/length(FFTWindow)));
 end;
 for i:=low(CheckBoxInstrumentControllerResolutionResolutionCheck) to high(CheckBoxInstrumentControllerResolutionResolutionCheck) do begin
  CheckBoxInstrumentControllerResolutionResolutionCheck[i]:=TSGTK0CheckBox.Create(SGTK0PanelInstrumentController);
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].Parent:=SGTK0PanelInstrumentController;
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].Tag:=i;
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].Caption:=inttostr(i)+'. '+CCNames[i];
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].Left:=8+((i shr 4)*256);
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].Top:=32+((i and 15)*16);
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].Width:=256;
  CheckBoxInstrumentControllerResolutionResolutionCheck[i].OnClick:=CheckBoxInstrumentControllerResolutionResolutionCheckClick;
 end;
 OscilBufferReadyIndex:=-1;
 ColorDirty:=false;
 ColorUpdating:=false;
 ColorTimer.Enabled:=false;
 SGTK0ButtonConvertOldToNewUnits.Visible:=sysutils.fileexists('d:\BeRoProjects\BR808\VSTi\BR808.dll');
 ImageTopViewGraphicsBuffer:=TBitmap.Create;
 OldInstanceCount:=-1;
 InstanceMode:=-1;
 APluginExportMIDIDoRecord:=false;
 LabelTitleVersion.Caption:='1.00.'+BuildNumber+'.'+CompileDate;
 DoubleBuffered:=false;
 OldScrollBoxModulationMatrixItemsScrollPos:=-1;
 OldPatchNr:=-1;
 OldOscTab:=-1;
 OldADSRTab:=-1;
 OldEnvTab:=-1;
 OldLFOTab:=-1;
 OldFilterTab:=-1;
 OldVoiceDistTab:=-1;
 OldChannelDistTab:=-1;
 OldChannelFilterTab:=-1;
 OldChannelDelayTab:=-1;
 OldModulationMatrix:=-1;
 BankWasChanged:=true;
 SGTK0ScrollbarGlobalsVoicesCount.Min:=1;
 SGTK0ScrollbarGlobalsVoicesCount.Max:=NumberOfVoices;
 ScrollBarInstrumentGlobalMaxPolyphony.Min:=1;
 ScrollBarInstrumentGlobalMaxPolyphony.Max:=NumberOfVoices;
 ADSRBitmap:=TBitmap.Create;
 ADSRBitmap.Width:=PaintBoxADSR.ClientWidth;
 ADSRBitmap.Height:=PaintBoxADSR.ClientHeight;
 OldTick:=timeGetTime;
 OldWidth:=Width;
 OldHeight:=Height;
 VUOnBitmap:=TBitmap.Create;
 VUOnBitmap.Width:=VUMeterWidth;
 VUOnBitmap.Height:=VUMeterHeight;
 with VUOnBitmap.Canvas do begin
  Brush.Color:=clBlack;
  Pen.Color:=clBlack;
  Brush.Style:=bsSolid;
  Pen.Style:=psSolid;
  FillRect(ClipRect);
  Brush.Color:=$40F040;
  Pen.Color:=$40F040;
  Counter:=0;
  while Counter<VUOnBitmap.Height do begin
   if Counter<((VUOnBitmap.Height*60) div 100) then begin
    Brush.Color:=$40F040;
    Pen.Color:=$40F040;
   end else if Counter<((VUOnBitmap.Height*80) div 100) then begin
    Brush.Color:=$40F0F0;
    Pen.Color:=$40F0F0;
   end else begin
    Brush.Color:=$4040F0;
    Pen.Color:=$4040F0;
   end;
   MoveTo(0,VUOnBitmap.Height-Counter);
   LineTo(VUOnBitmap.Width,VUOnBitmap.Height-Counter);
   inc(Counter,2);
  end;
 end;

 VUOffBitmap:=TBitmap.Create;
 VUOffBitmap.Width:=VUMeterWidth;
 VUOffBitmap.Height:=VUMeterHeight;
 with VUOffBitmap.Canvas do begin
  Brush.Color:=clBlack;
  Pen.Color:=clBlack;
  Brush.Style:=bsSolid;
  Pen.Style:=psSolid;
  FillRect(ClipRect);
  Brush.Color:=$084008;
  Pen.Color:=$084008;
  Counter:=0;
  while Counter<VUOffBitmap.Height do begin
   if Counter<((VUOffBitmap.Height*60) div 100) then begin
    Brush.Color:=$084008;
    Pen.Color:=$084008;
   end else if Counter<((VUOffBitmap.Height*80) div 100) then begin
    Brush.Color:=$084040;
    Pen.Color:=$084040;
   end else begin
    Brush.Color:=$080840;
    Pen.Color:=$080840;
   end;
   MoveTo(0,VUOnBitmap.Height-Counter);
   LineTo(VUOnBitmap.Width,VUOnBitmap.Height-Counter);
   inc(Counter,2);
  end;
 end;
 VUBufferBitmap:=TBitmap.Create;
 VUBufferBitmap.Width:=VUMeterWidth;
 VUBufferBitmap.Height:=VUMeterHeight;
// TopViewModeClick
 PanelTopViewMode:=0;
 PanelTopViewGraphics.Visible:=false;
 PanelTopViewChnStates.Visible:=true;
 Peaks[0]:=0;
 Peaks[1]:=0;
 for Counter:=0 to $f do begin
  PanelChnNr[Counter]:=TSGTK0Panel.Create(PanelTopViewChnStates);
  with PanelChnNr[Counter] do begin
   Parent:=PanelTopViewChnStates;
{  BevelInner:=bvLowered;
   BevelOuter:=bvRaised;}
   Width:=28;
   Height:=16;
   Left:=40+(Counter*(Width+1));
   Top:=8;
   Font.name:='Courier New';
   Font.Size:=8;
   Caption:=INTTOSTR(Counter+1);
   if length(Caption)<2 then Caption:='0'+Caption;
  end;
  PanelChnNr[Counter].OnClick:=TopViewModeClick;
  PanelChnPrg[Counter]:=TSGTK0Panel.Create(PanelTopViewChnStates);
  with PanelChnPrg[Counter] do begin
   Parent:=PanelTopViewChnStates;
{  BevelInner:=bvLowered;
   BevelOuter:=bvRaised;}
   Width:=28;
   Height:=16;
   Left:=40+(Counter*(Width+1));
   Top:=25;
   Font.name:='Courier New';
   Font.Size:=8;
   Caption:='000';
  end;
  PanelChnPrg[Counter].OnClick:=TopViewModeClick;
  PanelChnPoly[Counter]:=TSGTK0Panel.Create(PanelTopViewChnStates);
  with PanelChnPoly[Counter] do begin
   Parent:=PanelTopViewChnStates;
{  BevelInner:=bvLowered;
   BevelOuter:=bvRaised;}
   Width:=28;
   Height:=16;
   Left:=40+(Counter*(Width+1));
   Top:=42;
   Font.name:='Courier New';
   Font.Size:=8;
   Caption:='00';
  end;
  PanelChnPoly[Counter].OnClick:=TopViewModeClick;
 end;

{ComboBoxWavetables.Items.BeginUpdate;
 ComboBoxWavetables.Items.Clear;
 FOR Counter:=0 TO 127 DO BEGIN
  S:=INTTOSTR(Counter);
  WHILE LENGTH(S)<3 DO S:='0'+S;
  ComboBoxWavetables.Items.Add(S+'.');
 END;
 ComboBoxWavetables.Items.EndUpdate;
 ComboBoxWavetables.ItemIndex:=0;}

{ComboBoxSamples.Items.BeginUpdate;
 ComboBoxSamples.Items.Clear;
 FOR Counter:=0 TO 127 DO BEGIN
  S:=INTTOSTR(Counter);
  WHILE LENGTH(S)<3 DO S:='0'+S;
  ComboBoxSamples.Items.Add(S+'.');
 END;
 ComboBoxSamples.Items.EndUpdate;
 ComboBoxSamples.ItemIndex:=0;}

 for Counter:=0 to 127 do begin
  MenuItem:=TMenuItem.Create(PopupMenuInstruments);
  S:=INTTOSTR(Counter);
  while length(S)<3 do S:='0'+S;
  MenuItem.OnAdvancedDrawItem:=SGTK0Menu1.DrawItem;
  MenuItem.OnMeasureItem:=SGTK0Menu1.MeasureItem;
  MenuItem.Caption:=S;
  MenuItem.Tag:=Counter;
  MenuItem.OnClick:=SelectIns1Click;
  PopupMenuInstruments.Items.Add(MenuItem);
 end;

 DummyEnvelope.NodesCount:=0;
 DummyEnvelope.LoopStart:=-1;
 DummyEnvelope.LoopEnd:=-1;
 DummyEnvelope.SustainLoopStart:=-1;
 DummyEnvelope.SustainLoopEnd:=-1;

 EnvelopeForm:=TEnvelopeForm.Create(PanelFreedrawnEnvelopeEditor);
 EnvelopeForm.Form:=self;
 EnvelopeForm.Envelope:=@DummyEnvelope;
 EnvelopeForm.Parent:=PanelFreedrawnEnvelopeEditor;
 EnvelopeForm.BorderStyle:=bsNone;
 EnvelopeForm.Align:=alClient;
 EnvelopeForm.Visible:=true;

 ComboBoxInstrumentChannel.ItemIndex:=0;

 ScrollbarModulationMatrixItems.Kind:=sbVertical;

 for Counter:=0 to MaxVisibleModulationMatrixItems-1 do begin
  S:=INTTOSTR(Counter+1);
  while length(S)<3 do S:='0'+S;
  FormModulationMatrixItems[Counter]:=TFormModulationMatrixItem.Create(PanelModulationMatrixItems);
  FormModulationMatrixItems[Counter].Parent:=PanelModulationMatrixItems;
  FormModulationMatrixItems[Counter].Left:=5;
  FormModulationMatrixItems[Counter].Top:=5+((FormModulationMatrixItems[Counter].Height+5)*Counter);
  FormModulationMatrixItems[Counter].Visible:=false;
  FormModulationMatrixItems[Counter].PanelNr.Caption:=S;
  FormModulationMatrixItems[Counter].Nr:=Counter;
  FormModulationMatrixItems[Counter].HostEditorUpdate:=EditorUpdate;
  FormModulationMatrixItems[Counter].DeleteModulationMatrixItem:=DeleteModulationMatrixItem;
 end;
 MaxModulationMatrixItemsHeight:=5+((FormModulationMatrixItems[0].Height+5)*256);
 ScrollbarModulationMatrixItems.Max:=252; //MaxModulationMatrixItemsHeight;
{ScrollbarModulationMatrixItems.LargeChange:=FormModulationMatrixItems[0].Height+5;
 ScrollbarModulationMatrixItems.SmallChange:=FormModulationMatrixItems[0].Height+5;}

 TimerSize.Enabled:=false;

 WaveEditor:=TWaveEditor.Create(PanelOscSampleWaveEditor);
 WaveEditor.Form:=self;
 WaveEditor.ScrollBar:=ScrollBarSample;
 ScrollBarSample.OnScroll:=WaveEditor.ScrollUpdate;
 WaveEditor.Parent:=PanelOscSampleWaveEditor;
 WaveEditor.Align:=alClient;
 WaveEditor.Daten:=nil;
 WaveEditor.Init;

 WaveClipboardPointer:=nil;
 WaveClipboardBytes:=0;
 WaveClipboardRate:=0;
 WaveClipboardChannels:=0;
 CPEnvelopeOk:=false;

 ComboBoxSamplesNote.Items.BeginUpdate;
 ComboBoxSamplesNote.Items.Clear;
 for i:=0 to 127 do begin
  ComboBoxSamplesNote.Items.Add(Note3C(i));
 end;
 ComboBoxSamplesNote.Items.EndUpdate;

 UpdateColors;
 EditorUpdate;
end;

procedure TVSTiEditor.FormDestroy(Sender: TObject);
var Counter:integer;
begin
 if assigned(WaveClipboardPointer) then begin
  FREEMEM(WaveClipboardPointer);
  WaveClipboardPointer:=nil;
 end;
 WaveEditor.Destroy;
//UndoReplacePageControls(SELF);
 for Counter:=0 to $f do begin
  PanelChnNr[Counter].Free;
  PanelChnPrg[Counter].Free;
  PanelChnPoly[Counter].Free;
 end;
 VUOnBitmap.Free;
 VUOffBitmap.Free;
 VUBufferBitmap.Free;
 EnvelopeForm.Free;
 ADSRBitmap.Free;
 ImageTopViewGraphicsBuffer.Free;
 RefreshTimer.Interval:=250;
 RefreshTimer.Enabled:=false;
 FFT.Free;
 for Counter:=0 to MaxVisibleModulationMatrixItems-1 do begin
  FormModulationMatrixItems[Counter].Destroy;
 end;
 for Counter:=low(CheckBoxInstrumentControllerResolutionResolutionCheck) to high(CheckBoxInstrumentControllerResolutionResolutionCheck) do begin
  FreeAndNil(CheckBoxInstrumentControllerResolutionResolutionCheck[Counter]);
 end;
end;

const Sample8DivFaktor=1/(1 shl 7);
      Sample16DivFaktor=1/(1 shl 15);
      Sample24DivFaktor=1/(1 shl 23);
      Sample32DivFaktor=1/(1 shl 31);
      Sample24DivFaktorEx=1/(1 shl 31);

type TWaveFileHeader=packed record
      Signatur:array[1..4] of ansichar;
      Groesse:longword;
      WAVESignatur:array[1..4] of ansichar;
     end;

     TWaveFormatHeader=packed record
      FormatTag:word;
      Kaenale:word;
      SamplesProSekunde:longword;
      AvgBytesProSekunde:longword;
      SampleGroesse:word;
      BitsProSample:word;
     end;

     TWaveSampleHeader=packed record
      Manufacturer:longword;
      Produkt:longword;
      SamplePeriode:longword;
      BasisNote:longword;
      PitchFraction:longword;
      SMTPEFormat:longword;
      SMTPEOffset:longword;
      SampleLoops:longword;
      SamplerData:longword;
     end;

     TWaveSampleLoopHeader=packed record
      Identifier:longword;
      SchleifenTyp:longword;
      SchleifeStart:longword;
      SchleifeEnde:longword;
      Fraction:longword;
      AnzahlSpielen:longword;
     end;

     TWaveInfoHeader=array[1..4] of ansichar;

     TWaveXtraHeader=packed record
      Flags:longword;
      Pan:word;
      Lautstaerke:word;
      GlobalLautstaerke:word;
      Reserviert:word;
      VibType:byte;
      VibSweep:byte;
      VibDepth:byte;
      VibRate:byte;
     end;

     TWaveChunkHeader=packed record
      Signatur:array[1..4] of ansichar;
      Groesse:longword;
     end;

     PSample24Value=^TSample24Value;
     TSample24Value=packed record
      A,B,C:byte;
     end;

const IMAADPCMUnpackTable:array[0..88] of word=(
       7,         8,     9,    10,    11,    12,    13,    14,
       16,       17,    19,    21,    23,    25,    28,    31,
       34,       37,    41,    45,    50,    55,    60,    66,
       73,       80,    88,    97,   107,   118,   130,   143,
       157,     173,   190,   209,   230,   253,   279,   307,
       337,     371,   408,   449,   494,   544,   598,   658,
       724,     796,   876,   963,  1060,  1166,  1282,  1411,
       1552,   1707,  1878,  2066,  2272,  2499,  2749,  3024,
       3327,   3660,  4026,  4428,  4871,  5358,  5894,  6484,
       7132,   7845,  8630,  9493, 10442, 11487, 12635, 13899,
       15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794,
       32767);

       IMAADPCMIndexTable:array[0..7] of shortint=(-1,-1,-1,-1,2,4,6,8);

procedure TVSTiEditor.ClearSample(SampleSlot:integer);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if assigned(AudioCriticalSection) and not InChange then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   index:=SampleSlot;
   if (index>=0) and (index<MaxSamples) then begin
    fillchar(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header,sizeof(TSynthSampleHeader),#0);
    APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels:=1;
    APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate:=44100;
    APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note:=69;
    if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
     FREEMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data);
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data:=nil;
    end;
   end;
   SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
   CalculatePhaseSamples;
  finally
   AudioCriticalSection.Leave;
  end;
 end;
end;

{$WARNINGS OFF}
function TVSTiEditor.LoadWAVSample(Daten:TBeRoStream;SampleSlot:integer;WSMPOffset:plongword=nil):boolean;
var Header:TWaveFileHeader;
    WaveFormatHeader:TWaveFormatHeader;
    WaveFormatHeaderPCM:TWaveFormatHeader;
    WaveFormatHeaderTemp:TWaveFormatHeader;
    WaveSampleHeader:TWaveSampleHeader;
    WaveSampleLoopHeader:TWaveSampleLoopHeader;
    WaveInfoHeader:TWaveInfoHeader;
    WaveXtraHeader:TWaveXtraHeader;
    WaveChunkHeader:TWaveChunkHeader;
    WaveFormatHeaderDa:boolean;
    WaveFormatHeaderPCMDa:boolean;
    Fact:longword;
    Data:longword;
    Smpl:longword;
    Xtra:longword;
    List:longword;
    Next:integer;
    SampleGroesse:longword;
    PB:pbyte;
    PW:pword;
    PDW:plongword;
    I:integer;
    Groesse,ADPCMLength:integer;
    ADPCMPointer,ADPCMWorkPointer:pbyte;
    ADPCMCode,ADPCMDiff,ADPCMPredictor,ADPCMStepIndex:integer;
    ADPCMStep:longword;
    Bits,Kaenale:longword;
    FloatingPoint:boolean;
    Laenge,SampleRate:longword;
    Panning:boolean;
    DataPointer:pointer;
    RealSize:integer;
    SchleifeStart:longword;
    SchleifeEnde:longword;
    SustainSchleifeStart:longword;
    SustainSchleifeEnde:longword;
    Pan,Lautstaerke,GlobalLautstaerke:longword;
    Counter,EndValue:integer;
    LW32:longword;
    L32:longint absolute LW32;
    S8:pshortint;
    S16:psmallint;
    S24:PSample24Value;
    S32:plongint;
    S32F:psingle;
    S32Float:psingle;
    SampleData:pointer;
    SampleDataSize:longword;
    APlugin:TVSTiPlugin;
    index,Note:integer;
    FineTune:longword;
    LoopType:byte;
    SustainLoopType:byte;
begin
 ClearSample(SampleSlot);
 Daten.Seek(0);
 if Daten.read(Header,sizeof(TWaveFileHeader))<>sizeof(TWaveFileHeader) then begin
  result:=false;
  exit;
 end;
 if (Header.Signatur<>'RIFF') and (Header.Signatur<>'LIST') then begin
  result:=false;
  exit;
 end;
 if (Header.WAVESignatur<>'WAVE') and (Header.WAVESignatur<>'wave') then begin
  result:=false;
  exit;
 end;
 if assigned(WSMPOffset) then WSMPOffset^:=0;
 FILLCHAR(WaveFormatHeader,sizeof(TWaveFormatHeader),#0);
 FILLCHAR(WaveFormatHeaderPCM,sizeof(TWaveFormatHeader),#0);
 WaveFormatHeaderDa:=false;
 WaveFormatHeaderPCMDa:=false;
 Note:=69;
 Fact:=0;
 Data:=0;
 Smpl:=0;
 Xtra:=0;
 List:=0;
 LoopType:=slNONE;
 SustainLoopType:=slNONE;
 while (Daten.Position+8)<Daten.Size do begin
  if Daten.read(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
   result:=false;
   exit;
  end;
  Next:=Daten.Position+integer(WaveChunkHeader.Groesse);
  if (WaveChunkHeader.Signatur='fmt ') or (WaveChunkHeader.Signatur='fmt'#0) then begin
   if not WaveFormatHeaderDa then begin
    WaveFormatHeaderDa:=true;
    if Daten.read(WaveFormatHeader,sizeof(TWaveFormatHeader))<>sizeof(TWaveFormatHeader) then begin
     result:=false;
     exit;
    end;
   end;
  end else if (WaveChunkHeader.Signatur='pcm ') or (WaveChunkHeader.Signatur='pcm'#0) then begin
   if not WaveFormatHeaderPCMDa then begin
    WaveFormatHeaderPCMDa:=true;
    if Daten.read(WaveFormatHeaderPCM,sizeof(TWaveFormatHeader))<>sizeof(TWaveFormatHeader) then begin
     result:=false;
     exit;
    end;
   end;
  end else if WaveChunkHeader.Signatur='fact' then begin
   if Fact=0 then begin
    if Daten.read(Fact,4)<>4 then begin
     result:=false;
     exit;
    end;
   end;
  end else if WaveChunkHeader.Signatur='data' then begin
   if Data=0 then begin
    Data:=Daten.Position-sizeof(TWaveChunkHeader);
   end;
  end else if WaveChunkHeader.Signatur='smpl' then begin
   if Smpl=0 then begin
    Smpl:=Daten.Position-sizeof(TWaveChunkHeader);
   end;
  end else if WaveChunkHeader.Signatur='xtra' then begin
   if Xtra=0 then begin
    Xtra:=Daten.Position-sizeof(TWaveChunkHeader);
   end;
  end else if WaveChunkHeader.Signatur='list' then begin
   if List=0 then begin
    List:=Daten.Position-sizeof(TWaveChunkHeader);
   end;
  end else if WaveChunkHeader.Signatur='wsmp' then begin
   if assigned(WSMPOffset) then begin
    WSMPOffset^:=Daten.Position;
   end;
  end;
  Daten.Seek(Next);
 end;
 if WaveFormatHeaderDa and WaveFormatHeaderPCMDa then begin
  if (SwapWordLittleEndian(WaveFormatHeader.FormatTag)<>1) and (SwapWordLittleEndian(WaveFormatHeader.FormatTag)<>3) then begin
   WaveFormatHeaderTemp:=WaveFormatHeader;
   WaveFormatHeader:=WaveFormatHeaderPCM;
   WaveFormatHeaderPCM:=WaveFormatHeaderTemp;
  end else begin
// WaveFormatHeaderPCMDa:=FALSE;
  end;
 end;
 if (SwapWordLittleEndian(WaveFormatHeader.FormatTag)=1) or (SwapWordLittleEndian(WaveFormatHeader.FormatTag)=3) or (SwapWordLittleEndian(WaveFormatHeader.FormatTag)=$fffe) then begin
  if (SwapWordLittleEndian(WaveFormatHeader.Kaenale)<>1) and (SwapWordLittleEndian(WaveFormatHeader.Kaenale)<>2) then begin
   result:=false;
   exit;
  end;
  if (SwapWordLittleEndian(WaveFormatHeader.BitsProSample)<>8) and (SwapWordLittleEndian(WaveFormatHeader.BitsProSample)<>16) and (SwapWordLittleEndian(WaveFormatHeader.BitsProSample)<>24) and (SwapWordLittleEndian(WaveFormatHeader.BitsProSample)<>32) then begin
   result:=false;
   exit;
  end;
 end else if SwapWordLittleEndian(WaveFormatHeader.FormatTag)=17 then begin
  if SwapWordLittleEndian(WaveFormatHeader.Kaenale)<>1 then begin
   result:=false;
   exit;
  end;
  if SwapWordLittleEndian(WaveFormatHeader.BitsProSample)<>4 then begin
   result:=false;
   exit;
  end;
 end else begin
  result:=false;
  exit;
 end;
 if Data=0 then begin
  result:=false;
  exit;
 end;
 Daten.Seek(Data);
 if Daten.read(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
  result:=false;
  exit;
 end;
 Bits:=SwapWordLittleEndian(WaveFormatHeader.BitsProSample);
 Kaenale:=SwapWordLittleEndian(WaveFormatHeader.Kaenale);
 FloatingPoint:=WaveFormatHeader.FormatTag=3;
 if SwapWordLittleEndian(WaveFormatHeader.FormatTag)=17 then begin
  SampleGroesse:=1;
  Laenge:=((SwapDWordLittleEndian(WaveChunkHeader.Groesse)-4)*2)+1;
  FloatingPoint:=false;
 end else begin
  SampleGroesse:=(Kaenale*(Bits shr 3));
  Laenge:=SwapDWordLittleEndian(WaveChunkHeader.Groesse) div SampleGroesse;
 end;
 SampleRate:=SwapDWordLittleEndian(WaveFormatHeader.SamplesProSekunde);
 Panning:=false;
 case SwapWordLittleEndian(WaveFormatHeader.FormatTag) of
  1,3,$fffe:begin
   GETMEM(DataPointer,SwapDWordLittleEndian(WaveChunkHeader.Groesse));
   if Daten.read(DataPointer^,SwapDWordLittleEndian(WaveChunkHeader.Groesse))<>SwapDWordLittleEndian(WaveChunkHeader.Groesse) then begin
    result:=false;
    exit;
   end;
   RealSize:=WaveChunkHeader.Groesse;
   if (Bits=8) and (RealSize>0) then begin
    PB:=DataPointer;
    for I:=1 to RealSize do begin
     PB^:=PB^ xor $80;
     inc(PB);
    end;
   end;
   if (Bits=16) and (RealSize>0) then begin
    PW:=DataPointer;
    for I:=1 to RealSize do begin
     SwapLittleEndianData16(PW^);
     inc(PW);
    end;
   end;
   if (Bits=32) and (RealSize>0) then begin
    PDW:=DataPointer;
    for I:=1 to RealSize do begin
     SwapLittleEndianData32(PDW^);
     inc(PDW);
    end;
   end;
  end;
  17:begin
   Bits:=16;
   ADPCMLength:=SwapDWordLittleEndian(WaveChunkHeader.Groesse);
   RealSize:=((ADPCMLength-4)*4)+1;
   GETMEM(DataPointer,RealSize);
   GETMEM(ADPCMPointer,ADPCMLength);
   if Daten.read(ADPCMPointer^,ADPCMLength)<>ADPCMLength then begin
    result:=false;
    exit;
   end;
   ADPCMWorkPointer:=ADPCMPointer;
   ADPCMPredictor:=psmallint(ADPCMWorkPointer)^;
   psmallint(DataPointer)^:=ADPCMPredictor;
   ADPCMStepIndex:=pbyte(longword(longword(ADPCMWorkPointer)+2))^;
   inc(ADPCMWorkPointer,4);
   ADPCMLength:=(ADPCMLength-4) shl 1;
   for I:=0 to ADPCMLength-1 do begin
    ADPCMCode:=pbyte(longword(longword(ADPCMWorkPointer)+longword(I shr 1)))^;
    ADPCMCode:=(ADPCMCode shr ((I and 1) shl 2)) and $f;
    ADPCMStep:=IMAADPCMUnpackTable[ADPCMStepIndex];
    ADPCMDiff:=ADPCMStep shr 3;
    if (ADPCMCode and 1)<>0 then inc(ADPCMDiff,ADPCMStep shr 2);
    if (ADPCMCode and 2)<>0 then inc(ADPCMDiff,ADPCMStep shr 1);
    if (ADPCMCode and 4)<>0 then inc(ADPCMDiff,ADPCMStep);
    if (ADPCMCode and 8)<>0 then ADPCMDiff:=-ADPCMDiff;
    inc(ADPCMPredictor,ADPCMDiff);
    if ADPCMPredictor<-$8000 then begin
     ADPCMPredictor:=-$8000;
    end else if ADPCMPredictor>$7fff then begin
     ADPCMPredictor:=$7fff;
    end;
    psmallint(longword(longword(DataPointer)+longword((I+1)*sizeof(smallint))))^:=ADPCMPredictor;
    inc(ADPCMStepIndex,IMAADPCMIndexTable[ADPCMCode and 7]);
    if ADPCMStepIndex<0 then begin
     ADPCMStepIndex:=0;
    end else if ADPCMStepIndex>88 then begin
     ADPCMStepIndex:=88;
    end;
   end;
   FREEMEM(ADPCMPointer);
  end;
  else begin
// DataPointer:=NIL;
   result:=false;
   exit;
  end;
 end;
 if Smpl<>0 then begin
  Daten.Seek(Smpl);
  if Daten.read(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
   result:=false;
   exit;
  end;
  if Daten.read(WaveSampleHeader,sizeof(TWaveSampleHeader))<>sizeof(TWaveSampleHeader) then begin
   result:=false;
   exit;
  end;
  Note:=SwapDWordLittleEndian(WaveSampleHeader.BasisNote);
  FineTune:=SwapDWordLittleEndian(WaveSampleHeader.PitchFraction);
  if SwapDWordLittleEndian(WaveSampleHeader.SampleLoops)>1 then begin
   if Daten.read(WaveSampleLoopHeader,sizeof(TWaveSampleLoopHeader))<>sizeof(TWaveSampleLoopHeader) then begin
    result:=false;
    exit;
   end;
   case WaveSampleLoopHeader.SchleifenTyp of
    1:SustainLoopType:=slPINGPONG;
    2:SustainLoopType:=slBACKWARD;
    else SustainLoopType:=slFORWARD;
   end;
   SustainSchleifeStart:=SwapDWordLittleEndian(WaveSampleLoopHeader.SchleifeStart);
   SustainSchleifeEnde:=SwapDWordLittleEndian(WaveSampleLoopHeader.SchleifeEnde);
   if SustainSchleifeStart>=SustainSchleifeEnde then begin
    SustainLoopType:=slNONE;
   end;
  end;
  if SwapDWordLittleEndian(WaveSampleHeader.SampleLoops)>0 then begin
   if Daten.read(WaveSampleLoopHeader,sizeof(TWaveSampleLoopHeader))<>sizeof(TWaveSampleLoopHeader) then begin
    result:=false;
    exit;
   end;
   case WaveSampleLoopHeader.SchleifenTyp of
    1:LoopType:=slPINGPONG;
    2:LoopType:=slBACKWARD;
    else LoopType:=slFORWARD;
   end;
   SchleifeStart:=SwapDWordLittleEndian(WaveSampleLoopHeader.SchleifeStart);
   SchleifeEnde:=SwapDWordLittleEndian(WaveSampleLoopHeader.SchleifeEnde);
   if SchleifeStart>=SchleifeEnde then begin
    LoopType:=slNONE;
   end;
  end;
 end;
 if List<>0 then begin
  Daten.Seek(List);
  if Daten.read(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
   result:=false;
   exit;
  end;
  if Daten.read(WaveInfoHeader,sizeof(TWaveInfoHeader))<>sizeof(TWaveInfoHeader) then begin
   result:=false;
   exit;
  end;
  if WaveInfoHeader='INFO' then begin
   Groesse:=Daten.Position+integer(SwapDWordLittleEndian(WaveChunkHeader.Groesse));
   while (Daten.Position+8)<Groesse do begin
    if Daten.read(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
     result:=false;
     exit;
    end;
    Next:=Daten.Position+integer(SwapDWordLittleEndian(WaveChunkHeader.Groesse));
{   IF WaveChunkHeader.Signatur='INAM' THEN BEGIN
     IF (SwapDWordLittleEndian(WaveChunkHeader.Groesse)>0) AND (SwapDWordLittleEndian(WaveChunkHeader.Groesse)<$100) THEN BEGIN
      SETLENGTH(Name,SwapDWordLittleEndian(WaveChunkHeader.Groesse));
      IF Daten.Read(Name[1],SwapDWordLittleEndian(WaveChunkHeader.Groesse))<>SwapDWordLittleEndian(WaveChunkHeader.Groesse) THEN BEGIN
       RESULT:=FALSE;
       EXIT;
      END;
      Name:=TRIMRIGHT(Name);
     END;
     BREAK;
    END;{}
    Daten.Seek(Next);
   end;
  end;
 end;
 if Xtra<>0 then begin
  Daten.Seek(Xtra);
  if Daten.read(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
   result:=false;
   exit;
  end;
  if Daten.read(WaveXtraHeader,sizeof(TWaveXtraHeader))<>sizeof(TWaveXtraHeader) then begin
   result:=false;
   exit;
  end;
  SwapLittleEndianData32(WaveXtraHeader.Flags);
  SwapLittleEndianData16(WaveXtraHeader.Pan);
  SwapLittleEndianData16(WaveXtraHeader.Lautstaerke);
  SwapLittleEndianData16(WaveXtraHeader.GlobalLautstaerke);
  SwapLittleEndianData16(WaveXtraHeader.Reserviert);
  Pan:=WaveXtraHeader.Pan;
  Lautstaerke:=WaveXtraHeader.Lautstaerke;
  GlobalLautstaerke:=WaveXtraHeader.GlobalLautstaerke;
{ IF WaveChunkHeader.Groesse>SIZEOF(TWaveXtraHeader) THEN BEGIN
   IF (WaveChunkHeader.Groesse-SIZEOF(TWaveXtraHeader))>=32 THEN BEGIN
    SETLENGTH(Name,32);
    IF Daten.Read(Name[1],32)<>32 THEN BEGIN
     RESULT:=FALSE;
     EXIT;
    END;
    Name:=TRIMRIGHT(Name);
   END;
  END;{}
 end;
 if assigned(DataPointer) then begin
  SampleDataSize:=Laenge*Kaenale*sizeof(single);
  GETMEM(SampleData,SampleDataSize);
  S32Float:=SampleData;
  EndValue:=Laenge*Kaenale;
  case Bits of
   8:begin
    S8:=DataPointer;
    for Counter:=1 to EndValue do begin
     S32Float^:=S8^*Sample8DivFaktor;
     inc(S8);
     inc(S32Float);
    end;
   end;
   16:begin
    S16:=DataPointer;
    for Counter:=1 to EndValue do begin
     S32Float^:=S16^*Sample16DivFaktor;
     inc(S16);
     inc(S32Float);
    end;
   end;
   24:begin
    S24:=DataPointer;
    for Counter:=1 to EndValue do begin
     LW32:=(S24^.A shl 8) or (S24^.B shl 16) or (S24^.C shl 24);
     S32Float^:=L32*Sample24DivFaktorEx;
     inc(S24);
     inc(S32Float);
    end;
   end;
   32:begin
    if FloatingPoint then begin
     S32F:=DataPointer;
     for Counter:=1 to EndValue do begin
      S32Float^:=S32F^;
      inc(S32F);
      inc(S32Float);
     end;
    end else begin
     S32:=DataPointer;
     for Counter:=1 to EndValue do begin
      S32Float^:=S32^*Sample32DivFaktor;
      inc(S32);
      inc(S32Float);
     end;
    end;
   end;
  end;
  if assigned(AudioCriticalSection) and not InChange then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=SampleSlot;
    if (index>=0) and (index<MaxSamples) then begin
     fillchar(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header,sizeof(TSynthSampleHeader),#0);
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples:=Laenge;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels:=Kaenale;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate:=SampleRate;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note:=Note;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.FineTune:=FineTune;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode:=LoopType;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample:=SchleifeStart;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample:=SchleifeEnde;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode:=SustainLoopType;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample:=SustainSchleifeStart;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample:=SustainSchleifeEnde;
     GETMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data,Laenge*Kaenale*sizeof(single));
     MOVE(SampleData^,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data^,Laenge*Kaenale*sizeof(single));
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
     CalculatePhaseSamples;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  FREEMEM(SampleData);
  FREEMEM(DataPointer);
 end;
 result:=true;
end;

function TVSTiEditor.SaveWAVSample(Daten:TBeRoStream):boolean;
var Header:TWaveFileHeader;
    WaveFormatHeader:TWaveFormatHeader;
    WaveSampleHeader:TWaveSampleHeader;
    WaveSampleLoopHeader:TWaveSampleLoopHeader;
    WaveInfoHeader:TWaveInfoHeader;
    WaveXtraHeader:TWaveXtraHeader;
    WaveChunkHeader:TWaveChunkHeader;
    APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     Daten.Clear;
     Daten.Seek(0);
     Header.Signatur:='RIFF';
     Header.WAVESignatur:='WAVE';
     Header.Groesse:=SwapDWordLittleEndian(0);
     if Daten.write(Header,sizeof(TWaveFileHeader))<>sizeof(TWaveFileHeader) then begin
      result:=false;
     end;

     WaveChunkHeader.Signatur:='fmt ';
     WaveChunkHeader.Groesse:=SwapDWordLittleEndian(sizeof(TWaveFormatHeader));
     if Daten.write(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
      result:=false;
     end;

     FILLCHAR(WaveFormatHeader,sizeof(TWaveFormatHeader),#0);
     WaveFormatHeader.FormatTag:=SwapWordLittleEndian(3);
     WaveFormatHeader.Kaenale:=SwapWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels);
     WaveFormatHeader.BitsProSample:=SwapWordLittleEndian(32);
     WaveFormatHeader.SamplesProSekunde:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate);
     WaveFormatHeader.SampleGroesse:=SwapWordLittleEndian(WaveFormatHeader.Kaenale*(WaveFormatHeader.BitsProSample shr 3));
     WaveFormatHeader.AvgBytesProSekunde:=SwapDWordLittleEndian(WaveFormatHeader.SampleGroesse*APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate);
     if Daten.write(WaveFormatHeader,sizeof(TWaveFormatHeader))<>sizeof(TWaveFormatHeader) then begin
      result:=false;
     end;

     WaveChunkHeader.Signatur:='data';
     WaveChunkHeader.Groesse:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels*sizeof(single));
     if Daten.write(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
      result:=false;
     end;
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      if Daten.write(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data^,WaveChunkHeader.Groesse)<>WaveChunkHeader.Groesse then begin
       result:=false;
      end;
     end;

     WaveSampleHeader.SampleLoops:=0;
     WaveChunkHeader.Signatur:='smpl';
     WaveChunkHeader.Groesse:=SwapDWordLittleEndian(sizeof(TWaveSampleHeader));
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE then begin
      WaveChunkHeader.Groesse:=SwapDWordLittleEndian(SwapDWordLittleEndian(WaveChunkHeader.Groesse)+sizeof(TWaveSampleLoopHeader));
      inc(WaveSampleHeader.SampleLoops);
     end;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE then begin
      WaveChunkHeader.Groesse:=SwapDWordLittleEndian(SwapDWordLittleEndian(WaveChunkHeader.Groesse)+sizeof(TWaveSampleLoopHeader));
      inc(WaveSampleHeader.SampleLoops);
     end;
     if Daten.write(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
      result:=false;
     end;

     WaveSampleHeader.Manufacturer:=SwapDWordLittleEndian(0);
     WaveSampleHeader.Produkt:=SwapDWordLittleEndian(0);
     WaveSampleHeader.SamplePeriode:=SwapDWordLittleEndian(22675);
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate>256 then begin
      WaveSampleHeader.SamplePeriode:=SwapDWordLittleEndian(1000000000 div APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate);
     end;
     WaveSampleHeader.BasisNote:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note);
     WaveSampleHeader.PitchFraction:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.FineTune);
     WaveSampleHeader.SMTPEFormat:=SwapDWordLittleEndian(0);
     WaveSampleHeader.SMTPEOffset:=SwapDWordLittleEndian(0);
     WaveSampleHeader.SamplerData:=SwapDWordLittleEndian(0);
     if Daten.write(WaveSampleHeader,sizeof(TWaveSampleHeader))<>sizeof(TWaveSampleHeader) then begin
      result:=false;
     end;
     if WaveSampleHeader.SampleLoops>1 then begin
      WaveSampleLoopHeader.Identifier:=SwapDWordLittleEndian(0);
      case APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode of
       slBACKWARD:WaveSampleLoopHeader.SchleifenTyp:=SwapDWordLittleEndian(2);
       slPINGPONG:WaveSampleLoopHeader.SchleifenTyp:=SwapDWordLittleEndian(1);
       else WaveSampleLoopHeader.SchleifenTyp:=SwapDWordLittleEndian(0);
      end;
      WaveSampleLoopHeader.SchleifeStart:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample);
      WaveSampleLoopHeader.SchleifeEnde:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample);
      WaveSampleLoopHeader.Fraction:=SwapDWordLittleEndian(0);
      WaveSampleLoopHeader.AnzahlSpielen:=SwapDWordLittleEndian(0);
      if Daten.write(WaveSampleLoopHeader,sizeof(TWaveSampleLoopHeader))<>sizeof(TWaveSampleLoopHeader) then begin
       result:=false;
      end;
     end;
      if WaveSampleHeader.SampleLoops>0 then begin
      WaveSampleLoopHeader.Identifier:=SwapDWordLittleEndian(0);
      case APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode of
       slBACKWARD:WaveSampleLoopHeader.SchleifenTyp:=SwapDWordLittleEndian(2);
       slPINGPONG:WaveSampleLoopHeader.SchleifenTyp:=SwapDWordLittleEndian(1);
       else WaveSampleLoopHeader.SchleifenTyp:=SwapDWordLittleEndian(0);
      end;
      WaveSampleLoopHeader.SchleifeStart:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample);
      WaveSampleLoopHeader.SchleifeEnde:=SwapDWordLittleEndian(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample);
      WaveSampleLoopHeader.Fraction:=SwapDWordLittleEndian(0);
      WaveSampleLoopHeader.AnzahlSpielen:=SwapDWordLittleEndian(0);
      if Daten.write(WaveSampleLoopHeader,sizeof(TWaveSampleLoopHeader))<>sizeof(TWaveSampleLoopHeader) then begin
       result:=false;
      end;
     end;

     WaveChunkHeader.Signatur:='list';
     WaveChunkHeader.Groesse:=SwapDWordLittleEndian(sizeof(TWaveInfoHeader)+(sizeof(TWaveChunkHeader)*1){+LENGTH(Name)}+length(Software));
     if Daten.write(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
      result:=false;
      exit;
     end;
     WaveInfoHeader:='INFO';
     if Daten.write(WaveInfoHeader,sizeof(TWaveInfoHeader))<>sizeof(TWaveInfoHeader) then begin
      result:=false;
     end;
 {   IF LENGTH(Name)>0 THEN BEGIN
      WaveChunkHeader.Signatur:='INAM';
      WaveChunkHeader.Groesse:=SwapDWordLittleEndian(LENGTH(Name));
      IF Daten.Write(WaveChunkHeader,SIZEOF(TWaveChunkHeader))<>SIZEOF(TWaveChunkHeader) THEN BEGIN
       RESULT:=FALSE;
      END;
      IF Daten.Write(Name[1],LENGTH(Name))<>LENGTH(Name) THEN BEGIN
       RESULT:=FALSE;
      END;
     END;{}
     if length(Software)>0 then begin
      WaveChunkHeader.Signatur:='ISFT';
      WaveChunkHeader.Groesse:=SwapDWordLittleEndian(length(Software));
      if Daten.write(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
       result:=false;
      end;
      if Daten.write(Software[1],length(Software))<>length(Software) then begin
       result:=false;
       exit;
      end;
     end;

     WaveChunkHeader.Signatur:='xtra';
     WaveChunkHeader.Groesse:=SwapDWordLittleEndian(sizeof(TWaveXtraHeader));
     if Daten.write(WaveChunkHeader,sizeof(TWaveChunkHeader))<>sizeof(TWaveChunkHeader) then begin
      result:=false;
      exit;
     end;
     WaveXtraHeader.Flags:=0;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE then WaveXtraHeader.Flags:=WaveXtraHeader.Flags or $02;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode=slPINGPONG then WaveXtraHeader.Flags:=WaveXtraHeader.Flags or $04;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>SLNONE then WaveXtraHeader.Flags:=WaveXtraHeader.Flags or $08;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode=sLPINGPONG then WaveXtraHeader.Flags:=WaveXtraHeader.Flags or $10;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode=slBACKWARD then WaveXtraHeader.Flags:=WaveXtraHeader.Flags or $80;
     if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode=sLBACKWARD then WaveXtraHeader.Flags:=WaveXtraHeader.Flags or $100;
     //IF TRUE THEN WaveXtraHeader.Flags:=WaveXtraHeader.Flags OR $20;
     //IF Kaenale=2 THEN WaveXtraHeader.Flags:=WaveXtraHeader.Flags OR $40;
     SwapLittleEndianData32(WaveXtraHeader.Flags);
     WaveXtraHeader.Pan:=128;
     WaveXtraHeader.Lautstaerke:=255;
     WaveXtraHeader.GlobalLautstaerke:=255;
     WaveXtraHeader.VibType:=0;
     WaveXtraHeader.VibSweep:=0;
     WaveXtraHeader.VibDepth:=0;
     WaveXtraHeader.VibRate:=0;
     if Daten.write(WaveXtraHeader,sizeof(TWaveXtraHeader))<>sizeof(TWaveXtraHeader) then begin
      result:=false;
      exit;
     end;

     Daten.Seek(0);
     Header.Signatur:='RIFF';
     Header.WAVESignatur:='WAVE';
     Header.Groesse:=SwapDWordLittleEndian(Daten.Size-sizeof(TWaveFileHeader)+4);
     if Daten.write(Header,sizeof(TWaveFileHeader))<>sizeof(TWaveFileHeader) then begin
      result:=false;
      exit;
     end;
     Daten.Seek(Daten.Size);
     result:=true;
    end else begin
     result:=false;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;
{$WARNINGS ON}

procedure TVSTiEditor.CalculatePhaseSamples;
var APlugin:TVSTiPlugin;
    index:integer;
    Frequency:single;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  APlugin:=TVSTiPlugin(Plugin);
  index:=ComboBoxSamples.ItemIndex;
  if (index>=0) and (index<MaxSamples) then begin
   Frequency:=440*POW(2,((APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note-69)-(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.FineTune/$100000000))/12);
   if abs(Frequency)>=1e-12 then begin
    APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.PhaseSamples:=SoftTRUNC((APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate/Frequency)+0.5);
    EditSamplesPhaseSamples.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.PhaseSamples);
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSpeechTextInputChange(Sender: TObject);
var American:boolean;
begin
 American:=ComboBoxSpeechConvertLanguage.ItemIndex=1;
 case ComboBoxConverterSource.ItemIndex of
  0:EditSpeechPhonemOutput.Text:=SpeechConvertTextToPhonems(EditSpeechTextInput.Text);
  1:EditSpeechPhonemOutput.Text:=EditSpeechTextInput.Text;
  2:EditSpeechPhonemOutput.Text:=SpeechConvertARPABETToAlvey(EditSpeechTextInput.Text,American);
  3:EditSpeechPhonemOutput.Text:=SpeechConvertDECTALKToAlvey(EditSpeechTextInput.Text,American);
  4:EditSpeechPhonemOutput.Text:=SpeechConvertEdinToAlvey(EditSpeechTextInput.Text,American);
  5:EditSpeechPhonemOutput.Text:=SpeechConvertMACTALKToAlvey(EditSpeechTextInput.Text,American);
  6:EditSpeechPhonemOutput.Text:=SpeechConvertMRPAToAlvey(EditSpeechTextInput.Text,American);
  7:EditSpeechPhonemOutput.Text:=SpeechConvertSAMPAToAlvey(EditSpeechTextInput.Text,American);
  8:EditSpeechPhonemOutput.Text:=SpeechConvertViruzIIToAlvey(EditSpeechTextInput.Text,American);
  else EditSpeechPhonemOutput.Text:='';
 end;
end;

procedure TVSTiEditor.ComboBoxConverterSourceChange(Sender: TObject);
begin
 EditSpeechTextInputChange(Sender);
end;

procedure TVSTiEditor.FormShow(Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.AudioStatusTimerTimer(Sender: TObject);
const Div1000=1/1000;
      TimeFactor=25;
var VSTiPlugin:TVSTiPlugin;
//    FPSFactor:SINGLE;
    ARect:TRect;
    Poly,Counter,SubCounter,Count,NewInstanceMode:integer;
    S:string;
begin
 begin
  try
   if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
   end;
   try
    if assigned(InstanceInfo) then begin
     Count:=InstanceInfo^.NumberOfVSTiPluginInstances;
     if Count>1 then begin
      if TVSTiPlugin(Plugin).ExportMIDIDoRecord then begin
       s:='Stop';
      end else begin
       s:='Record';
      end;
      if APluginExportMIDIDoRecord<>TVSTiPlugin(Plugin).ExportMIDIDoRecord then begin
       APluginExportMIDIDoRecord:=TVSTiPlugin(Plugin).ExportMIDIDoRecord;
       ButtonExportMIDIRecordStop.Caption:=s;
      end;
     end;
    end else begin
     Count:=1;
    end;
    if OldInstanceCount<>Count then begin
     OldInstanceCount:=Count;
     if Count=1 then begin
      SGTK0PanelInstanceCount.Caption:='1 instance';
     end else begin
      SGTK0PanelInstanceCount.Caption:=inttostr(Count)+' instances';
     end;
    end;
    if assigned(InstanceInfo) then begin
     if OldInstanceCount=1 then begin
      NewInstanceMode:=0;
     end else begin
      if TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0])=Plugin then begin
       NewInstanceMode:=1;
      end else begin
       NewInstanceMode:=2;
      end;
     end;
    end else begin
     NewInstanceMode:=0;
    end;
    if InstanceMode<>NewInstanceMode then begin
     InstanceMode:=NewInstanceMode;
     case InstanceMode of
      1:begin
       SGTK0PanelMasterSlave.Caption:='Master';
      end;
      2:begin
       SGTK0PanelMasterSlave.Caption:='Slave';
      end;
      else begin
       SGTK0PanelMasterSlave.Caption:='Single';
      end;
     end;
    end;
   finally
   end;
   if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
    InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
   end;
   CurrentTick:=timeGetTime;
//   FPSFactor:=(ABS(OldTick-CurrentTick)*Div1000)*TimeFactor;
   OldTick:=CurrentTick;
//   IF FPSFactor>1 THEN FPSFactor:=1;
   VSTiPlugin:=TVSTiPlugin(Plugin);
   str(VSTiPlugin.CPUTime:1:1,s);
   SGTK0PanelCPUTime.Caption:=s+'%';
   Peaks[0]:=((20*log10(fastsqrt(VSTiPlugin.Peaks[0])))+60)/60;
   Peaks[1]:=((20*log10(fastsqrt(VSTiPlugin.Peaks[1])))+60)/60;
   if Peaks[0]<0 then begin
    Peaks[0]:=0;
   end else if Peaks[0]>1 then begin
    Peaks[0]:=1;
   end;
   if Peaks[1]<0 then begin
    Peaks[1]:=0;
   end else if Peaks[1]>1 then begin
    Peaks[1]:=1;
   end;

   VUBufferBitmap.Canvas.CopyRect(VUBufferBitmap.Canvas.ClipRect,VUOffBitmap.Canvas,VUOffBitmap.Canvas.ClipRect);
   ARect:=VUOffBitmap.Canvas.ClipRect;
   ARect:=RECT(ARect.Left,ARect.Bottom-SoftTRUNC(Peaks[0]*VUOnBitmap.Height),ARect.Right,ARect.Bottom);
   VUBufferBitmap.Canvas.CopyRect(ARect,VUOnBitmap.Canvas,ARect);
   ARect:=VUBufferBitmap.Canvas.ClipRect;
   Frame3D(VUBufferBitmap.Canvas,ARect,TVSTiPlugin(Plugin).ColorBorderCache,TVSTiPlugin(Plugin).ColorBorderCache,1);
// Frame3D(VUBufferBitmap.Canvas,ARect,clBtnShadow,clBtnHighlight,2);
   PaintBoxPeakLeft.Canvas.CopyRect(VUBufferBitmap.Canvas.ClipRect,VUBufferBitmap.Canvas,VUBufferBitmap.Canvas.ClipRect);

   VUBufferBitmap.Canvas.CopyRect(VUBufferBitmap.Canvas.ClipRect,VUOffBitmap.Canvas,VUOffBitmap.Canvas.ClipRect);
   ARect:=VUOffBitmap.Canvas.ClipRect;
   ARect:=RECT(ARect.Left,ARect.Bottom-SoftTRUNC(Peaks[1]*VUOnBitmap.Height),ARect.Right,ARect.Bottom);
   VUBufferBitmap.Canvas.CopyRect(ARect,VUOnBitmap.Canvas,ARect);
   ARect:=VUBufferBitmap.Canvas.ClipRect;
   Frame3D(VUBufferBitmap.Canvas,ARect,TVSTiPlugin(Plugin).ColorBorderCache,TVSTiPlugin(Plugin).ColorBorderCache,1);
// Frame3D(VUBufferBitmap.Canvas,ARect,clBtnShadow,clBtnHighlight,2);
   PaintBoxPeakRight.Canvas.CopyRect(VUBufferBitmap.Canvas.ClipRect,VUBufferBitmap.Canvas,VUBufferBitmap.Canvas.ClipRect);

   for Counter:=0 to NumberOfChannels-1 do begin
    Poly:=0;
    for SubCounter:=0 to NumberOfVoices-1 do begin
     if (VSTiPlugin.Track.Voices[SubCounter].Active) and
        (VSTiPlugin.Track.Voices[SubCounter].Channel=@VSTiPlugin.Track.Channels[Counter]) then begin
      inc(Poly);
     end;
    end;
    S:=INTTOSTR(Poly);
    if length(S)<2 then begin
     S:='0'+S;
    end;
    if PanelChnPoly[Counter].Caption<>S then begin
     PanelChnPoly[Counter].Caption:=S;
    end;
    S:=INTTOSTR(VSTiPlugin.Track.Channels[Counter].Patch);
    while length(S)<3 do begin
     S:='0'+S;
    end;
    if PanelChnPrg[Counter].Caption<>S then begin
     PanelChnPrg[Counter].Caption:=S;
    end;
   end;

   Poly:=0;
   for Counter:=0 to NumberOfVoices-1 do begin
    if VSTiPlugin.Track.Voices[Counter].Active then begin
     inc(Poly);
    end;
   end;
   S:=INTTOSTR(Poly);
   if length(S)<2 then begin
    S:='0'+S;
   end;
   if PanelGlobalPoly.Caption<>S then begin
    PanelGlobalPoly.Caption:=S;
   end;

   if WaveEditor.Focused<>WaveEditor.OldFocused then begin
    WaveEditor.Invalidate;
   end;

  finally
  end;
  if (ActiveControl<>EnvelopeForm) and (PageControlGlobal.ActivePage=TabSheetInstruments) and (PageControlInstrument.ActivePage=TabSheetInstrumentVoice) and (PageControlInstrumentVoice.ActivePage=TabSheetInstrumentVoiceEnvelopes) then begin
   EnvelopeForm.DrawView;
  end;
  if PanelTopViewGraphics.Visible then begin
   ImageTopViewGraphicsPaint(nil);
  end;
  ExportMIDIUpdate;
 end;
 try
  if DoSynMemoInstrumentSampleScriptCodeSelLength then begin
   DoSynMemoInstrumentSampleScriptCodeSelLength:=false;
   //SynMemoInstrumentSampleScriptCode.SelLength:=0;
  end;
 finally
 end;
end;

procedure TVSTiEditor.PanelTitleDblClick(Sender: TObject);
begin
 PanelCopyright.Visible:=not PanelCopyright.Visible;
end;

procedure TVSTiEditor.PanelCopyrightDblClick(Sender: TObject);
begin
 PanelCopyright.Visible:=not PanelCopyright.Visible;
end;

procedure TVSTiEditor.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
 if ActiveControl=EnvelopeForm then begin
 end;
end;

procedure TVSTiEditor.FormKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
 if ActiveControl=EnvelopeForm then begin
 end;
end;

procedure TVSTiEditor.ApplicationEvents1Idle(Sender: TObject;
  var Done: boolean);
begin
 Done:=true;
end;

procedure TVSTiEditor.RefreshTimerTimer(Sender: TObject);
begin
 RefreshTimer.Enabled:=false;
 DrawADSR;
 Invalidate;
 Update;
end;

procedure TVSTiEditor.ButtonSetToChannelClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(AudioCriticalSection) and not InChange then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   SynthProgramChange(@APlugin.Track,@APlugin.Track.Channels[ComboBoxInstrumentChannel.ItemIndex and $f],APlugin.CurrentProgram and $7f);
   SynthCheckDelayBuffers(@APlugin.Track);
  finally
   AudioCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.PanelInstrumentNrClick(Sender: TObject);
begin
 PopupMenuInstruments.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TVSTiEditor.SelectIns1Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if (Sender is TMenuItem) and not InChange then begin
  APlugin:=TVSTiPlugin(Plugin);
  InterlockedExchange(APlugin.CurrentProgram,TMenuItem(Sender).Tag);
  APlugin.UpdateDisplay;
  OldPatchNr:=-1;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.PopupMenuInstrumentsPopup(Sender: TObject);
var Counter:integer;
    APlugin:TVSTiPlugin;
    S:string;
    MenuItem:TMenuItem;
begin
 APlugin:=TVSTiPlugin(Plugin);
 for Counter:=0 to 127 do begin
  MenuItem:=PopupMenuInstruments.Items[Counter];
  S:=INTTOSTR(Counter);
  while length(S)<3 do S:='0'+S;
  MenuItem.Caption:=S+'. '+APlugin.ProgramNames[Counter];
 end;
end;

const cw:word=$133f;
      bw:word=0;

function F_POWER(Number,Exponent:single):single; assembler; stdcall;
asm
 fstcw bw
 fldcw cw
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
 fldcw bw
end;

procedure TVSTiEditor.DrawADSR;
 function EnvExp(FromValue,ToValue:single;Counter,Duration:integer):single;
 begin
  if Counter<Duration then begin
   result:=FromValue*F_POWER(ToValue/FromValue,Counter/Duration);
  end else begin
   result:=ToValue;
  end;
 end;
const FloatOne:single=1;

var OldState,State,ADSRSamples,Sum,W,WorkSamplesCount,OX,OY,X,Y:integer;
    Value,ADSRCoefA,ADSRCoefB,ADSRCoefC,ADSRCoefX,Amp:single;
    ValueCasted:longint absolute Value;
    FloatOneCasted:longint absolute FloatOne;
    Targets:array[esNONE..esRELEASE] of single;
    Modes:array[esNONE..esRELEASE] of integer;
    Samples:array[esNONE..esRELEASE] of integer;
    WorkSamples:array[esNONE..esRELEASE] of integer;
    HoldSustain,ColorState,NewState:boolean;
    S:string;
var SampleCounter,H:integer;
 procedure DoOutput;
 var X,Y:integer;
 begin
  with ADSRBitmap.Canvas do begin
   X:=SampleCounter; //(SampleCounter*W) DIV Sum;
   Y:=ROUND((1-(Value*Amp))*H);
   if SampleCounter=0 then begin
    if (ScrollBarInstrumentVoiceADSRAttack.Position<>0) and (Modes[esATTACK]<>emNONE) then begin
     LineTo(X,Y);
    end else begin
     MoveTo(X,Y);
    end;
   end else begin
    LineTo(X,Y);
   end;
  end;
 end;
 procedure CalculateADSRCoef(CurrentLevel,NextLevel:single;Samples,Mode:integer;Factor:single);
 begin
  if Samples=0 then Samples:=1;
  case Mode of
   emLINEAR:begin
    ADSRCoefA:=1;
    ADSRCoefB:=(NextLevel-CurrentLevel)/Samples;
    ADSRCoefC:=CurrentLevel;
    ADSRCoefX:=0;
   end;
   emEXP:begin
    ADSRCoefA:=F_POWER(Factor,1/Samples);
    ADSRCoefB:=0;
    ADSRCoefC:=CurrentLevel;
    ADSRCoefX:=(1/Factor)*(NextLevel-CurrentLevel);
   end;
   emLOG:begin
    ADSRCoefA:=F_POWER(1/Factor,1/Samples);
    ADSRCoefB:=0;
    ADSRCoefC:=NextLevel;
    ADSRCoefX:=CurrentLevel-NextLevel;
   end;
  end;
 end;
 procedure InnerLoop(const NextLevel:single);
 begin
  while SampleCounter<WorkSamplesCount do begin
   ADSRCoefX:=(ADSRCoefX*ADSRCoefA)+ADSRCoefB;
   Value:=ADSRCoefX+ADSRCoefC;
   DoOutput;
   dec(ADSRSamples);
   if ADSRSamples<=0 then begin
    Value:=NextLevel;
    inc(State);
    break;
   end;
   inc(SampleCounter);
  end;
 end;
 procedure InnerLoopSustain;
 begin
  while SampleCounter<WorkSamplesCount do begin
   DoOutput;
   inc(SampleCounter);
  end;
 end;
begin
 try
  with ADSRBitmap.Canvas do begin
   Brush.Color:=TranslateColor($202020);
   Brush.Style:=bsSolid;
   Pen.Color:=TranslateColor($404040);
   Pen.Style:=psSolid;
   Rectangle(ClipRect);
   Pen.Color:=TranslateColor($eeeeee);
   W:=ADSRBitmap.Width+2;
   H:=ADSRBitmap.Height;

   WorkSamplesCount:=W;

   Value:=0;

   Amp:=sqr(ScrollBarInstrumentVoiceADSRAmplify.Position*fci255);//F_POWER(2,ScrollBarInstrumentVoiceADSRAmplify.Position*fCI127)-1;

   Targets[esNONE]:=0;
   Targets[esATTACK]:=1;
   Targets[esDECAY]:=sqr(ScrollBarInstrumentVoiceADSRDecayLevel.Position*fci255);//F_POWER(2,ScrollBarInstrumentVoiceADSRDecayLevel.Position*fCI127)-1;
   Targets[esSUSTAIN]:=Targets[esDECAY];
   Targets[esRELEASE]:=0;

   Samples[esNONE]:=1;
   Samples[esATTACK]:=SoftTRUNC(F_POWER(0.00005,1-(ScrollBarInstrumentVoiceADSRAttack.Position*fCI255))*2000000);
   Samples[esDECAY]:=SoftTRUNC(F_POWER(0.00005,1-(ScrollBarInstrumentVoiceADSRDecay.Position*fCI255))*2000000);
   Samples[esSUSTAIN]:=SoftTRUNC(F_POWER(0.00005,1-(ScrollBarInstrumentVoiceADSRSustain.Position*fCI255))*2000000);
   Samples[esRELEASE]:=SoftTRUNC(F_POWER(0.00005,1-(ScrollBarInstrumentVoiceADSRRelease.Position*fCI255))*2000000);

   Modes[esNONE]:=emNONE;
   Modes[esATTACK]:=ComboBoxInstrumentVoiceADSRAttack.ItemIndex;
   Modes[esDECAY]:=ComboBoxInstrumentVoiceADSRDecay.ItemIndex;
   Modes[esSUSTAIN]:=ComboBoxInstrumentVoiceADSRSustain.ItemIndex;
   Modes[esRELEASE]:=ComboBoxInstrumentVoiceADSRRelease.ItemIndex;

   if Modes[esATTACK]=emNONE then Samples[esATTACK]:=0;
   if Modes[esDECAY]=emNONE then Samples[esDECAY]:=0;
   if Modes[esSUSTAIN]=emsOFF then Samples[esSUSTAIN]:=0;
   if Modes[esRELEASE]=emNONE then Samples[esRELEASE]:=0;

   Sum:=Samples[esATTACK]+Samples[esDECAY]+Samples[esRELEASE];
   if (Modes[esSUSTAIN]=emsON) {AND (Samples[esSUSTAIN]=0)} then begin
    Samples[esSUSTAIN]:=Sum div 2;
   end;
   inc(Sum,Samples[esSUSTAIN]);
   if Sum=0 then Sum:=1;
   WorkSamples[esNONE]:=(Samples[esNONE]*W) div Sum;
   WorkSamples[esATTACK]:=(Samples[esATTACK]*W) div Sum;
   WorkSamples[esDECAY]:=(Samples[esDECAY]*W) div Sum;
   WorkSamples[esSUSTAIN]:=(Samples[esSUSTAIN]*W) div Sum;
   WorkSamples[esRELEASE]:=(Samples[esRELEASE]*W) div Sum;

   OldState:=esNONE;
   State:=esATTACK;

   SampleCounter:=0;
   if (ScrollBarInstrumentVoiceADSRAttack.Position<>0) and (Modes[esATTACK]<>emNONE) then begin
    if WorkSamples[esATTACK]<2 then begin
     MoveTo(0,ROUND(H-(Amp*H)));
     LineTo(0,H);
    end else begin
     MoveTo(0,H);
    end;
   end;

   ColorState:=false;
   while true do begin
    if (State>esRELEASE) or (State=emNONE) then break;
    if SampleCounter>=WorkSamplesCount then break;
    NewState:=false;
    HoldSustain:=(State=esSUSTAIN) and (Modes[State]=emsON) and false;
    if State<>OldState then begin
     OldState:=State;
     case ColorState of
      false:Pen.Color:=TranslateColor($eeeeee);
      else Pen.Color:=TranslateColor($888888);
     end;
     if (Modes[State]=emNONE) or ((Samples[State]=0) and not HoldSustain) then begin
      if State=esATTACK then Value:=1;
      inc(State);
      continue;
     end;
     if not HoldSustain then begin
      if State=esSUSTAIN then begin
       ADSRCoefA:=1;
       ADSRCoefB:=0;
       ADSRCoefC:=Value;
       ADSRCoefX:=0;
       Targets[State]:=Value;
      end else begin
       if State=esATTACK then begin
        if Modes[State]=emLINEAR then begin
         Value:=0;
        end else begin
         Value:=0.01;
        end;
       end;
       CalculateADSRCoef(Value,Targets[State],WorkSamples[State],Modes[State],1000);
      end;
      ADSRSamples:=WorkSamples[State];
      ColorState:=not ColorState;
      NewState:=true;
     end;
    end;
    if HoldSustain or NewState then begin
     OX:=PenPos.X;
     OY:=PenPos.Y;
     Brush.Style:=bsClear;
     Font.Color:=Pen.Color;
     Font.Style:=[fsBold];
     if (State=esSUSTAIN) and (Modes[esSUSTAIN]=emsON) then begin
      S:='Hold';
 //   X:=SampleCounter+(((W-SampleCounter)-TextWidth(S)) DIV 2);
      X:=SampleCounter+((WorkSamples[State]-TextWidth(S)) div 2);
     end else begin
      str(Samples[State]*0.01:1:2,s);
      S:=s+' ms';
      X:=SampleCounter+((WorkSamples[State]-TextWidth(S)) div 2);
     end;
     if X<0 then begin
      X:=0;
     end else if (X+TextWidth(S))>=W then begin
      X:=W-TextWidth(S);
     end;
     if State in [esATTACK,esDECAY,esRELEASE] then begin
      Y:=State-1;
      if Y<esATTACK then Y:=esATTACK;
      Y:=ROUND(H-(Targets[Y]*0.5*Amp*H));
     end else begin
      Y:=ROUND(H-(Targets[(State-1) and 3]*Amp*H))+2;
     end;
     if Y<0 then begin
      Y:=0;
     end else if (Y+TextHeight(S))>=H then begin
      Y:=H-TextHeight(S);
     end;
     TextOut(X,Y,S);
     MoveTo(OX,OY);
    end;
    if HoldSustain then break;
    InnerLoop(Targets[State]);
   end;
   InnerLoopSustain;
   if Modes[esSUSTAIN]<>emsON then begin
    LineTo(W,H);
   end;
  end;
  PaintBoxADSR.Canvas.CopyRect(PaintBoxADSR.ClientRect,ADSRBitmap.Canvas,PaintBoxADSR.ClientRect);
 except
 end;
end;

procedure TVSTiEditor.ExportMIDIUpdate;
begin
 if assigned(Plugin) then begin
  PanelExportMIDIEvents.Caption:=inttostr(TVSTiPlugin(Plugin).ExportMIDIEventList.Count)+' events';
 end;
end;

procedure TVSTiEditor.EnvelopesUpdate;
var APlugin:TVSTiPlugin;
    OldInChange:boolean;
begin
 OldInChange:=InChange;
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);

   if EnvelopeForm.Envelope<>@APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab] then begin
    EnvelopeForm.AudioCriticalSection:=AudioCriticalSection;
    EnvelopeForm.DataCriticalSection:=DataCriticalSection;
    EnvelopeForm.Envelope:=@APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab];
    EnvelopeForm.Invalidate;
    EditEnvelopeName.Text:=APlugin.EnvelopeNames[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab];
   end;

   SpinEditEnvADSRAttack.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Attack;
   SpinEditEnvADSRDecay.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Decay;
   SpinEditEnvADSRSustainTime.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.SustainHold;
   SpinEditEnvADSRRelease.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Release;
   SpinEditEnvADSRAmplify.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Amplify;
   SpinEditEnvADSRSustainLevel.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.SustainLevel;
   CheckBoxEnvADSRSustain.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Sustain;

   CheckBoxEnvTranceGateStep1.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[0];
   CheckBoxEnvTranceGateStep2.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[1];
   CheckBoxEnvTranceGateStep3.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[2];
   CheckBoxEnvTranceGateStep4.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[3];
   CheckBoxEnvTranceGateStep5.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[4];
   CheckBoxEnvTranceGateStep6.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[5];
   CheckBoxEnvTranceGateStep7.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[6];
   CheckBoxEnvTranceGateStep8.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[7];
   CheckBoxEnvTranceGateStep9.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[8];
   CheckBoxEnvTranceGateStep10.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[9];
   CheckBoxEnvTranceGateStep11.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[10];
   CheckBoxEnvTranceGateStep12.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[11];
   CheckBoxEnvTranceGateStep13.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[12];
   CheckBoxEnvTranceGateStep14.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[13];
   CheckBoxEnvTranceGateStep15.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[14];
   CheckBoxEnvTranceGateStep16.Checked:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[15];
   SpinEditEnvTranceGateOnAmp.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.OnAmp;
   SpinEditEnvTranceGateOffAmp.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.OffAmp;
   SpinEditEnvTranceGateBPM.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.BPM;
   ComboBoxEnvTranceGateNoteLength.ItemIndex:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.NoteLength;
   SpinEditEnvTranceGateDots.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Dots;
   SpinEditEnvAmpliferAmplify.Text:=APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Amplifer.Amplify;

  finally
   DataCriticalSection.Leave;
  end;
 end;
 InChange:=OldInChange;
end;

function floattostrex(d:double;i:integer=10):string;
begin
 str(d:1:i,result);
 if pos('.',result)>0 then begin
  while (length(result)>0) and (result[length(result)]='0') do begin
   delete(result,length(result),1);
  end;
  if (length(result)>0) and (result[length(result)]='.') then begin
   delete(result,length(result),1);
  end;
 end;
end;

procedure TVSTiEditor.SamplesUpdate;
var Counter,index:integer;
    S:string;
    APlugin:TVSTiPlugin;
    OldInChange:boolean;
    OldComboBoxSamplesItemIndex,
    OldComboBoxInstrumentVoiceOscillatorSamplesItemIndex,
    OldComboBoxInstrumentVoiceLFOSamplesItemIndex:integer;
begin
 OldInChange:=InChange;
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);

   OldComboBoxSamplesItemIndex:=ComboBoxSamples.ItemIndex;
   OldComboBoxInstrumentVoiceOscillatorSamplesItemIndex:=ComboBoxInstrumentVoiceOscillatorSample.ItemIndex;
   OldComboBoxInstrumentVoiceLFOSamplesItemIndex:=ComboBoxInstrumentVoiceLFOSample.ItemIndex;

   ComboBoxSamples.Items.BeginUpdate;
   ComboBoxInstrumentVoiceOscillatorSample.Items.BeginUpdate;
   ComboBoxInstrumentVoiceLFOSample.Items.BeginUpdate;

   if ComboBoxSamples.Items.Count<>MaxSamples then begin
    ComboBoxSamples.Items.Clear;
    for Counter:=0 to MaxSamples-1 do begin
     S:=INTTOSTR(Counter);
     while length(S)<3 do S:='0'+S;
     S:=S+'. '+APlugin.SampleNames[APlugin.CurrentProgram and $7f,Counter];
     ComboBoxSamples.Items.Add(S);
    end;
    if OldComboBoxSamplesItemIndex<0 then begin
     OldComboBoxSamplesItemIndex:=0;
    end;
   end;

   if ComboBoxInstrumentVoiceOscillatorSample.Items.Count<>MaxSamples then begin
    ComboBoxInstrumentVoiceOscillatorSample.Items.Clear;
    for Counter:=0 to MaxSamples-1 do begin
     S:=INTTOSTR(Counter);
     while length(S)<3 do S:='0'+S;
     S:=S+'. '+APlugin.SampleNames[APlugin.CurrentProgram and $7f,Counter];
     ComboBoxInstrumentVoiceOscillatorSample.Items.Add(S);
    end;
    if OldComboBoxInstrumentVoiceOscillatorSamplesItemIndex<0 then begin
     OldComboBoxInstrumentVoiceOscillatorSamplesItemIndex:=0;
    end;
   end;

   if ComboBoxInstrumentVoiceLFOSample.Items.Count<>MaxSamples then begin
    ComboBoxInstrumentVoiceLFOSample.Items.Clear;
    for Counter:=0 to MaxSamples-1 do begin
     S:=INTTOSTR(Counter);
     while length(S)<3 do S:='0'+S;
     S:=S+'. '+APlugin.SampleNames[APlugin.CurrentProgram and $7f,Counter];
     ComboBoxInstrumentVoiceLFOSample.Items.Add(S);
    end;
    if OldComboBoxInstrumentVoiceLFOSamplesItemIndex<0 then begin
     OldComboBoxInstrumentVoiceLFOSamplesItemIndex:=0;
    end;
   end;

   for Counter:=0 to MaxSamples-1 do begin
    S:=INTTOSTR(Counter);
    while length(S)<3 do S:='0'+S;
    S:=S+'. '+APlugin.SampleNames[APlugin.CurrentProgram and $7f,Counter];
    if ComboBoxSamples.Items[Counter]<>S then begin
     ComboBoxSamples.Items[Counter]:=S;
    end;
    if ComboBoxInstrumentVoiceOscillatorSample.Items[Counter]<>S then begin
     ComboBoxInstrumentVoiceOscillatorSample.Items[Counter]:=S;
    end;
    if ComboBoxInstrumentVoiceLFOSample.Items[Counter]<>S then begin
     ComboBoxInstrumentVoiceLFOSample.Items[Counter]:=S;
    end;
   end;

   ComboBoxSamples.Items.EndUpdate;
   ComboBoxInstrumentVoiceOscillatorSample.Items.EndUpdate;
   ComboBoxInstrumentVoiceLFOSample.Items.EndUpdate;

   ComboBoxSamples.ItemIndex:=OldComboBoxSamplesItemIndex;
   ComboBoxInstrumentVoiceOscillatorSample.ItemIndex:=OldComboBoxInstrumentVoiceOscillatorSamplesItemIndex;
   ComboBoxInstrumentVoiceLFOSample.ItemIndex:=OldComboBoxInstrumentVoiceLFOSamplesItemIndex;

   if EditSampleName.Text<>APlugin.SampleNames[APlugin.CurrentProgram and $7f,ComboBoxSamples.ItemIndex and $7f] then begin
    EditSampleName.Text:=APlugin.SampleNames[APlugin.CurrentProgram and $7f,ComboBoxSamples.ItemIndex and $7f];
   end;

   index:=ComboBoxSamples.ItemIndex;

   EditSamplesSampleRate.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate);

   EditSamplesPhaseSamples.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.PhaseSamples);

   ComboBoxSamplesNote.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note;

   ScrollbarSamplesFineTune.Position:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.FineTune shr 24;
   ScrollbarSamplesFineTuneScroll(ScrollbarSamplesFineTune,ScrollbarSamplesFineTune.Position);

   ComboBoxSamplesLoopMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode;
   EditSamplesLoopStart.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample);
   EditSamplesLoopEnd.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample);

   ComboBoxSamplesSustainLoopMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode;
   EditSamplesSustainLoopStart.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample);
   EditSamplesSustainLoopEnd.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample);

   CheckBoxSamplesRandomStartPosition.Checked:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.RandomStartPosition;

   CheckBoxSamplesPadSynthActive.Checked:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Active;
   CheckBoxSamplesPadSynthExtended.Checked:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.ExtendedAlgorithm;
   EditSamplesPadSynthWaveTableSize.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize);
   EditSamplesPadSynthSampleRate.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.SampleRate);
   EditSamplesPadSynthFrequency.Text:=floattostrex(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Frequency);
   EditSamplesPadSynthBandwidth.Text:=floattostrex(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Bandwidth);
   EditSamplesPadSynthBandwidthScale.Text:=floattostrex(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.BandwidthScale);
   EditSamplesPadSynthNumberOfHarmonics.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.NumHarmonics);
   ComboBoxSamplesPadSynthProfile.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Profile;
   ComboBoxSamplesPadSynthCurveMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.CurveMode;

   ScrollbarSamplesPadSynthCurveSteepness.Position:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.CurveSteepness;
   ScrollbarSamplesPadSynthCurveSteepnessScroll(ScrollbarSamplesPadSynthCurveSteepness,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.CurveSteepness);

   CheckBoxSamplesPadSynthExtendedBalance.Checked:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.ExtendedBalance;

   CheckBoxSamplesPadSynthStereo.Checked:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Stereo;

   ScrollbarSamplesPadSynthBalance.Position:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Balance;
   ScrollbarSamplesPadSynthBalanceScroll(ScrollbarSamplesPadSynthBalance,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Balance);

   if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
    WaveEditor.Daten:=@PSINGLES(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[0];
    WaveEditor.Samples:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples;
   end else begin
    WaveEditor.Daten:=nil;
    WaveEditor.Samples:=0;
   end;
   WaveEditor.Position:=0;
   WaveEditor.Kaenale:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels;
   WaveEditor.Bits:=32;
   WaveEditor.FloatingPoint:=true;
   WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
   WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
   WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
   WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
   WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
   WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
   WaveEditor.PeakCacheAktualisieren:=true;
   WaveEditor.Markieren:=false;
   WaveEditor.Markierung:=false;
   WaveEditor.Init;
   WaveEditor.Invalidate;
   WaveEditor.ClearZoom;

   PanelSamplesLengthSamples.Caption:='Length: '+INTTOSTR(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples)+' samples';

   try
    if SGTK0ComboBoxInstrumentSampleScriptLanguage.ItemIndex<>APlugin.SampleScriptLanguages[APlugin.CurrentProgram and $7f,index and $7f] then begin
     SGTK0ComboBoxInstrumentSampleScriptLanguage.ItemIndex:=APlugin.SampleScriptLanguages[APlugin.CurrentProgram and $7f,index and $7f];
    end;
   except
   end;
   try
 {  if SynMemoInstrumentSampleScriptCode.Text<>APlugin.SampleScripts[APlugin.CurrentProgram and $7f,index and $7f] then begin
     SynMemoInstrumentSampleScriptCode.Text:=APlugin.SampleScripts[APlugin.CurrentProgram and $7f,index and $7f];
    end;}
   except
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 InChange:=OldInChange;
end;

procedure TVSTiEditor.SpeechTextsUpdate;
var Counter:integer;
    S:string;
    APlugin:TVSTiPlugin;
    OldInChange:boolean;
    OldComboBoxSpeechTextsItemIndex
{   OldScrollbarInstrumentChannelSpeechTextNumberPosition}:integer;
begin
 OldInChange:=InChange;
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);

   OldComboBoxSpeechTextsItemIndex:=ComboBoxSpeechTexts.ItemIndex;
// OldScrollbarInstrumentChannelSpeechTextNumberPosition:=ScrollbarInstrumentChannelSpeechTextNumber.Position;

   ComboBoxSpeechTexts.Items.BeginUpdate;

   if ComboBoxSpeechTexts.Items.Count<>MaxSpeechTexts then begin
    ComboBoxSpeechTexts.Items.Clear;
    for Counter:=0 to MaxSpeechTexts-1 do begin
     S:=INTTOSTR(Counter);
     while length(S)<3 do S:='0'+S;
     S:=S+'. '+APlugin.SpeechTextNames[APlugin.CurrentProgram and $7f,Counter];
     ComboBoxSpeechTexts.Items.Add(S);
    end;
    if OldComboBoxSpeechTextsItemIndex<0 then begin
     OldComboBoxSpeechTextsItemIndex:=0;
    end;
   end;

   for Counter:=0 to MaxSpeechTexts-1 do begin
    S:=INTTOSTR(Counter);
    while length(S)<3 do S:='0'+S;
    S:=S+'. '+APlugin.SpeechTextNames[APlugin.CurrentProgram and $7f,Counter];
    if ComboBoxSpeechTexts.Items[Counter]<>S then begin
     ComboBoxSpeechTexts.Items[Counter]:=S;
    end;
   end;

   ComboBoxSpeechTexts.Items.EndUpdate;

   ComboBoxSpeechTexts.ItemIndex:=OldComboBoxSpeechTextsItemIndex;
// ScrollbarInstrumentChannelSpeechTextNumber.Position:=OldScrollbarInstrumentChannelSpeechTextNumberPosition;

   if EditSpeechTextName.Text<>APlugin.SpeechTextNames[APlugin.CurrentProgram and $7f,ComboBoxSpeechTexts.ItemIndex and $7f] then begin
    EditSpeechTextName.Text:=APlugin.SpeechTextNames[APlugin.CurrentProgram and $7f,ComboBoxSpeechTexts.ItemIndex and $7f];
   end;
   
   if MemoSpeechText.Text<>APlugin.SpeechTexts[APlugin.CurrentProgram and $7f,ComboBoxSpeechTexts.ItemIndex and $7f] then begin
    MemoSpeechText.Text:=APlugin.SpeechTexts[APlugin.CurrentProgram and $7f,ComboBoxSpeechTexts.ItemIndex and $7f];
    MemoSpeechTextPhonems.Text:=SpeechConvertTextToPhonems(MemoSpeechText.Text);
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 InChange:=OldInChange;
end;

procedure TVSTiEditor.VoiceOrderUpdate;
var S:string;
    APlugin:TVSTiPlugin;
    OldInChange:boolean;
    OldItemIndex,index:integer;
begin
 OldInChange:=InChange;
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  OldItemIndex:=ListBoxInstrumentVoiceOrder.ItemIndex;
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   ListBoxInstrumentVoiceOrder.Items.BeginUpdate;
   ListBoxInstrumentVoiceOrder.Items.Clear;
   for index:=low(TSynthInstrumentVoiceOrder) to high(TSynthInstrumentVoiceOrder) do begin
    S:=INTTOSTR(index)+'. ';
    case APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[index] of
     voDistortion:S:=S+'Distortion';
     voFilter:S:=S+'Filter';
    end;
    ListBoxInstrumentVoiceOrder.Items.Add(S);
   end;
   ListBoxInstrumentVoiceOrder.Items.EndUpdate;
  finally
   DataCriticalSection.Leave;
  end;
  ListBoxInstrumentVoiceOrder.ItemIndex:=OldItemIndex;
  ListBoxInstrumentVoiceOrder.Selected[ListBoxInstrumentVoiceOrder.ItemIndex]:=true;
 end;
 InChange:=OldInChange;
end;

procedure TVSTiEditor.ChannelOrderUpdate;
var S:string;
    APlugin:TVSTiPlugin;
    OldInChange:boolean;
    OldItemIndex,index:integer;
begin
 OldInChange:=InChange;
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  OldItemIndex:=ListBoxInstrumentChannelOrder.ItemIndex;
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   ListBoxInstrumentChannelOrder.Items.BeginUpdate;
   ListBoxInstrumentChannelOrder.Items.Clear;
   for index:=low(TSynthInstrumentChannelOrder) to high(TSynthInstrumentChannelOrder) do begin
    S:=INTTOSTR(index)+'. ';
    case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[index] of
     coDistortion:S:=S+'Distortion';
     coFilter:S:=S+'Filter';
     coDelay:S:=S+'Delay';
     coChorusFlanger:S:=S+'Chorus/Flanger';
     coCompressor:S:=S+'Compressor';
     coSpeech:S:=S+'Speech';
     coPitchShifter:S:=S+'PitchShifter';
     coEQ:S:=S+'EQ';
    end;
    ListBoxInstrumentChannelOrder.Items.Add(S);
   end;
   ListBoxInstrumentChannelOrder.Items.EndUpdate;
  finally
   DataCriticalSection.Leave;
  end;
  ListBoxInstrumentChannelOrder.ItemIndex:=OldItemIndex;
  ListBoxInstrumentChannelOrder.Selected[ListBoxInstrumentChannelOrder.ItemIndex]:=true;
 end;
 InChange:=OldInChange;
end;

procedure TVSTiEditor.GlobalOrderUpdate;
var S:string;
    APlugin:TVSTiPlugin;
    OldInChange:boolean;
    OldItemIndex,index:integer;
begin
 OldInChange:=InChange;
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  OldItemIndex:=SGTK0ListBoxGlobalOrder.ItemIndex;
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   SGTK0ListBoxGlobalOrder.Items.BeginUpdate;
   SGTK0ListBoxGlobalOrder.Items.Clear;
   for index:=low(TSynthGlobalOrder) to high(TSynthGlobalOrder) do begin
    S:=INTTOSTR(index)+'. ';
    case APlugin.Track.Global.Order[index] of
     goPITCHSHIFTER:S:=S+'PitchShifter';
     goENDFILTER:S:=S+'End Filter';
     goEQ:S:=S+'EQ';
     goCOMPRESSOR:S:=S+'Compressor';
    end;
    SGTK0ListBoxGlobalOrder.Items.Add(S);
   end;
   SGTK0ListBoxGlobalOrder.Items.EndUpdate;
  finally
   DataCriticalSection.Leave;
  end;
  SGTK0ListBoxGlobalOrder.ItemIndex:=OldItemIndex;
  SGTK0ListBoxGlobalOrder.Selected[SGTK0ListBoxGlobalOrder.ItemIndex]:=true;
 end;
 InChange:=OldInChange;
end;

procedure TVSTiEditor.EditorUpdate;
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr,Counter,Value:integer;
begin
 InChange:=true;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);

   CheckBoxMultithreading.Checked:=APlugin.Track.UseMultithreading;
   CheckBoxSSE.Checked:=APlugin.Track.UseSSE;

   S:=INTTOSTR(APlugin.CurrentProgram);
   while length(S)<3 do begin
    S:='0'+S;
   end;
   PanelInstrumentNr.Caption:=S;

   if OldPatchNr<>APlugin.CurrentProgram then begin
    OldPatchNr:=APlugin.CurrentProgram;
    OldOscTab:=-1;
    OldADSRTab:=-1;
    OldEnvTab:=-1;
    OldLFOTab:=-1;
    OldFilterTab:=-1;
    OldVoiceDistTab:=-1;
    OldChannelDistTab:=-1;
    OldChannelFilterTab:=-1;
    OldChannelDelayTab:=-1;
    OldModulationMatrix:=-1;

    EnvelopesUpdate;
    SamplesUpdate;
    SpeechTextsUpdate;

    EditInstrumentName.Text:=APlugin.ProgramNames[APlugin.CurrentProgram];

    ScrollBarInstrumentGlobalVolume.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Volume;
    ScrollBarInstrumentGlobalVolumeScroll(self,ScrollBarInstrumentGlobalVolume.Position);

    ScrollBarInstrumentGlobalTranspose.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Transpose;
    ScrollBarInstrumentGlobalTransposeScroll(self,ScrollBarInstrumentGlobalTranspose.Position);

    ScrollBarInstrumentGlobalChannelVolume.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelVolume;
    ScrollBarInstrumentGlobalChannelVolumeScroll(self,ScrollBarInstrumentGlobalChannelVolume.Position);

    ScrollBarInstrumentGlobalMaxPolyphony.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].MaxPolyphony;
    ScrollBarInstrumentGlobalMaxPolyphonyScroll(self,ScrollBarInstrumentGlobalMaxPolyphony.Position);

    CheckBoxInstrumentGlobalCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Carry;
    CheckBoxInstrumentGlobalCarryClick(self);

    ScrollBarInstrumentGlobalOutput.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalOutput;
    ScrollBarInstrumentGlobalOutputScroll(self,ScrollBarInstrumentGlobalOutput.Position);

    ScrollBarInstrumentGlobalReverb.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalReverb;
    ScrollBarInstrumentGlobalReverbScroll(self,ScrollBarInstrumentGlobalReverb.Position);

    ScrollBarInstrumentGlobalDelay.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalDelay;
    ScrollBarInstrumentGlobalDelayScroll(self,ScrollBarInstrumentGlobalDelay.Position);

    ScrollBarInstrumentGlobalChorusFlanger.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalChorusFlanger;
    ScrollBarInstrumentGlobalChorusFlangerScroll(self,ScrollBarInstrumentGlobalChorusFlanger.Position);

    // ---

    VoiceOrderUpdate;

    // ---

    ChannelOrderUpdate;

    // ---

    ScrollBarInstrumentChannelChorusFlangerWet.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Wet;
    ScrollBarInstrumentChannelChorusFlangerWetScroll(self,ScrollBarInstrumentChannelChorusFlangerWet.Position);

    ScrollBarInstrumentChannelChorusFlangerDry.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Dry;
    ScrollBarInstrumentChannelChorusFlangerDryScroll(self,ScrollBarInstrumentChannelChorusFlangerDry.Position);

    ScrollBarInstrumentChannelChorusFlangerTimeLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.TimeLeft;
    ScrollBarInstrumentChannelChorusFlangerTimeLeftScroll(self,ScrollBarInstrumentChannelChorusFlangerTimeLeft.Position);

    ScrollBarInstrumentChannelChorusFlangerTimeRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.TimeRight;
    ScrollBarInstrumentChannelChorusFlangerTimeRightScroll(self,ScrollBarInstrumentChannelChorusFlangerTimeRight.Position);

    ScrollBarInstrumentChannelChorusFlangerFeedBackLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.FeedBackLeft;
    ScrollBarInstrumentChannelChorusFlangerFeedBackLeftScroll(self,ScrollBarInstrumentChannelChorusFlangerFeedBackLeft.Position);

    ScrollBarInstrumentChannelChorusFlangerFeedBackRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.FeedBackRight;
    ScrollBarInstrumentChannelChorusFlangerFeedBackRightScroll(self,ScrollBarInstrumentChannelChorusFlangerFeedBackRight.Position);

    ScrollBarInstrumentChannelChorusFlangerLFORateLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFORateLeft;
    ScrollBarInstrumentChannelChorusFlangerLFORateLeftScroll(self,ScrollBarInstrumentChannelChorusFlangerLFORateLeft.Position);

    ScrollBarInstrumentChannelChorusFlangerLFORateRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFORateRight;
    ScrollBarInstrumentChannelChorusFlangerLFORateRightScroll(self,ScrollBarInstrumentChannelChorusFlangerLFORateRight.Position);

    ScrollBarInstrumentChannelChorusFlangerLFODepthLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFODepthLeft;
    ScrollBarInstrumentChannelChorusFlangerLFODepthLeftScroll(self,ScrollBarInstrumentChannelChorusFlangerLFODepthLeft.Position);

    ScrollBarInstrumentChannelChorusFlangerLFODepthRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFODepthRight;
    ScrollBarInstrumentChannelChorusFlangerLFODepthRightScroll(self,ScrollBarInstrumentChannelChorusFlangerLFODepthRight.Position);

    ScrollBarInstrumentChannelChorusFlangerLFOPhaseLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFOPhaseLeft;
    ScrollBarInstrumentChannelChorusFlangerLFOPhaseLeftScroll(self,ScrollBarInstrumentChannelChorusFlangerLFOPhaseLeft.Position);

    ScrollBarInstrumentChannelChorusFlangerLFOPhaseRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFOPhaseRight;
    ScrollBarInstrumentChannelChorusFlangerLFOPhaseRightScroll(self,ScrollBarInstrumentChannelChorusFlangerLFOPhaseRight.Position);

    CheckBoxInstrumentChannelChorusFlangerActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Active;
    CheckBoxInstrumentChannelChorusFlangerCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Carry;

    SGTK0CheckBoxInstrumentChannelChorusFlangerFine.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Fine;

    ScrollbarInstrumentChannelChorusFlangerCount.Max:=CHORUS_MAX;
    ScrollbarInstrumentChannelChorusFlangerCount.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Count;
    ScrollbarInstrumentChannelChorusFlangerCountScroll(ScrollbarInstrumentChannelChorusFlangerCount,ScrollbarInstrumentChannelChorusFlangerCount.Position);

    // ---

    ComboBoxInstrumentChannelCompressorMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Mode;

    ScrollBarInstrumentChannelCompressorThreshold.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Threshold;
    ScrollBarInstrumentChannelCompressorThresholdScroll(self,ScrollBarInstrumentChannelCompressorThreshold.Position);

    ScrollBarInstrumentChannelCompressorRatio.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Ratio;
    ScrollBarInstrumentChannelCompressorRatioScroll(self,ScrollBarInstrumentChannelCompressorRatio.Position);

    ScrollBarInstrumentChannelCompressorWindow.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.WindowSize;
    ScrollBarInstrumentChannelCompressorWindowScroll(self,ScrollBarInstrumentChannelCompressorWindow.Position);

    ScrollBarInstrumentChannelCompressorSoftHardKnee.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.SoftHardKnee;
    ScrollBarInstrumentChannelCompressorSoftHardKneeScroll(self,ScrollBarInstrumentChannelCompressorSoftHardKnee.Position);

    ScrollBarInstrumentChannelCompressorAttack.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Attack;
    ScrollBarInstrumentChannelCompressorAttackScroll(self,ScrollBarInstrumentChannelCompressorAttack.Position);

    ScrollBarInstrumentChannelCompressorRelease.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Release;
    ScrollBarInstrumentChannelCompressorReleaseScroll(self,ScrollBarInstrumentChannelCompressorRelease.Position);

    ScrollBarInstrumentChannelCompressorOutGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.OutGain;
    ScrollBarInstrumentChannelCompressorOutGainScroll(self,ScrollBarInstrumentChannelCompressorOutGain.Position);

    CheckBoxInstrumentChannelCompressorAutoGain.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.AutoGain;

    ComboBoxInstrumentChannelCompressorSideIn.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.SideIn;
 
    // ---

    CheckBoxInstrumentChannelSpeechActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Active;

    ScrollBarInstrumentChannelSpeechFrameLength.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.FrameLength;
    ScrollBarInstrumentChannelSpeechFrameLengthScroll(self,ScrollBarInstrumentChannelSpeechFrameLength.Position);

    ScrollBarInstrumentChannelSpeechSpeed.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Speed;
    ScrollBarInstrumentChannelSpeechSpeedScroll(self,ScrollBarInstrumentChannelSpeechSpeed.Position);

    ScrollBarInstrumentChannelSpeechTextNumber.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber;
    ScrollBarInstrumentChannelSpeechTextNumberScroll(self,ScrollBarInstrumentChannelSpeechTextNumber.Position);

    ScrollBarInstrumentChannelSpeechColor.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Color;
    ScrollBarInstrumentChannelSpeechColorScroll(self,ScrollBarInstrumentChannelSpeechColor.Position);

    ScrollBarInstrumentChannelSpeechNoiseGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.NoiseGain;
    ScrollBarInstrumentChannelSpeechNoiseGainScroll(self,ScrollBarInstrumentChannelSpeechNoiseGain.Position);

    ScrollBarInstrumentChannelSpeechGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Gain;
    ScrollBarInstrumentChannelSpeechGainScroll(self,ScrollBarInstrumentChannelSpeechGain.Position);

    EditInstrumentChannelSpeechF4.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.F4);
    EditInstrumentChannelSpeechF5.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.F5);
    EditInstrumentChannelSpeechF6.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.F6);
    EditInstrumentChannelSpeechB4.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.B4);
    EditInstrumentChannelSpeechB5.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.B5);
    EditInstrumentChannelSpeechB6.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.B6);

    ScrollBarInstrumentChannelSpeechCascadeGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.CascadeGain;
    ScrollBarInstrumentChannelSpeechCascadeGainScroll(self,ScrollBarInstrumentChannelSpeechCascadeGain.Position);

    ScrollBarInstrumentChannelSpeechParallelGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.ParallelGain;
    ScrollBarInstrumentChannelSpeechParallelGainScroll(self,ScrollBarInstrumentChannelSpeechParallelGain.Position);

    ScrollBarInstrumentChannelSpeechAspirationGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.AspirationGain;
    ScrollBarInstrumentChannelSpeechAspirationGainScroll(self,ScrollBarInstrumentChannelSpeechAspirationGain.Position);

    ScrollBarInstrumentChannelSpeechFricationGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.FricationGain;
    ScrollBarInstrumentChannelSpeechFricationGainScroll(self,ScrollBarInstrumentChannelSpeechFricationGain.Position);

    // ---

    CheckBoxInstrumentChannelPitchShifterActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelPitchShifter.Active;

    ScrollBarInstrumentChannelPitchShifterTune.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelPitchShifter.Tune;
    ScrollBarInstrumentChannelPitchShifterTuneScroll(self,ScrollBarInstrumentChannelPitchShifterTune.Position);

    ScrollBarInstrumentChannelPitchShifterFineTune.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelPitchShifter.FineTune;
    ScrollBarInstrumentChannelPitchShifterFineTuneScroll(self,ScrollBarInstrumentChannelPitchShifterFineTune.Position);

    // ---

    CheckBoxInstrumentChannelEQActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Active;
    ComboBoxInstrumentChannelEQMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode;
    case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
     eqm6db:begin
      Label63.Caption:='6';
      Label64.Caption:='-6';
      Label68.Caption:='6';
      Label66.Caption:='-6';
     end;
     eqm12db:begin
      Label63.Caption:='12';
      Label64.Caption:='-12';
      Label68.Caption:='12';
      Label66.Caption:='-12';
     end;
     else begin
      Label63.Caption:='24';
      Label64.Caption:='-24';
      Label68.Caption:='24';
      Label66.Caption:='-24';
     end;
    end;

    CheckBoxInstrumentChannelEQCascaded.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Cascaded;
    CheckBoxInstrumentChannelEQAddCascaded.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.AddCascaded;
    str((APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Octave*fCI65536):1:2,s);
    EditInstrumentChannelEQOctaveFactor.Text:=s;

    ScrollbarInstrumentChannelEQPreAmp.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.PreAmp;
    ScrollbarInstrumentChannelEQPreAmpScroll(ScrollbarInstrumentChannelEQPreAmp,ScrollbarInstrumentChannelEQPreAmp.Position);

    ScrollbarInstrumentChannelEQGain1.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[0];
    ScrollbarInstrumentChannelEQGain1Scroll(ScrollbarInstrumentChannelEQGain1,ScrollbarInstrumentChannelEQGain1.Position);

    ScrollbarInstrumentChannelEQGain2.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[1];
    ScrollbarInstrumentChannelEQGain2Scroll(ScrollbarInstrumentChannelEQGain2,ScrollbarInstrumentChannelEQGain2.Position);

    ScrollbarInstrumentChannelEQGain3.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[2];
    ScrollbarInstrumentChannelEQGain3Scroll(ScrollbarInstrumentChannelEQGain3,ScrollbarInstrumentChannelEQGain3.Position);

    ScrollbarInstrumentChannelEQGain4.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[3];
    ScrollbarInstrumentChannelEQGain4Scroll(ScrollbarInstrumentChannelEQGain4,ScrollbarInstrumentChannelEQGain4.Position);

    ScrollbarInstrumentChannelEQGain5.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[4];
    ScrollbarInstrumentChannelEQGain5Scroll(ScrollbarInstrumentChannelEQGain5,ScrollbarInstrumentChannelEQGain5.Position);

    ScrollbarInstrumentChannelEQGain6.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[5];
    ScrollbarInstrumentChannelEQGain6Scroll(ScrollbarInstrumentChannelEQGain6,ScrollbarInstrumentChannelEQGain6.Position);

    ScrollbarInstrumentChannelEQGain7.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[6];
    ScrollbarInstrumentChannelEQGain7Scroll(ScrollbarInstrumentChannelEQGain7,ScrollbarInstrumentChannelEQGain7.Position);

    ScrollbarInstrumentChannelEQGain8.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[7];
    ScrollbarInstrumentChannelEQGain8Scroll(ScrollbarInstrumentChannelEQGain8,ScrollbarInstrumentChannelEQGain8.Position);

    ScrollbarInstrumentChannelEQGain9.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[8];
    ScrollbarInstrumentChannelEQGain9Scroll(ScrollbarInstrumentChannelEQGain9,ScrollbarInstrumentChannelEQGain9.Position);

    ScrollbarInstrumentChannelEQGain10.Position:=240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[9];
    ScrollbarInstrumentChannelEQGain10Scroll(ScrollbarInstrumentChannelEQGain10,ScrollbarInstrumentChannelEQGain10.Position);

    EditInstrumentChannelEQBandHz1.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[0]);
    EditInstrumentChannelEQBandHz2.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[1]);
    EditInstrumentChannelEQBandHz3.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[2]);
    EditInstrumentChannelEQBandHz4.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[3]);
    EditInstrumentChannelEQBandHz5.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[4]);
    EditInstrumentChannelEQBandHz6.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[5]);
    EditInstrumentChannelEQBandHz7.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[6]);
    EditInstrumentChannelEQBandHz8.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[7]);
    EditInstrumentChannelEQBandHz9.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[8]);
    EditInstrumentChannelEQBandHz10.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[9]);

    // ---

    ScrollbarChannelLFORate.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelLFO.Rate;
    ScrollbarChannelLFORateScroll(ScrollbarChannelLFORate,ScrollbarChannelLFORate.Position);

    CheckBoxChannelLFOActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelLFO.Active;

    // ---

    CheckBoxInstrumentLinkActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Link.Active;

    ScrollbarInstrumentLinkChannel.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Link.Channel;
    ScrollbarInstrumentLinkChannelScroll(ScrollbarInstrumentLinkChannel,APlugin.Track.Instruments[APlugin.CurrentProgram].Link.Channel);

    ScrollbarInstrumentLinkProgram.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Link.ProgramNr;
    ScrollbarInstrumentLinkProgramScroll(ScrollbarInstrumentLinkProgram,APlugin.Track.Instruments[APlugin.CurrentProgram].Link.ProgramNr);

    // ---

    for Counter:=low(CheckBoxInstrumentControllerResolutionResolutionCheck) to high(CheckBoxInstrumentControllerResolutionResolutionCheck) do begin
     if assigned(CheckBoxInstrumentControllerResolutionResolutionCheck[Counter]) then begin
      CheckBoxInstrumentControllerResolutionResolutionCheck[Counter].Checked:=(APlugin.Track.Instruments[APlugin.CurrentProgram].Controller7BitFlags and (longword(1) shl longword(Counter)))<>0;
     end;
    end;

    // ---

    CheckBoxInstrumentUseTuningTable.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].UseTuningTable;
    UpdateInstrumentTuning;

   end;                                                                                                      

   // ---

   ItemNr:=SGTK0TabControlVoiceDistortion.ActiveTab;
   if OldVoiceDistTab<>ItemNr then begin
    OldVoiceDistTab:=ItemNr;

    ComboBoxInstrumentVoiceDistortionMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Mode;

    ScrollBarInstrumentVoiceDistortionGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Gain;
    ScrollBarInstrumentVoiceDistortionGainScroll(self,ScrollBarInstrumentVoiceDistortionGain.Position);

    ScrollBarInstrumentVoiceDistortionDist.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Dist;
    ScrollBarInstrumentVoiceDistortionDistScroll(self,ScrollBarInstrumentVoiceDistortionDist.Position);

    ScrollBarInstrumentVoiceDistortionRate.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Rate;
    ScrollBarInstrumentVoiceDistortionRateScroll(self,ScrollBarInstrumentVoiceDistortionRate.Position);

    CheckBoxInstrumentVoiceDistortionCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Carry;
   end;

   // ---

   ItemNr:=SGTK0TabControlChannelDistortion.ActiveTab;
   if OldChannelDistTab<>ItemNr then begin
    OldChannelDistTab:=ItemNr;

    ComboBoxInstrumentChannelDistortionMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Mode;

    ScrollBarInstrumentChannelDistortionGain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Gain;
    ScrollBarInstrumentChannelDistortionGainScroll(self,ScrollBarInstrumentChannelDistortionGain.Position);

    ScrollBarInstrumentChannelDistortionDist.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Dist;
    ScrollBarInstrumentChannelDistortionDistScroll(self,ScrollBarInstrumentChannelDistortionDist.Position);

    ScrollBarInstrumentChannelDistortionRate.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Rate;
    ScrollBarInstrumentChannelDistortionRateScroll(self,ScrollBarInstrumentChannelDistortionRate.Position);

    CheckBoxInstrumentChannelDistortionCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Carry;
   end;

   // ---

   ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
   if OldChannelFilterTab<>ItemNr then begin
    OldChannelFilterTab:=ItemNr;
    ComboBoxInstrumentChannelFilterMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Mode;

    ScrollBarInstrumentChannelFilterCutOff.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].CutOff;
    ScrollBarInstrumentChannelFilterCutOffScroll(self,ScrollBarInstrumentChannelFilterCutOff.Position);

    ScrollBarInstrumentChannelFilterResonance.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Resonance;
    ScrollBarInstrumentChannelFilterResonanceScroll(self,ScrollBarInstrumentChannelFilterResonance.Position);

    ScrollBarInstrumentChannelFilterVolume.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Volume;
    ScrollBarInstrumentChannelFilterVolumeScroll(self,ScrollBarInstrumentChannelFilterVolume.Position);

    ScrollBarInstrumentChannelFilterAmplify.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Amplify;
    ScrollBarInstrumentChannelFilterAmplifyScroll(self,ScrollBarInstrumentChannelFilterAmplify.Position);

    CheckBoxInstrumentChannelFilterCascaded.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Cascaded;
    CheckBoxInstrumentChannelFilterChain.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Chain;
    SGTK0CheckBoxChannelFilterCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Carry;

    SGTK0EditInstrumentChannelFilterMinHz.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz);
    SGTK0EditInstrumentChannelFilterMaxHz.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz);
   end;

   // ---

   ItemNr:=SGTK0TabControlChannelDelay.ActiveTab;
   if OldChannelDelayTab<>ItemNr then begin
    OldChannelDelayTab:=ItemNr;

    ScrollBarInstrumentChannelDelayWet.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].Wet;
    ScrollBarInstrumentChannelDelayWetScroll(self,ScrollBarInstrumentChannelDelayWet.Position);

    ScrollBarInstrumentChannelDelayDry.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].Dry;
    ScrollBarInstrumentChannelDelayDryScroll(self,ScrollBarInstrumentChannelDelayDry.Position);

    ScrollBarInstrumentChannelDelayTimeLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].TimeLeft;
    ScrollBarInstrumentChannelDelayTimeLeftScroll(self,ScrollBarInstrumentChannelDelayTimeLeft.Position);

    ScrollBarInstrumentChannelDelayTimeRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].TimeRight;
    ScrollBarInstrumentChannelDelayTimeRightScroll(self,ScrollBarInstrumentChannelDelayTimeRight.Position);

    ScrollBarInstrumentChannelDelayFeedBackLeft.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].FeedBackLeft;
    ScrollBarInstrumentChannelDelayFeedBackLeftScroll(self,ScrollBarInstrumentChannelDelayFeedBackLeft.Position);

    ScrollBarInstrumentChannelDelayFeedBackRight.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].FeedBackRight;
    ScrollBarInstrumentChannelDelayFeedBackRightScroll(self,ScrollBarInstrumentChannelDelayFeedBackRight.Position);

    CheckBoxInstrumentChannelDelayActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].Active;

    CheckBoxInstrumentChannelDelayClockSync.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].ClockSync;

    CheckBoxInstrumentChannelDelayFine.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].Fine;

    CheckBoxInstrumentChannelDelayRecursive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[ItemNr].Recursive;
   end;

   // ---

   ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
   if OldOscTab<>ItemNr then begin
    OldOscTab:=ItemNr;

    ComboBoxInstrumentVoiceOscillatorNoteBegin.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].NoteBegin;
    ComboBoxInstrumentVoiceOscillatorNoteEnd.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].NoteEnd;
    ComboBoxInstrumentVoiceOscillatorWaveform.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Waveform;
    ComboBoxInstrumentVoiceOscillatorSynthesisType.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SynthesisType;

    ComboBoxInstrumentVoiceOscillatorInput.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Input+1;
    ComboBoxInstrumentVoiceOscillatorHardSyncInput.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].HardSyncInput+1;

    if APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Waveform=wfSAMPLE then begin
     ScrollbarInstrumentVoiceOscillatorColor.Max:=63;
    end else begin
     ScrollbarInstrumentVoiceOscillatorColor.Max:=64;
    end;
    ScrollBarInstrumentVoiceOscillatorColor.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Color;
    ScrollBarInstrumentVoiceOscillatorColorScroll(self,ScrollBarInstrumentVoiceOscillatorColor.Position);

    ScrollBarInstrumentVoiceOscillatorFeedBack.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].FeedBack;
    ScrollBarInstrumentVoiceOscillatorFeedBackScroll(self,ScrollBarInstrumentVoiceOscillatorFeedBack.Position);

    ScrollBarInstrumentVoiceOscillatorTranspose.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Transpose;
    ScrollBarInstrumentVoiceOscillatorTransposeScroll(self,ScrollBarInstrumentVoiceOscillatorTranspose.Position);

    ScrollBarInstrumentVoiceOscillatorFinetune.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Finetune;
    ScrollBarInstrumentVoiceOscillatorFinetuneScroll(self,ScrollBarInstrumentVoiceOscillatorFinetune.Position);

    ScrollBarInstrumentVoiceOscillatorPhaseStart.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PhaseStart;
    ScrollBarInstrumentVoiceOscillatorPhaseStartScroll(self,ScrollBarInstrumentVoiceOscillatorPhaseStart.Position);

    ScrollBarInstrumentVoiceOscillatorVolume.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Volume;
    ScrollBarInstrumentVoiceOscillatorVolumeScroll(self,ScrollBarInstrumentVoiceOscillatorVolume.Position);

    ScrollBarInstrumentVoiceOscillatorGlide.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Glide;
    ScrollBarInstrumentVoiceOscillatorGlideScroll(self,ScrollBarInstrumentVoiceOscillatorGlide.Position);

    CheckBoxInstrumentVoiceOscillatorHardsync.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].HardSync;
    CheckBoxInstrumentVoiceOscillatorCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Carry;
    CheckBoxInstrumentVoiceOscillatorPMFMExtendedMode.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PMFMExtendedMode;

    CheckBoxInstrumentVoiceOscillatorRandomPhase.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].RandomPhase;

    CheckBoxInstrumentVoiceOscillatorOutput.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Output;

    PanelInstrumentVoiceOscillatorSample.Visible:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].WaveForm=wfSAMPLE;
    if PanelInstrumentVoiceOscillatorSample.Visible then begin
     ComboBoxInstrumentVoiceOscillatorSample.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Color+64;
    end;

    CheckBoxInstrumentVoiceOscillatorPanning.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].UsePanning;
    ScrollBarInstrumentVoiceOscillatorPanning.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Panning;
    ScrollBarInstrumentVoiceOscillatorPanningScroll(self,ScrollBarInstrumentVoiceOscillatorPanning.Position);

    ScrollBarInstrumentVoiceOscillatorPluckedStringReflection.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringReflection;
    ScrollBarInstrumentVoiceOscillatorPluckedStringReflectionScroll(self,ScrollBarInstrumentVoiceOscillatorPluckedStringReflection.Position);

    ScrollBarInstrumentVoiceOscillatorPluckedStringPick.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringPick;
    ScrollBarInstrumentVoiceOscillatorPluckedStringPickScroll(self,ScrollBarInstrumentVoiceOscillatorPluckedStringPick.Position);

    ScrollBarInstrumentVoiceOscillatorPluckedStringPickUp.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringPickUp;
    ScrollBarInstrumentVoiceOscillatorPluckedStringPickUpScroll(self,ScrollBarInstrumentVoiceOscillatorPluckedStringPickUp.Position);

    ScrollBarInstrumentVoiceOscillatorPluckedStringDelayLineWidth.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringDelayLineWidth;
    ScrollBarInstrumentVoiceOscillatorPluckedStringDelayLineWidthScroll(self,ScrollBarInstrumentVoiceOscillatorPluckedStringDelayLineWidth.Position);

    ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringDelayLineMode;

    ComboBoxInstrumentVoiceOscillatorSuperOscWaveform.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscWaveform;

    ComboBoxInstrumentVoiceOscillatorSuperOscMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscMode;

    ScrollBarInstrumentVoiceOscillatorSuperOscCount.Min:=1;
    ScrollBarInstrumentVoiceOscillatorSuperOscCount.Max:=soCountSubOscillators;
    ScrollBarInstrumentVoiceOscillatorSuperOscCount.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscCount;
    ScrollBarInstrumentVoiceOscillatorSuperOscCountScroll(self,APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscCount);

    ScrollBarInstrumentVoiceOscillatorSuperOscDetune.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscDetune;
    ScrollBarInstrumentVoiceOscillatorSuperOscDetuneScroll(self,APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscDetune);

    ScrollBarInstrumentVoiceOscillatorSuperOscMix.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscMix;
    ScrollBarInstrumentVoiceOscillatorSuperOscMixScroll(self,APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscMix);
   end;

   // ---

   ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
   if OldADSRTab<>ItemNr then begin
    OldADSRTab:=ItemNr;

    ComboBoxInstrumentVoiceADSRAttack.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esAttack];
    ComboBoxInstrumentVoiceADSRDecay.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esDecay];
    ComboBoxInstrumentVoiceADSRSustain.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esSustain];
    ComboBoxInstrumentVoiceADSRRelease.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esRelease];

    ScrollBarInstrumentVoiceADSRAttack.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esATTACK];
    ScrollBarInstrumentVoiceADSRAttackScroll(self,ScrollBarInstrumentVoiceADSRAttack.Position);

    ScrollBarInstrumentVoiceADSRDecay.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esDECAY];
    ScrollBarInstrumentVoiceADSRDecayScroll(self,ScrollBarInstrumentVoiceADSRDecay.Position);

    ScrollBarInstrumentVoiceADSRSustain.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esSUSTAIN];
    ScrollBarInstrumentVoiceADSRSustainScroll(self,ScrollBarInstrumentVoiceADSRSustain.Position);

    ScrollBarInstrumentVoiceADSRRelease.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esRELEASE];
    ScrollBarInstrumentVoiceADSRReleaseScroll(self,ScrollBarInstrumentVoiceADSRRelease.Position);

    ScrollBarInstrumentVoiceADSRAmplify.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Amplify;
    ScrollBarInstrumentVoiceADSRAmplifyScroll(self,ScrollBarInstrumentVoiceADSRAmplify.Position);

    ScrollBarInstrumentVoiceADSRDecayLevel.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].TargetDecayLevel;
    ScrollBarInstrumentVoiceADSRDecayLevelScroll(self,ScrollBarInstrumentVoiceADSRDecayLevel.Position);

    CheckBoxInstrumentVoiceADSRActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Active;
    CheckBoxInstrumentVoiceADSRActiveCheck.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].ActiveCheck;
    CheckBoxInstrumentVoiceADSRCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Carry;
    CheckBoxInstrumentVoiceADSRCenterise.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Centerise;
         
    DrawADSR;
   end;

   ItemNr:=TabControlInstrumentVoiceEnvelopes.ActiveTab;
   if OldEnvTab<>ItemNr then begin
    OldEnvTab:=ItemNr;

    CheckBoxInstrumentVoiceEnvelopeActive.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Active;
    CheckBoxInstrumentVoiceEnvelopeActiveCheck.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].ActiveCheck;
    CheckBoxInstrumentVoiceEnvelopeCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Carry;
    CheckBoxInstrumentVoiceEnvelopeCenterise.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Centerise;

    ScrollBarInstrumentVoiceEnvelopeAmplify.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Amplify;
    ScrollBarInstrumentVoiceEnvelopeAmplifyScroll(self,ScrollBarInstrumentVoiceEnvelopeAmplify.Position);

    EnvelopesUpdate;
   end;

   ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
   if OldLFOTab<>ItemNr then begin
    OldLFOTab:=ItemNr;

    ComboBoxInstrumentVoiceLFOWaveform.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Waveform;
    ComboBoxInstrumentVoiceLFOSample.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Sample;

    ScrollBarInstrumentVoiceLFORate.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Rate;
    ScrollBarInstrumentVoiceLFORateScroll(self,ScrollBarInstrumentVoiceLFORate.Position);

    ScrollBarInstrumentVoiceLFODepth.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Depth;
    ScrollBarInstrumentVoiceLFODepthScroll(self,ScrollBarInstrumentVoiceLFODepth.Position);

    ScrollBarInstrumentVoiceLFOMiddle.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Middle;
    ScrollBarInstrumentVoiceLFOMiddleScroll(self,ScrollBarInstrumentVoiceLFOMiddle.Position);

    ScrollBarInstrumentVoiceLFOSweep.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Sweep;
    ScrollBarInstrumentVoiceLFOSweepScroll(self,ScrollBarInstrumentVoiceLFOSweep.Position);

    ScrollBarInstrumentVoiceLFOPhaseStart.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].PhaseStart;
    ScrollBarInstrumentVoiceLFOPhaseStartScroll(self,ScrollBarInstrumentVoiceLFOPhaseStart.Position);

    CheckBoxInstrumentVoiceLFOAmp.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Amp;
    CheckBoxInstrumentVoiceLFOCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Carry;

    ComboBoxInstrumentVoiceLFOPhaseSync.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].PhaseSync;

   end;

   ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
   if OldFilterTab<>ItemNr then begin
    OldFilterTab:=ItemNr;

    ComboBoxInstrumentVoiceFilterMode.ItemIndex:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Mode;

    ScrollBarInstrumentVoiceFilterCutOff.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff;
    ScrollBarInstrumentVoiceFilterCutOffScroll(self,ScrollBarInstrumentVoiceFilterCutOff.Position);

    ScrollBarInstrumentVoiceFilterResonance.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Resonance;
    ScrollBarInstrumentVoiceFilterResonanceScroll(self,ScrollBarInstrumentVoiceFilterResonance.Position);

    ScrollBarInstrumentVoiceFilterVolume.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Volume;
    ScrollBarInstrumentVoiceFilterVolumeScroll(self,ScrollBarInstrumentVoiceFilterVolume.Position);

    ScrollBarInstrumentVoiceFilterAmplify.Position:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Amplify;
    ScrollBarInstrumentVoiceFilterAmplifyScroll(self,ScrollBarInstrumentVoiceFilterAmplify.Position);

    CheckBoxInstrumentVoiceFilterCascaded.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Cascaded;
    CheckBoxInstrumentVoiceFilterChain.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Chain;
    CheckBoxInstrumentVoiceFilterCarry.Checked:=APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Carry;

    SGTK0EditInstrumentVoiceFilterHzMin.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz);
    SGTK0EditInstrumentVoiceFilterHzMax.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz);
   end;

   begin
    Value:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-MaxVisibleModulationMatrixItems;
    if Value<0 then begin
     Value:=0;
    end;
    if ScrollbarModulationMatrixItems.Max<>Value then begin
     if ScrollbarModulationMatrixItems.Position>Value then begin
      ScrollbarModulationMatrixItems.Position:=Value;
     end;
     ScrollbarModulationMatrixItems.Max:=Value;
    end;
   end;

   if OldModulationMatrix<>ScrollbarModulationMatrixItems.Position then begin
    OldModulationMatrix:=ScrollbarModulationMatrixItems.Position;

    for Counter:=0 to MaxVisibleModulationMatrixItems-1 do begin
     FormModulationMatrixItems[Counter].InChange:=true;
     FormModulationMatrixItems[Counter].AudioCriticalSection:=AudioCriticalSection;
     FormModulationMatrixItems[Counter].DataCriticalSection:=DataCriticalSection;
    end;

    try
     Value:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-MaxVisibleModulationMatrixItems;
     if Value<0 then Value:=0;
     ScrollbarModulationMatrixItems.Max:=Value;

     S:=INTTOSTR(APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems);
     while length(S)<3 do begin
      S:='0'+S;
     end;
     LabelModulationMatrixCount.Caption:=S;

     for Counter:=0 to MaxVisibleModulationMatrixItems-1 do begin
      Value:=Counter+ScrollbarModulationMatrixItems.Position;
      if Value<APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems then begin
       S:=INTTOSTR(Value);
       while length(S)<3 do S:='0'+S;
       FormModulationMatrixItems[Counter].Nr:=Value;
       FormModulationMatrixItems[Counter].Tag:=Value;
       FormModulationMatrixItems[Counter].PanelNr.Caption:=S;
       FormModulationMatrixItems[Counter].ModulationMatrixItem:=@APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Value];
       FormModulationMatrixItems[Counter].Visible:=true;
       FormModulationMatrixItems[Counter].DoUp:=DoModulationMatrixItemUp;
       FormModulationMatrixItems[Counter].DoDown:=DoModulationMatrixItemDown;
       FormModulationMatrixItems[Counter].EditorUpdate;
      end else begin
       FormModulationMatrixItems[Counter].Visible:=false;
      end;
     end;
    except
    end;
    for Counter:=0 to MaxVisibleModulationMatrixItems-1 do begin
     FormModulationMatrixItems[Counter].InChange:=false;
    end;
   end;

   // ---
   
   if BankWasChanged then begin
    BankWasChanged:=false;

    // ---
    
    CheckBoxGlobalsReverbActive.Checked:=APlugin.Track.Global.Reverb.Active;

    ScrollBarGlobalsReverbPreDelay.Position:=APlugin.Track.Global.Reverb.PreDelay;
    ScrollBarGlobalsReverbPreDelayScroll(self,ScrollBarGlobalsReverbPreDelay.Position);

    ScrollBarGlobalsReverbCombFilterSeparation.Position:=APlugin.Track.Global.Reverb.CombFilterSeparation;
    ScrollBarGlobalsReverbCombFilterSeparationScroll(self,ScrollBarGlobalsReverbCombFilterSeparation.Position);

    ScrollBarGlobalsReverbRoomSize.Position:=APlugin.Track.Global.Reverb.RoomSize;
    ScrollBarGlobalsReverbRoomSizeScroll(self,ScrollBarGlobalsReverbRoomSize.Position);

    ScrollBarGlobalsReverbFeedBack.Position:=APlugin.Track.Global.Reverb.FeedBack;
    ScrollBarGlobalsReverbFeedBackScroll(self,ScrollBarGlobalsReverbFeedBack.Position);

    ScrollBarGlobalsReverbAbsortion.Position:=APlugin.Track.Global.Reverb.Absortion;
    ScrollBarGlobalsReverbAbsortionScroll(self,ScrollBarGlobalsReverbAbsortion.Position);

    ScrollBarGlobalsReverbDry.Position:=APlugin.Track.Global.Reverb.Dry;
    ScrollBarGlobalsReverbDryScroll(self,ScrollBarGlobalsReverbDry.Position);

    ScrollBarGlobalsReverbWet.Position:=APlugin.Track.Global.Reverb.Wet;
    ScrollBarGlobalsReverbWetScroll(self,ScrollBarGlobalsReverbWet.Position);

    ScrollBarGlobalsReverbNumberOfAllPassFilters.Max:=MaxReverbAllPassFilters;
    ScrollBarGlobalsReverbNumberOfAllPassFilters.Position:=APlugin.Track.Global.Reverb.NumberOfAllPassFilters;
    ScrollBarGlobalsReverbNumberOfAllPassFiltersScroll(self,ScrollBarGlobalsReverbNumberOfAllPassFilters.Position);

    // ---

    CheckBoxGlobalsDelayActive.Checked:=APlugin.Track.Global.Delay.Active;

    CheckBoxGlobalsDelayClockSync.Checked:=APlugin.Track.Global.Delay.ClockSync;

    ScrollBarGlobalsDelayWet.Position:=APlugin.Track.Global.Delay.Wet;
    ScrollBarGlobalsDelayWetScroll(self,ScrollBarGlobalsDelayWet.Position);

    ScrollBarGlobalsDelayDry.Position:=APlugin.Track.Global.Delay.Dry;
    ScrollBarGlobalsDelayDryScroll(self,ScrollBarGlobalsDelayDry.Position);

    ScrollBarGlobalsDelayTimeLeft.Position:=APlugin.Track.Global.Delay.TimeLeft;
    ScrollBarGlobalsDelayTimeLeftScroll(self,ScrollBarGlobalsDelayTimeLeft.Position);

    ScrollBarGlobalsDelayTimeRight.Position:=APlugin.Track.Global.Delay.TimeRight;
    ScrollBarGlobalsDelayTimeRightScroll(self,ScrollBarGlobalsDelayTimeRight.Position);

    ScrollBarGlobalsDelayFeedBackLeft.Position:=APlugin.Track.Global.Delay.FeedBackLeft;
    ScrollBarGlobalsDelayFeedBackLeftScroll(self,ScrollBarGlobalsDelayFeedBackLeft.Position);

    ScrollBarGlobalsDelayFeedBackRight.Position:=APlugin.Track.Global.Delay.FeedBackRight;
    ScrollBarGlobalsDelayFeedBackRightScroll(self,ScrollBarGlobalsDelayFeedBackRight.Position);

    CheckBoxGlobalsDelayFine.Checked:=APlugin.Track.Global.Delay.Fine;

    CheckBoxGlobalsDelayRecursive.Checked:=APlugin.Track.Global.Delay.Recursive;

    // ---

    CheckBoxGlobalsChorusFlangerActive.Checked:=APlugin.Track.Global.ChorusFlanger.Active;

    ScrollBarGlobalsChorusFlangerWet.Position:=APlugin.Track.Global.ChorusFlanger.Wet;
    ScrollBarGlobalsChorusFlangerWetScroll(self,ScrollBarGlobalsChorusFlangerWet.Position);

    ScrollBarGlobalsChorusFlangerDry.Position:=APlugin.Track.Global.ChorusFlanger.Dry;
    ScrollBarGlobalsChorusFlangerDryScroll(self,ScrollBarGlobalsChorusFlangerDry.Position);

    ScrollBarGlobalsChorusFlangerTimeLeft.Position:=APlugin.Track.Global.ChorusFlanger.TimeLeft;
    ScrollBarGlobalsChorusFlangerTimeLeftScroll(self,ScrollBarGlobalsChorusFlangerTimeLeft.Position);

    ScrollBarGlobalsChorusFlangerTimeRight.Position:=APlugin.Track.Global.ChorusFlanger.TimeRight;
    ScrollBarGlobalsChorusFlangerTimeRightScroll(self,ScrollBarGlobalsChorusFlangerTimeRight.Position);

    ScrollBarGlobalsChorusFlangerFeedBackLeft.Position:=APlugin.Track.Global.ChorusFlanger.FeedBackLeft;
    ScrollBarGlobalsChorusFlangerFeedBackLeftScroll(self,ScrollBarGlobalsChorusFlangerFeedBackLeft.Position);

    ScrollBarGlobalsChorusFlangerFeedBackRight.Position:=APlugin.Track.Global.ChorusFlanger.FeedBackRight;
    ScrollBarGlobalsChorusFlangerFeedBackRightScroll(self,ScrollBarGlobalsChorusFlangerFeedBackRight.Position);

    ScrollBarGlobalsChorusFlangerLFORateLeft.Position:=APlugin.Track.Global.ChorusFlanger.LFORateLeft;
    ScrollBarGlobalsChorusFlangerLFORateLeftScroll(self,ScrollBarGlobalsChorusFlangerLFORateLeft.Position);

    ScrollBarGlobalsChorusFlangerLFORateRight.Position:=APlugin.Track.Global.ChorusFlanger.LFORateRight;
    ScrollBarGlobalsChorusFlangerLFORateRightScroll(self,ScrollBarGlobalsChorusFlangerLFORateRight.Position);

    ScrollBarGlobalsChorusFlangerLFODepthLeft.Position:=APlugin.Track.Global.ChorusFlanger.LFODepthLeft;
    ScrollBarGlobalsChorusFlangerLFODepthLeftScroll(self,ScrollBarGlobalsChorusFlangerLFODepthLeft.Position);

    ScrollBarGlobalsChorusFlangerLFODepthRight.Position:=APlugin.Track.Global.ChorusFlanger.LFODepthRight;
    ScrollBarGlobalsChorusFlangerLFODepthRightScroll(self,ScrollBarGlobalsChorusFlangerLFODepthRight.Position);

    ScrollBarGlobalsChorusFlangerLFOPhaseLeft.Position:=APlugin.Track.Global.ChorusFlanger.LFOPhaseLeft;
    ScrollBarGlobalsChorusFlangerLFOPhaseLeftScroll(self,ScrollBarGlobalsChorusFlangerLFOPhaseLeft.Position);

    ScrollBarGlobalsChorusFlangerLFOPhaseRight.Position:=APlugin.Track.Global.ChorusFlanger.LFOPhaseRight;
    ScrollBarGlobalsChorusFlangerLFOPhaseRightScroll(self,ScrollBarGlobalsChorusFlangerLFOPhaseRight.Position);

    CheckBoxGlobalsChorusFlangerCarry.Checked:=APlugin.Track.Global.ChorusFlanger.Carry;

    CheckBoxGlobalsChorusFlangerFine.Checked:=APlugin.Track.Global.ChorusFlanger.Fine;

    ScrollbarGlobalsChorusFlangerCount.Max:=CHORUS_MAX;
    ScrollbarGlobalsChorusFlangerCount.Position:=APlugin.Track.Global.ChorusFlanger.Count;
    ScrollbarGlobalsChorusFlangerCountScroll(ScrollbarGlobalsChorusFlangerCount,ScrollbarGlobalsChorusFlangerCount.Position);

    // ---

    CheckBoxGlobalsEndFilterActive.Checked:=APlugin.Track.Global.EndFilter.Active;

    ScrollBarGlobalsEndFilterLowCut.Position:=APlugin.Track.Global.EndFilter.LowCut;
    ScrollBarGlobalsEndFilterLowCutScroll(self,ScrollBarGlobalsEndFilterLowCut.Position);

    ScrollBarGlobalsEndFilterHighCut.Position:=APlugin.Track.Global.EndFilter.HighCut;
    ScrollBarGlobalsEndFilterHighCutScroll(self,ScrollBarGlobalsEndFilterHighCut.Position);

    // ---

    ComboBoxGlobalsCompressorMode.ItemIndex:=APlugin.Track.Global.Compressor.Mode;

    ScrollBarGlobalsCompressorThreshold.Position:=APlugin.Track.Global.Compressor.Threshold;
    ScrollBarGlobalsCompressorThresholdScroll(self,ScrollBarGlobalsCompressorThreshold.Position);

    ScrollBarGlobalsCompressorRatio.Position:=APlugin.Track.Global.Compressor.Ratio;
    ScrollBarGlobalsCompressorRatioScroll(self,ScrollBarGlobalsCompressorRatio.Position);

    ScrollBarGlobalsCompressorWindow.Position:=APlugin.Track.Global.Compressor.WindowSize;
    ScrollBarGlobalsCompressorWindowScroll(self,ScrollBarGlobalsCompressorWindow.Position);

    ScrollBarGlobalsCompressorSoftHardKnee.Position:=APlugin.Track.Global.Compressor.SoftHardKnee;
    ScrollBarGlobalsCompressorSoftHardKneeScroll(self,ScrollBarGlobalsCompressorSoftHardKnee.Position);

    ScrollBarGlobalsCompressorAttack.Position:=APlugin.Track.Global.Compressor.Attack;
    ScrollBarGlobalsCompressorAttackScroll(self,ScrollBarGlobalsCompressorAttack.Position);

    ScrollBarGlobalsCompressorRelease.Position:=APlugin.Track.Global.Compressor.Release;
    ScrollBarGlobalsCompressorReleaseScroll(self,ScrollBarGlobalsCompressorRelease.Position);

    ScrollBarGlobalsCompressorOutGain.Position:=APlugin.Track.Global.Compressor.OutGain;
    ScrollBarGlobalsCompressorOutGainScroll(self,ScrollBarGlobalsCompressorOutGain.Position);

    CheckBoxGlobalsCompressorAutoGain.Checked:=APlugin.Track.Global.Compressor.AutoGain;

    // ---

    CheckBoxGlobalPitchShifterActive.Checked:=APlugin.Track.Global.PitchShifter.Active;

    ScrollBarGlobalPitchShifterTune.Position:=APlugin.Track.Global.PitchShifter.Tune;
    ScrollBarGlobalPitchShifterTuneScroll(self,ScrollBarGlobalPitchShifterTune.Position);

    ScrollBarGlobalPitchShifterFineTune.Position:=APlugin.Track.Global.PitchShifter.FineTune;
    ScrollBarGlobalPitchShifterFineTuneScroll(self,ScrollBarGlobalPitchShifterFineTune.Position);

    // ---

    CheckBoxGlobalEQActive.Checked:=APlugin.Track.Global.EQ.Active;
    ComboBoxGlobalEQMode.ItemIndex:=APlugin.Track.Global.EQ.Mode;
    case APlugin.Track.Global.EQ.Mode of
     eqm6db:begin
      Label69.Caption:='6';
      Label70.Caption:='-6';
      Label74.Caption:='6';
      Label72.Caption:='-6';
     end;
     eqm12db:begin
      Label69.Caption:='12';
      Label70.Caption:='-12';
      Label74.Caption:='12';
      Label72.Caption:='-12';
     end;
     else begin
      Label69.Caption:='24';
      Label70.Caption:='-24';
      Label74.Caption:='24';
      Label72.Caption:='-24';
     end;
    end;

    CheckBoxGlobalEQCascaded.Checked:=APlugin.Track.Global.EQ.Cascaded;
    CheckBoxGlobalEQAddCascaded.Checked:=APlugin.Track.Global.EQ.AddCascaded;
    str((APlugin.Track.Global.EQ.Octave*fCI65536):1:2,s);
    EditGlobalEQOctaveFactor.Text:=s;

    ScrollbarGlobalEQPreAmp.Position:=APlugin.Track.Global.EQ.PreAmp;
    ScrollbarGlobalEQPreAmpScroll(ScrollbarGlobalEQPreAmp,ScrollbarGlobalEQPreAmp.Position);

    ScrollbarGlobalEQGain1.Position:=240-APlugin.Track.Global.EQ.Gain[0];
    ScrollbarGlobalEQGain1Scroll(ScrollbarGlobalEQGain1,ScrollbarGlobalEQGain1.Position);

    ScrollbarGlobalEQGain2.Position:=240-APlugin.Track.Global.EQ.Gain[1];
    ScrollbarGlobalEQGain2Scroll(ScrollbarGlobalEQGain2,ScrollbarGlobalEQGain2.Position);

    ScrollbarGlobalEQGain3.Position:=240-APlugin.Track.Global.EQ.Gain[2];
    ScrollbarGlobalEQGain3Scroll(ScrollbarGlobalEQGain3,ScrollbarGlobalEQGain3.Position);

    ScrollbarGlobalEQGain4.Position:=240-APlugin.Track.Global.EQ.Gain[3];
    ScrollbarGlobalEQGain4Scroll(ScrollbarGlobalEQGain4,ScrollbarGlobalEQGain4.Position);

    ScrollbarGlobalEQGain5.Position:=240-APlugin.Track.Global.EQ.Gain[4];
    ScrollbarGlobalEQGain5Scroll(ScrollbarGlobalEQGain5,ScrollbarGlobalEQGain5.Position);

    ScrollbarGlobalEQGain6.Position:=240-APlugin.Track.Global.EQ.Gain[5];
    ScrollbarGlobalEQGain6Scroll(ScrollbarGlobalEQGain6,ScrollbarGlobalEQGain6.Position);

    ScrollbarGlobalEQGain7.Position:=240-APlugin.Track.Global.EQ.Gain[6];
    ScrollbarGlobalEQGain7Scroll(ScrollbarGlobalEQGain7,ScrollbarGlobalEQGain7.Position);

    ScrollbarGlobalEQGain8.Position:=240-APlugin.Track.Global.EQ.Gain[7];
    ScrollbarGlobalEQGain8Scroll(ScrollbarGlobalEQGain8,ScrollbarGlobalEQGain8.Position);

    ScrollbarGlobalEQGain9.Position:=240-APlugin.Track.Global.EQ.Gain[8];
    ScrollbarGlobalEQGain9Scroll(ScrollbarGlobalEQGain9,ScrollbarGlobalEQGain9.Position);

    ScrollbarGlobalEQGain10.Position:=240-APlugin.Track.Global.EQ.Gain[9];
    ScrollbarGlobalEQGain10Scroll(ScrollbarGlobalEQGain10,ScrollbarGlobalEQGain10.Position);

    EditGlobalEQBandHz1.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[0]);
    EditGlobalEQBandHz2.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[1]);
    EditGlobalEQBandHz3.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[2]);
    EditGlobalEQBandHz4.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[3]);
    EditGlobalEQBandHz5.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[4]);
    EditGlobalEQBandHz6.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[5]);
    EditGlobalEQBandHz7.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[6]);
    EditGlobalEQBandHz8.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[7]);
    EditGlobalEQBandHz9.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[8]);
    EditGlobalEQBandHz10.Text:=inttostr(APlugin.Track.Global.EQ.BandHz[9]);

    // ---

    GlobalOrderUpdate;

    // ---

    ScrollBarGlobalsClockBPM.Position:=APlugin.Track.Global.Clock.BPM;
    ScrollBarGlobalsClockBPMScroll(self,ScrollBarGlobalsClockBPM.Position);

    ScrollBarGlobalsClockTPB.Position:=APlugin.Track.Global.Clock.TPB;
    ScrollBarGlobalsClockTPBScroll(self,ScrollBarGlobalsClockTPB.Position);

    // ---

    SGTK0ScrollBarGlobalsVoicesCount.Position:=APlugin.Track.Global.Voices.Count;
    SGTK0ScrollBarGlobalsVoicesCountScroll(self,SGTK0ScrollBarGlobalsVoicesCount.Position);

    // ---

    ComboBoxGlobalsFinalCompressorMode.ItemIndex:=APlugin.Track.Global.FinalCompressor.Mode;

    ScrollBarGlobalsFinalCompressorThreshold.Position:=APlugin.Track.Global.FinalCompressor.Threshold;
    ScrollBarGlobalsFinalCompressorThresholdScroll(self,ScrollBarGlobalsFinalCompressorThreshold.Position);

    ScrollBarGlobalsFinalCompressorRatio.Position:=APlugin.Track.Global.FinalCompressor.Ratio;
    ScrollBarGlobalsFinalCompressorRatioScroll(self,ScrollBarGlobalsFinalCompressorRatio.Position);

    ScrollBarGlobalsFinalCompressorWindow.Position:=APlugin.Track.Global.FinalCompressor.WindowSize;
    ScrollBarGlobalsFinalCompressorWindowScroll(self,ScrollBarGlobalsFinalCompressorWindow.Position);

    ScrollBarGlobalsFinalCompressorSoftHardKnee.Position:=APlugin.Track.Global.FinalCompressor.SoftHardKnee;
    ScrollBarGlobalsFinalCompressorSoftHardKneeScroll(self,ScrollBarGlobalsFinalCompressorSoftHardKnee.Position);

    ScrollBarGlobalsFinalCompressorAttack.Position:=APlugin.Track.Global.FinalCompressor.Attack;
    ScrollBarGlobalsFinalCompressorAttackScroll(self,ScrollBarGlobalsFinalCompressorAttack.Position);

    ScrollBarGlobalsFinalCompressorRelease.Position:=APlugin.Track.Global.FinalCompressor.Release;
    ScrollBarGlobalsFinalCompressorReleaseScroll(self,ScrollBarGlobalsFinalCompressorRelease.Position);

    ScrollBarGlobalsFinalCompressorOutGain.Position:=APlugin.Track.Global.FinalCompressor.OutGain;
    ScrollBarGlobalsFinalCompressorOutGainScroll(self,ScrollBarGlobalsFinalCompressorOutGain.Position);

    CheckBoxGlobalsFinalCompressorAutoGain.Checked:=APlugin.Track.Global.FinalCompressor.AutoGain;

    // --

    SGTK0ScrollbarOversample.Max:=DOWNSAMPLE_MAX;
    SGTK0ScrollbarOversample.Position:=APlugin.Track.Global.Oversample;
    SGTK0ScrollbarOversampleScroll(SGTK0ScrollbarOversample,SGTK0ScrollbarOversample.Position);

    SGTK0ScrollbarOversampleOrder.Position:=APlugin.Track.Global.OversampleOrder;
    SGTK0ScrollbarOversampleOrderScroll(SGTK0ScrollbarOversampleOrder,SGTK0ScrollbarOversampleOrder.Position);

    SGTK0CheckBoxFineOversample.Checked:=APlugin.Track.Global.FineOversample;
    
    SGTK0CheckBoxFineSincOversample.Checked:=APlugin.Track.Global.FineSincOversample;

    // --

    CheckBoxGlobalsClipping.Checked:=APlugin.Track.Global.Clipping;

    // --

    ScrollbarGlobalsRampingLen.Position:=APlugin.Track.Global.RampingLen;
    ScrollbarGlobalsRampingLenScroll(ScrollbarGlobalsRampingLen,APlugin.Track.Global.RampingLen);

    ComboBoxGlobalsRampingMode.ItemIndex:=APlugin.Track.Global.RampingMode;

    // --

    EditExportTrackName.Text:=APlugin.ExportTrackName;
    EditExportAuthor.Text:=APlugin.ExportAuthor;
    MemoExportComments.Text:=APlugin.ExportComments;

   end;

   Invalidate;
   RefreshTimer.Enabled:=true;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 InChange:=false;
end;

procedure TVSTiEditor.ButtonPreviousInstrumentClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   APlugin:=TVSTiPlugin(Plugin);
   DataCriticalSection.Enter;
   try
    APlugin.CurrentProgram:=(APlugin.CurrentProgram-1) and $7f;
   finally
    DataCriticalSection.Leave;
   end;
   APlugin.UpdateDisplay;
   OldPatchNr:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonNextInstrumentClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   APlugin:=TVSTiPlugin(Plugin);
   DataCriticalSection.Enter;
   try
    APlugin.CurrentProgram:=(APlugin.CurrentProgram+1) and $7f;
   finally
    DataCriticalSection.Leave;
   end;
   APlugin.UpdateDisplay;
   OldPatchNr:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentNameChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   APlugin:=TVSTiPlugin(Plugin);
   DataCriticalSection.Enter;
   try
    APlugin.ProgramNames[APlugin.CurrentProgram]:=EditInstrumentName.Text;
   finally
    DataCriticalSection.Leave;
   end;
   APlugin.UpdateDisplay;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentGlobalCarryClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Carry:=CheckBoxInstrumentGlobalCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentGlobalVolumeScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalVolume.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentGlobalVolume.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Volume:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentGlobalTransposeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentGlobalTranspose.Caption:=S;
 ScrollbarInstrumentGlobalTranspose.Track.Caption:=inttostr(ScrollPos)+' semitones';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Transpose:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentGlobalChannelVolumeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalChannelVolume.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentGlobalChannelVolume.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelVolume:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentGlobalMaxPolyphonyScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<2 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalMaxPolyphony.Caption:=S;         
 ScrollbarInstrumentGlobalMaxPolyphony.Track.Caption:=inttostr(ScrollPos)+' voices';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].MaxPolyphony:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentGlobalOutputScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalOutput.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentGlobalOutput.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalOutput:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentGlobalReverbScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalReverb.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentGlobalReverb.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalReverb:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentGlobalDelayScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalDelay.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci256))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentGlobalDelay.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalDelay:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentGlobalChorusFlangerScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentGlobalChorusFlanger.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentGlobalChorusFlanger.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].GlobalChorusFlanger:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.TabControlInstrumentVoiceOscillatorsTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.PageControlInstrumentVoiceTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.TabControlInstrumentVoiceEnvelopesTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
 EnvelopesUpdate;
end;

procedure TVSTiEditor.TabControlInstrumentVoiceLFOsTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.TabControlInstrumentVoiceFiltersTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.ScrollbarModulationMatrixItemsScroll(Sender: TObject;
  ScrollPos: integer);
begin
 if OldScrollBoxModulationMatrixItemsScrollPos<>ScrollPos then begin
  OldScrollBoxModulationMatrixItemsScrollPos:=ScrollPos;
  OldModulationMatrix:=-1;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorNoteBeginChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].NoteBegin:=ComboBoxInstrumentVoiceOscillatorNoteBegin.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorNoteEndChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].NoteEnd:=ComboBoxInstrumentVoiceOscillatorNoteEnd.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorWaveformChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Waveform:=ComboBoxInstrumentVoiceOscillatorWaveform.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
   OldOscTab:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorSynthesisTypeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SynthesisType:=ComboBoxInstrumentVoiceOscillatorSynthesisType.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorColorScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentVoiceOscillatorColor.Caption:=S;
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].WaveForm=wfSAMPLE then begin
    s:='Sample '+inttostr(ScrollPos+64);
   end else begin
    str(ScrollPos*100/64:1:2,s);
    s:=s+' %';
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarInstrumentVoiceOscillatorColor.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Color:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   if PanelInstrumentVoiceOscillatorSample.Visible then begin
    OldOscTab:=-1;
    EditorUpdate;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentVoiceOscillatorFeedbackScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<2 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorFeedBack.Caption:=S;
 str(ScrollBarInstrumentVoiceOscillatorFeedback.Position*fCI256*100:1:2,s);
 ScrollBarInstrumentVoiceOscillatorFeedback.Track.Caption:=s+' %';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].FeedBack:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorTransposeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentVoiceOscillatorTranspose.Caption:=S;
 ScrollBarInstrumentVoiceOscillatorTranspose.Track.Caption:=inttostr(ScrollPos)+' semitones';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Transpose:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorFinetuneScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentVoiceOscillatorFinetune.Caption:=S;
 ScrollBarInstrumentVoiceOscillatorFineTune.Track.Caption:=inttostr(ScrollPos)+' cents';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Finetune:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorPhaseStartScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorPhaseStart.Caption:=S;
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 str(ScrollPos*100*fci256:1:2,s);
 ScrollbarInstrumentVoiceOscillatorPhaseStart.Track.Caption:='+'+s+' %';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PhaseStart:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorVolumeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
    x:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorVolume.Caption:=S;
 x:=sqr(ScrollPos*fci255);
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(x)*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentVoiceOscillatorVolume.Track.Caption:=s+' dB';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Volume:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorGlideScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorGlide.Caption:=S;
 str(SoftTRUNC((POW(2,ScrollPos*fCI255)-1)*(1000*2{0.125})),s);
 ScrollbarInstrumentVoiceOscillatorGlide.Track.Caption:=s+' ms';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Glide:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceOscillatorHardsyncClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].HardSync:=CheckBoxInstrumentVoiceOscillatorHardsync.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceOscillatorCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Carry:=CheckBoxInstrumentVoiceOscillatorCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceADSRAttackChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esATTACK]:=ComboBoxInstrumentVoiceADSRAttack.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceADSRDecayChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esDECAY]:=ComboBoxInstrumentVoiceADSRDecay.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceADSRSustainChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esSustain]:=ComboBoxInstrumentVoiceADSRSustain.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceADSRReleaseChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Modes[esRelease]:=ComboBoxInstrumentVoiceADSRRelease.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.TabControlInstrumentVoiceADSRsTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.ScrollBarInstrumentVoiceADSRAttackScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceADSRAttack.Caption:=S;
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 str(SoftTRUNC(F_POWER(0.00005,1-(ScrollPos*fCI255))*2000000)*0.01:1:2,s);
 ScrollBarInstrumentVoiceADSRAttack.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esATTACK]:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentVoiceADSRDecayScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceADSRDecay.Caption:=S;
 str(SoftTRUNC(F_POWER(0.00005,1-(ScrollPos*fCI255))*2000000)*0.01:1:2,s);
 ScrollBarInstrumentVoiceADSRDecay.Track.Caption:=s+' ms';
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esDECAY]:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentVoiceADSRSustainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceADSRSustain.Caption:=S;
 str(SoftTRUNC(F_POWER(0.00005,1-(ScrollPos*fCI255))*2000000)*0.01:1:2,s);
 ScrollBarInstrumentVoiceADSRSustain.Track.Caption:=s+' ms';
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esSUSTAIN]:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentVoiceADSRReleaseScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceADSRRelease.Caption:=S;
 str(SoftTRUNC(F_POWER(0.00005,1-(ScrollPos*fCI255))*2000000)*0.01:1:2,s);
 ScrollBarInstrumentVoiceADSRRelease.Track.Caption:=s+' ms';
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Times[esRELEASE]:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceADSRAmplifyScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceADSRAmplify.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentVoiceADSRAmplify.Track.Caption:=s+' dB';
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Amplify:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceADSRDecayLevelScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceADSRDecayLevel.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;                        
 ScrollbarInstrumentVoiceADSRDecayLevel.Track.Caption:=s+' dB';
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].TargetDecayLevel:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceADSRActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Active:=CheckBoxInstrumentVoiceADSRActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceADSRActiveCheckClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].ActiveCheck:=CheckBoxInstrumentVoiceADSRActiveCheck.Checked;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceADSRCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Carry:=CheckBoxInstrumentVoiceADSRCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.PaintBoxADSRPaint(Sender: TObject);
begin
 DrawADSR;
end;

procedure TVSTiEditor.ButtonAddModulationMatrixItemClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    Value:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems<MaxModulationMatrixItems then begin
     inc(APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems);
     FILLCHAR(APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-1],sizeof(TSynthInstrumentModulationMatrixItem),#0);
     APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-1].Polarity:=mmpADD;
     APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-1].Amount:=64;
     Value:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-MaxVisibleModulationMatrixItems;
     if Value<0 then Value:=0;
     ScrollbarModulationMatrixItems.Max:=Value;
     ScrollbarModulationMatrixItems.Position:=ScrollbarModulationMatrixItems.Max;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   OldPatchNr:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.DeleteModulationMatrixItem(index:integer);
var APlugin:TVSTiPlugin;
    Value,Counter:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems>0 then begin
     for Counter:=index to MaxModulationMatrixItems-2 do begin
      APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Counter]:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Counter+1];
     end;
     dec(APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems);
     Value:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems-MaxVisibleModulationMatrixItems;
     if Value<0 then Value:=0;
     ScrollbarModulationMatrixItems.Max:=Value;
     if ScrollbarModulationMatrixItems.Position>Value then begin
      ScrollbarModulationMatrixItems.Position:=Value;
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   OldPatchNr:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.PageControlInstrumentTabChanged(Sender: TObject);
begin
 if assigned(AudioCriticalSection) then begin
  EditorUpdate;
  if PageControlInstrument.ActivePage=TabSheetInstrumentSamples then begin
  SamplesUpdate;
  try
   WaveEditor.ClearZoom;
   WaveEditor.Invalidate;
  except
  end;
  end else if PageControlInstrument.ActivePage=TabSheetInstrumentSpeech then begin
   SpeechTextsUpdate;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceEnvelopeActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceEnvelopes.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Active:=CheckBoxInstrumentVoiceEnvelopeActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceEnvelopeActiveCheckClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceEnvelopes.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].ActiveCheck:=CheckBoxInstrumentVoiceEnvelopeActiveCheck.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceEnvelopeCarryClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceEnvelopes.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Carry:=CheckBoxInstrumentVoiceEnvelopeCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceEnvelopeAmplifyScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceEnvelopeAmplify.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentVoiceEnvelopeAmplify.Track.Caption:=s+' dB';
 ItemNr:=TabControlInstrumentVoiceEnvelopes.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Amplify:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditEnvelopeNameChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.EnvelopeNames[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab]:=EditEnvelopeName.Text;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
 EnvelopesUpdate;
end;

procedure TVSTiEditor.ComboBoxEnvelopesChange(Sender: TObject);
begin
 EnvelopesUpdate;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceLFOWaveformChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Waveform:=ComboBoxInstrumentVoiceLFOWaveform.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceLFOSampleChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Sample:=ComboBoxInstrumentVoiceLFOSample.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceLFORateScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceLFORate.Caption:=S;
 str(POW(0.0001,(255-ScrollPos)*fci255)*100:1:4,s);
 s:=s+' Hz';
 ScrollbarInstrumentVoiceLFORate.Track.Caption:=s;
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Rate:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceLFODepthScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceLFODepth.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 s:=s+' %';
 ScrollbarInstrumentVoiceLFODepth.Track.Caption:=s;
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Depth:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceLFOMiddleScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentVoiceLFOMiddle.Caption:=S;
 str(ScrollPos*100*fci128:1:2,s);
 s:=s+' %';
 ScrollbarInstrumentVoiceLFOMiddle.Track.Caption:=s;
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Middle:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceLFOSweepScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceLFOSweep.Caption:=S;
 if ScrollPos=0 then begin
  s:='0';
 end else begin
  str(SoftTRUNC(POW(0.00005,1-(ScrollPos*fCI255))*(100000*20))/100:1:2,s);
 end;
 s:=s+' ms';
 ScrollbarInstrumentVoiceLFOSweep.Track.Caption:=s;
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Sweep:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentVoiceLFOPhaseStartScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceLFOPhaseStart.Caption:=S;
 str(ScrollPos*100*fci256:1:2,s);
 s:=s+' %';
 ScrollbarInstrumentVoiceLFOPhaseStart.Track.Caption:=s;
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].PhaseStart:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceLFOAmpClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Amp:=CheckBoxInstrumentVoiceLFOAmp.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceLFOCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].Carry:=CheckBoxInstrumentVoiceLFOCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorSampleChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if PanelInstrumentVoiceOscillatorSample.Visible and not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Color:=ComboBoxInstrumentVoiceOscillatorSample.ItemIndex-64;
   finally
    DataCriticalSection.Leave;
   end;
   OldOscTab:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceFilterModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,i,i1,i2:integer;
    S:string;
    f:double;
begin
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Mode:=ComboBoxInstrumentVoiceFilterMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  s:='Error!';
  ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    case APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Mode of
     fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
      str((sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz:1:2,s);
      s:=s+' Hz';
     end;
     fmFORMANT:begin
      f:=(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff*fci255)*4;
      i:=SoftTRUNC(f);
      f:=f-i;
      i2:=SoftTRUNC(f*100);
      i1:=100-i2;
      case i of
       0:begin
        s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
       end;
       1:begin
        s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
       end;
       2:begin
        s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
       end;
       3:begin
        s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
       end;
       4:begin
        s:='0% O - 100% U';
       end;
      end;
     end;
     else begin
      s:='-';
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  ScrollbarInstrumentVoiceFilterCutOff.Track.Caption:=s;
  if not InChange then begin
   ScrollbarInstrumentVoiceFilterCutOff.Track.Invalidate;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceFilterCutOffScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr,i,i1,i2:integer;
    S:string;
    f:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceFilterCutOff.Caption:=S;
 s:='Error!';
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   case APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Mode of
    fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
     str((sqr(ScrollPos*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz:1:2,s);
     s:=s+' Hz';
    end;
    fmFORMANT:begin
     f:=(ScrollPos*fci255)*4;
     i:=SoftTRUNC(f);
     f:=f-i;
     i2:=SoftTRUNC(f*100);
     i1:=100-i2;
     case i of
      0:begin
       s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
      end;
      1:begin
       s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
      end;
      2:begin
       s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
      end;
      3:begin
       s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
      end;
      4:begin
       s:='0% O - 100% U';
      end;
     end;
    end;
    else begin
     s:='-';
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarInstrumentVoiceFilterCutOff.Track.Caption:=s;
 if not InChange then begin
  ScrollbarInstrumentVoiceFilterCutOff.Track.Invalidate;
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceFilterResonanceScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceFilterResonance.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 ScrollbarInstrumentVoiceFilterResonance.Track.Caption:=s+' %';
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Resonance:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceFilterVolumeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceFilterVolume.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentVoiceFilterVolume.Track.Caption:=s+' dB';
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Volume:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceFilterAmplifyScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentVoiceFilterAmplify.Caption:=S;
 if ScrollPos=0 then begin
  s:='0.0';
 end else begin
  str(ln(POW(10,ScrollPos/40))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentVoiceFilterAmplify.Track.Caption:=s+' dB';
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Amplify:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceFilterCascadedClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Cascaded:=CheckBoxInstrumentVoiceFilterCascaded.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceFilterChainClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Chain:=CheckBoxInstrumentVoiceFilterChain.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceFilterCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Carry:=CheckBoxInstrumentVoiceFilterCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceDistortionModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlVoiceDistortion.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Mode:=ComboBoxInstrumentVoiceDistortionMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceDistortionGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlVoiceDistortion.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceDistortionGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentVoiceDistortionGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Gain:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceDistortionDistScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlVoiceDistortion.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceDistortionDist.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Dist:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceDistortionRateScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlVoiceDistortion.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceDistortionRate.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Rate:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceDistortionCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlVoiceDistortion.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceDistortion[ItemNr].Carry:=CheckBoxInstrumentVoiceDistortionCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentVoiceOrderMoveToUpClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,index,NA,NB:integer;
    BA,BB:boolean;
    TA,TB:string;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    index:=ListBoxInstrumentVoiceOrder.ItemIndex;
    APlugin:=TVSTiPlugin(Plugin);
    for ItemNr:=1 to ListBoxInstrumentVoiceOrder.Items.Count-1 do begin
     if ListBoxInstrumentVoiceOrder.Selected[ItemNr] then begin
      if (ItemNr=1) and ListBoxInstrumentVoiceOrder.Selected[ItemNr-1] then begin
       break;
      end;
      if ListBoxInstrumentVoiceOrder.ItemIndex=index then begin
       dec(index);
      end;
      BA:=ListBoxInstrumentVoiceOrder.Selected[ItemNr-1];
      BB:=ListBoxInstrumentVoiceOrder.Selected[ItemNr];
      TA:=ListBoxInstrumentVoiceOrder.Items[ItemNr-1];
      TB:=ListBoxInstrumentVoiceOrder.Items[ItemNr];
      ListBoxInstrumentVoiceOrder.Items[ItemNr-1]:=TB;
      ListBoxInstrumentVoiceOrder.Items[ItemNr]:=TA;
      NA:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr-1];
      NB:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr];
      APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr-1]:=NB;
      APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr]:=NA;
      ListBoxInstrumentVoiceOrder.Selected[ItemNr-1]:=BB;
      ListBoxInstrumentVoiceOrder.Selected[ItemNr]:=BA;
     end;
    end;
    ListBoxInstrumentVoiceOrder.ItemIndex:=index;
   finally
    AudioCriticalSection.Leave;
   end;
   VoiceOrderUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentVoiceOrderMoveToDownClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,index,NA,NB:integer;
    BA,BB:boolean;
    TA,TB:string;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    index:=ListBoxInstrumentVoiceOrder.ItemIndex;
    APlugin:=TVSTiPlugin(Plugin);
    for ItemNr:=ListBoxInstrumentVoiceOrder.Items.Count-2 downto 0 do begin
     if ListBoxInstrumentVoiceOrder.Selected[ItemNr] then begin
      if ((ItemNr+2)=ListBoxInstrumentVoiceOrder.Items.Count) and ListBoxInstrumentVoiceOrder.Selected[ItemNr+1] then begin
       break;
      end;
      if ListBoxInstrumentVoiceOrder.ItemIndex=index then begin
       inc(index);
      end;
      BA:=ListBoxInstrumentVoiceOrder.Selected[ItemNr];
      BB:=ListBoxInstrumentVoiceOrder.Selected[ItemNr+1];
      TA:=ListBoxInstrumentVoiceOrder.Items[ItemNr];
      TB:=ListBoxInstrumentVoiceOrder.Items[ItemNr+1];
      ListBoxInstrumentVoiceOrder.Items[ItemNr]:=TB;
      ListBoxInstrumentVoiceOrder.Items[ItemNr+1]:=TA;
      NA:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr];
      NB:=APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr+1];
      APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr]:=NB;
      APlugin.Track.Instruments[APlugin.CurrentProgram].VoiceOrder[ItemNr+1]:=NA;
      ListBoxInstrumentVoiceOrder.Selected[ItemNr]:=BB;
      ListBoxInstrumentVoiceOrder.Selected[ItemNr+1]:=BA;
     end;
    end;
    ListBoxInstrumentVoiceOrder.ItemIndex:=index;
   finally
    AudioCriticalSection.Leave;
   end;
   VoiceOrderUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentChannelDistortionModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelDistortion.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Mode:=ComboBoxInstrumentChannelDistortionMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollBarInstrumentChannelDistortionGainScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelDistortion.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDistortionGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelDistortionGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Gain:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDistortionDistScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelDistortion.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDistortionDist.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Dist:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDistortionRateScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelDistortion.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDistortionRate.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Rate:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelDistortionCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelDistortion.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDistortion[ItemNr].Carry:=CheckBoxInstrumentChannelDistortionCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentChannelFilterModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    S:string;
    f:double;
    i,i1,i2:integer;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Mode:=ComboBoxInstrumentChannelFilterMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
   s:='Error!';
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Mode of
      fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
       str((sqr(TVSTiPlugin(Plugin).Track.Instruments[TVSTiPlugin(Plugin).CurrentProgram].ChannelFilter[ItemNr].CutOff*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz:1:2,s);
       s:=s+' Hz';
      end;
      fmFORMANT:begin
       f:=(TVSTiPlugin(Plugin).Track.Instruments[TVSTiPlugin(Plugin).CurrentProgram].ChannelFilter[ItemNr].CutOff*fci255)*4;
       i:=SoftTRUNC(f);
       f:=f-i;
       i2:=SoftTRUNC(f*100);
       i1:=100-i2;
       case i of
        0:begin
         s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
        end;
        1:begin
         s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
        end;
        2:begin
         s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
        end;
        3:begin
         s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
        end;
        4:begin
         s:='0% O - 100% U';
        end;
       end;
      end;
      else begin
       s:='-';
      end;
     end;
    finally
     DataCriticalSection.Leave;
    end;
   end;
   ScrollbarInstrumentChannelFilterCutOff.Track.Caption:=s;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelFilterCutOffScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    f:double;
    i,i1,i2:integer;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelFilterCutOff.Caption:=S;
 s:='Error!';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Mode of
    fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
     str((sqr(ScrollPos*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz:1:2,s);
     s:=s+' Hz';
    end;
    fmFORMANT:begin
     f:=(ScrollPos*fci255)*4;
     i:=SoftTRUNC(f);
     f:=f-i;
     i2:=SoftTRUNC(f*100);
     i1:=100-i2;
     case i of
      0:begin
       s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
      end;
      1:begin
       s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
      end;
      2:begin
       s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
      end;
      3:begin
       s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
      end;
      4:begin
       s:='0% O - 100% U';
      end;
     end;
    end;
    else begin
     s:='-';
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarInstrumentChannelFilterCutOff.Track.Caption:=s;
 if not InChange then begin
  ScrollbarInstrumentChannelFilterCutOff.Track.Invalidate;
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].CutOff:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelFilterResonanceScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelFilterResonance.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 ScrollbarInstrumentChannelFilterResonance.Track.Caption:=s+' %';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Resonance:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelFilterVolumeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelFilterVolume.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelFilterVolume.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Volume:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelFilterAmplifyScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelFilterAmplify.Caption:=S;
 if ScrollPos=0 then begin
  s:='0.0';
 end else begin
  str(ln(POW(10,ScrollPos/40))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelFilterAmplify.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Amplify:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelFilterCascadedClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Cascaded:=CheckBoxInstrumentChannelFilterCascaded.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelFilterChainClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Chain:=CheckBoxInstrumentChannelFilterChain.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDelayWetScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDelayWet.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarInstrumentChannelDelayWet.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].Wet:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDelayDryScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDelayDry.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarInstrumentChannelDelayDry.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].Dry:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDelayTimeLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDelayTimeLeft.Caption:=S;
 s:='Error!';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].ClockSync then begin
    str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*ScrollPos,0,1000*DelayBufferSeconds):1:2,s);
    s:=s+' ms';
   end else begin
    str(Clip(sqr(ScrollPos*fCI255)*2000,0,2000):1:2,s);
    s:=s+' ms';
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarInstrumentChannelDelayTimeLeft.Track.Caption:=S;
 if not InChange then begin
  ScrollbarInstrumentChannelDelayTimeLeft.Track.Invalidate;
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].TimeLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDelayTimeRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelDelayTimeRight.Caption:=S;
 s:='Error!';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].ClockSync then begin
    str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*ScrollPos,0,1000*DelayBufferSeconds):1:2,s);
    s:=s+' ms';
   end else begin
    str(Clip(sqr(ScrollPos*fCI255)*2000,0,2000):1:2,s);
    s:=s+' ms';
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarInstrumentChannelDelayTimeRight.Track.Caption:=S;
 if not InChange then begin
  ScrollbarInstrumentChannelDelayTimeRight.Track.Invalidate;
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].TimeRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDelayFeedBackLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelDelayFeedBackLeft.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarInstrumentChannelDelayFeedBackLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].FeedBackLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelDelayFeedBackRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelDelayFeedBackRight.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarInstrumentChannelDelayFeedBackRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].FeedBackRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelDelayActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].Active:=CheckBoxInstrumentChannelDelayActive.Checked;
    SynthCheckDelayBuffers(@APlugin.Track);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerWetScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerWet.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarInstrumentChannelChorusFlangerWet.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Wet:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerDryScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerDry.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarInstrumentChannelChorusFlangerDry.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Dry:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerTimeLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerTimeLeft.Caption:=S;
 str(Clip(sqr(ScrollPos*fCI255)*1000,0,1000):1:2,s);
 s:=s+' ms';
 ScrollbarInstrumentChannelChorusFlangerTimeLeft.Track.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.TimeLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerTimeRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerTimeRight.Caption:=S;
 str(Clip(sqr(ScrollPos*fCI255)*1000,0,1000):1:2,s);
 s:=s+' ms';
 ScrollbarInstrumentChannelChorusFlangerTimeRight.Track.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.TimeRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerFeedBackLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelChorusFlangerFeedBackLeft.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarInstrumentChannelChorusFlangerFeedBackLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.FeedBackLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerFeedBackRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelChorusFlangerFeedBackRight.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarInstrumentChannelChorusFlangerFeedBackRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.FeedBackRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerLFORateLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerLFORateLeft.Caption:=S;
 str(POW(((ScrollPos*fci255)*0.99)+0.01,1.5)*100:1:2,s);
 s:=s+' Hz';
 ScrollbarInstrumentChannelChorusFlangerLFORateLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFORateLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerLFORateRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerLFORateRight.Caption:=S;
 str(POW(((ScrollPos*fci255)*0.99)+0.01,1.5)*100:1:2,s);
 s:=s+' Hz';
 ScrollbarInstrumentChannelChorusFlangerLFORateRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFORateRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerLFODepthLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerLFODepthLeft.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarInstrumentChannelChorusFlangerLFODepthLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFODepthLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerLFODepthRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerLFODepthRight.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarInstrumentChannelChorusFlangerLFODepthRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFODepthRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerLFOPhaseLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerLFOPhaseLeft.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 s:=s+' %';
 ScrollbarInstrumentChannelChorusFlangerLFOPhaseLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFOPhaseLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerLFOPhaseRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerLFOPhaseRight.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 s:=s+' %';
 ScrollbarInstrumentChannelChorusFlangerLFOPhaseRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.LFOPhaseRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelChorusFlangerActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Active:=CheckBoxInstrumentChannelChorusFlangerActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelChorusFlangerCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Carry:=CheckBoxInstrumentChannelChorusFlangerCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentChannelCompressorModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Mode:=ComboBoxInstrumentChannelCompressorMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorThresholdScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelCompressorThreshold.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci999))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelCompressorThreshold.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Threshold:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorRatioScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelCompressorRatio.Caption:=S;
 if ScrollPos=255 then begin
  ScrollbarInstrumentChannelCompressorRatio.Track.Caption:='Limit';
 end else begin
  str((ScrollPos*fCI17)+1:1:4,s);
  ScrollbarInstrumentChannelCompressorRatio.Track.Caption:=s+':1';
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Ratio:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorWindowScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelCompressorWindow.Caption:=S;
 str(100*sqr((ScrollPos*fCI999*0.99)+0.01):1:2,s);
 ScrollbarInstrumentChannelCompressorWindow.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.WindowSize:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorSoftHardKneeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelCompressorSoftHardKnee.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 ScrollbarInstrumentChannelCompressorSoftHardKnee.Track.Caption:=s+' %';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.SoftHardKnee:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorOutGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelCompressorOutGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='0.0';
 end else begin
  str(ln(POW(10,ScrollPos*fci999m4))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelCompressorOutGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.OutGain:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorAttackScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelCompressorAttack.Caption:=S;
 str(sqr((ScrollPos*fCI999*0.99)+0.01)*1000:1:2,s);
 ScrollbarInstrumentChannelCompressorAttack.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Attack:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelCompressorReleaseScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelCompressorRelease.Caption:=S;
 str(sqr((ScrollPos*fCI999*0.99)+0.01)*5000:1:2,s);
 ScrollbarInstrumentChannelCompressorRelease.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.Release:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelCompressorAutoGainClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.AutoGain:=CheckBoxInstrumentChannelCompressorAutoGain.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelSpeechActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Active:=CheckBoxInstrumentChannelSpeechActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechFrameLengthScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechFrameLength.Caption:=S;
 str(SoftTRUNC(((ScrollPos*1000)*0.001)+0.5):1,s);
 ScrollbarInstrumentChannelSpeechFrameLength.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.FrameLength:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.FrameLength:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechSpeedScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechSpeed.Caption:=S;
 ScrollbarInstrumentChannelSpeechSpeed.Track.Caption:=inttostr(ScrollPos)+' frames';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Speed:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.Speed:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechTextNumberScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechTextNumber.Caption:=S;
 ScrollbarInstrumentChannelSpeechTextNumber.Track.Caption:='Text nr. '+inttostr(ScrollPos);
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber:=ScrollPos;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentChannelOrderMoveToUpClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,index,NA,NB:integer;
    BA,BB:boolean;
    TA,TB:string;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    index:=ListBoxInstrumentChannelOrder.ItemIndex;
    APlugin:=TVSTiPlugin(Plugin);
    for ItemNr:=1 to ListBoxInstrumentChannelOrder.Items.Count-1 do begin
     if ListBoxInstrumentChannelOrder.Selected[ItemNr] then begin
      if (ItemNr=1) and ListBoxInstrumentChannelOrder.Selected[ItemNr-1] then begin
       break;
      end;
      if ListBoxInstrumentChannelOrder.ItemIndex=index then begin
       dec(index);
      end;
      BA:=ListBoxInstrumentChannelOrder.Selected[ItemNr-1];
      BB:=ListBoxInstrumentChannelOrder.Selected[ItemNr];
      TA:=ListBoxInstrumentChannelOrder.Items[ItemNr-1];
      TB:=ListBoxInstrumentChannelOrder.Items[ItemNr];
      ListBoxInstrumentChannelOrder.Items[ItemNr-1]:=TB;
      ListBoxInstrumentChannelOrder.Items[ItemNr]:=TA;
      NA:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr-1];
      NB:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr];
      APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr-1]:=NB;
      APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr]:=NA;
      ListBoxInstrumentChannelOrder.Selected[ItemNr-1]:=BB;
      ListBoxInstrumentChannelOrder.Selected[ItemNr]:=BA;
     end;
    end;
    ListBoxInstrumentChannelOrder.ItemIndex:=index;
   finally
    AudioCriticalSection.Leave;
   end;
   ChannelOrderUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentChannelOrderMoveToDownClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,index,NA,NB:integer;
    BA,BB:boolean;
    TA,TB:string;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    index:=ListBoxInstrumentChannelOrder.ItemIndex;
    APlugin:=TVSTiPlugin(Plugin);
    for ItemNr:=ListBoxInstrumentChannelOrder.Items.Count-2 downto 0 do begin
     if ListBoxInstrumentChannelOrder.Selected[ItemNr] then begin
      if ((ItemNr+2)=ListBoxInstrumentChannelOrder.Items.Count) and ListBoxInstrumentChannelOrder.Selected[ItemNr+1] then begin
       break;
      end;
      if ListBoxInstrumentChannelOrder.ItemIndex=index then begin
       inc(index);
      end;
      BA:=ListBoxInstrumentChannelOrder.Selected[ItemNr];
      BB:=ListBoxInstrumentChannelOrder.Selected[ItemNr+1];
      TA:=ListBoxInstrumentChannelOrder.Items[ItemNr];
      TB:=ListBoxInstrumentChannelOrder.Items[ItemNr+1];
      ListBoxInstrumentChannelOrder.Items[ItemNr]:=TB;
      ListBoxInstrumentChannelOrder.Items[ItemNr+1]:=TA;
      NA:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr];
      NB:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr+1];
      APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr]:=NB;
      APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelOrder[ItemNr+1]:=NA;
      ListBoxInstrumentChannelOrder.Selected[ItemNr]:=BB;
      ListBoxInstrumentChannelOrder.Selected[ItemNr+1]:=BA;
     end;
    end;
    ListBoxInstrumentChannelOrder.ItemIndex:=index;
   finally
    AudioCriticalSection.Leave;
   end;
   ChannelOrderUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonFreedrawnEnvelopeClearClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount:=0;
    APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].LoopStart:=-1;
    APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].LoopEnd:=-1;
    APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].SustainLoopStart:=-1;
    APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].SustainLoopEnd:=-1;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsReverbActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.Active:=CheckBoxGlobalsReverbActive.Checked;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbPreDelayScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbPreDelay.Caption:=S;
 str(sqr(ScrollPos*fCI255)*2000:1:2,s);
 ScrollbarGlobalsReverbPreDelay.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.PreDelay:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbCombFilterSeparationScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbCombFilterSeparation.Caption:=S;
 str(sqr(ScrollPos*fCI255)*2000:1:2,s);
 ScrollbarGlobalsReverbCombFilterSeparation.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.CombFilterSeparation:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbRoomSizeScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbRoomSize.Caption:=S;
 str(((sqr(ScrollPos*fCI255)*639)+1)*0.17:1:3,s);
 ScrollbarGlobalsReverbRoomSize.Track.Caption:=s+' meters';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.RoomSize:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbFeedBackScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbFeedBack.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsReverbFeedBack.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.FeedBack:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbAbsortionScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbAbsortion.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 ScrollbarGlobalsReverbAbsortion.Track.Caption:=s+' %';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.Absortion:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbDryScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbDry.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(ScrollPos*fCI255)*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsReverbDry.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.Dry:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbWetScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbWet.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(ScrollPos*fCI255)*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsReverbWet.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.Wet:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsReverbNumberOfAllPassFiltersScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsReverbNumberOfAllPassFilters.Caption:=S;
 ScrollbarGlobalsReverbNumberOfAllPassFilters.Track.Caption:=inttostr(ScrollPos)+' allpass filters';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Reverb.NumberOfAllPassFilters:=ScrollPos;
    APlugin.Track.GlobalData.Reverb.Ready:=false;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsDelayWetScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsDelayWet.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarGlobalsDelayWet.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.Wet:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsDelayDryScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsDelayDry.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarGlobalsDelayDry.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.Dry:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsDelayTimeLeftScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsDelayTimeLeft.Caption:=S;
 s:='Error!';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if APlugin.Track.Global.Delay.ClockSync then begin
    str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*ScrollPos,0,1000*DelayBufferSeconds):1:2,s);
    s:=s+' ms';
   end else begin
    str(Clip(sqr(ScrollPos*fCI255)*2000,0,2000):1:2,s);
    s:=s+' ms';
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarGlobalsDelayTimeLeft.Track.Caption:=S;
 if not InChange then begin
  ScrollbarGlobalsDelayTimeLeft.Track.Invalidate;
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.TimeLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsDelayTimeRightScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsDelayTimeRight.Caption:=S;
 s:='Error!';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if APlugin.Track.Global.Delay.ClockSync then begin
    str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*ScrollPos,0,1000*DelayBufferSeconds):1:2,s);
    s:=s+' ms';
   end else begin
    str(Clip(sqr(ScrollPos*fCI255)*2000,0,2000):1:2,s);
    s:=s+' ms';
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 ScrollbarGlobalsDelayTimeRight.Track.Caption:=S;
 if not InChange then begin
  ScrollbarGlobalsDelayTimeRight.Track.Invalidate;
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.TimeRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsDelayFeedBackLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalsDelayFeedBackLeft.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarGlobalsDelayFeedBackLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.FeedBackLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsDelayFeedBackRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalsDelayFeedBackRight.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarGlobalsDelayFeedBackRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.FeedBackRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsDelayActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.Active:=CheckBoxGlobalsDelayActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerWetScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerWet.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarGlobalsChorusFlangerWet.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.Wet:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerDryScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerDry.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarGlobalsChorusFlangerDry.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.Dry:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerTimeLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerTimeLeft.Caption:=S;
 str(Clip(sqr(ScrollPos*fci255)*1000,0,1000):1:2,s);
 s:=s+' ms';
 ScrollbarGlobalsChorusFlangerTimeLeft.Track.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.TimeLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerTimeRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerTimeRight.Caption:=S;
 str(Clip(sqr(ScrollPos*fci255)*1000,0,1000):1:2,s);
 s:=s+' ms';
 ScrollbarGlobalsChorusFlangerTimeRight.Track.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.TimeRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerFeedBackLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalsChorusFlangerFeedBackLeft.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarGlobalsChorusFlangerFeedBackLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.FeedBackLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerFeedBackRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalsChorusFlangerFeedBackRight.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB';
 end else if ScrollPos<0 then begin
  str(ln(-ScrollPos*fci128)*20/ln(10):1:2,s);
  s:=s+' dB (Inv)';
 end;
 ScrollbarGlobalsChorusFlangerFeedBackRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.FeedBackRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerLFORateLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerLFORateLeft.Caption:=S;
 str(POW(((ScrollPos*fci255)*0.99)+0.01,1.5)*100:1:2,s);
 s:=s+' Hz';
 ScrollbarGlobalsChorusFlangerLFORateLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.LFORateLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerLFORateRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerLFORateRight.Caption:=S;
 str(POW(((ScrollPos*fci255)*0.99)+0.01,1.5)*100:1:2,s);
 s:=s+' Hz';
 ScrollbarGlobalsChorusFlangerLFORateRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.LFORateRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerLFODepthLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerLFODepthLeft.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarGlobalsChorusFlangerLFODepthLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.LFODepthLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerLFODepthRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerLFODepthRight.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf dB';
 end else if ScrollPos>0 then begin
  str(ln(ScrollPos*fci255)*20/ln(10):1:2,s);
  s:=s+' dB';
 end;
 ScrollbarGlobalsChorusFlangerLFODepthRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.LFODepthRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerLFOPhaseLeftScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerLFOPhaseLeft.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 s:=s+' %';
 ScrollbarGlobalsChorusFlangerLFOPhaseLeft.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.LFOPhaseLeft:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerLFOPhaseRightScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerLFOPhaseRight.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 s:=s+' %';
 ScrollbarGlobalsChorusFlangerLFOPhaseRight.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.LFOPhaseRight:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsChorusFlangerActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.Active:=CheckBoxGlobalsChorusFlangerActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsChorusFlangerCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.Carry:=CheckBoxGlobalsChorusFlangerCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsEndFilterActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EndFilter.Active:=CheckBoxGlobalsEndFilterActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsEndFilterLowCutScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsEndFilterLowCut.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EndFilter.LowCut:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsEndFilterHighCutScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsEndFilterHighCut.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EndFilter.HighCut:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxGlobalsCompressorModeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.Mode:=ComboBoxGlobalsCompressorMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorThresholdScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsCompressorThreshold.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci999))*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsCompressorThreshold.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.Threshold:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorRatioScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsCompressorRatio.Caption:=S;
 LabelInstrumentChannelCompressorRatio.Caption:=S;
 if ScrollPos=255 then begin
  ScrollbarGlobalsCompressorRatio.Track.Caption:='Limit';
 end else begin
  str((ScrollPos*fCI17)+1:1:4,s);
  ScrollbarGlobalsCompressorRatio.Track.Caption:=s+':1';
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.Ratio:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorWindowScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsCompressorWindow.Caption:=S;
 str(100*sqr((ScrollPos*fCI999*0.99)+0.01):1:3,s);
 ScrollbarGlobalsCompressorWindow.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.WindowSize:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorSoftHardKneeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsCompressorSoftHardKnee.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 ScrollbarGlobalsCompressorSoftHardKnee.Track.Caption:=s+' %';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.SoftHardKnee:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorOutGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalsCompressorOutGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='0.0';
 end else begin
  str(ln(POW(10,ScrollPos*fci999m4))*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsCompressorOutGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.OutGain:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorAttackScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsCompressorAttack.Caption:=S;
 str(sqr((ScrollPos*fCI999*0.99)+0.01)*1000:1:2,s);
 ScrollbarGlobalsCompressorAttack.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.Attack:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsCompressorReleaseScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsCompressorRelease.Caption:=S;
 str(sqr((ScrollPos*fCI999*0.99)+0.01)*5000:1:2,s);
 ScrollbarGlobalsCompressorRelease.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.Release:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsCompressorAutoGainClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Compressor.AutoGain:=CheckBoxGlobalsCompressorAutoGain.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxGlobalsFinalCompressorModeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.Mode:=ComboBoxGlobalsFinalCompressorMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorThresholdScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsFinalCompressorThreshold.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci999))*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsFinalCompressorThreshold.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.Threshold:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorRatioScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsFinalCompressorRatio.Caption:=S;
 LabelInstrumentChannelCompressorRatio.Caption:=S;
 if ScrollPos=255 then begin
  ScrollbarGlobalsFinalCompressorRatio.Track.Caption:='Limit';
 end else begin
  str((ScrollPos*fCI17)+1:1:4,s);
  ScrollbarGlobalsFinalCompressorRatio.Track.Caption:=s+':1';
 end;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.Ratio:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorWindowScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsFinalCompressorWindow.Caption:=S;
 str(100*sqr((ScrollPos*fCI999*0.99)+0.01):1:3,s);
 ScrollbarGlobalsFinalCompressorWindow.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.WindowSize:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorSoftHardKneeScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsFinalCompressorSoftHardKnee.Caption:=S;
 str(ScrollPos*100*fci255:1:2,s);
 ScrollbarGlobalsFinalCompressorSoftHardKnee.Track.Caption:=s+' %';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.SoftHardKnee:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorOutGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalsFinalCompressorOutGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='0.0';
 end else begin
  str(ln(POW(10,ScrollPos*fci999m4))*20/ln(10):1:2,s);
 end;
 ScrollbarGlobalsFinalCompressorOutGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.OutGain:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorAttackScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsFinalCompressorAttack.Caption:=S;
 str(sqr((ScrollPos*fCI999*0.99)+0.01)*1000:1:2,s);
 ScrollbarGlobalsFinalCompressorAttack.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.Attack:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsFinalCompressorReleaseScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsFinalCompressorRelease.Caption:=S;
 str(sqr((ScrollPos*fCI999*0.99)+0.01)*5000:1:2,s);
 ScrollbarGlobalsFinalCompressorRelease.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.Release:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsFinalCompressorAutoGainClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FinalCompressor.AutoGain:=CheckBoxGlobalsFinalCompressorAutoGain.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.TimerSizeTimer(Sender: TObject);
begin
 TimerSize.Enabled:=false;
 ScrollBarGlobalsReverbNumberOfAllPassFilters.SetBounds(ScrollBarGlobalsReverbNumberOfAllPassFilters.Left,ScrollBarGlobalsReverbNumberOfAllPassFilters.Top,ScrollBarGlobalsReverbNumberOfAllPassFilters.Width,ScrollBarGlobalsReverbNumberOfAllPassFilters.Height);
 ScrollBarGlobalsReverbNumberOfAllPassFilters.Max:=13;
 ScrollBarGlobalsReverbNumberOfAllPassFilters.Max:=12;
end;

procedure TVSTiEditor.ComboBoxSpeechTextsChange(Sender: TObject);
begin
 SpeechTextsUpdate;
end;

procedure TVSTiEditor.EditSpeechTextNameChange(Sender: TObject);
var index:integer;
    APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  index:=ComboBoxSpeechTexts.ItemIndex;
  if (index>=0) and (index<MaxSpeechTexts) then begin
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     APlugin.SpeechTextNames[APlugin.CurrentProgram and $7f,index and $7f]:=EditSpeechTextName.Text;
    finally
     DataCriticalSection.Leave;
    end;
   end;
  end;
  SpeechTextsUpdate;
 end;
end;

procedure TVSTiEditor.MemoSpeechTextChange(Sender: TObject);
var index:integer;
    APlugin:TVSTiPlugin;
begin
 if not InChange then begin               
  index:=ComboBoxSpeechTexts.ItemIndex;
  if (index>=0) and (index<MaxSpeechTexts) then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     APlugin.SpeechTexts[APlugin.CurrentProgram and $7f,index and $7f]:=MemoSpeechText.Text;
     SynthSpeechConvertSpeechText(@APlugin.Track,APlugin.CurrentProgram and $7f,index and $7f,MemoSpeechText.Text);
     MemoSpeechTextPhonems.Text:=SpeechConvertTextToPhonems(MemoSpeechText.Text);
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
  SpeechTextsUpdate;
 end;
end;

procedure TVSTiEditor.ComboBoxSpeechConvertLanguageChange(Sender: TObject);
begin
 EditSpeechTextInputChange(Sender);
end;

procedure TVSTiEditor.ButtonFreedrawnEnvelopeInvertClick(Sender: TObject);
var i:integer;
    APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    for i:=0 to APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-1 do begin
     APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i].Value:=255-APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i].Value;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonFreedrawnEnvelopeReverseClick(Sender: TObject);
var i,j:integer;
    APlugin:TVSTiPlugin;
    a:TSynthEnvelope;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount>1 then begin
     a:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab];
     a.Nodes:=nil;
     SynthResizeEnvelope(@a,APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount*2);
     j:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-1].Time;
     for i:=0 to APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-1 do begin
      A.Nodes[APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-(i+1)]:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i];
     end;
     for i:=0 to APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-1 do begin
      a.Nodes[i].Time:=j-a.Nodes[i].Time;
     end;
     if a.LoopStart>=0 then begin
      a.LoopStart:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].LoopEnd+1);
     end;
     if a.LoopEnd>=0 then begin
      a.LoopEnd:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].LoopStart+1);
     end;
     if a.SustainLoopStart>=0 then begin
      a.SustainLoopStart:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].SustainLoopEnd+1);
     end;
     if a.SustainLoopEnd>=0 then begin
      a.SustainLoopEnd:=APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].SustainLoopStart+1);
     end;
     if assigned(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes) then begin
      FreeMemAligned(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes);
     end;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab]:=a;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonFreedrawnEnvelopeNormalizeClick(
  Sender: TObject);
var i,v,vmax:integer;
    APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount>0 then begin
     vmax:=abs(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[0].Value-128);
     for i:=0 to APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-1 do begin
      if vmax<abs(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i].Value-128) then begin
       vmax:=abs(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i].Value-128);
      end;
     end;
     if vmax>0 then begin
      for i:=0 to APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].NodesCount-1 do begin
       v:=(((APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i].Value-128)*128) div vmax)+128;
       if v<0 then begin
        v:=0;
       end else if v>255 then begin
        v:=255;
       end;
       APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Nodes[i].Value:=v;
      end;
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsClockBPMScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsClockBPM.Caption:=S;
 ScrollbarGlobalsClockBPM.Track.Caption:=inttostr(ScrollPos)+' BPM';
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Clock.BPM:=ScrollPos;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsClockTPBScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsClockTPB.Caption:=S;
 ScrollbarGlobalsClockTPB.Track.Caption:=inttostr(ScrollPos)+' ticks per beat';
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Clock.TPB:=ScrollPos;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsDelayClockSyncClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    s:string;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.ClockSync:=CheckBoxGlobalsDelayClockSync.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  s:='Error!';
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Global.Delay.ClockSync then begin
     str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*APlugin.Track.Global.Delay.TimeLeft,0,1000*DelayBufferSeconds):1:2,s);
     s:=s+' ms';
    end else begin
     str(Clip(sqr(APlugin.Track.Global.Delay.TimeLeft*fCI255)*2000,0,2000):1:2,s);
     s:=s+' ms';
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  ScrollbarGlobalsDelayTimeLeft.Track.Caption:=S;
  s:='Error!';
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Global.Delay.ClockSync then begin
     str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*APlugin.Track.Global.Delay.TimeRight,0,1000*DelayBufferSeconds):1:2,s);
     s:=s+' ms';
    end else begin
     str(Clip(sqr(APlugin.Track.Global.Delay.TimeRight*fCI255)*2000,0,2000):1:2,s);
     s:=s+' ms';
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  ScrollbarGlobalsDelayTimeRight.Track.Caption:=S;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelDelayClockSyncClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    s:string;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].ClockSync:=CheckBoxInstrumentChannelDelayClockSync.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  s:='Error!';
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].ClockSync then begin
     str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].TimeLeft,0,1000*DelayBufferSeconds):1:2,s);
     s:=s+' ms';
    end else begin
     str(Clip(sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].TimeLeft*fCI255)*2000,0,2000):1:2,s);
     s:=s+' ms';
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  ScrollbarInstrumentChannelDelayTimeLeft.Track.Caption:=S;
  if not InChange then begin
   ScrollbarInstrumentChannelDelayTimeLeft.Track.Invalidate;
  end;
  s:='Error!';
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].ClockSync then begin
     str(Clip(((60*1000)/(APlugin.Track.Global.Clock.BPM*APlugin.Track.Global.Clock.TPB))*APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].TimeRight,0,1000*DelayBufferSeconds):1:2,s);
     s:=s+' ms';
    end else begin
     str(Clip(sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].TimeRight*fCI255)*2000,0,2000):1:2,s);
     s:=s+' ms';
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  ScrollbarInstrumentChannelDelayTimeRight.Track.Caption:=S;
  if not InChange then begin
   ScrollbarInstrumentChannelDelayTimeRight.Track.Invalidate;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxSamplesChange(Sender: TObject);
begin
 SamplesUpdate;
end;

procedure TVSTiEditor.EditSampleNameChange(Sender: TObject);
var index:integer;
    APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  index:=ComboBoxSamples.ItemIndex;
  if (index>=0) and (index<MaxSamples) then begin
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     APlugin.SampleNames[APlugin.CurrentProgram and $7f,index and $7f]:=EditSampleName.Text;
    finally
     DataCriticalSection.Leave;
    end;
   end;
  end;
  SamplesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleZoomPlusClick(Sender: TObject);
begin
 try
  WaveEditor.ZoomIn;
  WaveEditor.Invalidate;
 except
 end;
end;

procedure TVSTiEditor.ButtonOscSampleZoomMinusClick(Sender: TObject);
begin
 try
  WaveEditor.ZoomOut;
  WaveEditor.Invalidate;
 except
 end;
end;

procedure TVSTiEditor.ButtonOscSampleResetZoomClick(Sender: TObject);
begin
 try
  WaveEditor.ClearZoom;
  WaveEditor.Invalidate;
 except
 end;
end;

procedure TVSTiEditor.ButtonLoadSampleClick(Sender: TObject);
var WAVFile:TBeRoFileStream;
begin
 OpenDialogWAV.Options:=OpenDialogWAV.Options-[ofAllowMultiSelect];
 if OpenDialogWAV.Execute then begin
  try
   WAVFile:=TBeRoFileStream.Create(OpenDialogWAV.FileName);
   LoadWAVSample(WAVFile,ComboBoxSamples.ItemIndex);
   WAVFile.Destroy;
  except
  end;
  SamplesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonSaveSampleClick(Sender: TObject);
var WAVFile:TBeRoFileStream;
begin
 if SaveDialogWAV.Execute then begin
  try
   WAVFile:=TBeRoFileStream.CreateNew(SaveDialogWAV.FileName);
   SaveWAVSample(WAVFile);
   WAVFile.Destroy;
  except
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarSamplesFineTuneScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    index:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<2 do begin
  S:='0'+S;
 end;
 LabelSamplesFineTune.Caption:=S;
 index:=ComboBoxSamples.ItemIndex;
 if (index>=0) and (index<MaxSamples) then begin
  if not InChange then begin
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     InterlockedExchange(longint(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.FineTune),longint(longword(ScrollPos shl 24)));
    finally
     DataCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleClearClick(Sender: TObject);
begin
 ClearSample(ComboBoxSamples.ItemIndex);
 SamplesUpdate;
end;

{$WARNINGS OFF}
procedure TVSTiEditor.ButtonOscSampleCopyClick(Sender: TObject);
var Bytes:longword;
    Von:longword;
    Zeiger:pbyte;
    APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      if WaveEditor.Markierung and not WaveEditor.MarkierungLinie then begin
       WaveClipboardChannels:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels;
       WaveClipboardBytes:=ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon)*sizeof(single)*WaveClipboardChannels;
       WaveClipboardRate:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate;
       REALLOCMEM(WaveClipboardPointer,WaveClipboardBytes);
       Von:=WaveEditor.MarkierungVon*sizeof(single)*WaveClipboardChannels;
       Bytes:=WaveClipboardBytes;
       Zeiger:=pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Von)));
       MOVE(Zeiger^,WaveClipboardPointer^,Bytes);
      end;                
     end;
    end;
    SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleCutClick(Sender: TObject);
var Bytes,Rest:longword;
    Von,Bis:longword;
    Zeiger:pbyte;
    APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      if WaveEditor.Markierung and not WaveEditor.MarkierungLinie then begin
       WaveClipboardChannels:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels;
       WaveClipboardBytes:=ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon)*sizeof(single)*WaveClipboardChannels;
       WaveClipboardRate:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate;
       REALLOCMEM(WaveClipboardPointer,WaveClipboardBytes);
       Von:=WaveEditor.MarkierungVon*sizeof(single)*WaveClipboardChannels;
       Bis:=WaveEditor.MarkierungBis*sizeof(single)*WaveClipboardChannels;
       Rest:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*sizeof(single)*WaveClipboardChannels)-Bis;
       Bytes:=WaveClipboardBytes;
       Zeiger:=pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Von)));
       MOVE(Zeiger^,WaveClipboardPointer^,Bytes);
       MOVE(pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Bis)))^,pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Von)))^,Rest);
       Rest:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*sizeof(single)*WaveClipboardChannels)-longword(ABS(Bis-Von));
       REALLOCMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data,Rest);
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-longword(ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
      end;
     end;
    end;
    SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
   finally
    AudioCriticalSection.Leave;
   end;
   SamplesUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSamplePasteClick(Sender: TObject);
var Bytes,Rest:longword;
    Von,Bis:longword;
    Zeiger:pbyte;
    Quelle:pointer;
    APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) and (WaveClipboardBytes>0) and assigned(WaveClipboardPointer) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) and (APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels=WaveClipboardChannels) then begin
      if not (WaveEditor.Markierung and WaveEditor.MarkierungLinie) then begin
       WaveEditor.Markierung:=true;
       WaveEditor.MarkierungLinie:=true;
       WaveEditor.MarkierungVon:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-1;
       WaveEditor.MarkierungBis:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-1;
      end;
      if WaveEditor.Markierung and WaveEditor.MarkierungLinie then begin
       Bytes:=WaveClipboardBytes;
       Von:=WaveEditor.MarkierungVon*sizeof(single)*WaveClipboardChannels;
       Bis:=Von+Bytes;
       Rest:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*sizeof(single)*WaveClipboardChannels)+Bytes;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples:=Rest div (sizeof(single)*WaveClipboardChannels);
       REALLOCMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data,Rest);
       Zeiger:=pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Von)));
       Rest:=Rest-Bytes-Von;
       if Rest>0 then begin
        MOVE(pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Von)))^,pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Bis)))^,Rest);
       end;
       Quelle:=WaveClipboardPointer;
       MOVE(Quelle^,Zeiger^,Bytes);
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample>=longword(WaveEditor.MarkierungVon) then begin
        inc(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample,Bytes div (sizeof(single)*WaveClipboardChannels));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample>=longword(WaveEditor.MarkierungVon) then begin
        inc(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample,Bytes div (sizeof(single)*WaveClipboardChannels));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample>=longword(WaveEditor.MarkierungVon) then begin
        inc(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample,Bytes div (sizeof(single)*WaveClipboardChannels));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample>=longword(WaveEditor.MarkierungVon) then begin
        inc(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample,Bytes div (sizeof(single)*WaveClipboardChannels));
       end;
      end;
     end else begin
      ClearSample(ComboBoxSamples.ItemIndex);
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples:=WaveClipboardBytes div (sizeof(single)*WaveClipboardChannels);
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels:=WaveClipboardChannels;
      Rest:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*(sizeof(single)*WaveClipboardChannels));
      GETMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data,Rest);
      Zeiger:=pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data))));
      MOVE(WaveClipboardPointer^,Zeiger^,WaveClipboardBytes);
      WaveEditor.Markierung:=true;
      WaveEditor.MarkierungLinie:=true;
      WaveEditor.MarkierungVon:=0;
      WaveEditor.MarkierungBis:=0;
     end;
    end;
    SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
   finally
    AudioCriticalSection.Leave;
   end;
   SamplesUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleDelClick(Sender: TObject);
var Rest:longword;
    Von,Bis,Channels:longword;
    APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      Channels:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels;
      if WaveEditor.Markierung and not WaveEditor.MarkierungLinie then begin
       Von:=WaveEditor.MarkierungVon*sizeof(single)*Channels;
       Bis:=WaveEditor.MarkierungBis*sizeof(single)*Channels;
       Rest:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*sizeof(single)*Channels)-Bis;
       MOVE(pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Bis)))^,pbyte(pointer(longword(longword(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)+Von)))^,Rest);
       Rest:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*sizeof(single)*Channels)-longword(ABS(Bis-Von));
       REALLOCMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data,Rest);
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-longword(ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample>=longword(WaveEditor.MarkierungVon) then begin
        dec(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample,ABS(WaveEditor.MarkierungBis-WaveEditor.MarkierungVon));
       end;
      end;
     end;
    end;
    SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
   finally
    AudioCriticalSection.Leave;
   end;
   OldOscTab:=-1;
   SamplesUpdate;
  end;
 end;
end;
{$WARNINGS ON}

procedure TVSTiEditor.ButtonOscSampleSetLoopClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      if WaveEditor.Markierung and not WaveEditor.MarkierungLinie then begin
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode=slNONE then begin
        APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode:=slFORWARD;
       end;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample:=WaveEditor.MarkierungVon;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample:=WaveEditor.MarkierungBis;
      end;
     end;
     ComboBoxSamplesLoopMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode;
     EditSamplesLoopStart.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample);
     EditSamplesLoopEnd.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample);
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleDelLoopClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode:=slNONE;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample:=0;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample:=0;
     ComboBoxSamplesLoopMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode;
     EditSamplesLoopStart.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample);
     EditSamplesLoopEnd.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample);
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleSetSustainLoopClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      if WaveEditor.Markierung and not WaveEditor.MarkierungLinie then begin
       if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode=slNONE then begin
        APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode:=slFORWARD;
       end;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample:=WaveEditor.MarkierungVon;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample:=WaveEditor.MarkierungBis;
      end;
     end;
     ComboBoxSamplesSustainLoopMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode;
     EditSamplesSustainLoopStart.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample);
     EditSamplesSustainLoopEnd.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample);
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleDelSustainLoopClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode:=slNONE;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample:=0;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample:=0;
     ComboBoxSamplesSustainLoopMode.ItemIndex:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode;
     EditSamplesSustainLoopStart.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample);
     EditSamplesSustainLoopEnd.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample);
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonOscSampleFixLoopsClick(Sender: TObject);
const SampleLoopAccuracy=0.05;
      PingPongLoopAccuracy=0.05;
var APlugin:TVSTiPlugin;
    index:integer;
    ScanDataPointer:pointer;
    LW32:longword;
    L32:longint absolute LW32;
    Laenge:integer;
 function CheckLoopSamples(const Start1,Start2,End1,End2:single):boolean;
 var Delta1,Delta2,DeltaStart,DeltaEnd:single;
 begin
  Delta1:=End1-Start1;
  Delta2:=End2-Start2;
  result:=(ABS(Delta1)<=SampleLoopAccuracy) and (ABS(Delta2)<=SampleLoopAccuracy);
  if result then begin
   DeltaStart:=Start2-Start1;
   DeltaEnd:=End2-End1;
   if DeltaStart=0 then DeltaStart:=DeltaEnd/128;
   if DeltaEnd=0 then DeltaEnd:=DeltaStart/128;
   result:=(ABS(DeltaEnd-DeltaStart)<=SampleLoopAccuracy) and not (((DeltaStart<=0) and (DeltaEnd>=0)) or ((DeltaStart>=0) and (DeltaEnd<=0)));
  end;
 end;
 function CheckPingPongLoopSamples(const Sample1,Sample2,Sample3:single):boolean;
 var Delta1,Delta2,Delta3:single;
 begin
  Delta1:=Sample2-Sample1;
  Delta2:=Sample3-Sample2;
  Delta3:=Sample3-Sample1;
  if Delta1=0 then Delta1:=Delta2/128;
  if Delta2=0 then Delta2:=Delta1/128;
  result:=(((Delta1>=-1) and (Delta1<=0) and (Delta2>-1) and (Delta2<=0) and (Delta3>=-1) and (Delta3<=0))) and not (((Delta1<=0) and (Delta2>=0)) or ((Delta1>=0) and (Delta2<=0)));
 end;
 procedure CheckLoop(LoopType:byte;var LoopStart,LoopEnd:integer);
 var Samples:PSINGLES;
     StereoSamples:PSynthBufferSamples;
     Position:integer;
     OldLoopStart,OldLoopEnd:longword;
     Found:boolean;
 begin
  Samples:=ScanDataPointer;
  StereoSamples:=pointer(Samples);
  OldLoopStart:=LoopStart;
  OldLoopEnd:=LoopEnd;
  case APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels of
   1:begin
    case LoopType of
     slPINGPONG:begin
      Found:=false;
      for Position:=OldLoopStart to (OldLoopEnd-16) do begin
       if CheckPingPongLoopSamples(Samples^[Position],Samples^[Position+1],Samples^[Position+2]) then begin
        LoopStart:=Position;
        Found:=true;
        break;
       end;
      end;
      if not Found then begin
       for Position:=OldLoopStart-1 downto 0 do begin
        if CheckPingPongLoopSamples(Samples^[Position],Samples^[Position+1],Samples^[Position+2]) then begin
         LoopStart:=Position;
  //     Found:=TRUE;
         break;
        end;
       end;
      end;
      Found:=false;
      for Position:=OldLoopEnd to Laenge-1 do begin
       if CheckPingPongLoopSamples(Samples^[Position],Samples^[Position+1],Samples^[Position+2]) then begin
        LoopEnd:=Position;
        Found:=true;
        break;
       end;
      end;
      if not Found then begin
       for Position:=OldLoopEnd downto OldLoopStart+16 do begin
        if CheckPingPongLoopSamples(Samples^[Position],Samples^[Position+1],Samples^[Position+2]) then begin
         LoopEnd:=Position;
  //     Found:=TRUE;
         break;
        end;
       end;
      end;
     end;
     slFORWARD,slBACKWARD:begin
      Found:=false;
      while not Found do begin
       for Position:=OldLoopEnd to Laenge-1 do begin
        if CheckLoopSamples(Samples^[OldLoopStart],Samples^[OldLoopStart+1],Samples^[Position],Samples^[Position+1]) then begin
         LoopEnd:=Position;
         Found:=true;
         break;
        end;
       end;
       if not Found then begin
        for Position:=OldLoopEnd downto OldLoopStart+16 do begin
         if CheckLoopSamples(Samples^[OldLoopStart],Samples^[OldLoopStart+1],Samples^[Position],Samples^[Position+1]) then begin
          LoopEnd:=Position;
          Found:=true;
          break;
         end;
        end;
       end;
       if Found then break;
       if OldLoopStart=0 then break;
       dec(OldLoopStart);
      end;
     end;
    end;
   end;
   2:begin
    case LoopType of
     slPINGPONG:begin
      Found:=false;
      for Position:=OldLoopStart to (OldLoopEnd-16) do begin
       if CheckPingPongLoopSamples(StereoSamples^[Position].Left,StereoSamples^[Position+1].Left,StereoSamples^[Position+2].Left) and
          CheckPingPongLoopSamples(StereoSamples^[Position].Right,StereoSamples^[Position+1].Right,StereoSamples^[Position+2].Right) then begin
        LoopStart:=Position;
        Found:=true;
        break;
       end;
      end;
      if not Found then begin
       for Position:=OldLoopStart-1 downto 0 do begin
        if CheckPingPongLoopSamples(StereoSamples^[Position].Left,StereoSamples^[Position+1].Left,StereoSamples^[Position+2].Left) and
           CheckPingPongLoopSamples(StereoSamples^[Position].Right,StereoSamples^[Position+1].Right,StereoSamples^[Position+2].Right) then begin
         LoopStart:=Position;
  //     Found:=TRUE;
         break;
        end;
       end;
      end;
      Found:=false;
      for Position:=OldLoopEnd to Laenge-1 do begin
       if CheckPingPongLoopSamples(StereoSamples^[Position].Left,StereoSamples^[Position+1].Left,StereoSamples^[Position+2].Left) and
          CheckPingPongLoopSamples(StereoSamples^[Position].Right,StereoSamples^[Position+1].Right,StereoSamples^[Position+2].Right) then begin
        LoopEnd:=Position;
        Found:=true;
        break;
       end;
      end;
      if not Found then begin
       for Position:=OldLoopEnd downto OldLoopStart+16 do begin
        if CheckPingPongLoopSamples(StereoSamples^[Position].Left,StereoSamples^[Position+1].Left,StereoSamples^[Position+2].Left) and
           CheckPingPongLoopSamples(StereoSamples^[Position].Right,StereoSamples^[Position+1].Right,StereoSamples^[Position+2].Right) then begin
         LoopEnd:=Position;
  //     Found:=TRUE;
         break;
        end;
       end;
      end;
     end;
     slFORWARD,slBACKWARD:begin
      Found:=false;
      while not Found do begin
       for Position:=OldLoopEnd to Laenge-1 do begin
        if CheckLoopSamples(StereoSamples^[OldLoopStart].Left,StereoSamples^[OldLoopStart+1].Left,StereoSamples^[Position].Left,StereoSamples^[Position+1].Left) and
           CheckLoopSamples(StereoSamples^[OldLoopStart].Right,StereoSamples^[OldLoopStart+1].Right,StereoSamples^[Position].Right,StereoSamples^[Position+1].Right) then begin
         LoopEnd:=Position;
         Found:=true;
         break;
        end;
       end;
       if not Found then begin
        for Position:=OldLoopEnd downto OldLoopStart+16 do begin
         if CheckLoopSamples(StereoSamples^[OldLoopStart].Left,StereoSamples^[OldLoopStart+1].Left,StereoSamples^[Position].Left,StereoSamples^[Position+1].Left) and
            CheckLoopSamples(StereoSamples^[OldLoopStart].Right,StereoSamples^[OldLoopStart+1].Right,StereoSamples^[Position].Right,StereoSamples^[Position+1].Right) then begin
          LoopEnd:=Position;
          Found:=true;
          break;
         end;
        end;
       end;
       if Found then break;
       if OldLoopStart=0 then break;
       dec(OldLoopStart);
      end;
     end;
    end;
   end;
  end;
{ IF Found THEN BEGIN
  END;}
 end;
begin
 if assigned(AudioCriticalSection) and not InChange then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   index:=ComboBoxSamples.ItemIndex;
   if (index>=0) and (index<MaxSamples) then begin
    Laenge:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples;
    if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
     ScanDataPointer:=@PSINGLES(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[0];
     CheckLoop(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample);
     CheckLoop(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample);
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   end;
  finally
   AudioCriticalSection.Leave;
  end;
  SamplesUpdate;
 end;
end;

procedure TVSTiEditor.ComboBoxSamplesLoopModeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode:=ComboBoxSamplesLoopMode.ItemIndex;
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxSamplesSustainLoopModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode:=ComboBoxSamplesSustainLoopMode.ItemIndex;
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesLoopStartChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,v,c:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     val(EditSamplesLoopStart.Text,v,c);
     if c=0 then begin
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample:=v;
     end;
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesLoopEndChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,v,c:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     val(EditSamplesLoopEnd.Text,v,c);
     if c=0 then begin
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample:=v;
     end;
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesSustainLoopStartChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,v,c:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     val(EditSamplesSustainLoopStart.Text,v,c);
     if c=0 then begin
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample:=v;
     end;
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesSustainLoopEndChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,v,c:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     val(EditSamplesSustainLoopEnd.Text,v,c);
     if c=0 then begin
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample:=v;
     end;
     WaveEditor.Loop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE;
     WaveEditor.SchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
     WaveEditor.SchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
     WaveEditor.SustainLoop:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE;
     WaveEditor.SustainSchleifeStart:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
     WaveEditor.SustainSchleifeEnde:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
     WaveEditor.Invalidate;
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesSampleRateChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,v,c:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     val(EditSamplesSampleRate.Text,v,c);
     if c=0 then begin
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate:=v;
     end;
    end;
   finally
    DataCriticalSection.Enter;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPhaseSamplesChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,v,c:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     val(EditSamplesPhaseSamples.Text,v,c);
     if c=0 then begin
      APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.PhaseSamples:=v;
     end;
    end;
   finally
    DataCriticalSection.Enter;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxSamplesNoteChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note:=ComboBoxSamplesNote.ItemIndex;
    end;
   finally
    DataCriticalSection.Enter;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonSamplesClearClick(Sender: TObject);
begin
 ClearSample(ComboBoxSamples.ItemIndex);
 SamplesUpdate;
end;

procedure TVSTiEditor.ButtonSamplesPhaseSamplesCalcClick(Sender: TObject);
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    CalculatePhaseSamples;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  SamplesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonSamplesInvertClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,i:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      for i:=0 to (APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels)-1 do begin
       psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i]:=-psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i];
      end;
      SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   SamplesUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonSamplesReverseClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,i,a,b:integer;
    v:single;
    s:TSynthBufferSample;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
      case APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels of
       1:begin
        for i:=0 to (APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples shr 1)-1 do begin
         v:=psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i];
         psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i]:=psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-(i+1)];
         psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-(i+1)]:=v;
        end;
       end;
       2:begin
        for i:=0 to (APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples shr 1)-1 do begin
         s:=PSynthBufferSamples(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i];
         PSynthBufferSamples(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i]:=PSynthBufferSamples(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-(i+1)];
         PSynthBufferSamples(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-(i+1)]:=s;
        end;
       end;
      end;
      if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode<>slNONE then begin
       a:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-1)-APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample;
       b:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-1)-APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample:=b;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample:=a;
      end;
      if APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode<>slNONE then begin
       a:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-1)-APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample;
       b:=(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples-1)-APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample:=b;
       APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample:=a;
      end;
      SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   SamplesUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonSamplesNormalizeClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index,i:integer;
    v,vmax:single;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
      vmax:=0;
      for i:=0 to (APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels)-1 do begin
       v:=psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i+SampleFixup];
       if abs(v)>vmax then begin
        vmax:=abs(v);
       end;
      end;
      if abs(vmax)>1e-12 then begin
       vmax:=1/vmax;
       for i:=0 to (APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples*APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels)-1 do begin
        v:=psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i+SampleFixup];
        v:=v*vmax;
        if v<-1 then begin
         v:=-1;
        end else if v>1 then begin
         v:=1;
        end;
        psingles(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data)^[i+SampleFixup]:=v;
       end;
      end;
      SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   SamplesUpdate;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxSamplesRandomStartPositionClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.RandomStartPosition:=CheckBoxSamplesRandomStartPosition.Checked;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxSamplesPadSynthActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Active:=CheckBoxSamplesPadSynthActive.Checked;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxSamplesPadSynthExtendedClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.ExtendedAlgorithm:=CheckBoxSamplesPadSynthExtended.Checked;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthWaveTableSizeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize:=NextOfPowerTwo(strtointdef(EditSamplesPadSynthWaveTableSize.Text,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize));
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthSampleRateChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.SampleRate:=BeRoUtils.strtoint(EditSamplesPadSynthSampleRate.Text);
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthFrequencyChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Frequency:=BeRoUtils.strtofloat(EditSamplesPadSynthFrequency.Text);
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthBandwidthChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Bandwidth:=BeRoUtils.strtofloat(EditSamplesPadSynthBandwidth.Text);
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthBandwidthScaleChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.BandwidthScale:=BeRoUtils.strtofloat(EditSamplesPadSynthBandwidthScale.Text);
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthNumberOfHarmonicsChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.NumHarmonics:=BeRoUtils.strtoint(EditSamplesPadSynthNumberOfHarmonics.Text);
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxSamplesPadSynthProfileChange(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Profile:=ComboBoxSamplesPadSynthProfile.ItemIndex;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

function fpowex:single; assembler; register; {$IFDEF FPC}NOSTACKFRAME;{$ENDIF}
asm
 fyl2x
 fld1
 fld st(1)
 fprem
 f2xm1
 faddp st(1),st
 fscale
 fstp st(1)
end;

function fpow(Number,Exponent:single):single; assembler; stdcall;
asm
 fld dword ptr Exponent
 fld dword ptr Number
 call fpowex
end;

const CurrentSample:PSynthSample=nil;

procedure TVSTiEditor.CheckBoxInstrumentVoiceOscillatorPMFMExtendedModeClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PMFMExtendedMode:=CheckBoxInstrumentVoiceOscillatorPMFMExtendedMode.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceEnvelopeCenteriseClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceEnvelopes.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Envelope[ItemNr].Centerise:=CheckBoxInstrumentVoiceEnvelopeCenterise.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceADSRCenteriseClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceADSRs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ADSR[ItemNr].Centerise:=CheckBoxInstrumentVoiceADSRCenterise.Checked;
   finally
    DataCriticalSection.Leave;
   end;
   DrawADSR;
  end;
 end;
end;

procedure TVSTiEditor.TabSheetSamplesShow(Sender: TObject);
begin
 SamplesUpdate;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelPitchShifterActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelPitchShifter.Active:=CheckBoxInstrumentChannelPitchShifterActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelPitchShifterTuneScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelPitchShifterTune.Caption:=S;
 ScrollbarInstrumentChannelPitchShifterTune.Track.Caption:=inttostr(ScrollPos)+' semitones';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelPitchShifter.Tune:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelPitchShifterFineTuneScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentChannelPitchShifterFineTune.Caption:=S;
 ScrollbarInstrumentChannelPitchShifterFineTune.Track.Caption:=inttostr(ScrollPos)+' cents';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelPitchShifter.FineTune:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalPitchShifterActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.PitchShifter.Active:=CheckBoxGlobalPitchShifterActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalPitchShifterTuneScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalPitchShifterTune.Caption:=S;
 ScrollbarGlobalPitchShifterTune.Track.Caption:=inttostr(ScrollPos)+' semitones';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.PitchShifter.Tune:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalPitchShifterFineTuneScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelGlobalPitchShifterFineTune.Caption:=S;
 ScrollbarGlobalPitchShifterFineTune.Track.Caption:=inttostr(ScrollPos)+' cents';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.PitchShifter.FineTune:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechColorScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechColor.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Color:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.Color:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechNoiseGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechNoiseGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelSpeechNoiseGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.NoiseGain:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.NoiseGain:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechGain.Caption:=S;
 str(-(255-ScrollPos):1,s);
 ScrollbarInstrumentChannelSpeechGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.Gain:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.Gain:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelSpeechF4Change(Sender: TObject);
var APlugin:TVSTiPlugin;
    Counter:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.F4:=BeRoUtils.strtoint(EditInstrumentChannelSpeechF4.Text);
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.F4:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.F4;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelSpeechF5Change(Sender: TObject);
var APlugin:TVSTiPlugin;
    Counter:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.f5:=BeRoUtils.strtoint(EditInstrumentChannelSpeechf5.Text);
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.f5:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.f5;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelSpeechF6Change(Sender: TObject);
var APlugin:TVSTiPlugin;
    Counter:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.f6:=BeRoUtils.strtoint(EditInstrumentChannelSpeechf6.Text);
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.f6:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.f6;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelSpeechB4Change(Sender: TObject);
var APlugin:TVSTiPlugin;
    Counter:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.b4:=BeRoUtils.strtoint(EditInstrumentChannelSpeechb4.Text);
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.b4:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.b4;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelSpeechB5Change(Sender: TObject);
var APlugin:TVSTiPlugin;
    Counter:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.b5:=BeRoUtils.strtoint(EditInstrumentChannelSpeechb5.Text);
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.b5:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.b5;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelSpeechB6Change(Sender: TObject);
var APlugin:TVSTiPlugin;
    Counter:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.b6:=BeRoUtils.strtoint(EditInstrumentChannelSpeechb6.Text);
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.b6:=APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.b6;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentChannelEQModeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode:=ComboBoxInstrumentChannelEQMode.ItemIndex;
    case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
     eqm6db:begin
      Label63.Caption:='6';
      Label64.Caption:='-6';
      Label68.Caption:='6';
      Label66.Caption:='-6';
     end;
     eqm12db:begin
      Label63.Caption:='12';
      Label64.Caption:='-12';
      Label68.Caption:='12';
      Label66.Caption:='-12';
     end;
     else begin
      Label63.Caption:='24';
      Label64.Caption:='-24';
      Label68.Caption:='24';
      Label66.Caption:='-24';
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
   OldPatchNr:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelEQActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Active:=CheckBoxInstrumentChannelEQActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain1Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[0]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain1.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain2Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[1]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain2.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain3Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[2]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain3.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain4Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[3]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain4.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain5Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[4]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain5.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain6Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[5]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain6.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain7Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[6]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain7.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain8Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[7]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain8.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain9Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[8]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain9.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQGain10Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[9]:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelInstrumentChannelEQGain10.Caption:=S;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz1Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[0]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz1.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz2Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[1]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz2.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz3Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[2]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz3.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz4Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[3]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz4.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz5Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[4]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz5.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz6Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[5]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz6.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz7Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[6]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz7.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz8Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[7]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz8.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz9Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[8]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz9.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQBandHz10Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[9]:=BeRoUtils.strtoint(EditInstrumentChannelEQBandHz10.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentChannelEQResetClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    SynthInitEQ(@APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ);
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  OldPatchNr:=-1;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.ComboBoxGlobalEQModeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.Mode:=ComboBoxGlobalEQMode.ItemIndex;
    case APlugin.Track.Global.EQ.Mode of
     eqm6db:begin
      Label69.Caption:='6';
      Label70.Caption:='-6';
      Label74.Caption:='6';
      Label72.Caption:='-6';
     end;
     eqm12db:begin
      Label69.Caption:='12';
      Label70.Caption:='-12';
      Label74.Caption:='12';
      Label72.Caption:='-12';
     end;
     else begin
      Label69.Caption:='24';
      Label70.Caption:='-24';
      Label74.Caption:='24';
      Label72.Caption:='-24';
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
   OldPatchNr:=-1;
   BankWasChanged:=true;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalEQActiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.Active:=CheckBoxGlobalEQActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain1Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[0]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain1.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain2Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[1]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain2.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain3Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[2]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain3.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain4Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[3]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain4.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain5Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[4]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain5.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain6Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[5]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain6.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain7Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[6]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain7.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain8Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[7]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain8.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain9Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[8]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain9.Caption:=S;
end;

procedure TVSTiEditor.ScrollbarGlobalEQGain10Scroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 ScrollPos:=240-ScrollPos;
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.Gain[9]:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 PanelGlobalEQGain10.Caption:=S;
end;

procedure TVSTiEditor.EditGlobalEQBandHz1Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[0]:=BeRoUtils.strtoint(EditGlobalEQBandHz1.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz2Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[1]:=BeRoUtils.strtoint(EditGlobalEQBandHz2.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;
    
procedure TVSTiEditor.EditGlobalEQBandHz3Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[2]:=BeRoUtils.strtoint(EditGlobalEQBandHz3.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz4Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[3]:=BeRoUtils.strtoint(EditGlobalEQBandHz4.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz5Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[4]:=BeRoUtils.strtoint(EditGlobalEQBandHz5.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz6Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[5]:=BeRoUtils.strtoint(EditGlobalEQBandHz6.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz7Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[6]:=BeRoUtils.strtoint(EditGlobalEQBandHz7.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz8Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[7]:=BeRoUtils.strtoint(EditGlobalEQBandHz8.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz9Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[8]:=BeRoUtils.strtoint(EditGlobalEQBandHz9.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQBandHz10Change(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.BandHz[9]:=BeRoUtils.strtoint(EditGlobalEQBandHz10.Text);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonGlobalEQResetClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    SynthInitEQ(@APlugin.Track.Global.EQ);
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  OldPatchNr:=-1;
  BankWasChanged:=true;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.ButtonEnvADSRGenerateClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    I,j:integer;
    Envelope:PSynthEnvelope;
begin
 if assigned(AudioCriticalSection) and not InChange then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   FILLCHAR(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab],sizeof(TSynthEnvelope),#0);
   Envelope:=@APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab];
   Envelope^.NodesCount:=5;
   SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+2)*2);
   Envelope^.Nodes[0].Time:=0;
   Envelope^.Nodes[1].Time:=BeRoUtils.strtoint(SpinEditEnvADSRAttack.Text);
   Envelope^.Nodes[2].Time:=Envelope^.Nodes[1].Time+BeRoUtils.strtoint(SpinEditEnvADSRDecay.Text);
   Envelope^.Nodes[3].Time:=Envelope^.Nodes[2].Time+BeRoUtils.strtoint(SpinEditEnvADSRSustainTime.Text);
   Envelope^.Nodes[4].Time:=Envelope^.Nodes[3].Time+BeRoUtils.strtoint(SpinEditEnvADSRRelease.Text);
   Envelope^.Nodes[0].Interpolation:=EnvelopeForm.LastInterpolation;
   Envelope^.Nodes[1].Interpolation:=EnvelopeForm.LastInterpolation;
   Envelope^.Nodes[2].Interpolation:=EnvelopeForm.LastInterpolation;
   Envelope^.Nodes[3].Interpolation:=EnvelopeForm.LastInterpolation;
   Envelope^.Nodes[4].Interpolation:=EnvelopeForm.LastInterpolation;
   Envelope^.Nodes[0].Value:=0;
   Envelope^.Nodes[1].Value:=longword((255*BeRoUtils.strtoint(SpinEditEnvADSRAmplify.Text)) div 100);
   Envelope^.Nodes[2].Value:=longword(((255*BeRoUtils.strtoint(SpinEditEnvADSRAmplify.Text)) div 100)*BeRoUtils.strtoint(SpinEditEnvADSRSustainLevel.Text) div 100);
   Envelope^.Nodes[3].Value:=Envelope^.Nodes[2].Value;
   Envelope^.Nodes[4].Value:=0;
   Envelope^.LoopStart:=-1;
   Envelope^.LoopEnd:=-1;
   if CheckBoxEnvADSRSustain.Checked then begin
    Envelope^.SustainLoopStart:=3;
    Envelope^.SustainLoopEnd:=3;
   end else begin
    Envelope^.SustainLoopStart:=-1;
    Envelope^.SustainLoopEnd:=-1;
   end;
   I:=0;
   while I<(Envelope^.NodesCount-1) do begin
    if (Envelope^.Nodes[I+1].Time-Envelope^.Nodes[I].Time)=0 then begin
     dec(Envelope^.NodesCount);
     j:=Envelope^.NodesCount-i;
     if j>0 then begin
      MOVE(Envelope^.Nodes[I+1],Envelope^.Nodes[I],j*sizeof(TSynthEnvelopeNode));
     end;
     if I<=Envelope^.SustainLoopStart then dec(Envelope^.SustainLoopStart);
     if I<=Envelope^.SustainLoopEnd then dec(Envelope^.SustainLoopEnd);
    end else begin
     inc(I);
    end;
   end;
  finally
   AudioCriticalSection.Leave;
  end;
  OldEnvTab:=-1;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonEnvTranceGateGenerateClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    I,j:integer;
    Envelope:PSynthEnvelope;
    B:array[0..15] of boolean;
    Interval,S,OS:single;
begin
 if assigned(AudioCriticalSection) and not InChange then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   FILLCHAR(APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab],sizeof(TSynthEnvelope),#0);
   Envelope:=@APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab];
   Envelope^.NodesCount:=17;
   SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+2)*2);
   for I:=0 to 16 do begin
    Envelope^.Nodes[I].Interpolation:=EnvelopeForm.LastInterpolation;
   end;
   S:=integer(1 shl (8-ComboBoxEnvTranceGateNoteLength.ItemIndex));
   OS:=S;
   for I:=1 to BeRoUtils.strtoint(SpinEditEnvTranceGateDots.Text) do begin
    OS:=OS*0.5;
    S:=S+OS;
   end;
   Interval:=(60000/(BeRoUtils.strtoint(SpinEditEnvTranceGateBPM.Text)*32))*S;
   for I:=0 to 16 do begin
    Envelope^.Nodes[I].Time:=TRUNC(Interval*I);
   end;
   Envelope^.Nodes[16].Time:=Envelope^.Nodes[16].Time-1;
   B[0]:=CheckBoxEnvTranceGateStep1.Checked;
   B[1]:=CheckBoxEnvTranceGateStep2.Checked;
   B[2]:=CheckBoxEnvTranceGateStep3.Checked;
   B[3]:=CheckBoxEnvTranceGateStep4.Checked;
   B[4]:=CheckBoxEnvTranceGateStep5.Checked;
   B[5]:=CheckBoxEnvTranceGateStep6.Checked;
   B[6]:=CheckBoxEnvTranceGateStep7.Checked;
   B[7]:=CheckBoxEnvTranceGateStep8.Checked;
   B[8]:=CheckBoxEnvTranceGateStep9.Checked;
   B[9]:=CheckBoxEnvTranceGateStep10.Checked;
   B[10]:=CheckBoxEnvTranceGateStep11.Checked;
   B[11]:=CheckBoxEnvTranceGateStep12.Checked;
   B[12]:=CheckBoxEnvTranceGateStep13.Checked;
   B[13]:=CheckBoxEnvTranceGateStep14.Checked;
   B[14]:=CheckBoxEnvTranceGateStep15.Checked;
   B[15]:=CheckBoxEnvTranceGateStep16.Checked;
   for I:=0 to 15 do begin
    if B[I] then begin
     Envelope^.Nodes[I].Value:=(BeRoUtils.strtoint(SpinEditEnvTranceGateOnAmp.Text)*255) div 100;
    end else begin
     Envelope^.Nodes[I].Value:=(BeRoUtils.strtoint(SpinEditEnvTranceGateOffAmp.Text)*255) div 100;
    end;
   end;
   Envelope^.Nodes[16].Value:=Envelope^.Nodes[15].Value;
   Envelope^.LoopStart:=0;
   Envelope^.LoopEnd:=16;
   Envelope^.SustainLoopStart:=-1;
   Envelope^.SustainLoopEnd:=-1;
   I:=0;
   while I<(Envelope^.NodesCount-1) do begin
    if (Envelope^.Nodes[I+1].Time-Envelope^.Nodes[I].Time)=0 then begin
     dec(Envelope^.NodesCount);
     j:=Envelope^.NodesCount-I;
     if j>0 then begin
      MOVE(Envelope^.Nodes[I+1],Envelope^.Nodes[I],j*sizeof(TSynthEnvelopeNode));
     end;
     if I<=Envelope^.SustainLoopStart then dec(Envelope^.SustainLoopStart);
     if I<=Envelope^.SustainLoopEnd then dec(Envelope^.SustainLoopEnd);
    end else begin
     inc(I);
    end;
   end;
  finally
   AudioCriticalSection.Leave;
  end;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.ButtonEnvAmpiferAmplifyClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    I,V:integer;
    Envelope:PSynthEnvelope;
begin
 if assigned(AudioCriticalSection) and not InChange then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   Envelope:=@APlugin.Track.Envelopes[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab];
   for I:=0 to Envelope^.NodesCount-1 do begin
    V:=(Envelope^.Nodes[I].Value*BeRoUtils.strtoint(SpinEditEnvAmpliferAmplify.Text)) div 100;
    if V<0 then begin
     V:=0;
    end else if V>255 then begin
     V:=255;
    end;
    Envelope^.Nodes[I].Value:=V;
   end;
  finally
   AudioCriticalSection.Leave;
  end;
  EnvelopesUpdate;
 end;
end;

procedure TVSTiEditor.SpinEditEnvADSRAttackChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Attack:=SpinEditEnvADSRAttack.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvADSRDecayChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Decay:=SpinEditEnvADSRDecay.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvADSRSustainTimeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.SustainHold:=SpinEditEnvADSRSustainTime.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvADSRReleaseChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Release:=SpinEditEnvADSRRelease.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvADSRAmplifyChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Amplify:=SpinEditEnvADSRAmplify.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvADSRSustainLevelChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.SustainLevel:=SpinEditEnvADSRSustainLevel.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvADSRSustainClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].ADSR.Sustain:=CheckBoxEnvADSRSustain.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep1Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[0]:=CheckBoxEnvTranceGateStep1.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep2Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[1]:=CheckBoxEnvTranceGateStep2.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep3Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[2]:=CheckBoxEnvTranceGateStep3.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep4Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[3]:=CheckBoxEnvTranceGateStep4.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep5Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[4]:=CheckBoxEnvTranceGateStep5.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep6Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[5]:=CheckBoxEnvTranceGateStep6.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep7Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[6]:=CheckBoxEnvTranceGateStep7.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep8Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[7]:=CheckBoxEnvTranceGateStep8.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep9Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[8]:=CheckBoxEnvTranceGateStep9.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep10Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[9]:=CheckBoxEnvTranceGateStep10.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep11Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[10]:=CheckBoxEnvTranceGateStep11.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep12Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[11]:=CheckBoxEnvTranceGateStep12.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep13Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[12]:=CheckBoxEnvTranceGateStep13.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep14Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[13]:=CheckBoxEnvTranceGateStep14.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep15Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[14]:=CheckBoxEnvTranceGateStep15.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxEnvTranceGateStep16Click(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Steps[15]:=CheckBoxEnvTranceGateStep16.Checked;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvTranceGateOnAmpChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.OnAmp:=SpinEditEnvTranceGateOnAmp.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvTranceGateOffAmpChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.OffAmp:=SpinEditEnvTranceGateOffAmp.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvTranceGateBPMChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.BPM:=SpinEditEnvTranceGateBPM.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxEnvTranceGateNoteLengthChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.NoteLength:=ComboBoxEnvTranceGateNoteLength.ItemIndex;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvTranceGateDotsChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].TranceGate.Dots:=SpinEditEnvTranceGateDots.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SpinEditEnvAmpliferAmplifyChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if assigned(DataCriticalSection) and not InChange then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   APlugin.EnvelopesSettings[APlugin.CurrentProgram,TabControlInstrumentVoiceEnvelopes.ActiveTab].Amplifer.Amplify:=SpinEditEnvAmpliferAmplify.Text;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelEQPreAmpScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.PreAmp:=ScrollPos;
   end;
   case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 LabelInstrumentChannelEQPreAmp.Caption:=S+' dB';
 ScrollbarInstrumentChannelEQPreAmp.Track.Caption:=S+' dB';
end;

procedure TVSTiEditor.ScrollbarGlobalEQPreAmpScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 s:='?';
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if not InChange then begin
    APlugin.Track.Global.EQ.PreAmp:=ScrollPos;
   end;
   case APlugin.Track.Global.EQ.Mode of
    eqm6db:begin
     str((ScrollPos*12/240)-6:1:2,s);
    end;
    eqm12db:begin
     str((ScrollPos*24/240)-12:1:2,s);
    end;
    else begin
     str((ScrollPos*48/240)-24:1:2,s);
    end;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
 LabelGlobalEQPreAmp.Caption:=S+' dB';
 ScrollbarGlobalEQPreAmp.Track.Caption:=S+' dB';
end;

procedure TVSTiEditor.CheckBoxGlobalEQCascadedClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.Cascaded:=CheckBoxGlobalEQCascaded.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditGlobalEQOctaveFactorChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.Octave:=softtrunc((BeRoUtils.strtofloat(EditGlobalEQOctaveFactor.Text)*65536)+0.5);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelEQCascadedClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Cascaded:=CheckBoxInstrumentChannelEQCascaded.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditInstrumentChannelEQOctaveFactorChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Octave:=softtrunc((BeRoUtils.strtofloat(EditInstrumentChannelEQOctaveFactor.Text)*65536)+0.5);
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalEQAddCascadedClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.EQ.AddCascaded:=CheckBoxGlobalEQAddCascaded.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelEQAddCascadedClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.AddCascaded:=CheckBoxInstrumentChannelEQAddCascaded.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

type TEQFSignature=array[1..27] of ansichar;
     TEQFHeader=packed record
      Signature:TEQFSignature;
      Unknown:array[1..4] of char;
     end;
     TEQFName=array[1..257] of ansichar;
const EQFSignatureText='Winamp EQ library file v1.1';
      EQFSignature:TEQFSignature=EQFSignatureText;
      EQFHeader:TEQFHeader=(Signature:EQFSignatureText;Unknown:#$1a#$21#$2d#$2d);

procedure TVSTiEditor.ButtonInstrumentChannelEQLoadEQFClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
    Stream:TBeRoStream;
    Header:TEQFHeader;
    name:TEQFName;
    i:integer;
    Bands:array[0..10] of byte;
begin
 if not InChange then begin
  if OpenDialogEQF.Execute then begin
   FileStream:=TBeRoFileStream.Create(OpenDialogEQF.FileName);
   Stream:=TBeRoStream.Create;
   Stream.Assign(FileStream);
   FileStream.Destroy;
   Stream.Seek(0);
   if Stream.read(Header,sizeof(TEQFHeader))=sizeof(TEQFHeader) then begin
    if Header.Signature=EQFSignature then begin
     while Stream.read(name,sizeof(name))=sizeof(name) do begin
      if Stream.read(Bands,sizeof(Bands))=sizeof(Bands) then begin
       if assigned(AudioCriticalSection) then begin
        AudioCriticalSection.Enter;
        try
         APlugin:=TVSTiPlugin(Plugin);
         SynthInitEQ(@APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ);
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Active:=true;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[0]:=60;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[1]:=120;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[2]:=310;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[3]:=600;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[4]:=1000;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[5]:=3000;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[6]:=6000;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[7]:=12000;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[8]:=14000;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.BandHz[9]:=16000;
         for i:=0 to MaxEQBands-1 do begin
          APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[i]:=240-((Bands[i]*240) div 64);
         end;
         APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.PreAmp:=240-((Bands[10]*240) div 64);
        finally
         AudioCriticalSection.Leave;
        end;
       end;
      end;
     end;
    end;
   end;
   Stream.Destroy;
   OldPatchNr:=-1;
   BankWasChanged:=true;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonGlobalEQLoadEQFClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
    Stream:TBeRoStream;
    Header:TEQFHeader;
    name:TEQFName;
    i:integer;
    Bands:array[0..10] of byte;
begin
 if not InChange then begin
  if OpenDialogEQF.Execute then begin
   FileStream:=TBeRoFileStream.Create(OpenDialogEQF.FileName);
   Stream:=TBeRoStream.Create;
   Stream.Assign(FileStream);
   FileStream.Destroy;
   Stream.Seek(0);
   if Stream.read(Header,sizeof(TEQFHeader))=sizeof(TEQFHeader) then begin
    if Header.Signature=EQFSignature then begin
     while Stream.read(name,sizeof(name))=sizeof(name) do begin
      if Stream.read(Bands,sizeof(Bands))=sizeof(Bands) then begin
       if assigned(AudioCriticalSection) then begin
        AudioCriticalSection.Enter;
        try
         APlugin:=TVSTiPlugin(Plugin);
         SynthInitEQ(@APlugin.Track.Global.EQ);
         APlugin.Track.Global.EQ.Active:=true;
         APlugin.Track.Global.EQ.BandHz[0]:=60;
         APlugin.Track.Global.EQ.BandHz[1]:=120;
         APlugin.Track.Global.EQ.BandHz[2]:=310;
         APlugin.Track.Global.EQ.BandHz[3]:=600;
         APlugin.Track.Global.EQ.BandHz[4]:=1000;
         APlugin.Track.Global.EQ.BandHz[5]:=3000;
         APlugin.Track.Global.EQ.BandHz[6]:=6000;
         APlugin.Track.Global.EQ.BandHz[7]:=12000;
         APlugin.Track.Global.EQ.BandHz[8]:=14000;
         APlugin.Track.Global.EQ.BandHz[9]:=16000;
         for i:=0 to MaxEQBands-1 do begin
          APlugin.Track.Global.EQ.Gain[i]:=240-((Bands[i]*240) div 64);
         end;
         APlugin.Track.Global.EQ.PreAmp:=240-((Bands[10]*240) div 64);
        finally
         AudioCriticalSection.Leave;
        end;
       end;
      end;
     end;
    end;
   end;
   Stream.Destroy;
   OldPatchNr:=-1;
   BankWasChanged:=true;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentChannelEQSaveEQFClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
    Stream:TBeRoStream;
    name:TEQFName;
    i:integer;
    Bands:array[0..10] of byte;
begin
 if not InChange then begin
  if SaveDialogEQF.Execute then begin
   Stream:=TBeRoStream.Create;
   if Stream.write(EQFHeader,sizeof(TEQFHeader))=sizeof(TEQFHeader) then begin
    fillchar(name,sizeof(name),#$0);
    if Stream.write(name,sizeof(name))=sizeof(name) then begin
     name[1]:='E';
     name[2]:='n';
     name[3]:='t';
     name[4]:='r';
     name[5]:='y';
     name[6]:='1';
     if assigned(DataCriticalSection) then begin
      DataCriticalSection.Enter;
      try
       APlugin:=TVSTiPlugin(Plugin);
       for i:=0 to MaxEQBands-1 do begin
        Bands[i]:=((240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.Gain[i])*64) div 240;
       end;
       Bands[10]:=((240-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ.PreAmp)*64) div 240;
      finally
       DataCriticalSection.Leave;
      end;
      if Stream.write(Bands,sizeof(Bands))=sizeof(Bands) then begin
       Stream.Seek(0);
       FileStream:=TBeRoFileStream.CreateNew(SaveDialogEQF.FileName);
       FileStream.Assign(Stream);
       FileStream.Destroy;
      end;
     end;
    end;
   end;
   Stream.Destroy;
  end;
 end;
end;

procedure TVSTiEditor.ButtonGlobalEQSaveEQFClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
    Stream:TBeRoStream;
    name:TEQFName;
    i:integer;
    Bands:array[0..10] of byte;
begin
 if not InChange then begin
  if SaveDialogEQF.Execute then begin
   Stream:=TBeRoStream.Create;
   if Stream.write(EQFHeader,sizeof(TEQFHeader))=sizeof(TEQFHeader) then begin
    fillchar(name,sizeof(name),#$0);
    if Stream.write(name,sizeof(name))=sizeof(name) then begin
     name[1]:='E';
     name[2]:='n';
     name[3]:='t';
     name[4]:='r';
     name[5]:='y';
     name[6]:='1';
     if assigned(DataCriticalSection) then begin
      DataCriticalSection.Enter;
      try
       APlugin:=TVSTiPlugin(Plugin);
       for i:=0 to MaxEQBands-1 do begin
        Bands[i]:=((240-APlugin.Track.Global.EQ.Gain[i])*64) div 240;
       end;
       Bands[10]:=((240-APlugin.Track.Global.EQ.PreAmp)*64) div 240;
      finally
       DataCriticalSection.Leave;
      end;
      if Stream.write(Bands,sizeof(Bands))=sizeof(Bands) then begin
       Stream.Seek(0);
       FileStream:=TBeRoFileStream.CreateNew(SaveDialogEQF.FileName);
       FileStream.Assign(Stream);
       FileStream.Destroy;
      end;
     end;
    end;
   end;
   Stream.Destroy;
  end;
 end;
end;

procedure TVSTiEditor.ButtonGlobalEQResetISOClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    SynthInitEQISO(@APlugin.Track.Global.EQ);
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  OldPatchNr:=-1;
  BankWasChanged:=true;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.ButtonInstrumentChannelEQResetISOClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    SynthInitEQISO(@APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelEQ);
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  OldPatchNr:=-1;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.ButtonExportMIDILoadClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
    Stream:TBeRoStream;
    s:string;
begin
 s:=ButtonExportMIDIRecordStop.Caption;
 if OpenDialogMIDI.Execute then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.ExportMIDIDoRecord:=false;
    APlugin.MIDIID:=0;
    FileStream:=TBeRoFileStream.Create(OpenDialogMIDI.FileName);
    Stream:=TBeRoStream.Create;
    Stream.Assign(FileStream);
    FileStream.Destroy;
    Stream.Seek(0);
    APlugin.ReadMIDIStream(Stream);
    Stream.Destroy;
   finally
    AudioCriticalSection.Leave;
   end;
   ExportMIDIUpdate;
   s:='Record';
  end;
 end;
 ButtonExportMIDIRecordStop.Caption:=s;
end;

procedure TVSTiEditor.ButtonExportMIDIRecordStopClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    s:string;
begin
 s:=ButtonExportMIDIRecordStop.Caption;
 if assigned(AudioCriticalSection) then begin
  AudioCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   if APlugin.ExportMIDIDoRecord then begin
    s:='Record';
    APlugin.RecordMIDIStop;
   end else begin
    s:='Stop';
    APlugin.RecordMIDIStart;
   end;
  finally
   AudioCriticalSection.Leave;
  end;
  ExportMIDIUpdate;
 end;
 ButtonExportMIDIRecordStop.Caption:=s;
end;

procedure TVSTiEditor.EditExportTrackNameChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.ExportTrackName:=EditExportTrackName.Text;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditExportAuthorChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.ExportAuthor:=EditExportAuthor.Text;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.MemoExportCommentsChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.ExportComments:=MemoExportComments.Text;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonExportSaveBMFClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
begin
 if not InChange then begin
  if SaveDialogBMF.Execute then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     FileStream:=TBeRoFileStream.CreateNew(SaveDialogBMF.FileName);
     APlugin.GenerateBMFWithBank(FileStream);
     FileStream.Destroy;
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonExportClearClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    s:string;
    i:integer;
begin
 s:=ButtonExportMIDIRecordStop.Caption;
 if assigned(AudioCriticalSection) then begin
  AudioCriticalSection.Enter;
  try
   if assigned(InstanceInfo) then begin
    for i:=0 to InstanceInfo.VSTiPluginInstancesList.Count-1 do begin
     APlugin:=TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[i]);
     if assigned(APlugin.AudioCriticalSection) then begin
      if APlugin<>self.Plugin then begin
       APlugin.AudioCriticalSection.Enter;
      end;
      try
       APlugin.ExportMIDIEventList.Clear;
       APlugin.ExportMIDIDoRecord:=false;
      except
      end;
      if APlugin<>self.Plugin then begin
       APlugin.AudioCriticalSection.Leave;
      end;
     end;
    end;
   end else begin
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.ExportMIDIEventList.Clear;
    APlugin.ExportMIDIDoRecord:=false;
   end;
   s:='Record';
  finally
   AudioCriticalSection.Leave;
  end;
  ExportMIDIUpdate;
 end;
 ButtonExportMIDIRecordStop.Caption:=s;
end;

procedure TVSTiEditor.ButtonSaveBBFFileClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
begin
 if not InChange then begin
  if SaveDialogBBF.Execute then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     FileStream:=TBeRoFileStream.CreateNew(SaveDialogBBF.FileName);
     APlugin.GenerateBank(FileStream,false);
     FileStream.Destroy;
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonExportGenerateSynthconfigINCClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    FileStream:TBeRoStream;
begin
 if not InChange then begin
  if SaveDialogSynthConfigInc.Execute then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     FileStream:=TBeRoFileStream.CreateNew(SaveDialogSynthConfigInc.FileName);
     APlugin.GenerateSynthConfigInc(FileStream,true);
     FileStream.Destroy;
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonExportExportPASClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    Stream:TBeRoStream;
    FileStream:TBeRoStream;
    C:integer;
    B:byte;
    S:string;
begin
 if not InChange then begin
  if SaveDialogPAS.Execute then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     Stream:=TBeRoStream.Create;
     APlugin.GenerateBMFWithBank(Stream);
     FileStream:=TBeRoFileStream.CreateNew(SaveDialogPAS.FileName);
     Stream.Seek(0);
     FileStream.WriteLine('unit '+ChangeFileExt(ExtractFileName(SaveDialogPAS.FileName),'')+';');
     FileStream.WriteLine('interface');
     FileStream.WriteLine('const TrackSize='+INTTOSTR(Stream.Size)+';');
     FileStream.WriteString('      TrackData:array[1..TrackSize] of byte=(');
     C:=0;
     while Stream.Position<Stream.Size do begin
      Stream.read(B,1);
      STR(B,S);
      if Stream.Position<>Stream.Size then S:=S+',';
      C:=C+length(S);
      FileStream.WriteString(S);
      if C>40 then begin
       if Stream.Position<>Stream.Size then begin
        FileStream.WriteLine('');
        FileStream.WriteString('                                             ');
       end;
       C:=0;
      end;
     end;
     FileStream.WriteLine(');');
     FileStream.WriteLine('implementation');
     FileStream.WriteLine('end.');
     FileStream.Destroy;
     Stream.Destroy;
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonExportExportEXEClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    Stream:TBeRoStream;
    dp:pointer;
    ds:integer;
begin
 if not InChange then begin
  if SaveDialogEXE.Execute then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     Stream:=TBeRoStream.Create;
     APlugin.GenerateBMFWithBank(Stream);
     Stream.Seek(0);
     ds:=Stream.Size;
     getmem(dp,ds);
     if Stream.read(dp^,ds)=ds then begin
      WriteEXEWithAppendedData(SaveDialogEXE.FileName,dp,ds);
{     StandardOptions.StripResources:=true;
      StandardOptions.StripRelocationTable:=true;
      StandardOptions.FillUpLastSection:=false;
      CompressFile(PCHAR(SaveDialogEXE.FileName),PCHAR(SaveDialogEXE.FileName),StandardOptions);}
     end;
     freemem(dp);
     Stream.Destroy;
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonExportExportHClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    Stream:TBeRoStream;
    FileStream:TBeRoStream;
    C:integer;
    B:byte;
    S:string;
begin
 if not InChange then begin
  if SaveDialogH.Execute then begin
   if assigned(AudioCriticalSection) then begin
    AudioCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     Stream:=TBeRoStream.Create;
     APlugin.GenerateBMFWithBank(Stream);
     FileStream:=TBeRoFileStream.CreateNew(SaveDialogH.FileName);
     Stream.Seek(0);
     FileStream.WriteLine('#ifndef '+UPPERCASE(ChangeFileExt(ExtractFileName(SaveDialogH.FileName),''))+'_H_');
     FileStream.WriteLine('#define '+UPPERCASE(ChangeFileExt(ExtractFileName(SaveDialogH.FileName),''))+'_H_');
     FileStream.WriteLine('#define TrackSize '+INTTOSTR(Stream.Size));
     FileStream.WriteString('const unsigned char TrackData[TrackSize]={');
     C:=0;
     while Stream.Position<Stream.Size do begin
      Stream.read(B,1);
      STR(B,S);
      if Stream.Position<>Stream.Size then S:=S+',';
      C:=C+length(S);
      FileStream.WriteString(S);
      if C>40 then begin
       if Stream.Position<>Stream.Size then begin
        FileStream.WriteLine('');
        FileStream.WriteString('                                          ');
       end;                   //const unsigned char TrackData[TrackSize]={
       C:=0;
      end;
     end;
     FileStream.WriteLine('};');
     FileStream.WriteLine('#endif');
     FileStream.Destroy;
     Stream.Destroy;
    finally
     AudioCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechCascadeGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechCascadeGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelSpeechCascadeGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.CascadeGain:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.CascadeGain:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechParallelGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechParallelGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelSpeechParallelGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.ParallelGain:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.ParallelGain:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechAspirationGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechAspirationGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelSpeechAspirationGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.AspirationGain:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.AspirationGain:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelSpeechFricationGainScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    Counter:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelSpeechFricationGain.Caption:=S;
 if ScrollPos=0 then begin
  s:='-Inf';
 end else begin
  str(ln(sqr(ScrollPos*fci255))*20/ln(10):1:2,s);
 end;
 ScrollbarInstrumentChannelSpeechFricationGain.Track.Caption:=s+' dB';
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.FricationGain:=ScrollPos;
    for Counter:=0 to NumberOfChannels-1 do begin
     if APlugin.Track.Channels[Counter].SpeechInstance.SegmentList.List=@APlugin.Track.SpeechSegmentLists[APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelSpeech.TextNumber] then begin
      APlugin.Track.Channels[Counter].SpeechInstance.FricationGain:=ScrollPos;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

function TVSTiEditor.TranslateColor(Color:TColor):TColor;
var mr,mg,mb,r,g,b:integer;
begin
 mr:=TVSTiPlugin(Plugin).ColorRFactor;
 mg:=TVSTiPlugin(Plugin).ColorGFactor;
 mb:=TVSTiPlugin(Plugin).ColorBFactor;
 r:=(GetRValue(Color)*abs(mr)) shr 8;
 g:=(GetGValue(Color)*abs(mg)) shr 8;
 b:=(GetBValue(Color)*abs(mb)) shr 8;
 if r<0 then begin
  r:=0;
 end else if r>$ff then begin
  r:=$ff;
 end;
 if g<0 then begin
  g:=0;
 end else if g>$ff then begin
  g:=$ff;
 end;
 if b<0 then begin
  b:=0;
 end else if b>$ff then begin
  b:=$ff;
 end;
 if mr<0 then begin
  r:=(not r) and $ff;
 end;
 if mg<0 then begin
  g:=(not g) and $ff;
 end;
 if mb<0 then begin
  b:=(not b) and $ff;
 end;
 result:=RGB(r,g,b);
end;

procedure TVSTiEditor.SGTK0CheckBoxColorInverseClick(Sender: TObject);
begin
 ColorDirty:=true;
 if not ColorUpdating then begin
  ColorTimer.Enabled:=true;
 end;
end;

procedure TVSTiEditor.SGTK0ScrollbarColorBScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelColorB.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.ColorBFactor<>ScrollPos then begin
     APlugin.ColorBFactor:=ScrollPos;
     ColorDirty:=true;
     if not ColorUpdating then begin
      ColorTimer.Enabled:=true;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ScrollbarColorGScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelColorG.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.ColorGFactor<>ScrollPos then begin
     APlugin.ColorGFactor:=ScrollPos;
     ColorDirty:=true;
     if not ColorUpdating then begin
      ColorTimer.Enabled:=true;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ScrollbarColorRScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelColorR.Caption:=S;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.ColorRFactor<>ScrollPos then begin
     APlugin.ColorRFactor:=ScrollPos;
     ColorDirty:=true;
     if not ColorUpdating then begin
      ColorTimer.Enabled:=true;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.UpdateColorsControls;
var S:string;
begin
 SGTK0ScrollbarColorR.Position:=TVSTiPlugin(Plugin).ColorRFactor;
 SGTK0ScrollbarColorG.Position:=TVSTiPlugin(Plugin).ColorGFactor;
 SGTK0ScrollbarColorB.Position:=TVSTiPlugin(Plugin).ColorBFactor;
 S:=INTTOSTR(SGTK0ScrollbarColorR.Position);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelColorR.Caption:=S;
 S:=INTTOSTR(SGTK0ScrollbarColorG.Position);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelColorG.Caption:=S;
 S:=INTTOSTR(SGTK0ScrollbarColorB.Position);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelColorB.Caption:=S;
end;

procedure TVSTiEditor.SGTK0PanelMasterSlaveClick(Sender: TObject);
var i:integer;
begin
 if assigned(InstanceInfo) and assigned(InstanceInfo^.VSTiPluginInstancesCriticalSection) then begin
  InstanceInfo^.VSTiPluginInstancesCriticalSection.Enter;
  try
   if TVSTiPlugin(InstanceInfo.VSTiPluginInstancesList[0])<>Plugin then begin
    i:=InstanceInfo.VSTiPluginInstancesList.IndexOf(Plugin);
    if i>=0 then begin
     InstanceInfo.VSTiPluginInstancesList.Exchange(0,i);
    end;
   end;
  except
  end;
  InstanceInfo^.VSTiPluginInstancesCriticalSection.Leave;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonVoiceOscSwapClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,ItemNr2:integer;
    t:TSynthInstrumentOscillator;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 ItemNr2:=SGTK0ComboBoxVoiceOscTarget.ItemIndex;
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if ItemNr2 in [0..7] then begin
     t:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr];
     APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr]:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr2];
     APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr2]:=t;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   OldOscTab:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonVoiceOscCopyClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,ItemNr2:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 ItemNr2:=SGTK0ComboBoxVoiceOscTarget.ItemIndex;
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if ItemNr2 in [0..7] then begin
     APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr2]:=APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr];
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   OldOscTab:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonGlobalOrderUpClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,index,NA,NB:integer;
    BA,BB:boolean;
    TA,TB:string;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    index:=SGTK0ListBoxGlobalOrder.ItemIndex;
    APlugin:=TVSTiPlugin(Plugin);
    for ItemNr:=1 to SGTK0ListBoxGlobalOrder.Items.Count-1 do begin
     if SGTK0ListBoxGlobalOrder.Selected[ItemNr] then begin
      if (ItemNr=1) and SGTK0ListBoxGlobalOrder.Selected[ItemNr-1] then begin
       break;
      end;
      if SGTK0ListBoxGlobalOrder.ItemIndex=index then begin
       dec(index);
      end;
      BA:=SGTK0ListBoxGlobalOrder.Selected[ItemNr-1];
      BB:=SGTK0ListBoxGlobalOrder.Selected[ItemNr];
      TA:=SGTK0ListBoxGlobalOrder.Items[ItemNr-1];
      TB:=SGTK0ListBoxGlobalOrder.Items[ItemNr];
      SGTK0ListBoxGlobalOrder.Items[ItemNr-1]:=TB;
      SGTK0ListBoxGlobalOrder.Items[ItemNr]:=TA;
      NA:=APlugin.Track.Global.Order[ItemNr-1];
      NB:=APlugin.Track.Global.Order[ItemNr];
      APlugin.Track.Global.Order[ItemNr-1]:=NB;
      APlugin.Track.Global.Order[ItemNr]:=NA;
      SGTK0ListBoxGlobalOrder.Selected[ItemNr-1]:=BB;
      SGTK0ListBoxGlobalOrder.Selected[ItemNr]:=BA;
     end;
    end;
    SGTK0ListBoxGlobalOrder.ItemIndex:=index;
   finally
    AudioCriticalSection.Leave;
   end;
   GlobalOrderUpdate;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonGlobalOrderDownClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,index,NA,NB:integer;
    BA,BB:boolean;
    TA,TB:string;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    index:=SGTK0ListBoxGlobalOrder.ItemIndex;
    APlugin:=TVSTiPlugin(Plugin);
    for ItemNr:=SGTK0ListBoxGlobalOrder.Items.Count-2 downto 0 do begin
     if SGTK0ListBoxGlobalOrder.Selected[ItemNr] then begin
      if ((ItemNr+2)=SGTK0ListBoxGlobalOrder.Items.Count) and SGTK0ListBoxGlobalOrder.Selected[ItemNr+1] then begin
       break;
      end;
      if SGTK0ListBoxGlobalOrder.ItemIndex=index then begin
       inc(index);
      end;
      BA:=SGTK0ListBoxGlobalOrder.Selected[ItemNr];
      BB:=SGTK0ListBoxGlobalOrder.Selected[ItemNr+1];
      TA:=SGTK0ListBoxGlobalOrder.Items[ItemNr];
      TB:=SGTK0ListBoxGlobalOrder.Items[ItemNr+1];
      SGTK0ListBoxGlobalOrder.Items[ItemNr]:=TB;
      SGTK0ListBoxGlobalOrder.Items[ItemNr+1]:=TA;
      NA:=APlugin.Track.Global.Order[ItemNr];
      NB:=APlugin.Track.Global.Order[ItemNr+1];
      APlugin.Track.Global.Order[ItemNr]:=NB;
      APlugin.Track.Global.Order[ItemNr+1]:=NA;
      SGTK0ListBoxGlobalOrder.Selected[ItemNr]:=BB;
      SGTK0ListBoxGlobalOrder.Selected[ItemNr+1]:=BA;
     end;
    end;
    SGTK0ListBoxGlobalOrder.ItemIndex:=index;
   finally
    AudioCriticalSection.Leave;
   end;
   GlobalOrderUpdate;
  end;
 end;
end;

procedure TVSTiEditor.UpdateColors;
{CONST ColorBack=$00202000;
      ColorFocusedHighlight=$007F7F00;
      ColorDown=$00606000;
      ColorBorder=$00FFFF00;
      ColorEditListBack=$00404000;
      ColorEditListFocused=$00303000;
      ColorFont=$00FFFF00;}
 procedure ProcessComponent(Component:TComponent);
 var i:integer;
 begin
  try
   if not assigned(Component) then begin
    exit;
   end;
   if Component is TSGTK0Menu then begin
    TSGTK0Menu(Component).FontNormal.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0Menu(Component).FontActive.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListFocused);
    TSGTK0Menu(Component).DownFace:=TranslateColor(TVSTiPlugin(Plugin).ColorDown);
    TSGTK0Menu(Component).FocusedFace:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Menu(Component).LineColor:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Menu(Component).NormalFace:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0Menu(Component).ShadowColor:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
   end;
   if Component is TSGTK0Panel then begin
    TSGTK0Panel(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0Panel(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0Panel(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
   end;
   if Component is TSGTK0Edit then begin
    TSGTK0Edit(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0Edit(Component).ColorFocused:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListFocused);
    TSGTK0Edit(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Edit(Component).ColorBack:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListBack);
   end;
   if Component is TSGTK0Button then begin
    TSGTK0Button(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0Button(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0Button(Component).ColorFocused:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
    TSGTK0Button(Component).ColorDown:=TranslateColor(TVSTiPlugin(Plugin).ColorDown);
    TSGTK0Button(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Button(Component).ColorHighLight:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
   end;
   if Component is TSGTK0ComboBox then begin
    TSGTK0ComboBox(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0ComboBox(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListBack);
    TSGTK0ComboBox(Component).ColorArrow:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0ComboBox(Component).ColorArrowBackground:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0ComboBox(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
   end;
   if Component is TSGTK0CheckBox then begin
    TSGTK0CheckBox(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0CheckBox(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0CheckBox(Component).ColorFocused:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
    TSGTK0CheckBox(Component).ColorDown:=TranslateColor(TVSTiPlugin(Plugin).ColorDown);
    TSGTK0CheckBox(Component).ColorCheck:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0CheckBox(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
   end;
   if Component is TSGTK0ScrollbarButton then begin
    TSGTK0ScrollbarButton(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
   end;
   if Component is TSGTK0ScrollbarTrack then begin
    TSGTK0ScrollbarTrack(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0ScrollbarTrack(Component).BorderColor:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0ScrollbarTrack(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorTrackBack);
   end;
   if Component is TSGTK0ScrollbarThumb then begin
    TSGTK0ScrollbarTrack(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
   end;
   if Component is TSGTK0Scrollbar then begin
    TSGTK0Scrollbar(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0Scrollbar(Component).ButtonHighlightColor:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
    TSGTK0Scrollbar(Component).ButtonBorderColor:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Scrollbar(Component).ButtonFocusedColor:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
    TSGTK0Scrollbar(Component).ButtonDownColor:=TranslateColor(TVSTiPlugin(Plugin).ColorDown);
    TSGTK0Scrollbar(Component).ButtonColor:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0Scrollbar(Component).ThumbHighlightColor:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
    TSGTK0Scrollbar(Component).ThumbBorderColor:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Scrollbar(Component).ThumbFocusedColor:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
    TSGTK0Scrollbar(Component).ThumbDownColor:=TranslateColor(TVSTiPlugin(Plugin).ColorDown);
    TSGTK0Scrollbar(Component).ThumbColor:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
   end;
   if Component is TSGTK0TabControl then begin
    TSGTK0TabControl(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0TabControl(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    TSGTK0TabControl(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0TabControl(Component).ColorUnselectedTab:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
   end;
   if Component is TSGTK0TabSheet then begin
    TSGTK0TabSheet(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
   end;
   if Component is TSGTK0PageControl then begin
    TSGTK0PageControl(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
   end;
   if Component is TSGTK0ListBox then begin
    TSGTK0ListBox(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0ListBox(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListBack);
    TSGTK0ListBox(Component).ColorArrow:=0;
    TSGTK0ListBox(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0ListBox(Component).ColorItemsRect:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListBack);
    TSGTK0ListBox(Component).ColorItemsSelect:=TranslateColor(TVSTiPlugin(Plugin).ColorFocusedHighlight);
   end;
   if Component is TSGTK0Memo then begin
    TSGTK0Memo(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TSGTK0Memo(Component).ColorFocused:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListFocused);
    TSGTK0Memo(Component).ColorBorder:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    TSGTK0Memo(Component).ColorBack:=TranslateColor(TVSTiPlugin(Plugin).ColorEditListBack);
   end;
   if Component is TLabel then begin
    TLabel(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TLabel(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
   end;
   if Component is TPanel then begin
    TLabel(Component).Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorFont);
    TLabel(Component).Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
   end;
   for i:=0 to Component.ComponentCount-1 do begin
    ProcessComponent(Component.Components[i]);
   end;
  except
  end;
 end;
//var Counter:integer;
begin
 if not assigned(Plugin) then begin
  exit;
 end;
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   ProcessComponent(self);
(*  VUOnBitmap.Width:=VUMeterWidth;
   VUOnBitmap.Height:=VUMeterHeight;
   with VUOnBitmap.Canvas do begin
    Brush.Color:=clBlack;
    Pen.Color:=clBlack;
    Brush.Style:=bsSolid;
    Pen.Style:=psSolid;
    FillRect(ClipRect);
    Brush.Color:=$00ff00;
    Pen.Color:=$00ff00;
    Counter:=0;
    while Counter<VUOnBitmap.Height do begin
     if Counter<(VUOnBitmap.Height*50 div 100) then begin
  {   Brush.Color:=$00FF00;
      Pen.Color:=$00FF00;}
      Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnA);
      Pen.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnA);
     end else if Counter<(VUOnBitmap.Height*75 div 100) then begin
  {   Brush.Color:=$00FFFF;
      Pen.Color:=$00FFFF;}
      Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnB);
      Pen.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnB);
     end else begin
  {   Brush.Color:=$0000FF;
      Pen.Color:=$0000FF;}
      Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
      Pen.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     end;
     MoveTo(0,VUOnBitmap.Height-Counter);
     LineTo(VUOnBitmap.Width,VUOnBitmap.Height-Counter);
     inc(Counter,2);
    end;
   end;

   VUOffBitmap.Width:=VUMeterWidth;
   VUOffBitmap.Height:=VUMeterHeight;
   with VUOffBitmap.Canvas do begin
    Brush.Color:=clBlack;
    Pen.Color:=clBlack;
    Brush.Style:=bsSolid;
    Pen.Style:=psSolid;
    FillRect(ClipRect);
    Brush.Color:=$007f00;
    Pen.Color:=$007f00;
    Counter:=0;
    while Counter<VUOffBitmap.Height do begin
     if Counter<(VUOffBitmap.Height*50 div 100) then begin
  {   Brush.Color:=$003F00;
      Pen.Color:=$003F00;}
      Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOffA);
      Pen.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOffA);
     end else if Counter<(VUOffBitmap.Height*75 div 100) then begin
  {   Brush.Color:=$003F3F;
      Pen.Color:=$003F3F;}
      Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOffB);
      Pen.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOffB);
     end else begin
  {   Brush.Color:=$00003F;
      Pen.Color:=$00003F;}
      Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOffC);
      Pen.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOffC);
     end;
     MoveTo(0,VUOnBitmap.Height-Counter);
     LineTo(VUOnBitmap.Width,VUOnBitmap.Height-Counter);
     inc(Counter,2);
    end;
   end;           *)
   TVSTiPlugin(Plugin).ColorBorderCache:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0EditInstrumentVoiceFilterHzMinChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,Value,Code,i,i1,i2:integer;
    f:double;
    s:string;
begin
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    val(SGTK0EditInstrumentVoiceFilterHzMin.Text,Value,Code);
    if Code=0 then begin
     APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz:=Value;
    end else begin
     SGTK0EditInstrumentVoiceFilterHzMin.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz);
    end;
   finally
    DataCriticalSection.Leave;
   end;
   s:='Error!';
   ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     case APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Mode of
      fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
       str((sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz:1:2,s);
       s:=s+' Hz';
      end;
      fmFORMANT:begin
       f:=(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff*fci255)*4;
       i:=SoftTRUNC(f);
       f:=f-i;
       i2:=SoftTRUNC(f*100);
       i1:=100-i2;
       case i of
        0:begin
         s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
        end;
        1:begin
         s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
        end;
        2:begin
         s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
        end;
        3:begin
         s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
        end;
        4:begin
         s:='0% O - 100% U';
        end;
       end;
      end;
      else begin
       s:='-';
      end;
     end;
    finally
     DataCriticalSection.Leave;
    end;
   end;
   ScrollbarInstrumentVoiceFilterCutOff.Track.Caption:=s;
   if not InChange then begin
    ScrollbarInstrumentVoiceFilterCutOff.Track.Invalidate;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0EditInstrumentVoiceFilterHzMaxChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr,Value,Code,i,i1,i2:integer;
    s:string;
    f:double;
begin
 ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    val(SGTK0EditInstrumentVoiceFilterHzMax.Text,Value,Code);
    if Code=0 then begin
     APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz:=Value;
    end else begin
     SGTK0EditInstrumentVoiceFilterHzMax.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz);
    end;
   finally
    DataCriticalSection.Leave;
   end;
   s:='Error!';
   ItemNr:=TabControlInstrumentVoiceFilters.ActiveTab;
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     case APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].Mode of
      fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
       str((sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].MinHz:1:2,s);
       s:=s+' Hz';
      end;
      fmFORMANT:begin
       f:=(APlugin.Track.Instruments[APlugin.CurrentProgram].Filter[ItemNr].CutOff*fci255)*4;
       i:=SoftTRUNC(f);
       f:=f-i;
       i2:=SoftTRUNC(f*100);
       i1:=100-i2;
       case i of
        0:begin
         s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
        end;
        1:begin
         s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
        end;
        2:begin
         s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
        end;
        3:begin
         s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
        end;
        4:begin
         s:='0% O - 100% U';
        end;
       end;
      end;
      else begin
       s:='-';
      end;
     end;
    finally
     DataCriticalSection.Leave;
    end;
   end;
   ScrollbarInstrumentVoiceFilterCutOff.Track.Caption:=s;
   if not InChange then begin
    ScrollbarInstrumentVoiceFilterCutOff.Track.Invalidate;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0EditInstrumentChannelFilterMinHzChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    Value,Code,i,i1,i2:integer;
    f:double;
    s:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    val(SGTK0EditInstrumentChannelFilterMinHz.Text,Value,Code);
    if Code=0 then begin
     APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz:=Value;
    end else begin
     SGTK0EditInstrumentChannelFilterMinHz.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz);
    end;
   finally
    DataCriticalSection.Leave;
   end;
   s:='Error!';
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Mode of
      fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
       str((sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].CutOff*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz:1:2,s);
       s:=s+' Hz';
      end;
      fmFORMANT:begin
       f:=(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].CutOff*fci255)*4;
       i:=SoftTRUNC(f);
       f:=f-i;
       i2:=SoftTRUNC(f*100);
       i1:=100-i2;
       case i of
        0:begin
         s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
        end;
        1:begin
         s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
        end;
        2:begin
         s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
        end;
        3:begin
         s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
        end;
        4:begin
         s:='0% O - 100% U';
        end;
       end;
      end;
      else begin
       s:='-';
      end;
     end;
    finally
     DataCriticalSection.Leave;
    end;
   end;
   ScrollbarInstrumentChannelFilterCutOff.Track.Caption:=s;
   if not InChange then begin
    ScrollbarInstrumentChannelFilterCutOff.Track.Invalidate;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0EditInstrumentChannelFilterMaxHzChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    Value,Code,i,i1,i2:integer;
    f:double;
    s:string;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    val(SGTK0EditInstrumentChannelFilterMaxHz.Text,Value,Code);
    if Code=0 then begin
     APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz:=Value;
    end else begin
     SGTK0EditInstrumentChannelFilterMaxHz.Text:=inttostr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz);
    end;
   finally
    DataCriticalSection.Leave;
   end;
   s:='Error!';
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     case APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Mode of
      fmLOWPASS..fmNOTCH,fmBIQUADLOWPASS..fmBIQUADHIGHSHELF,fmMOOGLOWPASS..fmMOOGBANDPASS:begin
       str((sqr(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].CutOff*fci255)*(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MaxHz-APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz))+APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].MinHz:1:2,s);
       s:=s+' Hz';
      end;
      fmFORMANT:begin
       f:=(APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].CutOff*fci255)*4;
       i:=SoftTRUNC(f);
       f:=f-i;
       i2:=SoftTRUNC(f*100);
       i1:=100-i2;
       case i of
        0:begin
         s:=inttostr(i1)+'% A - '+inttostr(i2)+'% E';
        end;
        1:begin
         s:=inttostr(i1)+'% E - '+inttostr(i2)+'% I';
        end;
        2:begin
         s:=inttostr(i1)+'% I - '+inttostr(i2)+'% O';
        end;
        3:begin
         s:=inttostr(i1)+'% O - '+inttostr(i2)+'% U';
        end;
        4:begin
         s:='0% O - 100% U';
        end;
       end;
      end;
      else begin
       s:='-';
      end;
     end;
    finally
     DataCriticalSection.Leave;
    end;
   end;
   ScrollbarInstrumentChannelFilterCutOff.Track.Caption:=s;
   if not InChange then begin
    ScrollbarInstrumentChannelFilterCutOff.Track.Invalidate;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonExportFXPClick(Sender: TObject);
var VSTProgram:TFXChunkSet;
    S:string;
    Size:integer;
    PBuffer:pointer;
    Stream:TBeRoFileStream;
begin
 if SaveDialogFXP.Execute then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    Stream:=TBeRoFileStream.CreateNew(SaveDialogFXP.FileName);
    try
     VSTProgram.ChunkMagic:=FourCharToLong('C','c','n','K');
     VSTProgram.FXMagic:=FourCharToLong('F','P','C','h');
     VSTProgram.Version:=1;
     VSTProgram.FXID:=FourCharToLong(VSTiID[1],VSTiID[2],VSTiID[3],VSTiID[4]);
     VSTProgram.FXVersion:=TVSTiPlugin(Plugin).VSTEffect.Version;
     VSTProgram.NumPrograms:=TVSTiPlugin(Plugin).VSTEffect.NumPrograms;
     SwapBigEndianData32(VSTProgram.ChunkMagic);
     SwapBigEndianData32(VSTProgram.FXMagic);
     SwapBigEndianData32(VSTProgram.Version);
     SwapBigEndianData32(VSTProgram.FXID);
     SwapBigEndianData32(VSTProgram.FXVersion);
     SwapBigEndianData32(VSTProgram.NumPrograms);
     S:=TVSTiPlugin(Plugin).ProgramNames[TVSTiPlugin(Plugin).CurrentProgram and $7f];
     FILLCHAR(VSTProgram.prgName,sizeof(VSTProgram.prgName),#0);
     if length(S)>0 then begin
      if length(S)>sizeof(VSTProgram.prgName) then begin
        MOVE(S[1],VSTProgram.prgName,sizeof(VSTProgram.prgName));
      end else begin
       MOVE(S[1],VSTProgram.prgName,length(S));
      end;
     end;
     Size:=TVSTiPlugin(Plugin).GetChunk(PBuffer,true);
     VSTProgram.chunkSize:=Size;
     VSTProgram.byteSize:=sizeof(VSTProgram)-(sizeof(longint)*2)+(VSTProgram.chunkSize-8);
     SwapBigEndianData32(VSTProgram.byteSize);
     SwapBigEndianData32(VSTProgram.chunkSize);
     Stream.write(VSTProgram,sizeof(VSTProgram)-sizeof(pointer));
     Stream.write(PBuffer^,Size);
    finally
     Stream.Free;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonImportFXPClick(Sender: TObject);
var VSTProgram:TFXChunkSet;
    Size,ID,ID2:integer;
    Data:pointer;
    Stream:TBeRoFileStream;
    b:byte;
    UseChunk:boolean;
begin
 if OpenDialogFXP.Execute then begin
  if assigned(AudioCriticalSection) then begin
   Stream:=TBeRoFileStream.Create(OpenDialogFXP.FileName);
   try
    Stream.Seek(9);
    Stream.read(B,1);
    UseChunk:=B<>$78;
    Stream.Seek(0);
    if UseChunk then begin
     Stream.read(VSTProgram,sizeof(TFXChunkSet)-sizeof(pointer));
     ID:=FourCharToLong(VSTiID[1],VSTiID[2],VSTiID[3],VSTiID[4]);
     ID2:=FourCharToLong(VSTiID2[1],VSTiID2[2],VSTiID2[3],VSTiID2[4]);
     SwapBigEndianData32(ID);
     SwapBigEndianData32(ID2);
     if (VSTProgram.fxId=ID) or (VSTProgram.fxId=ID2) then begin
      TVSTiPlugin(Plugin).ProgramNames[TVSTiPlugin(Plugin).CurrentProgram and $7f]:=trimright(VSTProgram.prgName);
      Size:=Stream.Size-Stream.Position;
      GETMEM(Data,Size+1);
      Size:=Stream.read(Data^,Size);
      TVSTiPlugin(Plugin).SetChunk(Data,Size,true);
      FREEMEM(Data);
     end;
    end;
   finally
    Stream.Free;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonExportFXBClick(Sender: TObject);
var VSTBank:TFXChunkBank;
    Size:integer;
    PBuffer:pointer;
    Stream:TBeRoFileStream;
begin
 if SaveDialogFXB.Execute then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    Stream:=TBeRoFileStream.CreateNew(SaveDialogFXB.FileName);
    try
     VSTBank.ChunkMagic:=FourCharToLong('C','c','n','K');
     VSTBank.FXMagic:=FourCharToLong('F','B','C','h');
     VSTBank.Version:=1;
     VSTBank.FXID:=FourCharToLong(VSTiID[1],VSTiID[2],VSTiID[3],VSTiID[4]);
     VSTBank.FXVersion:=TVSTiPlugin(Plugin).VSTEffect.version;
     VSTBank.NumPrograms:=TVSTiPlugin(Plugin).VSTEffect.numPrograms;
     SwapBigEndianData32(VSTBank.ChunkMagic);
     SwapBigEndianData32(VSTBank.FXMagic);
     SwapBigEndianData32(VSTBank.Version);
     SwapBigEndianData32(VSTBank.FXID);
     SwapBigEndianData32(VSTBank.FXVersion);
     SwapBigEndianData32(VSTBank.NumPrograms);
     Size:=TVSTiPlugin(Plugin).GetChunk(PBuffer,false);
     VSTBank.chunkSize:=Size;
     VSTBank.byteSize:=sizeof(VSTBank)-(sizeof(longword)*3)+(VSTBank.chunkSize+8);
     SwapBigEndianData32(VSTBank.byteSize);
     SwapBigEndianData32(VSTBank.chunkSize);
     Stream.write(VSTBank,sizeof(VSTBank)-sizeof(pointer));
     Stream.write(PBuffer^,Size);
    finally
     Stream.Free;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonImportFXBClick(Sender: TObject);
var VSTBank:TFXChunkBank;
    Size,ID,ID2:integer;
    Data:pointer;
    Stream:TBeRoFileStream;
    b:byte;
    UseChunk:boolean;
begin
 if OpenDialogFXB.Execute then begin
  if assigned(AudioCriticalSection) then begin
   Stream:=TBeRoFileStream.Create(OpenDialogFXB.FileName);
   try
    Stream.Seek(9);
    Stream.read(B,1);
    UseChunk:=B<>$78;
    Stream.Seek(0);
    if UseChunk then begin
     Stream.read(VSTBank,sizeof(TFXChunkBank)-sizeof(pointer));
     ID:=FourCharToLong(VSTiID[1],VSTiID[2],VSTiID[3],VSTiID[4]);
     ID2:=FourCharToLong(VSTiID2[1],VSTiID2[2],VSTiID2[3],VSTiID2[4]);
     SwapBigEndianData32(ID);
     SwapBigEndianData32(ID2);
     if (VSTBank.fxId=ID) or (VSTBank.fxId=ID2) then begin
      Size:=Stream.Size-Stream.Position;
      GETMEM(Data,Size+1);
      Size:=Stream.read(Data^,Size);
      TVSTiPlugin(Plugin).SetChunk(Data,Size,false);
      FREEMEM(Data);
     end;
    end;
   finally
    Stream.Free;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ScrollbarGlobalsVoicesCountScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    i:integer;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsVoicesCount.Caption:=S;
 SGTK0ScrollbarGlobalsVoicesCount.Track.Caption:=inttostr(ScrollPos)+' voices';
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Global.Voices.Count<>ScrollPos then begin
     for i:=APlugin.Track.Global.Voices.Count to ScrollPos-1 do begin
      APlugin.Track.Voices[i].Active:=false;
     end;
     APlugin.Track.Global.Voices.Count:=ScrollPos;
     for i:=APlugin.Track.Global.Voices.Count to NumberOfVoices-1 do begin
      APlugin.Track.Voices[i].Active:=false;
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonConvertOldToNewUnitsClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    SynthConvertOldToNewUnits(@APlugin.Track);
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  OldPatchNr:=-1;
  EditorUpdate;
 end;
end;

procedure TVSTiEditor.ColorTimerTimer(Sender: TObject);
var i:integer;
begin
 ColorTimer.Enabled:=false;
 i:=255;
 while ColorDirty and (i>0) do begin
  dec(i);
  ColorDirty:=false;
  SGTK0UpdateLock:=true;
  SendMessage(Handle,WM_SETREDRAW,0,0);
  ColorUpdating:=true;
  try
   UpdateColors;
  finally
   SGTK0UpdateLock:=false;
   SendMessage(Handle,WM_SETREDRAW,1,0);
   RedrawWindow(Handle,nil,0,RDW_NOERASE or RDW_NOFRAME or RDW_NOINTERNALPAINT or RDW_INVALIDATE or RDW_ALLCHILDREN);
   ColorUpdating:=false;
  end;
 end;
end;

procedure TVSTiEditor.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TVSTiEditor.SGTK0TabControlVoiceDistortionTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.SGTK0TabControlChannelDistortionTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.SGTK0CheckBoxChannelFilterCarryClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=SGTK0TabControlChannelFilter.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelFilter[ItemNr].Carry:=SGTK0CheckBoxChannelFilterCarry.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0TabControlChannelFilterTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.SGTK0ScrollbarOversampleScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelOversample.Caption:=S;
 SGTK0ScrollbarOversample.Track.Caption:=inttostr(1 shl ScrollPos)+'x';
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Global.Oversample<>ScrollPos then begin
     APlugin.Track.Global.Oversample:=ScrollPos;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0CheckBoxInstrumentChannelChorusFlangerFineClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Fine:=SGTK0CheckBoxInstrumentChannelChorusFlangerFine.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsChorusFlangerFineClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.Fine:=CheckBoxGlobalsChorusFlangerFine.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentChannelChorusFlangerCountScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentChannelChorusFlangerCount.Caption:=S;
 ScrollbarInstrumentChannelChorusFlangerCount.Track.Caption:=INTTOSTR(ScrollPos);
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelChorusFlanger.Count:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsChorusFlangerCountScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsChorusFlangerCount.Caption:=S;
 ScrollbarGlobalsChorusFlangerCount.Track.Caption:=INTTOSTR(ScrollPos);
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.ChorusFlanger.Count:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelDelayFineClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].Fine:=CheckBoxInstrumentChannelDelayFine.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsDelayFineClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.Fine:=CheckBoxGlobalsDelayFine.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceOscillatorRandomPhaseClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].RandomPhase:=CheckBoxInstrumentVoiceOscillatorRandomPhase.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorPluckedStringReflectionScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
    x:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorPluckedStringReflection.Caption:=S;
 x:=ScrollPos*fci256;
 str(x*100:1:2,s);
 ScrollbarInstrumentVoiceOscillatorPluckedStringReflection.Track.Caption:=s+'%';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringReflection:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorPluckedStringPickScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
    x:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorPluckedStringPick.Caption:=S;
 x:=ScrollPos*fci256;
 str(x*100:1:2,s);
 ScrollbarInstrumentVoiceOscillatorPluckedStringPick.Track.Caption:=s+'%';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringPick:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorPluckedStringPickUpScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
    x:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorPluckedStringPickUp.Caption:=S;
 x:=ScrollPos*fci256;
 str(x*100:1:2,s);
 ScrollbarInstrumentVoiceOscillatorPluckedStringPickUp.Track.Caption:=s+'%';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringPickUp:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorPluckedStringDelayLineWidthScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorPluckedStringDelayLineWidth.Caption:=S;
 ScrollbarInstrumentVoiceOscillatorPluckedStringDelayLineWidth.Track.Caption:='Offset -/+ '+IntToStr(ScrollPos);
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringDelayLineWidth:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].PluckedStringDelayLineMode:=ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorSuperOscWaveformChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscWaveform:=ComboBoxInstrumentVoiceOscillatorSuperOscWaveform.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorSuperOscModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscMode:=ComboBoxInstrumentVoiceOscillatorSuperOscMode.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorSuperOscCountScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorSuperOscCount.Caption:=S;
 ScrollbarInstrumentVoiceOscillatorSuperOscCount.Track.Caption:=IntToStr(ScrollPos)+' suboscs';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscCount:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorSuperOscDetuneScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
    x:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorSuperOscDetune.Caption:=S;
 x:=ScrollPos*fci255;
 str(x*100:1:2,s);
 ScrollbarInstrumentVoiceOscillatorSuperOscDetune.Track.Caption:=s+'%';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscDetune:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorSuperOscMixScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
    x:double;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelInstrumentVoiceOscillatorSuperOscMix.Caption:=S;
 x:=ScrollPos*fci255;
 str(x*100:1:2,s);
 ScrollbarInstrumentVoiceOscillatorSuperOscMix.Track.Caption:=s+'%';
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].SuperOscMix:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentVoiceOscillatorPanningScroll(
  Sender: TObject; ScrollPos: integer);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelInstrumentVoiceOscillatorPanning.Caption:=S;
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 ScrollbarInstrumentVoiceOscillatorPanning.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Panning:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceOscillatorPanningClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].UsePanning:=CheckBoxInstrumentVoiceOscillatorPanning.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.DummyOld;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    BankWasChanged:=true;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  TimerSize.Enabled:=true;
  EditorUpdate;
 end;
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    BankWasChanged:=true;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  TimerSize.Enabled:=true;
  EditorUpdate;
  SamplesUpdate;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceLFOPhaseSyncChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceLFOs.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].LFO[ItemNr].PhaseSync:=ComboBoxInstrumentVoiceLFOPhaseSync.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarChannelLFORateScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelChannelLFORate.Caption:=S;
 str(POW(0.0001,(255-ScrollPos)*fci255)*100:1:4,s);
 s:=s+' Hz';
 ScrollbarChannelLFORate.Track.Caption:=s;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelLFO.Rate:=ScrollPos;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxChannelLFOActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelLFO.Active:=CheckBoxChannelLFOActive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxSamplesPadSynthCurveModeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.CurveMode:=ComboBoxSamplesPadSynthCurveMode.ItemIndex;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarSamplesPadSynthCurveSteepnessScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    index:integer;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<2 do begin
  S:='0'+S;
 end;
 LabelSamplesPadSynthCurveSteepness.Caption:=S;
 index:=ComboBoxSamples.ItemIndex;
 if (index>=0) and (index<MaxSamples) then begin
  if not InChange then begin
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.CurveSteepness:=ScrollPos;
    finally
     DataCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxSamplesPadSynthExtendedBalanceClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.ExtendedBalance:=CheckBoxSamplesPadSynthExtendedBalance.Checked;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarSamplesPadSynthBalanceScroll(Sender: TObject;
  ScrollPos: integer);
var APlugin:TVSTiPlugin;
    S:string;
    index:integer;
begin
 S:=INTTOSTR(ScrollPos);
 if (length(S)=2) and (POS('-',S)=1) then begin
  INSERT('0',S,2);
 end;
 while length(S)<2 do begin
  S:='0'+S;
 end;
 while length(S)<3 do begin
  S:=' '+S;
 end;
 LabelSamplesPadSynthBalance.Caption:=S;
// ScrollbarSamplesPadSynthBalance.Track.Caption:='';
 index:=ComboBoxSamples.ItemIndex;
 if (index>=0) and (index<MaxSamples) then begin
  if not InChange then begin
   if assigned(DataCriticalSection) then begin
    DataCriticalSection.Enter;
    try
     APlugin:=TVSTiPlugin(Plugin);
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Balance:=ScrollPos;
    finally
     DataCriticalSection.Leave;
    end;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ButtonSamplesPadSynthGenIt1Click(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     CurrentSample:=@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index];
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize:=NextOfPowerTwo(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize);
     if EditSamplesPadSynthWaveTableSize.Text<>inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize) then begin
      InChange:=true;
      try
       EditSamplesPadSynthWaveTableSize.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize);
      finally
       InChange:=false;
      end;
     end;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.ToGenerate:=true;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels:=1;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Note:=69;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Finetune:=0;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.Mode:=slFORWARD;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.StartSample:=0;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Loop.EndSample:=APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WaveTableSize-1;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.Mode:=slNONE;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.StartSample:=0;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SustainLoop.EndSample:=0;
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.RandomStartPosition:=true;
     SynthPadSynthGenerateHarmonics(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth);
     SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.ToGenerate:=false;
     CalculatePhaseSamples;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
 SamplesUpdate;
end;

procedure TVSTiEditor.CheckBoxSamplesPadSynthStereoClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.Stereo:=CheckBoxSamplesPadSynthStereo.Checked;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxMultithreadingClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   InChange:=true;
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if CheckBoxMultithreading.Checked and (APlugin.Track.JobManager.CountThreads<2) then begin
     CheckBoxMultithreading.Checked:=false;
     APlugin.Track.UseMultithreading:=false;
    end else begin
     APlugin.Track.UseMultithreading:=CheckBoxMultithreading.Checked;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   InChange:=false;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxSSEClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   InChange:=true;
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if CheckBoxSSE.Checked and not SSEExt then begin
     CheckBoxSSE.Checked:=false;
     APlugin.Track.UseSSE:=false;
    end else begin
     APlugin.Track.UseSSE:=CheckBoxSSE.Checked;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   InChange:=false;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentChannelDelayRecursiveClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelDelay[SGTK0TabControlChannelDelay.ActiveTab and 7].Recursive:=CheckBoxInstrumentChannelDelayRecursive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsDelayRecursiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Delay.Recursive:=CheckBoxGlobalsDelayRecursive.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxGlobalsClippingClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.Clipping:=CheckBoxGlobalsClipping.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentChannelCompressorSideInChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].ChannelCompressor.SideIn:=ComboBoxInstrumentChannelCompressorSideIn.ItemIndex;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0TabControlChannelDelayTabChanged(
  Sender: TObject);
begin
 EditorUpdate;
end;

procedure TVSTiEditor.CheckBoxInstrumentLinkActiveClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Link.Active:=CheckBoxInstrumentLinkActive.Checked;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentLinkChannelScroll(Sender: TObject;
  ScrollPos: Integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<2 do begin
  S:='0'+S;
 end;
 LabelInstrumentLinkChannel.Caption:=S;
 if ScrollPos<0 then begin
  s:='none';
 end else begin
  s:='MIDI channel '+INTTOSTR(ScrollPos+1);
 end;
 ScrollbarInstrumentLinkChannel.Track.Caption:=s;
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Link.Channel:=ScrollPos;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ScrollbarInstrumentLinkProgramScroll(Sender: TObject;
  ScrollPos: Integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<2 do begin
  S:='0'+S;
 end;
 LabelInstrumentLinkProgram.Caption:=S;
 if ScrollPos<0 then begin
  s:='none';
 end else begin
  s:='MIDI program '+INTTOSTR(ScrollPos);
 end;
 ScrollbarInstrumentLinkProgram.Track.Caption:=s;
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Link.ProgramNr:=ScrollPos;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.Label1Click(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.Label2Click(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.Label3Click(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.SGTK0PanelCPUTimeClick(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.Label4Click(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.PanelGlobalPolyClick(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.PanelTopViewChnStatesClick(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.PanelTopViewGraphicsClick(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.ImageTopViewGraphicsClick(Sender: TObject);
begin
 TopViewModeClick(Sender);
end;

procedure TVSTiEditor.ImageTopViewGraphicsPaint(Sender: TObject);
const sChn:array[0..15] of ansistring=('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16');
var i,j,w,h,pw,ph,x,y:integer;
    ChannelPeaks:array[0..1] of single;
    v,minv,maxv:single;
begin
 if (ImageTopViewGraphicsBuffer.Width<>ImageTopViewGraphics.ClientWidth) or
    (ImageTopViewGraphicsBuffer.Height<>ImageTopViewGraphics.ClientHeight) then begin
  ImageTopViewGraphicsBuffer.Width:=ImageTopViewGraphics.ClientWidth;
  ImageTopViewGraphicsBuffer.Height:=ImageTopViewGraphics.ClientHeight;
 end;
 if ImageTopViewGraphicsBuffer.HandleType<>bmDIB then begin
  ImageTopViewGraphicsBuffer.HandleType:=bmDIB;
 end;
 w:=ImageTopViewGraphicsBuffer.Width;
 h:=ImageTopViewGraphicsBuffer.Height;
 if assigned(Plugin) then begin
  case PanelTopViewMode of
   1:begin
    ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
    ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
    ImageTopViewGraphicsBuffer.Canvas.FillRect(ImageTopViewGraphicsBuffer.Canvas.ClipRect);
    ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsClear;
    ImageTopViewGraphicsBuffer.Canvas.Font.Assign(self.Font);
    ImageTopViewGraphicsBuffer.Canvas.Font.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBorder);
    pw:=w div NumberOfChannels;
    ph:=ImageTopViewGraphicsBuffer.Canvas.TextHeight('I')+6;
    for i:=0 to NumberOfChannels-1 do begin
     ChannelPeaks[0]:=((20*log10(fastsqrt(TVSTiPlugin(Plugin).Track.Channels[i].OutPeaks.Left)))+60)/60;
     ChannelPeaks[1]:=((20*log10(fastsqrt(TVSTiPlugin(Plugin).Track.Channels[i].OutPeaks.Right)))+60)/60;
     if ChannelPeaks[0]<0 then begin
      ChannelPeaks[0]:=0;
     end else if ChannelPeaks[0]>1 then begin
      ChannelPeaks[0]:=1;
     end;
     if ChannelPeaks[1]<0 then begin
      ChannelPeaks[1]:=0;
     end else if ChannelPeaks[1]>1 then begin
      ChannelPeaks[1]:=1;
     end;
     x:=((i*w) div NumberOfChannels);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsClear;
     ImageTopViewGraphicsBuffer.Canvas.TextOut(x+((pw-ImageTopViewGraphicsBuffer.Canvas.TextWidth(sChn[i])) div 2),h-ph,sChn[i]);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Style:=psSolid;
     ImageTopViewGraphicsBuffer.Canvas.Rectangle(x+((pw div 2)-(pw div 4)),h-((ph+7)+round(FastSQRT(ChannelPeaks[0])*((h-(ph+12))))),
                                                 x+(pw div 2),h-(ph+6));
     ImageTopViewGraphicsBuffer.Canvas.Rectangle(x+(pw div 2),h-((ph+7)+round(FastSQRT(ChannelPeaks[1])*((h-(ph+12))))),
                                                 x+((pw div 2)+(pw div 4)),h-(ph+6));
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Rectangle(x+((pw div 2)-1),h-((ph+7)+round(max(FastSQRT(ChannelPeaks[0]),FastSQRT(ChannelPeaks[1]))*((h-(ph+12))))),
                                                 x+((pw div 2)+1),h-(ph+7));
    end;
    ImageTopViewGraphics.Canvas.Draw(0,0,ImageTopViewGraphicsBuffer);
   end;
   2:begin
    j:=TVSTiPlugin(Plugin).OscilBufferReadyIndex and OscilBufferMasterMask;
    if OscilBufferReadyIndex<>j then begin
     OscilBufferReadyIndex:=j;
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
     ImageTopViewGraphicsBuffer.Canvas.FillRect(ImageTopViewGraphicsBuffer.Canvas.ClipRect);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Style:=psSolid;
     for i:=0 to OscilBufferMask do begin
      x:=(i*w) div OscilBufferSize;
      y:=round((1-(((TVSTiPlugin(Plugin).OscilBuffer[j,0,i]+TVSTiPlugin(Plugin).OscilBuffer[j,1,i])*0.5)+1)*0.5)*h);
      if i=0 then begin
       ImageTopViewGraphicsBuffer.Canvas.MoveTo(x,y);
      end else begin
       ImageTopViewGraphicsBuffer.Canvas.LineTo(x,y);
      end;
     end;
     ImageTopViewGraphics.Canvas.Draw(0,0,ImageTopViewGraphicsBuffer);
    end;
   end;
   3:begin
    j:=TVSTiPlugin(Plugin).OscilBufferReadyIndex and OscilBufferMasterMask;
    if OscilBufferReadyIndex<>j then begin
     OscilBufferReadyIndex:=j;
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
     ImageTopViewGraphicsBuffer.Canvas.FillRect(ImageTopViewGraphicsBuffer.Canvas.ClipRect);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Style:=psSolid;
     for i:=0 to OscilBufferMask do begin
      x:=(i*w) div OscilBufferSize;
      y:=round((1-((TVSTiPlugin(Plugin).OscilBuffer[j,0,i]+1)*0.5))*(h*0.5));
      if i=0 then begin
       ImageTopViewGraphicsBuffer.Canvas.MoveTo(x,y);
      end else begin
       ImageTopViewGraphicsBuffer.Canvas.LineTo(x,y);
      end;
     end;
     for i:=0 to OscilBufferMask do begin
      x:=(i*w) div OscilBufferSize;
      y:=round(((1-((TVSTiPlugin(Plugin).OscilBuffer[j,1,i]+1)*0.5))*(h*0.5))+(h*0.5));
      if i=0 then begin
       ImageTopViewGraphicsBuffer.Canvas.MoveTo(x,y);
      end else begin
       ImageTopViewGraphicsBuffer.Canvas.LineTo(x,y);
      end;
     end;
     ImageTopViewGraphics.Canvas.Draw(0,0,ImageTopViewGraphicsBuffer);
    end;
   end;
   4:begin
    j:=TVSTiPlugin(Plugin).OscilBufferReadyIndex and OscilBufferMasterMask;
    if OscilBufferReadyIndex<>j then begin
     OscilBufferReadyIndex:=j;
     for i:=0 to OscilBufferMask do begin
      FFTBuffer[0,i]:=((TVSTiPlugin(Plugin).OscilBuffer[j,0,i]+TVSTiPlugin(Plugin).OscilBuffer[j,1,i])*0.5)*FFTWindow[i];
     end;
     FFT.FFT(@FFTBuffer[1,0],@FFTBuffer[0,0]);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
     ImageTopViewGraphicsBuffer.Canvas.FillRect(ImageTopViewGraphicsBuffer.Canvas.ClipRect);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Style:=psSolid;
     minv:=0;
     maxv:=0;
     for i:=0 to (OscilBufferMask div 2)-1 do begin
      v:=fastsqrt(sqr(FFTBuffer[1,i])+sqr(FFTBuffer[1,i+(OscilBufferMask div 2)]));
      FFTBuffer[0,i]:=v;
      if i=0 then begin
       minv:=v;
       maxv:=v;
      end else begin
       minv:=min(minv,v);
       maxv:=max(maxv,v);
      end;
     end;
     if maxv>1 then begin
      v:=1/maxv;
      for i:=0 to (OscilBufferMask div 2)-1 do begin
       FFTBuffer[0,i]:=FFTBuffer[0,i]*v;
      end;
     end;
     for i:=0 to (OscilBufferMask div 2)-1 do begin
      x:=(i*w*2) div OscilBufferSize;
      y:=round(((1-FFTBuffer[0,i])*(h*0.9))+(h*0.05));
      if i=0 then begin
       ImageTopViewGraphicsBuffer.Canvas.MoveTo(x,y);
      end else begin
       ImageTopViewGraphicsBuffer.Canvas.LineTo(x,y);
      end;
     end;
     ImageTopViewGraphics.Canvas.Draw(0,0,ImageTopViewGraphicsBuffer);
    end;
   end;
   5:begin
    j:=TVSTiPlugin(Plugin).OscilBufferReadyIndex and OscilBufferMasterMask;
    if OscilBufferReadyIndex<>j then begin
     OscilBufferReadyIndex:=j;
     for i:=0 to OscilBufferMask do begin
      FFTBuffer[0,i]:=TVSTiPlugin(Plugin).OscilBuffer[j,0,i]*FFTWindow[i];
     end;
     FFT.FFT(@FFTBuffer[1,0],@FFTBuffer[0,0]);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorBack);
     ImageTopViewGraphicsBuffer.Canvas.FillRect(ImageTopViewGraphicsBuffer.Canvas.ClipRect);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Style:=psSolid;
     minv:=0;
     maxv:=0;
     for i:=0 to (OscilBufferMask div 2)-1 do begin
      v:=fastsqrt(sqr(FFTBuffer[1,i])+sqr(FFTBuffer[1,i+(OscilBufferMask div 2)]));
      FFTBuffer[0,i]:=v;
      if i=0 then begin
       minv:=v;
       maxv:=v;
      end else begin
       minv:=min(minv,v);
       maxv:=max(maxv,v);
      end;
     end;
     if maxv>1 then begin
      v:=1/maxv;
      for i:=0 to (OscilBufferMask div 2)-1 do begin
       FFTBuffer[0,i]:=FFTBuffer[0,i]*v;
      end;
     end;
     for i:=0 to (OscilBufferMask div 2)-1 do begin
      x:=(i*w*2) div OscilBufferSize;
      y:=round((((1-FFTBuffer[0,i])*(h*0.9))+(h*0.05))*0.5);
      if i=0 then begin
       ImageTopViewGraphicsBuffer.Canvas.MoveTo(x,y);
      end else begin
       ImageTopViewGraphicsBuffer.Canvas.LineTo(x,y);
      end;
     end;
     for i:=0 to OscilBufferMask do begin
      FFTBuffer[0,i]:=TVSTiPlugin(Plugin).OscilBuffer[j,1,i]*FFTWindow[i];
     end;
     FFT.FFT(@FFTBuffer[1,0],@FFTBuffer[0,0]);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Color:=TranslateColor(TVSTiPlugin(Plugin).ColorPeakOnC);
     ImageTopViewGraphicsBuffer.Canvas.Brush.Style:=bsSolid;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Color:=ImageTopViewGraphicsBuffer.Canvas.Brush.Color;
     ImageTopViewGraphicsBuffer.Canvas.Pen.Style:=psSolid;
     minv:=0;
     maxv:=0;
     for i:=0 to (OscilBufferMask div 2)-1 do begin
      v:=fastsqrt(sqr(FFTBuffer[1,i])+sqr(FFTBuffer[1,i+(OscilBufferMask div 2)]));
      FFTBuffer[0,i]:=v;
      if i=0 then begin
       minv:=v;
       maxv:=v;
      end else begin
       minv:=min(minv,v);
       maxv:=max(maxv,v);
      end;
     end;
     if maxv>1 then begin
      v:=1/maxv;
      for i:=0 to (OscilBufferMask div 2)-1 do begin
       FFTBuffer[0,i]:=FFTBuffer[0,i]*v;
      end;
     end;
     for i:=0 to (OscilBufferMask div 2)-1 do begin
      x:=(i*w*2) div OscilBufferSize;
      y:=round(((((1-FFTBuffer[0,i])*(h*0.9))+(h*0.05))*0.5)+(h*0.5));
      if i=0 then begin
       ImageTopViewGraphicsBuffer.Canvas.MoveTo(x,y);
      end else begin
       ImageTopViewGraphicsBuffer.Canvas.LineTo(x,y);
      end;
     end;
     ImageTopViewGraphics.Canvas.Draw(0,0,ImageTopViewGraphicsBuffer);
    end;
   end;
   else begin
   end;
  end;
 end;
end;

procedure TVSTiEditor.EditSamplesPadSynthWaveTableSizeExit(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize:=NextOfPowerTwo(strtointdef(EditSamplesPadSynthWaveTableSize.Text,APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize));
     if EditSamplesPadSynthWaveTableSize.Text<>inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize) then begin
      InChange:=true;
      try
       EditSamplesPadSynthWaveTableSize.Text:=inttostr(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].PadSynth.WavetableSize);
      finally
       InChange:=false;
      end;
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0Panel92Resize(Sender: TObject);
begin
 if assigned(WaveEditor) then begin
  WaveEditor.ClearZoom;
 end;
end;

procedure TVSTiEditor.ScrollbarGlobalsRampingLenScroll(Sender: TObject;
  ScrollPos: Integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelGlobalsRampingLen.Caption:=S;
 str((ScrollPos*100)/1000:1:1,s);
 ScrollbarGlobalsRampingLen.Track.Caption:=s+' ms';
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Global.RampingLen<>ScrollPos then begin
     APlugin.Track.Global.RampingLen:=ScrollPos;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxGlobalsRampingModeChange(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.RampingMode:=ComboBoxGlobalsRampingMode.ItemIndex;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.DoModulationMatrixItemUp(Sender: TObject);
var APlugin:TVSTiPlugin;
    Index,NewIndex:integer;
    Item:TSynthInstrumentModulationMatrixItem;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   NewIndex:=ScrollbarModulationMatrixItems.Position;
   AudioCriticalSection.Enter;
   try
    if assigned(Sender) and (Sender is TFormModulationMatrixItem) then begin
     APlugin:=TVSTiPlugin(Plugin);
     Index:=TFormModulationMatrixItem(Sender).Tag and $ff;
     if Index>0 then begin
      Item:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index];
      APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index]:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index-1];
      APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index-1]:=Item;
      dec(NewIndex);
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   ScrollbarModulationMatrixItems.Position:=NewIndex;
   OldModulationMatrix:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.DoModulationMatrixItemDown(Sender: TObject);
var APlugin:TVSTiPlugin;
    Index,NewIndex:integer;
    Item:TSynthInstrumentModulationMatrixItem;
begin
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   NewIndex:=ScrollbarModulationMatrixItems.Position;
   AudioCriticalSection.Enter;
   try
    if assigned(Sender) and (Sender is TFormModulationMatrixItem) then begin
     APlugin:=TVSTiPlugin(Plugin);
     Index:=TFormModulationMatrixItem(Sender).Tag and $ff;
     if (Index+1)<APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrixItems then begin
      Item:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index];
      APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index]:=APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index+1];
      APlugin.Track.Instruments[APlugin.CurrentProgram].ModulationMatrix[Index+1]:=Item;
      inc(NewIndex);
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   ScrollbarModulationMatrixItems.Position:=NewIndex;
   OldModulationMatrix:=-1;
   EditorUpdate;
  end;
 end;
end;

procedure TVSTiEditor.CheckBoxInstrumentVoiceOscillatorOutputClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Output:=CheckBoxInstrumentVoiceOscillatorOutput.Checked;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorInputChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].Input:=ComboBoxInstrumentVoiceOscillatorInput.ItemIndex-1;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.ComboBoxInstrumentVoiceOscillatorHardSyncInputChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    ItemNr:integer;
begin
 ItemNr:=TabControlInstrumentVoiceOscillators.ActiveTab;
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].Oscillator[ItemNr].HardSyncInput:=ComboBoxInstrumentVoiceOscillatorHardSyncInput.ItemIndex-1;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.UpdateInstrumentTuning;
var APlugin:TVSTiPlugin;
    sl:TStringList;
    i:integer;
begin
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  try
   APlugin:=TVSTiPlugin(Plugin);
   sl:=TStringList.Create;
   try
    for i:=0 to 127 do begin
     sl.Add(BeRoConvertDoubleToString(APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i],pdtsmSTANDARD,0));
    end;
    SGTK0MemoTuningTable.Text:=sl.Text;
   finally
    sl.Free;
   end;
  finally
   DataCriticalSection.Leave;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonImportScaleFileClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    sl:TStringList;
    s,sa,sb,Desc,Desc2:string;
    i,j,k:longint;
    LUTRatios:array[0..127] of boolean;
    LUTValues:array[0..127] of double;
    Base,BaseFreq:double;
begin
 if OpenDialogScaleFile.Execute then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    sl:=TStringList.Create;
    try
     sl.LoadFromFile(OpenDialogScaleFile.FileName);
     if lowercase(ExtractFileExt(OpenDialogScaleFile.FileName))='.scl' then begin
      Desc:='';
      Desc2:='';
      j:=0;
      for i:=0 to sl.Count-1 do begin
       if j>=128 then begin
        break;
       end;
       s:=trim(sl[i]);
       if (length(s)>0) and (pos('!',s)=0) then begin
        if length(Desc)=0 then begin
         Desc:=s;
        end else if length(Desc2)=0 then begin
         Desc2:=s;
        end else begin
         if pos('.',s)>0 then begin
          // Cents
          s:=Parse(s,[#0..#32]);
          LUTRatios[j]:=false;
          LUTValues[j]:=BeRoConvertStringToDouble(s);
         end else begin
          // Ratio
          sa:=trim(Parse(s,'/'));
          sb:=trim(Parse(s,[#0..#32]));
          LUTRatios[j]:=true;
          if length(sb)=0 then begin
           LUTValues[j]:=BeRoConvertStringToDouble(sa);
          end else begin
           LUTValues[j]:=BeRoConvertStringToDouble(sb);
           if LUTValues[j]=0 then begin
            LUTValues[j]:=1;
           end;
           LUTValues[j]:=BeRoConvertStringToDouble(sa)/LUTValues[j];
          end;
         end;
         inc(j);
        end;
       end;
      end;

      Base:=0;
      APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[0]:=Base;
      BaseFreq:=power(2,4.0313842+Base);
      i:=1;
      while i<128 do begin
       for k:=0 to j-1 do begin
        if LUTRatios[k] then begin
         APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=(ln(BaseFreq*LUTValues[k])/ln(2))-4.0313842;
        end else begin
         APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=Base+(LUTValues[k]/1200.0);
        end;
        inc(i);
        if i>127 then begin
         break;
        end;
       end;
       Base:=APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i-1];
       BaseFreq:=power(2,4.0313842+Base);
      end;
      for i:=0 to 127 do begin
       APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]*12.0;
      end;

     end else if lowercase(ExtractFileExt(OpenDialogScaleFile.FileName))='.mtd' then begin

      for i:=0 to 127 do begin
       APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=i;
      end;
      
      j:=0;
      for i:=0 to sl.Count-1 do begin
       if j>=128 then begin
        break;
       end;
       s:=trim(sl[i]);
       if (length(s)>0) and (pos('!',s)=0) then begin
        APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[j]:=BeRoConvertStringToDouble(Parse(s,[#0..#32]));
        inc(j);
       end;
      end;

     end else begin
      for i:=0 to 127 do begin
       APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=i;
      end;
     end;
    finally
     sl.Free;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
 UpdateInstrumentTuning;
end;

procedure TVSTiEditor.SGTK0ButtonInstrumentTuningParseClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    sl:TStringList;
    s,sa,sb,Desc,Desc2:string;
    i,j,k:longint;
    LUTRatios:array[0..127] of boolean;
    LUTValues:array[0..127] of double;
    Base,BaseFreq:double;
begin
 begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    sl:=TStringList.Create;
    try
     sl.Text:=SGTK0MemoTuningTable.Text;
     if sl.Count>0 then begin
      if lowercase(trim(sl[0]))='!scl' then begin
       Desc:='';
       Desc2:='';
       j:=0;
       for i:=0 to sl.Count-1 do begin
        if j>=128 then begin
         break;
        end;
        s:=trim(sl[i]);
        if (length(s)>0) and (pos('!',s)=0) then begin
         if length(Desc)=0 then begin
          Desc:=s;
         end else if length(Desc2)=0 then begin
          Desc2:=s;
         end else begin
          if pos('.',s)>0 then begin
           // Cents
           s:=Parse(s,[#0..#32]);
           LUTRatios[j]:=false;
           LUTValues[j]:=BeRoConvertStringToDouble(s);
          end else begin
           // Ratio
           sa:=trim(Parse(s,'/'));
           sb:=trim(Parse(s,[#0..#32]));
           LUTRatios[j]:=true;
           if length(sb)=0 then begin
            LUTValues[j]:=BeRoConvertStringToDouble(sa);
           end else begin
            LUTValues[j]:=BeRoConvertStringToDouble(sb);
            if LUTValues[j]=0 then begin
             LUTValues[j]:=1;
            end;
            LUTValues[j]:=BeRoConvertStringToDouble(sa)/LUTValues[j];
           end;
          end;
          inc(j);
         end;
        end;
       end;

       Base:=0;
       APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[0]:=Base;
       BaseFreq:=power(2,4.0313842+Base);
       i:=1;
       while i<128 do begin
        for k:=0 to j-1 do begin
         if LUTRatios[k] then begin
          APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=(ln(BaseFreq*LUTValues[k])/ln(2))-4.0313842;
         end else begin
          APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=Base+(LUTValues[k]/1200.0);
         end;
         inc(i);
         if i>127 then begin
          break;
         end;
        end;
        Base:=APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i-1];
        BaseFreq:=power(2,4.0313842+Base);
       end;
       for i:=0 to 127 do begin
        APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]*12.0;
       end;

      end else begin

       for i:=0 to 127 do begin
        APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[i]:=i;
       end;
      
       j:=0;
       for i:=0 to sl.Count-1 do begin
        if j>=128 then begin
         break;
        end;
        s:=trim(sl[i]);
        if (length(s)>0) and (pos('!',s)=0) then begin
         APlugin.Track.Instruments[APlugin.CurrentProgram].TuningTable[j]:=BeRoConvertStringToDouble(Parse(s,[#0..#32]));
         inc(j);
        end;
       end;

      end;
     end;
    finally
     sl.Free;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
 UpdateInstrumentTuning;
end;

procedure TVSTiEditor.CheckBoxInstrumentUseTuningTableClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Instruments[APlugin.CurrentProgram].UseTuningTable:=CheckBoxInstrumentUseTuningTable.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonScaleExportClick(Sender: TObject);
begin
 if SaveDialogTuning.Execute then begin
  SGTK0MemoTuningTable.Lines.SaveToFile(SaveDialogTuning.FileName);
 end;
end;

procedure TVSTiEditor.SGTK0ButtonInstrumentSampleScriptGenerateClick(
  Sender: TObject);
var PascalScript:TBeRoPascalScript;
    APlugin:TVSTiPlugin;
    index:integer;
    OK:boolean;
begin
 case SGTK0ComboBoxInstrumentSampleScriptLanguage.ItemIndex of
  0:begin
   try
    PascalScript:=TBeRoPascalScript.Create;
    try
     OK:=false;
     try
//      PascalScript.Compile(SynMemoInstrumentSampleScriptCode.Text);
      PascalScript.Run;
      OK:=true;
     except
      on e:Exception do begin
       MessageBox(Handle,pchar(e.Message),'Script error',MB_OK OR MB_ICONERROR);
      end;
     end;
     if OK then begin
      if (PascalScript.SampleLength*PascalScript.SampleChannels)<=length(PascalScript.Sample) then begin
       if not InChange then begin
        if assigned(AudioCriticalSection) then begin
         AudioCriticalSection.Enter;
         try
          APlugin:=TVSTiPlugin(Plugin);
          index:=ComboBoxSamples.ItemIndex;
          if (index>=0) and (index<MaxSamples) then begin
           APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Samples:=PascalScript.SampleLength;
           APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.Channels:=PascalScript.SampleChannels;
           APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Header.SampleRate:=PascalScript.SampleRate;
           if assigned(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data) then begin
            FREEMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data);
            APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data:=nil;
           end;
           GETMEM(APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data,PascalScript.SampleLength*PascalScript.SampleChannels*sizeof(single));
           MOVE(PascalScript.Sample[0],APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index].Data^,PascalScript.SampleLength*PascalScript.SampleChannels*sizeof(single));
          end;
          SynthInitSample(@APlugin.Track,@APlugin.Track.Samples[APlugin.CurrentProgram and $7f,index]);
          CalculatePhaseSamples;
         finally
          AudioCriticalSection.Leave;
         end;
        end;
       end;
      end;
     end;
    finally
     PascalScript.Free;
    end;
   except
   end;
  end;
 end;
 SamplesUpdate;
end;

procedure TVSTiEditor.SGTK0ButtonInstrumentSampleGetExampleClick(
  Sender: TObject);
begin
 if  MessageBox(Handle,'Overwrite the current script code?','BR808',MB_YESNO OR MB_ICONQUESTION)=ID_YES then begin
  case SGTK0ComboBoxInstrumentSampleScriptLanguage.ItemIndex of
   0:begin
{   SynMemoInstrumentSampleScriptCode.Text:='program example;'+#13#10+
                                            'var'+#13#10+
                                            '  i : integer;'+#13#10+
                                            '  f, v : single;'+#13#10+
                                            'begin'+#13#10+
                                            '  SetSampleLength(44100); // in samples'+#13#10+
                                            '  SetSampleChannels(2); // 1=mono, 2=stereo'+#13#10+
                                            '  SetSampleRate(44100); // the sample rate'+#13#10+
                                            '  f := (440 * (2 * pi)) / 44100.0;'+#13#10+
                                            '  for i := 0 to 44099 do'+#13#10+
                                            '  begin'+#13#10+
                                            '    v := sin(i * f);'+#13#10+
                                            '    SetSample(i * 2, v); // left'+#13#10+
                                            '    SetSample((i * 2) + 1, v); // right'+#13#10+
                                            '  end;'+#13#10+
                                            'end.';   }
   end;
  end;
  //SynMemoInstrumentSampleScriptCodeChange(SynMemoInstrumentSampleScriptCode);
 end;
end;

procedure TVSTiEditor.Undo2Click(Sender: TObject);
begin
//SynMemoInstrumentSampleScriptCode.Undo;
end;

procedure TVSTiEditor.Redo2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.Redo;
end;

procedure TVSTiEditor.Cut2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.CutToClipboard;
end;

procedure TVSTiEditor.Copy2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.CopyToClipboard;
end;

procedure TVSTiEditor.Paste2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.PasteFromClipboard;
end;

procedure TVSTiEditor.Delete2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.SelText:='';
end;

procedure TVSTiEditor.Selectall2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.SelectAll;
end;

procedure TVSTiEditor.Unselectall2Click(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.SelLength:=0;
end;

procedure TVSTiEditor.PopupMenuEditorPopup(Sender: TObject);
begin
{Undo2.Enabled:=SynMemoInstrumentSampleScriptCode.CanUndo;
 Redo2.Enabled:=SynMemoInstrumentSampleScriptCode.CanRedo;
 Cut2.Enabled:=SynMemoInstrumentSampleScriptCode.SelLength>0;
 Copy2.Enabled:=SynMemoInstrumentSampleScriptCode.SelLength>0;
 Paste2.Enabled:=SynMemoInstrumentSampleScriptCode.CanPaste;
 Delete2.Enabled:=SynMemoInstrumentSampleScriptCode.SelLength>0;
 SelectAll2.Enabled:=SynMemoInstrumentSampleScriptCode.Lines.Count>0;
 UnselectAll2.Enabled:=SynMemoInstrumentSampleScriptCode.SelLength>0;}
end;

procedure TVSTiEditor.SynMemoInstrumentSampleScriptCodeChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
//    APlugin.SampleScripts[APlugin.CurrentProgram and $7f,index and $7f]:=SynMemoInstrumentSampleScriptCode.Text;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ComboBoxInstrumentSampleScriptLanguageChange(
  Sender: TObject);
var APlugin:TVSTiPlugin;
    index:integer;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    index:=ComboBoxSamples.ItemIndex;
    if (index>=0) and (index<MaxSamples) then begin
     APlugin.SampleScriptLanguages[APlugin.CurrentProgram and $7f,index and $7f]:=SGTK0ComboBoxInstrumentSampleScriptLanguage.ItemIndex;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SynMemoInstrumentSampleScriptCodeEnter(
  Sender: TObject);
begin
//SynMemoInstrumentSampleScriptCode.SetBounds(0,0,605+16,260+63);
 DoSynMemoInstrumentSampleScriptCodeSelLength:=true;
end;

procedure TVSTiEditor.SynMemoInstrumentSampleScriptCodeExit(
  Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.SetBounds(16,260,605,63);
end;

procedure TVSTiEditor.SGTK0Panel84Click(Sender: TObject);
begin
 SGTK0Panel84.SetFocus;
end;

procedure TVSTiEditor.PanelSamplesLengthSamplesClick(Sender: TObject);
begin
 SGTK0Panel84.SetFocus;
end;

procedure TVSTiEditor.Panel1Click(Sender: TObject);
begin
 SGTK0Panel84.SetFocus;
end;

procedure TVSTiEditor.SGTK0Panel91Click(Sender: TObject);
begin
 SGTK0Panel84.SetFocus;
end;

procedure TVSTiEditor.SGTK0Panel94Click(Sender: TObject);
begin
 SGTK0Panel84.SetFocus;
end;

procedure TVSTiEditor.TabSheetSampleScriptShow(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.Visible:=true;
end;

procedure TVSTiEditor.TabSheetSampleScriptHide(Sender: TObject);
begin
// SynMemoInstrumentSampleScriptCode.Visible:=false;
end;

procedure TVSTiEditor.Panel9Click(Sender: TObject);
begin
 Panel9.SetFocus;
end;

procedure TVSTiEditor.Panel11Click(Sender: TObject);
begin
 Panel11.SetFocus;
end;

procedure TVSTiEditor.Label5Click(Sender: TObject);
begin
 Panel11.SetFocus;
end;

procedure TVSTiEditor.LabelModulationMatrixCountClick(Sender: TObject);
begin
 Panel11.SetFocus;
end;

procedure TVSTiEditor.SGTK0Panel71Click(Sender: TObject);
begin
 SGTK0Panel71.SetFocus;
end;

procedure TVSTiEditor.SGTK0CheckBoxFineOversampleClick(Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FineOversample:=SGTK0CheckBoxFineOversample.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0CheckBoxFineSincOversampleClick(
  Sender: TObject);
var APlugin:TVSTiPlugin;
begin
 if not InChange then begin
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    APlugin.Track.Global.FineSincOversample:=SGTK0CheckBoxFineSincOversample.Checked;
   finally
    DataCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ScrollbarOversampleOrderScroll(Sender: TObject;
  ScrollPos: Integer);
var APlugin:TVSTiPlugin;
    S:string;
begin
 S:=INTTOSTR(ScrollPos);
 while length(S)<3 do begin
  S:='0'+S;
 end;
 LabelOversampleOrder.Caption:=S;
 SGTK0ScrollbarOversampleOrder.Track.Caption:=inttostr(ScrollPos)+'x';
 if not InChange then begin
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   try
    APlugin:=TVSTiPlugin(Plugin);
    if APlugin.Track.Global.OversampleOrder<>ScrollPos then begin
     APlugin.Track.Global.OversampleOrder:=ScrollPos;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonSampleMultiLoadClick(Sender: TObject);
var WAVFile:TBeRoFileStream;
    i:integer;
begin
 OpenDialogWAV.Options:=OpenDialogWAV.Options+[ofAllowMultiSelect];
 if OpenDialogWAV.Execute then begin
  if OpenDialogWAV.Files.Count>0 then begin
   for i:=0 to OpenDialogWAV.Files.Count-1 do begin
   try
    WAVFile:=TBeRoFileStream.Create(OpenDialogWAV.Files[i]);
    try
     LoadWAVSample(WAVFile,(ComboBoxSamples.ItemIndex+i) and $7f);
    finally
     WAVFile.Free;
    end;
   except
   end;
   end;
   SamplesUpdate;
  end;
 end;
end;

procedure TVSTiEditor.SGTK0ButtonInstrumentClearClick(Sender: TObject);
var APlugin:TVSTiPlugin;
    SubCounter:integer;
begin
 if assigned(AudioCriticalSection) then begin
  if MessageBox(Handle,'Overwrite the current instrument preset with default initial preset values?','BR808',MB_YESNO OR MB_ICONQUESTION)=ID_YES then begin
   APlugin:=TVSTiPlugin(Plugin);
   AudioCriticalSection.Enter;
   try
    Synth.SynthInitInstrument(@APlugin.Track.Instruments[APlugin.CurrentProgram]);
    APlugin.ProgramNames[APlugin.CurrentProgram]:='';
    for SubCounter:=0 to MaxInstrumentEnvelopes-1 do begin
     APlugin.EnvelopeNames[APlugin.CurrentProgram,SubCounter]:='';
     APlugin.EnvelopesSettings[APlugin.CurrentProgram,SubCounter]:=APlugin.EnvelopeSettings;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].NodesCount:=0;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].NegValue:=0;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].PosValue:=0;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].LoopStart:=-1;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].LoopEnd:=-1;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].SustainLoopStart:=-1;
     APlugin.Track.Envelopes[APlugin.CurrentProgram,SubCounter].SustainLoopEnd:=-1;
    end;
    for SubCounter:=0 to MaxSamples-1 do begin
     APlugin.SampleNames[APlugin.CurrentProgram,SubCounter]:='';
     APlugin.SampleScripts[APlugin.CurrentProgram,SubCounter]:='';
     APlugin.SampleScriptLanguages[APlugin.CurrentProgram,SubCounter]:=0;
     ClearSample(SubCounter);
    end; 
    for SubCounter:=0 to MaxSpeechTexts-1 do begin
     APlugin.SpeechTextNames[APlugin.CurrentProgram,SubCounter]:='';
     APlugin.SpeechTexts[APlugin.CurrentProgram,SubCounter]:='';
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   if assigned(APlugin.VSTEditor) then begin
    APlugin.VSTEditor.UpdateEx;
   end;
  end;
 end;
end;

end.
