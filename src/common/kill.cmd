@echo off
:: Maps 'kill [pid]' to 'taskkill /F /PID [pid]'
if "%~1"=="" (
    echo Usage: kill [PID]
    exit /b 1
)
:: /F = Forcefully terminate, /T = Terminate child processes also
taskkill /F /T /PID %1