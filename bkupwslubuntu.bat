:: Use to create an importable bkup of wsl ubuntu
@echo off
cls
set wsl_os=%1
echo Backing up %wsl_os%
set wslroot=c:\wslbackups
set destDir=%wslroot%\%wsl_os%

:loopCheck
set retry=0

:: Check if Docker Desktop is running
tasklist /FI "IMAGENAME eq Docker Desktop.exe" 2>NUL | find /I /N "Docker Desktop.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo Docker Desktop is running. Please close it before proceeding with backup.
    set retry=1
)

:: Check if VSCode is running
tasklist /FI "IMAGENAME eq Code.exe" 2>NUL | find /I /N "Code.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo VSCode is running. Please close it before proceeding with backup.
    set retry=1
)

if "%retry%"=="1" (
    timeout /t 5 /nobreak >NUL
    goto loopCheck
)

set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%
set dateTimeStr=%CUR_MM%-%CUR_DD%-%CUR_YYYY%-%CUR_HH%-%CUR_NN%
set outFile=%destDir%\%wsl_os%-%dateTimeStr%.vhdx

:: Test to make sure output directory exists
if not exist "%destDir%\" (
    echo Directory not found. Creating %destDir%...
    mkdir "%destDir%"
)

:: backup to vhdx
@echo on
wsl --terminate %wsl_os%
wsl --shutdown
wsl --export %wsl_os% %outFile% --vhd
@echo off

:: Check if the backup file exists
if not exist "%outFile%" (
    echo ERROR! ERROR! ERROR!
    echo BACKUP FAILED! BACKUP FAILED!
    echo The backup file was not created successfully.
    echo Please check the WSL instance name and try again.
    echo ERROR! ERROR! ERROR!
    echo BACKUP FAILED! BACKUP FAILED!
) else (
    echo Backup completed successfully.
    explorer %destDir%
)

pause
::powershell start-process powershell -verb runas c:\development\tools\dockerrestart.ps1
::pause Might need to restart Docker Desktop
