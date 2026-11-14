#!/usr/bin/env bash
# PreToolUse (Edit|Write): keep Claude's hands off secrets and generated files.
file=$(jq -r '.tool_input.file_path // ""')

case "$file" in
  *.env|*.env.*|*/.git/*|*.pem|*.key|*/package-lock.json|*/pnpm-lock.yaml|*/yarn.lock)
    echo "Blocked: $(basename "$file") is protected. Ask the user to change it." >&2
    exit 2 ;;
esac
exit 0
