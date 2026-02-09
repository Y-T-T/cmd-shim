:: ls command implementation for Windows
:: Note: In PowerShell, 'ls' is a built-in alias for 'Get-ChildItem'.
:: This shim will NOT be executed unless you remove the alias:
:: Run "Remove-Item alias:ls" in your PowerShell profile.

@echo off
if "%~1"=="" (
    dir
) else (
    dir %*
)