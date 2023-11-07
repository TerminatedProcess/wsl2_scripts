Windows 11 utility scripts for WSL2 Backup and Restore of Containers
Author: Mark Ryan (terminatedprocess)

Overview:
The concept behind this script system is that you will backup using a script file. The backup script will backup your WSL container and date/time stamp it.  To restore, you would find the backup file, right-click it, and select RestoreToWSL. See below:

Caveats:
These tools should be cloned to c:\development\tools\wsltools. You can, of course, change this to your preferences, but will need to search for and replace the path with your custom path.

Tools:
1. setRestoreTOWSLUbuntu.reg
   -  Registry file to install a right-click option for restoring .vhdx files. DISCLAIMER - PLEASE READ FILE FIRST FOR YOUR OWN PEACE OF MIND.
   -  Once added to your registry, you can right-click on a .vdhx file and select <b>RestoreToWSL</b>.
   -  There are no stops here. If you right-click a .vdhx file and select this option to restore, it will replace your 
      current Ubuntu with the saved copy. 

6. bkupwslubuntu.ps1
   - On first run, you will be asked to enter the backup directory. This directory will contain a sub-folder for each distro.
   
   - Since VSCODE and Docker Desktop can interfere with the backup, a check is performed. 
     a. If VSCODE is running, just quit.
     b. If Docker Desktop is running, use the taskbar icon in the toolbar tray (far right icons) to QUIT DOCKER.
   
   - This backup routine will collect a list of distors. If only one distor, it will proceed with the backup. 
     If more than one, it will allow you to select your distro, defaulting to the last selection.
   
   - Selected distro will be backedup and saved to backup directory in a sub-folder matching the distro name.
     For example, if backup directory is c:/wslbackups (default), and you are backing up ubuntu, the destination directory is c:/wslbackups/ubuntu.
   
   - Last distro and backup directory are stored in file wslbackup.ini. This file is in the same location as the powershell script.
  
8. rbkupwslubuntu.bat
   - First install the setRestoreToWslUbuntu.reg file to install a right-click option for restoring a .vhdx.
   - Right-click on .vhdx and select RestoreToWSLUbuntu. 
   - The 1st word of the restore file is the name of the distro that will be restored. 
     For example: ubuntu-11-06-2023-21-41.vhdx will restore and show up in wsl -l -v as ubuntu.
   - The ext4.vhdx restored file will be located in the folder c:\wsldistro in a sub-folder matching the distro name.

For hot keys under windows, I use Executor. See this website https://executor.dk
1. Backup hotkey
   Command: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
   Parameter: -ExecutionPolicy Bypass -File  "C:\Development\tools\wsltools\bkupwslubuntu.ps1"
2. Hotkey for starting Windows Terminal
   Command: wt
   Parameter: -p Ubuntu
3. I also have hotkeys for starting Docker Desktop and for opening the backup directory.

Mark Ryan
mryan.dev@outlook.com
