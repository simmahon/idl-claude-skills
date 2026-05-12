#!/usr/bin/env bash
#
# IDL Branded Documents — one-line installer for Mac and Linux.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/simmahon/idl-claude-skills/main/install.sh | bash
#
# What it does:
#   1. Downloads the latest skill from GitHub (as a zip — no git required).
#   2. Backs up any existing IDL skill (with a timestamp suffix).
#   3. Copies the skill to ~/.claude/skills/idl-brand-documents/
#   4. Prints next steps.
#
# Prerequisites:
#   - Claude desktop app installed (https://claude.ai/download)
#   - Curl (pre-installed on every Mac and Linux)
#   - Unzip (pre-installed on every Mac and Linux)
#

set -euo pipefail

ZIP_URL="https://github.com/simmahon/idl-claude-skills/archive/refs/heads/main.zip"
SKILLS_DIR="$HOME/.claude/skills"
TARGET="$SKILLS_DIR/idl-brand-documents"
TMP=$(mktemp -d -t idl-claude-skill.XXXXXX)
trap 'rm -rf "$TMP"' EXIT

# Colours (turned off if not a terminal)
if [ -t 1 ]; then
    BLUE="\033[0;34m"; GREEN="\033[0;32m"; YELLOW="\033[1;33m"; RED="\033[0;31m"; NC="\033[0m"
else
    BLUE=""; GREEN=""; YELLOW=""; RED=""; NC=""
fi

printf "${BLUE}Installing IDL Branded Documents skill…${NC}\n\n"

# 1. Sanity checks
for cmd in curl unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf "${RED}✗ '$cmd' is not installed. Install it and re-run.${NC}\n"
        exit 1
    fi
done

# 2. Make sure ~/.claude/skills/ exists
mkdir -p "$SKILLS_DIR"

# 3. Backup existing install (if any)
if [ -d "$TARGET" ]; then
    BACKUP="${TARGET}.backup-$(date +%Y%m%d-%H%M%S)"
    printf "${YELLOW}!  Existing skill found — backing up to:${NC}\n   $BACKUP\n"
    mv "$TARGET" "$BACKUP"
fi

# 4. Download zip from GitHub
printf "Downloading from GitHub… "
curl -fsSL "$ZIP_URL" -o "$TMP/repo.zip"
printf "${GREEN}done${NC}\n"

# 5. Extract
printf "Extracting… "
unzip -q "$TMP/repo.zip" -d "$TMP/extracted"
printf "${GREEN}done${NC}\n"

# 6. Copy the skill to ~/.claude/skills/
SRC="$TMP/extracted/idl-claude-skills-main/plugins/idl-brand-documents/skills/idl-brand-documents"
if [ ! -d "$SRC" ]; then
    printf "${RED}✗ Could not find skill folder inside the downloaded zip.${NC}\n"
    printf "  Expected: $SRC\n"
    exit 1
fi

cp -R "$SRC" "$TARGET"
printf "Installing… ${GREEN}done${NC}\n\n"

# 7. Done
printf "${GREEN}✓ Installed to $TARGET${NC}\n\n"
printf "${BLUE}Next steps:${NC}\n"
printf "  1. ${GREEN}Quit and reopen the Claude desktop app${NC} (⌘ + Q, then reopen)\n"
printf "     — this forces it to detect the new skill.\n"
printf "  2. Click the ${GREEN}Code${NC} tab at the top.\n"
printf "  3. Click ${GREEN}+ New session${NC} → pick your ~/Documents/IDL-Claude folder\n"
printf "     (or any folder you'll use consistently for IDL work).\n"
printf "  4. In the chat, type:  ${GREEN}start the IDL onboarding${NC}\n"
printf "  5. Answer the 11 questions (~5 min). You're set up.\n\n"
printf "${BLUE}Daily use:${NC} say things like '${GREEN}make me a branded QC report for [product]${NC}'.\n"
printf "Files save to the location you chose during onboarding.\n\n"
printf "To update later: re-run this installer. Your interview answers are kept.\n\n"
