(*
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
unit UnitWaveEditor;

interface

uses Windows,Messages,SysUtils,Classes,Graphics,Controls,Forms,Dialogs,Math,
     StdCtrls,extctrls,BeRoDrawTools,UnitVSTiGUI;

type TWaveEditorPeakCacheEntry=record
      Min,Max:integer;
     end;
     TWaveEditorPeakCache=array of TWaveEditorPeakCacheEntry;

     TWaveEditorNewPosition=procedure(CurrentSamplePosition:integer) of object;

     TWaveEditor=class(TCustomControl)
      private
       DoubleBuffer:TBitmap;
       PeakCache:TWaveEditorPeakCache;
       PeakCacheScrollPosition:integer;
       procedure PaintEx;
      protected
       procedure Paint; override;
       procedure Resize; override;
       procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure MouseMove(Shift:TShiftState;X,Y:integer); override;
       procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:integer); override;
       procedure WMEraseBkgnd(var message:TMessage); message WM_ERASEBKGND;
       procedure WMGetDlgCode(var message:TMessage); message WM_GetDlgCode;
       procedure KeyDown(var Key:word;Shift:TShiftState); override;
       procedure KeyUp(var Key:word;Shift:TShiftState); override;
      public
       Form:TForm;
       LastShift:TShiftState;
       LastKey:word;
       Markieren:boolean;
       Markierung:boolean;
       MarkierungLinie:boolean;
       MarkierungVon,MarkierungBis:integer;
       Kaenale:byte;
       Bits:byte;
       FloatingPoint:boolean;
       Daten:pointer;
       SchleifeStart:integer;
       SchleifeEnde:integer;
       SustainSchleifeStart:integer;
       SustainSchleifeEnde:integer;
       CurrentSample:integer;
       SampleNr:integer;
       Samples:integer;
       Position:integer;
       Loop:boolean;
       SustainLoop:boolean;
       Bis:integer;
       BisX:integer;
       Faktor:single;
       MaxFaktor:single;
       ScrollBar:TSGTK0ScrollBar;
       PeakCacheAktualisieren:boolean;
       NewPositionProc:TWaveEditorNewPosition;
       OldFocused:boolean;
       constructor Create(AOwner:TComponent); override;
       destructor Destroy; override;
       procedure Init;
       procedure ClearZoom;
       procedure ZoomIn;
       procedure ZoomOut;
       procedure ScrollUpdate(Sender:TObject;ScrollPos:integer);//ScrollCode:TScrollCode;VAR ScrollPos:Integer);
       procedure KeyProcess;
      published
     end;

implementation

uses UnitVSTiEditor,UnitVSTiPlugin;

type PBYTES=^TBYTES;
     TBYTES=array[0..(2147483647 div sizeof(byte))-1] of byte;

     PSHORTINTS=^TSHORTINTS;
     TSHORTINTS=array[0..(2147483647 div sizeof(shortint))-1] of shortint;

     PSMALLINTS=^TSMALLINTS;
     TSMALLINTS=array[0..(2147483647 div sizeof(smallint))-1] of smallint;

     PLONGINTS=^TLONGINTS;
     TLONGINTS=array[0..(2147483647 div sizeof(longint))-1] of longint;

     PSINGLES=^TSINGLES;
     TSINGLES=array[0..(2147483647 div sizeof(single))-1] of single;

{CONST cBackground=$101000;
      cData=$FFFF00;
      cSelectionBackground=$FFFF00;
      cSelectionData=$101000;
      cSelectionLine=$888800;
      cMiddle=$404000;
      cLoopLine=$ADAD00;
      cSustainLoopLine=$666600;
      cPositionLine=$333300;
      cSplitter=clBtnFace;}

function TRUNC(FloatValue:single):integer;
type plongword=^longword;
const MaskMantissa=(1 shl 23)-1;
var Exponent,Mantissa,Sig,SigExtra,Signed,IsDenormalized:longword;
    Value,Shift:integer;
begin
 Exponent:=(plongword(@FloatValue)^ and $7fffffff) shr 23;
 Mantissa:=plongword(@FloatValue)^and MaskMantissa;
 Shift:=Exponent-$96;
 Sig:=Mantissa or $00800000;
 SigExtra:=Sig shl (Shift and 31);
 IsDenormalized:=0-ord(0<=Shift);
 Value:=(((-ord(Exponent>=$7e)) and (Sig shr (32-Shift))) and not IsDenormalized) or
        (SigExtra and IsDenormalized);
 Signed:=0-ord((plongword(@FloatValue)^ and $80000000)<>0);
 result:=(((0-Value) and Signed) or (Value and not Signed)) and (0-ord($9e>Exponent));
