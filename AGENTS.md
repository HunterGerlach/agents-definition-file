# AGENTS.md — Universal Agent Instructions

This file contains portable engineering defaults.
Project-specific rules live in the repo's own `AGENTS.md`, `AGENTS.override.md`, or nested `AGENTS.md` per subdirectory.
If a project rule conflicts with this file, **project rules win**.

## Operating Protocol

Follow this workflow on every task:

1. **Restate the problem** in 1–3 sentences.
2. **Write a user story**: "As a [role], I want [capability], so that [benefit]."
3. **Define acceptance criteria** in Given/When/Then format. Scale scenario count to the code's expected value and longevity.
4. **Plan the smallest viable change.** Prefer minimal diffs. No renames, file moves, or architecture rewrites unless requested or clearly necessary. If a change touches many files, explain why.
5. **Implement** using Red-Green-Refactor.
6. **Verify**: run fast checks first (unit tests, lint), then broader checks as needed. Fix failures before delivering.
7. **Deliver**: summarize what changed, why, and how it was validated. Note follow-ups explicitly.

**Ask before proceeding** when:
- Requirements are ambiguous.
- The change affects public APIs or security posture.
- A new production dependency is needed.
- The change requires broad refactors or file moves.

### Definition of Done

- [ ] Acceptance criteria written (Given/When/Then)
- [ ] Tests added or updated
- [ ] **All** tests pass — not just new tests, but every previously passing test. Do not leave regressions.
- [ ] Security implications considered
- [ ] ADR added if architecture changed
- [ ] Docs updated if behavior changed

## 1. Problem Understanding & Prioritization

- Before writing code, articulate the problem you are solving.
- Prioritize by **Cost of Delay**: sequence work by the economic cost of *not* delivering it. Urgency and value outrank effort.
- Definition of Done is proportional — throwaway scripts need less rigor than core domain logic.

## 2. Architecture & Design

- Default to **hexagonal / ports-and-adapters** architecture: domain logic at the center, adapters at the edges. This keeps future change cheap. Simpler structures are acceptable for trivial or short-lived code, but the burden of proof is on simplifying, not on structuring.
- Apply **SOLID** principles:
  - **S**ingle Responsibility — one reason to change per module.
  - **O**pen/Closed — extend behavior without modifying existing code.
  - **L**iskov Substitution — subtypes must be substitutable for their base types.
  - **I**nterface Segregation — prefer small, focused interfaces.
  - **D**ependency Inversion — depend on abstractions, not concretions.
- Follow **Clean Code** (Robert C. Martin): small files, succinct methods, intention-revealing names, top-down narrative flow.
- Use **Design Patterns** (GoF) where they simplify — never for their own sake.
- For system integration, consider **Enterprise Integration Patterns** (Hohpe & Woolf).
- Document significant architectural choices as **Architecture Decision Records (ADRs)** with context, decision, and consequences.

## 3. Testing & Development Process

- Primary problem-solving lens: **"How might I test this?"** When stuck, ask how you would verify the solution — this often reveals the path forward.
- Follow the **Red-Green-Refactor** TDD loop strictly:
  1. **Red** — Write a failing test that defines the desired behavior.
  2. **Green** — Write the minimum code to make the test pass.
  3. **Refactor** — Clean up while keeping tests green.
- Do not skip steps. Do not write implementation before tests.
- **Test Pyramid**: heavy base of unit tests, moderate integration tests, thin layer of end-to-end tests. Favor low-cost, high-value, non-fragile tests.
- **Full test coverage** is the default expectation. Untested code is the exception that requires justification (e.g., trivial getters, framework boilerplate, legacy code not under active change).

## 4. Application Design & Delivery

- Follow the **12-Factor App** methodology (12factor.net), extended to 15-factor where applicable.
- Key factors to always consider:
  - Config in environment variables.
  - Stateless processes.
  - Port binding for service export.
  - Disposability — fast startup, graceful shutdown.
  - Dev/prod parity.
  - Logs as event streams.
