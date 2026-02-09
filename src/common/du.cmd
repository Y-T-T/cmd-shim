@echo off
:: Maps 'du' to PowerShell measure-object
:: Usage: du [-h] [-s] [path]

:: if systeminternal suite is installed, use du64.exe for better performance on large directories
where du64.exe >nul 2>nul
if %errorlevel%==0 (
    du64.exe -nobanner -q %*
    exit /b
)

powershell -NoProfile -Command ^
    "& { " ^
    "$target = '.'; $summary = $false; $human = $false; " ^
    "foreach($a in $args) { " ^
    "  if($a -match '^-') { " ^
    "    if($a -match 'h') { $human = $true }; " ^
    "    if($a -match 's') { $summary = $true }; " ^
    "    continue " ^
    "  } " ^
    "  $target = $a " ^
    "} " ^
    "function Get-Size($p) { (Get-ChildItem $p -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum }; " ^
    "function Fmt($n) { " ^
    "  if(!$human) { return [math]::Ceiling($n/1KB) } " ^
    "  if($n -ge 1GB) { return '{0:N2}G' -f ($n/1GB) } " ^
    "  if($n -ge 1MB) { return '{0:N2}M' -f ($n/1MB) } " ^
    "  return '{0:N2}K' -f ($n/1KB) " ^
    "}; " ^
    "if($summary) { " ^
    "  $s = Get-Size $target; " ^
    "  Write-Host (\"{0}`t{1}\" -f (Fmt $s), (Resolve-Path $target -ErrorAction SilentlyContinue)) " ^
    "} else { " ^
    "  $sub = Get-ChildItem $target -Force -ErrorAction SilentlyContinue; " ^
    "  foreach($i in $sub) { " ^
    "    if($i.PSIsContainer) { $s = Get-Size $i.FullName } else { $s = $i.Length }; " ^
    "    Write-Host (\"{0}`t{1}\" -f (Fmt $s), $i.Name) " ^
    "  } " ^
    "} " ^
    "}" ^
    -Args %*