end;

constructor TWaveEditor.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 ControlStyle:=ControlStyle+[csOpaque];
 DoubleBuffer:=TBitmap.Create;
 TabStop:=true;
 LastShift:=[];
 LastKey:=0;
 Markieren:=false;
 Markierung:=false;
 MarkierungLinie:=false;
 MarkierungVon:=0;
 MarkierungBis:=0;
 Kaenale:=1;
 Bits:=8;
 FloatingPoint:=false;
 Daten:=nil;
 Samples:=0;
 Position:=0;
 Width:=704;
 Bis:=1;
 BisX:=1;
 Faktor:=1;
 CurrentSample:=0;
 SampleNr:=0;
{ScrollBar:=TScrollBar.Create(SELF);
 ScrollBar.Parent:=SELF;
 ScrollBar.Align:=alBottom;
 ScrollBar.OnScroll:=ScrollUpdate;}
 ScrollBar:=nil;
 PeakCache:=nil;
 PeakCacheAktualisieren:=true;
 PeakCacheScrollPosition:=-1;
 NewPositionProc:=nil;
end;

destructor TWaveEditor.Destroy;
begin
//ScrollBar.Free;
 setlength(PeakCache,0);
 DoubleBuffer.Free;
 inherited Destroy;
end;

procedure TWaveEditor.Init;
begin
 if (Samples>0) and (Width>0) then begin
  Faktor:=Samples/Width;
  MaxFaktor:=Samples/Width;
 end else begin
  Faktor:=1;
  MaxFaktor:=1;
 end;
end;

procedure TWaveEditor.ClearZoom;
begin
 Init;
 Position:=0;
 if assigned(ScrollBar) then begin
  ScrollBar.Position:=Position;
 end;
 PeakCacheAktualisieren:=true;
 Invalidate;
end;

procedure TWaveEditor.ZoomIn;
begin
 if Markierung and not MarkierungLinie then begin
  Position:=MarkierungVon;
  Faktor:=(MarkierungBis-MarkierungVon)/Width;
  if assigned(ScrollBar) then ScrollBar.Position:=Position;
 end else begin
  if (Faktor/1.5)>(Width/Samples) then Faktor:=Faktor/1.5;
 end;
 PeakCacheAktualisieren:=true;
 Invalidate;
end;

procedure TWaveEditor.ZoomOut;
var Zaehler:integer;
    Schritt:integer;
    Sample:integer;
    J:integer;
    OK:boolean;
begin
 if (Faktor*2)<MaxFaktor then begin
  Schritt:=1;
  if Faktor<1 then Schritt:=TRUNC(1/Faktor);
  if Schritt<=0 then Schritt:=1;
  Faktor:=Faktor*1.5;
  OK:=false;
  while not OK do begin
   OK:=true;
   Zaehler:=0;
   while Zaehler<Width do begin
    Sample:=TRUNC(Zaehler*Faktor)+Position;
    if Sample>=Samples then begin
     J:=1;
     if Position>=J then begin
      dec(Position,J);
      OK:=false;
     end else if Faktor<MaxFaktor then begin
      Faktor:=MaxFaktor;
      Position:=0;
      OK:=false;
     end;
     break;
    end;
    inc(Zaehler,Schritt);
   end;
  end;
 end else begin
  Position:=0;
  Faktor:=MaxFaktor;
 end;
 if assigned(ScrollBar) then if ScrollBar.Position<>Position then ScrollBar.Position:=Position;
 PeakCacheAktualisieren:=true;
 Invalidate;
end;

procedure TWaveEditor.PaintEx;
var R:TRect;
    VX,BX,HHY:integer;
    S:single;
    V24:longword;
    ToRedrawRect:TRECT;
    NewNewRect:TRect;
