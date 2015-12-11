(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2004-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit SpeechTools;

interface

uses BeRoUtils;

function SpeechConvertARPABETToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
function SpeechConvertDECTALKToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
function SpeechConvertEdinToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
function SpeechConvertMACTALKToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
function SpeechConvertMRPAToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
function SpeechConvertSAMPAToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
function SpeechConvertViruzIIToAlvey(Phonems:string;American:boolean;Divider:string=''):string;

implementation

type TSpeechConvertToAlveyItem=record
      name,DictBR,DictAM:string[3];
     end;

const SpeechARPABETToAlveyArray:array[0..45] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                           (name:'b';DictBR:'b';DictAM:'b'),
                                                                           (name:'ch';DictBR:'tS';DictAM:'tS'),
                                                                           (name:'d';DictBR:'d';DictAM:'d'),
                                                                           (name:'dh';DictBR:'D';DictAM:'D'),
                                                                           (name:'f';DictBR:'f';DictAM:'f'),
                                                                           (name:'g';DictBR:'g';DictAM:'g'),
                                                                           (name:'hh';DictBR:'h';DictAM:'h'),
                                                                           (name:'jh';DictBR:'dZ';DictAM:'dZ'),
                                                                           (name:'k';DictBR:'k';DictAM:'k'),
                                                                           (name:'l';DictBR:'l';DictAM:'l'),
                                                                           (name:'m';DictBR:'m';DictAM:'m'),
                                                                           (name:'n';DictBR:'n';DictAM:'n'),
                                                                           (name:'ng';DictBR:'9';DictAM:'9'),
                                                                           (name:'p';DictBR:'p';DictAM:'p'),
                                                                           (name:'r';DictBR:'r';DictAM:'r'),
                                                                           (name:'s';DictBR:'s';DictAM:'s'),
                                                                           (name:'sh';DictBR:'S';DictAM:'S'),
                                                                           (name:'t';DictBR:'t';DictAM:'t'),
                                                                           (name:'th';DictBR:'T';DictAM:'T'),
                                                                           (name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                           (name:'v';DictBR:'v';DictAM:'v'),
                                                                           (name:'w';DictBR:'w';DictAM:'w'),
                                                                           (name:'y';DictBR:'j';DictAM:'j'),
                                                                           (name:'z';DictBR:'z';DictAM:'z'),
                                                                           (name:'zh';DictBR:'Z';DictAM:'Z'),
                                                                           (name:'ax';DictBR:'@';DictAM:'@'),
                                                                           (name:'aa';DictBR:'A';DictAM:'A'),
                                                                           (name:'ae';DictBR:'&';DictAM:'&'),
                                                                           (name:'ah';DictBR:'V';DictAM:'V'),
                                                                           (name:'ao';DictBR:'O';DictAM:'O'),
                                                                           (name:'aw';DictBR:'aU';DictAM:'aU'),
                                                                           (name:'ay';DictBR:'aI';DictAM:'aI'),
                                                                           (name:'ea';DictBR:'e@';DictAM:'e@'),
                                                                           (name:'eh';DictBR:'e';DictAM:'e'),
                                                                           (name:'er';DictBR:'3';DictAM:'3R'),
                                                                           (name:'ey';DictBR:'eI';DictAM:'eI'),
                                                                           (name:'ia';DictBR:'I@';DictAM:'I@'),
                                                                           (name:'ih';DictBR:'I';DictAM:'I'),
                                                                           (name:'iy';DictBR:'i';DictAM:'i'),
                                                                           (name:'oh';DictBR:'0';DictAM:'0'),
                                                                           (name:'ow';DictBR:'@U';DictAM:'oU'),
                                                                           (name:'oy';DictBR:'oI';DictAM:'oI'),
                                                                           (name:'ua';DictBR:'U@';DictAM:'u'),
                                                                           (name:'uh';DictBR:'U';DictAM:'U'),
                                                                           (name:'uw';DictBR:'u';DictAM:'u'));

function SpeechConvertARPABETToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z':begin
    S:=LOCASE(C);
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z']) then begin
     inc(Counter);
     S:=S+LOCASE(Phonems[Counter]);
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechARPABETToAlveyArray) to high(SpeechARPABETToAlveyArray) do begin
      if SpeechARPABETToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechARPABETToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechARPABETToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

