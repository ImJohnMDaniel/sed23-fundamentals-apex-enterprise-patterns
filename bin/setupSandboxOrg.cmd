@ECHO OFF
@REM ###############################################################
@REM #
@REM #  bin\setupSandboxOrg.cmd [org_alias]
@REM #
@REM ###############################################################

REM set variables
set "org_alias=%~1"
echo "org_alias is %org_alias%"
set "temp_dir=temp"

REM Install all dependencies
REM     Install fflib-apex-mocks framework
call del /f /s /q %temp_dir%\fflib-apex-mocks
call git clone -q --no-tags https://github.com/apex-enterprise-patterns/fflib-apex-mocks.git %temp_dir%\fflib-apex-mocks
if %errorlevel% neq 0 exit /b %errorlevel%
cd %temp_dir%\fflib-apex-mocks
call sf project deploy start --ignore-conflicts --target-org %org_alias%
if %errorlevel% neq 0 exit /b %errorlevel%
cd ../..

REM     Install fflib-apex-common framework
call del /f /s /q %temp_dir%\fflib-apex-common
call git clone -q --no-tags https://github.com/apex-enterprise-patterns/fflib-apex-common.git %temp_dir%\fflib-apex-common
if %errorlevel% neq 0 exit /b %errorlevel%
cd %temp_dir%\fflib-apex-common
call sf project deploy start --ignore-conflicts --target-org %org_alias%
if %errorlevel% neq 0 exit /b %errorlevel%
cd ../..

REM Push source code to org.
call sf project deploy start --ignore-conflicts --target-org %org_alias%
if %errorlevel% neq 0 exit /b %errorlevel%

REM Open the org
call sf org open --path lightning/setup/SetupOneHome/home --target-org %org_alias%
echo ""
echo "Sandbox org %org_alias% is ready"
echo ""
