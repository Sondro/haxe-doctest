@echo off
REM Copyright (c) 2016-2018 Vegard IT GmbH, https://vegardit.com
REM SPDX-License-Identifier: Apache-2.0
REM Author: Sebastian Thomschke, Vegard IT GmbH

call %~dp0_test-prepare.cmd js

echo Compiling...
haxe -main hx.doctest.TestRunner ^
  -lib hx3compat ^
  -lib munit ^
  -lib tink_testrunner ^
  -cp src ^
  -cp test ^
  -dce full ^
  -debug ^
  -D dump=pretty ^
  -js target\js\TestRunner.js
set rc=%errorlevel%
popd
if not %rc% == 0 exit /b %rc%

echo Testing [Direct Execution]...
phantomjs "%~dp0..\target\js\TestRunner.js"

echo Testing [Execution in WegPage Context]...
phantomjs "%~dp0phantomJS\phantom.js"
