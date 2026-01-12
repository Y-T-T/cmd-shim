@echo off
:: Simple wget shim using PowerShell
if "%~1"=="" (
    echo Usage: wget [URL] [OutFile - optional]
    exit /b 1
)
if "%~2"=="" (
    powershell -Command "Invoke-WebRequest -Uri '%1' -OutFile '%~nx1'"
) else (
    powershell -Command "Invoke-WebRequest -Uri '%1' -OutFile '%2'"
)