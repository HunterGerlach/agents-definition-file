# Beads Integration

Beads (`bd`) is the default task tracking tool for this workflow. When available, use it as the primary task ledger.

## Detection

Beads is active when any of the following are true:
- The `bd` command is available on PATH
- A `.beads/` directory exists in the repo

## Task Discovery

- `bd ready` — list tasks ready for work
- `bd show <id> --json` — view task details
- `bd ready --json` — machine-readable task list

## Task Lifecycle

- `bd create "title" -p <priority> -t <type>` — create a new task
- `bd update <id> --status in_progress` — claim a task
- `bd close <id> --reason "Completed"` — close completed work

## Session Integration

- `bd prime` — prime your session with current task context
- `bd sync` — sync task state with git (run before push)
- Include `(bd-xxx)` in commit messages to link commits to tasks

## Git Workflow

- Beads uses git hooks for state synchronization.
- Always run `bd sync` before `git push`.
- If merge conflicts occur in `.beads/issues.jsonl`, see Beads documentation for resolution.

## Stealth Mode

If Beads metadata in PRs is unwanted, use stealth mode (see Beads documentation). This keeps task tracking local without polluting pull requests.

## When Beads Is Not Available

Fall back to:
1. GitHub Issues (`gh issue list`, `gh issue create`)
2. TODO files in the repo
3. Inline TODO/FIXME comments (last resort)
