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
unit BeRoFlexibleDataStorage;

interface

uses BeRoStream;

const MaxListSize=2147483647 div sizeof(pointer);

      bfdstNONE=$0;
      bfdstBYTE=$1;
      bfdstSHORTINT=$2;
      bfdstCHAR=$3;
      bfdstWORD=$4;
      bfdstSMALLINT=$5;
      bfdstINT=$6;
      bfdstUINT=$7;
      bfdstINT64=$8;
      bfdstUINT64=$9;
      bfdstFLOAT=$a;
      bfdstBOOL=$b;
      bfdstSTRING=$10;
      bfdstDATA=$20;
      bfdstSTORAGE=$40;
      bfdstSTREAM=$80;
      bfdstEND=bfdstSTREAM;

type TBeRoFlexibleDataStorageListSignature=packed array[1..4] of ansichar;

     TBeRoFlexibleDataStorageDataType=byte;

     TBeRoFlexibleDataStorageList=class;

     TBeRoFlexibleDataStorageValue=record
      ValueSTRING:utf8string;
      case DataType:TBeRoFlexibleDataStorageDataType of
       bfdstNONE:();
       bfdstBYTE:(ValueBYTE:byte);
       bfdstSHORTINT:(ValueSHORTINT:shortint);
       bfdstCHAR:(ValueCHAR:ansichar);
       bfdstWORD:(ValueWORD:word);
       bfdstSMALLINT:(ValueSMALLINT:smallint);
       bfdstINT:(ValueINT:longint);
       bfdstUINT:(ValueUINT:longword);
       bfdstINT64:(ValueINT64:int64);
       bfdstUINT64:(ValueUINT64:int64);
       bfdstFLOAT:(ValueFLOAT:single);
       bfdstBOOL:(ValueBOOL:boolean);
       bfdstSTRING:();
       bfdstDATA:(ValueDATA:pointer;ValueDATASize:longint);
       bfdstSTORAGE:(ValueSTORAGE:TBeRoFlexibleDataStorageList);
       bfdstSTREAM:(ValueSTREAM:TBeRoStream);
     end;

     TBeRoFlexibleDataStorageItem=class
      public
       ItemName:utf8string;
       Value:TBeRoFlexibleDataStorageValue;
       constructor Create;
       destructor Destroy; override;
     end;

     PBeRoFlexibleDataStorageArray=^TBeRoFlexibleDataStorageArray;
     TBeRoFlexibleDataStorageArray=array[0..MaxListSize-1] of TBeRoFlexibleDataStorageItem;

     TBeRoFlexibleDataStorageList=class
      private
       FList:PBeRoFlexibleDataStorageArray;
       FCount,FSize:integer;
       FSorted:boolean;
       function GetName(index:integer):utf8string;
       procedure SetName(index:integer;Value:utf8string);
       function GetItemValue(index:integer):TBeRoFlexibleDataStorageValue;
       procedure SetItemValue(index:integer;Value:TBeRoFlexibleDataStorageValue);
       function GetNameItemValue(name:utf8string):TBeRoFlexibleDataStorageValue;
       procedure SetNameItemValue(name:utf8string;Value:TBeRoFlexibleDataStorageValue);
       procedure SetSorted(ASorted:boolean);
      public
       constructor Create;
       destructor Destroy; override;
       procedure Clear;
       function Add(name:utf8string;Value:TBeRoFlexibleDataStorageValue):integer;
       procedure Insert(index:integer;name:utf8string;Value:TBeRoFlexibleDataStorageValue);
       procedure Delete(index:integer);
       function Remove(name:utf8string):integer;
       function Find(name:utf8string):integer;
       function IndexOf(name:utf8string):integer;
       procedure Exchange(Index1,Index2:integer);
       procedure SetCapacity(NewCapacity:integer);
       procedure SetCount(NewCount:integer);
       function LoadFromStream(Stream:TBeRoStream):boolean;
       function SaveToStream(Stream:TBeRoStream):boolean;
       procedure BeginUpdate;
       procedure EndUpdate;
       procedure Sort;
       property Count:integer read FCount;
       property Capacity:integer read FSize write SetCapacity;
       property Sorted:boolean read FSorted write SetSorted;
       property Names[index:integer]:utf8string read GetName write SetName; default;
       property ItemValues[index:integer]:TBeRoFlexibleDataStorageValue read GetItemValue write SetItemValue;
       property Values[Hame:utf8string]:TBeRoFlexibleDataStorageValue read GetNameItemValue write SetNameItemValue;
     end;

