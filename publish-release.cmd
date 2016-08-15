@echo off
:: @author Sebastian Thomschke, Vegard IT GmbH
::
:: creates a new release in GitHub and haxelib.org

where  zip.exe /Q
if %errorlevel% neq 0 (
    echo Rerquired command 'zip' not found. Download from http://www.info-zip.org/Zip.html#Downloads
    exit /b 1
)

where wget.exe /Q
if %errorlevel% neq 0 (
    echo Rerquired command 'wget' not found. Download from https://eternallybored.org/misc/wget/
    exit /b 1
)

if [%GITHUB_ACCESS_TOKEN%] == [] (
    echo Rerquired environment variable GITHUB_ACCESS_TOKEN is not set!
    exit /b 1
)

setlocalset DRAFT=false
set PREPRELEASE=false

:: cd into project root
cd %~dp0

REM extract GIT URL from haxelib.json
for /f "tokens=*" %%a in ( 'findstr url haxelib.json' ) do (set textLine=%%a)
set REPO_URL=%textLine:"name": "=%
set REPO_URL=%REPO_URL:",=%

REM extract repo name from haxelib.json
set REPO_NAME=%REPO_URL:https://github.com/=%

REM extract project version from haxelib.json
for /f "tokens=*" %%a in ( 'findstr version haxelib.json' ) do (set textLine=%%a)
set PROJECT_VERSION=%textLine:"version": "=%
set PROJECT_VERSION=%PROJECT_VERSION:",=%

REM extract release note from haxelib.json
for /f "tokens=*" %%a in ( 'findstr releasenote haxelib.json' ) do (set textLine=%%a)
set RELEASE_NOTE=%textLine:"releasenote": "=%
set RELEASE_NOTE=%RELEASE_NOTE:",=%

if not exist target mkdir target

:: create github release https://developer.github.com/v3/repos/releases/#create-a-release
(
  echo {
  echo "tag_name":"v%PROJECT_VERSION%",
  echo "name":"v%PROJECT_VERSION%",
  echo "target_commitish":"master",
  echo "body":"%RELEASE_NOTE%",
  echo "draft":%DRAFT%,
  echo "prerelease":%PREPRELEASE%
  echo }
)>target/github_release.json
wget -qO- --post-file=target/github_release.json "https://api.github.com/repos/%REPO_NAME%/releases?access_token=%GITHUB_ACCESS_TOKEN%" || goto :eof

:: create haxelib release
zip target/haxelib-upload.zip src haxelib.json LICENSE.txt CONTRIBUTING.md README.md -r -9 || goto :eof

:: submit haxelib release
haxelib submit target/haxelib-upload.zip

:eof
endlocal
