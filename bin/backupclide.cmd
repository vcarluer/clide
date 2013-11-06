@echo off
call "%~dp0config.cmd"
@echo on
xcopy /S /Y "%~dp0.." "%backuppath%"
