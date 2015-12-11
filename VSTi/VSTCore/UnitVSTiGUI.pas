unit UnitVSTiGUI;
{$j+}

interface

uses Windows,Messages,SysUtils,Classes,Math,Graphics,Controls,Forms,Dialogs,
     StdCtrls,ExtCtrls,ComCtrls,CheckLst,Menus,Buttons;

const clrBack=$00202000;
      clrFocusedHighlight=$007f7f00;
      clrDown=$00606000;
      clrBorder=$00ffff00;
      clrEditListBack=$00404000;
      clrEditListFocused=$00303000;

      DEFAULT_RIGHT_MARGIN=5;
      DEFAULT_LEFT_MARGIN=16;
      DEFAULT_FOCUSED_FACE=$00EAEA00;
      DEFAULT_LINE_COLOR=$00909000;
      DEFAULT_NORMAL_FACE=$00202000;
      DEFAULT_DOWN_FACE=$0006060600;
      DEFAULT_HIGHLIGHT_COLOR=$007f7f00;
      DEFAULT_SHADOW_COLOR=$00404000;
      DEFAULT_TEXT_VERT_MARGIN=2;

      SGTK0UpdateLock:boolean=false;

type TSGTK0Panel=class(TCustomPanel)
      private
       BufferBitmap:TBitmap;
       FColorBorder:TColor;
       procedure SetColors(index:integer;Value:TColor);
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure CMTextChanged(var message:TWmNoParams); message CM_TEXTCHANGED;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure Resize; override;
       procedure Paint; override;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
      published
       property Caption;
       property Font;
       property Color default clrBack;
       property ParentColor;
       property ParentFont;
       property Enabled;
       property Visible;
       property ColorBorder:TColor index 0 read FColorBorder write SetColors default clrBorder;
       property Align;
       property Alignment;
       property Cursor;
       property Hint;
       property ParentShowHint;
       property ShowHint;
       property PopupMenu;
       property TabOrder;
       property TabStop;
       property AutoSize;
       property UseDockManager;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property DragMode;
       property DragCursor;
       property ParentBiDiMode;
       property DockSite;
       property OnEndDock;
       property OnStartDock;
       property OnCanResize;
       property OnConstrainedResize;
       property OnDockDrop;
       property OnDockOver;
       property OnGetSiteInfo;
       property OnUnDock;
       property OnContextPopup;
       property OnClick;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnResize;
       property OnStartDrag;
       property BevelInner default bvNone;
       property BevelOuter default bvRaised;
       property BevelWidth;
       property BorderStyle;
       property BorderWidth;
       property Locked;
       property FullRepaint;
     end;

     TCustomSGTK0Edit=class(TCustomEdit)
      private
       FParentColor:boolean;
       FFocusedColor:TColor;
       FBorderColor:TColor;
       FBackColor:TColor;
       ButtonMouseInControl:boolean;
       procedure SetColors(index:integer;Value:TColor);
       procedure SetParentColor(Value:boolean);
       procedure RedrawBorder(const Clip:HRGN);
       procedure NewAdjustHeight;
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure CMFontChanged(var message:TMessage); message CM_FONTCHANGED;
       procedure CMMouseEnter(var message:TMessage); message CM_MOUSEENTER;
       procedure CMMouseLeave(var message:TMessage); message CM_MOUSELEAVE;
       procedure WMSetFocus(var message:TWMSetFocus); message WM_SETFOCUS;
       procedure WMKillFocus(var message:TWMKillFocus); message WM_KILLFOCUS;
       procedure WMNCCalcSize(var message:TWMNCCalcSize); message WM_NCCALCSIZE;
       procedure WMNCPaint(var message:TMessage); message WM_NCPAINT;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
