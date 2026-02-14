# agent-playbook

A universal, portable agent instruction set that codifies operational protocols and durable engineering principles for AI-assisted development. Drop it into any project to give AI agents consistent, high-quality guidance.

## Repo Structure

```
AGENTS.md                  # Bootstrap stub (tool compatibility + critical ops)
CLAUDE.md -> AGENTS.md     # Claude Code compatibility symlink
AGENT_INSTRUCTIONS.md      # Full instructions (operations + standards)
skills/
  _POLICY.md               # Risk tier model and security rules for skills
  adr-writing/             # Tier 0: Architecture Decision Records
  security-review/         # Tier 0: Security review checklist
  dependency-adding/       # Tier 0: Dependency evaluation workflow
  ci-debugging/            # Tier 0: CI/CD pipeline debugging
  disconnected-environments/ # Tier 0: Air-gapped validation
  feature-spec/            # Tier 0: Spec-driven development
  root-cause-analysis/     # Tier 0: Root cause analysis (iterative "why?" technique)
modules/
  beads.md                 # Beads task tracking integration (default-on)
  gastown.md               # Gas Town multi-agent integration (default-on)
scripts/
  agent-prime.sh           # Template prime script (fallback for projects without bd/gt)
  install-skills.sh        # Install skills into tool-specific directories
```

## Quick Start

### Recommended layout

Keep only the bootstrap file at your project root. Everything else goes in a subdirectory (`.agent/` by convention) to avoid cluttering the repo:

```
your-project/
  AGENTS.md              # Bootstrap stub (required at root — tools scan for it)
  CLAUDE.md -> AGENTS.md # Claude Code compatibility symlink
  .agent/                # All playbook support files live here
    AGENT_INSTRUCTIONS.md
    modules/
    scripts/
    skills/
  src/                   # ← your code, undisturbed
  ...
```

### Setup

```bash
PLAYBOOK=/path/to/agent-playbook
PROJECT=~/your-project

# 1. Bootstrap file — must be at project root (tools scan for it)
#    Option A: symlink (stays in sync)
ln -s "$PLAYBOOK/AGENTS.md" "$PROJECT/AGENTS.md"
#    Option B: copy (independent snapshot)
cp "$PLAYBOOK/AGENTS.md" "$PROJECT/AGENTS.md"

# 2. Claude Code compatibility
ln -s AGENTS.md "$PROJECT/CLAUDE.md"

# 3. Support files — keep in .agent/ subdirectory
mkdir -p "$PROJECT/.agent"
cp "$PLAYBOOK/AGENT_INSTRUCTIONS.md" "$PROJECT/.agent/"
cp -r "$PLAYBOOK/modules" "$PROJECT/.agent/"
cp -r "$PLAYBOOK/scripts" "$PROJECT/.agent/"
cp -r "$PLAYBOOK/skills"  "$PROJECT/.agent/"
```

Then update the path in your project's `AGENTS.md` bootstrap to point to `.agent/AGENT_INSTRUCTIONS.md` instead of `AGENT_INSTRUCTIONS.md`.

### Install skills into tool-specific directories

```bash
# Install for all supported tools (symlinks by default)
./scripts/install-skills.sh

# Install for a specific tool
./scripts/install-skills.sh --target claude

# Use copies instead of symlinks
./scripts/install-skills.sh --copy
```

## How It Works

- **AGENTS.md** is a slim bootstrap stub. Tools that scan for `AGENTS.md` get the critical minimum: prime protocol, non-interactive safety, session completion, and a pointer to the full instructions.
- **AGENT_INSTRUCTIONS.md** contains the complete operational and engineering standards, organized in three parts:
  1. **Agent Operations** — prime protocol, task workflow, non-interactive safety, session completion
  2. **Engineering Standards** — architecture, testing, delivery, security, versioning
  3. **Context & Integration** — thinking tools, AI norms, skills, Beads/Gas Town, project customization

## Skills

Skills are on-demand runbooks installed into tool-specific directories. They use progressive disclosure — agents see metadata up front and load full instructions only when relevant.

| Skill | Tier | Description |
|---|---|---|
| `adr-writing` | 0 | Architecture Decision Records |
| `security-review` | 0 | Security review checklist |
| `dependency-adding` | 0 | Dependency evaluation workflow |
| `ci-debugging` | 0 | CI/CD pipeline debugging |
| `disconnected-environments` | 0 | Air-gapped / network-restricted validation |
| `feature-spec` | 0 | Feature spec creation (spec-driven development) |
| `root-cause-analysis` | 0 | Root cause analysis (iterative "why?" technique) |

All skills follow a strict risk tier model defined in [`skills/_POLICY.md`](skills/_POLICY.md). See [`skills/README.md`](skills/README.md) for the full catalog.

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
