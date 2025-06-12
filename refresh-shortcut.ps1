# Refresh Shortcut Script
param (
    [string]$ShortcutName = "SafeDocsGenerator Website",
    [string]$TargetURL = "http://javonte260.github.io/rights-protection/"
)

# Download bald eagle icon
& "download-icon.ps1"

# Remove existing shortcut if it exists
$shortcutPath = Join-Path $env:USERPROFILE "Desktop\$ShortcutName.lnk"
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath -Force
}

# Create new shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $TargetURL
$Shortcut.IconLocation = "$PSScriptRoot\assets\bald-eagle.ico,0"
$Shortcut.Save()

Write-Host "Shortcut has been refreshed with bald eagle icon."

# Download bald eagle icon if it doesn't exist
$iconPath = Join-Path $PSScriptRoot "assets\bald-eagle.ico"
$iconDir = Split-Path $iconPath
if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir -Force
}

if (-not (Test-Path $iconPath)) {
    $iconUrl = "https://raw.githubusercontent.com/icons8/icons8.github.io/master/Assets/Windows11/PNG/256/bald_eagle.png"
    $tempPath = Join-Path $env:TEMP "bald-eagle.png"
    Invoke-WebRequest -Uri $iconUrl -OutFile $tempPath
    
    # Convert PNG to ICO
    Add-Type -AssemblyName System.Drawing
    $img = [System.Drawing.Image]::FromFile($tempPath)
    $ico = New-Object System.Drawing.Icon($img, 32, 32)
    $ico.Save($iconPath)
    
    Remove-Item $tempPath
}

# Remove existing shortcut if it exists
$shortcutPath = Join-Path $env:USERPROFILE "Desktop\$ShortcutName.lnk"
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath -Force
}

# Create new shortcut with icon
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $TargetURL
$Shortcut.IconLocation = $iconPath, 0
$Shortcut.Save()

Write-Host "Shortcut has been refreshed with bald eagle icon."

# Remove existing shortcut if it exists
$shortcutPath = Join-Path $env:USERPROFILE "Desktop\$ShortcutName.lnk"
if (Test-Path $shortcutPath) {
    Remove-Item $shortcutPath -Force
}

# Create new shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $TargetURL
$Shortcut.Save()

Write-Host "Shortcut has been refreshed."
