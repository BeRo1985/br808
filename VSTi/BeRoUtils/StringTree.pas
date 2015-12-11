(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2005, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
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
unit StringTree;
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

uses {$ifdef win32}Windows,{$endif}Classes,SysUtils,UCS4,UTF8;

const MaxStringHashes=32;

{$ifndef fpc}
      fsFromBeginning=0;
      fsFromCurrent=1;
      fsFromEnd=2;
{$endif}

type TStringTreeData=int64;

     TStringTree=class
      public
       procedure Clear; virtual;
       procedure DumpTree; virtual;
       procedure DumpList; virtual;
       procedure AppendTo(DestStringTree:TStringTree); virtual;
       procedure Optimize(DestStringTree:TStringTree); virtual;
       procedure CopyTo(DestStringTree:TStringTree); virtual;
       procedure Assign(SrcStringTree:TStringTree); virtual;
       function Add(Content:TUCS4STRING;Data:TStringTreeData;Replace:boolean=false):boolean; virtual;
       function Delete(Content:TUCS4STRING):boolean; virtual;
       function Find(Content:TUCS4STRING;var Data:TStringTreeData):boolean; virtual;
     end;
     
     PStringTreeNodeMemory=^TStringTreeNodeMemory;
     TStringTreeNodeMemory=record
      TheChar:TUCS4CHAR;
      Data:TStringTreeData;
      DataExist:boolean;
      Prevoius,Next,Up,Down:PStringTreeNodeMemory;
     end;

     TStringHashes=array[0..MaxStringHashes-1] of longword;
     TStringHashStrings=array[0..MaxStringHashes-1] of TUCS4STRING;
     TStringHashNodes=array[0..MaxStringHashes-1] of PStringTreeNodeMemory;

     TStringTreeMemory=class(TStringTree)
      private
       Root:PStringTreeNodeMemory;
       Hashes:TStringHashes;
       HashStrings:TStringHashStrings;
       HashNodes:TStringHashNodes;
       HashIndex:integer;
       function HashString(s:TUCS4STRING):longword;
       function CreateStringTreeNode(AChar:TUCS4CHAR):PStringTreeNodeMemory;
       procedure DestroyStringTreeNode(Node:PStringTreeNodeMemory);
      public
       Hashing:boolean;
       constructor Create;
       destructor Destroy; override;
       procedure Clear; override;
       procedure DumpTree; override;
       procedure DumpList; override;
       procedure AppendTo(DestStringTree:TStringTree); override;
       procedure Optimize(DestStringTree:TStringTree); override;
       function Add(Content:TUCS4STRING;Data:TStringTreeData;Replace:boolean=false):boolean; override;
       function Delete(Content:TUCS4STRING):boolean; override;
       function Find(Content:TUCS4STRING;var Data:TStringTreeData):boolean; override;
     end;

     TStringTreeNodeFile=packed record
      Prevoius,Next,Up,Down:int64;
      TheChar:TUCS4CHAR;
      Data:TStringTreeData;
      DataExist:boolean;
     end;

     TStringTreeFile=class(TStringTree)
      private
       datafile:THandle;
       FileName:TUCS4STRING;
       function CreateStringTreeNode(AChar:TUCS4CHAR):TStringTreeNodeFile;
      public
       constructor Create(AFileName:TUCS4STRING);
       destructor Destroy; override;
       procedure Clear; override;
       procedure DumpTree; override;
       procedure DumpList; override;
       procedure AppendTo(DestStringTree:TStringTree); override;
       procedure Optimize(DestStringTree:TStringTree); override;
       function Add(Content:TUCS4STRING;Data:TStringTreeData;Replace:boolean=false):boolean; override;
       function Delete(Content:TUCS4STRING):boolean; override;
       function Find(Content:TUCS4STRING;var Data:TStringTreeData):boolean; override;
     end;

implementation

procedure TStringTree.Clear;
begin
end;

procedure TStringTree.DumpTree;
begin
end;

procedure TStringTree.DumpList;
begin
end;

procedure TStringTree.AppendTo(DestStringTree:TStringTree);
begin
end;

procedure TStringTree.Optimize(DestStringTree:TStringTree);
begin
end;

procedure TStringTree.CopyTo(DestStringTree:TStringTree);
begin
 Optimize(DestStringTree);
end;

procedure TStringTree.Assign(SrcStringTree:TStringTree);
begin
 if not assigned(SrcStringTree) then exit;
 SrcStringTree.CopyTo(self);
end;

function TStringTree.Add(Content:TUCS4STRING;Data:TStringTreeData;Replace:boolean=false):boolean;
begin
 result:=false;
end;

function TStringTree.Delete(Content:TUCS4STRING):boolean;
begin
 result:=false;
end;

function TStringTree.Find(Content:TUCS4STRING;var Data:TStringTreeData):boolean;
begin
 result:=false;
end;

// ---

constructor TStringTreeMemory.Create;
begin
 inherited Create;
 Root:=nil;
 Clear;
end;

destructor TStringTreeMemory.Destroy;
begin
 Clear;
 inherited Destroy;
end;

function TStringTreeMemory.HashString(s:TUCS4STRING):longword;
var Counter,StringLength:integer;
begin
 result:=0;
 StringLength:=length(s);
 for Counter:=0 to StringLength-1 do begin
{$IFDEF CPU386}
  asm
   ROR dword PTR result,13
  end;
  inc(result,s[Counter]);
{$ELSE}
  result:=((result shr 13) or (result shl (32-13)))+s[Counter];
{$ENDIF}
 end;
end;

function TStringTreeMemory.CreateStringTreeNode(AChar:TUCS4CHAR):PStringTreeNodeMemory;
begin
 getmem(result,sizeof(TStringTreeNodeMemory));
 result^.TheChar:=AChar;
 result^.Data:=0;
 result^.DataExist:=false;
 result^.Prevoius:=nil;
 result^.Next:=nil;
 result^.Up:=nil;
 result^.Down:=nil;
end;

procedure TStringTreeMemory.DestroyStringTreeNode(Node:PStringTreeNodeMemory);
begin
 if not assigned(Node) then exit;
 DestroyStringTreeNode(Node^.Next);
 DestroyStringTreeNode(Node^.Down);
 freemem(Node);
end;

procedure TStringTreeMemory.Clear;
var Counter:integer;
begin
 DestroyStringTreeNode(Root);
 Root:=nil;
 fillchar(Hashes,sizeof(TStringHashes),#0);
 fillchar(HashNodes,sizeof(TStringHashNodes),#0);
 for Counter:=0 to MaxStringHashes-1 do begin
  setlength(HashStrings[Counter],0);
 end;
 HashIndex:=0;
end;

procedure TStringTreeMemory.DumpTree;
var Ident:integer;
 procedure DumpNode(Node:PStringTreeNodeMemory);
 var SubNode:PStringTreeNodeMemory;
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
  writeln;
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

procedure TStringTreeMemory.DumpList;
 procedure DumpNode(Node:PStringTreeNodeMemory;const ParentStr:TUCS4STRING);
 var s:TUCS4STRING;
 begin
  if not assigned(Node) then exit;
  if Node^.DataExist then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node^.TheChar);
   writeln(UCS4ToUTF8(s));
  end;
  if assigned(Node^.Next) then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node^.TheChar);
   DumpNode(Node^.Next,s);
  end;
  if assigned(Node^.Down) then DumpNode(Node^.Down,ParentStr);
 end;
begin
 if not assigned(Root) then exit;
 DumpNode(Root,nil);
end;

procedure TStringTreeMemory.AppendTo(DestStringTree:TStringTree);
 procedure DumpNode(Node:PStringTreeNodeMemory;const ParentStr:TUCS4STRING);
 var s:TUCS4STRING;
 begin
  if not assigned(Node) then exit;
  if Node^.DataExist then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node^.TheChar);
   DestStringTree.Add(s,Node^.Data);
  end;
  if assigned(Node^.Next) then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node^.TheChar);
   DumpNode(Node^.Next,s);
  end;
  if assigned(Node^.Down) then DumpNode(Node^.Down,ParentStr);
 end;
