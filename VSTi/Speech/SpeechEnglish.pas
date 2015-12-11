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
unit SpeechEnglish;

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

const A_rules:array[0..35] of TSpeechRule=
(
 (Anything,'A',Nothing,'ax'),
 (Nothing,'AND',Nothing,'ae/n/d'),
 (Nothing,'ARE',Nothing,'aa/r'),
 (Nothing,'AR','O','ax/r'),
 (Anything,'AR','#','eh/r'),
 ('^','AS','#','ey/s'),
 (Anything,'A','WA','ax'),
 (Anything,'AW',Anything,'ao'),
 (' :','ANY',Anything,'eh/n/iy'),
 (Anything,'A','^+#','ey'),
 ('#:','ALLY',Anything,'ax/l/iy'),
 (Nothing,'AL','#','ax/l'),
 (Anything,'AGAIN',Anything,'ax/g/eh/n'),
 ('#:','AG','E','ih/jh'),
 (Anything,'A','^+:#','ae'),
 (' :','A','^+ ','ey'),
 (Anything,'A','^%','ey'),
 (Nothing,'ARR',Anything,'ax/r'),
 (Anything,'ARR',Anything,'ae/r'),
 (' :','AR',Nothing,'aa/r'),
 (Anything,'AR',Nothing,'er'),
 (Anything,'AR',Anything,'aa/r'), // oh/r
 (Anything,'AIR',Anything,'eh/r'),
 (Anything,'AI',Anything,'ey'),
 (Anything,'AY',Anything,'ey'),
 (Anything,'AU',Anything,'ao'),
 ('#:','AL',Nothing,'ax/l'),
 ('#:','ALS',Nothing,'ax/l/z'),
 (Anything,'ALK',Anything,'ao/k'),
 (Anything,'AL','^','ao/l'),
 (' :','ABLE',Anything,'ey/b/ax/l'),
 (Anything,'ABLE',Anything,'ax/b/ax/l'),
 (Anything,'ANG','+','ey/n/jh'),
 (Anything,'A','^#','ey'),
 (Anything,'A',Anything,'ae'),
 (Anything,'',Anything,Silent)
);

const B_rules:array[0..6] of TSpeechRule=
(
 (Nothing,'BE','^#','b/ih'),
 (Anything,'BEING',Anything,'b/iy/ih/ng'),
 (Nothing,'BOTH',Nothing,'b/ow/th'),
 (Nothing,'BUS','#','b/ih/z'),
 (Anything,'BUIL',Anything,'b/ih/l'),
 (Anything,'B',Anything,'b'),
 (Anything,'',Anything,Silent)
);

const C_rules:array[0..11] of TSpeechRule=
(
 (Nothing,'CH','^','k'),
 ('^E','CH',Anything,'k'),
 (Anything,'CH',Anything,'ch'),
 (' S','CI','#','s/ay'),
 (Anything,'CI','A','sh'),
 (Anything,'CI','O','sg'),
 (Anything,'CI','EN','sh'),
 (Anything,'C','+','s'),
 (Anything,'CK',Anything,'k'),
 (Anything,'COM','%','k/ah/m'),
 (Anything,'C',Anything,'k'),
 (Anything,'',Anything,Silent)
);

const D_rules:array[0..10] of TSpeechRule=
(
 ('#:','DED',Nothing,'d/ih/d'),
 ('.E','D',Nothing,'d'),
 ('#:^E','D',Nothing,'t'),
 (Nothing,'DE','^#','d/ih'),
 (Nothing,'DO',Nothing,'d/uw'),
 (Nothing,'DOES',Anything,'d/ah/z'),
 (Nothing,'DOING',Anything,'d/uw/ih/ng'),
 (Nothing,'DOW',Anything,'d/aw'),
 (Anything,'DU','A','jh/uw'),
 (Anything,'D',Anything,'d'),
 (Anything,'',Anything,Silent)
);

