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

## Notes
- Keep feedback specific and actionable. No long lectures.
