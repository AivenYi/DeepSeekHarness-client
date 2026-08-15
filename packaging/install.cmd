@echo off
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%PS%" set "PS=%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%PS%" exit /b 9009
"%PS%" -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -Interactive
exit /b %errorlevel%
