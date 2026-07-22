#!/usr/bin/env bash
# Blocks `gh pr create` when the body includes a Test plan section or
# checklist — the ship skill's PR format is Summary-only.
set -euo pipefail

cmd=$(jq -r '.tool_input.command // empty')

printf '%s' "$cmd" | grep -qi 'gh pr create' || exit 0
printf '%s' "$cmd" | grep -Eqi '## *test plan|- \[[ xX]\]' || exit 0

jq -cn '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:"PR body contains a Test plan section or checklist. Remove it - the ship skill PR format is Summary-only."}}'
