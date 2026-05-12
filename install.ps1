# IDL Branded Documents - one-line installer for Windows.
#
# Usage (paste into PowerShell):
#   irm https://raw.githubusercontent.com/simmahon/idl-claude-skills/main/install.ps1 | iex
#
# What it does:
#   1. Downloads the latest skill from GitHub (as a zip - no git required).
#   2. Backs up any existing IDL skill (with a timestamp suffix).
#   3. Copies the skill to %USERPROFILE%\.claude\skills\idl-brand-documents\
#   4. Prints next steps.
#
# Prerequisites:
#   - Claude desktop app installed (https://claude.ai/download)
#   - PowerShell 5.1+ (built into Windows 10/11)

$ErrorActionPreference = "Stop"

$ZipUrl     = "https://github.com/simmahon/idl-claude-skills/archive/refs/heads/main.zip"
$SkillsDir  = Join-Path $env:USERPROFILE ".claude\skills"
$Target     = Join-Path $SkillsDir "idl-brand-documents"
$Tmp        = Join-Path $env:TEMP ("idl-claude-skill-" + [guid]::NewGuid().ToString())
$ZipPath    = Join-Path $Tmp "repo.zip"
$ExtractDir = Join-Path $Tmp "extracted"

function Write-Step($Msg)    { Write-Host $Msg -ForegroundColor Cyan }
function Write-OK($Msg)      { Write-Host "[OK] $Msg" -ForegroundColor Green }
function Write-Warn($Msg)    { Write-Host "[!] $Msg" -ForegroundColor Yellow }
function Write-Err($Msg)     { Write-Host "[X] $Msg" -ForegroundColor Red }

Write-Step "Installing IDL Branded Documents skill..."
Write-Host ""

try {
    # 1. Make sure target folders exist
    New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
    New-Item -ItemType Directory -Force -Path $Tmp       | Out-Null

    # 2. Backup existing install (if any)
    if (Test-Path $Target) {
        $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backup = "${Target}.backup-${stamp}"
        Write-Warn "Existing skill found - backing up to:"
        Write-Host  "    $backup"
        Move-Item -Path $Target -Destination $backup
    }

    # 3. Download the zip from GitHub
    Write-Host "Downloading from GitHub..." -NoNewline
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
    Write-Host " done" -ForegroundColor Green

    # 4. Extract
    Write-Host "Extracting..." -NoNewline
    Expand-Archive -Path $ZipPath -DestinationPath $ExtractDir -Force
    Write-Host " done" -ForegroundColor Green

    # 5. Copy the skill folder
    $src = Join-Path $ExtractDir "idl-claude-skills-main\plugins\idl-brand-documents\skills\idl-brand-documents"
    if (-not (Test-Path $src)) {
        Write-Err "Could not find skill folder inside the downloaded zip."
        Write-Host "Expected: $src"
        exit 1
    }
    Write-Host "Installing..." -NoNewline
    Copy-Item -Recurse -Path $src -Destination $Target
    Write-Host " done" -ForegroundColor Green

    Write-Host ""
    Write-OK "Installed to $Target"
    Write-Host ""
    Write-Step "Next steps:"
    Write-Host "  1. Quit and reopen the Claude desktop app"
    Write-Host "     (right-click the Claude tray icon -> Quit, then reopen)."
    Write-Host "     This forces it to detect the new skill."
    Write-Host "  2. Click the Code tab at the top."
    Write-Host "  3. Click '+ New session' -> pick your Documents\IDL-Claude folder"
    Write-Host "     (or any folder you use consistently for IDL work)."
    Write-Host "  4. In the chat, type:  start the IDL onboarding"
    Write-Host "  5. Answer the 11 questions (about 5 minutes). You are set up."
    Write-Host ""
    Write-Step "Daily use:"
    Write-Host "  Say things like 'make me a branded QC report for [product]'."
    Write-Host "  Files save to the location you chose during onboarding."
    Write-Host ""
    Write-Host "To update later: re-run this installer. Your interview answers are kept."
    Write-Host ""
}
finally {
    if (Test-Path $Tmp) {
        Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue
    }
}
