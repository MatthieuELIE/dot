#!/usr/bin/env bash
# Test suite for pr-body-no-test-plan.sh. Run directly: ./pr-body-no-test-plan.test.sh
set -uo pipefail

hook_dir="$(cd "$(dirname "$0")" && pwd)"
hook="$hook_dir/pr-body-no-test-plan.sh"
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

run_case "body with a Test plan section" "deny" \
    'gh pr create --title "feat(core): x" --body "## Summary
- did x

## Test plan
- [ ] manual check"'

run_case "body with a Test plan section, different case" "deny" \
    'gh pr create --title "feat(core): x" --body "## summary

## TEST PLAN
verified locally"'

run_case "body with a checklist but no Test plan header" "deny" \
    'gh pr create --title "feat(core): x" --body "## Summary
- [x] did x"'

run_case "summary-only body" "allow" \
    'gh pr create --title "feat(core): x" --body "## Summary
- did x
- did y"'

run_case "body mentions testing in prose, no section or checklist" "allow" \
    'gh pr create --title "feat(core): x" --body "## Summary
- tested this manually before opening"'

run_case "gh pr edit is not gh pr create" "allow" \
    'gh pr edit 12 --body "## Test plan
- [ ] a"'

run_case "unrelated command" "allow" \
    'ls -la'

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
