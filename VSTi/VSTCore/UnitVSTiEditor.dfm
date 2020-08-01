object VSTiEditor: TVSTiEditor
  Left = 1751
  Top = 209
  ActiveControl = PageControlInstrument
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'VSTiEditor'
  ClientHeight = 507
  ClientWidth = 1005
  Color = 2105344
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clAqua
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SGTK0Panel1X: TSGTK0Panel
    Left = 0
    Top = 0
    Width = 1005
    Height = 507
    ParentColor = True
    Align = alClient
    TabOrder = 0
    UseDockManager = True
    BevelOuter = bvLowered
    object TopPanel: TSGTK0Panel
      Left = 1
      Top = 1
      Width = 1003
      Height = 77
      ParentColor = True
      Align = alTop
      TabOrder = 0
      UseDockManager = True
      BevelOuter = bvNone
      object PanelTitle: TSGTK0Panel
        Left = 0
        Top = 0
        Width = 128
        Height = 77
        Cursor = crHandPoint
        Hint = 'Copyright (C) 2005-2007, Benjamin '#39'BeRo'#39' Rosseaux '
        Caption = 'BR808'
        Font.Charset = ANSI_CHARSET
        Font.Color = clAqua
        Font.Height = -32
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        Align = alLeft
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        UseDockManager = True
        OnClick = PanelTitleDblClick
        BevelOuter = bvNone
        object LabelTitleVersion: TLabel
          Left = 16
          Top = 54
          Width = 97
          Height = 14
          Cursor = crHandPoint
          Alignment = taCenter
          AutoSize = False
          Caption = 'Version 1.00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clAqua
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PanelTitleDblClick
        end
        object LabelTitleAuthor: TLabel
          Left = 16
          Top = 8
          Width = 97
          Height = 14
          Cursor = crHandPoint
          Alignment = taCenter
          AutoSize = False
          Caption = 'BeRo'#39's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clAqua
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = PanelTitleDblClick
        end
        object PanelCopyright: TSGTK0Panel
          Left = 0
          Top = 0
          Width = 128
          Height = 77
          Cursor = crHandPoint
          Font.Charset = ANSI_CHARSET
          Font.Color = clAqua
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          Align = alClient
          TabOrder = 0
          UseDockManager = True
          OnClick = PanelCopyrightDblClick
          BevelOuter = bvNone
          object LabelCopyright: TLabel
            Left = 6
            Top = 17
            Width = 117
            Height = 42
            Cursor = crHandPoint
            Alignment = taCenter
            AutoSize = False
            Caption = 'Copyright (C) 2004-2011, Benjamin '#39'BeRo'#39' Rosseaux'
            Color = 2105344
            Font.Charset = ANSI_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            WordWrap = True
            OnClick = PanelCopyrightDblClick
          end
        end
      end
      object Panel2: TSGTK0Panel
        Left = 129
        Top = 0
        Width = 874
        Height = 77
        Align = alClient
        TabOrder = 1
        UseDockManager = True
        BevelOuter = bvNone
        BorderWidth = 5
        object Panel3: TSGTK0Panel
          Left = 7
          Top = 5
          Width = 56
          Height = 67
          Align = alLeft
          TabOrder = 0
          UseDockManager = True
          BevelOuter = bvLowered
          object PaintBoxPeakLeft: TPaintBox
            Left = 8
            Top = 10
            Width = 16
            Height = 48
          end
          object PaintBoxPeakRight: TPaintBox
            Left = 32
            Top = 10
            Width = 16
            Height = 48
          end
        end
        object Panel10: TSGTK0Panel
          Left = 63
          Top = 5
          Width = 5
          Height = 67
          ParentColor = True
          Align = alLeft
          TabOrder = 1
          UseDockManager = True
          BevelOuter = bvNone
        end
        object PanelTop: TSGTK0Panel
          Left = 68
          Top = 5
          Width = 801
          Height = 67
          Align = alClient
          TabOrder = 2
          UseDockManager = True
          BevelOuter = bvLowered
          object LabelColorR: TLabel
            Left = 770
            Top = 22
            Width = 23
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '000'
            Font.Charset = ANSI_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
          end
          object Label90: TLabel
            Left = 576
            Top = 22
            Width = 20
            Height = 13
            Alignment = taRightJustify
            Caption = 'Red'
          end
          object Label108: TLabel
            Left = 568
            Top = 35
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = 'Green'
          end
          object Label110: TLabel
            Left = 577
            Top = 48
            Width = 21
            Height = 13
            Alignment = taRightJustify
            Caption = 'Blue'
          end
          object LabelColorG: TLabel
            Left = 770
            Top = 35
            Width = 23
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '000'
            Font.Charset = ANSI_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
          end
          object LabelColorB: TLabel
            Left = 770
            Top = 48
            Width = 23
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '000'
            Font.Charset = ANSI_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
          end
          object SGTK0Panel176: TSGTK0Panel
            Left = 562
            Top = 2
            Width = 1
            Height = 69
            Caption = 'SGTK0Panel176'
            TabOrder = 0
            UseDockManager = True
            BevelOuter = bvLowered
          end
          object SGTK0PanelMasterSlave: TSGTK0Panel
            Left = 750
            Top = 0
            Width = 51
            Height = 18
            Hint = 'Click here to make this instance to master'
            Caption = 'Single'
            TabOrder = 1
            UseDockManager = True
            OnClick = SGTK0PanelMasterSlaveClick
            BevelOuter = bvLowered
          end
          object SGTK0PanelInstanceCount: TSGTK0Panel
            Left = 676
            Top = 0
            Width = 75
            Height = 18
            Caption = '1 instances'
            TabOrder = 2
            UseDockManager = True
            BevelOuter = bvLowered
          end
          object SGTK0ScrollbarColorR: TSGTK0Scrollbar
            Left = 604
            Top = 22
            Width = 160
            Height = 14
            Min = -255
            Max = 255
            Kind = sbHorizontal
            OnScroll = SGTK0ScrollbarColorRScroll
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
          object SGTK0ScrollbarColorG: TSGTK0Scrollbar
            Left = 604
            Top = 35
            Width = 160
            Height = 14
            Min = -255
            Max = 255
            Kind = sbHorizontal
            OnScroll = SGTK0ScrollbarColorGScroll
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
          object SGTK0ScrollbarColorB: TSGTK0Scrollbar
            Left = 604
            Top = 48
            Width = 160
            Height = 14
            Min = -255
            Max = 255
            Kind = sbHorizontal
            OnScroll = SGTK0ScrollbarColorBScroll
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
          object SGTK0Panel195: TSGTK0Panel
            Left = 562
            Top = 0
            Width = 115
            Height = 18
            TabOrder = 6
            UseDockManager = True
            BevelOuter = bvLowered
            object CheckBoxSSE: TSGTK0CheckBox
              Left = 72
              Top = 1
              Width = 41
              Height = 14
              Caption = 'SSE'
              ParentColor = False
              TabOrder = 0
              TabStop = True
              OnClick = CheckBoxSSEClick
            end
            object SGTK0Panel193: TSGTK0Panel
              Left = 66
              Top = 0
              Width = 1
              Height = 17
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
            end
            object CheckBoxMultithreading: TSGTK0CheckBox
              Left = 5
              Top = 1
              Width = 59
              Height = 14
              Caption = 'Threads'
              ParentColor = False
              TabOrder = 2
              TabStop = True
              OnClick = CheckBoxMultithreadingClick
            end
          end
          object PanelTopViewChnStates: TSGTK0Panel
            Left = 0
            Top = 0
            Width = 563
            Height = 67
            TabOrder = 7
            UseDockManager = True
            OnClick = PanelTopViewChnStatesClick
            BevelOuter = bvLowered
            object Label1: TLabel
              Left = 8
              Top = 8
              Width = 28
              Height = 14
              Caption = 'Chn#'
              Font.Charset = ANSI_CHARSET
              Font.Color = clAqua
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              OnClick = Label1Click
            end
            object Label2: TLabel
              Left = 8
              Top = 25
              Width = 28
              Height = 14
              Caption = 'Prg#'
              Font.Charset = ANSI_CHARSET
              Font.Color = clAqua
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              OnClick = Label2Click
            end
            object Label3: TLabel
              Left = 8
              Top = 42
              Width = 28
              Height = 14
              Caption = 'Poly'
              Font.Charset = ANSI_CHARSET
              Font.Color = clAqua
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              OnClick = Label3Click
            end
            object Label4: TLabel
              Left = 507
              Top = 43
              Width = 14
              Height = 14
              Caption = '->'
              Font.Charset = ANSI_CHARSET
              Font.Color = clAqua
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              OnClick = Label4Click
            end
            object PanelGlobalPoly: TSGTK0Panel
              Left = 526
              Top = 42
              Width = 28
              Height = 16
              Caption = '00'
              ParentColor = True
              TabOrder = 0
              UseDockManager = True
              OnClick = PanelGlobalPolyClick
              BevelOuter = bvLowered
            end
            object SGTK0PanelCPUTime: TSGTK0Panel
              Left = 506
              Top = 8
              Width = 49
              Height = 16
              Caption = '0%'
              TabOrder = 1
              UseDockManager = True
              OnClick = SGTK0PanelCPUTimeClick
              BevelOuter = bvLowered
            end
          end
          object PanelTopViewGraphics: TSGTK0Panel
            Left = 0
            Top = 0
            Width = 563
            Height = 67
            TabOrder = 8
            UseDockManager = True
            OnClick = PanelTopViewGraphicsClick
            BevelOuter = bvLowered
            object ImageTopViewGraphics: TImage
              Left = 1
              Top = 1
              Width = 561
              Height = 65
              Align = alClient
              OnClick = ImageTopViewGraphicsClick
            end
          end
        end
        object SGTK0Panel5: TSGTK0Panel
          Left = 5
          Top = 5
          Width = 2
          Height = 67
          ParentColor = True
          Align = alLeft
          TabOrder = 3
          UseDockManager = True
          BevelOuter = bvNone
        end
      end
      object SGTK0Panel4: TSGTK0Panel
        Left = 128
        Top = 0
        Width = 1
        Height = 77
        ParentColor = True
        Align = alLeft
        TabOrder = 2
        UseDockManager = True
        BevelOuter = bvLowered
      end
    end
    object PageControlGlobal: TSGTK0PageControl
      Left = 1
      Top = 79
      Width = 1003
      Height = 427
      Align = alClient
      BorderWidth = 2
      Tabs.Strings = (
        'Instruments'
        'Globals'
        'Export')
      Color = 2105344
      ParentColor = False
      TabOrder = 1
      ActivePage = TabSheetInstruments
      object TabSheetInstruments: TSGTK0TabSheet
        BorderWidth = 1
        Caption = 'Instruments'
        object Panel5: TSGTK0Panel
          Left = 0
          Top = 0
          Width = 744
          Height = 403
          Caption = '0'
          ParentColor = True
          Align = alClient
          TabOrder = 0
          UseDockManager = True
          BevelOuter = bvLowered
          BorderWidth = 1
          object Panel7: TSGTK0Panel
            Left = 2
            Top = 2
            Width = 740
            Height = 399
            ParentColor = True
            Align = alClient
            TabOrder = 0
            UseDockManager = True
            BevelOuter = bvNone
            object Panel21: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 740
              Height = 399
              ParentColor = True
              Align = alClient
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvNone
              object Panel77: TSGTK0Panel
                Left = 0
                Top = 0
                Width = 740
                Height = 29
                ParentColor = True
                Align = alTop
                TabOrder = 0
                UseDockManager = True
                BevelOuter = bvLowered
                object Label7: TLabel
                  Left = 77
                  Top = 7
                  Width = 28
                  Height = 13
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Name'
                end
                object EditInstrumentName: TSGTK0Edit
                  Left = 111
                  Top = 4
                  Width = 356
                  Height = 21
                  ColorFocused = 3158016
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 0
                  OnChange = EditInstrumentNameChange
                end
                object PanelInstrumentNr: TSGTK0Panel
                  Left = 4
                  Top = 4
                  Width = 28
                  Height = 20
                  Cursor = crHandPoint
                  Caption = '000'
                  Color = 4210688
                  TabOrder = 1
                  UseDockManager = True
                  OnClick = PanelInstrumentNrClick
                  BevelOuter = bvLowered
                end
                object ButtonPreviousInstrument: TSGTK0Button
                  Left = 33
                  Top = 4
                  Width = 16
                  Height = 20
                  Caption = '<'
                  ParentColor = False
                  TabOrder = 2
                  OnClick = ButtonPreviousInstrumentClick
                end
                object ButtonNextInstrument: TSGTK0Button
                  Tag = 40
                  Left = 50
                  Top = 4
                  Width = 16
                  Height = 20
                  Caption = '>'
                  ParentColor = False
                  TabOrder = 3
                  OnClick = ButtonNextInstrumentClick
                end
                object ButtonSetToChannel: TSGTK0Button
                  Left = 471
                  Top = 4
                  Width = 77
                  Height = 21
                  Caption = 'set to channel'
                  ParentColor = False
                  TabOrder = 4
                  OnClick = ButtonSetToChannelClick
                end
                object ComboBoxInstrumentChannel: TSGTK0ComboBox
                  Left = 552
                  Top = 4
                  Width = 40
                  Height = 21
                  Style = csDropDownList
                  Items.Strings = (
                    '01'
                    '02'
                    '03'
                    '04'
                    '05'
                    '06'
                    '07'
                    '08'
                    '09'
                    '10'
                    '11'
                    '12'
                    '13'
                    '14'
                    '15'
                    '16')
                  TabOrder = 5
                  ItemIndex = -1
                end
                object SGTK0Panel8: TSGTK0Panel
                  Left = 70
                  Top = 4
                  Width = 1
                  Height = 21
                  ParentColor = True
                  TabOrder = 6
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object SGTK0ButtonImportFXP: TSGTK0Button
                  Left = 644
                  Top = 4
                  Width = 44
                  Height = 21
                  Hint = 'Import preset'
                  Caption = 'Import'
                  ParentColor = False
                  TabOrder = 7
                  OnClick = SGTK0ButtonImportFXPClick
                end
                object SGTK0ButtonExportFXP: TSGTK0Button
                  Left = 692
                  Top = 4
                  Width = 44
                  Height = 21
                  Hint = 'Export preset'
                  Caption = 'Export'
                  ParentColor = False
                  TabOrder = 8
                  OnClick = SGTK0ButtonExportFXPClick
                end
                object SGTK0ButtonInstrumentClear: TSGTK0Button
                  Left = 596
                  Top = 4
                  Width = 44
                  Height = 21
                  Hint = 'Clear preset'
                  Caption = 'Clear'
                  ParentColor = False
                  TabOrder = 9
                  OnClick = SGTK0ButtonInstrumentClearClick
                end
              end
              object Panel80: TSGTK0Panel
                Left = 0
                Top = 29
                Width = 740
                Height = 5
                ParentColor = True
                Align = alTop
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvNone
              end
              object PageControlInstrument: TSGTK0PageControl
                Left = 0
                Top = 34
                Width = 740
                Height = 365
                Align = alClient
                Tabs.Strings = (
                  'Globals'
                  'Voice'
                  'Channel'
                  'Samples'
                  'Speech'
                  'Link'
                  'Controller'
                  'Tunings')
                Color = 2105344
                ParentColor = False
                TabOrder = 2
                OnTabChanged = PageControlInstrumentTabChanged
                ActivePage = TabSheetInstrumentGlobals
                object TabSheetInstrumentGlobals: TSGTK0TabSheet
                  Caption = 'Globals'
                  object Panel46: TSGTK0Panel
                    Left = 0
                    Top = 0
                    Width = 738
                    Height = 347
                    Align = alClient
                    TabOrder = 0
                    UseDockManager = True
                    BevelOuter = bvNone
                    BorderWidth = 3
                    object PanelInstrumentGlobalCarry: TSGTK0Panel
                      Left = 501
                      Top = 4
                      Width = 232
                      Height = 27
                      ParentColor = True
                      TabOrder = 0
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object CheckBoxInstrumentGlobalCarry: TSGTK0CheckBox
                        Left = 4
                        Top = 5
                        Width = 217
                        Height = 17
                        Caption = 'Carry'
                        Checked = True
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentColor = False
                        ParentFont = False
                        TabOrder = 0
                        TabStop = True
                        OnClick = CheckBoxInstrumentGlobalCarryClick
                      end
                    end
                    object PanelInstrumentGlobalChannelVolume: TSGTK0Panel
                      Left = 5
                      Top = 34
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 1
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalChannelVolume: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Chn Vol'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalChannelVolume: TLabel
                        Left = 218
                        Top = 6
                        Width = 23
                        Height = 15
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollBarInstrumentGlobalChannelVolume: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Max = 255
                        Kind = sbHorizontal
                        OnScroll = ScrollBarInstrumentGlobalChannelVolumeScroll
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
                    end
                    object PanelInstrumentGlobalVolume: TSGTK0Panel
                      Left = 5
                      Top = 4
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 2
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalVolume: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Volume'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalVolume: TLabel
                        Left = 218
                        Top = 6
                        Width = 23
                        Height = 15
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollBarInstrumentGlobalVolume: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Max = 255
                        Kind = sbHorizontal
                        OnScroll = ScrollBarInstrumentGlobalVolumeScroll
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
                    end
                    object PanelInstrumentGlobalMaxPolyphony: TSGTK0Panel
                      Left = 253
                      Top = 34
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 3
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalMaxPolyphony: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Max Poly'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalMaxPolyphony: TLabel
                        Left = 216
                        Top = 6
                        Width = 23
                        Height = 15
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = '00'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollBarInstrumentGlobalMaxPolyphony: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Min = 1
                        Max = 99
                        Position = 1
                        Kind = sbHorizontal
                        OnScroll = ScrollBarInstrumentGlobalMaxPolyphonyScroll
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
                    end
                    object PanelInstrumentGlobalTranspose: TSGTK0Panel
                      Left = 253
                      Top = 4
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 4
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalTranspose: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Transpose'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalTranspose: TLabel
                        Left = 218
                        Top = 6
                        Width = 23
                        Height = 15
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollBarInstrumentGlobalTranspose: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Min = -128
                        Max = 127
                        Kind = sbHorizontal
                        OnScroll = ScrollBarInstrumentGlobalTransposeScroll
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
                    end
                    object PanelInstrumentGlobalChorusFlanger: TSGTK0Panel
                      Left = 253
                      Top = 95
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 5
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalChorusFlanger: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Chorus/F.'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalChorusFlanger: TLabel
                        Left = 216
                        Top = 6
                        Width = 23
                        Height = 15
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollbarInstrumentGlobalChorusFlanger: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Max = 255
                        Kind = sbHorizontal
                        OnScroll = ScrollbarInstrumentGlobalChorusFlangerScroll
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
                    end
                    object PanelInstrumentGlobalReverb: TSGTK0Panel
                      Left = 253
                      Top = 65
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 6
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalReverb: TLabel
                        Left = 5
                        Top = 6
                        Width = 49
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Reverb'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalReverb: TLabel
                        Left = 218
                        Top = 6
                        Width = 23
                        Height = 15
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollbarInstrumentGlobalReverb: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Max = 255
                        Kind = sbHorizontal
                        OnScroll = ScrollbarInstrumentGlobalReverbScroll
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
                    end
                    object PanelInstrumentGlobalDelay: TSGTK0Panel
                      Left = 5
                      Top = 95
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 7
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalDelay: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Delay'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalDelay: TLabel
                        Left = 218
                        Top = 6
                        Width = 23
                        Height = 15
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollbarInstrumentGlobalDelay: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Max = 255
                        Kind = sbHorizontal
                        OnScroll = ScrollbarInstrumentGlobalDelayScroll
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
                    end
                    object PanelInstrumentGlobalOutput: TSGTK0Panel
                      Left = 5
                      Top = 65
                      Width = 244
                      Height = 27
                      ParentColor = True
                      TabOrder = 8
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object LabelTitleInstrumentGlobalOutput: TLabel
                        Left = 4
                        Top = 6
                        Width = 50
                        Height = 13
                        Alignment = taRightJustify
                        AutoSize = False
                        Caption = 'Output'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        ParentFont = False
                      end
                      object LabelInstrumentGlobalOutput: TLabel
                        Left = 218
                        Top = 6
                        Width = 23
                        Height = 15
                        AutoSize = False
                        Caption = '000'
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                      end
                      object ScrollbarInstrumentGlobalOutput: TSGTK0Scrollbar
                        Left = 60
                        Top = 5
                        Width = 152
                        Height = 16
                        Max = 255
                        Kind = sbHorizontal
                        OnScroll = ScrollbarInstrumentGlobalOutputScroll
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
                    end
                  end
                end
                object TabSheetInstrumentVoice: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Voice'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object PageControlInstrumentVoice: TSGTK0PageControl
                    Left = 0
                    Top = 0
                    Width = 728
                    Height = 337
                    Align = alClient
                    Tabs.Strings = (
                      'Oscillators'
                      'ADSRs'
                      'Envelopes'
                      'LFOs'
                      'Filters'
                      'Distortion'
                      'Order')
                    Color = 2105344
                    ParentColor = False
                    TabOrder = 0
                    OnTabChanged = PageControlInstrumentVoiceTabChanged
                    ActivePage = TabSheetInstrumentVoiceOscillators
                    object TabSheetInstrumentVoiceOscillators: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Oscillators'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object TabControlInstrumentVoiceOscillators: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'MS Sans Serif'
                        Font.Style = []
                        Color = 2105344
                        ParentColor = False
                        ParentFont = False
                        TabOrder = 0
                        OnTabChanged = TabControlInstrumentVoiceOscillatorsTabChanged
                        object P1: TSGTK0Panel
                          Left = 1
                          Top = 24
                          Width = 714
                          Height = 284
                          Align = alBottom
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvNone
                          BorderWidth = 5
                          object SGTK0Panel174: TSGTK0Panel
                            Left = 477
                            Top = 5
                            Width = 232
                            Height = 138
                            TabOrder = 15
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label41: TLabel
                              Left = 6
                              Top = 4
                              Width = 221
                              Height = 13
                              Alignment = taCenter
                              AutoSize = False
                              Caption = 'Plucked String'
                            end
                            object Label42: TLabel
                              Left = 12
                              Top = 28
                              Width = 48
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Reflection'
                            end
                            object LabelInstrumentVoiceOscillatorPluckedStringReflection: TLabel
                              Left = 204
                              Top = 27
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label120: TLabel
                              Left = 39
                              Top = 50
                              Width = 21
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Pick'
                            end
                            object LabelInstrumentVoiceOscillatorPluckedStringPick: TLabel
                              Left = 204
                              Top = 49
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label122: TLabel
                              Left = 24
                              Top = 72
                              Width = 36
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Pick up'
                            end
                            object LabelInstrumentVoiceOscillatorPluckedStringPickUp: TLabel
                              Left = 204
                              Top = 71
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label124: TLabel
                              Left = 32
                              Top = 94
                              Width = 28
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Width'
                            end
                            object LabelInstrumentVoiceOscillatorPluckedStringDelayLineWidth: TLabel
                              Left = 204
                              Top = 93
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label126: TLabel
                              Left = 31
                              Top = 116
                              Width = 27
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Mode'
                            end
                            object ScrollbarInstrumentVoiceOscillatorPluckedStringReflection: TSGTK0Scrollbar
                              Left = 64
                              Top = 26
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorPluckedStringReflectionScroll
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
                            object ScrollbarInstrumentVoiceOscillatorPluckedStringPick: TSGTK0Scrollbar
                              Left = 64
                              Top = 48
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorPluckedStringPickScroll
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
                            object ScrollbarInstrumentVoiceOscillatorPluckedStringPickUp: TSGTK0Scrollbar
                              Left = 64
                              Top = 70
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorPluckedStringPickUpScroll
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
                            object ScrollbarInstrumentVoiceOscillatorPluckedStringDelayLineWidth: TSGTK0Scrollbar
                              Left = 64
                              Top = 92
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorPluckedStringDelayLineWidthScroll
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
                            object ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineMode: TSGTK0ComboBox
                              Left = 64
                              Top = 113
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Nearest'
                                'Linear'
                                'Lagrange'
                                'Cubic spline'
                                'Sinc'
                                'Allpass access'
                                'Allpass logic')
                              TabOrder = 4
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceOscillatorPluckedStringDelayLineModeChange
                            end
                            object SGTK0Panel48: TSGTK0Panel
                              Left = 0
                              Top = 20
                              Width = 233
                              Height = 1
                              TabOrder = 5
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                          end
                          object SGTK0Panel10: TSGTK0Panel
                            Left = 5
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 0
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label6: TLabel
                              Left = 9
                              Top = 8
                              Width = 49
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Waveform'
                            end
                            object ComboBoxInstrumentVoiceOscillatorWaveform: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'None'
                                'Sine'
                                'Triangle'
                                'Parabola'
                                'Pulse'
                                'Sawtooth Up'
                                'Sawtooth Down'
                                'SawTri'
                                'White Noise'
                                'Pink Noise'
                                'Gray Noise'
                                'Brown Noise'
                                'Blue Noise'
                                'Clip Noise'
                                'Gaussian Noise'
                                'Bandlimited Triangle'
                                'Bandlimited Parabola'
                                'Bandlimited Pulse'
                                'Bandlimited Sawtooth Up'
                                'Bandlimited Sawtooth Down'
                                'Plucked String'
                                'SuperOsc'
                                'Sample')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceOscillatorWaveformChange
                            end
                          end
                          object SGTK0Panel11: TSGTK0Panel
                            Left = 241
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label8: TLabel
                              Left = 13
                              Top = 8
                              Width = 45
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Synthesis'
                            end
                            object ComboBoxInstrumentVoiceOscillatorSynthesisType: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'None'
                                'Phase Modulation'
                                'Ring Modulation'
                                'Amplitude Modulation'
                                'Additive'
                                'Subtractive'
                                'Frequency Modulation'
                                'Phase Mul Modulation'
                                'Frequency Mul Modulation')
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceOscillatorSynthesisTypeChange
                            end
                          end
                          object SGTK0Panel12: TSGTK0Panel
                            Left = 5
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 2
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label9: TLabel
                              Left = 5
                              Top = 8
                              Width = 53
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Note Begin'
                            end
                            object Label10: TLabel
                              Left = 127
                              Top = 8
                              Width = 45
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Note End'
                            end
                            object ComboBoxInstrumentVoiceOscillatorNoteBegin: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 50
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'C-0'
                                'C#0'
                                'D-0'
                                'D#0'
                                'E-0'
                                'F-0'
                                'F#0'
                                'G-0'
                                'G#0'
                                'A-0'
                                'A#0'
                                'B-0'
                                'C-1'
                                'C#1'
                                'D-1'
                                'D#1'
                                'E-1'
                                'F-1'
                                'F#1'
                                'G-1'
                                'G#1'
                                'A-1'
                                'A#1'
                                'B-1'
                                'C-2'
                                'C#2'
                                'D-2'
                                'D#2'
                                'E-2'
                                'F-2'
                                'F#2'
                                'G-2'
                                'G#2'
                                'A-2'
                                'A#2'
                                'B-2'
                                'C-3'
                                'C#3'
                                'D-3'
                                'D#3'
                                'E-3'
                                'F-3'
                                'F#3'
                                'G-3'
                                'G#3'
                                'A-3'
                                'A#3'
                                'B-3'
                                'C-4'
                                'C#4'
                                'D-4'
                                'D#4'
                                'E-4'
                                'F-4'
                                'F#4'
                                'G-4'
                                'G#4'
                                'A-4'
                                'A#4'
                                'B-4'
                                'C-5'
                                'C#5'
                                'D-5'
                                'D#5'
                                'E-5'
                                'F-5'
                                'F#5'
                                'G-5'
                                'G#5'
                                'A-5'
                                'A#5'
                                'B-5'
                                'C-6'
                                'C#6'
                                'D-6'
                                'D#6'
                                'E-6'
                                'F-6'
                                'F#6'
                                'G-6'
                                'G#6'
                                'A-6'
                                'A#6'
                                'B-6'
                                'C-7'
                                'C#7'
                                'D-7'
                                'D#7'
                                'E-7'
                                'F-7'
                                'F#7'
                                'G-7'
                                'G#7'
                                'A-7'
                                'A#7'
                                'B-7'
                                'C-8'
                                'C#8'
                                'D-8'
                                'D#8'
                                'E-8'
                                'F-8'
                                'F#8'
                                'G-8'
                                'G#8'
                                'A-8'
                                'A#8'
                                'B-8'
                                'C-9'
                                'C#9'
                                'D-9'
                                'D#9'
                                'E-9'
                                'F-9'
                                'F#9'
                                'G-9'
                                'G#9'
                                'A-9'
                                'A#9'
                                'B-9')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              Text = 'C-0'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceOscillatorNoteBeginChange
                            end
                            object ComboBoxInstrumentVoiceOscillatorNoteEnd: TSGTK0ComboBox
                              Left = 179
                              Top = 5
                              Width = 50
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'C-0'
                                'C#0'
                                'D-0'
                                'D#0'
                                'E-0'
                                'F-0'
                                'F#0'
                                'G-0'
                                'G#0'
                                'A-0'
                                'A#0'
                                'B-0'
                                'C-1'
                                'C#1'
                                'D-1'
                                'D#1'
                                'E-1'
                                'F-1'
                                'F#1'
                                'G-1'
                                'G#1'
                                'A-1'
                                'A#1'
                                'B-1'
                                'C-2'
                                'C#2'
                                'D-2'
                                'D#2'
                                'E-2'
                                'F-2'
                                'F#2'
                                'G-2'
                                'G#2'
                                'A-2'
                                'A#2'
                                'B-2'
                                'C-3'
                                'C#3'
                                'D-3'
                                'D#3'
                                'E-3'
                                'F-3'
                                'F#3'
                                'G-3'
                                'G#3'
                                'A-3'
                                'A#3'
                                'B-3'
                                'C-4'
                                'C#4'
                                'D-4'
                                'D#4'
                                'E-4'
                                'F-4'
                                'F#4'
                                'G-4'
                                'G#4'
                                'A-4'
                                'A#4'
                                'B-4'
                                'C-5'
                                'C#5'
                                'D-5'
                                'D#5'
                                'E-5'
                                'F-5'
                                'F#5'
                                'G-5'
                                'G#5'
                                'A-5'
                                'A#5'
                                'B-5'
                                'C-6'
                                'C#6'
                                'D-6'
                                'D#6'
                                'E-6'
                                'F-6'
                                'F#6'
                                'G-6'
                                'G#6'
                                'A-6'
                                'A#6'
                                'B-6'
                                'C-7'
                                'C#7'
                                'D-7'
                                'D#7'
                                'E-7'
                                'F-7'
                                'F#7'
                                'G-7'
                                'G#7'
                                'A-7'
                                'A#7'
                                'B-7'
                                'C-8'
                                'C#8'
                                'D-8'
                                'D#8'
                                'E-8'
                                'F-8'
                                'F#8'
                                'G-8'
                                'G#8'
                                'A-8'
                                'A#8'
                                'B-8'
                                'C-9'
                                'C#9'
                                'D-9'
                                'D#9'
                                'E-9'
                                'F-9'
                                'F#9'
                                'G-9'
                                'G#9'
                                'A-9'
                                'A#9'
                                'B-9')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 1
                              Text = 'B-9'
                              ItemIndex = 119
                              OnChange = ComboBoxInstrumentVoiceOscillatorNoteEndChange
                            end
                            object SGTK0Panel204: TSGTK0Panel
                              Left = 115
                              Top = 0
                              Width = 1
                              Height = 28
                              Caption = 'SGTK0Panel22'
                              TabOrder = 2
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                          end
                          object SGTK0Panel13: TSGTK0Panel
                            Left = 241
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 3
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label139: TLabel
                              Left = 34
                              Top = 8
                              Width = 24
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Input'
                            end
                            object SGTK0Panel205: TSGTK0Panel
                              Left = 115
                              Top = 0
                              Width = 1
                              Height = 28
                              Caption = 'SGTK0Panel22'
                              TabOrder = 0
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceOscillatorOutput: TSGTK0CheckBox
                              Left = 122
                              Top = 6
                              Width = 81
                              Height = 17
                              Hint = 'Force mix to output'
                              Caption = 'Output'
                              ParentColor = False
                              ShowHint = True
                              TabOrder = 1
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceOscillatorOutputClick
                            end
                            object ComboBoxInstrumentVoiceOscillatorInput: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 50
                              Height = 21
                              Hint = 'Modulation source (index must be < current osc index)'
                              Style = csDropDownList
                              Items.Strings = (
                                'Last'
                                '1'
                                '2'
                                '3'
                                '4'
                                '5'
                                '6'
                                '7'
                                '8')
                              ParentShowHint = False
                              ShowHint = True
                              TabOrder = 2
                              Text = 'Last'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceOscillatorInputChange
                            end
                          end
                          object SGTK0Panel14: TSGTK0Panel
                            Left = 241
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 4
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label11: TLabel
                              Left = 10
                              Top = 8
                              Width = 48
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Feedback'
                            end
                            object LabelInstrumentVoiceOscillatorFeedback: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollBarInstrumentVoiceOscillatorFeedback: TSGTK0Scrollbar
                              Left = 62
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -256
                              Max = 256
                              Kind = sbHorizontal
                              OnScroll = ScrollBarInstrumentVoiceOscillatorFeedbackScroll
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
                          end
                          object SGTK0Panel15: TSGTK0Panel
                            Left = 5
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 5
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label12: TLabel
                              Left = 34
                              Top = 8
                              Width = 24
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Color'
                            end
                            object LabelInstrumentVoiceOscillatorColor: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorColor: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -64
                              Max = 64
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorColorScroll
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
                          end
                          object SGTK0Panel16: TSGTK0Panel
                            Left = 5
                            Top = 110
                            Width = 232
                            Height = 30
                            TabOrder = 6
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label13: TLabel
                              Left = 8
                              Top = 8
                              Width = 50
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Transpose'
                            end
                            object LabelInstrumentVoiceOscillatorTranspose: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorTranspose: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -128
                              Max = 127
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorTransposeScroll
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
                          end
                          object SGTK0Panel17: TSGTK0Panel
                            Left = 241
                            Top = 110
                            Width = 232
                            Height = 30
                            TabOrder = 7
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label15: TLabel
                              Left = 17
                              Top = 8
                              Width = 41
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Finetune'
                            end
                            object LabelInstrumentVoiceOscillatorFinetune: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorFinetune: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -100
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorFinetuneScroll
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
                          end
                          object SGTK0Panel18: TSGTK0Panel
                            Left = 5
                            Top = 145
                            Width = 232
                            Height = 30
                            TabOrder = 8
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label14: TLabel
                              Left = 6
                              Top = 8
                              Width = 52
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'PhaseStart'
                            end
                            object LabelInstrumentVoiceOscillatorPhaseStart: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorPhaseStart: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorPhaseStartScroll
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
                          end
                          object SGTK0Panel19: TSGTK0Panel
                            Left = 241
                            Top = 145
                            Width = 232
                            Height = 30
                            TabOrder = 9
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label17: TLabel
                              Left = 23
                              Top = 8
                              Width = 35
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Volume'
                            end
                            object LabelInstrumentVoiceOscillatorVolume: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorVolume: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorVolumeScroll
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
                          end
                          object SGTK0Panel20: TSGTK0Panel
                            Left = 5
                            Top = 179
                            Width = 232
                            Height = 30
                            TabOrder = 10
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label16: TLabel
                              Left = 34
                              Top = 8
                              Width = 24
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Glide'
                            end
                            object LabelInstrumentVoiceOscillatorGlide: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorGlide: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorGlideScroll
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
                          end
                          object SGTK0Panel21: TSGTK0Panel
                            Left = 241
                            Top = 179
                            Width = 232
                            Height = 30
                            TabOrder = 11
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceOscillatorHardsync: TSGTK0CheckBox
                              Left = 5
                              Top = 7
                              Width = 69
                              Height = 17
                              Hint = 'HardSync sender'
                              Caption = 'HardSync'
                              ParentColor = False
                              ShowHint = True
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceOscillatorHardsyncClick
                            end
                            object SGTK0Panel22: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceOscillatorCarry: TSGTK0CheckBox
                              Left = 123
                              Top = 7
                              Width = 96
                              Height = 17
                              Caption = 'Carry'
                              Checked = True
                              ParentColor = False
                              TabOrder = 2
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceOscillatorCarryClick
                            end
                            object ComboBoxInstrumentVoiceOscillatorHardSyncInput: TSGTK0ComboBox
                              Left = 70
                              Top = 5
                              Width = 44
                              Height = 21
                              Hint = 'HardSync source (index must be < current osc index)'
                              Style = csDropDownList
                              Items.Strings = (
                                'Last'
                                '1'
                                '2'
                                '3'
                                '4'
                                '5'
                                '6'
                                '7'
                                '8')
                              ParentShowHint = False
                              ShowHint = True
                              TabOrder = 3
                              Text = 'Last'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceOscillatorHardSyncInputChange
                            end
                          end
                          object PanelInstrumentVoiceOscillatorSample: TSGTK0Panel
                            Left = 5
                            Top = 246
                            Width = 232
                            Height = 30
                            Visible = False
                            TabOrder = 12
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceOscillatorSample: TLabel
                              Left = 23
                              Top = 8
                              Width = 35
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Sample'
                            end
                            object ComboBoxInstrumentVoiceOscillatorSample: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceOscillatorSampleChange
                            end
                          end
                          object SGTK0Panel108: TSGTK0Panel
                            Left = 241
                            Top = 213
                            Width = 232
                            Height = 30
                            TabOrder = 13
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceOscillatorPMFMExtendedMode: TSGTK0CheckBox
                              Left = 5
                              Top = 7
                              Width = 101
                              Height = 17
                              Caption = 'PM/FM Extmode'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceOscillatorPMFMExtendedModeClick
                            end
                            object CheckBoxInstrumentVoiceOscillatorRandomPhase: TSGTK0CheckBox
                              Left = 123
                              Top = 7
                              Width = 96
                              Height = 17
                              Caption = 'Random phase'
                              Checked = True
                              ParentColor = False
                              TabOrder = 1
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceOscillatorRandomPhaseClick
                            end
                            object SGTK0Panel7: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 2
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                          end
                          object SGTK0Panel168: TSGTK0Panel
                            Left = 241
                            Top = 246
                            Width = 232
                            Height = 30
                            TabOrder = 14
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label106: TLabel
                              Left = 27
                              Top = 8
                              Width = 31
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Target'
                            end
                            object SGTK0ComboBoxVoiceOscTarget: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 44
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                '1'
                                '2'
                                '3'
                                '4'
                                '5'
                                '6'
                                '7'
                                '8')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                            end
                            object SGTK0ButtonVoiceOscSwap: TSGTK0Button
                              Left = 110
                              Top = 5
                              Width = 57
                              Height = 21
                              Caption = 'Swap'
                              ParentColor = False
                              TabOrder = 1
                              OnClick = SGTK0ButtonVoiceOscSwapClick
                            end
                            object SGTK0ButtonVoiceOscCopy: TSGTK0Button
                              Left = 170
                              Top = 5
                              Width = 57
                              Height = 21
                              Caption = 'Copy'
                              ParentColor = False
                              TabOrder = 2
                              OnClick = SGTK0ButtonVoiceOscCopyClick
                            end
                          end
                          object SGTK0Panel53: TSGTK0Panel
                            Left = 477
                            Top = 141
                            Width = 232
                            Height = 138
                            TabOrder = 16
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label119: TLabel
                              Left = 6
                              Top = 4
                              Width = 221
                              Height = 13
                              Alignment = taCenter
                              AutoSize = False
                              Caption = 'Super Osc'
                            end
                            object Label125: TLabel
                              Left = 32
                              Top = 70
                              Width = 28
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Count'
                            end
                            object LabelInstrumentVoiceOscillatorSuperOscCount: TLabel
                              Left = 204
                              Top = 69
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label128: TLabel
                              Left = 25
                              Top = 92
                              Width = 35
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Detune'
                            end
                            object LabelInstrumentVoiceOscillatorSuperOscDetune: TLabel
                              Left = 204
                              Top = 91
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label130: TLabel
                              Left = 44
                              Top = 114
                              Width = 16
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Mix'
                            end
                            object LabelInstrumentVoiceOscillatorSuperOscMix: TLabel
                              Left = 204
                              Top = 113
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object Label132: TLabel
                              Left = 9
                              Top = 26
                              Width = 49
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Waveform'
                            end
                            object Label121: TLabel
                              Left = 31
                              Top = 48
                              Width = 27
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Mode'
                            end
                            object ScrollbarInstrumentVoiceOscillatorSuperOscCount: TSGTK0Scrollbar
                              Left = 64
                              Top = 68
                              Width = 134
                              Height = 17
                              Min = 1
                              Max = 9
                              Position = 1
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorSuperOscCountScroll
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
                            object ScrollbarInstrumentVoiceOscillatorSuperOscDetune: TSGTK0Scrollbar
                              Left = 64
                              Top = 90
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorSuperOscDetuneScroll
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
                            object ScrollbarInstrumentVoiceOscillatorSuperOscMix: TSGTK0Scrollbar
                              Left = 64
                              Top = 112
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorSuperOscMixScroll
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
                            object ComboBoxInstrumentVoiceOscillatorSuperOscWaveform: TSGTK0ComboBox
                              Left = 64
                              Top = 23
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'SawUp'
                                'SawDown'
                                'Sine'
                                'Triangle'
                                'Pulse'
                                'Parabola'
                                'Highpass SawUp'
                                'Highpass SawDown'
                                'Highpass Sine'
                                'Highpass Triangle'
                                'Highpass Pulse'
                                'Highpass Parabola'
                                'Bandlimited SawUp'
                                'Bandlimited SawDown'
                                'Bandlimited Sine'
                                'Bandlimited Triangle'
                                'Bandlimited Pulse'
                                'Bandlimited Parabola')
                              TabOrder = 3
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceOscillatorSuperOscWaveformChange
                            end
                            object SGTK0Panel87: TSGTK0Panel
                              Left = 0
                              Top = 20
                              Width = 233
                              Height = 1
                              TabOrder = 4
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object ComboBoxInstrumentVoiceOscillatorSuperOscMode: TSGTK0ComboBox
                              Left = 64
                              Top = 45
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Oldschool'
                                'Symmetric'
                                'Modern')
                              TabOrder = 5
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceOscillatorSuperOscModeChange
                            end
                          end
                          object SGTK0Panel88: TSGTK0Panel
                            Left = 5
                            Top = 213
                            Width = 232
                            Height = 30
                            TabOrder = 17
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelInstrumentVoiceOscillatorPanning: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceOscillatorPanning: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -64
                              Max = 64
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceOscillatorPanningScroll
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
                            object CheckBoxInstrumentVoiceOscillatorPanning: TSGTK0CheckBox
                              Left = 3
                              Top = 6
                              Width = 58
                              Height = 17
                              Caption = 'Panning'
                              ParentColor = False
                              TabOrder = 1
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceOscillatorPanningClick
                            end
                          end
                        end
                      end
                    end
                    object TabSheetInstrumentVoiceADSRs: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'ADSRs'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object TabControlInstrumentVoiceADSRs: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = TabControlInstrumentVoiceADSRsTabChanged
                        object P2: TSGTK0Panel
                          Left = 1
                          Top = 24
                          Width = 714
                          Height = 284
                          Align = alBottom
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvNone
                          BevelWidth = 4
                          object SGTK0Panel23: TSGTK0Panel
                            Left = 5
                            Top = 5
                            Width = 704
                            Height = 136
                            TabOrder = 0
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 5
                            object PaintBoxADSR: TPaintBox
                              Left = 6
                              Top = 6
                              Width = 692
                              Height = 124
                              Align = alClient
                              OnPaint = PaintBoxADSRPaint
                            end
                          end
                          object SGTK0Panel24: TSGTK0Panel
                            Left = 5
                            Top = 145
                            Width = 64
                            Height = 25
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel25: TSGTK0Panel
                            Left = 5
                            Top = 171
                            Width = 64
                            Height = 25
                            Caption = 'Attack'
                            TabOrder = 2
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel26: TSGTK0Panel
                            Left = 5
                            Top = 197
                            Width = 64
                            Height = 25
                            Caption = 'Decay'
                            TabOrder = 3
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel27: TSGTK0Panel
                            Left = 5
                            Top = 223
                            Width = 64
                            Height = 25
                            Caption = 'Sustain'
                            TabOrder = 4
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel28: TSGTK0Panel
                            Left = 5
                            Top = 249
                            Width = 64
                            Height = 25
                            Caption = 'Release'
                            TabOrder = 5
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel29: TSGTK0Panel
                            Left = 70
                            Top = 145
                            Width = 64
                            Height = 25
                            Caption = 'Mode'
                            TabOrder = 6
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel30: TSGTK0Panel
                            Left = 70
                            Top = 171
                            Width = 64
                            Height = 25
                            TabOrder = 7
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object ComboBoxInstrumentVoiceADSRAttack: TSGTK0ComboBox
                              Left = 2
                              Top = 2
                              Width = 60
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Off'
                                'Linear'
                                'Exp'
                                'Log')
                              TabOrder = 0
                              Text = 'Off'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceADSRAttackChange
                            end
                          end
                          object SGTK0Panel31: TSGTK0Panel
                            Left = 70
                            Top = 197
                            Width = 64
                            Height = 25
                            TabOrder = 8
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object ComboBoxInstrumentVoiceADSRDecay: TSGTK0ComboBox
                              Left = 2
                              Top = 2
                              Width = 60
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Off'
                                'Linear'
                                'Exp'
                                'Log')
                              TabOrder = 0
                              Text = 'Off'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceADSRDecayChange
                            end
                          end
                          object SGTK0Panel32: TSGTK0Panel
                            Left = 70
                            Top = 223
                            Width = 64
                            Height = 25
                            TabOrder = 9
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object ComboBoxInstrumentVoiceADSRSustain: TSGTK0ComboBox
                              Left = 2
                              Top = 2
                              Width = 60
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Off'
                                'On'
                                'Time')
                              TabOrder = 0
                              Text = 'Off'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceADSRSustainChange
                            end
                          end
                          object SGTK0Panel33: TSGTK0Panel
                            Left = 70
                            Top = 249
                            Width = 64
                            Height = 25
                            TabOrder = 10
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object ComboBoxInstrumentVoiceADSRRelease: TSGTK0ComboBox
                              Left = 2
                              Top = 2
                              Width = 60
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Off'
                                'Linear'
                                'Exp'
                                'Log')
                              TabOrder = 0
                              Text = 'Off'
                              ItemIndex = 0
                              OnChange = ComboBoxInstrumentVoiceADSRReleaseChange
                            end
                          end
                          object SGTK0Panel34: TSGTK0Panel
                            Left = 135
                            Top = 145
                            Width = 140
                            Height = 25
                            Caption = 'Time'
                            TabOrder = 11
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object SGTK0Panel35: TSGTK0Panel
                            Left = 135
                            Top = 171
                            Width = 140
                            Height = 25
                            TabOrder = 12
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelInstrumentVoiceADSRAttack: TLabel
                              Left = 114
                              Top = 5
                              Width = 21
                              Height = 14
                              Alignment = taRightJustify
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollBarInstrumentVoiceADSRAttack: TSGTK0Scrollbar
                              Left = 2
                              Top = 4
                              Width = 108
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollBarInstrumentVoiceADSRAttackScroll
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
                          end
                          object SGTK0Panel36: TSGTK0Panel
                            Left = 135
                            Top = 197
                            Width = 140
                            Height = 25
                            TabOrder = 13
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelInstrumentVoiceADSRDecay: TLabel
                              Left = 114
                              Top = 5
                              Width = 21
                              Height = 14
                              Alignment = taRightJustify
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollBarInstrumentVoiceADSRDecay: TSGTK0Scrollbar
                              Left = 2
                              Top = 4
                              Width = 108
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollBarInstrumentVoiceADSRDecayScroll
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
                          end
                          object SGTK0Panel37: TSGTK0Panel
                            Left = 135
                            Top = 223
                            Width = 140
                            Height = 25
                            TabOrder = 14
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelInstrumentVoiceADSRSustain: TLabel
                              Left = 114
                              Top = 5
                              Width = 21
                              Height = 14
                              Alignment = taRightJustify
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollBarInstrumentVoiceADSRSustain: TSGTK0Scrollbar
                              Left = 2
                              Top = 4
                              Width = 108
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollBarInstrumentVoiceADSRSustainScroll
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
                          end
                          object SGTK0Panel38: TSGTK0Panel
                            Left = 135
                            Top = 249
                            Width = 140
                            Height = 25
                            TabOrder = 15
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelInstrumentVoiceADSRRelease: TLabel
                              Left = 114
                              Top = 5
                              Width = 21
                              Height = 14
                              Alignment = taRightJustify
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollBarInstrumentVoiceADSRRelease: TSGTK0Scrollbar
                              Left = 2
                              Top = 4
                              Width = 108
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollBarInstrumentVoiceADSRReleaseScroll
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
                          end
                          object SGTK0Panel39: TSGTK0Panel
                            Left = 276
                            Top = 145
                            Width = 197
                            Height = 25
                            TabOrder = 16
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceADSRActive: TSGTK0CheckBox
                              Left = 4
                              Top = 4
                              Width = 82
                              Height = 17
                              Caption = 'Active'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceADSRActiveClick
                            end
                            object SGTK0Panel40: TSGTK0Panel
                              Left = 97
                              Top = 2
                              Width = 1
                              Height = 21
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceADSRActiveCheck: TSGTK0CheckBox
                              Left = 102
                              Top = 4
                              Width = 87
                              Height = 17
                              Caption = 'Active Check'
                              ParentColor = False
                              TabOrder = 2
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceADSRActiveCheckClick
                            end
                          end
                          object SGTK0Panel41: TSGTK0Panel
                            Left = 276
                            Top = 171
                            Width = 197
                            Height = 25
                            TabOrder = 17
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label18: TLabel
                              Left = 32
                              Top = 6
                              Width = 33
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Amplify'
                            end
                            object LabelInstrumentVoiceADSRAmplify: TLabel
                              Left = 171
                              Top = 5
                              Width = 21
                              Height = 14
                              Alignment = taRightJustify
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceADSRAmplify: TSGTK0Scrollbar
                              Left = 70
                              Top = 4
                              Width = 96
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceADSRAmplifyScroll
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
                          end
                          object SGTK0Panel42: TSGTK0Panel
                            Left = 276
                            Top = 197
                            Width = 197
                            Height = 25
                            TabOrder = 18
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label20: TLabel
                              Left = 5
                              Top = 6
                              Width = 60
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Decay Level'
                            end
                            object LabelInstrumentVoiceADSRDecayLevel: TLabel
                              Left = 171
                              Top = 5
                              Width = 21
                              Height = 14
                              Alignment = taRightJustify
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceADSRDecayLevel: TSGTK0Scrollbar
                              Left = 70
                              Top = 4
                              Width = 96
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceADSRDecayLevelScroll
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
                          end
                          object SGTK0Panel43: TSGTK0Panel
                            Left = 477
                            Top = 145
                            Width = 232
                            Height = 25
                            TabOrder = 19
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceADSRCarry: TSGTK0CheckBox
                              Left = 6
                              Top = 4
                              Width = 82
                              Height = 17
                              Caption = 'Carry'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceADSRCarryClick
                            end
                            object CheckBoxInstrumentVoiceADSRCenterise: TSGTK0CheckBox
                              Left = 122
                              Top = 5
                              Width = 75
                              Height = 17
                              Caption = 'Centerise'
                              ParentColor = False
                              TabOrder = 1
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceADSRCenteriseClick
                            end
                            object SGTK0Panel44: TSGTK0Panel
                              Left = 115
                              Top = -1
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 2
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                          end
                          object SGTK0Panel175: TSGTK0Panel
                            Left = 477
                            Top = 173
                            Width = 232
                            Height = 30
                            TabOrder = 20
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                        end
                      end
                    end
                    object TabSheetInstrumentVoiceEnvelopes: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Envelopes'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object TabControlInstrumentVoiceEnvelopes: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = TabControlInstrumentVoiceEnvelopesTabChanged
                        object P3: TSGTK0Panel
                          Left = 1
                          Top = 24
                          Width = 714
                          Height = 284
                          Align = alBottom
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvNone
                          BevelWidth = 4
                          object SGTK0Panel45: TSGTK0Panel
                            Left = 241
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 0
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceEnvelopeCarry: TSGTK0CheckBox
                              Left = 8
                              Top = 6
                              Width = 82
                              Height = 17
                              Caption = 'Carry'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceEnvelopeCarryClick
                            end
                            object SGTK0Panel46: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceEnvelopeCenterise: TSGTK0CheckBox
                              Left = 124
                              Top = 7
                              Width = 87
                              Height = 17
                              Caption = 'Centerise'
                              ParentColor = False
                              TabOrder = 2
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceEnvelopeCenteriseClick
                            end
                          end
                          object SGTK0Panel49: TSGTK0Panel
                            Left = 5
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceEnvelopeActive: TSGTK0CheckBox
                              Left = 8
                              Top = 7
                              Width = 82
                              Height = 17
                              Caption = 'Active'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceEnvelopeActiveClick
                            end
                            object SGTK0Panel50: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceEnvelopeActiveCheck: TSGTK0CheckBox
                              Left = 124
                              Top = 7
                              Width = 87
                              Height = 17
                              Caption = 'Active Check'
                              ParentColor = False
                              TabOrder = 2
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceEnvelopeActiveCheckClick
                            end
                          end
                          object SGTK0Panel47: TSGTK0Panel
                            Left = 477
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 2
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label19: TLabel
                              Left = 25
                              Top = 8
                              Width = 33
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Amplify'
                            end
                            object LabelInstrumentVoiceEnvelopeAmplify: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceEnvelopeAmplify: TSGTK0Scrollbar
                              Left = 63
                              Top = 7
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceEnvelopeAmplifyScroll
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
                          end
                          object PageControl3: TSGTK0PageControl
                            Left = 5
                            Top = 200
                            Width = 704
                            Height = 79
                            Tabs.Strings = (
                              'Edit'
                              'ADSR'
                              'TranceGate'
                              'Amplifer')
                            Color = 2105344
                            ParentColor = False
                            TabOrder = 3
                            ActivePage = TabSheetEnvEdit
                            object TabSheetEnvEdit: TSGTK0TabSheet
                              Caption = 'Edit'
                              ExplicitLeft = 0
                              ExplicitTop = 0
                              ExplicitWidth = 0
                              ExplicitHeight = 0
                              object Label22: TLabel
                                Left = 20
                                Top = 10
                                Width = 28
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Name'
                              end
                              object ButtonFreedrawnEnvelopeNormalize: TSGTK0Button
                                Left = 156
                                Top = 34
                                Width = 57
                                Height = 21
                                Caption = 'Normalize'
                                ParentColor = False
                                TabOrder = 0
                                OnClick = ButtonFreedrawnEnvelopeNormalizeClick
                              end
                              object ButtonFreedrawnEnvelopeReverse: TSGTK0Button
                                Left = 101
                                Top = 34
                                Width = 49
                                Height = 21
                                Caption = 'Reverse'
                                ParentColor = False
                                TabOrder = 1
                                OnClick = ButtonFreedrawnEnvelopeReverseClick
                              end
                              object ButtonFreedrawnEnvelopeInvert: TSGTK0Button
                                Left = 53
                                Top = 34
                                Width = 41
                                Height = 21
                                Caption = 'Invert'
                                ParentColor = False
                                TabOrder = 2
                                OnClick = ButtonFreedrawnEnvelopeInvertClick
                              end
                              object ButtonFreedrawnEnvelopeClear: TSGTK0Button
                                Left = 5
                                Top = 34
                                Width = 41
                                Height = 23
                                Caption = 'Clear'
                                ParentColor = False
                                TabOrder = 3
                                OnClick = ButtonFreedrawnEnvelopeClearClick
                              end
                              object EditEnvelopeName: TSGTK0Edit
                                Left = 53
                                Top = 6
                                Width = 644
                                Height = 22
                                ColorFocused = 3158016
                                Font.Charset = DEFAULT_CHARSET
                                Font.Color = clAqua
                                Font.Height = -11
                                Font.Name = 'Courier New'
                                Font.Style = []
                                ParentFont = False
                                TabOrder = 4
                                OnChange = EditEnvelopeNameChange
                              end
                            end
                            object TabSheetEnvADSR: TSGTK0TabSheet
                              Caption = 'ADSR'
                              ExplicitLeft = 0
                              ExplicitTop = 0
                              ExplicitWidth = 0
                              ExplicitHeight = 0
                              object Label92: TLabel
                                Left = 6
                                Top = 9
                                Width = 31
                                Height = 13
                                Caption = 'Attack'
                              end
                              object Label93: TLabel
                                Left = 102
                                Top = 11
                                Width = 13
                                Height = 13
                                Caption = 'ms'
                              end
                              object Label94: TLabel
                                Left = 102
                                Top = 35
                                Width = 13
                                Height = 13
                                Caption = 'ms'
                              end
                              object Label95: TLabel
                                Left = 6
                                Top = 33
                                Width = 31
                                Height = 13
                                Caption = 'Decay'
                              end
                              object Label96: TLabel
                                Left = 245
                                Top = 9
                                Width = 13
                                Height = 13
                                Caption = 'ms'
                              end
                              object Label97: TLabel
                                Left = 121
                                Top = 10
                                Width = 62
                                Height = 13
                                Caption = 'Sustain/Hold'
                              end
                              object Label98: TLabel
                                Left = 245
                                Top = 35
                                Width = 13
                                Height = 13
                                Caption = 'ms'
                              end
                              object Label99: TLabel
                                Left = 144
                                Top = 35
                                Width = 39
                                Height = 13
                                Caption = 'Release'
                              end
                              object Label100: TLabel
                                Left = 298
                                Top = 12
                                Width = 33
                                Height = 13
                                Caption = 'Ampilfy'
                              end
                              object Label101: TLabel
                                Left = 268
                                Top = 36
                                Width = 64
                                Height = 13
                                Caption = 'Sustain Level'
                              end
                              object Label79: TLabel
                                Left = 400
                                Top = 10
                                Width = 8
                                Height = 13
                                Caption = '%'
                              end
                              object Label80: TLabel
                                Left = 400
                                Top = 36
                                Width = 8
                                Height = 13
                                Caption = '%'
                              end
                              object SpinEditEnvADSRAttack: TSGTK0Edit
                                Left = 44
                                Top = 5
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '50'
                                OnChange = SpinEditEnvADSRAttackChange
                              end
                              object SpinEditEnvADSRDecay: TSGTK0Edit
                                Left = 44
                                Top = 30
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 1
                                Text = '100'
                                OnChange = SpinEditEnvADSRDecayChange
                              end
                              object SpinEditEnvADSRSustainTime: TSGTK0Edit
                                Left = 187
                                Top = 7
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 2
                                Text = '0'
                                OnChange = SpinEditEnvADSRSustainTimeChange
                              end
                              object SpinEditEnvADSRRelease: TSGTK0Edit
                                Left = 187
                                Top = 32
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 3
                                Text = '150'
                                OnChange = SpinEditEnvADSRReleaseChange
                              end
                              object CheckBoxEnvADSRSustain: TSGTK0CheckBox
                                Left = 560
                                Top = 10
                                Width = 97
                                Height = 17
                                Caption = 'Sustain'
                                Checked = True
                                ParentColor = False
                                TabOrder = 4
                                TabStop = True
                                OnClick = CheckBoxEnvADSRSustainClick
                              end
                              object SpinEditEnvADSRAmplify: TSGTK0Edit
                                Left = 337
                                Top = 7
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 5
                                Text = '100'
                                OnChange = SpinEditEnvADSRAmplifyChange
                              end
                              object SpinEditEnvADSRSustainLevel: TSGTK0Edit
                                Left = 337
                                Top = 32
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 6
                                Text = '32'
                                OnChange = SpinEditEnvADSRSustainLevelChange
                              end
                              object ButtonEnvADSRGenerate: TSGTK0Button
                                Left = 416
                                Top = 9
                                Width = 126
                                Height = 20
                                Caption = 'Generate envelope'
                                ParentColor = False
                                TabOrder = 7
                                OnClick = ButtonEnvADSRGenerateClick
                              end
                            end
                            object TabSheetEnvTranceGate: TSGTK0TabSheet
                              Caption = 'TranceGate'
                              ExplicitLeft = 0
                              ExplicitTop = 0
                              ExplicitWidth = 0
                              ExplicitHeight = 0
                              object Label102: TLabel
                                Left = 437
                                Top = 5
                                Width = 59
                                Height = 13
                                Caption = 'Note Length'
                              end
                              object Label103: TLabel
                                Left = 613
                                Top = 9
                                Width = 20
                                Height = 13
                                Caption = 'dots'
                              end
                              object GroupBox29: TSGTK0Panel
                                Left = 4
                                Top = 4
                                Width = 258
                                Height = 42
                                TabOrder = 0
                                UseDockManager = True
                                BevelOuter = bvLowered
                                object Label75: TLabel
                                  Left = 4
                                  Top = -2
                                  Width = 71
                                  Height = 13
                                  Caption = '16 step pattern'
                                end
                                object CheckBoxEnvTranceGateStep1: TSGTK0CheckBox
                                  Left = 6
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 0
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep1Click
                                end
                                object CheckBoxEnvTranceGateStep2: TSGTK0CheckBox
                                  Left = 20
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 1
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep2Click
                                end
                                object CheckBoxEnvTranceGateStep3: TSGTK0CheckBox
                                  Left = 34
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 2
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep3Click
                                end
                                object CheckBoxEnvTranceGateStep4: TSGTK0CheckBox
                                  Left = 48
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 3
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep4Click
                                end
                                object CheckBoxEnvTranceGateStep5: TSGTK0CheckBox
                                  Left = 70
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 4
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep5Click
                                end
                                object CheckBoxEnvTranceGateStep6: TSGTK0CheckBox
                                  Left = 84
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 5
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep6Click
                                end
                                object CheckBoxEnvTranceGateStep7: TSGTK0CheckBox
                                  Left = 98
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 6
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep7Click
                                end
                                object CheckBoxEnvTranceGateStep8: TSGTK0CheckBox
                                  Left = 112
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 7
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep8Click
                                end
                                object CheckBoxEnvTranceGateStep9: TSGTK0CheckBox
                                  Left = 134
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 8
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep9Click
                                end
                                object CheckBoxEnvTranceGateStep10: TSGTK0CheckBox
                                  Left = 148
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 9
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep10Click
                                end
                                object CheckBoxEnvTranceGateStep11: TSGTK0CheckBox
                                  Left = 162
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 10
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep11Click
                                end
                                object CheckBoxEnvTranceGateStep12: TSGTK0CheckBox
                                  Left = 176
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 11
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep12Click
                                end
                                object CheckBoxEnvTranceGateStep13: TSGTK0CheckBox
                                  Left = 198
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 12
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep13Click
                                end
                                object CheckBoxEnvTranceGateStep14: TSGTK0CheckBox
                                  Left = 212
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 13
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep14Click
                                end
                                object CheckBoxEnvTranceGateStep15: TSGTK0CheckBox
                                  Left = 226
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 14
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep15Click
                                end
                                object CheckBoxEnvTranceGateStep16: TSGTK0CheckBox
                                  Left = 240
                                  Top = 18
                                  Width = 14
                                  Height = 17
                                  ParentColor = False
                                  TabOrder = 15
                                  TabStop = True
                                  OnClick = CheckBoxEnvTranceGateStep16Click
                                end
                              end
                              object ButtonEnvTranceGateGenerate: TSGTK0Button
                                Left = 436
                                Top = 27
                                Width = 126
                                Height = 20
                                Caption = 'Generate envelope'
                                ParentColor = False
                                TabOrder = 1
                                OnClick = ButtonEnvTranceGateGenerateClick
                              end
                              object GroupBox30: TSGTK0Panel
                                Left = 264
                                Top = 4
                                Width = 52
                                Height = 43
                                TabOrder = 2
                                UseDockManager = True
                                BevelOuter = bvLowered
                                object Label76: TLabel
                                  Left = 4
                                  Top = 0
                                  Width = 43
                                  Height = 13
                                  Caption = 'OnAmp%'
                                end
                                object SpinEditEnvTranceGateOnAmp: TSGTK0Edit
                                  Left = 5
                                  Top = 16
                                  Width = 41
                                  Height = 22
                                  ColorFocused = 3158016
                                  TabOrder = 0
                                  Text = '90'
                                  OnChange = SpinEditEnvTranceGateOnAmpChange
                                end
                              end
                              object GroupBox31: TSGTK0Panel
                                Left = 318
                                Top = 4
                                Width = 49
                                Height = 43
                                TabOrder = 3
                                UseDockManager = True
                                BevelOuter = bvLowered
                                object Label77: TLabel
                                  Left = 4
                                  Top = 0
                                  Width = 35
                                  Height = 13
                                  Caption = 'OffAmp&'
                                end
                                object SpinEditEnvTranceGateOffAmp: TSGTK0Edit
                                  Left = 5
                                  Top = 16
                                  Width = 41
                                  Height = 22
                                  ColorFocused = 3158016
                                  TabOrder = 0
                                  Text = '10'
                                  OnChange = SpinEditEnvTranceGateOffAmpChange
                                end
                              end
                              object GroupBox32: TSGTK0Panel
                                Left = 369
                                Top = 4
                                Width = 63
                                Height = 43
                                TabOrder = 4
                                UseDockManager = True
                                BevelOuter = bvLowered
                                object Label78: TLabel
                                  Left = 4
                                  Top = 0
                                  Width = 23
                                  Height = 13
                                  Caption = 'BPM'
                                end
                                object SpinEditEnvTranceGateBPM: TSGTK0Edit
                                  Left = 5
                                  Top = 16
                                  Width = 54
                                  Height = 22
                                  ColorFocused = 3158016
                                  TabOrder = 0
                                  Text = '125'
                                  OnChange = SpinEditEnvTranceGateBPMChange
                                end
                              end
                              object ComboBoxEnvTranceGateNoteLength: TSGTK0ComboBox
                                Left = 503
                                Top = 4
                                Width = 66
                                Height = 21
                                Style = csDropDownList
                                Items.Strings = (
                                  '1*2'
                                  '1/1'
                                  '1/2'
                                  '1/4'
                                  '1/8'
                                  '1/16'
                                  '1/32'
                                  '1/64'
                                  '1/128')
                                TabOrder = 5
                                Text = '1/4'
                                ItemIndex = 3
                                OnChange = ComboBoxEnvTranceGateNoteLengthChange
                              end
                              object SpinEditEnvTranceGateDots: TSGTK0Edit
                                Left = 571
                                Top = 3
                                Width = 41
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 6
                                Text = '0'
                                OnChange = SpinEditEnvTranceGateDotsChange
                              end
                            end
                            object TabSheetEnvAmplifer: TSGTK0TabSheet
                              Caption = 'Amplifer'
                              ExplicitLeft = 0
                              ExplicitTop = 0
                              ExplicitWidth = 0
                              ExplicitHeight = 0
                              object Label104: TLabel
                                Left = 4
                                Top = 16
                                Width = 33
                                Height = 13
                                Caption = 'Ampilfy'
                              end
                              object Label105: TLabel
                                Left = 99
                                Top = 16
                                Width = 8
                                Height = 13
                                Caption = '%'
                              end
                              object SpinEditEnvAmpliferAmplify: TSGTK0Edit
                                Left = 42
                                Top = 11
                                Width = 56
                                Height = 22
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '100'
                                OnChange = SpinEditEnvAmpliferAmplifyChange
                              end
                              object ButtonEnvAmpiferAmplify: TSGTK0Button
                                Left = 112
                                Top = 11
                                Width = 126
                                Height = 20
                                Caption = 'Amplify envelope'
                                ParentColor = False
                                TabOrder = 1
                                OnClick = ButtonEnvAmpiferAmplifyClick
                              end
                            end
                          end
                          object PanelFreedrawnEnvelopeEditor: TSGTK0Panel
                            Left = 5
                            Top = 40
                            Width = 704
                            Height = 156
                            ParentColor = True
                            TabOrder = 4
                            UseDockManager = True
                            BevelOuter = bvNone
                          end
                        end
                      end
                    end
                    object TabSheetInstrumentVoiceLFOs: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'LFOs'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object TabControlInstrumentVoiceLFOs: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = TabControlInstrumentVoiceLFOsTabChanged
                        object P4: TSGTK0Panel
                          Left = 1
                          Top = 24
                          Width = 714
                          Height = 284
                          Align = alBottom
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvNone
                          BevelWidth = 4
                          object PanelInstrumentVoiceLFOWaveform: TSGTK0Panel
                            Left = 5
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 0
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceLFOWaveform: TLabel
                              Left = 9
                              Top = 8
                              Width = 49
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Waveform'
                            end
                            object ComboBoxInstrumentVoiceLFOWaveform: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'None'
                                'Sine'
                                'Sawtooth up'
                                'Sawtooth down'
                                'Triangle'
                                'Square'
                                'Random'
                                'Sample')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceLFOWaveformChange
                            end
                          end
                          object PanelInstrumentVoiceLFOWavetable: TSGTK0Panel
                            Left = 241
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceLFOSample: TLabel
                              Left = 23
                              Top = 8
                              Width = 35
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Sample'
                            end
                            object ComboBoxInstrumentVoiceLFOSample: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceLFOSampleChange
                            end
                          end
                          object PanelInstrumentVoiceLFORate: TSGTK0Panel
                            Left = 5
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 2
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceLFORate: TLabel
                              Left = 35
                              Top = 8
                              Width = 23
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Rate'
                            end
                            object LabelInstrumentVoiceLFORate: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceLFORate: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceLFORateScroll
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
                          end
                          object PanelInstrumentVoiceLFODepth: TSGTK0Panel
                            Left = 241
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 3
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceLFODepth: TLabel
                              Left = 29
                              Top = 8
                              Width = 29
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Depth'
                            end
                            object LabelInstrumentVoiceLFODepth: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceLFODepth: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceLFODepthScroll
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
                          end
                          object PanelInstrumentVoiceLFOMiddle: TSGTK0Panel
                            Left = 5
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 4
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label28: TLabel
                              Left = 27
                              Top = 8
                              Width = 31
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Middle'
                            end
                            object LabelInstrumentVoiceLFOMiddle: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceLFOMiddle: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -128
                              Max = 127
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceLFOMiddleScroll
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
                          end
                          object PanelInstrumentVoiceLFOSweep: TSGTK0Panel
                            Left = 241
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 5
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceLFOSweep: TLabel
                              Left = 25
                              Top = 8
                              Width = 33
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Sweep'
                            end
                            object LabelInstrumentVoiceLFOSweep: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceLFOSweep: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceLFOSweepScroll
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
                          end
                          object PanelInstrumentVoiceLFOPhaseStart: TSGTK0Panel
                            Left = 477
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 6
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceLFOPhaseStart: TLabel
                              Left = 6
                              Top = 8
                              Width = 52
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'PhaseStart'
                            end
                            object LabelInstrumentVoiceLFOPhaseStart: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollBarInstrumentVoiceLFOPhaseStart: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollBarInstrumentVoiceLFOPhaseStartScroll
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
                          end
                          object PanelInstrumentVoiceLFOOptions: TSGTK0Panel
                            Left = 477
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 7
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceLFOAmp: TSGTK0CheckBox
                              Left = 8
                              Top = 7
                              Width = 82
                              Height = 17
                              Caption = 'Amplifer'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceLFOAmpClick
                            end
                            object SGTK0Panel61: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceLFOCarry: TSGTK0CheckBox
                              Left = 123
                              Top = 7
                              Width = 96
                              Height = 17
                              Caption = 'Carry'
                              Checked = True
                              ParentColor = False
                              TabOrder = 2
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceLFOCarryClick
                            end
                          end
                          object SGTK0Panel98: TSGTK0Panel
                            Left = 477
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 8
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label123: TLabel
                              Left = 4
                              Top = 8
                              Width = 54
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'PhaseSync'
                            end
                            object ComboBoxInstrumentVoiceLFOPhaseSync: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Global'
                                'Channel'
                                'Voice'
                                'Random')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceLFOPhaseSyncChange
                            end
                          end
                        end
                      end
                    end
                    object TabSheetInstrumentVoiceFilters: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Filters'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object TabControlInstrumentVoiceFilters: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = TabControlInstrumentVoiceFiltersTabChanged
                        object P5: TSGTK0Panel
                          Left = 1
                          Top = 24
                          Width = 714
                          Height = 284
                          Align = alBottom
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvNone
                          BevelWidth = 4
                          object PanelInstrumentVoiceFilterMode: TSGTK0Panel
                            Left = 5
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 0
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceFilterMode: TLabel
                              Left = 31
                              Top = 8
                              Width = 27
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Mode'
                            end
                            object ComboBoxInstrumentVoiceFilterMode: TSGTK0ComboBox
                              Left = 63
                              Top = 5
                              Width = 163
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'None'
                                'SVF LowPass'
                                'SVF HighPass'
                                'SVF BandPass'
                                'SVF Notch'
                                'SVF AllPass'
                                'Biquad LowPass'
                                'Biquad HighPass'
                                'Biquad BandPass'
                                'Biquad Notch'
                                'Biquad Peak EQ'
                                'Biquad LowShelf'
                                'Biquad HighShelf'
                                'Formant'
                                'OverDrive'
                                'Moog LowPass'
                                'Moog HighPass'
                                'Moog BandPass')
                              ParentShowHint = False
                              ShowHint = False
                              TabOrder = 0
                              ItemIndex = -1
                              OnChange = ComboBoxInstrumentVoiceFilterModeChange
                            end
                          end
                          object PanelInstrumentVoiceFilterVolume: TSGTK0Panel
                            Left = 241
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceFilterVolume: TLabel
                              Left = 23
                              Top = 8
                              Width = 35
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Volume'
                            end
                            object LabelInstrumentVoiceFilterVolume: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceFilterVolume: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceFilterVolumeScroll
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
                          end
                          object PanelInstrumentVoiceFilterCutOff: TSGTK0Panel
                            Left = 5
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 2
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceFilterCutOff: TLabel
                              Left = 28
                              Top = 8
                              Width = 30
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'CutOff'
                            end
                            object LabelInstrumentVoiceFilterCutOff: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceFilterCutOff: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceFilterCutOffScroll
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
                          end
                          object PanelInstrumentVoiceFilterResonance: TSGTK0Panel
                            Left = 241
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 3
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceFilterResonance: TLabel
                              Left = 3
                              Top = 8
                              Width = 55
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Resonance'
                            end
                            object LabelInstrumentVoiceFilterResonance: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceFilterResonance: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Max = 255
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceFilterResonanceScroll
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
                          end
                          object PanelInstrumentVoiceFilterOptionsB: TSGTK0Panel
                            Left = 477
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 4
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceFilterCarry: TSGTK0CheckBox
                              Left = 8
                              Top = 6
                              Width = 82
                              Height = 17
                              Caption = 'Carry'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceFilterCarryClick
                            end
                            object SGTK0Panel67: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                          end
                          object PanelInstrumentVoiceFilterOptionsA: TSGTK0Panel
                            Left = 241
                            Top = 5
                            Width = 232
                            Height = 30
                            TabOrder = 5
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object CheckBoxInstrumentVoiceFilterCascaded: TSGTK0CheckBox
                              Left = 6
                              Top = 7
                              Width = 82
                              Height = 17
                              Caption = 'Cascaded'
                              ParentColor = False
                              TabOrder = 0
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceFilterCascadedClick
                            end
                            object SGTK0Panel75: TSGTK0Panel
                              Left = 115
                              Top = 2
                              Width = 1
                              Height = 26
                              Caption = 'SGTK0Panel22'
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                            object CheckBoxInstrumentVoiceFilterChain: TSGTK0CheckBox
                              Left = 123
                              Top = 7
                              Width = 96
                              Height = 17
                              Caption = 'Chain'
                              ParentColor = False
                              TabOrder = 2
                              TabStop = True
                              OnClick = CheckBoxInstrumentVoiceFilterChainClick
                            end
                          end
                          object PanelInstrumentVoiceFilterAmplify: TSGTK0Panel
                            Left = 5
                            Top = 75
                            Width = 232
                            Height = 30
                            TabOrder = 6
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object LabelNameInstrumentVoiceFilterAmplify: TLabel
                              Left = 25
                              Top = 8
                              Width = 33
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Amplify'
                            end
                            object LabelInstrumentVoiceFilterAmplify: TLabel
                              Left = 202
                              Top = 7
                              Width = 23
                              Height = 14
                              Alignment = taRightJustify
                              AutoSize = False
                              Caption = '000'
                              Font.Charset = ANSI_CHARSET
                              Font.Color = clAqua
                              Font.Height = -11
                              Font.Name = 'Courier New'
                              Font.Style = []
                              ParentFont = False
                            end
                            object ScrollbarInstrumentVoiceFilterAmplify: TSGTK0Scrollbar
                              Left = 63
                              Top = 6
                              Width = 134
                              Height = 17
                              Min = -128
                              Max = 127
                              Kind = sbHorizontal
                              OnScroll = ScrollbarInstrumentVoiceFilterAmplifyScroll
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
                          end
                          object SGTK0PanelInstrumentVoiceFilterRange: TSGTK0Panel
                            Left = 477
                            Top = 40
                            Width = 232
                            Height = 30
                            TabOrder = 7
                            UseDockManager = True
                            BevelOuter = bvLowered
                            object Label109: TLabel
                              Left = 117
                              Top = 10
                              Width = 13
                              Height = 13
                              Alignment = taCenter
                              AutoSize = False
                              Caption = 'to'
                            end
                            object Label111: TLabel
                              Left = 214
                              Top = 10
                              Width = 13
                              Height = 13
                              Caption = 'Hz'
                            end
                            object Label112: TLabel
                              Left = 10
                              Top = 10
                              Width = 23
                              Height = 13
                              Caption = 'From'
                            end
                            object SGTK0EditInstrumentVoiceFilterHzMin: TSGTK0Edit
                              Left = 40
                              Top = 6
                              Width = 75
                              Height = 19
                              ColorFocused = 3158016
                              TabOrder = 0
                              Text = '20'
                              OnChange = SGTK0EditInstrumentVoiceFilterHzMinChange
                            end
                            object SGTK0EditInstrumentVoiceFilterHzMax: TSGTK0Edit
                              Left = 134
                              Top = 6
                              Width = 75
                              Height = 19
                              ColorFocused = 3158016
                              TabOrder = 1
                              Text = '20000'
                              OnChange = SGTK0EditInstrumentVoiceFilterHzMaxChange
                            end
                          end
                        end
                      end
                    end
                    object TabSheetVoiceInstrumentDistortion: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Distortion'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0TabControlVoiceDistortion: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = SGTK0TabControlVoiceDistortionTabChanged
                        object PanelInstrumentVoiceDistortionMode: TSGTK0Panel
                          Left = 6
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNamelInstrumentVoiceDistortionMode: TLabel
                            Left = 31
                            Top = 8
                            Width = 27
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Mode'
                          end
                          object ComboBoxInstrumentVoiceDistortionMode: TSGTK0ComboBox
                            Left = 63
                            Top = 5
                            Width = 163
                            Height = 21
                            Style = csDropDownList
                            Items.Strings = (
                              'None'
                              'Soft'
                              'Hard'
                              'FastWaveShaper'
                              'WaveShaper 1'
                              'WaveShaper 2'
                              'GloubiBoulga'
                              'FoldBack'
                              'Saturation'
                              'DecimatorCrusher'
                              'BitCrusher'
                              'Decimator'
                              'OverDrive'
                              'Arctangent'
                              'Asymmetric'
                              'Asymmetric 2'
                              'Power'
                              'Power 2'
                              'Power 3'
                              'Sine'
                              'Sinus'
                              'Quantisize'
                              'Zigzag'
                              'Limiter'
                              'Upper Limiter'
                              'Lower Limiter'
                              'Inverse Limiter'
                              'Clip'
                              'Sigmoid'
                              'Diff'
                              'Stereo Expander'
                              'Stereo Enhancer'
                              'Stereo Field Rotation')
                            ParentShowHint = False
                            ShowHint = False
                            TabOrder = 0
                            ItemIndex = -1
                            OnChange = ComboBoxInstrumentVoiceDistortionModeChange
                          end
                        end
                        object PanelInstrumentVoiceDistortionDist: TSGTK0Panel
                          Left = 6
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentVoiceDistortionDist: TLabel
                            Left = 40
                            Top = 8
                            Width = 18
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Dist'
                          end
                          object LabelInstrumentVoiceDistortionDist: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentVoiceDistortionDist: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentVoiceDistortionDistScroll
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
                        end
                        object PanelInstrumentVoiceDistortionRate: TSGTK0Panel
                          Left = 242
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 2
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object Label35: TLabel
                            Left = 35
                            Top = 8
                            Width = 23
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Rate'
                          end
                          object LabelInstrumentVoiceDistortionRate: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentVoiceDistortionRate: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentVoiceDistortionRateScroll
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
                        end
                        object PanelInstrumentVoiceDistortionGain: TSGTK0Panel
                          Left = 242
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 3
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentVoiceDistortionGain: TLabel
                            Left = 36
                            Top = 8
                            Width = 22
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Gain'
                          end
                          object LabelInstrumentVoiceDistortionGain: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentVoiceDistortionGain: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentVoiceDistortionGainScroll
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
                        end
                        object PanelInstrumentVoiceDistortionOptions: TSGTK0Panel
                          Left = 478
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 4
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object CheckBoxInstrumentVoiceDistortionCarry: TSGTK0CheckBox
                            Left = 8
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Carry'
                            ParentColor = False
                            TabOrder = 0
                            TabStop = True
                            OnClick = CheckBoxInstrumentVoiceDistortionCarryClick
                          end
                          object SGTK0Panel9: TSGTK0Panel
                            Left = 115
                            Top = 2
                            Width = 1
                            Height = 26
                            Caption = 'SGTK0Panel22'
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                        end
                      end
                    end
                    object TabSheetVoiceInstrumentGate: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Gate'
                      TabVisible = False
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                    end
                    object TabSheetInstrumentVoiceSignalRouteOrder: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Order'
                      object ListBoxInstrumentVoiceOrder: TSGTK0ListBox
                        Left = 5
                        Top = 5
                        Width = 203
                        Height = 42
                        Items.Strings = (
                          'Distortion'
                          'Filter')
                      end
                      object ButtonInstrumentVoiceOrderMoveToUp: TSGTK0Button
                        Left = 210
                        Top = 5
                        Width = 77
                        Height = 21
                        Caption = 'Move to up'
                        ParentColor = False
                        TabOrder = 1
                        OnClick = ButtonInstrumentVoiceOrderMoveToUpClick
                      end
                      object ButtonInstrumentVoiceOrderMoveToDown: TSGTK0Button
                        Left = 210
                        Top = 27
                        Width = 77
                        Height = 21
                        Caption = 'Move to down'
                        ParentColor = False
                        TabOrder = 2
                        OnClick = ButtonInstrumentVoiceOrderMoveToDownClick
                      end
                    end
                  end
                end
                object TabSheetInstrumentChannel: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Channel'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object PageControlInstrumentChannel: TSGTK0PageControl
                    Left = 0
                    Top = 0
                    Width = 728
                    Height = 337
                    Align = alClient
                    Tabs.Strings = (
                      'Distortion'
                      'Filter'
                      'Delay'
                      'Chorus/Flanger'
                      'Compressor'
                      'Speech'
                      'PitchShifter'
                      'EQ'
                      'Order'
                      'LFO')
                    Color = 2105344
                    ParentColor = False
                    TabOrder = 0
                    ActivePage = TabSheetInstrumentChannelDistortion
                    object TabSheetInstrumentChannelDistortion: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Distortion'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0TabControlChannelDistortion: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = SGTK0TabControlChannelDistortionTabChanged
                        object PanelInstrumentChannelDistortionMode: TSGTK0Panel
                          Left = 6
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNamInstrumentChannelDistortionMode: TLabel
                            Left = 31
                            Top = 8
                            Width = 27
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Mode'
                          end
                          object ComboBoxInstrumentChannelDistortionMode: TSGTK0ComboBox
                            Left = 63
                            Top = 5
                            Width = 163
                            Height = 21
                            Style = csDropDownList
                            Items.Strings = (
                              'None'
                              'Soft'
                              'Hard'
                              'FastWaveShaper'
                              'WaveShaper 1'
                              'WaveShaper 2'
                              'GloubiBoulga'
                              'FoldBack'
                              'Saturation'
                              'DecimatorCrusher'
                              'BitCrusher'
                              'Decimator'
                              'OverDrive'
                              'Arctangent'
                              'Asymmetric'
                              'Asymmetric 2'
                              'Power'
                              'Power 2'
                              'Power 3'
                              'Sine'
                              'Sinus'
                              'Quantisize'
                              'Zigzag'
                              'Limiter'
                              'Upper Limiter'
                              'Lower Limiter'
                              'Inverse Limiter'
                              'Clip'
                              'Sigmoid'
                              'Diff'
                              'Stereo Expander'
                              'Stereo Enhancer'
                              'Stereo Field Rotation')
                            ParentShowHint = False
                            ShowHint = False
                            TabOrder = 0
                            ItemIndex = -1
                            OnChange = ComboBoxInstrumentChannelDistortionModeChange
                          end
                        end
                        object PanelInstrumentChannelDistortionDist: TSGTK0Panel
                          Left = 6
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNamInstrumentChannelDistortionDist: TLabel
                            Left = 40
                            Top = 8
                            Width = 18
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Dist'
                          end
                          object LabelInstrumentChannelDistortionDist: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDistortionDist: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDistortionDistScroll
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
                        end
                        object PanelInstrumentChannelDistortionRate: TSGTK0Panel
                          Left = 242
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 2
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object Label25: TLabel
                            Left = 35
                            Top = 8
                            Width = 23
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Rate'
                          end
                          object LabelInstrumentChannelDistortionRate: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDistortionRate: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDistortionRateScroll
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
                        end
                        object PanelInstrumentChannelDistortionGain: TSGTK0Panel
                          Left = 242
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 3
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDistortionGain: TLabel
                            Left = 36
                            Top = 8
                            Width = 22
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Gain'
                          end
                          object LabelInstrumentChannelDistortionGain: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollBarInstrumentChannelDistortionGain: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollBarInstrumentChannelDistortionGainScroll
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
                        end
                        object PanelInstrumentChannelDistortionOptions: TSGTK0Panel
                          Left = 478
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 4
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object CheckBoxInstrumentChannelDistortionCarry: TSGTK0CheckBox
                            Left = 8
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Carry'
                            ParentColor = False
                            TabOrder = 0
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelDistortionCarryClick
                          end
                          object SGTK0Panel65: TSGTK0Panel
                            Left = 115
                            Top = 2
                            Width = 1
                            Height = 26
                            Caption = 'SGTK0Panel22'
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                        end
                      end
                    end
                    object TabSheetInstrumentChannelFilter: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Filter'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0TabControlChannelFilter: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = SGTK0TabControlChannelFilterTabChanged
                        object PanelInstrumentChannelFilterMode: TSGTK0Panel
                          Left = 6
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelFilterMode: TLabel
                            Left = 31
                            Top = 8
                            Width = 27
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Mode'
                          end
                          object ComboBoxInstrumentChannelFilterMode: TSGTK0ComboBox
                            Left = 63
                            Top = 5
                            Width = 163
                            Height = 21
                            Style = csDropDownList
                            Items.Strings = (
                              'None'
                              'SVF LowPass'
                              'SVF HighPass'
                              'SVF BandPass'
                              'SVF Notch'
                              'SVF AllPass'
                              'Biquad LowPass'
                              'Biquad HighPass'
                              'Biquad BandPass'
                              'Biquad Notch'
                              'Biquad Peak EQ'
                              'Biquad LowShelf'
                              'Biquad HighShelf'
                              'Formant'
                              'OverDrive'
                              'Moog LowPass'
                              'Moog HighPass'
                              'Moog BandPass')
                            ParentShowHint = False
                            ShowHint = False
                            TabOrder = 0
                            ItemIndex = -1
                            OnChange = ComboBoxInstrumentChannelFilterModeChange
                          end
                        end
                        object PanelInstrumentChannelFilterCutOff: TSGTK0Panel
                          Left = 6
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelFilterCutOff: TLabel
                            Left = 28
                            Top = 8
                            Width = 30
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'CutOff'
                          end
                          object LabelInstrumentChannelFilterCutOff: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelFilterCutOff: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelFilterCutOffScroll
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
                        end
                        object PanelInstrumentChannelFilterAmplify: TSGTK0Panel
                          Left = 6
                          Top = 99
                          Width = 232
                          Height = 30
                          TabOrder = 2
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelFilterAmplify: TLabel
                            Left = 25
                            Top = 8
                            Width = 33
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Amplify'
                          end
                          object LabelInstrumentChannelFilterAmplify: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelFilterAmplify: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Min = -128
                            Max = 127
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelFilterAmplifyScroll
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
                        end
                        object PanelInstrumentChannelFilterVolume: TSGTK0Panel
                          Left = 242
                          Top = 99
                          Width = 232
                          Height = 30
                          TabOrder = 3
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelFilterVolume: TLabel
                            Left = 23
                            Top = 8
                            Width = 35
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Volume'
                          end
                          object LabelInstrumentChannelFilterVolume: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelFilterVolume: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelFilterVolumeScroll
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
                        end
                        object PanelInstrumentChannelFilterResonance: TSGTK0Panel
                          Left = 242
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 4
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelFilterResonance: TLabel
                            Left = 3
                            Top = 8
                            Width = 55
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Resonance'
                          end
                          object LabelInstrumentChannelFilterResonance: TLabel
                            Left = 202
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelFilterResonance: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 134
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelFilterResonanceScroll
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
                        end
                        object PanelInstrumentChannelFilterOptions: TSGTK0Panel
                          Left = 242
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 5
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object CheckBoxInstrumentChannelFilterCascaded: TSGTK0CheckBox
                            Left = 6
                            Top = 7
                            Width = 82
                            Height = 17
                            Caption = 'Cascaded'
                            ParentColor = False
                            TabOrder = 0
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelFilterCascadedClick
                          end
                          object SGTK0Panel73: TSGTK0Panel
                            Left = 115
                            Top = 2
                            Width = 1
                            Height = 26
                            Caption = 'SGTK0Panel22'
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object CheckBoxInstrumentChannelFilterChain: TSGTK0CheckBox
                            Left = 123
                            Top = 7
                            Width = 96
                            Height = 17
                            Caption = 'Chain'
                            ParentColor = False
                            TabOrder = 2
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelFilterChainClick
                          end
                        end
                        object SGTK0Panel170: TSGTK0Panel
                          Left = 478
                          Top = 64
                          Width = 232
                          Height = 30
                          TabOrder = 6
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object Label113: TLabel
                            Left = 117
                            Top = 10
                            Width = 13
                            Height = 13
                            Alignment = taCenter
                            AutoSize = False
                            Caption = 'to'
                          end
                          object Label114: TLabel
                            Left = 214
                            Top = 10
                            Width = 13
                            Height = 13
                            Caption = 'Hz'
                          end
                          object Label115: TLabel
                            Left = 10
                            Top = 10
                            Width = 23
                            Height = 13
                            Caption = 'From'
                          end
                          object SGTK0EditInstrumentChannelFilterMinHz: TSGTK0Edit
                            Left = 40
                            Top = 6
                            Width = 75
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 0
                            Text = '20'
                            OnChange = SGTK0EditInstrumentChannelFilterMinHzChange
                          end
                          object SGTK0EditInstrumentChannelFilterMaxHz: TSGTK0Edit
                            Left = 134
                            Top = 6
                            Width = 75
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 1
                            Text = '20000'
                            OnChange = SGTK0EditInstrumentChannelFilterMaxHzChange
                          end
                        end
                        object SGTK0Panel69: TSGTK0Panel
                          Left = 478
                          Top = 29
                          Width = 232
                          Height = 30
                          TabOrder = 7
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object SGTK0CheckBoxChannelFilterCarry: TSGTK0CheckBox
                            Left = 8
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Carry'
                            ParentColor = False
                            TabOrder = 0
                            TabStop = True
                            OnClick = SGTK0CheckBoxChannelFilterCarryClick
                          end
                          object SGTK0Panel167: TSGTK0Panel
                            Left = 115
                            Top = 2
                            Width = 1
                            Height = 26
                            Caption = 'SGTK0Panel22'
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                        end
                      end
                    end
                    object TabSheetInstrumentChannelDelay: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Delay'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0TabControlChannelDelay: TSGTK0TabControl
                        Left = 0
                        Top = 0
                        Width = 716
                        Height = 309
                        Align = alClient
                        Tabs.Strings = (
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6'
                          '7'
                          '8')
                        Color = 2105344
                        ParentColor = False
                        TabOrder = 0
                        OnTabChanged = SGTK0TabControlChannelDelayTabChanged
                        object SGTK0Panel182: TSGTK0Panel
                          Left = 248
                          Top = 133
                          Width = 237
                          Height = 30
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object CheckBoxInstrumentChannelDelayFine: TSGTK0CheckBox
                            Left = 8
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Fine'
                            ParentColor = False
                            TabOrder = 0
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelDelayFineClick
                          end
                          object SGTK0Panel183: TSGTK0Panel
                            Left = 118
                            Top = 2
                            Width = 1
                            Height = 26
                            Caption = 'SGTK0Panel22'
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object CheckBoxInstrumentChannelDelayRecursive: TSGTK0CheckBox
                            Left = 126
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Recursive'
                            ParentColor = False
                            TabOrder = 2
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelDelayRecursiveClick
                          end
                        end
                        object PanelInstrumentChannelDelayOptions: TSGTK0Panel
                          Left = 6
                          Top = 134
                          Width = 237
                          Height = 30
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object CheckBoxInstrumentChannelDelayActive: TSGTK0CheckBox
                            Left = 8
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Active'
                            ParentColor = False
                            TabOrder = 0
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelDelayActiveClick
                          end
                          object SGTK0Panel63: TSGTK0Panel
                            Left = 118
                            Top = 2
                            Width = 1
                            Height = 26
                            Caption = 'SGTK0Panel22'
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object CheckBoxInstrumentChannelDelayClockSync: TSGTK0CheckBox
                            Left = 126
                            Top = 6
                            Width = 82
                            Height = 17
                            Caption = 'Clock Sync'
                            ParentColor = False
                            TabOrder = 2
                            TabStop = True
                            OnClick = CheckBoxInstrumentChannelDelayClockSyncClick
                          end
                        end
                        object PanelInstrumentChannelDelayFeedBackLeft: TSGTK0Panel
                          Left = 6
                          Top = 99
                          Width = 237
                          Height = 30
                          TabOrder = 2
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDelayFeedBackLeft: TLabel
                            Left = 24
                            Top = 8
                            Width = 34
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'FB Left'
                          end
                          object LabelInstrumentChannelDelayFeedBackLeft: TLabel
                            Left = 208
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDelayFeedBackLeft: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 142
                            Height = 17
                            Min = -128
                            Max = 127
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDelayFeedBackLeftScroll
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
                        end
                        object PanelInstrumentChannelDelayTimeLeft: TSGTK0Panel
                          Left = 6
                          Top = 64
                          Width = 237
                          Height = 30
                          TabOrder = 3
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDelayTimeLeft: TLabel
                            Left = 14
                            Top = 8
                            Width = 44
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Time Left'
                          end
                          object LabelInstrumentChannelDelayTimeLeft: TLabel
                            Left = 208
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDelayTimeLeft: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 142
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDelayTimeLeftScroll
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
                        end
                        object PanelInstrumentChannelDelayWet: TSGTK0Panel
                          Left = 6
                          Top = 29
                          Width = 237
                          Height = 30
                          TabOrder = 4
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDelayWet: TLabel
                            Left = 38
                            Top = 8
                            Width = 20
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Wet'
                          end
                          object LabelInstrumentChannelDelayWet: TLabel
                            Left = 208
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDelayWet: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 142
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDelayWetScroll
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
                        end
                        object PanelInstrumentChannelDelayDry: TSGTK0Panel
                          Left = 247
                          Top = 29
                          Width = 237
                          Height = 30
                          TabOrder = 5
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDelayDry: TLabel
                            Left = 42
                            Top = 8
                            Width = 16
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Dry'
                          end
                          object LabelInstrumentChannelDelayDry: TLabel
                            Left = 208
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDelayDry: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 142
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDelayDryScroll
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
                        end
                        object PanelInstrumentChannelDelayTimeRight: TSGTK0Panel
                          Left = 247
                          Top = 64
                          Width = 237
                          Height = 30
                          TabOrder = 6
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDelayTimeRight: TLabel
                            Left = 7
                            Top = 8
                            Width = 51
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'Time Right'
                          end
                          object LabelInstrumentChannelDelayTimeRight: TLabel
                            Left = 208
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDelayTimeRight: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 142
                            Height = 17
                            Max = 255
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDelayTimeRightScroll
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
                        end
                        object PanelInstrumentChannelDelayFeedBackRight: TSGTK0Panel
                          Left = 247
                          Top = 99
                          Width = 237
                          Height = 30
                          TabOrder = 7
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelNameInstrumentChannelDelayFeedBackRight: TLabel
                            Left = 17
                            Top = 8
                            Width = 41
                            Height = 13
                            Alignment = taRightJustify
                            Caption = 'FB Right'
                          end
                          object LabelInstrumentChannelDelayFeedBackRight: TLabel
                            Left = 208
                            Top = 7
                            Width = 23
                            Height = 14
                            Alignment = taRightJustify
                            AutoSize = False
                            Caption = '000'
                            Font.Charset = ANSI_CHARSET
                            Font.Color = clAqua
                            Font.Height = -11
                            Font.Name = 'Courier New'
                            Font.Style = []
                            ParentFont = False
                          end
                          object ScrollbarInstrumentChannelDelayFeedBackRight: TSGTK0Scrollbar
                            Left = 63
                            Top = 6
                            Width = 142
                            Height = 17
                            Min = -128
                            Max = 127
                            Kind = sbHorizontal
                            OnScroll = ScrollbarInstrumentChannelDelayFeedBackRightScroll
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
                        end
                      end
                    end
                    object TabSheetInstrumentChannelChorusFlanger: TSGTK0TabSheet
                      Hint = 'Chorus/Flanger'
                      BorderWidth = 5
                      Caption = 'Chorus/Flanger'
                      ParentShowHint = False
                      ShowHint = False
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object PanelInstrumentChannelChorusFlangerFeedBackLeft: TSGTK0Panel
                        Left = 0
                        Top = 70
                        Width = 237
                        Height = 30
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerFeedBackLeft: TLabel
                          Left = 24
                          Top = 8
                          Width = 34
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'FB Left'
                        end
                        object LabelInstrumentChannelChorusFlangerFeedBackLeft: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerFeedBackLeft: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Min = -128
                          Max = 127
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerFeedBackLeftScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerOptions: TSGTK0Panel
                        Left = 482
                        Top = 0
                        Width = 234
                        Height = 30
                        TabOrder = 1
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxInstrumentChannelChorusFlangerActive: TSGTK0CheckBox
                          Left = 8
                          Top = 6
                          Width = 82
                          Height = 17
                          Caption = 'Active'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelChorusFlangerActiveClick
                        end
                        object SGTK0Panel62: TSGTK0Panel
                          Left = 118
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                        object CheckBoxInstrumentChannelChorusFlangerCarry: TSGTK0CheckBox
                          Left = 123
                          Top = 7
                          Width = 96
                          Height = 17
                          Caption = 'Carry'
                          Checked = True
                          ParentColor = False
                          TabOrder = 2
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelChorusFlangerCarryClick
                        end
                      end
                      object PanelInstrumentChannelChorusFlangerWet: TSGTK0Panel
                        Left = 0
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 2
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerWet: TLabel
                          Left = 38
                          Top = 8
                          Width = 20
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Wet'
                        end
                        object LabelInstrumentChannelChorusFlangerWet: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerWet: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerWetScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerFeedBackRight: TSGTK0Panel
                        Left = 241
                        Top = 70
                        Width = 237
                        Height = 30
                        TabOrder = 3
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerFeedBackRight: TLabel
                          Left = 17
                          Top = 8
                          Width = 41
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'FB Right'
                        end
                        object LabelInstrumentChannelChorusFlangerFeedBackRight: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerFeedBackRight: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Min = -128
                          Max = 127
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerFeedBackRightScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerLFODepthLeft: TSGTK0Panel
                        Left = 0
                        Top = 140
                        Width = 237
                        Height = 30
                        TabOrder = 4
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerLFODepthLeft: TLabel
                          Left = 3
                          Top = 8
                          Width = 55
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'LFODepthL'
                        end
                        object LabelInstrumentChannelChorusFlangerLFODepthLeft: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerLFODepthLeft: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerLFODepthLeftScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerLFORateLeft: TSGTK0Panel
                        Left = 0
                        Top = 105
                        Width = 237
                        Height = 30
                        TabOrder = 5
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerLFORateLeft: TLabel
                          Left = 3
                          Top = 8
                          Width = 55
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'LFO Rate L'
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'MS Sans Serif'
                          Font.Style = []
                          ParentFont = False
                        end
                        object LabelInstrumentChannelChorusFlangerLFORateLeft: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerLFORateLeft: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerLFORateLeftScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerLFOPhaseLeft: TSGTK0Panel
                        Left = 0
                        Top = 174
                        Width = 237
                        Height = 30
                        TabOrder = 6
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerLFOPhaseLeft: TLabel
                          Left = 2
                          Top = 8
                          Width = 56
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'LFOPhaseL'
                        end
                        object LabelInstrumentChannelChorusFlangerLFOPhaseLeft: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerLFOPhaseLeft: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerLFOPhaseLeftScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerLFOPhaseRight: TSGTK0Panel
                        Left = 241
                        Top = 174
                        Width = 237
                        Height = 30
                        TabOrder = 7
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerLFOPhaseRight: TLabel
                          Left = 1
                          Top = 9
                          Width = 58
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'LFOPhaseR'
                        end
                        object LabelInstrumentChannelChorusFlangerLFOPhaseRight: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerLFOPhaseRight: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerLFOPhaseRightScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerLFODepthRight: TSGTK0Panel
                        Left = 241
                        Top = 140
                        Width = 237
                        Height = 30
                        TabOrder = 8
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerLFODepthRight: TLabel
                          Left = 1
                          Top = 8
                          Width = 57
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'LFODepthR'
                        end
                        object LabelInstrumentChannelChorusFlangerLFODepthRight: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerLFODepthRight: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerLFODepthRightScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerLFORateRight: TSGTK0Panel
                        Left = 241
                        Top = 105
                        Width = 237
                        Height = 30
                        TabOrder = 9
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerLFORateRight: TLabel
                          Left = 1
                          Top = 8
                          Width = 57
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'LFO Rate R'
                        end
                        object LabelInstrumentChannelChorusFlangerLFORateRight: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerLFORateRight: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerLFORateRightScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerDry: TSGTK0Panel
                        Left = 241
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 10
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerDry: TLabel
                          Left = 42
                          Top = 8
                          Width = 16
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Dry'
                        end
                        object LabelInstrumentChannelChorusFlangerDry: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerDry: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerDryScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerTimeRight: TSGTK0Panel
                        Left = 241
                        Top = 35
                        Width = 237
                        Height = 30
                        TabOrder = 11
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerTimeRight: TLabel
                          Left = 7
                          Top = 8
                          Width = 51
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Time Right'
                        end
                        object LabelInstrumentChannelChorusFlangerTimeRight: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerTimeRight: TSGTK0Scrollbar
                          Left = 63
                          Top = 7
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerTimeRightScroll
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
                      end
                      object PanelInstrumentChannelChorusFlangerTimeLeft: TSGTK0Panel
                        Left = 0
                        Top = 35
                        Width = 237
                        Height = 30
                        TabOrder = 12
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelChorusFlangerTimeLeft: TLabel
                          Left = 14
                          Top = 8
                          Width = 44
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Time Left'
                        end
                        object LabelInstrumentChannelChorusFlangerTimeLeft: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerTimeLeft: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerTimeLeftScroll
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
                      end
                      object SGTK0Panel171: TSGTK0Panel
                        Left = 482
                        Top = 35
                        Width = 234
                        Height = 30
                        TabOrder = 13
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object SGTK0CheckBoxInstrumentChannelChorusFlangerFine: TSGTK0CheckBox
                          Left = 8
                          Top = 6
                          Width = 82
                          Height = 17
                          Caption = 'Fine'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = SGTK0CheckBoxInstrumentChannelChorusFlangerFineClick
                        end
                        object SGTK0Panel177: TSGTK0Panel
                          Left = 118
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                      end
                      object SGTK0Panel180: TSGTK0Panel
                        Left = 482
                        Top = 70
                        Width = 234
                        Height = 30
                        TabOrder = 14
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelInstrumentChannelChorusFlangerCountTitle: TLabel
                          Left = 30
                          Top = 8
                          Width = 28
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Count'
                        end
                        object LabelInstrumentChannelChorusFlangerCount: TLabel
                          Left = 206
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelChorusFlangerCount: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 140
                          Height = 17
                          Min = 1
                          Max = 32
                          Position = 1
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelChorusFlangerCountScroll
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
                      end
                    end
                    object TabSheetInstrumentChannelCompressor: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Compressor'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object PanelInstrumentChannelCompressorMode: TSGTK0Panel
                        Left = 0
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorMode: TLabel
                          Left = 31
                          Top = 8
                          Width = 27
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Mode'
                        end
                        object ComboBoxInstrumentChannelCompressorMode: TSGTK0ComboBox
                          Left = 63
                          Top = 5
                          Width = 170
                          Height = 21
                          Style = csDropDownList
                          Items.Strings = (
                            'None'
                            'Mono Env Follow Peak'
                            'Mono Average Peak'
                            'Mono Minimum Peak'
                            'Mono Maximum Peak'
                            'Mono LowPass RMS'
                            'Mono Average RMS'
                            'Stereo Env Follow Peak'
                            'Stereo Average Peak'
                            'Stereo Minimum Peak'
                            'Stereo Maximum Peak'
                            'Stereo LowPass RMS'
                            'Stereo Average RMS')
                          ParentShowHint = False
                          ShowHint = False
                          TabOrder = 0
                          ItemIndex = -1
                          OnChange = ComboBoxInstrumentChannelCompressorModeChange
                        end
                      end
                      object PanelInstrumentChannelCompressorThreshold: TSGTK0Panel
                        Left = 241
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 1
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorThreshold: TLabel
                          Left = 11
                          Top = 8
                          Width = 47
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Threshold'
                        end
                        object LabelInstrumentChannelCompressorThreshold: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorThreshold: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 999
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorThresholdScroll
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
                      end
                      object PanelInstrumentChannelCompressorLookAhead: TSGTK0Panel
                        Left = 241
                        Top = 35
                        Width = 237
                        Height = 30
                        TabOrder = 2
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorWindow: TLabel
                          Left = 19
                          Top = 8
                          Width = 39
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Window'
                        end
                        object LabelInstrumentChannelCompressorWindow: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorWindow: TSGTK0Scrollbar
                          Left = 63
                          Top = 8
                          Width = 142
                          Height = 17
                          Max = 999
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorWindowScroll
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
                      end
                      object PanelInstrumentChannelCompressorRatio: TSGTK0Panel
                        Left = 0
                        Top = 35
                        Width = 237
                        Height = 30
                        TabOrder = 3
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorRatio: TLabel
                          Left = 33
                          Top = 8
                          Width = 25
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Ratio'
                        end
                        object LabelInstrumentChannelCompressorRatio: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorRatio: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorRatioScroll
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
                      end
                      object PanelInstrumentChannelCompressorOutGain: TSGTK0Panel
                        Left = 241
                        Top = 70
                        Width = 237
                        Height = 30
                        TabOrder = 4
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorOutGain: TLabel
                          Left = 16
                          Top = 8
                          Width = 42
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Out Gain'
                        end
                        object LabelInstrumentChannelCompressorOutGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorOutGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Min = -999
                          Max = 999
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorOutGainScroll
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
                      end
                      object PanelInstrumentChannelCompressorSoftHardKnee: TSGTK0Panel
                        Left = 0
                        Top = 70
                        Width = 237
                        Height = 30
                        TabOrder = 5
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorSoftHardKnee: TLabel
                          Left = 6
                          Top = 8
                          Width = 52
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'SoHaKnee'
                        end
                        object LabelInstrumentChannelCompressorSoftHardKnee: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorSoftHardKnee: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorSoftHardKneeScroll
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
                      end
                      object PanelInstrumentChannelCompressorAttack: TSGTK0Panel
                        Left = 0
                        Top = 105
                        Width = 237
                        Height = 30
                        TabOrder = 6
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorAttack: TLabel
                          Left = 27
                          Top = 8
                          Width = 31
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Attack'
                        end
                        object LabelInstrumentChannelCompressorAttack: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorAttack: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 999
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorAttackScroll
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
                      end
                      object PanelInstrumentChannelCompressorRelease: TSGTK0Panel
                        Left = 241
                        Top = 105
                        Width = 237
                        Height = 30
                        TabOrder = 7
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelCompressorRelease: TLabel
                          Left = 19
                          Top = 8
                          Width = 39
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Release'
                        end
                        object LabelInstrumentChannelCompressorRelease: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelCompressorRelease: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 999
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelCompressorReleaseScroll
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
                      end
                      object PanelInstrumentChannelCompressorOptions: TSGTK0Panel
                        Left = 482
                        Top = 0
                        Width = 234
                        Height = 30
                        TabOrder = 8
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxInstrumentChannelCompressorAutoGain: TSGTK0CheckBox
                          Left = 8
                          Top = 6
                          Width = 82
                          Height = 17
                          Caption = 'Auto Gain'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelCompressorAutoGainClick
                        end
                        object SGTK0Panel66: TSGTK0Panel
                          Left = 118
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                      end
                      object SGTK0Panel197: TSGTK0Panel
                        Left = 482
                        Top = 34
                        Width = 234
                        Height = 30
                        TabOrder = 9
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label133: TLabel
                          Left = 25
                          Top = 8
                          Width = 33
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Side In'
                        end
                        object ComboBoxInstrumentChannelCompressorSideIn: TSGTK0ComboBox
                          Left = 63
                          Top = 5
                          Width = 167
                          Height = 21
                          Style = csDropDownList
                          Items.Strings = (
                            'None'
                            'Channel 1'
                            'Channel 2'
                            'Channel 3'
                            'Channel 4'
                            'Channel 5'
                            'Channel 6'
                            'Channel 7'
                            'Channel 8'
                            'Channel 9'
                            'Channel 10'
                            'Channel 11'
                            'Channel 12'
                            'Channel 13'
                            'Channel 14'
                            'Channel 15'
                            'Channel 16')
                          ParentShowHint = False
                          ShowHint = False
                          TabOrder = 0
                          ItemIndex = -1
                          OnChange = ComboBoxInstrumentChannelCompressorSideInChange
                        end
                      end
                    end
                    object TabSheetInstrumentChannelSpeech: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Speech'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object PanelInstrumentChannelSpeechFrameLength: TSGTK0Panel
                        Left = 241
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelSpeechFrameLength: TLabel
                          Left = 8
                          Top = 8
                          Width = 50
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Frame Len'
                        end
                        object LabelInstrumentChannelSpeechFrameLength: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechFrameLength: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 127
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechFrameLengthScroll
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
                      end
                      object PanelInstrumentChannelSpeechTextNumber: TSGTK0Panel
                        Left = 241
                        Top = 35
                        Width = 237
                        Height = 30
                        TabOrder = 1
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object LabelNameInstrumentChannelSpeechTextNumber: TLabel
                          Left = 2
                          Top = 8
                          Width = 56
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Textnumber'
                        end
                        object LabelInstrumentChannelSpeechTextNumber: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechTextNumber: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 127
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechTextNumberScroll
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
                      end
                      object PanelInstrumentChannelSpeechSpeed: TSGTK0Panel
                        Left = 0
                        Top = 35
                        Width = 237
                        Height = 30
                        TabOrder = 2
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label27: TLabel
                          Left = 27
                          Top = 8
                          Width = 31
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Speed'
                        end
                        object LabelInstrumentChannelSpeechSpeed: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechSpeed: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 127
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechSpeedScroll
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
                      end
                      object PanelInstrumentChannelSpeechOptions: TSGTK0Panel
                        Left = 0
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 3
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxInstrumentChannelSpeechActive: TSGTK0CheckBox
                          Left = 8
                          Top = 6
                          Width = 82
                          Height = 17
                          Caption = 'Active'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelSpeechActiveClick
                        end
                        object SGTK0Panel72: TSGTK0Panel
                          Left = 118
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                      end
                      object SGTK0Panel117: TSGTK0Panel
                        Left = 0
                        Top = 70
                        Width = 237
                        Height = 30
                        TabOrder = 4
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label53: TLabel
                          Left = 34
                          Top = 8
                          Width = 24
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Color'
                        end
                        object LabelInstrumentChannelSpeechColor: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechColor: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Min = -64
                          Max = 63
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechColorScroll
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
                      end
                      object SGTK0Panel118: TSGTK0Panel
                        Left = 240
                        Top = 70
                        Width = 237
                        Height = 30
                        TabOrder = 5
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label55: TLabel
                          Left = 9
                          Top = 8
                          Width = 49
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'NoiseGain'
                        end
                        object LabelInstrumentChannelSpeechNoiseGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechNoiseGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechNoiseGainScroll
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
                      end
                      object SGTK0Panel119: TSGTK0Panel
                        Left = 0
                        Top = 104
                        Width = 237
                        Height = 30
                        TabOrder = 6
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label56: TLabel
                          Left = 36
                          Top = 8
                          Width = 22
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Gain'
                        end
                        object LabelInstrumentChannelSpeechGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechGainScroll
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
                      end
                      object SGTK0Panel120: TSGTK0Panel
                        Left = 0
                        Top = 138
                        Width = 237
                        Height = 139
                        TabOrder = 7
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label57: TLabel
                          Left = 46
                          Top = 8
                          Width = 12
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'F4'
                        end
                        object Label58: TLabel
                          Left = 46
                          Top = 30
                          Width = 12
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'F5'
                        end
                        object Label59: TLabel
                          Left = 46
                          Top = 52
                          Width = 12
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'F6'
                        end
                        object Label60: TLabel
                          Left = 45
                          Top = 74
                          Width = 13
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'B4'
                        end
                        object Label61: TLabel
                          Left = 45
                          Top = 96
                          Width = 13
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'B5'
                        end
                        object Label62: TLabel
                          Left = 45
                          Top = 118
                          Width = 13
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'B6'
                        end
                        object EditInstrumentChannelSpeechF4: TSGTK0Edit
                          Left = 63
                          Top = 6
                          Width = 170
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 0
                          Text = '3250'
                          OnChange = EditInstrumentChannelSpeechF4Change
                        end
                        object EditInstrumentChannelSpeechF5: TSGTK0Edit
                          Left = 63
                          Top = 28
                          Width = 170
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 1
                          Text = '3700'
                          OnChange = EditInstrumentChannelSpeechF5Change
                        end
                        object EditInstrumentChannelSpeechF6: TSGTK0Edit
                          Left = 63
                          Top = 50
                          Width = 170
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 2
                          Text = '4990'
                          OnChange = EditInstrumentChannelSpeechF6Change
                        end
                        object EditInstrumentChannelSpeechB6: TSGTK0Edit
                          Left = 63
                          Top = 116
                          Width = 170
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 3
                          Text = '500'
                          OnChange = EditInstrumentChannelSpeechB6Change
                        end
                        object EditInstrumentChannelSpeechB5: TSGTK0Edit
                          Left = 63
                          Top = 94
                          Width = 170
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 4
                          Text = '200'
                          OnChange = EditInstrumentChannelSpeechB5Change
                        end
                        object EditInstrumentChannelSpeechB4: TSGTK0Edit
                          Left = 63
                          Top = 72
                          Width = 170
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 5
                          Text = '200'
                          OnChange = EditInstrumentChannelSpeechB4Change
                        end
                      end
                      object SGTK0Panel163: TSGTK0Panel
                        Left = 240
                        Top = 104
                        Width = 237
                        Height = 30
                        TabOrder = 8
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label88: TLabel
                          Left = 12
                          Top = 8
                          Width = 46
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'CascGain'
                        end
                        object LabelInstrumentChannelSpeechCascadeGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechCascadeGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechCascadeGainScroll
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
                      end
                      object SGTK0Panel164: TSGTK0Panel
                        Left = 240
                        Top = 138
                        Width = 237
                        Height = 30
                        TabOrder = 9
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label89: TLabel
                          Left = 14
                          Top = 8
                          Width = 44
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'ParaGain'
                        end
                        object LabelInstrumentChannelSpeechParallelGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechParallelGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechParallelGainScroll
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
                      end
                      object SGTK0Panel165: TSGTK0Panel
                        Left = 240
                        Top = 172
                        Width = 237
                        Height = 30
                        TabOrder = 10
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label91: TLabel
                          Left = 18
                          Top = 8
                          Width = 40
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'AspGain'
                        end
                        object LabelInstrumentChannelSpeechAspirationGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechAspirationGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechAspirationGainScroll
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
                      end
                      object SGTK0Panel166: TSGTK0Panel
                        Left = 240
                        Top = 206
                        Width = 237
                        Height = 30
                        TabOrder = 11
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label107: TLabel
                          Left = 13
                          Top = 8
                          Width = 45
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'FricaGain'
                        end
                        object LabelInstrumentChannelSpeechFricationGain: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelSpeechFricationGain: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelSpeechFricationGainScroll
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
                      end
                    end
                    object TabSheetInstrumentChannelPitchShifter: TSGTK0TabSheet
                      Hint = 'PitchShifter'
                      BorderWidth = 5
                      Caption = 'PitchShifter'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0Panel109: TSGTK0Panel
                        Left = 0
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxInstrumentChannelPitchShifterActive: TSGTK0CheckBox
                          Left = 8
                          Top = 6
                          Width = 82
                          Height = 17
                          Caption = 'Active'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelPitchShifterActiveClick
                        end
                        object SGTK0Panel110: TSGTK0Panel
                          Left = 118
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                      end
                      object SGTK0Panel111: TSGTK0Panel
                        Left = 241
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 1
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label50: TLabel
                          Left = 33
                          Top = 8
                          Width = 25
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Tune'
                        end
                        object LabelInstrumentChannelPitchShifterTune: TLabel
                          Left = 208
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelPitchShifterTune: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 142
                          Height = 17
                          Min = -128
                          Max = 127
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelPitchShifterTuneScroll
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
                      end
                      object SGTK0Panel112: TSGTK0Panel
                        Left = 482
                        Top = 0
                        Width = 234
                        Height = 30
                        TabOrder = 2
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label52: TLabel
                          Left = 9
                          Top = 8
                          Width = 45
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'FineTune'
                        end
                        object LabelInstrumentChannelPitchShifterFineTune: TLabel
                          Left = 204
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelPitchShifterFineTune: TSGTK0Scrollbar
                          Left = 59
                          Top = 6
                          Width = 142
                          Height = 17
                          Min = -100
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelPitchShifterFineTuneScroll
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
                      end
                    end
                    object TabSheetInstrumentChannelEQ: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'EQ'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0Panel121: TSGTK0Panel
                        Left = 0
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxInstrumentChannelEQActive: TSGTK0CheckBox
                          Left = 8
                          Top = 6
                          Width = 82
                          Height = 17
                          Caption = 'Active'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelEQActiveClick
                        end
                        object SGTK0Panel122: TSGTK0Panel
                          Left = 118
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                        object ComboBoxInstrumentChannelEQMode: TSGTK0ComboBox
                          Left = 122
                          Top = 4
                          Width = 111
                          Height = 21
                          Style = csDropDownList
                          Items.Strings = (
                            '-6 .. 6 dB'
                            '-12 .. 12 dB'
                            '-24 .. 24 dB')
                          TabOrder = 2
                          Text = '-6 .. 6 dB'
                          ItemIndex = 0
                          OnChange = ComboBoxInstrumentChannelEQModeChange
                        end
                      end
                      object TSGTK0Panel
                        Left = 0
                        Top = 35
                        Width = 479
                        Height = 230
                        TabOrder = 1
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label63: TLabel
                          Left = 6
                          Top = 60
                          Width = 18
                          Height = 13
                          Alignment = taCenter
                          AutoSize = False
                          Caption = '24'
                        end
                        object Label64: TLabel
                          Left = 6
                          Top = 166
                          Width = 18
                          Height = 13
                          Alignment = taCenter
                          AutoSize = False
                          Caption = '-24'
                        end
                        object Label65: TLabel
                          Left = 6
                          Top = 110
                          Width = 18
                          Height = 13
                          Alignment = taCenter
                          AutoSize = False
                          Caption = '0'
                        end
                        object Label66: TLabel
                          Left = 456
                          Top = 166
                          Width = 18
                          Height = 13
                          Alignment = taCenter
                          AutoSize = False
                          Caption = '-24'
                        end
                        object Label67: TLabel
                          Left = 456
                          Top = 110
                          Width = 18
                          Height = 13
                          Alignment = taCenter
                          AutoSize = False
                          Caption = '0'
                        end
                        object Label68: TLabel
                          Left = 456
                          Top = 60
                          Width = 18
                          Height = 13
                          Alignment = taCenter
                          AutoSize = False
                          Caption = '24'
                        end
                        object SGTK0Panel124: TSGTK0Panel
                          Left = 26
                          Top = 12
                          Width = 427
                          Height = 206
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object SGTK0Panel123: TSGTK0Panel
                            Left = 8
                            Top = 100
                            Width = 411
                            Height = 10
                            TabOrder = 30
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 3
                            object SGTK0Panel125: TSGTK0Panel
                              Left = 4
                              Top = 4
                              Width = 403
                              Height = 2
                              Align = alClient
                              TabOrder = 0
                              UseDockManager = True
                              BevelOuter = bvLowered
                            end
                          end
                          object EditInstrumentChannelEQBandHz1: TSGTK0Edit
                            Left = 4
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 0
                            Text = '31'
                            OnChange = EditInstrumentChannelEQBandHz1Change
                          end
                          object TSGTK0Panel
                            Left = 13
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain1: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain1Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain1: TSGTK0Panel
                            Left = 4
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0,00'
                            TabOrder = 2
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz2: TSGTK0Edit
                            Left = 46
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 3
                            Text = '62'
                            OnChange = EditInstrumentChannelEQBandHz2Change
                          end
                          object TSGTK0Panel
                            Left = 55
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 4
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain2: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain2Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain2: TSGTK0Panel
                            Left = 46
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0,00'
                            TabOrder = 5
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz3: TSGTK0Edit
                            Left = 88
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 6
                            Text = '125'
                            OnChange = EditInstrumentChannelEQBandHz3Change
                          end
                          object TSGTK0Panel
                            Left = 97
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 7
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain3: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain3Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain3: TSGTK0Panel
                            Left = 88
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 8
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz4: TSGTK0Edit
                            Left = 130
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 9
                            Text = '250'
                            OnChange = EditInstrumentChannelEQBandHz4Change
                          end
                          object TSGTK0Panel
                            Left = 139
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 10
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain4: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain4Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain4: TSGTK0Panel
                            Left = 130
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 11
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz5: TSGTK0Edit
                            Left = 172
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 12
                            Text = '500'
                            OnChange = EditInstrumentChannelEQBandHz5Change
                          end
                          object TSGTK0Panel
                            Left = 181
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 13
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain5: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain5Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain5: TSGTK0Panel
                            Left = 172
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 14
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz6: TSGTK0Edit
                            Left = 214
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 15
                            Text = '1000'
                            OnChange = EditInstrumentChannelEQBandHz6Change
                          end
                          object TSGTK0Panel
                            Left = 223
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 16
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain6: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain6Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain6: TSGTK0Panel
                            Left = 214
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 17
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz7: TSGTK0Edit
                            Left = 256
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 18
                            Text = '2000'
                            OnChange = EditInstrumentChannelEQBandHz7Change
                          end
                          object TSGTK0Panel
                            Left = 265
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 19
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain7: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain7Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain7: TSGTK0Panel
                            Left = 256
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0,00'
                            TabOrder = 20
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz8: TSGTK0Edit
                            Left = 298
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 21
                            Text = '4000'
                            OnChange = EditInstrumentChannelEQBandHz8Change
                          end
                          object TSGTK0Panel
                            Left = 307
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 22
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain8: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain8Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain8: TSGTK0Panel
                            Left = 298
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 23
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz9: TSGTK0Edit
                            Left = 340
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 24
                            Text = '8000'
                            OnChange = EditInstrumentChannelEQBandHz9Change
                          end
                          object TSGTK0Panel
                            Left = 349
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 25
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain9: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain9Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain9: TSGTK0Panel
                            Left = 340
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 26
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object EditInstrumentChannelEQBandHz10: TSGTK0Edit
                            Left = 382
                            Top = 182
                            Width = 40
                            Height = 19
                            ColorFocused = 3158016
                            TabOrder = 27
                            Text = '16000'
                            OnChange = EditInstrumentChannelEQBandHz10Change
                          end
                          object TSGTK0Panel
                            Left = 391
                            Top = 32
                            Width = 22
                            Height = 147
                            TabOrder = 28
                            UseDockManager = True
                            BevelOuter = bvLowered
                            BorderWidth = 2
                            object ScrollbarInstrumentChannelEQGain10: TSGTK0Scrollbar
                              Left = 3
                              Top = 3
                              Width = 16
                              Height = 141
                              Max = 240
                              Position = 120
                              OnScroll = ScrollbarInstrumentChannelEQGain10Scroll
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
                              Align = alClient
                              Color = 2105344
                              ParentColor = False
                            end
                          end
                          object PanelInstrumentChannelEQGain10: TSGTK0Panel
                            Left = 382
                            Top = 4
                            Width = 40
                            Height = 25
                            Caption = '0.00'
                            TabOrder = 29
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                        end
                        object SGTK0Panel126: TSGTK0Panel
                          Left = 4
                          Top = 16
                          Width = 19
                          Height = 25
                          Caption = 'dB'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                        object SGTK0Panel127: TSGTK0Panel
                          Left = 456
                          Top = 16
                          Width = 19
                          Height = 25
                          Caption = 'dB'
                          TabOrder = 2
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                        object SGTK0Panel128: TSGTK0Panel
                          Left = 4
                          Top = 194
                          Width = 19
                          Height = 20
                          Caption = 'Hz'
                          TabOrder = 3
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                        object SGTK0Panel129: TSGTK0Panel
                          Left = 456
                          Top = 194
                          Width = 19
                          Height = 20
                          Caption = 'Hz'
                          TabOrder = 4
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                      end
                      object ButtonInstrumentChannelEQReset: TSGTK0Button
                        Left = 2
                        Top = 272
                        Width = 43
                        Height = 27
                        Caption = 'Reset'
                        ParentColor = False
                        TabOrder = 2
                        OnClick = ButtonInstrumentChannelEQResetClick
                      end
                      object SGTK0Panel139: TSGTK0Panel
                        Left = 241
                        Top = 0
                        Width = 237
                        Height = 30
                        TabOrder = 3
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label81: TLabel
                          Left = 4
                          Top = 8
                          Width = 36
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Preamp'
                        end
                        object LabelInstrumentChannelEQPreAmp: TLabel
                          Left = 168
                          Top = 7
                          Width = 63
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '0,00 dB'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarInstrumentChannelEQPreAmp: TSGTK0Scrollbar
                          Left = 45
                          Top = 6
                          Width = 120
                          Height = 17
                          Max = 240
                          Position = 120
                          Kind = sbHorizontal
                          OnScroll = ScrollbarInstrumentChannelEQPreAmpScroll
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
                      end
                      object SGTK0Panel141: TSGTK0Panel
                        Left = 94
                        Top = 272
                        Width = 105
                        Height = 27
                        TabOrder = 4
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxInstrumentChannelEQCascaded: TSGTK0CheckBox
                          Left = 4
                          Top = 5
                          Width = 69
                          Height = 17
                          Caption = 'Cascaded'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelEQCascadedClick
                        end
                        object CheckBoxInstrumentChannelEQAddCascaded: TSGTK0CheckBox
                          Left = 74
                          Top = 5
                          Width = 24
                          Height = 17
                          Caption = '+'
                          ParentColor = False
                          TabOrder = 1
                          TabStop = True
                          OnClick = CheckBoxInstrumentChannelEQAddCascadedClick
                        end
                      end
                      object SGTK0Panel142: TSGTK0Panel
                        Left = 202
                        Top = 272
                        Width = 141
                        Height = 27
                        TabOrder = 5
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label83: TLabel
                          Left = 6
                          Top = 7
                          Width = 65
                          Height = 13
                          Caption = 'Octave factor'
                        end
                        object EditInstrumentChannelEQOctaveFactor: TSGTK0Edit
                          Left = 76
                          Top = 4
                          Width = 61
                          Height = 19
                          ColorFocused = 3158016
                          TabOrder = 0
                          Text = '1.00'
                          OnChange = EditInstrumentChannelEQOctaveFactorChange
                        end
                      end
                      object ButtonInstrumentChannelEQLoadEQF: TSGTK0Button
                        Left = 346
                        Top = 272
                        Width = 57
                        Height = 27
                        Caption = 'Load EQF'
                        ParentColor = False
                        TabOrder = 6
                        OnClick = ButtonInstrumentChannelEQLoadEQFClick
                      end
                      object ButtonInstrumentChannelEQSaveEQF: TSGTK0Button
                        Left = 406
                        Top = 272
                        Width = 57
                        Height = 27
                        Caption = 'Save EQF'
                        ParentColor = False
                        TabOrder = 7
                        OnClick = ButtonInstrumentChannelEQSaveEQFClick
                      end
                      object ButtonInstrumentChannelEQResetISO: TSGTK0Button
                        Left = 48
                        Top = 272
                        Width = 43
                        Height = 27
                        Caption = 'ISO'
                        ParentColor = False
                        TabOrder = 8
                        OnClick = ButtonInstrumentChannelEQResetISOClick
                      end
                    end
                    object TabSheetInstrumentChannelSignalRouteOrder: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'Order'
                      object ButtonInstrumentChannelOrderMoveToUp: TSGTK0Button
                        Left = 210
                        Top = 5
                        Width = 77
                        Height = 21
                        Caption = 'Move to up'
                        ParentColor = False
                        TabOrder = 0
                        OnClick = ButtonInstrumentChannelOrderMoveToUpClick
                      end
                      object ButtonInstrumentChannelOrderMoveToDown: TSGTK0Button
                        Left = 210
                        Top = 27
                        Width = 77
                        Height = 21
                        Caption = 'Move to down'
                        ParentColor = False
                        TabOrder = 1
                        OnClick = ButtonInstrumentChannelOrderMoveToDownClick
                      end
                      object ListBoxInstrumentChannelOrder: TSGTK0ListBox
                        Left = 5
                        Top = 5
                        Width = 203
                        Height = 156
                        Items.Strings = (
                          'Distortion'
                          'Filter'
                          'Delay'
                          'Chorus/Flanger'
                          'Compressor'
                          'Speech'
                          'PitchShifter'
                          'EQ')
                      end
                    end
                    object TabSheetInstrumentChannelLFO: TSGTK0TabSheet
                      BorderWidth = 5
                      Caption = 'LFO'
                      ExplicitLeft = 0
                      ExplicitTop = 0
                      ExplicitWidth = 0
                      ExplicitHeight = 0
                      object SGTK0Panel106: TSGTK0Panel
                        Left = 243
                        Top = 5
                        Width = 232
                        Height = 30
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object CheckBoxChannelLFOActive: TSGTK0CheckBox
                          Left = 8
                          Top = 7
                          Width = 82
                          Height = 17
                          Caption = 'Active'
                          ParentColor = False
                          TabOrder = 0
                          TabStop = True
                          OnClick = CheckBoxChannelLFOActiveClick
                        end
                        object SGTK0Panel186: TSGTK0Panel
                          Left = 115
                          Top = 2
                          Width = 1
                          Height = 26
                          Caption = 'SGTK0Panel22'
                          TabOrder = 1
                          UseDockManager = True
                          BevelOuter = bvLowered
                        end
                      end
                      object SGTK0Panel187: TSGTK0Panel
                        Left = 5
                        Top = 5
                        Width = 232
                        Height = 30
                        TabOrder = 1
                        UseDockManager = True
                        BevelOuter = bvLowered
                        object Label127: TLabel
                          Left = 35
                          Top = 8
                          Width = 23
                          Height = 13
                          Alignment = taRightJustify
                          Caption = 'Rate'
                        end
                        object LabelChannelLFORate: TLabel
                          Left = 202
                          Top = 7
                          Width = 23
                          Height = 14
                          Alignment = taRightJustify
                          AutoSize = False
                          Caption = '000'
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                        end
                        object ScrollbarChannelLFORate: TSGTK0Scrollbar
                          Left = 63
                          Top = 6
                          Width = 134
                          Height = 17
                          Max = 255
                          Kind = sbHorizontal
                          OnScroll = ScrollbarChannelLFORateScroll
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
                      end
                    end
                  end
                end
                object TabSheetInstrumentSamples: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Samples'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object SGTK0Panel71: TSGTK0Panel
                    Left = 0
                    Top = 0
                    Width = 728
                    Height = 337
                    ParentColor = True
                    Align = alClient
                    TabOrder = 0
                    UseDockManager = True
                    OnClick = SGTK0Panel71Click
                    BevelOuter = bvLowered
                    BorderWidth = 3
                    object SGTK0Panel84: TSGTK0Panel
                      Left = 4
                      Top = 4
                      Width = 720
                      Height = 39
                      ParentColor = True
                      Align = alTop
                      TabOrder = 0
                      UseDockManager = True
                      OnClick = SGTK0Panel84Click
                      BevelOuter = bvLowered
                      object ComboBoxSamples: TSGTK0ComboBox
                        Left = 8
                        Top = 8
                        Width = 128
                        Height = 22
                        Style = csDropDownList
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 0
                        ItemIndex = -1
                        OnChange = ComboBoxSamplesChange
                      end
                      object EditSampleName: TSGTK0Edit
                        Left = 143
                        Top = 8
                        Width = 128
                        Height = 22
                        ColorFocused = 3158016
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 1
                        OnChange = EditSampleNameChange
                      end
                      object SGTK0Panel89: TSGTK0Panel
                        Left = 278
                        Top = 8
                        Width = 1
                        Height = 21
                        ParentColor = True
                        TabOrder = 2
                        UseDockManager = True
                        BevelOuter = bvLowered
                      end
                      object ButtonSamplesClear: TSGTK0Button
                        Left = 287
                        Top = 8
                        Width = 41
                        Height = 21
                        Caption = 'Clear'
                        ParentColor = False
                        TabOrder = 3
                        OnClick = ButtonSamplesClearClick
                      end
                      object ButtonSamplesInvert: TSGTK0Button
                        Left = 335
                        Top = 8
                        Width = 41
                        Height = 21
                        Caption = 'Invert'
                        ParentColor = False
                        TabOrder = 4
                        OnClick = ButtonSamplesInvertClick
                      end
                      object ButtonSamplesReverse: TSGTK0Button
                        Left = 383
                        Top = 8
                        Width = 49
                        Height = 21
                        Caption = 'Reverse'
                        ParentColor = False
                        TabOrder = 5
                        OnClick = ButtonSamplesReverseClick
                      end
                      object ButtonSamplesNormalize: TSGTK0Button
                        Left = 438
                        Top = 8
                        Width = 57
                        Height = 21
                        Caption = 'Normalize'
                        ParentColor = False
                        TabOrder = 6
                        OnClick = ButtonSamplesNormalizeClick
                      end
                      object PanelSamplesLengthSamples: TSGTK0Panel
                        Left = 502
                        Top = 6
                        Width = 147
                        Height = 25
                        Caption = 'Length: 0 samples'
                        TabOrder = 7
                        UseDockManager = True
                        OnClick = PanelSamplesLengthSamplesClick
                        BevelOuter = bvLowered
                      end
                      object SGTK0ButtonSampleMultiLoad: TSGTK0Button
                        Left = 653
                        Top = 8
                        Width = 62
                        Height = 21
                        Caption = 'Multi load'
                        ParentColor = False
                        TabOrder = 8
                        OnClick = SGTK0ButtonSampleMultiLoadClick
                      end
                    end
                    object SGTK0Panel90: TSGTK0Panel
                      Left = 4
                      Top = 43
                      Width = 720
                      Height = 5
                      ParentColor = True
                      Align = alTop
                      TabOrder = 1
                      UseDockManager = True
                      BevelOuter = bvNone
                    end
                    object SGTK0Panel91: TSGTK0Panel
                      Left = 4
                      Top = 48
                      Width = 720
                      Height = 176
                      ParentColor = True
                      Align = alTop
                      TabOrder = 2
                      UseDockManager = True
                      OnClick = SGTK0Panel91Click
                      BevelOuter = bvLowered
                      BorderWidth = 5
                      object SGTK0Panel92: TSGTK0Panel
                        Left = 6
                        Top = 6
                        Width = 708
                        Height = 164
                        ParentColor = True
                        Align = alClient
                        TabOrder = 0
                        UseDockManager = True
                        OnResize = SGTK0Panel92Resize
                        BevelOuter = bvLowered
                        object GroupBox4: TSGTK0Panel
                          Left = 1
                          Top = 1
                          Width = 706
                          Height = 162
                          Caption = 'Sample'
                          Align = alClient
                          TabOrder = 0
                          UseDockManager = True
                          BevelOuter = bvSpace
                          object Panel1: TSGTK0Panel
                            Left = 1
                            Top = 135
                            Width = 704
                            Height = 26
                            Align = alBottom
                            TabOrder = 0
                            UseDockManager = True
                            OnClick = Panel1Click
                            BevelOuter = bvLowered
                            object ButtonLoadSample: TSGTK0Button
                              Left = 99
                              Top = 3
                              Width = 32
                              Height = 21
                              Caption = 'Load'
                              ParentColor = False
                              TabOrder = 0
                              OnClick = ButtonLoadSampleClick
                            end
                            object ButtonSaveSample: TSGTK0Button
                              Left = 132
                              Top = 3
                              Width = 32
                              Height = 21
                              Caption = 'Save'
                              ParentColor = False
                              TabOrder = 1
                              OnClick = ButtonSaveSampleClick
                            end
                            object ButtonOscSampleCopy: TSGTK0Button
                              Left = 198
                              Top = 3
                              Width = 29
                              Height = 21
                              Caption = 'Copy'
                              ParentColor = False
                              TabOrder = 2
                              OnClick = ButtonOscSampleCopyClick
                            end
                            object ButtonOscSampleCut: TSGTK0Button
                              Left = 228
                              Top = 3
                              Width = 23
                              Height = 21
                              Caption = 'Cut'
                              ParentColor = False
                              TabOrder = 3
                              OnClick = ButtonOscSampleCutClick
                            end
                            object ButtonOscSamplePaste: TSGTK0Button
                              Left = 253
                              Top = 3
                              Width = 33
                              Height = 21
                              Caption = 'Paste'
                              ParentColor = False
                              TabOrder = 4
                              OnClick = ButtonOscSamplePasteClick
                            end
                            object ButtonOscSampleSetLoop: TSGTK0Button
                              Left = 327
                              Top = 3
                              Width = 46
                              Height = 21
                              Caption = 'Set loop'
                              ParentColor = False
                              TabOrder = 5
                              OnClick = ButtonOscSampleSetLoopClick
                            end
                            object ButtonOscSampleDelLoop: TSGTK0Button
                              Left = 374
                              Top = 3
                              Width = 63
                              Height = 21
                              Caption = 'Delete loop'
                              ParentColor = False
                              TabOrder = 6
                              OnClick = ButtonOscSampleDelLoopClick
                            end
                            object ButtonOscSampleDelSustainLoop: TSGTK0Button
                              Left = 522
                              Top = 3
                              Width = 97
                              Height = 21
                              Caption = 'Delete sustain loop'
                              ParentColor = False
                              TabOrder = 7
                              OnClick = ButtonOscSampleDelSustainLoopClick
                            end
                            object ButtonOscSampleSetSustainLoop: TSGTK0Button
                              Left = 438
                              Top = 3
                              Width = 83
                              Height = 21
                              Caption = 'Set sustain loop'
                              ParentColor = False
                              TabOrder = 8
                              OnClick = ButtonOscSampleSetSustainLoopClick
                            end
                            object ButtonOscSampleFixLoops: TSGTK0Button
                              Left = 620
                              Top = 3
                              Width = 61
                              Height = 21
                              Caption = 'Fix loops'
                              ParentColor = False
                              TabOrder = 9
                              OnClick = ButtonOscSampleFixLoopsClick
                            end
                            object ButtonOscSampleZoomPlus: TSGTK0Button
                              Left = 2
                              Top = 3
                              Width = 17
                              Height = 21
                              Caption = '+'
                              ParentColor = False
                              TabOrder = 10
                              OnClick = ButtonOscSampleZoomPlusClick
                            end
                            object ButtonOscSampleZoomMinus: TSGTK0Button
                              Left = 20
                              Top = 3
                              Width = 17
                              Height = 21
                              Caption = '-'
                              ParentColor = False
                              TabOrder = 11
                              OnClick = ButtonOscSampleZoomMinusClick
                            end
                            object ButtonOscSampleDel: TSGTK0Button
                              Left = 287
                              Top = 3
                              Width = 39
                              Height = 21
                              Caption = 'Delete'
                              ParentColor = False
                              TabOrder = 12
                              OnClick = ButtonOscSampleDelClick
                            end
                            object ButtonOscSampleResetZoom: TSGTK0Button
                              Left = 38
                              Top = 3
                              Width = 60
                              Height = 21
                              Caption = 'Zoom reset'
                              ParentColor = False
                              TabOrder = 13
                              OnClick = ButtonOscSampleResetZoomClick
                            end
                            object ButtonOscSampleClear: TSGTK0Button
                              Left = 165
                              Top = 3
                              Width = 32
                              Height = 21
                              Caption = 'Clear'
                              ParentColor = False
                              TabOrder = 14
                              OnClick = ButtonOscSampleClearClick
                            end
                          end
                          object PanelOscSampleWaveEditor: TSGTK0Panel
                            Left = 1
                            Top = 1
                            Width = 704
                            Height = 118
                            Color = clBlack
                            Align = alClient
                            TabOrder = 1
                            UseDockManager = True
                            BevelOuter = bvNone
                          end
                          object ScrollBarSample: TSGTK0Scrollbar
                            Left = 1
                            Top = 119
                            Width = 704
                            Height = 16
                            Kind = sbHorizontal
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
                            Align = alBottom
                            Color = 2105344
                            ParentColor = False
                          end
                        end
                      end
                    end
                    object SGTK0Panel93: TSGTK0Panel
                      Left = 4
                      Top = 224
                      Width = 720
                      Height = 5
                      ParentColor = True
                      Align = alTop
                      TabOrder = 3
                      UseDockManager = True
                      BevelOuter = bvNone
                    end
                    object SGTK0Panel94: TSGTK0Panel
                      Left = 4
                      Top = 229
                      Width = 720
                      Height = 104
                      ParentColor = True
                      Align = alClient
                      TabOrder = 4
                      UseDockManager = True
                      OnClick = SGTK0Panel94Click
                      BevelOuter = bvLowered
                      BorderWidth = 5
                      object SGTK0Panel95: TSGTK0Panel
                        Left = 6
                        Top = 6
                        Width = 708
                        Height = 92
                        ParentColor = True
                        Align = alClient
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        BorderWidth = 3
                        object PageControlInstrumentSample: TSGTK0PageControl
                          Left = 4
                          Top = 4
                          Width = 700
                          Height = 84
                          Align = alClient
                          Tabs.Strings = (
                            'General settings'
                            'Loop'
                            'Sustain loop'
                            'PadSynth'
                            'PadSynth Harmonics'
                            'Script')
                          Color = 2105344
                          ParentColor = False
                          TabOrder = 0
                          ActivePage = TabSheetSampleGeneralSettings
                          object TabSheetSampleGeneralSettings: TSGTK0TabSheet
                            Caption = 'General settings'
                            ExplicitLeft = 0
                            ExplicitTop = 0
                            ExplicitWidth = 0
                            ExplicitHeight = 0
                            object SGTK0Panel81: TSGTK0Panel
                              Left = 4
                              Top = 4
                              Width = 231
                              Height = 27
                              TabOrder = 0
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label26: TLabel
                                Left = 16
                                Top = 6
                                Width = 61
                                Height = 13
                                Caption = 'Sample Rate'
                              end
                              object Label30: TLabel
                                Left = 180
                                Top = 6
                                Width = 13
                                Height = 13
                                Caption = 'Hz'
                              end
                              object EditSamplesSampleRate: TSGTK0Edit
                                Left = 84
                                Top = 4
                                Width = 93
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '44100'
                                OnChange = EditSamplesSampleRateChange
                              end
                            end
                            object SGTK0Panel82: TSGTK0Panel
                              Left = 238
                              Top = 4
                              Width = 232
                              Height = 27
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label31: TLabel
                                Left = 6
                                Top = 6
                                Width = 73
                                Height = 13
                                Caption = 'Phase Samples'
                              end
                              object EditSamplesPhaseSamples: TSGTK0Edit
                                Left = 84
                                Top = 4
                                Width = 93
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '44100'
                                OnChange = EditSamplesPhaseSamplesChange
                              end
                              object ButtonSamplesPhaseSamplesCalc: TSGTK0Button
                                Left = 180
                                Top = 3
                                Width = 31
                                Height = 22
                                Caption = 'Calc'
                                ParentColor = False
                                TabOrder = 1
                                OnClick = ButtonSamplesPhaseSamplesCalcClick
                              end
                            end
                            object SGTK0Panel83: TSGTK0Panel
                              Left = 4
                              Top = 33
                              Width = 231
                              Height = 27
                              TabOrder = 2
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label32: TLabel
                                Left = 54
                                Top = 8
                                Width = 23
                                Height = 13
                                Caption = 'Note'
                              end
                              object ComboBoxSamplesNote: TSGTK0ComboBox
                                Left = 84
                                Top = 4
                                Width = 143
                                Height = 21
                                Style = csDropDownList
                                TabOrder = 0
                                ItemIndex = -1
                                OnChange = ComboBoxSamplesNoteChange
                              end
                            end
                            object SGTK0Panel86: TSGTK0Panel
                              Left = 238
                              Top = 33
                              Width = 232
                              Height = 28
                              TabOrder = 3
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label33: TLabel
                                Left = 6
                                Top = 8
                                Width = 48
                                Height = 13
                                Caption = 'Fine Tune'
                              end
                              object LabelSamplesFineTune: TLabel
                                Left = 202
                                Top = 7
                                Width = 23
                                Height = 14
                                Alignment = taRightJustify
                                AutoSize = False
                                Caption = '000'
                                Font.Charset = ANSI_CHARSET
                                Font.Color = clAqua
                                Font.Height = -11
                                Font.Name = 'Courier New'
                                Font.Style = []
                                ParentFont = False
                              end
                              object ScrollbarSamplesFineTune: TSGTK0Scrollbar
                                Left = 63
                                Top = 6
                                Width = 134
                                Height = 17
                                Max = 255
                                Kind = sbHorizontal
                                OnScroll = ScrollbarSamplesFineTuneScroll
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
                            end
                            object SGTK0Panel51: TSGTK0Panel
                              Left = 472
                              Top = 4
                              Width = 111
                              Height = 27
                              TabOrder = 4
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object CheckBoxSamplesRandomStartPosition: TSGTK0CheckBox
                                Left = 6
                                Top = 6
                                Width = 101
                                Height = 17
                                Caption = 'Random startpos'
                                ParentColor = False
                                TabOrder = 0
                                TabStop = True
                                OnClick = CheckBoxSamplesRandomStartPositionClick
                              end
                            end
                          end
                          object TabSheetSampleLoop: TSGTK0TabSheet
                            Caption = 'Loop'
                            ExplicitLeft = 0
                            ExplicitTop = 0
                            ExplicitWidth = 0
                            ExplicitHeight = 0
                            object Label34: TLabel
                              Left = 28
                              Top = 8
                              Width = 27
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Mode'
                            end
                            object Label36: TLabel
                              Left = 225
                              Top = 10
                              Width = 49
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Loop Start'
                            end
                            object Label37: TLabel
                              Left = 444
                              Top = 10
                              Width = 46
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Loop End'
                            end
                            object ComboBoxSamplesLoopMode: TSGTK0ComboBox
                              Left = 60
                              Top = 6
                              Width = 115
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Off'
                                'Forwards'
                                'Pingpong'
                                'Backwards')
                              TabOrder = 0
                              Text = 'Off'
                              ItemIndex = 0
                              OnChange = ComboBoxSamplesLoopModeChange
                            end
                            object EditSamplesLoopStart: TSGTK0Edit
                              Left = 278
                              Top = 8
                              Width = 115
                              Height = 19
                              ColorFocused = 3158016
                              TabOrder = 1
                              Text = '0'
                              OnChange = EditSamplesLoopStartChange
                            end
                            object EditSamplesLoopEnd: TSGTK0Edit
                              Left = 494
                              Top = 8
                              Width = 115
                              Height = 19
                              ColorFocused = 3158016
                              TabOrder = 2
                              Text = '0'
                              OnChange = EditSamplesLoopEndChange
                            end
                          end
                          object TabSheetSampleSustainLoop: TSGTK0TabSheet
                            Caption = 'Sustain loop'
                            ExplicitLeft = 0
                            ExplicitTop = 0
                            ExplicitWidth = 0
                            ExplicitHeight = 0
                            object Label38: TLabel
                              Left = 28
                              Top = 8
                              Width = 27
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Mode'
                            end
                            object Label39: TLabel
                              Left = 225
                              Top = 10
                              Width = 49
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Loop Start'
                            end
                            object Label40: TLabel
                              Left = 444
                              Top = 10
                              Width = 46
                              Height = 13
                              Alignment = taRightJustify
                              Caption = 'Loop End'
                            end
                            object ComboBoxSamplesSustainLoopMode: TSGTK0ComboBox
                              Left = 60
                              Top = 6
                              Width = 115
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Off'
                                'Forwards'
                                'Pingpong'
                                'Backwards')
                              TabOrder = 0
                              Text = 'Off'
                              ItemIndex = 0
                              OnChange = ComboBoxSamplesSustainLoopModeChange
                            end
                            object EditSamplesSustainLoopStart: TSGTK0Edit
                              Left = 278
                              Top = 8
                              Width = 115
                              Height = 19
                              ColorFocused = 3158016
                              TabOrder = 1
                              Text = '0'
                              OnChange = EditSamplesSustainLoopStartChange
                            end
                            object EditSamplesSustainLoopEnd: TSGTK0Edit
                              Left = 494
                              Top = 8
                              Width = 115
                              Height = 19
                              ColorFocused = 3158016
                              TabOrder = 2
                              Text = '0'
                              OnChange = EditSamplesSustainLoopEndChange
                            end
                          end
                          object TabSheetSamplePadSynth: TSGTK0TabSheet
                            Caption = 'PadSynth'
                            ExplicitLeft = 0
                            ExplicitTop = 0
                            ExplicitWidth = 0
                            ExplicitHeight = 0
                            object SGTK0Panel52: TSGTK0Panel
                              Left = 4
                              Top = 4
                              Width = 159
                              Height = 27
                              TabOrder = 0
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object CheckBoxSamplesPadSynthActive: TSGTK0CheckBox
                                Left = 4
                                Top = 4
                                Width = 49
                                Height = 15
                                Caption = 'Active'
                                ParentColor = False
                                TabOrder = 0
                                TabStop = True
                                OnClick = CheckBoxSamplesPadSynthActiveClick
                              end
                              object SGTK0Panel107: TSGTK0Panel
                                Left = 82
                                Top = 2
                                Width = 1
                                Height = 41
                                TabOrder = 1
                                UseDockManager = True
                                BevelOuter = bvLowered
                              end
                              object CheckBoxSamplesPadSynthExtended: TSGTK0CheckBox
                                Left = 88
                                Top = 4
                                Width = 65
                                Height = 17
                                Caption = 'Extended'
                                ParentColor = False
                                TabOrder = 2
                                TabStop = True
                                OnClick = CheckBoxSamplesPadSynthExtendedClick
                              end
                            end
                            object SGTK0Panel54: TSGTK0Panel
                              Left = 4
                              Top = 34
                              Width = 159
                              Height = 27
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label43: TLabel
                                Left = 4
                                Top = 6
                                Width = 73
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Wavetable size'
                              end
                              object EditSamplesPadSynthWaveTableSize: TSGTK0Edit
                                Left = 82
                                Top = 4
                                Width = 73
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '262144'
                                OnChange = EditSamplesPadSynthWaveTableSizeChange
                                OnExit = EditSamplesPadSynthWaveTableSizeExit
                              end
                            end
                            object SGTK0Panel55: TSGTK0Panel
                              Left = 166
                              Top = 34
                              Width = 159
                              Height = 27
                              TabOrder = 2
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label44: TLabel
                                Left = 21
                                Top = 6
                                Width = 56
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Sample rate'
                              end
                              object EditSamplesPadSynthSampleRate: TSGTK0Edit
                                Left = 82
                                Top = 4
                                Width = 73
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '44100'
                                OnChange = EditSamplesPadSynthSampleRateChange
                              end
                            end
                            object SGTK0Panel56: TSGTK0Panel
                              Left = 328
                              Top = 34
                              Width = 159
                              Height = 27
                              TabOrder = 3
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label45: TLabel
                                Left = 27
                                Top = 6
                                Width = 50
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Frequency'
                              end
                              object EditSamplesPadSynthFrequency: TSGTK0Edit
                                Left = 82
                                Top = 4
                                Width = 73
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '440'
                                OnChange = EditSamplesPadSynthFrequencyChange
                              end
                            end
                            object SGTK0Panel57: TSGTK0Panel
                              Left = 166
                              Top = 4
                              Width = 159
                              Height = 27
                              TabOrder = 4
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label46: TLabel
                                Left = 27
                                Top = 6
                                Width = 50
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Bandwidth'
                              end
                              object EditSamplesPadSynthBandwidth: TSGTK0Edit
                                Left = 82
                                Top = 4
                                Width = 73
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '20'
                                OnChange = EditSamplesPadSynthBandwidthChange
                              end
                            end
                            object SGTK0Panel58: TSGTK0Panel
                              Left = 328
                              Top = 4
                              Width = 159
                              Height = 27
                              TabOrder = 5
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label47: TLabel
                                Left = 2
                                Top = 6
                                Width = 78
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Bandwidth scale'
                                Font.Charset = DEFAULT_CHARSET
                                Font.Color = clAqua
                                Font.Height = -9
                                Font.Name = 'MS Sans Serif'
                                Font.Style = []
                                ParentFont = False
                              end
                              object EditSamplesPadSynthBandwidthScale: TSGTK0Edit
                                Left = 82
                                Top = 4
                                Width = 73
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '0.5'
                                OnChange = EditSamplesPadSynthBandwidthScaleChange
                              end
                            end
                            object SGTK0Panel59: TSGTK0Panel
                              Left = 490
                              Top = 4
                              Width = 159
                              Height = 27
                              TabOrder = 6
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label48: TLabel
                                Left = 17
                                Top = 6
                                Width = 60
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Harmonics #'
                              end
                              object EditSamplesPadSynthNumberOfHarmonics: TSGTK0Edit
                                Left = 82
                                Top = 4
                                Width = 73
                                Height = 19
                                ColorFocused = 3158016
                                TabOrder = 0
                                Text = '8'
                                OnChange = EditSamplesPadSynthNumberOfHarmonicsChange
                              end
                            end
                            object SGTK0Panel60: TSGTK0Panel
                              Left = 490
                              Top = 34
                              Width = 159
                              Height = 27
                              TabOrder = 7
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label49: TLabel
                                Left = 48
                                Top = 6
                                Width = 29
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Profile'
                              end
                              object ComboBoxSamplesPadSynthProfile: TSGTK0ComboBox
                                Left = 82
                                Top = 2
                                Width = 75
                                Height = 21
                                Style = csDropDownList
                                Items.Strings = (
                                  'Gauss'
                                  'Single'
                                  'Detune'
                                  'Spread')
                                TabOrder = 0
                                Text = 'Gauss'
                                ItemIndex = 0
                                OnChange = ComboBoxSamplesPadSynthProfileChange
                              end
                            end
                            object ButtonSamplesPadSynthGenIt1: TSGTK0Button
                              Left = 652
                              Top = 4
                              Width = 43
                              Height = 57
                              Caption = 'GEN IT'
                              ParentColor = False
                              TabOrder = 8
                              OnClick = ButtonSamplesPadSynthGenIt1Click
                            end
                          end
                          object TabSheetSamplePadSynthHarmonics: TSGTK0TabSheet
                            Caption = 'PadSynth Harmonics'
                            ExplicitLeft = 0
                            ExplicitTop = 0
                            ExplicitWidth = 0
                            ExplicitHeight = 0
                            object SGTK0Panel188: TSGTK0Panel
                              Left = 4
                              Top = 4
                              Width = 232
                              Height = 27
                              TabOrder = 0
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label129: TLabel
                                Left = 3
                                Top = 6
                                Width = 57
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Curve mode'
                              end
                              object ComboBoxSamplesPadSynthCurveMode: TSGTK0ComboBox
                                Left = 64
                                Top = 2
                                Width = 163
                                Height = 21
                                Style = csDropDownList
                                Items.Strings = (
                                  '1-(x/count)'
                                  '1/sqrt(x+1)'
                                  '1/(x+1)'
                                  '1-(x/(count-1))'
                                  '1/sqrt(x)'
                                  '1/x')
                                TabOrder = 0
                                ItemIndex = -1
                                OnChange = ComboBoxSamplesPadSynthCurveModeChange
                              end
                            end
                            object SGTK0Panel189: TSGTK0Panel
                              Left = 4
                              Top = 33
                              Width = 232
                              Height = 28
                              TabOrder = 1
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label131: TLabel
                                Left = 10
                                Top = 8
                                Width = 50
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Steepness'
                              end
                              object LabelSamplesPadSynthCurveSteepness: TLabel
                                Left = 202
                                Top = 7
                                Width = 23
                                Height = 14
                                Alignment = taRightJustify
                                AutoSize = False
                                Caption = '000'
                                Font.Charset = ANSI_CHARSET
                                Font.Color = clAqua
                                Font.Height = -11
                                Font.Name = 'Courier New'
                                Font.Style = []
                                ParentFont = False
                              end
                              object ScrollbarSamplesPadSynthCurveSteepness: TSGTK0Scrollbar
                                Left = 63
                                Top = 6
                                Width = 134
                                Height = 17
                                Max = 255
                                Kind = sbHorizontal
                                OnScroll = ScrollbarSamplesPadSynthCurveSteepnessScroll
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
                            end
                            object SGTK0Panel190: TSGTK0Panel
                              Left = 238
                              Top = 33
                              Width = 232
                              Height = 28
                              TabOrder = 2
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object Label134: TLabel
                                Left = 21
                                Top = 8
                                Width = 39
                                Height = 13
                                Alignment = taRightJustify
                                Caption = 'Balance'
                              end
                              object LabelSamplesPadSynthBalance: TLabel
                                Left = 202
                                Top = 7
                                Width = 23
                                Height = 14
                                Alignment = taRightJustify
                                AutoSize = False
                                Caption = '000'
                                Font.Charset = ANSI_CHARSET
                                Font.Color = clAqua
                                Font.Height = -11
                                Font.Name = 'Courier New'
                                Font.Style = []
                                ParentFont = False
                              end
                              object ScrollbarSamplesPadSynthBalance: TSGTK0Scrollbar
                                Left = 63
                                Top = 6
                                Width = 134
                                Height = 17
                                Min = -64
                                Max = 64
                                Kind = sbHorizontal
                                OnScroll = ScrollbarSamplesPadSynthBalanceScroll
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
                            end
                            object SGTK0Panel191: TSGTK0Panel
                              Left = 238
                              Top = 4
                              Width = 232
                              Height = 27
                              TabOrder = 3
                              UseDockManager = True
                              BevelOuter = bvLowered
                              object CheckBoxSamplesPadSynthExtendedBalance: TSGTK0CheckBox
                                Left = 5
                                Top = 5
                                Width = 107
                                Height = 15
                                Caption = 'Extended balance'
                                ParentColor = False
                                TabOrder = 0
                                TabStop = True
                                OnClick = CheckBoxSamplesPadSynthExtendedBalanceClick
                              end
                              object SGTK0Panel192: TSGTK0Panel
                                Left = 115
                                Top = 1
                                Width = 1
                                Height = 26
                                Caption = 'SGTK0Panel22'
                                TabOrder = 1
                                UseDockManager = True
                                BevelOuter = bvLowered
                              end
                              object CheckBoxSamplesPadSynthStereo: TSGTK0CheckBox
                                Left = 123
                                Top = 5
                                Width = 96
                                Height = 17
                                Caption = 'Stereo'
                                Checked = True
                                ParentColor = False
                                TabOrder = 2
                                TabStop = True
                                OnClick = CheckBoxSamplesPadSynthStereoClick
                              end
                            end
                            object SGTK0Button1: TSGTK0Button
                              Left = 652
                              Top = 4
                              Width = 43
                              Height = 57
                              Caption = 'GEN IT'
                              ParentColor = False
                              TabOrder = 4
                              OnClick = ButtonSamplesPadSynthGenIt1Click
                            end
                          end
                          object TabSheetSampleScript: TSGTK0TabSheet
                            Caption = 'Script'
                            OnHide = TabSheetSampleScriptHide
                            OnShow = TabSheetSampleScriptShow
                            ExplicitLeft = 0
                            ExplicitTop = 0
                            ExplicitWidth = 0
                            ExplicitHeight = 0
                            object SGTK0ButtonInstrumentSampleScriptGenerate: TSGTK0Button
                              Left = 614
                              Top = 42
                              Width = 81
                              Height = 19
                              Caption = 'GEN IT'
                              ParentColor = False
                              TabOrder = 0
                              OnClick = SGTK0ButtonInstrumentSampleScriptGenerateClick
                            end
                            object SGTK0ComboBoxInstrumentSampleScriptLanguage: TSGTK0ComboBox
                              Left = 614
                              Top = 4
                              Width = 81
                              Height = 21
                              Style = csDropDownList
                              Items.Strings = (
                                'Pascal')
                              TabOrder = 1
                              Text = 'Pascal'
                              ItemIndex = 0
                              OnChange = SGTK0ComboBoxInstrumentSampleScriptLanguageChange
                            end
                            object SGTK0ButtonInstrumentSampleGetExample: TSGTK0Button
                              Left = 614
                              Top = 24
                              Width = 81
                              Height = 19
                              Caption = 'GET EXAMPLE'
                              ParentColor = False
                              TabOrder = 2
                              OnClick = SGTK0ButtonInstrumentSampleGetExampleClick
                            end
                          end
                        end
                      end
                    end
                  end
                end
                object TabSheetInstrumentSpeech: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Speech'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object SGTK0Panel96: TSGTK0Panel
                    Left = 0
                    Top = 0
                    Width = 728
                    Height = 337
                    ParentColor = True
                    Align = alClient
                    TabOrder = 0
                    UseDockManager = True
                    BevelOuter = bvLowered
                    BorderWidth = 3
                    object SGTK0Panel97: TSGTK0Panel
                      Left = 4
                      Top = 4
                      Width = 720
                      Height = 39
                      ParentColor = True
                      Align = alTop
                      TabOrder = 0
                      UseDockManager = True
                      BevelOuter = bvLowered
                      object ComboBoxSpeechTexts: TSGTK0ComboBox
                        Left = 8
                        Top = 8
                        Width = 128
                        Height = 22
                        Style = csDropDownList
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 0
                        ItemIndex = -1
                        OnChange = ComboBoxSpeechTextsChange
                      end
                      object EditSpeechTextName: TSGTK0Edit
                        Left = 143
                        Top = 8
                        Width = 128
                        Height = 22
                        ColorFocused = 3158016
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clAqua
                        Font.Height = -11
                        Font.Name = 'Courier New'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 1
                        OnChange = EditSpeechTextNameChange
                      end
                      object SGTK0Panel99: TSGTK0Panel
                        Left = 278
                        Top = 8
                        Width = 1
                        Height = 21
                        ParentColor = True
                        TabOrder = 2
                        UseDockManager = True
                        BevelOuter = bvLowered
                      end
                    end
                    object SGTK0Panel100: TSGTK0Panel
                      Left = 4
                      Top = 43
                      Width = 720
                      Height = 5
                      ParentColor = True
                      Align = alTop
                      TabOrder = 1
                      UseDockManager = True
                      BevelOuter = bvNone
                    end
                    object SGTK0Panel101: TSGTK0Panel
                      Left = 4
                      Top = 48
                      Width = 720
                      Height = 125
                      ParentColor = True
                      Align = alTop
                      TabOrder = 2
                      UseDockManager = True
                      BevelOuter = bvLowered
                      BorderWidth = 5
                      object SGTK0Panel102: TSGTK0Panel
                        Left = 6
                        Top = 6
                        Width = 708
                        Height = 113
                        ParentColor = True
                        Align = alClient
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvNone
                        object MemoSpeechText: TSGTK0Memo
                          Left = 0
                          Top = 0
                          Width = 708
                          Height = 31
                          Align = alClient
                          TabOrder = 0
                          OnChange = MemoSpeechTextChange
                        end
                        object MemoSpeechTextPhonems: TSGTK0Memo
                          Left = 0
                          Top = 36
                          Width = 708
                          Height = 36
                          ColorFocused = 2105344
                          ColorBack = 2105344
                          Align = alBottom
                          ReadOnly = True
                          TabOrder = 1
                        end
                        object SGTK0Panel76: TSGTK0Panel
                          Left = 0
                          Top = 31
                          Width = 708
                          Height = 5
                          Align = alBottom
                          TabOrder = 2
                          UseDockManager = True
                          BevelOuter = bvNone
                        end
                        object GroupBoxTextToPhonemConverter: TSGTK0Panel
                          Left = 0
                          Top = 77
                          Width = 708
                          Height = 36
                          Align = alBottom
                          TabOrder = 3
                          UseDockManager = True
                          BevelOuter = bvLowered
                          object LabelAlvey: TLabel
                            Left = 673
                            Top = 11
                            Width = 26
                            Height = 13
                            Alignment = taRightJustify
                            BiDiMode = bdRightToLeftNoAlign
                            Caption = 'Alvey'
                            ParentBiDiMode = False
                          end
                          object Label21: TLabel
                            Left = 8
                            Top = 11
                            Width = 46
                            Height = 13
                            Caption = 'Converter'
                          end
                          object EditSpeechTextInput: TSGTK0Edit
                            Left = 164
                            Top = 8
                            Width = 256
                            Height = 21
                            ColorFocused = 3158016
                            TabOrder = 0
                            OnChange = EditSpeechTextInputChange
                          end
                          object EditSpeechPhonemOutput: TSGTK0Edit
                            Left = 478
                            Top = 8
                            Width = 189
                            Height = 21
                            ColorFocused = 3158016
                            ReadOnly = True
                            TabOrder = 1
                          end
                          object ComboBoxConverterSource: TSGTK0ComboBox
                            Left = 60
                            Top = 8
                            Width = 103
                            Height = 21
                            Style = csDropDownList
                            Items.Strings = (
                              'Text'
                              'Alvey'
                              'ARPABET'
                              'DECTALK'
                              'Edin.'
                              'MACTALK'
                              'MRPA'
                              'SAMPA'
                              'Viruz II')
                            TabOrder = 2
                            Text = 'Text'
                            ItemIndex = 0
                            OnChange = ComboBoxConverterSourceChange
                          end
                          object SGTK0Panel78: TSGTK0Panel
                            Left = 429
                            Top = 8
                            Width = 1
                            Height = 21
                            ParentColor = True
                            TabOrder = 3
                            UseDockManager = True
                            BevelOuter = bvLowered
                          end
                          object ComboBoxSpeechConvertLanguage: TSGTK0ComboBox
                            Left = 438
                            Top = 8
                            Width = 39
                            Height = 21
                            Items.Strings = (
                              'UK'
                              'US')
                            TabOrder = 4
                            Text = 'UK'
                            ItemIndex = 0
                            OnChange = ComboBoxSpeechConvertLanguageChange
                          end
                        end
                        object SGTK0Panel77: TSGTK0Panel
                          Left = 0
                          Top = 72
                          Width = 708
                          Height = 5
                          Align = alBottom
                          TabOrder = 4
                          UseDockManager = True
                          BevelOuter = bvNone
                        end
                      end
                    end
                    object SGTK0Panel103: TSGTK0Panel
                      Left = 4
                      Top = 173
                      Width = 720
                      Height = 5
                      ParentColor = True
                      Align = alTop
                      TabOrder = 3
                      UseDockManager = True
                      BevelOuter = bvNone
                    end
                    object SGTK0Panel104: TSGTK0Panel
                      Left = 4
                      Top = 178
                      Width = 720
                      Height = 155
                      ParentColor = True
                      Align = alClient
                      TabOrder = 4
                      UseDockManager = True
                      BevelOuter = bvLowered
                      BorderWidth = 5
                      object SGTK0Panel105: TSGTK0Panel
                        Left = 6
                        Top = 6
                        Width = 708
                        Height = 143
                        ParentColor = True
                        Align = alClient
                        TabOrder = 0
                        UseDockManager = True
                        BevelOuter = bvLowered
                        BorderWidth = 5
                        object Label23: TLabel
                          Left = 8
                          Top = 8
                          Width = 40
                          Height = 16
                          Caption = 'HELP'
                          Font.Charset = DEFAULT_CHARSET
                          Font.Color = clAqua
                          Font.Height = -13
                          Font.Name = 'MS Sans Serif'
                          Font.Style = [fsBold, fsUnderline]
                          ParentFont = False
                        end
                        object MemoSpeechHelp: TSGTK0Memo
                          Left = 8
                          Top = 29
                          Width = 693
                          Height = 106
                          ColorFocused = 2105344
                          ColorBack = 2105344
                          Font.Charset = ANSI_CHARSET
                          Font.Color = clAqua
                          Font.Height = -11
                          Font.Name = 'Courier New'
                          Font.Style = []
                          ParentFont = False
                          TabOrder = 0
                          Lines.Strings = (
                            '[x] = Alvey'
                            
                              '{l:x} or {lang:x} = Select language, where x can be: EN/UK/ENUK=' +
                              'UK-Eng, US/ENUS=US-Eng, '
                            'DE/DEUK=German '
                            'with uk dialekt, DEUS=German with us dialekt'
                            '#x = Additional Frame length'
                            '_ = Wait for note off'
                            '! = Wait for note on'
                            ' ')
                        end
                      end
                    end
                  end
                end
                object TabSheetInstrumentLink: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Link'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object SGTK0Panel198: TSGTK0Panel
                    Left = 0
                    Top = 0
                    Width = 237
                    Height = 30
                    TabOrder = 0
                    UseDockManager = True
                    BevelOuter = bvLowered
                    object CheckBoxInstrumentLinkActive: TSGTK0CheckBox
                      Left = 8
                      Top = 6
                      Width = 82
                      Height = 17
                      Caption = 'Active'
                      ParentColor = False
                      TabOrder = 0
                      TabStop = True
                      OnClick = CheckBoxInstrumentLinkActiveClick
                    end
                    object SGTK0Panel199: TSGTK0Panel
                      Left = 118
                      Top = 2
                      Width = 1
                      Height = 26
                      Caption = 'SGTK0Panel22'
                      TabOrder = 1
                      UseDockManager = True
                      BevelOuter = bvLowered
                    end
                  end
                  object SGTK0Panel200: TSGTK0Panel
                    Left = 241
                    Top = 0
                    Width = 232
                    Height = 30
                    TabOrder = 1
                    UseDockManager = True
                    BevelOuter = bvLowered
                    object Label135: TLabel
                      Left = 9
                      Top = 8
                      Width = 49
                      Height = 13
                      Alignment = taRightJustify
                      Caption = 'Channel #'
                    end
                    object LabelInstrumentLinkChannel: TLabel
                      Left = 202
                      Top = 7
                      Width = 23
                      Height = 14
                      Alignment = taRightJustify
                      AutoSize = False
                      Caption = '000'
                      Font.Charset = ANSI_CHARSET
                      Font.Color = clAqua
                      Font.Height = -11
                      Font.Name = 'Courier New'
                      Font.Style = []
                      ParentFont = False
                    end
                    object ScrollbarInstrumentLinkChannel: TSGTK0Scrollbar
                      Left = 63
                      Top = 6
                      Width = 134
                      Height = 17
                      Min = -1
                      Max = 15
                      Kind = sbHorizontal
                      OnScroll = ScrollbarInstrumentLinkChannelScroll
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
                  end
                  object SGTK0Panel201: TSGTK0Panel
                    Left = 477
                    Top = 0
                    Width = 232
                    Height = 30
                    TabOrder = 2
                    UseDockManager = True
                    BevelOuter = bvLowered
                    object Label137: TLabel
                      Left = 9
                      Top = 8
                      Width = 49
                      Height = 13
                      Alignment = taRightJustify
                      Caption = 'Program #'
                    end
                    object LabelInstrumentLinkProgram: TLabel
                      Left = 202
                      Top = 7
                      Width = 23
                      Height = 14
                      Alignment = taRightJustify
                      AutoSize = False
                      Caption = '000'
                      Font.Charset = ANSI_CHARSET
                      Font.Color = clAqua
                      Font.Height = -11
                      Font.Name = 'Courier New'
                      Font.Style = []
                      ParentFont = False
                    end
                    object ScrollbarInstrumentLinkProgram: TSGTK0Scrollbar
                      Left = 63
                      Top = 6
                      Width = 134
                      Height = 17
                      Min = -1
                      Max = 127
                      Kind = sbHorizontal
                      OnScroll = ScrollbarInstrumentLinkProgramScroll
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
                  end
                end
                object TabSheetInstrumentController: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Controller'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object SGTK0PanelInstrumentController: TSGTK0Panel
                    Left = 0
                    Top = 0
                    Width = 728
                    Height = 337
                    Align = alClient
                    TabOrder = 0
                    UseDockManager = True
                    BevelOuter = bvLowered
                    object Label140: TLabel
                      Left = 8
                      Top = 8
                      Width = 592
                      Height = 13
                      Caption = 
                        'Controller resolution flags (unchecked=7bit, checked=14bit) (for' +
                        ' standard controller behaviours, not for parameter automations)'
                    end
                  end
                end
                object TabSheetInstrumentTunings: TSGTK0TabSheet
                  BorderWidth = 5
                  Caption = 'Tunings'
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object CheckBoxInstrumentUseTuningTable: TSGTK0CheckBox
                    Left = 400
                    Top = 2
                    Width = 121
                    Height = 17
                    Caption = 'Use tuning table'
                    ParentColor = False
                    TabOrder = 0
                    TabStop = True
                    OnClick = CheckBoxInstrumentUseTuningTableClick
                  end
                  object SGTK0MemoTuningTable: TSGTK0Memo
                    Left = 2
                    Top = 2
                    Width = 391
                    Height = 335
                    ScrollBars = ssBoth
                    TabOrder = 1
                  end
                  object SGTK0ButtonImportScaleFile: TSGTK0Button
                    Left = 400
                    Top = 22
                    Width = 97
                    Height = 25
                    Caption = 'Import'
                    ParentColor = False
                    TabOrder = 2
                    OnClick = SGTK0ButtonImportScaleFileClick
                  end
                  object SGTK0ButtonInstrumentTuningParse: TSGTK0Button
                    Left = 400
                    Top = 50
                    Width = 97
                    Height = 25
                    Caption = 'Parse'
                    ParentColor = False
                    TabOrder = 3
                    OnClick = SGTK0ButtonInstrumentTuningParseClick
                  end
                  object SGTK0ButtonScaleExport: TSGTK0Button
                    Left = 500
                    Top = 22
                    Width = 97
                    Height = 25
                    Caption = 'Export'
                    ParentColor = False
                    TabOrder = 4
                    OnClick = SGTK0ButtonScaleExportClick
                  end
                end
              end
            end
          end
        end
        object Panel6: TSGTK0Panel
          Left = 749
          Top = 0
          Width = 246
          Height = 403
          Align = alRight
          TabOrder = 1
          UseDockManager = True
          BevelOuter = bvLowered
          BorderWidth = 3
          object Panel8: TSGTK0Panel
            Left = 4
            Top = 84
            Width = 238
            Height = 315
            ParentColor = True
            Align = alClient
            TabOrder = 0
            UseDockManager = True
            BevelOuter = bvLowered
            BorderWidth = 5
            object PanelModulationMatrixItems: TSGTK0Panel
              Left = 6
              Top = 6
              Width = 209
              Height = 303
              Align = alClient
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvNone
            end
            object ScrollbarModulationMatrixItems: TSGTK0Scrollbar
              Left = 215
              Top = 6
              Width = 17
              Height = 303
              Max = 1000
              OnScroll = ScrollbarModulationMatrixItemsScroll
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
              Align = alRight
              Color = 2105344
              ParentColor = False
            end
          end
          object Panel9: TSGTK0Panel
            Left = 4
            Top = 4
            Width = 238
            Height = 41
            Caption = 'Modulation Matrix'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clAqua
            Font.Height = -19
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Align = alTop
            TabOrder = 1
            UseDockManager = True
            OnClick = Panel9Click
            BevelOuter = bvLowered
            object SGTK0ButtonConvertOldToNewUnits: TSGTK0Button
              Left = 208
              Top = 8
              Width = 25
              Height = 25
              Caption = 'C'
              ParentColor = False
              TabOrder = 0
              Visible = False
              OnClick = SGTK0ButtonConvertOldToNewUnitsClick
            end
          end
          object Panel11: TSGTK0Panel
            Left = 4
            Top = 50
            Width = 238
            Height = 29
            Align = alTop
            TabOrder = 2
            UseDockManager = True
            OnClick = Panel11Click
            BevelOuter = bvLowered
            object Label5: TLabel
              Left = 124
              Top = 7
              Width = 109
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = '/255 Modulations used'
              Color = 2105344
              ParentColor = False
              OnClick = Label5Click
            end
            object LabelModulationMatrixCount: TLabel
              Left = 96
              Top = 7
              Width = 28
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = '000'
              OnClick = LabelModulationMatrixCountClick
            end
            object ButtonAddModulationMatrixItem: TSGTK0Button
              Left = 8
              Top = 6
              Width = 32
              Height = 17
              Caption = 'Add'
              Font.Charset = ANSI_CHARSET
              Font.Color = clAqua
              Font.Height = -11
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ParentColor = False
              TabOrder = 0
              OnClick = ButtonAddModulationMatrixItemClick
            end
          end
          object SGTK0Panel1: TSGTK0Panel
            Left = 4
            Top = 45
            Width = 238
            Height = 5
            Align = alTop
            TabOrder = 3
            UseDockManager = True
            BevelOuter = bvNone
          end
          object SGTK0Panel2: TSGTK0Panel
            Left = 4
            Top = 79
            Width = 238
            Height = 5
            Align = alTop
            TabOrder = 4
            UseDockManager = True
            BevelOuter = bvNone
          end
        end
        object SGTK0Panel3: TSGTK0Panel
          Left = 744
          Top = 0
          Width = 5
          Height = 403
          ParentColor = True
          Align = alRight
          TabOrder = 2
          UseDockManager = True
          BevelOuter = bvNone
        end
      end
      object TabSheetGlobals: TSGTK0TabSheet
        BorderWidth = 1
        Caption = 'Globals'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object PageControl1: TSGTK0PageControl
          Left = 0
          Top = 0
          Width = 995
          Height = 403
          Align = alClient
          Tabs.Strings = (
            'Reverb'
            'Delay'
            'Chorus/Flanger'
            'PitchShifter'
            'End Filter'
            'EQ'
            'Compressor'
            'Order'
            'Clock'
            'Voices'
            'Final Compressor'
            'Oversample'
            'Output'
            'Ramping')
          Color = 2105344
          ParentColor = False
          TabOrder = 0
          ActivePage = TabSheetGlobalsReverb
          object TabSheetGlobalsReverb: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Reverb'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelGlobalsReverbOptions: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsReverbActive: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Active'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsReverbActiveClick
              end
              object SGTK0Panel74: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object PanelGlobalsReverbPreDelay: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbPreDelay: TLabel
                Left = 15
                Top = 8
                Width = 43
                Height = 13
                Alignment = taRightJustify
                Caption = 'PreDelay'
              end
              object LabelGlobalsReverbPreDelay: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbPreDelay: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbPreDelayScroll
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
            end
            object PanelGlobalsReverbRoomSize: TSGTK0Panel
              Left = 241
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbRoomSize: TLabel
                Left = 6
                Top = 8
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Room Size'
              end
              object LabelGlobalsReverbRoomSize: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbRoomSize: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbRoomSizeScroll
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
            end
            object PanelGlobalsReverbCombFilterSeparation: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 3
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbCombFilterSeparation: TLabel
                Left = 6
                Top = 8
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = 'CombSepa'
              end
              object LabelGlobalsReverbCombFilterSeparation: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbCombFilterSeparation: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbCombFilterSeparationScroll
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
            end
            object PanelGlobalsReverbFeedBack: TSGTK0Panel
              Left = 0
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 4
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbFeedBack: TLabel
                Left = 9
                Top = 8
                Width = 49
                Height = 13
                Alignment = taRightJustify
                Caption = 'FeedBack'
              end
              object LabelGlobalsReverbFeedBack: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbFeedBack: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbFeedBackScroll
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
            end
            object PanelGlobalsReverbAbsortion: TSGTK0Panel
              Left = 241
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 5
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbAbsortion: TLabel
                Left = 14
                Top = 8
                Width = 44
                Height = 13
                Alignment = taRightJustify
                Caption = 'Absortion'
              end
              object LabelGlobalsReverbAbsortion: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbAbsortion: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbAbsortionScroll
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
            end
            object PanelGlobalsReverbDry: TSGTK0Panel
              Left = 0
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 6
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbDry: TLabel
                Left = 42
                Top = 8
                Width = 16
                Height = 13
                Alignment = taRightJustify
                Caption = 'Dry'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object LabelGlobalsReverbDry: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbDry: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbDryScroll
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
            end
            object PanelGlobalsReverbWet: TSGTK0Panel
              Left = 241
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 7
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbWet: TLabel
                Left = 38
                Top = 8
                Width = 20
                Height = 13
                Alignment = taRightJustify
                Caption = 'Wet'
              end
              object LabelGlobalsReverbWet: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbWet: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbWetScroll
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
            end
            object PanelGlobalsReverbNumberOfAllPassFilters: TSGTK0Panel
              Left = 0
              Top = 140
              Width = 237
              Height = 30
              TabOrder = 8
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsReverbNumberOfAllPassFilters: TLabel
                Left = 14
                Top = 7
                Width = 44
                Height = 13
                Alignment = taRightJustify
                Caption = 'AllPass #'
              end
              object LabelGlobalsReverbNumberOfAllPassFilters: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsReverbNumberOfAllPassFilters: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsReverbNumberOfAllPassFiltersScroll
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
            end
          end
          object TabSheetGlobalsDelay: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Delay'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelGlobalsDelayWet: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsDelayWet: TLabel
                Left = 38
                Top = 8
                Width = 20
                Height = 13
                Alignment = taRightJustify
                Caption = 'Wet'
              end
              object LabelGlobalsDelayWet: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsDelayWet: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsDelayWetScroll
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
            end
            object PanelGlobalsDelayDry: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsDelayDry: TLabel
                Left = 42
                Top = 8
                Width = 16
                Height = 13
                Alignment = taRightJustify
                Caption = 'Dry'
              end
              object LabelGlobalsDelayDry: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsDelayDry: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsDelayDryScroll
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
            end
            object PanelGlobalsDelayTimeRight: TSGTK0Panel
              Left = 241
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsDelayTimeRight: TLabel
                Left = 7
                Top = 8
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Time Right'
              end
              object LabelGlobalsDelayTimeRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsDelayTimeRight: TSGTK0Scrollbar
                Left = 63
                Top = 7
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsDelayTimeRightScroll
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
            end
            object PanelGlobalsDelayTimeLeft: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 3
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsDelayTimeLeft: TLabel
                Left = 14
                Top = 8
                Width = 44
                Height = 13
                Alignment = taRightJustify
                Caption = 'Time Left'
              end
              object LabelGlobalsDelayTimeLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsDelayTimeLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsDelayTimeLeftScroll
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
            end
            object PanelGlobalsDelayFeedBackLeft: TSGTK0Panel
              Left = 0
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 4
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsDelayFeedBackLeft: TLabel
                Left = 24
                Top = 8
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'FB Left'
              end
              object LabelGlobalsDelayFeedBackLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsDelayFeedBackLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -128
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsDelayFeedBackLeftScroll
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
            end
            object PanelGlobalsDelayOptions: TSGTK0Panel
              Left = 0
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 5
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsDelayActive: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Active'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsDelayActiveClick
              end
              object SGTK0Panel64: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object CheckBoxGlobalsDelayClockSync: TSGTK0CheckBox
                Left = 126
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Clock Sync'
                ParentColor = False
                TabOrder = 2
                TabStop = True
                OnClick = CheckBoxGlobalsDelayClockSyncClick
              end
            end
            object PanelGlobalsDelayFeedBackRight: TSGTK0Panel
              Left = 241
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 6
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsDelayFeedBackRight: TLabel
                Left = 17
                Top = 8
                Width = 41
                Height = 13
                Alignment = taRightJustify
                Caption = 'FB Right'
              end
              object LabelGlobalsDelayFeedBackRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsDelayFeedBackRight: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -128
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsDelayFeedBackRightScroll
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
            end
            object SGTK0Panel184: TSGTK0Panel
              Left = 241
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 7
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsDelayFine: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Fine'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsDelayFineClick
              end
              object SGTK0Panel185: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object CheckBoxGlobalsDelayRecursive: TSGTK0CheckBox
                Left = 126
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Recursive'
                ParentColor = False
                TabOrder = 2
                TabStop = True
                OnClick = CheckBoxGlobalsDelayRecursiveClick
              end
            end
          end
          object TabSheetGlobalsChorusFlanger: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Chorus/Flanger'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelGlobalsChorusFlangerWet: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerWet: TLabel
                Left = 38
                Top = 8
                Width = 20
                Height = 13
                Alignment = taRightJustify
                Caption = 'Wet'
              end
              object LabelGlobalsChorusFlangerWet: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerWet: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerWetScroll
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
            end
            object PanelGlobalsChorusFlangerDry: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerDry: TLabel
                Left = 42
                Top = 8
                Width = 16
                Height = 13
                Alignment = taRightJustify
                Caption = 'Dry'
              end
              object LabelGlobalsChorusFlangerDry: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerDry: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerDryScroll
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
            end
            object PanelGlobalsChorusFlangerTimeRight: TSGTK0Panel
              Left = 241
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerTimeRight: TLabel
                Left = 7
                Top = 8
                Width = 51
                Height = 13
                Alignment = taRightJustify
                Caption = 'Time Right'
              end
              object LabelGlobalsChorusFlangerTimeRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerTimeRight: TSGTK0Scrollbar
                Left = 63
                Top = 7
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerTimeRightScroll
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
            end
            object PanelGlobalsChorusFlangerFeedBackRight: TSGTK0Panel
              Left = 241
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 3
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerFeedBackRight: TLabel
                Left = 17
                Top = 8
                Width = 41
                Height = 13
                Alignment = taRightJustify
                Caption = 'FB Right'
              end
              object LabelGlobalsChorusFlangerFeedBackRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerFeedBackRight: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -128
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerFeedBackRightScroll
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
            end
            object PanelGlobalsChorusFlangerLFORateRight: TSGTK0Panel
              Left = 241
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 4
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerLFORateRight: TLabel
                Left = 1
                Top = 8
                Width = 57
                Height = 13
                Alignment = taRightJustify
                Caption = 'LFO Rate R'
              end
              object LabelGlobalsChorusFlangerLFORateRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerLFORateRight: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerLFORateRightScroll
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
            end
            object PanelGlobalsChorusFlangerLFODepthRight: TSGTK0Panel
              Left = 241
              Top = 140
              Width = 237
              Height = 30
              TabOrder = 5
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerLFODepthRight: TLabel
                Left = 1
                Top = 8
                Width = 57
                Height = 13
                Alignment = taRightJustify
                Caption = 'LFODepthR'
              end
              object LabelGlobalsChorusFlangerLFODepthRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerLFODepthRight: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerLFODepthRightScroll
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
            end
            object PanelGlobalsChorusFlangerLFOPhaseRight: TSGTK0Panel
              Left = 241
              Top = 174
              Width = 237
              Height = 30
              TabOrder = 6
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerLFOPhaseRight: TLabel
                Left = 1
                Top = 9
                Width = 58
                Height = 13
                Alignment = taRightJustify
                Caption = 'LFOPhaseR'
              end
              object LabelGlobalsChorusFlangerLFOPhaseRight: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerLFOPhaseRight: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerLFOPhaseRightScroll
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
            end
            object PanelGlobalsChorusFlangerOptions: TSGTK0Panel
              Left = 0
              Top = 208
              Width = 237
              Height = 30
              TabOrder = 7
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsChorusFlangerActive: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Active'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsChorusFlangerActiveClick
              end
              object SGTK0Panel68: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object CheckBoxGlobalsChorusFlangerCarry: TSGTK0CheckBox
                Left = 123
                Top = 7
                Width = 96
                Height = 17
                Caption = 'Carry'
                Checked = True
                ParentColor = False
                TabOrder = 2
                TabStop = True
                OnClick = CheckBoxGlobalsChorusFlangerCarryClick
              end
            end
            object PanelGlobalsChorusFlangerLFOPhaseLeft: TSGTK0Panel
              Left = 0
              Top = 174
              Width = 237
              Height = 30
              TabOrder = 8
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerLFOPhaseLeft: TLabel
                Left = 2
                Top = 8
                Width = 56
                Height = 13
                Alignment = taRightJustify
                Caption = 'LFOPhaseL'
              end
              object LabelGlobalsChorusFlangerLFOPhaseLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerLFOPhaseLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerLFOPhaseLeftScroll
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
            end
            object PanelGlobalsChorusFlangerLFODepthLeft: TSGTK0Panel
              Left = 0
              Top = 140
              Width = 237
              Height = 30
              TabOrder = 9
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerLFODepthLeft: TLabel
                Left = 3
                Top = 8
                Width = 55
                Height = 13
                Alignment = taRightJustify
                Caption = 'LFODepthL'
              end
              object LabelGlobalsChorusFlangerLFODepthLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerLFODepthLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerLFODepthLeftScroll
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
            end
            object PanelGlobalsChorusFlangerLFORateLeft: TSGTK0Panel
              Left = 0
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 10
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerLFORateLeft: TLabel
                Left = 3
                Top = 8
                Width = 55
                Height = 13
                Alignment = taRightJustify
                Caption = 'LFO Rate L'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object LabelGlobalsChorusFlangerLFORateLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerLFORateLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerLFORateLeftScroll
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
            end
            object PanelGlobalsChorusFlangerFeedBackLeft: TSGTK0Panel
              Left = 0
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 11
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerFeedBackLeft: TLabel
                Left = 24
                Top = 8
                Width = 34
                Height = 13
                Alignment = taRightJustify
                Caption = 'FB Left'
              end
              object LabelGlobalsChorusFlangerFeedBackLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerFeedBackLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -128
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerFeedBackLeftScroll
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
            end
            object PanelGlobalsChorusFlangerTimeLeft: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 12
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsChorusFlangerTimeLeft: TLabel
                Left = 14
                Top = 8
                Width = 44
                Height = 13
                Alignment = taRightJustify
                Caption = 'Time Left'
              end
              object LabelGlobalsChorusFlangerTimeLeft: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerTimeLeft: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerTimeLeftScroll
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
            end
            object SGTK0Panel178: TSGTK0Panel
              Left = 0
              Top = 242
              Width = 237
              Height = 30
              TabOrder = 13
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsChorusFlangerFine: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Fine'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsChorusFlangerFineClick
              end
              object SGTK0Panel179: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object SGTK0Panel181: TSGTK0Panel
              Left = 241
              Top = 208
              Width = 237
              Height = 30
              TabOrder = 14
              UseDockManager = True
              BevelOuter = bvLowered
              object Label118: TLabel
                Left = 31
                Top = 9
                Width = 28
                Height = 13
                Alignment = taRightJustify
                Caption = 'Count'
              end
              object LabelGlobalsChorusFlangerCount: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsChorusFlangerCount: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = 1
                Max = 32
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsChorusFlangerCountScroll
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
            end
          end
          object TabSheetGlobalsPitchShifter: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'PitchShifter'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel113: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object Label51: TLabel
                Left = 33
                Top = 8
                Width = 25
                Height = 13
                Alignment = taRightJustify
                Caption = 'Tune'
              end
              object LabelGlobalPitchShifterTune: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalPitchShifterTune: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -128
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalPitchShifterTuneScroll
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
            end
            object SGTK0Panel114: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalPitchShifterActive: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Active'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalPitchShifterActiveClick
              end
              object SGTK0Panel115: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object SGTK0Panel116: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object Label54: TLabel
                Left = 13
                Top = 8
                Width = 45
                Height = 13
                Alignment = taRightJustify
                Caption = 'FineTune'
              end
              object LabelGlobalPitchShifterFineTune: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Hint = 's'
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalPitchShifterFineTune: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -100
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalPitchShifterFineTuneScroll
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
            end
          end
          object TabSheetGlobalsEndFilter: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'End Filter'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelGlobalsEndFilterOptions: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsEndFilterActive: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Active'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsEndFilterActiveClick
              end
              object SGTK0Panel85: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object PanelGlobalsEndFilterLowCut: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsEndFilterCutOff: TLabel
                Left = 19
                Top = 8
                Width = 39
                Height = 13
                Alignment = taRightJustify
                Caption = 'Low Cut'
              end
              object LabelGlobalsEndFilterLowCut: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsEndFilterLowCut: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsEndFilterLowCutScroll
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
            end
            object PanelGlobalsEndFilterHighCut: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsEndFilterHighCut: TLabel
                Left = 17
                Top = 8
                Width = 41
                Height = 13
                Alignment = taRightJustify
                Caption = 'High Cut'
              end
              object LabelGlobalsEndFilterHighCut: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsEndFilterHighCut: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 127
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsEndFilterHighCutScroll
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
            end
          end
          object TabSheetGlobalsEQ: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'EQ'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel130: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalEQActive: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Active'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalEQActiveClick
              end
              object SGTK0Panel131: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object ComboBoxGlobalEQMode: TSGTK0ComboBox
                Left = 122
                Top = 4
                Width = 111
                Height = 21
                Style = csDropDownList
                Items.Strings = (
                  '-6 .. 6 dB'
                  '-12 .. 12 dB'
                  '-24 .. 24 dB')
                TabOrder = 2
                Text = '-6 .. 6 dB'
                ItemIndex = 0
                OnChange = ComboBoxGlobalEQModeChange
              end
            end
            object TSGTK0Panel
              Left = 0
              Top = 35
              Width = 479
              Height = 230
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object Label69: TLabel
                Left = 6
                Top = 60
                Width = 18
                Height = 13
                Alignment = taCenter
                AutoSize = False
                Caption = '24'
              end
              object Label70: TLabel
                Left = 6
                Top = 166
                Width = 18
                Height = 13
                Alignment = taCenter
                AutoSize = False
                Caption = '-24'
              end
              object Label71: TLabel
                Left = 6
                Top = 110
                Width = 18
                Height = 13
                Alignment = taCenter
                AutoSize = False
                Caption = '0'
              end
              object Label72: TLabel
                Left = 456
                Top = 166
                Width = 18
                Height = 13
                Alignment = taCenter
                AutoSize = False
                Caption = '-24'
              end
              object Label73: TLabel
                Left = 456
                Top = 110
                Width = 18
                Height = 13
                Alignment = taCenter
                AutoSize = False
                Caption = '0'
              end
              object Label74: TLabel
                Left = 456
                Top = 60
                Width = 18
                Height = 13
                Alignment = taCenter
                AutoSize = False
                Caption = '24'
              end
              object SGTK0Panel132: TSGTK0Panel
                Left = 26
                Top = 12
                Width = 427
                Height = 206
                TabOrder = 0
                UseDockManager = True
                BevelOuter = bvLowered
                object SGTK0Panel133: TSGTK0Panel
                  Left = 8
                  Top = 100
                  Width = 411
                  Height = 10
                  TabOrder = 30
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 3
                  object SGTK0Panel134: TSGTK0Panel
                    Left = 4
                    Top = 4
                    Width = 403
                    Height = 2
                    Align = alClient
                    TabOrder = 0
                    UseDockManager = True
                    BevelOuter = bvLowered
                  end
                end
                object EditGlobalEQBandHz1: TSGTK0Edit
                  Left = 4
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 0
                  Text = '31'
                  OnChange = EditGlobalEQBandHz1Change
                end
                object TSGTK0Panel
                  Left = 13
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 1
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain1: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain1Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain1: TSGTK0Panel
                  Left = 4
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0,00'
                  TabOrder = 2
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz2: TSGTK0Edit
                  Left = 46
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 3
                  Text = '62'
                  OnChange = EditGlobalEQBandHz2Change
                end
                object TSGTK0Panel
                  Left = 55
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 4
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain2: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain2Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain2: TSGTK0Panel
                  Left = 46
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0,00'
                  TabOrder = 5
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz3: TSGTK0Edit
                  Left = 88
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 6
                  Text = '125'
                  OnChange = EditGlobalEQBandHz3Change
                end
                object TSGTK0Panel
                  Left = 97
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 7
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain3: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain3Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain3: TSGTK0Panel
                  Left = 88
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 8
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz4: TSGTK0Edit
                  Left = 130
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 9
                  Text = '250'
                  OnChange = EditGlobalEQBandHz4Change
                end
                object TSGTK0Panel
                  Left = 139
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 10
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain4: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain4Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain4: TSGTK0Panel
                  Left = 130
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 11
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz5: TSGTK0Edit
                  Left = 172
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 12
                  Text = '500'
                  OnChange = EditGlobalEQBandHz5Change
                end
                object TSGTK0Panel
                  Left = 181
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 13
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain5: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain5Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain5: TSGTK0Panel
                  Left = 172
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 14
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz6: TSGTK0Edit
                  Left = 214
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 15
                  Text = '1000'
                  OnChange = EditGlobalEQBandHz6Change
                end
                object TSGTK0Panel
                  Left = 223
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 16
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain6: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain6Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain6: TSGTK0Panel
                  Left = 214
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 17
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz7: TSGTK0Edit
                  Left = 256
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 18
                  Text = '2000'
                  OnChange = EditGlobalEQBandHz7Change
                end
                object TSGTK0Panel
                  Left = 265
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 19
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain7: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain7Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain7: TSGTK0Panel
                  Left = 256
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0,00'
                  TabOrder = 20
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz8: TSGTK0Edit
                  Left = 298
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 21
                  Text = '4000'
                  OnChange = EditGlobalEQBandHz8Change
                end
                object TSGTK0Panel
                  Left = 307
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 22
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain8: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain8Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain8: TSGTK0Panel
                  Left = 298
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 23
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz9: TSGTK0Edit
                  Left = 340
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 24
                  Text = '8000'
                  OnChange = EditGlobalEQBandHz9Change
                end
                object TSGTK0Panel
                  Left = 349
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 25
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain9: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain9Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain9: TSGTK0Panel
                  Left = 340
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 26
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
                object EditGlobalEQBandHz10: TSGTK0Edit
                  Left = 382
                  Top = 182
                  Width = 40
                  Height = 19
                  ColorFocused = 3158016
                  TabOrder = 27
                  Text = '16000'
                  OnChange = EditGlobalEQBandHz10Change
                end
                object TSGTK0Panel
                  Left = 391
                  Top = 32
                  Width = 22
                  Height = 147
                  TabOrder = 28
                  UseDockManager = True
                  BevelOuter = bvLowered
                  BorderWidth = 2
                  object ScrollbarGlobalEQGain10: TSGTK0Scrollbar
                    Left = 3
                    Top = 3
                    Width = 16
                    Height = 141
                    Max = 240
                    Position = 120
                    OnScroll = ScrollbarGlobalEQGain10Scroll
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
                    Align = alClient
                    Color = 2105344
                    ParentColor = False
                  end
                end
                object PanelGlobalEQGain10: TSGTK0Panel
                  Left = 382
                  Top = 4
                  Width = 40
                  Height = 25
                  Caption = '0.00'
                  TabOrder = 29
                  UseDockManager = True
                  BevelOuter = bvLowered
                end
              end
              object SGTK0Panel135: TSGTK0Panel
                Left = 4
                Top = 16
                Width = 19
                Height = 25
                Caption = 'dB'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object SGTK0Panel136: TSGTK0Panel
                Left = 456
                Top = 16
                Width = 19
                Height = 25
                Caption = 'dB'
                TabOrder = 2
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object SGTK0Panel137: TSGTK0Panel
                Left = 4
                Top = 194
                Width = 19
                Height = 20
                Caption = 'Hz'
                TabOrder = 3
                UseDockManager = True
                BevelOuter = bvLowered
              end
              object SGTK0Panel138: TSGTK0Panel
                Left = 456
                Top = 194
                Width = 19
                Height = 20
                Caption = 'Hz'
                TabOrder = 4
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object ButtonGlobalEQReset: TSGTK0Button
              Left = 2
              Top = 272
              Width = 43
              Height = 27
              Caption = 'Reset'
              ParentColor = False
              TabOrder = 2
              OnClick = ButtonGlobalEQResetClick
            end
            object SGTK0Panel140: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 3
              UseDockManager = True
              BevelOuter = bvLowered
              object Label82: TLabel
                Left = 4
                Top = 8
                Width = 36
                Height = 13
                Alignment = taRightJustify
                Caption = 'Preamp'
              end
              object LabelGlobalEQPreAmp: TLabel
                Left = 168
                Top = 7
                Width = 63
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0,00 dB'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalEQPreAmp: TSGTK0Scrollbar
                Left = 45
                Top = 6
                Width = 120
                Height = 17
                Max = 240
                Position = 120
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalEQPreAmpScroll
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
            end
            object SGTK0Panel143: TSGTK0Panel
              Left = 94
              Top = 272
              Width = 105
              Height = 27
              TabOrder = 4
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalEQCascaded: TSGTK0CheckBox
                Left = 4
                Top = 5
                Width = 69
                Height = 17
                Caption = 'Cascaded'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalEQCascadedClick
              end
              object CheckBoxGlobalEQAddCascaded: TSGTK0CheckBox
                Left = 74
                Top = 5
                Width = 24
                Height = 17
                Caption = '+'
                ParentColor = False
                TabOrder = 1
                TabStop = True
                OnClick = CheckBoxGlobalEQAddCascadedClick
              end
            end
            object SGTK0Panel144: TSGTK0Panel
              Left = 202
              Top = 272
              Width = 141
              Height = 27
              TabOrder = 5
              UseDockManager = True
              BevelOuter = bvLowered
              object Label84: TLabel
                Left = 6
                Top = 7
                Width = 65
                Height = 13
                Caption = 'Octave factor'
              end
              object EditGlobalEQOctaveFactor: TSGTK0Edit
                Left = 76
                Top = 4
                Width = 61
                Height = 19
                ColorFocused = 3158016
                TabOrder = 0
                Text = '1.00'
                OnChange = EditGlobalEQOctaveFactorChange
              end
            end
            object ButtonGlobalEQLoadEQF: TSGTK0Button
              Left = 346
              Top = 272
              Width = 57
              Height = 27
              Caption = 'Load EQF'
              ParentColor = False
              TabOrder = 6
              OnClick = ButtonGlobalEQLoadEQFClick
            end
            object ButtonGlobalEQSaveEQF: TSGTK0Button
              Left = 406
              Top = 272
              Width = 57
              Height = 27
              Caption = 'Save EQF'
              ParentColor = False
              TabOrder = 7
              OnClick = ButtonGlobalEQSaveEQFClick
            end
            object ButtonGlobalEQResetISO: TSGTK0Button
              Left = 48
              Top = 272
              Width = 43
              Height = 27
              Caption = 'ISO'
              ParentColor = False
              TabOrder = 8
              OnClick = ButtonGlobalEQResetISOClick
            end
          end
          object TabSheetGlobalsCompressor: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Compressor'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelGlobalsCompressorMode: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorMode: TLabel
                Left = 31
                Top = 8
                Width = 27
                Height = 13
                Alignment = taRightJustify
                Caption = 'Mode'
              end
              object ComboBoxGlobalsCompressorMode: TSGTK0ComboBox
                Left = 63
                Top = 5
                Width = 170
                Height = 21
                Style = csDropDownList
                Items.Strings = (
                  'None'
                  'Mono Env Follow Peak'
                  'Mono Average Peak'
                  'Mono Minimum Peak'
                  'Mono Maximum Peak'
                  'Mono LowPass RMS'
                  'Mono Average RMS'
                  'Stereo Env Follow Peak'
                  'Stereo Average Peak'
                  'Stereo Minimum Peak'
                  'Stereo Maximum Peak'
                  'Stereo LowPass RMS'
                  'Stereo Average RMS')
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                ItemIndex = -1
                OnChange = ComboBoxGlobalsCompressorModeChange
              end
            end
            object PanelGlobalsCompressorThreshold: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorThreshold: TLabel
                Left = 11
                Top = 8
                Width = 47
                Height = 13
                Alignment = taRightJustify
                Caption = 'Threshold'
              end
              object LabelGlobalsCompressorThreshold: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorThreshold: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorThresholdScroll
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
            end
            object PanelGlobalsCompressorLookAhead: TSGTK0Panel
              Left = 241
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorWindow: TLabel
                Left = 19
                Top = 8
                Width = 39
                Height = 13
                Alignment = taRightJustify
                Caption = 'Window'
              end
              object LabelGlobalsCompressorWindow: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorWindow: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorWindowScroll
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
            end
            object PanelGlobalsCompressorOutGain: TSGTK0Panel
              Left = 241
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 3
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorOutGain: TLabel
                Left = 16
                Top = 8
                Width = 42
                Height = 13
                Alignment = taRightJustify
                Caption = 'Out Gain'
              end
              object LabelGlobalsCompressorOutGain: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorOutGain: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -999
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorOutGainScroll
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
            end
            object PanelGlobalsCompressorRelease: TSGTK0Panel
              Left = 241
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 4
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorRelease: TLabel
                Left = 19
                Top = 8
                Width = 39
                Height = 13
                Alignment = taRightJustify
                Caption = 'Release'
              end
              object LabelGlobalsCompressorRelease: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorRelease: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorReleaseScroll
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
            end
            object PanelGlobalsCompressorOptions: TSGTK0Panel
              Left = 0
              Top = 140
              Width = 237
              Height = 30
              TabOrder = 5
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsCompressorAutoGain: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Auto Gain'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsCompressorAutoGainClick
              end
              object SGTK0Panel70: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object PanelGlobalsCompressorAttack: TSGTK0Panel
              Left = 0
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 6
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorAttack: TLabel
                Left = 27
                Top = 8
                Width = 31
                Height = 13
                Alignment = taRightJustify
                Caption = 'Attack'
              end
              object LabelGlobalsCompressorAttack: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorAttack: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorAttackScroll
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
            end
            object PanelGlobalsCompressorSoftHardKnee: TSGTK0Panel
              Left = 0
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 7
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorSoftHardKnee: TLabel
                Left = 6
                Top = 8
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = 'SoHaKnee'
              end
              object LabelGlobalsCompressorSoftHardKnee: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorSoftHardKnee: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorSoftHardKneeScroll
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
            end
            object PanelGlobalsCompressorRatio: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 8
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsCompressorRatio: TLabel
                Left = 33
                Top = 8
                Width = 25
                Height = 13
                Alignment = taRightJustify
                Caption = 'Ratio'
              end
              object LabelGlobalsCompressorRatio: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsCompressorRatio: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsCompressorRatioScroll
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
            end
          end
          object TabSheetGlobalsOrder: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Order'
            object SGTK0ButtonGlobalOrderDown: TSGTK0Button
              Left = 210
              Top = 27
              Width = 77
              Height = 21
              Caption = 'Move to down'
              ParentColor = False
              TabOrder = 0
              OnClick = SGTK0ButtonGlobalOrderDownClick
            end
            object SGTK0ButtonGlobalOrderUp: TSGTK0Button
              Left = 210
              Top = 5
              Width = 77
              Height = 21
              Caption = 'Move to up'
              ParentColor = False
              TabOrder = 1
              OnClick = SGTK0ButtonGlobalOrderUpClick
            end
            object SGTK0ListBoxGlobalOrder: TSGTK0ListBox
              Left = 5
              Top = 5
              Width = 203
              Height = 80
              Items.Strings = (
                'PitchShifter'
                'End Filter'
                'EQ'
                'Compressor')
            end
          end
          object TabSheetGlobalsClock: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Clock'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel79: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object Label24: TLabel
                Left = 35
                Top = 8
                Width = 23
                Height = 13
                Alignment = taRightJustify
                Caption = 'BPM'
              end
              object LabelGlobalsClockBPM: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsClockBPM: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = 1
                Max = 255
                Position = 1
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsClockBPMScroll
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
            end
            object SGTK0Panel80: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object Label29: TLabel
                Left = 37
                Top = 8
                Width = 21
                Height = 13
                Alignment = taRightJustify
                Caption = 'TPB'
              end
              object LabelGlobalsClockTPB: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsClockTPB: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = 1
                Max = 255
                Position = 1
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsClockTPBScroll
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
            end
          end
          object TabSheetGlobalsVoices: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Voices'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel172: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object Label116: TLabel
                Left = 26
                Top = 8
                Width = 32
                Height = 13
                Alignment = taRightJustify
                Caption = 'Voices'
              end
              object LabelGlobalsVoicesCount: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object SGTK0ScrollbarGlobalsVoicesCount: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = 1
                Max = 96
                Position = 1
                Kind = sbHorizontal
                OnScroll = SGTK0ScrollbarGlobalsVoicesCountScroll
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
            end
          end
          object TabSheetGlobalsFinalCompressor: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Final Compressor'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelGlobalsFinalCompressorMode: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorMode: TLabel
                Left = 31
                Top = 8
                Width = 27
                Height = 13
                Alignment = taRightJustify
                Caption = 'Mode'
              end
              object ComboBoxGlobalsFinalCompressorMode: TSGTK0ComboBox
                Left = 63
                Top = 5
                Width = 170
                Height = 21
                Style = csDropDownList
                Items.Strings = (
                  'None'
                  'Mono Env Follow Peak'
                  'Mono Average Peak'
                  'Mono Minimum Peak'
                  'Mono Maximum Peak'
                  'Mono LowPass RMS'
                  'Mono Average RMS'
                  'Stereo Env Follow Peak'
                  'Stereo Average Peak'
                  'Stereo Minimum Peak'
                  'Stereo Maximum Peak'
                  'Stereo LowPass RMS'
                  'Stereo Average RMS')
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                ItemIndex = -1
                OnChange = ComboBoxGlobalsFinalCompressorModeChange
              end
            end
            object PanelGlobalsFinalCompressorThreshold: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorThreshold: TLabel
                Left = 11
                Top = 8
                Width = 47
                Height = 13
                Alignment = taRightJustify
                Caption = 'Threshold'
              end
              object LabelGlobalsFinalCompressorThreshold: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorThreshold: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorThresholdScroll
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
            end
            object PanelGlobalsFinalCompressorLookAhead: TSGTK0Panel
              Left = 241
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorWindow: TLabel
                Left = 19
                Top = 8
                Width = 39
                Height = 13
                Alignment = taRightJustify
                Caption = 'Window'
              end
              object LabelGlobalsFinalCompressorWindow: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorWindow: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorWindowScroll
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
            end
            object PanelGlobalsFinalCompressorOutGain: TSGTK0Panel
              Left = 241
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 3
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorOutGain: TLabel
                Left = 16
                Top = 8
                Width = 42
                Height = 13
                Alignment = taRightJustify
                Caption = 'Out Gain'
              end
              object LabelGlobalsFinalCompressorOutGain: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorOutGain: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = -999
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorOutGainScroll
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
            end
            object PanelGlobalsFinalCompressorRelease: TSGTK0Panel
              Left = 241
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 4
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorRelease: TLabel
                Left = 19
                Top = 8
                Width = 39
                Height = 13
                Alignment = taRightJustify
                Caption = 'Release'
              end
              object LabelGlobalsFinalCompressorRelease: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorRelease: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorReleaseScroll
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
            end
            object PanelGlobalsFinalCompressorOptions: TSGTK0Panel
              Left = 0
              Top = 140
              Width = 237
              Height = 30
              TabOrder = 5
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsFinalCompressorAutoGain: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Auto Gain'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsFinalCompressorAutoGainClick
              end
              object SGTK0Panel173: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object PanelGlobalsFinalCompressorAttack: TSGTK0Panel
              Left = 0
              Top = 105
              Width = 237
              Height = 30
              TabOrder = 6
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorAttack: TLabel
                Left = 27
                Top = 8
                Width = 31
                Height = 13
                Alignment = taRightJustify
                Caption = 'Attack'
              end
              object LabelGlobalsFinalCompressorAttack: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorAttack: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 999
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorAttackScroll
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
            end
            object PanelGlobalsFinalCompressorSoftHardKnee: TSGTK0Panel
              Left = 0
              Top = 70
              Width = 237
              Height = 30
              TabOrder = 7
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorSoftHardKnee: TLabel
                Left = 6
                Top = 8
                Width = 52
                Height = 13
                Alignment = taRightJustify
                Caption = 'SoHaKnee'
              end
              object LabelGlobalsFinalCompressorSoftHardKnee: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorSoftHardKnee: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorSoftHardKneeScroll
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
            end
            object PanelGlobalsFinalCompressorRatio: TSGTK0Panel
              Left = 0
              Top = 35
              Width = 237
              Height = 30
              TabOrder = 8
              UseDockManager = True
              BevelOuter = bvLowered
              object LabelNameGlobalsFinalCompressorRatio: TLabel
                Left = 33
                Top = 8
                Width = 25
                Height = 13
                Alignment = taRightJustify
                Caption = 'Ratio'
              end
              object LabelGlobalsFinalCompressorRatio: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsFinalCompressorRatio: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 255
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsFinalCompressorRatioScroll
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
            end
          end
          object TabSheetGlobalsOversample: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Oversample'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel169: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object Label117: TLabel
                Left = 28
                Top = 8
                Width = 30
                Height = 13
                Alignment = taRightJustify
                Caption = 'Factor'
              end
              object LabelOversample: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object SGTK0ScrollbarOversample: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Max = 4
                Position = 1
                Kind = sbHorizontal
                OnScroll = SGTK0ScrollbarOversampleScroll
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
            end
            object SGTK0Panel206: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 742
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object SGTK0CheckBoxFineOversample: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 441
                Height = 17
                Caption = 
                  'Fine (only for use with caution, because it needs a lot of more ' +
                  'memory and CPU time!)'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = SGTK0CheckBoxFineOversampleClick
              end
              object SGTK0CheckBoxFineSincOversample: TSGTK0CheckBox
                Left = 468
                Top = 6
                Width = 203
                Height = 17
                Caption = 'Use kaiser-windowed SINC resampling'
                ParentColor = False
                TabOrder = 1
                TabStop = True
                OnClick = SGTK0CheckBoxFineSincOversampleClick
              end
              object SGTK0Panel208: TSGTK0Panel
                Left = 461
                Top = 0
                Width = 1
                Height = 33
                Caption = 'SGTK0Panel22'
                TabOrder = 2
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
            object SGTK0Panel207: TSGTK0Panel
              Left = 0
              Top = 36
              Width = 237
              Height = 30
              TabOrder = 2
              UseDockManager = True
              BevelOuter = bvLowered
              object Label141: TLabel
                Left = 32
                Top = 8
                Width = 26
                Height = 13
                Alignment = taRightJustify
                Caption = 'Order'
              end
              object LabelOversampleOrder: TLabel
                Left = 208
                Top = 7
                Width = 23
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object SGTK0ScrollbarOversampleOrder: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 142
                Height = 17
                Min = 4
                Max = 64
                Position = 4
                Kind = sbHorizontal
                OnScroll = SGTK0ScrollbarOversampleOrderScroll
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
            end
          end
          object TabSheetGlobalsOutput: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Output'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel194: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object CheckBoxGlobalsClipping: TSGTK0CheckBox
                Left = 8
                Top = 6
                Width = 82
                Height = 17
                Caption = 'Clipping'
                ParentColor = False
                TabOrder = 0
                TabStop = True
                OnClick = CheckBoxGlobalsClippingClick
              end
              object SGTK0Panel196: TSGTK0Panel
                Left = 118
                Top = 2
                Width = 1
                Height = 26
                Caption = 'SGTK0Panel22'
                TabOrder = 1
                UseDockManager = True
                BevelOuter = bvLowered
              end
            end
          end
          object TabSheetGlobalsRamping: TSGTK0TabSheet
            BorderWidth = 5
            Caption = 'Ramping'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object SGTK0Panel202: TSGTK0Panel
              Left = 0
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 0
              UseDockManager = True
              BevelOuter = bvLowered
              object Label136: TLabel
                Left = 25
                Top = 8
                Width = 33
                Height = 13
                Alignment = taRightJustify
                Caption = 'Length'
              end
              object LabelGlobalsRampingLen: TLabel
                Left = 200
                Top = 7
                Width = 31
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = '0000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clAqua
                Font.Height = -11
                Font.Name = 'Courier New'
                Font.Style = []
                ParentFont = False
              end
              object ScrollbarGlobalsRampingLen: TSGTK0Scrollbar
                Left = 63
                Top = 6
                Width = 136
                Height = 17
                Min = 1
                Max = 1000
                Position = 28
                Kind = sbHorizontal
                OnScroll = ScrollbarGlobalsRampingLenScroll
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
            end
            object SGTK0Panel203: TSGTK0Panel
              Left = 241
              Top = 0
              Width = 237
              Height = 30
              TabOrder = 1
              UseDockManager = True
              BevelOuter = bvLowered
              object Label138: TLabel
                Left = 31
                Top = 8
                Width = 27
                Height = 13
                Alignment = taRightJustify
                Caption = 'Mode'
              end
              object ComboBoxGlobalsRampingMode: TSGTK0ComboBox
                Left = 63
                Top = 5
                Width = 170
                Height = 21
                Style = csDropDownList
                Items.Strings = (
                  'Linear'
                  'Exponential')
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                ItemIndex = -1
                OnChange = ComboBoxGlobalsRampingModeChange
              end
            end
          end
        end
      end
      object TabSheetExport: TSGTK0TabSheet
        BorderWidth = 1
        Caption = 'Export'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object SGTK0Panel145: TSGTK0Panel
          Left = 4
          Top = 4
          Width = 185
          Height = 169
          TabOrder = 0
          UseDockManager = True
          BevelOuter = bvLowered
          BorderWidth = 4
          object SGTK0Panel146: TSGTK0Panel
            Left = 5
            Top = 5
            Width = 175
            Height = 24
            Caption = 'MIDI source'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Align = alTop
            TabOrder = 0
            UseDockManager = True
            BevelOuter = bvLowered
          end
          object SGTK0Panel147: TSGTK0Panel
            Left = 5
            Top = 29
            Width = 175
            Height = 4
            Align = alTop
            TabOrder = 1
            UseDockManager = True
            BevelOuter = bvNone
          end
          object SGTK0Panel148: TSGTK0Panel
            Left = 5
            Top = 33
            Width = 175
            Height = 41
            Align = alTop
            TabOrder = 2
            UseDockManager = True
            BevelOuter = bvLowered
            object ButtonExportMIDILoad: TSGTK0Button
              Left = 4
              Top = 4
              Width = 83
              Height = 32
              Caption = 'Load MIDI file'
              ParentColor = False
              TabOrder = 0
              OnClick = ButtonExportMIDILoadClick
            end
            object ButtonExportClear: TSGTK0Button
              Left = 88
              Top = 4
              Width = 83
              Height = 32
              Caption = 'Clear'
              ParentColor = False
              TabOrder = 1
              OnClick = ButtonExportClearClick
            end
          end
          object SGTK0Panel149: TSGTK0Panel
            Left = 5
            Top = 119
            Width = 175
            Height = 4
            Align = alTop
            TabOrder = 3
            UseDockManager = True
            BevelOuter = bvNone
          end
          object SGTK0Panel150: TSGTK0Panel
            Left = 5
            Top = 78
            Width = 175
            Height = 41
            Align = alTop
            TabOrder = 4
            UseDockManager = True
            BevelOuter = bvLowered
            object ButtonExportMIDIRecordStop: TSGTK0Button
              Left = 4
              Top = 4
              Width = 167
              Height = 32
              Caption = 'Record'
              ParentColor = False
              TabOrder = 0
              OnClick = ButtonExportMIDIRecordStopClick
            end
          end
          object SGTK0Panel151: TSGTK0Panel
            Left = 5
            Top = 74
            Width = 175
            Height = 4
            Align = alTop
            TabOrder = 5
            UseDockManager = True
            BevelOuter = bvNone
          end
          object PanelExportMIDIEvents: TSGTK0Panel
            Left = 5
            Top = 123
            Width = 175
            Height = 40
            Caption = '0 events'
            Align = alTop
            TabOrder = 6
            UseDockManager = True
            BevelOuter = bvLowered
          end
        end
        object SGTK0Panel152: TSGTK0Panel
          Left = 194
          Top = 4
          Width = 185
          Height = 203
          TabOrder = 1
          UseDockManager = True
          BevelOuter = bvLowered
          BorderWidth = 4
          object SGTK0Panel153: TSGTK0Panel
            Left = 5
            Top = 5
            Width = 175
            Height = 24
            Caption = 'Output'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Align = alTop
            TabOrder = 0
            UseDockManager = True
            BevelOuter = bvLowered
          end
          object SGTK0Panel154: TSGTK0Panel
            Left = 5
            Top = 29
            Width = 175
            Height = 4
            Align = alTop
            TabOrder = 1
            UseDockManager = True
            BevelOuter = bvNone
          end
          object SGTK0Panel155: TSGTK0Panel
            Left = 5
            Top = 123
            Width = 175
            Height = 76
            Visible = False
            Align = alTop
            TabOrder = 2
            UseDockManager = True
            BevelOuter = bvLowered
            object ButtonExportExportPAS: TSGTK0Button
              Left = 4
              Top = 4
              Width = 83
              Height = 32
              Caption = 'Export PAS'
              ParentColor = False
              TabOrder = 0
              OnClick = ButtonExportExportPASClick
            end
            object ButtonExportExportH: TSGTK0Button
              Left = 4
              Top = 40
              Width = 83
              Height = 32
              Caption = 'Export H'
              ParentColor = False
              TabOrder = 1
              OnClick = ButtonExportExportHClick
            end
            object ButtonSaveBBFFile: TSGTK0Button
              Left = 88
              Top = 4
              Width = 83
              Height = 32
              Caption = 'Save BBF file'
              ParentColor = False
              TabOrder = 2
              OnClick = ButtonSaveBBFFileClick
            end
          end
          object SGTK0Panel156: TSGTK0Panel
            Left = 5
            Top = 33
            Width = 175
            Height = 41
            Align = alTop
            TabOrder = 3
            UseDockManager = True
            BevelOuter = bvLowered
            object ButtonExportSaveBMF: TSGTK0Button
              Left = 4
              Top = 4
              Width = 83
              Height = 32
              Caption = 'Save BMF file'
              ParentColor = False
              TabOrder = 0
              OnClick = ButtonExportSaveBMFClick
            end
            object ButtonExportExportEXE: TSGTK0Button
              Left = 88
              Top = 4
              Width = 83
              Height = 32
              Caption = 'Export EXE'
              ParentColor = False
              TabOrder = 1
              OnClick = ButtonExportExportEXEClick
            end
          end
          object SGTK0Panel157: TSGTK0Panel
            Left = 5
            Top = 74
            Width = 175
            Height = 4
            Align = alTop
            TabOrder = 4
            UseDockManager = True
            BevelOuter = bvNone
          end
          object SGTK0Panel158: TSGTK0Panel
            Left = 5
            Top = 119
            Width = 175
            Height = 4
            Align = alTop
            TabOrder = 5
            UseDockManager = True
            BevelOuter = bvNone
          end
          object SGTK0Panel159: TSGTK0Panel
            Left = 5
            Top = 78
            Width = 175
            Height = 41
            Visible = False
            Align = alTop
            TabOrder = 6
            UseDockManager = True
            BevelOuter = bvLowered
            object ButtonExportGenerateSynthconfigINC: TSGTK0Button
              Left = 4
              Top = 4
              Width = 167
              Height = 32
              Caption = 'Generate synthconfig.inc'
              ParentColor = False
              TabOrder = 0
              OnClick = ButtonExportGenerateSynthconfigINCClick
            end
          end
        end
        object SGTK0Panel160: TSGTK0Panel
          Left = 384
          Top = 4
          Width = 371
          Height = 169
          TabOrder = 2
          UseDockManager = True
          BevelOuter = bvLowered
          BorderWidth = 4
          object Label85: TLabel
            Left = 7
            Top = 36
            Width = 60
            Height = 13
            Caption = 'Track name:'
          end
          object Label86: TLabel
            Left = 205
            Top = 36
            Width = 34
            Height = 13
            Caption = 'Author:'
          end
          object Label87: TLabel
            Left = 6
            Top = 84
            Width = 52
            Height = 13
            Caption = 'Comments:'
          end
          object SGTK0Panel161: TSGTK0Panel
            Left = 5
            Top = 5
            Width = 361
            Height = 24
            Caption = 'Informations'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clAqua
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Align = alTop
            TabOrder = 0
            UseDockManager = True
            BevelOuter = bvLowered
          end
          object SGTK0Panel162: TSGTK0Panel
            Left = 5
            Top = 29
            Width = 361
            Height = 4
            Align = alTop
            TabOrder = 1
            UseDockManager = True
            BevelOuter = bvNone
          end
          object EditExportTrackName: TSGTK0Edit
            Left = 7
            Top = 52
            Width = 159
            Height = 19
            ColorFocused = 3158016
            TabOrder = 2
            OnChange = EditExportTrackNameChange
          end
          object EditExportAuthor: TSGTK0Edit
            Left = 205
            Top = 52
            Width = 159
            Height = 19
            ColorFocused = 3158016
            TabOrder = 3
            OnChange = EditExportAuthorChange
          end
          object MemoExportComments: TSGTK0Memo
            Left = 7
            Top = 98
            Width = 357
            Height = 64
            TabOrder = 4
            OnChange = MemoExportCommentsChange
          end
        end
      end
    end
    object SGTK0Panel6: TSGTK0Panel
      Left = 1
      Top = 78
      Width = 1003
      Height = 1
      ParentColor = True
      Align = alTop
      TabOrder = 2
      UseDockManager = True
      BevelOuter = bvLowered
    end
  end
  object SGTK0ButtonImportFXB: TSGTK0Button
    Left = 917
    Top = 78
    Width = 44
    Height = 18
    Hint = 'Import bank'
    Caption = 'Import'
    ParentColor = False
    TabOrder = 1
    OnClick = SGTK0ButtonImportFXBClick
  end
  object SGTK0ButtonExportFXB: TSGTK0Button
    Left = 960
    Top = 78
    Width = 44
    Height = 18
    Hint = 'Export bank'
    Caption = 'Export'
    ParentColor = False
    TabOrder = 2
    OnClick = SGTK0ButtonExportFXBClick
  end
  object AudioStatusTimer: TTimer
    Interval = 10
    OnTimer = AudioStatusTimerTimer
    Left = 135
    Top = 1
  end
  object RefreshTimer: TTimer
    OnTimer = RefreshTimerTimer
    Left = 247
    Top = 42
  end
  object TimerSize: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerSizeTimer
    Left = 187
    Top = 46
  end
  object SaveDialogWAV: TSaveDialog
    DefaultExt = '.wav'
    Filter = 'RIFF WAVE files (*.wav)|*.wav|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save sample'
    Left = 311
  end
  object OpenDialogWAV: TOpenDialog
    DefaultExt = '.wav'
    Filter = 'RIFF WAVE files (*.wav)|*.wav|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load sample'
    Left = 278
    Top = 3
  end
  object OpenDialogEQF: TOpenDialog
    DefaultExt = '.eqf'
    Filter = 'EQ preset files (*.eqf)|*.eqf|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load EQ preset'
    Left = 348
    Top = 65535
  end
  object SaveDialogEQF: TSaveDialog
    DefaultExt = '.eqf'
    Filter = 'EQ preset files (*.eqf)|*.eqf|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save EQ preset'
    Left = 381
  end
  object OpenDialogMIDI: TOpenDialog
    DefaultExt = '.mid'
    Filter = 
      'MIDI files (*.mid;*.midi;*.rmi)|*.mid;*.midi;*.rmi|All files (*.' +
      '*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load MIDI'
    Left = 412
    Top = 1
  end
  object SaveDialogBMF: TSaveDialog
    DefaultExt = '.bmf'
    Filter = 'BR808 music files (*.bmf)|*.bmf|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save BMF'
    Left = 445
  end
  object SaveDialogBBF: TSaveDialog
    DefaultExt = '.bbf'
    Filter = 'BR808 bank files (*.bmf)|*.bbf|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save BBF'
    Left = 475
  end
  object SaveDialogSynthConfigINC: TSaveDialog
    DefaultExt = '.inc'
    Filter = 'BR808 synthconfig include files (*.inc|*.inc|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save synthconfig-inc'
    Left = 505
    Top = 65534
  end
  object SaveDialogPAS: TSaveDialog
    DefaultExt = '.pas'
    Filter = '(Object-)Pascal unit files (*.pas|*.pas|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save BMF PAS unit'
    Left = 535
    Top = 65532
  end
  object SaveDialogEXE: TSaveDialog
    DefaultExt = '.exe'
    Filter = 'Win32 executable files (*.exe)|*.exe|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save EXE'
    Left = 375
    Top = 32
  end
  object SaveDialogH: TSaveDialog
    DefaultExt = '.h'
    Filter = 'C/C++ H header file (*.h)|*.h|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save BMF C/C++ H header file'
    Left = 345
    Top = 34
  end
  object SaveDialogFXP: TSaveDialog
    DefaultExt = '.fxp'
    Filter = 'VST(i) preset files (*.fxp)|*.fxp|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export preset'
    Left = 449
    Top = 36
  end
  object OpenDialogFXP: TOpenDialog
    DefaultExt = '.fxp'
    Filter = 'VST(i) preset files (*.fxp)|*.fxp|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import preset'
    Left = 412
    Top = 34
  end
  object SaveDialogFXB: TSaveDialog
    DefaultExt = '.fxb'
    Filter = 'VST(i) bank files (*.fxb)|*.fxb|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export bank'
    Left = 517
    Top = 32
  end
  object OpenDialogFXB: TOpenDialog
    DefaultExt = '.fxb'
    Filter = 'VST(i) bank files (*.fxb)|*.fxb|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import bank'
    Left = 482
    Top = 36
  end
  object ColorTimer: TTimer
    Interval = 50
    OnTimer = ColorTimerTimer
    Left = 98
    Top = 2
  end
  object PopupMenuInstruments: TPopupMenu
    OwnerDraw = True
    OnPopup = PopupMenuInstrumentsPopup
    Left = 240
    Top = 65534
  end
  object SGTK0Menu1: TSGTK0Menu
    AssignedMenus = <
      item
        Menu = PopupMenuInstruments
      end
      item
        Menu = PopupMenuEditor
      end>
    FontActive.Charset = DEFAULT_CHARSET
    FontActive.Color = 2105344
    FontActive.Height = -11
    FontActive.Name = 'Arial'
    FontActive.Style = [fsBold]
    FontNormal.Charset = DEFAULT_CHARSET
    FontNormal.Color = clAqua
    FontNormal.Height = -11
    FontNormal.Name = 'Arial'
    FontNormal.Style = []
    LinuxStyle = True
    Active = True
    Left = 569
    Top = 23
  end
  object OpenDialogScaleFile: TOpenDialog
    DefaultExt = '.scl'
    Filter = 
      'All supported files (*.scl;*.mtd)|*.scl;*.mtd|Scala scale files ' +
      '(*.scl)|*.scl|MIDI tuning dump ASCII files (*.mtd)|*.mtd|All fil' +
      'es (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import tuning'
    Left = 544
    Top = 72
  end
  object SaveDialogTuning: TSaveDialog
    DefaultExt = '.mtd'
    Filter = 'MIDI tuning dump ASCII files (*.mtd)|*.mtd|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export tuning'
    Left = 579
    Top = 66
  end
  object PopupMenuEditor: TPopupMenu
    OwnerDraw = True
    OnPopup = PopupMenuEditorPopup
    Left = 100
    Top = 38
    object Undo2: TMenuItem
      Caption = '&Undo'
      ShortCut = 16474
      OnClick = Undo2Click
    end
    object Redo2: TMenuItem
      Caption = 'Redo'
      ShortCut = 24666
      OnClick = Redo2Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Cut2: TMenuItem
      Caption = 'Cu&t'
      ShortCut = 16472
      OnClick = Cut2Click
    end
    object Copy2: TMenuItem
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = Copy2Click
    end
    object Paste2: TMenuItem
      Caption = '&Paste'
      ShortCut = 16470
      OnClick = Paste2Click
    end
    object Delete2: TMenuItem
      Caption = '&Delete'
      ShortCut = 16430
      OnClick = Delete2Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Selectall2: TMenuItem
      Caption = '&Select all'
      ShortCut = 16449
      OnClick = Selectall2Click
    end
    object Unselectall2: TMenuItem
      Caption = '&Unselect all '
      ShortCut = 24641
      OnClick = Unselectall2Click
    end
  end
end
