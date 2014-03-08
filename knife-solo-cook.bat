@echo off
setlocal

set hostname=%~n0

if not defined HOME set HOME=%HOMEDRIVE%%HOMEPATH%
set key=%HOME%\.ssh\%hostname%

pushd %~dp0..

ansicon knife.bat solo cook "chef@%hostname%" -i "%key%"

popd
pause
