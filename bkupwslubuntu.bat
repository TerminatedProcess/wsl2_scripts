:: Use to create an importable bkup of wsl ubuntu
@echo off
cls
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS

set wsl_os=%1
set destDir=c:\wslbackups\%wsl_os%

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

echo Backing up %wsl_os%
pause Make sure everything is CLOSED! and SHUTDOWN Docker Desktop

:: Test to make sure output directory exists
if not exist "%destDir%\" (
    echo Directory not found. Creating %destDir%...
    mkdir "%destDir%"
)

:: backup to vhdx
wsl --terminate %wsl_os%
wsl --shutdown
@echo on
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
