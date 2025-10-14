# /docs:readme — Draft or refresh README.md

The command name is derived from this filename.

**Delegate**
- Sub-agent: **documentarian** (`.claude/agents/documentarian.md`)

**Goal**
Draft or update `README.md` so it reflects the current project and workflow.

**Inputs**
- `SPEC.md`, `ACCEPTANCE.md`, `PLAN.md` (if present)
- Source files (for language/framework context)

**Procedure**
1. Scan the inputs (read-only).
2. If `README.md` exists, propose a minimal diff. If not, draft a fresh file.
3. Show the full proposed content/diff and wait for approval before writing.

**Output**
- A complete `README.md` content block or a diff.

**Notes**
- Keep docs under ~120 lines.
- Stay generic — no assumptions about tech stack.

