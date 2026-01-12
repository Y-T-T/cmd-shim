@echo off
:: Maps tail to PowerShell
:: Usage: tail [filename] [lines - optional, default 10]
if "%~2"=="" (
    powershell -NoProfile -Command "Get-Content '%~1' -Tail 10"
) else (
    powershell -NoProfile -Command "Get-Content '%~1' -Tail %2"
)