(* Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * Licensed under the terms of the LGPL V3 or later, see LGPLv3.txt or
 * http://www.gnu.org/licenses/lgpl.html for details
 *)
unit UnitFormEnvelopeEditor;
{$j+}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, AppEvnts, Globals, Math, Synth,
  BeRoCriticalSection, UnitVSTiGUI;

type
  TEnvelopeNodes=array of TSynthEnvelopeNode;

  TEnvelopeForm = class(TForm)
    PopupMenu: TPopupMenu;
    Delete1: TMenuItem;
    N3: TMenuItem;
    Setinterpolation1: TMenuItem;
    Nearest1: TMenuItem;
    Linear1: TMenuItem;
    PanelImage: TSGTK0Panel;
    PaintBoxImage: TPaintBox;
    Setinterpolation3: TMenuItem;
    Nearest3: TMenuItem;
    Linear3: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Insert1: TMenuItem;
    SGTK0PanelCenter: TSGTK0Panel;
    SGTK0ScrollbarScroll: TSGTK0Scrollbar;
    Cubic1: TMenuItem;
    Cubic2: TMenuItem;
    Cosine1: TMenuItem;
    CatmullRom1: TMenuItem;
    Cosine2: TMenuItem;
    CatmullRom2: TMenuItem;
    N1: TMenuItem;
    Nodesize1: TMenuItem;
    N11: TMenuItem;
    N41: TMenuItem;
    N81: TMenuItem;
    N151: TMenuItem;
    N321: TMenuItem;
    N641: TMenuItem;
    N2: TMenuItem;
    Markstart1: TMenuItem;
    Markend1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete2: TMenuItem;
    Clear1: TMenuItem;
    SGTK0ScrollbarNegValue: TSGTK0Scrollbar;
    SGTK0ScrollbarPosValue: TSGTK0Scrollbar;
    SGTK0ScrollbarZoom: TSGTK0Scrollbar;
    N4: TMenuItem;
    Dump1: TMenuItem;
    N5: TMenuItem;
    SetLoopStart1: TMenuItem;
    Setloopend1: TMenuItem;
    N6: TMenuItem;
    Markassustainloopstart1: TMenuItem;
    Markassustainloopend1: TMenuItem;
    N7: TMenuItem;
    Deleteloop1: TMenuItem;
    Deletesustainloop1: TMenuItem;
    N8: TMenuItem;
    Lock1: TMenuItem;
    SGTK0Menu1: TSGTK0Menu;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EnvelopeImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EnvelopeImageMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure EnvelopeImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Delete1Click(Sender: TObject);
    procedure InterpolationModeClick(Sender: TObject);
    procedure PanelImageResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBoxImagePaint(Sender: TObject);
    procedure InterpolationModeAllClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Insert1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Markstart1Click(Sender: TObject);
    procedure Markend1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure SGTK0ScrollbarScrollScroll(Sender: TObject; ScrollPos: Integer);
    procedure SGTK0ScrollbarZoomScroll(Sender: TObject; ScrollPos: Integer);
    procedure SGTK0ScrollbarNegValueScroll(Sender: TObject;
      ScrollPos: Integer);
    procedure SGTK0ScrollbarPosValueScroll(Sender: TObject;
      ScrollPos: Integer);
    procedure Dump1Click(Sender: TObject);
    procedure Setloopstart1Click(Sender: TObject);
    procedure Setloopend1Click(Sender: TObject);
    procedure Markassustainloopstart1Click(Sender: TObject);
    procedure Markassustainloopend1Click(Sender: TObject);
    procedure DeleteLoopButtonClick(Sender: TObject);
    procedure DeleteSustainLoopButtonClick(Sender: TObject);
    procedure Lock1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    AudioCriticalSection:TBeRoCriticalSection;
    DataCriticalSection:TBeRoCriticalSection;
    Form:TForm;
    ScrollPosition:INTEGER;
    OK:BOOLEAN;
    Envelope:PSynthEnvelope;
    EnvelopeInstanceTick:integer;
    CurrentNode:INTEGER;
    NodesXY:ARRAY[0..MaxEnvelopeNodes-1] OF TPoint;
    LastNodeNumber:INTEGER;
    PopupNodeNumber:INTEGER;
    LastInterpolation:byte;
    MoveNode:BOOLEAN;
    BufferBitmap:TBitmap;
    BaseValue:INTEGER;
    EnvelopeScale:INTEGER;
    XScale:INTEGER;
    AlignInterval:integer;
    Align2Interval:integer;
    NodeStart:integer;
    NodeEnd:integer;
    Nodes:TEnvelopeNodes;
    procedure DuplicateNodes;
    procedure DrawView;
    function FindNodeAtXY(X,Y:INTEGER):INTEGER;
    procedure TestActive;
    procedure UpdateEnv;
  end;

var
  EnvelopeForm: TEnvelopeForm;

const eiNONE=0;
      eiLINEAR=1;
      SelectBoxHalfSize:integer=4;

implementation

{$R *.DFM}

uses UnitVSTiEditor;

const ScrollFactor=1;
      TimeFactor=100;

procedure TEnvelopeForm.FormCreate(Sender: TObject);
begin
 try
  DoubleBuffered:=FALSE;
  AlignInterval:=1;
  Align2Interval:=1;
  EnvelopeInstanceTick:=0;
  AudioCriticalSection:=NIL;
  DataCriticalSection:=NIL;
  Envelope:=NIL;
  Nodes:=nil;
  NodeStart:=-1;
  NodeEnd:=-1;
  LastNodeNumber:=-1;
  PopupNodeNumber:=-1;
  CurrentNode:=-1;
  LastInterpolation:=1;
  MoveNode:=FALSE;
  BaseValue:=255;
  EnvelopeScale:=1;
  BufferBitmap:=TBitmap.Create;
  BufferBitmap.PixelFormat:=pf32Bit;
  BufferBitmap.HandleType:=bmDIB;
  SGTK0ScrollbarZoom.Track.Caption:='Zoom';
  SGTK0ScrollbarScroll.Track.Caption:='Scroll';
  SGTK0ScrollbarNegValue.Track.Caption:='-1';
  SGTK0ScrollbarPosValue.Track.Caption:='+1';
 {LoopStart:=-1;
  LoopEnd:=-1;
  SustainLoopStart:=-1;
  SustainLoopEnd:=-1;}
 except
 end;
end;

procedure TEnvelopeForm.OKButtonClick(Sender: TObject);
begin
 try
  OK:=true;
  CLOSE;
 except
 end;
end;

procedure TEnvelopeForm.CancelButtonClick(Sender: TObject);
begin
 try
  OK:=FALSE;
  CLOSE;
 except
 end;
end;

procedure TEnvelopeForm.FormShow(Sender: TObject);
begin
 try
  OK:=FALSE;
  LastNodeNumber:=-1;
  PopupNodeNumber:=-1;
  CurrentNode:=-1;
  XScale:=1;
  MoveNode:=FALSE;
  DrawView;
 except
 end;
end;

procedure TEnvelopeForm.DrawView;
var NodeCounter,XC,X,Y,LX,LY:INTEGER;
    T,InvXScale:double;
 procedure PutPixel(X,Y:INTEGER;Color,Alpha:LONGWORD);
 var P:^LONGWORD;
 begin
  if (X<0) or (X>=BufferBitmap.Width) or (Y<0) or (Y>=BufferBitmap.Height) then exit;
  P:=BufferBitmap.ScanLine[Y];
  inc(P,X);
  Color:=(Alpha shl 24) or ((Color and $ff) shl 16) or (((Color shr 8) and $ff) shl 8) or (((Color shr 16) and $ff) shl 0);
  p^:=(((p^ and $00ff00ff)+(((((Color and $00ff00ff)-(p^ and $00ff00ff))*(Color shr 24))+$00800080) div 256)) and $00ff00ff) or
      (((p^ and $0000ff00)+(((((Color and $0000ff00)-(p^ and $0000ff00))*(Color shr 24))+$00008000) div 256)) and $0000ff00);{ or
      ((((Color shr 24)+(p^ shr 24))-((((Color shr 24)*(p^ shr 24))+255) shr 8)) shl 24)};
 end;
 procedure AALine(X1,Y1,X2,Y2:INTEGER;Color:LONGWORD);
 const AAlevels=256;
       AAbits=8;
 var xx0,yy0,xx1,yy1,dx,dy,tmp,xdir,y0p1,x0pxdir,i:integer;
     intshift,erracc,erradj,erracctmp,wgt{,wgtcompmask}:longword;
 begin
  // Keep on working with 32bit numbers
  xx0:=x1;
  yy0:=y1;
  xx1:=x2;
  yy1:=y2;

  // Reorder points if required
  if yy0>yy1 then begin
   tmp:=yy0;
   yy0:=yy1;
   yy1:=tmp;
   tmp:=xx0;
   xx0:=xx1;
   xx1:=tmp;
  end;

  // Calculate distance
  dx:=xx1-xx0;
  dy:=yy1-yy0;

  // Adjust for negative dx and set xdir
  if dx>=0 then begin
   xdir:=1;
  end else begin
   xdir:=-1;
   dx:=-dx;
  end;

  // Check for special cases
  if dx=0 then begin
   // Vertical line
   if Y1<Y2 then begin
    for I:=Y1 to Y2 do begin
     PutPixel(X1,I,Color,255);
    end;
   end else begin
    for I:=Y2 downto Y1 do begin
     PutPixel(X1,I,Color,255);
    end;
   end;
  end else if dy=0 then begin
   // Horizontal line
   if x1<x2 then begin
    for I:=X1 to X2 do begin
     PutPixel(I,y1,Color,255);
    end;
   end else begin
    for I:=X2 downto X1 do begin
     PutPixel(I,y1,Color,255);
    end;
   end;
  end else if dx=dy then begin
   // Diagonal line
   x:=xx0;
   for I:=yy0 to yy1 do begin
    PutPixel(X,I,Color,255);
    inc(x,xdir);
   end;
  end else begin
   // Line is not horizontal, vertical or diagonal

   // Zero accumulator
   erracc:=0;

   /// number of bits by which to shift erracc to get intensity level
   intshift:=32-AAbits;

   // Mask used to flip all bits in an intensity weighting
