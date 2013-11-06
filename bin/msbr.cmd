@echo off
call "%~dp0config.cmd"
@echo on
msbuild /p:configuration=Release /tv:%NetVersion% /m /ds %1
