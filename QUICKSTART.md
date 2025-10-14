# Quick Start: Using vibe-code-bootstrap in Your Project

**Goal:** Get vibe-code-bootstrap working in your actual project in under 5 minutes.

## Prerequisites

1. **Claude Code CLI installed**: `claude --help` should work
2. **Your project directory exists**: e.g., `~/my-awesome-app/`
3. **vibe-code-bootstrap cloned**: `git clone https://github.com/YOUR_USERNAME/vibe-code-bootstrap.git`

## Installation (Choose One Method)

### Method 1: Auto-Install Script (Recommended)

```bash
# From vibe-code-bootstrap repo:
cd ~/vibe-code-bootstrap
bash install.sh ~/my-awesome-app

# Follow prompts - it will:
# - Copy .claude/ directory (commands and agents)
# - Copy CLAUDE.md (project policies)
# - Copy templates/ (optional)
# - Offer to create .gitignore if missing
```

### Method 2: Manual Copy (More Control)

```bash
# From your project directory:
cd ~/my-awesome-app

# Copy essential files
cp -r ~/vibe-code-bootstrap/template/.claude .
cp ~/vibe-code-bootstrap/template/CLAUDE.md .

# Optional: Copy templates for later use
mkdir -p templates
cp -r ~/vibe-code-bootstrap/template/templates/* templates/

# Optional: Copy tool mappings
cp ~/vibe-code-bootstrap/template/mcp.tools.json .
```

### Method 3: Minimal Install (Just Commands)

```bash
cd ~/my-awesome-app

# Only copy the commands and agents (bare minimum)
cp -r ~/vibe-code-bootstrap/template/.claude .
cp ~/vibe-code-bootstrap/template/CLAUDE.md .

# That's it! Templates will be created on-the-fly as needed
```

## Your First Session

### Option A: Autopilot Mode (Easiest)

```bash
cd ~/my-awesome-app

# Let autopilot guide you
claude .claude/commands/project/next.md
```

**What happens:**
- If you have no SPEC.md, it tells you to run `/project:init`
- If you have SPEC.md but no PLAN.md, it tells you to run `/project:plan`
- Just keep running `/project:next` and follow the guidance

### Option B: Manual Mode (Full Control)

**Step 1: Initialize**
```bash
claude .claude/commands/project/init.md
```
- Answers 4-5 quick questions about your project
- Creates `SPEC.md` (problem, constraints, non-goals)
- Creates `ACCEPTANCE.md` (testable success criteria)
- Optionally creates `.claude/vibe.md` (tone, style, constraints)

**Step 2: Plan**
```bash
claude .claude/commands/project/plan.md
```
- Reads your SPEC.md and breaks it into 3-7 micro-tasks
- Creates `PLAN.md` with complexity budget
- Optionally generates precode test stubs (TDD mode)

**Step 3: Build**
```bash
claude .claude/commands/project/build.md
```
- Implements the next task from PLAN.md
- Makes minimal changes (smallest diff that works)
- Logs progress to `PROGRESS.md`

**Step 4: Review**
```bash
claude .claude/commands/project/review.md
```
- Checks acceptance criteria
- Enforces complexity budget
- Approves or proposes revert with simpler alternative

**Step 5: Repeat**
```bash
# Keep going until all tasks complete
claude .claude/commands/project/build.md
claude .claude/commands/project/review.md
# ... or just use autopilot:
claude .claude/commands/project/next.md
```

## Real-World Example

```bash
# You're starting a new CLI tool
cd ~/projects/my-cli-tool

# Install vibe-bootstrap
bash ~/vibe-code-bootstrap/install.sh .

# Initialize your project
claude .claude/commands/project/init.md
```

**Claude asks:**
```
What's the one-sentence product intent?
> A command-line tool that converts Markdown to HTML with zero dependencies

Who are the primary users?
> Solo developers and bloggers who want simple static site generation

Target runtime/language?
> Node.js (ES modules), no build step

Constraints?
> Zero npm dependencies, works offline, < 500 LOC

Known risks?
> Need to verify Markdown spec compatibility without using a parsing library
```

