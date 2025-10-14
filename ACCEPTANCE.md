# ACCEPTANCE: Template/Dev Config Separation

Run these checks from vibe-code-bootstrap repository root after restructuring.

## AC1: Template directory structure exists

**Test**: Verify all distribution artifacts moved to `template/`

```bash
#!/usr/bin/env bash
set -e

# Template structure
[ -d template/.claude ] || { echo "FAIL: template/.claude missing"; exit 1; }
[ -d template/.claude/agents ] || { echo "FAIL: template/.claude/agents missing"; exit 1; }
[ -d template/.claude/commands ] || { echo "FAIL: template/.claude/commands missing"; exit 1; }
[ -d template/templates ] || { echo "FAIL: template/templates missing"; exit 1; }
[ -f template/CLAUDE.md ] || { echo "FAIL: template/CLAUDE.md missing"; exit 1; }
[ -f template/mcp.tools.json ] || { echo "FAIL: template/mcp.tools.json missing"; exit 1; }

echo "PASS: AC1 - Template structure exists"
```

## AC2: Dev config separated at root

**Test**: Verify root `.claude/` exists and is distinct from template

```bash
#!/usr/bin/env bash
set -e

[ -d .claude ] || { echo "FAIL: root .claude/ missing"; exit 1; }
[ ! -L .claude ] || { echo "FAIL: .claude is a symlink (should be real dir)"; exit 1; }

# Ensure root .claude is distinct from template (not same inode)
ROOT_INODE=$(stat -c %i .claude 2>/dev/null || stat -f %i .claude 2>/dev/null)
TMPL_INODE=$(stat -c %i template/.claude 2>/dev/null || stat -f %i template/.claude 2>/dev/null)
[ "$ROOT_INODE" != "$TMPL_INODE" ] || { echo "FAIL: .claude and template/.claude are same directory"; exit 1; }

echo "PASS: AC2 - Dev config separated"
```

## AC3: Bootstrap script updated

**Test**: Verify `vibe_bootstrap.sh` checks template paths

```bash
#!/usr/bin/env bash
set -e

# Check sanity validation uses template/.claude
grep -q 'template/.claude' vibe_bootstrap.sh || { echo "FAIL: vibe_bootstrap.sh missing template/.claude check"; exit 1; }

# Check template/templates reference for gitignore
grep -q 'template/templates/gitignore-minimal' vibe_bootstrap.sh || { echo "FAIL: vibe_bootstrap.sh missing template/templates reference"; exit 1; }

echo "PASS: AC3 - Bootstrap script updated"
```

## AC4: End-to-end bootstrap test

**Test**: Run bootstrap script in fresh directory and verify template installation

```bash
#!/usr/bin/env bash
set -e

BOOTSTRAP_REPO="$(pwd)"
TEMP_PROJECT="$(mktemp -d)"

echo "Testing bootstrap in: $TEMP_PROJECT"
cd "$TEMP_PROJECT"

# Copy bootstrap artifacts (simulating user clone)
cp -r "$BOOTSTRAP_REPO/template/.claude" .
cp "$BOOTSTRAP_REPO/template/CLAUDE.md" .
cp "$BOOTSTRAP_REPO/template/mcp.tools.json" .
mkdir -p templates
cp -r "$BOOTSTRAP_REPO/template/templates/"* templates/ 2>/dev/null || true

# Verify structure installed correctly
[ -d .claude ] || { echo "FAIL: .claude not installed"; exit 1; }
[ -f CLAUDE.md ] || { echo "FAIL: CLAUDE.md not installed"; exit 1; }
[ -d .claude/agents ] || { echo "FAIL: agents not installed"; exit 1; }
[ -d .claude/commands ] || { echo "FAIL: commands not installed"; exit 1; }

# Cleanup
cd "$BOOTSTRAP_REPO"
rm -rf "$TEMP_PROJECT"

echo "PASS: AC4 - End-to-end bootstrap works"
```

## AC5: README documents separation

**Test**: Verify README explains template vs dev structure

```bash
#!/usr/bin/env bash
set -e

grep -q 'template/' README.md || { echo "FAIL: README missing template/ reference"; exit 1; }

echo "PASS: AC5 - README updated"
```

## AC6: No orphaned files

**Test**: Verify old locations cleaned up (no duplicate artifacts)

```bash
#!/usr/bin/env bash
set -e

# Root should NOT have template content anymore
if [ -f CLAUDE.md ] && [ ! -L CLAUDE.md ]; then
  # Check if it's different from template version (old duplicate)
  if [ -f template/CLAUDE.md ] && ! diff -q CLAUDE.md template/CLAUDE.md >/dev/null 2>&1; then
    echo "FAIL: Root CLAUDE.md differs from template (orphaned?)"
    exit 1
  fi
fi

if [ -f mcp.tools.json ] && [ ! -L mcp.tools.json ]; then
  if [ -f template/mcp.tools.json ] && ! diff -q mcp.tools.json template/mcp.tools.json >/dev/null 2>&1; then
    echo "FAIL: Root mcp.tools.json differs from template (orphaned?)"
    exit 1
  fi
fi

echo "PASS: AC6 - No orphaned files"
```

## Summary

Run all checks:

```bash
bash ACCEPTANCE.md  # if executable
# OR run each AC block individually
```

Expected output: All checks print "PASS: ACN - ..." and exit 0.