// wgtcompmask:=AAlevels-1;

   // Draw the initial pixel in the foreground color
   PutPixel(x1,y1,Color,255);

   // x-major or y-major?
   if dy>dx then begin
    // y-major. Calculate 16-bit fixed point fractional part of a pixel that
    // X advances every Time Y advances 1 pixel, truncating the result so that
    // we won't overrun the endpoint along the X axis

    // not-so-portable version: erradj:=(int64(dx) shl 32) div int64(dy);
    erradj:=(int64(dx) shl 32) div int64(dy);
//  erradj:=((dx shl 16) div dy) div 16;

    // draw all pixels other than the first and last
    x0pxdir:=xx0+xdir;
    for i:=dy downto 1 do begin
     erracctmp:=erracc;
     inc(erracc,erradj);
     if erracc<=erracctmp then begin
      // rollover in error accumulator, x coord advances
      xx0:=x0pxdir;
      inc(x0pxdir,xdir);
     end;
     inc(yy0); // y-major so always advance Y

     // the AAbits most significant bits of erracc give us the intensity
     // weighting for this pixel, and the complement of the weighting for
     // the paired pixel.
     wgt:=(erracc shr intshift) and $ff;
     PutPixel(xx0,yy0,Color,255-wgt);
     PutPixel(x0pxdir,yy0,Color,wgt);
    end;
   end else begin
    // x-major line. Calculate 16-bit fixed-point fractional part of a pixel
    // that Y advances each Time X advances 1 pixel, truncating the result so
    // that we won't overrun the endpoint along the X axis.

    // not-so-portable version: erradj:=(int64(dy) shl 32) div int64(dx);
    erradj:=(int64(dy) shl 32) div int64(dx);
//  erradj:=((dy shl 16) div dx) div 16;

    // draw all pixels other than the first and last
    y0p1:=yy0+1;
    for i:=dx downto 1 do begin
     erracctmp:=erracc;
     inc(erracc,erradj);
     if erracc<=erracctmp then begin
      // Accumulator turned over, advance y
      yy0:=y0p1;
      inc(y0p1);
     end;
     inc(xx0,xdir); // x-major so always advance X

     // the AAbits most significant bits of erracc give us the intensity
     // weighting for this pixel, and the complement of the weighting for
     // the paired pixel.
     wgt:=(erracc shr intshift) and $ff;
     PutPixel(xx0,yy0,Color,255-wgt);
     PutPixel(xx0,y0p1,Color,wgt);
    end;
   end;

   // Draw final pixel, always exactly intersected by the line and doesn't
   // need to be weighted.
   PutPixel(x2,y2,Color,255);
  end;
 end;
 procedure AALineClip(X0,Y0,X1,Y1,XMin,XMax,YMin,YMax:double;Color:LONGWORD);
 TYPE Edge=(LEFT,RIGHT,BOTTOM,TOP);
      OutCode=SET OF Edge;
 var Accept:BOOLEAN;
     Outcode0,Outcode1,OutcodeOut:OutCode;
     X,Y:double;
  procedure CompOutCode(X,Y:single;var Code:OutCode);
  begin
   if Y>YMax then begin
    Code:=[TOP];
   end else if Y<YMin then begin
    Code:=[BOTTOM];
   end else begin
    Code:=[];
   end;
   if X>XMax then begin
    Code:=Code+[RIGHT];
   end else if X<XMin then begin
    Code:=Code+[LEFT];
   end;
  end;
 begin
  Accept:=FALSE;
  X:=0;
  Y:=0;
  CompOutCode(X0,Y0,Outcode0);
  CompOutCode(X1,Y1,Outcode1);
  while true do begin
   if (Outcode0=[]) and (Outcode1=[]) then begin
    Accept:=true;
    break;
   end else if (Outcode0*Outcode1)<>[] then begin
    break;
   end else begin
    if Outcode0<>[] then begin
     OutcodeOut:=Outcode0;
    end else begin
     OutcodeOut:=Outcode1;
    end;
    if TOP IN OutcodeOut then begin
     X:=X0+(X1-X0)*(YMax-Y0)/(Y1-Y0);
     Y:=YMax;
    end;
    if BOTTOM IN OutcodeOut then begin
     X:=X0+(X1-X0)*(YMin-Y0)/(Y1-Y0);
     Y:=YMax;
    end else if RIGHT IN OutcodeOut then begin
     Y:=Y0+(Y1-Y0)*(XMax-X0)/(X1-X0);
     X:=XMax;
    end else if LEFT IN OutcodeOut then begin
     Y:=Y0+(Y1-Y0)*(XMin-X0)/(X1-X0);
     X:=XMin;
    end;
    if OutcodeOut=Outcode0 then begin
     X0:=X;
     Y0:=Y;
     CompOutCode(X0,Y0,Outcode0);
    end else begin
     X1:=X;
     Y1:=Y;
     CompOutCode(X1,Y1,Outcode1);
    end
   end;
  end;
  if Accept then begin
   AALine(round(X0),round(Y0),round(X1),round(Y1),Color);
  end;
 end;
 procedure AALineTo(DX,DY:INTEGER);
 var P1,P2:TPoint;
 begin
  P1:=BufferBitmap.Canvas.PenPos;
  P2:=Point(DX,DY);
  //AALine(P1.X,P1.Y,P2.X,P2.Y,BufferBitmap.Canvas.Pen.Color);
  AALineClip(P1.X,P1.Y,P2.X,P2.Y,0,BufferBitmap.Width-1,0,BufferBitmap.Height-1,BufferBitmap.Canvas.Pen.Color);
  BufferBitmap.Canvas.PenPos:=P2;
 end;