//  Counter:INTEGER;
 procedure HoleMinMax(var Min,Max:integer;Position,Von,Bis,Mult,Offset:integer);
 var Sample,Wert,PeakCachePosition:integer;
     V24:longword;
 begin
  if PeakCacheAktualisieren then begin
   case Bits of
    8:Min:=127;
    16:Min:=32767;
    24:Min:=32767;
    32:Min:=32767;
    else Min:=0;
   end;
   case Bits of
    8:Max:=-127;
    16:Max:=-32767;
    24:Max:=-32767;
    32:Max:=-32767;
    else Max:=0;
   end;
   for Sample:=Von to Bis do begin
    if (Sample>=0) and (Sample<Samples) then begin
     if FloatingPoint then begin
      case Bits of
       32:Wert:=TRUNC(PSINGLES(Daten)^[(Sample*Mult)+Offset]*32767);
       else Wert:=0;
      end;
     end else begin
      case Bits of
       8:Wert:=PSHORTINTS(Daten)^[(Sample*Mult)+Offset];
       16:Wert:=PSMALLINTS(Daten)^[(Sample*Mult)+Offset];
       24:begin
        V24:=PBYTES(Daten)^[((Sample*Mult)*3)+(Offset*3)] shl 8;
        V24:=V24 or (PBYTES(Daten)^[((Sample*Mult)*3)+(Offset*3)+1] shl 16);
        V24:=V24 or (PBYTES(Daten)^[((Sample*Mult)*3)+(Offset*3)+2] shl 24);
        Wert:=longint(V24) div (256*256);
       end;
       32:Wert:=PLONGINTS(Daten)^[(Sample*Mult)+Offset] div (256*256);
       else Wert:=0;
      end;
    end;
    end else begin
     Wert:=0;
    end;
    if Wert<Min then Min:=Wert;
    if Wert>Max then Max:=Wert;
   end;
   PeakCachePosition:=(Position*Mult)+Offset;
   if (PeakCachePosition>=0) and (PeakCachePosition<length(PeakCache)) then begin
    PeakCache[PeakCachePosition].Min:=Min;
    PeakCache[PeakCachePosition].Max:=Max;
   end;
  end else begin
   PeakCachePosition:=(Position*Mult)+Offset;
   if (PeakCachePosition>=0) and (PeakCachePosition<length(PeakCache)) then begin
    Min:=PeakCache[PeakCachePosition].Min;
    Max:=PeakCache[PeakCachePosition].Max;
   end;
  end;
 end;
 procedure Zeichnen(VX,BX,HY,VS:integer;ZeichneMarkierung:boolean;F:integer);
 var MHY,MMHY:integer;
     Schritt:integer;
     Zaehler:integer;
     Sample:integer;
     Wert:integer;
     SampleWert:integer;
     Min:integer;
     Max:integer;
     NewRect,NewNewRect:TRect;
 begin
  MHY:=HY div 2;
  MMHY:=MHY div 2;
  Schritt:=1;
  if Faktor<1 then Schritt:=TRUNC(1/Faktor);
  if Schritt<=0 then Schritt:=1;
  Wert:=0;
  SampleWert:=0;
  case Kaenale of
   1:begin
    with DoubleBuffer.Canvas do begin
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($808080);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($404040);
     end;
     Pen.Style:=psSolid;
     NewRect:=RECT(VX,MHY,BX,MHY);
     if GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) then begin
      MoveTo(NewNewRect.Left,NewNewRect.Top);
      LineTo(NewNewRect.Right,NewNewRect.Bottom);
     end;
     if ZeichneMarkierung then begin
      if OldFocused then begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($101010);
      end else begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($010101);
      end;
     end else begin
      if OldFocused then begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($f0f0f0);
      end else begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($808080);
      end;
     end;
     if assigned(Daten) and (Samples>0) then begin
      Zaehler:=VX;
      while Zaehler<=(BX+(Schritt*F)) do begin
       Sample:=TRUNC(Zaehler*Faktor)+VS;
       if (Sample>=0) and (Sample<Samples) then begin
        if not ZeichneMarkierung then begin
         Bis:=Sample;
         BisX:=Zaehler;
        end;
        if Faktor<1 then begin
         if FloatingPoint then begin
          case Bits of
           32:Wert:=ROUND(PSINGLES(Daten)^[Sample]*32767);
           else Wert:=0;
          end;
         end else begin
          case Bits of
           8:Wert:=PSHORTINTS(Daten)^[Sample];
           16:Wert:=PSMALLINTS(Daten)^[Sample];
           24:begin
            V24:=PBYTES(Daten)^[(Sample*3)+2] shl 8;
            V24:=(V24 or PBYTES(Daten)^[(Sample*3)+1]) shl 8;
            V24:=(V24 or PBYTES(Daten)^[(Sample*3)]) shl 8;
            Wert:=longint(V24) div (128*256);
           end;
           32:Wert:=PLONGINTS(Daten)^[Sample] div (256*256);
           else Wert:=0;
          end;
         end;
        end else begin
         HoleMinMax(Min,Max,Zaehler,TRUNC(Zaehler*Faktor)+VS,TRUNC((Zaehler+1)*Faktor)+VS,1,0);
        end;
       end else begin
        if Faktor<1 then begin
         Wert:=0;
        end else begin
         Min:=0;
         Max:=0;
        end;
       end;
       if Faktor<1 then begin
        case Bits of
         8:SampleWert:=Wert*MHY div 128;
         16,24,32:SampleWert:=Wert*MHY div 32768;
        end;
        if (Zaehler-VX)<=0 then begin
         MoveTo(Zaehler,MHY-SampleWert);
        end else begin
         LineTo(Zaehler,MHY-SampleWert);
        end;
       end else begin
        case Bits of
         8:SampleWert:=Min*MHY div 128;
         16,24,32:SampleWert:=Min*MHY div 32768;
        end;
        NewRect.Left:=Zaehler;
        NewRect.Right:=Zaehler;
        NewRect.Top:=MHY-SampleWert+1;
        case Bits of
         8:SampleWert:=Max*MHY div 128;
         16,24,32:SampleWert:=Max*MHY div 32768;
        end;
        NewRect.Bottom:=MHY-SampleWert;
