@echo off
set /p taskkillid=Process ID to kill: 
@echo on
taskkill /F /PID %taskkillid%
