# Usage: .\set_db_env.ps1 "your_actual_password"
param([string]$password)

if (-not $password) {
    Write-Host "Please provide the Aiven MySQL password as an argument." -ForegroundColor Yellow
    Write-Host "Example: .\set_db_env.ps1 'my_secret_pwd'"
    exit
}

$env:DB_PASSWORD = $password
[System.Environment]::SetEnvironmentVariable("DB_PASSWORD", $password, "User")

Write-Host "Environment variable DB_PASSWORD has been set for the current session and your user account." -ForegroundColor Green
Write-Host "Please restart NetBeans or your terminal for changes to take effect if they don't show up immediately."