const E_rules:array[0..53] of TSpeechRule=
(
 (Anything,'EAUX',Nothing,'ow'),
 ('#:','E',Nothing,Silent),
 (''':^','E',Nothing,Silent),
 (' :','E',Nothing,'iy'),
 ('#','ED',Nothing,'d'),
 ('#:','E','D',Silent),
 (Anything,'EV','ER','eh/v'),
 (Anything,'E','^%','iy'),
 (Anything,'ERI','#','iy/r/iy'),
 (Anything,'ERI',Anything,'eh/r/ih'),
 ('#:','ER','#','er'),
 (Anything,'ER','#','eh/r'),
 (Anything,'ER',Anything,'er'),
 (Nothing,'EVEN',Anything,'iy/v/eh/n'),
 ('#:','E','W',Silent),
 ('T','EW',Anything,'uw'),
 ('S','EW',Anything,'uw'),
 ('R','EW',Anything,'uw'),
 ('D','EW',Anything,'uw'),
 ('L','EW',Anything,'uw'),
 ('Z','EW',Anything,'uw'),
 ('N','EW',Anything,'uw'),
 ('J','EW',Anything,'uw'),
 ('TH','EW',Anything,'uw'),
 ('CH','EW',Anything,'uw'),
 ('SH','EW',Anything,'uw'),
 (Anything,'EW',Anything,'y/uw'),
 (Anything,'E','O','iy'),
 ('#:S','ES',Nothing,'ih/z'),
 ('#:C','ES',Nothing,'ih/z'),
 ('#:G','ES',Nothing,'ih/z'),
 ('#:Z','ES',Nothing,'ih/z'),
 ('#:X','ES',Nothing,'ih/z'),
 ('#:J','ES',Nothing,'ih/z'),
 ('#:CH','ES',Nothing,'ih/z'),
 ('#:SH','ES',Nothing,'ih/z'),
 ('#:','E','S',Silent),
 ('#:','ELY',Nothing,'l/iy'),
 ('#:','EMENT',Anything,'m/eh/n/t'),
 (Anything,'EFUL',Anything,'f/uh/l'),
 (Anything,'EE',Anything,'iy'),
 (Anything,'EARN',Anything,'er/n'),
 (Nothing,'EAR','^','er'),
 (Anything,'EAD',Anything,'eh/d'),
 ('#:','EA',Nothing,'iy/ax'),
 (Anything,'EA','SU','eh'),
 (Anything,'EA',Anything,'iy'),
 (Anything,'EIGH',Anything,'ey'),
 (Anything,'EI',Anything,'iy'),
 (Nothing,'EYE',Anything,'ay'),
 (Anything,'EY',Anything,'iy'),
 (Anything,'EU',Anything,'y/uw'),
 (Anything,'E',Anything,'eh'),
 (Anything,'',Anything,Silent)
);

const F_rules:array[0..2] of TSpeechRule=
(
 (Anything,'FUL',Anything,'f/uh/l'),
 (Anything,'F',Anything,'f'),
 (Anything,'',Anything,Silent)
);

const G_rules:array[0..10] of TSpeechRule=
(
 (Anything,'GIV',Anything,'g/ih/v'),
 (Nothing,'G','I^','g'),
 (Anything,'GE','T','g/eh'),
 ('SU','GGES',Anything,'g/jh/eh/s'),
 (Anything,'GG',Anything,'g'),
 (' B#','G',Anything,'g'),
 (Anything,'G','+','jh'),
 (Anything,'GREAT',Anything,'g/r/ey/t'),
 ('#','GH',Anything,Silent),
 (Anything,'G',Anything,'g'),
 (Anything,'',Anything,Silent)
);

const H_rules:array[0..6] of TSpeechRule=
(
 (Nothing,'HAV',Anything,'hh/ae/v'),
 (Nothing,'HERE',Anything,'hh/iy/r'),
 (Nothing,'HOUR',Anything,'aw/er'),
 (Anything,'HOW',Anything,'hh/aw'),
 (Anything,'H','#','hh'),
 (Anything,'H',Anything,Silent),
 (Anything,'',Anything,Silent)
);

const I_rules:array[0..36] of TSpeechRule=
(
 (Nothing,'IAIN',Nothing,'ih/ax/n'),
 (Nothing,'ING',Nothing,'ih/ng'),
 (Nothing,'IN',Anything,'ih/n'),
 (Nothing,'I',Nothing,'ay'),
 (Nothing,'I''M',Nothing,'ay/m'),
 (Nothing,'I''LL',Nothing,'ay/l'),
 (Nothing,'I''D',Nothing,'ay/d'),
 (Nothing,'I''S',Nothing,'ay/s'),
 (Nothing,'I''VE',Nothing,'ay/v'),
 (Anything,'IN','D','ay/n'),
 (Anything,'IER',Anything,'iy/er'),
 ('#:R','IED',Anything,'iy/d'),
 (Anything,'IED',Nothing,'ay/d'),
 (Anything,'IEN',Anything,'iy/eh/n'),
 (Anything,'IE','T','ay/eh'),
 (' :','I','%','ay'),
 (Anything,'I','%','iy'),
 (Anything,'IE',Anything,'iy'),
 (Anything,'I','^+:#','ih'),
 (Anything,'IR','#','ay/r'),
 (Anything,'IZ','%','ay/z'),
 (Anything,'IS','%','ay/z'),
 (Anything,'I','D%','ay'),
 ('+^','I','^+','ih'),
 (Anything,'I','T%','ay'),
 ('#:^','I','^+','ih'),
 (Anything,'I','^+','ay'),
 (Anything,'IR',Anything,'er'),
 (Anything,'IGH',Anything,'ay'),
 (Anything,'ILD',Anything,'ay/l/d'),
 (Anything,'IGN',Nothing,'ay/n'),
 (Anything,'IGN','^','ay/n'),
 (Anything,'IGN','%','ay/n'),
 (Anything,'IQUE',Anything,'iy/k'),
 ('^','I','^#','ay'),
 (Anything,'I',Anything,'ih'),
 (Anything,'',Anything,Silent)
);

const J_rules:array[0..1] of TSpeechRule=
(
 (Anything,'J',Anything,'jh'),
 (Anything,'',Anything,Silent)
);

const K_rules:array[0..2] of TSpeechRule=
(
 (Nothing,'K','N',Silent),
 (Anything,'K',Anything,'k'),
 (Anything,'',Anything,Silent)
);

const L_rules:array[0..5] of TSpeechRule=
(
 (Anything,'LO','C#','l/ow'),
 ('L','L',Anything,Silent),
 ('#:^','L','%','ax/l'),
 (Anything,'LEAD',Anything,'l/iy/d'),
 (Anything,'L',Anything,'l'),
 (Anything,'',Anything,Silent)
);

const M_rules:array[0..3] of TSpeechRule=
(
 (Anything,'MOV',Anything,'m/uw/v'),
 ('#','MM','#','m'),
 (Anything,'M',Anything,'m'),
 (Anything,'',Anything,Silent)
);

const N_rules:array[0..9] of TSpeechRule=
(
 ('E','NG','+','n/jh'),
 (Anything,'NG','R','ng/g'),
 (Anything,'NG','#','ng/g'),
 (Anything,'NGL','%','ng/g/ax/l'),
 (Anything,'NG',Anything,'ng'),
 (Anything,'NK',Anything,'ng/k'),
 (Nothing,'NOW',Nothing,'n/aw'),
 ('#','NG',Nothing,'NGg'),
 (Anything,'N',Anything,'n'),
 (Anything,'',Anything,Silent)
);

const O_rules:array[0..48] of TSpeechRule=
(
 (Anything,'OF',Nothing,'ax/v'),
 (Anything,'OROUGH',Anything,'er/ow'),
 ('#:','OR',Nothing,'er'),
 ('#:','ORS',Nothing,'er/z'),
 (Anything,'OR',Anything,'ao/r'),
 (Nothing,'ONE',Anything,'w/ah/n'),
 (Anything,'OW',Anything,'ow'),
 (Nothing,'OVER',Anything,'ow/v/er'),
 (Anything,'OV',Anything,'ah/v'),
 (Anything,'O','^%','ow'),
 (Anything,'O','^EN','ow'),
 (Anything,'O','^I#','ow'),
 (Anything,'OL','D','ow/l'),
 (Anything,'OUGHT',Anything,'ao/t'),
 (Anything,'OUGH',Anything,'ah/f'),
 (Nothing,'OU',Anything,'aw'),
 ('H','OU','S#','aw'),
 (Anything,'OUS',Anything,'ax/s'),
 (Anything,'OUR',Anything,'ao/r'),
 (Anything,'OULD',Anything,'uh/d'),
 ('^','OU','^L','ah'),
 (Anything,'OUP',Anything,'uw/p'),
 (Anything,'OU',Anything,'aw'),
 (Anything,'OY',Anything,'oy'),
 (Anything,'OING',Anything,'ow/ih/ng'),
 (Anything,'OI',Anything,'oy'),
 (Anything,'OOR',Anything,'ao/r'),
 (Anything,'OOK',Anything,'uh/k'),
 (Anything,'OOD',Anything,'uh/d'),
 (Anything,'OO',Anything,'uw'),
 (Anything,'O','E','ow'),
 (Anything,'O',Nothing,'ow'),
 (Anything,'OA',Anything,'ow'),
 (Nothing,'ONLY',Anything,'ow/n/l/iy'),
 (Nothing,'ONCE',Anything,'w/ah/n/s'),
 (Anything,'ON''T',Anything,'ow/n/t'),
 ('C','O','N','oh'),
 (Anything,'O','NG','ao'),
 (' :^','O','N','ah'),
 ('I','ON',Anything,'ax/n'),
 ('#:','ON',Nothing,'ax/n'),
 ('#^','ON',Anything,'ax/n'),
 (Anything,'O','ST ','ow'),
 (Anything,'OF','^','ao/f'),
 (Anything,'OTHER',Anything,'ah/dh/er'),
 (Anything,'OSS',Nothing,'ao/s'),
 ('#:^','OM',Anything,'ah/m'),
 (Anything,'O',Anything,'oh'),
 (Anything,'',Anything,Silent)
);

const P_rules:array[0..5] of TSpeechRule=
(
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

const R_rules:array[0..2] of TSpeechRule=
(
 (Nothing,'RE','^#','r/iy'),
 (Anything,'R',Anything,'r'),
 (Anything,'',Anything,Silent)
);

const S_rules:array[0..23] of TSpeechRule=
(
 (Anything,'SH',Anything,'sh'),
 ('#','SION',Anything,'zh/ax/n'),
 (Anything,'SOME',Anything,'s/ah/m'),
 ('#','SUR','#','zh/er'),
 (Anything,'SUR','#','sh/er'),
 ('#','SU','#','zh/uw'),
 ('#','SSU','#','sh/uw'),
 ('#','SED',Nothing,'z/d'),
 ('#','S','#','z'),
 (Anything,'SAID',Anything,'s/eh/d'),
 ('^','SION',Anything,'sh/ax/n'),
 (Anything,'S','S',Silent),
 ('.','S',Nothing,'z'),
 ('#:.E','S',Nothing,'z'),
 ('#:^##','S',Nothing,'z'),
 ('#:^#','S',Nothing,'s'),
 ('U','S',Nothing,'s'),
 (' :#','S',Nothing,'z'),
 (Nothing,'SCH',Anything,'s/k'),
 (Anything,'S','C+',Silent),
 ('#','SM',Anything,'z/m'),
 ('#','SN','''','z/ax/n'),
 (Anything,'S',Anything,'s'),
 (Anything,'',Anything,Silent)
);

const T_rules:array[0..26] of TSpeechRule=
(
 (Nothing,'THE',Nothing,'dh/ax'),
 (Anything,'TO',Nothing,'t/uw'),
 (Anything,'THAT',Nothing,'dh/ae/t'),
 (Nothing,'THIS',Nothing,'dh/ih/s'),
 (Nothing,'THEY',Anything,'dh/ey'),
 (Nothing,'THERE',Anything,'dh/eh/r'),
 (Anything,'THER',Anything,'dh/er'),
 (Anything,'THEIR',Anything,'dh/eh/r'),
 (Nothing,'THAN',Nothing,'dh/ae/n'),
 (Nothing,'THEM',Nothing,'dh/eh/m'),
 (Anything,'THESE',Nothing,'dh/iy/z'),
 (Nothing,'THEN',Anything,'dh/eh/n'),
 (Anything,'THROUGH',Anything,'th/r/uw'),
 (Anything,'THOSE',Anything,'dh/ow/z'),
 (Anything,'THOUGH',Nothing,'dh/ow'),
 (Nothing,'THUS',Anything,'dh/ah/s'),
 (Anything,'TH',Anything,'th'),
 ('#:','TED',Nothing,'t/ih/d'),
 ('S','TI','#N','ch'),
 (Anything,'TI','O','sh'),
 (Anything,'TI','A','sh'),
 (Anything,'TIEN',Anything,'sh/ax/n'),
 (Anything,'TUR','#','ch/er'),
 (Anything,'TU','A','ch/uw'),
 (Nothing,'TWO',Anything,'t/uw'),
 (Anything,'T',Anything,'t'),
 (Anything,'',Anything,Silent)
);

const U_rules:array[0..35] of TSpeechRule=
(
 (Nothing,'UN','I','y/uw/n'),
 (Nothing,'UN',Anything,'ah/n'),
 (Nothing,'UPON',Anything,'ax/p/ao/n'),
 ('T','UR','#','uh/r'),
 ('S','UR','#','uh/r'),
 ('R','UR','#','uh/r'),
 ('D','UR','#','uh/r'),
 ('L','UR','#','uh/r'),
 ('Z','UR','#','uh/r'),
 ('N','UR','#','uh/r'),
 ('J','UR','#','uh/r'),
 ('TH','UR','#','uh/r'),
 ('CH','UR','#','uh/r'),
 ('SH','UR','#','uh/r'),
 (Anything,'UR','#','y/uh/r'),
 (Anything,'UR',Anything,'er'),
 (Anything,'U','^ ','ah'),
 (Anything,'U','^^','ah'),
 (Anything,'UY',Anything,'ay'),
 (' G','U','#',Silent),
 ('G','U','%',Silent),
 ('G','U','#','w'),
 ('#N','U',Anything,'y/uw'),
 ('T','U',Anything,'uw'),
 ('S','U',Anything,'uw'),
 ('R','U',Anything,'uw'),
 ('D','U',Anything,'uw'),
 ('L','U',Anything,'uw'),
 ('Z','U',Anything,'uw'),
 ('N','U',Anything,'uw'),
 ('J','U',Anything,'uw'),
 ('TH','U',Anything,'uw'),
 ('CH','U',Anything,'uw'),
 ('SH','U',Anything,'uw'),
 (Anything,'U',Anything,'y/uw'),
 (Anything,'',Anything,Silent)
);

const V_rules:array[0..2] of TSpeechRule=
(
 (Anything,'VIEW',Anything,'v/y/uw'),
 (Anything,'V',Anything,'v'),
 (Anything,'',Anything,Silent)
);

const W_rules:array[0..12] of TSpeechRule=
(                                           
 (Nothing,'WERE',Anything,'w/er'),
 (Anything,'WA','S','w/oh'), // w/aa
 (Anything,'WA','T','w/oh'), // w/aa
 (Anything,'WHERE',Anything,'wh/eh/r'),
 (Anything,'WHAT',Anything,'wh/oh/t'), // wh/aa/t
 (Anything,'WHOL',Anything,'hg/ow/l'),
 (Anything,'WHO',Anything,'hh/uw'),
 (Anything,'WH',Anything,'wh'),
 (Anything,'WAR',Anything,'w/ao/r'),
 (Anything,'WOR','^','w/er'),
 (Anything,'WR',Anything,'r'),
 (Anything,'W',Anything,'w'),
 (Anything,'',Anything,Silent)
);

const X_rules:array[0..1] of TSpeechRule=
(
 (Anything,'X',Anything,'k/s'),
 (Anything,'',Anything,Silent)
);

const Y_rules:array[0..11] of TSpeechRule=
(
 (Anything,'YOUNG',Anything,'y/ah/ng'),
 (Nothing,'YOU',Anything,'y/uw'),
 (Nothing,'YES',Anything,'y/eh/s'),
 (Nothing,'Y',Anything,'y'),
 ('#:^','Y',Nothing,'iy'),
 ('#:^','Y','I','iy'),
 (' :','Y',Nothing,'ay'),
 (' :','Y','#','ay'),
 (' :','Y','^+:#','ih'),
 (' :','Y','^#','ay'),
 (Anything,'Y',Anything,'ih'),
 (Anything,'',Anything,Silent)
);

const Z_rules:array[0..1] of TSpeechRule=
(
 (Anything,'Z',Anything,'z'),
 (Anything,'',Anything,Silent)
);

const Rules:TSpeechRulesArray=
(
 @punct_rules,
 @A_rules,@B_rules,@C_rules,@D_rules,@E_rules,@F_rules,@G_rules,@H_rules,
 @I_rules,@J_rules,@K_rules,@L_rules,@M_rules,@N_rules,@O_rules,@P_rules,
 @Q_rules,@R_rules,@S_rules,@T_rules,@U_rules,@V_rules,@W_rules,@X_rules,
 @Y_rules,@Z_rules,nil
);

const AsciiRules:TSpeechAsciiRules=('NULL','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    '','','','',
                                    'SPACE','EXCLAMATION MARK','DOUBLE QUOTE','HASH',
                                    'DOLLAR','PERCENT','AMPERSAND','QUOTE',
                                    'OPEN PARENTHESIS','CLOSE PARENTHESIS','ASTERISK','PLUS',
                                    'COMMA','MINUS','FULL STOP','SLASH',
                                    'ZERO','ONE','TWO','THREE',
                                    'FOUR','FIVE','SIX','SEVEN',
                                    'EIGHT','NINE','COLON','SEMI COLON',
                                    'LESS THAN','EQUALS','GREATER THAN','QUESTION MARK',
                                    'AT','AY','BEE','SEE',
                                    'DEE','E','EFF','GEE',
                                    'AYCH','I','JAY','KAY',
                                    'ELL','EM','EN','OHE',
                                    'PEE','KJU','ARE','ES',
                                    'TEE','YOU','VEE','DOUBLE YOU',
                                    'EKS','WHY','ZED','OPEN BRACKET',
                                    'BACK SLASH','CLOSE BRACKET','CIRCUMFLEX','UNDERSCORE',
                                    'BACK QUOTE','AY','BEE','SEE',
                                    'DEE','E','EFF','GEE',
                                    'AYCH','I','JAY','KAY',
                                    'ELL','EM','EN','OHE',
                                    'PEE','KJU','ARE','ES',
                                    'TEE','YOU','VEE','DOUBLE YOU',
                                    'EKS','WHY','ZED','OPEN BRACE',
                                    'VERTICAL BAR','CLOSE BRACE','TILDE','DELETE');

function DoConvertCardinalInteger(Value:integer):string;
function DoConvertOrdinalInteger(Value:integer):string;
function DoConvertFloat(Value:extended):string;
function IsVowel(C:char):boolean;
function IsAlpha(C:char):boolean;
function IsUpper(C:char):boolean;
function IsConstant(C:char):boolean;
function IsSpace(C:char):boolean;
function UPCASE(C:char):char;

const SpeechEnglishRules:TSpeechLanguageRules=(
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

const Cardinals:array[0..19] of string=
(
 'ZERO','ONE','TWO','THREE',
 'FOUR','FIVE','SIX','SEVEN',
 'EIGHT','NINE',
 'TEN','ELEVEN','TWELVE','THIRTEEN',
 'FOURTEEN','FIFTEEN','SIXTEEN','SEVENTEEN',
 'EIGHTEEN','NINETEEN'
);

const CardinalsTwenties:array[0..7] of string=
(
 'TWENZY','THIRTY','FORTY','FIFTY',
 'SIXTY','SEVENTY','EIGHTY','NINETY'
);

const Ordinals:array[0..19] of string=
(
 'ZEROTH','FIRST','SECOND','THIRD',
 'FOURTH','FIFTH','SIXTH','SEVENTH',
 'EIGHTH','NINTH',
 'TEHTH','ELEVENTH','TWELFTH','THIRTEENTH',
 'FOURTEENTH','FIFTEENTH','SIXTEENTH','SEVENTEENTH',
 'EIGHTEENTH','NINETEENTH'
);

const OrdinalsTwenties:array[0..7] of string=
(
 'TWENTIETH','THIRTIETH','FORTIETH','FIFTIETH',
 'SIXTIETH','SEVENTIETH','EIGHTIETH','NINETIETH'
);

function DoConvertCardinalInteger(Value:integer):string;
begin
 if Value<0 then begin
  Value:=-Value;
  if Value<0 then begin
   result:='a lot';
   exit;
  end else begin
   result:='minus ';
  end;
 end else begin
  result:='';
 end;
 if Value>=1000000000 then begin
  result:=result+DoConvertCardinalInteger(Value div 1000000000)+' BILLION';
  Value:=Value mod 1000000000;
  if Value=0 then exit;
  result:=result+' ';
  if Value<100 then result:=result+'AND ';
 end;
 if Value>=1000000 then begin
  result:=result+DoConvertCardinalInteger(Value div 1000000)+' MILLION';
  Value:=Value mod 1000000;
  if Value=0 then exit;
  result:=result+' ';
  if Value<100 then result:=result+'AND ';
 end;
 if ((Value>=1000) and (Value<=1099)) or (Value>=2000) then begin
  result:=result+DoConvertCardinalInteger(Value div 1000)+' THOUSAND';
  Value:=Value mod 1000;
  if Value=0 then exit;
  result:=result+' ';
  if Value<100 then result:=result+'AND ';
 end;
 if Value>=100 then begin
  result:=result+Cardinals[(Value div 100) mod 20]+' HUNDRED';
  Value:=Value mod 100;
  result:=result+' ';
  if Value=0 then exit;
 end;
 if Value>=20 then begin
  result:=result+CardinalsTwenties[((Value-20) div 10) mod 10];
  Value:=Value mod 10;
  if Value=0 then exit;
  result:=result+' ';
 end;
 result:=result+Cardinals[Value mod 20];
end;

function DoConvertOrdinalInteger(Value:integer):string;
begin
 if Value<0 then begin
  Value:=-Value;
  if Value<0 then begin
   result:='a lot';
   exit;
  end else begin
   result:='minus ';
  end;
 end else begin
  result:='';
 end;
 if Value>=1000000000 then begin
  result:=result+DoConvertCardinalInteger(Value div 1000000000)+' ';
  if (Value mod 1000000000)=0 then begin
   result:=result+'BILLIONTH';
   exit;
  end else begin
   result:=result+'BILLION ';
   Value:=Value mod 1000000000;
   if Value<100 then result:=result+'AND ';
  end;
 end;
 if Value>=1000000 then begin
  result:=result+DoConvertCardinalInteger(Value div 1000000)+' ';
  if (Value mod 1000000)=0 then begin
   result:=result+'MILLIONTH';
   exit;
  end else begin
   result:=result+'MILLION ';
   Value:=Value mod 1000000;
   if Value<100 then result:=result+'AND ';
  end;
 end;
 if ((Value>=1000) and (Value<=1099)) or (Value>=2000) then begin
  result:=result+DoConvertCardinalInteger(Value div 1000)+' ';
  if (Value mod 1000)=0 then begin
   result:=result+'THOUSANDTH';
   exit;
  end else begin
   result:=result+'THOUSAND ';
   Value:=Value mod 1000;
   if Value<100 then result:=result+'AND ';
  end;
 end;
 if Value>=100 then begin
  result:=result+Cardinals[(Value div 100) mod 20]+' ';
  if (Value mod 100)=0 then begin
   result:=result+'HUNDREDTH';
   exit;
  end else begin
   result:=result+'HUNDRED ';
   Value:=Value mod 100;
  end;
 end;
 if Value>=20 then begin
  if (Value mod 10)=0 then begin
   result:=result+OrdinalsTwenties[((Value-20) div 10) mod 10];
   exit;
  end else begin
   result:=result+CardinalsTwenties[((Value-20) div 10) mod 10]+' ';
   Value:=Value mod 10;
  end;
 end;
 result:=result+Ordinals[Value mod 20];
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
   result:=result+' POINT';
   for I:=1 to length(X) do begin
    result:=result+' '+DoConvertCardinalInteger(ord(X[I])-ord('0'));
   end;
  end;
 end;
end;

function IsVowel(C:char):boolean;
begin
 result:=C in ['A','E','I','O','U'];
end;

function IsAlpha(C:char):boolean;
begin
 result:=C in ['A'..'Z','a'..'z'];
end;

function IsUpper(C:char):boolean;
begin
 result:=C in ['A'..'Z'];
end;

function IsConstant(C:char):boolean;
begin
 result:=C in (['A'..'Z']-['A','E','I','O','U']);
end;

function IsSpace(C:char):boolean;
begin
 result:=C in [#0..#32];
end;

function UPCASE(C:char):char;
begin
 case C of
  'a'..'z':result:=char(byte(C)-32);
  else result:=C;
 end;
end;

end.
