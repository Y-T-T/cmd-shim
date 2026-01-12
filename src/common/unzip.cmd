@echo off
:: Usage: unzip [file.zip]
:: Example: unzip data.zip

if "%~1"=="" (
    echo Usage: unzip [file.zip]
    exit /b 1
)

:: -DestinationPath '.': Extract to the current directory (mimics Linux default behavior)
:: -Force: Overwrite existing files without prompting (mimics unzip -o)
powershell -NoProfile -Command "Expand-Archive -Path '%~1' -DestinationPath '.' -Force"


:: Faster unzip using native tar.exe (Windows 10 build 17063+)
:: Uncomment the following line and comment out the PowerShell Expand-Archive line
:: to use tar instead of PowerShell Expand-Archive
:: -x: extract, -f: file
@REM tar -xf %1