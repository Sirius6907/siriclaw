# SiriClaw Windows Installer
# Run with: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Sirius6907/siriclaw/main/install.ps1'))

$ErrorActionPreference = "Stop"

Write-Host "⚡ SiriClaw Installation Started" -ForegroundColor Cyan

# 1. Check for Cargo/Rust
if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  Rust/Cargo not found. Please install Rust from https://rustup.rs/ and try again." -ForegroundColor Yellow
    exit 1
}

# 2. Clone or Download
$TempDir = Join-Path $env:TEMP "siriclaw_install"
if (Test-Path $TempDir) { Remove-Item $TempDir -Recurse -Force }
New-Item -ItemType Directory -Path $TempDir | Out-Null

Write-Host "📦 Downloading SiriClaw..." -ForegroundColor Gray
git clone https://github.com/Sirius6907/siriclaw.git $TempDir

# 3. Build and Install
Set-Location $TempDir
Write-Host "🏗️  Building SiriClaw (this may take a minute)..." -ForegroundColor Gray
cargo install --path .

# 4. Success
Write-Host "`n✅ SiriClaw successfully installed!" -ForegroundColor Green
Write-Host "🚀 Run 'sirius onboard' to get started." -ForegroundColor Cyan

# Cleanup
Set-Location $env:USERPROFILE
Remove-Item $TempDir -Recurse -Force
