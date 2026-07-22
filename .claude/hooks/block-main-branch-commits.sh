#!/usr/bin/env bash
# Refuses `git commit`/`git push` while checked out on main/master —
# forces branching first (see the ship skill).
set -euo pipefail

command="$(jq -r '.tool_input.command // empty')"
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" || exit 0

[ "$branch" = "main" ] || [ "$branch" = "master" ] || exit 0

printf '%s' "$command" | grep -Eq '(^|[;&|]|[[:space:]])git[[:space:]]+(commit|push)([[:space:]]|$)' || exit 0

echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Blocked: refusing git commit/push while on main. Create a branch first."}}'
