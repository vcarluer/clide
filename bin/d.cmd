@echo off
call "%~dp0config.cmd"
set rep=trunk
if NOT "%1" == "" (	
	if NOT "%1" == "trunk" (	
		set rep=branches\%1
	)	
)

cd "%workspace%\%project%\%rep%"
:end
echo Good dev in %rep%!
