@echo off
setlocal

set hostname=%~n0

if not defined HOME set HOME=%HOMEDRIVE%%HOMEPATH%
set key=%HOME%\.ssh\%hostname%

pushd %~dp0..\..

if not exist "%key%" ssh-keygen -N "" -C "chef@%hostname%" -f "%key%"

ssh-keygen -R "%hostname%" 2> nul
del "%HOME%\.ssh\known_hosts.old"

type "%key%.pub" | ssh -o StrictHostKeyChecking=no "root@%hostname%" "useradd chef && mkdir ~chef/.ssh && cat > ~chef/.ssh/authorized_keys && chown -R chef:chef ~chef/.ssh && chmod -R u=rwX,go= ~chef/.ssh && echo -e 'Defaults:chef !requiretty\\nchef ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/chef && chmod 440 /etc/sudoers.d/chef"

ansicon knife.bat solo prepare "chef@%hostname%" -i "%key%"
ansicon knife.bat solo cook    "chef@%hostname%" -i "%key%" -o prepare

popd
pause
