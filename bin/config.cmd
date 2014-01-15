@echo off
set PATH=%PATH%;%~dp0..\ctags58
if NOT EXIST "%~dp0..\config\settings.ini" copy "%~dp0..\config\settings.template.ini" "%~dp0..\config\settings.ini"
set INIFILE="%~dp0..\config\settings.ini"
call:getvalue %INIFILE%
goto:eof

:getvalue
rem This function reads values from an INI file and stored them in corresponding variables
rem %1 = name of ini file to search in.
FOR /F "eol=; eol=[ tokens=1,2* delims==" %%i in ('findstr /l /i "=" %1') DO (
	set %%~i=%%~j
)

goto:eof
