param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("1", "2")]
    [string]$Theme = "2"
)

$targetDir = "Design $Theme"

if (-not (Test-Path $targetDir)) {
    Write-Error "Directory $targetDir does not exist."
    exit 1
}

Write-Host ">>> Activating $targetDir as root GitHub Profile README..." -ForegroundColor Cyan

# Copy README.md
Copy-Item "$targetDir\README.md" ".\README.md" -Force

# Recreate assets directory
if (Test-Path ".\assets") {
    Remove-Item ".\assets" -Recurse -Force
}
Copy-Item "$targetDir\assets" ".\assets" -Recurse -Force

Write-Host ">>> Success! Root README.md and assets/ updated to $targetDir." -ForegroundColor Green
Write-Host ">>> Run 'git add .', 'git commit -m `"`chore: switch to $targetDir`"`', and 'git push' to deploy live!" -ForegroundColor Yellow
