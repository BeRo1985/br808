object FormModulationMatrixitem: TFormModulationMatrixitem
  Left = 1672
  Top = 436
  BorderStyle = bsNone
  Caption = 'FormModulationMatrixItem'
  ClientHeight = 145
  ClientWidth = 195
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clAqua
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SGTK0Panel45: TSGTK0Panel
    Left = 0
    Top = 0
    Width = 195
    Height = 145
    Align = alClient
    TabOrder = 0
    UseDockManager = True
    BevelOuter = bvLowered
    object SGTK0Panel1: TSGTK0Panel
      Left = 29
      Top = 5
      Width = 162
      Height = 55
      TabOrder = 0
      UseDockManager = True
      BevelOuter = bvLowered
      object Label1: TLabel
        Left = 5
        Top = 5
        Width = 34
        Height = 13
        Caption = 'Source'
      end
      object ComboBoxSource: TSGTK0ComboBox
        Left = 43
        Top = 4
        Width = 115
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clAqua
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'NONE'
          'ADSR'
          'ENV'
          'LFO'
          'VALUE'
          'CONTROLLER'
          'NOTE'
          'VELOCITY'
          'KEYOFFVELOCITY'
          'AFTERTOUCH'
          'MODULATION'
          'BREATH'
          'VOLUME'
          'EXPRESSION'
          'PANNING'
          'PORTA-TIME'
          'FOOTPEDAL'
          'HOLDPEDAL'
          'PORTAMENTOPEDAL'
          'SOSTENUTOPEDAL'
          'SOFTPEDAL'
          'LEGATOPEDAL'
          'HOLD2PEDAL'
          'VALUE EXT'
          'RESCALE'
          'INV RESCALE'
          'MEMORY'
          'NRPN')
        ParentFont = False
        TabOrder = 0
        ItemIndex = -1
        OnChange = ComboBoxSourceChange
      end
      object ComboBoxSourceIndex: TSGTK0ComboBox
        Left = 100
        Top = 29
        Width = 58
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        ItemIndex = -1
        OnChange = ComboBoxSourceIndexChange
      end
      object SGTK0ComboBoxSourceMode: TSGTK0ComboBox
        Left = 43
        Top = 29
        Width = 56
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clAqua
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        Items.Strings = (
          'linear'
          'x^2'
          'x^0.5'
          'sin1/4'
          'cos1/4')
        ParentFont = False
        TabOrder = 2
        ItemIndex = -1
        OnChange = SGTK0ComboBoxSourceModeChange
      end
      object SGTK0CheckBoxInverse: TSGTK0CheckBox
        Left = 6
        Top = 19
        Width = 37
        Height = 17
        Caption = 'Inv'
        ParentColor = False
        TabOrder = 3
        TabStop = True
        OnClick = SGTK0CheckBoxInverseClick
      end
      object SGTK0CheckBoxRamping: TSGTK0CheckBox
        Left = 6
        Top = 34
        Width = 35
        Height = 17
        Hint = 'Ramping'
        Caption = 'Ramp'
        ParentColor = False
        ShowHint = True
        TabOrder = 4
        TabStop = True
        OnClick = SGTK0CheckBoxRampingClick
      end
    end
    object SGTK0Panel2: TSGTK0Panel
      Left = 29
      Top = 63
      Width = 162
      Height = 55
      TabOrder = 1
      UseDockManager = True
      BevelOuter = bvLowered
      object Label2: TLabel
        Left = 5
        Top = 5
        Width = 31
        Height = 13
        Caption = 'Target'
      end
      object ComboBoxTarget: TSGTK0ComboBox
        Left = 43
        Top = 5
        Width = 115
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        Items.Strings = (
          'GlobalChnVol'
          'GlobalOutput'
          'GlobalReverb'
          'GlobalDelay'
          'GlobalCh.Fl.'
          'Volume'
          'Panning'
          'Transpose'
          'Pitch'
          'Osc Transpose'
          'Osc Pitch'
          'Osc FeedBack'
          'Osc Color'
          'Osc Volume'
          'Osc HardSync'
          'Osc Glide'
          'Osc SmpPos'
          'Osc Reflection'
          'Osc Pick'
          'Osc PickUp'
          'Osc SODetune'
          'Osc SOMix'
          'Filter CutOff'
          'Filter Resonance'
          'Filter Volume'
          'Filter Amplify'
          'ADSR Attack'
          'ADSR Decay'
          'ADSR Sustain'
          'ADSR Release'
          'ADSR DecayLevel'
          'ADSR Amplify'
          'Envelope Amplify'
          'LFO Rate'
          'LFO Phase'
          'LFO Depth'
          'LFO Middle'
          'VoiceDist Gain'
          'VoiceDist Dist'
          'VoiceDist Rate'
          'ChnDist Gain'
          'ChnDist Dist'
          'ChnDist Rate'
          'ChnFilter CutOff'
          'ChnFilter Resonance'
          'ChnFilter Volume'
          'ChnFilter Amplify'
          'ChnDelay TimeLeft'
          'ChnDelay FeedBackLeft'
          'ChnDelay TimeRight'
          'ChnDelay FeedBackRight'
          'ChnDelay Wet'
          'ChnDelay Dry'
          'ChnChrFla TimeLeft'
          'ChnChrFla FeedBackLeft'
          'ChnChrFla LFORateLeft'
          'ChnChrFla LFODepthLeft'
          'ChnChrFla LFOPhaseLeft'
          'ChnChrFla TimeRight'
          'ChnChrFla FeedBackRight'
          'ChnChrFla LFORateRight'
          'ChnChrFla LFODepthRight'
          'ChnChrFla LFOPhaseRight'
          'ChnChrFla Wet'
          'ChnChrFla Dry'
          'ChnComp Window'
          'ChnComp SoftHardKnee'
          'ChnComp Threshold'
          'ChnComp Ratio'
          'ChnComp Attack'
          'ChnComp Release'
          'ChnComp OutGain'
          'ChnSpeech TxtNr'
          'ChnSpeech Speed'
          'ChnSpeech Color'
          'ChnSpeech NoGa'
          'ChnSpeech Gain'
          'ChnSpeech Pos'
          'ChnSpeech CaGa'
          'ChnSpeech PaGa'
          'ChnSpeech AsGa'
          'ChnSpeech PaGa'
          'ChnPiSh Tune'
          'ChnPiSh FineTune'
          'ChnEQ Gain1'
          'ChnEQ Gain2'
          'ChnEQ Gain3'
          'ChnEQ Gain4'
          'ChnEQ Gain5'
          'ChnEQ Gain6'
          'ChnEQ Gain7'
          'ChnEQ Gain8'
          'ChnEQ Gain9'
          'ChnEQ Gain10'
          'Memory')
        TabOrder = 0
        ItemIndex = -1
        OnChange = ComboBoxTargetChange
      end
      object ComboBoxTargetIndex: TSGTK0ComboBox
        Left = 43
        Top = 29
        Width = 115
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        ItemIndex = -1
        OnChange = ComboBoxTargetIndexChange
      end
      object SGTK0ButtonUp: TSGTK0Button
        Left = 2
        Top = 24
        Width = 18
        Height = 25
        Hint = 'Up'
        Caption = 'Up'
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = SGTK0ButtonUpClick
      end
      object SGTK0ButtonDown: TSGTK0Button
        Left = 21
        Top = 24
        Width = 20
        Height = 25
        Hint = 'Down'
        Caption = 'Dn'
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = SGTK0ButtonDownClick
      end
    end
    object ScrollbarAmount: TSGTK0Scrollbar
      Left = 29
      Top = 122
      Width = 162
      Height = 17
      Min = -64
      Max = 64
      Kind = sbHorizontal
      OnScroll = ScrollbarAmountScroll
      ButtonHighlightColor = 8355584
      ButtonBorderColor = clAqua
      ButtonFocusedColor = 8355584
      ButtonDownColor = 6316032
      ButtonColor = 2105344
      ThumbHighlightColor = 8355584
      ThumbBorderColor = clAqua
      ThumbFocusedColor = 8355584
      ThumbDownColor = 6316032
      ThumbColor = clAqua
      Color = 2105344
      ParentColor = False
    end
    object ListBoxPolarity: TSGTK0ListBox
      Left = 4
      Top = 30
      Width = 22
      Height = 88
      Items.Strings = (
        '*'
        'x'
        '+'
        '-'
        '/'
        ':')
      ItemHeight = 12
      Font.Charset = ANSI_CHARSET
      Font.Color = clAqua
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      OnClick = ListBoxPolarityClick
    end
    object PanelNr: TSGTK0Panel
      Left = 4
      Top = 5
      Width = 22
      Height = 21
      Caption = '000'
      TabOrder = 4
      UseDockManager = True
      BevelOuter = bvLowered
    end
    object ButtonDelete: TSGTK0Button
      Left = 4
      Top = 122
      Width = 22
      Height = 17
      Caption = 'Del'
      ParentColor = False
      TabOrder = 5
      OnClick = ButtonDeleteClick
    end
  end
end
