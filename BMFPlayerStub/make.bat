@ECHO OFF
del *.dcu
"C:\Program Files (x86)\Borland\Delphi7\bin\dcc32" -B -dBR404EXEMUSPLAYER BMFPlayerStub.dpr
rem "C:\Programme\Borland\Delphi5\bin\dcc32" -B -dBR404EXEMUSPLAYER BMFPlayerStub.dpr
cd stub2pas
"C:\Program Files (x86)\Borland\Delphi7\bin\dcc32" -b stub2pas.dpr
stub2pas.exe
cd ..
