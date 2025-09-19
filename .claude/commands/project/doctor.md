---
name: "/project:doctor"
description: "Run project health checks and list the next actionable command"
phase: "any"
role: "reviewer (.claude/agents/reviewer.md)"
stop_after: "Checklist + next command shown"
allowed_tools:
  - "shell for git status/diff --stat"
---

# /project:doctor — Self-Check

## Checks
- `SPEC.md` & `ACCEPTANCE.md` exist (init done)
- `PLAN.md` exists with 3–7 tasks; each has exactly one acceptance check
- No unapproved dependencies in diffs since last PASS
- Complexity budget not exceeded (file count / LOC)
- Latest task has either:
  - Build evidence snippet → proceed to `/project:review`, or
  - Review PASS + next task pending → proceed to `/project:build`

## Output
- A concise summary of which files exist, pending diffs (`git diff --stat`), and the **single** next command to run.
