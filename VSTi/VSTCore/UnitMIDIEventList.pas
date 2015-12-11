(* Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * Licensed under the terms of the LGPL V3 or later, see LGPLv3.txt or
 * http://www.gnu.org/licenses/lgpl.html for details
 *)
unit UnitMIDIEventList;
{$IFDEF FPC}
 {$MODE DELPHI}
 {$WARNINGS OFF}
 {$HINTS OFF}
 {$OVERFLOWCHECKS OFF}
 {$RANGECHECKS OFF}
 {$IFDEF CPUI386}
  {$ASMMODE INTEL}
 {$ENDIF}
{$ENDIF}

interface

uses UnitMIDIEvent;

const MaxListSize=2147483647 div sizeof(TMIDIEvent);

type PMIDIEvents=^TMIDIEvents;
     TMIDIEvents=array[0..MaxListSize-1] of TMIDIEvent;

     TMIDIEventList=class
      private
       FList:PMIDIEvents;
       FCount,FSize:integer;
       function GetItem(index:integer):TMIDIEvent;
       procedure SetItem(index:integer;Value:TMIDIEvent);
       function GetItemPointer(index:integer):TMIDIEvent;
      public
       constructor Create;
       destructor Destroy; override;
       procedure Clear;
       function Add(Item:TMIDIEvent):integer;
       function NewClass:TMIDIEvent;
       function AddEvent(MIDIMessage,Data1,Data2:byte;DeltaFrames:integer):TMIDIEvent;
       procedure Insert(index:integer;Item:TMIDIEvent);
       procedure Delete(index:integer);
       function Remove(Item:TMIDIEvent):integer;
       function RemoveClass(Item:TMIDIEvent):integer;
       function Find(Item:TMIDIEvent):integer;
       function IndexOf(Item:TMIDIEvent):integer;
       procedure Exchange(Index1,Index2:integer);
       procedure SetCapacity(NewCapacity:integer);
       procedure SetCount(NewCount:integer);
       procedure Sort;
       procedure SortPerID;
       property Count:integer read FCount;
       property Capacity:integer read FSize write SetCapacity;
       property Item[index:integer]:TMIDIEvent read GetItem write SetItem; default;
       property Items[index:integer]:TMIDIEvent read GetItem write SetItem;
       property PItems[index:integer]:TMIDIEvent read GetItemPointer;
     end;

implementation                          

function IntLog2(x:longword):longword; {$ifdef cpu386}register;
asm
 test eax,eax
 jz @Done
 bsr eax,eax
 @Done:
end;
{$else}
begin
 x:=x or (x shr 1);
 x:=x or (x shr 2);
 x:=x or (x shr 4);
 x:=x or (x shr 8);
 x:=x or (x shr 16);
 x:=x shr 1;
 x:=x-((x shr 1) and $55555555);
 x:=((x shr 2) and $33333333)+(x and $33333333);
 x:=((x shr 4)+x) and $0f0f0f0f;
 x:=x+(x shr 8);
 x:=x+(x shr 16);
 result:=x and $3f;
end;
{$endif}

constructor TMIDIEventList.Create;
begin
 inherited Create;
 FCount:=0;
 FSize:=0;
 FList:=nil;
 Clear;
end;

destructor TMIDIEventList.Destroy;
begin
 Clear;
 inherited Destroy;
end;

procedure TMIDIEventList.Clear;
var Counter:integer;
begin
 try
  for Counter:=0 to FCount-1 do begin
   if assigned(FList^[Counter]) then begin
    try
     FList^[Counter].Destroy;
    except
    end;
    FList^[Counter]:=nil;
   end;
  end;
 except
 end;
 FCount:=0;
 FSize:=0;
 REALLOCMEM(FList,0);
end;

procedure TMIDIEventList.SetCapacity(NewCapacity:integer);
begin
 if (NewCapacity>=0) and (NewCapacity<MaxListSize) then begin
  REALLOCMEM(FList,NewCapacity*sizeof(TMIDIEvent));
  FSize:=NewCapacity;
 end;
end;