var S:string;
begin
 if assigned(Envelope) then begin
  try
   if (BufferBitmap.Width<>PaintBoxImage.ClientWidth) or (BufferBitmap.Height<>PaintBoxImage.ClientHeight) then begin
    BufferBitmap.Height:=0;
    BufferBitmap.Width:=PaintBoxImage.ClientWidth;
    BufferBitmap.Height:=PaintBoxImage.ClientHeight;
   end;
   if SGTK0ScrollbarNegValue.Position<>(255-Envelope^.NegValue) then begin
    SGTK0ScrollbarNegValue.Position:=255-Envelope^.NegValue;
   end;
   if SGTK0ScrollbarPosValue.Position<>(255-Envelope^.PosValue) then begin
    SGTK0ScrollbarPosValue.Position:=255-Envelope^.PosValue;
   end;
   XScale:=EnvelopeScale;
   InvXScale:=1/XScale;
   with BufferBitmap.Canvas do begin
    Brush.Style:=bsSolid;
    Pen.Style:=psSolid;
    Brush.Color:=TVSTiEditor(Form).TranslateColor($202020);
    Pen.Color:=TVSTiEditor(Form).TranslateColor($202020);
    FillRect(ClipRect);
    begin
     IF Focused THEN BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($383838);
     END ELSE BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($282828);
     END;
     X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale));
     while X<=BufferBitmap.Width do begin
      if x>=0 then begin
       MoveTo(X,10);
       LineTo(X,BufferBitmap.Height-10);
      end;
      inc(X,XScale);
     end;
     IF Focused THEN BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($484848);
     END ELSE BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($383838);
     END;
     X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale));
     while X<=BufferBitmap.Width do begin
      if x>=0 then begin
       MoveTo(X,10);
       LineTo(X,BufferBitmap.Height-10);
      end;
      inc(X,10*XScale);
     end;
     IF Focused THEN BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($585858);
     END ELSE BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($484848);
     END;
     X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale));
     while X<=BufferBitmap.Width do begin
      if x>=0 then begin
       MoveTo(X,10);
       LineTo(X,BufferBitmap.Height-10);
      end;
      inc(X,100*XScale);
     end;
     IF Focused THEN BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($686868);
     END ELSE BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($585858);
     END;
     X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale));
     while X<=BufferBitmap.Width do begin
      if x>=0 then begin
       MoveTo(X,10);
       LineTo(X,BufferBitmap.Height-10);
      end;
      inc(X,1000*XScale);
     end;
    end;
    IF Focused THEN BEGIN
     Pen.Color:=TVSTiEditor(Form).TranslateColor($666666);
    END ELSE BEGIN
     Pen.Color:=TVSTiEditor(Form).TranslateColor($444444);
    END;
    MoveTo(0,10);
    LineTo(BufferBitmap.Width,10);
    Y:=(((255-BaseValue)*(BufferBitmap.Height-20)) div 255)+10;
    MoveTo(0,Y);
    LineTo(BufferBitmap.Width,Y);
    MoveTo(0,BufferBitmap.Height-10);
    LineTo(BufferBitmap.Width,BufferBitmap.Height-10);
    MoveTo(10-(ScrollPosition*ScrollFactor*EnvelopeScale),10);
    LineTo(10-(ScrollPosition*ScrollFactor*EnvelopeScale),BufferBitmap.Height-10);
 {  if assigned(Envelope) and (Envelope^.Time>=0) then begin
     Pen.Color:=$2480DB;
     X:=round((10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(Envelope^.Time*XScale));
     MoveTo(x,10);
     LineTo(x,BufferBitmap.Height-10);
    end;}
    for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
     X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(Envelope^.Nodes^[NodeCounter].Time*XScale);
     Y:=(((255-Envelope^.Nodes^[NodeCounter].Value)*(BufferBitmap.Height-20)) div 255)+10;
     NodesXY[NodeCounter].X:=X;
     NodesXY[NodeCounter].Y:=Y;
    end;
    FOR NodeCounter:=0 TO Envelope^.NodesCount-1 DO BEGIN
     X:=NodesXY[NodeCounter].X;
     IF (Envelope^.LoopStart=NodeCounter) OR (Envelope^.LoopEnd=NodeCounter) THEN BEGIN
      IF Focused THEN BEGIN
       Pen.Color:=TVSTiEditor(Form).TranslateColor($cccccc);
      END ELSE BEGIN
       Pen.Color:=TVSTiEditor(Form).TranslateColor($aaaaaa);
      END;
      MoveTo(X,10);
      LineTo(X,BufferBitmap.Height-10);
     END ELSE IF (Envelope^.SustainLoopStart=NodeCounter) OR (Envelope^.SustainLoopEnd=NodeCounter) THEN BEGIN
      IF Focused THEN BEGIN
       Pen.Color:=TVSTiEditor(Form).TranslateColor($888888);
      END ELSE BEGIN
       Pen.Color:=TVSTiEditor(Form).TranslateColor($666666);
      END;
      MoveTo(X,10);
      LineTo(X,BufferBitmap.Height-10);
     END;
    END;
 {  for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
     X:=NodesXY[NodeCounter].X;
     if Envelope^.Header.SustainPoint=NodeCounter then begin
      Pen.Color:=$85B3E0;
      MoveTo(X,10);
      LineTo(X,BufferBitmap.Height-10);
     end;
    end;}
    if Envelope^.NodesCount>0 then begin
     Pen.Color:=$C5C2A8;
 (*  for I:=0 to Envelope^.Nodes^[Envelope^.NodesCount-1].Time do begin
 ///     EI.Time:=I;
      X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(I*XScale);
      Y:=0;//Y:=(((255-round(EnvGetValueDraw(ProcessEnvelope(EI,Envelope^,true,1,edb))*255))*(BufferBitmap.Height-20)) div 255)+10;
      if I=0 then begin
       MoveTo(X,Y);
      end else begin
       LineTo(X,Y);
      end;
     end;   *)
  {  Pen.Color:=$C5C2A8;
   //XC:=0;
     LX:=0;
     LY:=0;
     for NodeCounter:=0 to Envelope^.Header.NodesCount-1 do begin
      ProcessEnvelope
      X:=NodesXY[NodeCounter].X;
      Y:=(((255-round(EnvGetValueDraw(Envelope^.Nodes^[NodeCounter].Value)*255))*(BufferBitmap.Height-20)) div 255)+10;
      if (NodeCounter=0) or Envelope^.Nodes^[NodeCounter-1].Interpolation then begin
       if NodeCounter=0 then begin
        MoveTo(X,Y);
       end else begin
        AALineTo(X,Y);
       end;
      end else begin
       if NodeCounter=0 then begin
        LX:=X;
        LY:=Y;
       end;
       MoveTo(LX,LY);
       AALineTo(X,LY);
       AALineTo(X,Y);
      end;
      LX:=X;
      LY:=Y;
   // XC:=Envelope^.Nodes^[NodeCounter].Time;
     end;{}
    end;
    if ((assigned(Envelope) and ((NodeStart>=0) and (NodeEnd>=0))) and (NodeStart<=NodeEnd)) and ((NodeStart<Envelope^.NodesCount) and (NodeEnd<Envelope^.NodesCount)) then begin
     Brush.Style:=bsClear;
     IF Focused THEN BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($dddddd);
     END ELSE BEGIN
      Pen.Color:=TVSTiEditor(Form).TranslateColor($777777);
     END;
     Pen.Width:=2;
     Y:=5;
     MoveTo((10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(Envelope^.Nodes^[NodeStart].Time*XScale),Y);
     LineTo((10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(Envelope^.Nodes^[NodeEnd].Time*XScale),Y);
     Y:=BufferBitmap.Height-5;
     MoveTo((10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(Envelope^.Nodes^[NodeStart].Time*XScale),Y);
     LineTo((10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(Envelope^.Nodes^[NodeEnd].Time*XScale),Y);
     Pen.Width:=1;
    end;
    IF Focused THEN BEGIN
     Pen.Color:=TVSTiEditor(Form).TranslateColor($ffffff);
    END ELSE BEGIN
     Pen.Color:=TVSTiEditor(Form).TranslateColor($888888);
    END;
  //XC:=0;
    LX:=0;
    LY:=0;
    for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
     X:=NodesXY[NodeCounter].X;
     Y:=NodesXY[NodeCounter].Y;
     if NodeCounter=0 then begin
      MoveTo(X,Y);
     end else begin
      case Envelope^.Nodes^[NodeCounter].Interpolation of
       0:begin
        MoveTo(LX,LY);
        LineTo(X,LY);
        LineTo(X,Y);
       end;
       1:begin
        AALineTo(X,Y);
       end;
       else begin
        for XC:=LX to X do begin
         T:=(XC-(10-(ScrollPosition*ScrollFactor*EnvelopeScale)))*InvXScale;
         Y:=trunc(((1.0-SynthEnvelopeGetValue(Envelope,min(max(T,Envelope^.Nodes^[NodeCounter-1].Time),Envelope^.Nodes^[NodeCounter].Time)))*(BufferBitmap.Height-20))+10);
         LineTo(XC,Y);
        end;
       end;
      end;
     end;
     LX:=X;
     LY:=Y;
  // XC:=Envelope^.Nodes^[NodeCounter].Time;
    end;
 {  if Envelope^.NodesCount>0 then begin
     MoveTo(NodesXY[0].X,NodesXY[0].Y);
     for XC:=0 to Envelope^.Nodes^[Envelope^.NodesCount-1].Time do begin
      X:=(10-(ScrollPosition*ScrollFactor*EnvelopeScale))+(XC*XScale);
      Y:=trunc(((1.0-GetValue(Envelope,XC))*(BufferBitmap.Height-20))+10);
      LineTo(X,Y);
     end;
    end;}
    Brush.Style:=bsClear;
    Font.Color:=Pen.Color;
    if Dump1.Checked then begin
     for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
      X:=NodesXY[NodeCounter].X;
      Y:=NodesXY[NodeCounter].Y;
      begin
       STR((Envelope^.Nodes^[NodeCounter].Value/255):1:2,S);
       if POS('.',S)>0 then begin
        while (LENGTH(S)>0) and (S[LENGTH(S)]='0') do begin
         DELETE(S,LENGTH(S),1);
        end;
        if (LENGTH(S)>0) and (S[LENGTH(S)]='.') then begin
         DELETE(S,LENGTH(S),1);
        end;
       end;
       S:='V:'+S;
       TextOut(X-((TextWidth(S) div 2)),Y-((TextHeight(S)*2)+SelectBoxHalfSize),S);
       TextOut(X-((TextWidth(S) div 2)),Y+(TextHeight(S)+SelectBoxHalfSize),S);
      end;
      S:='X:'+INTTOSTR(Envelope^.Nodes^[NodeCounter].Time);
      TextOut(X-((TextWidth(S) div 2)),Y-(TextHeight(S)+SelectBoxHalfSize),S);
      S:='Y:'+INTTOSTR(Envelope^.Nodes^[NodeCounter].Value);
      TextOut(X-((TextWidth(S) div 2)),Y+SelectBoxHalfSize,S);
     end;
    end;
    Pen.Color:=clWhite;
    {if not FormMain.CheckBoxSceneEnvelopeRaw.Checked then} begin
     for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
      X:=NodesXY[NodeCounter].X;
      Y:=NodesXY[NodeCounter].Y;
      if NodeCounter=CurrentNode then begin
       Pen.Width:=3;
       IF Focused THEN BEGIN
        Pen.Color:=TVSTiEditor(Form).TranslateColor($ffffff);
        Brush.Color:=TVSTiEditor(Form).TranslateColor($888888);
       END ELSE BEGIN
        Pen.Color:=TVSTiEditor(Form).TranslateColor($888888);
        Brush.Color:=TVSTiEditor(Form).TranslateColor($444444);
       END;
      end else begin
       Pen.Width:=1;
       IF Focused THEN BEGIN
        Pen.Color:=TVSTiEditor(Form).TranslateColor($999999);
        Brush.Color:=TVSTiEditor(Form).TranslateColor($666666);
       END ELSE BEGIN
        Pen.Color:=TVSTiEditor(Form).TranslateColor($666666);
        Brush.Color;
       end;
      end;
      Rectangle(X-SelectBoxHalfSize,Y-SelectBoxHalfSize,X+SelectBoxHalfSize,Y+SelectBoxHalfSize);
     end;
    end;
    Brush.Color:=TVSTiEditor(Form).TranslateColor($202020);
    Pen.Width:=1;
   end;
   PaintBoxImage.Canvas.CopyRect(BufferBitmap.Canvas.ClipRect,BufferBitmap.Canvas,BufferBitmap.Canvas.ClipRect);
  except
  end;
 end;
end;

function TEnvelopeForm.FindNodeAtXY(X,Y:INTEGER):INTEGER;
var NodeCounter:INTEGER;
begin
 result:=-1;
 try
  if not assigned(Envelope) then exit;
  for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
   if ((NodesXY[NodeCounter].X-SelectBoxHalfSize)<=X) and
      ((NodesXY[NodeCounter].Y-SelectBoxHalfSize)<=Y) and
      ((NodesXY[NodeCounter].X+SelectBoxHalfSize)>=X) and
      ((NodesXY[NodeCounter].Y+SelectBoxHalfSize)>=Y) then begin
    result:=NodeCounter;
   end;
  end;
 except
 end;
end;

procedure TEnvelopeForm.EnvelopeImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var NodeNumber:INTEGER;
    NodeCounter:INTEGER;
    Time:INTEGER;
    Value:INTEGER;
    DoPopup:boolean;
begin
 DoPopup:=false;
 try
  if not assigned(Envelope) then exit;
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   TRY
    ActiveControl:=nil;
    SetFocus;
    NodeNumber:=FindNodeAtXY(X,Y);
    CASE Button OF
     mbLeft:begin
      if (NodeNumber<0) and ((Envelope^.NodesCount+1)<MaxEnvelopeNodes) and not Lock1.Checked then begin
       if (X>=(10-(ScrollPosition*ScrollFactor*EnvelopeScale))) and (Y>=10) and (Y<=(BufferBitmap.Height-10)) then begin
        Time:=(X-(10-(ScrollPosition*ScrollFactor*EnvelopeScale))) div XScale;
        if AlignInterval>1 then begin
         Time:=round(Time/AlignInterval)*AlignInterval;
        end;
//      if Time>32767 then Time:=32767;
        Value:=255-(((Y-10)*255) div (BufferBitmap.Height-20));
        if Align2Interval>1 then begin
         Value:=round(Value/Align2Interval)*Align2Interval;
        end;
        if Value<0 then begin
         Value:=0;
        end else if Value>255 then begin
         Value:=255;
        end;
        if (not assigned(Envelope)) or (Envelope^.NodesCount=0) then begin
         Envelope^.NodesCount:=2;
         if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
          SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
         end;
         Envelope^.Nodes^[0].Time:=0;
         Envelope^.Nodes^[0].Value:=Value;
         Envelope^.Nodes^[0].Interpolation:=LastInterpolation;
         Envelope^.Nodes^[1].Time:=Time;
         Envelope^.Nodes^[1].Value:=Value;
         Envelope^.Nodes^[1].Interpolation:=LastInterpolation;
         NodeNumber:=1;
        end else begin
         NodeNumber:=-1;
         for NodeCounter:=0 to Envelope^.NodesCount-1 do begin
          if Envelope^.Nodes^[NodeCounter].Time<Time then begin
           NodeNumber:=NodeCounter+1;
          end;
         end;
         if NodeNumber<0 then begin
          if Envelope^.NodesCount<MaxEnvelopeNodes then begin
           NodeNumber:=Envelope^.NodesCount;
           inc(Envelope^.NodesCount);
           if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
            SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
           end;
          end;
         end else begin
          inc(Envelope^.NodesCount);
          if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
           SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
          end;
          NodeCounter:=Envelope^.NodesCount;
          while NodeCounter>NodeNumber do begin
           if (NodeCounter>0) and (NodeCounter<MaxEnvelopeNodes) then begin
            Envelope^.Nodes^[NodeCounter]:=Envelope^.Nodes^[NodeCounter-1];
           end;
           dec(NodeCounter);
          end;
         end;
         if NodeNumber>=0 then begin
          IF (Envelope^.LoopStart>=0) AND (Envelope^.LoopStart>=NodeNumber) THEN BEGIN
           INC(Envelope^.LoopStart);
          END;
          IF (Envelope^.LoopEnd>=0) AND (Envelope^.LoopEnd>=NodeNumber) THEN BEGIN
           INC(Envelope^.LoopEnd);
          END;
          IF (Envelope^.SustainLoopStart>=0) AND (Envelope^.SustainLoopStart>=NodeNumber) THEN BEGIN
           INC(Envelope^.SustainLoopStart);
          END;
          IF (Envelope^.SustainLoopEnd>=0) AND (Envelope^.SustainLoopEnd>=NodeNumber) THEN BEGIN
           INC(Envelope^.SustainLoopEnd);
          END;
          IF (Envelope^.LoopStart<0) OR (Envelope^.LoopStart>=INTEGER(Envelope^.NodesCount)) OR
             (Envelope^.LoopEnd<0) OR (Envelope^.LoopEnd>=INTEGER(Envelope^.NodesCount)) THEN BEGIN
           Envelope^.LoopStart:=-1;
           Envelope^.LoopEnd:=-1;
          END;
          IF (Envelope^.SustainLoopStart<0) OR (Envelope^.SustainLoopStart>=INTEGER(Envelope^.NodesCount)) OR
             (Envelope^.SustainLoopEnd<0) OR (Envelope^.SustainLoopEnd>=INTEGER(Envelope^.NodesCount)) THEN BEGIN
           Envelope^.SustainLoopStart:=-1;
           Envelope^.SustainLoopEnd:=-1;
          END;
          Envelope^.Nodes^[NodeNumber].Time:=Time;
          Envelope^.Nodes^[NodeNumber].Value:=Value;
          Envelope^.Nodes^[NodeNumber].Interpolation:=LastInterpolation;
         end;
        end;
        SynthEnvelopeSort(Envelope,@NodeNumber);
        LastNodeNumber:=NodeNumber;
        CurrentNode:=NodeNumber;
        MoveNode:=true;
//      Envelope^.Dirty:=true;
//      Project.Dirty:=true;
       end;
      end else begin
       LastNodeNumber:=NodeNumber;
       CurrentNode:=NodeNumber;
       MoveNode:=NodeNumber>=0;
      end;
     end;
     mbRight:begin
      if NodeNumber>=0 then begin
       PopupNodeNumber:=NodeNumber;
       CurrentNode:=NodeNumber;
       DoPopup:=true;
      end;
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  ActiveControl:=NIL;
  SetFocus;
  DrawView;
  UpdateEnv;
  if DoPopup then begin
   PopupMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;
 finally
 end;
end;

procedure TEnvelopeForm.EnvelopeImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var NodeNumber:INTEGER;
    Time:INTEGER;
    Value:INTEGER;
    Redraw,Valid:BOOLEAN;
begin
 try
  if not assigned(Envelope) then exit;
  Redraw:=FALSE;
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   TRY
    if MoveNode and (LastNodeNumber>=0) then begin
     if X>=(10-(ScrollPosition*ScrollFactor*EnvelopeScale)) then begin
      Time:=(X-(10-(ScrollPosition*ScrollFactor*EnvelopeScale))) div XScale;
      if AlignInterval>1 then begin
       Time:=round(Time/AlignInterval)*AlignInterval;
      end;
      Valid:=(Envelope^.Nodes^[LastNodeNumber-1].Time<Time);// and (Time<32768);
      if (LastNodeNumber+1)<Envelope^.NodesCount then begin
       Valid:=Valid and (Envelope^.Nodes^[LastNodeNumber+1].Time>Time);
      end;
      if (LastNodeNumber>0) and Valid then begin
       Envelope^.Nodes^[LastNodeNumber].Time:=Time;
{      Envelope^.Dirty:=true;
       Project.Dirty:=true;}
       Redraw:=true;
      end;
     end;
     if (Y>=10) and (Y<=(BufferBitmap.Height-10)) then begin
      Value:=255-(((Y-10)*255) div (BufferBitmap.Height-20));
      if Align2Interval>1 then begin
       Value:=round(Value/Align2Interval)*Align2Interval;
      end;
      if Value<0 then begin
       Value:=0;
      end else if Value>255 then begin
       Value:=255;
      end;
      Envelope^.Nodes^[LastNodeNumber].Value:=Value;
{     Envelope^.Dirty:=true;
      Project.Dirty:=true;}
      Redraw:=true;
     end;
     if Redraw then begin
      NodeNumber:=CurrentNode;
      Value:=Envelope^.Nodes^[NodeNumber].Time;
      if Envelope^.NodesCount=0 then begin
       ScrollPosition:=0;
      end else begin
       while Value<ScrollPosition do begin
        dec(ScrollPosition);
        if ScrollPosition<0 then begin
         ScrollPosition:=0;
         break;
        end;
       end;
       while (Value*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
        inc(ScrollPosition);
       end;
      end;
      SGTK0ScrollbarScroll.Position:=ScrollPosition;
     end;
    end;
   finally
    DataCriticalSection.Leave;
   end;
  end;
  if Redraw then begin
   DrawView;
   UpdateEnv;
  end;
  NodeNumber:=FindNodeAtXY(X,Y);
  if NodeNumber>=0 then begin
   PaintBoxImage.Cursor:=crHandPoint;
  end else begin
   PaintBoxImage.Cursor:=crDefault;
  end;
 finally
 end;
end;

procedure TEnvelopeForm.EnvelopeImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 try
  if not assigned(Envelope) then exit;
  ActiveControl:=NIL;
  SetFocus;
  LastNodeNumber:=-1;
  if MoveNode then begin
   UpdateEnv;
  end;
  MoveNode:=FALSE;
 except
 end;
end;

procedure TEnvelopeForm.Delete1Click(Sender: TObject);
var NodeCounter:INTEGER;
    NodeNumber:INTEGER;
    Value:integer;
begin
 try
  if not assigned(Envelope) then exit;
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   TRY
    NodeNumber:=CurrentNode;
    PopupNodeNumber:=-1;
    if (NodeNumber>0) or ((NodeNumber=0) and (Envelope^.NodesCount=1)) then begin
     IF (Envelope^.LoopStart>=0) AND (Envelope^.LoopStart>=NodeNumber) THEN BEGIN
      DEC(Envelope^.LoopStart);
     END;
     IF (Envelope^.LoopEnd>=0) AND (Envelope^.LoopEnd>=NodeNumber) THEN BEGIN
      DEC(Envelope^.LoopEnd);
     END;
     IF (Envelope^.SustainLoopStart>=0) AND (Envelope^.SustainLoopStart>=NodeNumber) THEN BEGIN
      DEC(Envelope^.SustainLoopStart);
     END;
     IF (Envelope^.SustainLoopEnd>=0) AND (Envelope^.SustainLoopEnd>=NodeNumber) THEN BEGIN
      DEC(Envelope^.SustainLoopEnd);
     END;
     IF (Envelope^.LoopStart<0) OR (Envelope^.LoopStart>=INTEGER(Envelope^.NodesCount)) OR
        (Envelope^.LoopEnd<0) OR (Envelope^.LoopEnd>=INTEGER(Envelope^.NodesCount)) THEN BEGIN
      Envelope^.LoopStart:=-1;
      Envelope^.LoopEnd:=-1;
     END;
     IF (Envelope^.SustainLoopStart<0) OR (Envelope^.SustainLoopStart>=INTEGER(Envelope^.NodesCount)) OR
        (Envelope^.SustainLoopEnd<0) OR (Envelope^.SustainLoopEnd>=INTEGER(Envelope^.NodesCount)) THEN BEGIN
      Envelope^.SustainLoopStart:=-1;
      Envelope^.SustainLoopEnd:=-1;
     END;
     NodeCounter:=NodeNumber;
     while NodeCounter<(Envelope^.NodesCount-1) do begin
      if NodeCounter<MaxEnvelopeNodes then begin
       Envelope^.Nodes^[NodeCounter]:=Envelope^.Nodes^[NodeCounter+1];
      end;
      inc(NodeCounter);
     end;
     dec(Envelope^.NodesCount);
     if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
      SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
     end;
     if Envelope^.NodesCount<=CurrentNode then begin
      CurrentNode:=Envelope^.NodesCount-1;
     end;
     NodeNumber:=CurrentNode;
     Value:=Envelope^.Nodes^[NodeNumber].Time;
     if Envelope^.NodesCount=0 then begin
      ScrollPosition:=0;
     end else begin
      while Value<ScrollPosition do begin
       dec(ScrollPosition);
       if ScrollPosition<0 then begin
        ScrollPosition:=0;
        break;
       end;
      end;
      while (Value*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
       inc(ScrollPosition);
      end;
     end;
     SGTK0ScrollbarScroll.Position:=ScrollPosition;
{    Envelope^.Dirty:=true;
     Project.Dirty:=true;}
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  DrawView;
  UpdateEnv;
 finally
 end;
end;

procedure TEnvelopeForm.InterpolationModeClick(Sender: TObject);
var NodeNumber:INTEGER;
begin
 try
  if not assigned(Envelope) then exit;
  if assigned(DataCriticalSection) then begin
   DataCriticalSection.Enter;
   TRY
    NodeNumber:=CurrentNode;
    PopupNodeNumber:=-1;
    if (NodeNumber>=0) and (NodeNumber<Envelope^.NodesCount) and (Sender IS TComponent) then begin
     Envelope^.Nodes^[NodeNumber].Interpolation:=TComponent(Sender).Tag;
{    Envelope^.Dirty:=true;
     Project.Dirty:=true;}
    end;
    if Sender IS TComponent then begin
     LastInterpolation:=TComponent(Sender).Tag;
    end;
   finally
    DataCriticalSection.Leave;
   end;
   DrawView;
   UpdateEnv;
  end;
 finally
 end;
end;

procedure TEnvelopeForm.PanelImageResize(Sender: TObject);
begin
 try
  BufferBitmap.Height:=0;
  BufferBitmap.Width:=PaintBoxImage.ClientWidth;
  BufferBitmap.Height:=PaintBoxImage.ClientHeight;
  DrawView;
  Invalidate;
 except
 end;
end;

procedure TEnvelopeForm.FormDestroy(Sender: TObject);
begin
 try
  BufferBitmap.Destroy;
 except
 end;
 SetLength(Nodes,0);
end;

procedure TEnvelopeForm.PaintBoxImagePaint(Sender: TObject);
begin
 try
  DrawView;
 except
 end;
end;

procedure TEnvelopeForm.InterpolationModeAllClick(Sender: TObject);
var NodeNumber:INTEGER;
begin
 try
  if not assigned(Envelope) then exit;
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   TRY
    if Sender IS TComponent then begin
     LastInterpolation:=TComponent(Sender).Tag;
     PopupNodeNumber:=-1;
     for NodeNumber:=0 to Envelope^.NodesCount-1 do begin
      Envelope^.Nodes^[NodeNumber].Interpolation:=TComponent(Sender).Tag;
     end;
{    Envelope^.Dirty:=true;
     Project.Dirty:=true;}
    end;
   finally
    AudioCriticalSection.Leave;
   end;
   DrawView;
  end;
 finally
 end;
end;

procedure TEnvelopeForm.TestActive;
begin
 try
  if not assigned(Envelope) then exit;
  Delete1.Enabled:=(CurrentNode>=0) and (Envelope^.NodesCount>0);
  Setinterpolation1.Enabled:=(CurrentNode>=0) and (Envelope^.NodesCount>0);
  Setinterpolation3.Enabled:=Envelope^.NodesCount>0;
  SetLoopStart1.Enabled:=(CurrentNode>=0) AND (Envelope^.NodesCount>0);
  SetLoopEnd1.Enabled:=(CurrentNode>=0) AND (Envelope^.NodesCount>0);
  MarkasSustainLoopStart1.Enabled:=(CurrentNode>=0) AND (Envelope^.NodesCount>0);
  MarkasSustainLoopEnd1.Enabled:=(CurrentNode>=0) AND (Envelope^.NodesCount>0);
  Setinterpolation1.Enabled:=(CurrentNode>=0) AND (Envelope^.NodesCount>0);
  Setinterpolation3.Enabled:=Envelope^.NodesCount>0;
  Deleteloop1.Enabled:=(Envelope^.NodesCount>0) AND ((Envelope^.LoopStart>=0) OR (Envelope^.LoopEnd>=0));
  DeleteSustainLoop1.Enabled:=(Envelope^.NodesCount>0) AND ((Envelope^.SustainLoopStart>=0) OR (Envelope^.SustainLoopEnd>=0));
 except
 end;
end;

procedure TEnvelopeForm.PopupMenuPopup(Sender: TObject);
begin
 try
  TestActive;
{ ActiveControl:=NIL;
  SetFocus;}
  //DrawView;
 except
 end;
end;

procedure TEnvelopeForm.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
 Done:=true;
 try
  TestActive;
 except
 end;
end;

procedure TEnvelopeForm.DuplicateNodes;
var i,j,k,g:INTEGER;
begin
 try
  if assigned(Envelope) and (Envelope^.NodesCount>0) and (((Envelope^.NodesCount*2)+1)<MaxEnvelopeNodes) then begin
   j:=Envelope^.NodesCount;
   k:=(j*2)-1;
   Envelope^.NodesCount:=k;
   if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
    SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
   end;
   g:=1;
   for i:=j to k-1 do begin
    Envelope^.Nodes^[i].Time:=Envelope^.Nodes^[g].Time+Envelope^.Nodes^[j-1].Time;
    Envelope^.Nodes^[i].Value:=Envelope^.Nodes^[g].Value;
    Envelope^.Nodes^[i].Interpolation:=Envelope^.Nodes^[g].Interpolation;
    inc(g);
   end;
   Envelope^.Nodes^[j-1].Value:=Envelope^.Nodes^[0].Value;
   Envelope^.Nodes^[j-1].Interpolation:=Envelope^.Nodes^[0].Interpolation;
  end;
{ Envelope^.Dirty:=true;
  Project.Dirty:=true;}
  DrawView;
  UpdateEnv;
 except
 end;
end;

procedure TEnvelopeForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var NodeNumber,MaxTick:INTEGER;
begin
 try
  if not assigned(Envelope) then exit;
  MaxTick:=16777216;
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   TRY
    NodeNumber:=CurrentNode;
    if (NodeNumber>=0) and (NodeNumber<Envelope^.NodesCount) then begin
     if (Shift*[ssShift,ssAlt,ssCtrl])=[ssShift] then begin
      CASE Key OF
       VK_F1:begin
//      SetSustainPoint1Click(Sender);
       end;
       VK_UP,ORD('W'),VK_NUMPAD8:begin
        if Envelope^.Nodes^[NodeNumber].Value<255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_DOWN,ORD('S'),VK_NUMPAD2:begin
        if Envelope^.Nodes^[NodeNumber].Value>0 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_HOME:begin
        Envelope^.Nodes^[NodeNumber].Value:=255;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_END:begin
        Envelope^.Nodes^[NodeNumber].Value:=0;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_PRIOR:begin
        if (Envelope^.Nodes^[NodeNumber].Value+16)<=255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value,16);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_NEXT:begin
        if Envelope^.Nodes^[NodeNumber].Value>16 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value,16);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_LEFT,ORD('A'),VK_NUMPAD4:begin
        if (NodeNumber=0) then begin
        end else if (NodeNumber>0) and (Envelope^.Nodes^[NodeNumber-1].Time>=(Envelope^.Nodes^[NodeNumber].Time-1)) then begin
        end else if Envelope^.Nodes^[NodeNumber].Time>0 then begin
         dec(Envelope^.Nodes^[NodeNumber].Time);
        end else begin
         Envelope^.Nodes^[NodeNumber].Time:=0;
        end;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_RIGHT,ORD('D'),VK_NUMPAD6:begin
        if (NodeNumber=0) then begin
        end else if ((NodeNumber+1)<Envelope^.NodesCount) and (Envelope^.Nodes^[NodeNumber+1].Time<=(Envelope^.Nodes^[NodeNumber].Time+1)) then begin
        end else if Envelope^.Nodes^[NodeNumber].Time<MaxTick then begin
         inc(Envelope^.Nodes^[NodeNumber].Time);
        end else begin
         Envelope^.Nodes^[NodeNumber].Time:=MaxTick;
        end;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_Delete:begin
//        DeleteLoopButtonClick(Sender);
       end;
       ORD('P'):begin
        DuplicateNodes;
       end;
      end;
     end else if (Shift*[ssShift,ssAlt,ssCtrl])=[ssCtrl] then begin
      CASE Key OF
       VK_UP,ORD('W'),VK_NUMPAD8:begin
        if Envelope^.Nodes^[NodeNumber].Value<255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_DOWN,ORD('S'),VK_NUMPAD2:begin
        if Envelope^.Nodes^[NodeNumber].Value>0 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_HOME:begin
        Envelope^.Nodes^[NodeNumber].Value:=255;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_END:begin
        Envelope^.Nodes^[NodeNumber].Value:=0;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_PRIOR:begin
        if (Envelope^.Nodes^[NodeNumber].Value+16)<=255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value,16);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_NEXT:begin
        if Envelope^.Nodes^[NodeNumber].Value>16 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value,16);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_LEFT,ORD('A'),VK_NUMPAD4:begin
        if (NodeNumber=0) then begin
        end else if (NodeNumber>0) and (Envelope^.Nodes^[NodeNumber-1].Time>=(Envelope^.Nodes^[NodeNumber].Time-1)) then begin
        end else if Envelope^.Nodes^[NodeNumber].Time>0 then begin
         dec(Envelope^.Nodes^[NodeNumber].Time);
        end else begin
         Envelope^.Nodes^[NodeNumber].Time:=0;
        end;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_RIGHT,ORD('D'),VK_NUMPAD6:begin
        if (NodeNumber=0) then begin
        end else if ((NodeNumber+1)<Envelope^.NodesCount) and (Envelope^.Nodes^[NodeNumber+1].Time<=(Envelope^.Nodes^[NodeNumber].Time+1)) then begin
        end else if Envelope^.Nodes^[NodeNumber].Time<MaxTick then begin
         inc(Envelope^.Nodes^[NodeNumber].Time);
        end else begin
         Envelope^.Nodes^[NodeNumber].Time:=MaxTick;
        end;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_Delete:begin
//        DeleteLoopButtonClick(Sender);
       end;
      end;
     end else if ((Shift*[ssShift,ssAlt,ssCtrl])=[ssAlt]) or ((Shift*[ssShift,ssAlt,ssCtrl])=[ssAlt,ssCtrl]) then begin
      CASE Key OF
       ORD('0')..ORD('4'):begin
        Envelope^.Nodes^[NodeNumber].Interpolation:=Key-ORD('0');
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
        LastInterpolation:=Key-ORD('0');
       end;
       ORD('5')..ORD('9'):begin
        for NodeNumber:=0 to Envelope^.NodesCount-1 do begin
         Envelope^.Nodes^[NodeNumber].Interpolation:=Key-ORD('5');
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
        LastInterpolation:=Key-ORD('5');
       end;
       VK_HOME:begin
        Envelope^.Nodes^[NodeNumber].Value:=255;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_END:begin
        Envelope^.Nodes^[NodeNumber].Value:=0;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_PRIOR:begin
        if (Envelope^.Nodes^[NodeNumber].Value+64)<=255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value,64);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_NEXT:begin
        if Envelope^.Nodes^[NodeNumber].Value>64 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value,64);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_UP,ORD('W'),VK_NUMPAD8:begin
        if (Envelope^.Nodes^[NodeNumber].Value+16)<=255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value,16);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_DOWN,ORD('S'),VK_NUMPAD2:begin
        if Envelope^.Nodes^[NodeNumber].Value>16 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value,16);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_LEFT,ORD('A'),VK_NUMPAD4:begin
        if (NodeNumber=0) then begin
        end else if (NodeNumber>0) and (Envelope^.Nodes^[NodeNumber-1].Time>=(Envelope^.Nodes^[NodeNumber].Time-18)) then begin
        end else if Envelope^.Nodes^[NodeNumber].Time>10 then begin
         dec(Envelope^.Nodes^[NodeNumber].Time,10);
        end else begin
         Envelope^.Nodes^[NodeNumber].Time:=0;
        end;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_RIGHT,ORD('D'),VK_NUMPAD6:begin
        if (NodeNumber=0) then begin
        end else if ((NodeNumber+1)<Envelope^.NodesCount) and (Envelope^.Nodes^[NodeNumber+1].Time<=(Envelope^.Nodes^[NodeNumber].Time+10)) then begin
        end else if (Envelope^.Nodes^[NodeNumber].Time+10)<=MaxTick then begin
         inc(Envelope^.Nodes^[NodeNumber].Time,10);
        end else begin
         Envelope^.Nodes^[NodeNumber].Time:=MaxTick;
        end;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_Delete:begin
