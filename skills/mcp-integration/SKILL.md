---
name: mcp-integration
description: Plan MCP server integration when tool or data access needs exceed what local CLIs provide.
version: 1.0.0
tier: 0
license: MIT
---

# MCP Integration

Use this skill to plan the integration of an MCP server into a project. MCP is opt-in — the default is CLI-first.

## When to Trigger

- Tool or data access is needed across multiple agent frontends.
- A typed tool interface is preferred over shell string parsing.
- Permission boundaries finer-grained than shell access are required.
- A local CLI does not cover the need (exhaust CLI options first).

## Workflow

1. **Justify the need.** Can an existing CLI, script, or native capability cover this? Every MCP server is a dependency.
2. **Classify transport:**
   - **Local stdio** — lower risk, runs as a local process.
   - **Remote HTTP/SSE** — higher risk, requires auth, data classification, and audit.
3. **Produce an MCP Integration Plan:**
   - Tools and resources needed (be specific — no "run arbitrary command" tools).
   - Local vs. remote transport and rationale.
   - Auth model (if remote): OAuth, API key, mTLS, or other.
   - Data classification: what crosses the boundary? Any PII, secrets, or sensitive data?
   - Threat model: what can go wrong? What is the blast radius?
   - Testing plan: how will you verify correct behavior and security?
   - Rollout plan: how will the server be deployed, versioned, and updated?
4. **Pin the server version.** Treat MCP servers like dependencies: pin, verify, audit.
5. **Document the decision** as an ADR if the integration affects system architecture.

## Security Checks

- [ ] CLI alternative was considered and ruled out
- [ ] Transport classified (local stdio vs. remote)
- [ ] No "run arbitrary command" tools exposed
- [ ] Inputs validated and subcommands/flags allowlisted
- [ ] Auth model documented (if remote)
- [ ] Data classification assessed
- [ ] Server version pinned
- [ ] Tool invocations logged
- [ ] Least privilege enforced on server capabilities

## Quality Checks

- [ ] Integration plan reviewed before implementation
- [ ] MCP server treated as a dependency (review, pin, audit)
- [ ] Approved server documented in project configuration
- [ ] Fallback to CLI documented for disconnected environments
