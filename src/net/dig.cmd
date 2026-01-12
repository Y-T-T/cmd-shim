@echo off
:: Maps 'dig' to 'nslookup'
:: Note: Complex dig flags (like +short, +trace) are not supported in this simple shim.
:: Usage: dig [domain] [server - optional]

:: Example mapping for muscle memory:
:: Linux: dig google.com
:: Win:   nslookup google.com

nslookup %*