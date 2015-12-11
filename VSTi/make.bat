@echo off
cd ..\BMFPlayerStub
call make.bat
cd ..\VSTi
cd UpdateVersionInfo
"C:\Program Files (x86)\Borland\Delphi7\bin\dcc32" -b UpdateVersionInfo.dpr
UpdateVersionInfo.exe
cd ..
del BR808.dll 
del BR808MultiOutput.dll 
"C:\Program Files (x86)\Borland\Delphi7\bin\dcc32" -dMultiOutput -b BR808.dpr
copy BR808.dll BR808MultiOutput.dll
del BR808.dll 
"C:\Program Files (x86)\Borland\Delphi7\bin\dcc32" -b BR808.dpr
