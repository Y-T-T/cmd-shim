@echo off
:: PowerShell equivalent: Start-Sleep -Seconds <n>
if "%~1"=="" (
    timeout /t 1 /nobreak >nul
) else (
    timeout /t %1 /nobreak >nul
)