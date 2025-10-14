# SPEC: Separate Template from Dev Config

## Problem Statement

The vibe-code-bootstrap repository currently uses `.claude/` for **dual purposes**:

1. **Development configuration**: Instructions Claude uses when developing vibe-bootstrap itself
2. **Template product**: Artifacts copied to user projects via `vibe_bootstrap.sh`

This causes operational confusion: editing template files during development changes Claude's active session instructions. Users copying the repo also get dev-specific configs mixed with distributable templates.

## Solution

Restructure following industry-standard patterns (create-react-app's `/packages/cra-template/`, cookiecutter's `/{{project_slug}}/`):

- **Separate concerns**: Dev config stays at root `.claude/`, template moves to `template/` subdirectory
- **Clear boundaries**: Development of vibe-bootstrap uses root config; distribution comes from `template/`
- **No functional changes**: Bootstrap script and end-user experience remain identical

## Scope

### In Scope
- Create `template/` directory containing all distribution artifacts
- Move current `.claude/`, `templates/`, `CLAUDE.md`, `mcp.tools.json` → `template/`
- Create new root `.claude/` for vibe-bootstrap development (initially minimal/empty)
- Update `vibe_bootstrap.sh` sanity check (line 39) from `.claude` → `template/.claude`
- Update `vibe_bootstrap.sh` template copy logic (lines 115, 163) from `templates/` → `template/templates/`
- Update README.md to explain separation and installation path

### Out of Scope
- No changes to template content (agent prompts, commands, etc.)
- No changes to bootstrap script behavior beyond path updates
- No new features or functional enhancements
- No changes to `scripts/` directory (remains at root for bootstrap tooling)

## Constraints

- **Zero breakage**: Existing `bash vibe_bootstrap.sh` workflow must work identically
- **Backward compat**: Users with old instructions should get clear error messages
- **Minimal diff**: Only move files and update paths; avoid refactoring
- **No new deps**: This is a pure reorganization

## Non-Goals

- Not creating new dev-specific agents or commands (can be added later)
- Not changing template functionality or user-facing behavior
- Not adding new configuration options or flags
- Not documenting internal development workflow (README focuses on user installation)

## Design Decisions

### Why `template/` not `dist/` or `pkg/`?
- **Clarity**: "template" explicitly signals purpose (files copied to user projects)
- **Convention**: Aligns with create-react-app, cookiecutter, scaffold generators
- **Simplicity**: Single word, no abbreviations, self-documenting

### Why keep `scripts/` at root?
- Scripts are bootstrap tooling (run from vibe-bootstrap repo), not user artifacts
- `vibe_bootstrap.sh` expects `scripts/` at same level for relative path resolution
- Keeps diff minimal and avoids cascading path updates

### New root `.claude/` structure
Start minimal (empty or placeholder). Future work can add dev-specific agents like:
- `meta-reviewer.md` — reviews vibe-bootstrap changes
- `template-validator.md` — ensures template consistency

## Interface Changes

### Before (current)
```bash
vibe-code-bootstrap/
├── .claude/agents/          # dual-purpose confusion
├── .claude/commands/
├── templates/
├── CLAUDE.md
├── mcp.tools.json
└── vibe_bootstrap.sh        # checks [ -d ".claude" ]
```

### After (target)
```bash
vibe-code-bootstrap/
├── .claude/                 # NEW: dev config (empty initially)
├── template/                # NEW: distribution root
│   ├── .claude/agents/      # MOVED
│   ├── .claude/commands/
│   ├── templates/           # MOVED
│   ├── CLAUDE.md            # MOVED
│   └── mcp.tools.json       # MOVED
├── scripts/                 # unchanged
└── vibe_bootstrap.sh        # UPDATED: checks template/.claude
```

## Assumptions

- Git repo structure allows arbitrary directory moves (no submodules, no symlinks)
- Users invoke `vibe_bootstrap.sh` from vibe-code-bootstrap root (as documented)
- No external scripts or CI/CD pipelines depend on current `.claude/` location
- Python `scripts/` use relative paths that remain valid after template move

## Open Questions

None — restructuring is mechanical and well-defined.

## Risks

**Low risk**: Pure file move with path updates.

**Mitigation**: Acceptance tests verify bootstrap script works end-to-end post-refactor.
