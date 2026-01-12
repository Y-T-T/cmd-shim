@echo off
:: Simple Base64 Encoder/Decoder
:: Usage: base64 [file] (encodes)
::        base64 -d [string] (decodes string) - simple wrapper idea

if "%1"=="-d" (
    powershell -NoProfile -Command "[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('%2'))"
) else (
    powershell -NoProfile -Command "[Convert]::ToBase64String([IO.File]::ReadAllBytes('%1'))"
)