begin
 if not assigned(DestStringTree) then exit;
 if not assigned(Root) then exit;
 DumpNode(Root,nil);
end;

procedure TStringTreeMemory.Optimize(DestStringTree:TStringTree);
 procedure DumpNode(Node:PStringTreeNodeMemory;ParentStr:TUCS4STRING);
 var s:TUCS4STRING;
 begin
  if not assigned(Node) then exit;
  ParentStr:=ParentStr;
  if Node^.DataExist then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node^.TheChar);
   DestStringTree.Add(s,Node^.Data);
  end;
  if assigned(Node^.Next) then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node^.TheChar);
   DumpNode(Node^.Next,s);
  end;
  if assigned(Node^.Down) then DumpNode(Node^.Down,ParentStr);
 end;
begin
 if not assigned(DestStringTree) then exit;
 DestStringTree.Clear;
 if not assigned(Root) then exit;
 DumpNode(Root,nil);
end;

function TStringTreeMemory.Add(Content:TUCS4STRING;Data:TStringTreeData;Replace:boolean=false):boolean;
var StringLength,Position,PositionCounter:integer;
    NewNode,LastNode,Node:PStringTreeNodeMemory;
    StringChar,NodeChar:TUCS4CHAR;
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
      if UCS4Compare(HashStrings[HashCounter],Content) then begin
       if assigned(HashNodes[HashCounter]) then begin
        LastNode:=HashNodes[HashCounter];
        if Replace or not LastNode^.DataExist then begin
         LastNode^.Data:=Data;
         result:=true;
        end;
        exit;
       end;
      end;
     end;
    end else begin
     break;
    end;
   end;
  end;
  LastNode:=nil;
  Node:=Root;
  for Position:=0 to StringLength-1 do begin
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
    for PositionCounter:=Position to StringLength-1 do begin
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
   if Replace or not LastNode^.DataExist then begin
    if Hashing then begin
     Hashes[HashIndex]:=Hash;
     HashStrings[HashIndex]:=copy(Content,0,length(Content));
     HashNodes[HashIndex]:=LastNode;
     HashIndex:=(HashIndex+1) mod MaxStringHashes;
    end;
    LastNode^.Data:=Data;
    LastNode^.DataExist:=true;
    result:=true;
   end;
  end;
 end;
