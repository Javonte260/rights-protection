param (
    [string]$ShortcutName = "SafeDocsGenerator Website",
    [string]$TargetURL = "http://javonte260.github.io/rights-protection/"
)

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

# Verify the shortcut
$shortcutProperties = Get-ItemProperty $shortcutPath
Write-Host "Shortcut Properties:"
Write-Host "Target Path: $($shortcutProperties.TargetPath)"
Write-Host "Icon Location: $($shortcutProperties.IconLocation)"

# Test opening the shortcut
Write-Host "Testing shortcut..."
& $shortcutPath
