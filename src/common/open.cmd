@echo off
:: Maps 'open' (Mac) or 'xdg-open' (Linux) to Windows 'start'
:: The first empty quote "" is required because 'start' treats the first quoted argument as Window Title.

if "%~1"=="" (
    start .
) else (
    start "" "%~1"
)