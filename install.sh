#!/bin/sh
# This installer is retired. It is kept, and kept working as a signpost, because
# a command someone saved a year ago should tell them what to do now rather than
# fail with "404".
#
# History: it downloaded a zip of skill files from Cloud Storage, which went four
# months stale without ever failing. It was then changed to install the CLI and
# let the CLI install the skills. The CLI is now retired too: the platform is
# reached over MCP, and the instructions come from the server rather than from
# copies on disk.

cat <<'EOF'

  This installer is retired — there is nothing left to install.

  MyAPI is now Sabaki, and it is reached over MCP. The tools and their
  instructions come from the server, so they cannot go stale locally.

  In Claude Code:

      /plugin marketplace add myapihq/agent-skills
      /plugin install sabaki

  Any other MCP client (ChatGPT, Cursor, Windsurf, Zed, VS Code):

      https://api.myapihq.com/mcp

  https://sabaki.app/

EOF
exit 0
