@echo off
:: Maps 'uname' to system info
:: -a : All info (OS Name + Version + Architecture)

if "%1"=="-a" (
    echo Windows_NT %PROCESSOR_ARCHITECTURE%
    ver
) else (
    echo Windows_NT
)