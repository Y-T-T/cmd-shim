@echo off
setlocal EnableDelayedExpansion

:: =================Setup=================
:: Source Root: The "src" folder next to the script
set "SRC_ROOT=%~dp0src"
:: Destination: C:\Users\User\.local\bin
set "DEST_BASE=%USERPROFILE%\.local"
set "DEST_DIR=%DEST_BASE%\bin"

:: Initialize Flags (0=False, 1=True)
set "INSTALL_NET=0"
set "INSTALL_SYS=0"
set "INSTALL_CUS=0"
:: =========================================

:: --- 1. Argument Parsing ---
:parse_args
if "%~1"=="" goto :check_dest

if /i "%~1"=="--net" set "INSTALL_NET=1"
if /i "%~1"=="--sysinternals" set "INSTALL_SYS=1"
if /i "%~1"=="--customs" set "INSTALL_CUS=1"
if /i "%~1"=="--all" (
    set "INSTALL_NET=1"
    set "INSTALL_SYS=1"
    set "INSTALL_CUS=1"
)

:: Warn on unknown arguments
if /i not "%~1"=="--net" if /i not "%~1"=="--sysinternals" if /i not "%~1"=="--customs" if /i not "%~1"=="--all" (
    echo [WARN] Unknown argument ignored: %~1
)

shift
goto :parse_args

:check_dest
echo.
echo [1/3] Checking destination directory...

:: Create destination directory if it doesn't exist
if not exist "%DEST_DIR%" (
    echo    - Creating "%DEST_DIR%"...
    mkdir "%DEST_DIR%"
) else (
    echo    - Directory exists.
)

echo.
echo [2/3] Installing scripts...

:: --- 2. Install Common (Default) ---
echo    - [Common] Installing defaults...
if exist "%SRC_ROOT%\common\*.cmd" (
    xcopy /Y /Q "%SRC_ROOT%\common\*.cmd" "%DEST_DIR%\" >nul
) else (
    echo      [WARN] No common scripts found in src\common
)

:: --- 3. Install Net Modules ---
if "%INSTALL_NET%"=="1" (
    echo    - [Net] Installing network tools...
    if exist "%SRC_ROOT%\net\*.cmd" (
        xcopy /Y /Q "%SRC_ROOT%\net\*.cmd" "%DEST_DIR%\" >nul
    ) else (
        echo      [WARN] No scripts found in src\net
    )
)

:: --- 4. Install Sysinternals Modules ---
if "%INSTALL_SYS%"=="1" (
    echo    - [Sysinternals] Installing sysinternals wrappers...
    if exist "%SRC_ROOT%\sysinternals\*.cmd" (
        xcopy /Y /Q "%SRC_ROOT%\sysinternals\*.cmd" "%DEST_DIR%\" >nul
    ) else (
        echo      [WARN] No scripts found in src\sysinternals
    )
)

:: --- 5. Install Customs ---
if "%INSTALL_CUS%"=="1" (
    echo    - [Customs] Installing custom scripts...
    if exist "%SRC_ROOT%\customs\*.cmd" (
        xcopy /Y /Q "%SRC_ROOT%\customs\*.cmd" "%DEST_DIR%\" >nul
    ) else (
        echo      [WARN] No scripts found in src\customs
    )
)

echo.
echo [3/3] Updating User Path...

:: Add .local\bin to PATH if not already present
powershell -Command "$target='%DEST_DIR%'; $current=[Environment]::GetEnvironmentVariable('Path', 'User'); if ($current -split ';' -contains $target) { Write-Host '   [INFO] .local\bin is already in your PATH.' -ForegroundColor Yellow } else { [Environment]::SetEnvironmentVariable('Path', $target + ';' + $current, 'User'); Write-Host '   [SUCCESS] Added .local\bin to User PATH.' -ForegroundColor Green }"

echo.
echo ==============================================
echo  Installation Complete!
echo  Location: %DEST_DIR%
echo ==============================================
echo.
pause