//      IF GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) THEN BEGIN
         MoveTo(NewRect.Left,NewRect.Top);
         LineTo(NewRect.Right,NewRect.Bottom);
//      END;
       end;
       inc(Zaehler,Schritt);
      end;
     end;
    end;
   end;
   2:begin
    with DoubleBuffer.Canvas do begin
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($808080);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($404040);
     end;
     Pen.Style:=psSolid;
     NewRect:=RECT(VX,MMHY,BX,MMHY);
//   IF GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) THEN BEGIN
      MoveTo(NewRect.Left,NewRect.Top);
      LineTo(NewRect.Right,NewRect.Bottom);
//   END;
     NewRect:=RECT(VX,MHY+MMHY,BX,MHY+MMHY);
//   IF GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) THEN BEGIN
      MoveTo(NewRect.Left,NewRect.Top);
      LineTo(NewRect.Right,NewRect.Bottom);
//   END;
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($444444);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($333333);
     end;
     NewRect:=RECT(VX,MHY,BX,MHY);
//   IF GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) THEN BEGIN
      MoveTo(NewRect.Left,NewRect.Top);
      LineTo(NewRect.Right,NewRect.Bottom);
//   END;
     if ZeichneMarkierung then begin
      if OldFocused then begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($101010);
      end else begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($010101);
      end;
     end else begin
      if OldFocused then begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($f0f0f0);
      end else begin
       Pen.Color:=TVSTiEditor(Form).TranslateColor($808080);
      end;
     end;
     if assigned(Daten) and (Samples>0) then begin
      MoveTo(VX,MMHY);
      Zaehler:=VX;
      while Zaehler<=(BX+(Schritt*F)) do begin
       Sample:=TRUNC(Zaehler*Faktor)+VS;
       if (Sample>=0) and (Sample<Samples) then begin
        if not ZeichneMarkierung then begin
         Bis:=Sample;
         BisX:=Zaehler;
        end;
        if Faktor<1 then begin
         if FloatingPoint then begin
          case Bits of
           32:Wert:=ROUND(PSINGLES(Daten)^[Sample*2]*32767);
           else Wert:=0;
          end;
         end else begin
          case Bits of
           8:Wert:=PSHORTINTS(Daten)^[Sample*2];
           16:Wert:=PSMALLINTS(Daten)^[Sample*2];
           24:begin
            V24:=PBYTES(Daten)^[(Sample*(3*2))+2] shl 8;
            V24:=(V24 or PBYTES(Daten)^[(Sample*(3*2))+1]) shl 8;
            V24:=(V24 or PBYTES(Daten)^[(Sample*(3*2))]) shl 8;
            Wert:=longint(V24) div (128*256);
           end;
           32:Wert:=PLONGINTS(Daten)^[Sample*2] div (256*256);
           else Wert:=0;
          end;
         end;
        end else begin
         HoleMinMax(Min,Max,ZAehler,TRUNC(Zaehler*Faktor)+VS,TRUNC((Zaehler+1)*Faktor)+VS,2,0);
        end;
       end else begin
        if Faktor<1 then begin
         Wert:=0;
        end else begin
         Min:=0;
         Max:=0;
        end;
       end;
       if Faktor<1 then begin
        case Bits of
         8:SampleWert:=Wert*MMHY div 128;
         16,24,32:SampleWert:=Wert*MMHY div 32768;
        end;
        if (Zaehler-VX)<=0 then begin
         MoveTo(Zaehler,MMHY-SampleWert);
        end else begin
         LineTo(Zaehler,MMHY-SampleWert);
        end;
       end else begin
        case Bits of
         8:SampleWert:=Min*MMHY div 128;
         16,24,32:SampleWert:=Min*MMHY div 32768;
        end;
        NewRect.Left:=Zaehler;
        NewRect.Right:=Zaehler;
        NewRect.Top:=MMHY-SampleWert+1;
        case Bits of
         8:SampleWert:=Max*MMHY div 128;
         16,24,32:SampleWert:=Max*MMHY div 32768;
        end;
        NewRect.Bottom:=MMHY-SampleWert;
