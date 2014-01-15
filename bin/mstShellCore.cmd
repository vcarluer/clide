REM USAGE: mstShellCore PLUGIN CLASS/TEST
call rmd TestResults
mkdir TestResults
set testResults=TestResults\TestResults.trx
del %testResults%
msbuild .\PluginCore\%1\%1Test\%1Test.csproj /m /tv:4.0 /ds
if %ErrorLevel% == 0 (
	mstest /testcontainer:.\bin\test\Plugins\%1\Ortems.PlannerOne.%1Test.dll /test:%2 /nologo /resultsfile:%testResults% /testsettings:Coverage.testsettings %3
)
