# vibe-code-bootstrap: Simplest Working Solution Pipeline

A constraint-driven coding pipeline designed for the Claude Code CLI that enforces “simplest working solution wins.” It interviews the user, decomposes work, and coordinates agents to produce specs, micro‑tasks, code, and reviews.

Overview
- Phases: init → plan → build → review
- Roles: spec-writer → task-decomposer → coder → reviewer
- Guardrails: no new deps (by default), small diffs, MVP-first, fast rollback

Add To Your Project (copy these files)
- Required: copy `template/.claude/` folder and `template/CLAUDE.md` into the root of your own project (your repository).
- Recommended (for guided setup): also copy `vibe_bootstrap.sh`, the `scripts/` folder, `template/mcp.tools.json`, and the `template/templates/` folder. These add the one‑liner setup and onboarding helper.
- That's it — no other tools or servers are required.
- Note: The root `.claude/` directory in this repo is for vibe-bootstrap development only; user projects get the distribution from `template/`.

Prerequisites
- Claude Code CLI installed and authenticated. See Anthropic docs: Overview/CLI Reference/Setup/Slash Commands/Tool Use/Best Practices.
  - https://docs.anthropic.com/en/docs/claude-code (overview)
  - https://docs.anthropic.com/en/docs/claude-code/cli-reference (CLI reference)
  - https://docs.anthropic.com/en/docs/claude-code/setup (setup/quickstart)
  - https://docs.anthropic.com/en/docs/claude-code/slash-commands (slash commands)
  - https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/overview (tool use)
  - https://www.anthropic.com/engineering/claude-code-best-practices (best practices)

Non-Technical Quick Start (no extra setup)
- First, copy `template/.claude/` + `template/CLAUDE.md` (and optionally `vibe_bootstrap.sh` + `scripts/`) into your project folder.
- No MCP servers required. This works out-of-the-box using Claude Code's local tools.
- Easiest path: run `bash vibe_bootstrap.sh` (no need for chmod), then paste `/project:init` into Claude Code.
- Non-interactive: `bash vibe_bootstrap.sh --defaults` (applies defaults and offers onboarding).
- In an interactive terminal, the script offers to run onboarding immediately.
- If a `.gitignore` is missing, the script can create a minimal one for you.

Quick Start
1) Verify CLI
- Run: `claude --help` and optionally `claude code --help`.

2) Initialize Project Spec
- Run (path invocation): `claude .claude/commands/project/init.md`
- If your CLI does not support path invocation, open the file in Claude Code and run it as a slash command (paste the contents into the chat input).
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
- `template/` — Distribution artifacts copied to user projects
  - `template/.claude/agents/*.md` — Role prompts for each agent phase
  - `template/.claude/commands/project/*.md` — Slash commands that orchestrate each phase
  - `template/.claude/templates/*.md` — Templates for `SPEC.md`, `PLAN.md` tasks, and `ACCEPTANCE.md`
  - `template/CLAUDE.md` — Local policies, tool use, and verification tests
  - `template/mcp.tools.json` — Optional MCP tool mappings
  - `template/templates/` — Additional project templates (e.g., .gitignore)
- `.claude/` — Development config for working on vibe-bootstrap itself (not distributed)

Typical Flow
- Start: `init` to create `SPEC.md` and `ACCEPTANCE.md` → `plan` to create `PLAN.md` → loop over `build` then `review` per micro‑task until MVP acceptance passes → feature-freeze or proceed with strictly scoped improvements.

Verification & Troubleshooting
- CLI flags and command discovery: run `claude --help`. If path-based execution is unsupported, open the Markdown file in Claude Code and run it as a slash command.
- Tool visibility: commands announce tool intent (per Tool Use docs). Confirm outputs are summarized, not verbose.
- Rollback: use `git checkout -- <file>` or revert the last patch/diff if a gate fails, then re-run `build` with a smaller change.

Advanced: Optional MCP Servers (totally optional)
- You do not need any MCP servers to use this boilerplate. Most users can ignore this section.
- If you already use extra MCP servers (e.g., `octocode`, `sequential-thinking`) in your editor, you can reflect that preference in `mcp.tools.json`.
- Update the mapping interactively: `python3 scripts/configure_mcp_tools.py --interactive`.
- Verify the mapping any time: `python3 scripts/configure_mcp_tools.py --list`.
- Note: `mcp.tools.json` is documentation of intended defaults. It does not configure your editor; enable/disable servers in your editor’s MCP settings if desired.

What are MCP servers? (plain-English)
- Helpers your editor can talk to for extra tools (e.g., linters, analyzers).
- You don’t need any of them to use this boilerplate.
- If you already use them, the mapping here just documents which agents may use which tools.

 Notes
- Keep acceptance tests concrete (exact commands/outputs).
- Prefer editing existing files over adding new ones when feasible.
- Summarize tool outputs; avoid long logs.
- Agents note: `.claude/agents/*.md` are reference role specs. Commands inline the relevant role constraints so behavior is enforced even if the CLI doesn’t auto-load agent files.
