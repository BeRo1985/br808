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
unit SpeechRules;

interface

uses Synth;

const Anything='';
      Nothing=' ';
      Silent='';

      LEFT_PART=0;
      MATCH_PART=1;
      RIGHT_PART=2;
      OUT_PART=3;
      LIP_PART=4;

type PSpeechRule=^TSpeechRule;
     TSpeechRule=array[0..3] of string;

     PSpeechRules=^TSpeechRules;
     TSpeechRules=array[0..100] of TSpeechRule;

     PSpeechRulesArray=^TSpeechRulesArray;
     TSpeechRulesArray=array[0..27] of PSpeechRules;

     PSpeechAsciiRules=^TSpeechAsciiRules;
     TSpeechAsciiRules=array[0..127] of string;

     TSpeechRulesConvertInteger=function(Value:integer):string;
     TSpeechRulesConvertFloat=function(Value:extended):string;
     TSpeechRulesIsCharXYZ=function(C:char):boolean;
     TSpeechRulesUpcaseChar=function(C:char):char;

     PSpeechLanguageRules=^TSpeechLanguageRules;
     TSpeechLanguageRules=record
      Rules:pSpeechRulesArray;
      AsciiRules:PSpeechAsciiRules;
      ConvertCardinalInteger:TSpeechRulesConvertInteger;
      ConvertOrdinalInteger:TSpeechRulesConvertInteger;
      ConvertFloat:TSpeechRulesConvertFloat;
      IsVowel:TSpeechRulesIsCharXYZ;
      IsAlpha:TSpeechRulesIsCharXYZ;
      IsUpper:TSpeechRulesIsCharXYZ;
      IsConstant:TSpeechRulesIsCharXYZ;
      IsSpace:TSpeechRulesIsCharXYZ;
      UPCASE:TSpeechRulesUpcaseChar;
     end;

function SpeechConvertTextToPhonems(AString:string):string;
function SpeechConvertPhonemsToSegmentList(var SegmentList:TSynthSpeechSegmentList;Phonems:string):boolean;

implementation

uses SpeechTools,Functions,BeRoUtils,SpeechEnglish,SpeechGerman;

function ConvertStringToText(AString:string):string;
var I,J,K,V,Code:integer;
    C:char;
    Number,word,CommandLine,Command,CommandParameter:string;
    WasMinus:boolean;
    LanguageRules:PSpeechLanguageRules;
