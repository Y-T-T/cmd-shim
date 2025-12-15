@echo off
echo Adding %~dp0bin to System Path...
setx PATH "%PATH%;%USERPROFILE%\bin"
echo Done! Please restart your terminal.
pause