#!/usr/bin/env bash
# install-skills.sh — Install skills into tool-specific directories
#
# Usage:
#   ./scripts/install-skills.sh [--copy] [--target <tool>]
#
# Options:
#   --copy       Copy files instead of symlinking (default: symlink)
#   --target     Install for a specific tool only: claude, codex, copilot (default: all)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"
MODE="symlink"
TARGET="all"

while [[ $# -gt 0 ]]; do
  case $1 in
    --copy) MODE="copy"; shift ;;
    --target) TARGET="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

install_skill() {
  local src="$1"
  local dest="$2"
  local skill_name
  skill_name="$(basename "$src")"

  # Skip non-skill entries
  [[ ! -d "$src" ]] && return

  mkdir -p "$dest/$skill_name"

  if [[ "$MODE" == "symlink" ]]; then
    find "$src" -type f | while read -r file; do
      local rel="${file#$src/}"
      local target_dir="$dest/$skill_name/$(dirname "$rel")"
      mkdir -p "$target_dir"
      ln -sf "$file" "$dest/$skill_name/$rel"
    done
    echo "  Linked: $skill_name"
  else
    cp -rf "$src/." "$dest/$skill_name/"
    echo "  Copied: $skill_name"
  fi
}

install_for_tool() {
  local tool="$1"
  local dest_dir

  case "$tool" in
    claude)  dest_dir=".claude/skills" ;;
    codex)   dest_dir=".agents/skills" ;;
    copilot) dest_dir=".github/skills" ;;
    *) echo "Unknown tool: $tool"; return 1 ;;
  esac

  echo "Installing skills -> $dest_dir ($MODE mode)"
  mkdir -p "$dest_dir"

  for skill_dir in "$SKILLS_SRC"/*/; do
    [[ -d "$skill_dir" ]] && install_skill "$skill_dir" "$dest_dir"
  done
  echo ""
}

if [[ "$TARGET" == "all" ]]; then
  install_for_tool "claude"
  install_for_tool "codex"
  install_for_tool "copilot"
else
  install_for_tool "$TARGET"
fi

echo "Done. Skills installed from: $SKILLS_SRC"