//        DeleteLoopButtonClick(Sender);
       end;
      end;
     end else if (Shift*[ssShift,ssAlt,ssCtrl])=[] then begin
      CASE Key OF
       ORD('Y'):begin
        Markstart1Click(nil);
       end;
       ORD('X'):begin
        Markend1Click(nil);
       end;
       ORD('C'):begin
        Copy1Click(nil);
       end;
       ORD('V'):begin
        Paste1Click(nil);
       end;
       ORD('B'):begin
        Clear1Click(nil);
       end;
       ORD('M'):begin
        Delete2Click(nil);
       end;
       VK_UP,ORD('W'),VK_NUMPAD8:begin
        if Envelope^.Nodes^[NodeNumber].Value<255 then begin
         inc(Envelope^.Nodes^[NodeNumber].Value);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=255;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_DOWN,ORD('S'),VK_NUMPAD2:begin
        if Envelope^.Nodes^[NodeNumber].Value>0 then begin
         dec(Envelope^.Nodes^[NodeNumber].Value);
        end else begin
         Envelope^.Nodes^[NodeNumber].Value:=0;
        end;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_HOME:begin
        CurrentNode:=0;
        NodeNumber:=CurrentNode;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_END:begin
        CurrentNode:=Envelope^.NodesCount-1;
        NodeNumber:=CurrentNode;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_PRIOR:begin
        if CurrentNode>4 then begin
         dec(CurrentNode,4);
        end else begin
         CurrentNode:=0;
        end;
        NodeNumber:=CurrentNode;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_NEXT:begin
        if (CurrentNode+4)<Envelope^.NodesCount then begin
         inc(CurrentNode,4);
        end else begin
         CurrentNode:=Envelope^.NodesCount-1;
        end;
        NodeNumber:=CurrentNode;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_LEFT,ORD('A'),VK_NUMPAD4:begin
        if CurrentNode>0 then begin
         dec(CurrentNode);
        end;
        NodeNumber:=CurrentNode;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_RIGHT,ORD('D'),VK_NUMPAD6:begin
        if (CurrentNode+1)<Envelope^.NodesCount then begin
         inc(CurrentNode);
        end;
        NodeNumber:=CurrentNode;
        if Envelope^.NodesCount=0 then begin
         ScrollPosition:=0;
        end else begin
         while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
          dec(ScrollPosition);
          if ScrollPosition<0 then begin
           ScrollPosition:=0;
           break;
          end;
         end;
         while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
          inc(ScrollPosition);
         end;
        end;
        SGTK0ScrollbarScroll.Position:=ScrollPosition;
{       Envelope^.Dirty:=true;
        Project.Dirty:=true;}
       end;
       VK_INSERT:begin
        Insert1Click(Sender);
       end;
       VK_Delete:begin
        Delete1Click(Sender);
       end;
      end;
     end;
    end;
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  ActiveControl:=NIL;
  SetFocus;
  DrawView;
  UpdateEnv;
 finally
 end;