end;

function TStringTreeMemory.Delete(Content:TUCS4STRING):boolean;
var StringLength,Position:integer;
    Node:PStringTreeNodeMemory;
    StringChar,NodeChar:TUCS4CHAR;
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
      if UCS4Compare(HashStrings[HashCounter],Content) then begin
       if assigned(HashNodes[HashCounter]) then begin
        HashNodes[HashCounter]^.DataExist:=false;
        result:=true;
        exit;
       end;
      end;
     end;
    end else begin
     break;
    end;
   end;
  end;
  Node:=Root;
  for Position:=0 to StringLength-1 do begin
   StringChar:=Content[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    while (NodeChar<>StringChar) and assigned(Node^.Down) do begin
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=(StringLength-1)) and Node^.DataExist then begin
      if Hashing then begin
       Hashes[HashIndex]:=Hash;
       HashStrings[HashIndex]:=copy(Content,0,length(Content));
       HashNodes[HashIndex]:=Node;
       HashIndex:=(HashIndex+1) mod MaxStringHashes;
      end;
      Node^.DataExist:=false;
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

function TStringTreeMemory.Find(Content:TUCS4STRING;var Data:TStringTreeData):boolean;
var StringLength,Position:integer;
    Node:PStringTreeNodeMemory;
    StringChar,NodeChar:TUCS4CHAR;
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
      if UCS4Compare(HashStrings[HashCounter],Content) then begin
       if assigned(HashNodes[HashCounter]) then begin
        Data:=HashNodes[HashCounter]^.Data;
        result:=true;
        exit;
       end;
      end;
     end;
    end else begin
     break;
    end;
   end;
  end;
  Node:=Root;
  for Position:=0 to StringLength-1 do begin
   StringChar:=Content[Position];
   if assigned(Node) then begin
    NodeChar:=Node^.TheChar;
    while (NodeChar<>StringChar) and assigned(Node^.Down) do begin
     Node:=Node^.Down;
     NodeChar:=Node^.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=(StringLength-1)) and Node^.DataExist then begin
      if Hashing then begin
       Hashes[HashIndex]:=Hash;
       HashStrings[HashIndex]:=copy(Content,0,length(Content));
       HashNodes[HashIndex]:=Node;
       HashIndex:=(HashIndex+1) mod MaxStringHashes;
      end;
      Data:=Node^.Data;
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

// ---

