# MCP Integration

The Model Context Protocol (MCP) provides standardized tool and data connectivity between LLM-based clients and servers. It is an **optional integration** — not a default requirement.

## CLI-First Principle

This playbook defaults to **CLI-first**. Use existing repo CLIs (`git`, `gh`, `make`, language toolchains) directly. They have the lowest integration surface area, are easiest to audit, and already work in every environment.

Use MCP **only when CLI is insufficient**:

- You need typed tool access across multiple agent frontends (Claude Code, Copilot, IDE agents).
- You need structured resource/data integration that CLI pipes handle poorly.
- You need permission boundaries finer-grained than shell access.
- You want a stable, versioned tool interface decoupled from shell string parsing.

If MCP disappeared tomorrow and you'd lose only convenience, stay CLI-first.

## Security Posture

### Local stdio MCP (Tier 1 behavior)

- Runs as a local process; communication over stdin/stdout.
- Side effects are local and controllable.
- Still requires review: a local MCP server can read/write files, run commands, etc.
- Pin server versions. Treat them like dependencies.

### Remote MCP (Tier 2 behavior)

- Remote MCP is **production infrastructure**. Treat it accordingly.
- Requires explicit user intent to enable (never model-invocable).
- Auth model must be documented (OAuth, API key, mTLS).
- Data classification must be assessed — what crosses the network boundary?
- Audit tool definitions: no "run arbitrary command" tools.
- Log all tool invocations.
- Enforce least privilege on server-side tool capabilities.

## Tool Adapter Architecture

When wrapping CLIs as MCP servers, follow the Backends-for-Frontends (BFF) pattern:

```
┌─────────────────────────────────────┐
│  Domain backend (canonical logic)   │
├──────────┬──────────┬───────────────┤
│ CLI      │ MCP      │ Future        │
│ adapter  │ adapter  │ adapter       │
└──────────┴──────────┴───────────────┘
```

- **Domain backend** stays stable — it implements the real operations.
- **Adapters are thin** — they translate between the backend and a specific client protocol.
- Expose **explicit tools with typed arguments**. Do not expose "run arbitrary command" tools.
- Sanitize inputs and allowlist subcommands/flags in the adapter layer.

## Operational Rules for Agents

- Never install unknown MCP servers mid-task.
- Use only pinned, approved servers listed in project configuration.
- Treat MCP servers like dependencies: review, pin, audit, scan.
- If a local CLI covers the need, prefer it over an MCP server.
- Document approved MCP servers in project-level configuration (e.g., `.agent/capabilities.yml`).

## When MCP Is Not Available

Fall back to CLI-first. This playbook and all its skills are designed to work without MCP.
