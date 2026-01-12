@echo off
:: Maps 'sca' to Fortify Static Code Analyzer command-line tool 'sourceanalyzer'
where sourceanalyzer >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] 'sourceanalyzer' not found. Please install Fortify SCA and ensure it is in your PATH.
    exit /b 1
)

sourceanalyzer %*