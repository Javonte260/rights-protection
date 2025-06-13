# Auto-update Pepperoni.zip, GitHub, and refresh shortcut after changes
param (
    [string]$SourceDir = "C:\Users\Javonte\Desktop\rights-protection",
    [string]$ZipPath = "C:\Users\Javonte\Desktop\Pepperoni.zip",
    [string]$GitHubUsername = "javonte260",
    [string]$RepoName = "rights-protection",
    [string]$ShortcutName = "SafeDocsGenerator Website",
    [string]$TargetURL = "http://$GitHubUsername.github.io/$RepoName/"
)

# Watch for changes in the source directory
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $SourceDir
$watcher.Filter = "*.*"
$watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite'
$watcher.IncludeSubdirectories = $true

# Define action when a change occurs
$action = {
    Write-Host "Detected changes. Updating Pepperoni.zip..."
    
    # Remove existing zip if it exists
    if (Test-Path $ZipPath) {
        Remove-Item $ZipPath -Force
    }
    
    # Create new zip with latest files
    Compress-Archive -Path "$SourceDir\*" -DestinationPath $ZipPath -Force
    Write-Host "Pepperoni.zip has been updated."

    # Upload to GitHub
    Write-Host "Uploading changes to GitHub..."
    & "upload-to-github.ps1" -RepoPath $SourceDir -GitHubUsername $GitHubUsername -RepoName $RepoName
    Write-Host "GitHub upload complete."

    # Refresh desktop shortcut
    Write-Host "Refreshing desktop shortcut..."
    & "refresh-shortcut.ps1" -ShortcutName $ShortcutName -TargetURL $TargetURL
    Write-Host "Shortcut refreshed."
}

# Register the action for different types of changes
Register-ObjectEvent $watcher "Created" -Action $action
Register-ObjectEvent $watcher "Changed" -Action $action
Register-ObjectEvent $watcher "Deleted" -Action $action
Register-ObjectEvent $watcher "Renamed" -Action $action

# Start watching
$watcher.EnableRaisingEvents = $true

# Keep the script running
Write-Host "Watching for changes in $SourceDir... Press Ctrl+C to exit."
while ($true) {
    Start-Sleep -Seconds 1
}
