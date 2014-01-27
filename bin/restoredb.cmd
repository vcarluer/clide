@echo off
call "%~dp0config.cmd"
dir "%sqlbackup%"
set /p backupFile=Source file name to restore from? 
set /p databaseName=Target database name? 
@echo on
osql -E -S %sqlServer% -Q "select name from sysdatabases"
@echo off
set /p dropDatabase=Do you want to drop database %databaseName% (Y/N)? 
if X%dropDatabase% == XY (
@echo on
osql -E -S %sqlserver% -Q "DROP DATABASE %databaseName%"
)

@echo on
osql -E -S %sqlserver% -Q "RESTORE FILELISTONLY FROM DISK = '%backupFile%'"
@echo off
set /p dataFile=Data logical name? 
set /p logFile=Log locagical name? 
set dataTargetPath=%sqldata%\%dataFile%.mdf
set logTargetPath=%sqldata%\%logFile%.ldf
echo Target data file: %dataTargetPath%
echo Target log file: %logTargetPath%
dir "%sqldata%"
set /p deletePreviousFiles=Do you want to delete target files (Y/N)? 
@echo on
if X%deletePreviousFiles% == XY (
	del "%dataTargetPath%"
	del "%logTargetPath%"
)

osql -E -S %sqlserver% -Q "RESTORE DATABASE %databaseName% FROM DISK = '%backupFile%' WITH MOVE '%dataFile%' to '%dataTargetPath%', MOVE '%logFile%' to '%logTargetPath%'"
