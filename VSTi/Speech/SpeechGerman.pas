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
unit SpeechGerman;

interface

uses SpeechRules;

const punct_rules:array[0..10] of TSpeechRule=
(
 (Anything,' ',Anything,' '),
 (Anything,'-',Anything,''),
 ('.','''S',Anything,'z'),
 ('#:.E','''S',Anything,'z'),
 ('#','''S',Anything,'z'),
 (Anything,'''',Anything,''),
 (Anything,',',Anything,' '),
 (Anything,'.',Anything,' '),
 (Anything,'?',Anything,' '),
 (Anything,'!',Anything,' '),
 (Anything,'',Anything,Silent)
);

const A_rules:array[0..13] of TSpeechRule=
(
 (Nothing,'ACH',Anything,'ae/ch'),
 (Nothing,'A',Nothing,'aa'),
 (Anything,'A',Nothing,'ah'),
 (Anything,'AU',Anything,'aw'),
 (Anything,'AE',Anything,'eh/eh'),
 (Anything,'AFF',Anything,'aa/f/f'),
 (Anything,'AF',Anything,'aa/f'),
 (Anything,'AR',Anything,'ah/ax'),
 (Nothing,'AB','B','ah/b'),
 (Nothing,'AN','N','ah/n'),
 (Anything,'A','$','ah'),
 (Anything,'A','H','ah/ah'),
 (Anything,'A',Anything,'aa'),
 (Anything,'',Anything,Silent)
);

const B_rules:array[0..2] of TSpeechRule=
(
 ('#','BB','#','b'),
 (Anything,'B',Anything,'b'),
 (Anything,'',Anything,Silent)
);

const C_rules:array[0..7] of TSpeechRule=
(
 (Nothing,'CH',Anything,'k'),
//(Anything,'CH',Anything,'ch/k'),
 ('#','CH',Anything,'ch'),
 (Anything,'CH',Anything,'k'),
 (Anything,'CI','EN','sh'),
 (Anything,'CK',Anything,'k'),
 (Anything,'COM','%','k/ah/m'),
 (Anything,'C',Anything,'k'),
 (Anything,'',Anything,Silent)
);

const D_rules:array[0..6] of TSpeechRule=
(
 ('#:','DED',Nothing,'d/ih/d'),
 ('.E','D',Nothing,'d'),
 ('#:^E','D',Nothing,'t'),
 ('#','DD','#','d'),
 ('#','DD',Nothing,'d'),
 (Anything,'D',Anything,'d'),
 (Anything,'',Anything,Silent)
);

const E_rules:array[0..15] of TSpeechRule=
(
 (Anything,'EAUX',Nothing,'ow'),
 (':','E',Nothing,'ax/ax'),
 (Anything,'ES',Anything,'eh/s'),
 (Anything,'ER',Nothing,'er'),
 (Anything,'ER','ER','er/v'),
 (Anything,'ER','#','er'),
 (Anything,'EW',Anything,'eh/v'),
 (Anything,'EI',Anything,'ay'),
 (Anything,'EU',Anything,'oy'),
 (Anything,'EH',Anything,'eh/eh/eh'),
 (Anything,'EE',Anything,'eh/eh/eh'),
 (Anything,'E','^^','eh'),
 (Anything,'E','$','eh'),
 (Anything,'EN',Nothing,'ax/n'),
 (Anything,'E',Anything,'eh/eh'),
 (Anything,'',Anything,Silent)
);

const F_rules:array[0..4] of TSpeechRule=
(
 ('F','F','F','f f'),
 ('#','FF','#','f'),
 ('#','FF',Nothing,'f'),
 (Anything,'F',Anything,'f'),
 (Anything,'',Anything,Silent)
);

const G_rules:array[0..5] of TSpeechRule=
(
 (Nothing,'GE','E','g/ax '),
 (Nothing,'GIN',Nothing,'jh/iy/n '),
 (Anything,'GREAT',Anything,'g/r/ey/t'),
 ('#','GG','#','g'),
 (Anything,'G',Anything,'g'),
 (Anything,'',Anything,Silent)
);

const H_rules:array[0..2] of TSpeechRule=
(
//(Nothing,'H',Nothing,'hh/ah'),
 (Anything,'H','#','hh'),
 (Anything,'H',Anything,Silent),
 (Anything,'',Anything,Silent)
);

const I_rules:array[0..9] of TSpeechRule=
(
 (Anything,'IE',Anything,'iy'),
 (Anything,'IER',Anything,'iy/er'),
 (Anything,'IQUE',Anything,'iy/k'),
 (Nothing,'ICH',Anything,'ih/ch'),
 (Anything,'ICH',Anything,'ih/k'),
 (Anything,'I','A','iy'),
 (Anything,'I','H','iy'),
 (Anything,'I','$','ih'),
 (Anything,'I',Anything,'iy'),
 (Anything,'',Anything,Silent)
);

const J_rules:array[0..2] of TSpeechRule=
(
 (Nothing,'JA',Nothing,'jh/aa/aa'),
 (Anything,'J',Anything,'jh'),
 (Anything,'',Anything,Silent)
);

const K_rules:array[0..2] of TSpeechRule=
(
 (Nothing,'K','N',Silent),
 (Anything,'K',Anything,'k'),
 (Anything,'',Anything,Silent)
);

const L_rules:array[0..3] of TSpeechRule=
(
 (Anything,'LL','#','l'),
 (Anything,'LL',Nothing,'l'),
 (Anything,'L',Anything,'l'),
 (Anything,'',Anything,Silent)
);

const M_rules:array[0..3] of TSpeechRule=
(
 ('#','MM','#','m'),
 ('#','MM',Nothing,'m'),
 (Anything,'M',Anything,'m'),
 (Anything,'',Anything,Silent)
);

const N_rules:array[0..3] of TSpeechRule=
(
 ('#','NN','#','n'),
 ('#','NN',Nothing,'n'),
 (Anything,'N',Anything,'n'),
 (Anything,'',Anything,Silent)
);

const O_rules:array[0..13] of TSpeechRule=
(
 (Nothing,'ONE',Nothing,'w/ah/n'),
 (Anything,'OE',Anything,'ax/ax'),
 (Nothing,'OVER',Anything,'ow/v/er'),
 (Nothing,'OK',Nothing,'ao/k/ey'),
 (Nothing,'OKAY',Nothing,'ao/k/ey'),
 (Anything,'OY',Anything,'oy'),
 (Anything,'OI',Anything,'oy'),
 ('C','O','N','oh'),
 (Anything,'O','$','oh'),
 (Anything,'O','ß','ao/ao'),
 (Anything,'O','H','ao/ao'),
 (Anything,'O','ß','ao/ao'),
 (Anything,'O',Anything,'oh'),
 (Anything,'',Anything,Silent)
);

const P_rules:array[0..7] of TSpeechRule=
(
 ('#','PP','#','p'),
 ('#','PP',Nothing,'p'),
 (Anything,'PH',Anything,'f'),
 (Anything,'PEOP',Anything,'p/iy/p'),
 (Anything,'POW',Anything,'p/aw'),
 (Anything,'PUT',Nothing,'p/uh/t'),
 (Anything,'P',Anything,'p'),
 (Anything,'',Anything,Silent)
);

const Q_rules:array[0..3] of TSpeechRule=
(
 (Anything,'QUAR',Anything,'k/w/ao/r'),
 (Anything,'QU',Anything,'k/w'),
 (Anything,'Q',Anything,'k'),
 (Anything,'',Anything,Silent)
);

const R_rules:array[0..4] of TSpeechRule=
(
 (Nothing,'RE','^#','r/eh'),
 ('#','RR','#','r'),
 ('#','RR',Nothing,'r'),
 (Anything,'R',Anything,'r'),
 (Anything,'',Anything,Silent)
);

const S_rules:array[0..12] of TSpeechRule=
(
 (Anything,'SH',Anything,'sh'),
 (Anything,'SO',Nothing,'s/oh'),
 ('#','SS','#','s'),
 ('#','SS',Nothing,'s'),
 ('.','S',Nothing,'z'),
 ('#:.E','S',Nothing,'z'),
 ('#:^##','S',Nothing,'z'),
 ('#:^#','S',Nothing,'s'),
 ('U','S',Nothing,'s'),
 (' :#','S',Nothing,'z'),
 (Anything,'SCH',Anything,'sh'),
 (Anything,'S',Anything,'s'),
 (Anything,'',Anything,Silent)
);

const T_rules:array[0..5] of TSpeechRule=
(
 ('#','TT','#','t'),
 ('#','TT',Nothing,'t'),
 (Nothing,'TWO',Anything,'t/uw'),
 (Anything,'TION',Anything,'ts/iy/oa/n'),
 (Anything,'T',Anything,'t'),
 (Anything,'',Anything,Silent)
);

const U_rules:array[0..7] of TSpeechRule=
(
 (Nothing,'UH',Nothing,'uw/uw'),
 (Nothing,'UN','N','uw/n'),
 ('P','U',Anything,'y/uw'),
 (Anything,'U','$','uh'),
 (Anything,'U','H','uw/uw'),
 (Anything,'UE',Anything,'ih'),
 (Anything,'U',Anything,'uw'),
 (Anything,'',Anything,Silent)
);

const V_rules:array[0..3] of TSpeechRule=
(
 (Anything,'VIEW',Anything,'v/y/uw'),
 (Nothing,'V',Anything,'f'),
 (Anything,'V',Anything,'v'),
 (Anything,'',Anything,Silent)
);

const W_rules:array[0..5] of TSpeechRule=
(
 (Anything,'WHERE',Anything,'wh/eh/r'),
 (Anything,'WHAT',Anything,'wh/oh/t'), // wh/aa/t
 (Anything,'WHO',Anything,'hh/uw'),
 (Anything,'W',Nothing,'f'),
 (Anything,'W',Anything,'w'),
 (Anything,'',Anything,Silent)
);

const X_rules:array[0..1] of TSpeechRule=
(
 (Anything,'X',Anything,'k/s'),
 (Anything,'',Anything,Silent)
);

const Y_rules:array[0..4] of TSpeechRule=
(
 (Anything,'YOUNG',Anything,'y/ah/ng'),
 (Nothing,'YES',Anything,'y/eh/s'),
 (Nothing,'Y',Anything,'ih'),
 (Anything,'Y',Anything,'ih'),
 (Anything,'',Anything,Silent)
);

const Z_rules:array[0..1] of TSpeechRule=
(
//(Nothing,'ZED',Nothing,'ts/eh/eh/d'),
 (Anything,'Z',Anything,'ts'),
 (Anything,'',Anything,Silent)
);

const Uml_rules:array[0..5] of TSpeechRule=
(
 (Anything,'ÄU',Anything,'oy'),
 (Anything,'ß',Anything,'s'),
 (Anything,'Ä',Anything,'eh/eh'),
 (Anything,'Ö',Anything,'ax/ax'),
 (Anything,'Ü',Anything,'ih'),
 (Anything,'',Anything,Silent)
);

const Rules:TSpeechRulesArray=
(
 @punct_rules,
 @A_rules,@B_rules,@C_rules,@D_rules,@E_rules,@F_rules,@G_rules,@H_rules,
 @I_rules,@J_rules,@K_rules,@L_rules,@M_rules,@N_rules,@O_rules,@P_rules,
 @Q_rules,@R_rules,@S_rules,@T_rules,@U_rules,@V_rules,@W_rules,@X_rules,
 @Y_rules,@Z_rules,@Uml_rules
);

const AsciiRules:TSpeechAsciiRules=('NULL','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    'BLENK','AUSRUFEZEICHEN','DOUBLE QUOTE','HASH',
                                    'DOLLAR','PROZENT','AMPERSAND','QUOTE',
                                    'KLAMMER AUF','KLAMMER ZU','MAL','PLUS',
                                    'KOMMA','MINUS','FULL STOP','SLASH',
                                    'NULL','EINS','ZWEI','DREI',
                                    'VIER','FÜNF','SECHS','SIEBEN',
                                    'ACHT','NEUN','DOPPELPUNKT','SEMI COLON',
                                    'KLEINER ALS','GLEICH','GRÖSSER ALS','FRAGEZEICHEN',
                                    'BACK QUOTE','A','BEE','ZEE',
                                    'DEE','EE','EFF','GE',
                                    'HA','I','JOTT','KA',
                                    'ELL','EM','EN','OO',
                                    'PEE','KUH','ERR','ES',
                                    'TEE','UH','VAU','WE',
                                    'IKS','YPSILON','ZED','ECKIGE KLAMMER AUF',
                                    'BACK SLASH','ECKIGE KLAMMER ZU','ZIRKUMFLEX','UNTERSTRICH',
                                    'BACK QUOTE','A','BEE','ZEE',
                                    'DEE','EE','EFF','GE',
                                    'HA','I','JOTT','KA',
                                    'ELL','EM','EN','OO',
                                    'PEE','KUH','ERR','ES',
                                    'TEE','UH','VAU','WE',
                                    'IKS','YPSILON','ZED','GESTREIFTE KLAMMER AUF',
                                    'SENKRECHTER STRICH','GESTREIFTE KLAMMER ZU','TILDE','LÖSCHEN');

function DoConvertCardinalInteger(Value:integer):string;
function DoConvertOrdinalInteger(Value:integer):string;
function DoConvertFloat(Value:extended):string;
function IsVowel(C:char):boolean;
function IsAlpha(C:char):boolean;
function IsUpper(C:char):boolean;
function IsConstant(C:char):boolean;
function IsSpace(C:char):boolean;
function UPCASE(C:char):char;

const SpeechGermanRules:TSpeechLanguageRules=(
       Rules:@Rules;
       AsciiRules:@AsciiRules;
       ConvertCardinalInteger:DoConvertCardinalInteger;
       ConvertOrdinalInteger:DoConvertOrdinalInteger;
       ConvertFloat:DoConvertFloat;
       IsVowel:IsVowel;
       IsAlpha:IsAlpha;
       IsUpper:IsUpper;
       IsConstant:IsConstant;
       IsSpace:IsSpace;
       UPCASE:UPCASE;
      );

implementation

uses Synth;

const SubNumber:array[0..9] of string=('','ZEHN','ZWAN','DREI','VIER','FÜNF','SECH','SIEB','ACH','NEUN');
      Number:array[0..9] of string=('','EIN','ZWEI','DREI','VIER','FÜNF','SECHS','SIEBEN','ACHT','NEUN');

function NinthAndOnes(N10,N1:byte):string;
var N:integer;
begin
 result:='';
 N:=(N10*10)+N1;
 if N10=0 then begin
  if N1<>0 then result:=result+' '+Number[n1];
  if N1=1 then result:=result+'S';
 end else begin
  if N10=1 then begin
   if N=11 then begin
    result:=result+' ELF';
   end else if N=12 then begin
    result:=result+' ZWÖLF';
   end else begin
    result:=result+' '+Number[N1]+'ZEHN';
   end;
  end else begin
   result:=result+' '+Number[N1];
   if N1>0 then result:=result+' UND';
   result:=result+SubNumber[N10];
   if N10<>3 then begin
    result:=result+'ZIG';
   end else begin
    result:=result+'ßIG';
   end;
  end;
 end;
end;

function DoConvertCardinalInteger(Value:integer):string;
var N100,N10,N1:integer;
    Negativ:boolean;
begin
 if Value=0 then begin
  result:=' NULL';
  exit;
 end;
 result:='';
 if Value<0 then begin
  Value:=-Value;
  Negativ:=true;
 end else begin
  Negativ:=false;
 end;
 if Value>=1000000000 then begin
  if Value=1000000000 then begin
   result:=' EINE MILLIARDE';
  end else begin
   result:=DoConvertCardinalInteger(Value div 1000000000)+' MILLIARDEN';
  end;
  Value:=Value mod 1000000000;
 end;
 if Value>=1000000 then begin
  if Value=1000000 then begin
   result:=' EINE MILLION';
  end else begin
   result:=DoConvertCardinalInteger(Value div 1000000)+' MILLIONEN';
  end;
  Value:=Value mod 1000000;
 end;
 if Value>=1000 then begin
  if Value=1000 then begin
   result:=' EIN TAUSEND';
  end else begin
   result:=DoConvertCardinalInteger(Value div 1000)+' TAUSEND';
  end;
  Value:=Value mod 1000;
 end;
 N100:=Value div 100;
 Value:=Value mod 100;
 N10:=Value div 10;
 N1:=Value mod 10;
 if N100<>0 then begin
  result:=result+Number[N100]+' HUNDERT';
 end;
 result:=result+NinthAndOnes(N10,N1);
 if Negativ then result:='MINUS '+result;
end;

function DoConvertOrdinalInteger(Value:integer):string;
 function Pass(Value,Level:integer):string;
 var N100,N10,N1:integer;
     Negativ:boolean;
  function PassNinthAndOnes(N10,N1:byte):string;
  const SubNumber:array[0..9] of string=('','ZEHN','ZWAN','DREI','VIER','FÜNF','SECH','SIEB','ACH','NEUN');
        Number:array[0..9] of string=('','ERS','ZWEI','DREI','VIER','FÜNF','SECHS','SIEBEN','ACHT','NEUN');
  var N:integer;
  begin
   result:='';
   N:=(N10*10)+N1;
   if N10=0 then begin
    if N1<>0 then result:=result+' '+Number[n1]+'TER';
   end else begin
    if N10=1 then begin
     if N=11 then begin
      result:=result+' ELFTER';
     end else if N=12 then begin
      result:=result+' ZWÖLFTER';
     end else begin
      result:=result+' '+Number[N1]+'ZEHNTER';
     end;
    end else begin
     result:=result+' '+Number[N1];
     if N1>0 then result:=result+' UND';
     result:=result+SubNumber[N10];
     if N10<>3 then begin
      result:=result+'ZIGSTER';
     end else begin
      result:=result+'ßIGSTER';
     end;
    end;
   end;
  end;
 begin
  if Value=0 then begin
   result:=' NULL';
   exit;
  end;
  result:='';
  if Value<0 then begin
   Value:=-Value;
   Negativ:=true;
  end else begin
   Negativ:=false;
  end;
  if Value>=1000000000 then begin
   if Value=1000000000 then begin
    if Level=0 then begin
     result:=' EINE MILLIARDESTE';
    end else begin
     result:=' EINE MILLIARDE';
    end;
   end else begin
    result:=Pass(Value div 1000000000,Level+1)+' MILLIARDEN';
   end;
   Value:=Value mod 1000000000;
  end;
  if Value>=1000000 then begin
   if Value=1000000 then begin
    if Level=0 then begin
     result:=' EINE MILLIONESTE';
    end else begin
     result:=' EINE MILLION';
    end;
   end else begin
    result:=Pass(Value div 1000000,Level+1)+' MILLIONEN';
   end;
   Value:=Value mod 1000000;
  end;
  if Value>=1000 then begin
   if Value=1000 then begin
    if Level=0 then begin
     result:=' EIN TAUSENDESTE';
    end else begin
     result:=' TAUSEND';
    end;
   end else begin
    result:=Pass(Value div 1000,Level+1)+' TAUSEND';
   end;
   Value:=Value mod 1000;
  end;
  N100:=Value div 100;
  Value:=Value mod 100;
  N10:=Value div 10;
  N1:=Value mod 10;
  if N100<>0 then begin
   if (N10=0) and (N1=0) then begin
    if Level=0 then begin
     result:=' EINE HUNDERTESTE';
    end else begin
     result:=' HUNDERTESTE';
    end;
   end else begin
    result:=result+Number[N100]+' HUNDERT';
   end;
  end;
  if Level=0 then begin
   result:=result+PassNinthAndOnes(N10,N1);
  end else begin
   result:=result+NinthAndOnes(N10,N1);
  end;
  if Negativ then result:='MINUS '+result;
 end;
begin
 result:=Pass(Value,0);
end;

function DoConvertFloat(Value:extended):string;
var I:integer;
    X:string;
begin
 result:=DoConvertCardinalInteger(TRUNC(Value));
 STR(Value:1:10,X);
 I:=POS('.',X);
 if I>0 then begin
  while X[length(X)]='0' do X:=COPY(X,1,length(X)-1);
  if X[length(X)]='.' then X:=COPY(X,1,length(X)-1);
  DELETE(X,1,I);
  if length(X)<>0 then begin
   result:=result+' PUNKT';
   for I:=1 to length(X) do begin
    result:=result+' '+DoConvertCardinalInteger(ord(X[I])-ord('0'));
   end;
  end;
 end;
end;

function IsVowel(C:char):boolean;
begin
 result:=C in ['A','E','I','O','U','Ä','Ö','Ü','Y'];
end;

function IsAlpha(C:char):boolean;
begin
 result:=C in ['A'..'Z','a'..'z','Ä','Ö','Ü','ä','ö','ü','ß'];
end;

function IsUpper(C:char):boolean;
begin
 result:=C in ['A'..'Z','Ä','Ö','Ü'];
end;

function IsConstant(C:char):boolean;
begin
 result:=C in (['A'..'Z','ß']-['A','E','I','O','U','Y','Ä','Ö','Ü']);
end;

function IsSpace(C:char):boolean;
begin
 result:=C in [#0..#32];
end;

function UPCASE(C:char):char;
begin
 case C of
  'a'..'z':result:=char(byte(C)-32);
  'ä':result:='Ä';
  'ö':result:='Ö';
  'ü':result:='Ü';
  else result:=C;
 end;
end;

end.
