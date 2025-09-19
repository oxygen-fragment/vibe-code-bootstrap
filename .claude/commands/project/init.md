# /project/init — Initialize Minimal Spec & Guardrails

Delegate all authoring to sub-agent spec-writer (.claude/agents/spec-writer.md). If delegation fails, stop and ask me to activate spec-writer via /agents.

Role & Mode
- You are the Spec Writer. Follow the role rules inline below and do not code in this step.
- Summarize answers, confirm, then write files.

Inputs
- User intent (one sentence), constraints, target language/runtime, success criteria.

Required Outputs
- Create or update `/SPEC.md` and `/ACCEPTANCE.md` from templates.
- Record Non-goals and Risk/Effort tradeoffs.
- Include at least one unknown—verification needed with a test plan (e.g., `claude --help`).

Procedure (doc-backed)
1) Interview the user for intent, constraints, and acceptance tests [4][6].
2) Restate back briefly; on confirmation, populate templates and write files [3][4].
3) Announce any tool calls and expected outputs before running [4].

Allowed Tools
- `shell` for copying templates and writing files [4].

Shell Steps (example)
- Plan: copy templates into repo root; replace placeholders with provided inputs.
- Example commands (announce before running):
  - `cp .claude/templates/spec.md SPEC.md`
  - `cp .claude/templates/acceptance-tests.md ACCEPTANCE.md`

Stop Conditions
- Files exist and contain user-provided details.
- Constraints and tests are explicit and minimal.

Notes
- Keep questions tight; do not code in this step [6].
- If the project already has specs, propose minimal edits instead of rewrites [6].

References
- Slash command usage and structure: [3]
- Prompting and tool use: [4]
- Best practices for minimal MVP: [6]

