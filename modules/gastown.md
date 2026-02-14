# Gas Town Integration

Gas Town (`gt`) is the default multi-agent coordination tool. When running under Gas Town, follow these guidelines.

## Detection

Gas Town is active when any of the following are true:
- The `gt` command is available on PATH
- A `GT_ROLE` environment variable is set
- The working directory is within a Gas Town workspace structure

## Priming

- Always use `gt prime` for session initialization — it assembles role-specific context dynamically.
- After compaction or context clear, re-run `gt prime` immediately.
- Do NOT rely on static instruction files for role context when Gas Town is active. `gt prime` is the source of truth.

## Role Behavior

- Gas Town assigns roles based on filesystem location. Trust the role you're given.
- Do NOT add global directives to static files (AGENTS.md, CLAUDE.md) that could cause role drift. Universal instructions should not conflict with your assigned role.
- If role context conflicts with universal instructions, follow the role context.

## CLAUDE.md Under Gas Town

- Gas Town generates CLAUDE.md per-clone. It is gitignored.
- Do NOT commit a CLAUDE.md when working under Gas Town.
- The generated CLAUDE.md is tailored to your role and workspace.

## Key Commands

- `gt prime` — inject role context
- `gt mail check --inject` — check inter-agent mail
- `gt done` — signal work completion
- `gt handoff` — hand off to a new session with context

## When Gas Town Is Not Active

If `gt` is not available:
- Use `bd prime` (if Beads is available) or `make agent-prime` / `./scripts/agent-prime`
- Manage sessions manually using the session completion protocol in `AGENT_INSTRUCTIONS.md`.
