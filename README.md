# claude-hooks-starter

Five small, practical [Claude Code hooks](https://code.claude.com/docs/en/hooks) you can drop into any project:

| Hook | Event | What it does |
| --- | --- | --- |
| `guard-bash.sh` | `PreToolUse` (Bash) | Denies `rm -rf /`, force-pushes, `git reset --hard`, and `curl \| sh` |
| `protect-files.sh` | `PreToolUse` (Edit\|Write) | Blocks edits to `.env`, keys, `.git/` and lockfiles |
| `format.sh` | `PostToolUse` (Edit\|Write) | Runs Prettier on the file Claude just changed |
| `test-gate.sh` | `Stop` | Won't let Claude finish while `npm test` is failing |
| `notify.sh` | `Notification` | Desktop ping when Claude is waiting for you |

## Use it

```bash
git clone https://github.com/hasalaonline/claude-hooks-starter
cd claude-hooks-starter
npm install
chmod +x .claude/hooks/*.sh
claude
```

Then type `/hooks` inside Claude Code to see all five loaded.

To add them to your own project, copy `.claude/hooks/` and the `hooks` block from `.claude/settings.json`, then `chmod +x .claude/hooks/*.sh`. The scripts need `jq`.

## Try each hook without Claude

Every hook reads JSON on stdin, so you can test it by hand:

```bash
export CLAUDE_PROJECT_DIR=$PWD
echo '{"tool_input":{"command":"git push --force origin main"}}' | .claude/hooks/guard-bash.sh
echo "{\"tool_input\":{\"file_path\":\"$PWD/.env\"}}" | .claude/hooks/protect-files.sh; echo "exit=$?"
echo '{"stop_hook_active":false}' | .claude/hooks/test-gate.sh
```

> Command hooks run with your full user permissions. Read them before you install them, including these.
