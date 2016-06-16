set testResults=..\TestResults\TestResults.trx
del %testResults%
if %ErrorLevel% == 0 (
	"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\MSTest.exe" /testcontainer:..\bin\test\Plugins\%1\Ortems.PlannerOne.%1Test.dll /nologo /resultsfile:%testResults% /testsettings:..\tests.testsettings %2
)
