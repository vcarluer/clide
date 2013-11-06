@echo off
call "%~dp0config.cmd"
set callPath=%CD%
cd "%DeveloperCommandStartPath%"
start %comspec% /k "%DeveloperVsDevCmd%"
cd %callPath%