**Claude creates:**
- `SPEC.md` - Clean problem statement
- `ACCEPTANCE.md` - 3-4 testable criteria like:
  ```bash
  # AC1: Basic conversion works
  echo "# Hello" | node cli.js > out.html
  grep "<h1>Hello</h1>" out.html || exit 1
  ```

**Then run autopilot:**
```bash
claude .claude/commands/project/next.md
# Output: "No PLAN.md found. Run: claude .claude/commands/project/plan.md"

claude .claude/commands/project/plan.md
# Creates PLAN.md with tasks like:
# - Task 1: CLI argument parsing
# - Task 2: Read stdin/file
# - Task 3: Markdown → HTML conversion (headers)
# - Task 4: Markdown → HTML conversion (lists, links)
# - Task 5: Write output file

claude .claude/commands/project/next.md
# Output: "PLAN.md exists with 5 pending tasks. Run: claude .claude/commands/project/build.md"

claude .claude/commands/project/build.md
# Implements Task 1 (CLI argument parsing) with minimal code

claude .claude/commands/project/next.md
# Output: "Task 1 complete but not reviewed. Run: claude .claude/commands/project/review.md"

# ...and so on
```

## What Files Get Created?

**By vibe-bootstrap:**
- `.claude/` - Commands and agents (you installed this)
- `CLAUDE.md` - Project policies (you installed this)
- `templates/` - Optional templates (you installed this)

**By the workflow:**
- `SPEC.md` - Created by `/project:init`
- `ACCEPTANCE.md` - Created by `/project:init`
- `.claude/vibe.md` - Optional, created if you choose "Define" during init
- `PLAN.md` - Created by `/project:plan`
- `PROGRESS.md` - Auto-generated by all commands
- `DECISIONS.md` - Optional, created by `/docs:decision`
- Your actual code files - Created by `/project:build`

## Common Workflows

### Starting a New Feature
```bash
# Update SPEC.md with new feature requirements
vim SPEC.md

# Re-plan
claude .claude/commands/project/plan.md

# Build it
claude .claude/commands/project/next.md  # autopilot
```

### Quick One-Off Task
```bash
# No need for full init/plan/build cycle
claude .claude/commands/ops/adhoc.md "Add logging to auth.js"
```

### Document a Decision
```bash
# Log why you chose SQLite over PostgreSQL
claude .claude/commands/docs/decision.md "Use SQLite for local dev"
```

### Going Open Source
```bash
# Create comprehensive docs (CONTRIBUTING, SECURITY, etc.)
claude .claude/commands/docs/scaffold-advanced.md
```

## Troubleshooting

**Q: Commands not found when I run `claude .claude/commands/project/init.md`**
- Make sure you're in the project directory where you installed `.claude/`
- Verify: `ls .claude/commands/project/` should show the command files

**Q: Claude doesn't seem to follow the workflow**
- Check if `CLAUDE.md` exists in your project root
- Claude reads this file for project-specific policies

**Q: I want to skip the vibe definition / TDD mode**
- Just choose "Skip" or "N" when prompted
- All advanced features are optional

**Q: Can I use this without any MCP servers?**
- Yes! The basic workflow requires zero MCP servers
- Claude Code's built-in tools are sufficient

**Q: How do I update to a newer version?**
- Re-run `install.sh` (it will ask before overwriting)
- Or manually copy new `.claude/` files

## Next Steps

- Read `README.md` for full feature list
- Check `template/CLAUDE.md` for all policies
- See `ENHANCEMENT_ROADMAP.md` for implemented features
- Run `claude .claude/commands/project/help.md` for command reference

## Getting Help

- **In-workflow help**: `claude .claude/commands/project/help.md`
- **Route unclear intent**: `claude .claude/commands/ops/route.md`
- **Diagnose issues**: `claude .claude/commands/project/doctor.md`
