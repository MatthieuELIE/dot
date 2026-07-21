---
name: ship
description: >
  Branch, implement, verify, commit, push, and open a GitHub PR for review —
  the standard workflow for turning a task into a reviewable pull request.
  Use when the user asks to start work on a new branch, get a change ready
  for review, "ship" something, or open a PR for the current work. Does not
  handle addressing PR review comments after the fact — that is a separate,
  explicit ask.
---

Ties together branch creation, verification, and PR opening into one flow so
none of the steps get skipped under time pressure.

## Steps

1. **Before writing any code** — run `git status`. If there is unstaged or
   uncommitted work that isn't yours to discard, stash it (`-u` for
   untracked) or ask before touching it.

   Find the default branch first: `git symbolic-ref refs/remotes/origin/HEAD`
   (or `git remote show origin` if that's unset), and make sure it's up to
   date (`git fetch origin` / `git pull`) before branching off it — branching
   off a stale local main leads to avoidable conflicts later.

   Derive the branch name from how this repo actually names branches, don't
   default to a generic scheme:
   - `git branch -a` and `git log --all --oneline -20` for recent branch/PR
     names in this repo.
   - If the repo uses type-prefixed branches (`feat/`, `fix/`, `refactor/`,
     `chore/`, `test/`, `docs/`), pick the prefix matching the task and follow
     it with a short kebab-case description of *what*, not the ticket number
     alone: `feat/configurable-templates`, not `feat/phase-2-task-3`.
   - If the repo shows no consistent pattern, ask rather than invent one.

   `git checkout -b <branch>` from the up-to-date default branch.

2. **Implement** the requested change.

3. **Verify before committing** — discover and run the project's own checks,
   don't assume a stack. Look in order: `CLAUDE.md`, `README`, `package.json`
   scripts, `Makefile`, CI config (`.github/workflows/*.yml`). Typical set:
   lint, format-check, test suite. Fix failures — never skip hooks or checks
   to force a green run, and never invent a check the project doesn't define.

4. **Commit** following this harness's standard git conventions (see the
   "Committing changes with git" instructions already in context: new commit
   rather than amend, never `--no-verify`, review `git status`/`git diff`
   before staging, HEREDOC for the message). On top of that:
   - Message format is strict, always: `type(scope): summary` (e.g.
     `fix(core): harden path resolution`, `test(core): add tests on
     toggle_diary`). No exceptions for repos that don't already use it. The
     summary must be short and unambiguous — one clause, no filler, no
     restating the file list.
   - Stage only the files the change actually touches (`git add <path>...`),
     never `-A`/`.`. Double-check anything untracked-but-unrelated (like
     stray config files) is left out.
   - One commit per logical unit of work. If the same session later
     addresses PR review feedback, that's a separate follow-up commit, not a
     rewrite of this one (no amend/rebase unless asked).
   - The commit message is the single `type(scope): summary` line only — no
     body paragraph, no `Co-Authored-By` trailer. This overrides the general
     "Committing changes with git" instructions on that one point.

5. **Push** the branch with `-u` so it tracks upstream.

6. **Open the PR** with `gh pr create`, targeting the repo's default branch.
   Body is a `## Summary` section only — a few short bullet points on what
   changed and why. No `## Test plan` section, no checklists. Report the PR
   URL back to the user.

## Boundaries

- Never merges, never force-pushes, never skips hooks (`--no-verify` etc.)
  unless explicitly told to.
- Stops once the PR is open. Reading and addressing review comments is a
  separate, explicit request — not part of this flow.
- Not a GitHub repo / no remote configured: say so rather than guessing a
  URL or silently skipping the PR step.