{$warnings off}
{$hints off}
constructor TStringTreeFile.Create(AFileName:TUCS4STRING);
begin
 inherited Create;
 FileName:=AFileName;
 if fileexists(UCS4ToUTF8(FileName)) then begin
  datafile:=FileOpen(UCS4ToUTF8(FileName),fmOpenReadWrite or fmShareDenyWrite);
  if datafile<0 then begin
   raise Exception.Create('Open error');
  end;
 end else begin
  datafile:=FileCreate(UCS4ToUTF8(FileName));//,fmOpenReadWrite or fmShareDenyWrite);
  if datafile<0 then begin
   raise Exception.Create('Create error');
  end;
  Clear;
 end;
end;

destructor TStringTreeFile.Destroy;
begin
 if FileSeek(datafile,int64(0),fsFromEnd)<0 then begin
  raise Exception.Create('Seek error');
 end;
 FileClose(datafile);
 inherited Destroy;
end;

function TStringTreeFile.CreateStringTreeNode(AChar:TUCS4CHAR):TStringTreeNodeFile;
begin
 fillchar(result,sizeof(TStringTreeNodeFile),#0);
 result.TheChar:=AChar;
 result.Data:=0;
 result.DataExist:=false;
 result.Prevoius:=0;
 result.Next:=0;
 result.Up:=0;
 result.Down:=0;
end;

procedure TStringTreeFile.Clear;
var databytes:packed array[1..sizeof(TStringTreeNodeFile)] of byte;
begin
{$ifdef fpc}
 if not FileTruncate(datafile,0) then begin
  raise Exception.Create('Truncate error');
 end;
{$endif}
 if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
  raise Exception.Create('Seek error');
 end;
 fillchar(databytes,sizeof(databytes),#0);
 if FileWrite(datafile,databytes,sizeof(databytes))<>sizeof(databytes) then begin
  raise Exception.Create('Write error');
 end;
end;

procedure TStringTreeFile.DumpTree;
var Ident:integer;
 procedure DumpNode(NodeOffset:int64);
 var Node:TStringTreeNodeFile;
     SubNodeOffset:int64;
     SubNode:TStringTreeNodeFile;
     IdentCounter,IdentOld:integer;
 begin
  if NodeOffset=0 then exit;
  if FileSeek(datafile,NodeOffset,fsFromBeginning)<>NodeOffset then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
   raise Exception.Create('Read error');
  end;
  for IdentCounter:=1 to Ident do write(' ');
  write(Node.TheChar);
  if Node.DataExist and (Node.Next<>0) then begin
   writeln;
   for IdentCounter:=1 to Ident do write(' ');
   write(Node.TheChar);
  end;
  IdentOld:=Ident;
  SubNodeOffset:=Node.Next;
  while SubNodeOffset<>0 do begin
   if FileSeek(datafile,SubNodeOffset,fsFromBeginning)<>SubNodeOffset then begin
    raise Exception.Create('Seek error');
   end;
   if FileRead(datafile,SubNode,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
    raise Exception.Create('Read error');
   end;
   write(SubNode.TheChar);
   if SubNode.Next=0 then break;
   inc(Ident);
   SubNodeOffset:=SubNode.Next;
  end;
  writeln;
  inc(Ident);
  while (SubNodeOffset<>0) and (SubNodeOffset<>NodeOffset) do begin
   if FileSeek(datafile,SubNodeOffset,fsFromBeginning)<>SubNodeOffset then begin
    raise Exception.Create('Seek error');
   end;
   if FileRead(datafile,SubNode,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
    raise Exception.Create('Read error');
   end;
   if SubNode.Down<>0 then DumpNode(SubNode.Down);
   SubNodeOffset:=SubNode.Prevoius;
   dec(Ident);
  end;
  Ident:=IdentOld;
  if Node.Down<>0 then DumpNode(Node.Down);
 end;
var RootNodeOffset:int64;
begin
 Ident:=0;
 if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
  raise Exception.Create('Seek error');
 end;
 if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
  raise Exception.Create('Read error');
 end;
 if RootNodeOffset=0 then exit;
 DumpNode(RootNodeOffset);
end;

procedure TStringTreeFile.DumpList;
 procedure DumpNode(NodeOffset:int64;ParentStr:TUCS4STRING);
 var Node:TStringTreeNodeFile;
     s:TUCS4STRING;
 begin
  if NodeOffset=0 then exit;
  if FileSeek(datafile,NodeOffset,fsFromBeginning)<>NodeOffset then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
   raise Exception.Create('Read error');
  end;
  ParentStr:=ParentStr;
  if Node.DataExist then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node.TheChar);
   writeln(UCS4ToUTF8(s));
  end;
  if Node.Next<>0 then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node.TheChar);
   DumpNode(Node.Next,s);
  end;
  if Node.Down<>0 then DumpNode(Node.Down,ParentStr);
 end;
var RootNodeOffset:int64;
begin
 if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
  raise Exception.Create('Seek error');
 end;
 if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
  raise Exception.Create('Read error');
 end;
 if RootNodeOffset=0 then exit;
 DumpNode(RootNodeOffset,nil);
end;

procedure TStringTreeFile.AppendTo(DestStringTree:TStringTree);
 procedure DumpNode(NodeOffset:int64;ParentStr:TUCS4STRING);
 var Node:TStringTreeNodeFile;
     s:TUCS4STRING;
 begin
  if NodeOffset=0 then exit;
  if FileSeek(datafile,NodeOffset,fsFromBeginning)<>NodeOffset then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
   raise Exception.Create('Read error');
  end;
  ParentStr:=ParentStr;
  if Node.DataExist then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node.TheChar);
   DestStringTree.Add(s,Node.Data);
  end;
  if Node.Next<>0 then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node.TheChar);
   DumpNode(Node.Next,s);
  end;
  if Node.Down<>0 then DumpNode(Node.Down,ParentStr);
 end;
