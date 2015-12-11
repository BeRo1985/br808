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
PROGRAM MID2PAS;
VAR Quelle:FILE;
    Ziel:TEXT;
    B,C:BYTE;
    S:STRING;
BEGIN
 ASSIGNFILE(Quelle,'..\BMFPlayerStub.exe');
 {$I-}RESET(Quelle,1);{$I+}
 IF IOResult=0 THEN BEGIN
  ASSIGNFILE(Ziel,'..\BMFPlayerStubfile.pas');
  {$I-}REWRITE(Ziel);{$I+}
  IF IOResult=0 THEN BEGIN
   WRITELN(Ziel,'UNIT BMFPlayerStubfile;');
   WRITELN(Ziel,'INTERFACE');
   WRITELN(Ziel,'CONST BMFPlayerStubSize=',FILESIZE(Quelle),';');
   WRITE(Ziel,'      BMFPlayerStubData:ARRAY[1..BMFPlayerStubSize] OF BYTE=(');
   C:=0;
   WHILE NOT EOF(Quelle) DO BEGIN
    BLOCKREAD(Quelle,B,1);
    STR(B,S);
    IF FILESIZE(Quelle)<>FILEPOS(Quelle) THEN S:=S+',';
    C:=C+LENGTH(S);
    WRITE(Ziel,S);
    IF C>40 THEN BEGIN
     IF FILESIZE(Quelle)<>FILEPOS(Quelle) THEN BEGIN
      WRITELN(Ziel);
      WRITE(Ziel,'                                             ');
     END;
     C:=0;
    END;
   END;
   WRITELN(Ziel,');');
   WRITELN(Ziel,'IMPLEMENTATION');
   WRITELN(Ziel,'END.');
   CLOSEFILE(Ziel);
  END;
  CLOSEFILE(Quelle);
 END;
END.