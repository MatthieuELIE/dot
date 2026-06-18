#!/bin/bash

# bin: new

set -o errexit
set -o nounset
set -o pipefail

for var in JIRA_PROJECT_KEY JIRA_HOST GITLAB_TOKEN GITLAB_USERID; do
    [ -n "${!var:-}" ] || {
        echo "Missing required environment variable: $var" >&2
        exit 1
    }
done

command -v gum >/dev/null 2>&1 || {
    echo "gum is required but not installed" >&2
    exit 1
}

command -v mr >/dev/null 2>&1 || {
    echo "mr command is required but not installed" >&2
    exit 1
}

BRANCH_TYPE=$(
    gum choose \
        --header "Select branch type" \
        feat \
        fix \
        chore \
        refactor \
        docs \
        test \
        build \
        ci \
        perf \
        revert
)
[ -n "$BRANCH_TYPE" ]

while true; do
    TICKET_NUMBER=$(
        gum input \
            --placeholder "Jira ticket number (e.g. 418)"
    )

    [[ "$TICKET_NUMBER" =~ ^[0-9]+$ ]] && break
    gum style --foreground 1 "Ticket number must be numeric"
done

JIRA_TICKET="${JIRA_PROJECT_KEY}-${TICKET_NUMBER}"

while true; do
    SCOPE=$(
        gum input \
            --placeholder "Scope (e.g. api, auth, ui)"
    )

    [ -n "$SCOPE" ] && break
    gum style --foreground 1 "Scope is required"
done

while true; do
    DESCRIPTION=$(
        gum input \
            --placeholder "Description (imperative, e.g. add retry logic to payment endpoint)"
    )

    [ -n "$DESCRIPTION" ] && break
    gum style --foreground 1 "Description is required"
done

BASE_BRANCH=$(git symbolic-ref --short HEAD)
BRANCH_NAME="${BRANCH_TYPE}/${JIRA_TICKET}"
COMMIT_MESSAGE="${BRANCH_TYPE}(${SCOPE}): ${JIRA_TICKET} | ${DESCRIPTION}"

gum confirm "$(
    cat <<EOF
About to create and publish:

Branch :
  ${BRANCH_NAME}
Base :
  ${BASE_BRANCH}

Commit :
  ${COMMIT_MESSAGE}

Then create a Merge Request.
EOF
)" || exit 1

git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}" && {
    echo "Branch already exists: ${BRANCH_NAME}" >&2
    exit 1
}

git switch -c "$BRANCH_NAME"
git config "branch.${BRANCH_NAME}.origin" "$BASE_BRANCH"

git commit --allow-empty -m "$COMMIT_MESSAGE"
git push -u origin "$BRANCH_NAME"

mr

echo
echo "Workflow completed:"
echo "- Branch created and pushed"
echo "- Initial commit created"
echo "- Merge Request opened"
