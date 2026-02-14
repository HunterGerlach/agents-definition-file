---
name: security-review
description: Perform a security review checklist when changes touch authentication, authorization, cryptography, secrets, or external interfaces.
version: 1.0.0
tier: 0
---

# Security Review

Use this skill when a code change touches security-sensitive areas.

## When to Trigger

- Authentication or authorization logic is added or modified.
- Cryptographic operations are introduced or changed.
- Secrets, tokens, or credentials are handled.
- External APIs or network boundaries are affected.
- User input handling or validation is changed.
- Dependencies are added or updated.

## Checklist

### Cryptography & Compliance

- [ ] Only FIPS-validated algorithms used (AES, SHA-256/384/512, TLS 1.2+)
- [ ] No non-compliant primitives (MD5, RC4, non-FIPS RNGs)
- [ ] Encryption at rest and in transit for sensitive data

### Authentication & Authorization

- [ ] Zero-trust applied: every request authenticated and authorized
- [ ] Least privilege enforced for all roles and service accounts
- [ ] No hardcoded credentials, tokens, or keys
- [ ] Secrets sourced from secret manager or environment injection

### Input & Interface

- [ ] All external inputs validated and sanitized
- [ ] OWASP Top 10 considered for web-facing changes
- [ ] API surface deliberately designed (Hyrum's Law)

### Dependencies

- [ ] New dependencies justified (not available in stdlib?)
- [ ] Versions pinned, checksums verified
- [ ] Transitive dependencies audited
- [ ] License compatibility confirmed

### Observability

- [ ] Security-relevant events logged (auth failures, access denials, config changes)
- [ ] No secrets or PII in logs
- [ ] Audit trail traceable

## Output

Document which items were reviewed and their status. If any items are not applicable, note why.
