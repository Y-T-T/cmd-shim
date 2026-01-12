@echo off
:: Maps 'uptime' using PowerShell
:: Calculates system uptime precisely

powershell -NoProfile -Command "$os = Get-CimInstance Win32_OperatingSystem; $uptime = (Get-Date) - $os.LastBootUpTime; Write-Host \"Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes\""