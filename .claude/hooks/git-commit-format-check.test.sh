#!/usr/bin/env bash
# Test suite for git-commit-format-check.sh. Run directly: ./git-commit-format-check.test.sh
set -uo pipefail

hook_dir="$(cd "$(dirname "$0")" && pwd)"
hook="$hook_dir/git-commit-format-check.sh"
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

run_case "apostrophe in double-quoted message" "allow" \
    'git commit -m "fix(core): it'"'"'s broken"'

run_case "double-quote inside single-quoted message" "allow" \
    "git commit -m 'fix(core): say \"hi\" properly'"

run_case "multiple -m flags produce a body" "deny" \
    'git commit -m "fix(core): title here" -m "a real body line"'

command=$(cat <<'RAWCMD'
git commit -m "$(cat <<'EOF'
feat(core): add thing
EOF
)"
RAWCMD
)
run_case "heredoc with EOF delimiter" "allow" "$command"

command=$(cat <<'RAWCMD'
git commit -m "$(cat <<'MSG'
feat(core): add thing
MSG
)"
RAWCMD
)
run_case "heredoc with custom delimiter" "allow" "$command"

command=$(printf 'git commit -m "$(cat <<-'"'"'COMMIT'"'"'\n\tfeat(core): add thing\n\tCOMMIT\n)"')
run_case "heredoc <<- strips leading tabs" "allow" "$command"

run_case "git commit text inside an unrelated echo string" "allow" \
    'echo "just talking about; git commit -m stuff"'

run_case "chained command before a real commit" "allow" \
    'npm test && git commit -m "fix(core): after tests"'

run_case "valid header-only commit" "allow" \
    'git commit -m "fix(core): simple valid header"'

run_case "header missing scope" "deny" \
    'git commit -m "update stuff"'

long_header="fix(core): $(printf 'x%.0s' $(seq 1 95))"
run_case "header over 100 chars" "deny" \
    "git commit -m \"$long_header\""

command=$(cat <<'RAWCMD'
git commit -m "$(cat <<'EOF'
feat(core): add thing

with a body line
EOF
)"
RAWCMD
)
run_case "heredoc with a real body" "deny" "$command"

command=$(cat <<'RAWCMD'
git commit -m "$(cat <<'EOF'
feat(core): add thing

Co-Authored-By: Bob <bob@example.com>
EOF
)"
RAWCMD
)
run_case "heredoc with Co-Authored-By trailer" "deny" "$command"

run_case "git commit without -m" "allow" \
    'git commit --amend'

run_case "unrelated command" "allow" \
    'ls -la'

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
