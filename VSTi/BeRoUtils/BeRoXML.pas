(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2004, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoXML;
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
 {$HINTS OFF}
 {$DEFINE LITTLE_ENDIAN}
 {$IFNDEF CPU64}
  {$DEFINE CPU32}
 {$ENDIF}
 {$OPTIMIZATION ON}
{$ENDIF}
{$DEFINE UNICODE}

interface

uses BeRoStream,BeRoStringTree;

type TBeRoXMLString={$IFDEF UNICODE}widestring{$ELSE}string{$ENDIF};
     TBeRoXMLChar={$IFDEF UNICODE}widechar{$ELSE}char{$ENDIF};

     TBeRoXMLParameter=class
      public
       name:string;
       Value:TBeRoXMLString;
       constructor Create;
       destructor Destroy; override;
       procedure SetParameter(AParameter:string);
     end;

     TBeRoXMLItem=class
      public
       Items:array of TBeRoXMLItem;
       constructor Create; virtual;
       destructor Destroy; override;
       procedure Clear; virtual;
       procedure Add(Item:TBeRoXMLItem);
     end;

     TBeRoXMLText=class(TBeRoXMLItem)
      public
       Text:TBeRoXMLString;
       constructor Create; override;
       destructor Destroy; override;
       procedure SetText(AText:string);
     end;

     TBeRoXMLComment=class(TBeRoXMLItem)
      public
       Text:string;
       constructor Create; override;
       destructor Destroy; override;
       procedure SetText(AText:string);
     end;

     TBeRoXMLTag=class(TBeRoXMLItem)
      private
       StringTree:TBeRoStringTree;
      public
       name:string;
       Parameter:array of TBeRoXMLParameter;
       IsAloneTag:boolean;
       constructor Create; override;
       destructor Destroy; override;
       procedure Clear; override;
       function FindParameter(ParameterName:string):TBeRoXMLParameter;
       function GetParameter(ParameterName:string;default:string=''):string;
       function AddParameter(AParameter:TBeRoXMLParameter):boolean; overload;
       function AddParameter(name:string;Value:TBeRoXMLString):boolean; overload;
       function RemoveParameter(AParameter:TBeRoXMLParameter):boolean; overload;
       function RemoveParameter(ParameterName:string):boolean; overload;
       procedure SetTag(Data:string);
     end;

     TBeRoXMLProcessTag=class(TBeRoXMLTag)
      public
       constructor Create; override;
       destructor Destroy; override;
     end;

     TBeRoXMLScriptTag=class(TBeRoXMLItem)
      public
       Text:string;
       constructor Create; override;
       destructor Destroy; override;
       procedure SetText(AText:string);
     end;

     TBeRoXMLCDataTag=class(TBeRoXMLItem)
      public
       Text:string;
       constructor Create; override;
       destructor Destroy; override;
       procedure SetText(AText:string);
     end;

     TBeRoXMLExtraTag=class(TBeRoXMLItem)
      public
       Text:string;
       constructor Create; override;
       destructor Destroy; override;
       procedure SetText(AText:string);
     end;

     TBeRoXML=class(TObject)
      private
       function ReadXMLText:string;
       procedure WriteXMLText(Text:string);
      public
       Root:TBeRoXMLItem;
       AutomaticAloneTagDetection:boolean;
       FormatIndent:boolean;
       FormatIndentText:boolean;
       constructor Create;
       destructor Destroy; override;
       function Parse(Stream:TBeRoStream):boolean;
       function read(Stream:TBeRoStream):boolean;
       procedure write(Stream:TBeRoStream;IdentSize:integer=2);
       property Text:string read ReadXMLText write WriteXMLText;
     end;

implementation

uses BeRoUtils;

const EntityChars:array[1..101,1..2] of TBeRoXMLString=(('&quot;',#34),('&amp;',#38),
                                                        ('&lt;',#60),('&gt;',#62),('&euro;',#128),('&nbsp;',#160),('&iexcl;',#161),
                                                        ('&cent;',#162),('&pound;',#163),('&curren;',#164),('&yen;',#165),
                                                        ('&brvbar;',#166),('&sect;',#167),('&uml;',#168),('&copy;',#169),
                                                        ('&ordf;',#170),('&laquo;',#171),('&not;',#172),('&shy;',#173),
                                                        ('&reg;',#174),('&macr;',#175),('&deg;',#176),('&plusmn;',#177),
                                                        ('&sup2;',#178),('&sup3;',#179),('&acute;',#180),('&micro;',#181),
                                                        ('&para;',#182),('&middot;',#183),('&cedil;',#184),('&sup1;',#185),
                                                        ('&ordm;',#186),('&raquo;',#187),('&frac14;',#188),('&frac12;',#189),
                                                        ('&frac34;',#190),('&iquest;',#191),('&Agrave;',#192),('&Aacute;',#193),
                                                        ('&Acirc;',#194),('&Atilde;',#195),('&Auml;',#196),('&Aring;',#197),
                                                        ('&AElig;',#198),('&Ccedil;',#199),('&Egrave;',#200),('&Eacute;',#201),
                                                        ('&Ecirc;',#202),('&Euml;',#203),('&Igrave;',#204),('&Iacute;',#205),
                                                        ('&Icirc;',#206),('&Iuml;',#207),('&ETH;',#208),('&Ntilde;',#209),
                                                        ('&Ograve;',#210),('&Oacute;',#211),('&Ocirc;',#212),('&Otilde;',#213),
                                                        ('&Ouml;',#214),('&times;',#215),('&Oslash;',#216),('&Ugrave;',#217),
                                                        ('&Uacute;',#218),('&Ucirc;',#219),('&Uuml;',#220),('&Yacute;',#221),
                                                        ('&THORN;',#222),('&szlig;',#223),('&agrave;',#224),('&aacute;',#225),
                                                        ('&acirc;',#226),('&atilde;',#227),('&auml;',#228),('&aring;',#229),
                                                        ('&aelig;',#230),('&ccedil;',#231),('&egrave;',#232),('&eacute;',#233),
                                                        ('&ecirc;',#234),('&euml;',#235),('&igrave;',#236),('&iacute;',#237),
                                                        ('&icirc;',#238),('&iuml;',#239),('&eth;',#240),('&ntilde;',#241),
                                                        ('&ograve;',#242),('&oacute;',#243),('&ocirc;',#244),('&otilde;',#245),
                                                        ('&ouml;',#246),('&divide;',#247),('&oslash;',#248),('&ugrave;',#249),
                                                        ('&uacute;',#250),('&ucirc;',#251),('&uuml;',#252),('&yacute;',#253),
                                                        ('&thorn;',#254),('&yuml;',#255));

type TEntitiesCharLookUpItem=record
      IsEntity:boolean;
      Entity:string;
     end;

     TEntitiesCharLookUpTable=array[0..{$IFDEF UNICODE}65535{$ELSE}255{$ENDIF}] of TEntitiesCharLookUpItem;

var EntitiesCharLookUp:TEntitiesCharLookUpTable;

procedure InitializeEntites;
var EntityCounter:integer;
begin
 FastFillChar(EntitiesCharLookUp,sizeof(TEntitiesCharLookUpTable),#0);
 for EntityCounter:=low(EntityChars) to high(EntityChars) do begin
  with EntitiesCharLookUp[ord(EntityChars[EntityCounter,2][1])] do begin
   IsEntity:=true;
   Entity:=EntityChars[EntityCounter,1];
  end;
 end;
end;

function ParseEntities(AString:string):TBeRoXMLString;
var Counter,OldIndex,EntityCounter,EntityLength,Value,Code:integer;
    Entity:string;
    C:TBeRoXMLChar;
    InputChar:char;
    Found:boolean;
begin
 result:='';
 Counter:=1;
 while Counter<=length(AString) do begin
  InputChar:=AString[Counter];
  case InputChar of
   '&':begin
    if (Counter+1)<=length(AString) then begin
     inc(Counter);
     OldIndex:=Counter;
     Entity:=InputChar;
     while (Counter<=length(AString)) and ((AString[Counter] in ['a'..'z','A'..'Z','0'..'9']) or ((Counter=OldIndex) and (AString[Counter]='#'))) do begin
      InputChar:=AString[Counter];
      Entity:=Entity+InputChar;
      inc(Counter);
     end;
     if (Counter<=length(AString)) and (AString[Counter]=';') then begin
      Entity:=Entity+';';
      inc(Counter);
      EntityLength:=length(Entity);
      if (EntityLength>3) and (Entity[2]='#') then begin
       DELETE(Entity,EntityLength,1);
       DELETE(Entity,1,2);
       if LOWERCASE(Entity[1])='x' then Entity[1]:='$';
       if length(Entity)<=5 then begin
        VAL(Entity,Value,Code);
        if Code=0 then begin
{$IFDEF UNICODE}
         C:=widechar(word(Value));
{$ELSE}
         C:=char(byte(Value));
{$ENDIF}
         result:=result+C;
        end;
       end;
      end else begin
       Found:=false;
       for EntityCounter:=low(EntityChars) to high(EntityChars) do begin
        if Entity=EntityChars[EntityCounter,1] then begin
         result:=result+EntityChars[EntityCounter,2];
         Found:=true;
         break;
        end;
       end;
       if not Found then begin
        result:=result+Entity;
       end;
      end;
     end else begin
      result:=result+Entity;
     end;
     continue;
    end else begin
     result:=result+InputChar;
    end;
   end;
   else result:=result+InputChar;
  end;
  inc(Counter);
 end;
end;

function ConvertToEntities(AString:TBeRoXMLString;IdentLevel:integer=0):string;
var Counter,IdentCounter:integer;
    C:TBeRoXMLChar;
begin
 result:='';
 for Counter:=1 to length(AString) do begin
  C:=AString[Counter];
  if C=#13 then begin
   if ((Counter+1)<=length(AString)) and (AString[Counter+1]=#10) then begin
    continue;
   end;
   C:=#10;
  end;
  if EntitiesCharLookUp[ord(C)].IsEntity then begin
   result:=result+EntitiesCharLookUp[ord(C)].Entity;
  end else if (C=#9) or (C=#10) or (C=#13) or ((C>=#32) and (C<=#127)) then begin
   result:=result+C;
   if C=#10 then begin
    for IdentCounter:=1 to IdentLevel do result:=result+' ';
   end;
  end else begin
{$IFDEF UNICODE}
   if C<#255 then begin
    result:=result+'&#'+INTTOSTR(ord(C))+';';
   end else begin
    result:=result+'&#x'+DecToHex(ord(C))+';';
   end;
{$ELSE}
   result:=result+'&#'+INTTOSTR(byte(C))+';';
{$ENDIF}
  end;
 end;
end;

constructor TBeRoXMLItem.Create;
begin
 inherited Create;
 Items:=nil;
end;

destructor TBeRoXMLItem.Destroy;
begin
 Clear;
 inherited Destroy;
end;

procedure TBeRoXMLItem.Clear;
var Counter:integer;
begin
 for Counter:=0 to length(Items)-1 do Items[Counter].Free;
 setlength(Items,0);
end;

procedure TBeRoXMLItem.Add(Item:TBeRoXMLItem);
var index:integer;
begin
 index:=length(Items);
 setlength(Items,index+1);
 Items[index]:=Item;
end;

constructor TBeRoXMLParameter.Create;
begin
 inherited Create;
 name:='';
 Value:='';
end;

destructor TBeRoXMLParameter.Destroy;
begin
 name:='';
 Value:='';
 inherited Destroy;
end;

procedure TBeRoXMLParameter.SetParameter(AParameter:string);
var NewValue:string;
begin
 name:=TRIM(Parse(AParameter,'='));
 NewValue:=TRIM(AParameter);
 if (length(NewValue)>1) and ((NewValue[1] in ['"','''']) and (NewValue[length(NewValue)] in ['"',''''])) then begin
  Value:=ParseEntities(COPY(NewValue,2,length(NewValue)-2));
 end else begin
  Value:=NewValue;
 end;
end;

constructor TBeRoXMLText.Create;
begin
 inherited Create;
 Text:='';
end;

destructor TBeRoXMLText.Destroy;
begin
 Text:='';
 inherited Destroy;
end;

procedure TBeRoXMLText.SetText(AText:string);
begin
 Text:=AText;
end;

constructor TBeRoXMLComment.Create;
begin
 inherited Create;
 Text:='';
end;

destructor TBeRoXMLComment.Destroy;
begin
 Text:='';
 inherited Destroy;
end;

procedure TBeRoXMLComment.SetText(AText:string);
begin
 Text:=AText;
end;

constructor TBeRoXMLTag.Create;
begin
 inherited Create;
 StringTree:=TBeRoStringTree.Create;
 name:='';
 Parameter:=nil;
end;

destructor TBeRoXMLTag.Destroy;
begin
 StringTree.Destroy;
 StringTree:=nil;
 inherited Destroy;
end;

procedure TBeRoXMLTag.Clear;
var Counter:integer;
begin
 inherited Clear;
 if assigned(StringTree) then StringTree.Clear;
 for Counter:=0 to length(Parameter)-1 do Parameter[Counter].Free;
 setlength(Parameter,0);
 name:='';
end;

function TBeRoXMLTag.FindParameter(ParameterName:string):TBeRoXMLParameter;
var Link:TBeRoStringTreeLink;
    LinkClass:TBeRoXMLParameter absolute Link;
begin
 if StringTree.Find(ParameterName,Link) then begin
  result:=LinkClass;
 end else begin
  result:=nil;
 end;
end;

function TBeRoXMLTag.GetParameter(ParameterName:string;default:string=''):string;
var Link:TBeRoStringTreeLink;
    LinkClass:TBeRoXMLParameter absolute Link;
begin
 if StringTree.Find(ParameterName,Link) then begin
  result:=LinkClass.Value;
 end else begin
  result:=default;
 end;
end;

function TBeRoXMLTag.AddParameter(AParameter:TBeRoXMLParameter):boolean;
var index:integer;
begin
 try
  index:=length(Parameter);
  setlength(Parameter,index+1);
  Parameter[index]:=AParameter;
  StringTree.Add(AParameter.name,longword(AParameter),true);
  result:=true;
 except
  result:=false;
 end;
end;

function TBeRoXMLTag.AddParameter(name:string;Value:TBeRoXMLString):boolean;
var AParameter:TBeRoXMLParameter;
begin
 AParameter:=TBeRoXMLParameter.Create;
 AParameter.name:=name;
 AParameter.Value:=Value;
 result:=AddParameter(AParameter);
end;

function TBeRoXMLTag.RemoveParameter(AParameter:TBeRoXMLParameter):boolean;
var Found,Counter:integer;
begin
 result:=false;
 try
  Found:=-1;
  for Counter:=0 to length(Parameter)-1 do begin
   if Parameter[Counter]=AParameter then begin
    Found:=Counter;
    break;
   end;
  end;
  if Found>=0 then begin
   for Counter:=Found to length(Parameter)-2 do begin
    Parameter[Counter]:=Parameter[Counter+1];
   end;
   setlength(Parameter,length(Parameter)-1);
   StringTree.Delete(AParameter.name);
   AParameter.Destroy;
   result:=true;
  end;
 except
 end;
end;

function TBeRoXMLTag.RemoveParameter(ParameterName:string):boolean;
begin
 result:=RemoveParameter(FindParameter(ParameterName));
end;

procedure TBeRoXMLTag.SetTag(Data:string);
var index:integer;
    Tag,ParameterString:string;
    AParameter:TBeRoXMLParameter;
    IsQuote:boolean;
    C,QuoteChar:char;
 function IsEOL:boolean;
 begin
  result:=index>length(Data);
 end;
 function ReadChar:char;
 begin
  inc(index);
  if IsEOL then begin
   result:=#0;
  end else begin
   result:=Data[index];
  end;
  C:=result;
 end;
 procedure SkipSpaces;
 begin
  while (C in SpaceChars) and not IsEOL do ReadChar;
 end;
begin
 Clear;
 Tag:=Parse(Data,SpaceChars);
 name:=Tag;
 index:=0;
 ReadChar;
 while not IsEOL do begin
  SkipSpaces;
  ParameterString:='';
  IsQuote:=false;
  QuoteChar:=#0;
  while ((C<>' ') or IsQuote) and not IsEOL do begin
   if not IsQuote then begin
    if C in ['"',''''] then begin
     QuoteChar:=C;
     IsQuote:=true;
    end;
   end else if C=QuoteChar then begin
    IsQuote:=false;
   end;
   if C='\' then ReadChar;
   ParameterString:=ParameterString+C;
   ReadChar;
  end;
  if length(ParameterString)<>0 then begin
   AParameter:=TBeRoXMLParameter.Create;
   AParameter.SetParameter(ParameterString);
   AddParameter(AParameter);
  end;
 end;
end;

constructor TBeRoXMLProcessTag.Create;
begin
 inherited Create;
end;

destructor TBeRoXMLProcessTag.Destroy;
begin
 inherited Destroy;
end;

constructor TBeRoXMLScriptTag.Create;
begin
 inherited Create;
 Text:='';
end;

destructor TBeRoXMLScriptTag.Destroy;
begin
 Text:='';
 inherited Destroy;
end;

procedure TBeRoXMLScriptTag.SetText(AText:string);
begin
 Text:=AText;
end;

constructor TBeRoXMLCDataTag.Create;
begin
 inherited Create;
 Text:='';
end;

destructor TBeRoXMLCDataTag.Destroy;
begin
 Text:='';
 inherited Destroy;
end;

procedure TBeRoXMLCDataTag.SetText(AText:string);
begin
 Text:=AText;
end;

constructor TBeRoXMLExtraTag.Create;
begin
 inherited Create;
 Text:='';
end;

destructor TBeRoXMLExtraTag.Destroy;
begin
 Text:='';
 inherited Destroy;
end;

procedure TBeRoXMLExtraTag.SetText(AText:string);
begin
 Text:=AText;
end;

constructor TBeRoXML.Create;
begin
 inherited Create;
 Root:=TBeRoXMLItem.Create;
 AutomaticAloneTagDetection:=true;
 FormatIndent:=true;
 FormatIndentText:=false;
end;

destructor TBeRoXML.Destroy;
begin
 Root.Free;
 inherited Destroy;
end;

function TBeRoXML.Parse(Stream:TBeRoStream):boolean;
var Errors:boolean;
    LastChar:char;
 procedure Process(ParentItem:TBeRoXMLItem;Closed:boolean);
 var Text:string;
     Tag:string;
     IsTag,IsNewTag,IsComment,IsProcess,IsScript,IsCDATA,IsExtraTag,IsAloneTag,
     FinishLevel,DoReadChar:boolean;
     C:char;
     ModeIndexCounter:integer;
  procedure AddText;
  var AText:TBeRoXMLText;
  begin
   if not IsTag then begin
    if length(TRIM(Text))<>0 then begin
     AText:=TBeRoXMLText.Create;
     AText.Text:=ParseEntities(Text);
     ParentItem.Add(AText);
    end;
    Text:='';
   end;
  end;
  procedure AddTag;
  var ATag:TBeRoXMLTag;
  begin
   IsTag:=false;
   ATag:=TBeRoXMLTag.Create;
   while (length(Tag)>0) and (Tag[length(Tag)] in SpaceChars) do begin
    Tag:=COPY(Tag,1,length(Tag)-1);
   end;
   if (length(Tag)>0) and (Tag[length(Tag)]='/') then begin
    Tag:=COPY(Tag,1,length(Tag)-1);
    IsAloneTag:=true;
   end;
   ATag.SetTag(Tag);
   ATag.IsAloneTag:=IsAloneTag;
   Tag:='';
   if (ParentItem<>Root) and (ParentItem is TBeRoXMLTag) and (ATag.name='/'+TBeRoXMLTag(ParentItem).name) then begin
    ATag.Destroy;
    FinishLevel:=true;
    Closed:=true;
   end else begin
    ParentItem.Add(ATag);
    if not IsAloneTag then begin
     Process(ATag,false);
    end;
   end;
   IsAloneTag:=false;
  end;
  procedure AddComment;
  var AComment:TBeRoXMLComment;
  begin
   AComment:=TBeRoXMLComment.Create;
   AComment.SetText(COPY(Tag,4,length(Tag)-5));
   ParentItem.Add(AComment);
   Tag:='';
  end;
  procedure AddProcessTag;
  var AProcessTag:TBeRoXMLProcessTag;
  begin
   AProcessTag:=TBeRoXMLProcessTag.Create;
   AProcessTag.SetTag(COPY(Tag,2,length(Tag)-2));
   ParentItem.Add(AProcessTag);
   Tag:='';
  end;
  procedure AddScriptTag;
  var AScriptTag:TBeRoXMLScriptTag;
  begin
   AScriptTag:=TBeRoXMLScriptTag.Create;
   AScriptTag.SetText(COPY(Tag,2,length(Tag)-2));
   ParentItem.Add(AScriptTag);
   Tag:='';
  end;
  procedure AddCDataTag;
  var ACDataTag:TBeRoXMLCDataTag;
  begin
   ACDataTag:=TBeRoXMLCDataTag.Create;
   ACDataTag.SetText(COPY(Tag,9,length(Tag)-10));
   ParentItem.Add(ACDataTag);
   Tag:='';
  end;
  procedure AddExtraTag;
  var AExtraTag:TBeRoXMLExtraTag;
  begin
   AExtraTag:=TBeRoXMLExtraTag.Create;
   AExtraTag.SetText(COPY(Tag,2,length(Tag)-1));
   ParentItem.Add(AExtraTag);
   Tag:='';
  end;
 begin
  Text:='';
  Tag:='';
  IsTag:=false;
  IsNewTag:=false;
  IsComment:=false;
  IsProcess:=false;
  IsScript:=false;
  IsCData:=false;
  IsExtraTag:=false;
  IsAloneTag:=false;
  ModeIndexCounter:=0;
  FinishLevel:=false;
  DoReadChar:=true;
  while (Stream.Position<Stream.Size) and not (FinishLevel or Errors) do begin
   if DoReadChar then begin
    Stream.read(C,sizeof(char));
    if C=#13 then begin
     LastChar:=C;
     C:=#10;
    end else if (C=#10) and (LastChar=#13) then begin
     LastChar:=C;
     continue;
    end else begin
     LastChar:=C;
    end;
   end;
   DoReadChar:=true;
   if IsTag and IsComment then begin
    case ModeIndexCounter of
     1..4:begin
      if (ModeIndexCounter=1) and (C='[') then begin
       IsComment:=false;
       IsCData:=true;
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else  if C='-' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else if ModeIndexCounter in [1..2] then begin
       IsExtraTag:=true;
       IsComment:=false;
       ModeIndexCounter:=0;
       DoReadChar:=false;
      end else begin
       ModeIndexCounter:=3;
       Tag:=Tag+C;
      end;
     end;
     5:begin
      if C='>' then begin
       AddComment;
       IsAloneTag:=false;
       IsTag:=false;
       IsComment:=false;
      end else begin
       ModeIndexCounter:=3;
       Tag:=Tag+C;
      end;
     end;
     else begin
      if ModeIndexCounter>3 then ModeIndexCounter:=3;
      Tag:=Tag+C;
     end;
    end;
   end else if IsTag and IsProcess then begin
    case ModeIndexCounter of
     1:begin
      if C='?' then inc(ModeIndexCounter);
      Tag:=Tag+C;
     end;
     2:begin
      if C='>' then begin
       AddProcessTag;
       IsAloneTag:=false;
       IsTag:=false;
       IsProcess:=false;
      end else begin
       ModeIndexCounter:=1;
       Tag:=Tag+C;
      end;
     end;
    end;
   end else if IsTag and IsScript then begin
    case ModeIndexCounter of
     1:begin
      if C='%' then inc(ModeIndexCounter);
      Tag:=Tag+C;
     end;
     2:begin
      if C='>' then begin
       AddScriptTag;
       IsAloneTag:=false;
       IsTag:=false;
       IsScript:=false;
      end else begin
       ModeIndexCounter:=1;
       Tag:=Tag+C;
      end;
     end;
    end;
   end else if IsTag and IsCData then begin
    case ModeIndexCounter of
     2:begin
      if C='C' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else begin
       IsCData:=false;
       IsExtraTag:=true;
      end;
     end;
     3:begin
      if C='D' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else begin
       IsCData:=false;
       IsExtraTag:=true;
      end;
     end;
     4:begin
      if C='A' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else begin
       IsCData:=false;
       IsExtraTag:=true;
      end;
     end;
     5:begin
      if C='T' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else begin
       IsCData:=false;
       IsExtraTag:=true;
       DoReadChar:=true;
      end;
     end;
     6:begin
      if C='A' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else begin
       IsCData:=false;
       IsExtraTag:=true;
       DoReadChar:=true;
      end;
     end;
     7:begin
      if C='[' then begin
       inc(ModeIndexCounter);
       Tag:=Tag+C;
      end else begin
       IsCData:=false;
       IsExtraTag:=true;
       DoReadChar:=true;
      end;
     end;
     8..9:begin
      if C=']' then begin
       inc(ModeIndexCounter);
      end else begin
       ModeIndexCounter:=8;
      end;
      Tag:=Tag+C;
     end;
     10:begin
      if C='>' then begin
       AddCDataTag;
       IsAloneTag:=false;
       IsTag:=false;
       IsCData:=false;
      end else begin
       ModeIndexCounter:=8;
       Tag:=Tag+C;
      end;
     end;
     else begin
      if ModeIndexCounter>3 then ModeIndexCounter:=3;
      Tag:=Tag+C;
     end;
    end;
   end else begin
    if C='<' then begin
     AddText;
     IsAloneTag:=false;
     IsTag:=true;
     IsNewTag:=true;
     IsComment:=false;
     ModeIndexCounter:=0;
    end else if (C='>') and (IsTag or IsComment or IsProcess or IsScript or IsCData or IsExtraTag or IsAloneTag) then begin
     if IsExtraTag then begin
      AddExtraTag;
     end else begin
      AddTag;
     end;
    end else begin
     if IsTag then begin
      if (C='!') and IsNewTag then begin
       IsNewTag:=false;
       IsComment:=true;
       ModeIndexCounter:=1;
      end else if (C='?') and IsNewTag then begin
       IsNewTag:=false;
       IsProcess:=true;
       ModeIndexCounter:=1;
      end else if (C='%') and IsNewTag then begin
       IsNewTag:=false;
       IsScript:=true;
       ModeIndexCounter:=1;
      end else if C='/' then begin
       IsAloneTag:=true;
      end else if IsAloneTag and not (C in SpaceChars) then begin
       IsAloneTag:=false;
      end;
      IsNewTag:=false;
      Tag:=Tag+C;
     end else begin
      Text:=Text+C;
     end;
    end;
   end;
  end;
  if IsTag then begin
   if length(Tag)<>0 then AddTag;
  end else begin
   if length(Text)<>0 then AddText;
  end;
  if not Closed then begin
   Errors:=true;
  end;
 end;
begin
 Errors:=false;
 LastChar:=#0;
 Root.Clear;
 Stream.Seek(0,bsoFromBeginning);
 Process(Root,true);
 if Errors then Root.Clear;
 result:=not Errors;
end;

function TBeRoXML.read(Stream:TBeRoStream):boolean;
begin
 result:=Parse(Stream);
end;

procedure TBeRoXML.write(Stream:TBeRoStream;IdentSize:integer=2);
var IdentLevel:integer;
 procedure Process(Item:TBeRoXMLItem;DoIndent:boolean);
 var Line:string;
     Counter:integer;
     TagWithSingleLineText,ItemsText:boolean;
  procedure WriteLineEx(Line:string);
  begin
   if length(Line)>0 then begin
    Stream.write(Line[1],length(Line));
   end;
  end;
  procedure WriteLine(Line:string);
  begin
   if FormatIndent and DoIndent then Line:=Line+#10;
   if length(Line)>0 then begin
    Stream.write(Line[1],length(Line));
   end;
  end;
 begin
  if assigned(Item) then begin
   inc(IdentLevel,IdentSize);
   Line:='';
   if FormatIndent and DoIndent then for Counter:=1 to IdentLevel do Line:=Line+' ';
   if Item is TBeRoXMLText then begin
    if FormatIndentText then begin
     Line:=Line+ConvertToEntities(TBeRoXMLText(Item).Text,IdentLevel);
    end else begin
     Line:=ConvertToEntities(TBeRoXMLText(Item).Text);
    end;
    WriteLine(Line);
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end else if Item is TBeRoXMLComment then begin
    Line:=Line+'<!--'+TBeRoXMLComment(Item).Text+'-->';
    WriteLine(Line);
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end else if Item is TBeRoXMLProcessTag then begin
    Line:=Line+'<?'+TBeRoXMLProcessTag(Item).name;
    for Counter:=0 to length(TBeRoXMLProcessTag(Item).Parameter)-1 do begin
     if assigned(TBeRoXMLProcessTag(Item).Parameter[Counter]) then begin
      Line:=Line+' '+TBeRoXMLProcessTag(Item).Parameter[Counter].name+'="'+ConvertToEntities(TBeRoXMLProcessTag(Item).Parameter[Counter].Value)+'"';
     end;
    end;
    Line:=Line+'?>';
    WriteLine(Line);
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end else if Item is TBeRoXMLScriptTag then begin
    Line:=Line+'<%'+TBeRoXMLScriptTag(Item).Text+'%>';
    WriteLine(Line);
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end else if Item is TBeRoXMLCDataTag then begin
    Line:=Line+'<![CDATA['+TBeRoXMLCDataTag(Item).Text+']]>';
    WriteLine(Line);
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end else if Item is TBeRoXMLExtraTag then begin
    Line:=Line+'<!'+TBeRoXMLExtraTag(Item).Text+'>';
    WriteLine(Line);
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end else if Item is TBeRoXMLTag then begin
    if AutomaticAloneTagDetection then begin
     TBeRoXMLTag(Item).IsAloneTag:=length(TBeRoXMLTag(Item).Items)=0;
    end;
    Line:=Line+'<'+TBeRoXMLTag(Item).name;
    for Counter:=0 to length(TBeRoXMLTag(Item).Parameter)-1 do begin
     if assigned(TBeRoXMLTag(Item).Parameter[Counter]) then begin
      Line:=Line+' '+TBeRoXMLTag(Item).Parameter[Counter].name+'="'+ConvertToEntities(TBeRoXMLTag(Item).Parameter[Counter].Value)+'"';
     end;
    end;
    if TBeRoXMLTag(Item).IsAloneTag then begin
     Line:=Line+' />';
     WriteLine(Line);
    end else begin
     TagWithSingleLineText:=false;
     if length(Item.Items)=1 then begin
      if assigned(Item.Items[0]) then begin
       if Item.Items[0] is TBeRoXMLText then begin
        if ((POS(#13,TBeRoXMLText(Item.Items[0]).Text)=0) and
            (POS(#10,TBeRoXMLText(Item.Items[0]).Text)=0)) or not FormatIndentText then begin
         TagWithSingleLineText:=true;
        end;
       end;
      end;
     end;
     ItemsText:=false;
     for Counter:=0 to length(Item.Items)-1 do begin
      if assigned(Item.Items[Counter]) then begin
       if Item.Items[Counter] is TBeRoXMLText then begin
        ItemsText:=true;
       end;
      end;
     end;
     if TagWithSingleLineText then begin
      Line:=Line+'>'+TBeRoXMLText(Item.Items[0]).Text+'</'+TBeRoXMLTag(Item).name+'>';
      WriteLine(Line);
     end else if length(Item.Items)<>0 then begin
      Line:=Line+'>';
      if assigned(Item.Items[0]) and (Item.Items[0] is TBeRoXMLText) and not FormatIndentText then begin
       WriteLineEx(Line);
      end else begin
       WriteLine(Line);
      end;
      for Counter:=0 to length(Item.Items)-1 do begin
       Process(Item.Items[Counter],DoIndent and ((not ItemsText) or (FormatIndent and FormatIndentText)));
      end;
      Line:='';
      if DoIndent and ((not ItemsText) or (FormatIndent and FormatIndentText)) then for Counter:=1 to IdentLevel do Line:=Line+' ';
      Line:=Line+'</'+TBeRoXMLTag(Item).name+'>';
      WriteLine(Line);
     end else begin
      Line:=Line+'></'+TBeRoXMLTag(Item).name+'>';
      WriteLine(Line);
     end;
    end;
   end else begin
    for Counter:=0 to length(Item.Items)-1 do begin
     Process(Item.Items[Counter],DoIndent);
    end;
   end;
   dec(IdentLevel,IdentSize);
  end;
 end;
begin
 IdentLevel:=-(2*IdentSize);
 Stream.Clear;
 Process(Root,FormatIndent);
end;

function TBeRoXML.ReadXMLText:string;
var Stream:TBeRoMemoryStream;
begin
 Stream:=TBeRoMemoryStream.Create;
 write(Stream);
 result:=Stream.Text;
 Stream.Destroy;
end;

procedure TBeRoXML.WriteXMLText(Text:string);
var Stream:TBeRoMemoryStream;
begin
 Stream:=TBeRoMemoryStream.Create;
 Stream.Text:=Text;
 Parse(Stream);
 Stream.Destroy;
end;

initialization
 InitializeEntites;
finalization
end.
