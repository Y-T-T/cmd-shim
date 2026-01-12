@echo off
:: Smart diff shim
:: 1. Tries to use 'git diff' (Best output, colored)
:: 2. Fallback to PowerShell Compare-Object
:: 3. Fallback to native 'fc' (Last resort)

:: Try Git Diff first (can diff files even if not in a git repo)
where git >nul 2>nul
if %errorlevel%==0 (
    :: --no-index allows diffing any two files
    :: --color=always forces colored output
    git diff --no-index --color=always %1 %2
    exit /b
)

:: If Git is not installed, use native fc
fc %1 %2