- Build for **full observability** from the start: structured logging, metrics, distributed tracing. Instrument at service boundaries and key decision points. If something breaks in production, you should be able to answer "what happened and why" from telemetry alone.
- Consider **resource usage** explicitly: CPU, memory, storage, network, and cloud spend. Right-size allocations, set limits/requests, and avoid unbounded growth patterns (e.g., uncontrolled caching, memory leaks, fan-out without backpressure).
- Distinguish the **inner loop** from the **outer loop**:
  - **Inner loop** (developer laptop): fast edit-build-test cycles, local linting, unit tests, hot reload. Optimize for speed and tight feedback.
  - **Outer loop** (CI/CD pipeline): full integration tests, security scans, compliance checks, artifact promotion, deployment. Optimize for correctness and auditability.
  - Design so that inner-loop confidence translates cleanly to outer-loop validation — no "works on my machine" gaps.
- Practice **Continuous Delivery** (Dave Farley): optimize for fast, reliable, repeatable deployments. Keep the main branch deployable. Prefer small batches, fast feedback, and automation over manual process. Every change should be releasable.

## 5. Versioning & Git Discipline

- Use **Semantic Versioning** (semver.org):
  - **MAJOR** — incompatible API changes.
  - **MINOR** — backwards-compatible new functionality.
  - **PATCH** — backwards-compatible bug fixes.
- Write **git commit messages** in imperative mood (Tim Pope convention):
  - First line completes the sentence: "If applied, this commit will ..."
  - Example: "Add retry logic to HTTP client" — not "Added retry logic."
  - Keep the first line under 50 characters; wrap the body at 72 characters.
  - The body explains *why*, not *what*.

## 6. Security & Compliance

- Adopt a **security-first mindset** — security and compliance are not afterthoughts; they are built in from the start.
- Assume a **FIPS-enabled** target environment. Use only FIPS-validated cryptographic modules and algorithms (e.g., AES, SHA-256/384/512, TLS 1.2+). Avoid non-compliant primitives (e.g., MD5, RC4, non-FIPS RNGs).
- Apply **zero-trust** principles: never assume trust based on network location. Authenticate and authorize every request, validate all inputs, and assume any component can be compromised.
- Apply **least privilege** everywhere: IAM roles, service accounts, file permissions, network policies.
- Treat secrets as first-class concerns — never hardcode credentials, tokens, or keys. Use secret managers or environment injection.
- **Minimize dependencies.** Every dependency is attack surface, maintenance burden, and supply-chain risk. Prefer the standard library. When a third-party dependency is necessary, pin versions, verify checksums, and audit transitives.
- Include **dependency scanning** and **SBOM generation** in the outer loop. Know what you ship.
- Default to **encrypted at rest and in transit**. If a component does not support encryption, document the exception and the compensating control.
- Write code that is **auditable**: clear logging of security-relevant events, traceable decisions, no silent failures on auth/authz paths.

## 7. Thinking Tools

- **Gall's Law** — Complex systems that work evolved from simple systems that worked. Start simple.
- **Hyrum's Law** — All observable behaviors of an API will be depended upon. Be deliberate about interfaces.
- **Goodhart's Law** — When a measure becomes a target, it ceases to be a good measure.
- Keep as constant companions: **KISS**, **YAGNI**, **DRY**, and the **Pareto Principle**.

## 8. AI-Assisted Development

- AI agents are **tools, not authors**. All output should read as if a human wrote it.
- **Do not leave fingerprints.** No "Co-Authored-By: [AI]" trailers, no "generated by" comments, no AI-specific annotations in code, commits, PRs, or documentation.
- Commit messages, code comments, and documentation should reflect the *intent of the change* — not the means by which it was produced.
- AI agents must follow every standard in this file without exception. Being AI-assisted is not a reason to cut corners on testing, security, or design.

## 9. Project-Level Customization

- This file captures **universal, portable** engineering principles.
- For project-specific instructions, use the repo's own `AGENTS.md`, `AGENTS.override.md` (where supported), or nested `AGENTS.md` files in subdirectories.
- Project-level instructions **extend and may override** the universal defaults. Conflicts resolve in favor of the project-level file.
- Keep this file language- and framework-agnostic so it remains portable.

## 10. Documentation Artifacts

- When making architectural decisions, produce or update an **ADR**.
- When defining work, produce a **user story** with acceptance criteria.
- Proportionality principle: lightweight code gets lightweight docs; durable, valuable code gets thorough docs.
