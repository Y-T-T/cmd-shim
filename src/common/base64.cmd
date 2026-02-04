@echo off
setlocal

:: ==================================================================================
:: Robust Base64 Tool
:: Description: Wrapper for PowerShell Base64 functions.
:: Fix: Replaced Write-Error with [Console]::Error for clean CLI output.
:: ==================================================================================

:: Capture all arguments exactly as typed
set "RAW_ARGS=%*"

:: Execute PowerShell logic
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference = 'Stop'; " ^
    "$inputArgs = $env:RAW_ARGS; " ^
    "if ([string]::IsNullOrWhiteSpace($inputArgs)) { " ^
    "    $inputData = @($Input); " ^
    "    if (-not $inputData) { [Console]::Error.WriteLine('Usage: base64 [file] OR base64 [string] OR pipeline'); exit 1 } " ^
    "    $payload = $inputData -join [char]10; " ^
    "    $mode = 'Encode'; " ^
    "} else { " ^
    "    $isDecode = $inputArgs -match '(?i)-d'; " ^
    "    if ($isDecode) { $mode = 'Decode' } else { $mode = 'Encode' }; " ^
    "    $payload = ($inputArgs -replace '(?i)-d','').Trim(); " ^
    "    $payload = $payload.Trim([char]34).Trim([char]39); " ^
    "    if ([string]::IsNullOrWhiteSpace($payload)) { " ^
    "        $inputData = @($Input); " ^
    "        if ($inputData) { $payload = $inputData -join [char]10 } " ^
    "    } " ^
    "} " ^
    "if ($mode -eq 'Decode') { " ^
    "    try { " ^
    "        $clean = $payload -replace '\s',''; " ^
    "        $bytes = [System.Convert]::FromBase64String($clean); " ^
    "        [System.Text.Encoding]::UTF8.GetString($bytes); " ^
    "    } catch { " ^
    "        [Console]::Error.WriteLine('base64: invalid input'); " ^
    "        exit 1; " ^
    "    } " ^
    "} else { " ^
    "    if ((Test-Path -Path $payload -PathType Leaf) -and (-not [string]::IsNullOrWhiteSpace($inputArgs))) { " ^
    "        [Convert]::ToBase64String([IO.File]::ReadAllBytes($payload)); " ^
    "    } else { " ^
    "        $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload); " ^
    "        [Convert]::ToBase64String($bytes); " ^
    "    } " ^
    "}"

exit /b %errorlevel%