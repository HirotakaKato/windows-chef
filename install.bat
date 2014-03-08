@echo off
setlocal

set ansicon_version=1.66
set git_version=1.9.0-preview20140217
set chef_version=11.10.4-1

whoami /groups | findstr /c:"Mandatory Label\High Mandatory Level" > nul
if errorlevel 1 (
	echo Please run as administrator.
	pause
	exit /b 1
)

set ansicon_zip=ansi%ansicon_version:.=%.zip
set ansicon_url=https://github.com/adoxa/ansicon/releases/download/v%ansicon_version%/%ansicon_zip%
set ansicon_subdir=x86
if defined ProgramW6432 set ansicon_subdir=x64

set git_7z=PortableGit-%git_version%.7z
set git_url=http://msysgit.googlecode.com/files/%git_7z%
set git_path=%SystemDrive%\git\bin

set chef_msi=chef-client-%chef_version%.windows.msi
set chef_url=http://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/%chef_msi%
set chef_path=%SystemDrive%\opscode\chef\bin

set github=https://raw.github.com/HirotakaKato/windows-chef/master

set sevenzip=%git_path%\7za.exe
set sevenzip_url=%github%/7za920/7za.exe

set solo_bat=%~dp0solo.bat
set solo_bat_url=%github%/solo.bat

set solo_json=%~dp0solo.json
set solo_json_url=%github%/solo.json

set solo_rb=%~dp0solo.rb
set solo_rb_url=%github%/solo.rb

set knife_solo_cook_bat=%~dp0knife-solo-cook.bat
set knife_solo_cook_bat_url=%github%/knife-solo-cook.bat

set knife_solo_prepare_bat=%~dp0knife-solo-prepare.bat
set knife_solo_prepare_bat_url=%github%/knife-solo-prepare.bat

set clone_dir=%~dp0cookbooks
set repository=https://github.com/HirotakaKato/windows-cookbooks.git

if not exist "%git_path%" mkdir "%git_path%"

if not exist "%sevenzip%" (
	echo Downloading %sevenzip_url%
	powershell "(New-Object System.Net.WebClient).DownloadFile('%sevenzip_url%', '%sevenzip%')"
	echo.
)

if not exist "%git_path%\ansicon.exe" (
	echo Downloading %ansicon_url%
	powershell "(New-Object System.Net.WebClient).DownloadFile('%ansicon_url%', '%ansicon_zip%')"
	echo.

	echo Extracting %ansicon_zip%
	"%sevenzip%" e -y -o"%git_path%" "%TMP%\%ansicon_zip%" "%ansicon_subdir%\*" > nul
	echo.

	del "%TMP%\%ansicon_zip%"
)

if not exist "%git_path%\git.exe" (
	echo Downloading %git_url%
	powershell "(New-Object System.Net.WebClient).DownloadFile('%git_url%', '%TMP%\%git_7z%')"
	echo.

	echo Extracting %git_7z%
	"%sevenzip%" x -y -o"%git_path:\bin=%" "%TMP%\%git_7z%" > nul
	echo.

	del "%TMP%\%git_7z%"
)

path | findstr /c:"%git_path%" > nul
if errorlevel 1 set  Path=%Path%;%git_path%
if errorlevel 1 setx Path "%Path%" /m > nul

if not exist "%chef_path%\chef-solo.bat" (
	echo Downloading %chef_url%
	echo.
	curl -o "%TMP%\%chef_msi%" "%chef_url%"
	echo.

	echo Installing Chef
	"%TMP%\%chef_msi%" /passive
	echo.

	del "%TMP%\%chef_msi%"
)

if not exist "%~dp0nodes\prepare" mkdir "%~dp0nodes\prepare"

if not exist "%solo_bat%" (
	echo Downloading %solo_bat_url%
	echo.
	curl -o "%solo_bat%" "%solo_bat_url%"
	echo.
)

if not exist "%solo_json%" (
	echo Downloading %solo_json_url%
	echo.
	curl -o "%solo_json%" "%solo_json_url%"
	echo.
)

if not exist "%solo_rb%" (
	echo Downloading %solo_rb_url%
	echo.
	curl -o "%solo_rb%" "%solo_rb_url%"
	echo.
)

if not exist "%knife_solo_cook_bat%" (
	echo Downloading %knife_solo_cook_bat_url%
	echo.
	curl -o "%knife_solo_cook_bat%" "%knife_solo_cook_bat_url%"
	echo.
)

if not exist "%knife_solo_prepare_bat%" (
	echo Downloading %knife_solo_prepare_bat_url%
	echo.
	curl -o "%knife_solo_prepare_bat%" "%knife_solo_prepare_bat_url%"
	echo.
)

if not exist "%clone_dir%" (
	git clone --recursive "%repository%" "%clone_dir%"
	echo.
)

pause
