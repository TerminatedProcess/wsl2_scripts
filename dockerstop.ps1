Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Attempting to stop Docker Desktop..."

# Stop Docker Desktop service if it exists and is running
$dockerService = Get-Service -Name 'com.docker.service' -ErrorAction SilentlyContinue
if ($dockerService -and $dockerService.Status -eq 'Running') {
    Stop-Service $dockerService.Name -Force
    Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Docker service stopped."
} else {
    Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Docker service not running or not found."
}

# Stop Docker Desktop processes
$dockerProcesses = Get-Process -Name 'Docker*' -ErrorAction SilentlyContinue
if ($dockerProcesses) {
    $dockerProcesses | Stop-Process -Force
    Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Docker processes stopped."
} else {
    Write-Output "$((Get-Date).ToString("HH:mm:ss")) - No Docker processes found."
}

Write-Output "$((Get-Date).ToString("HH:mm:ss")) - Docker Desktop should now be stopped."
