@echo off
:: Maps Linux 'strings' to Sysinternals strings64.exe
:: Usage: strings [file]

:: check if strings64.exe is available
where strings64.exe >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] 'strings64.exe' not found. Please ensure Sysinternals Suite is in your PATH.
    exit /b 1
)

:: invoke strings64.exe with all passed arguments
strings64.exe -accepteula -nobanner %*