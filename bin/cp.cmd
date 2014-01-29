@echo off
call "%~dp0config.cmd"
cd "%DeveloperCommandStartPath%"
call "%DeveloperVsDevCmd%"
powershell
