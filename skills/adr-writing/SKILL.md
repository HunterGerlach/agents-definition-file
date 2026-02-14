---
name: adr-writing
description: Write an Architecture Decision Record (ADR) when a significant architectural choice is made or changed.
version: 1.0.0
tier: 0
---

# ADR Writing

Use this skill when an architectural decision is made that affects system boundaries, technology choices, or integration patterns.

## When to Trigger

- A new service boundary or component is introduced.
- A technology or framework choice is made.
- An existing architectural pattern is changed.
- The change affects more than one system or team.

## Workflow

1. Create a new ADR file: `docs/adr/NNNN-<title>.md` (increment from last ADR number).
2. Use the template in `assets/adr-template.md`.
3. Fill in all sections: Title, Status, Context, Decision, Consequences.
4. Context should explain the forces at play — what constraints, requirements, or trade-offs led to this decision.
5. Decision should be stated in full sentences, active voice.
6. Consequences should list both positive and negative outcomes, including trade-offs accepted.
7. Set Status to "Accepted" (or "Proposed" if pending review).
8. Add the ADR to version control in the same commit as the architectural change.

## Quality Checks

- [ ] Context explains *why* this decision was needed
- [ ] Decision is clear and unambiguous
- [ ] Consequences include trade-offs, not just benefits
- [ ] ADR is numbered sequentially
- [ ] Status is set appropriately
