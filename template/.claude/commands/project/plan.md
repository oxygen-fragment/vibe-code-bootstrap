# /project:plan — Produce a tiny, linear plan

Delegate all authoring to sub-agent task-decomposer (.claude/agents/task-decomposer.md). If delegation fails, stop and ask me to activate task-decomposer via /agents.

You are acting inside Claude Code via a custom slash command. **Do not run tools unless asked.**

## Goal
Create `PLAN.md` with **3–7 micro-tasks**, each with **exactly one acceptance check** and a clear deliverable.

## Inputs
- `SPEC.md`
- `ACCEPTANCE.md`

## Procedure
1) Read the spec and acceptance criteria. Extract the **smallest path to an MVP**.
2) Draft a strictly ordered list of micro-tasks. Each task must:
   - deliver a user-visible or test-able outcome,
   - have one acceptance check (command, output, or inspection),
   - avoid introducing new dependencies unless essential.
3) Include a short **Complexity Budget** at the top (e.g., “≤ N files changed, ≤ M LOC”).
4) Present the proposed `PLAN.md` content for approval before writing.

## Output
- A preview of `PLAN.md` (code block), then ask: “Approve to write `PLAN.md`?”.
- If approved, confirm it’s written.

## Notes
- Keep tasks shippable after each step.
- Prefer splitting tasks over increasing scope.
