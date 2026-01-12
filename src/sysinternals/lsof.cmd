@echo off
:: lsof equivalent using Sysinternals Handle
:: Requires handle.exe in PATH or specify full path
handle -a -u %*