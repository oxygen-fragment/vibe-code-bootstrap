# /project:help — How this 4-step flow works

**Order of operations**
1) `/project:init` → Draft/confirm `SPEC.md` + `ACCEPTANCE.md`
2) `/project:plan` → Draft/confirm `PLAN.md` (3–7 micro-tasks, one check each)
3) `/project:build` → Implement exactly **one** task with smallest diff + evidence
4) `/project:review` → PASS/FAIL against acceptance + simplicity + budget

**Stuck? Try this**
- Run `/project:doctor` to see what’s missing and the single next step.
- If a command needs a different “voice,” just say so (e.g., “review this like a strict tester”).
- When in doubt, reduce scope or split the task.

**What “good” looks like**
- Minimal changes, no surprise dependencies, clear evidence per task.
- Each step leaves the project in a usable state.
