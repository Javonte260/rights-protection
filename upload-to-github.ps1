# GitHub Upload Script
param (
    [string]$RepoPath = "C:\Users\Javonte\Desktop\rights-protection",
    [string]$GitHubUsername = "javonte260",
    [string]$RepoName = "rights-protection"
)

# Initialize git if not already initialized
if (-not (Test-Path "$RepoPath\.git")) {
    git init
    git remote add origin https://github.com/$GitHubUsername/$RepoName.git
}

# Add all files
Write-Host "Adding files to git..."
git add .

# Check if there are any changes to commit
$changes = git status --porcelain
if ($changes) {
    # Commit changes
    $commitMessage = "Update website files - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    Write-Host "Committing changes: $commitMessage"
    git commit -m $commitMessage

    # Push changes
    Write-Host "Pushing changes to GitHub..."
    git push origin main
} else {
    Write-Host "No changes to commit."
}

Write-Host "GitHub upload complete."
