@echo off
setlocal

:: =================Setup=================
:: Source: the "bin" folder next to the current script
set "SOURCE_DIR=%~dp0bin"
:: Destination: C:\Users\User\.local\bin
set "DEST_BASE=%USERPROFILE%\.local"
set "DEST_DIR=%DEST_BASE%\bin"
:: =========================================

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

:: Copy files
if exist "%SOURCE_DIR%\*.cmd" (
    copy /Y "%SOURCE_DIR%\*.cmd" "%DEST_DIR%\" > nul
    echo    - Installed .cmd scripts.
) else (
    echo    [ERROR] No .cmd files found in "%SOURCE_DIR%"
    pause
    exit /b 1
)

:: if there are .bat files, copy them as well
if exist "%SOURCE_DIR%\*.bat" (
    copy /Y "%SOURCE_DIR%\*.bat" "%DEST_DIR%\" > nul 2>&1
)

echo.
echo [3/3] Updating User Path...

:: Add .local\bin to PATH if not already present
powershell -Command "$target='%DEST_DIR%'; $current=[Environment]::GetEnvironmentVariable('Path', 'User'); if ($current -split ';' -contains $target) { Write-Host '   [INFO] .local\bin is already in your PATH.' -ForegroundColor Yellow } else { [Environment]::SetEnvironmentVariable('Path', $current + ';' + $target, 'User'); Write-Host '   [SUCCESS] Added .local\bin to User PATH.' -ForegroundColor Green }"

echo.
echo ==============================================
echo  Installation Complete!
echo  Location: %DEST_DIR%
echo ==============================================
echo.
pause