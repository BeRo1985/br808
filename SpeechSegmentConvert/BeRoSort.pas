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
unit BeRoSort;

interface

type TSortCompareFunction=function(const A,B:pointer):integer;

procedure QuickSort(DataBase:pointer;Count,ItemSize:integer;CompareFunction:TSortCompareFunction);

implementation

type pbyte=^byte;

procedure QuickSort(DataBase:pointer;Count,ItemSize:integer;CompareFunction:TSortCompareFunction);
var TempItem:pointer;
 function GetItemPointer(index:integer):pointer;
 var APointer:pbyte;
 begin
  APointer:=DataBase;
  inc(APointer,index*ItemSize);
  result:=APointer;
 end;
 procedure SwapItems(Item,WithItem:pointer);
 begin
  MOVE(Item^,TempItem^,ItemSize);
  MOVE(WithItem^,Item^,ItemSize);
  MOVE(TempItem^,WithItem^,ItemSize);
 end;
 procedure ProcessQuickSort(Left,Right:integer);
 var I,J:integer;
     X:pointer;
 begin
  I:=Left;
  J:=Right;
  X:=GetItemPointer((Left+Right) div 2);
  while I<=J do begin
   while CompareFunction(GetItemPointer(I),X)<0 do inc(I);
   while CompareFunction(GetItemPointer(j),X)>0 do dec(J);
   if I<=J then begin
    SwapItems(GetItemPointer(I),GetItemPointer(J));
    inc(I);
    dec(J);
   end;
  end;
  if Left<J then ProcessQuickSort(Left,J);
  if Right>I then ProcessQuickSort(I,Right);
 end;
begin
 if assigned(DataBase) and (Count>0) and (ItemSize>0) and assigned(CompareFunction) then begin
  GETMEM(TempItem,ItemSize);
  ProcessQuickSort(0,Count-1);
  FREEMEM(TempItem);
 end;
end;

end.