const SpeechDECTALKToAlveyArray:array[0..46] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                           (name:'b';DictBR:'b';DictAM:'b'),
                                                                           (name:'ch';DictBR:'tS';DictAM:'tS'),
                                                                           (name:'d';DictBR:'d';DictAM:'d'),
                                                                           (name:'dh';DictBR:'D';DictAM:'D'),
                                                                           (name:'f';DictBR:'f';DictAM:'f'),
                                                                           (name:'g';DictBR:'g';DictAM:'g'),
                                                                           (name:'h';DictBR:'h';DictAM:'h'),
                                                                           (name:'hx';DictBR:'h';DictAM:'h'),
                                                                           (name:'yx';DictBR:'dZ';DictAM:'dZ'),
                                                                           (name:'k';DictBR:'k';DictAM:'k'),
                                                                           (name:'lx';DictBR:'l';DictAM:'l'),
                                                                           (name:'m';DictBR:'m';DictAM:'m'),
                                                                           (name:'n';DictBR:'n';DictAM:'n'),
                                                                           (name:'nx';DictBR:'9';DictAM:'9'),
                                                                           (name:'p';DictBR:'p';DictAM:'p'),
                                                                           (name:'rr';DictBR:'r';DictAM:'r'),
                                                                           (name:'s';DictBR:'s';DictAM:'s'),
                                                                           (name:'sh';DictBR:'S';DictAM:'S'),
                                                                           (name:'t';DictBR:'t';DictAM:'t'),
                                                                           (name:'th';DictBR:'T';DictAM:'T'),
                                                                           (name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                           (name:'v';DictBR:'v';DictAM:'v'),
                                                                           (name:'w';DictBR:'w';DictAM:'w'),
                                                                           (name:'y';DictBR:'j';DictAM:'j'),
                                                                           (name:'z';DictBR:'z';DictAM:'z'),
                                                                           (name:'zh';DictBR:'Z';DictAM:'Z'),
                                                                           (name:'ax';DictBR:'@';DictAM:'@'),
                                                                           (name:'aa';DictBR:'A';DictAM:'A'),
                                                                           (name:'ae';DictBR:'&';DictAM:'&'),
                                                                           (name:'ah';DictBR:'V';DictAM:'V'),
                                                                           (name:'ao';DictBR:'O';DictAM:'O'),
                                                                           (name:'aw';DictBR:'aU';DictAM:'aU'),
                                                                           (name:'ay';DictBR:'aI';DictAM:'aI'),
                                                                           (name:'ea';DictBR:'e@';DictAM:'e@'),
                                                                           (name:'eh';DictBR:'e';DictAM:'e'),
                                                                           (name:'er';DictBR:'3';DictAM:'3R'),
                                                                           (name:'ey';DictBR:'eI';DictAM:'eI'),
                                                                           (name:'ia';DictBR:'I@';DictAM:'I@'),
                                                                           (name:'ih';DictBR:'I';DictAM:'I'),
                                                                           (name:'iy';DictBR:'i';DictAM:'i'),
                                                                           (name:'oh';DictBR:'0';DictAM:'0'),
                                                                           (name:'ow';DictBR:'@U';DictAM:'oU'),
                                                                           (name:'oy';DictBR:'oI';DictAM:'oI'),
                                                                           (name:'ua';DictBR:'U@';DictAM:'u'),
                                                                           (name:'uh';DictBR:'U';DictAM:'U'),
                                                                           (name:'u';DictBR:'u';DictAM:'u'));

function SpeechConvertDECTALKToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z':begin
    S:=LOCASE(C);
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z']) then begin
     inc(Counter);
     S:=S+LOCASE(Phonems[Counter]);
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechDECTALKToAlveyArray) to high(SpeechDECTALKToAlveyArray) do begin
      if SpeechDECTALKToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechDECTALKToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechDECTALKToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

