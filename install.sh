#!/bin/sh
set -e

ZIP_URL="https://storage.googleapis.com/myapi-skills/skills.zip"
TMP="$(mktemp /tmp/myapi-skills-XXXXXX.zip)"

INSTALL_CLAUDE=0
INSTALL_GEMINI=0

if [ $# -eq 0 ]; then
  INSTALL_CLAUDE=1
  INSTALL_GEMINI=1
else
  for arg in "$@"; do
    case "$arg" in
      --claude) INSTALL_CLAUDE=1 ;;
      --gemini) INSTALL_GEMINI=1 ;;
      --all)    INSTALL_CLAUDE=1; INSTALL_GEMINI=1 ;;
      *) echo "Unknown option: $arg"; echo "Usage: install.sh [--claude] [--gemini] [--all]"; exit 1 ;;
    esac
  done
fi

echo "Downloading myapi skills..."
curl -sSLf "$ZIP_URL" -o "$TMP"

if [ $INSTALL_CLAUDE -eq 1 ]; then
  echo "Installing for Claude Code..."
  mkdir -p "$HOME/.claude/skills"
  unzip -qo "$TMP" -d "$HOME/.claude/skills"
  echo "  -> $HOME/.claude/skills"
fi

if [ $INSTALL_GEMINI -eq 1 ]; then
  echo "Installing for Gemini..."
  mkdir -p "$HOME/.gemini/skills"
  unzip -qo "$TMP" -d "$HOME/.gemini/skills"
  echo "  -> $HOME/.gemini/skills"
fi

rm -f "$TMP"
echo "Done!"