var RootNodeOffset:int64;
begin
 if not assigned(DestStringTree) then exit;
 if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
  raise Exception.Create('Seek error');
 end;
 if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
  raise Exception.Create('Read error');
 end;
 if RootNodeOffset=0 then exit;
 DumpNode(RootNodeOffset,nil);
end;

procedure TStringTreeFile.Optimize(DestStringTree:TStringTree);
 procedure DumpNode(NodeOffset:int64;ParentStr:TUCS4STRING);
 var Node:TStringTreeNodeFile;
     s:TUCS4STRING;
 begin
  if NodeOffset=0 then exit;
  if FileSeek(datafile,NodeOffset,fsFromBeginning)<>NodeOffset then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
   raise Exception.Create('Read error');
  end;
  ParentStr:=ParentStr;
  if Node.DataExist then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node.TheChar);
   DestStringTree.Add(s,Node.Data);
  end;
  if Node.Next<>0 then begin
   s:=copy(ParentStr,0,length(ParentStr));
   UCS4AddChar(s,Node.TheChar);
   DumpNode(Node.Next,s);
  end;
  if Node.Down<>0 then DumpNode(Node.Down,ParentStr);
 end;
var RootNodeOffset:int64;
begin
 if not assigned(DestStringTree) then exit;
 DestStringTree.Clear;
 if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
  raise Exception.Create('Seek error');
 end;
 if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
  raise Exception.Create('Read error');
 end;
 if RootNodeOffset=0 then exit;
 DumpNode(RootNodeOffset,nil);
end;

