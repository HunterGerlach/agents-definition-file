# AGENTS.md — Bootstrap

See **[AGENT_INSTRUCTIONS.md](AGENT_INSTRUCTIONS.md)** for complete instructions.

This file provides the minimum critical guidance for any agent. Read the full instructions when possible.

## Prime Protocol

On every session start, after compaction, or after context clear:

1. Run the repo's prime command: `bd prime` / `gt prime` / `make agent-prime`
2. If no prime command exists, read `AGENT_INSTRUCTIONS.md` and identify test/lint/build commands before editing code.
3. Re-prime after any compaction or context reset.

## Non-Interactive Safety

- Never open editors or pagers (`$EDITOR`, `less`, `more`, `vi`, `nano`).
- Use non-interactive flags: `cp -f`, `mv -f`, `rm -rf`, `apt-get -y`.
- Use batch mode for remote operations: `ssh -o BatchMode=yes`, `scp -o BatchMode=yes`.
- Assume shell aliases may add `-i` (interactive). Always use explicit flags.
- Use `gh` CLI for GitHub operations — never browser or playwright tools.
- If a command might prompt for input, find the non-interactive alternative or skip it and explain why.

## Session Completion

Before ending any session:

1. File follow-ups — create issues/beads for remaining work.
2. Run quality gates — test, lint, build (if code changed). All must pass.
3. Commit all changes with meaningful messages.
4. Push if you have write access. If not, commit locally and produce a patch/diff with apply instructions.
5. Verify clean state — `git status` shows no uncommitted work.
6. Summarize — what was done, what remains, where to pick up next.

## Ask Before Proceeding

- Requirements are ambiguous.
- The change affects public APIs or security posture.
- A new production dependency is needed.
- The change requires broad refactors or file moves.
