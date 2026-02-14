# Skills Catalog

Canonical skill definitions for AI-assisted development workflows. These skills are tool-agnostic and can be installed into Claude Code, Codex, GitHub Copilot, or any tool that supports the Agent Skills specification.

## Available Skills

| Skill | Tier | Description |
|---|---|---|
| `adr-writing` | 0 | Write Architecture Decision Records for significant architectural choices |
| `security-review` | 0 | Security review checklist for changes touching auth, crypto, or external interfaces |
| `dependency-adding` | 0 | Evaluate and add dependencies with supply-chain security and compliance checks |
| `ci-debugging` | 0 | Systematically debug CI/CD pipeline failures |

## Installation

```bash
# Install into tool-specific directories (defaults to symlinks)
./scripts/install-skills.sh

# Use copies instead of symlinks
./scripts/install-skills.sh --copy

# Install for a specific tool only
./scripts/install-skills.sh --target claude
```

See [`_POLICY.md`](_POLICY.md) for the risk tier model and security rules.
