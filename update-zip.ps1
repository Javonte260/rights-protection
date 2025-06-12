# Update Pepperoni.zip with latest changes
param (
    [string]$SourceDir = "C:\Users\Javonte\Desktop\rights-protection",
    [string]$ZipPath = "C:\Users\Javonte\Desktop\Pepperoni.zip"
)

# Remove existing zip if it exists
if (Test-Path $ZipPath) {
    Remove-Item $ZipPath -Force
}

# Create new zip with latest files
Compress-Archive -Path "$SourceDir\*" -DestinationPath $ZipPath -Force

Write-Host "Pepperoni.zip has been updated with the latest changes."
