Windows 11 utility scripts for WSL2
These Utilities allow you to easily backup and restore your Ubuntu WSL2 instance.

Tools:
1. setRestoreTOWSLUbuntu.reg
   -  Registry file to install a right-click option for restoring .vhdx files. DISCLAIMER - PLEASE READ FILE FIRST.
   -  Once added to your registry, you can right-click on a .vdhx file and select RestoreToWSLUbuntu.
   -  There are no stops here. If you right-click a .vdhx file and select this option to restore, it will replace your 
      current Ubuntu with the saved copy. 

2. cmdDockerStop.bat
   - This script stops Docker Desktop. You need to do this before backing up or the backup will fail.

3. bkupwslubuntut.bat
   - This still works, but is deprecated. It is replaced by bkupwslubuntu.ps1
   - Set a hotkey for this. This bat file will backup your current Ubuntu to c:\wslbackups with date/time stamp.
   - This batch file will accept one parameter with the name of the wsl instance you are backing up. E.g. ubuntu
   - if you are using Docker for Desktop, you will need to run the DockerRestart.ps1 to free up locked resources.
   - if you are not using Docker, you can comment out the Docker pause.
   - Backup file is saved to c:\wslbackups\<<name of wsl2 instance>>. E.g. c:\wslbackups\ubuntu.

4. rbkupwslubuntu.bat
   - First install the setRestoreToWslUbuntu.reg file to install a right-click option for restoring a .vhdx.
   - Right-click on .vhdx and select RestoreToWSLUbuntu. 
   - After, if you are using Docker, you will need to restart Docker.
   - This batch file looks at the file name paramter deriving the name of the wsl2 instance. E.g. ubuntu.
   - The vdhx file is restored to c:\wsldistros\<<name of wsl2 instance>>. E.g. c:\wsldistros\ubuntu\ext4.vdhx

5. cmdDockerRestart.bat
   - not in use. However, I don't want to toss the code. Instead, create a shortcut to Docker Desktop and if you like, set a hotkey.

6. bkupwslubuntu.ps1
   - This backup routine will present the user with a list of available distros.
   - Selected distro will be backedup and saved to backup directory under the distro name.
   - For example, if backup directory is c:/wslbackups (default), and you are backing up ubuntu, the destination directory is c:/wslbackups/ubuntu.
   - On first run you will be required to enter the backup directory. Default is c:/wslbackups. Directory must exist.
   - Last distro selected for backup will be automatically re-selected in the list.
   - Last distro and backup directory are stored in file wslbackup.ini. This file is in the same location as the powershell script.
   - If there is only one distro then user will not be presented with a selection list (time-saver).
  
For hot keys under windows, I use Executor. See this website https://executor.dk

Mark Ryan
mryan.dev@outlook.com
