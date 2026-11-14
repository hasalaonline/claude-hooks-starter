#!/usr/bin/env bash
# Notification: ping me when Claude is waiting on me.
input=$(cat)
msg=$(jq -r '.message // "Claude Code needs you"' <<<"$input")
title=$(jq -r '.title // "Claude Code"' <<<"$input")

if command -v osascript >/dev/null; then
  osascript -e "display notification \"${msg//\"/}\" with title \"${title//\"/}\" sound name \"Glass\""
elif command -v notify-send >/dev/null; then
  notify-send "$title" "$msg"
else
  printf '\a'
fi
exit 0
