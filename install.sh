#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🧠 Installing MetaCog (metacog)..."

INSTALLED=0

# 1. Antigravity / Gemini Global Skills
if [ -d "$HOME/.gemini/config/skills" ] || [ -d "$HOME/.gemini" ]; then
  TARGET="$HOME/.gemini/config/skills/metacog"
  mkdir -p "$TARGET"
  cp -r "$SCRIPT_DIR/SKILL.md" "$SCRIPT_DIR/references" "$TARGET/"
  echo "  ✔ Installed to Antigravity / Gemini skills: $TARGET"
  INSTALLED=$((INSTALLED + 1))
fi

# 2. Claude Code Global Skills
if [ -d "$HOME/.claude" ]; then
  TARGET="$HOME/.claude/skills/metacog"
  mkdir -p "$TARGET"
  cp -r "$SCRIPT_DIR/SKILL.md" "$SCRIPT_DIR/references" "$TARGET/"
  echo "  ✔ Installed to Claude Code skills: $TARGET"
  INSTALLED=$((INSTALLED + 1))
fi

# 3. Codex / OpenAI Agent Skills
if [ -d "$HOME/.codex" ]; then
  TARGET="$HOME/.codex/skills/metacog"
  mkdir -p "$TARGET"
  cp -r "$SCRIPT_DIR/SKILL.md" "$SCRIPT_DIR/references" "$TARGET/"
  echo "  ✔ Installed to Codex skills: $TARGET"
  INSTALLED=$((INSTALLED + 1))
fi

# 4. Fallback to ~/.config/skills/metacog if none exist yet
if [ "$INSTALLED" -eq 0 ]; then
  TARGET="$HOME/.config/skills/metacog"
  mkdir -p "$TARGET"
  cp -r "$SCRIPT_DIR/SKILL.md" "$SCRIPT_DIR/references" "$TARGET/"
  echo "  ✔ Installed to $TARGET"
fi

echo "✅ MetaCog installed! Invoke it in your agent with '@metacog' or 'use metacog'."
