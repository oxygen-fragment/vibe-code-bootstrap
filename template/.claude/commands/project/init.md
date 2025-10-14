# /project:init — Initialize minimal spec & acceptance

Delegate all authoring to sub-agent spec-writer (.claude/agents/spec-writer.md). If delegation fails, stop and ask me to activate spec-writer via /agents.

You are acting inside Claude Code via a custom slash command. Follow the steps below and **ask for confirmation before writing files or running any tools**.

## Goal
Create or update two lightweight docs at the project root:
- `SPEC.md` — problem, constraints, non-goals
- `ACCEPTANCE.md` — clear, testable checks
- `.claude/vibe.md` — (optional) creative direction and tone guide

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

## Progress Logging

After successfully creating or updating SPEC.md and ACCEPTANCE.md, append a progress entry to `PROGRESS.md`:

1. **Check if PROGRESS.md exists** at project root:
   - If missing: Copy from `template/templates/PROGRESS.md` OR create minimal version with header
   - If exists: Append to existing file

2. **Append this entry format** (replace placeholders with actual values):

```markdown
### YYYY-MM-DD HH:MM - /project:init
**Agent:** spec-writer
**Status:** completed
**Summary:** [Brief summary of what was created/updated]
**Files:** [List files affected, e.g., "SPEC.md, ACCEPTANCE.md (created)"]
**Outcome:** [Key points captured: problem statement, acceptance criteria count, constraints]
```

3. **Example entry:**
```markdown
### 2025-10-14 14:23 - /project:init
**Agent:** spec-writer
**Status:** completed
**Summary:** Created initial project specification for user dashboard MVP
**Files:** SPEC.md, ACCEPTANCE.md (created)
**Outcome:** Defined 3 core features, 4 acceptance criteria, constraint: no external dependencies
```

4. **After logging**, inform the user:
```
✓ Done! Progress logged to PROGRESS.md
Run '/project:next' to continue
```

## Optional: Vibe Definition

After creating SPEC.md and ACCEPTANCE.md, the spec-writer may optionally offer to define a project vibe.

**When to offer:**
- Only if the project has specific aesthetic, tonal, or philosophical constraints
- Default: Skip (not needed for most projects)

**How to offer:**
The spec-writer agent will prompt:
```
Would you like to define a creative vibe/tone for this project? [Skip/Define]

This helps maintain consistency in:
- Tone & voice (e.g., "Professional but approachable")
- Design philosophy (e.g., "Simplicity over features")
- Technical constraints (e.g., "Zero dependencies")
- Target audience and use cases

Skip for most projects; useful when aesthetic matters.
```

**If user chooses "Define":**
1. Spec-writer asks 4-5 concise questions about tone, philosophy, constraints, audience, guardrails
2. Generate `.claude/vibe.md` from template (`template/templates/vibe.md`)
3. Fill in user's answers
4. Place at `.claude/vibe.md` (agents can reference for consistency)

**If user chooses "Skip":**
- Proceed directly to progress logging
- No vibe.md created

See `.claude/agents/spec-writer.md` for full vibe definition workflow.

## Notes
- Do **not** write code here.
- Keep everything tool-agnostic; don't assume git, test runners, or templates exist.
- Progress logging is lightweight (3-5 lines) and appended, never overwrites
