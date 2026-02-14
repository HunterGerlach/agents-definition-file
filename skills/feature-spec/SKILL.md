---
name: feature-spec
description: Create or update a feature spec as the canonical source of acceptance criteria, constraints, and test plan for a non-trivial change.
version: 1.0.0
tier: 0
license: MIT
---

# Feature Spec

Use this skill to create or update a feature spec before implementation. The spec is the canonical home of acceptance criteria — not a separate artifact alongside them.

## When to Trigger

- Any non-trivial feature, behavior change, or interface change.
- A change that spans multiple files or components.
- A change where edge cases, constraints, or rollout steps need to be captured.
- Skip for trivial changes (typo fixes, config tweaks, single-line bug fixes) — inline acceptance criteria in the task are sufficient.

## The Spec Ladder

This playbook supports three levels. Default to the first; escalate when the situation warrants it.

1. **Spec-first** (default) — Write the spec before implementation. Use it to drive acceptance criteria and tests. The spec may be discarded after shipping if the change is short-lived.
2. **Spec-anchored** (preferred for durable features) — Keep the spec in-repo permanently. When behavior changes, update spec + tests in the same PR.
3. **Spec-as-source** (opt-in only) — The spec is the primary artifact and code is generated from it. Use only where a natural compiler/codegen boundary exists: OpenAPI, protobuf, JSON Schema, Avro, infrastructure definitions.

## Workflow

1. Create a spec file: `specs/<slug>.md` using the template in `assets/spec-template.md`.
2. Fill in: Summary, User Story, Scope, Constraints, Acceptance Criteria (Given/When/Then), Edge Cases, Interface Impacts, and Test Plan.
3. The acceptance criteria in the spec ARE the acceptance criteria for the task — do not duplicate them elsewhere.
4. Derive tests from the spec's acceptance criteria and edge cases.
5. Implement using Red-Green-Refactor as usual.
6. If behavior or interfaces change later, update the spec in the same commit or PR.

## Security Note

Specs are trusted repo artifacts. Do not paste raw untrusted input (customer emails, ticket contents, external requests) into a spec without reviewing and sanitizing first.

## Quality Checks

- [ ] Scope clearly defines what is in and out
- [ ] Acceptance criteria are in Given/When/Then format
- [ ] Edge cases and invariants are captured
- [ ] Interface/contract impacts are documented
- [ ] Test plan maps to acceptance criteria
- [ ] Constraints include security and compliance considerations
