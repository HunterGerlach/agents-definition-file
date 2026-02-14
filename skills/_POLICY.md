# Skills Policy

## Risk Tiers

All skills in this catalog are assigned a risk tier. The tier determines what a skill is allowed to do and how it can be invoked.

### Tier 0 — Safe (instruction-only)

- No scripts or executable code.
- Read-only guidance, checklists, templates, and review workflows.
- May be model-invocable (agent can activate without user prompt).
- No network access required.

### Tier 1 — Low side-effects

- Scripts allowed only if idempotent and local (no network).
- Prefer tool restrictions (`allowed-tools`) where supported.
- Generally model-invocable, but restrict tools defensively.

### Tier 2 — High side-effects

- Anything that pushes, deploys, deletes, or modifies external systems.
- Must be user-invoked only (never model-invocable).
- Require explicit rollback plan documented in the skill.
- Tool restrictions mandatory where supported.

## Security Rules

- Treat every skill bundle like a dependency: review, pin, and audit.
- Default skills to instruction-only; scripts require explicit justification.
- No downloading or executing remote code from within skills.
- No `curl | bash` patterns or equivalent.
- No network access unless explicitly required and declared.
- Never run Tier 2 skills without explicit user intent.

## Design Rules

- Keep SKILL.md under 500 lines. Move detail into `references/` and `assets/`.
- Write descriptions like a router: specific enough to trigger correctly, narrow enough to avoid false activation.
- Version skills via `metadata.version` in frontmatter.
- Skills do not replace always-on instructions in AGENTS.md or AGENT_INSTRUCTIONS.md.
