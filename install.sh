#!/usr/bin/env bash
# breathe — installer for the /breathe Claude Code slash command
# Usage: curl -sSL https://raw.githubusercontent.com/jayvee6/breathe/main/install.sh | bash

set -e

REPO_RAW="https://raw.githubusercontent.com/jayvee6/breathe/main"
COMMANDS_DIR="$HOME/.claude/commands"
COMMAND_FILE="$COMMANDS_DIR/breathe.md"

echo ""
echo "  breathe — install"
echo "  ─────────────────"
echo ""

# Make sure ~/.claude/commands exists
mkdir -p "$COMMANDS_DIR"

# Fetch the slash command markdown
if ! curl -fsSL "$REPO_RAW/breathe.md" -o "$COMMAND_FILE"; then
  echo "  ✗ Failed to download breathe.md from $REPO_RAW"
  echo "    Check your connection or the repo URL and try again."
  exit 1
fi

echo "  ✓ Installed slash command to: $COMMAND_FILE"
echo ""
echo "  Restart Claude Code (or start a new session), then type:"
echo ""
echo "    /breathe        4-cycle 4-7-8 session (~76s)"
echo "    /breathe 1      single cycle (~19s)"
echo "    /breathe 7      seven cycles (~133s)"
echo ""
echo "  To uninstall:  rm $COMMAND_FILE"
echo ""
