---
name: dependency-adding
description: Evaluate and add a new production dependency, ensuring supply-chain security, license compliance, and minimal footprint.
version: 1.0.0
tier: 0
license: MIT
---

# Dependency Adding

Use this skill when adding a new production dependency to any project.

## When to Trigger

- A new library, package, or module is being added to the project.
- An existing dependency is being replaced.

## Workflow

1. **Justify the addition.** Can this be done with the standard library? Every dependency is attack surface, maintenance burden, and supply-chain risk.
2. **Evaluate the candidate:**
   - [ ] Active maintenance (recent commits, responsive maintainers)
   - [ ] Acceptable license (compatible with project license)
   - [ ] Reasonable dependency tree (check transitive deps)
   - [ ] Known vulnerabilities checked (CVE databases, `npm audit`, `pip-audit`, etc.)
   - [ ] FIPS compliance if cryptographic functionality is involved
3. **Pin the version.** Use exact version pins, not ranges.
4. **Verify checksums** where the package manager supports it.
5. **Audit transitive dependencies.** Know what you're pulling in.
6. **Update SBOM** if the project maintains one.
7. **Document the decision.** Note why this dependency was chosen over alternatives (including stdlib).

## Ask Before Proceeding

Always ask the user before adding a new production dependency. This is a non-negotiable gate in the Operating Protocol.

## Quality Checks

- [ ] Standard library alternative was considered and ruled out
- [ ] Version pinned (no floating ranges)
- [ ] License reviewed
- [ ] No known CVEs
- [ ] Transitive deps are acceptable
- [ ] SBOM updated (if applicable)
