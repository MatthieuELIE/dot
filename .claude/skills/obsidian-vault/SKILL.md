---
name: obsidian-vault
description: This skill should be used when the user wants to create, read, edit, or organize notes in their Obsidian vault ("Vault 713") — e.g. "note ça dans mon vault", "crée une note sur X", "range ça dans mes ressources/projets", or any request involving Obsidian notes, todos, or the vault's knowledge base. Applies whether the current session is opened elsewhere (interact via `obsidian-cli`) or directly inside the vault (interact via direct file access).
metadata:
  version: 1.0.0
---

# Obsidian Vault (Vault 713)

## Context

- Vault = personal + professional second brain, private notes, never shared
- Note language: French (English for technical content — function names, commands, snippets)
- Note style: concise, structured, factual — no filler
- Documentation after the fact — notes capture what was done/learned, not in real time
- Content: technical/dev notes, learnings, watch topics (JavaScript, Apple, AI — structure around concept/source/concrete impact)

## How to interact with the vault

- **Session opened elsewhere than in the vault**: go through `obsidian-cli` (binary `/Applications/Obsidian.app/Contents/MacOS/obsidian-cli`, alias `obsidian`). See `obsidian-cli --help` for the list of commands (`create`, `append`, `vault`, etc.).
  - Vault path on disk: `obsidian-cli vault info=path`.
  - Creating a new note: direct via `obsidian-cli create name=<name> content=<text>`, no intermediate draft.
- **Session opened directly in the vault**: direct access (native Read/Write/Edit), no need to go through the CLI.
- In both cases, same conventions below (structure, categories, formatting).
- **Modifying or deleting an existing note**: never without explicit user confirmation, regardless of access mode.

## Vault structure

```
00_INBOX/          → Quick notes to process later
01_DAILY_NOTES/    → Journal, one note per day (YYYY/MM/DD-MM-YYYY.md), managed by vault.nvim
02_KNOWLEDGE_BASE/ → Evergreen notes, flat + categories/Bases (see below)
03_RESOURCES/
  Templates/       → Reusable templates
  Bases/           → .base files (one table view per category)
04_PERSONAL/       → Finances, jobs, style — flat + categories/Bases
05_PROJECTS/       → One folder per project; todos.md managed by vault.nvim (fixed path, do not flatten)
  <project>/plans/ → Dev traces (plans written in collaborative mode), one note per feature/PR
```

No subfolders in `02_KNOWLEDGE_BASE/` and `04_PERSONAL/`: deep folder navigation is deliberately avoided (see Categories and Bases). `05_PROJECTS/<project>/` stays foldered: `todos.md` is addressed there mechanically by vault.nvim (Neovim cwd), no navigation involved so it's not affected by the flattening.

`05_PROJECTS/<project>/plans/`: dev traces (plans written in collaborative mode, `.planning/` in the project's repo — context, technical approach, files changed), not general knowledge notes. One note per feature/PR, `kebab-case.md` with no project prefix or `(plan)` suffix (the folder already gives the context). No category or Base for now — to be reassessed based on volume across multiple projects.

## Categories and Bases

Replaces the "one folder per subject" logic in `02_KNOWLEDGE_BASE/` and `04_PERSONAL/`. Each note carries a `categories` property (list, multiple values possible), in addition to the standard fields (full frontmatter documented in File Conventions):

```yaml
categories:
  - "[[JavaScript]]"
  - "[[DevOps]]"
```

For each category: a flat entry note (`02_KNOWLEDGE_BASE/CategoryName.md`) containing `![[CategoryName.base]]`, and the corresponding file in `03_RESOURCES/Bases/CategoryName.base` (filter `note.categories.contains(link("CategoryName"))`). To find a note: full-text or tag search first, the category note only when you want a grouped table view.

`Todo` category: exception to the scope above, carried only by `05_PROJECTS/<project>/todos.md` (tag = project name in kebab-case). Groups the todos of all projects in `Todo.base`. New todos.md → start from `03_RESOURCES/Templates/Todo Template.md`.

## File conventions

- Naming: `kebab-case.md` (e.g. `my-new-note.md`)
- Metadata in YAML frontmatter when needed:

```yaml
---
categories:
  - "[[CategoryName]]"
tags:
  - tag1
  - tag2
aliases: ["An alias"]
creation-date: YYYY-MM-DD
---
```

- `categories` only for `02_KNOWLEDGE_BASE/` and `04_PERSONAL/` (see Categories and Bases), except `05_PROJECTS/<project>/todos.md` (`categories: [[Todo]]`, this file only)
- `tags`: multi-line YAML list only (no inline `[a, b]` format, no quotes) — one single format across the whole vault

## Formatting conventions

- Unordered lists: dash `-`
- Headings: ATX style (`#`, `##`, `###`)
- External links: `[text](https://url.com)`
- Internal links: `[[note-name]]`
- Inline comments: `<!-- comment -->`
- Spacing:
  - Two blank lines between main sections
  - One blank line after each heading
  - One blank line before and after each code block
- Never use `---` or `***` as visual separators in notes

## Available templates

Before creating a new note, always check whether a template exists in `03_RESOURCES/Templates/`:

- `Daily Note Template.md` (used by vault.nvim)
- `Todo Template.md` (new project `todos.md`)

If no template fits, propose a structure before creating — do not assume a template exists without checking.

## Instructions for Claude

- If the request is ambiguous, ask a single clarifying question before generating/creating
- Propose the right destination folder based on the vault structure for any new note
- After each creation/edit, propose a conventional git commit (`docs: add note-name.md` / `docs: update note-name.md`); group multiple files into a single commit
- Never touch the `.obsidian/` folder

**Mobile (claude.ai, no direct access to the vault or `obsidian-cli`)**

- Generate notes in plain Markdown, in a code block, ready to copy-paste into Obsidian
</content>
