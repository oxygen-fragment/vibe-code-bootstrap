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

## Notes
- Avoid adding new dependencies unless essential to the task.
- Keep changes within the current Complexity Budget from `PLAN.md`.
