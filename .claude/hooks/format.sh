#!/usr/bin/env bash
# PostToolUse (Edit|Write): format the file Claude just touched.
file=$(jq -r '.tool_input.file_path // ""')
prettier="$CLAUDE_PROJECT_DIR/node_modules/.bin/prettier"

case "$file" in
  *.js|*.jsx|*.ts|*.tsx|*.json|*.css|*.md)
    if [ -x "$prettier" ]; then
      "$prettier" --write --log-level warn "$file" >&2 || exit 1
      echo "formatted $(basename "$file")" >&2
    fi ;;
esac
exit 0
