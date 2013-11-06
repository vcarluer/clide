@echo off
call "%~dp0config.cmd"
set /p project=What is the new project name? 
set namespace=%DefaultNamespace%.%project%
set projectPath="%workspace%\%project%\trunk"
if NOT "" == "%project%" (
	set /p namespace=What is the namespace (default: %namespace%^)? 
	call "%~dp0..\templates\tools\createProject.cmd" %projectPath% csharpconsole %project% %namespace%
	cd %projectPath%
	call "%~dp0msb.cmd" build.xml
	call bin\%project%.exe
)
