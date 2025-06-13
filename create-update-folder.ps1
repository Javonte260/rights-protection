$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$updatesFolder = "C:\Users\Javonte\Desktop\Pepperoni-updates\updates-$timestamp"

# Create the base directory if it doesn't exist
New-Item -ItemType Directory -Path "C:\Users\Javonte\Desktop\Pepperoni-updates" -Force

# Create the update folder
New-Item -ItemType Directory -Path $updatesFolder -Force

# Get all files in the rights-protection directory
$allFiles = Get-ChildItem -Path "C:\Users\Javonte\Desktop\rights-protection" -Recurse -File

# Copy each file to the updates folder
foreach ($file in $allFiles) {
    $relativePath = $file.FullName.Replace("C:\Users\Javonte\Desktop\rights-protection\", "")
    $destinationPath = Join-Path $updatesFolder $relativePath
    
    # Create destination directory if it doesn't exist
    $destinationDir = Split-Path $destinationPath -Parent
    if (!(Test-Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force
    }
    
    # Copy the file
    Copy-Item -Path $file.FullName -Destination $destinationPath -Force
}

Write-Host "Update folder created at $updatesFolder"
