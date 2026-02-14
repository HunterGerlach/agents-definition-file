---
name: disconnected-environments
description: Verify that a solution works in air-gapped or disconnected environments with no external network access.
version: 1.0.0
tier: 0
---

# Disconnected Environments

Use this skill when building or validating software that must run in air-gapped, disconnected, or network-restricted environments.

## When to Trigger

- The target environment has no outbound internet access.
- The deployment is behind a strict egress firewall or in a classified network.
- A dependency, build step, or runtime behavior assumes network connectivity.
- Container images need to be pre-staged to a local registry.

## Checklist

### Build & Packaging

- [ ] All dependencies vendored or available from an internal mirror (no runtime fetches)
- [ ] No build steps that download from the public internet (`go get`, `npm install` from registry, `pip install` from PyPI)
- [ ] Container images pullable from a local/private registry — no references to Docker Hub, GHCR, or public registries at runtime
- [ ] Build artifacts are fully self-contained (no lazy downloads, no CDN references)

### Runtime

- [ ] No phone-home, telemetry, or license-check calls that fail open or block startup
- [ ] No hard dependencies on external DNS, NTP, or certificate authorities not available in the enclave
- [ ] TLS certificates handled via internal CA or pre-provisioned trust bundles
- [ ] Graceful degradation if an optional external service is unreachable (log, don't crash)

### Configuration & Secrets

- [ ] Config sourced from local environment, files, or internal vault — not remote SaaS config services
- [ ] Secrets injectable without network (env vars, mounted volumes, local secret store)
- [ ] No OAuth/OIDC flows that require callbacks to external identity providers unless an internal IdP is available

### Testing

- [ ] Tested with network disabled (e.g., `--network=none` for containers, firewall rules, or network namespace isolation)
- [ ] Smoke test covers startup, core functionality, and shutdown without any external connectivity
- [ ] Documented which features degrade vs. which are fully functional when disconnected

### Delivery

- [ ] Deployment artifacts (images, binaries, charts, manifests) can be transferred via sneakernet or secure file transfer
- [ ] Installation runbook does not assume `curl`, `wget`, or any network-based fetch
- [ ] SBOM and dependency checksums included alongside artifacts for offline verification

## Output

Document the disconnected-readiness status: what works fully offline, what degrades, and what is blocked. Flag any hard network dependencies that need remediation.
