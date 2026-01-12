@echo off
:: Simulates 'nc' (Netcat) using PowerShell Test-NetConnection
:: Bypass Antivirus detection since we are not using real nc.exe
:: This is a basic implementation for TCP connection testing.
:: Usage: nc [IP/Host] [Port]
:: Example: nc 192.168.1.1 80

if "%~2"=="" (
    echo Usage: nc [Host] [Port]
    echo Example: nc google.com 443
    exit /b 1
)

echo [INFO] Testing TCP connection to %1:%2 ...
powershell -NoProfile -Command "try { $t = Test-NetConnection -ComputerName '%1' -Port %2 -InformationLevel Quiet; if ($t) { Write-Host 'Connection Succeeded!' -ForegroundColor Green } else { Write-Host 'Connection Failed.' -ForegroundColor Red } } catch { Write-Host 'Error: Host not found or invalid.' -ForegroundColor Red }"