const SpeechEdinToAlveyArray:array[0..45] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                        (name:'b';DictBR:'b';DictAM:'b'),
                                                                        (name:'ch';DictBR:'tS';DictAM:'tS'),
                                                                        (name:'d';DictBR:'d';DictAM:'d'),
                                                                        (name:'dh';DictBR:'D';DictAM:'D'),
                                                                        (name:'f';DictBR:'f';DictAM:'f'),
                                                                        (name:'g';DictBR:'g';DictAM:'g'),
                                                                        (name:'h';DictBR:'h';DictAM:'h'),
                                                                        (name:'j';DictBR:'dZ';DictAM:'dZ'),
                                                                        (name:'k';DictBR:'k';DictAM:'k'),
                                                                        (name:'l';DictBR:'l';DictAM:'l'),
                                                                        (name:'m';DictBR:'m';DictAM:'m'),
                                                                        (name:'n';DictBR:'n';DictAM:'n'),
                                                                        (name:'ng';DictBR:'9';DictAM:'9'),
                                                                        (name:'p';DictBR:'p';DictAM:'p'),
                                                                        (name:'r';DictBR:'r';DictAM:'r'),
                                                                        (name:'s';DictBR:'s';DictAM:'s'),
                                                                        (name:'sh';DictBR:'S';DictAM:'S'),
                                                                        (name:'t';DictBR:'t';DictAM:'t'),
                                                                        (name:'th';DictBR:'T';DictAM:'T'),
                                                                        (name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                        (name:'v';DictBR:'v';DictAM:'v'),
                                                                        (name:'w';DictBR:'w';DictAM:'w'),
                                                                        (name:'y';DictBR:'j';DictAM:'j'),
                                                                        (name:'z';DictBR:'z';DictAM:'z'),
                                                                        (name:'zh';DictBR:'Z';DictAM:'Z'),
                                                                        (name:'a';DictBR:'@';DictAM:'@'),
                                                                        (name:'ar';DictBR:'A';DictAM:'A'),
                                                                        (name:'aa';DictBR:'&';DictAM:'&'),
                                                                        (name:'u';DictBR:'V';DictAM:'V'),
                                                                        (name:'aw';DictBR:'O';DictAM:'O'),
                                                                        (name:'ou';DictBR:'aU';DictAM:'aU'),
                                                                        (name:'ie';DictBR:'aI';DictAM:'aI'),
                                                                        (name:'air';DictBR:'e@';DictAM:'e@'),
                                                                        (name:'e';DictBR:'e';DictAM:'e'),
                                                                        (name:'er';DictBR:'3';DictAM:'3R'),
                                                                        (name:'ai';DictBR:'eI';DictAM:'eI'),
                                                                        (name:'eer';DictBR:'I@';DictAM:'I@'),
                                                                        (name:'i';DictBR:'I';DictAM:'I'),
                                                                        (name:'ee';DictBR:'i';DictAM:'i'),
                                                                        (name:'o';DictBR:'0';DictAM:'0'),
                                                                        (name:'oa';DictBR:'@U';DictAM:'oU'),
                                                                        (name:'oi';DictBR:'oI';DictAM:'oI'),
                                                                        (name:'oor';DictBR:'U@';DictAM:'u'),
                                                                        (name:'oo';DictBR:'U';DictAM:'U'),
                                                                        (name:'uu';DictBR:'u';DictAM:'u'));

function SpeechConvertEdinToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z':begin
    S:=LOCASE(C);
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z']) then begin
     inc(Counter);
     S:=S+LOCASE(Phonems[Counter]);
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z']) then begin
      inc(Counter);
      S:=S+LOCASE(Phonems[Counter]);
     end;
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechEdinToAlveyArray) to high(SpeechEdinToAlveyArray) do begin
      if SpeechEdinToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechEdinToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechEdinToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

