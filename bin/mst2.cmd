set testResults=TestResults\TestResults.trx
echo X%3
if "X%3" == "XBuild" (
	msbuild .\%1Test\%1Test.csproj /p:configuration="Debug" /p:BuildProjectReferences=false /m
)

if %ErrorLevel% == 0 (
	del %testResults%
	"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\MSTest.exe" /testcontainer:.\bin\test\Plugins\%1\Ortems.PlannerOne.%1Test.dll /test:%2 /nologo /resultsfile:%testResults% /testsettings:.\%1.testsettings %4
	start %testResults%
)
