set testResults=TestResults\TestResults.trx
del %testResults%
msbuild .\%3\%1\%1Test\%1Test.csproj /m /tv:4.0 /ds
if %ErrorLevel% == 0 (
	mstest /testcontainer:.\bin\test\Plugins\%1\Ortems.PlannerOne.%1Test.dll /test:%2 /nologo /resultsfile:%testResults% %4
)
