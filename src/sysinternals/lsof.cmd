@echo off
setlocal
:: ============================================================
:: lsof shim using Sysinternals Handle + Netstat
:: Dependency: Sysinternals handle.exe (must be in PATH)
:: ============================================================

:: 1. Intercept network request (-i / -P) -> Use netstat
::    Simple check: if arguments contain "-i", switch to netstat
echo %* | findstr /i "\-i" >nul
if not errorlevel 1 (
    echo [INFO] 'lsof -i' detected: switching to 'netstat -ano'
    
    set "FILTER="
    setlocal EnableDelayedExpansion
    for %%A in (%*) do (
        :: Check for simple port filter like :8080
        echo %%A| findstr "^:[0-9]" >nul
        if not errorlevel 1 set "FILTER=%%A"
    )
    
    if defined FILTER (
        echo [INFO] Filtering specifically for "!FILTER!"
        netstat -ano | findstr "!FILTER!"
    ) else (
        endlocal
        netstat -ano
    )
    exit /b
)

:: 2. Check for handle.exe availability
where handle >nul 2>nul
if errorlevel 1 (
    echo [ERROR] 'handle.exe' not found.
    echo         This command relies on Sysinternals Handle tool to list open files.
    echo         Please install it ^(e.g., choco install handle^) or add it to PATH.
    exit /b 1
)

:: 3. Run handle
:: -accepteula : Auto-accept license to avoid GUI hang/prompt
:: -nobanner   : Hide copyright header
:: -u          : Show username checking the handle
handle -accepteula -nobanner -u %*

if errorlevel 1 (
    echo.
    echo [WARN] 'handle' found nothing or failed.
    echo        Make sure you are running as Administrator (Required to see handle info).
)
endlocal