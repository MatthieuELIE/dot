#!/bin/bash

# bin: mr
# description: ...

set -o errexit
set -o nounset
set -o pipefail

for var in JIRA_HOST GITLAB_TOKEN GITLAB_USERID; do
    [ -n "${!var:-}" ]
done

CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

case "$CURRENT_BRANCH" in
*/*)
    ISSUE_ID=${CURRENT_BRANCH#*/}
    ;;
*)
    exit 1
    ;;
esac

[ -n "$ISSUE_ID" ]

ORIGIN_BRANCH=$(git config --get branch.$CURRENT_BRANCH.origin)
[ -n "$ORIGIN_BRANCH" ]

COMMIT_TITLE=$(git log -1 --pretty=%s)
[ -n "$COMMIT_TITLE" ]

REMOTE_URL=$(git remote get-url origin)
[ -n "$REMOTE_URL" ]

REMOTE_HOST=""
PROJECT_PATH=""

case "$REMOTE_URL" in
git@*:*/*.git)
    REMOTE_HOST=${REMOTE_URL#git@}
    REMOTE_HOST=${REMOTE_HOST%%:*}
    PROJECT_PATH=${REMOTE_URL#*:}
    PROJECT_PATH=${PROJECT_PATH%.git}
    ;;
https://*/*/*.git)
    REMOTE_HOST=${REMOTE_URL#https://}
    REMOTE_HOST=${REMOTE_HOST%%/*}
    PROJECT_PATH=${REMOTE_URL#https://$REMOTE_HOST/}
    PROJECT_PATH=${PROJECT_PATH%.git}
    ;;
*)
    exit 1
    ;;
esac

[ -n "$REMOTE_HOST" ]
[ -n "$PROJECT_PATH" ]

PROJECT_ID=$(jq -rn --arg p "$PROJECT_PATH" '$p|@uri')
[ -n "$PROJECT_ID" ]

DESCRIPTION="https://${JIRA_HOST}/browse/${ISSUE_ID}"

RESPONSE=$(
    curl --insecure --silent --show-error --request POST \
        "https://${REMOTE_HOST}/api/v4/projects/${PROJECT_ID}/merge_requests" \
        --header "Authorization: Bearer ${GITLAB_TOKEN}" \
        --header "Content-Type: application/json" \
        --data @- <<EOF
{
  "source_branch": "$CURRENT_BRANCH",
  "target_branch": "$ORIGIN_BRANCH",
  "title": $(jq -n --arg title "Draft: $COMMIT_TITLE" '$title'),
  "assignee_id": $GITLAB_USERID,
  "description": $(jq -n --arg desc "$DESCRIPTION" '$desc'),
  "labels": "Parking",
  "remove_source_branch": true,
  "squash": true
}
EOF
)

if ! jq -e '.web_url' <<<"$RESPONSE" >/dev/null; then
    jq -r '.message' <<<"$RESPONSE"
    exit 1
fi

echo
echo "Merge Request can be found on : $(jq -r '.web_url' <<<"$RESPONSE") !"