end;

procedure TEnvelopeForm.Insert1Click(Sender: TObject);
var NodeNumber,NodeCounter,X1,Y1,X2,Y2,X,Y:INTEGER;
begin
 try
  if not assigned(Envelope) then exit;
  if Lock1.Checked then exit;
  if assigned(AudioCriticalSection) then begin
   AudioCriticalSection.Enter;
   TRY
    NodeNumber:=CurrentNode;
    if (NodeNumber>=0) and (NodeNumber<Envelope^.NodesCount) and ((Envelope^.NodesCount+1)<MaxEnvelopeNodes) then begin
     X1:=Envelope^.Nodes^[NodeNumber].Time;
     Y1:=Envelope^.Nodes^[NodeNumber].Value;
     if (NodeNumber+1)<Envelope^.NodesCount then begin
      X2:=Envelope^.Nodes^[NodeNumber+1].Time;
      Y2:=Envelope^.Nodes^[NodeNumber+1].Value;
      if ABS(X2-X1)>1 then begin
       if ABS(X2-X1)<=2 then begin
        X:=X1;
       end else begin
        X:=(X1+X2) div 2;
       end;
       Y:=(Y1+Y2) div 2;
       inc(Envelope^.NodesCount);
       if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
        SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
       end;
       NodeCounter:=Envelope^.NodesCount;
       while NodeCounter>NodeNumber do begin
        if (NodeCounter>0) and (NodeCounter<MaxEnvelopeNodes) then begin
         Envelope^.Nodes^[NodeCounter]:=Envelope^.Nodes^[NodeCounter-1];
        end;
        dec(NodeCounter);
       end;
       inc(NodeNumber);
       Envelope^.Nodes^[NodeNumber].Time:=X;
       Envelope^.Nodes^[NodeNumber].Value:=Y;
       Envelope^.Nodes^[NodeNumber].Interpolation:=LastInterpolation;
       CurrentNode:=NodeNumber;
      end;
     end else if (NodeNumber+1)=Envelope^.NodesCount then begin
      X:=X1+10;
      Y:=Y1 div 2;
      if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
       SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
      end;
      Envelope^.Nodes^[NodeNumber+1].Time:=X;
      Envelope^.Nodes^[NodeNumber+1].Value:=Y;
      Envelope^.Nodes^[NodeNumber+1].Interpolation:=LastInterpolation;
      inc(Envelope^.NodesCount);
      CurrentNode:=Envelope^.NodesCount-1;
     end;
    end else if Envelope^.NodesCount=0 then begin
     Envelope^.NodesCount:=1;
     if Envelope^.NodesCount>=Envelope^.NodesAllocated then begin
      SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+1)*2);
     end;
     Envelope^.Nodes^[0].Time:=0;
     Envelope^.Nodes^[0].Value:=0;
     Envelope^.Nodes^[0].Interpolation:=LastInterpolation;
     CurrentNode:=0;
    end;
    ActiveControl:=NIL;
    SetFocus;
    SynthEnvelopeSort(Envelope,@CurrentNode);
    NodeNumber:=CurrentNode;
    if Envelope^.NodesCount=0 then begin
     ScrollPosition:=0;
    end else begin
     while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
      dec(ScrollPosition);
      if ScrollPosition<0 then begin
       ScrollPosition:=0;
       break;
      end;
     end;
     while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
      inc(ScrollPosition);
     end;
    end;
    SGTK0ScrollbarScroll.Position:=ScrollPosition;
{   Envelope^.Dirty:=true;
    Project.Dirty:=true;}
   finally
    AudioCriticalSection.Leave;
   end;
  end;
  DrawView;
  UpdateEnv;
 finally
 end;
