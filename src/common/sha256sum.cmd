@echo off
:: Maps sha256sum to PowerShell Get-FileHash
if "%~1"=="" (
    echo Usage: sha256sum [filename]
    exit /b 1
)
powershell -NoProfile -Command "Get-FileHash -Algorithm SHA256 '%~1' | Format-List"