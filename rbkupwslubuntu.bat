@echo off
cls
set wsl_os=Ubuntu
c:

IF [%1] == [] GOTO NoParam
REM #echo Restart Docker Desktop
REM pause
@echo on

wsl --terminate %wsl_os%
wsl --shutdown
wsl --unregister %wsl_os%
wsl --import %wsl_os% c:\wsl2distros %1% --vhd
wsl --setdefault %wsl_os%
ubuntu config --default-user dev
exit

:NoParam
echo No File parameter provided. Quit.
pause
