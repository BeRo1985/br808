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
program BMFPlayerStub;
{$IMAGEBASE $00450000}
{$APPTYPE GUI}

uses
  Windows,
  Messages,
  CommCtrl,
  ShellApi,
  Synth in '..\Synth.pas';

const AString:pchar='';

var WndClass:TWndClassA;
    Inst:HINST;
    hWindow:HWND;
    Msg:TMsg;
    FormMain:HWND;
    hfFormMain:HFONT;
    GroupBoxTrackName:HWND;
    EditTrackName:HWND;
    GroupBoxAuthor:HWND;
    EditAuthor:HWND;
    GroupBoxComments:HWND;
    MemoComments:HWND;
    GroupBoxPosition:HWND;
    TrackBarPosition:HWND;
    GroupBoxControls:HWND;
    ButtonPlay:HWND;
    ButtonStop:HWND;
    hfButtonStop:HFONT;
    hpButtonStop:HPEN;
    ButtonPause:HWND;
    CheckBoxLoop:HWND;
    ButtonWWW:HWND;
    ButtonExit:HWND;
    Track:PSynthTrack;
    mslength,ap,np:int64;
    First:boolean;

var inttopcharbuffer:array[0..256] of char;
function inttopchar(x:int64):pchar;
var i:integer;
begin
 fillchar(inttopcharbuffer,sizeof(inttopcharbuffer),#0);
 i:=high(inttopcharbuffer);
 while (x>0) or (i=high(inttopcharbuffer)) do begin
  dec(i);
  inttopcharbuffer[i]:=char(byte(byte(x mod 10)+byte('0')));
  x:=x div 10;
 end;
 result:=@inttopcharbuffer[i];
end;

function PCharLength(const A:pchar):integer; register; assembler;
asm
 MOV EDX,EDI
 MOV EDI,EAX
 xor EAX,EAX
 TEST EDI,EDI
 JZ @exit
 MOV ECX,$ffffffff
 REPNE SCASB
 MOV EAX,$fffffffe
 SUB EAX,ECX
 @exit:
 MOV EDI,EDX
end;

var UpdateTimeBuf:array[0..256] of char;
procedure UpdateTime(Position,Duration:int64);
var p:pchar;
    i,j:integer;
begin
 fillchar(UpdateTimeBuf,sizeof(UpdateTimeBuf),#0);
 i:=0;

 p:=inttopchar((Position div 1000) div (60*60));
 j:=PCharLength(p);
 if j=1 then begin
  UpdateTimeBuf[i]:='0';
  inc(i);
 end;
 move(p^,UpdateTimeBuf[i],j);
 inc(i,j);
 UpdateTimeBuf[i]:=':';
 inc(i);
 p:=inttopchar(((Position div 1000) div 60) mod 60);
 j:=PCharLength(p);
 if j=1 then begin
  UpdateTimeBuf[i]:='0';
  inc(i);
 end;
 move(p^,UpdateTimeBuf[i],j);
 inc(i,j);
 UpdateTimeBuf[i]:=':';
 inc(i);
 p:=inttopchar((Position div 1000) mod 60);
 j:=PCharLength(p);
 if j=1 then begin
  UpdateTimeBuf[i]:='0';
  inc(i);
 end;
 move(p^,UpdateTimeBuf[i],j); inc(i,j);

 UpdateTimeBuf[i]:=' ';
 inc(i);
 UpdateTimeBuf[i]:='/';
 inc(i);
 UpdateTimeBuf[i]:=' ';
 inc(i);

 inc(Duration,500);

 p:=inttopchar((Duration div 1000) div (60*60));
 j:=PCharLength(p);
 if j=1 then begin
  UpdateTimeBuf[i]:='0';
  inc(i);
 end;
 move(p^,UpdateTimeBuf[i],j);
 inc(i,j);
 UpdateTimeBuf[i]:=':';
 inc(i);
 p:=inttopchar(((Duration div 1000) div 60) mod 60);
 j:=PCharLength(p);
 if j=1 then begin
  UpdateTimeBuf[i]:='0';
  inc(i);
 end;
 move(p^,UpdateTimeBuf[i],j);
 inc(i,j);
 UpdateTimeBuf[i]:=':';
 inc(i);
 p:=inttopchar((Duration div 1000) mod 60);
 j:=PCharLength(p);
 if j=1 then begin
  UpdateTimeBuf[i]:='0';
  inc(i);
 end;
 move(p^,UpdateTimeBuf[i],j); inc(i,j);

 UpdateTimeBuf[i]:=' ';
 inc(i);
 UpdateTimeBuf[i]:='m';
 inc(i);
 UpdateTimeBuf[i]:='i';
 inc(i);
 UpdateTimeBuf[i]:='n';

 SetWindowText(GroupBoxPosition,@UpdateTimeBuf[0]);
end;

function WindowProc(hWindow:HWnd;message,wParam,lParam:integer):integer; stdcall;
var WDC:integer;
    WRECT:TRECT;
begin
 result:=0;
 case message of
  WM_CREATE:begin
   InitCommonControls;
  end;
  WM_DESTROY:begin
   PostQuitMessage(0);
  end;
  WM_COMMAND:begin
   if hiword(wParam)=BN_CLICKED then begin
    if lParam=ButtonPlay then begin
     if not Track.Played then begin
      SynthEnter(Track);
      SynthPlay(Track);
      SynthLeave(Track);
     end;
    end else if lParam=ButtonStop then begin
     if Track.Played then begin
      SynthEnter(Track);
      SynthStop(Track);
      SynthReset(Track);
      SynthLeave(Track);
     end;
     SendMessage(TrackBarPosition,TBM_SETPOS,1,0);
     UpdateTime(0,mslength);
    end else if lParam=ButtonPause then begin
     if Track.Played then begin
      SynthEnter(Track);
      SynthStop(Track);
      SynthLeave(Track);
     end;
    end else if lParam=ButtonWWW then begin
     ShellExecute(hWindow,'open','http://www.rosseaux.com/','','',SW_SHOWMAXIMIZED);
    end else if lParam=ButtonExit then begin
     PostQuitMessage(0);
    end;
   end;
  end;
  WM_SIZE:begin
  end;
  WM_PAINT:begin
   result:=DefWindowProc(hWindow,message,wParam,lParam);
  end;
  WM_DrawItem:begin
   result:=DefWindowProc(hWindow,message,wParam,lParam);
  end;
  WM_HSCROLL:begin
   case LoWord(wParam) of
    TB_THUMBTRACK,TB_TOP,TB_BOTTOM,TB_LINEUP,TB_LINEDOWN,TB_PAGEDOWN,TB_PAGEUP:begin
     if lParam=TrackBarPosition then begin
      np:=SendMessage(TrackBarPosition,TBM_GETPOS,0,0);
      if ap<>np then begin
       SynthEnter(Track);
       SynthSeekToMS(Track,np*1000);
       SynthLeave(Track);
      end;
     end;
    end;
   end;
  end;
  else begin
   result:=DefWindowProc(hWindow,message,wParam,lParam);
  end;
 end;
end;

const TrackData:array[1..4] of char='TRDA';
      TrackSize:array[1..4] of char='TRSI';
begin
{$ifdef cpu386}
 asm
  fldcw word ptr SynthFCW
 end;
{$endif}

 Inst:=hInstance;
 with WndClass do begin
  Style:=CS_CLASSDC or CS_PARENTDC;
  lpfnWndProc:=@WindowProc;
  hInstance:=Inst;
  hbrBackground:=color_btnface+1;
  lpszClassname:='TFormMain';
  hIcon:=LoadIcon(0,IDI_APPLICATION);
  hCursor:=LoadCursor(0,IDC_ARROW);
 end;

 new(Track);
 SynthInit(Track,SynthReadBMFSampleRate(pointer(TrackData),integer(TrackSize)),2048);
 SynthReadBMF(Track,pointer(TrackData),integer(TrackSize));
 mslength:=SynthSeekToMS(Track,-1);

 RegisterClass(WndClass);

 hWindow:=CreateWindowEx(WS_EX_WINDOWEDGE,'TFormMain','BR808 Player ©'#39'11, Benjamin '#39'BeRo'#39' Rosseaux',WS_OVERLAPPED or WS_SYSMENU or WS_CAPTION or WS_VISIBLE,(GetSystemMetrics(SM_CXSCREEN)-(317+4)) div 2,(GetSystemMetrics(SM_CYSCREEN)-(291+24)) div 2,317+(2*GetSystemMetrics(SM_CXFRAME)),291+(GetSystemMetrics(SM_CYFRAME)+GetSystemMetrics(SM_CYCAPTION)),0,0,Inst,nil);
 FormMain:=hWindow;

 hfFormMain:=CreateFont(-11,0,0,700,0,0,0,0,DEFAULT_CHARSET,0,0,0,0,'MS Sans Serif');
 SendMessage(FormMain,WM_SETFONT,hfFormMain,0);

 GroupBoxTrackName:=CreateWindow('Button','Track name',WS_VISIBLE or WS_CHILD or BS_GROUPBOX,0,0,317,45,hWindow,0,Inst,nil);

 EditTrackName:=CreateWindowEx(WS_EX_CLIENTEDGE,'Edit',pchar(Track^.Informations.TrackName),WS_VISIBLE or WS_CHILD or WS_BORDER or WS_TABSTOP,6,16,305,21,GroupBoxTrackName,0,Inst,nil);
 SendMessage(EditTrackName,WM_SETFONT,hfFormMain,0);

 GroupBoxAuthor:=CreateWindow('Button','Author',WS_VISIBLE or WS_CHILD or BS_GROUPBOX,0,45,317,45,hWindow,0,Inst,nil);

 EditAuthor:=CreateWindowEx(WS_EX_CLIENTEDGE,'Edit',pchar(Track^.Informations.Author),WS_VISIBLE or WS_CHILD or WS_BORDER or WS_TABSTOP,6,16,305,21,GroupBoxAuthor,0,Inst,nil);
 SendMessage(EditAuthor,WM_SETFONT,hfFormMain,0);

 GroupBoxComments:=CreateWindow('Button','Comments',WS_VISIBLE or WS_CHILD or BS_GROUPBOX,0,90,317,107,hWindow,0,Inst,nil);

 MemoComments:=CreateWindowEx(WS_EX_CLIENTEDGE,'Edit',Track^.Informations.Comments,WS_VISIBLE or WS_CHILD or WS_BORDER or ES_MULTILINE or ES_WANTRETURN or ES_AUTOVSCROLL or ES_LEFT,2,15,313,90,GroupBoxComments,0,Inst,nil);
 SendMessage(MemoComments,WM_SETTEXT,0,LPARAM(pchar(Track^.Informations.Comments)));
 SendMessage(MemoComments,WM_SETFONT,hfFormMain,0);

 GroupBoxPosition:=CreateWindow('Button','0:00 / 0:00 min',WS_VISIBLE or WS_CHILD or BS_GROUPBOX,0,197,317,56,hWindow,0,Inst,nil);

 TrackBarPosition:=CreateWindow('MSCtls_TrackBar32','TrackBar',WS_VISIBLE or WS_CHILD or TBS_HORZ or TBS_AUTOTICKS or TBS_BOTTOM or CS_DBLCLKS,2,197+15,313,39,hWindow,0,Inst,nil);
 SendMessage(TrackBarPosition,TBM_SETTHUMBLENGTH,20,0);
 SendMessage(TrackBarPosition,TBM_SETLINESIZE,0,1);
 SendMessage(TrackBarPosition,TBM_SETPAGESIZE,0,2);
 SendMessage(TrackBarPosition,TBM_SETRANGEMIN,0,0);
 SendMessage(TrackBarPosition,TBM_SETRANGEMAX,0,msLength div 1000);
 SendMessage(TrackBarPosition,TBM_SETPOS,1,0);
 SendMessage(TrackBarPosition,TBM_SETTICFREQ,msLength div 16000,1);
 SendMessage(TrackBarPosition,WM_SETFONT,hfFormMain,0);

 GroupBoxControls:=CreateWindow('Button','',WS_VISIBLE or WS_CHILD or BS_GROUPBOX,0,250,317,41,hWindow,0,Inst,nil);

 ButtonPlay:=CreateWindow('Button','>',WS_VISIBLE or WS_CHILD or WS_TABSTOP or BS_PUSHLIKE or BS_TEXT,4,250+12,24,25,hWindow,0,Inst,nil);
 SendMessage(ButtonPlay,WM_SETFONT,hfFormMain,0);

 ButtonStop:=CreateWindow('Button','”',WS_VISIBLE or WS_CHILD or WS_TABSTOP or BS_PUSHLIKE or BS_TEXT,34,250+12,24,25,hWindow,0,Inst,nil);
 hfButtonStop:=CreateFont(-11,0,0,700,0,0,0,0,DEFAULT_CHARSET,0,0,0,0,'Fixedsys');
 SendMessage(ButtonStop,WM_SETFONT,hfButtonStop,0);

 ButtonPause:=CreateWindow('Button','',WS_VISIBLE or WS_CHILD or WS_TABSTOP or BS_PUSHLIKE or BS_TEXT,64,250+12,24,25,hWindow,0,Inst,nil);
 SendMessage(ButtonPause,WM_SETFONT,hfFormMain,0);

 CheckBoxLoop:=CreateWindowEx(0,'Button','&Loop',WS_VISIBLE or WS_CHILD or WS_TABSTOP or WS_CHILD or BS_AUTOCHECKBOX,100,252+12,90,25,hWindow,0,Inst,nil);
 SendMessage(CheckBoxLoop,BM_SETCHECK,BST_CHECKED,0);

 ButtonWWW:=CreateWindow('Button','&WWW',WS_VISIBLE or WS_CHILD or WS_TABSTOP or BS_PUSHLIKE or BS_TEXT,226,250+12,48,25,hWindow,0,Inst,nil);
 SendMessage(ButtonWWW,WM_SETFONT,hfFormMain,0);

 ButtonExit:=CreateWindow('Button','&Exit',WS_VISIBLE or WS_CHILD or WS_TABSTOP or BS_PUSHLIKE or BS_TEXT,278,250+12,32,25,hWindow,0,Inst,nil);
 SendMessage(ButtonExit,WM_SETFONT,hfFormMain,0);

 UpdateWindow(hWindow);

 SetFocus(ButtonPause);

 First:=true;
 SynthPlay(Track);
 ap:=SynthGetTimePosition(Track);
 while true do begin
  if PeekMessage(Msg,0,0,0,PM_REMOVE) then begin
   if Msg.Message=WM_QUIT then begin
    break;
   end else begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
   end;
  end;
  sleep(10);
  np:=SynthGetTimePosition(Track);
  if np>=mslength then begin
   np:=mslength;
   if Track.Played and (SendMessage(CheckBoxLoop,BM_GETCHECK,0,0)=BST_CHECKED) then begin
    SynthEnter(Track);
    SynthReset(Track);
    SynthLeave(Track);
    np:=SynthGetTimePosition(Track);
   end;
  end;
  if ((ap div 1000)<>(np div 1000)) or First then begin
   First:=false;
   ap:=np;
   SendMessage(TrackBarPosition,TBM_SETPOS,1,SynthGetTimePosition(Track) div 1000);
   UpdateTime(np,mslength);
  end;
 end;
 SynthEnter(Track);
 SynthStop(Track);
 SynthLeave(Track);
 SynthDone(Track);
 dispose(Track);
end.