function TStringTreeFile.Add(Content:TUCS4STRING;Data:TStringTreeData;Replace:boolean=false):boolean;
var StringLength,Position,PositionCounter:integer;
    NewNode,LastNode,Node,TempNode:TStringTreeNodeFile;
    NewNodeOfs,LastNodeOfs,NodeOfs,TempNodeOfs:int64;
    StringChar,NodeChar:TUCS4CHAR;
    RootNodeOffset:int64;
 procedure ReadNode(ThisNodeOfs:integer;var ThisNode:TStringTreeNodeFile);
 begin
  if FileSeek(datafile,ThisNodeOfs,fsFromBeginning)<>ThisNodeOfs then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,ThisNode,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
   raise Exception.Create('Read error');
  end;
 end;
 procedure WriteNode(ThisNodeOfs:integer;const ThisNode:TStringTreeNodeFile);
 begin
  if FileSeek(datafile,ThisNodeOfs,fsFromBeginning)<>ThisNodeOfs then begin
   raise Exception.Create('Seek error');
  end;
  if FileWrite(datafile,ThisNode,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
   raise Exception.Create('Wrize error');
  end;
  if (NewNodeOfs<>0) and (ThisNodeOfs=NewNodeOfs) then begin
   ReadNode(NewNodeOfs,NewNode);
  end;
  if (LastNodeOfs<>0) and (ThisNodeOfs=LastNodeOfs) then begin
   ReadNode(LastNodeOfs,LastNode);
  end;
  if (NodeOfs<>0) and (ThisNodeOfs=NodeOfs) then begin
   ReadNode(NodeOfs,Node);
  end;
 end;
begin
 result:=false;
 StringLength:=length(Content);
 if StringLength>0 then begin
  LastNodeOfs:=0;
  NewNodeOfs:=0;
  if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
   raise Exception.Create('Read error');
  end;
  NodeOfs:=RootNodeOffset;
  for Position:=0 to StringLength-1 do begin
   StringChar:=Content[Position];
   if NodeOfs<>0 then begin
    ReadNode(NodeOfs,Node);
    NodeChar:=Node.TheChar;
    if NodeChar=StringChar then begin
     LastNode:=Node;
     LastNodeOfs:=NodeOfs;
     NodeOfs:=Node.Next;
     ReadNode(NodeOfs,Node);
    end else begin
     while (NodeChar<StringChar) and (Node.Down<>0) do begin
      NodeOfs:=Node.Down;
      ReadNode(NodeOfs,Node);
      NodeChar:=Node.TheChar;
     end;
     if NodeChar=StringChar then begin
      LastNode:=Node;
      LastNodeOfs:=NodeOfs;
      NodeOfs:=Node.Next;
      ReadNode(NodeOfs,Node);
     end else begin
      NewNodeOfs:=FileSeek(datafile,int64(0),fsFromEnd);
      if NewNodeOfs<0 then begin
       raise Exception.Create('Seek from file end error');
      end;
      NewNode:=CreateStringTreeNode(StringChar);
      WriteNode(NewNodeOfs,NewNode);
      if NodeChar<StringChar then begin
       NewNode.Down:=Node.Down;
       NewNode.Up:=NodeOfs;
       WriteNode(NewNodeOfs,NewNode);
       if NewNode.Down<>0 then begin
        TempNodeOfs:=NewNode.Down;
        ReadNode(TempNodeOfs,TempNode);
        TempNode.Up:=NewNodeOfs;
        WriteNode(TempNodeOfs,TempNode);
       end;
       NewNode.Prevoius:=Node.Prevoius;
       WriteNode(NewNodeOfs,NewNode);
       Node.Down:=NewNodeOfs;
       WriteNode(NodeOfs,Node);
      end else if NodeChar>StringChar then begin
       NewNode.Down:=NodeOfs;
       NewNode.Up:=Node.Up;
       WriteNode(NewNodeOfs,NewNode);
       if NewNode.Up<>0 then begin
        TempNodeOfs:=NewNode.Up;
        ReadNode(TempNodeOfs,TempNode);
        TempNode.Down:=NewNodeOfs;
        WriteNode(TempNodeOfs,TempNode);
       end;
       NewNode.Prevoius:=Node.Prevoius;
       WriteNode(NewNodeOfs,NewNode);
       if NewNode.Up=0 then begin
        if NewNode.Prevoius<>0 then begin
         TempNodeOfs:=NewNode.Prevoius;
         ReadNode(TempNodeOfs,TempNode);
         TempNode.Next:=NewNodeOfs;
         WriteNode(TempNodeOfs,TempNode);
        end else begin
         RootNodeOffset:=NewNodeOfs;
         if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
          raise Exception.Create('Seek error');
         end;
         if FileWrite(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
          raise Exception.Create('Write error');
         end;
        end;
       end;
       Node.Up:=NewNodeOfs;
       WriteNode(NodeOfs,Node);
      end;
      LastNodeOfs:=NewNodeOfs;
      LastNode:=NewNode;
      NodeOfs:=LastNode.Next;
      ReadNode(NodeOfs,Node);
     end;
    end;
   end else begin
    for PositionCounter:=Position to StringLength-1 do begin
     NewNodeOfs:=FileSeek(datafile,int64(0),fsFromEnd);
     if NewNodeOfs<0 then begin
      raise Exception.Create('Seek from file end error');
     end;
     NewNode:=CreateStringTreeNode(Content[PositionCounter]);
     WriteNode(NewNodeOfs,NewNode);
     if LastNodeOfs<>0 then begin
      NewNode.Prevoius:=LastNodeOfs;
      WriteNode(NewNodeOfs,NewNode);
      LastNode.Next:=NewNodeOfs;
      WriteNode(LastNodeOfs,LastNode);
      LastNodeOfs:=LastNode.Next;
      ReadNode(LastNodeOfs,LastNode);
     end else begin
      if RootNodeOffset=0 then begin
       RootNodeOffset:=NewNodeOfs;
       if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
        raise Exception.Create('Seek error');
       end;
       if FileWrite(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
        raise Exception.Create('Write error');
       end;
       LastNodeOfs:=NewNodeOfs;
       LastNode:=NewNode;
      end;
     end;
    end;
    break;
   end;
  end;
  if (LastNodeOfs<>0) and (Replace or not LastNode.DataExist) then begin
   LastNode.Data:=Data;
   LastNode.DataExist:=true;
   WriteNode(LastNodeOfs,LastNode);
   result:=true;
  end;
 end;
end;

function TStringTreeFile.Delete(Content:TUCS4STRING):boolean;
var StringLength,Position:integer;
    Node:TStringTreeNodeFile;
    RootNodeOffset,NodeOfs:int64;
    StringChar,NodeChar:TUCS4CHAR;
begin
 result:=false;
 StringLength:=length(Content);
 if StringLength>0 then begin
  if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
   raise Exception.Create('Read error');
  end;
  NodeOfs:=RootNodeOffset;
  for Position:=0 to StringLength-1 do begin
   StringChar:=Content[Position];
   if NodeOfs<>0 then begin
    if FileSeek(datafile,NodeOfs,fsFromBeginning)<>NodeOfs then begin
     raise Exception.Create('Seek error');
    end;
    if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
     raise Exception.Create('Read error');
    end;
    NodeChar:=Node.TheChar;
    while (NodeChar<>StringChar) and (Node.Down<>0) do begin
     NodeOfs:=Node.Down;
     if FileSeek(datafile,NodeOfs,fsFromBeginning)<>NodeOfs then begin
      raise Exception.Create('Seek error');
     end;
     if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
      raise Exception.Create('Read error');
     end;
     NodeChar:=Node.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=(StringLength-1)) and Node.DataExist then begin
      Node.DataExist:=false;
      if FileSeek(datafile,NodeOfs,fsFromBeginning)<>NodeOfs then begin
       raise Exception.Create('Seek error');
      end;
      if FileWrite(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
       raise Exception.Create('Write error');
      end;
      result:=true;
      exit;
     end;
     NodeOfs:=Node.Next;
    end else begin
     break;
    end;
   end else begin
    break;
   end;
  end;
 end;
end;

function TStringTreeFile.Find(Content:TUCS4STRING;var Data:TStringTreeData):boolean;
var StringLength,Position:integer;
    Node:TStringTreeNodeFile;
    RootNodeOffset,NodeOfs:int64;
    StringChar,NodeChar:TUCS4CHAR;
begin
 result:=false;
 StringLength:=length(Content);
 if StringLength>0 then begin
  if FileSeek(datafile,0,fsFromBeginning)<>0 then begin
   raise Exception.Create('Seek error');
  end;
  if FileRead(datafile,RootNodeOffset,sizeof(int64))<>sizeof(int64) then begin
   raise Exception.Create('Read error');
  end;
  NodeOfs:=RootNodeOffset;
  for Position:=0 to StringLength-1 do begin
   StringChar:=Content[Position];
   if NodeOfs<>0 then begin
    if FileSeek(datafile,NodeOfs,fsFromBeginning)<>NodeOfs then begin
     raise Exception.Create('Seek error');
    end;
    if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
     raise Exception.Create('Read error');
    end;
    NodeChar:=Node.TheChar;
    while (NodeChar<>StringChar) and (Node.Down<>0) do begin
     NodeOfs:=Node.Down;
     if FileSeek(datafile,NodeOfs,fsFromBeginning)<>NodeOfs then begin
      raise Exception.Create('Seek error');
     end;
     if FileRead(datafile,Node,sizeof(TStringTreeNodeFile))<>sizeof(TStringTreeNodeFile) then begin
      raise Exception.Create('Read error');
     end;
     NodeChar:=Node.TheChar;
    end;
    if NodeChar=StringChar then begin
     if (Position=(StringLength-1)) and Node.DataExist then begin
      Data:=Node.Data;
      result:=true;
      exit;
     end;
     NodeOfs:=Node.Next;
    end else begin
     break;
    end;
   end else begin
    break;
   end;
  end;
 end;
end;

{$warnings on}
{$hints on}

end.

