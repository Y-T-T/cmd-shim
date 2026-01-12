@echo off
:: Maps wc (word count) using PowerShell Measure-Object
powershell -NoProfile -Command "Get-Content '%~1' | Measure-Object -Line -Word -Character"