#!/usr/bin/env bash
# Stop: don't let Claude say "done" while the tests are red.
input=$(cat)

# Already continuing because of this hook? Let it stop (prevents loops).
if [ "$(jq -r '.stop_hook_active' <<<"$input")" = "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR" || exit 0
if ! out=$(npm test --silent 2>&1); then
  jq -n --arg r "Tests are failing. Fix them before finishing:
$(tail -n 25 <<<"$out")" '{decision: "block", reason: $r}'
fi
exit 0
