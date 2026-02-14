# agents-definition-file

A universal, portable agent instruction set that codifies operational protocols and durable engineering principles for AI-assisted development. Drop it into any project to give AI agents consistent, high-quality guidance.

## Repo Structure

```
AGENTS.md                  # Bootstrap stub (tool compatibility + critical ops)
CLAUDE.md -> AGENTS.md     # Claude Code compatibility symlink
AGENT_INSTRUCTIONS.md      # Full instructions (operations + standards)
modules/
  beads.md                 # Beads task tracking integration (default-on)
  gastown.md               # Gas Town multi-agent integration (default-on)
scripts/
  agent-prime.sh           # Template prime script (fallback for projects without bd/gt)
```

## Quick Start

**Copy or symlink into your project root:**

```bash
# Option A: symlink (stays in sync with this repo)
ln -s /path/to/agents-definition-file/AGENTS.md ~/your-project/AGENTS.md
ln -s /path/to/agents-definition-file/AGENT_INSTRUCTIONS.md ~/your-project/AGENT_INSTRUCTIONS.md

# Option B: copy (independent snapshot)
cp /path/to/agents-definition-file/AGENTS.md ~/your-project/
cp /path/to/agents-definition-file/AGENT_INSTRUCTIONS.md ~/your-project/
```

**For Claude Code compatibility:**

```bash
ln -s AGENTS.md CLAUDE.md
```

**Optional — copy modules and prime script as needed:**

```bash
cp -r /path/to/agents-definition-file/modules ~/your-project/
mkdir -p ~/your-project/scripts && cp /path/to/agents-definition-file/scripts/agent-prime.sh ~/your-project/scripts/
```

## How It Works

- **AGENTS.md** is a slim bootstrap stub. Tools that scan for `AGENTS.md` get the critical minimum: prime protocol, non-interactive safety, session completion, and a pointer to the full instructions.
- **AGENT_INSTRUCTIONS.md** contains the complete operational and engineering standards, organized in three parts:
  1. **Agent Operations** — prime protocol, task workflow, non-interactive safety, session completion
  2. **Engineering Standards** — architecture, testing, delivery, security, versioning
  3. **Context & Integration** — thinking tools, AI norms, Beads/Gas Town, project customization

## Tool Integration

This workflow defaults to **Beads** for task tracking and **Gas Town** for multi-agent coordination:

- If `bd` or `.beads/` is present: use Beads as the task ledger
- If `gt` or `GT_ROLE` is set: use Gas Town for priming and coordination
- If neither is available: use `scripts/agent-prime.sh` and GitHub Issues

Projects may opt out by documenting the exception in project-level instructions.

## Project-Specific Overrides

These files are intentionally language- and framework-agnostic. For project-specific details, use:

- The repo's own `AGENTS.md` (overrides this template)
- `AGENTS.override.md` (where supported by the tool)
- Nested `AGENTS.md` files in subdirectories

Project-level instructions extend and may override the universal defaults.

## What's Inside

See [`AGENTS.md`](AGENTS.md) for the bootstrap stub and [`AGENT_INSTRUCTIONS.md`](AGENT_INSTRUCTIONS.md) for the full instructions.
