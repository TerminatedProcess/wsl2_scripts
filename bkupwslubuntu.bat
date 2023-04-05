:: Use to create an importable bkup of wsl ubuntu
cls
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
echo CLOSE VSCODE AND OTHER WINDOWS
pause Make sure everything is CLOSED! and Restart Docker Desktop
wsl --terminate Ubuntu
wsl --shutdown
@echo off
set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)
set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%
::set SUBFILENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%-%CUR_HH%%CUR_NN%%CUR_SS%
set SUBFILENAME=%CUR_MM%-%CUR_DD%-%CUR_YYYY%-%CUR_HH%-%CUR_NN%
@echo on
wsl --export Ubuntu C:\wslbackups\Ubuntu-%SUBFILENAME%.vhdx --vhd
explorer c:\wslbackups
pause
::powershell start-process powershell -verb runas c:\development\tools\dockerrestart.ps1
::pause Might need to restart Docker Desktop

