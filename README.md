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
  validate-skills.sh       # Validate skill frontmatter and structure
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

## Staying Up to Date

The playbook evolves as we learn. Copies drift — use one of these strategies to stay current.

### Git submodule (recommended for teams)

Pins a specific commit and makes updates explicit via PR:

```bash
# Add once
git submodule add https://github.com/HunterGerlach/agent-playbook.git .agent/playbook

# Bootstrap symlinks from the submodule
ln -s .agent/playbook/AGENTS.md AGENTS.md
ln -s AGENTS.md CLAUDE.md
```

To pull the latest:

```bash
cd .agent/playbook && git pull origin main && cd -
git add .agent/playbook
git commit -m "Update agent-playbook to latest"
```

Team members get the update automatically on their next `git pull` + `git submodule update --init`.

### Local symlinks (solo / single-machine)

If you cloned agent-playbook alongside your projects, the symlink approach from Quick Start keeps files in sync with no manual steps. Good for solo work; doesn't travel with the repo.

### Periodic copy-refresh

If you prefer vendored copies (e.g., air-gapped environments), create a script or CI job to refresh:

```bash
# .agent/update-playbook.sh
#!/usr/bin/env bash
set -euo pipefail
PLAYBOOK="${1:?Usage: update-playbook.sh /path/to/agent-playbook}"
cp "$PLAYBOOK/AGENTS.md" "$(git rev-parse --show-toplevel)/AGENTS.md"
cp "$PLAYBOOK/AGENT_INSTRUCTIONS.md" .agent/
cp -r "$PLAYBOOK/modules" .agent/
cp -r "$PLAYBOOK/scripts" .agent/
cp -r "$PLAYBOOK/skills"  .agent/
echo "Playbook updated from $PLAYBOOK at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
```

Run it periodically or add a CI reminder to check for upstream changes.

### Which strategy to use?

| Situation | Strategy |
|---|---|
| Team repo, want controlled updates | **Git submodule** |
| Solo dev, playbook cloned locally | **Local symlinks** |
| Air-gapped / vendored / no submodules | **Periodic copy-refresh** |

## How It Works

- **AGENTS.md** is a slim bootstrap stub. Tools that scan for `AGENTS.md` get the critical minimum: prime protocol, non-interactive safety, session completion, and a pointer to the full instructions.
- **AGENT_INSTRUCTIONS.md** contains the complete operational and engineering standards, organized in three parts:
  1. **Agent Operations** — prime protocol, task workflow, non-interactive safety, session completion
  2. **Engineering Standards** — architecture, testing, delivery, security, versioning
  3. **Context & Integration** — thinking tools, AI norms, skills, Beads/Gas Town, project customization

## Skills

Skills are on-demand runbooks with progressive disclosure — agents see metadata up front and load full instructions only when relevant. All skills follow the risk tier model in [`skills/_POLICY.md`](skills/_POLICY.md).

See [`skills/README.md`](skills/README.md) for the full catalog with descriptions.

## Further Reading

- [`AGENTS.md`](AGENTS.md) — Bootstrap stub (what agents see first)
- [`AGENT_INSTRUCTIONS.md`](AGENT_INSTRUCTIONS.md) — Complete operational and engineering standards
- [`modules/`](modules/) — Tool integrations (Beads, Gas Town)
- [`skills/_POLICY.md`](skills/_POLICY.md) — Skill risk tiers and security rules
