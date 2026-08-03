#!/usr/bin/env bash
# Shared helpers for hooks that grep a raw Bash command string for a
# trigger phrase. Since these hooks aren't real shell parsers, a phrase
# merely mentioned inside an echoed/printed string literal (not an actual
# invocation) would otherwise be treated as the real thing - these track
# single/double quote state up to a match to tell the two apart.
# First-occurrence only, matching the non-adversarial scope of the hooks
# that use it.

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
            double)
                if [ "$c" = '\' ]; then i=$((i + 1))
                elif [ "$c" = '"' ]; then state=none
                fi
                ;;
        esac
    done
    [ "$state" != none ]
}

# True if the first occurrence of ERE $2 within $1 sits inside an open quote.
match_in_open_quote() {
    local cmd="$1" regex="$2" first_match
    first_match=$(printf '%s' "$cmd" | grep -oEi "$regex" | head -1)
    [ -z "$first_match" ] && return 1
    in_open_quote "${cmd%%"$first_match"*}"
}