function BYTEToStorageValue(Value:byte):TBeRoFlexibleDataStorageValue;
function SHORTINTToStorageValue(Value:shortint):TBeRoFlexibleDataStorageValue;
function CHARToStorageValue(Value:ansichar):TBeRoFlexibleDataStorageValue;
function WORDToStorageValue(Value:word):TBeRoFlexibleDataStorageValue;
function SMALLINTToStorageValue(Value:smallint):TBeRoFlexibleDataStorageValue;
function INTToStorageValue(Value:longint):TBeRoFlexibleDataStorageValue;
function UINTToStorageValue(Value:longword):TBeRoFlexibleDataStorageValue;
function INT64ToStorageValue(Value:int64):TBeRoFlexibleDataStorageValue;
function UINT64ToStorageValue(Value:int64):TBeRoFlexibleDataStorageValue;
function FLOATToStorageValue(Value:single):TBeRoFlexibleDataStorageValue;
function BooleanToStorageValue(Value:boolean):TBeRoFlexibleDataStorageValue;
function STRINGToStorageValue(Value:utf8string):TBeRoFlexibleDataStorageValue;
function DataToStorageValue(Value:pointer;Size:integer):TBeRoFlexibleDataStorageValue;
function STORAGEToStorageValue(AItemList:TBeRoFlexibleDataStorageList):TBeRoFlexibleDataStorageValue;
function StreamToStorageValue(Value:TBeRoStream):TBeRoFlexibleDataStorageValue;

implementation

const BeRoFlexibleDataStorageListSignature:TBeRoFlexibleDataStorageListSignature='BFDS';

function BYTEToStorageValue(Value:byte):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstBYTE;
 result.ValueBYTE:=Value;
end;

function SHORTINTToStorageValue(Value:shortint):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstSHORTINT;
 result.ValueSHORTINT:=Value;
end;

function CHARToStorageValue(Value:ansichar):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstCHAR;
 result.ValueCHAR:=Value;
end;

function WORDToStorageValue(Value:word):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstWORD;
 result.ValueWORD:=Value;
end;

function SMALLINTToStorageValue(Value:smallint):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstSMALLINT;
 result.ValueSMALLINT:=Value;
end;

function INTToStorageValue(Value:longint):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstINT;
 result.ValueINT:=Value;
end;

function UINTToStorageValue(Value:longword):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstUINT;
 result.ValueUINT:=Value;
end;

function INT64ToStorageValue(Value:int64):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstINT64;
 result.ValueINT64:=Value;
end;

function UINT64ToStorageValue(Value:int64):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstUINT64;
 result.ValueUINT64:=Value;
end;

function FLOATToStorageValue(Value:single):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstFLOAT;
 result.ValueFLOAT:=Value;
end;

function BooleanToStorageValue(Value:boolean):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstBOOL;
 result.ValueBOOL:=Value;
end;

function STRINGToStorageValue(Value:utf8string):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstSTRING;
 result.ValueSTRING:=Value;
end;

function DataToStorageValue(Value:pointer;Size:integer):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstDATA;
 result.ValueDATA:=Value;
 result.ValueDATASize:=Size;
end;

function STORAGEToStorageValue(AItemList:TBeRoFlexibleDataStorageList):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstSTORAGE;
 result.ValueSTORAGE:=AItemList;
end;

function StreamToStorageValue(Value:TBeRoStream):TBeRoFlexibleDataStorageValue;
begin
 FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 result.DataType:=bfdstSTREAM;
 result.ValueSTREAM:=Value;
end;

