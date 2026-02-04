@echo off
:: Only handles doskey commands for aliasing
:: Cannot work with powershell functions or scripts
:: Get all parameters
setlocal EnableDelayedExpansion
set "params=%*"

:: If no parameters, list current macros (mimics Linux standalone alias)
if "!params!"=="" (
    doskey /macros
    goto :eof
)

:: Handle Linux syntax: remove single quotes '
:: Linux: alias ll='ls -l' -> CMD: doskey ll=ls -l
set "params=!params:'=!"

:: Check if it is an assignment (contains =)
echo !params! | findstr "=" >nul
if errorlevel 1 (
    :: Not an assignment, just run doskey (e.g. doskey /macros)
    doskey !params!
    goto :eof
)

:: Parse key=value to create a shim file
for /f "tokens=1* delims==" %%A in ("!params!") do (
    set "key=%%A"
    set "val=%%B"
)

:: Trim spaces
for %%I in ("!key!") do set "key=%%~I"
:: (Value trimming is harder in batch and usually preserved for arguments)

if "!val!"=="" (
    :: Deletion case: alias test=
    if exist "%~dp0!key!.cmd" (
        del "%~dp0!key!.cmd"
        echo [INFO] Removed shim: !key!.cmd
    )
    doskey !key!=
) else (
    :: Creation case: Create a physical .cmd file
    echo @echo off > "%~dp0!key!.cmd"
    
    :: Remove all double quotes from the value for the shim file to avoid syntax errors
    :: e.g. converts "ls -l" to ls -l, or ls -l" to ls -l
    set "clean_val=!val:"=!"
    echo !clean_val! %%* >> "%~dp0!key!.cmd"
    
    :: Still register doskey for current CMD compatibility
    doskey !params!
    echo [INFO] Created shim: !key! -^> !val!
)
endlocal