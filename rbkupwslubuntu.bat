@echo off
cls

IF [%1] == [] GOTO NoParam

:: Extract the first part of the filename
for /f "delims=-" %%a in ("%~n1") do set "wsl_os=%%a"
set destDir=c:\wsldistros\%wsl_os%
set inFile=%1

:: Check for existence of the destination directory and create if not present
if not exist "%destDir%\" mkdir "%destDir%"

:: Default to C: so we are not using a subst drive letter which causes errors
c:

REM #echo Restart Docker Desktop
REM pause

@echo on

wsl --terminate %wsl_os%
wsl --shutdown
wsl --unregister %wsl_os%
wsl --import %wsl_os% %destDir% %inFile% --vhd
wsl --setdefault %wsl_os%
@echo off
echo To set default user (example is username dev)
echo sudo vi /etc/wsl.conf. Add the following:
echo [user]
echo default=dev

pause
exit

:NoParam
echo No File parameter provided. Quit.
pause