constructor TBeRoFlexibleDataStorageItem.Create;
begin
 inherited Create;
 ItemName:='';
 FILLCHAR(Value,sizeof(TBeRoFlexibleDataStorageValue),#0);
end;

destructor TBeRoFlexibleDataStorageItem.Destroy;
begin
 ItemName:='';
 case Value.DataType of
  bfdstSTRING:Value.ValueSTRING:='';
  bfdstDATA:FREEMEM(Value.ValueDATA);
  bfdstSTORAGE:begin
   if assigned(Value.ValueSTORAGE) then begin
    TBeRoFlexibleDataStorageList(Value.ValueSTORAGE).Free;
    Value.ValueSTORAGE:=nil;
   end;
  end;
  bfdstSTREAM:if assigned(Value.ValueSTREAM) then Value.ValueSTREAM.Free;
 end;
 FILLCHAR(Value,sizeof(TBeRoFlexibleDataStorageValue),#0);
 inherited Destroy;
end;

constructor TBeRoFlexibleDataStorageList.Create;
begin
 inherited Create;
 FCount:=0;
 FSize:=0;
 FList:=nil;
 FSorted:=false;
 Clear;
end;

destructor TBeRoFlexibleDataStorageList.Destroy;
begin
 Clear;
 inherited Destroy;
end;

procedure TBeRoFlexibleDataStorageList.Clear;
var Counter:integer;
begin
 for Counter:=0 to fCount-1 do begin
  if assigned(fList [Counter]) then begin
   fList^[Counter].Free;
  end;
 end;
 FCount:=0;
 FSize:=0;
 REALLOCMEM(FList,0);
end;

procedure TBeRoFlexibleDataStorageList.SetCapacity(NewCapacity:integer);
begin
 if (NewCapacity>=0) and (NewCapacity<MaxListSize) then begin
  REALLOCMEM(FList,NewCapacity*sizeof(TBeRoFlexibleDataStorageItem));
  FSize:=NewCapacity;
 end;
end;

procedure TBeRoFlexibleDataStorageList.SetCount(NewCount:integer);
begin
 if (NewCount>=0) and (NewCount<MaxListSize) then begin
  if NewCount<FCount then begin
   FCount:=NewCount;
  end else if NewCount>FCount then begin
   if NewCount>FSize then begin
    SetCapacity(NewCount);
   end;
   if FCount<NewCount then begin
    FILLCHAR(FList^[FCount],(NewCount-FCount)*sizeof(TBeRoFlexibleDataStorageItem),0);
   end;
   FCount:=NewCount;
  end;
 end;
end;

function TBeRoFlexibleDataStorageList.Add(name:utf8string;Value:TBeRoFlexibleDataStorageValue):integer;
begin
 if FCount=FSize then begin
  if FSize>64 then begin
   inc(FSize,FSize div 4);
  end else if FSize>8 then begin
   inc(FSize,16);
  end else begin
   inc(FSize,4);
  end;
  REALLOCMEM(FList,FSize*sizeof(TBeRoFlexibleDataStorageItem));
 end;
 FList^[FCount]:=TBeRoFlexibleDataStorageItem.Create;
 FList^[FCount].ItemName:=name;
 FList^[FCount].Value:=Value;
 result:=FCount;
 inc(FCount);
end;

procedure TBeRoFlexibleDataStorageList.Insert(index:integer;name:utf8string;Value:TBeRoFlexibleDataStorageValue);
var I:integer;
begin
 if (index>=0) and (index<FCount) then begin
  SetCount(FCount+1);
  I:=FCount-1;
  while I>index do begin
   FList^[I]:=FList^[I-1];
   inc(I);
  end;
  FList^[index]:=TBeRoFlexibleDataStorageItem.Create;
  FList^[index].ItemName:=name;
  FList^[index].Value:=VAlue;
 end else if index=FCount then begin
  Add(name,Value);
 end else if index>FCount then begin
  SetCount(index);
  Add(name,Value);
 end;
end;

procedure TBeRoFlexibleDataStorageList.Delete(index:integer);
var I,J,K:integer;
begin
 if (index>=0) and (index<FCount) then begin
  if assigned(FList[index]) then FList[index].Free;
  K:=FCount-1;
  J:=index;
  I:=J;
  while I<K do begin
   FList^[I]:=FList^[I+1];
   inc(I);
  end;
  SetCount(K);
 end;
end;

function TBeRoFlexibleDataStorageList.Remove(name:utf8string):integer;
var I,J,K:integer;
begin
 result:=-1;
 K:=FCount;
 J:=-1;
 I:=0;
 while I<K do begin
  if assigned(FList^[I]) and (FList^[I].ItemName=name) then begin
   J:=I;
   break;
  end;
  inc(I);
 end;
 if J>=0 then begin
  if assigned(FList[J]) then FList[J].Free;
  dec(K);
  I:=J;
  while I<K do begin
   FList^[I]:=FList^[I+1];
   inc(I);
  end;
  SetCount(K);
  result:=J;
 end;
end;

function TBeRoFlexibleDataStorageList.Find(name:utf8string):integer;
var I:integer;
begin
 result:=-1;
 I:=0;
 while I<FCount do begin
  if assigned(FList^[I]) and (FList^[I].ItemName=name) then begin
   result:=I;
   exit;
  end;
  inc(I);
 end;
end;

function TBeRoFlexibleDataStorageList.IndexOf(name:utf8string):integer;
var I:integer;
begin
 result:=-1;
 I:=0;
 while I<FCount do begin
  if assigned(FList^[I]) and (FList^[I].ItemName=name) then begin
   result:=I;
   exit;
  end;
  inc(I);
 end;
end;

procedure TBeRoFlexibleDataStorageList.Exchange(Index1,Index2:integer);
var TempPointer:TBeRoFlexibleDataStorageItem;
begin
 if (Index1>=0) and (Index1<FCount) and (Index2>=0) and (Index2<FCount) then begin
  TempPointer:=FList^[Index1];
  FList^[Index1]:=FList^[Index2];
  FList^[Index2]:=TempPointer;
 end;
end;

function TBeRoFlexibleDataStorageList.GetName(index:integer):utf8string;
begin
 if (index>=0) and (index<FCount) then begin
  result:=FList^[index].ItemName;
 end else begin
  result:='';
 end;
end;

procedure TBeRoFlexibleDataStorageList.SetName(index:integer;Value:utf8string);
begin
 if (index>=0) and (index<FCount) then FList^[index].ItemName:=Value;
end;

function TBeRoFlexibleDataStorageList.GetItemValue(index:integer):TBeRoFlexibleDataStorageValue;
begin
 if (index>=0) and (index<FCount) then begin
  result:=FList^[index].Value;
 end else begin
  FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 end;
end;

procedure TBeRoFlexibleDataStorageList.SetItemValue(index:integer;Value:TBeRoFlexibleDataStorageValue);
begin
 if (index>=0) and (index<FCount) then FList^[index].Value:=Value;
end;

function TBeRoFlexibleDataStorageList.GetNameItemValue(name:utf8string):TBeRoFlexibleDataStorageValue;
var index:integer;
begin
 index:=IndexOf(name);
 if (index>=0) and (index<FCount) then begin
  result:=FList^[index].Value;
 end else begin
  FILLCHAR(result,sizeof(TBeRoFlexibleDataStorageValue),#0);
 end;
end;

procedure TBeRoFlexibleDataStorageList.SetNameItemValue(name:utf8string;Value:TBeRoFlexibleDataStorageValue);
var index:integer;
begin
 index:=IndexOf(name);
 if (index>=0) and (index<FCount) then begin
  FList^[index].Value:=Value;
 end else begin
  Add(name,Value);
 end;
end;

procedure TBeRoFlexibleDataStorageList.SetSorted(ASorted:boolean);
begin
 FSorted:=ASorted;
 if FSorted then Sort;
end;

function TBeRoFlexibleDataStorageList.LoadFromStream(Stream:TBeRoStream):boolean;
var B8:byte;
    I32,Size,NextOfs:longint;
    S:utf8string;
    AStream:TBeRoStream;
    ItemListSignature:TBeRoFlexibleDataStorageListSignature;
    ItemName:utf8string;
    Value:TBeRoFlexibleDataStorageValue;
begin
 result:=false;
 try
  Clear;
  Stream.Seek(0,bsoFromBeginning);
  if Stream.read(ItemListSignature,sizeof(TBeRoFlexibleDataStorageListSignature))=sizeof(TBeRoFlexibleDataStorageListSignature) then begin
   if ItemListSignature<>BeRoFlexibleDataStorageListSignature then exit;
   while Stream.Position<Stream.Size do begin
    FILLCHAR(Value,sizeof(TBeRoFlexibleDataStorageValue),#0);

    if Stream.read(I32,sizeof(longint))<>sizeof(longint) then exit;
    setlength(S,I32);
    if I32>0 then if Stream.read(S[1],I32)<>I32 then exit;
    ItemName:=S;

    if Stream.read(B8,sizeof(byte))<>sizeof(byte) then exit;
    Value.DataType:=B8;

    case Value.DataType of
     bfdstBYTE:Size:=sizeof(byte);
     bfdstSHORTINT:Size:=sizeof(shortint);
     bfdstCHAR:Size:=sizeof(ansichar);
     bfdstWORD:Size:=sizeof(word);
     bfdstSMALLINT:Size:=sizeof(smallint);
     bfdstINT:Size:=sizeof(longint);
     bfdstUINT:Size:=sizeof(longword);
     bfdstINT64:Size:=sizeof(int64);
     bfdstUINT64:Size:=sizeof(int64);
     bfdstFLOAT:Size:=sizeof(single);
     bfdstBOOL:Size:=sizeof(boolean);
     bfdstSTRING,bfdstDATA,bfdstSTORAGE,bfdstSTREAM:begin
      if Stream.read(Size,sizeof(longint))<>sizeof(longint) then exit;
     end;
     else Size:=0;
    end;
    NextOfs:=Stream.Position+Size;

    case Value.DataType of
     bfdstBYTE:begin
      if Stream.read(Value.ValueBYTE,sizeof(byte))<>sizeof(byte) then exit;
     end;
     bfdstSHORTINT:begin
      if Stream.read(Value.ValueSHORTINT,sizeof(shortint))<>sizeof(shortint) then exit;
     end;
     bfdstCHAR:begin
      if Stream.read(Value.ValueCHAR,sizeof(ansichar))<>sizeof(ansichar) then exit;
     end;
     bfdstWORD:begin
      if Stream.read(Value.ValueWORD,sizeof(word))<>sizeof(word) then exit;
     end;
     bfdstSMALLINT:begin
      if Stream.read(Value.ValueSMALLINT,sizeof(smallint))<>sizeof(smallint) then exit;
     end;
     bfdstINT:begin
      if Stream.read(Value.ValueINT,sizeof(longint))<>sizeof(longint) then exit;
     end;
     bfdstUINT:begin
      if Stream.read(Value.ValueUINT,sizeof(longword))<>sizeof(longword) then exit;
     end;
     bfdstINT64:begin
      if Stream.read(Value.ValueINT64,sizeof(int64))<>sizeof(int64) then exit;
     end;
     bfdstUINT64:begin
      if Stream.read(Value.ValueUINT64,sizeof(int64))<>sizeof(int64) then exit;
     end;
     bfdstFLOAT:begin
      if Stream.read(Value.ValueFLOAT,sizeof(single))<>sizeof(single) then exit;
     end;
     bfdstBOOL:begin
      if Stream.read(Value.ValueBOOL,sizeof(boolean))<>sizeof(boolean) then exit;
     end;
     bfdstSTRING:begin
      setlength(S,Size);
      if Size>0 then if Stream.read(S[1],Size)<>Size then exit;
      Value.ValueSTRING:=S;
     end;
     bfdstDATA:begin
      Value.ValueDATASize:=Size;
      GETMEM(Value.ValueDATA,Value.ValueDATASize);
      if Stream.read(Value.ValueDATA^,Value.ValueDATASize)<>Value.ValueDATASize then exit;
     end;
     bfdstSTORAGE:begin
      Value.ValueSTORAGE:=TBeRoFlexibleDataStorageList.Create;
      AStream:=TBeRoStream.Create;
      AStream.AppendFrom(Stream,Size);
      if Size>0 then begin
       if not TBeRoFlexibleDataStorageList(Value.ValueSTORAGE).LoadFromStream(AStream) then begin
        AStream.Free;
        exit;
       end;
      end;
      AStream.Free;
     end;
     bfdstSTREAM:begin
      Value.ValueSTREAM:=TBeRoStream.Create;
      if Size>0 then Value.ValueSTREAM.AppendFrom(Stream,Size);
     end;
    end;

    Stream.Seek(NextOfs,bsoFromBeginning);
    Add(ItemName,Value);
   end;
   result:=true;
  end;
 except
 end;
end;

function TBeRoFlexibleDataStorageList.SaveToStream(Stream:TBeRoStream):boolean;
var index:integer;
    AItem:TBeRoFlexibleDataStorageItem;
    B8:byte;
    I32:longint;
    S:utf8string;
    AStream:TBeRoStream;
begin
 result:=false;
 try
  if Stream.write(BeRoFlexibleDataStorageListSignature,sizeof(TBeRoFlexibleDataStorageListSignature))=sizeof(TBeRoFlexibleDataStorageListSignature) then begin
   for index:=0 to FCount-1 do begin
    AItem:=FList^[index];
    if assigned(AItem) then begin
     S:=AItem.ItemName;
     I32:=length(S);
   //IF Stream.Write(I32,SIZEOF(LONGINT))<>SIZEOF(LONGINT) THEN EXIT;
     if I32>0 then if Stream.write(S[1],I32)<>I32 then exit;

     B8:=AItem.Value.DataType;
     if Stream.write(B8,sizeof(byte))<>sizeof(byte) then exit;

     case AItem.Value.DataType of
      bfdstBYTE:begin
       if Stream.write(AItem.Value.ValueBYTE,sizeof(byte))<>sizeof(byte) then exit;
      end;
      bfdstSHORTINT:begin
       if Stream.write(AItem.Value.ValueSHORTINT,sizeof(shortint))<>sizeof(shortint) then exit;
      end;
      bfdstCHAR:begin
       if Stream.write(AItem.Value.ValueCHAR,sizeof(ansichar))<>sizeof(ansichar) then exit;
      end;
      bfdstWORD:begin
       if Stream.write(AItem.Value.ValueWORD,sizeof(word))<>sizeof(word) then exit;
      end;
      bfdstSMALLINT:begin
       if Stream.write(AItem.Value.ValueSMALLINT,sizeof(smallint))<>sizeof(smallint) then exit;
      end;
      bfdstINT:begin
       if Stream.write(AItem.Value.ValueINT,sizeof(longint))<>sizeof(longint) then exit;
      end;
      bfdstUINT:begin
       if Stream.write(AItem.Value.ValueUINT,sizeof(longword))<>sizeof(longword) then exit;
      end;
      bfdstINT64:begin
       if Stream.write(AItem.Value.ValueINT64,sizeof(int64))<>sizeof(int64) then exit;
      end;
      bfdstUINT64:begin
       if Stream.write(AItem.Value.ValueUINT64,sizeof(int64))<>sizeof(int64) then exit;
      end;
      bfdstFLOAT:begin
       if Stream.write(AItem.Value.ValueFLOAT,sizeof(single))<>sizeof(single) then exit;
      end;
      bfdstBOOL:begin
       if Stream.write(AItem.Value.ValueBOOL,sizeof(boolean))<>sizeof(boolean) then exit;
      end;
      bfdstSTRING:begin
       S:=AItem.Value.ValueSTRING;
       I32:=length(S);
       if Stream.write(I32,sizeof(longint))<>sizeof(longint) then exit;
       if I32>0 then if Stream.write(S[1],I32)<>I32 then exit;
      end;
      bfdstDATA:begin
       if Stream.write(AItem.Value.ValueDATASize,sizeof(longint))<>sizeof(longint) then exit;
       if AItem.Value.ValueDATASize>0 then begin
        if assigned(AItem.Value.ValueDATA) then begin
         if Stream.write(AItem.Value.ValueDATA^,AItem.Value.ValueDATASize)<>AItem.Value.ValueDATASize then exit;
        end else begin
         exit;
        end;
       end;
      end;
      bfdstSTORAGE:begin
       if assigned(AItem.Value.ValueSTORAGE) then begin
        AStream:=TBeRoStream.Create;
        TBeRoFlexibleDataStorageList(AItem.Value.ValueSTORAGE).SaveToStream(AStream);
        I32:=AStream.Size;
        if Stream.write(I32,sizeof(longint))<>sizeof(longint) then exit;
        if I32>0 then begin
         AStream.Seek(0,bsoFromBeginning);
         Stream.AppendFrom(AStream,AStream.Size);
        end;
        AStream.Free;
       end else begin
        I32:=0;
        if Stream.write(I32,sizeof(longint))<>sizeof(longint) then exit;
       end;
      end;
      bfdstSTREAM:begin
       if assigned(AItem.Value.ValueSTREAM) then begin
        I32:=AItem.Value.ValueSTREAM.Size;
        if Stream.write(I32,sizeof(longint))<>sizeof(longint) then exit;
        if I32>0 then begin
         AItem.Value.ValueSTREAM.Seek(0,bsoFromBeginning);
         Stream.AppendFrom(AItem.Value.ValueSTREAM,AItem.Value.ValueSTREAM.Size);
        end;
       end else begin
       end;
      end;
     end;
    end;
   end;
  end;
  result:=true;
 except
 end;
end;

procedure TBeRoFlexibleDataStorageList.BeginUpdate;
begin
end;

procedure TBeRoFlexibleDataStorageList.EndUpdate;
begin
end;

procedure TBeRoFlexibleDataStorageList.Sort;
var Counter:integer;
begin
 Counter:=0;
 while Counter<fCount-1 do begin
  if assigned(fList[Counter]) and assigned(fList[Counter+1]) then begin
   if fList^[Counter+1].ItemName<fList^[Counter].ItemName then begin
    Exchange(Counter,Counter+1);
    Counter:=-1;
   end;
  end;
  inc(Counter);
 end;
end;

end.
