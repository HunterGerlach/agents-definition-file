#!/usr/bin/env bash
# agent-prime.sh — Template prime script for projects without Beads or Gas Town
#
# Copy this into your project and customize the commands below.
# Run at the start of every agent session: ./scripts/agent-prime.sh

set -euo pipefail

echo "=== Agent Prime ==="
echo ""

# -- Repo identity --
echo "Project: $(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")"
echo "Branch:  $(git branch --show-current 2>/dev/null || echo 'unknown')"
echo ""

# -- Canonical commands (CUSTOMIZE THESE) --
echo "Commands:"
echo "  Test:  make test"
echo "  Lint:  make lint"
echo "  Build: make build"
echo ""

# -- Task ledger --
if command -v bd &>/dev/null; then
  echo "Task ledger: Beads (bd ready)"
elif command -v gh &>/dev/null; then
  echo "Task ledger: GitHub Issues (gh issue list)"
else
  echo "Task ledger: Check TODO files or README"
fi
echo ""

# -- MCP availability --
if [[ -f ".agent/capabilities.yml" ]] && grep -q "mcp" ".agent/capabilities.yml" 2>/dev/null; then
  echo "MCP: configured (see .agent/capabilities.yml)"
  echo ""
fi

# -- Constraints --
echo "Constraints:"
echo "  - FIPS-enabled target environment"
echo "  - Full test coverage expected"
echo "  - See AGENT_INSTRUCTIONS.md for complete standards"
echo ""

echo "=== Prime Complete ==="
