(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2003-2004, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoThread;
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

{$IFDEF WIN32}
uses Windows,Messages{$IFDEF FPC},SysThrds{$ENDIF};

type TBeRoThreadMethod=procedure of object;
     TBeRoThreadPriority=(tpIdle,tpLowest,tpLower,tpNormal,tpHigher,tpHighest,tpTimeCritical);

     TBeRoThread=class
      private
       FHandle:THandle;
       FThreadID:TThreadID;
       FFinished,FSuspended,FTerminated,FFreeOnTerminate:boolean;
       FReturnValue:longword;
       function GetPriority:TBeRoThreadPriority;
       procedure SetPriority(Value:TBeRoThreadPriority);
       procedure SetSuspended(Value:boolean);
      protected
       procedure Execute; virtual; abstract;
       property ReturnValue:longword read FReturnValue write FReturnValue;
       property Terminated:boolean read FTerminated;
      public
       constructor Create(CreateSuspended:boolean);
       destructor Destroy; override;
       procedure Resume;
       procedure Suspend;
       procedure Terminate;
       procedure HardTerminate;
       procedure TerminateAndWait;
       procedure WaitFor;
       property FreeOnTerminate:boolean read FFreeOnTerminate write FFreeOnTerminate;
       property Handle:THandle read FHandle;
       property Priority:TBeRoThreadPriority read GetPriority write SetPriority;
       property Suspended:boolean read FSuspended write SetSuspended;
       property ThreadID:TThreadID read FThreadID;
     end;
{$ELSE}
 {$IFDEF FPC}
uses SysUtils,Classes,SyncObjs;

type TBeRoThread=class(TThread)
      private
      protected
      public
       constructor Create(CreateSuspended:boolean);
       destructor Destroy; override;
       procedure HardTerminate;
       procedure TerminateAndWait;
       procedure ThreadEnter;
       procedure ThreadLeave;
       procedure Enter;
       procedure Leave;
     end;
 {$ENDIF}
{$ENDIF}

implementation

{$IFDEF WIN32}
function ThreadProc(Thread:TBeRoThread):dword;
var ThreadBeendet:boolean;
begin
 Thread.Execute;
 ThreadBeendet:=Thread.FFreeOnTerminate;
 result:=Thread.FReturnValue;
 Thread.FFinished:=true;
 if ThreadBeendet then begin
  Thread.Free;
  Thread:=nil;
 end;
 EndThread(result);
end;

constructor TBeRoThread.Create(CreateSuspended:boolean);
var Flags:dword;
begin
 inherited Create;
 FSuspended:=CreateSuspended;
 Flags:=0;
 if CreateSuspended then Flags:=CREATE_SUSPENDED;
 FHandle:=BeginThread(nil,0,@ThreadProc,pointer(self),Flags,FThreadID);
end;

destructor TBeRoThread.Destroy;
begin
 if FHandle<>0 then CloseHandle(FHandle);
 inherited Destroy;
end;

const Priorities:array[TBeRoThreadPriority] of integer=
      (THREAD_PRIORITY_IDLE,THREAD_PRIORITY_LOWEST,THREAD_PRIORITY_BELOW_NORMAL,
       THREAD_PRIORITY_NORMAL,THREAD_PRIORITY_ABOVE_NORMAL,THREAD_PRIORITY_HIGHEST,
       THREAD_PRIORITY_TIME_CRITICAL);

function TBeRoThread.GetPriority:TBeRoThreadPriority;
var P:integer;
    I:TBeRoThreadPriority;
begin
 P:=GetThreadPriority(FHandle);
 result:=tpNormal;
 for I:=low(TBeRoThreadPriority) to high(TBeRoThreadPriority) do if Priorities[I]=P then result:=I;
end;

procedure TBeRoThread.SetPriority(Value:TBeRoThreadPriority);
begin
 SetThreadPriority(FHandle,Priorities[Value]);
end;

procedure TBeRoThread.SetSuspended(Value:boolean);
begin
 if Value<>FSuspended then begin
  if Value then begin
   Suspend;
  end else Resume;
 end;
end;

procedure TBeRoThread.Suspend;
begin
 FSuspended:=true;
 SuspendThread(FHandle);
end;

procedure TBeRoThread.Resume;
begin
 if ResumeThread(FHandle)=1 then FSuspended:=false;
end;

procedure TBeRoThread.Terminate;
begin
 FTerminated:=true;
end;

procedure TBeRoThread.HardTerminate;
begin
 FTerminated:=true;
 WaitForSingleObject(FHandle,25);
 TerminateThread(FHandle,0);
 WaitForSingleObject(FHandle,5000);
end;

procedure TBeRoThread.TerminateAndWait;
begin
 FTerminated:=true;
 WaitForSingleObject(FHandle,longword(-1));
end;

procedure TBeRoThread.WaitFor;
begin
 FTerminated:=true;
 WaitForSingleObject(FHandle,longword(-1));
end;
{$ELSE}
{$IFDEF FPC}
constructor TBeRoThread.Create(CreateSuspended:boolean);
var Flags:dword;
begin
 inherited Create(true);
 FCriticalSection:=TCriticalSection.Create;
 FEntered:=false;
//IF NOT CreateSuspended THEN Resume;
end;

destructor TBeRoThread.Destroy;
begin
 FCriticalSection.Free;
 inherited Destroy;
end;

procedure TBeRoThread.HardTerminate;
begin
 Terminate;
 WaitFor;
end;

procedure TBeRoThread.TerminateAndWait;
begin
 Terminate;
 WaitFor;
end;

procedure TBeRoThread.ThreadEnter;
begin
 FCriticalSection.Enter;
end;

procedure TBeRoThread.ThreadLeave;
begin
 FCriticalSection.Leave;
end;

procedure TBeRoThread.Enter;
begin
 FCriticalSection.Enter;
 FEntered:=true;
end;

procedure TBeRoThread.Leave;
begin
 FEntered:=false;
 FCriticalSection.Leave;
end;
 {$ENDIF}
{$ENDIF}

end.

