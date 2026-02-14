# AGENTS.md — Universal Agent Instructions

## 1. Problem Understanding & Prioritization

- Before writing code, articulate the problem you are solving.
- Frame work as a user story: "As a [role], I want [capability], so that [benefit]."
- Write acceptance criteria in **Given/When/Then** format:
  - **Given** [precondition], **When** [action], **Then** [expected outcome].
  - Scale the number of scenarios proportionally to the expected value and longevity of the code.
- Definition of Done reflects the same proportionality — throwaway scripts need less rigor than core domain logic.
- Prioritize by **Cost of Delay**: sequence work by the economic cost of *not* delivering it. Urgency and value outrank effort.

## 2. Architecture & Design

- Default to **hexagonal / ports-and-adapters** architecture: domain logic at the center, adapters at the edges. This keeps future change cheap.
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
- **Full test coverage** is the default expectation. Untested code is the exception that requires justification (e.g., trivial getters, framework boilerplate).

## 4. Application Design & Delivery

- Follow the **12-Factor App** methodology (12factor.net), extended to 15-factor where applicable.
- Key factors to always consider:
  - Config in environment variables.
  - Stateless processes.
  - Port binding for service export.
  - Disposability — fast startup, graceful shutdown.
  - Dev/prod parity.
  - Logs as event streams.
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
- Apply **least privilege** everywhere: IAM roles, service accounts, file permissions, network policies.
- Treat secrets as first-class concerns — never hardcode credentials, tokens, or keys. Use secret managers or environment injection.
- Include **dependency scanning** and **SBOM generation** in the outer loop. Know what you ship.
- Default to **encrypted at rest and in transit**. If a component does not support encryption, document the exception and the compensating control.
- Apply **zero-trust** principles: never assume trust based on network location. Authenticate and authorize every request, validate all inputs, and assume any component can be compromised.
- **Minimize dependencies.** Every dependency is attack surface, maintenance burden, and supply-chain risk. Prefer the standard library. When a third-party dependency is necessary, pin versions, verify checksums, and audit transitives.
- Write code that is **auditable**: clear logging of security-relevant events, traceable decisions, no silent failures on auth/authz paths.

## 7. Thinking Tools & Mental Models

- Draw on **Hacker Laws** (dwmkerr/hacker-laws) as a thinking toolkit:
  - **Gall's Law** — Complex systems that work evolved from simple systems that worked. Start simple.
  - **Conway's Law** — System design mirrors org structure. Be intentional about boundaries.
  - **Hyrum's Law** — All observable behaviors of an API will be depended upon. Be deliberate about interfaces.
  - **Kernighan's Law** — Debugging is twice as hard as writing code. Write code at half your cleverness capacity.
  - **Goodhart's Law** — When a measure becomes a target, it ceases to be a good measure.
- Keep as constant companions: **KISS**, **YAGNI**, **DRY**, and the **Pareto Principle**.

## 8. AI-Assisted Development

- AI agents are **tools, not authors**. All output should read as if a human wrote it.
- **Do not leave fingerprints.** No "Co-Authored-By: [AI]" trailers, no "generated by" comments, no AI-specific annotations in code, commits, PRs, or documentation.
- Commit messages, code comments, and documentation should reflect the *intent of the change* — not the means by which it was produced.
- AI agents must follow every standard in this file without exception. Being AI-assisted is not a reason to cut corners on testing, security, or design.

## 9. Project-Level Customization

- This file captures **universal, portable** engineering principles. It is designed to be copied or symlinked into any project.
- For project-specific instructions (language, framework, repo conventions, team norms), create a separate file (e.g., `AGENTS-PROJECT.md` or a tool-specific file like `CLAUDE.md`) in the project root.
- When both files exist, project-level instructions **extend and may override** the universal defaults in this file. Conflicts should be resolved in favor of the project-level file.
- Keep this file language- and framework-agnostic so it remains portable.

## 10. Documentation Artifacts

- When making architectural decisions, produce or update an **ADR**.
- When defining work, produce a **user story** with acceptance criteria.
- Proportionality principle: lightweight code gets lightweight docs; durable, valuable code gets thorough docs.
