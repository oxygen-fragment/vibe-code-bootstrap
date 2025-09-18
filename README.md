# bmad-lite: Simplest Working Solution Pipeline

A constraint-driven coding pipeline designed for the Claude Code CLI that enforces “simplest working solution wins.” It interviews the user, decomposes work, and coordinates agents to produce specs, micro‑tasks, code, and reviews.

Overview
- Phases: init → plan → build → review
- Roles: spec-writer → task-decomposer → coder → reviewer
- Guardrails: no new deps (by default), small diffs, MVP-first, fast rollback

Prerequisites
- Claude Code CLI installed and authenticated. See Anthropic docs: Overview/CLI Reference/Setup/Slash Commands/Tool Use/Best Practices.
  - https://docs.anthropic.com/en/docs/claude-code (overview)
  - https://docs.anthropic.com/en/docs/claude-code/cli-reference (CLI reference)
  - https://docs.anthropic.com/en/docs/claude-code/setup (setup/quickstart)
  - https://docs.anthropic.com/en/docs/claude-code/slash-commands (slash commands)
  - https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/overview (tool use)
  - https://www.anthropic.com/engineering/claude-code-best-practices (best practices)

Quick Start
1) Verify CLI
- Run: `claude --help` and optionally `claude code --help`.

2) Initialize Project Spec
- Run (path invocation): `claude .claude/commands/project/init.md`
- If your CLI does not support direct path invocation, open the file in Claude Code and run it as a slash command. unknown—verification needed; confirm via `claude --help`.
- Answer short questions. The command creates `SPEC.md` and `ACCEPTANCE.md` at the repo root.

3) Plan Micro‑Tasks
- Run: `claude .claude/commands/project/plan.md`
- Produces `PLAN.md` with 3–7 micro‑tasks based on `templates/microtask.md` and sets a complexity budget and rollback checkpoint.

4) Build the Next Task
- Run: `claude .claude/commands/project/build.md`
- Implements the smallest possible diff to satisfy the current task’s acceptance check, and shows minimal evidence (command output snippet).

5) Review and Gate
- Run: `claude .claude/commands/project/review.md`
- Enforces gates: no new deps unless approved, change size within budget, acceptance evidence present. Approves or proposes revert with a smaller alternative.

Guardrails (enforced by commands and agents)
- Dependency policy: no new dependencies for MVP unless mandated by acceptance tests.
- Complexity budget: default 1 file change per micro‑task (justify exceptions in `PLAN.md`).
- Feature freeze: after first green MVP test, pause features; future work must pass an “MVP-first” gate.
- Rollback: if gates fail, revert immediately and propose the smallest successful path.

Repository Structure
- `.claude/CLAUDE.md` — Local policies, tool use, and verification tests.
- `.claude/agents/*.md` — Role prompts for each agent phase.
- `.claude/commands/project/*.md` — Slash commands that orchestrate each phase.
- `.claude/templates/*.md` — Templates for `SPEC.md`, `PLAN.md` tasks, and `ACCEPTANCE.md`.

Typical Flow
- Start: `init` to create `SPEC.md` and `ACCEPTANCE.md` → `plan` to create `PLAN.md` → loop over `build` then `review` per micro‑task until MVP acceptance passes → feature-freeze or proceed with strictly scoped improvements.

Verification & Troubleshooting
- CLI flags and command discovery: run `claude --help`. If path-based command execution is unsupported, open the Markdown file in Claude Code and run as a slash command. unknown—verification needed per CLI version.
- Tool visibility: commands announce tool intent (per Tool Use docs). Confirm outputs are summarized, not verbose.
- Rollback: use `git checkout -- <file>` or revert the last patch/diff if a gate fails, then re-run `build` with a smaller change.

Notes
- Keep acceptance tests concrete (exact commands/outputs).
- Prefer editing existing files over adding new ones when feasible.
- Summarize tool outputs; avoid long logs.
- Agents note: `.claude/agents/*.md` are reference role specs. Commands already inline the relevant role constraints so behavior is enforced even if the CLI doesn’t auto-load agent files.
