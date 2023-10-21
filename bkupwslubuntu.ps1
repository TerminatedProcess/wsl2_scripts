function getConfigFile {
    # returns the config file path and file name
    $configFile = Join-Path $PSScriptRoot "wslbackup.ini"
    return $configFile
}


function Set-Data {
    # Creates a populated hashtable data object
    param (
        [string]$backupDir,
        [string]$lastDistro
    )

    # Returns a populated data object
    $iniData = @{
        backupDir  = $backupDir
        lastDistro = $lastDistro
    }

    return $iniData
}


function Write-Ini {
    # This function will update the config file with the contents of the data set.
    param (
        [hashtable]$data
    )

    $configFile = getConfigFile
    $data.GetEnumerator() | ForEach-Object {
        "$($_.Key)=$($_.Value)"
    } | Out-File $configFile
}

function Read-Ini {
    # This function will read the entries from the config file
    $configFile = getConfigFile

    if (Test-Path $configFile) {
        $iniContent = Get-Content $configFile | Out-String
        $iniContent = $iniContent -replace '\\', '\\\\' # Escape the backslashes
        $iniData = $iniContent | ConvertFrom-StringData
        $iniData = Set-Data $iniData["backupDir"] $iniData["lastDistro"]
    } else {
        $iniData = Set-Data "", ""
        Write-Ini -data $iniData
    }

    return $iniData
}



function Validate-BackupDir {
    # This function will get or create the ini file. If needed it will set the backup directory
    $iniData = Read-Ini # Get/create ini file
    $backupDir = $iniData["backupDir"]

    while ($true) {
        if (-Not [string]::IsNullOrWhiteSpace($backupDir) -and (Test-Path $backupDir -PathType Container)) {
            break # Exit the loop if a valid directory is provided
        }

        # Ask the user for the backup directory
        $backupDir = Read-Host "Please enter the path to the backup folder (default: C:\wslbackups)"
        
        if ([string]::IsNullOrWhiteSpace($backupDir)) {
            $backupDir = "C:\wslbackups"
        }

        if (-Not (Test-Path $backupDir -PathType Container)) {
            Write-Host "Directory does not exist. Please enter a valid directory."
        } else {
            # Update the ini file with the new backup directory
            $iniData["backupDir"] = $backupDir
            Write-Ini -data $iniData
        }
    }

    return $backupDir
}


function Select-Distro {
    # Get all installed distros minus any Docker instances.
    $distroList = Get-WSLDistros

    # Add "Cancel" as the last option in the distro list
    $distroList += "Cancel"

    $iniData = Read-Ini
    $previousSelection = $iniData["lastDistro"]

    $selectedIndex = $distroList.IndexOf($previousSelection)
    if ($selectedIndex -eq -1) { $selectedIndex = 0 }

        while ($true) {
            Clear-Host
            Write-Host "Please select a WSL distro to backup:"

            for ($i = 0; $i -lt $distroList.Length; $i++) {
                if ($i -eq $selectedIndex) {
                    Write-Host ("-> " + $distroList[$i]) -ForegroundColor Green
                } else {
                    Write-Host ("   " + $distroList[$i])
                }
            }

            $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

            switch ($key.VirtualKeyCode) {
                38 { if ($selectedIndex -gt 0) { $selectedIndex-- } } # Up arrow
                40 { if ($selectedIndex -lt $distroList.Length - 1) { $selectedIndex++ } } # Down arrow
                13 { # Enter to Select
                    $selectedDistro = ($distroList[$selectedIndex]).Trim()

                    # If "Cancel" is selected, exit the script
                    if ($selectedDistro -eq "Cancel") {
                        exit 0
                    }

                    $iniData = Read-Ini
                    $iniData["lastDistro"] = $selectedDistro
                    Write-Ini $iniData
                    return $selectedDistro
                }
            }
        }
}


function Get-WSLDistros_old {
    # Get the list of WSL distros
    $distros = wsl --list --quiet
    $distroList = $distros -split "`n" | Where-Object { $_ }

    # Exclude unwanted distros
    $excludedDistros = "docker-desktop", "docker-desktop-data"
    $distroList = $distroList | Where-Object { $_ -notin $excludedDistros }
    Analyze-String $distroList[2]
    return $distroList
}


function Get-WSLDistros {
    # Get the list of WSL distros
    $distros = wsl --list --quiet
    $distroList = $distros -split "`n" | Where-Object { $_ }

    # Exclude unwanted distros and remove null characters
    $excludedDistros = "docker-desktop", "docker-desktop-data"
    $cleanedDistroList = $distroList | Where-Object { $_ -notin $excludedDistros } | ForEach-Object {
        $_ -replace "`0", "" # Removing null characters
    }
    
    # Filter out empty strings and build the return list
    $returnList = @()
    foreach ($distro in $cleanedDistroList) {
        if ($distro) {
            $returnList += ,$distro
        }
    }

    return ,$returnList
}


function Check-Process {
    param (
        [string]$processName
    )
    
    $process = Get-Process | Where-Object { $_.Name -like $processName }
    return $process
}

####################################################################################
# Start of main code
Clear-Host

# Usage
$backupDir = Validate-BackupDir
#Read-Host "Press Enter"

$distro = Select-Distro
$iniData = Read-Ini
Clear-Host

# $destDir = Join-Path $wslroot $distro

# # Loop to check if Docker Desktop or VSCode is running
# do {
#     $retry = $false

#     if (Check-Process "Docker Desktop") {
#         Write-Host "Docker Desktop is running. Please close it before proceeding with backup."
#         $retry = $true
#     }

#     if (Check-Process "Code") {
#         Write-Host "VSCode is running. Please close it before proceeding with backup."
# #        $retry = $true
#     }

#     if ($retry) {
#         Start-Sleep -Seconds 5
#     }

# } while ($retry)

# $dateTimeStr = Get-Date -Format "MM-dd-yyyy-HH-mm"
# $outFile = Join-Path $destDir "$wsl_os-$dateTimeStr.vhdx"

# # Test to make sure output directory exists
# if (-Not (Test-Path $destDir)) {
#     Write-Host "Directory not found. Creating $destDir..."
#     New-Item -Path $destDir -ItemType Directory
# }

# # Backup to vhdx
# Write-Host "Backing up $wsl_os"
# #wsl --terminate $wsl_os
# #wsl --shutdown
# #wsl --export $wsl_os $outFile --vhd

# # Check if the backup file exists
# if (-Not (Test-Path $outFile)) {
#     Write-Host "ERROR! ERROR! ERROR!"
#     Write-Host "BACKUP FAILED! BACKUP FAILED!"
#     Write-Host "The backup file was not created successfully."
#     Write-Host "Please check the WSL instance name and try again."
#     Write-Host "ERROR! ERROR! ERROR!"
#     Write-Host "BACKUP FAILED! BACKUP FAILED!"
# } else {
#     Write-Host "Backup completed successfully."
#     explorer $destDir
# }

Read-Host "Press Enter to exit..."
