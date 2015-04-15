@ECHO OFF
set HOME=%~dp0
set LYNX_TEMP_SPACE=%HOME%
set LYNX_CFG=%HOME%\lynx.cfg
set LYNX_LSS=%HOME%\lynx.lss
"%0" %1 %2 %3 %4 %5
