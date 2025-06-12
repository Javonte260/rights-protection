param (
    [string]$ShortcutName = "SafeDocsGenerator Website",
    [string]$TargetURL = "http://javonte260.github.io/rights-protection/"
)

# Create assets directory if it doesn't exist
$iconDir = Join-Path $PSScriptRoot "assets"
if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir -Force
}

# Create a new shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\$ShortcutName.lnk")
$Shortcut.TargetPath = $TargetURL
$Shortcut.IconLocation = "%SystemRoot%\System32\imageres.dll,103"
$Shortcut.Save()

# Download bald eagle icon if it doesn't exist
$iconPath = Join-Path $PSScriptRoot "assets\bald-eagle.ico"
$iconDir = Split-Path $iconPath
if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir -Force
}

if (-not (Test-Path $iconPath)) {
    # Download icon from a reliable source
    $iconUrl = "https://raw.githubusercontent.com/icons8/icons8.github.io/master/Assets/Windows11/PNG/256/bald_eagle.png"
    $tempPath = Join-Path $env:TEMP "bald-eagle.png"
    
    try {
        Invoke-WebRequest -Uri $iconUrl -OutFile $tempPath
        
        # Convert PNG to ICO using PowerShell
        Add-Type -AssemblyName System.Drawing
        $img = [System.Drawing.Image]::FromFile($tempPath)
        
        # Create a new bitmap with the right size
        $bmp = New-Object System.Drawing.Bitmap($img, 32, 32)
        
        # Create a new icon
        $ico = New-Object System.Drawing.Icon($bmp.GetHbitmap(), 32, 32)
        $ico.Save($iconPath)
        
        # Clean up
        $img.Dispose()
        $bmp.Dispose()
        Remove-Item $tempPath
    } catch {
        Write-Host "Failed to download or process icon. Using default icon."
    }
}

# Create a new shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\$ShortcutName.lnk")
$Shortcut.TargetPath = $TargetURL
$Shortcut.IconLocation = "$iconPath,0"
$Shortcut.Save()

# Create a new shortcut
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\$ShortcutName.lnk")
$Shortcut.TargetPath = $TargetURL
$Shortcut.Save()
