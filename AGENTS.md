# AGENTS.md — Bootstrap

See **[AGENT_INSTRUCTIONS.md](AGENT_INSTRUCTIONS.md)** for complete instructions.
<!-- If you moved support files into .agent/, change the path above to .agent/AGENT_INSTRUCTIONS.md -->

This file provides the minimum critical guidance for any agent. Read the full instructions when possible.

## Prime Protocol

On every session start, after compaction, or after context clear:

1. Run the repo's prime command: `bd prime` / `gt prime` / `make agent-prime` / `./scripts/agent-prime.sh`
2. If no prime command exists, read `AGENT_INSTRUCTIONS.md` (or `.agent/AGENT_INSTRUCTIONS.md`) and identify test/lint/build commands before editing code.
3. Re-prime after any compaction or context reset.

## Critical Safety Rails

- **Non-interactive only.** Never open editors/pagers. Use non-interactive flags (`-f`, `-y`, `BatchMode=yes`). Use `gh` CLI for GitHub — never browser tools. Full list in AGENT_INSTRUCTIONS.md.
- **Clean up every session.** Run quality gates, commit all changes, push if possible, verify `git status` is clean, summarize what was done and what remains. Full checklist in AGENT_INSTRUCTIONS.md.

## Ask Before Proceeding

- Requirements are ambiguous.
- The change affects public APIs or security posture.
- A new production dependency is needed.
- The change requires broad refactors or file moves.
