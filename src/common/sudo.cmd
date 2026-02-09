@echo off
:: Note: If "Sudo for Windows" (Developer Mode) is enabled in Windows 11,
:: the built-in 'sudo.exe' may take precedence over this script.
set "CURRENT_DIR=%CD%"

if "%~1"=="" (
    powershell -Command "Start-Process cmd -ArgumentList '/k cd /d """%CURRENT_DIR%"""' -Verb RunAs"
) else (
    powershell -Command "Start-Process cmd -ArgumentList '/k cd /d """%CURRENT_DIR%""" && %*' -Verb RunAs"
)