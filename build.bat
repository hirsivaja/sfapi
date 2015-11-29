@ECHO OFF

call mvn clean install
IF %ERRORLEVEL% NEQ 0 (
 GOTO :EXIT
)

cd test\Flex3Tester
call mvn clean install
IF %ERRORLEVEL% NEQ 0 (
 GOTO :EXIT
)

cd ..\..\test\Flex4Tester
call mvn clean install
IF %ERRORLEVEL% NEQ 0 (
 GOTO :EXIT
)

set /P continue="Press enter to continue..."
GOTO:EOF

:EXIT
set /P continue="Build failed..."
exit 1