#!/usr/bin/env sh

# bin: audit
# description: npm audit filtered to high and critical vulnerabilities

tmp_file="/tmp/audit.json"

npm audit --json >"$tmp_file" || true

node <<'EOF'
const fs = require("fs");

const { vulnerabilities } = JSON.parse(
  fs.readFileSync("/tmp/audit.json", "utf8")
);

const filtered = Object.values(vulnerabilities)
  .filter(v => {
    const severity = v.severity.toLowerCase();
    return severity === "high" || severity === "critical";
  });

console.log(JSON.stringify(filtered, null, 2));
EOF
