@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Scan-WiFi.ps1"
start "" "%~dp0index.html"
pause
