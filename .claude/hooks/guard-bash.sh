#!/usr/bin/env bash
# PreToolUse (Bash): deny commands you never want an agent to run.
input=$(cat)
cmd=$(jq -r '.tool_input.command // ""' <<<"$input")

deny() {
  jq -n --arg r "$1" '{hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: $r }}'
  exit 0
}

case "$cmd" in
  *"rm -rf /"*|*"rm -rf ~"*|*'rm -rf $HOME'*)
    deny "Blocked: recursive delete of / or home. Delete specific paths instead." ;;
  *"git push"*"--force"*|*"git push"*" -f"*)
    deny "Blocked: force-push. Push normally or open a PR." ;;
  *"git reset --hard"*)
    deny "Blocked: git reset --hard discards work. Use git stash first." ;;
  *"curl"*"| sh"*|*"curl"*"| bash"*|*"wget"*"| sh"*)
    deny "Blocked: piping a download into a shell." ;;
esac
exit 0
