#!/usr/bin/env bash
# Blocks branch creation whose name doesn't match <type>/<description>
# (feat|fix|chore|docs|refactor|test|style|perf|build|ci|revert), for
# `git checkout -b`, `git switch -c`, and `git branch <name>`.
#
# Text-based parsing of a raw shell command string, not a real shell parser.
# Targets the realistic patterns Claude Code produces for its own branch
# creation, not adversarial shell escaping.
set -euo pipefail

cmd=$(jq -r '.tool_input.command // empty')
pattern='^(feat|fix|chore|docs|refactor|test|style|perf|build|ci|revert)/[a-zA-Z0-9._-]+$'

name=""
if [[ "$cmd" =~ git[[:space:]]+checkout[[:space:]]+-[bB][[:space:]]+([^[:space:]]+) ]]; then
    name="${BASH_REMATCH[1]}"
elif [[ "$cmd" =~ git[[:space:]]+switch[[:space:]]+-[cC][[:space:]]+([^[:space:]]+) ]]; then
    name="${BASH_REMATCH[1]}"
elif [[ "$cmd" =~ git[[:space:]]+branch[[:space:]]+([^-[:space:]][^[:space:]]*) ]]; then
    name="${BASH_REMATCH[1]}"
fi

[ -z "$name" ] && exit 0
[[ "$name" =~ $pattern ]] && exit 0

jq -cn --arg reason "Blocked: branch name '$name' doesn't match <type>/<description> (feat|fix|chore|docs|refactor|test|style|perf|build|ci|revert)." \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
