#!/usr/bin/env bash
# Refuses `git commit`/`git push` while checked out on main/master —
# forces branching first (see the ship skill).
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

command="$(jq -r '.tool_input.command // empty')"
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || exit 0

[ "$branch" = "main" ] || [ "$branch" = "master" ] || exit 0

regex='(^|[;&|]) *git[[:space:]]+(commit|push)([[:space:]]|$)'
printf '%s' "$command" | grep -Eqi "$regex" || exit 0
match_in_open_quote "$command" "$regex" && exit 0

echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked: refusing git commit/push while on main. Create a branch first."}}'
