#!/usr/bin/env bash
# Test suite for block-bad-branch-name.sh. Run directly:
# ./block-bad-branch-name.test.sh
set -uo pipefail

hook="$HOME/.claude/hooks/block-bad-branch-name.sh"
pass=0
fail=0

run_case() {
    local name="$1" expected="$2" command="$3"
    local payload output actual
    payload=$(jq -n --arg cmd "$command" '{tool_input:{command:$cmd}}')
    output=$(printf '%s' "$payload" | bash "$hook")
    actual="allow"
    printf '%s' "$output" | grep -q '"permissionDecision":"deny"' && actual="deny"
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name"
        pass=$((pass + 1))
    else
        echo "FAIL: $name (expected $expected, got $actual) -- output: $output"
        fail=$((fail + 1))
    fi
}

run_case "checkout -b with a valid name" "allow" \
    'git checkout -b feat/good-name'

run_case "checkout -b with an invalid name" "deny" \
    'git checkout -b bad-name'

run_case "checkout -B (capital) with a valid name" "allow" \
    'git checkout -B fix/thing'

run_case "switch -c with a valid name" "allow" \
    'git switch -c chore/cleanup'

run_case "switch -c with an invalid name" "deny" \
    'git switch -c random'

run_case "branch create with a valid name" "allow" \
    'git branch docs/update-readme'

run_case "branch create with an invalid name" "deny" \
    'git branch bad-name'

run_case "branch delete is not a creation and must not be flagged" "allow" \
    'git branch -d old-branch'

run_case "branch --list is not a creation and must not be flagged" "allow" \
    'git branch --list'

run_case "commit phrase mentioned inside an echo string" "allow" \
    'echo "just talking about git branch my-bad-name"'

run_case "unrelated command" "allow" \
    'ls -la'

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
