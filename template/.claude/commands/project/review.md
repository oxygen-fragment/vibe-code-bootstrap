# /project:review — Diff-based review against acceptance

Delegate all authoring to sub-agent reviewer (.claude/agents/reviewer.md). If delegation fails, stop and ask me to activate reviewer via /agents.

You are acting inside Claude Code via a custom slash command. **Don’t assume git or any specific VCS is available.** If diffs aren’t accessible, review by comparing old/new snippets.

## Goal
Decide PASS/FAIL for the **latest completed task** based on:
- The task’s single acceptance check,
- Simplicity (smallest viable change),
- The project’s Complexity Budget.

## Inputs
- Latest change summary/evidence from `/project:build`
- `SPEC.md`, `PLAN.md`, `ACCEPTANCE.md`

## Procedure
1) Inspect the change and the evidence snippet.
2) Check gates:
   - Acceptance satisfied?
   - Simplicity maintained (no gratuitous scope/new deps)?
   - Complexity Budget respected?
3) Verdict:
   - **PASS** → Provide a one-line changelog entry and suggest the next task.
   - **FAIL** → Name the smallest fix or immediate revert, and propose a simpler alternative.

## Output
- PASS/FAIL with 1–3 concrete reasons.
- If FAIL: the minimal corrective step(s) and what evidence will prove it.
- The exact next command to run (e.g., `/project:build` or `/project:plan` to split).

## Progress Logging

After completing the review, append a progress entry to `PROGRESS.md`:

1. **Check if PROGRESS.md exists** at project root:
   - If missing: Copy from `template/templates/PROGRESS.md` OR create minimal version
   - If exists: Append to existing file

2. **Append entry based on verdict:**

**For PASS:**
```markdown
### YYYY-MM-DD HH:MM - /project:review
**Agent:** reviewer
**Status:** completed
**Summary:** Reviewed [task name or milestone]
**Gates Passed:**
- ✓ [Acceptance criteria met]
- ✓ [Simplicity maintained]
- ✓ [Complexity budget respected]
**Outcome:** [Task/MVP approved. Next steps.]
```

**For FAIL:**
```markdown
### YYYY-MM-DD HH:MM - /project:review
**Agent:** reviewer
**Status:** failed
**Summary:** Review failed for [task name]
**Gates Failed:**
- ✗ [Which gate failed]
**Issue:** [What needs fixing]
**Next:** [Recommended action: revert, adjust, re-plan]
```

3. **Example entries:**

**PASS:**
```markdown
### 2025-10-14 15:25 - /project:review
**Agent:** reviewer
**Status:** completed
**Summary:** Reviewed MVP completion (all 5 tasks)
**Gates Passed:**
- ✓ All 3 acceptance criteria pass
- ✓ No new dependencies (used native crypto)
- ✓ Complexity budget met (4 files, 167 LOC < 200)
**Outcome:** MVP approved. Ready to deploy or add features.
```

**FAIL:**
```markdown
### 2025-10-14 15:18 - /project:review
**Agent:** reviewer
**Status:** failed
**Summary:** Review failed for Task 3 - Authentication
**Gates Failed:**
- ✗ Complexity budget exceeded (8 files > 5 file limit)
**Issue:** Added unnecessary logging framework and config files
**Next:** Revert extra files, keep only auth.js and hash.js. Re-review.
```

4. **After logging**, inform the user:

**If PASS:**
```
✓ Review PASSED! Progress logged to PROGRESS.md
Run '/project:next' to continue
```

**If FAIL:**
```
✗ Review FAILED. See PROGRESS.md for corrective actions.
Run the recommended fix, then re-run '/project:review'
```

## Notes
- Keep feedback specific and actionable. No long lectures.
- Always log reviews—they provide critical gate-check history for future decisions
