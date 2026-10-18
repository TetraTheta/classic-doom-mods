@echo off
setlocal

set "SEVEN_ZIP=C:\Program Files\7-Zip-Zstandard\7z.exe"

if "%~1"=="" (
  echo Drag a mod folder onto this file.
  exit /b 1
)

if not exist "%SEVEN_ZIP%" (
  echo 7-Zip was not found: "%SEVEN_ZIP%"
  exit /b 1
)

if not exist "%~f1\" (
  echo Not a folder: "%~f1"
  exit /b 1
)

set "MOD_NAME=%~nx1"
set "MOD_NAME=%MOD_NAME:-=_%"
set "OUTPUT=%~dp1%MOD_NAME%.pk3"

if exist "%OUTPUT%" del /q "%OUTPUT%"

pushd "%~f1"
"%SEVEN_ZIP%" a -tzip -mx=9 "%OUTPUT%" ".\*"
set "PACK_RESULT=%ERRORLEVEL%"
popd

if not "%PACK_RESULT%"=="0" (
  echo Failed to create "%OUTPUT%".
  exit /b %PACK_RESULT%
)

"%SEVEN_ZIP%" t "%OUTPUT%" >nul
if errorlevel 1 (
  echo Archive validation failed: "%OUTPUT%"
  exit /b 1
)

echo Created "%OUTPUT%".
