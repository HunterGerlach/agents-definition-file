# Agent Instructions — Universal Engineering Defaults

This file contains portable operational protocols and engineering standards.
Project-specific rules live in the repo's own `AGENTS.md`, `AGENTS.override.md`, or nested `AGENTS.md` per subdirectory.
If a project rule conflicts with this file, **project rules win**.

---

## Part 1: Agent Operations

### Prime Protocol

On every session start, after compaction, or after context clear:

1. Run the repo's prime command:
   - If Beads is available: `bd prime`
   - If Gas Town is available: `gt prime`
   - Otherwise: `make agent-prime` or `./scripts/agent-prime.sh`
2. If no prime command exists:
   - Read this file and any project-level agent instructions.
   - Identify the canonical test, lint, and build commands before editing code.
   - Locate the task ledger (Beads, GitHub Issues, or TODO).
3. After any compaction, context clear, or new session: re-prime immediately.

### Operating Protocol

Follow this workflow on every task:

1. **Restate the problem** in 1–3 sentences.
2. **Write a user story**: "As a [role], I want [capability], so that [benefit]."
3. **Create or update a feature spec** (`specs/<slug>.md`) as the canonical home of acceptance criteria (Given/When/Then), scope, constraints, edge cases, and test plan. For trivial changes, inline acceptance criteria are sufficient — skip the spec file.
4. **Plan the smallest viable change.** Prefer minimal diffs. No renames, file moves, or architecture rewrites unless requested or clearly necessary. If a change touches many files, explain why.
5. **Implement** using Red-Green-Refactor.
6. **Verify**: run fast checks first (unit tests, lint), then broader checks as needed. Fix failures before delivering.
7. **Deliver**: summarize what changed, why, and how it was validated. Note follow-ups explicitly.

#### Definition of Done

- [ ] Spec created or updated (if non-trivial); acceptance criteria written (Given/When/Then)
- [ ] Tests added or updated
- [ ] **All** tests pass — not just new tests, but every previously passing test. Do not leave regressions.
- [ ] Security implications considered
- [ ] ADR added if architecture changed
- [ ] Docs updated if behavior changed

### Non-Interactive Safety

Agents must never hang waiting for interactive input:

- Never open editors or pagers (`$EDITOR`, `less`, `more`, `vi`, `nano`).
- Use non-interactive flags: `cp -f`, `mv -f`, `rm -rf`, `apt-get -y`.
- Use batch mode for remote operations: `ssh -o BatchMode=yes`, `scp -o BatchMode=yes`.
- Suppress auto-update prompts: `HOMEBREW_NO_AUTO_UPDATE=1`.
- Assume shell aliases may add `-i` (interactive). Always use explicit flags.
- Use `gh` CLI for GitHub operations — never browser or playwright tools.
- If a command might prompt for input, find the non-interactive alternative or skip it and explain why.

### Session Completion

Before ending any session:

1. **File follow-ups**: create issues or beads for discovered/remaining work.
2. **Run quality gates**: test, lint, build (if code changed). All must pass.
3. **Update task status**: close completed items, note in-progress state.
4. **Commit** all changes with meaningful messages (imperative mood, explains *why*).
5. **Push** if you have write access. If push fails, resolve and retry.
   - If no write access: commit locally, produce a patch/diff with apply instructions.
6. **Verify** clean state: `git status` shows no uncommitted changes, no unpushed commits (if push was possible).
7. **Summarize**: what was done, what remains, where the next session should pick up.

**Prefer existing capabilities.** Before reaching for an external tool or service, exhaust built-in capabilities and existing skills. Every external call is latency, risk, and a potential point of failure. Only reach outward when no internal option covers the need.

**Ask before proceeding** when:
- Requirements are ambiguous.
- The change affects public APIs or security posture.
- A new production dependency is needed.
- The change requires broad refactors or file moves.

---

## Part 2: Engineering Standards

### 1. Problem Understanding & Prioritization

