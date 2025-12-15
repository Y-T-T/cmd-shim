@echo off
setlocal

set "MODE=FILE"
for %%i in (-r -rf -R) do (
    if "%~1"=="%%i" (
        set "MODE=RECURSIVE"
        shift
        goto :LOOP
    )
)
if "%~1"=="-f" (
    shift
)

:LOOP
if "%~1"=="" goto :EOF

set "TARGET=%~1"

if not exist "%TARGET%" (
    echo rm: cannot remove '%TARGET%': No such file or directory
    shift
    goto :LOOP
)

if exist "%TARGET%\" (
    if "%MODE%"=="RECURSIVE" (
        rd /S /Q "%TARGET%"
    ) else (
        echo rm: cannot remove "%TARGET%": Is a directory
    )
) else (
    del /Q /F "%TARGET%"
)

shift
goto :LOOP