end;

procedure TEnvelopeForm.N11Click(Sender: TObject);
begin
 if assigned(Sender) and (Sender is TMenuItem) then begin
  SelectBoxHalfSize:=TMenuItem(Sender).Tag;
  DrawView;
 end;
end;

procedure TEnvelopeForm.Clear1Click(Sender: TObject);
begin
 NodeStart:=-1;
 NodeEnd:=-1;
 DrawView;
end;

procedure TEnvelopeForm.Markstart1Click(Sender: TObject);
begin
 NodeStart:=CurrentNode;
 if (NodeEnd<0) or (NodeEnd<NodeStart) then begin
  NodeEnd:=CurrentNode;
 end;
 DrawView;
end;

procedure TEnvelopeForm.Markend1Click(Sender: TObject);
begin
 NodeEnd:=CurrentNode;
 if (NodeStart<0) or (NodeStart>NodeEnd) then begin
  NodeStart:=CurrentNode;
 end;
 DrawView;
end;

procedure TEnvelopeForm.Copy1Click(Sender: TObject);
begin
 if ((assigned(Envelope) and ((NodeStart>=0) and (NodeEnd>=0))) and (NodeStart<=NodeEnd)) and ((NodeStart<Envelope^.NodesCount) and (NodeEnd<Envelope^.NodesCount)) then begin
  SetLength(Nodes,(NodeEnd-NodeStart)+1);
  Move(Envelope^.Nodes^[NodeStart],Nodes[0],(NodeEnd-NodeStart)+1);
  DrawView;
 end;
