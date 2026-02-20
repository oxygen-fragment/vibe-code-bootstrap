# PLAN: Template/Dev Config Separation

## Complexity Budget
- Files changed: ≤ 10
- New code: ≤ 50 LOC
- Test runs: All acceptance checks (AC1-AC6) must pass

## Micro-Tasks

### Task 1: Create template directory structure
**Goal**: Establish `template/` and move existing distribution artifacts into it
**Changes**: 
- Create `template/` directory
- `git mv .claude template/.claude`
- `git mv templates template/templates`
- `git mv CLAUDE.md template/CLAUDE.md`
- `git mv mcp.tools.json template/mcp.tools.json`
**Acceptance**: AC1 - Template directory structure exists
**Command**: 
```bash
[ -d template/.claude ] && [ -d template/.claude/agents ] && [ -d template/.claude/commands ] && \
[ -d template/templates ] && [ -f template/CLAUDE.md ] && [ -f template/mcp.tools.json ] && \
echo "PASS: AC1"
```

### Task 2: Create new root dev config
**Goal**: Establish separate root `.claude/` for vibe-bootstrap development
**Changes**:
- Create `.claude/` directory at root
- Add `.claude/.gitkeep` or minimal placeholder to ensure directory is tracked
**Acceptance**: AC2 - Dev config separated at root
**Command**:
```bash
[ -d .claude ] && [ ! -L .claude ] && \
ROOT_INODE=$(stat -c %i .claude 2>/dev/null || stat -f %i .claude 2>/dev/null) && \
TMPL_INODE=$(stat -c %i template/.claude 2>/dev/null || stat -f %i template/.claude 2>/dev/null) && \
[ "$ROOT_INODE" != "$TMPL_INODE" ] && echo "PASS: AC2"
```

### Task 3: Update vibe_bootstrap.sh paths
**Goal**: Update bootstrap script to reference new template/ locations
**Changes**:
- Line 39: Sanity check from `.claude` → `template/.claude`
- Line 115: Template copy from `templates/` → `template/templates/`
- Line 163: Template reference from `templates/` → `template/templates/`
**Acceptance**: AC3 - Bootstrap script updated
**Command**:
```bash
grep -q 'template/.claude' vibe_bootstrap.sh && \
grep -q 'template/templates/gitignore-minimal' vibe_bootstrap.sh && \
echo "PASS: AC3"
```

### Task 4: Update README.md documentation
**Goal**: Document the template/dev separation for users and contributors
**Changes**:
- Update README.md to explain `template/` directory purpose
- Update installation instructions to reference `template/` artifacts
- Add brief note about root `.claude/` being for vibe-bootstrap development
**Acceptance**: AC5 - README documents separation
**Command**:
```bash
grep -q 'template/' README.md && echo "PASS: AC5"
```

### Task 5: End-to-end verification
**Goal**: Verify bootstrap workflow functions correctly with new structure
**Changes**:
- No file changes, pure validation
- Run AC4 test script to simulate user bootstrap experience
**Acceptance**: AC4 - End-to-end bootstrap test & AC6 - No orphaned files
**Command**:
```bash
# AC4 test
BOOTSTRAP_REPO="$(pwd)"
TEMP_PROJECT="$(mktemp -d)"
cd "$TEMP_PROJECT"
cp -r "$BOOTSTRAP_REPO/template/.claude" .
cp "$BOOTSTRAP_REPO/template/CLAUDE.md" .
cp "$BOOTSTRAP_REPO/template/mcp.tools.json" .
mkdir -p templates
cp -r "$BOOTSTRAP_REPO/template/templates/"* templates/ 2>/dev/null || true
[ -d .claude ] && [ -f CLAUDE.md ] && [ -d .claude/agents ] && [ -d .claude/commands ] && \
cd "$BOOTSTRAP_REPO" && rm -rf "$TEMP_PROJECT" && echo "PASS: AC4"

# AC6 test
[ ! -f CLAUDE.md ] || [ -L CLAUDE.md ] && \
[ ! -f mcp.tools.json ] || [ -L mcp.tools.json ] && \
echo "PASS: AC6"
```

## Dependencies
- git (for moves)
- bash (for bootstrap script and tests)
- stat command (for inode checks)
- None new

## Task Execution Order
```
Task 1 → Task 2 → Task 3 → Task 4 → Task 5
   ↓        ↓        ↓        ↓        ↓
  AC1      AC2      AC3      AC5    AC4+AC6
```

## Rollback
If any acceptance check fails:
```bash
git reset --hard HEAD
git clean -fd
```

This resets to pre-refactor state. No intermediate commits required between tasks.

## Notes
- Tasks 1-4 are independent changes to different areas
- Task 5 is pure verification with no file modifications
- Total files modified: ~2 files (vibe_bootstrap.sh, README.md)
- Total files moved: 4 items (`.claude/`, `templates/`, `CLAUDE.md`, `mcp.tools.json`)
- Total new content: ~10 LOC (root `.claude/.gitkeep`, README additions)
- Well under complexity budget (≤10 files, ≤50 LOC)