const SpeechMACTALKToAlveyArray:array[0..46] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                           (name:'b';DictBR:'b';DictAM:'b'),
                                                                           (name:'C';DictBR:'tS';DictAM:'tS'),
                                                                           (name:'d';DictBR:'d';DictAM:'d'),
                                                                           (name:'D';DictBR:'D';DictAM:'D'),
                                                                           (name:'f';DictBR:'f';DictAM:'f'),
                                                                           (name:'g';DictBR:'g';DictAM:'g'),
                                                                           (name:'h';DictBR:'h';DictAM:'h'),
                                                                           (name:'J';DictBR:'dZ';DictAM:'dZ'),
                                                                           (name:'k';DictBR:'k';DictAM:'k'),
                                                                           (name:'l';DictBR:'l';DictAM:'l'),
                                                                           (name:'m';DictBR:'m';DictAM:'m'),
                                                                           (name:'n';DictBR:'n';DictAM:'n'),
                                                                           (name:'N';DictBR:'9';DictAM:'9'),
                                                                           (name:'p';DictBR:'p';DictAM:'p'),
                                                                           (name:'r';DictBR:'r';DictAM:'r'),
                                                                           (name:'s';DictBR:'s';DictAM:'s'),
                                                                           (name:'S';DictBR:'S';DictAM:'S'),
                                                                           (name:'t';DictBR:'t';DictAM:'t'),
                                                                           (name:'T';DictBR:'T';DictAM:'T'),
                                                                           (name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                           (name:'v';DictBR:'v';DictAM:'v'),
                                                                           (name:'w';DictBR:'w';DictAM:'w'),
                                                                           (name:'y';DictBR:'j';DictAM:'j'),
                                                                           (name:'z';DictBR:'z';DictAM:'z'),
                                                                           (name:'Z';DictBR:'Z';DictAM:'Z'),
                                                                           (name:'UX';DictBR:'@';DictAM:'@'),
                                                                           (name:'AX';DictBR:'@';DictAM:'@'),
                                                                           (name:'AA';DictBR:'A';DictAM:'A'),
                                                                           (name:'AE';DictBR:'&';DictAM:'&'),
                                                                           (name:'AH';DictBR:'V';DictAM:'V'),
                                                                           (name:'AO';DictBR:'O';DictAM:'O'),
                                                                           (name:'AW';DictBR:'aU';DictAM:'aU'),
                                                                           (name:'AY';DictBR:'aI';DictAM:'aI'),
                                                                           (name:'ea';DictBR:'e@';DictAM:'e@'),
                                                                           (name:'EH';DictBR:'e';DictAM:'e'),
                                                                           (name:'er';DictBR:'3';DictAM:'3R'),
                                                                           (name:'EY';DictBR:'eI';DictAM:'eI'),
                                                                           (name:'ia';DictBR:'I@';DictAM:'I@'),
                                                                           (name:'IH';DictBR:'I';DictAM:'I'),
                                                                           (name:'IY';DictBR:'i';DictAM:'i'),
                                                                           (name:'oh';DictBR:'0';DictAM:'0'),
                                                                           (name:'OW';DictBR:'@U';DictAM:'oU'),
                                                                           (name:'OY';DictBR:'oI';DictAM:'oI'),
                                                                           (name:'ua';DictBR:'U@';DictAM:'u'),
                                                                           (name:'UH';DictBR:'U';DictAM:'U'),
                                                                           (name:'UW';DictBR:'u';DictAM:'u'));

function SpeechConvertMACTALKToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z':begin
    S:=C;
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z']) then begin
     inc(Counter);
     S:=S+Phonems[Counter];
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechMACTALKToAlveyArray) to high(SpeechMACTALKToAlveyArray) do begin
      if SpeechMACTALKToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechMACTALKToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechMACTALKToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

