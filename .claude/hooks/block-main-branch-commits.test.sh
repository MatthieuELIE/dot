#!/usr/bin/env bash
# Test suite for block-main-branch-commits.sh. Run directly:
# ./block-main-branch-commits.test.sh
#
# The hook reads the real current branch via `git rev-parse --abbrev-ref
# HEAD`, so it can't be driven purely through the JSON payload like the other
# hooks - each case runs inside a throwaway git repo checked out on the
# branch it needs to exercise.
set -uo pipefail

hook_dir="$(cd "$(dirname "$0")" && pwd)"
hook="$hook_dir/block-main-branch-commits.sh"
pass=0
fail=0

repo_dir="$(mktemp -d)"
trap 'rm -rf "$repo_dir"' EXIT

(
    cd "$repo_dir" || exit 1
    git init -q -b main
    git config user.email test@example.com
    git config user.name test
    git commit -q --allow-empty -m "init"
    git checkout -q -b feature/x
)

run_case() {
    local name="$1" expected="$2" branch="$3" command="$4"
    local payload output actual
    payload=$(jq -n --arg cmd "$command" '{tool_input:{command:$cmd}}')
    output=$(cd "$repo_dir" && git checkout -q "$branch" && printf '%s' "$payload" | bash "$hook")
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

run_case "git commit on main" "deny" "main" \
    'git commit -m "fix(core): x"'

run_case "git push on main" "deny" "main" \
    'git push origin main'

run_case "chained command with a commit on main" "deny" "main" \
    'npm test && git commit -m "fix(core): x"'

run_case "unrelated command on main" "allow" "main" \
    'ls -la'

run_case "git commit on a feature branch" "allow" "feature/x" \
    'git commit -m "fix(core): x"'

run_case "git push on a feature branch" "allow" "feature/x" \
    'git push -u origin feature/x'

run_case "git status on main" "allow" "main" \
    'git status'

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
