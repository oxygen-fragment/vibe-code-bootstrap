---
name: "/project:help"
description: "Explain the 4-phase workflow and how to proceed when stuck"
phase: "any"
role: "spec-writer (.claude/agents/spec-writer.md)"
stop_after: "Help text displayed with next action"
allowed_tools: []
---

# /project:help — How this works

**What to run, in order**
1) `/project:init` → Writes `/SPEC.md` and `/ACCEPTANCE.md`
2) `/project:plan` → Writes `/PLAN.md` (3–7 tiny tasks)
3) `/project:build` → Implements exactly ONE task from `/PLAN.md`
4) `/project:review` → PASS/FAIL and tell you the next thing to do

**If a command doesn't use the right agent**
- Run `/agents`, select the agent (spec-writer / task-decomposer / coder / reviewer)
- Then paste the command body
- Or run `/project:doctor` for quick checks

**What “good” looks like**
- Tiny scope, one acceptance per task, minimal diffs, no surprise deps
- If it feels heavy: split tasks; defer nice-to-haves
