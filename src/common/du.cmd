@echo off
:: Maps 'du' to PowerShell measure-object
:: Usage: du [path] (Defaults to current directory)

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=."

echo Calculating size for: "%TARGET%" ...

powershell -NoProfile -Command ^
    "$size = (Get-ChildItem '%TARGET%' -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum;" ^
    "$mb = '{0:N2} MB' -f ($size / 1MB);" ^
    "$gb = '{0:N2} GB' -f ($size / 1GB);" ^
    "Write-Host \"Total Size: $mb  ($gb)\""