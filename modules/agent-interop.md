# Agent Interop Protocols

This module tracks agent-to-agent and remote agent invocation protocols. These are **opt-in** — most projects using this playbook will not need them.

## Protocol Landscape

### MCP (Model Context Protocol)

- **Purpose:** LLM-app ↔ tools/data connectivity.
- **Scope:** Client/server architecture for tool calls and resource access.
- **Status:** Adopted. See `modules/mcp.md` for integration guidance.

### A2A (Agent-to-Agent Protocol)

- **Purpose:** Agent ↔ agent interoperability across systems and vendors.
- **Scope:** Task delegation, status exchange, and artifact handoff between autonomous agents.
- **Status:** Watch. Complements MCP — MCP connects agents to tools; A2A connects agents to other agents.
- **When relevant:** Multi-agent orchestration across organizational or vendor boundaries.

### ACP (overloaded acronym)

Multiple protocols use the "ACP" name. Before adopting, clarify which one:

| Name | Focus | Transport |
|---|---|---|
| Agent Client Protocol | Editor-centered agent control | JSON-RPC (stdio/HTTP/WebSocket) |
| Agent Communication Protocol | RESTful agent interop | HTTP REST |
| Agent Connect Protocol | Remote agent invocation | OpenAPI-defined HTTP |

- **Status:** Watch. The namespace collision makes "adopt ACP" ambiguous.
- **When relevant:** Specific integration requirements that match one of these protocols.

## Decision Framework

Before adopting an interop protocol, answer:

1. **What problem are you solving?** Multi-agent delegation? Remote execution? Cross-vendor interoperability?
2. **Which protocol matches?** MCP for tools/data; A2A/ACP for agent-to-agent.
3. **What are the trust boundaries?** Who authenticates? What data crosses the boundary?
4. **Do you need this now?** If the answer is "maybe someday," wait. Premature protocol adoption is premature abstraction.

## Hard Rules

- Interop protocols are **opt-in** and must be documented in project-level overrides.
- Remote protocols carry Tier 2 risk (external side-effects). Require explicit user intent.
- Never adopt a protocol without a concrete use case in the current project.
- Document the choice as an ADR if it affects system architecture.

## When None of This Applies

Most single-agent, single-repo development workflows need none of these protocols. CLI-first with local tool access covers the vast majority of use cases. This module exists so that when the need arises, there is a clear slot for it — not to encourage premature adoption.
