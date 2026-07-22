#!/usr/bin/env bash
# Enforces header-only commit messages: "type(scope): summary", max 100 chars,
# no body, no Co-Authored-By trailer, for `git commit -m ...` (including the
# heredoc style `-m "$(cat <<'EOF' ...)"`, any delimiter).
#
# This is text-based parsing of a raw shell command string, not a real shell
# parser. It targets the realistic patterns Claude Code produces for its own
# commits, not adversarial shell escaping.
set -euo pipefail

# Extracts every `-m "..."` / `-m '...'` argument (each becomes a paragraph,
# joined by a blank line, matching how git concatenates multiple -m flags).
# Matches the closing quote to the SAME type as the opening one, so a message
# quoted with " can safely contain a ' (e.g. "fix: it's broken") and vice versa.
extract_dash_m_messages() {
    local remaining="$1"
    local re="-m[[:space:]]+(\"([^\"]*)\"|'([^']*)')"
    while [[ "$remaining" =~ $re ]]; do
        if [ "${BASH_REMATCH[1]:0:1}" = '"' ]; then
            printf '%s\n\n' "${BASH_REMATCH[2]}"
        else
            printf '%s\n\n' "${BASH_REMATCH[3]}"
        fi
        remaining="${remaining#*"${BASH_REMATCH[0]}"}"
    done
}

# Heuristic against false positives when "git commit" appears inside a string
# literal (e.g. `echo "...; git commit -m..."`): walks the prefix tracking
# single- and double-quote state independently. Counting all quote chars in
# one total (the previous approach) misfires as soon as an apostrophe sits
# inside an earlier double-quoted string - e.g. `echo "don't" && git commit`
# has 3 quote chars (odd), which the old parity check wrongly read as "still
# inside a string" and let the real invocation through unchecked.
in_open_quote() {
    local s="$1" state=none i c
    for (( i = 0; i < ${#s}; i++ )); do
        c="${s:i:1}"
        case "$state" in
            none)
                if [ "$c" = "'" ]; then state=single
                elif [ "$c" = '"' ]; then state=double
                fi
                ;;
            single) [ "$c" = "'" ] && state=none ;;
            double) [ "$c" = '"' ] && state=none ;;
        esac
    done
    [ "$state" != none ]
}

cmd=$(jq -r '.tool_input.command // empty')

commit_regex='(^|[;&|]) *git commit\b'
printf '%s' "$cmd" | grep -qE "${commit_regex}.*-m" || exit 0

first_match=$(printf '%s' "$cmd" | grep -oE "$commit_regex" | head -1)
prefix="${cmd%%"$first_match"*}"
in_open_quote "$prefix" && exit 0

heredoc_re="(<<-?)[\"']?([A-Za-z_][A-Za-z0-9_]*)[\"']?"
if [[ "$cmd" =~ $heredoc_re ]]; then
    operator="${BASH_REMATCH[1]}"
    delimiter="${BASH_REMATCH[2]}"
    start_line=$(printf '%s\n' "$cmd" | grep -nE -- "${operator}[\"']?${delimiter}[\"']?" | head -1 | cut -d: -f1)
    if [ "$operator" = "<<-" ]; then
        # <<- strips leading tabs from both the end delimiter and every content line.
        end_pattern="^[[:space:]]*${delimiter}[[:space:]]*$"
        full_message=$(printf '%s\n' "$cmd" | tail -n +"$((start_line + 1))" | sed -n "/${end_pattern}/q;p" | sed 's/^\t*//')
    else
        end_pattern="^${delimiter}[[:space:]]*$"
        full_message=$(printf '%s\n' "$cmd" | tail -n +"$((start_line + 1))" | sed -n "/${end_pattern}/q;p")
    fi
else
    full_message=$(extract_dash_m_messages "$cmd")
fi

[ -z "$full_message" ] && exit 0

header=$(printf '%s\n' "$full_message" | head -1)
non_empty_lines=$(printf '%s\n' "$full_message" | sed -e '/^[[:space:]]*$/d' | wc -l | tr -d ' ')

reason=""
if printf '%s' "$full_message" | grep -qi 'co-authored-by:'; then
    reason="Commit message must not include a Co-Authored-By trailer."
elif [ "$non_empty_lines" -gt 1 ]; then
    reason="Commit message must be header-only (no body). Got $non_empty_lines non-blank lines."
elif ! printf '%s' "$header" | grep -qE "^[a-z]+\([a-z0-9._/-]+\): .+\$"; then
    reason="Commit header must match 'type(scope): summary'. Got: \"$header\""
elif [ "${#header}" -gt 100 ]; then
    reason="Commit header is ${#header} chars, max 100: \"$header\""
fi

if [ -n "$reason" ]; then
    jq -cn --arg reason "$reason" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$reason}}'
fi