//      IF GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) THEN BEGIN
         MoveTo(NewRect.Left,NewRect.Top);
         LineTo(NewRect.Right,NewRect.Bottom);
//      END;
       end;
       inc(Zaehler,Schritt);
      end;
      MoveTo(VX,MHY+MMHY);
      Zaehler:=VX;
      while Zaehler<=(BX+(Schritt*F)) do begin
       Sample:=TRUNC(Zaehler*Faktor)+VS;
       if (Sample>=0) and (Sample<Samples) then begin
        if Faktor<1 then begin
         if FloatingPoint then begin
          case Bits of
           32:Wert:=ROUND(PSINGLES(Daten)^[(Sample*2)+1]*32767);
           else Wert:=0;
          end;
         end else begin
          case Bits of
           8:Wert:=PSHORTINTS(Daten)^[(Sample*2)+1];
           16:Wert:=PSMALLINTS(Daten)^[(Sample*2)+1];
           24:begin
            V24:=PBYTES(Daten)^[Sample*(3*2)+5] shl 8;
            V24:=(V24 or PBYTES(Daten)^[(Sample*(3*2))+4]) shl 8;
            V24:=(V24 or PBYTES(Daten)^[(Sample*(3*2))+3]) shl 8;
            Wert:=longint(V24) div (128*256);
           end;
           32:Wert:=PLONGINTS(Daten)^[(Sample*2)+1] div (256*256);
           else Wert:=0;
          end;
         end;
        end else begin
         HoleMinMax(Min,Max,Zaehler,TRUNC(Zaehler*Faktor)+VS,TRUNC((Zaehler+1)*Faktor)+VS,2,1);
        end;
       end else begin
        if Faktor<1 then begin
         Wert:=0;
        end else begin
         Min:=0;
         Max:=0;
        end;
       end;
       if Faktor<1 then begin
        case Bits of
         8:SampleWert:=Wert*MMHY div 128;
         16,24,32:SampleWert:=Wert*MMHY div 32768;
        end;
        if (Zaehler-VX)<=0 then begin
         MoveTo(Zaehler,MHY+MMHY-SampleWert);
        end else begin
         LineTo(Zaehler,MHY+MMHY-SampleWert);
        end;
       end else begin
        case Bits of
         8:SampleWert:=Min*MMHY div 128;
         16,24,32:SampleWert:=Min*MMHY div 32768;
        end;
        NewRect.Left:=Zaehler;
        NewRect.Right:=Zaehler;
        NewRect.Top:=MHY+MMHY-SampleWert+1;
        case Bits of
         8:SampleWert:=Max*MMHY div 128;
         16,24,32:SampleWert:=Max*MMHY div 32768;
        end;
        NewRect.Bottom:=MHY+MMHY-SampleWert;
//      IF GetIntersectRectEx(NewNewRect,NewRect,ToRedrawRect) THEN BEGIN
         MoveTo(NewRect.Left,NewRect.Top);
         LineTo(NewRect.Right,NewRect.Bottom);
//      END;
       end;
       inc(Zaehler,Schritt);
      end;
     end;
    end;
   end;
  end;
 end;
 procedure ZeichnenLeer(VX,BX,HY:integer);
 var MHY,MMHY:integer;
     NewNewRect:TRect;
 begin
  MHY:=HY div 2;
  MMHY:=MHY div 2;
  case Kaenale of
   0,1:begin
    with DoubleBuffer.Canvas do begin
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($808080);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($404040);
     end;
     Pen.Style:=psSolid;
     NewNewRect:=RECT(VX,MHY,BX,MHY);
     MoveTo(NewNewRect.Left,NewNewRect.Top);
     LineTo(NewNewRect.Right,NewNewRect.Bottom);
    end;
   end;
   2:begin
    with DoubleBuffer.Canvas do begin
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($808080);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($404040);
     end;
     Pen.Style:=psSolid;
     NewNewRect:=RECT(VX,MMHY,BX,MMHY);
     MoveTo(NewNewRect.Left,NewNewRect.Top);
     LineTo(NewNewRect.Right,NewNewRect.Bottom);
     NewNewRect:=RECT(VX,MHY+MMHY,BX,MHY+MMHY);
     MoveTo(NewNewRect.Left,NewNewRect.Top);
     LineTo(NewNewRect.Right,NewNewRect.Bottom);
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($444444);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($33333);
     end;
     NewNewRect:=RECT(VX,MHY,BX,MHY);
     MoveTo(NewNewRect.Left,NewNewRect.Top);
     LineTo(NewNewRect.Right,NewNewRect.Bottom);
    end;
   end;
  end;
 end;
