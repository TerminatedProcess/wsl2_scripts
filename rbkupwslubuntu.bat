@echo off
cls

IF [%1] == [] GOTO NoParam

:: Extract the first part of the filename
for /f "delims=-" %%a in ("%~n1") do set "wsl_os=%%a"
set destDir=c:\wsl2distros\%wsl_os%
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
:: ubuntu config --default-user dev
:: instead setup wsl.config default section
pause
exit

:NoParam
echo No File parameter provided. Quit.
pause
