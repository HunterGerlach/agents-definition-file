# agents-definition-file

A universal, portable `AGENTS.md` that codifies durable software engineering principles for AI-assisted development. Drop it into any project to give AI agents consistent, high-quality instructions.

## Usage

**Copy or symlink into your project root:**

```bash
# Option A: symlink (stays in sync with this repo)
ln -s /path/to/agents-definition-file/AGENTS.md ~/your-project/AGENTS.md

# Option B: copy (independent snapshot)
cp /path/to/agents-definition-file/AGENTS.md ~/your-project/AGENTS.md
```

**For Claude Code compatibility**, add a symlink in your project:

```bash
ln -s AGENTS.md CLAUDE.md
```

## Project-Specific Overrides

`AGENTS.md` is intentionally language- and framework-agnostic. For project-specific details (tech stack, repo conventions, team norms), use one of:

- The repo's own `AGENTS.md` (overrides this template)
- `AGENTS.override.md` (where supported by the tool)
- Nested `AGENTS.md` files in subdirectories

Project-level instructions extend and may override the universal defaults.

## What's Inside

`AGENTS.md` includes an **Operating Protocol** (repeatable task workflow with Definition of Done), then covers: problem understanding, architecture & design, TDD & testing, application delivery (inner/outer loop), versioning & git discipline, security & compliance (FIPS, zero-trust), thinking tools, AI-assisted development norms, and documentation artifacts.

See [`AGENTS.md`](AGENTS.md) for the full file.