begin
 if length(PeakCache)<>(Width*3) then begin
  setlength(PeakCache,Width*3);
  PeakCacheAktualisieren:=true;
 end;

 ToRedrawRect:=Canvas.ClipRect;
 R:=GetClientRect;

 HHY:=Height;

 if assigned(ScrollBar) then begin
  if (Samples>0) and ((Samples-(Bis-Position))>0) then begin
   try
    ScrollBar.Min:=0;
    ScrollBar.Max:=Samples-(Bis-Position);
   except
    ScrollBar.Min:=0;
    ScrollBar.Max:=Samples;
   end;
   if ScrollBar.Max=(Samples-(Bis-Position)) then begin
//  ScrollBar.PageSize:=TRUNC((Bis-Position)/Samples);
    if Faktor<1 then begin
     ScrollBar.SmallChange:=max(TRUNC((Bis-Position)*Faktor) div 16,1);
     ScrollBar.LargeChange:=TRUNC((Bis-Position)*Faktor);
    end else begin
     ScrollBar.SmallChange:=max(TRUNC((Bis-Position)/Faktor) div 16,1);
     ScrollBar.LargeChange:=TRUNC((Bis-Position)/Faktor);
    end;
    if ScrollBar.SmallChange<1 then ScrollBar.SmallChange:=1;
    if ScrollBar.LargeChange<2 then ScrollBar.LargeChange:=2;
   end;

   Position:=ScrollBar.Position;
   S:=Samples/Width;
   ScrollBar.Visible:=Faktor<S;
  end else begin
   ScrollBar.Min:=0;
   ScrollBar.Max:=Samples;
   ScrollBar.Visible:=false;
  end;

{ IF ScrollBar.Visible THEN BEGIN
   DEC(HHY,ScrollBar.Height+1);
   DEC(R.Bottom,ScrollBar.Height+1);
  END ELSE BEGIN
   ScrollBar.Max:=Samples;
  END;}
  if not ScrollBar.Visible then ScrollBar.Max:=Samples;
 end else begin
 end;

 if PeakCacheScrollPosition<>Position then begin
  PeakCacheScrollPosition:=Position;
  PeakCacheAktualisieren:=true;
 end;

 OldFocused:=Focused;

 with DoubleBuffer.Canvas do begin
  if OldFocused then begin
   Brush.Color:=TVSTiEditor(Form).TranslateColor($282828);
  end else begin
   Brush.Color:=TVSTiEditor(Form).TranslateColor($202020);
  end;
  Pen.Color:=Brush.Color;
  Brush.Style:=bsSolid;
  Pen.Style:=psSolid;
  FillRect(Rect(0,0,Width,Height));
 end;

 if Samples=0 then begin
  ZeichnenLeer(0,Width,HHY);
 end else begin
  Zeichnen(0,Width,HHY,Position,false,1);
  if Markierung then begin
   if MarkierungLinie then begin
    VX:=TRUNC((MarkierungVon-Position)/Faktor);
    with DoubleBuffer.Canvas do begin
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($888888);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($444444);
     end;
     Brush.Color:=Pen.Color;
     Brush.Style:=bsSolid;
     Pen.Style:=psSolid;
     NewNewRect:=RECT(VX,0,VX,HHY);
     MoveTo(NewNewRect.Left,NewNewRect.Top);
     LineTo(NewNewRect.Right,NewNewRect.Bottom);
    end;
   end else begin
    if MarkierungVon<MarkierungBis then begin
     VX:=TRUNC(((MarkierungVon-Position)/Faktor)+0.5);
     BX:=TRUNC(((MarkierungBis-Position)/Faktor)+0.5);
    end else begin
     VX:=TRUNC(((MarkierungBis-Position)/Faktor)+0.5);
     BX:=TRUNC(((MarkierungVon-Position)/Faktor)+0.5);
    end;
    with DoubleBuffer.Canvas do begin
     if OldFocused then begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($ffffff);
     end else begin
      Pen.Color:=TVSTiEditor(Form).TranslateColor($888888);
     end;
     Brush.Color:=Pen.Color;
     Brush.Style:=bsSolid;
     Pen.Style:=psSolid;
     AdjustFillRect(DoubleBuffer.Canvas,RECT(VX,0,BX,Height),ToRedrawRect);
    end;
    Zeichnen(VX,BX,HHY,Position,true,0);
   end;
  end;
 end;

 if Loop then begin
  with DoubleBuffer.Canvas do begin
   if OldFocused then begin
    Pen.Color:=TVSTiEditor(Form).TranslateColor($ffffff);
   end else begin
    Pen.Color:=TVSTiEditor(Form).TranslateColor($888888);
   end;
   Brush.Color:=Pen.Color;
   Brush.Style:=bsClear;
   Pen.Style:=psDot;
   VX:=TRUNC((SchleifeStart-Position)/Faktor);
   BX:=TRUNC((SchleifeEnde-Position)/Faktor);
   MoveTo(VX,0);
   LineTo(VX,HHY);
   MoveTo(BX,0);
   LineTo(BX,HHY);
  end;
 end;

 if SustainLoop then begin
  with DoubleBuffer.Canvas do begin
   if OldFocused then begin
    Pen.Color:=TVSTiEditor(Form).TranslateColor($aaaaaa);
   end else begin
    Pen.Color:=TVSTiEditor(Form).TranslateColor($666666);
   end;
   Brush.Color:=Pen.Color;
   Brush.Style:=bsClear;
   Pen.Style:=psDot;
   VX:=TRUNC((SustainSchleifeStart-Position)/Faktor);
   BX:=TRUNC((SustainSchleifeEnde-Position)/Faktor);
   MoveTo(VX,0);
   LineTo(VX,HHY);
   MoveTo(BX,0);
   LineTo(BX,HHY);
  end;
 end;

