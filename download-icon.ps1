# Download bald eagle icon
$iconPath = Join-Path $PSScriptRoot "assets\bald-eagle.ico"
$iconDir = Split-Path $iconPath

# Create assets directory if it doesn't exist
if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir -Force
}

# Use a reliable source for the bald eagle icon
$iconUrl = "https://raw.githubusercontent.com/icons8/icons8.github.io/master/Assets/Windows11/PNG/256/bald_eagle.png"

# Download the icon
try {
    Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath
    Write-Host "Successfully downloaded bald eagle icon."
} catch {
    Write-Host "Failed to download bald eagle icon. Using default icon."
    # Create a default icon if download fails
    $defaultIconPath = Join-Path $env:windir "System32\shell32.dll"
    $iconPath = $defaultIconPath
}
