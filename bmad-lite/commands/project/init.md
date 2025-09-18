# /project/init — Initialize Minimal Spec & Guardrails

Role
- Create skeleton `/SPEC.md` and `/ACCEPTANCE.md` from templates and capture answers to the user interview.

Inputs
- User intent (one sentence), constraints, target language/runtime, and success criteria.

Required Outputs
- New or updated `/SPEC.md` and `/ACCEPTANCE.md` derived from templates.
- Recorded Non-goals and Risk/Effort tradeoffs.
- At least one unknown—verification needed with a test plan (e.g., `claude --help`).

Procedure (doc-backed)
1) Interview the user for intent, constraints, and acceptance tests [4][6].
2) Restate back briefly; on confirmation, populate templates and write files [3][4].
3) Announce any tool calls and expected outputs before running [4].

Allowed Tools
- `shell` for copying templates and writing files [4].

Shell Steps (example)
- Plan: copy templates into repo root; replace placeholders with provided inputs.
- Example commands (announce before running):
  - `cp bmad-lite/templates/spec.md SPEC.md`
  - `cp bmad-lite/templates/acceptance-tests.md ACCEPTANCE.md`

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

