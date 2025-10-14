#!/usr/bin/env bash
# install.sh - Install vibe-code-bootstrap into target project
set -euo pipefail

say()  { printf "\033[1;36m%s\033[0m\n" "$*"; }
warn() { printf "\033[1;33m%s\033[0m\n" "$*"; }
err()  { printf "\033[1;31m%s\033[0m\n" "$*"; exit 1; }

usage() {
  cat <<'USAGE'
install.sh - Install vibe-code-bootstrap into your project

Usage:
  # From vibe-code-bootstrap repo:
  bash install.sh /path/to/your/project

  # Or pipe from GitHub:
  curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/vibe-code-bootstrap/main/install.sh | bash -s /path/to/your/project

Options:
  --minimal    Install only .claude/ and CLAUDE.md (no templates/)
  --help       Show this help

Example:
  cd ~/vibe-code-bootstrap
  bash install.sh ~/my-new-project
USAGE
}

# Parse arguments
TARGET_DIR=""
MINIMAL=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --minimal)
      MINIMAL=true
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

# Validate target directory
if [[ -z "$TARGET_DIR" ]]; then
  err "Usage: bash install.sh /path/to/your/project"
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  err "Target directory does not exist: $TARGET_DIR"
fi

# Detect if running from vibe-code-bootstrap repo or standalone
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -d "$SCRIPT_DIR/template/.claude" ]]; then
  # Running from vibe-code-bootstrap repo
  TEMPLATE_DIR="$SCRIPT_DIR/template"
  say "Installing from local vibe-code-bootstrap repo..."
else
  # Standalone script - would need to download (future enhancement)
  err "This script must be run from the vibe-code-bootstrap repository for now."
fi

# Check if target already has vibe-bootstrap installed
if [[ -d "$TARGET_DIR/.claude" ]]; then
  warn "Target already has .claude/ directory."
  read -r -p "Overwrite? [y/N] " ans
  case "${ans:-}" in
    y|Y) rm -rf "$TARGET_DIR/.claude" ;;
    *) err "Installation cancelled." ;;
  esac
fi

# Install core files
say "Installing to: $TARGET_DIR"

cp -r "$TEMPLATE_DIR/.claude" "$TARGET_DIR/"
say "✓ Installed .claude/ (commands and agents)"

cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/"
say "✓ Installed CLAUDE.md (project policies)"

# Install optional files unless --minimal
if [[ "$MINIMAL" != true ]]; then
  if [[ -d "$TEMPLATE_DIR/templates" ]]; then
    mkdir -p "$TARGET_DIR/templates"
    cp -r "$TEMPLATE_DIR/templates/"* "$TARGET_DIR/templates/" 2>/dev/null || true
    say "✓ Installed templates/ (SPEC, PLAN, PROGRESS, etc.)"
  fi

  if [[ -f "$TEMPLATE_DIR/mcp.tools.json" ]]; then
    cp "$TEMPLATE_DIR/mcp.tools.json" "$TARGET_DIR/"
    say "✓ Installed mcp.tools.json (optional tool mappings)"
  fi
fi

# Create .gitignore if missing
if [[ ! -f "$TARGET_DIR/.gitignore" ]]; then
  read -r -p "No .gitignore found. Create one? [Y/n] " ans
  case "${ans:-}" in
    n|N) ;;
    *)
      if [[ -f "$TEMPLATE_DIR/templates/gitignore-minimal" ]]; then
        cp "$TEMPLATE_DIR/templates/gitignore-minimal" "$TARGET_DIR/.gitignore"
        say "✓ Created .gitignore"
      fi
      ;;
  esac
fi

say ""
say "✅ Installation complete!"
say ""
say "Next steps:"
say "  1. cd $TARGET_DIR"
say "  2. claude .claude/commands/project/init.md"
say "  3. Follow the prompts to create SPEC.md and ACCEPTANCE.md"
say ""
say "Or use autopilot mode:"
say "  claude .claude/commands/project/next.md"
say ""
say "For help:"
say "  claude .claude/commands/project/help.md"
