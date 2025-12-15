@echo off
set "CURRENT_DIR=%CD%"

powershell -Command "Start-Process cmd -ArgumentList '/k cd /d """%CURRENT_DIR%""" && %*' -Verb RunAs"