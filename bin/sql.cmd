@echo off
set sqlinstance=localhost\sqlserver
set /p sqlinstance=SQL server name (Host\Instance): 
@echo on
osql -S %sqlinstance%  -E
