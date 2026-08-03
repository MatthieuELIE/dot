#!/usr/bin/env bash
# Test suite for block-outside-cwd.sh. Run directly:
# ./block-outside-cwd.test.sh
set -uo pipefail

hook="$HOME/.claude/hooks/block-outside-cwd.sh"
pass=0
fail=0

work="$(mktemp -d)"
outside="$(mktemp -d)"
trap 'rm -rf "$work" "$outside"' EXIT
touch "$work/inside.txt"
touch "$outside/secret.txt"
mkdir -p "$work/sub"

run_case() {
    local name="$1" expected="$2" payload_json="$3"
    local output actual
    output="$(printf '%s' "$payload_json" | bash "$hook")"
    actual="$(printf '%s' "$output" | jq -r '.hookSpecificOutput.permissionDecision // "allow"' 2>/dev/null)"
    [ -n "$actual" ] || actual="allow"
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name"
        pass=$((pass + 1))
    else
        echo "FAIL: $name (expected $expected, got $actual) -- output: $output"
        fail=$((fail + 1))
    fi
}

# --- Edit / Write / Read: file_path ---

run_case "Edit inside cwd" "allow" \
    "$(jq -n --arg cwd "$work" --arg f "$work/inside.txt" '{cwd:$cwd,tool_name:"Edit",tool_input:{file_path:$f}}')"

run_case "Edit outside cwd (absolute)" "deny" \
    "$(jq -n --arg cwd "$work" --arg f "$outside/secret.txt" '{cwd:$cwd,tool_name:"Edit",tool_input:{file_path:$f}}')"

run_case "Write new file inside cwd (does not exist yet)" "allow" \
    "$(jq -n --arg cwd "$work" --arg f "$work/sub/new-file.txt" '{cwd:$cwd,tool_name:"Write",tool_input:{file_path:$f}}')"

run_case "Write new file outside cwd (does not exist yet)" "deny" \
    "$(jq -n --arg cwd "$work" --arg f "$outside/new-file.txt" '{cwd:$cwd,tool_name:"Write",tool_input:{file_path:$f}}')"

run_case "Read escaping via .. from inside cwd" "deny" \
    "$(jq -n --arg cwd "$work" --arg f "$work/../$(basename "$outside")/secret.txt" '{cwd:$cwd,tool_name:"Read",tool_input:{file_path:$f}}')"

# --- NotebookEdit ---

run_case "NotebookEdit outside cwd" "deny" \
    "$(jq -n --arg cwd "$work" --arg f "$outside/nb.ipynb" '{cwd:$cwd,tool_name:"NotebookEdit",tool_input:{notebook_path:$f}}')"

# --- Grep / Glob: optional path ---

run_case "Grep with no path (defaults to cwd)" "allow" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Grep",tool_input:{pattern:"foo"}}')"

run_case "Grep with explicit outside path" "deny" \
    "$(jq -n --arg cwd "$work" --arg p "$outside" '{cwd:$cwd,tool_name:"Grep",tool_input:{pattern:"foo",path:$p}}')"

# --- Bash: best-effort token scan ---

run_case "Bash unrelated command" "allow" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:"ls -la"}}')"

run_case "Bash referencing absolute path inside cwd" "allow" \
    "$(jq -n --arg cwd "$work" --arg cmd "cat $work/inside.txt" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:$cmd}}')"

run_case "Bash referencing absolute path outside cwd" "deny" \
    "$(jq -n --arg cwd "$work" --arg cmd "cat $outside/secret.txt" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:$cmd}}')"

run_case "Bash cd to a home-relative path outside cwd" "deny" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:"cd ~/projects/comment.nvim && ls"}}')"

run_case "Bash relative .. traversal outside cwd" "deny" \
    "$(jq -n --arg cwd "$work" --arg cmd "cat ../$(basename "$outside")/secret.txt" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:$cmd}}')"

run_case "Bash git log with a..b range does not false-positive" "allow" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:"git log main..feature"}}')"

run_case "Bash git clone with a URL does not false-positive" "allow" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:"git clone https://github.com/foo/bar"}}')"

run_case "Bash relative path inside cwd (no leading slash)" "allow" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Bash",tool_input:{command:"cat sub/file.txt"}}')"

# --- Allowlist ---

run_case "Read under /private/tmp (allowlisted)" "allow" \
    "$(jq -n --arg cwd "$work" '{cwd:$cwd,tool_name:"Read",tool_input:{file_path:"/private/tmp/testfile.txt"}}')"

run_case "Read under \$HOME/.claude (allowlisted)" "allow" \
    "$(jq -n --arg cwd "$work" --arg f "$HOME/.claude/settings.json" '{cwd:$cwd,tool_name:"Read",tool_input:{file_path:$f}}')"

run_case "Read under \$HOME/dot (allowlisted)" "allow" \
    "$(jq -n --arg cwd "$work" --arg f "$HOME/dot/PROMPT.md" '{cwd:$cwd,tool_name:"Read",tool_input:{file_path:$f}}')"

run_case "Read under unrelated outside dir (not allowlisted)" "deny" \
    "$(jq -n --arg cwd "$work" --arg f "$outside/secret.txt" '{cwd:$cwd,tool_name:"Read",tool_input:{file_path:$f}}')"

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
