set filter= 
set /p filter=Enter the filter: 
wmic process get processid, description, executablepath | grep "%filter%"
pause
