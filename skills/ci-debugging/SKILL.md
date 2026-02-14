---
name: ci-debugging
description: Systematically debug CI/CD pipeline failures by analyzing logs, configuration, and environment differences.
version: 1.0.0
tier: 0
---

# CI Debugging

Use this skill when a CI/CD pipeline fails and the cause is not immediately obvious.

## When to Trigger

- A CI job fails after a code change.
- A previously passing pipeline starts failing.
- CI behavior differs from local (inner loop) results.

## Workflow

1. **Read the failure log.** Start from the bottom — the root cause is usually near the end.
2. **Classify the failure:**
   - **Build failure** — compilation, missing dependencies, version mismatch
   - **Test failure** — failing assertions, timeout, flaky test
   - **Lint/format failure** — style violations, type errors
   - **Infrastructure failure** — network, permissions, resource limits, runner issues
   - **Configuration failure** — env vars, secrets, pipeline config syntax
3. **Check for environment differences.** Compare CI environment against local:
   - Language/runtime versions
   - Environment variables (especially secrets availability)
   - OS and architecture
   - Installed tooling versions
4. **Reproduce locally** if possible. Use the same commands CI runs.
5. **Fix the root cause.** Do not mask failures with retries or skips unless the failure is genuinely flaky and documented.
6. **Verify the fix** passes in CI before considering the task complete.

## Anti-Patterns

- Do not add `continue-on-error` or `|| true` to silence failures.
- Do not skip tests that fail in CI but pass locally — find the environment difference.
- Do not retry without understanding why it failed the first time.
- Do not modify CI config without understanding the pipeline structure.

## Quality Checks

- [ ] Root cause identified (not just symptom)
- [ ] Fix verified in CI (not just locally)
- [ ] No tests skipped or silenced
- [ ] CI config changes explained in commit message