const SpeechMRPAToAlveyArray:array[0..45] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                        (name:'b';DictBR:'b';DictAM:'b'),
                                                                        (name:'ch';DictBR:'tS';DictAM:'tS'),
                                                                        (name:'d';DictBR:'d';DictAM:'d'),
                                                                        (name:'dh';DictBR:'D';DictAM:'D'),
                                                                        (name:'f';DictBR:'f';DictAM:'f'),
                                                                        (name:'g';DictBR:'g';DictAM:'g'),
                                                                        (name:'h';DictBR:'h';DictAM:'h'),
                                                                        (name:'j';DictBR:'dZ';DictAM:'dZ'),
                                                                        (name:'k';DictBR:'k';DictAM:'k'),
                                                                        (name:'l';DictBR:'l';DictAM:'l'),
                                                                        (name:'m';DictBR:'m';DictAM:'m'),
                                                                        (name:'n';DictBR:'n';DictAM:'n'),
                                                                        (name:'ng';DictBR:'9';DictAM:'9'),
                                                                        (name:'p';DictBR:'p';DictAM:'p'),
                                                                        (name:'r';DictBR:'r';DictAM:'r'),
                                                                        (name:'s';DictBR:'s';DictAM:'s'),
                                                                        (name:'sh';DictBR:'S';DictAM:'S'),
                                                                        (name:'t';DictBR:'t';DictAM:'t'),
                                                                        (name:'th';DictBR:'T';DictAM:'T'),
                                                                        (name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                        (name:'v';DictBR:'v';DictAM:'v'),
                                                                        (name:'w';DictBR:'w';DictAM:'w'),
                                                                        (name:'y';DictBR:'j';DictAM:'j'),
                                                                        (name:'z';DictBR:'z';DictAM:'z'),
                                                                        (name:'zh';DictBR:'Z';DictAM:'Z'),
                                                                        (name:'@';DictBR:'@';DictAM:'@'),
                                                                        (name:'aa';DictBR:'A';DictAM:'A'),
                                                                        (name:'a';DictBR:'&';DictAM:'&'),
                                                                        (name:'uh';DictBR:'V';DictAM:'V'),
                                                                        (name:'oo';DictBR:'O';DictAM:'O'),
                                                                        (name:'au';DictBR:'aU';DictAM:'aU'),
                                                                        (name:'ai';DictBR:'aI';DictAM:'aI'),
                                                                        (name:'e@';DictBR:'e@';DictAM:'e@'),
                                                                        (name:'e';DictBR:'e';DictAM:'e'),
                                                                        (name:'@@';DictBR:'3';DictAM:'3R'),
                                                                        (name:'ai';DictBR:'eI';DictAM:'eI'),
                                                                        (name:'i@';DictBR:'I@';DictAM:'I@'),
                                                                        (name:'i';DictBR:'I';DictAM:'I'),
                                                                        (name:'ii';DictBR:'i';DictAM:'i'),
                                                                        (name:'o';DictBR:'0';DictAM:'0'),
                                                                        (name:'ou';DictBR:'@U';DictAM:'oU'),
                                                                        (name:'oi';DictBR:'oI';DictAM:'oI'),
                                                                        (name:'u@';DictBR:'U@';DictAM:'u'),
                                                                        (name:'u';DictBR:'U';DictAM:'U'),
                                                                        (name:'uu';DictBR:'u';DictAM:'u'));

function SpeechConvertMRPAToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z','@':begin
    S:=LOCASE(C);
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z','@']) then begin
     inc(Counter);
     S:=S+LOCASE(Phonems[Counter]);
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechMRPAToAlveyArray) to high(SpeechMRPAToAlveyArray) do begin
      if SpeechMRPAToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechMRPAToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechMRPAToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

const SpeechSAMPAToAlveyArray:array[0..49] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                         (name:'b';DictBR:'b';DictAM:'b'),
                                                                         (name:'tS';DictBR:'tS';DictAM:'tS'),
                                                                         (name:'d';DictBR:'d';DictAM:'d'),
                                                                         (name:'D';DictBR:'D';DictAM:'D'),
                                                                         (name:'f';DictBR:'f';DictAM:'f'),
                                                                         (name:'g';DictBR:'g';DictAM:'g'),
                                                                         (name:'h';DictBR:'h';DictAM:'h'),
                                                                         (name:'dZ';DictBR:'dZ';DictAM:'dZ'),
                                                                         (name:'k';DictBR:'k';DictAM:'k'),
                                                                         (name:'l';DictBR:'l';DictAM:'l'),
                                                                         (name:'m';DictBR:'m';DictAM:'m'),
                                                                         (name:'n';DictBR:'n';DictAM:'n'),
                                                                         (name:'N';DictBR:'9';DictAM:'9'),
                                                                         (name:'p';DictBR:'p';DictAM:'p'),
                                                                         (name:'r';DictBR:'r';DictAM:'r'),
                                                                         (name:'s';DictBR:'s';DictAM:'s'),
                                                                         (name:'S';DictBR:'S';DictAM:'S'),
                                                                         (name:'4';DictBR:'t';DictAM:'t'),
                                                                         (name:'t';DictBR:'t';DictAM:'t'),
                                                                         (name:'T';DictBR:'T';DictAM:'T'),