procedure TMIDIEventList.SetCount(NewCount:integer);
begin
 if (NewCount>=0) and (NewCount<MaxListSize) then begin
  if NewCount<FCount then begin
   FCount:=NewCount;
  end else if NewCount>FCount then begin
   if NewCount>FSize then begin
    SetCapacity(NewCount);
   end;
   if FCount<NewCount then begin
    FILLCHAR(FList^[FCount],(NewCount-FCount)*sizeof(TMIDIEvent),0);
   end;
   FCount:=NewCount;
  end;
 end;
end;

function TMIDIEventList.Add(Item:TMIDIEvent):integer;
begin
 if FCount=FSize then begin
  if FSize>64 then begin
   inc(FSize,FSize div 4);
  end else if FSize>8 then begin
   inc(FSize,16);
  end else begin
   inc(FSize,4);
  end;
  REALLOCMEM(FList,FSize*sizeof(TMIDIEvent));
 end;
 FList^[FCount]:=Item;
 result:=FCount;
 inc(FCount);
end;

function TMIDIEventList.NewClass:TMIDIEvent;
var Item:TMIDIEvent;
begin
 Item:=TMIDIEvent.Create;
 Add(Item);
 result:=Item;
end;

function TMIDIEventList.AddEvent(MIDIMessage,Data1,Data2:byte;DeltaFrames:integer):TMIDIEvent;
var Item:TMIDIEvent;
begin
 Item:=TMIDIEvent.Create;
 Item.DeltaFrames:=DeltaFrames;
 Item.MIDIData[0]:=MIDIMessage;
 Item.MIDIData[1]:=Data1;
 Item.MIDIData[2]:=Data2;
 Add(Item);
 result:=Item;
end;

procedure TMIDIEventList.Insert(index:integer;Item:TMIDIEvent);
var I:integer;
begin
 if (index>=0) and (index<FCount) then begin
  SetCount(FCount+1);
  for I:=FCount-1 downto index do FList^[I+1]:=FList^[I];
  FList^[index]:=Item;
 end else if index=FCount then begin
  Add(Item);
 end else if index>FCount then begin
  SetCount(index);
  Add(Item);
 end;
end;

procedure TMIDIEventList.Delete(index:integer);
var I,J,K:integer;
begin
 if (index>=0) and (index<FCount) then begin
  K:=FCount-1;
  J:=index;
  for I:=J to K-1 do FList^[I]:=FList^[I+1];
  SetCount(K);
 end;
end;

function TMIDIEventList.Remove(Item:TMIDIEvent):integer;
var I,J,K:integer;
begin
 result:=-1;
 K:=FCount;
 J:=-1;
 for I:=0 to K-1 do begin
  if FList^[I]=Item then begin
   J:=I;
   break;
  end;
 end;
 if J>=0 then begin
  dec(K);
  for I:=J to K-1 do FList^[I]:=FList^[I+1];
  SetCount(K);
  result:=J;
 end;
end;

function TMIDIEventList.RemoveClass(Item:TMIDIEvent):integer;
var I,J,K:integer;
begin
 result:=-1;
 K:=FCount;
 J:=-1;
 for I:=0 to K-1 do begin
  if FList^[I]=Item then begin
   J:=I;
   break;
  end;
 end;
 if J>=0 then begin
  dec(K);
  for I:=J to K-1 do FList^[I]:=FList^[I+1];
  SetCount(K);
  if assigned(Item) then Item.Free;
  result:=J;
 end;
end;

function TMIDIEventList.Find(Item:TMIDIEvent):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to FCount-1 do begin
  if FList^[I]=Item then begin
   result:=I;
   exit;
  end;
 end;
end;

function TMIDIEventList.IndexOf(Item:TMIDIEvent):integer;
var I:integer;
begin
 result:=-1;
 for I:=0 to FCount-1 do begin
  if FList^[I]=Item then begin
   result:=I;
   exit;
  end;
 end;
end;

