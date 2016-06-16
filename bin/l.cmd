@echo off
call "%~dp0config.cmd"
set term=vt100
set home=%clide%\lynx
set temp=%clide%\temp
set lynx_cfg=%home%\lynx.cfg
set lynx_lss=%home%\lynx.lss
%home%\lynx.exe %1 %2 %3 %4 %5
