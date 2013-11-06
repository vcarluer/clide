@echo off
call "%~dp0config.cmd"
@echo on
msbuild /tv:%NetVersion% /m /ds %1
