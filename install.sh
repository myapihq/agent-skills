#!/bin/sh
# This installer is retired. It is kept, and kept working as a signpost,
# because a command someone saved a year ago should tell them what to do now
# rather than fail with "404".
#
# History, briefly: it downloaded a zip of skill files from Cloud Storage,
# which went four months stale without failing. It was then changed to install
# the CLI and let the CLI install the skills. The CLI is now being retired too:
# the platform is reached over MCP, and the instructions come from the server
# instead of from copies on disk.

cat <<'EOF'

  The MyAPI skills installer is retired — there is nothing left to install.

  MyAPI is now reached over MCP. The tools and their instructions come from
  the server, so they cannot go stale in a local copy.

  In Claude Code:

      /plugin marketplace add myapihq/agent-skills
      /plugin install myapi

  Any other MCP client:

      https://api.myapihq.com/mcp

  https://myapihq.com/

EOF
exit 0
