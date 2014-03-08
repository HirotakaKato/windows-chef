@echo off
setlocal

whoami /groups | findstr /c:"Mandatory Label\High Mandatory Level" > nul
if errorlevel 1 (
	echo Please run as administrator.
	pause
	exit /b 1
)

ansicon chef-solo.bat --color -c "%~dpn0.rb"

pause