- Before writing code, articulate the problem you are solving.
- Prioritize by **Cost of Delay**: sequence work by the economic cost of *not* delivering it. Urgency and value outrank effort.
- Definition of Done is proportional — throwaway scripts need less rigor than core domain logic.

### 2. Architecture & Design

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

### 3. Testing & Development Process

- Primary problem-solving lens: **"How might I test this?"** When stuck, ask how you would verify the solution — this often reveals the path forward.
- Follow the **Red-Green-Refactor** TDD loop strictly:
  1. **Red** — Write a failing test that defines the desired behavior.
  2. **Green** — Write the minimum code to make the test pass.
  3. **Refactor** — Clean up while keeping tests green.
- Do not skip steps. Do not write implementation before tests.
- **Test Pyramid**: heavy base of unit tests, moderate integration tests, thin layer of end-to-end tests. Favor low-cost, high-value, non-fragile tests.
- **Full test coverage** is the default expectation. Untested code is the exception that requires justification (e.g., trivial getters, framework boilerplate, legacy code not under active change).

### 4. Application Design & Delivery

- Follow the **12-Factor App** methodology (12factor.net), extended to 15-factor where applicable.
- Key factors: config in env vars, stateless processes, port binding, disposability, dev/prod parity, logs as event streams.
- Build for **full observability** from the start: structured logging, metrics, distributed tracing. Instrument at service boundaries and key decision points. If something breaks in production, you should be able to answer "what happened and why" from telemetry alone.
- Consider **resource usage** explicitly: CPU, memory, storage, network, and cloud spend. Right-size allocations, set limits/requests, and avoid unbounded growth patterns (e.g., uncontrolled caching, memory leaks, fan-out without backpressure).
- Distinguish the **inner loop** from the **outer loop**:
  - **Inner loop** (developer laptop): fast edit-build-test cycles, local linting, unit tests, hot reload. Optimize for speed and tight feedback.
  - **Outer loop** (CI/CD pipeline): full integration tests, security scans, compliance checks, artifact promotion, deployment. Optimize for correctness and auditability.
  - Design so that inner-loop confidence translates cleanly to outer-loop validation — no "works on my machine" gaps.
- Practice **Continuous Delivery** (Dave Farley): optimize for fast, reliable, repeatable deployments. Keep the main branch deployable. Prefer small batches, fast feedback, and automation over manual process. Every change should be releasable.

### 5. Versioning & Git Discipline

- Use **Semantic Versioning** (semver.org):
  - **MAJOR** — incompatible API changes.
  - **MINOR** — backwards-compatible new functionality.
  - **PATCH** — backwards-compatible bug fixes.
- **Commit early and often.** Each commit should be a single, atomic unit of work — one logical change that compiles, passes tests, and could be reverted independently. Do not batch unrelated changes into a single commit. If you find yourself writing "and" in a commit message, it should probably be two commits.
- Write **git commit messages** in imperative mood (Tim Pope convention):
  - First line completes the sentence: "If applied, this commit will ..."
  - Example: "Add retry logic to HTTP client" — not "Added retry logic."
  - Keep the first line under 50 characters; wrap the body at 72 characters.
  - The body explains *why*, not *what*.

### 6. Security & Compliance

- Adopt a **security-first mindset** — security and compliance are not afterthoughts; they are built in from the start.
- **Default to FIPS-compliant cryptography.** Use only FIPS-validated modules and algorithms (e.g., AES, SHA-256/384/512, TLS 1.2+) and avoid non-compliant primitives (e.g., MD5, RC4, non-FIPS RNGs). Projects may relax this requirement by documenting the exception in their project-level instructions.
- Apply **zero-trust** principles: never assume trust based on network location. Authenticate and authorize every request, validate all inputs, and assume any component can be compromised.
- Apply **least privilege** everywhere: IAM roles, service accounts, file permissions, network policies.
- Treat secrets as first-class concerns — never hardcode credentials, tokens, or keys. Use secret managers or environment injection.
- **Minimize dependencies.** Every dependency is attack surface, maintenance burden, and supply-chain risk. Prefer the standard library. When a third-party dependency is necessary, pin versions, verify checksums, and audit transitives.
- Include **dependency scanning** and **SBOM generation** in the outer loop. Know what you ship.
- Default to **encrypted at rest and in transit**. If a component does not support encryption, document the exception and the compensating control.
- Write code that is **auditable**: clear logging of security-relevant events, traceable decisions, no silent failures on auth/authz paths.

