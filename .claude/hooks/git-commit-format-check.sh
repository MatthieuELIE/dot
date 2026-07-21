#!/usr/bin/env bash
# Enforces header-only commit messages: "type(scope): summary", max 100 chars,
# no body, no Co-Authored-By trailer, for `git commit -m ...` (including the
# heredoc style `-m "$(cat <<'EOF' ...)"`).
set -euo pipefail

cmd=$(jq -r '.tool_input.command // empty')

printf '%s' "$cmd" | grep -qE '(^|[;&|]) *git commit\b.*-m' || exit 0

if printf '%s' "$cmd" | grep -qE "<<[\"']*EOF[\"']*"; then
    start_line=$(printf '%s\n' "$cmd" | grep -nE "<<[\"']*EOF[\"']*" | head -1 | cut -d: -f1)
    full_message=$(printf '%s\n' "$cmd" | tail -n +"$((start_line + 1))" | sed '/^EOF$/,$d')
else
    full_message=$(printf '%s\n' "$cmd" | grep -oE -- "-m[[:space:]]+['\"][^'\"]*" | head -1 | sed -E "s/-m[[:space:]]+['\"]//")
fi

[ -z "$full_message" ] && exit 0

header=$(printf '%s\n' "$full_message" | head -1)
non_empty_lines=$(printf '%s\n' "$full_message" | sed -e '/^[[:space:]]*$/d' | wc -l | tr -d ' ')

reason=""
if printf '%s' "$full_message" | grep -qi 'co-authored-by:'; then
    reason="Commit message must not include a Co-Authored-By trailer."
elif [ "$non_empty_lines" -gt 1 ]; then
    reason="Commit message must be header-only (no body). Got $non_empty_lines non-blank lines."
elif ! printf '%s' "$header" | grep -qE "^[a-z]+\([a-z0-9._/-]+\): .+\$"; then
    reason="Commit header must match 'type(scope): summary'. Got: \"$header\""
elif [ "${#header}" -gt 100 ]; then
    reason="Commit header is ${#header} chars, max 100: \"$header\""
fi

if [ -n "$reason" ]; then
    jq -cn --arg reason "$reason" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
fi
