@echo off
:: Maps 'shred' to sdelete64
:: Auto-adds '-s' to handle directories recursively (solving native shred limitation)

if "%~1"=="" (
    echo Usage: shred [file_or_dir]
    exit /b 1
)

:: -p 3: Overwrite 3 times (DOD standard)
:: -s: Recurse subdirectories
sdelete64.exe -p 3 -s %*