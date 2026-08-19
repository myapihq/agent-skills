#!/bin/sh
set -e

# This script used to download a zip of skill files from Cloud Storage.
#
# That zip was last built on 2026-04-30 and contained 10 of the 25 skills. It
# went stale the day the skills moved into the myapi repo: the workflow that
# published it watches a directory in the old repo that nobody edits any more,
# so it has not run since, and it never failed either — it simply stopped
# mattering. Anyone running this script in the months afterwards installed a
# subset four months old, including one skill for a slot that has since been
# renamed.
#
# The CLI is now the source. `myapi install-skills` installs the skills out of
# the package it shipped in, so the skills and the client cannot drift apart:
# there is no second copy to forget to publish.

# The old flags. They no longer select anything — the CLI installs for Claude,
# Gemini and Cursor in one pass — but accepting them means a command someone
# saved a year ago still works instead of dying on "Unknown option".
for arg in "$@"; do
  case "$arg" in
    --claude|--gemini|--all) ;;
    *) echo "Unknown option: $arg"; echo "Usage: install.sh"; exit 1 ;;
  esac
done

if ! command -v npm >/dev/null 2>&1; then
  cat <<'EOF'
This installer needs npm, which is not on your PATH.

Install Node.js 20 or newer (https://nodejs.org), then run:

  npm install -g @myapihq/cli
  myapi install-skills
EOF
  exit 1
fi

echo "Installing the MyAPI CLI..."
npm install -g @myapihq/cli

echo "Installing skills..."
myapi install-skills

cat <<'EOF'

────────────────────────────────────────
Start your agent and ask:
  What can I do with the myapi skills?

The CLI is installed too — `myapi status` shows your
account and every resource in your default org.
────────────────────────────────────────
EOF
