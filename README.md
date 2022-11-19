Windows 11 utility scripts for WSL2
Assumptions:
1. c:\wslbackups is destination for backups
2. c:\wsldistros is location where restored backups will be instantiated.
3. Backup/Restore is the .vhdx file.
4. Uses arguments only available in Windows 11. If you are on Win10, you will need to adjust the arguments
   to use .tar instead. Tar is much slower, but smaller backups. The .vdhx backup however is seriously fast.

Tools:
1. bkupwslubuntut.bat
   - Set a hotkey for this. This bat file will backup your current Ubuntu to c:\wslbackups with date/time stamp.
   - if you are using Docker for Desktop, you will need to run the DockerRestart.ps1 to free up locked resources.
   - if you are not using Docker, you can comment out the Docker pause.

2. rbkupwslubuntu.bat
   - Install the setRestoreToWslUbuntu.reg file to install a right-click option for restoring a .vhdx.
   - Right-click on .vhdx and select RestoreToWSLUbuntu. 
   - If you are using Docker, you will need to restart Docker.

3. setRestoreTOWSLUbuntu.reg
   - Registry file to install a right-click option for restoring .vhdx files.
   - For windows 10, you will need to modify this to restore a .tar file. 

4. dockerrestart.ps1
   - Will restart Docker for Desktop. Once it says restarting docker, you can proceed with backup/restore in other scripts.

5. cmdDockerRestart.bat
   - Executes dockerrestart.ps1. I'm sure there is a better way, but I didn't have time to delve into Powershell.

6. cmdDockerStop.bat
   - Just stops Docker, but does not restart.