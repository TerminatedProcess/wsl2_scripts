Windows 11 utility scripts for WSL2 Backup and Restore of Containers
Author: Mark Ryan (terminatedprocess)

Overview:
The concept behind this script system is that you will backup using a script file. The backup script will backup your WSL container and date/time stamp it.  To restore, you would find the backup file, right-click it, and select RestoreToWSL. See below:

Caveats:
These tools should be cloned to c:\development\tools\wsltools. You can, of course, change this to your preferences, but will need to search for and replace the path with your custom path.

Tools:
1. setRestoreTOWSLUbuntu.reg
   -  Registry file to install a right-click option for restoring .vhdx files. DISCLAIMER - PLEASE READ FILE FIRST FOR YOUR OWN PROTECTION.
   -  Once added to your registry, you can right-click on a .vdhx file and select <b>RestoreToWSL</b>.
   -  There are no stops here. If you right-click a .vdhx file and select this option to restore, it will replace your 
      current Ubuntu with the saved copy. 

6. bkupwslubuntu.ps1
   - Since VSCODE and Docker Desktop can interfere with 
   - This backup routine will collect a list of distors. If only one distor, it will proceed with the backup. 
     If more than one, it will allow you to select your distro, defaulting to the last selection.



   - Selected distro will be backedup and saved to backup directory under the distro name.
   - For example, if backup directory is c:/wslbackups (default), and you are backing up ubuntu, the destination directory is c:/wslbackups/ubuntu.
   - On first run you will be required to enter the backup directory. Default is c:/wslbackups. Directory must exist.
   - Last distro selected for backup will be automatically re-selected in the list.
   - Last distro and backup directory are stored in file wslbackup.ini. This file is in the same location as the powershell script.
   - If there is only one distro then user will not be presented with a selection list (time-saver).
  
7. dockerstop.ps1
   - This script stops Docker Desktop. You need to do this before backing up or the backup will fail.

8. rbkupwslubuntu.bat
   - First install the setRestoreToWslUbuntu.reg file to install a right-click option for restoring a .vhdx.
   - Right-click on .vhdx and select RestoreToWSLUbuntu. 
   - After, if you are using Docker, you will need to restart Docker.
   - This batch file looks at the file name paramter deriving the name of the wsl2 instance. E.g. ubuntu.
   - The vdhx file is restored to c:\wsldistros\<<name of wsl2 instance>>. E.g. c:\wsldistros\ubuntu\ext4.vdhx

9. cmdDockerRestart.bat
   - not in use. However, I don't want to toss the code. Instead, create a shortcut to Docker Desktop and if you like, set a hotkey.

For hot keys under windows, I use Executor. See this website https://executor.dk

Mark Ryan
mryan.dev@outlook.com