begin
 result:='';
 LanguageRules:=@SpeechEnglishRules;
 I:=1;
 WasMinus:=false;
 while I<=length(AString) do begin
  C:=AString[I];
  inc(I);
  case C of
   'a'..'z','A'..'Z':begin
    if WasMinus then begin
     result:=result+'-';
     WasMinus:=false;
    end;
    word:=LanguageRules^.UPCASE(C);
    while (I<=length(AString)) and (AString[I] in ['a'..'z','A'..'Z']) do begin
     C:=AString[I];
     inc(I);
     word:=word+LanguageRules^.UPCASE(C);
    end;
    if word='ROSSEAUX' then begin
     word:='ROSSO';
    end else if word='DR' then begin
     word:='DOCTOR';
    end else if word='MR' then begin
     word:='MISTER';
    end else if word='MS' then begin
     word:='MISS';
    end else if word='MRS' then begin
     word:='MISSUS';
    end else if word='OK' then begin
     word:='OKAY';
    end;
    result:=result+word;
   end;
   '$':begin
    if WasMinus then begin
     result:=result+'-';
     WasMinus:=false;
    end;
    if (I<=length(AString)) and (AString[I] in ['0'..'9','-']) then begin
     Number:='';
     while (I<=length(AString)) and (AString[I] in ['0'..'9','-']) do begin
      C:=AString[I];
      inc(I);
      Number:=Number+C;
     end;
     VAL(Number,V,Code);
     if (I<=length(AString)) and (AString[I] in ['.',',']) then begin
      if V<>0 then begin
       result:=result+LanguageRules^.ConvertCardinalInteger(V)+' ';
       result:=result+'DOLLAR ';
{      IF V=1 THEN BEGIN
        RESULT:=RESULT+'DOLLAR ';
       END ELSE BEGIN
        RESULT:=RESULT+'DOLLARS ';
       END;}
       result:=result+'AND ';
      end;
      inc(I);
      Number:='';
      while (I<=length(AString)) and (AString[I] in ['0'..'9','-']) do begin
       C:=AString[I];
       inc(I);
       Number:=Number+C;
      end;
      VAL(Number,V,Code);
      result:=result+LanguageRules^.ConvertCardinalInteger(V)+' ';
      result:=result+'CENT ';
{     IF V=1 THEN BEGIN
       RESULT:=RESULT+'CENT ';
      END ELSE BEGIN
       RESULT:=RESULT+'CENTS ';
      END;}
     end else begin
      result:=result+LanguageRules^.ConvertCardinalInteger(V)+' ';
      result:=result+'DOLLAR ';
{     IF V=1 THEN BEGIN
       RESULT:=RESULT+'DOLLAR ';
      END ELSE BEGIN
       RESULT:=RESULT+'DOLLARS ';
      END;}
     end;
    end else begin
     result:=result+C;
    end;
   end;
   '€':begin
    if WasMinus then begin
     result:=result+'-';
     WasMinus:=false;
    end;
    if (I<=length(AString)) and (AString[I] in ['0'..'9','-']) then begin
     Number:='';
     while (I<=length(AString)) and (AString[I] in ['0'..'9','-']) do begin
      C:=AString[I];
      inc(I);
      Number:=Number+C;
     end;
     VAL(Number,V,Code);
     if (I<=length(AString)) and (AString[I] in ['.',',']) then begin
      if V<>0 then begin
       result:=result+LanguageRules^.ConvertCardinalInteger(V)+' ';
       result:=result+'EURO ';
{      IF V=1 THEN BEGIN
        RESULT:=RESULT+'EURO ';
       END ELSE BEGIN
        RESULT:=RESULT+'EUROS ';
       END;}
       result:=result+'AND ';
      end;
      inc(I);
      Number:='';
      while (I<=length(AString)) and (AString[I] in ['0'..'9','-']) do begin
       C:=AString[I];
       inc(I);
       Number:=Number+C;
      end;
      VAL(Number,V,Code);
      result:=result+LanguageRules^.ConvertCardinalInteger(V)+' ';
      result:=result+'CENT ';
{     IF V=1 THEN BEGIN
       RESULT:=RESULT+'CENT ';
      END ELSE BEGIN
       RESULT:=RESULT+'CENTS ';
      END;}
     end else begin
      result:=result+LanguageRules^.ConvertCardinalInteger(V)+' ';
      result:=result+'EURO ';
{     IF V=1 THEN BEGIN
       RESULT:=RESULT+'EURO ';
      END ELSE BEGIN
       RESULT:=RESULT+'EUROS ';
      END;}
     end;
    end else begin
     result:=result+'EURO ';
    end;
   end;
   '0'..'9':begin
    if WasMinus then begin
     WasMinus:=false;
     Number:='-';
    end else begin
     Number:='';
    end;
    Number:=Number+C;
    while (I<=length(AString)) and (AString[I] in ['0'..'9','.']) do begin
     C:=AString[I];
     inc(I);
     Number:=Number+C;
    end;
    J:=POS('.',Number);
    if J<>0 then begin
     if J<>length(Number) then begin
      VAL(COPY(Number,1,J-1),V,Code);
      result:=result+LanguageRules^.ConvertCardinalInteger(V)+' POINT';
      for K:=J+1 to length(Number) do begin
       result:=result+' '+LanguageRules^.ConvertCardinalInteger(ord(Number[K])-ord('0'));
      end;
     end else begin
      VAL(COPY(Number,1,length(Number)-1),V,Code);
      result:=result+LanguageRules^.ConvertOrdinalInteger(V);
     end;
    end else begin
     VAL(Number,V,Code);
     result:=result+LanguageRules^.ConvertCardinalInteger(V);
    end;
   end;
   '{':begin
    CommandLine:='';
    result:=result+'{';
    while (I<=length(AString)) and (AString[I]<>'}') do begin
     C:=AString[I];
     inc(I);
     CommandLine:=CommandLine+C;
     result:=result+C;
    end;
    result:=result+'}';
    inc(I);
    Command:=UPPERCASE(Parse(CommandLine,':'));
    CommandParameter:=UPPERCASE(TRIM(CommandLine));
    if (Command='L') or (Command='LANG') then begin
     if (CommandParameter='EN') or (CommandParameter='UK') or (CommandParameter='ENUK') or (CommandParameter='ENUS') then begin
      LanguageRules:=@SpeechEnglishRules;
     end else if (CommandParameter='DE') or (CommandParameter='DEUK') or (CommandParameter='DEUS') then begin
      LanguageRules:=@SpeechGermanRules;
     end;
    end;
   end;
   '[':begin
    result:=result+C;
    while (I<=length(AString)) and (AString[I]<>']') do begin
     C:=AString[I];
     inc(I);
     result:=result+C;
    end;
    result:=result+']';
    inc(I);
   end;
   '-':begin
    if WasMinus then result:=result+'-';
    WasMinus:=true;
   end;
   '#':begin
    result:=result+'#';
    while (I<=length(AString)) and (AString[I] in ['0'..'9']) do begin
     result:=result+AString[I];
     inc(I);
    end;
   end;
   else begin
    if WasMinus then begin
     result:=result+'-';
     WasMinus:=false;
    end;
    result:=result+C;
   end;
  end;
 end;
 if WasMinus then result:=result+'-';
