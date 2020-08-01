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
unit BeRoCriticalSection;
{$IFDEF FPC}
 {$MODE DELPHI}
 {$WARNINGS OFF}
 {$HINTS OFF}
 {$OVERFLOWCHECKS OFF}
 {$RANGECHECKS OFF}
 {$IFDEF CPUI386}
  {$DEFINE CPU386}
  {$ASMMODE INTEL}
 {$ENDIF}
 {$IFDEF FPC_LITTLE_ENDIAN}
  {$DEFINE LITTLE_ENDIAN}
 {$ELSE}
  {$IFDEF FPC_BIG_ENDIAN}
   {$DEFINE BIG_ENDIAN}
  {$ENDIF}
 {$ENDIF}
{$ELSE}
 {$DEFINE LITTLE_ENDIAN}
 {$IFNDEF CPU64}
  {$DEFINE CPU32}
 {$ENDIF}
 {$OPTIMIZATION ON}
{$ENDIF}
{$HINTS OFF}

interface

{$IFDEF FPC}
uses SyncObjs;
{$ELSE}
uses Windows,Messages;
{$ENDIF}

type TBeRoCriticalSection=class
      private
       FEntered:boolean;
       FLevel:integer;
{$IFDEF FPC}
       FCriticalSection:TCriticalSection;
{$ELSE}
       FCriticalSection:TRTLCriticalSection;
{$ENDIF}
      protected
      public
       constructor Create;
       destructor Destroy; override;
       function TryEnter:boolean;
       procedure Enter;
       procedure Leave;
       property Entered:boolean read FEntered write FEntered;
     end;

implementation

constructor TBeRoCriticalSection.Create;
var Flags:dword;
begin
 inherited Create;
{$IFDEF FPC}
 FCriticalSection:=TCriticalSection.Create;
{$ELSE}
 {$IFDEF WIN32}
 InitializeCriticalSection(FCriticalSection);
 {$ENDIF}
{$ENDIF}
 FEntered:=false;
 FLevel:=0;
end;

destructor TBeRoCriticalSection.Destroy;
begin
{$IFDEF FPC}
 FCriticalSection.Free;
{$ELSE}
 DeleteCriticalSection(FCriticalSection);
{$ENDIF}
 inherited Destroy;
end;

function TBeRoCriticalSection.TryEnter:boolean;
begin
{$IFDEF FPC}
 if FLevel=0 then begin
  result:=FCriticalSection.TryEnter;
 end else begin
  result:=false;
 end;
{$ELSE}
 result:=TryEnterCriticalSection(FCriticalSection);
{$ENDIF}
 if result then begin
  inc(FLevel);
//Assert(FLevel>0,'Recursive critical section error');
  FEntered:=true;
 end;
end;

procedure TBeRoCriticalSection.Enter;
begin
{$IFDEF FPC}
 if FLevel=0 then begin
  FCriticalSection.Enter;
 end;
{$ELSE}
 {$IFDEF WIN32}
 EnterCriticalSection(FCriticalSection);
 {$ENDIF}
{$ENDIF}
 inc(FLevel);
//Assert(FLevel>0,'Recursive critical section error');
 FEntered:=true;
end;

procedure TBeRoCriticalSection.Leave;
begin
//Assert(FLevel>0,'Recursive critical section error');
 dec(FLevel);
 FEntered:=false;
{$IFDEF FPC}
 if FLevel=0 then begin
  FCriticalSection.Leave;
 end;
{$ELSE}
 LeaveCriticalSection(FCriticalSection);
{$ENDIF}
end;

end.

