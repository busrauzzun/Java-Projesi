---
name: pr-naming
description: Use when opening a pull request in this repository. Defines the required PR title format (Conventional Commits style), allowed types, scope, and examples — apply whenever generating a `gh pr create` title.
---

# PR naming guidance for task-api

Every pull request title in this repository must follow Conventional Commits. The title is the single source of truth for changelog generation and review triage, so get it right the first time.

## Format

```
<type>(<scope>): <short summary>
```

- `<type>` — one of the allowed types below. Lowercase.
- `<scope>` — optional but encouraged. The module or area touched, lowercase, no spaces (`task`, `logging`, `tests`, `ci`, `deps`).
- `<short summary>` — imperative mood, lowercase, no trailing period, **≤ 60 chars** (hard cap 70 for the whole title).

Breaking changes append `!` before the colon: `feat(task)!: drop description field`.

## Allowed types

| Type       | When to use                                                            |
|------------|------------------------------------------------------------------------|
| `feat`     | New user-facing capability (new endpoint, new field, new behavior).    |
| `fix`      | Bug fix in existing behavior.                                          |
| `refactor` | Internal restructuring, no behavior change.                            |
| `perf`     | Performance improvement, no behavior change.                           |
| `test`     | Adding or restructuring tests only.                                    |
| `docs`     | Documentation only (READMEs, skill files, javadoc).                    |
| `build`    | Maven, Dockerfile, packaging changes.                                  |
| `ci`       | CI pipeline / GitHub Actions changes.                                  |
| `chore`    | Routine maintenance not covered above (dep bumps, gitignore, etc.).    |
| `revert`   | Reverts a previous commit; body must reference the SHA.                |

If a change spans types, pick the one that best describes the user-visible effect. `feat` beats `refactor`; `fix` beats `test`.

## Summary rules

- Imperative: "add task validation", not "added" / "adds" / "adding".
- No ticket numbers, no `[WIP]`, no emojis in the title. Put ticket refs in the body.
- No file paths or class names — describe the behavior, not the implementation.
- Avoid filler words: "update", "improve", "fix bug" alone are not summaries.

## Good examples

- `feat(task): add completed filter to GET /api/tasks`
- `fix(task): return 404 instead of 500 on unknown id`
- `refactor(service): extract task mapper out of controller`
- `test(task): cover validation error responses`
- `docs(skills): add logging guidance`
- `chore(deps): bump spring-boot to 3.3.5`
- `feat(task)!: drop legacy description field`

## Bad examples (and why)

- `Update TaskController.java` — no type, references a file, not imperative.
- `feat: stuff` — summary is empty noise.
- `Fixed a bug where deleting a task that didn't exist returned 500 instead of 404 which broke the frontend` — over the length cap; trim and move detail to the body.
- `feat(task): Added new endpoint.` — wrong tense, trailing period, capitalized summary.

## When generating a PR title

1. Read the diff. Pick the type from the table above based on the user-visible effect.
2. Pick a scope from the touched packages (`task`, `logging`, `tests`, `build`, `ci`, `skills`, `deps`).
3. Write the summary in the imperative, under 60 chars, no period.
4. Verify total title length ≤ 70 chars before calling `gh pr create`.
