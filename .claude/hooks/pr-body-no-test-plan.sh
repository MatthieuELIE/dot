#!/usr/bin/env bash
# Blocks `gh pr create` when the body includes a Test plan section or
# checklist — the ship skill's PR format is Summary-only.
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

cmd=$(jq -r '.tool_input.command // empty')

create_regex='gh pr create'
printf '%s' "$cmd" | grep -qi "$create_regex" || exit 0
printf '%s' "$cmd" | grep -Eqi '## *test plan|- \[[ xX]\]' || exit 0
match_in_open_quote "$cmd" "$create_regex" && exit 0

jq -cn '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:"PR body contains a Test plan section or checklist. Remove it - the ship skill PR format is Summary-only."}}'