---

## Part 3: Context & Integration

### 7. Thinking Tools

- **Gall's Law** — Complex systems that work evolved from simple systems that worked. Start simple.
- **Hyrum's Law** — All observable behaviors of an API will be depended upon. Be deliberate about interfaces.
- **Goodhart's Law** — When a measure becomes a target, it ceases to be a good measure.
- **Anti-patterns compound.** An anti-pattern left in place attracts more anti-patterns — workarounds breed workarounds. When you encounter one, trace it to the root cause (ask "why?" until you reach it). Fix the cause, not the symptom. A quick patch over a structural problem guarantees a harder fix later.
- **Unix Philosophy** — Do one thing and do it well. Each module, function, and file should have a single, clear purpose. Compose small, focused pieces rather than building monoliths.
- **Avoid sprawl.** Duplicative comments, repeated descriptions, and parallel references are maintenance debt. Every fact should have one canonical home. Other locations should link, not restate. If you find the same information in two places, consolidate it.
- Keep as constant companions: **KISS**, **YAGNI**, **DRY**, and the **Pareto Principle**.

### 8. AI-Assisted Development

- AI agents are **tools, not authors**. All output should read as if a human wrote it.
- **Default to no AI attribution.** No "Co-Authored-By: [AI]" trailers, no "generated by" comments, no AI-specific annotations in code, commits, PRs, or documentation. If the repo or org explicitly requires AI disclosure, follow that policy instead.
- Commit messages, code comments, and documentation should reflect the *intent of the change* — not the means by which it was produced.
- AI agents must follow every standard in this file without exception. Being AI-assisted is not a reason to cut corners on testing, security, or design.

### 9. Tool Integration

This workflow defaults to **Beads** for task tracking and **Gas Town** for multi-agent coordination. See `modules/beads.md` and `modules/gastown.md` for detailed guidance.

- If `bd` is available or `.beads/` exists: use Beads as the task ledger.
- If `gt` is available or `GT_ROLE` is set: rely on Gas Town for priming and coordination.
- If neither is present: fall back to GitHub Issues and the repo's `agent-prime.sh` script.

Projects may opt out of either tool by documenting the exception in their project-level instructions.

### 10. Skills

Skills are on-demand runbooks for specialized workflows. They use progressive disclosure: agents see metadata up front and load full instructions only when the skill is relevant.

- Skills live in `skills/` as tool-agnostic source files. Use `scripts/install-skills.sh` to install into tool-specific directories (`.claude/skills/`, `.agents/skills/`, `.github/skills/`).
- See `skills/_POLICY.md` for the risk tier model and security rules.
- Skills do not replace always-on instructions in this file or `AGENTS.md`.

#### Skill Security Model

- Treat every skill bundle like a dependency: review, pin, and audit.
- Default skills to instruction-only (Tier 0); scripts require explicit justification.
- No downloading or executing remote code from within skills.
- No `curl | bash` patterns or equivalent.
- Never run Tier 2 skills (external side-effects) without explicit user intent.
- Use `allowed-tools` restrictions where supported to limit skill capabilities.

### 11. Project-Level Customization

- This file captures **universal, portable** engineering principles.
- For project-specific instructions, use the repo's own `AGENTS.md`, `AGENTS.override.md` (where supported), or nested `AGENTS.md` files in subdirectories.
- Project-level instructions **extend and may override** the universal defaults. Conflicts resolve in favor of the project-level file.
- Keep this file language- and framework-agnostic so it remains portable.

### 12. Documentation Artifacts

- When making architectural decisions, produce or update an **ADR**.
- When defining work, produce a **user story** with acceptance criteria.
- Proportionality principle: lightweight code gets lightweight docs; durable, valuable code gets thorough docs.
