#!/usr/bin/env bash
# Blocks branch creation whose name doesn't match <type>/<description>
# (feat|fix|chore|docs|refactor|test|style|perf|build|ci|revert), for
# `git checkout -b`, `git switch -c`, and `git branch <name>`.
#
# Text-based parsing of a raw shell command string, not a real shell parser.
# Targets the realistic patterns Claude Code produces for its own branch
# creation, not adversarial shell escaping.
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

cmd=$(jq -r '.tool_input.command // empty')
pattern='^(feat|fix|chore|docs|refactor|test|style|perf|build|ci|revert)/[a-zA-Z0-9._-]+$'

name=""
match=""
if [[ "$cmd" =~ git[[:space:]]+checkout[[:space:]]+-[bB][[:space:]]+([^[:space:]]+) ]]; then
    name="${BASH_REMATCH[1]}"
    match="${BASH_REMATCH[0]}"
elif [[ "$cmd" =~ git[[:space:]]+switch[[:space:]]+-[cC][[:space:]]+([^[:space:]]+) ]]; then
    name="${BASH_REMATCH[1]}"
    match="${BASH_REMATCH[0]}"
elif [[ "$cmd" =~ git[[:space:]]+branch[[:space:]]+([^-[:space:]][^[:space:]]*) ]]; then
    name="${BASH_REMATCH[1]}"
    match="${BASH_REMATCH[0]}"
fi

[ -z "$name" ] && exit 0
in_open_quote "${cmd%%"$match"*}" && exit 0
[[ "$name" =~ $pattern ]] && exit 0

jq -cn --arg reason "Blocked: branch name '$name' doesn't match <type>/<description> (feat|fix|chore|docs|refactor|test|style|perf|build|ci|revert)." \
    '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
