# /project:init — Initialize minimal spec & acceptance

Delegate all authoring to sub-agent spec-writer (.claude/agents/spec-writer.md). If delegation fails, stop and ask me to activate spec-writer via /agents.

You are acting inside Claude Code via a custom slash command. Follow the steps below and **ask for confirmation before writing files or running any tools**.

## Goal
Create or update two lightweight docs at the project root:
- `SPEC.md` — problem, constraints, non-goals
- `ACCEPTANCE.md` — clear, testable checks

## Inputs to collect (keep it tight)
- One-sentence product intent
- Primary user(s) & success criteria
- Target runtime/language (if any)
- Constraints (deps, hosting, privacy/security)
- Known risks/unknowns (include at least one “verification needed” item)

## Procedure
1) Brief interview: ask only what’s necessary to draft SPEC + ACCEPTANCE.
2) Reflect back a short summary. **Wait for user approval.**
3) If `SPEC.md`/`ACCEPTANCE.md` already exist, propose **minimal edits** instead of rewrites.
4) On approval, draft `SPEC.md` and `ACCEPTANCE.md`. Keep both concise and specific.
5) List one small command or check the user can run to verify each acceptance item.

## Output
- A succinct recap of what you captured.
- Either: “Proposed SPEC/ACCEPTANCE below—confirm to write,” *or* “Suggested edits below—confirm to apply.”
- The exact file contents you intend to write (in fenced code blocks).

## Notes
- Do **not** write code here.
- Keep everything tool-agnostic; don’t assume git, test runners, or templates exist.
