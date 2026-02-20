# /project:next — Autopilot: Recommend next command

Delegate decision-making to sub-agent router (.claude/agents/router.md). If delegation fails, stop and ask me to activate router via /agents.

You are acting inside Claude Code via a custom slash command. This is the **autopilot command** that analyzes project state and recommends the single best next step.

## Goal
Analyze the current project state and recommend **exactly one** next command to run. Remove all cognitive load from the user—they should just keep running `/project:next` until their project is complete.

## State Detection Logic

Check for these files in the project root (use `Read` tool or equivalent):
1. **SPEC.md** — Project specification
2. **PLAN.md** — Task breakdown
3. **PROGRESS.md** — Work log (optional, may not exist yet)
4. **ACCEPTANCE.md** — Success criteria

## Recommendation Heuristics

Apply these rules **in order** (first match wins):

### 1. No SPEC.md exists
→ **Run `/project:init`**
- Reason: Project needs initial specification and acceptance criteria
- Agent: spec-writer
- What it does: Interviews user to create SPEC.md and ACCEPTANCE.md

### 2. SPEC.md exists, but no PLAN.md
→ **Run `/project:plan`**
- Reason: Specification is ready, need to break down into micro-tasks
- Agent: task-decomposer
- What it does: Creates PLAN.md with adaptive micro-task count (simple/medium/complex)

### 3. PLAN.md exists with incomplete tasks
→ **Run `/project:build`**
- Reason: Tasks are defined, time to implement the next one
- Agent: coder
- What it does: Implements the next pending task with minimal diff
- **How to check:** Read PLAN.md and look for unchecked tasks `[ ]` or "Status: pending"

### 4. PLAN.md exists, all tasks marked complete
→ **Run `/project:review`**
- Reason: All implementation done, need final review and gate check
- Agent: reviewer
- What it does: Verifies gates (no new deps, complexity budget, acceptance evidence)
- **How to check:** All tasks in PLAN.md are checked `[x]` or "Status: completed"

### 5. MVP is complete (ACCEPTANCE.md criteria all pass)
→ **Suggest feature freeze or new planning**
- Message: "🎉 MVP complete! Your acceptance criteria pass. Options:\n  - Run `/project:doctor` to check project health\n  - Start new feature: Run `/project:init` to create SPEC-v2.md\n  - Add docs: Run `/docs:readme` to update documentation\n  - Close this milestone and celebrate!"

### 6. Unclear state (edge case)
→ **Run `/project:doctor`**
- Reason: Project state is ambiguous, need diagnostic
- What it does: Checks for missing files, incomplete work, or configuration issues

## Procedure

1. **Check file existence** using Read tool (don't assume):
   - Try to read SPEC.md (note if exists)
   - Try to read PLAN.md (note if exists)
   - Try to read PROGRESS.md (optional, for context)
   - Try to read ACCEPTANCE.md (optional, note if exists)

2. **If PLAN.md exists, parse it** to determine task status:
   - Look for `[ ]` (pending), `[x]` (complete), or `[~]` (in-progress) markers
   - OR look for "Status: pending|completed|in-progress" text
   - Count how many tasks are incomplete

3. **Apply heuristics** from above (in order, first match wins)

4. **Output the recommendation** in this format:

```
📍 **Project State:**
- SPEC.md: [exists/missing]
- PLAN.md: [exists/missing] [(X tasks remaining)]
- PROGRESS.md: [exists/missing]

🎯 **Next Step:**

Run: /project:[command]

**Why:** [1-2 sentence explanation]

**What it does:** [Brief description of what will happen]

**Agent:** [agent-name]
```

## Output Format Example

```
📍 **Project State:**
- SPEC.md: exists ✓
- PLAN.md: exists ✓ (3 tasks remaining)
- PROGRESS.md: exists ✓

🎯 **Next Step:**

Run: /project:build

**Why:** Your plan has 3 incomplete tasks. Build implements the next one.

**What it does:** The coder agent will implement the smallest change to satisfy the next task's acceptance check.

**Agent:** coder
```

Use plain language and this 3-part structure:
- **What happened**
- **Why it matters**
- **What to do next**

## Notes

- **Be explicit:** Always show which files exist and task counts
- **Be decisive:** Return exactly one recommendation, never multiple options
- **Be encouraging:** Use positive language ("Great! Time to...", "Ready to...", "Let's...")
- **Be helpful:** If state is weird (e.g., PLAN.md but no SPEC.md), recommend `/project:doctor` first
- **Don't modify files:** This command only reads and recommends, never writes
- **Handle missing files gracefully:** If Read fails, assume the file doesn't exist

## Edge Cases

- **PLAN.md has 0 tasks:** Recommend `/project:plan` again (plan may be malformed)
- **PLAN.md has tasks but no status markers:** Count all as pending, recommend `/project:build`
- **SPEC.md exists but is empty:** Recommend `/project:init` to populate it
- **Multiple files missing:** Always start with `/project:init` (foundational)

## Progress Logging

After providing the recommendation, optionally append a lightweight entry to `PROGRESS.md`:

**Note:** `/project:next` typically does NOT log progress (it's a read-only navigator). However, if you want to track usage for debugging, you can add minimal entries.

**Optional minimal entry:**
```markdown
### YYYY-MM-DD HH:MM - /project:next
**Agent:** router
**Status:** completed
**Recommendation:** /project:[command]
**Reason:** [1-line why]
```

**Example (if logging enabled):**
```markdown
### 2025-10-14 15:30 - /project:next
**Agent:** router
**Status:** completed
**Recommendation:** /project:build
**Reason:** PLAN.md has 3 incomplete tasks
```

**Default behavior:** Do NOT log unless user explicitly requests tracking all commands (e.g., via an environment variable or flag). This keeps PROGRESS.md focused on actual work, not navigation.

## Success Criteria

✓ A complete beginner can run ONLY `/project:init` + repeated `/project:next` to complete their project
✓ The recommendation always makes sense given the visible state
✓ No cognitive load—user never has to think "what should I do now?"
