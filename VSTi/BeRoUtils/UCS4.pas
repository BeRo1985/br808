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
unit UCS4;
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

interface

uses UTF8;

type TUCS4CHAR=longint;
     TUCS4CHARUNSIGNED=longword;

     TUCS4STRING=array of TUCS4CHAR;

function UCS4Pos(const SubStr,s:TUCS4STRING):integer;
procedure UCS4Delete(var s:TUCS4STRING;index,Len:integer);
function UCS4Compare(const a,b:TUCS4STRING):boolean; overload;
function UCS4Compare(const a:TUCS4STRING;const b:string):boolean; overload;
procedure UCS4Clear(var a:TUCS4STRING);
procedure UCS4AddString(var a:TUCS4STRING;const b:string);
procedure UCS4AddChar(var a:TUCS4STRING;const b:TUCS4CHAR); overload;
procedure UCS4AddChar(var a:TUCS4STRING;const b:char); overload;
procedure UCS4Add(var a:TUCS4STRING;const b:TUCS4STRING);
function UCS4ToUTF8(const s:TUCS4STRING):TUTF8STRING;
function UTF8ToUCS4(const s:TUTF8STRING):TUCS4STRING;
function UCS4ToWIDESTRING(const s:TUCS4STRING):widestring;
function WIDESTRINGToUCS4(const s:widestring):TUCS4STRING;
function UCS4ToSTRING(const s:TUCS4STRING):string;
function STRINGToUCS4(const s:string):TUCS4STRING;

implementation

function UCS4Pos(const SubStr,s:TUCS4STRING):integer;
var i,j:integer;
begin
 result:=-1;
 for i:=0 to length(s)-length(SubStr) do begin
  for j:=0 to length(SubStr)-1 do begin
   if SubStr[j]<>s[i+j] then begin
    break;
   end;
   result:=i;
   exit;
  end;
 end;
end;

procedure UCS4Delete(var s:TUCS4STRING;index,Len:integer);
var i,a,b:integer;
begin
 if index>=length(s) then begin
  exit;
 end;
 if Len>length(s) then begin
  Len:=length(s);
 end;
 if (index+Len)>=length(s) then begin
  Len:=length(s)-index;
 end;
 a:=index+Len;
 b:=index;
 i:=length(s)-a;
 move(s[a],s[b],i*sizeof(TUCS4Char));
 setlength(s,length(s)-Len);
end;

function UCS4Compare(const a,b:TUCS4STRING):boolean; overload;
var i:integer;
begin
 if a=b then begin
  result:=true;
  exit;
 end;
 if length(a)<>length(b) then begin
  result:=false;
  exit;
 end;
 for i:=0 to length(a)-1 do begin
  if a[i]<>b[i] then begin
   result:=false;
   exit;
  end;
 end;
 result:=true;
end;

function UCS4Compare(const a:TUCS4STRING;const b:string):boolean; overload;
var i:integer;
begin
 if length(a)<>length(b) then begin
  result:=false;
  exit;
 end;
 for i:=0 to length(a)-1 do begin
  if a[i]<>byte(b[i+1]) then begin
   result:=false;
   exit;
  end;
 end;
 result:=true;
end;

procedure UCS4Clear(var a:TUCS4STRING);
begin
 setlength(a,0);
end;

procedure UCS4AddString(var a:TUCS4STRING;const b:string);
var i,j:integer;
begin
 j:=length(a);
 setlength(a,j+length(b));
 for i:=1 to length(b) do begin
  a[j+i-1]:=byte(b[i]);
 end;
end;

procedure UCS4AddChar(var a:TUCS4STRING;const b:TUCS4CHAR); overload;
var j:integer;
begin
 j:=length(a);
 setlength(a,j+1);
 a[j]:=b;
end;

procedure UCS4AddChar(var a:TUCS4STRING;const b:char); overload;
var j:integer;
begin
 j:=length(a);
 setlength(a,j+1);
 a[j]:=byte(b);
end;

procedure UCS4Add(var a:TUCS4STRING;const b:TUCS4STRING);
var i,j:integer;
begin
 j:=length(a);
 setlength(a,j+length(b));
 for i:=0 to length(b)-1 do begin
  a[j+i]:=byte(b[i]);
 end;
end;

function UCS4ToUTF8(const s:TUCS4STRING):TUTF8STRING;
var i,j:integer;
    u4c:TUCS4CHARUNSIGNED;
begin
 result:='';
 j:=0;
 for i:=0 to length(s)-1 do begin
  u4c:=s[i];
  if u4c<=$7f then begin
   inc(j);
  end else if u4c<=$7ff then begin
   inc(j,2);
  end else if u4c<=$ffff then begin
   inc(j,3);
  end else if u4c<=$1fffff then begin
   inc(j,4);
  end else if u4c<=$3ffffff then begin
   inc(j,5);
  end else if u4c<=$7fffffff then begin
   inc(j,6);
  end;
 end;
 setlength(result,j);
 j:=1;
 for i:=0 to length(s)-1 do begin
  u4c:=s[i];
  if u4c<=$7f then begin
   result[j]:=chr(u4c);
   inc(j);
  end else if u4c<=$7ff then begin
   result[j]:=chr($c0 or (u4c shr 6));
   result[j+1]:=chr($80 or (u4c and $3f));
   inc(j,2);
  end else if u4c<=$ffff then begin
   result[j]:=chr($e0 or (u4c shr 12));
   result[j+1]:=chr($80 or ((u4c shr 6) and $3f));
   result[j+2]:=chr($80 or (u4c and $3f));
   inc(j,3);
  end else if u4c<=$1fffff then begin
   result[j]:=chr($f0 or (u4c shr 18));
   result[j+1]:=chr($80 or ((u4c shr 12) and $3f));
   result[j+2]:=chr($80 or ((u4c shr 6) and $3f));
   result[j+3]:=chr($80 or (u4c and $3f));
   inc(j,4);
  end else if u4c<=$3ffffff then begin
   result[j]:=chr($f8 or (u4c shr 24));
   result[j+1]:=chr($80 or ((u4c shr 18) and $3f));
   result[j+2]:=chr($80 or ((u4c shr 12) and $3f));
   result[j+3]:=chr($80 or ((u4c shr 6) and $3f));
   result[j+4]:=chr($80 or (u4c and $3f));
   inc(j,5);
  end else if u4c<=$7fffffff then begin
   result[j]:=chr($fc or (u4c shr 30));
   result[j+1]:=chr($80 or ((u4c shr 24) and $3f));
   result[j+2]:=chr($80 or ((u4c shr 18) and $3f));
   result[j+3]:=chr($80 or ((u4c shr 12) and $3f));
   result[j+4]:=chr($80 or ((u4c shr 6) and $3f));
   result[j+5]:=chr($80 or (u4c and $3f));
   inc(j,6);
  end;
 end;
