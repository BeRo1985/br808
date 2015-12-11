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
unit BeRoDrawTools;

interface

uses Windows,Graphics;

function CorrectRect(const R:TRect):TRect;
function IsIntersectRect(const R1,R2:TRect):boolean;
function GetIntersectRect(out DestRect:TRect;const R1,R2:TRect):boolean;
function GetIntersectRectEx(out DestRect:TRect;const R1,R2:TRect):boolean;
function AdjustRect(const ARect,ToRedrawRect:TRect):TRect;
procedure MyFillRect(Canvas:TCanvas;const ARect:TRect);
procedure AdjustFillRect(Canvas:TCanvas;const ARect,ToRedrawRect:TRect);

implementation

function Min(A,B:integer):integer;
begin
 if A<B then begin
  result:=A;
 end else begin
  result:=B;
 end;
end;

function Max(A,B:integer):integer;
begin
 if A>B then begin
  result:=A;
 end else begin
  result:=B;
 end;
end;

function CorrectRect(const R:TRect):TRect;
begin
 if R.Left<R.Right then begin
  result.Left:=R.Left;
  result.Right:=R.Right;
 end else begin
  result.Left:=R.Right;
  result.Right:=R.Left;
 end;
 if R.Top<R.Bottom then begin
  result.Top:=R.Top;
  result.Bottom:=R.Bottom;
 end else begin
  result.Top:=R.Bottom;
  result.Bottom:=R.Top;
 end;
end;

function IsIntersectRect(const R1,R2:TRect):boolean;
begin
 result:=(R2.Right>=R1.Left) and (R2.Bottom>=R1.Top) and (R1.Right>=R2.Left) and (R1.Bottom>=R2.Top);
end;

function GetIntersectRect(out DestRect:TRect;const R1,R2:TRect):boolean;
begin
 result:=(R2.Right>=R1.Left) and (R2.Bottom>=R1.Top) and (R1.Right>=R2.Left) and (R1.Bottom>=R2.Top) and
         (ABS(R1.Right-R1.Left)>0) and (ABS(R1.Bottom-R1.Top)>0) and
         (ABS(R2.Right-R2.Left)>0) and (ABS(R2.Bottom-R2.Top)>0);
 if result then begin
  DestRect.Left:=Max(R1.Left,R2.Left);
  DestRect.Right:=Min(R1.Right,R2.Right);
  DestRect.Top:=Max(R1.Top,R2.Top);
  DestRect.Bottom:=Min(R1.Bottom,R2.Bottom);
 end else begin
  FILLCHAR(DestRect,sizeof(TRect),#0);
 end;
end;

function GetIntersectRectEx(out DestRect:TRect;const R1,R2:TRect):boolean;
begin
 result:=(R2.Right>=R1.Left) and (R2.Bottom>=R1.Top) and (R1.Right>=R2.Left) and (R1.Bottom>=R2.Top);
 if result then begin
  DestRect.Left:=Max(R1.Left,R2.Left);
  DestRect.Right:=Min(R1.Right,R2.Right);
  DestRect.Top:=Max(R1.Top,R2.Top);
  DestRect.Bottom:=Min(R1.Bottom,R2.Bottom);
 end else begin
  FILLCHAR(DestRect,sizeof(TRect),#0);
 end;
end;

function AdjustRect(const ARect,ToRedrawRect:TRect):TRect;
begin
 GetIntersectRect(result,ARect,ToRedrawRect);
end;

procedure MyFillRect(Canvas:TCanvas;const ARect:TRect);
begin
{$IFDEF WIN32}
 ExtTextOut(Canvas.Handle,ARect.Left,ARect.Top,ETO_OPAQUE,@ARect,'',0,nil);
{$ELSE}
 Canvas.FillRect(ARect);
{$ENDIF}
end;

procedure AdjustFillRect(Canvas:TCanvas;const ARect,ToRedrawRect:TRect);
var NewRect:TRect;
begin
 if GetIntersectRect(NewRect,CorrectRect(ARect),ToRedrawRect) then begin
  MyFillRect(Canvas,NewRect);
 end;
end;

end.
 