#!/usr/bin/env bash
# vibe_bootstrap.sh — zero-shave setup for vibe-code-bootstrap
set -euo pipefail

say()  { printf "\033[1;36m%s\033[0m\n" "$*"; }
warn() { printf "\033[1;33m%s\033[0m\n" "$*"; }
err()  { printf "\033[1;31m%s\033[0m\n" "$*"; }

has_py() { command -v python3 >/dev/null 2>&1; }

# Parse optional flags
MODE=""
usage() {
  cat <<USAGE
vibe_bootstrap.sh — setup for vibe-code-bootstrap

Usage:
  bash vibe_bootstrap.sh              # menu, recommended for most users
  bash vibe_bootstrap.sh --defaults   # apply safe defaults (no prompts)
  bash vibe_bootstrap.sh --interactive# customize optional tools (advanced)
  bash vibe_bootstrap.sh --help       # show this help

Notes:
- No extra MCP servers are required. You can skip editor setup.
- If Python is unavailable, configuration is skipped and you can proceed.
USAGE
}

if [[ "${1-}" == "--help" ]]; then
  usage
  exit 0
elif [[ "${1-}" == "--defaults" ]]; then
  MODE="defaults"
elif [[ "${1-}" == "--interactive" ]]; then
  MODE="interactive"
fi

# 0) sanity
[ -d ".claude" ] || { err "Missing .claude/ in this directory. Copy the boilerplate first."; exit 1; }
[ -f "CLAUDE.md" ] || { err "Missing CLAUDE.md in this directory."; exit 1; }
[ -f "mcp.tools.json" ] || { warn "mcp.tools.json not found; creating defaults."; cat > mcp.tools.json <<'JSON'
{
  "agents": {
    "spec-writer": ["filesystem", "memory", "context7"],
    "task-decomposer": ["filesystem", "memory", "context7"],
    "coder": ["filesystem", "shell", "memory", "context7"],
    "reviewer": ["shell", "filesystem", "memory", "context7"]
  },
  "commands": {
    "/project:init": [],
    "/project:plan": [],
    "/project:build": ["shell for smallest test/CLI validation", "editor/patch for minimal diffs"],
    "/project:review": ["shell for git status/diff and smallest confirming checks", "editor/patch only for revert or tiny fix"]
  },
  "descriptions": {
    "filesystem": "filesystem MCP: Create/edit project files and docs",
    "memory": "memory MCP: Retrieve prior decisions, constraints, guardrails",
    "context7": "context7 MCP: Maintain session context, decisions, and focus",
    "shell": "shell MCP: Run smallest validating commands",
    "editor/patch": "editor/patch: Apply minimal diffs when needed",
    "octocode": "octocode MCP: Static analysis, linting, and code intelligence",
    "sequential-thinking": "sequential-thinking MCP: Stepwise reasoning for multi-step tasks"
  }
}
JSON
}

say "vibe-code-bootstrap — Welcome! 🎉"
if [[ -z "$MODE" ]]; then
  say "Choose setup mode:"
  PS3="Select an option (1-2): "
  select mode in "Use defaults (recommended)" "Customize MCP tools"; do
    case $REPLY in
      1) MODE="defaults"; break ;;
      2) MODE="interactive"; break ;;
      *) warn "Please choose 1 or 2." ;;
    esac
  done
fi

case "$MODE" in
  defaults)
    say "Applying defaults from mcp.tools.json…"
    if has_py; then
      python3 scripts/configure_mcp_tools.py --apply-json || warn "Configurator reported an issue; continuing."
      say "No extra MCP servers are required. You can skip editor setup."
    else
      warn "python3 not found; skipping MCP mapping validation. This is safe to ignore."
    fi
    ;;
  interactive)
    if [[ -t 0 ]] && has_py; then
      say "Launching interactive MCP customization…"
      python3 scripts/configure_mcp_tools.py --interactive || warn "Configurator reported an issue; continuing."
    else
      warn "Interactive customization is unavailable (need a terminal and python3). Applying safe defaults instead."
      if has_py; then
        python3 scripts/configure_mcp_tools.py --apply-json || warn "Configurator reported an issue; continuing."
      fi
      say "No extra MCP servers are required. You can skip editor setup."
    fi
    ;;
  *)
    warn "Unknown mode '$MODE'; continuing without MCP customization."
    ;;
esac

ensure_gitignore() {
  if [[ -f ".gitignore" ]]; then return; fi
  if [[ -t 0 ]]; then
    read -r -p "No .gitignore found. Create a minimal one now? [Y/n] " ans || ans=""
    case "${ans:-}" in
      n|N) ;;
      *)
        if [[ -f templates/gitignore-minimal ]]; then
          cp templates/gitignore-minimal .gitignore && say "Created .gitignore (from templates/gitignore-minimal)."
        else
          cat > .gitignore <<'GITIGNORE'
# OS artifacts
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Python
__pycache__/
.pytest_cache/
.venv/
venv/
.python-version
.coverage
.mypy_cache/
.ruff_cache/

# Node
node_modules/
.pnpm-store/

# Build artifacts
dist/
build/
.cache/

# Editors/IDEs
.idea/
.vscode/

# Environment files
.env
.env.local
.env.*.local
GITIGNORE
          say "Created .gitignore (minimal)."
        fi
        ;;
    esac
  else
    warn "No .gitignore found. To add one: cp templates/gitignore-minimal .gitignore"
  fi
}

say "Done. Next steps:"
ensure_gitignore
if has_py && [ -t 0 ]; then
  read -r -p "Run onboarding now? [Y/n] " ans || ans=""
  case "${ans:-}" in
    n|N) : ;;
    *) say "Starting onboarding…"; python3 scripts/vibe_onboarding.py || warn "Onboarding exited with a non-zero status." ;;
  esac
else
  echo "  1) Run: python3 scripts/vibe_onboarding.py"
  echo "  2) Then paste the suggested /project:init command into Claude Code."
fi
