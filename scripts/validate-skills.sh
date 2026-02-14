#!/usr/bin/env bash
# validate-skills.sh — Validate skill frontmatter and structure
#
# Usage:
#   ./scripts/validate-skills.sh [skills_dir]
#
# Checks:
#   - SKILL.md exists and has YAML frontmatter
#   - Required fields present: name, description, version, tier, license
#   - Tier 0 skills have no scripts/ directory

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${1:-$(cd "$SCRIPT_DIR/../skills" && pwd)}"
ERRORS=0

check_field() {
  local file="$1"
  local field="$2"
  if ! grep -q "^${field}:" "$file"; then
    echo "  MISSING: $field"
    ERRORS=$((ERRORS + 1))
  fi
}

for skill_dir in "$SKILLS_DIR"/*/; do
  [[ ! -d "$skill_dir" ]] && continue

  skill_name="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"

  echo "Checking: $skill_name"

  # SKILL.md must exist
  if [[ ! -f "$skill_file" ]]; then
    echo "  MISSING: SKILL.md"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Must have frontmatter delimiters
  if ! head -1 "$skill_file" | grep -q "^---$"; then
    echo "  INVALID: Missing opening frontmatter delimiter (---)"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Check required fields
  check_field "$skill_file" "name"
  check_field "$skill_file" "description"
  check_field "$skill_file" "version"
  check_field "$skill_file" "tier"
  check_field "$skill_file" "license"

  # Extract tier value
  tier=$(grep "^tier:" "$skill_file" | head -1 | awk '{print $2}')

  # Tier 0 must not have scripts/
  if [[ "$tier" == "0" ]] && [[ -d "$skill_dir/scripts" ]]; then
    echo "  VIOLATION: Tier 0 skill must not contain scripts/"
    ERRORS=$((ERRORS + 1))
  fi

done

echo ""
if [[ $ERRORS -gt 0 ]]; then
  echo "FAILED: $ERRORS error(s) found"
  exit 1
else
  echo "PASSED: All skills valid"
  exit 0
fi