end;

function LeftMatch(LanguageRules:PSpeechLanguageRules;Pattern,Context:string;Position:integer):boolean;
var Count,TextCount:integer;
    Pat,Text:char;
begin
 if length(Pattern)=0 then begin
  result:=true;
  exit;
 end;
 TextCount:=Position;
 for Count:=length(Pattern) downto 1 do begin
  Pat:=Pattern[Count];
  if (TextCount<1) or (TextCount>length(Context)) then begin
   if Pat in ['''',' '] then begin
    result:=true;
   end else begin
    result:=false;
   end;
   exit;
  end;
  Text:=Context[TextCount];
  if LanguageRules^.IsAlpha(Pat) or (Pat in ['''',' ']) then begin
   if Pat<>Text then begin
    result:=false;
    exit;
   end else begin
    dec(TextCount);
    continue;
   end;
  end;
  case Pat of
   '#':begin
    if not LanguageRules^.IsVowel(Text) then begin
     result:=false;
     exit;
    end;
    dec(TextCount);
    while ((TextCount>=1) and (TextCount<=length(Context))) and LanguageRules^.IsVowel(Context[TextCount]) do begin
     dec(TextCount);
    end;
   end;
   ':':begin
    while ((TextCount>=1) and (TextCount<=length(Context))) and LanguageRules^.IsConstant(Context[TextCount]) do begin
     dec(TextCount);
    end;
   end;
   '^':begin
    if not LanguageRules^.IsConstant(Text) then begin
     result:=false;
     exit;
    end;
    dec(TextCount);
   end;
   '.':begin
    if not (Text in ['B','D','V','G','J','L','M','N','R','W','Z']) then begin
     result:=false;
     exit;
    end;
    dec(TextCount);
   end;
   '+':begin
    if not (Text in ['E','I','Y']) then begin
     result:=false;
     exit;
    end;
    dec(TextCount);
   end;
   '%':begin
    result:=false;
    exit;
   end;
   '$':begin
    if not LanguageRules^.IsAlpha(Text) then begin
     result:=false;
     exit;
    end;
    dec(TextCount);
   end;
   else begin
    result:=false;
    exit;
   end;
  end;
 end;
 result:=true;
end;

function RightMatch(LanguageRules:PSpeechLanguageRules;Pattern,Context:string;Position:integer):boolean;
var Count,TextCount:integer;
    Pat,Text:char;
begin
 if length(Pattern)=0 then begin
  result:=true;
  exit;
 end;
 TextCount:=Position;
 for Count:=1 to length(Pattern) do begin
  Pat:=Pattern[Count];
  if (TextCount<1) or (TextCount>length(Context)) then begin
   if Pat in ['''',' '] then begin
    result:=true;
   end else begin
    result:=false;
   end;
   exit;
  end;
  Text:=Context[TextCount];
  if LanguageRules^.IsAlpha(Pat) or (Pat in ['''',' ']) then begin
   if Pat<>Text then begin
    result:=false;
    exit;
   end else begin
    inc(TextCount);
    continue;
   end;
  end;
  case Pat of
   '#':begin
    if not LanguageRules^.IsVowel(Text) then begin
     result:=false;
     exit;
    end;
    inc(TextCount);
    while ((TextCount>=1) and (TextCount<=length(Context))) and LanguageRules^.IsVowel(Context[TextCount]) do begin
     inc(TextCount);
    end;
   end;
   ':':begin
    while ((TextCount>=1) and (TextCount<=length(Context))) and LanguageRules^.IsConstant(Context[TextCount]) do begin
     inc(TextCount);
    end;
   end;
   '^':begin
    if not LanguageRules^.IsConstant(Text) then begin
     result:=false;
     exit;
    end;
    inc(TextCount);
   end;
   '.':begin
    if not (Text in ['B','D','V','G','J','L','M','N','R','W','Z']) then begin
     result:=false;
     exit;
    end;
    inc(TextCount);
   end;
   '+':begin
    if not (Text in ['E','I','Y']) then begin
     result:=false;
     exit;
    end;
    inc(TextCount);
   end;
   '%':begin
    if Text='E' then begin
     inc(TextCount);
     if ((TextCount>=1) and (TextCount<=length(Context))) and (Context[TextCount]='L') then begin
      inc(TextCount);
      if ((TextCount>=1) and (TextCount<=length(Context))) and (Context[TextCount]='Y') then begin
       inc(TextCount);
      end else begin
       dec(TextCount);
      end;
     end else if ((TextCount>=1) and (TextCount<=length(Context))) and (Context[TextCount] in ['R','S','D']) then begin
      inc(TextCount);
     end;
    end else if Text='I' then begin
     inc(TextCount);
     if ((TextCount>=1) and (TextCount<=length(Context))) and (Context[TextCount]='N') then begin
      inc(TextCount);
      if ((TextCount>=1) and (TextCount<=length(Context))) and (Context[TextCount]='G') then begin
       inc(TextCount);
      end else begin
       result:=false;
       exit;
      end;
     end else begin
      result:=false;
      exit;
     end;
    end else begin
     result:=false;
     exit;
    end;
   end;
   '$':begin
    if not LanguageRules^.IsAlpha(Text) then begin
     result:=false;
     exit;
    end;
    inc(TextCount);
   end;
   else begin
    result:=false;
    exit;
   end;
  end;
 end;
 result:=true;
end;

function FindRule(LanguageRules:PSpeechLanguageRules;word:string;index,AType:integer):integer;
var IndexRule,IndexMatch,Remainder,WordLength:integer;
    Rule:PSpeechRule;
    Left,Match,Right,Output:string;
begin
 result:=-1;
 IndexRule:=0;
 WordLength:=length(word);
 Left:='';
 Match:='';
 Right:='';
 Output:='';
 if WordLength>0 then begin
  while true do begin
   Rule:=@LanguageRules^.Rules[AType]^[IndexRule];
   inc(IndexRule);
   Match:=Rule^[MATCH_PART];
   if length(Match)=0 then begin
    exit;
   end;
   Remainder:=index;
   IndexMatch:=1;
   while ((IndexMatch-1)<>length(Match)) and ((Remainder-1)<>WordLength) do begin
    if Match[IndexMatch]<>word[Remainder] then break;
    inc(Remainder);
    inc(IndexMatch);
   end;
   if (IndexMatch-1)<>length(Match) then continue;
   Left:=Rule^[LEFT_PART];
   Right:=Rule^[RIGHT_PART];
   if not LeftMatch(LanguageRules,Left,word,index-1) then continue;
   if not RightMatch(LanguageRules,Right,word,Remainder) then continue;
   result:=IndexRule-1;
   exit;
  end;
 end;
end;

function ConvertWordToPhonem(LanguageRules:PSpeechLanguageRules;word:string;OutType:integer=OUT_PART):string;
var index,AType,IndexRule,WordLength:integer;
    Phoneme:string;
    C:char;
begin
 result:='';
 index:=1;
 WordLength:=length(word);
 while index<=WordLength do begin
  C:=LanguageRules^.UPCASE(word[index]);
  if LanguageRules^.IsUpper(C) or (C='ß') then begin
   case C of
    'A'..'Z':AType:=byte(C)-ord('A')+1;
    'Ä','Ü','Ö','ß':AType:=27;
    else AType:=0;
   end;
  end else begin
   AType:=0;
  end;
  IndexRule:=FindRule(LanguageRules,word,index,AType);
  if IndexRule<0 then begin
   inc(index);
  end else begin
   Phoneme:=LanguageRules^.Rules[AType]^[IndexRule,OutType];
   if length(Phoneme)>0 then begin
    if (length(result)>0) and (Phoneme<>' ') then result:=result+'/';
    result:=result+Phoneme;
   end;
   inc(index,length(LanguageRules^.Rules[AType]^[IndexRule,MATCH_PART]));
  end;
 end;
end;

function SpeechConvertTextToPhonems(AString:string):string;
var I:integer;
    C:char;
    word,Phonems,CommandLine,Command,CommandParameter:string;
    WasLastSpace,WasLastWord:boolean;
    American:boolean;
    LanguageRules:PSpeechLanguageRules;
begin
 LanguageRules:=@SpeechEnglishRules;
 AString:=ConvertStringToText(AString);
 result:='';
 WasLastSpace:=false;
 WasLastWord:=false;
 American:=false;
 I:=1;
 while I<=length(AString) do begin
  C:=AString[I];
  inc(I);
  case C of
   'a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß':begin
    if (I<=length(AString)) and (AString[I]='.') then begin
     word:=LanguageRules^.AsciiRules[byte(C)];
     if length(word)<>0 then begin
//   IF WasLastWord THEN RESULT:=RESULT+'/';
      result:=result+SpeechConvertARPABETToAlvey(ConvertWordToPhonem(LanguageRules,word),American);
      WasLastWord:=true;
      inc(I);
      continue;
     end;
    end;
    word:=LanguageRules^.UPCASE(C);
    while (I<=length(AString)) and (AString[I] in ['a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß','''']) do begin
     C:=AString[I];
     inc(I);
     word:=word+LanguageRules^.UPCASE(C);
    end;
//  IF WasLastWord THEN RESULT:=RESULT+'/';
    result:=result+SpeechConvertARPABETToAlvey(ConvertWordToPhonem(LanguageRules,word),American);
    WasLastSpace:=false;
    WasLastWord:=true;
   end;
   ' ':begin
    if not WasLastSpace then result:=result+' ';
    WasLastSpace:=true;
    WasLastWord:=false;
   end;
   '[':begin
//  IF WasLastWord THEN RESULT:=RESULT+'/';
    WasLastSpace:=false;
    Phonems:='';
    while (I<=length(AString)) and (AString[I]<>']') do begin
     C:=AString[I];
     inc(I);
     Phonems:=Phonems+C;
    end;
    inc(I);
    result:=result+Phonems;
//  WasLastWord:=C<>'/';
    WasLastWord:=false;
   end;
   '{':begin
    WasLastSpace:=false;
    CommandLine:='';
    while (I<=length(AString)) and (AString[I]<>'}') do begin
     C:=AString[I];
     inc(I);
     CommandLine:=CommandLine+C;
    end;
    inc(I);
    Command:=UPPERCASE(Parse(CommandLine,':'));
    CommandParameter:=UPPERCASE(TRIM(CommandLine));
    if (Command='L') or (Command='LANG') then begin
     if (CommandParameter='EN') or (CommandParameter='UK') or (CommandParameter='ENUK') then begin
      LanguageRules:=@SpeechEnglishRules;
      American:=false;
     end else if (CommandParameter='US') or (CommandParameter='ENUS') then begin
      LanguageRules:=@SpeechEnglishRules;
      American:=true;
     end else if (CommandParameter='DE') or (CommandParameter='DEUK') then begin
      LanguageRules:=@SpeechGermanRules;
      American:=false;
     end else if (CommandParameter='DEUS') then begin
      LanguageRules:=@SpeechGermanRules;
      American:=true;
     end;
    end;
   end;
   '_','!':result:=result+C;
   '|':;
   '#':begin
    result:=result+'#';
    while (I<=length(AString)) and (AString[I] in ['0'..'9']) do begin
     result:=result+AString[I];
     inc(I);
    end;
   end;
   else begin
    WasLastSpace:=false;
    if C in [#0..#127] then begin
     word:=LanguageRules^.AsciiRules[byte(C)];
     if length(word)<>0 then begin
      if WasLastWord then result:=result+' ';
      result:=result+SpeechConvertARPABETToAlvey(ConvertWordToPhonem(LanguageRules,word),American);
      WasLastWord:=true;
     end else begin
      WasLastWord:=false;
      result:=result+C;
     end;
    end else begin
     WasLastWord:=false;
     result:=result+C;
    end;
   end;
  end;
 end;
 if not WasLastSpace then result:=result+' ';
end;

function SpeechConvertPhonemsToSegmentList(var SegmentList:TSynthSpeechSegmentList;Phonems:string):boolean;
var S:string;
    C:char;
    Counter,SubCounter,OldCounter,Found,index,DurationTimeFactor,ItemsAllocated:integer;
    SegmentItem:TSynthSpeechSegmentItem;
    NewItems:PSynthSpeechSegmentItems;
begin
 result:=SegmentList.Phonems<>Phonems;
 if result then begin
  SegmentList.Phonems:=Phonems;
  if assigned(SegmentList.Items) then begin
   FreeMemAligned(SegmentList.Items);
   SegmentList.Items:=nil;
  end;
  SegmentList.ItemCount:=0;
  DurationTimeFactor:=0;
  ItemsAllocated:=0;
  Counter:=1;
  S:='';
  while Counter<=length(Phonems) do begin
   C:=Phonems[Counter];
   case C of
    'a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß','@','0'..'9','&','%',' ':begin
     S:=C;
     OldCounter:=Counter;
     if ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['a'..'z','A'..'Z','ä','ö','ü','Ä','Ö','Ü','ß','@','0'..'9','&','%']) then begin
      inc(Counter);
      S:=S+Phonems[Counter];
     end;
     Found:=-1;
     while (length(S)>0) and (Found<0) do begin
      for SubCounter:=low(SynthSpeechSegmentsPhonems) to high(SynthSpeechSegmentsPhonems) do begin
       if SynthSpeechSegmentsPhonems[SubCounter].Phonem=S then begin
        Found:=SubCounter;
        break;
       end;
      end;
      S:=COPY(S,1,length(S)-1);
      if Found<0 then dec(Counter);
     end;
     if Found>=0 then begin
      if SynthSpeechSegmentsPhonems[Found].SegmentCount>0 then begin
       for SubCounter:=0 to SynthSpeechSegmentsPhonems[Found].SegmentCount-1 do begin
        FastFillChar(SegmentItem,sizeof(TSynthSpeechSegmentItem),#0);
        SegmentItem.SegmentIndex:=SynthSpeechSegmentsPhonems[Found].Segments[SubCounter];
        SegmentItem.DurationTimeFactor:=DurationTimeFactor;
        index:=SegmentList.ItemCount;
        if (index+2)>=ItemsAllocated then begin
         ItemsAllocated:=(index+2)*2;
         GetMemAligned(NewItems,(ItemsAllocated+1)*sizeof(TSynthSpeechSegmentItem));
         Move(SegmentList.Items^[0],NewItems^[0],index*sizeof(TSynthSpeechSegmentItem));
         FreeMemAligned(SegmentList.Items);
         SegmentList.Items:=NewItems;
        end;
        SegmentList.Items[index]:=SegmentItem;
        inc(SegmentList.ItemCount);
       end;
      end;
     end else begin
      Counter:=OldCounter;
     end;
    end;
    '!':begin
     index:=SegmentList.ItemCount-1;
     if (index>=0) and (index<SegmentList.ItemCount) then begin
      SegmentList.Items[index].WaitForEvent:=wfeNOTEON;
     end;
    end;
    '_':begin
     index:=SegmentList.ItemCount-1;
     if (index>=0) and (index<SegmentList.ItemCount) then begin
      SegmentList.Items[index].WaitForEvent:=wfeNOTEOFF;
     end;
    end;
    '#':begin
     S:='';
     while ((Counter+1)<=length(Phonems)) and (Phonems[Counter+1] in ['0'..'9']) do begin
      S:=S+Phonems[Counter+1];
      inc(Counter);
     end;
     DurationTimeFactor:=STRTOINT(S);
    end;
    '/':;
    else begin
    end;
   end;
   inc(Counter);
  end;
 end;
end;

end.


