@echo off
call "%~dp0config.cmd"
@echo on
msbuild /m /ds %1
