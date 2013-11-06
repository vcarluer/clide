@echo off
set catchPhrase=Welcome in the MATRIX
set runMode=1

:CHOICE
cls
if %runMode% == 1 set modeName=THE LOBBY
if %runMode% == 2 set modeName=THE WORKSHOP
if %runMode% == 3 set modeName=THE TRAINING ROOM
if %runMode% == 4 set modeName=THE COMMAND CENTER
set toRun=None

echo       ___/===-,_
echo    I==  I       ===--,,_      _,,-==)
echo    I    I    /_         ===--/_    /
echo    \    I   I__===--,_            /
echo     \   I   /  ===-,_ ===-,__,,-==
echo     \  I   /         ==-,__,-==
echo      \ I  /
echo       \I_/
echo      ( / )           [ %modeName% ]
echo     _)/_\(_          
echo   /       _ \
echo  /  _   /'_  \
echo /  (*\   /*)  \      A voice in the matrix says:
echo /  =""=,=""=  \      "%catchPhrase% %USERNAME%"
echo ^<    ::I::    ^>      
echo  "=--\_^_,--="
echo     I    I
echo %computername% %date% %time%
set matrixCount=1
:while
if %matrixCount% GTR 4 goto MATRIXEND
echo %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random% %random%
set /a matrixCount=matrixCount+1
goto while
:MATRIXEND
echo.
echo What do you want to run?
if %runMode% == 1 goto MAIN
if %runMode% == 2 goto TOOLS
if %runMode% == 3 goto GAMES
if %runMode% == 4 goto COMMANDS

:MAIN
echo 1 - Developer command prompt
echo 2 - Chrome
echo 3 - Explorer
echo a - TOOLS
echo z - GAMES
echo e - COMMANDS
echo q - Quit (or x to keep window open)
set /P toRun=Choice: 
if %toRun% == 1 (
	set catchPhrase=Have a good dev time
	call "%~dp0c.cmd"
	goto CHOICE
)

if %toRun% == 2 (
	set catchPhrase=Browse the metal
	start cmd /C "start C:\Progra~2\Google\Chrome\Application\chrome.exe"
	goto CHOICE
)

if %toRun% == 3 (
	set catchPhrase=Explore your virtual universe
	start cmd /C "%windir%\explorer.exe"
	goto CHOICE
)

if %toRun% == a (
	set runMode=2
	goto CHOICE
)

if %toRun% == z (
	set runMode=3
	goto CHOICE
)

if %toRun% == e (
	set runMode=4
	goto CHOICE
)

if %toRun% == q (
	goto END
)

if %toRun% == x (
	goto ENDX
)

set catchPhrase=You seem to be lost
goto CHOICE

:TOOLS
echo 1 - Outlook
echo 2 - Jira client
echo 3 - Remote desktop
echo 4 - SQL server management studio
echo 5 - IIS Manager
echo 6 - Windows Service Management
echo 7 - Gimp
echo 8 - Visual Studio 2012
echo 9 - FileZilla
echo 10 - Virtual Box
echo 11 - Eclipse
echo 12 - Lynx
echo 13 - Azure management
echo 14 - Internet Explorer
echo 15 - Microsoft Dynamics NAV 2009 R2 Classic SQL
echo 16 - System properties
echo 17 - Computer management
echo b - back
echo q - Quit (or x to keep window open)
set /P toRun=Choice: 

set runMode=1
if %toRun% == 1 (
	set catchPhrase=Look out
	start cmd /C "start C:\Progra~2\Micros~1\Office14\Outlook.exe"
	goto CHOICE
)

if %toRun% == 2 (
	set catchPhrase=Name your task
	start cmd /C "start C:\Progra~2\JIRACL~1\bin\jiraclient.exe"
	goto CHOICE
)

if %toRun% == 3 (
	set catchPhrase=Puppet master all this
	start cmd /C "start %windir%\system32\mstsc.exe /admin"
	goto CHOICE
)

if %toRun% == 4 (
	set catchPhrase=What does EsseCuElle means
	start cmd /C "start C:\Progra~2\MI3EDC~1\110\Tools\Binn\ManagementStudio\Ssms.exe"
	goto CHOICE
)

if %toRun% == 5 (
	set catchPhrase=Internet is yours
	start cmd /C "start %windir%\system32\inetsrv\InetMgr.exe"
	goto CHOICE
)

if %toRun% == 6 (
	set catchPhrase=Serve them well
	start cmd /C "start %windir%\system32\services.msc"
	goto CHOICE
)

if %toRun% == 7 (
	set catchPhrase=Draw me a sheep
	start cmd /C "start C:\Progra~1\GIMP2~1\bin\gimp-2~1.exe"
	goto CHOICE
)

if %toRun% == 8 (
	set catchPhrase=Use it smartly
	start cmd /C "start C:\Progra~2\Micros~1.0\Common7\IDE\devenv.exe" 
	goto CHOICE
)

if %toRun% == 9 (
	set catchPhrase=All your files are belong to us
	start cmd /C "start C:\Progra~2\FileZi~1\filezilla.exe"
	goto CHOICE
)

if %toRun% == 10 (
	set catchPhrase=Your bits will be virtual
	start cmd /C "start C:\Progra~1\Oracle\VirtualBox\VirtualBox.exe"
	goto CHOICE
)

if %toRun% == 11 (
	set catchPhrase=Code before the sun strike
	start cmd /C "eclipse"
	goto CHOICE
)

if %toRun% == 12 (
	set catchPhrase=You have found the matrix gateway
	start /MAX cmd /C "l"
	goto CHOICE
)

if %toRun% == 13 (
	set catchPhrase=It's cloudy today
	start cmd /C "start c:\PROGRA~1\INTERN~1\iexplore https://manage.windowsazure.com"
	goto CHOICE
)

if %toRun% == 14 (
	set catchPhrase=I assume you need some Microsoft features
	start cmd /C "start c:\PROGRA~1\INTERN~1\iexplore"
	goto CHOICE
)

if %toRun% == 15 (
	set catchPhrase=I assume you need some Microsoft features
	start cmd /C "start C:\PROGRA~2\MIB72F~1\60\Classic\finsql.exe"

	goto CHOICE
)

if %toRun% == 16 (
	set catchPhrase=Who am I
	start /MIN cmd /C "sysdm.cpl"
	goto CHOICE
)

if %toRun% == 17 (
	set catchPhrase=Manage me well
	start /MIN cmd /C "compmgmt.msc"
	goto CHOICE
)

if %toRun% == b (
	set catchPhrase=Back to the future
	goto CHOICE
)

if %toRun% == q (
	goto END
)

if %toRun% == x (
	goto ENDX
)

set runMode=2
set catchPhrase=You seem to be lost
goto CHOICE

:GAMES
echo 1 - Dota 2
echo 2 - Steam
echo b - back
echo q - Quit (or x to keep window open)
set /P toRun=Choice: 

set runMode=1
if %toRun% == 1 (
	set catchPhrase=launching dota 2!! Gank powa
	start cmd /C "start c:\Progra~2\Steam\SteamA~1\common\dota2b~1\dota.exe"
	goto CHOICE
)

if %toRun% == 2 (
	set catchPhrase=Life is a game
	start cmd /C "start c:\Progra~2\Steam\Steam.exe"
	goto CHOICE
)

if %toRun% == b (
	set catchPhrase=Back to the future
	goto CHOICE
)

if %toRun% == q (
	goto END
)

if %toRun% == x (
	goto ENDX
)

set runMode=3
set catchPhrase=You seem to be lost
goto CHOICE

:COMMANDS
echo !COMMAND - Run COMMAND
echo 1 - Empty recycle bin
echo 2 - List processes
echo 3 - Add or remove features
echo 4 - IIS restart
echo sd - Shutdown computer
echo b - back
echo q - Quit (or x to keep window open)
set /P toRun=Choice: 

set runMode=1

set firstCommand=%toRun:~0,1%
set allCommand=%toRun:~1,99%
if %firstCommand% == ! (
	set catchPhrase=Tried to run %allCommand%
	start cmd /C %allCommand% 
	goto CHOICE
)

if %toRun% == 1 (
	set catchPhrase=Recycle is the cycle
	start cmd /C "rmdir /S C:\$RECYCLE.BIN\S-1-5-21-790525478-413027322-725345543-1748\."
	goto CHOICE
)

if %toRun% == 2 (
	set catchPhrase=Look closely at the list
	start cmd /C "proc"
	goto CHOICE
)

if %toRun% == 3 (
	set catchPhrase=Change it all
	start /MIN cmd /C "appwiz.cpl"
	goto CHOICE
)

if %toRun% == 4 (
	set catchPhrase=Reset the web
	start cmd /C "iisreset"
	goto CHOICE
)

if %toRun% == sd (
	set catchPhrase=Fool, the MATRIX is everywhere
	start cmd /C "shutdown /s /t 0"
	goto CHOICE
)

if %toRun% == b (
	set catchPhrase=Back to the future
	goto CHOICE
)

if %toRun% == q (
	goto END
)

if %toRun% == x (
	goto ENDX
)

set runMode=4
set catchPhrase=You seem to be lost
goto CHOICE

:END
echo The voice says: "Bye man, you will return"
exit
:ENDX
echo The voice says: "Bye man, you will return"