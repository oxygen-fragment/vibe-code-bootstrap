# /project:doctor — Quick project health & next step

## What I’ll check (lightweight, tool-agnostic)
- Does `SPEC.md` exist?
- Does `ACCEPTANCE.md` exist?
- Does `PLAN.md` exist and list 3–7 micro-tasks with one acceptance each?
- Is there a clearly identified **current** task and recent evidence snippet?
- Is the declared Complexity Budget being respected?

## Output
- A concise status summary (which files/info are present/absent).
- Exactly **one** recommended next command to run (e.g., `/project:init`, `/project:plan`, `/project:build`, or `/project:review`).
- If the plan feels heavy, recommend splitting the current task.

## Notes
- If version control is available, you may *offer* to show a small diff, but don’t assume git exists.