procedure TMIDIEventList.Exchange(Index1,Index2:integer);
var TempPointer:TMIDIEvent;
begin
 if (Index1>=0) and (Index1<FCount) and (Index2>=0) and (Index2<FCount) then begin
  TempPointer:=FList^[Index1];
  FList^[Index1]:=FList^[Index2];
  FList^[Index2]:=TempPointer;
 end;
end;

function TMIDIEventList.GetItem(index:integer):TMIDIEvent;
begin
 FILLCHAR(result,sizeof(TMIDIEvent),#0);
 if (index>=0) and (index<FCount) then result:=FList^[index];
end;

procedure TMIDIEventList.SetItem(index:integer;Value:TMIDIEvent);
begin
 if (index>=0) and (index<FCount) then FList^[index]:=Value;
end;

function TMIDIEventList.GetItemPointer(index:integer):TMIDIEvent;
begin
 result:=nil;
 if (index>=0) and (index<FCount) then result:=FList^[index];
end;

procedure TMIDIEventList.Sort;
 function CompareItems(I,J:TMIDIEvent):integer;
 begin
  if assigned(I) and assigned(J) then begin
   if I.DeltaFrames<J.DeltaFrames then begin
    result:=-1;
   end else if I.DeltaFrames>J.DeltaFrames then begin
    result:=1;
   end else begin
    result:=0;
   end;
  end else begin
   result:=0;
  end;
 end;
 procedure ProcessQuickSort(Left,Right:integer);
 var I,J:integer;
     X:TMIDIEvent;
 begin
  I:=Left;
  J:=Right;
  X:=FList^[(Left+Right) div 2];
  while I<=J do begin
   while CompareItems(FList^[I],X)<0 do inc(I);
   while CompareItems(FList^[J],X)>0 do dec(J);
   if I<=J then begin
    Exchange(I,J);
    inc(I);
    dec(J);
   end;
  end;
  if Left<J then ProcessQuickSort(Left,J);
  if Right>I then ProcessQuickSort(I,Right);
 end;
 procedure ProcessBeRoSort;
 var I,J,K,L:integer;
     X:TMIDIEvent;
 begin
  I:=0;
  J:=FCount-1;
  while I<J do begin
   if CompareItems(FList^[I],FList^[I+1])>1 then begin
    X:=FList[I+1];
    K:=I;
    for L:=I downto 0 do if CompareItems(X,FList[L])<0 then K:=L;
    for L:=I downto K do FList[L+1]:=FList[L];
    FList[K]:=X;
   end;
   inc(I);
  end;
 end;
 procedure ProcessBeRoSimpleSort;
 var I,J:integer;
     X:TMIDIEvent;
 begin
  I:=0;
  J:=FCount-1;
  while I<J do begin
   if CompareItems(FList^[I],FList^[I+1])>1 then begin
    X:=FList[I+1];
    FList[I+1]:=FList[I];
    FList[I]:=X;
    if I>0 then begin
     dec(I);
    end else begin
     inc(I);
    end;
   end else begin
    inc(I);
   end;
  end;
 end;
begin
 if FCount>0 then begin
  ProcessQuickSort(0,FCount-1);
  ProcessBeRoSimpleSort;
 end;
end;

procedure TMIDIEventList.SortPerID;
 function CompareItems(I,J:TMIDIEvent):integer;
 begin
  if assigned(I) and assigned(J) then begin
   if I.ID<J.ID then begin
    result:=-1;
   end else if I.ID>J.ID then begin
    result:=1;
   end else begin
    result:=0;
   end;
  end else begin
   result:=0;
  end;
 end;
 procedure ProcessSort(Left,Right:integer;Depth:longword);
  procedure SiftDown(Current,MaxIndex:integer);
  var SiftLeft,SiftRight,Largest:integer;
      t:TMIDIEvent;
  begin
   SiftLeft:=Left+(2*(Current-Left))+1;
   SiftRight:=Left+(2*(Current-Left))+2;
   Largest:=Current;
   if (SiftLeft<=MaxIndex) and (CompareItems(FList^[SiftLeft],FList^[Largest])>0) then begin
    Largest:=SiftLeft;
   end;
   if (SiftRight<=MaxIndex) and (CompareItems(FList^[SiftRight],FList^[Largest])>0) then begin
    Largest:=SiftRight;
   end;
   if Largest<>Current then begin
    t:=FList^[Current];
    FList^[Current]:=FList^[Largest];
    FList^[Largest]:=t;
    SiftDown(Largest,MaxIndex);
   end;
  end;
 var Middle,i,j:integer;
     x,t:TMIDIEvent;
 begin
  if Left>Right then begin
   exit;
  end;
  if (Right-Left)<16 then begin
   // Insertion sort
   for i:=Left+1 to Right do begin
    t:=FList^[i];
    j:=i-1;
    while (j>=Left) and (CompareItems(t,FList^[j])<0) do begin
     FList^[j+1]:=FList^[j];
     dec(j);
    end;
    FList^[j+1]:=t;
   end;
  end else if Depth=0 then begin
   // Heap sort
   for i:=((Left+Right+1) div 2)-1 downto Left do begin
    SiftDown(i,Right);
   end;
   for i:=Right downto Left+1 do begin
    t:=FList^[i];
    FList^[i]:=FList^[Left];
    FList^[Left]:=t;
    SiftDown(Left,i-1);
   end;
  end else begin
   // Quick sort with median of three
   Middle:=(Left+Right) div 2;
   if CompareItems(FList^[Left],FList^[Middle])>0 then begin
    t:=FList^[Left];
    FList^[Left]:=FList^[Middle];
    FList^[Middle]:=t;
   end;
   if CompareItems(FList^[Left],FList^[Right])>0 then begin
    t:=FList^[Left];
    FList^[Left]:=FList^[Right];
    FList^[Right]:=t;
   end;
   if CompareItems(FList^[Middle],FList^[Right])>0 then begin
    t:=FList^[Middle];
    FList^[Middle]:=FList^[Right];
    FList^[Right]:=t;
   end;
   t:=FList^[Middle];
   FList^[Middle]:=FList^[Right-1];
   FList^[Right-1]:=t;
   x:=t;
   i:=Left;                           
   j:=Right-1;
   while true do begin
    repeat
     inc(i);
    until not ((i<Right) and (CompareItems(FList^[i],x)<0));
    repeat
     dec(j);
    until not ((j>Left) and (CompareItems(FList^[j],x)>0));
    if i>=j then begin
     break;
    end else begin
     t:=FList^[i];
     FList^[i]:=FList^[j];
     FList^[j]:=t;
    end;
   end;
   t:=FList^[i];
   FList^[i]:=FList^[Right-1];
   FList^[Right-1]:=t;
   ProcessSort(Left,i-1,Depth-1);
   ProcessSort(i+1,Right,Depth-1);
  end;
 end;
 procedure ProcessBeRoSort;
 var I,J,K,L:integer;
     X:TMIDIEvent;
 begin
  I:=0;
  J:=FCount-1;
  while I<J do begin
   if CompareItems(FList^[I],FList^[I+1])>1 then begin
    X:=FList[I+1];
    K:=I;
    for L:=I downto 0 do if CompareItems(X,FList[L])<0 then K:=L;
    for L:=I downto K do FList[L+1]:=FList[L];
    FList[K]:=X;
   end;
   inc(I);
  end;
 end;
 procedure ProcessBeRoSimpleSort;
 var I,J:integer;
     X:TMIDIEvent;
 begin
  I:=0;
  J:=FCount-1;
  while I<J do begin
   if CompareItems(FList^[I],FList^[I+1])>1 then begin
    X:=FList[I+1];
    FList[I+1]:=FList[I];
    FList[I]:=X;
    if I>0 then begin
     dec(I);
    end else begin
     inc(I);
    end;
   end else begin
    inc(I);
   end;
  end;
 end;
begin
 if FCount>0 then begin
  //ProcessQuickSort(0,FCount-1);
  ProcessSort(0,FCount-1,IntLog2(FCount)*2);
  ProcessBeRoSimpleSort;
 end;
end;

end.


