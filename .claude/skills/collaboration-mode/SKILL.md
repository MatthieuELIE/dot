---
name: collaboration-mode
description: >
  Collaborative planning workflow where the plan is written to a real
  markdown file in the repo (.planning/<feature>.md) instead of native plan
  mode, so it can be reviewed and annotated by hand (Neovim or another
  editor) before implementation starts. Triggered by the phrase "let's go
  collaborative mode" or the /collaboration command. Use for any non-trivial
  coding task where the user wants to validate the approach in writing,
  with a cycle of `<!-- ANNOTATION: ... -->` comments in the plan file,
  before any code gets written.
---

Replaces native plan mode with a versioned plan in the repo that can be
annotated directly in an external editor.

## Workflow

1. **Research, read-only.** Explore the necessary code (Read/Grep/Glob).
   No writing at this stage.

2. **First draft of the plan.** Write it to `.planning/<feature-name>.md`
   at the root of the current project:
   - Create `.planning/` if it doesn't exist.
   - Add `.planning/` to the project's `.gitignore` if not already there.
   - Required structure: `## Context`, `## Approach`, `## Files changed`,
     `## Steps`, `## Open questions`.
   - Language: match the rest of the project; default to French if
     ambiguous.

3. **Stop.** Explicitly say the file is ready to be annotated, and don't
   touch it again until the user says to continue — they're reviewing it
   in their editor.

4. **Resume.** When the user says to continue: reread the file, find every
   `<!-- ANNOTATION: ... -->`, adapt the plan accordingly, then remove each
   annotation once handled.
   - If an annotation is phrased as an open question rather than a clear
     directive (e.g. "move the child? or notify instead?"), don't just bury
     your choice in the rewritten prose. When you announce the file is
     ready for review again (next step 3), summarize the decision made for
     each such question in one visible line in the chat ("Decision made:
     ..."), so the user doesn't have to reread everything to find it.

5. **Repeat steps 3-4** as long as `<!-- ANNOTATION: -->` markers remain in
   the file.

6. **Confirm before implementing.** As soon as no annotations remain, stop
   and explicitly ask for confirmation, e.g.: "No more annotations
   detected. Should I move to implementation?" Never start coding without
   this explicit confirmation, even if the plan looks complete.

7. **Implement.** Once confirmed, implement according to the plan. Leave
   `.planning/<feature-name>.md` in place afterward — don't delete it.

## Constraints

- Never edit the plan file while the user is reading/annotating it — only
  in explicit response to "continue" (step 4).
- One planning task per file at a time; don't reuse an existing
  `.planning/` file for a different feature.
