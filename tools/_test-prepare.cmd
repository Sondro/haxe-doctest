@echo off
REM Copyright (c) 2016-2018 Vegard IT GmbH, https://vegardit.com
REM SPDX-License-Identifier: Apache-2.0
REM Author: Sebastian Thomschke, Vegard IT GmbH

pushd .

REM cd into project root
cd %~dp0..


if exist dump\%1 (
    echo Cleaning [dump\%1]...
    rd /s /q dump\%1
)
if exist target\%1 (
    echo Cleaning [target\%1]...
    rd /s /q target\%1
)
shift

goto :eof

REM install common libs
echo Checking required haxelibs...
for %%i in (hx3compat munit tink_testrunner) do (
    haxelib list | findstr %%i >NUL
    if errorlevel 1 (
        echo Installing [%%i]...
        haxelib install %%i
    )
)


REM install additional libs
:iterate

    if "%~1"=="" goto :eof

    haxelib list | findstr %1 >NUL
    if errorlevel 1 (
        echo Installing [%1]...
        haxelib install %1
    )

    shift
    goto iterate