end;

function UTF8ToUCS4(const s:TUTF8STRING):TUCS4STRING;
var i,j:integer;
    b:byte;
begin
 j:=0;
 i:=1;
 while i<=length(s) do begin
  b:=byte(s[i]);
  if (b and $80)=0 then begin
   inc(i);
   inc(j);
  end else if ((i+1)<length(s)) and ((b and $e0)=$c0) then begin
   if (byte(s[i+1]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   inc(i,2);
   inc(j);
  end else if ((i+2)<length(s)) and ((b and $f0)=$e0) then begin
   if (byte(s[i+1]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+2]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   inc(i,3);
   inc(j);
  end else if ((i+3)<length(s)) and ((b and $f8)=$f0) then begin
   if (byte(s[i+1]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+2]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+3]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   inc(i,4);
   inc(j);
  end else if ((i+4)<length(s)) and ((b and $fc)=$f8) then begin
   if (byte(s[i+1]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+2]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+3]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+4]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   inc(i,5);
   inc(j);
  end else if ((i+5)<length(s)) and ((b and $fe)=$fc)then begin
   if (byte(s[i+1]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+2]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+3]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+4]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   if (byte(s[i+5]) and $c0)<>$80 then begin
    j:=0;
    break;
   end;
   inc(i,6);
   inc(j);
  end else begin
   j:=0;
   break;
  end;
 end;
 setlength(result,j);
 if j=0 then begin
  exit;
 end;
 j:=0;
 i:=1;
 while i<=length(s) do begin
  b:=byte(s[i]);
  if (b and $80)=0 then begin
   result[j]:=b;
   inc(i);
   inc(j);
  end else if ((i+1)<length(s)) and ((b and $e0)=$c0) then begin
   result[j]:=((byte(s[i]) and $3f) shl 6) or (byte(s[i+1]) and $3f);
   inc(i,2);
   inc(j);
  end else if ((i+2)<length(s)) and ((b and $f0)=$e0) then begin
   result[j]:=((byte(s[i]) and $3f) shl 12) or ((byte(s[i+1]) and $3f) shl 6) or (byte(s[i+2]) and $3f);
   inc(i,3);
   inc(j);
  end else if ((i+3)<length(s)) and ((b and $f8)=$f0) then begin
   result[j]:=((byte(s[i]) and $3f) shl 18) or ((byte(s[i+1]) and $3f) shl 12) or ((byte(s[i+2]) and $3f) shl 6) or (byte(s[i+3]) and $3f);
   inc(i,4);
   inc(j);
  end else if ((i+4)<length(s)) and ((b and $fc)=$f8) then begin
   result[j]:=((byte(s[i]) and $3f) shl 24) or ((byte(s[i+1]) and $3f) shl 18) or ((byte(s[i+2]) and $3f) shl 12) or ((byte(s[i+3]) and $3f) shl 6) or (byte(s[i+4]) and $3f);
   inc(i,5);
   inc(j);
  end else if ((i+5)<length(s)) and ((b and $fe)=$fc) then begin
   result[j]:=((byte(s[i]) and $3f) shl 30) or ((byte(s[i+1]) and $3f) shl 24) or ((byte(s[i+2]) and $3f) shl 18) or ((byte(s[i+3]) and $3f) shl 12) or ((byte(s[i+4]) and $3f) shl 6) or (byte(s[i+5]) and $3f);
   inc(i,6);
   inc(j);
  end else begin
   break;
  end;
 end;
end;

function UCS4ToWIDESTRING(const s:TUCS4STRING):widestring;
var i:integer;
begin
 setlength(result,length(s));
 for i:=0 to length(s)-1 do begin
  result[i+1]:=widechar(word(s[i]));
 end;
end;

function WIDESTRINGToUCS4(const s:widestring):TUCS4STRING;
var i:integer;
begin
 setlength(result,length(s));
 for i:=1 to length(s) do begin
  result[i-1]:=word(widechar(s[i]));
 end;
end;

function UCS4ToSTRING(const s:TUCS4STRING):string;
var i:integer;
begin
 setlength(result,length(s));
 for i:=0 to length(s)-1 do begin
  result[i+1]:=char(byte(s[i]));
 end;
end;

function STRINGToUCS4(const s:string):TUCS4STRING;
var i:integer;
begin
 setlength(result,length(s));
 for i:=1 to length(s) do begin
  result[i-1]:=byte(char(s[i]));
 end;
end;

end.