{IF ASSIGNED(Info) AND (Info.Channels>0) THEN BEGIN
  WITH DoubleBuffer.Canvas DO BEGIN
   Brush.Color:=cPositionLine;
   Brush.Style:=bsSolid;
   Pen.Color:=cPositionLine;
   Pen.Style:=psSolid;
   FOR Counter:=0 TO Track.AnzahlDerKaenale-1 DO BEGIN
    IF (Info.BaseChannel[Counter].Active) AND (Info.BaseChannel[Counter].Sample=SampleNr) THEN BEGIN
     VX:=TRUNCSINGLE((Info.BaseChannel[Counter].SamplePosition-Position)/Faktor);
     MoveTo(VX,0);
     LineTo(VX,HHY);
    END;
   END;
   FOR Counter:=0 TO Track.AnzahlDerDrumKaenale-1 DO BEGIN
    IF (Info.DrumChannel[Counter].Active) AND (Info.DrumChannel[Counter].Sample=SampleNr) THEN BEGIN
     VX:=TRUNCSINGLE((Info.DrumChannel[Counter].SamplePosition-Position)/Faktor);
     MoveTo(VX,0);
     LineTo(VX,HHY);
    END;
   END;
   FOR Counter:=0 TO Track.MaximumNNAKaenale-1 DO BEGIN
    IF (Info.NNAChannel[Counter].Active) AND (Info.NNAChannel[Counter].Sample=SampleNr) THEN BEGIN
     VX:=TRUNCSINGLE((Info.NNAChannel[Counter].SamplePosition-Position)/Faktor);
     MoveTo(VX,0);
     LineTo(VX,HHY);
    END;
   END;
  END;
 END;}

{$IFDEF WIN32}
 BitBlt(Canvas.Handle,ToRedrawRect.Left,ToRedrawRect.Top,
       ToRedrawRect.Right-ToRedrawRect.Left,ToRedrawRect.Bottom-ToRedrawRect.Top,
       DoubleBuffer.Canvas.Handle,ToRedrawRect.Left,ToRedrawRect.Top,SRCCOPY);
{$ELSE}
 Canvas.CopyRect(ToRedrawRect,DoubleBuffer.Canvas,ToRedrawRect);
{$ENDIF}

 PeakCacheAktualisieren:=false;

 if ScrollBar.Visible then ScrollBar.Invalidate;
end;

procedure TWaveEditor.Paint;
begin
 PaintEx;
end;