end;

procedure TEnvelopeForm.Paste1Click(Sender: TObject);
var i,j,k,t,tt,NodeNumber:integer;
begin
 if (length(Nodes)>0) and (assigned(Envelope) and ((CurrentNode>=0) and (CurrentNode<Envelope^.NodesCount))) then begin
  j:=Envelope^.NodesCount;
  inc(Envelope^.NodesCount,length(Nodes));
  if (Envelope^.NodesCount+2)>=Envelope^.NodesAllocated then begin
   SynthResizeEnvelope(Envelope,(Envelope^.NodesCount+4)*2);
  end;
  t:=Envelope^.Nodes^[CurrentNode].Time-Nodes[0].Time;
  tt:=(Nodes[length(Nodes)-1].Time-Nodes[0].Time)+1;
  for i:=j-1 downto CurrentNode do begin
   k:=i+length(Nodes);
   Envelope^.Nodes^[k]:=Envelope^.Nodes^[i];
   inc(Envelope^.Nodes^[k].Time,tt);
  end;
  for i:=0 to length(Nodes)-1 do begin
   Envelope^.Nodes^[CurrentNode+i]:=Nodes[i];
   inc(Envelope^.Nodes^[CurrentNode+i].Time,t);
  end;
  inc(CurrentNode,length(Nodes));
{ Envelope^.Dirty:=true;
  Project.Dirty:=true;}
  NodeNumber:=CurrentNode;
  if Envelope^.NodesCount=0 then begin
   ScrollPosition:=0;
  end else begin
   while Envelope^.Nodes^[NodeNumber].Time<ScrollPosition do begin
    dec(ScrollPosition);
    if ScrollPosition<0 then begin
     ScrollPosition:=0;
     break;
    end;
   end;
   while (Envelope^.Nodes^[NodeNumber].Time*XScale)>((ScrollPosition*XScale)-18+BufferBitmap.Width) do begin
    inc(ScrollPosition);
   end;
  end;
  SGTK0ScrollbarScroll.Position:=ScrollPosition;
  DrawView;
  UpdateEnv;
 end;
