REM %1 is project target path
REM %2 is template name
REM %3 is project name 
REM %4 is namespace

REM Copy template
xcopy /S /Y "%~dp0..\%2" "%1\"

REM RENAME main class file
set callingDir=%CD%
cd %1
rename MainClass.cs "%3.cs"

REM Change template entry
msbuild "%~dp0ReplaceTemplate.xml" /p:ProjectPath="%1" /p:Namespace="%4" /p:Project="%3"
cd %callingDir%
