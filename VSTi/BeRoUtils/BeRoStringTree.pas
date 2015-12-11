(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2003-2004, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit BeRoStringTree;
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

const MaxStringHashes=32;

type TBeRoStringTreeLink=longword;

     PBeRoStringTreeNode=^TBeRoStringTreeNode;
     TBeRoStringTreeNode=record
      TheChar:char;
      Link:TBeRoStringTreeLink;
      LinkExist:boolean;
      Prevoius,Next,Up,Down:PBeRoStringTreeNode;
     end;

     TBeRoStringHashes=array[0..MaxStringHashes-1] of longword;
     TBeRoStringHashNodes=array[0..MaxStringHashes-1] of PBeRoStringTreeNode;

     TBeRoStringTree=class
      private
       Root:PBeRoStringTreeNode;
       Hashes:TBeRoStringHashes;
       HashNodes:TBeRoStringHashNodes;
      public
       Hashing:boolean;
       constructor Create;
       destructor Destroy; override;
       procedure Clear;
       procedure Dump;
       function Add(Content:string;Link:TBeRoStringTreeLink;Replace:boolean=false):boolean;
       function Delete(Content:string):boolean;
       function Find(Content:string;var Link:TBeRoStringTreeLink):boolean;
     end;

implementation

function HashString(S:string):longword;
var Counter,StringLength:integer;
begin
 result:=0;
 StringLength:=length(S);
 for Counter:=1 to StringLength do begin
{$IFDEF CPU386}
  asm
   ROR dword PTR result,13
  end;
  inc(result,byte(S[Counter]));
{$ELSE}
  result:=((result shr 13) or (result shl (32-13)))+byte(S[Counter]);
{$ENDIF}
 end;
end;

function CreateStringTreeNode(AChar:char):PBeRoStringTreeNode;
begin
 GETMEM(result,sizeof(TBeRoStringTreeNode));
 result^.TheChar:=AChar;
 result^.Link:=0;
 result^.LinkExist:=false;
 result^.Prevoius:=nil;
 result^.Next:=nil;
 result^.Up:=nil;
 result^.Down:=nil;
end;

procedure DestroyStringTreeNode(Node:PBeRoStringTreeNode);
begin
 if assigned(Node) then begin
  DestroyStringTreeNode(Node^.Next);
  DestroyStringTreeNode(Node^.Down);
  FREEMEM(Node);
 end;
end;

constructor TBeRoStringTree.Create;
begin
 inherited Create;
 Root:=nil;
 FILLCHAR(Hashes,sizeof(TBeRoStringHashes),#0);
 FILLCHAR(HashNodes,sizeof(TBeRoStringHashNodes),#0);
end;

destructor TBeRoStringTree.Destroy;
begin
 DestroyStringTreeNode(Root);
 inherited Destroy;
end;

procedure TBeRoStringTree.Clear;
begin
 DestroyStringTreeNode(Root);
 Root:=nil;
end;

procedure TBeRoStringTree.Dump;
var Ident:integer;
 procedure DumpNode(Node:PBeRoStringTreeNode);
 var SubNode:PBeRoStringTreeNode;
     IdentCounter,IdentOld:integer;
 begin
  for IdentCounter:=1 to Ident do write(' ');
  write(Node^.TheChar);
  IdentOld:=Ident;
  SubNode:=Node^.Next;
  while assigned(SubNode) do begin
   write(SubNode.TheChar);
   if not assigned(SubNode^.Next) then break;
   inc(Ident);
   SubNode:=SubNode^.Next;
  end;
  WRITELN;
  inc(Ident);
  while assigned(SubNode) and (SubNode<>Node) do begin
   if assigned(SubNode^.Down) then DumpNode(SubNode^.Down);
   SubNode:=SubNode^.Prevoius;
   dec(Ident);
  end;
  Ident:=IdentOld;
  if assigned(Node^.Down) then DumpNode(Node^.Down);
 end;
begin
 Ident:=0;
 DumpNode(Root);
end;

function TBeRoStringTree.Add(Content:string;Link:TBeRoStringTreeLink;Replace:boolean=false):boolean;
var StringLength,Position,PositionCounter:integer;
    NewNode,LastNode,Node:PBeRoStringTreeNode;
    StringChar,NodeChar:char;
    Hash,HashToCompare,HashCounter:longword;
begin
 result:=false;
 Hash:=0;
 StringLength:=length(Content);
 if StringLength>0 then begin
  if Hashing then begin
   Hash:=HashString(Content);
   for HashCounter:=0 to MaxStringHashes-1 do begin
    HashToCompare:=Hashes[HashCounter];
    if HashToCompare<>0 then begin
     if HashToCompare=Hash then begin
      if assigned(HashNodes[HashCounter]) then begin
       LastNode:=HashNodes[HashCounter];
       if Replace or not LastNode^.LinkExist then begin
        LastNode^.Link:=Link;
        result:=true;
       end;
       exit;
      end;
     end;
    end else begin
     break;
    end;
   end;
  end;
  LastNode:=nil;
  Node:=Root;
  for Position:=1 to StringLength do begin
   StringChar:=Content[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    if NodeChar=StringChar then begin
     LastNode:=Node;
     Node:=Node^.Next;
   end else begin
     while (NodeChar<StringChar) and assigned(Node^.Down) do begin
      Node:=Node^.Down;
      NodeChar:=Node^.TheChar;
     end;
     if NodeChar=StringChar then begin
      LastNode:=Node;
      Node:=Node^.Next;
     end else begin
      NewNode:=CreateStringTreeNode(StringChar);
      if NodeChar<StringChar then begin
       NewNode^.Down:=Node^.Down;
       NewNode^.Up:=Node;
       if assigned(NewNode^.Down) then begin
        NewNode^.Down^.Up:=NewNode;
       end;
       NewNode^.Prevoius:=Node^.Prevoius;
       Node^.Down:=NewNode;
      end else if NodeChar>StringChar then begin
       NewNode^.Down:=Node;
       NewNode^.Up:=Node^.Up;
       if assigned(NewNode^.Up) then begin
        NewNode^.Up^.Down:=NewNode;
       end;
       NewNode^.Prevoius:=Node^.Prevoius;
       if not assigned(NewNode^.Up) then begin
        if assigned(NewNode^.Prevoius) then begin
         NewNode^.Prevoius^.Next:=NewNode;
        end else begin
         Root:=NewNode;
        end;
       end;
       Node^.Up:=NewNode;
      end;
      LastNode:=NewNode;
      Node:=LastNode^.Next;
     end;
    end;
   end else begin
    for PositionCounter:=Position to StringLength do begin
     NewNode:=CreateStringTreeNode(Content[PositionCounter]);
     if assigned(LastNode) then begin
      NewNode^.Prevoius:=LastNode;
      LastNode^.Next:=NewNode;
      LastNode:=LastNode^.Next;
     end else begin
      if not assigned(Root) then begin
       Root:=NewNode;
       LastNode:=Root;
      end;
     end;
    end;
    break;
   end;
  end;
  if assigned(LastNode) then begin
   if Replace or not LastNode^.LinkExist then begin
    if Hashing then begin
     for HashCounter:=0 to MaxStringHashes-2 do begin
      Hashes[HashCounter+1]:=Hashes[HashCounter];
      HashNodes[HashCounter+1]:=HashNodes[HashCounter];
     end;
     Hashes[0]:=Hash;
     HashNodes[0]:=LastNode;
    end;
    LastNode^.Link:=Link;
    LastNode^.LinkExist:=true;
    result:=true;
   end;
  end;
 end;
end;

function TBeRoStringTree.Delete(Content:string):boolean;
var StringLength,Position:integer;
    Node:PBeRoStringTreeNode;
    StringChar,NodeChar:char;
    Hash,HashToCompare,HashCounter:longword;
begin
 result:=false;
 Hash:=0;
 StringLength:=length(Content);
 if StringLength>0 then begin
  if Hashing then begin
   Hash:=HashString(Content);
   for HashCounter:=0 to MaxStringHashes-1 do begin
    HashToCompare:=Hashes[HashCounter];
    if HashToCompare<>0 then begin
     if HashToCompare=Hash then begin
      if assigned(HashNodes[HashCounter]) then begin
       HashNodes[HashCounter]^.LinkExist:=false;
       result:=true;
       exit;
      end;
     end;
    end else begin
     break;
    end;
   end;
  end;
  Node:=Root;
  for Position:=1 to StringLength do begin
   StringChar:=Content[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    while (NodeChar<>StringChar) and assigned(Node^.Down) do begin
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=StringLength) and Node^.LinkExist then begin
      if Hashing then begin
       for HashCounter:=0 to MaxStringHashes-2 do begin
        Hashes[HashCounter+1]:=Hashes[HashCounter];
        HashNodes[HashCounter+1]:=HashNodes[HashCounter];
       end;
       Hashes[0]:=Hash;
       HashNodes[0]:=Node;
      end;
      Node^.LinkExist:=false;
      result:=true;
      break;
     end;
     Node:=Node^.Next;
    end else begin
     break;
    end;
   end else begin
    break;
   end;
  end;
 end;
end;

function TBeRoStringTree.Find(Content:string;var Link:TBeRoStringTreeLink):boolean;
var StringLength,Position:integer;
    Node:PBeRoStringTreeNode;
    StringChar,NodeChar:char;
    Hash,HashToCompare,HashCounter:longword;
begin
 result:=false;
 Hash:=0;
 StringLength:=length(Content);
 if StringLength>0 then begin
  if Hashing then begin
   Hash:=HashString(Content);
   for HashCounter:=0 to MaxStringHashes-1 do begin
    HashToCompare:=Hashes[HashCounter];
    if HashToCompare<>0 then begin
     if HashToCompare=Hash then begin
      if assigned(HashNodes[HashCounter]) then begin
       Link:=HashNodes[HashCounter]^.Link;
       result:=true;
       exit;
      end;
     end;
    end else begin
      break;
    end;
   end;
  end;
  Node:=Root;
  for Position:=1 to StringLength do begin
   StringChar:=Content[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    while (NodeChar<>StringChar) and assigned(Node^.Down) do begin
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=StringLength) and Node^.LinkExist then begin
      if Hashing then begin
       for HashCounter:=0 to MaxStringHashes-2 do begin
        Hashes[HashCounter+1]:=Hashes[HashCounter];
        HashNodes[HashCounter+1]:=HashNodes[HashCounter];
       end;
       Hashes[0]:=Hash;
       HashNodes[0]:=Node;
      end;
      Link:=Node^.Link;
      result:=true;
      exit;
     end;
     Node:=Node^.Next;
    end else begin
     break;
    end;
   end else begin
    break;
   end;
  end;
 end;
end;

end.