end;

procedure TEnvelopeForm.Delete2Click(Sender: TObject);
var i,j:integer;
begin
 if ((assigned(Envelope) and ((NodeStart>=0) and (NodeEnd>=0))) and (NodeStart<=NodeEnd)) and ((NodeStart<Envelope^.NodesCount) and (NodeEnd<Envelope^.NodesCount)) then begin
  j:=NodeStart;
  for i:=NodeEnd+1 to Envelope^.NodesCount-1 do begin
   Envelope^.Nodes^[j]:=Envelope^.Nodes^[i];
   inc(j);
  end;
  Envelope^.NodesCount:=j;
{ Envelope^.Dirty:=true;
  Project.Dirty:=true;}
  DrawView;
  UpdateEnv;
 end;
end;

procedure TEnvelopeForm.UpdateEnv;
begin
{if FormMain.CheckBoxEnvUpdate.Checked and not UnitFormMain.Playing then begin
  FormGL.Render(FormMain.Timeline.TrackTimeLine.Time*Project.TicksPerRow);
 end;}
end;

procedure TEnvelopeForm.SGTK0ScrollbarScrollScroll(Sender: TObject;
  ScrollPos: Integer);
begin
 try
  ScrollPosition:=ScrollPos;
  DrawView;
 except
 end;
end;

procedure TEnvelopeForm.SGTK0ScrollbarZoomScroll(Sender: TObject;
  ScrollPos: Integer);
begin
 try
  EnvelopeScale:=ScrollPos;
  DrawView;
 except
 end;
end;

procedure TEnvelopeForm.SGTK0ScrollbarNegValueScroll(Sender: TObject;
  ScrollPos: Integer);
begin
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  TRY
   if Envelope^.NegValue<>(255-ScrollPos) then begin
    Envelope^.NegValue:=255-ScrollPos;
   end;
  finally
   DataCriticalSection.Leave;
  end;
  DrawView;
 end;
end;

procedure TEnvelopeForm.SGTK0ScrollbarPosValueScroll(Sender: TObject;
  ScrollPos: Integer);
begin
 if assigned(DataCriticalSection) then begin
  DataCriticalSection.Enter;
  TRY
   if Envelope^.PosValue<>(255-ScrollPos) then begin
    Envelope^.PosValue:=255-ScrollPos;
   end;
  finally
   DataCriticalSection.Leave;
  end;
  DrawView;
 end;
end;

procedure TEnvelopeForm.Dump1Click(Sender: TObject);
begin
 try
  Dump1.Checked:=not Dump1.Checked;
  DrawView;
 except
 end;
end;

procedure TEnvelopeForm.SetLoopStart1Click(Sender: TObject);
begin
 IF ASSIGNED(AudioCriticalSection) THEN BEGIN
  AudioCriticalSection.Enter;
  TRY
   IF CurrentNode>=0 THEN BEGIN
    Envelope^.LoopStart:=CurrentNode;
    IF Envelope^.LoopEnd<0 THEN Envelope^.LoopEnd:=CurrentNode;
   END;
   PopupNodeNumber:=-1;
  finally
   AudioCriticalSection.Leave;
  END;
  DrawView;
 END;
end;

procedure TEnvelopeForm.SetLoopEnd1Click(Sender: TObject);
begin
 IF ASSIGNED(AudioCriticalSection) THEN BEGIN
  AudioCriticalSection.Enter;
  TRY
   IF CurrentNode>=0 THEN BEGIN
    Envelope^.LoopEnd:=CurrentNode;
    IF Envelope^.LoopStart<0 THEN Envelope^.LoopStart:=CurrentNode;
   END;
   PopupNodeNumber:=-1;
  finally
   AudioCriticalSection.Leave;
  END;
  DrawView;
 END;
end;

procedure TEnvelopeForm.MarkasSustainLoopStart1Click(Sender: TObject);
begin
 IF ASSIGNED(AudioCriticalSection) THEN BEGIN
  AudioCriticalSection.Enter;
  TRY
   IF CurrentNode>=0 THEN BEGIN
    Envelope^.SustainLoopStart:=CurrentNode;
    IF Envelope^.SustainLoopEnd<0 THEN Envelope^.SustainLoopEnd:=CurrentNode;
   END;
  finally
   AudioCriticalSection.Leave;
  END;
  DrawView;
 END;
end;

procedure TEnvelopeForm.MarkasSustainLoopEnd1Click(Sender: TObject);
begin
 IF ASSIGNED(AudioCriticalSection) THEN BEGIN
  AudioCriticalSection.Enter;
  TRY
   IF CurrentNode>=0 THEN BEGIN
    Envelope^.SustainLoopEnd:=CurrentNode;
    IF Envelope^.SustainLoopStart<0 THEN Envelope^.SustainLoopStart:=CurrentNode;
   END;
  finally
   AudioCriticalSection.Leave;
  END;
  DrawView;
 END;
end;

procedure TEnvelopeForm.DeleteLoopButtonClick(Sender: TObject);
begin
 IF ASSIGNED(AudioCriticalSection) THEN BEGIN
  AudioCriticalSection.Enter;
  TRY
   Envelope^.LoopStart:=-1;
   Envelope^.LoopEnd:=-1;
  finally
   AudioCriticalSection.Leave;
  END;
  DrawView;
 END;
end;

procedure TEnvelopeForm.DeleteSustainLoopButtonClick(Sender: TObject);
begin
 IF ASSIGNED(AudioCriticalSection) THEN BEGIN
  AudioCriticalSection.Enter;
  TRY
   Envelope^.SustainLoopStart:=-1;
   Envelope^.SustainLoopEnd:=-1;
  finally
   AudioCriticalSection.Leave;
  END;
  DrawView;
 END;
end;

procedure TEnvelopeForm.Lock1Click(Sender: TObject);
begin
 Lock1.Checked:=not Lock1.Checked;
end;

end.
