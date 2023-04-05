Windows 11 utility scripts for WSL2
Assumptions:
1. c:\wslbackups is destination for backups
2. c:\wsldistros is location where restored backups will be instantiated.
3. Backup/Restore is the .vhdx file.
4. Uses arguments only available in Windows 11. If you are on Win10, you 
   may need to use .tar instead. Tar is much slower, but smaller backups. The .vdhx backup however is seriously fast.

Tools:
1. bkupwslubuntut.bat
   - Set a hotkey for this. This bat file will backup your current Ubuntu to c:\wslbackups with date/time stamp.
   - if you are using Docker for Desktop, you will need to run the DockerRestart.ps1 to free up locked resources.
   - if you are not using Docker, you can comment out the Docker pause.

2. rbkupwslubuntu.bat
   - First install the setRestoreToWslUbuntu.reg file to install a right-click option for restoring a .vhdx.
   - Right-click on .vhdx and select RestoreToWSLUbuntu. 
   - If you are using Docker, you will need to restart Docker.
   - if you do not have support for .vhdx (older windows 10 systems), you may have to modify this to use .tar files.

3. setRestoreTOWSLUbuntu.reg
   - Registry file to install a right-click option for restoring .vhdx files. DISCLAIMER - PLEASE READ IT FIRST.
   - For windows 10, you may need to modify this to restore a .tar file. 

4. cmdDockerRestart.bat
   - Executes dockerrestart.ps1. I'm sure there is a better way, but I didn't have time to delve into Powershell.

5. cmdDockerStop.bat
   - This script stops Dockeri

For hot keys under windows, I use Executor. See this website https://executor.dk

Mark Ryan
mryan.dev@outlook.com
