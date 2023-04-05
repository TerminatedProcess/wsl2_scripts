@echo off
cls
c:
IF [%1] == [] GOTO NoParam
echo Restart Docker Desktop
pause
@echo on
wsl --terminate Ubuntu
wsl --shutdown
wsl --unregister ubuntu
wsl --import Ubuntu c:\wsl2distros %1% --vhd
wsl --setdefault Ubuntu
ubuntu config --default-user dev
exit
:NoParam
echo No File parameter provided. Quit.
pause
