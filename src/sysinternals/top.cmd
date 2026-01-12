@echo off
:: Maps 'top' to Process Explorer (GUI) or PsList (CLI)

:: Mode 1: If the -c parameter is added, run the command-line version (PsList in spy mode)
if "%1"=="-c" (
    pslist64.exe -s -r 2
    exit /b
)

:: Mode 2 (default): Launch Process Explorer (the most powerful Task Manager)
start procexp.exe