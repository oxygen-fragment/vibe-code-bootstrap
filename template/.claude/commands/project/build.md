# /project:build — Implement exactly one micro-task

Delegate all authoring to sub-agent coder (.claude/agents/coder.md). If delegation fails, stop and ask me to activate coder via /agents.

You are acting inside Claude Code via a custom slash command. **Ask before editing files or running any tools.**

## Goal
Implement the **next task in `PLAN.md`** with the **smallest possible diff** and produce a brief evidence snippet that satisfies its acceptance check.

## Inputs
- `PLAN.md` (pick the next task)
- `SPEC.md`, `ACCEPTANCE.md`

## Procedure
1) Identify the next task and restate the intended change + expected evidence.
2) List the minimal steps. If tools are needed (e.g., a test command), propose them and **wait for approval**.
3) Apply the smallest change necessary to meet the task’s acceptance.
4) Run only what’s needed to gather the evidence (or provide a manual check if no runner exists).
5) Summarize the result (1–3 sentences) and show the evidence snippet.

## Output
- A short “Intent → Change → Evidence” summary.
- A minimal diff preview or edited file snippets.
- A one-line recommendation for the **next** command (usually `/project:review`).

Use plain language and this 3-part structure:
- **What happened**
- **Why it matters**
- **What to do next**

## Progress Logging

After attempting to implement the task, append a progress entry to `PROGRESS.md`:

1. **Check if PROGRESS.md exists** at project root:
   - If missing: Copy from `template/templates/PROGRESS.md` OR create minimal version
   - If exists: Append to existing file

2. **Append entry based on outcome:**

**For successful completion:**
```markdown
### YYYY-MM-DD HH:MM - /project:build
**Agent:** coder
**Status:** completed
**Summary:** Implemented Task N - [task name]
**Files:** [list files modified with line counts]
**Evidence:** [brief verification output]
**Outcome:** [what works now]
```

**For failed attempts (gate violations, errors):**
```markdown
### YYYY-MM-DD HH:MM - /project:build
**Agent:** coder
**Status:** failed
**Summary:** Attempted Task N - [task name]
**Files:** (none - reverted)
**Issue:** [why it failed: dep violation, budget exceeded, test failures]
**Next:** [what needs to happen: re-plan, adjust acceptance, etc.]
```

3. **Example entries:**

**Success:**
```markdown
### 2025-10-14 14:45 - /project:build
**Agent:** coder
**Status:** completed
**Summary:** Implemented Task 1 - Database schema
**Files:** schema.sql (+45 lines), migrations/001_init.sql (+32 lines)
**Evidence:** `sqlite3 db.sqlite < schema.sql` runs without errors
**Outcome:** Users table with email, password_hash, created_at columns
```

**Failure:**
```markdown
### 2025-10-14 15:02 - /project:build
**Agent:** coder
**Status:** failed
**Summary:** Attempted Task 2 - Authentication endpoint
**Files:** (none - reverted)
**Issue:** Required bcrypt dependency not in budget; violates no-deps policy
**Next:** Re-plan Task 2 with native crypto or adjust acceptance criteria
```

4. **After logging**, inform the user:

**If successful:**
```
✓ Done! Task completed and logged to PROGRESS.md
Run '/project:next' to continue
```

**If failed:**
```
⚠ Task failed. See PROGRESS.md for details.
Run '/project:plan' to adjust the plan, or '/project:doctor' for diagnostics.
```

## Notes
- Avoid adding new dependencies unless essential to the task.
- Keep changes within the current Complexity Budget from `PLAN.md`.
- Always log progress, even for failures—it helps agents learn what didn't work
