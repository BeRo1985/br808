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
unit UTF8;
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

type TUTF8STRING=string;

function WIDESTRINGToUTF8(const s:widestring):TUTF8STRING;
function UTF8ToWIDESTRING(const s:TUTF8STRING):widestring;

implementation

function WIDESTRINGToUTF8(const s:widestring):TUTF8STRING;
var i,j:integer;
    wc:longword;
begin
 result:='';
 j:=0;
 for i:=1 to length(s) do begin
  wc:=word(s[i]);
  if wc<=$7f then begin
   inc(j);
  end else if wc<=$7ff then begin
   inc(j,2);
  end else if wc<=$ffff then begin
   inc(j,3);
  end;
 end;
 setlength(result,j);
 j:=1;
 for i:=1 to length(s) do begin
  wc:=word(s[i]);
  if wc<=$7f then begin
   result[j]:=chr(wc);
   inc(j);
  end else if wc<=$7ff then begin
   result[j]:=chr($c0 or (wc shr 6));
   result[j+1]:=chr($80 or (wc and $3f));
   inc(j,2);
  end else if wc<=$ffff then begin
   result[j]:=chr($e0 or (wc shr 12));
   result[j+1]:=chr($80 or ((wc shr 6) and $3f));
   result[j+2]:=chr($80 or (wc and $3f));
   inc(j,3);
  end;
 end;
end;

function UTF8ToWIDESTRING(const s:TUTF8STRING):widestring;
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
  end else begin
   j:=0;
   break;
  end;
 end;
 setlength(result,j);
 if j=0 then begin
  exit;
 end;
 j:=1;
 i:=1;
 while i<=length(s) do begin
  b:=byte(s[i]);
  if (b and $80)=0 then begin
   result[j]:=widechar(word(b));
   inc(i);
   inc(j);
  end else if ((i+1)<length(s)) and ((b and $e0)=$c0) then begin
   result[j]:=widechar(word(((byte(s[i]) and $3f) shl 6) or (byte(s[i+1]) and $3f)));
   inc(i,2);
   inc(j);
  end else if ((i+2)<length(s)) and ((b and $f0)=$e0) then begin
   result[j]:=widechar(word(((byte(s[i]) and $3f) shl 12) or ((byte(s[i+1]) and $3f) shl 6) or (byte(s[i+2]) and $3f)));
   inc(i,3);
   inc(j);
  end else begin
   break;
  end;
 end;
end;

end.

