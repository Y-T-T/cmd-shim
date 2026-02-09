@echo off
:: Maps 'less' to PowerShell Out-GridView (GUI)
:: Allows filtering and scrolling, much better than 'more'
if "%~1"=="" (
    echo Usage: less [filename]
    exit /b 1
)
powershell -NoProfile -Command "Get-Content '%~1' | Out-GridView -Wait -Title 'Less: %~nx1'"