//     procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure Loaded; override;
       property ColorFocused:TColor index 0 read FFocusedColor write SetColors default clrEditListFocused;
       property ColorBorder:TColor index 1 read FBorderColor write SetColors default clrBorder;
       property ColorBack:TColor index 2 read FBackColor write SetColors default clBlack;
       property ParentColor:boolean read FParentColor write SetParentColor default false;
       property CharCase;
       property DragCursor;
       property Enabled;
       property Font;
       property HideSelection;
       property MaxLength;
       property OEMConvert;
       property ParentFont;
       property ParentShowHint;
       property PasswordChar;
       property PopupMenu;
       property ReadOnly;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property Text;
       property Visible;
       property OnChange;
       property OnClick;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnStartDrag;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
      public
       constructor Create(AOwner:TComponent); override;
     end;

     TSGTK0Edit=class(TCustomSGTK0Edit)
      published
       property ColorFocused:TColor index 0 read FFocusedColor write SetColors default $404000;
       property ColorBorder:TColor index 1 read FBorderColor write SetColors default clrBorder;
       property ColorBack:TColor index 2 read FBackColor write SetColors default clrEditListBack;
       property ParentColor:boolean read FParentColor write SetParentColor default false;
       property CharCase;
       property DragCursor;
       property DragMode;
       property Enabled;
       property Font;
       property HideSelection;
       property MaxLength;
       property OEMConvert;
       property ParentFont;
       property ParentShowHint;
       property PasswordChar;
       property PopupMenu;
       property ReadOnly;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property Text;
       property Visible;
       property OnChange;
       property OnClick;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnStartDrag;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0Button=class(TCustomControl)
      private
       BufferBitmap:TBitmap;
       FOnMouseEnter:TNotifyEvent;
       FOnMouseLeave:TNotifyEvent;
       FModalResult:TModalResult;
       FDownColor:TColor;
       FBorderColor:TColor;
       FColorHighlight:TColor;
       FFocusedColor:TColor;
       FGroupIndex:integer;
       FDown:boolean;
       FDragging:boolean;
       FAllowAllUp:boolean;
       FSpacing:integer;
       FMargin:integer;
       FMouseInControl:boolean;
       FDefault:boolean;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
       procedure SetColors(index:integer;Value:TColor);
       procedure UpdateExclusive;
       procedure SetDown(Value:boolean);
       procedure SetAllowAllUp(Value:boolean);
       procedure SetGroupIndex(Value:integer);
       procedure SetSpacing(Value:integer);
       procedure SetMargin(Value:integer);
       procedure UpdateTracking;
       procedure WMLButtonDblClk(var message:TWMLButtonDown); message WM_LBUTTONDBLCLK;
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure CMButtonPressed(var message:TMessage); message CM_BUTTONPRESSED;
       procedure CMDialogChar(var message:TCMDialogChar); message CM_DIALOGCHAR;
       procedure CMFontChanged(var message:TMessage); message CM_FONTCHANGED;
       procedure CMTextChanged(var message:TMessage); message CM_TEXTCHANGED;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
       procedure RemoveMouseTimer;
       procedure MouseTimerHandler(Sender:TObject);
       procedure SetDefault(const Value:boolean);
       procedure WMSetFocus(var message:TWMSetFocus); message WM_SETFOCUS;
       procedure WMKillFocus(var message:TWMKillFocus); message WM_KILLFOCUS;
       procedure WMKeyDown(var message:TWMKeyDown); message WM_KEYDOWN;
       procedure WMKeyUp(var message:TWMKeyUp); message WM_KEYUP;
       procedure WMSize(var message:TWMSize); message WM_SIZE;
       procedure WMMove(var message:TWMMove); message WM_MOVE;
       procedure CMMouseEnter(var message:TMessage); message CM_MOUSEENTER;
       procedure CMMouseLeave(var message:TMessage); message CM_MOUSELEAVE;
     protected
       FState:TButtonState;
       procedure Loaded; override;
       procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure MouseMove(Shift:TShiftState;X,Y:integer); override;
       procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure Resize; override;
       procedure Paint; override;
     public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       procedure Click; override;
       procedure MouseEnter;
       procedure MouseLeave;
     published
       property default:boolean read FDefault write SetDefault default false;
       property AllowAllUp:boolean read FAllowAllUp write SetAllowAllUp default false;
       property Color default clrBack;
       property ColorFocused:TColor index 0 read FFocusedColor write SetColors default clrFocusedHighlight;
       property ColorDown:TColor index 1 read FDownColor write SetColors default clrDown;
       property ColorBorder:TColor index 2 read FBorderColor write SetColors default clrBorder;
       property ColorHighLight:TColor index 3 read FColorHighlight write SetColors default clrFocusedHighlight;
       property GroupIndex:integer read FGroupINDEX write SetGroupINDEX default 0;
       property Down:boolean read FDown write SetDown default false;
       property Caption;
       property Enabled;
       property Font;
       property Margin:integer read FMargin write SetMargin default -1;
       property ParentFont;
       property ParentColor;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property TabStop;
       property TabOrder;
       property Spacing:integer read FSpacing write SetSpacing default 4;
       property ModalResult:TModalResult read FModalResult write FModalResult default 0;
       property Visible;
       property OnClick;
       property OnDblClick;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnMouseEnter:TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
       property OnMouseLeave:TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0ComboBox=class(TCustomComboBox)
      private
       FArrowColor:TColor;
       FArrowBackgroundColor:TColor;
       FBorderColor:TColor;
       FButtonWidth:integer;
       FChildHandle:HWND;
       FDefListProc:pointer;
       FListHandle:HWND;
       FListInstance:pointer;
       FSysBtnWidth:integer;
       FSolidBorder:boolean;
       procedure SetColors(index:integer;Value:TColor);
       function GetButtonRect:TRect;
       procedure PaintButton;
       procedure PaintBorder;
       procedure RedrawBorders;
       procedure InvalidateSelection;
       function GetSolidBorder:boolean;
       procedure SetSolidBorder;
       procedure ListWndProc(var message:TMessage);
       procedure WMSetFocus(var message:TMessage); message WM_SETFOCUS;
       procedure WMKillFocus(var message:TMessage); message WM_KILLFOCUS;
       procedure WMKeyDown(var message:TMessage); message WM_KEYDOWN;
       procedure WMPaint(var message:TWMPaint); message WM_PAINT;
       procedure WMNCPaint(var message:TMessage); message WM_NCPAINT;
       procedure CMEnabledChanged(var Msg:TMessage); message CM_ENABLEDCHANGED;
       procedure CNCommand(var message:TWMCommand); message CN_COMMAND;
       procedure CMFontChanged(var message:TMessage); message CM_FONTCHANGED;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure WndProc(var message:TMessage); override;
       procedure ComboWndProc(var message:TMessage;ComboWnd:HWnd;ComboProc:pointer); override;
       property SolidBorder:boolean read FSolidBorder;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
      published
       property Style;
       property Color default clrEditListBack;
       property ColorArrow:TColor index 0 read FArrowColor write SetColors default clrBorder;
       property ColorArrowBackground:TColor index 1 read FArrowBackgroundColor write SetColors default clrBack;
       property ColorBorder:TColor index 2 read FBorderColor write SetColors default clrBorder;
       property DragMode;
       property DragCursor;
       property DropDownCount;
       property Enabled;
       property Font;
       property ItemHeight;
       property Items;
       property MaxLength;
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property Sorted;
       property TabOrder;
       property TabStop;
       property Text;
       property Visible;
       property ItemIndex;
       property OnChange;
       property OnClick;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnDrawItem;
       property OnDropDown;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMeasureItem;
       property OnStartDrag;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0CheckBox=class(TCustomControl)
      private
       BufferBitmap:TBitmap;
       FMouseInControl:boolean;
       MouseIsDown:boolean;
       Focused:boolean;
       FChecked:boolean;
       FFocusedColor:TColor;
       FDownColor:TColor;
       FCheckColor:TColor;
       FBorderColor:TColor;
       procedure SetColors(index:integer;Value:TColor);
       procedure SetChecked(Value:boolean);
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure CMTextChanged(var message:TWmNoParams); message CM_TEXTCHANGED;
       procedure CMDialogChar(var message:TCMDialogChar); message CM_DIALOGCHAR;
       procedure CNCommand(var message:TWMCommand); message CN_COMMAND;
       procedure WMSetFocus(var message:TWMSetFocus); message WM_SETFOCUS;
       procedure WMKillFocus(var message:TWMKillFocus); message WM_KILLFOCUS;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
       procedure RemoveMouseTimer;
       procedure MouseTimerHandler(Sender:TObject);
       procedure CMDesignHitTest(var message:TCMDesignHitTest); message CM_DESIGNHITTEST;
       procedure WMSize(var message:TWMSize); message WM_SIZE;
       procedure WMMove(var message:TWMMove); message WM_MOVE;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
     protected
       procedure DoEnter; override;
       procedure DoExit; override;
       procedure MouseDown(Button:TMouseButton;Shift:TShIFtState;X,Y:integer); override;
       procedure MouseUp(Button:TMouseButton;Shift:TShIFtState;X,Y:integer); override;
       procedure MouseMove(Shift:TShIFtState;X,Y:integer); override;
       procedure CreateWnd; override;
       procedure DrawCheckRect;
       procedure DrawCheckText;
       procedure Paint; override;
       procedure SetBiDiMode(Value:TBiDiMode); override;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       procedure MouseEnter;
       procedure MouseLeave;
      published
       property Caption;
       property Checked:boolean read FChecked write SetChecked default false;
       property Color default clrBack;
       property ColorFocused:TColor index 0 read FFocusedColor write SetColors default clrFocusedHighlight;
       property ColorDown:TColor index 1 read FDownColor write SetColors default clrDown;
       property ColorCheck:TColor index 2 read FCheckColor write SetColors default clrBorder;
       property ColorBorder:TColor index 3 read FBorderColor write SetColors default clrBorder;
       property Enabled;
       property Font;
       property ParentColor;
       property ParentFont;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property Visible;
       property OnClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property Action;
       property Anchors;
       property BiDiMode write SetBidiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0ScrollbarThumb=class(TSGTK0Button)
      private
       FDown:boolean;
       FOldX,FOldY:integer;
       FTopLimit:integer;
       FBottomLimit:integer;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure Paint; override;
      public
       constructor Create(AOwner:TComponent); override;
       procedure MouseDown(Button:TMouseButton;Shift:TShIFtState;X,Y:integer); override;
       procedure MouseMove(Shift:TShIFtState;X,Y:integer); override;
       procedure MouseUp(Button:TMouseButton;Shift:TShIFtState;X,Y:integer); override;
       property Color;
     end;

     TSGTK0ScrollbarTrack=class(TCustomControl)
      private
       BufferBitmap:TBitmap;
       FThumb:TSGTK0ScrollbarThumb;
       FKind:TScrollBarKind;
       FBorderColor:TColor;
       FSmallChange:integer;
       FLargeChange:integer;
       FMin:integer;
       FMax:integer;
       FPosition:integer;
       FOldPosition:integer;
       FOldCaption:string;
       procedure SetSmallChange(Value:integer);
       procedure SetLargeChange(Value:integer);
       procedure SetMin(Value:integer);
       procedure SetMax(Value:integer);
       procedure SetPosition(Value:integer);
       procedure SetKind(Value:TScrollBarKind);
       procedure WMSize(var message:TMessage); message WM_SIZE;
       function ThumbFromPosition:integer;
       function PositionFromThumb:integer;
       procedure DoPositionChange;
       procedure DoThumbHighlightColor(Value:TColor);
       procedure DoThumbBorderColor(Value:TColor);
       procedure DoThumbFocusedColor(Value:TColor);
       procedure DoThumbDownColor(Value:TColor);
       procedure DoThumbColor(Value:TColor);
       procedure DoHScroll(var message:TWMScroll);
       procedure DoVScroll(var message:TWMScroll);
       procedure DoEnableArrows(var message:TMessage);
       procedure DoGetPos(var message:TMessage);
       procedure DoGetRange(var message:TMessage);
       procedure DoSetPos(var message:TMessage);
       procedure DoSetRange(var message:TMessage);
       procedure DoKeyDown(var message:TWMKeyDown);
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure Paint; override;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       procedure ProcessNewSize;
      published
       property Align;
       property BorderColor:TColor read FBorderColor write FBorderColor default clrBorder;
       property Caption;
       property Color;
       property Font;
       property ParentColor;
       property ParentFont;
       property Min:integer read FMin write SetMin;
       property Max:integer read FMax write SetMax;
       property SmallChange:integer read FSmallChange write SetSmallChange;
       property LargeChange:integer read FLargeChange write SetLargeChange;
       property Position:integer read FPosition write SetPosition;
       property Kind:TScrollBarKind read FKind write SetKind;
     end;

     TSGTK0ScrollbarButton=class(TSGTK0Button)
      private
       FNewDown:boolean;
       FTimer:TTimer;
       FMode:integer;
       FOnDown:TNotIFyEvent;
       procedure DoTimer(Sender:TObject);
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure Paint; override;
       procedure MouseDown(Button:TMouseButton;Shift:TShIFtState;X,Y:integer); override;
       procedure MouseMove(Shift:TShIFtState;X,Y:integer); override;
       procedure MouseUp(Button:TMouseButton;Shift:TShIFtState;X,Y:integer); override;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
      published
       property Align;
       property OnDown:TNotIFyEvent read FOnDown write FOnDown;
     end;

     TSGTK0OnScroll=procedure(Sender:TObject;ScrollPos:integer) of object;

     TSGTK0Scrollbar=class(TCustomControl)
      private
       FTrack:TSGTK0ScrollbarTrack;
       FBtnOne:TSGTK0ScrollbarButton;
       FBtnTwo:TSGTK0ScrollbarButton;
       FMin:integer;
       FMax:integer;
       FSmallChange:integer;
       FLargeChange:integer;
       FPosition:integer;
       FKind:TScrollBarKind;
       FButtonHighlightColor:TColor;
       FButtonBorderColor:TColor;
       FButtonFocusedColor:TColor;
       FButtonDownColor:TColor;
       FButtonColor:TColor;
       FThumbHighlightColor:TColor;
       FThumbBorderColor:TColor;
       FThumbFocusedColor:TColor;
       FThumbDownColor:TColor;
       FThumbColor:TColor;
       FOnScroll:TSGTK0OnScroll;
       procedure SetSmallChange(Value:integer);
       procedure SetLargeChange(Value:integer);
       procedure SetMin(Value:integer);
       procedure SetMax(Value:integer);
       procedure SetPosition(Value:integer);
       procedure SetKind(Value:TScrollBarKind);
       procedure SetButtonHighlightColor(Value:TColor);
       procedure SetButtonBorderColor(Value:TColor);
       procedure SetButtonFocusedColor(Value:TColor);
       procedure SetButtonDownColor(Value:TColor);
       procedure SetButtonColor(Value:TColor);
       procedure SetThumbHighlightColor(Value:TColor);
       procedure SetThumbBorderColor(Value:TColor);
       procedure SetThumbFocusedColor(Value:TColor);
       procedure SetThumbDownColor(Value:TColor);
       procedure SetThumbColor(Value:TColor);
       procedure BtnOneClick(Sender:TObject);
       procedure BtnTwoClick(Sender:TObject);
       procedure EnableBtnOne(Value:boolean);
       procedure EnableBtnTwo(Value:boolean);
       procedure DoScroll;
       procedure WMSize(var message:TWMSize); message WM_SIZE;
       procedure CNHScroll(var message:TWMScroll); message WM_HSCROLL;
       procedure CNVScroll(var message:TWMScroll); message WM_VSCROLL;
       procedure SBMEnableArrows(var message:TMessage); message SBM_ENABLE_ARROWS;
       procedure SBMGetPos(var message:TMessage); message SBM_GETPOS;
       procedure SBMGetRange(var message:TMessage); message SBM_GETRANGE;
       procedure SBMSetPos(var message:TMessage); message SBM_SETPOS;
       procedure SBMSetRange(var message:TMessage); message SBM_SETRANGE;
       procedure WMKeyDown(var message:TWMKeyDown); message WM_KEYDOWN;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
      published
       property Min:integer read FMin write SetMin default 0;
       property Max:integer read FMax write SetMax default 100;
       property SmallChange:integer read FSmallChange write SetSmallChange default 1;
       property LargeChange:integer read FLargeChange write SetLargeChange default 1;
       property Position:integer read FPosition write SetPosition default 0;
       property Kind:TScrollBarKind read FKind write SetKind default sbVertical;
       property OnScroll:TSGTK0OnScroll read FOnScroll write FOnScroll;
       property ButtonHighlightColor:TColor read FButtonHighlightColor write SetButtonHighlightColor;
       property ButtonBorderColor:TColor read FButtonBorderColor write SetButtonBorderColor;
       property ButtonFocusedColor:TColor read FButtonFocusedColor write SetButtonFocusedColor;
       property ButtonDownColor:TColor read FButtonDownColor write SetButtonDownColor;
       property ButtonColor:TColor read FButtonColor write SetButtonColor;
       property ThumbHighlightColor:TColor read FThumbHighlightColor write SetThumbHighlightColor;
       property ThumbBorderColor:TColor read FThumbBorderColor write SetThumbBorderColor;
       property ThumbFocusedColor:TColor read FThumbFocusedColor write SetThumbFocusedColor;
       property ThumbDownColor:TColor read FThumbDownColor write SetThumbDownColor;
       property ThumbColor:TColor read FThumbColor write SetThumbColor;
       property Track:TSGTK0ScrollbarTrack read FTrack;
       property Align;
       property Color;
       property ParentColor;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyUp;
       property OnStartDrag;
     end;

     TSGTK0TabControl=class(TCustomControl)
      private
       BufferBitmap:TBitmap;
       FTabs:TStringList;
       FTabsRect:TList;
       FTabHeight:integer;
       FTabSpacing:integer;
       FActiveTab:integer;
       FUnselectedColor:TColor;
       FBorderColor:TColor;
       FOnTabChanged:TNotifyEvent;
       FBorderWidth:integer;
       FInChange:boolean;
       procedure SetTabs(Value:TStringList);
       procedure SetTabHeight(Value:integer);
       procedure SetTabSpacing(Value:integer);
       procedure SetActiveTab(Value:integer);
       procedure SetColors(index:integer;Value:TColor);
       procedure SetTabRect;
       procedure CMDialogChar(var message:TCMDialogChar); message CM_DIALOGCHAR;
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure WMSize(var message:TWMSize); message WM_SIZE;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
       procedure CMDesignHitTest(var message:TCMDesignHitTest); message CM_DESIGNHITTEST;
       procedure WMMove(var message:TWMMove); message WM_MOVE;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
       procedure SetBorderWidth(const Value:integer);
      protected
       procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure Loaded; override;
       procedure Resize; override;
       procedure Paint; override;
       procedure AlignControls(AControl:TControl;var Rect:TRect); override;
       procedure TabsChanged(Sender:TObject);
       procedure SetBiDiMode(Value:TBiDiMode); override;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
     published
       property Align;
       property BorderWidth:integer read FBorderWidth write SetBorderWidth default 0;
       property ColorBorder:TColor index 0 read FBorderColor write SetColors default clrBorder;
       property ColorUnselectedTab:TColor index 1 read FUnselectedColor write SetColors default clrBorder;
       property Tabs:TStringList read FTabs write SetTabs;
       property TabHeight:integer read FTabHeight write SetTabHeight default 16;
       property TabSpacing:integer read FTabSpacing write SetTabSpacing default 4;
       property ActiveTab:integer read FActiveTab write SetActiveTab default 0;
       property Font;
       property Color;
       property ParentColor;
       property Enabled;
       property Visible;
       property Cursor;
       property ParentShowHint;
       property ParentFont;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property OnEnter;
       property OnExit;
       property OnMouseMove;
       property OnMouseDown;
       property OnMouseUp;
       property OnTabChanged:TNotifyEvent read FOnTabChanged write FOnTabChanged;
       property Anchors;
       property BiDiMode write SetBidiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0PageControl=class;

     TSGTK0TabSheet=class(TCustomControl)
      private
       FPageControl:TSGTK0PageControl;
       FTabVisible:boolean;
       FTabShowing:boolean;
       FHighlighted:boolean;
       FOnHide:TNotifyEvent;
       FOnShow:TNotifyEvent;
       function GetPageIndex:integer;
       function GetTabIndex:integer;
       procedure SetHighlighted(Value:boolean);
       procedure SetPageControl(APageControl:TSGTK0PageControl);
       procedure SetPageIndex(Value:integer);
       procedure SetTabShowing(Value:boolean);
       procedure SetTabVisible(Value:boolean);
       procedure UpdateTabShowing;
       procedure CMTextChanged(var message:TMessage); message CM_TEXTCHANGED;
       procedure CMShowingChanged(var message:TMessage); message CM_SHOWINGCHANGED;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       procedure CreateParams(var Params:TCreateParams); override;
       procedure DoHide; dynamic;
       procedure DoShow; dynamic;
       procedure Paint; override;
       procedure ReadState(Reader:TReader); override;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       property PageControl:TSGTK0PageControl read FPageControl write SetPageControl;
       property TabIndex:integer read GetTabIndex;
      published
       property BorderWidth;
       property Caption;
       property DragMode;
       property Enabled;
       property Font;
       property Height stored false;
       property Highlighted:boolean read FHighlighted write SetHighlighted default false;
       property Left stored false;
       property Constraints;
       property PageIndex:integer read GetPageIndex write SetPageIndex stored false;
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property TabVisible:boolean read FTabVisible write SetTabVisible default true;
       property Top stored false;
       property Visible stored false;
       property Width stored false;
       property OnContextPopup;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnHide:TNotifyEvent read FOnHide write FOnHide;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnResize;
       property OnShow:TNotifyEvent read FOnShow write FOnShow;
       property OnStartDrag;
     end;

     TSGTK0PageControl=class(TSGTK0TabControl)
      private
       FPages:TList;
       FActivePage:TSGTK0TabSheet;
       FNewDockSheet:TSGTK0TabSheet;
       FUndockingPage:TSGTK0TabSheet;
       procedure ChangeActivePage(Page:TSGTK0TabSheet);
       procedure DeleteTab(Page:TSGTK0TabSheet;index:integer);
       function GetActivePageIndex:integer;
       function GetDockClientFromMousePos(MousePos:TPoint):TControl;
       function GetPage(index:integer):TSGTK0TabSheet;
       function GetPageCount:integer;
       procedure InsertPage(Page:TSGTK0TabSheet);
       procedure InsertTab(Page:TSGTK0TabSheet);
       procedure MoveTab(CurIndex,NewIndex:integer);
       procedure RemovePage(Page:TSGTK0TabSheet);
       procedure SetActivePage(Page:TSGTK0TabSheet);
       procedure SetActivePageIndex(const Value:integer);
       procedure UpdateTab(Page:TSGTK0TabSheet);
       procedure UpdateTabHighlights;
       procedure CMDialogKey(var message:TCMDialogKey); message CM_DIALOGKEY;
       procedure CMDockClient(var message:TCMDockClient); message CM_DOCKCLIENT;
       procedure CMDockNotification(var message:TCMDockNotification); message CM_DOCKNOTIFICATION;
       procedure CMUnDockClient(var message:TCMUnDockClient); message CM_UNDOCKCLIENT;
       procedure WMLButtonDown(var message:TWMLButtonDown); message WM_LBUTTONDOWN;
       procedure WMLButtonDblClk(var message:TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
      protected
       function CanShowTab(TabIndex:integer):boolean;
       procedure Change;
       procedure DoAddDockClient(Client:TControl;const ARect:TRect); override;
       procedure DockOver(Source:TDragDockObject;X,Y:integer;State:TDragState;var Accept:boolean); override;
       procedure DoRemoveDockClient(Client:TControl); override;
       procedure GetChildren(Proc:TGetChildProc; Root:TComponent); override;
       function GetPageFromDockClient(Client:TControl):TSGTK0TabSheet;
       procedure GetSiteInfo(Client:TControl;var InfluenceRect:TRect;MousePos:TPoint;var CanDock:boolean); override;
       procedure Loaded; override;
       procedure SetChildOrder(Child:TComponent;Order:integer); override;
       procedure ShowControl(AControl:TControl); override;
       procedure UpdateActivePage; virtual;
      public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       function FindNextPage(CurPage:TSGTK0TabSheet;GoForward,CheckTabVisible:boolean):TSGTK0TabSheet;
       procedure SelectNextPage(GoForward:boolean);
       property ActivePageIndex:integer read GetActivePageIndex write SetActivePageIndex;
       property PageCount:integer read GetPageCount;
       property Pages[index:integer]:TSGTK0TabSheet read GetPage;
      published
       property ActivePage:TSGTK0TabSheet read FActivePage write SetActivePage;
       property Align;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DockSite;
       property DragCursor;
       property DragKind;
       property DragMode;
       property Enabled;
       property Font;
       property ParentBiDiMode;
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property TabHeight;
       property TabOrder;
       property TabStop;
       property Visible;
       property OnContextPopup;
       property OnDockDrop;
       property OnDockOver;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDock;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnGetSiteInfo;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnResize;
       property OnStartDock;
       property OnStartDrag;
       property OnUnDock;
     end;

     TSGTK0ListBox=class(TCustomControl)
      private
       BufferBitmap:TBitmap;
       cWheelMessage:CARDINAL;
       ScrollType:byte;
       FirstItem:integer;
       MaxItems:integer;
       FSorted:boolean;
       FItems:TStringList;
       FItemsRect:TList;
       FItemsHeight:integer;
       FItemIndex:integer;
       FSelected:set of byte;
       FMultiSelect:boolean;
       FScrollBars:boolean;
       FArrowColor:TColor;
       FBorderColor:TColor;
       FItemsRectColor:TColor;
       FItemsSelectColor:TColor;
       procedure SetColors(index:integer;Value:TColor);
       procedure SetSorted(Value:boolean);
       procedure SetItems(Value:TStringList);
       procedure SetItemsRect;
       procedure SetItemsHeight(Value:integer);
       function GetSelected(index:integer):boolean;
       procedure SetSelected(index:integer;Value:boolean);
       function GetSelCount:integer;
       procedure SetScrollBars(Value:boolean);
       function GetItemIndex:integer;
       procedure SetItemIndex(Value:integer);
       procedure SetMultiSelect(Value:boolean);
       procedure WMSize(var message:TWMSize); message WM_SIZE;
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
       procedure ScrollTimerHandler(Sender:TObject);
       procedure ItemsChanged(Sender:TObject);
       procedure WMMove(var message:TWMMove); message WM_MOVE;
       procedure WMSetFocus(var message:TWMSetFocus); message WM_SETFOCUS;
       procedure WMKillFocus(var message:TWMKillFocus); message WM_KILLFOCUS;
       procedure CNKeyDown(var message:TWMKeyDown); message CN_KEYDOWN;
       procedure WMMouseWheel(var message:TMessage); message WM_MOUSEWHEEL;
       procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
     protected
       procedure DrawScrollBar(Canvas:TCanvas);
       procedure Loaded; override;
       procedure Resize; override;
       procedure Paint; override;
       procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure WndProc(var message:TMessage); override;
       procedure SetBiDiMode(Value:TBiDiMode); override;
     public
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       property Selected[index:integer]:boolean read GetSelected write SetSelected;
       property SelCount:integer read GetSelCount;
       property ItemIndex:integer read GetItemIndex write SetItemIndex;
     published
       property Align;
       property Items:TStringList read FItems write SetItems;
       property ItemHeight:integer read FItemsHeight write SetItemsHeight default 17;
       property MultiSelect:boolean read FMultiSelect write SetMultiSelect default false;
       property ScrollBars:boolean read FScrollBars write SetScrollBars default false;
       property Color default clrBack;
       property ColorArrow:TColor index 0 read FArrowColor write SetColors default clrBorder;
       property ColorBorder:TColor index 1 read FBorderColor write SetColors default clrBorder;
       property ColorItemsRect:TColor index 2 read FItemsRectColor write SetColors default clrEditListBack;
       property ColorItemsSelect:TColor index 3 read FItemsSelectColor write SetColors default clrFocusedHighlight;
       property Sorted:boolean read FSorted write SetSorted default false;
       property Font;
       property ParentFont;
       property ParentColor;
       property ParentShowHint;
       property Enabled;
       property Visible;
       property PopupMenu;
       property ShowHint;
       property OnClick;
       property OnMouseMove;
       property OnMouseDown;
       property OnMouseUp;
       property Anchors;
       property BiDiMode write SetBidiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0Memo=class(TCustomMemo)
      private
       FParentColor:boolean;
       FFocusedColor:TColor;
       FBorderColor:TColor;
       FBackColor:TColor;
       MouseInControl:boolean;
       procedure SetColors(index:integer;Value:TColor);
       procedure SetParentColor(Value:boolean);
       procedure CMEnabledChanged(var message:TMessage); message CM_ENABLEDCHANGED;
       procedure CMMouseEnter(var message:TMessage); message CM_MOUSEENTER;
       procedure CMMouseLeave(var message:TMessage); message CM_MOUSELEAVE;
       procedure WMSetFocus(var message:TWMSetFocus); message WM_SETFOCUS;
       procedure WMKillFocus(var message:TWMKillFocus); message WM_KILLFOCUS;
       procedure WMNCCalcSize(var message:TWMNCCalcSize); message WM_NCCALCSIZE;
       procedure WMNCPaint(var message:TMessage); message WM_NCPAINT;
       procedure CMSysColorChange(var message:TMessage); message CM_SYSCOLORCHANGE;
       procedure CMParentColorChanged(var message:TWMNoParams); message CM_PARENTCOLORCHANGED;
       //procedure WMEraseBkgnd(var Msg:TWMEraseBkgnd); message WM_ERASEBKGND;
     protected
       procedure RedrawBorder(const Clip:HRGN);
     public
       constructor Create(AOwner:TComponent); override;
     published
       property ColorFocused:TColor index 0 read FFocusedColor write SetColors default clrEditListFocused;
       property ColorBorder:TColor index 1 read FBorderColor write SetColors default clrBorder;
       property ColorBack:TColor index 2 read FBackColor write SetColors default clrEditListBack;
       property ParentColor:boolean read FParentColor write SetParentColor default false;
       property Align;
       property Alignment;
       property DragCursor;
       property DragMode;
       property Enabled;
       property Font;
       property HideSelection;
       property MaxLENGTH;
       property OEMConvert;
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ReadOnly;
       property ShowHint;
       property ScrollBars;
       property TabOrder;
       property TabStop;
       property Visible;
       property Lines;
       property WantReturns;
       property WantTabs;
       property WordWrap;
       property OnChange;
       property OnClick;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnStartDrag;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property OnEndDock;
       property OnStartDock;
     end;

     TSGTK0Menu=class;
     TSGTK0MenuCollection=class;

     TSGTK0MenuCollectionItem=class(TCollectionItem)
      private
       FMenu:TMenu;
       procedure SetMenu(const Value:TMenu);
      protected
       function GetDisplayName:string; override;
       procedure AssignMenu(const Value:TMenu;Assign:boolean);
       procedure AssignTo(Dest:TPersistent); override;
      public
       constructor Create(Collection:TCollection); override;
       destructor Destroy; override;
       function MenuComponent:TSGTK0Menu;
      published
       property Menu:TMenu read FMenu write SetMenu;
     end;

     TSGTK0MenuCollection=class(TCollection)
      private
       FMenu:TSGTK0Menu;
       function GetItems(i:integer):TSGTK0MenuCollectionItem;
      protected
       function GetOwner:TPersistent; override;
      public
       constructor Create(Acmp:TSGTK0Menu);
       property Menu:TSGTK0Menu read FMenu;
       procedure DeleteLink(const AComponent:TComponent);
       property Items[i:integer]:TSGTK0MenuCollectionItem read GetItems;
     end;

     TSGTK0Menu=class(TComponent)
      private
       FFontActive:TFont;
       FFontNormal:TFont;
       FRightMargin:integer;
       FLeftMargin:integer;
       FDownFace:TColor;
       FNormalFace:TColor;
       FLineColor:TColor;
       FFocusedFace:TColor;
       FTextVert:integer;
       FAssignedMenus:TSGTK0MenuCollection;
       FLinuxStyle:boolean;
       FShadowColor:TColor;
       FHighlightColor:TColor;
       FActive:boolean;
       function ItemMargin(Item:TMenuItem;Left:boolean):integer;
       procedure SetFontActive(const Value:TFont);
       procedure SetFontNormal(const Value:TFont);
       procedure SetAssignedMenus(const Value:TSGTK0MenuCollection);
       function IsTopItem(Item:TMenuItem):boolean;
       procedure SetActive(const Value:boolean);
      protected
       procedure Notification(AComponent:TComponent;Operation:TOperation); override;
      public
       procedure DrawItem(Sender:TObject;ACanvas:TCanvas;ARect:TRect;State:TOwnerDrawState);
       procedure MeasureItem(Sender:TObject;ACanvas:TCanvas;var Width,Height:Integer);
       procedure AssignMethods(AItem:TMenuItem;Assign:boolean);
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       procedure AddMenu(const AMenu:TMenu);
      published
       property AssignedMenus:TSGTK0MenuCollection read FAssignedMenus write SetAssignedMenus;
       property FontActive:TFont read FFontActive write SetFontActive;
       property FontNormal:TFont read FFontNormal write SetFontNormal;
       property LeftMargin:integer read FLeftMargin write FLeftMargin default DEFAULT_LEFT_MARGIN;
       property RightMargin:integer read FRightMargin write FRightMargin default DEFAULT_RIGHT_MARGIN;
       property TextVertMargin:integer read FTextVert write FTextVert default DEFAULT_TEXT_VERT_MARGIN;
       property FocusedFace:TColor read FFocusedFace write FFocusedFace default DEFAULT_FOCUSED_FACE;
       property LineColor:TColor read FLineColor write FLineColor default DEFAULT_LINE_COLOR;
       property NormalFace:TColor read FNormalFace write FNormalFace default DEFAULT_NORMAL_FACE;
       property DownFace:TColor read FDownFace write FDownFace default DEFAULT_DOWN_FACE;
       property LinuxStyle:boolean read FLinuxStyle write FLinuxStyle;
       property HighlightColor:TColor read FHighlightColor write FHighlightColor default DEFAULT_HIGHLIGHT_COLOR;
       property ShadowColor:TColor read FShadowColor write FShadowColor default DEFAULT_SHADOW_COLOR;
       property Active:boolean read FActive write SetActive;
     end;

const ButtonMouseInControl:TSGTK0Button=nil;
      CheckBoxMouseInControl:TSGTK0CheckBox=nil;

procedure Register;

implementation

const ButtonMouseTimer:TTimer=nil;
      ButtonControlCounter:integer=0;
      CheckBoxMouseTimer:TTimer=nil;
      CheckBoxControlCounter:integer=0;
      ListBoxScrollTimer:TTimer=nil;

      FTimerInterval=600;
      FScrollSpeed=100;

      Up=0;
      Down=1;

procedure Register;
begin
 RegisterComponents('SGTK0',[TSGTK0Panel,TSGTK0Edit,TSGTK0ComboBox,TSGTK0Button,TSGTK0CheckBox,TSGTK0ScrollBar,TSGTK0TabControl,TSGTK0TabSheet,TSGTK0PageControl,TSGTK0ListBox,TSGTK0Memo,TSGTK0Menu]);
end;

function GetFontMetrics(Font:TFont):TTextMetric;
var DC:HDC;
    SaveFont:HFont;
begin
 DC:=GetDC(0);
 SaveFont:=SelectObject(DC,Font.Handle);
 GetTextMetrics(DC,result);
 SelectObject(DC,SaveFont);
 ReleaseDC(0,DC);
end;

function GetFontHeight(Font:TFont):integer;
var t:TTextMetric;
begin
 t:=GetFontMetrics(Font);
 result:=ROUND(t.tmHeight+(t.tmHeight*0.125));
end;

function MakeVerticalFont(f:TFont):TFont;
var lf:TLogFont;
begin
 result:=TFont.Create;
 result.Assign(f);
 GetObject(result.Handle,sizeof(lf),@lf);
 lf.lfEscapement:=900;
 lf.lfOrientation:=900;
 result.Handle:=CreateFontIndirect(lf);
end;

function RectInRect(R1,R2:TRect):boolean;
begin
 result:=IntersectRect(R1,R1,R2);
end;

function Min(A,B:word):word;
begin
 result:=A;
 if A>B then result:=B;
end;

procedure Frame3DBorder(Canvas:TCanvas;Rect:TRect;TopColor,BottomColor:TColor;Width:integer);
 procedure DoRect;
 var TopRight,BottomLeft:TPoint;
 begin
  with Canvas,Rect do begin
   TopRight.X:=Right;
   TopRight.Y:=Top;
   BottomLeft.X:=Left;
   BottomLeft.Y:=Bottom;
   Pen.Color:=TopColor;
   PolyLine([BottomLeft,TopLeft,TopRight]);
   Pen.Color:=BottomColor;
   dec(BottomLeft.X);
   PolyLine([TopRight,BottomRight,BottomLeft]);
  end;
 end;
begin
 Canvas.Pen.Width:=1;
 dec(Rect.Bottom);
 dec(Rect.Right);
 while Width>0 do begin
  dec(Width);
  DoRect;
  InflateRect(Rect,-1,-1);
 end;
 inc(Rect.Bottom);
 inc(Rect.Right);
end;

constructor TSGTK0Panel.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 ParentFont:=true;
 FColorBorder:=clrBorder;
 ParentColor:=false;
 Color:=clrBack;
 BevelInner:=bvNone;
 BevelOuter:=bvLowered;
 ControlStyle:=ControlStyle+[csAcceptsControls,csOpaque];
 BufferBitmap:=TBitmap.Create;
 SetBounds(0,0,185,41);
end;

destructor TSGTK0Panel.Destroy;
begin
 BufferBitmap.Destroy;
 inherited Destroy;
end;

procedure TSGTK0Panel.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FColorBorder:=Value;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Panel.Resize;
begin
 inherited Resize;
 if (BufferBitmap.Width<>ClientRect.Right) or
    (BufferBitmap.Height<>ClientRect.Bottom) then begin
  BufferBitmap.Height:=0;
  BufferBitmap.Width:=ClientRect.Right;
  BufferBitmap.Height:=ClientRect.Bottom;
 end;
end;

procedure TSGTK0Panel.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0Panel.Paint;
var TextBounds:TRect;
    Format:longword;
    IP,MyBevelWidth:integer;
begin
 TextBounds:=ClientRect;
 Format:=DT_SINGLELINE or DT_VCENTER;
 case Alignment of
  taLeftJustify:Format:=Format or DT_LEFT;
  taCenter:Format:=Format or DT_CENTER;
  taRightJustify:Format:=Format or DT_RIGHT;
 end;
 try
  if(BufferBitmap.Width<>ClientRect.Right) or
    (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;

  BufferBitmap.Canvas.Brush.Color:=self.Color;
  BufferBitmap.Canvas.FillRect(ClientRect);

  MyBevelWidth:=BevelWidth;
  if MyBevelWidth=0 then begin
   MyBevelWidth:=1;
  end;

  case BevelOuter of
   bvNone:IP:=0;
   bvLowered:begin
    IP:=MyBevelWidth;
    Frame3DBorder(BufferBitmap.Canvas,ClientRect,FColorBorder,FColorBorder,MyBevelWidth);
   end;
   bvRaised:begin
    IP:=MyBevelWidth;
    Frame3DBorder(BufferBitmap.Canvas,ClientRect,FColorBorder,FColorBorder,MyBevelWidth);
   end;
   bvSpace:begin
    IP:=MyBevelWidth;
   end;
   else IP:=0;
  end;

  case BevelInner of
   bvLowered:begin
    Frame3DBorder(BufferBitmap.Canvas,RECT(ClientRect.Left+IP,ClientRect.Top+IP,ClientRect.Right-IP,ClientRect.Bottom-IP),FColorBorder,FColorBorder,MyBevelWidth);
   end;
   bvRaised:begin
    Frame3DBorder(BufferBitmap.Canvas,RECT(ClientRect.Left+IP,ClientRect.Top+IP,ClientRect.Right-IP,ClientRect.Bottom-IP),FColorBorder,FColorBorder,MyBevelWidth);
   end;
  end;

  BufferBitmap.Canvas.Font.Assign(self.Font);
  BufferBitmap.Canvas.Brush.Style:=bsClear;
  if Enabled then begin
   DrawText(BufferBitmap.Canvas.Handle,pchar(Caption),length(Caption),TextBounds,Format);
  end else begin
   OffsetRect(TextBounds,1,1);
   BufferBitmap.Canvas.Font.Color:=clBtnHighlight;
   DrawText(BufferBitmap.Canvas.Handle,pchar(Caption),length(Caption),TextBounds,Format);
   OffsetRect(TextBounds,-1,-1);
   BufferBitmap.Canvas.Font.Color:=clBtnShadow;
   DrawText(BufferBitmap.Canvas.Handle,pchar(Caption),length(Caption),TextBounds,Format);
  end;

  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 except
 end;
end;

procedure TSGTK0Panel.CMEnabledChanged(var message:TMessage);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Panel.CMTextChanged(var message:TWmNoParams);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

constructor TCustomSGTK0Edit.Create(AOwner:TComponent);
begin
 inherited;
 ParentFont:=true;
 FFocusedColor:=clrEditListFocused;
 FBorderColor:=clrBorder;
 FBackColor:=clrEditListBack;
 FParentColor:=false;
 AutoSize:=false;
 Ctl3D:=false;
 BorderStyle:=bsNone;
 ControlStyle:=ControlStyle-[csFramed];
 SetBounds(0,0,121,19);
end;

procedure TCustomSGTK0Edit.SetParentColor(Value:boolean);
begin
 if Value<>FParentColor then begin
  FParentColor:=Value;
  if FParentColor then begin
   if assigned(Parent) then FBackColor:=TForm(Parent).Color;
   RedrawBorder(0);
  end;
 end;
end;

procedure TCustomSGTK0Edit.CMSysColorChange(var message:TMessage);
begin
 if FParentColor and assigned(Parent) then begin
  FBackColor:=TForm(Parent).Color;
 end;
 RedrawBorder(0);
end;

procedure TCustomSGTK0Edit.CMParentColorChanged(var message:TWMNoParams);
begin
 if FParentColor and assigned(Parent) then begin
  FBackColor:=TForm(Parent).Color;
 end;
 if not SGTK0UpdateLock then begin
  RedrawBorder(0);
 end;
end;

procedure TCustomSGTK0Edit.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FFocusedColor:=Value;
  1:FBorderColor:=Value;
  2:begin
   FBackColor:=Value;
   FParentColor:=false;
  end;
 end;
 if not SGTK0UpdateLock then begin
  RedrawBorder(0);
 end;
end;

procedure TCustomSGTK0Edit.CMMouseEnter(var message:TMessage);
begin
 inherited;
 if GetActiveWindow<>0 then begin
   ButtonMouseInControl:=true;
   RedrawBorder(0);
 end;
end;

procedure TCustomSGTK0Edit.CMMouseLeave(var message:TMessage);
begin
 inherited;
 ButtonMouseInControl:=false;
 RedrawBorder(0);
end;

procedure TCustomSGTK0Edit.NewAdjustHeight;
var DC:HDC;
    SaveFont:HFONT;
    Metrics:TTextMetric;
begin
 DC:=GetDC(0);
 SaveFont:=SelectObject(DC,Font.Handle);
 GetTextMetrics(DC,Metrics);
 SelectObject(DC,SaveFont);
 ReleaseDC(0,DC);
 //Height:=Metrics.tmHeight+6;
end;

procedure TCustomSGTK0Edit.Loaded;
begin
 inherited;
 if not (csDesigning in ComponentState) then NewAdjustHeight;
end;

procedure TCustomSGTK0Edit.CMEnabledChanged(var message:TMessage);
const EnableColors:array[boolean] of TColor=(clBtnFace,clrEditListBack);
begin
 inherited;
 Color:=EnableColors[Enabled];
 RedrawBorder(0);
end;

procedure TCustomSGTK0Edit.CMFontChanged(var message:TMessage);
begin
 inherited;
 if not((csDesigning in ComponentState) and(csLoading in ComponentState)) then begin
  NewAdjustHeight;
 end;
end;

procedure TCustomSGTK0Edit.WMSetFocus(var message:TWMSetFocus);
begin
 inherited;
 if not(csDesigning in ComponentState) then RedrawBorder(0);
end;

procedure TCustomSGTK0Edit.WMKillFocus(var message:TWMKillFocus);
begin
 inherited;
 if not(csDesigning in ComponentState) then RedrawBorder(0);
end;

procedure TCustomSGTK0Edit.WMNCCalcSize(var message:TWMNCCalcSize);
begin
 inherited;
 InflateRect(message.CalcSize_Params^.rgrc[0],-3,-3);
end;

procedure TCustomSGTK0Edit.WMNCPaint(var message:TMessage);
begin
 inherited;
 RedrawBorder(HRGN(message.WParam));
end;

{procedure TCustomSGTK0Edit.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;}

procedure TCustomSGTK0Edit.RedrawBorder(const Clip:HRGN);
var DC:HDC;
    R:TRect;
    BtnFaceBrush,WindowBrush,FocusBrush:HBRUSH;
begin
 DC:=GetWindowDC(Handle);
 try
  GetWindowRect(Handle,R);
  OffsetRect(R,-R.Left,-R.Top);
  BtnFaceBrush:=CreateSolidBrush(ColorToRGB(FBorderColor));
  WindowBrush:=CreateSolidBrush(ColorToRGB(FBackColor));
  FocusBrush:=CreateSolidBrush(ColorToRGB(FFocusedColor));
  if(not(csDesigning in ComponentState) and(Focused or(ButtonMouseInControl and not(Screen.ActiveControl is TSGTK0Edit)))) then begin
   Color:=FFocusedColor;
   FrameRect(DC,R,BtnFaceBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,FocusBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,FocusBrush);
  end else begin
   Color:=FBackColor;
   FrameRect(DC,R,BtnFaceBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,WindowBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,WindowBrush);
  end;
 finally
  ReleaseDC(Handle,DC);
 end;
 DeleteObject(WindowBrush);
 DeleteObject(BtnFaceBrush);
 DeleteObject(FocusBrush);
end;

constructor TSGTK0Button.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 BufferBitmap:=TBitmap.Create;
 if ButtonMouseTimer=nil then begin
  ButtonMouseTimer:=TTimer.Create(nil);
  ButtonMouseTimer.Enabled:=false;
  ButtonMouseTimer.Interval:=100;
 end;
 SetBounds(0,0,25,25);
 ControlStyle:=[csCaptureMouse,csOpaque,csDoubleClicks];
 ParentFont:=true;
 ParentColor:=false;
 Color:=clrBack;
 FFocusedColor:=clrFocusedHighlight;
 FDownColor:=clrDown;
 FBorderColor:=clrBorder;
 FColorHighlight:=clrFocusedHighlight;
 FSpacing:=4;
 FMargin:=-1;
 FModalResult:=mrNone;
 inc(ButtonControlCounter);
end;

destructor TSGTK0Button.Destroy;
begin
 RemoveMouseTimer;
 dec(ButtonControlCounter);
 if ButtonControlCounter=0 then begin
  ButtonMouseTimer.Free;
  ButtonMouseTimer:=nil;
 end;
 BufferBitmap.Destroy;
 inherited Destroy;
end;

procedure TSGTK0Button.Resize;
begin
 inherited Resize;
 if (BufferBitmap.Width<>ClientRect.Right) or
    (BufferBitmap.Height<>ClientRect.Bottom) then begin
  BufferBitmap.Height:=0;
  BufferBitmap.Width:=ClientRect.Right;
  BufferBitmap.Height:=ClientRect.Bottom;
 end;
end;

procedure TSGTK0Button.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0Button.Paint;
var Offset:TPoint;
    X,Y:integer;
begin
 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;
  BufferBitmap.Canvas.Font.Assign(self.Font);

  if FState in [bsDown,bsExclusive] then begin
   Offset:=Point(1,1);
  end else begin
   Offset:=Point(0,0);
  end;

  if Enabled then begin
   if FState=bsDisabled then begin
    if FDown and (GroupIndex<>0) then begin
     FState:=bsExclusive;
    end else begin
     FState:=bsUp;
    end;
   end;
  end else begin
   FState:=bsDisabled;
   FDragging:=false;
  end;

  case FState of
   bsUp:begin
    if FMouseInControl then begin
     BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
    end else begin
     BufferBitmap.Canvas.Brush.Color:=self.Color;
    end;
   end;
   bsDown:BufferBitmap.Canvas.Brush.Color:=FDownColor;
   bsExclusive:begin
    if FMouseInControl then begin
     BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
    end else begin
     BufferBitmap.Canvas.Brush.Color:=FDownColor;
    end;
   end;
   bsDisabled:BufferBitmap.Canvas.Brush.Color:=self.Color;
  end;
  BufferBitmap.Canvas.FillRect(ClientRect);

  case FState of
   bsUp:begin
    if FMouseInControl then begin
     Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
    end else begin
     if FDefault then begin
      Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,2);
     end else begin
      Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
     end;
    end;
   end;
   bsDown,bsExclusive:Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
   bsDisabled:Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
  end;
  
  BufferBitmap.Canvas.Brush.Style:=bsClear;
  if FState=bsDisabled then begin
  end;
  X:=ClientRect.Left+(((ClientRect.Right-ClientRect.Left)-BufferBitmap.Canvas.TextWidth(Caption)) div 2);
  Y:=ClientRect.Top+(((ClientRect.Bottom-ClientRect.Top)-BufferBitmap.Canvas.TextHeight(Caption)) div 2);
  BufferBitmap.Canvas.TextRect(ClientRect,X,Y,Caption);

  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 except
 end;
end;

procedure TSGTK0Button.UpdateTracking;
var P:TPoint;
begin
 if Enabled then begin
  GetCursorPos(P);
  FMouseInControl:=FindDragTarget(P,true)<>self;
  if FMouseInControl then begin
   MouseLeave;
  end else begin
   MouseEnter;
  end;
 end;
end;

procedure TSGTK0Button.Loaded;
begin
 inherited Loaded;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
begin
 inherited MouseDown(Button,Shift,X,Y);
 if (Button=mbLeft) and Enabled then begin
  if not FDown then begin
   FState:=bsDown;
   if not SGTK0UpdateLock then begin
    Invalidate;
   end;
  end;
  FDragging:=true;
  SetFocus;
 end;
end;

procedure TSGTK0Button.MouseMove(Shift:TShiftState;X,Y:integer);
var NewState:TButtonState;
    P:TPoint;
begin
 inherited;

 P:=ClientToScreen(Point(X,Y));
 if(ButtonMouseInControl<>self) and (FindDragTarget(P,true)=self) then begin
  if assigned(ButtonMouseInControl) then ButtonMouseInControl.MouseLeave;
  if(GetActiveWindow<>0) then begin
   if ButtonMouseTimer.Enabled then ButtonMouseTimer.Enabled:=false;
   ButtonMouseInControl:=self;
   ButtonMouseTimer.OnTimer:=MouseTimerHandler;
   ButtonMouseTimer.Enabled:=true;
   MouseEnter;
  end;
 end;

 if FDragging then begin
  if FDown then begin
   NewState:=bsExclusive;
  end else begin
   NewState:=bsUp
  end;
  if (X>=0) and (X<ClientWidth) and (Y>=0) and (Y<=ClientHeight) then begin
   if FDown then begin
    NewState:=bsExclusive;
   end else begin
    NewState:=bsDown;
   end;
  end;
  if NewState<>FState then begin
   FState:=NewState;
   if not SGTK0UpdateLock then begin
    Invalidate;
   end;
  end;
 end;
end;

procedure TSGTK0Button.MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
var DoClick:boolean;
begin
 inherited MouseUp(Button,Shift,X,Y);
 if FDragging then begin
  FDragging:=false;
  DoClick:=(X>=0) and (X<ClientWidth) and (Y>=0) and (Y<=ClientHeight);
  if FGroupIndex=0 then begin
   FState:=bsUp;
   FMouseInControl:=false;
   if DoClick and not(FState in [bsExclusive,bsDown]) then begin
    if not SGTK0UpdateLock then begin
     Invalidate;
    end;
   end;
  end else begin
   if DoClick then begin
    SetDown(not FDown);
    if FDown then Repaint;
   end else begin
    if FDown then FState:=bsExclusive;
    Repaint;
   end;
  end;
  if DoClick then begin
   Click
  end else begin
   MouseLeave;
  end;
  UpdateTracking;
 end;
end;

procedure TSGTK0Button.Click;
begin
 if Parent<>nil then GetParentForm(self).ModalResult:=FModalResult;
 inherited Click;
end;

procedure TSGTK0Button.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FFocusedColor:=Value;
  1:FDownColor:=Value;
  2:FBorderColor:=Value;
  3:FColorHighlight:=Value;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.UpdateExclusive;
var Msg:TMessage;
begin
 if (FGroupIndex<>0) and assigned(Parent) then begin
  Msg.Msg:=CM_BUTTONPRESSED;
  Msg.WParam:=FGroupIndex;
  Msg.LParam:=longint(self);
  Msg.result:=0;
  Parent.Broadcast(Msg);
 end;
end;

procedure TSGTK0Button.SetDown(Value:boolean);
begin
 if FGroupIndex=0 then Value:=false;
 if Value<>FDown then begin
  if FDown and not FAllowAllUp then exit;
  FDown:=Value;
  if Value then begin
   if FState=bsUp then begin
    if not SGTK0UpdateLock then begin
     Invalidate;
    end;
   end;
   FState:=bsExclusive
  end else begin
   FState:=bsUp;
   Repaint;
  end;
  if Value then UpdateExclusive;
 end;
end;

procedure TSGTK0Button.SetGroupIndex(Value:integer);
begin
 if FGroupIndex<>Value then begin
  FGroupIndex:=Value;
  UpdateExclusive;
 end;
end;

procedure TSGTK0Button.SetMargin(Value:integer);
begin
 if (Value<>FMargin) and (Value>=-1) then begin
  FMargin:=Value;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.SetSpacing(Value:integer);
begin
 if Value<>FSpacing then begin
  FSpacing:=Value;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.SetAllowAllUp(Value:boolean);
begin
 if FAllowAllUp<>Value then begin
  FAllowAllUp:=Value;
  UpdateExclusive;
 end;
end;

procedure TSGTK0Button.WMLButtonDblClk(var message:TWMLButtonDown);
begin
  inherited;
  if FDown then DblClick;
end;

procedure TSGTK0Button.CMEnabledChanged(var message:TMessage);
begin
 inherited;
 if not Enabled then begin
  FMouseInControl:=false;
  FState:=bsDisabled;
  RemoveMouseTimer;
 end;
 UpdateTracking;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.CMButtonPressed(var message:TMessage);
var Sender:TSGTK0Button;
begin
 if message.WParam=FGroupINDEX then begin
  Sender:=TSGTK0Button(message.LParam);
  if Sender<>self then begin
   if Sender.Down and FDown then begin
    FDown:=false;
    FState:=bsUp;
    if not SGTK0UpdateLock then begin
     Invalidate;
    end;
   end;
   FAllowAllUp:=Sender.AllowAllUp;
  end;
 end;
end;

procedure TSGTK0Button.CMDialogChar(var message:TCMDialogChar);
begin
 with message do begin
  if IsAccel(CharCode,Caption) and Enabled then begin
   if GroupIndex<>0 then SetDown(true);
   Click;
   result:=1;
  end;
 end;
end;

procedure TSGTK0Button.CMFontChanged(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.CMTextChanged(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.CMSysColorChange(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.CMParentColorChanged(var message:TWMNoParams);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.MouseEnter;
begin
 if Enabled and not FMouseInControl then begin
  FMouseInControl:=true;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.MouseLeave;
begin
 if Enabled and FMouseInControl and not FDragging then begin
  FMouseInControl:=false;
  RemoveMouseTimer;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.MouseTimerHandler(Sender:TObject);
var P:TPoint;
begin
 GetCursorPos(P);
 if FindDragTarget(P,true)<>self then MouseLeave;
end;

procedure TSGTK0Button.RemoveMouseTimer;
begin
 if ButtonMouseInControl=self then begin
  ButtonMouseTimer.Enabled:=false;
  ButtonMouseInControl:=nil;
 end;
end;

procedure TSGTK0Button.SetDefault(const Value:boolean);
var Form:TCustomForm;
begin
 FDefault:=Value;
 if HandleAllocated then begin
  Form:=GetParentForm(self);
  if assigned(Form) then begin
   Form.Perform(CM_FOCUSCHANGED,0,longint(Form.ActiveControl));
  end;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.WMKillFocus(var message:TWMKillFocus);
begin
 inherited;
 MouseLeave;
end;

procedure TSGTK0Button.WMSetFocus(var message:TWMSetFocus);
begin
 inherited;
 if Enabled then begin
  FMouseInControl:=true;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.WMKeyDown(var message:TWMKeyDown);
begin
 if message.CharCode=VK_SPACE then begin
  if GroupIndex=0 then begin
   FState:=bsDown;
  end else begin
   SetDown(true);
  end;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.WMKeyUp(var message:TWMKeyUp);
begin
 if message.CharCode=VK_SPACE then begin
  if GroupIndex=0 then begin
   FState:=bsUp;
  end else begin
   SetDown(false);
  end;
  Click;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0Button.WMMove(var message:TWMMove);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.WMSize(var message:TWMSize);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0Button.CMMouseEnter(var message:TMessage);
begin
 inherited;
 if assigned(FOnMouseEnter) then FOnMouseEnter(self);
end;

procedure TSGTK0Button.CMMouseLeave(var message:TMessage);
begin
 inherited;
 if assigned(FOnMouseLeave) then FOnMouseLeave(self);
end;

constructor TSGTK0ComboBox.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 ControlStyle:=(ControlStyle-[csFixedHeight])+[csOpaque];
 TControlCanvas(Canvas).Control:=self;
 FButtonWidth:=11;
 FSysBtnWidth:=GetSystemMetrics(SM_CXVSCROLL);
 FListInstance:=MakeObjectInstance(ListWndProc);
 FDefListProc:=nil;
 ItemHeight:=13;
 Color:=clrEditListBack;
 FArrowColor:=clrBorder;
 FArrowBackgroundColor:=clrBack;
 FBorderColor:=clrBorder;
end;

destructor TSGTK0ComboBox.Destroy;
begin
 FreeObjectInstance(FListInstance);
 inherited;
end;

procedure TSGTK0ComboBox.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0ComboBox.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FArrowColor:=Value;
  1:FArrowBackgroundColor:=Value;
  2:FBorderColor:=Value;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ComboBox.CMSysColorChange(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ComboBox.CMParentColorChanged(var message:TWMNoParams);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ComboBox.WndProc(var message:TMessage);
begin
 if message.Msg=WM_PARENTNOTIFY then begin
  case LoWord(message.wParam) of
   WM_CREATE:begin
    if assigned(FDefListProc) then begin
     SetWindowLong(FListHandle,GWL_WNDPROC,longint(FDefListProc));
     FDefListProc:=nil;
     FChildHandle:=message.lParam;
    end else if FChildHandle=0 then begin
     FChildHandle:=message.lParam
    end else begin
     FListHandle:=message.lParam;
    end;
   end;
   else begin
    if(message.Msg=WM_WINDOWPOSCHANGING) and (Style in [csDropDown,csSimple]) then begin
     SetWindowPos(EditHandle,0,0,0,((ClientWidth-FButtonWidth)-(2*2))-4,((Height)-(2*2))-2,SWP_NOMOVE+SWP_NOZORDER+SWP_NOACTIVATE+SWP_NOREDRAW);
    end;
   end;
  end;
 end;
 inherited;
 if message.Msg=WM_CTLCOLORLISTBOX then begin
  SetBkColor(message.wParam,ColorToRGB(Color));
  message.result:=CreateSolidBrush(ColorToRGB(Color));
 end;
end;

procedure TSGTK0ComboBox.ListWndProc(var message:TMessage);
begin
 case message.Msg of
  WM_WINDOWPOSCHANGING:begin
   with TWMWindowPosMsg(message).WindowPos^ do begin
    if Style in [csDropDown,csDropDownList] then begin
     CY:=(GetFontHeight(Font)-2)*Min(DropDownCount,Items.Count)+4;
    end else begin
     CY:=ItemHeight*Min(DropDownCount,Items.Count)+4;
    end;
    if CY<=4 then CY:=10;
   end;
  end;
  else begin
   with message do begin
    result:=CallWindowProc(FDefListProc,FListHandle,Msg,WParam,LParam);
   end;
  end;
 end;
end;

procedure TSGTK0ComboBox.ComboWndProc(var message:TMessage;ComboWnd:HWnd;ComboProc:pointer);
begin
 inherited;
 if ComboWnd=EditHandle then begin
  case message.Msg of
   WM_SETFOCUS,WM_KILLFOCUS:SetSolidBorder;
  end;
 end;
end;

procedure TSGTK0ComboBox.WMSetFocus(var message:TMessage);
begin
 inherited;
 if not(csDesigning in ComponentState) then begin
  SetSolidBorder;
  if not (Style in [csSimple,csDropDown]) then begin
   InvalidateSelection;
  end;
 end;
end;

procedure TSGTK0ComboBox.WMKillFocus(var message:TMessage);
begin
 inherited;
 if not(csDesigning in ComponentState) then begin
  SetSolidBorder;
  if not(Style in [csSimple,csDropDown]) then begin
   InvalidateSelection;
  end;
 end;
end;

procedure TSGTK0ComboBox.CMEnabledChanged(var Msg:TMessage);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ComboBox.CNCommand(var message:TWMCommand);
var R:TRect;
begin
 inherited;
 if(message.NotifyCode in [1,9,CBN_DROPDOWN,CBN_SELCHANGE]) and
    not(Style in [csSimple,csDropDown]) then begin
  InvalidateSelection;
 end;
 if message.NotifyCode in [CBN_CLOSEUP] then begin
  R:=GetButtonRect;
  dec(R.Left,2);
  InvalidateRect(Handle,@R,false);
 end;
end;

procedure TSGTK0ComboBox.WMKeyDown(var message:TMessage);
var S:string;
begin
 S:=Text;
 inherited;
 if not(Style in [csSimple,csDropDown]) and(Text<>S) then begin
  InvalidateSelection;
 end;
end;

procedure TSGTK0ComboBox.WMPaint(var message:TWMPaint);
var R:TRect;
    DC:HDC;
    PS:TPaintStruct;
begin
 if not SGTK0UpdateLock then begin
  DC:=BeginPaint(Handle,PS);
  try
   R:=PS.rcPaint;
   if R.Right>(Width-FButtonWidth-4) then begin
    R.Right:=Width-FButtonWidth-4;
   end;
   FillRect(DC,R,Brush.Handle);
   if RectInRect(GetButtonRect,PS.rcPaint) then  PaintButton;
   ExcludeClipRect(DC,ClientWidth-FSysBtnWidth-2,0,ClientWidth,ClientHeight);
   PaintWindow(DC);
   if (Style=csDropDown) and DroppedDown then begin
    R:=ClientRect;
    InflateRect(R,-2,-2);
    R.Right:=Width-FButtonWidth-3;
    Canvas.Brush.Color:=clWindow;
    Canvas.FrameRect(R);
   end else if Style<>csDropDown then begin
    InvalidateSelection;
   end;
  finally
   EndPaint(Handle,PS);
  end;
  RedrawBorders;
 end;
 message.result:=0;
end;

procedure TSGTK0ComboBox.WMNCPaint(var message:TMessage);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  RedrawBorders;
 end;
end;

procedure TSGTK0ComboBox.CMFontChanged(var message:TMessage);
begin
 inherited;
 ItemHeight:=13;
 RecreateWnd;
end;

procedure TSGTK0ComboBox.InvalidateSelection;
var R:TRect;
begin
 R:=ClientRect;
 InflateRect(R,-2,-3);
 R.Left:=R.Right-FButtonWidth-8;
 dec(R.Right,FButtonWidth+3);
 if(GetFocus=Handle) and not DroppedDown then begin
  Canvas.Brush.Color:=clHighlight
 end else begin
  Canvas.Brush.Color:=Color;
 end;
 Canvas.Brush.Style:=bsSolid;
 Canvas.FillRect(R);
 if(GetFocus=Handle) and not DroppedDown then begin
  R:=ClientRect;
  InflateRect(R,-3,-3);
  dec(R.Right,FButtonWidth+2);
  Canvas.FrameRect(R);
  Canvas.Brush.Color:=clWindow;
 end;
 ExcludeClipRect(Canvas.Handle,ClientWidth-FSysBtnWidth-2,0,ClientWidth,ClientHeight);
end;

function TSGTK0ComboBox.GetButtonRect:TRect;
begin
 GetWindowRect(Handle,result);
 OffsetRect(result,-result.Left,-result.Top);
 inc(result.Left,ClientWidth-FButtonWidth);
 OffsetRect(result,-1,0);
end;

procedure TSGTK0ComboBox.PaintButton;
var R:TRect;
    X,Y:integer;
begin
 R:=GetButtonRect;
 InflateRect(R,1,0);

 Canvas.Brush.Color:=FArrowBackgroundColor;
 Canvas.FillRect(R);
 Canvas.Brush.Color:=FBorderColor;
 Canvas.FrameRect(R);

 X:=((R.Right-R.Left) div 2)-6+R.Left;
 if DroppedDown then begin
  Y:=((R.Bottom-R.Top) div 2)-1+R.Top;
 end else begin
  Y:=((R.Bottom-R.Top) div 2)-1+R.Top;
 end;

 if Enabled then begin
  Canvas.Brush.Color:=FArrowColor;
  Canvas.Pen.Color:=FArrowColor;
  if DroppedDown then begin
   Canvas.Polygon([Point(X+4,Y+2),Point(X+8,Y+2),Point(X+6,Y)]);
  end else begin
   Canvas.Polygon([Point(X+4,Y),Point(X+8,Y),Point(X+6,Y+2)]);
  end;
 end else begin
  Canvas.Brush.Color:=clWhite;
  Canvas.Pen.Color:=clWhite;
  inc(X);
  inc(Y);
  if DroppedDown then begin
   Canvas.Polygon([Point(X+4,Y+2),Point(X+8,Y+2),Point(X+6,Y)]);
  end else begin
   Canvas.Polygon([Point(X+4,Y),Point(X+8,Y),Point(X+6,Y+2)]);
  end;
  dec(X);
  dec(Y);
  Canvas.Brush.Color:=clGray;
  Canvas.Pen.Color:=clGray;
  if DroppedDown then begin
   Canvas.Polygon([Point(X+4,Y+2),Point(X+8,Y+2),Point(X+6,Y)]);
  end else begin
   Canvas.Polygon([Point(X+4,Y),Point(X+8,Y),Point(X+6,Y+2)]);
  end;
 end;
 ExcludeClipRect(Canvas.Handle,ClientWidth-FSysBtnWidth,0,ClientWidth,ClientHeight);
end;

procedure TSGTK0ComboBox.PaintBorder;
var DC:HDC;
    R:TRect;
    BtnFaceBrush,WindowBrush:HBRUSH;
begin
 DC:=GetWindowDC(Handle);
 GetWindowRect(Handle,R);
 OffsetRect(R,-R.Left,-R.Top);
 dec(R.Right,FButtonWidth+1);
 try
  BtnFaceBrush:=CreateSolidBrush(ColorToRGB(FBorderColor));
  WindowBrush:=CreateSolidBrush(ColorToRGB(Color));
  FrameRect(DC,R,BtnFaceBrush);
  InflateRect(R,-1,-1);
  FrameRect(DC,R,WindowBrush);
  InflateRect(R,-1,-1);
  FrameRect(DC,R,WindowBrush);
 finally
  ReleaseDC(Handle,DC);
 end;
 DeleteObject(WindowBrush);
 DeleteObject(BtnFaceBrush);
end;

function TSGTK0ComboBox.GetSolidBorder:boolean;
begin
 result:=((csDesigning in ComponentState) and Enabled) or(not(csDesigning in ComponentState) and(DroppedDown or(GetFocus=Handle) or(GetFocus=EditHandle)));
end;

procedure TSGTK0ComboBox.SetSolidBorder;
var Value:boolean;
begin
 Value:=GetSolidBorder;
 if Value<>FSolidBorder then begin
  FSolidBorder:=Value;
  RedrawBorders;
 end;
end;

procedure TSGTK0ComboBox.RedrawBorders;
begin
 PaintBorder;
 if Style<>csSimple then PaintButton;
end;

procedure TSGTK0CheckBox.CMDesignHitTest(var message:TCMDesignHitTest);
begin
 if PtInRect(Rect(ClientRect.Left+1,ClientRect.Top+3,ClientRect.Left+12,ClientRect.Top+14),Point(message.XPos,message.YPos)) then begin
  message.result:=1
 end else begin
  message.result:=0;
 end;
end;

constructor TSGTK0CheckBox.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 BufferBitmap:=TBitmap.Create;
 if not assigned(CheckBoxMouseTimer) then begin
  CheckBoxMouseTimer:=TTimer.Create(nil);
  CheckBoxMouseTimer.Enabled:=false;
  CheckBoxMouseTimer.Interval:=100;
 end;
 ParentColor:=false;
 ParentFont:=true;
 FFocusedColor:=clrFocusedHighlight;
 Color:=clrBack;
 FDownColor:=clrDown;
 FCheckColor:=clrBorder;
 FBorderColor:=clrBorder;
 TabStop:=true;
 FChecked:=false;
 Enabled:=true;
 Visible:=true;
 SetBounds(0,0,121,17);
 inc(CheckBoxControlCounter);
end;

destructor TSGTK0CheckBox.Destroy;
begin
 RemoveMouseTimer;
 dec(CheckBoxControlCounter);
 if CheckBoxControlCounter=0 then begin
  CheckBoxMouseTimer.Free;
  CheckBoxMouseTimer:=nil;
 end;
 BufferBitmap.Free;
 inherited Destroy;
end;

procedure TSGTK0CheckBox.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FFocusedColor:=Value;
  1:FDownColor:=Value;
  2:FCheckColor:=Value;
  3:FBorderColor:=Value;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0CheckBox.SetChecked(Value:boolean);
begin
 if FChecked<>Value then begin
  FChecked:=Value;
  Click;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
  if csDesigning in ComponentState then begin
   if assigned(GetParentForm(self)) and assigned(GetParentForm(self).Designer) then begin
    GetParentForm(self).Designer.ModIFied;
   end;
  end;
 end;
end;

procedure TSGTK0CheckBox.CMEnabledChanged(var message:TMessage);
begin
 inherited;
 if not Enabled then begin
  FMouseInControl:=false;
  MouseIsDown:=false;
  RemoveMouseTimer;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0CheckBox.CMTextChanged(var message:TWmNoParams);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0CheckBox.MouseEnter;
begin
 if Enabled and not FMouseInControl then begin
  FMouseInControl:=true;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 end;
end;

procedure TSGTK0CheckBox.MouseLeave;
begin
 if Enabled and FMouseInControl and not MouseIsDown then begin
  FMouseInControl:=false;
  RemoveMouseTimer;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 end;
end;

procedure TSGTK0CheckBox.CMDialogChar(var message:TCMDialogChar);
begin
 with message do begin
  if IsAccel(message.CharCode,Caption) and CanFocus then begin
   SetFocus;
   Checked:=not Checked;
   result:=1;
  end else if (CharCode=VK_SPACE) and Focused then begin
   Checked:=not Checked;
  end else begin
   inherited;
  end;
 end;
end;

procedure TSGTK0CheckBox.CNCommand(var message:TWMCommand);
begin
 if message.NotIFyCode=BN_CLICKED then Click;
end;

procedure TSGTK0CheckBox.WMSetFocus(var message:TWMSetFocus);
begin
 inherited;
 if Enabled then begin
  Focused:=true;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 end;
end;

procedure TSGTK0CheckBox.WMKillFocus(var message:TWMKillFocus);
begin
 inherited;
 if Enabled then begin
  FMouseInControl:=false;
  Focused:=false;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 end;
end;

procedure TSGTK0CheckBox.CMSysColorChange(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0CheckBox.CMParentColorChanged(var message:TWMNoParams);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0CheckBox.DoEnter;
begin
 inherited DoEnter;
 Focused:=true;
 DrawCheckRect;
 Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
end;

procedure TSGTK0CheckBox.DoExit;
begin
 inherited DoExit;
 Focused:=false;
 DrawCheckRect;
 Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
end;

procedure TSGTK0CheckBox.MouseDown(Button:TMouseButton;Shift:TShIFtState;X,Y:integer);
begin
 if (Button=mbLeft) and Enabled then begin
  SetFocus;
  MouseIsDown:=true;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
  inherited MouseDown(Button,Shift,X,Y);
 end;
end;

procedure TSGTK0CheckBox.MouseUp(Button:TMouseButton;Shift:TShIFtState;X,Y:integer);
begin
 if (Button=mbLeft) and Enabled then begin
  MouseIsDown:=false;
  if FMouseInControl then Checked:=not Checked;
  DrawCheckRect;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
  inherited MouseUp(Button,Shift,X,Y);
 end;
end;

procedure TSGTK0CheckBox.MouseMove(Shift:TShIFtState;X,Y:integer);
var P:TPoint;
begin
 inherited;
 P:=ClientToScreen(Point(X,Y));
 if (CheckBoxMouseInControl<>self) and (FindDragTarget(P,true)=self) then begin
  if assigned(CheckBoxMouseInControl) then CheckBoxMouseInControl.MouseLeave;
  if GetActiveWindow<>0 then begin
   if CheckBoxMouseTimer.Enabled then CheckBoxMouseTimer.Enabled:=false;
   CheckBoxMouseInControl:=self;
   CheckBoxMouseTimer.OnTimer:=MouseTimerHandler;
   CheckBoxMouseTimer.Enabled:=true;
   MouseEnter;
  end;
 end;
end;

procedure TSGTK0CheckBox.CreateWnd;
begin
 inherited CreateWnd;
 SENDMessage(Handle,BM_SETCHECK,Cardinal(FChecked),0);
end;

procedure TSGTK0CheckBox.DrawCheckRect;
var CheckboxRect:TRect;
begin
 CheckboxRect:=Rect(ClientRect.Left+1,ClientRect.Top+3,ClientRect.Left+12,ClientRect.Top+14);
 BufferBitmap.Canvas.Pen.style:=psSolid;
  BufferBitmap.Canvas.Pen.width:=1;
 if Focused or FMouseInControl then begin
  if MouseIsDown then begin
   BufferBitmap.Canvas.Brush.Color:=FDownColor;
   BufferBitmap.Canvas.Brush.Color:=FDownColor;
  end else begin
   BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
   BufferBitmap.Canvas.Pen.Color:=FFocusedColor;
  end;
 end else begin
  BufferBitmap.Canvas.Brush.Color:=Color;
  BufferBitmap.Canvas.Pen.Color:=Color;
 end;
 BufferBitmap.Canvas.FillRect(CheckboxRect);
 if Checked then begin
  if Enabled then begin
   BufferBitmap.Canvas.Pen.Color:=FCheckColor;
  end else begin
   BufferBitmap.Canvas.Pen.Color:=clBtnShadow;
  end;
  BufferBitmap.Canvas.penpos:=Point(CheckboxRect.Left+2,CheckboxRect.Top+4);
  BufferBitmap.Canvas.lineto(CheckboxRect.Left+6,CheckboxRect.Top+8);
  BufferBitmap.Canvas.penpos:=Point(CheckboxRect.Left+2,CheckboxRect.Top+5);
  BufferBitmap.Canvas.lineto(CheckboxRect.Left+5,CheckboxRect.Top+8);
  BufferBitmap.Canvas.penpos:=Point(CheckboxRect.Left+2,CheckboxRect.Top+6);
  BufferBitmap.Canvas.lineto(CheckboxRect.Left+5,CheckboxRect.Top+9);
  BufferBitmap.Canvas.penpos:=Point(CheckboxRect.Left+8,CheckboxRect.Top+2);
  BufferBitmap.Canvas.lineto(CheckboxRect.Left+4,CheckboxRect.Top+6);
  BufferBitmap.Canvas.penpos:=Point(CheckboxRect.Left+8,CheckboxRect.Top+3);
  BufferBitmap.Canvas.lineto(CheckboxRect.Left+4,CheckboxRect.Top+7);
  BufferBitmap.Canvas.penpos:=Point(CheckboxRect.Left+8,CheckboxRect.Top+4);
  BufferBitmap.Canvas.lineto(CheckboxRect.Left+5,CheckboxRect.Top+7);
 end;
 BufferBitmap.Canvas.Brush.Color:=FBorderColor;
 BufferBitmap.Canvas.FrameRect(CheckboxRect);
end;

procedure TSGTK0CheckBox.DrawCheckText;
var TextBounds:TRect;
    Format:longword;
begin
 Format:=DT_WORDBREAK;
 TextBounds:=Rect(ClientRect.Left+16,ClientRect.Top+1,ClientRect.Right-1,ClientRect.Bottom-1);
 Format:=Format or DT_LEFT;
 with BufferBitmap.Canvas do begin
  Brush.Style:=bsClear;
  Font.Assign(self.Font);
  if Enabled then begin
   DrawText(Handle,pchar(Caption),length(Caption),TextBounds,Format);
  end else begin
   OffsetRect(TextBounds,1,1);
   Font.Color:=clBtnHighlight;
   DrawText(Handle,pchar(Caption),length(Caption),TextBounds,Format);
   OffsetRect(TextBounds,-1,-1);
   Font.Color:=clBtnShadow;
   DrawText(Handle,pchar(Caption),length(Caption),TextBounds,Format);
  end;
 end;
end;

procedure TSGTK0CheckBox.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0CheckBox.Paint;
begin
 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;

  BufferBitmap.Canvas.Brush.Color:=self.Color;
  BufferBitmap.Canvas.FillRect(ClientRect);

  DrawCheckRect;
  DrawCheckText;

  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 except
 end;
end;

procedure TSGTK0CheckBox.MouseTimerHandler(Sender:TObject);
var P:TPoint;
begin
 GetCursorPos(P);
 if FindDragTarget(P,true)<>self then MouseLeave;
end;

procedure TSGTK0CheckBox.RemoveMouseTimer;
begin
 if CheckBoxMouseInControl=self then begin
  CheckBoxMouseTimer.Enabled:=false;
  CheckBoxMouseInControl:=nil;
 end;
end;

procedure TSGTK0CheckBox.WMMove(var message:TWMMove);
begin
 inherited;
end;

procedure TSGTK0CheckBox.WMSize(var message:TWMSize);
begin
 inherited;
end;

procedure TSGTK0CheckBox.SetBiDiMode(Value:TBiDiMode);
begin
 inherited;
end;

constructor TSGTK0ScrollbarThumb.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
end;

procedure TSGTK0ScrollbarThumb.Paint;
var Offset:TPoint;
    X,Y:integer;
    c:TColor;
begin
 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;
  BufferBitmap.Canvas.Font.Assign(self.Font);

  if FState in [bsDown,bsExclusive] then begin
   Offset:=Point(1,1);
  end else begin
   Offset:=Point(0,0);
  end;

  if Enabled then begin
   if FState=bsDisabled then begin
    if FDown and (GroupIndex<>0) then begin
     FState:=bsExclusive;
    end else begin
     FState:=bsUp;
    end;
   end;
  end else begin
   FState:=bsDisabled;
   FDragging:=false;
  end;

  case FState of
   bsUp:begin
    if FMouseInControl then begin
     BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
    end else begin
     BufferBitmap.Canvas.Brush.Color:=self.Color;
    end;
   end;
   bsDown:BufferBitmap.Canvas.Brush.Color:=FDownColor;
   bsExclusive:begin
    if FMouseInControl then begin
     BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
    end else begin
     BufferBitmap.Canvas.Brush.Color:=FDownColor;
    end;
   end;
   bsDisabled:BufferBitmap.Canvas.Brush.Color:=self.Color;
  end;
  BufferBitmap.Canvas.FillRect(ClientRect);

  case FState of
   bsUp:begin
    if FMouseInControl then begin
     Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
    end else begin
     if FDefault then begin
      Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,2);
     end else begin
      Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
     end;
    end;
   end;
   bsDown,bsExclusive:Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
   bsDisabled:Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
  end;
  
  BufferBitmap.Canvas.Brush.Style:=bsClear;
  if FState=bsDisabled then begin
  end;
  X:=ClientRect.Left+(((ClientRect.Right-ClientRect.Left)-BufferBitmap.Canvas.TextWidth(Caption)) div 2);
  Y:=ClientRect.Top+(((ClientRect.Bottom-ClientRect.Top)-BufferBitmap.Canvas.TextHeight(Caption)) div 2);
  BufferBitmap.Canvas.TextRect(ClientRect,X,Y,Caption);

  if Owner is TSGTK0ScrollbarTrack then begin
   if length(TSGTK0ScrollbarTrack(Owner).Caption)>0 then begin
    c:=self.color;
    case FState of
     bsUp:begin
      if FMouseInControl then begin
       c:=self.Color;//FFocusedColor;
      end else begin
       c:=FFocusedColor;//SELF.Color;
      end;
     end;
     bsDown:c:=self.Color;//FDownColor;
     bsExclusive:begin
      if FMouseInControl then begin
       c:=self.Color;//FFocusedColor;
      end else begin
       c:=self.Color;//FDownColor;
      end;
     end;
     bsDisabled:c:=FFocusedColor; //SELF.Color;
    end;
    BufferBitmap.Canvas.Brush.Style:=bsClear;
    Font.Color:=c;
    if TSGTK0ScrollbarTrack(Owner).Kind=sbVertical then begin
     BufferBitmap.Canvas.TextRect(ClientRect,(TSGTK0ScrollbarTrack(Owner).Width-BufferBitmap.Canvas.TextWidth(TSGTK0ScrollbarTrack(Owner).Caption)) div 2,((TSGTK0ScrollbarTrack(Owner).Height-BufferBitmap.Canvas.TextHeight(TSGTK0ScrollbarTrack(Owner).Caption)) div 2)-Top,TSGTK0ScrollbarTrack(Owner).Caption);
    end else begin
     BufferBitmap.Canvas.TextRect(ClientRect,((TSGTK0ScrollbarTrack(Owner).Width-BufferBitmap.Canvas.TextWidth(TSGTK0ScrollbarTrack(Owner).Caption)) div 2)-Left,(TSGTK0ScrollbarTrack(Owner).Height-BufferBitmap.Canvas.TextHeight(TSGTK0ScrollbarTrack(Owner).Caption)) div 2,TSGTK0ScrollbarTrack(Owner).Caption);
    end;
    BufferBitmap.Canvas.Brush.Style:=bsSolid;
   end;
  end;

  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 except
 end;
end;

procedure TSGTK0ScrollbarThumb.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0ScrollbarThumb.MouseMove(Shift:TShIFtState;X,Y:integer);
var iTop:integer;
begin
 if TSGTK0ScrollbarTrack(Parent).Kind=sbVertical then begin
  FTopLimit:=0;
  FBottomLimit:=TSGTK0ScrollbarTrack(Parent).Height;
  if FDown then begin
   iTop:=Top+Y-FOldY;
   if iTop<FTopLimit then iTop:=FTopLimit;
   if (iTop>FBottomLimit) or ((iTop+Height)>FBottomLimit) then begin
    iTop:=FBottomLimit-Height;
   end;
   Top:=iTop;
  end;
 end else begin
  FTopLimit:=0;
  FBottomLimit:=TSGTK0ScrollbarTrack(Parent).Width;
  if FDown then begin
   iTop:=Left+X-FOldX;
   if iTop<FTopLimit then iTop:=FTopLimit;
   if (iTop>FBottomLimit) or ((iTop+Width)>FBottomLimit) then begin
    iTop:=FBottomLimit-Width;
   end;
   Left:=iTop;
  end;
 end;
 if FDown then begin
  TSGTK0ScrollbarTrack(Parent).FPosition:=TSGTK0ScrollbarTrack(Parent).PositionFromThumb;
  TSGTK0ScrollbarTrack(Parent).DoPositionChange;
 end;
 inherited MouseMove(Shift,X,Y);
end;

procedure TSGTK0ScrollbarThumb.MouseUp(Button:TMouseButton;Shift:TShIFtState;X,Y:integer);
begin
 FDown:=false;
 inherited MouseUp(Button,Shift,X,Y);
end;

procedure TSGTK0ScrollbarThumb.MouseDown(Button:TMouseButton;Shift:TShIFtState;X,Y:integer);
begin
 if (Button=mbLeft) and not FDown then FDown:=true;
 FOldX:=X;
 FOldy:=Y;
 inherited MouseDown(Button,Shift,X,Y);
 TSGTK0ScrollbarTrack(Parent).SetFocus;
end;

constructor TSGTK0ScrollbarTrack.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
// ControlStyle:=ControlStyle+[csOpaque];
//ControlStyle:=ControlStyle+[csAcceptsControls,csOpaque];
 Color:=clrBack;

 FThumb:=TSGTK0ScrollbarThumb.Create(self);
 FThumb.Color:=clrBorder;
 FThumb.ColorFocused:=clrBorder;
 FThumb.ColorDown:=clrBorder;
 FThumb.ColorBorder:=clrBorder;
 FThumb.ColorHighLight:=clrBorder;
 FThumb.Height:=17;
 InsertControl(FThumb);

 FMin:=0;
 FMax:=100;
 FSmallChange:=1;
 FLargeChange:=1;
 FPosition:=0;
 FOldPosition:=-$7fffffff;
 FOldCaption:='';
 FThumb.Left:=0;
 FThumb.Top:=ThumbFromPosition;

 Caption:='';

 BufferBitmap:=TBitmap.Create;
end;

destructor TSGTK0ScrollbarTrack.Destroy;
begin
 FThumb.Free;
 BufferBitmap.Free;
 inherited Destroy;
end;

procedure TSGTK0ScrollbarTrack.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0ScrollbarTrack.Paint;
begin
 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;
  with BufferBitmap.Canvas do begin
   Brush.Color:=Color;
   FillRect(ClientRect);
   Pen.Color:=FBorderColor;
   Pen.Style:=psSolid;
   case FKind of
    sbHorizontal:begin
     MoveTo(0,0);
     LineTo(Width,0);
     MoveTo(0,Height-1);
     LineTo(Width,Height-1);
    end;
    sbVertical:begin
     MoveTo(0,0);
     LineTo(0,Height);
     MoveTo(Width-1,0);
     LineTo(Width-1,Height);
    end;
   end;
   if length(Caption)>0 then begin
    BufferBitmap.Canvas.Font.Assign(self.Font);
    Brush.Style:=bsClear;
    BufferBitmap.Canvas.TextRect(ClientRect,(Width-TextWidth(Caption)) div 2,(Height-TextHeight(Caption)) div 2,Caption);
    Brush.Style:=bsSolid;
   end;
  end;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 except
 end;
end;

procedure TSGTK0ScrollbarTrack.SetSmallChange(Value:integer);
begin
 if Value<>FSmallChange then begin
  FSmallChange:=Value;
 end;
end;

procedure TSGTK0ScrollbarTrack.SetLargeChange(Value:integer);
begin
 if Value<>FLargeChange then begin
  FLargeChange:=Value;
 end;
end;

procedure TSGTK0ScrollbarTrack.SetMin(Value:integer);
begin
 if Value<>FMin then begin
  FMin:=Value;
  ProcessNewSize;
 end;
end;

procedure TSGTK0ScrollbarTrack.SetMax(Value:integer);
begin
 if Value<>FMax then begin
  FMax:=Value;
  ProcessNewSize;
 end;
end;

procedure TSGTK0ScrollbarTrack.SetPosition(Value:integer);
begin
 FPosition:=Value;
 if Position>Max then begin
  Position:=Max;
 end else if Position<Min then begin
  Position:=Min;
 end;
 case FKind of
  sbVertical:begin
   FThumb.Left:=0;
   FThumb.Top:=ThumbFromPosition;
  end;
  sbHorizontal:begin
   FThumb.Left:=ThumbFromPosition;
   FThumb.Top:=0;
  end;
 end;
 if (FOldPosition<>FPosition) or (FOldCaption<>Caption) then begin
  FOldPosition:=FPosition;
  FOldCaption:=Caption;
  if not SGTK0UpdateLock then begin
   Invalidate;
   FThumb.Invalidate;
  end;
 end;
end;

procedure TSGTK0ScrollbarTrack.SetKind(Value:TScrollBarKind);
begin
 if Value<>FKind then begin
  FKind:=Value;
  case FKind of
   sbVertical:FThumb.Height:=17;
   sbHorizontal:FThumb.Width:=17;
  end;
  ProcessNewSize;
 end;
 Position:=FPosition;
end;

procedure TSGTK0ScrollbarTrack.ProcessNewSize;
var ThumbSize,ThumbDiv:integer;
begin
 if FKind=sbVertical then begin
  ThumbSize:=Height;
 end else begin
  ThumbSize:=Width;
 end;
 if ThumbSize=0 then ThumbSize:=1;
 ThumbDiv:=ABS(Max-Min)+1;
 if ThumbDiv=0 then ThumbDiv:=1;
 ThumbSize:=ThumbSize div ThumbDiv;
 if ThumbSize<8 then ThumbSize:=8;
 if FKind=sbVertical then begin
  FThumb.Width:=Width;
  FThumb.Height:=ThumbSize;
  FThumb.Left:=0;
 end else begin
  FThumb.Height:=Height;
  FThumb.Width:=ThumbSize;
  FThumb.Top:=0;
 end;
end;

procedure TSGTK0ScrollbarTrack.WMSize(var message:TMessage);
begin
 ProcessNewSize;
end;

function TSGTK0ScrollbarTrack.ThumbFromPosition:integer;
var iHW,iV:integer;
begin
 iHW:=0;
 case FKind of
  sbVertical:iHW:=Height-FThumb.Height;
  sbHorizontal:iHW:=Width-FThumb.Width;
 end;
 iV:=FMax-FMin;
 if iV=0 then iV:=1;
 if FPosition<=FMin then begin
  result:=0;
 end else if FPosition>=FMax then begin
  result:=iHW;
 end else begin
  result:=(iHW*(FPosition-FMin)) div iV;
 end;
end;

function TSGTK0ScrollbarTrack.PositionFromThumb:integer;
var iHW,iPosition:integer;
begin
 iHW:=0;
 case FKind of
  sbVertical:iHW:=Height-FThumb.Height;
  sbHorizontal:iHW:=Width-FThumb.Width;
 end;
 iPosition:=0;
 case FKind of
  sbVertical:iPosition:=FThumb.Top;
  sbHorizontal:iPosition:=FThumb.Left;
 end;
 if iHW=0 then iHW:=1;
 if iPosition<=0 then begin
  result:=FMin;
 end else if iPosition>=iHW then begin
  result:=FMax;
 end else begin
  result:=((iPosition*(FMax-FMin)) div iHW)+FMin;
  if result<=FMin then begin
   result:=FMin;
  end else if result>=FMax then begin
   result:=FMax;
  end;
 end;
end;

procedure TSGTK0ScrollbarTrack.DoPositionChange;
begin
 TSGTK0Scrollbar(Parent).FPosition:=Position;
 TSGTK0Scrollbar(Parent).DoScroll;
 if (FOldPosition<>FPosition) or (FOldCaption<>Caption) then begin
  FOldPosition:=FPosition;
  FOldCaption:=Caption;
  if not SGTK0UpdateLock then begin
   Invalidate;
   FThumb.Invalidate;
  end;
 end;
end;

procedure TSGTK0ScrollbarTrack.DoThumbHighlightColor(Value:TColor);
begin
 FThumb.ColorHighlight:=Value;
end;

procedure TSGTK0ScrollbarTrack.DoThumbBorderColor(Value:TColor);
begin
 FThumb.ColorBorder:=Value;
end;

procedure TSGTK0ScrollbarTrack.DoThumbFocusedColor(Value:TColor);
begin
 FThumb.ColorFocused:=Value;
end;

procedure TSGTK0ScrollbarTrack.DoThumbDownColor(Value:TColor);
begin
 FThumb.ColorDown:=Value;
end;

procedure TSGTK0ScrollbarTrack.DoThumbColor(Value:TColor);
begin
 FThumb.Color:=Value;
end;

procedure TSGTK0ScrollbarTrack.DoHScroll(var message:TWMScroll);
var iPosition:integer;
begin
 case message.ScrollCode of
  SB_BOTTOM:Position:=Max;
  SB_LINELEFT:begin
   iPosition:=Position;
   dec(iPosition,SmallChange);
   Position:=iPosition;
  end;
  SB_LINERIGHT:begin
   iPosition:=Position;
   inc(iPosition,SmallChange);
   Position:=iPosition;
  end;
  SB_PAGELEFT:begin
   iPosition:=Position;
   dec(iPosition,LargeChange);
   Position:=iPosition;
  end;
  SB_PAGERIGHT:begin
   iPosition:=Position;
   inc(iPosition,LargeChange);
   Position:=iPosition;
  end;
  SB_THUMBPOSITION,SB_THUMBTRACK:Position:=message.POS;
  SB_TOP:Position:=Min;
 end;
 message.result:=0;
end;

procedure TSGTK0ScrollbarTrack.DoVScroll(var message:TWMScroll);
var iPosition:integer;
begin
 case message.ScrollCode of
  SB_BOTTOM:Position:=Max;
  SB_LINEUP:begin
   iPosition:=Position;
   dec(iPosition,SmallChange);
   Position:=iPosition;
  end;
  SB_LINEDOWN:begin
   iPosition:=Position;
   inc(iPosition,SmallChange);
   Position:=iPosition;
  end;
  SB_PAGEUP:begin
   iPosition:=Position;
   dec(iPosition,LargeChange);
   Position:=iPosition;
  end;
  SB_PAGEDOWN:begin
   iPosition:=Position;
   inc(iPosition,LargeChange);
   Position:=iPosition;
  end;
  SB_THUMBPOSITION,SB_THUMBTRACK:Position:=message.POS;
  SB_TOP:Position:=Min;
 end;
 message.result:=0;
end;

procedure TSGTK0ScrollbarTrack.DoEnableArrows(var message:TMessage);
begin
 case message.WParam of
  ESB_DISABLE_BOTH:begin
   TSGTK0Scrollbar(Parent).EnableBtnOne(false);
   TSGTK0Scrollbar(Parent).EnableBtnTwo(false);
  end;
  ESB_DISABLE_DOWN:begin
   if FKind=sbVertical then TSGTK0Scrollbar(Parent).EnableBtnTwo(false);
  end;
  ESB_DISABLE_LTUP:TSGTK0Scrollbar(Parent).EnableBtnOne(false);
 end;
 case message.WParam of
  ESB_DISABLE_LEFT:begin
   if FKind=sbHorizontal then TSGTK0Scrollbar(Parent).EnableBtnOne(false);
  end;
  ESB_DISABLE_RTDN:TSGTK0Scrollbar(Parent).EnableBtnTwo(false);
 end;
 case message.WParam of
  ESB_DISABLE_UP:begin
   if FKind=sbVertical then TSGTK0Scrollbar(Parent).EnableBtnOne(false);
  end;
  ESB_ENABLE_BOTH:begin
   TSGTK0Scrollbar(Parent).EnableBtnOne(true);
   TSGTK0Scrollbar(Parent).EnableBtnTwo(true);
  end;
 end;
 message.result:=1;
end;

procedure TSGTK0ScrollbarTrack.DoGetPos(var message:TMessage);
begin
 message.result:=Position;
end;

procedure TSGTK0ScrollbarTrack.DoGetRange(var message:TMessage);
begin
 message.WParam:=Min;
 message.LParam:=Max;
end;

procedure TSGTK0ScrollbarTrack.DoSetPos(var message:TMessage);
begin
 Position:=message.WParam;
end;

procedure TSGTK0ScrollbarTrack.DoSetRange(var message:TMessage);
begin
 Min:=message.WParam;
 Max:=message.LParam;
end;

procedure TSGTK0ScrollbarTrack.DoKeyDown(var message:TWMKeyDown);
var iPosition:integer;
begin
 iPosition:=Position;
 case message.CharCode of
  VK_PRIOR:dec(iPosition,LargeChange);
  VK_NEXT:inc(iPosition,LargeChange);
  VK_UP:if FKind=sbVertical then dec(iPosition,SmallChange);
  VK_DOWN:if FKind=sbVertical then inc(iPosition,SmallChange);
  VK_LEFT:if FKind=sbHorizontal then dec(iPosition,SmallChange);
  VK_RIGHT:if FKind=sbHorizontal then inc(iPosition,SmallChange);
 end;
 Position:=iPosition;
end;

constructor TSGTK0ScrollbarButton.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FTimer:=nil;
 FMode:=0;
end;

destructor TSGTK0ScrollbarButton.Destroy;
begin
 if assigned(FTimer) then begin
  FTimer.Enabled:=false;
  FTimer.Free;
  FTimer:=nil;
 end;
 inherited Destroy;
end;

procedure TSGTK0ScrollbarButton.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0ScrollbarButton.Paint;
const SizeArrow=5;
var Offset:TPoint;
begin
 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;
  BufferBitmap.Canvas.Font.Assign(self.Font);

  if FState in [bsDown,bsExclusive] then begin
   Offset:=Point(1,1);
  end else begin
   Offset:=Point(0,0);
  end;

  if Enabled then begin
   if FState=bsDisabled then begin
    if FDown and (GroupIndex<>0) then begin
     FState:=bsExclusive;
    end else begin
     FState:=bsUp;
    end;
   end;
  end else begin
   FState:=bsDisabled;
   FDragging:=false;
  end;

  case FState of
   bsUp:begin
    if FMouseInControl then begin
     BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
    end else begin
     BufferBitmap.Canvas.Brush.Color:=self.Color;
    end;
   end;
   bsDown:BufferBitmap.Canvas.Brush.Color:=FDownColor;
   bsExclusive:begin
    if FMouseInControl then begin
     BufferBitmap.Canvas.Brush.Color:=FFocusedColor;
    end else begin
     BufferBitmap.Canvas.Brush.Color:=FDownColor;
    end;
   end;
   bsDisabled:BufferBitmap.Canvas.Brush.Color:=self.Color;
  end;
  BufferBitmap.Canvas.FillRect(ClientRect);

  case FState of
   bsUp:begin
    if FMouseInControl then begin
     Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
    end else begin
     if FDefault then begin
      Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,2);
     end else begin
      Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
     end;
    end;
   end;
   bsDown,bsExclusive:Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
   bsDisabled:Frame3DBorder(BufferBitmap.Canvas,ClientRect,FBorderColor,FBorderColor,1);
  end;
  
  BufferBitmap.Canvas.Brush.Style:=bsClear;
  if FState=bsDisabled then begin
  end;

  case FMode of
   0:begin
    BufferBitmap.Canvas.MoveTo(ClientRect.Left+SizeArrow,ClientRect.Bottom-SizeArrow);
    BufferBitmap.Canvas.LineTo((ClientRect.Left+ClientRect.Right) div 2,ClientRect.Top+SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Right-SizeArrow,ClientRect.Bottom-SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Left+SizeArrow,ClientRect.Bottom-SizeArrow);
   end;
   1:begin
    BufferBitmap.Canvas.MoveTo(ClientRect.Left+SizeArrow,ClientRect.Top+SizeArrow);
    BufferBitmap.Canvas.LineTo((ClientRect.Left+ClientRect.Right) div 2,ClientRect.Bottom-SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Right-SizeArrow,ClientRect.Top+SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Left+SizeArrow,ClientRect.Top+SizeArrow);
   end;
   2:begin
    BufferBitmap.Canvas.MoveTo(ClientRect.Right-SizeArrow,ClientRect.Top+SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Left+SizeArrow,(ClientRect.Top+ClientRect.Bottom) div 2);
    BufferBitmap.Canvas.LineTo(ClientRect.Right-SizeArrow,ClientRect.Bottom-SizeArrow);
    BufferBitmap.Canvas.LIneTo(ClientRect.Right-SizeArrow,ClientRect.Top+SizeArrow);
   end;
   3:begin
    BufferBitmap.Canvas.MoveTo(ClientRect.Left+SizeArrow,ClientRect.Top+SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Right-SizeArrow,(ClientRect.Top+ClientRect.Bottom) div 2);
    BufferBitmap.Canvas.LineTo(ClientRect.Left+SizeArrow,ClientRect.Bottom-SizeArrow);
    BufferBitmap.Canvas.LineTo(ClientRect.Left+SizeArrow,ClientRect.Top+SizeArrow);
   end;
  end;

  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 except
 end;
end;

procedure TSGTK0ScrollbarButton.MouseDown(Button:TMouseButton;Shift:TShIFtState;X,Y:integer);
begin
 inherited MouseDown(Button,Shift,X,Y);
 FNewDown:=true;
 if not assigned(FTimer) then FTimer:=TTimer.Create(self);
 FTimer.Interval:=250;
 FTimer.OnTimer:=DoTimer;
 FTimer.Enabled:=true;
 if assigned(FOnDown) then FOnDown(self);
 TSGTK0Scrollbar(Parent).DoScroll;
 if assigned(GetParentForm(self)) then begin
  if not SGTK0UpdateLock then begin
   GetParentForm(self).Invalidate;
  end;
 end;
 TSGTK0Scrollbar(Parent).FTrack.SetFocus;
end;

procedure TSGTK0ScrollbarButton.MouseMove(Shift:TShIFtState;X,Y:integer);
begin
 inherited MouseMove(Shift,X,Y);
end;

procedure TSGTK0ScrollbarButton.MouseUp(Button:TMouseButton;Shift:TShIFtState;X,Y:integer);
begin
 inherited MouseUp(Button,Shift,X,Y);
 FNewDown:=false;
 if assigned(FTimer) then begin
  FTimer.Enabled:=false;
  FTimer.Free;
  FTimer:=nil;
 end;
end;

procedure TSGTK0ScrollbarButton.DoTimer(Sender:TObject);
begin
 if FNewDown then begin
  FTimer.Interval:=10;
  if assigned(FOnDown) then FOnDown(self);
  TSGTK0Scrollbar(Parent).DoScroll;
  if assigned(GetParentForm(self)) then begin
   if not SGTK0UpdateLock then begin
    GetParentForm(self).Invalidate;
   end;
  end;
 end;
end;

constructor TSGTK0Scrollbar.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 Width:=200;
 Height:=17;
 Color:=clrBack;

 FBtnOne:=TSGTK0ScrollbarButton.Create(self);
 FBtnOne.Color:=clrBack;
 FBtnOne.ColorFocused:=clrBack;
 FBtnOne.ColorDown:=clrBack;
 FBtnOne.ColorBorder:=clrBack;
 FBtnOne.OnDown:=BtnOneClick;
 FBtnOne.FMode:=2;
 InsertControl(FBtnOne);

 FBtnTwo:=TSGTK0ScrollbarButton.Create(self);
 FBtnTwo.Color:=clrBack;
 FBtnTwo.ColorFocused:=clrBack;
 FBtnTwo.ColorDown:=clrBack;
 FBtnTwo.ColorBorder:=clrBack;
 FBtnTwo.OnDown:=BtnTwoClick;
 FBtnTwo.FMode:=3;
 InsertControl(FBtnTwo);

 FTrack:=TSGTK0ScrollbarTrack.Create(self);
 FTrack.Color:=clrBack;
 FTrack.SetBounds(0,0,Width,Height);
 InsertControl(FTrack);

 Kind:=sbVertical;

 Min:=0;
 Max:=100;
 Position:=0;
 SmallChange:=1;
 LargeChange:=1;

 ButtonColor:=clrBack;
 ButtonFocusedColor:=clrFocusedHighlight;
 ButtonDownColor:=clrDown;
 ButtonBorderColor:=clrBorder;
 ButtonHighlightColor:=clrFocusedHighlight;

 ThumbColor:=clrBorder;
 ThumbFocusedColor:=clrFocusedHighlight;
 ThumbDownColor:=clrDown;
 ThumbBorderColor:=clrBorder;
 ThumbHighlightColor:=clrFocusedHighlight;
end;

destructor TSGTK0Scrollbar.Destroy;
begin
 FTrack.Free;
 FBtnOne.Free;
 FBtnTwo.Free;
 inherited Destroy;
end;

procedure TSGTK0Scrollbar.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0Scrollbar.SetSmallChange(Value:integer);
begin
 if Value<>FSmallChange then begin
  FSmallChange:=Value;
  FTrack.SmallChange:=FSmallChange;
 end;
end;

procedure TSGTK0Scrollbar.SetLargeChange(Value:integer);
begin
 if Value<>FLargeChange then begin
  FLargeChange:=Value;
  FTrack.LargeChange:=FLargeChange;
 end;
end;

procedure TSGTK0Scrollbar.SetMin(Value:integer);
begin
 if Value<>FMin then begin
  FMin:=Value;
  FTrack.Min:=FMin;
 end;
end;

procedure TSGTK0Scrollbar.SetMax(Value:integer);
begin
 if Value<>FMax then begin
  FMax:=Value;
  FTrack.Max:=FMax;
 end;
end;

procedure TSGTK0Scrollbar.SetPosition(Value:integer);
begin
 FPosition:=Value;
 if Position<Min then begin
  Position:=Min;
 end else if Position>Max then begin
  Position:=Max;
 end;
 FTrack.Position:=FPosition;
end;

procedure TSGTK0Scrollbar.SetKind(Value:TScrollBarKind);
var i:integer;
begin
 if FKind<>Value then begin
  FKind:=Value;
  FTrack.Kind:=FKind;
  if FKind=sbVertical then begin
   FBtnOne.FMode:=0;
   FBtnOne.Refresh;
   FBtnTwo.FMode:=1;
   FBtnTwo.Refresh;
  end else begin
   FBtnOne.FMode:=2;
   FBtnOne.Refresh;
   FBtnTwo.FMode:=3;
   FBtnTwo.Refresh;
  end;
  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then begin
   i:=Width;
   Width:=Height;
   Height:=i;
  end;
 end;
end;

procedure TSGTK0Scrollbar.SetButtonHighlightColor(Value:TColor);
begin
 if Value<>FButtonHighlightColor then begin
  FButtonHighlightColor:=Value;
  FBtnOne.ColorHighlight:=ButtonHighlightColor;
  FBtnTwo.ColorHighlight:=ButtonHighlightColor;
 end;
end;

procedure TSGTK0Scrollbar.SetButtonBorderColor(Value:TColor);
begin
 if Value<>FButtonBorderColor then begin
  FButtonBorderColor:=Value;
  FBtnOne.ColorBorder:=ButtonBorderColor;
  FBtnTwo.ColorBorder:=ButtonBorderColor;
 end;
end;

procedure TSGTK0Scrollbar.SetButtonFocusedColor(Value:TColor);
begin
 if Value<>FButtonFocusedColor then begin
  FButtonFocusedColor:=Value;
  FBtnOne.ColorFocused:=ButtonFocusedColor;
  FBtnTwo.ColorFocused:=ButtonFocusedColor;
 end;
end;

procedure TSGTK0Scrollbar.SetButtonDownColor(Value:TColor);
begin
 if Value<>FButtonDownColor then begin
  FButtonDownColor:=Value;
  FBtnOne.ColorDown:=ButtonDownColor;
  FBtnTwo.ColorDown:=ButtonDownColor;
 end;
end;

procedure TSGTK0Scrollbar.SetButtonColor(Value:TColor);
begin
 if Value<>FButtonColor then begin
  FButtonColor:=Value;
  FBtnOne.Color:=ButtonColor;
  FBtnTwo.Color:=ButtonColor;
 end;
end;

procedure TSGTK0Scrollbar.SetThumbHighlightColor(Value:TColor);
begin
 if Value<>FThumbHighlightColor then begin
  FThumbHighlightColor:=Value;
  FTrack.DoThumbHighlightColor(Value);
 end;
end;

procedure TSGTK0Scrollbar.SetThumbBorderColor(Value:TColor);
begin
 if Value<>FThumbBorderColor then begin
  FThumbBorderColor:=Value;
  FTrack.DoThumbBorderColor(Value);
 end;
end;

procedure TSGTK0Scrollbar.SetThumbFocusedColor(Value:TColor);
begin
 if Value<>FThumbFocusedColor then begin
  FThumbFocusedColor:=Value;
  FTrack.DoThumbFocusedColor(Value);
 end;
end;

procedure TSGTK0Scrollbar.SetThumbDownColor(Value:TColor);
begin
 if Value<>FThumbDownColor then begin
  FThumbDownColor:=Value;
  FTrack.DoThumbDownColor(Value);
 end;
end;

procedure TSGTK0Scrollbar.SetThumbColor(Value:TColor);
begin
 if Value<>FThumbColor then begin
  FThumbColor:=Value;
  FTrack.DoThumbColor(Value);
 end;
end;

procedure TSGTK0Scrollbar.BtnOneClick(Sender:TObject);
var iPosition:integer;
begin
 iPosition:=Position;
 dec(iPosition,SmallChange);
 Position:=iPosition;
end;

procedure TSGTK0Scrollbar.BtnTwoClick(Sender:TObject);
var iPosition:integer;
begin
 iPosition:=Position;
 inc(iPosition,SmallChange);
 Position:=iPosition;
end;

procedure TSGTK0Scrollbar.EnableBtnOne(Value:boolean);
begin
 FBtnOne.Enabled:=Value;
end;

procedure TSGTK0Scrollbar.EnableBtnTwo(Value:boolean);
begin
 FBtnTwo.Enabled:=Value;
end;

procedure TSGTK0Scrollbar.WMSize(var message:TWMSize);
begin
 if FKind=sbVertical then begin
  SetBounds(Left,Top,Width,Height);
  FBtnOne.SetBounds(0,0,Width,17);
  FBtnTwo.SetBounds(0,Height-17,Width,17);
  FTrack.SetBounds(0,17,Width,Height-34);
 end else begin
  SetBounds(Left,Top,Width,Height);
  FBtnOne.SetBounds(0,0,17,Height);
  FBtnTwo.SetBounds(Width-17,0,17,Height);
  FTrack.SetBounds(17,0,Width-34,Height);
 end;
 Position:=FPosition;
end;

procedure TSGTK0Scrollbar.DoScroll;
begin
 if assigned(FOnScroll) then FOnScroll(self,Position);
end;

procedure TSGTK0Scrollbar.CNHScroll(var message:TWMScroll);
begin
 FTrack.DoHScroll(message);
end;

procedure TSGTK0Scrollbar.CNVScroll(var message:TWMScroll);
begin
 FTrack.DoVScroll(message);
end;

procedure TSGTK0Scrollbar.SBMEnableArrows(var message:TMessage);
begin
 FTrack.DoEnableArrows(message);
end;

procedure TSGTK0Scrollbar.SBMGetPos(var message:TMessage);
begin
 FTrack.DoGetPos(message);
end;

procedure TSGTK0Scrollbar.SBMGetRange(var message:TMessage);
begin
 FTrack.DoGetRange(message);
end;

procedure TSGTK0Scrollbar.SBMSetPos(var message:TMessage);
begin
 FTrack.DoSetPos(message);
end;

procedure TSGTK0Scrollbar.SBMSetRange(var message:TMessage);
begin
 FTrack.DoSetRange(message);
end;

procedure TSGTK0Scrollbar.WMKeyDown(var message:TWMKeyDown);
begin
 FTrack.DoKeyDown(message);
end;

procedure TSGTK0TabControl.CMDesignHitTest(var message:TCMDesignHitTest);
begin
 if PtInRect(Rect(ClientRect.Left,ClientRect.Top,ClientRect.Right,ClientRect.Top+FTabHeight+1),Point(message.XPos,message.YPos)) then begin
  message.result:=1;
 end else begin
  message.result:=0;
 end;
end;

constructor TSGTK0TabControl.Create(AOwner:TComponent);
begin
 inherited;
 BufferBitmap:=TBitmap.Create;
 ControlStyle:=ControlStyle+[csAcceptsControls,csOpaque];
 SetBounds(Left,Top,289,193);
 FTabs:=TStringList.Create;
 FTabs.OnChange:=TabsChanged;
 FTabsRect:=TList.Create;
 FTabHeight:=16;
 FTabSpacing:=4;
 FActiveTab:=0;
 Color:=clrBack;
 FBorderColor:=clrBorder;
 FUnselectedColor:=clrBorder;
 ParentColor:=false;
 ParentFont:=true;
 FInChange:=false;
end;

destructor TSGTK0TabControl.Destroy;
begin
 FTabs.Free;
 FTabsRect.Free;
 BufferBitmap.Destroy;
 inherited;
end;

procedure TSGTK0TabControl.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0TabControl.CMSysColorChange(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.CMParentColorChanged(var message:TWMNoParams);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.Loaded;
begin
 inherited;
 SetTabRect;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.WMSize(var message:TWMSize);
begin
 inherited;
 SetTabRect;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.CMEnabledChanged(var message:TMessage);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

{PROCEDURE TSGTK0TabControl.SetTabPosition(Value:TSGTK0TabPosition);
VAR I:INTEGER;
    R:TRect;
BEGIN
 IF Value<>FTabPosition THEN BEGIN
  FOR I:=0 TO ControlCount-1 DO BEGIN
   IF Value=tpTop THEN BEGIN
    Controls[I].Top:=Controls[I].Top+TabHeight;
   END ELSE BEGIN
    Controls[I].Top:=Controls[I].Top-TabHeight;
   END;
  END;
  FTabPosition:=Value;
  SetTabRect;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
  R:=ClientRect;
  AlignControls(SELF,R);
 END;
END;    }

procedure TSGTK0TabControl.SetActiveTab(Value:integer);
begin
 if FInChange then exit;
 if assigned(FTabs) then begin
  if Value>(FTabs.Count-1) then begin
   Value:=FTabs.Count-1;
  end else if Value<0 then begin
   Value:=0;
  end;
  FActiveTab:=Value;
  if assigned(FOnTabChanged) then FOnTabChanged(self);
  FInChange:=true;
  if self is TSGTK0PageControl then begin
   TSGTK0PageControl(self).Change;
  end;
  FInChange:=false;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end else begin
  FActiveTab:=0;
 end;
 if csDesigning in ComponentState then begin
  if assigned(GetParentForm(self)) and assigned(GetParentForm(self).Designer) then begin
   GetParentForm(self).Designer.Modified;
  end;
 end;
end;

procedure TSGTK0TabControl.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FBorderColor:=Value;
  1:FUnselectedColor:=Value;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.SetTabs(Value:TStringList);
var Counter:integer;
begin
 FTabs.Assign(Value);
 if FTabs.Count=0 then begin
  FActiveTab:=0
 end else begin
  if (FTabs.Count-1)<FActiveTab then FActiveTab:=FTabs.Count-1;
  for Counter:=0 to FTabs.Count-1 do FTabs[counter]:=TRIM(FTabs[Counter]);
 end;
 SetTabRect;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.SetTabHeight(Value:integer);
var R:TRect;
begin
 if Value<0 then Value:=0;
 FTabHeight:=Value;
 SetTabRect;
 R:=ClientRect;
 AlignControls(self,R);
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.SetTabSpacing(Value:integer);
begin
 if Value<1 then Value:=1;
 FTabSpacing:=Value;
 SetTabRect;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.SetTabRect;
var TabCount:integer;
    TabRect:^TRect;
    Position:TPoint;
    CaptionTextWidth:integer;
    CaptionTextString:string;
begin
 Canvas.Font.Assign(self.Font);
 FTabsRect.Clear;
 if BidiMode=bdRightToLeft then begin
  Position:=Point(ClientRect.Right,ClientRect.Top);
 end else begin
  Position:=Point(ClientRect.Left,ClientRect.Top);
 end;
 for TabCount:=0 to FTabs.Count-1 do begin
  NEW(TabRect);
  if POS('&',FTabs[TabCount])<>0 then begin
   CaptionTextString:=FTabs[TabCount];
   DELETE(CaptionTextString,POS('&',FTabs[TabCount]),1);
   CaptionTextWidth:=Canvas.TextWidth(CaptionTextString);
  end else begin
   CaptionTextWidth:=Canvas.TextWidth(FTabs[TabCount]);
  end;
  if BidiMode=bdRightToLeft then begin
   TabRect^:=Rect(Position.X-CaptionTextWidth-20,position.Y,position.X,FTabHeight);
   position:=Point(position.X-CaptionTextWidth-20-FTabSpacing,position.Y);
  end else begin
   TabRect^:=Rect(position.X,position.Y,position.X+CaptionTextWidth+20,FTabHeight);
   position:=Point(position.X+CaptionTextWidth+20+FTabSpacing,position.Y);
  end;
  FTabsRect.Add(TabRect);
 end;
end;

procedure TSGTK0TabControl.CMDialogChar(var message:TCMDialogChar);
var CurrentTab:integer;
begin
 with message do begin
  if FTabs.Count>0 then begin
   for CurrentTab:=0 to FTabs.Count-1 do begin
    if IsAccel(CharCode,FTabs[CurrentTab]) then begin
     if FActiveTab<>CurrentTab then begin
      SetActiveTab(CurrentTab);
      SetFocus;
     end;
     result:=1;
     break;
    end;
   end;
  end else begin
   inherited;
  end;
 end;
end;

procedure TSGTK0TabControl.Resize;
begin
 inherited Resize;
 if (BufferBitmap.Width<>ClientRect.Right) or
    (BufferBitmap.Height<>ClientRect.Bottom) then begin
  BufferBitmap.Height:=0;
  BufferBitmap.Width:=ClientRect.Right;
  BufferBitmap.Height:=ClientRect.Bottom;
 end;
end;

procedure TSGTK0TabControl.Paint;
var TabCount:integer;
    TempRect:^TRect;
begin
 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;
  BufferBitmap.Canvas.Font.Assign(self.Font);
{ IF FTabs.Count>0 THEN BEGIN
   DrawParentImage(SELF,BufferBitmap.Canvas);
   END ELSE BEGIN}
   BufferBitmap.Canvas.Brush.Color:=self.Color;
   BufferBitmap.Canvas.FillRect(ClientRect);
//END;
  if FTabs.Count=0 then begin
   BufferBitmap.Canvas.Brush.Color:=FBorderColor;
   BufferBitmap.Canvas.FrameRect(ClientRect)
  end else begin
   BufferBitmap.Canvas.Pen.Color:=FBorderColor;
   TempRect:=FTabsRect.Items[FActiveTab];
   if ClientRect.Left<>TempRect^.Left then begin
    BufferBitmap.Canvas.Polyline([Point(ClientRect.Left,ClientRect.Top+FTabHeight),Point(TempRect^.Left,ClientRect.Top+FTabHeight)]);
    BufferBitmap.Canvas.Polyline([Point(TempRect^.Right-1,ClientRect.Top+FTabHeight),Point(ClientRect.Right,ClientRect.Top+FTabHeight)]);
   end else begin
    BufferBitmap.Canvas.Polyline([Point(TempRect^.Right-1,ClientRect.Top+FTabHeight),Point(ClientRect.Right,ClientRect.Top+FTabHeight)]);
   end;
   BufferBitmap.Canvas.Polyline([Point(ClientRect.Left,ClientRect.Top+FTabHeight),Point(ClientRect.Left,ClientRect.Bottom-1),Point(ClientRect.Right-1,ClientRect.Bottom-1),Point(ClientRect.Right-1,ClientRect.Top+FTabHeight)]);
  end;
  BufferBitmap.Canvas.Brush.Color:=Color;
  BufferBitmap.Canvas.FillRect(Rect(ClientRect.Left+1,ClientRect.Top+FTabHeight+1,ClientRect.Right-1,ClientRect.Bottom-1));
  for TabCount:=0 to FTabs.Count-1 do begin
   TempRect:=FTabsRect.Items[TabCount];
   BufferBitmap.Canvas.Brush.style:=bsclear;
   BufferBitmap.Canvas.Pen.Color:=clBlack;
   if TabCount=FActiveTab then begin
    BufferBitmap.Canvas.Font.Color:=self.Font.Color;
    BufferBitmap.Canvas.Brush.Color:=Color;
    BufferBitmap.Canvas.Pen.Color:=FBorderColor;
    BufferBitmap.Canvas.FillRect(Rect(TempRect^.Left,TempRect^.Top,TempRect^.Right-1,TempRect^.Bottom+1));
    BufferBitmap.Canvas.Polyline([Point(TempRect^.Left,TempRect^.Bottom),Point(TempRect^.Left,TempRect^.Top),Point(TempRect^.Right-1,TempRect^.Top),Point(TempRect^.Right-1,TempRect^.Bottom)]);
   end else begin
    BufferBitmap.Canvas.Font.Color:=Color;
    BufferBitmap.Canvas.Brush.Color:=FUnselectedColor;
    BufferBitmap.Canvas.FillRect(TempRect^);
   end;
   BufferBitmap.Canvas.Brush.Style:=bsClear;
   if (TabCount=ActiveTab) and not Enabled then begin
    BufferBitmap.Canvas.Font.Color:=FUnselectedColor;
    DrawText(BufferBitmap.Canvas.Handle,pchar(FTabs[TabCount]),length(FTabs[TabCount]),TempRect^,DT_CENTER or DT_VCENTER or DT_SINGLELINE)
   end else begin
    DrawText(BufferBitmap.Canvas.Handle,pchar(FTabs[TabCount]),length(FTabs[TabCount]),TempRect^,DT_CENTER or DT_VCENTER or DT_SINGLELINE);
   end;
  end;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect)
 except
 end;
end;

procedure TSGTK0TabControl.MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
var CursorPos:TPoint;
    CurrentTab:integer;
    CurrentRect:^TRect;
begin
 GetCursorPos(CursorPos);
 CursorPos:=ScreenToClient(CursorPos);
 if FTabs.Count>0 then begin
  for CurrentTab:=0 to FTabs.Count-1 do begin
   CurrentRect:=FTabsRect.Items[CurrentTab];
   if PtInRect(CurrentRect^,CursorPos) and (FActiveTab<>CurrentTab) then begin
    SetActiveTab(CurrentTab);
    SetFocus;
   end;
  end;
 end;
 inherited;
end;

procedure TSGTK0TabControl.AlignControls(AControl:TControl;var Rect:TRect);
begin
 SetRect(Rect,clientRect.Left+1+FBorderWidth,clientRect.Top+TabHeight+1+FBorderWidth,clientRect.Right-1-FBorderWidth,clientRect.Bottom-1-FBorderWidth);
 inherited;
end;

procedure TSGTK0TabControl.WMMove(var message:TWMMove);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.SetBiDiMode(Value:TBiDiMode);
begin
 inherited;
 SetTabRect;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.TabsChanged(Sender:TObject);
begin
 SetTabRect;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0TabControl.SetBorderWidth(const Value:integer);
var R:TRect;
begin
 if Value<>FBorderWidth then begin
  FBorderWidth:=Value;
  R:=ClientRect;
  AlignControls(self,R);
 end;
end;

constructor TSGTK0TabSheet.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 Align:=alClient;
 ControlStyle:=ControlStyle+[csAcceptsControls,csNoDesignVisible];
 Visible:=false;
 FTabVisible:=true;
 FHighlighted:=false;
end;

destructor TSGTK0TabSheet.Destroy;
begin
 if assigned(FPageControl) then begin
  if FPageControl.FUndockingPage=self then FPageControl.FUndockingPage:=nil;
  FPageControl.RemovePage(self);
 end;
 inherited Destroy;
end;

procedure TSGTK0TabSheet.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0TabSheet.DoHide;
begin
 if assigned(FOnHide) then FOnHide(self);
end;

procedure TSGTK0TabSheet.DoShow;
begin
  if assigned(FOnShow) then FOnShow(self);
end;

procedure TSGTK0TabSheet.Paint;
begin
 with Canvas do begin
  Brush.Style:=bsSolid;
  Brush.Color:=Color;
  FillRect(ClipRect);
 end;
end;

function TSGTK0TabSheet.GetPageIndex:integer;
begin
 if assigned(FPageControl) then begin
  result:=FPageControl.FPages.IndexOf(self);
 end else begin
  result:=-1;
 end;
end;

function TSGTK0TabSheet.GetTabIndex:integer;
var I:integer;
begin
 result:=0;
 if FTabShowing then begin
  for I:=0 to PageIndex-1 do begin
   if TSGTK0TabSheet(FPageControl.FPages[I]).FTabShowing then begin
    inc(result);
   end;
  end;
 end else begin
  dec(result);
 end;
end;

procedure TSGTK0TabSheet.CreateParams(var Params:TCreateParams);
begin
 inherited CreateParams(Params);
 with Params.WindowClass do begin
  Style:=Style and not (CS_HREDRAW or CS_VREDRAW);
 end;
end;

procedure TSGTK0TabSheet.ReadState(Reader:TReader);
begin
 inherited ReadState(Reader);
 if Reader.Parent is TSGTK0PageControl then begin
  PageControl:=TSGTK0PageControl(Reader.Parent);
 end;
end;

procedure TSGTK0TabSheet.SetPageControl(APageControl:TSGTK0PageControl);
begin
 if FPageControl<>APageControl then begin
  if assigned(FPageControl) then FPageControl.RemovePage(self);
  Parent:=APageControl;
  if assigned(APageControl) then APageControl.InsertPage(self);
 end;
end;

procedure TSGTK0TabSheet.SetPageIndex(Value:integer);
var I,MaxPageIndex:integer;
begin
 if assigned(FPageControl) then begin
  MaxPageIndex:=FPageControl.FPages.Count-1;
  if Value>MaxPageIndex then exit;
  I:=TabIndex;
  FPageControl.FPages.Move(PageIndex,Value);
  if I>=0 then FPageControl.MoveTab(I,TabIndex);
 end;
end;

procedure TSGTK0TabSheet.SetTabShowing(Value:boolean);
var index:integer;
begin
 if FTabShowing<>Value then begin
  if Value then begin
   FTabShowing:=true;
   FPageControl.InsertTab(self);
  end else begin
   index:=TabIndex;
   FTabShowing:=false;
   FPageControl.DeleteTab(self,index);
  end;
 end;
end;

procedure TSGTK0TabSheet.SetTabVisible(Value:boolean);
begin
 if FTabVisible<>Value then begin
  FTabVisible:=Value;
  UpdateTabShowing;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0TabSheet.UpdateTabShowing;
begin
 SetTabShowing(assigned(FPageControl) and FTabVisible);
end;

procedure TSGTK0TabSheet.CMTextChanged(var message:TMessage);
begin
 if FTabShowing then FPageControl.UpdateTab(self);
end;

procedure TSGTK0TabSheet.CMShowingChanged(var message:TMessage);
begin
 inherited;
 if Showing then begin
  try
   DoShow;
  except
   Application.HandleException(self);
  end;
 end else if not Showing then begin
  try
   DoHide;
  except
   Application.HandleException(self);
  end;
 end;
end;

procedure TSGTK0TabSheet.SetHighlighted(Value:boolean);
begin
 if not (csReading in ComponentState) then begin
//SendMessage(PageControl.Handle,TCM_HIGHLIGHTITE,TabIndex,MakeLong(WORD(Value),0));
 end;
 FHighlighted:=Value;
end;

constructor TSGTK0PageControl.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 ControlStyle:=[csAcceptsControls,csDoubleClicks,csOpaque];
 FPages:=TList.Create;
end;

destructor TSGTK0PageControl.Destroy;
var I:integer;
begin
 for I:=0 to FPages.Count-1 do TSGTK0TabSheet(FPages[I]).FPageControl:=nil;
 FPages.Free;
 inherited Destroy;
end;

procedure TSGTK0PageControl.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0PageControl.UpdateTabHighlights;
var I:integer;
begin
 for I:=0 to PageCount-1 do Pages[I].SetHighlighted(Pages[I].FHighlighted);
end;

procedure TSGTK0PageControl.Loaded;
begin
 inherited Loaded;
 UpdateTabHighlights;
end;

function TSGTK0PageControl.CanShowTab(TabIndex:integer):boolean;
begin
 result:=TSGTK0TabSheet(FPages[TabIndex]).Enabled;
end;

procedure TSGTK0PageControl.Change;
var Form:TCustomForm;
begin
 UpdateActivePage;
 if csDesigning in ComponentState then begin
  Form:=GetParentForm(self);
  if assigned(Form) and assigned(Form.Designer) then begin
   Form.Designer.Modified;
  end;
  if assigned(Form) then begin
   if not SGTK0UpdateLock then begin
    Form.Invalidate;
   end;
  end;
 end;
//inherited Change;
end;

procedure TSGTK0PageControl.ChangeActivePage(Page:TSGTK0TabSheet);
var ParentForm:TCustomForm;
begin
 if FActivePage<>Page then begin
  ParentForm:=GetParentForm(self);
  if assigned(ParentForm) and assigned(FActivePage) and
     FActivePage.ContainsControl(ParentForm.ActiveControl) then begin
   ParentForm.ActiveControl:=FActivePage;
   if ParentForm.ActiveControl<>FActivePage then begin
    ActiveTab:=FActivePage.TabIndex;
    exit;
   end;
  end;
  if assigned(Page) then begin
   Page.BringToFront;
   Page.Visible:=true;
   if assigned(ParentForm) and assigned(FActivePage) and
     (ParentForm.ActiveControl=FActivePage) then begin
    if Page.CanFocus then begin
     ParentForm.ActiveControl:=Page;
    end else begin
     ParentForm.ActiveControl:=self;
    end;
   end;
  end;
  if assigned(FActivePage) then FActivePage.Visible:=false;
  FActivePage:=Page;
  if assigned(ParentForm) and assigned(FActivePage) and
     (ParentForm.ActiveControl=FActivePage) then begin
   FActivePage.SelectFirst;
  end;
 end;
end;

procedure TSGTK0PageControl.DeleteTab(Page:TSGTK0TabSheet;index:integer);
var UpdateIndex:boolean;
begin
 UpdateIndex:=Page=ActivePage;
 Tabs.Delete(index);
 if UpdateIndex then begin
  if index>=Tabs.Count then index:=Tabs.Count-1;
  ActiveTab:=index;
 end;
 UpdateActivePage;
end;

procedure TSGTK0PageControl.DoAddDockClient(Client:TControl; const ARect:TRect);
begin
 if assigned(FNewDockSheet) then Client.Parent:=FNewDockSheet;
end;

procedure TSGTK0PageControl.DockOver(Source:TDragDockObject; X,Y:integer;
  State:TDragState; var Accept:boolean);
var R:TRect;
begin
 GetWindowRect(Handle,R);
 Source.DockRect:=R;
 DoDockOver(Source,X,Y,State,Accept);
end;

procedure TSGTK0PageControl.DoRemoveDockClient(Client:TControl);
begin
 if assigned(FUndockingPage) and not (csDestroying in ComponentState) then begin
  SelectNextPage(true);
  FUndockingPage.Free;
  FUndockingPage:=nil;
 end;
end;

function TSGTK0PageControl.FindNextPage(CurPage:TSGTK0TabSheet;GoForward,CheckTabVisible:boolean):TSGTK0TabSheet;
var I,StartIndex:integer;
begin
 if FPages.Count<>0 then begin
  StartIndex:=FPages.IndexOf(CurPage);
  if StartIndex=-1 then begin
   if GoForward then begin
    StartIndex:=FPages.Count-1;
   end else begin
    StartIndex:=0;
   end;
  end;
  I:=StartIndex;
  repeat
   if GoForward then begin
    inc(I);
    if I=FPages.Count then I:=0;
   end else begin
    if I=0 then I:=FPages.Count;
    dec(I);
   end;
   result:=FPages[I];
   if not CheckTabVisible or result.TabVisible then exit;
  until I=StartIndex;
 end;
 result:=nil;
end;

procedure TSGTK0PageControl.GetChildren(Proc:TGetChildProc; Root:TComponent);
var I:integer;
begin
 for I:=0 to FPages.Count-1 do Proc(TComponent(FPages[I]));
end;

function TSGTK0PageControl.GetPageFromDockClient(Client:TControl):TSGTK0TabSheet;
var I:integer;
begin
 result:=nil;
 for I:=0 to PageCount-1 do begin
  if (Client.Parent=Pages[I]) and (Client.HostDockSite=self) then begin
   result:=Pages[I];
   exit;
  end;
 end;
end;

function TSGTK0PageControl.GetPage(index:integer):TSGTK0TabSheet;
begin
 result:=FPages[index];
end;

function TSGTK0PageControl.GetPageCount:integer;
begin
 result:=FPages.Count;
end;

procedure TSGTK0PageControl.GetSiteInfo(Client:TControl;var InfluenceRect:TRect;MousePos:TPoint;var CanDock:boolean);
begin
 CanDock:=GetPageFromDockClient(Client)=nil;
 inherited GetSiteInfo(Client,InfluenceRect,MousePos,CanDock);
end;

procedure TSGTK0PageControl.InsertPage(Page:TSGTK0TabSheet);
begin
 if FPages.IndexOf(Page)<0 then begin
  FPages.Add(Page);
  Page.FPageControl:=self;
  Page.UpdateTabShowing;
 end;
end;

procedure TSGTK0PageControl.InsertTab(Page:TSGTK0TabSheet);
var I:integer;
begin
 if Tabs.IndexOfObject(Page)<0 then begin
  I:=Tabs.IndexOf(Page.Caption);
  if I>=0 then Tabs.Delete(I);
  Tabs.InsertObject(Page.TabIndex,Page.Caption,Page);
  UpdateActivePage;
 end;
end;

procedure TSGTK0PageControl.MoveTab(CurIndex,NewIndex:integer);
begin
 Tabs.Move(CurIndex,NewIndex);
end;

procedure TSGTK0PageControl.RemovePage(Page:TSGTK0TabSheet);
var NextSheet:TSGTK0TabSheet;
begin
 NextSheet:=FindNextPage(Page,true,not (csDesigning in ComponentState));
 if NextSheet=Page then NextSheet:=nil;
 Page.SetTabShowing(false);
 Page.FPageControl:=nil;
 FPages.Remove(Page);
 SetActivePage(NextSheet);
end;

procedure TSGTK0PageControl.SelectNextPage(GoForward:boolean);
var Page:TSGTK0TabSheet;
begin
 Page:=FindNextPage(ActivePage,GoForward,true);
 if assigned(Page) and (Page<>ActivePage) {AND CanChange} then begin
  ActiveTab:=Page.TabIndex;
  Change;
 end;
end;

procedure TSGTK0PageControl.SetActivePage(Page:TSGTK0TabSheet);
begin
 if assigned(Page) and (Page.PageControl<>self) then exit;
 ChangeActivePage(Page);
 if Page=nil then begin
  ActiveTab:=-1;
 end else if Page=FActivePage then begin
  ActiveTab:=Page.TabIndex;
 end;
end;

procedure TSGTK0PageControl.SetChildOrder(Child:TComponent;Order:integer);
begin
 TSGTK0TabSheet(Child).PageIndex:=Order;
end;

procedure TSGTK0PageControl.ShowControl(AControl:TControl);
begin
 if (AControl is TSGTK0TabSheet) and (TSGTK0TabSheet(AControl).PageControl=self) then begin
  SetActivePage(TSGTK0TabSheet(AControl));
 end;
 inherited ShowControl(AControl);
end;

procedure TSGTK0PageControl.UpdateTab(Page:TSGTK0TabSheet);
begin
 Tabs[Page.TabIndex]:=Page.Caption;
end;

procedure TSGTK0PageControl.UpdateActivePage;
begin
 if ActiveTab>=0 then begin
  SetActivePage(TSGTK0TabSheet(Tabs.Objects[ActiveTab]));
 end else begin
  SetActivePage(nil);
 end;
end;

procedure TSGTK0PageControl.CMDialogKey(var message:TCMDialogKey);
begin
 if (Focused or Windows.IsChild(Handle,Windows.GetFocus)) and
    (message.CharCode=VK_TAB) and (GetKeyState(VK_CONTROL)<0) then begin
  SelectNextPage(GetKeyState(VK_SHIFT)>=0);
  message.result:=1;
 end else begin
  inherited;
 end;
end;

procedure TSGTK0PageControl.CMDockClient(var message:TCMDockClient);
var IsVisible:boolean;
    DockCtl:TControl;
begin
 message.result:=0;
 FNewDockSheet:=TSGTK0TabSheet.Create(self);
 try
  try
   DockCtl:=message.DockSource.Control;
   if DockCtl is TCustomForm then begin
    FNewDockSheet.Caption:=TCustomForm(DockCtl).Caption;
   end;
   FNewDockSheet.PageControl:=self;
   DockCtl.Dock(self,message.DockSource.DockRect);
  except
   FNewDockSheet.Free;
   raise;
  end;
  IsVisible:=DockCtl.Visible;
  FNewDockSheet.TabVisible:=IsVisible;
  if IsVisible then ActivePage:=FNewDockSheet;
  DockCtl.Align:=alClient;
 finally
  FNewDockSheet:=nil;
 end;
end;

procedure TSGTK0PageControl.CMDockNotification(var message:TCMDockNotification);
var I:integer;
    S:string;
    Page:TSGTK0TabSheet;
begin
 Page:=GetPageFromDockClient(message.Client);
 if assigned(Page) then begin
  case message.NotifyRec.ClientMsg of
   WM_SETTEXT:begin
    S:=pchar(message.NotifyRec.MsgLParam);
    for I:=1 to length(S) do begin
     if S[I] in [#13,#10] then begin
      setlength(S,I-1);
      break;
     end;
    end;
    Page.Caption:=S;
   end;
   CM_VISIBLECHANGED:Page.TabVisible:=boolean(message.NotifyRec.MsgWParam);
  end;
 end;
 inherited;
end;

procedure TSGTK0PageControl.CMUnDockClient(var message:TCMUnDockClient);
var Page:TSGTK0TabSheet;
begin
 message.result:=0;
 Page:=GetPageFromDockClient(message.Client);
 if assigned(Page) then begin
  FUndockingPage:=Page;
  message.Client.Align:=alNone;
 end;
end;

function TSGTK0PageControl.GetDockClientFromMousePos(MousePos:TPoint):TControl;
begin
 result:=nil;
end;

procedure TSGTK0PageControl.WMLButtonDown(var message:TWMLButtonDown);
var DockCtl:TControl;
begin
 inherited;
 DockCtl:=GetDockClientFromMousePos(SmallPointToPoint(message.Pos));
 if assigned(DockCtl) then DockCtl.BeginDrag(false);
end;

procedure TSGTK0PageControl.WMLButtonDblClk(var message:TWMLButtonDblClk);
var DockCtl:TControl;
begin
 inherited;
 DockCtl:=GetDockClientFromMousePos(SmallPointToPoint(message.Pos));
 if assigned(DockCtl) then DockCtl.ManualDock(nil,nil,alNone);
end;

function TSGTK0PageControl.GetActivePageIndex:integer;
begin
 if assigned(ActivePage) then begin
  result:=ActivePage.GetPageIndex;
 end else begin
  result:=-1;
 end;
end;

procedure TSGTK0PageControl.SetActivePageIndex(const Value:integer);
begin
 if (Value>=0) and (Value<PageCount) then begin
  ActivePage:=Pages[Value];
 end else begin
  ActivePage:=nil;
 end;
end;

constructor TSGTK0ListBox.Create(AOwner:TComponent);
begin
 inherited;
 BufferBitmap:=TBitmap.Create;
 if not assigned(ListBoxScrollTimer) then begin
  ListBoxScrollTimer:=TTimer.Create(nil);
  ListBoxScrollTimer.Enabled:=false;
  ListBoxScrollTimer.Interval:=FTimerInterval;
 end;
 ControlStyle:=ControlStyle+[csOpaque];
 SetBounds(Left,Top,137,99);
 FItems:=TStringList.Create;
 FItemsRect:=TList.Create;
 FItemsHeight:=17;

 TStringList(FItems).OnChange:=ItemsChanged;

 FMultiSelect:=false;
 FScrollBars:=false;
 FirstItem:=0;
 FItemIndex:=-1;
 FArrowColor:=clrBorder;
 FBorderColor:=clrBorder;
 FItemsRectColor:=clrEditListBack;
 FItemsSelectColor:=clrFocusedHighlight;
 ParentColor:=true;
 ParentFont:=true;
 Enabled:=true;
 Visible:=true;
 FSorted:=false;
 cWheelMessage:=RegisterWindowMessage(MSH_MOUSEWHEEL);
end;

destructor TSGTK0ListBox.Destroy;
var Counter:integer;
begin
 ListBoxScrollTimer.Free;
 ListBoxScrollTimer:=nil;
 FItems.Free;
 for Counter:=0 to FItemsRect.Count-1 do DISPOSE(FItemsRect.Items[Counter]);
 FItemsRect.Free;
 BufferBitmap.Destroy;
 inherited;
end;

procedure TSGTK0ListBox.WndProc(var message:TMessage);
begin
 if message.Msg=cWheelMessage then begin
  SendMessage(self.Handle,WM_MOUSEWHEEL,message.wParam,message.lParam);
 end;
 inherited;
end;

procedure TSGTK0ListBox.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;

procedure TSGTK0ListBox.WMMouseWheel(var message:TMessage);
var fScrollLines:integer;
begin
 if not(csDesigning in ComponentState) then begin
  SystemParametersInfo(SPI_GETWHEELSCROLLLINES,0,@fScrollLines,0);
  if fScrollLines=0 then fScrollLines:=MaxItems;
  if shortint(message.WParamHi)=-WHEEL_DELTA then begin
   if FirstItem+MaxItems+fScrollLines<=FItems.Count then begin
    inc(FirstItem,fScrollLines);
   end else if FItems.Count-MaxItems<0 then begin
    FirstItem:=0;
   end else begin
    FirstItem:=FItems.Count-MaxItems;
   end;
  end else if shortint(message.WParamHi)=WHEEL_DELTA then begin
   if FirstItem-fScrollLines<0 then begin
    FirstItem:=0;
   end else begin
    dec(FirstItem,fScrollLines);
   end
  end;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0ListBox.ItemsChanged(Sender:TObject);
begin
 if Enabled then begin
  FSelected:=FSelected-[0..high(byte)];
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0ListBox.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FArrowColor:=Value;
  1:FBorderColor:=Value;
  2:FItemsRectColor:=Value;
  3:FItemsSelectColor:=Value;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.SetSorted(Value:boolean);
begin
 if Value<>FSorted then begin
  FSorted:=Value;
  FItems.Sorted:=Value;
  FSelected:=FSelected-[0..high(byte)];
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0ListBox.SetItems(Value:TStringList);
var  Counter:integer;
begin
 if Value.Count-1>high(byte) then exit;
 for Counter:=0 to Value.Count-1 do Value[Counter]:=Trim(Value[Counter]);
 FItems.Assign(Value);
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.SetItemsRect;
var Counter,Z:integer;
    ItemRect:^TRect;
    Position:TPoint;
begin
 FItemsRect.Clear;
 if ScrollBars then begin
  Z:=Height-24;
 end else begin
  Z:=Height-4;
 end;
 MaxItems:=Z div (FItemsHeight+2);

 if ScrollBars then begin
  Position:=POINT(ClientRect.Left+3,ClientRect.Top+13);
 end else begin
  Position:=POINT(ClientRect.Left+3,ClientRect.Top+3);
 end;

 for Counter:=0 to MaxItems-1 do begin
  NEW(ItemRect);
  ItemRect^:=Rect(Position.X,Position.Y,ClientRect.Right-3,Position.Y+FItemsHeight);
  Position:=POINT(Position.X,Position.Y+FItemsHeight+2);
  FItemsRect.Add(ItemRect);
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.SetItemsHeight(Value:integer);
begin
 if Value<1 then Value:=1;
 FItemsHeight:=Value;
 if not (csLoading in ComponentState) then begin
  if ScrollBars then begin
   SetBounds(Left,Top,Width,MaxItems*(FItemsHeight+2)+24);
  end else begin
   SetBounds(Left,Top,Width,MaxItems*(FItemsHeight+2)+4);
  end;
 end;
 SetItemsRect;
end;

function TSGTK0ListBox.GetSelected(index:integer):boolean;
begin
 result:=index in FSelected;
end;

procedure TSGTK0ListBox.SetSelected(index:integer;Value:boolean);
begin
 if MultiSelect then begin
  if Value then begin
   include(FSelected,index);
  end else begin
   exclude(FSelected,index);
  end;
 end else begin
  FSelected:=FSelected-[low(byte)..high(byte)];
  if Value then begin
   include(FSelected,index);
  end else begin
   exclude(FSelected,index);
  end;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

function TSGTK0ListBox.GetSelCount:integer;
var Counter:integer;
begin
 if MultiSelect then begin
  result:=0;
  for Counter:=low(byte) to high(byte) do begin
   if Counter in FSelected then begin
    inc(result);
   end;
  end;
 end else begin
  result:=-1;
 end;
end;

procedure TSGTK0ListBox.SetScrollBars(Value:boolean);
begin
 if FScrollBars<>Value then begin
  FScrollBars:=Value;
  if not (csLoading in ComponentState) then begin
   if Value then begin
    Height:=Height+20;
   end else begin
    Height:=Height-20;
   end;
  end;
  SetItemsRect;
 end;
end;

procedure TSGTK0ListBox.DrawScrollBar(Canvas:TCanvas);
var X,Y:integer;
begin
 Canvas.Brush.Color:=Color;
 Canvas.FillRect(Rect(ClientRect.Left,ClientRect.Top,ClientRect.Right,ClientRect.Top+11));
 Canvas.FillRect(Rect(ClientRect.Left,ClientRect.Bottom-11,ClientRect.Right,ClientRect.Bottom));

 Canvas.Brush.Color:=FBorderColor;
 Canvas.FrameRect(Rect(ClientRect.Left,ClientRect.Top,ClientRect.Right,ClientRect.Top+11));
 Canvas.FrameRect(Rect(ClientRect.Left,ClientRect.Bottom-11,ClientRect.Right,ClientRect.Bottom));

 X:=((ClientRect.Right-ClientRect.Left) div 2)-6;
 Y:=ClientRect.Top+4;

 if (FirstItem<>0) and Enabled then begin
  Canvas.Brush.Color:=FArrowColor;
  Canvas.Pen.Color:=FArrowColor;
  Canvas.Polygon([POINT(X+4,Y+2),POINT(X+8,Y+2),POINT(X+6,Y)]);
 end else begin
  Canvas.Brush.Color:=clWhite;
  Canvas.Pen.Color:=clWhite;
  inc(X);
  inc(Y);
  Canvas.Polygon([POINT(X+4,Y+2),POINT(X+8,Y+2),POINT(X+6,Y)]);
  dec(X);
  dec(Y);
  Canvas.Brush.Color:=clGray;
  Canvas.Pen.Color:=clGray;
  Canvas.Polygon([POINT(X+4,Y+2),POINT(X+8,Y+2),POINT(X+6,Y)]);
 end;

 Y:=ClientRect.Bottom-7;
 if (FirstItem+MaxItems+1<=FItems.Count) and Enabled then begin
  Canvas.Brush.Color:=FArrowColor;
  Canvas.Pen.Color:=FArrowColor;
  Canvas.Polygon([POINT(X+4,Y),POINT(X+8,Y),POINT(X+6,Y+2)]);
 end else begin
  Canvas.Brush.Color:=clWhite;
  Canvas.Pen.Color:=clWhite;
  inc(X);
  inc(Y);
  Canvas.Polygon([POINT(X+4,Y),POINT(X+8,Y),POINT(X+6,Y+2)]);
  dec(X);
  dec(Y);
  Canvas.Brush.Color:=clGray;
  Canvas.Pen.Color:=clGray;
  Canvas.Polygon([POINT(X+4,Y),POINT(X+8,Y),POINT(X+6,Y+2)]);
 end;
end;

procedure TSGTK0ListBox.Resize;
begin
 inherited Resize;
 if (BufferBitmap.Width<>ClientRect.Right) or
    (BufferBitmap.Height<>ClientRect.Bottom) then begin
  BufferBitmap.Height:=0;
  BufferBitmap.Width:=ClientRect.Right;
  BufferBitmap.Height:=ClientRect.Bottom;
 end;
end;

procedure TSGTK0ListBox.Paint;
var CounterRect,CounterItem:integer;
    ItemRect:^TRect;
    Format:UINT;
begin
 if BidiMode=bdRightToLeft then begin
  Format:=DT_RIGHT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX;
 end else begin
  Format:=DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX;
 end;

 try
  if (BufferBitmap.Width<>ClientRect.Right) or
     (BufferBitmap.Height<>ClientRect.Bottom) then begin
   BufferBitmap.Height:=0;
   BufferBitmap.Width:=ClientRect.Right;
   BufferBitmap.Height:=ClientRect.Bottom;
  end;

  BufferBitmap.Canvas.Font.Assign(self.Font);

  BufferBitmap.Canvas.Brush.Color:=FItemsRectColor;
  BufferBitmap.Canvas.FillRect(ClientRect);

  BufferBitmap.Canvas.Brush.Color:=FBorderColor;
  BufferBitmap.Canvas.FrameRect(ClientRect);

  if ScrollBars then DrawScrollBar(BufferBitmap.Canvas);

  CounterItem:=FirstItem;

  for CounterRect:=0 to MaxItems-1 do begin
   ItemRect:=FItemsRect.Items[CounterRect];
   if (CounterItem<=FItems.Count-1) then begin
    if CounterItem in FSelected then begin
     BufferBitmap.Canvas.Brush.color:=FItemsSelectColor;
     BufferBitmap.Canvas.FillRect(ItemRect^);
     BufferBitmap.Canvas.Brush.color:=FBorderColor;
     BufferBitmap.Canvas.FrameRect(ItemRect^);
    end;
    BufferBitmap.Canvas.Brush.Style:=bsClear;
    InflateRect(ItemRect^,-3,0);
    if Enabled then begin
     DrawText(BufferBitmap.Canvas.Handle,pchar(FItems[CounterItem]),length(FItems[CounterItem]),ItemRect^,Format);
    end else begin
     OffsetRect(ItemRect^,1,1);
     BufferBitmap.Canvas.Font.Color:=clBtnHighlight;
     DrawText(BufferBitmap.Canvas.Handle,pchar(FItems[CounterItem]),length(FItems[CounterItem]),ItemRect^,Format);
     OffsetRect(ItemRect^,-1,-1);
     BufferBitmap.Canvas.Font.Color:=clBtnShadow;
     DrawText(BufferBitmap.Canvas.Handle,pchar(FItems[CounterItem]),length(FItems[CounterItem]),ItemRect^,Format);
    end;
    InflateRect(ItemRect^,3,0);
    inc(CounterItem);
   end;
  end;
  Canvas.CopyRect(ClientRect,BufferBitmap.Canvas,ClientRect);
 finally
 end;
end;

procedure TSGTK0ListBox.MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
var CursorPos:TPoint;
    CounterRect:integer;
    CurrentRect:^TRect;
begin
 GetCursorPos(CursorPos);
 CursorPos:=ScreenToClient(CursorPos);
 if (FItems.Count>0) and (Button=mbLeft) then begin
  for CounterRect:=0 to FItemsRect.Count-1 do begin
   CurrentRect:=FItemsRect.Items[CounterRect];
   if PtInRect(CurrentRect^,CursorPos) then begin
    if MultiSelect then begin
     if(FirstItem+CounterRect) in FSelected then begin
      exclude(FSelected,FirstItem+CounterRect);
     end else begin
      include(FSelected,FirstItem+CounterRect);
     end;
     FItemIndex:=FirstItem+CounterRect;
    end else begin
     FSelected:=FSelected-[low(byte)..high(byte)];
     include(FSelected,FirstItem+CounterRect);
     FItemIndex:=FirstItem+CounterRect;
    end;
    SetFocus;
    if not SGTK0UpdateLock then begin
     Invalidate;
    end;
    exit;
   end;
  end;
 end;

 if ScrollBars then begin
  if PtInRect(Rect(ClientRect.Left,ClientRect.Top,ClientRect.Right,ClientRect.Top+11),CursorPos) then begin
   if(FirstItem-1)<0 then begin
    FirstItem:=0;
   end else begin
    dec(FirstItem);
   end;
   SetFocus;
   if not SGTK0UpdateLock then begin
    Invalidate;
   end;
   ScrollType:=Up;
   if ListBoxScrollTimer.Enabled then ListBoxScrollTimer.Enabled:=false;
   ListBoxScrollTimer.OnTimer:=ScrollTimerHandler;
   ListBoxScrollTimer.Enabled:=true;
  end;
  if PtInRect(Rect(ClientRect.Left,ClientRect.Bottom-11,ClientRect.Right,ClientRect.Bottom),CursorPos) then begin
   if FirstItem+MaxItems+1<=FItems.Count then  inc(FirstItem);
   SetFocus;
   if not SGTK0UpdateLock then begin
    Invalidate;
   end;
   ScrollType:=Down;
   if ListBoxScrollTimer.Enabled then ListBoxScrollTimer.Enabled:=false;
   ListBoxScrollTimer.OnTimer:=ScrollTimerHandler;
   ListBoxScrollTimer.Enabled:=true;
  end;
 end;
 inherited;
end;

procedure TSGTK0ListBox.MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
begin
 ListBoxScrollTimer.Enabled:=false;
 ListBoxScrollTimer.Interval:=FTimerInterval;
 inherited MouseUp(Button,Shift,X,Y);
end;

procedure TSGTK0ListBox.ScrollTimerHandler(Sender:TObject);
begin
 ListBoxScrollTimer.Interval:=FScrollSpeed;
 case ScrollType of
  Up:begin
   if(FirstItem-1)<0 then begin
    FirstItem:=0;
    ListBoxScrollTimer.Enabled:=false;
   end else begin
    dec(FirstItem);
   end;
  end;
  Down:begin
   if FirstItem+MaxItems+1<=FItems.Count then begin
    inc(FirstItem);
   end else begin
    ListBoxScrollTimer.Enabled:=false;
   end;
  end;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.Loaded;
begin
 inherited;
 SetItemsRect;
end;

procedure TSGTK0ListBox.WMSize(var message:TWMSize);
begin
 inherited;
 if ScrollBars then begin
  MaxItems:=(Height-24) div (FItemsHeight+2);
 end else begin
  MaxItems:=(Height-4) div (FItemsHeight+2);
 end;
 if ScrollBars then begin
  SetBounds(Left,Top,Width,MaxItems*(FItemsHeight+2)+24);
 end else begin
  SetBounds(Left,Top,Width,MaxItems*(FItemsHeight+2)+4);
 end;
 SetItemsRect;
end;

procedure TSGTK0ListBox.CMEnabledChanged(var message:TMessage);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.CMSysColorChange(var message:TMessage);
begin
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.CMParentColorChanged(var message:TWMNoParams);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.WMMove(var message:TWMMove);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.WMKillFocus(var message:TWMKillFocus);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.WMSetFocus(var message:TWMSetFocus);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

procedure TSGTK0ListBox.CNKeyDown(var message:TWMKeyDown);
begin
 case message.CharCode of
  VK_UP:begin
   if (FirstItem-1)<0 then begin
    FirstItem:=0;
   end else begin
    dec(FirstItem);
   end;
  end;
  VK_DOWN:begin
   if FirstItem+MaxItems+1<=FItems.Count then begin
    inc(FirstItem);
   end;
  end;
  VK_PRIOR:begin
   if (FirstItem-MaxItems)<0 then begin
    FirstItem:=0;
   end else begin
    dec(FirstItem,MaxItems);
   end;
  end;
  VK_NEXT:begin
   if (FirstItem+(MaxItems*2))<=FItems.Count then begin
    inc(FirstItem,MaxItems);
   end else begin
    FirstItem:=FItems.Count-MaxItems;
   end;
  end;
  else begin
   inherited;
  end;
 end;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

function TSGTK0ListBox.GetItemIndex:integer;
begin
 result:=FItemIndex;
end;

procedure TSGTK0ListBox.SetItemIndex(Value:integer);
begin
 if GetItemIndex<>Value then begin
  FItemIndex:=Value;
  if MultiSelect then begin
   if Value in FSelected then begin
    exclude(FSelected,Value);
   end else begin
    include(FSelected,Value);
   end;
  end else begin
   FSelected:=FSelected-[low(byte)..high(byte)];
   include(FSelected,Value);
  end;
  if not SGTK0UpdateLock then begin
   Invalidate;
  end;
 end;
end;

procedure TSGTK0ListBox.SetMultiSelect(Value:boolean);
begin
 FMultiSelect:=Value;
 if Value then FItemIndex:=0;
end;

procedure TSGTK0ListBox.SetBiDiMode(Value:TBiDiMode);
begin
 inherited;
 if not SGTK0UpdateLock then begin
  Invalidate;
 end;
end;

constructor TSGTK0Memo.Create(AOwner:TComponent);
begin
 inherited;
 ParentFont:=true;
 FFocusedColor:=clrEditListFocused;
 FBorderColor:=clrBorder;
 FBackColor:=clrEditListBack;
 FParentColor:=false;
 AutoSize:=false;
 Ctl3D:=false;
 BorderStyle:=bsNone;
 ControlStyle:=ControlStyle-[csFramed];
 SetBounds(0,0,185,89);
end;

procedure TSGTK0Memo.SetParentColor(Value:boolean);
begin
 if Value<>FParentColor then begin
  FParentColor:=Value;
  if FParentColor then begin
   if assigned(Parent) then begin
    FBackColor:=TForm(Parent).Color;
   end;
   if not SGTK0UpdateLock then begin
    RedrawBorder(0);
   end;
  end;
 end;
end;

procedure TSGTK0Memo.CMSysColorChange(var message:TMessage);
begin
 if FParentColor then begin
  if assigned(Parent) then begin
   FBackColor:=TForm(Parent).Color;
  end;
 end;
 if not SGTK0UpdateLock then begin
  RedrawBorder(0);
 end;
end;

procedure TSGTK0Memo.CMParentColorChanged(var message:TWMNoParams);
begin
 if FParentColor then begin
  if assigned(Parent) then begin
   FBackColor:=TForm(Parent).Color;
  end;
 end;
 if not SGTK0UpdateLock then begin
  RedrawBorder(0);
 end;
end;

procedure TSGTK0Memo.SetColors(index:integer;Value:TColor);
begin
 case index of
  0:FFocusedColor:=Value;
  1:FBorderColor:=Value;
  2:begin
   FBackColor:=Value;
   FParentColor:=false;
  end;
 end;
 if not SGTK0UpdateLock then begin
  RedrawBorder(0);
 end;
end;

procedure TSGTK0Memo.CMMouseEnter(var message:TMessage);
begin
 inherited;
 if GetActiveWindow<>0 then begin
  MouseInControl:=true;
  RedrawBorder(0);
 end;
end;

procedure TSGTK0Memo.CMMouseLeave(var message:TMessage);
begin
  inherited;
  MouseInControl:=false;
  RedrawBorder(0);
end;

procedure TSGTK0Memo.CMEnabledChanged(var message:TMessage);
const EnableColors:array[boolean] of TColor=(clBtnFace,clrBack);
begin
 inherited;
 Color:=EnableColors[Enabled];
 RedrawBorder(0);
end;

procedure TSGTK0Memo.WMSetFocus(var message:TWMSetFocus);
begin
 inherited;
 if not (csDesigning in ComponentState) then begin
  RedrawBorder(0);
 end;
end;

procedure TSGTK0Memo.WMKillFocus(var message:TWMKillFocus);
begin
 inherited;
 if not (csDesigning in ComponentState) then begin
  RedrawBorder(0);
 end;
end;

procedure TSGTK0Memo.WMNCCalcSize(var message:TWMNCCalcSize);
begin
 inherited;
 InflateRect(message.CalcSize_Params^.rgrc[0],-3,-3);
end;

procedure TSGTK0Memo.WMNCPaint(var message:TMessage);
begin
 inherited;
 RedrawBorder(HRGN(message.WParam));
end;

{procedure TSGTK0Memo.WMEraseBkgnd(var Msg:TWMEraseBkgnd);
begin
 Msg.result:=1;
end;}

procedure TSGTK0Memo.RedrawBorder(const Clip:HRGN);
var DC:HDC;
    R:TRect;
    BtnFaceBrush,WindowBrush,FocusBrush:HBRUSH;
begin
 DC:=GetWindowDC(Handle);
 try
  GetWindowRect(Handle,R);
  OffsetRect(R,-R.Left,-R.Top);
  BtnFaceBrush:=CreateSolidBrush(ColorToRGB(FBorderColor));
  WindowBrush:=CreateSolidBrush(ColorToRGB(FBackColor));
  FocusBrush:=CreateSolidBrush(ColorToRGB(FFocusedColor));
  if not (csDesigning in ComponentState) and (Focused or(MouseInControl and not(Screen.ActiveControl is TSGTK0Memo))) then begin
   Color:=FFocusedColor;
   FrameRect(DC,R,BtnFaceBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,FocusBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,FocusBrush);
   if ScrollBars=ssBoth then begin
    FillRect(DC,Rect(R.Right-17,R.Bottom-17,R.Right-1,R.Bottom-1),FocusBrush);
   end;
  end else begin
   Color:=FBackColor;
   FrameRect(DC,R,BtnFaceBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,WindowBrush);
   InflateRect(R,-1,-1);
   FrameRect(DC,R,WindowBrush);
   if ScrollBars=ssBoth then begin
    FillRect(DC,Rect(R.Right-17,R.Bottom-17,R.Right-1,R.Bottom-1),WindowBrush);
   end;
  end;
 finally
  ReleaseDC(Handle,DC);
 end;
 DeleteObject(WindowBrush);
 DeleteObject(BtnFaceBrush);
 DeleteObject(FocusBrush);
end;

constructor TSGTK0MenuCollectionItem.Create(Collection:TCollection);
begin
 inherited Create(Collection);
 FMenu:=nil;
end;

destructor TSGTK0MenuCollectionItem.Destroy;
begin
 AssignMenu(FMenu,false);
 inherited Destroy;
end;

procedure TSGTK0MenuCollectionItem.AssignMenu(const Value:TMenu;Assign:boolean);
begin
 if assigned(Value) then begin
  TSGTK0MenuCollection(Collection).Menu.AssignMethods(Value.Items,Assign);
 end;
 if Assign then begin
  Value.FreeNotification(MenuComponent);
 end;
end;

function TSGTK0MenuCollectionItem.GetDisplayName:string;
begin
 if assigned(FMenu) then begin
  result:=FMenu.Name;
 end else begin
  result:='Add a menu';
 end;
end;

procedure TSGTK0MenuCollectionItem.SetMenu(const Value:TMenu);
begin
 AssignMenu(FMenu,false);
 try
  FMenu:=Value;
 finally
  AssignMenu(FMenu,true);
 end;
 FMenu.OwnerDraw:=MenuComponent.Active;
end;

function TSGTK0MenuCollectionItem.MenuComponent:TSGTK0Menu;
begin
 result:=TSGTK0MenuCollection(Collection).Menu;
end;

procedure TSGTK0Menu.SetAssignedMenus(const Value:TSGTK0MenuCollection);
begin
 FAssignedMenus.Assign(Value);
end;

procedure TSGTK0Menu.Notification(AComponent:TComponent;Operation:TOperation);
begin
 inherited Notification(AComponent,Operation);
 if (Operation=opRemove) and (AComponent is TMenu) then begin
  FAssignedMenus.DeleteLink(AComponent);
 end;
end;

procedure TSGTK0Menu.AddMenu(const AMenu:TMenu);
 var it:TSGTK0MenuCollectionItem;
begin
 it:=TSGTK0MenuCollectionItem(FAssignedMenus.Add);
 it.Menu:=AMenu;
end;

procedure TSGTK0Menu.SetActive(const Value:boolean);
var i:integer;
begin
 FActive:=Value;
 for i:=0 to FAssignedMenus.Count-1 do begin
  if assigned(FAssignedMenus.Items[i].Menu) then begin
   FAssignedMenus.Items[i].Menu.OwnerDraw:=Value;
  end;
 end;
end;

constructor TSGTK0MenuCollection.Create(Acmp:TSGTK0Menu);
begin
 inherited Create(TSGTK0MenuCollectionItem);
 FMenu:=Acmp;
end;

procedure TSGTK0MenuCollection.DeleteLink(const AComponent:Tcomponent);
var i:integer;
begin
 i:=0;
 while i<Count do begin
  if AComponent=TSGTK0MenuCollectionItem(Items[i]).Menu then begin
   Delete(i);
  end else begin
   inc(i);
  end;
 end;
end;

function TSGTK0MenuCollection.GetItems(i:integer):TSGTK0MenuCollectionItem;
begin
 result:=TSGTK0MenuCollectionItem(inherited Items[i]);
end;

function TSGTK0MenuCollection.GetOwner:TPersistent;
begin
 result:=Self.Menu;
end;

procedure TSGTK0MenuCollectionItem.AssignTo(Dest:TPersistent);
begin
 if Dest is TSGTK0MenuCollectionItem then begin
  TSGTK0MenuCollectionItem(Dest).Menu:=Menu;
 end else begin
  inherited AssignTo(Dest);
 end;
end;

constructor TSGTK0Menu.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);

 FActive:=true;
 FAssignedMenus:=TSGTK0MenuCollection.Create(Self);

 FFontActive:=TFont.Create;
 FFontActive.Style:=[fsBold];
 FFontActive.name:='Arial';
 FFontNormal:=TFont.Create;
 FFontNormal.name:='Arial';

 FLeftMargin:=DEFAULT_LEFT_MARGIN;
 FRightMargin:=DEFAULT_RIGHT_MARGIN;
 FDownFace:=DEFAULT_DOWN_FACE;
 FNormalFace:=DEFAULT_NORMAL_FACE;
 FLineColor:=DEFAULT_LINE_COLOR;
 FFocusedFace:=DEFAULT_FOCUSED_FACE;
 FTextVert:=DEFAULT_TEXT_VERT_MARGIN;
 FHighlightColor:=DEFAULT_HIGHLIGHT_COLOR;
 FShadowColor:=DEFAULT_SHADOW_COLOR;
end;

destructor TSGTK0Menu.Destroy;
begin
 FAssignedMenus.Free;
 FFontActive.Free;
 FFontNormal.Free;
 inherited Destroy;
end;

function TSGTK0Menu.ItemMargin(Item:TMenuItem; Left:boolean):integer;
begin
 if (not IsTopItem(Item)) and Left then begin
  result:=FLeftMargin;
 end else begin
  result:=FRightMargin;
 end;
end;

function TSGTK0Menu.IsTopItem(Item:TMenuItem):boolean;
begin
 result:=(Item.GetParentMenu is TMainMenu) and (Item.Parent.Parent=nil);
end;

procedure TSGTK0Menu.DrawItem(Sender:TObject;ACanvas:TCanvas;ARect:TRect;State:TOwnerDrawState);
var it:TMenuItem;
    lLeft:integer;
    lLineTop:integer;
    lDown:boolean;
    lActive:boolean;
    lColor:TColor;
    lTopItem:boolean;
 procedure PaintText(AX,AY:integer;AText:string;ARightSideX:boolean);
 var lPaintRect:trect;
 begin
  if odDisabled in State then begin
   AText:=StripHotkey(AText);
  end;

  ACanvas.Brush.Style:=bsSolid;
  if (odSelected in State) or (odHotLight in State) then begin
   ACanvas.Font.Assign(FFontActive);
  end else begin
   ACanvas.Font.Assign(FFontNormal);
  end;
  if odDefault in State then begin
   ACanvas.Font.Style:=ACanvas.Font.Style+[fsBold];
  end;

  if ARightSideX then begin
   dec(AX,ACanvas.TextWidth(AText));
  end;
  if not lTopItem then begin
   inc(AY,FTextVert-1);
  end;
  if lActive and not lTopItem then begin
   dec(AY);
  end;

  lPaintRect:=ARect;
  lPaintRect.Top:=AY;
  lPaintRect.Left:=AX;

  if (lTopItem and not lDown) and not lActive then begin
   ACanvas.Font.Color:=clMenuText;
  end;

  if odDisabled in State then begin
   ACanvas.Font.Color:=FShadowColor;
  end;
  DrawText(ACanvas.Handle,PChar(AText),Length(AText),lPaintRect,DT_VCENTER or DT_TOP or DT_NOCLIP);

  if (odChecked in State) and not ARightSideX then begin
   ACanvas.Pen.Color:=ACanvas.Font.Color;
   ACanvas.Pen.Style:=psSolid;
   ACanvas.Pen.Width:=2;
   ACanvas.MoveTo(AX-12,((AY+5)+(ARect.Bottom-5)) div 2);
   ACanvas.LineTo(AX-8,ARect.Bottom-5);
   ACanvas.LineTo(AX-4,AY+5);
   ACanvas.Pen.Width:=1;
  end;

 end;
begin
 it:=TMenuItem(Sender);
 lTopItem:=IsTopItem(it);

 if it.IsLine then begin
  ACanvas.Pen.Width:=1;
  lLineTop:=ARect.Top+(ARect.Bottom-ARect.Top) div 2;
  ACanvas.Brush.Color:=FNormalFace;
  ACanvas.FillRect(ARect);
  ACanvas.Pen.Color:=FLineColor;
  ACanvas.MoveTo(ARect.Left,lLineTop-1);
  ACanvas.LineTo(ARect.Right,lLineTop-1);
  ACanvas.Pen.Color:=FLineColor;
  ACanvas.MoveTo(ARect.Left,lLineTop+1);
  ACanvas.LineTo(ARect.Right,lLineTop+1);
 end else begin
  lDown:=(not FLinuxStyle) and lTopItem and (odSelected in state);
  lActive:=(not lDown) and ((odSelected in state) or (odHotLight in state));

  lColor:=FNormalFace;

  if lDown then begin
   lColor:=FDownFace;
  end;

  if lActive then begin
   lColor:=FFocusedFace;
  end;

  if not lActive and not lDown and lTopItem then begin
   lColor:=clMenu;
  end;

  //Frame3D(ACanvas,ARect,lTopCol,lBottomCol,1);
  ACanvas.Brush.Color:=lColor;
  ACanvas.FillRect(ARect);

  lLeft:=ARect.Left+ItemMargin(it,true);
  PaintText(lLeft,ARect.Top,it.Caption,false);
  lLeft:=ARect.Right-ItemMargin(it,false);
  PaintText(lLeft,ARect.Top,ShortCutToText(it.ShortCut),true);
 end;
end;

procedure TSGTK0Menu.MeasureItem(Sender:TObject;ACanvas:TCanvas;var Width,Height:Integer);
var it:TMenuItem;
    lTxt:string;
 procedure MeasureFor(const AFont:TFont;const AText:string);
 var w:integer;
 begin
  ACanvas.Font.Assign(AFont);
  w:=ACanvas.TextWidth(AText);
  if not IsTopItem(it) then begin
   inc(w,ItemMargin(it,true)+ItemMargin(it,false));
  end;
  Width:=Max(Width,w);
  Height:=Max(Height,ACanvas.TextHeight(AText)+(FTextVert*2));
 end;
begin
 it:=TMenuItem(sender);
 if it.IsLine then begin
  Height:=5;
 end else begin
  if it.Default then begin
   ACanvas.Font.Style:=[fsBold];
  end;
  lTxt:=StripHotkey(it.Caption);
  if it.ShortCut<>0 then begin
   lTxt:=lTxt+' '+ShortCutToText(it.ShortCut);
  end;
  Width:=0;
  Height:=0;
  MeasureFor(FFontActive,lTxt);
  MeasureFor(FFontNormal,lTxt);
 end;
end;

procedure TSGTK0Menu.AssignMethods(AItem:TMenuItem;Assign:boolean);
var SelfDraw,ItemDraw:TAdvancedMenuDrawItemEvent;
    SelfMeasure,ItemMeasure:TMenuMeasureItemEvent;
    i:integer;
begin
 if Assign then begin
  if not assigned(AItem.OnAdvancedDrawItem) then begin
   AItem.OnAdvancedDrawItem:=DrawItem;
  end;
  if not assigned(AItem.OnMeasureItem) then begin
   AItem.OnMeasureItem:=MeasureItem;
  enD;
 end else begin
  ItemDraw:=AItem.OnAdvancedDrawItem;
  ItemMeasure:=AItem.OnMeasureItem;
  SelfDraw:=DrawItem;
  SelfMeasure:=MeasureItem;
  if @ItemDraw=@SelfDraw then begin
   AItem.OnAdvancedDrawItem:=nil;
  end;
  if @ItemMeasure=@SelfMeasure then begin
   AItem.OnAdvancedDrawItem:=nil;
  end;
 end;
 for i:=0 to AItem.Count-1 do begin
  AssignMethods(AItem.Items[i],Assign);
 end;
end;

procedure TSGTK0Menu.SetFontActive(const Value:TFont);
begin
 FFontActive.Assign(Value);
end;

procedure TSGTK0Menu.SetFontNormal(const Value:TFont);
begin
 FFontNormal.Assign(Value);
end;

end.