//                                                                       (Name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                         (name:'v';DictBR:'v';DictAM:'v'),
                                                                         (name:'w';DictBR:'w';DictAM:'w'),
                                                                         (name:'j';DictBR:'j';DictAM:'j'),
                                                                         (name:'z';DictBR:'z';DictAM:'z'),
                                                                         (name:'Z';DictBR:'Z';DictAM:'Z'),
                                                                         (name:'@';DictBR:'@';DictAM:'@'),
                                                                         (name:'A:';DictBR:'A';DictAM:'A'),
                                                                         (name:'A';DictBR:'A';DictAM:'A'),
                                                                         (name:'{';DictBR:'&';DictAM:'&'),
                                                                         (name:'V';DictBR:'V';DictAM:'V'),
                                                                         (name:'O';DictBR:'O';DictAM:'O'),
                                                                         (name:'aU';DictBR:'aU';DictAM:'aU'),
                                                                         (name:'aI';DictBR:'aI';DictAM:'aI'),
                                                                         (name:'e@';DictBR:'e@';DictAM:'e@'),
                                                                         (name:'E';DictBR:'e';DictAM:'e'),
                                                                         (name:'3:';DictBR:'3';DictAM:'3R'),
                                                                         (name:'r=';DictBR:'3';DictAM:'3R'),
                                                                         (name:'eI';DictBR:'eI';DictAM:'eI'),
                                                                         (name:'EI';DictBR:'eI';DictAM:'eI'),
                                                                         (name:'I@';DictBR:'I@';DictAM:'I@'),
                                                                         (name:'I';DictBR:'I';DictAM:'I'),
                                                                         (name:'i:';DictBR:'i';DictAM:'i'),
                                                                         (name:'i';DictBR:'i';DictAM:'i'),
                                                                         (name:'Q';DictBR:'0';DictAM:'0'),
                                                                         (name:'@U';DictBR:'@U';DictAM:'oU'),
                                                                         (name:'OI';DictBR:'oI';DictAM:'oI'),
                                                                         (name:'U@';DictBR:'U@';DictAM:'u'),
                                                                         (name:'U';DictBR:'U';DictAM:'U'),
                                                                         (name:'u:';DictBR:'u';DictAM:'u'));

function SpeechConvertSAMPAToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z','3','4','@','{':begin
    S:=C;
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z',':','=','@']) then begin
     inc(Counter);
     S:=S+Phonems[Counter];
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechSAMPAToAlveyArray) to high(SpeechSAMPAToAlveyArray) do begin
      if SpeechSAMPAToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechSAMPAToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechSAMPAToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