procedure TWaveEditor.Resize;
begin
 inherited Resize;
 DoubleBuffer.Height:=0;
 DoubleBuffer.Width:=Width;
 DoubleBuffer.Height:=Height;
end;

procedure TWaveEditor.WMEraseBkgnd(var message:TMessage);
begin
 message.result:=1;
end;

procedure TWaveEditor.WMGetDlgCode(var message:TMessage);
begin
 message.result:=DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTALLKEYS or DLGC_WANTTAB;
end;

procedure TWaveEditor.KeyDown(var Key:word;Shift:TShiftState);
begin
 inherited KeyDown(Key,Shift);
 LastShift:=Shift;
 LastKey:=Key;
 if Daten<>nil then KeyProcess;
 LastShift:=[];
 LastKey:=0;
end;

procedure TWaveEditor.KeyUp(var Key:word;Shift:TShiftState);
begin
 LastShift:=[];
 LastKey:=0;
 inherited KeyUp(Key,Shift);
end;

procedure TWaveEditor.MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
var MarkierungFaktor:single;
begin
 LastShift:=[];
 LastKey:=0;
 if not Focused then begin
  SetFocus;
  if Daten=nil then begin
   Invalidate;
  end;
 end;
 if Daten=nil then exit;
 if Button=mbLeft then begin
  SetCapture(Handle);
  if BisX=0 then BisX:=1;
  Markieren:=true;
  Markierung:=true;
  MarkierungLinie:=false;
  MarkierungFaktor:=(Bis-Position)/BisX;
  MarkierungVon:=TRUNC(MarkierungFaktor*X)+Position;
  MarkierungBis:=MarkierungVon;
  if MarkierungVon<0 then MarkierungVon:=0;
  if MarkierungBis<0 then MarkierungBis:=0;
  if MarkierungVon>=Samples then MarkierungVon:=Samples;
  if MarkierungBis>=Samples then MarkierungBis:=Samples;
  Invalidate;
 end else if Button=mbRight then begin
  Markieren:=false;
  Markierung:=false;
  Invalidate;
 end;
end;

procedure TWaveEditor.MouseMove(Shift:TShiftState;X,Y:integer);
var MarkierungFaktor:single;
begin
 LastShift:=[];
 LastKey:=0;
 if Daten=nil then exit;
 if BisX=0 then BisX:=1;
 MarkierungFaktor:=(Bis-Position)/BisX;
 CurrentSample:=TRUNC(MarkierungFaktor*X)+Position;
 if assigned(NewPositionProc) then NewPositionProc(CurrentSample);
 if Markieren then begin
  Markierung:=true;
  MarkierungBis:=TRUNC(MarkierungFaktor*X)+Position;
  if MarkierungVon<0 then MarkierungVon:=0;
  if MarkierungBis<0 then MarkierungBis:=0;
  if MarkierungVon>=Samples then MarkierungVon:=Samples;
  if MarkierungBis>=Samples then MarkierungBis:=Samples;
  Invalidate;
 end;
end;

procedure TWaveEditor.MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:integer);
var MarkierungFaktor:single;
    Alt:integer;
begin
 if Daten=nil then exit;
 if Markieren then begin
  ReleaseCapture;
  if BisX=0 then BisX:=1;
  Markieren:=false;
  Markierung:=true;
  MarkierungFaktor:=(Bis-Position)/BisX;
  MarkierungBis:=TRUNC(MarkierungFaktor*X)+Position;
  if MarkierungBis<MarkierungVon then begin
   Alt:=MarkierungBis;
   MarkierungBis:=MarkierungVon;
   MarkierungVon:=Alt;
  end;
  if MarkierungVon<0 then MarkierungVon:=0;
  if MarkierungBis<0 then MarkierungBis:=0;
  if MarkierungVon>=Samples then MarkierungVon:=Samples;
  if MarkierungBis>=Samples then MarkierungBis:=Samples;
  if MarkierungBis=MarkierungVon then begin
   MarkierungBis:=MarkierungVon;
   MarkierungLinie:=true;
  end;
  Invalidate;
 end;
end;

procedure TWaveEditor.ScrollUpdate(Sender:TObject;ScrollPos:integer);//ScrollCode:TScrollCode;VAR ScrollPos:Integer);
begin
 Invalidate;
end;

procedure TWaveEditor.KeyProcess;
var Key:word;
    Shift:TShiftState;
begin
 if Daten=nil then exit;
 if LastKey=0 then exit;
 Key:=LastKey;
 Shift:=LastShift;
 case Key of
  ord('U'):begin
  end;
  else begin
  end;
 end;
end;

end.
