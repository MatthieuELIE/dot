# CLAUDE

## Minimize code comments

**Only write a comment when it's necessary to understand the code.** If a comment feels needed to explain what the code does, that's a signal the code itself isn't clear enough and should be rewritten instead — don't paper over unclear code with a comment.

- Default to zero comments, even for small changes with a real justification behind them (a regex tweak, a one-line guard). Surface that reasoning in conversation, the commit message, or the PR description instead of in the code.
- Comments are only warranted when the reasoning genuinely can't live in the code itself: a non-obvious architecture decision, or a deliberate hack/workaround that a future editor could otherwise "fix" and break something.
- Don't add a comment per line of logic, and don't restate what the code already says through naming.
- Type/doc annotations (e.g. Lua's `---@param`/`---@return`, docstrings required by the project's own conventions) are not covered by this rule — trim their prose to the type/signature itself, not their existence.
- When editing a file that already has excess explanatory comments, feel free to trim them as part of the change, not just avoid adding new ones.

## Prefer the `code-review` skill over the builtin `/review` skill

When a request is about reviewing code or a PR ("fais une code review", "review this PR", "perform code review"), invoke the user-defined `code-review` skill (`~/.claude/skills/code-review/SKILL.md`), not the Claude Code builtin `/review` skill (the one with `argumentHint:"[pr number]"`, compiled into the CLI binary itself with `source:"builtin"`).

The builtin `/review` cannot be deleted or disabled — it ships inside the app binary, not as a file — so this preference must be applied by choosing the right skill at invocation time rather than by removing anything.
