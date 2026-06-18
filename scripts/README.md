# Scripts

This directory contains personal shell scripts, versioned with dotfiles
and intended for local use.

These scripts are designed to be:
- simple
- explicit
- self-contained
- understandable over time

They form a small, controlled personal toolbox — not a generic utility library.

---

## Philosophy

- Each script does **one thing**, clearly.
- A script’s behavior is defined **inside the script itself**.
- A script’s exposure (aliases, shell integration) is **declarative**, via metadata.
- No script relies on implicit or hidden conventions.

---

## Script structure

A script in this directory:
- is executable
- starts with a valid shebang
- may declare metadata using comments at the top of the file

Minimal example:

```sh
#!/usr/bin/env sh
# alias: audit
# description: npm audit filtered to high and critical vulnerabilities
```

Metadata is **optional**.

---

## Supported metadata

Scripts can declare metadata using comment directives.

### `alias`

```sh
# alias: audit
```

- Defines a shell alias for the script.
- Optional.
- If no alias is defined, the script is only usable via its path.
- A script must declare **at most one alias**.

---

### `description`

```sh
# description: npm audit filtered to high and critical vulnerabilities
```

- Human-readable description of what the script does.
- Documentation-only.
- May be used by future tooling (listing, help, etc.).

---

## About aliases

- Aliases are **never implicit**.
- The file name does not imply the alias name.
- Adding an alias is an **explicit decision**.
- Aliases are generated automatically from metadata (via `install.sh`).

---

## Best practices

- Prefer clarity over cleverness.
- Keep scripts small and focused.
- Document intent using `description`.
- Avoid modifying generated files (`node_modules`, build artifacts, etc.).

---

## What this directory is not

- A generic CLI tool
- A shared library
- A framework
- A place for throwaway scripts

This is a **personal, controlled, explicitly documented** space.
