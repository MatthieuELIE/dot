#!/usr/bin/env bash
# Smoke test for statusline.sh. Run directly: ./statusline.test.sh
set -uo pipefail

hook="$HOME/.claude/hooks/statusline.sh"
pass=0
fail=0

run_case() {
    local name="$1" payload="$2"
    local output line_count
    output=$(printf '%s' "$payload" | bash "$hook")
    line_count=$(printf '%s\n' "$output" | wc -l | tr -d ' ')
    if [ "$line_count" -eq 2 ] && printf '%s' "$output" | grep -q 'Workspace:' && printf '%s' "$output" | grep -q 'Context Tokens:'; then
        echo "PASS: $name"
        pass=$((pass + 1))
    else
        echo "FAIL: $name -- output: $output"
        fail=$((fail + 1))
    fi
}

run_case "full payload" \
    "$(jq -cn '{workspace:{current_dir:"/tmp"},model:{display_name:"Sonnet 5"},effort:{level:"high"},cost:{total_cost_usd:1.2345,total_duration_ms:125000},context_window:{current_usage:{input_tokens:100,output_tokens:50,cache_creation_input_tokens:10,cache_read_input_tokens:5}}}')"

run_case "missing cost and context_window fields" \
    "$(jq -cn '{cwd:"/tmp",model:{display_name:"Sonnet 5"}}')"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