const SpeechViruzIIToAlveyArray:array[0..47] of TSpeechConvertToAlveyItem=((name:'';DictBR:'';DictAM:''),
                                                                           (name:'b';DictBR:'b';DictAM:'b'),
                                                                           (name:'ch';DictBR:'tS';DictAM:'tS'),
                                                                           (name:'d';DictBR:'d';DictAM:'d'),
                                                                           (name:'dh';DictBR:'D';DictAM:'D'),
                                                                           (name:'f';DictBR:'f';DictAM:'f'),
                                                                           (name:'g';DictBR:'g';DictAM:'g'),
                                                                           (name:'h';DictBR:'h';DictAM:'h'),
                                                                           (name:'hh';DictBR:'h';DictAM:'h'),
                                                                           (name:'j';DictBR:'dZ';DictAM:'dZ'),
                                                                           (name:'jh';DictBR:'dZ';DictAM:'dZ'),
                                                                           (name:'k';DictBR:'k';DictAM:'k'),
                                                                           (name:'l';DictBR:'l';DictAM:'l'),
                                                                           (name:'m';DictBR:'m';DictAM:'m'),
                                                                           (name:'n';DictBR:'n';DictAM:'n'),
                                                                           (name:'ng';DictBR:'9';DictAM:'9'),
                                                                           (name:'p';DictBR:'p';DictAM:'p'),
                                                                           (name:'r';DictBR:'r';DictAM:'r'),
                                                                           (name:'s';DictBR:'s';DictAM:'s'),
                                                                           (name:'sh';DictBR:'S';DictAM:'S'),
                                                                           (name:'t';DictBR:'t';DictAM:'t'),
                                                                           (name:'th';DictBR:'T';DictAM:'T'),
                                                                           (name:'ts';DictBR:'ts';DictAM:'ts'),
                                                                           (name:'v';DictBR:'v';DictAM:'v'),
                                                                           (name:'w';DictBR:'w';DictAM:'w'),
                                                                           (name:'y';DictBR:'j';DictAM:'j'),
                                                                           (name:'z';DictBR:'z';DictAM:'z'),
                                                                           (name:'zh';DictBR:'Z';DictAM:'Z'),
                                                                           (name:'ax';DictBR:'@';DictAM:'@'),
                                                                           (name:'aa';DictBR:'A';DictAM:'A'),
                                                                           (name:'ae';DictBR:'&';DictAM:'&'),
                                                                           (name:'ah';DictBR:'V';DictAM:'V'),
                                                                           (name:'ao';DictBR:'O';DictAM:'O'),
                                                                           (name:'aw';DictBR:'aU';DictAM:'aU'),
                                                                           (name:'ay';DictBR:'aI';DictAM:'aI'),
                                                                           (name:'ea';DictBR:'e@';DictAM:'e@'),
                                                                           (name:'eh';DictBR:'e';DictAM:'e'),
                                                                           (name:'er';DictBR:'3';DictAM:'3R'),
                                                                           (name:'ey';DictBR:'eI';DictAM:'eI'),
                                                                           (name:'ia';DictBR:'I@';DictAM:'I@'),
                                                                           (name:'ih';DictBR:'I';DictAM:'I'),
                                                                           (name:'iy';DictBR:'i';DictAM:'i'),
                                                                           (name:'oh';DictBR:'0';DictAM:'0'),
                                                                           (name:'ow';DictBR:'@U';DictAM:'oU'),
                                                                           (name:'oy';DictBR:'oI';DictAM:'oI'),
                                                                           (name:'ua';DictBR:'U@';DictAM:'u'),
                                                                           (name:'uh';DictBR:'U';DictAM:'U'),
                                                                           (name:'uw';DictBR:'u';DictAM:'u'));

function SpeechConvertViruzIIToAlvey(Phonems:string;American:boolean;Divider:string=''):string;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found:integer;
begin
 result:='';
 Counter:=1;
 S:='';
 while Counter<=length(Phonems) do begin
  C:=Phonems[Counter];
  case C of
   'a'..'z','A'..'Z':begin
    S:=LOCASE(C);
    OldCounter:=Counter;
    if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z']) then begin
     inc(Counter);
     S:=S+LOCASE(Phonems[Counter]);
    end;
    Found:=-1;
    while (length(S)>0) and (Found<0) do begin
     for SubCounter:=low(SpeechViruzIIToAlveyArray) to high(SpeechViruzIIToAlveyArray) do begin
      if SpeechViruzIIToAlveyArray[SubCounter].name=S then begin
       Found:=SubCounter;
       break;
      end;
     end;
     S:=COPY(S,1,length(S)-1);
     if Found<0 then dec(Counter);
    end;
    if Found>=0 then begin
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) then begin
      result:=result+'#'+Phonems[Counter+1];
      inc(Counter);
      while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
       result:=result+Phonems[Counter+1];
       inc(Counter);
      end;
     end;
     if American then begin
      result:=result+SpeechViruzIIToAlveyArray[Found].DictAM+Divider;
     end else begin
      result:=result+SpeechViruzIIToAlveyArray[Found].DictBR+Divider;
     end;
    end else begin
     Counter:=OldCounter;
    end;
   end;
   '/':;
   else begin
    result:=result+C;
   end;
  end;
  inc(Counter);
 end;
end;

end.
