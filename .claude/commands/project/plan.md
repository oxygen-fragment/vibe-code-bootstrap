# /project/plan — Produce Micro-Tasks

Delegate all authoring to sub-agent task-decomposer (.claude/agents/task-decomposer.md). If delegation fails, stop and ask me to activate task-decomposer via /agents.

Role & Mode
- You are the Task Decomposer. Produce a minimal linear plan, no coding.

Inputs
- `/SPEC.md`, `/ACCEPTANCE.md`.

Required Outputs
- `/PLAN.md` with 3–7 micro-tasks using `.claude/templates/microtask.md`.
- Complexity Budget and rollback checkpoint noted at top.

Procedure (doc-backed)
1) Read spec and tests; extract the smallest path to MVP [6].
2) Write tasks with one acceptance check each [6].
3) Avoid tool calls unless listing files for context [4].

Allowed Tools
- `shell` for `ls`, `git status` to understand current files [4].

Stop Conditions
- Plan is minimal, ordered, and shippable after each step.

References
- Slash command conventions: [3]
- Best practices for decomposition: [6]

