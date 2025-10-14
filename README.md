# vibe-code-bootstrap: Simplest Working Solution Pipeline

A constraint-driven coding pipeline designed for the Claude Code CLI that enforces “simplest working solution wins.” It interviews the user, decomposes work, and coordinates agents to produce specs, micro‑tasks, code, and reviews.

Overview
- **Autopilot mode**: Run `/project:next` and it tells you what to do next
- Phases: init → plan → build → review (or just follow /project:next guidance)
- Roles: spec-writer → task-decomposer → coder → reviewer
- Progress tracking: PROGRESS.md auto-generated for agent-to-agent context
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

Quick Start (Autopilot Mode - Recommended)
1) Verify CLI: `claude --help`

2) Start your project: `claude .claude/commands/project/init.md`
   - Answer a few questions to create `SPEC.md` and `ACCEPTANCE.md`
   - Optionally define a project vibe (tone, style, constraints)

3) Let autopilot guide you: `claude .claude/commands/project/next.md`
   - Analyzes your project state (SPEC, PLAN, PROGRESS)
   - Tells you exactly what to run next
   - Just keep running `/project:next` until your MVP is complete

That's it! The autopilot mode eliminates decision-making fatigue.

Manual Mode (Expert Users)
If you prefer explicit control, run commands directly:

1) **Init**: `claude .claude/commands/project/init.md`
   - Creates `SPEC.md` and `ACCEPTANCE.md`
   - Optional: Define project vibe in `.claude/vibe.md`

2) **Plan**: `claude .claude/commands/project/plan.md`
   - Produces `PLAN.md` with 3–7 micro-tasks
   - Optional: Generate precode test stubs for TDD mode

3) **Build**: `claude .claude/commands/project/build.md`
   - Implements the next task with minimal diff
   - Logs progress to `PROGRESS.md`

4) **Review**: `claude .claude/commands/project/review.md`
   - Enforces gates: deps, complexity budget, acceptance checks
   - Approves or proposes revert with smaller alternative

5) **Repeat**: Build → Review until all tasks complete

Guardrails (enforced by commands and agents)
- Dependency policy: no new dependencies for MVP unless mandated by acceptance tests.
- Complexity budget: default 1 file change per micro‑task (justify exceptions in `PLAN.md`).
- Feature freeze: after first green MVP test, pause features; future work must pass an “MVP-first” gate.
- Rollback: if gates fail, revert immediately and propose the smallest successful path.

Repository Structure
- `template/` — Distribution artifacts copied to user projects
  - `template/.claude/agents/*.md` — Role prompts (spec-writer, task-decomposer, coder, reviewer, router, documentarian)
  - `template/.claude/commands/project/*.md` — Core workflow commands (12 total)
  - `template/.claude/commands/docs/*.md` — Documentation commands
  - `template/CLAUDE.md` — Local policies, tool use, and verification tests
  - `template/mcp.tools.json` — Optional MCP tool mappings
  - `template/templates/*.md` — Templates for SPEC, PLAN, ACCEPTANCE, PROGRESS, DECISIONS, vibe.md
  - `template/templates/comprehensive/*.md` — Advanced open-source templates (WORKFLOW, ARCHITECTURE, SECURITY, etc.)
- `.claude/` — Development config for working on vibe-bootstrap itself (not distributed)

Optional Features (Accordion Design)
All advanced features are **opt-in** and never forced:
- **Vibe Definition**: Define creative direction in `.claude/vibe.md` (asked during init)
- **TDD Mode**: Generate precode test stubs (asked during plan)
- **Comprehensive Docs**: Create full open-source structure with `/docs:scaffold-advanced`
- **Decision Logging**: Track architectural decisions with `/docs:decision`
- **Progress Tracking**: PROGRESS.md auto-generated (always enabled for agent context)

Available Commands

**Core Workflow (project/):**
- `/project:next` - Autopilot navigator (tells you what to run next)
- `/project:init` - Create SPEC.md and ACCEPTANCE.md
- `/project:plan` - Break down spec into micro-tasks
- `/project:build` - Implement the next task
- `/project:review` - Gate check and approve/reject
- `/project:doctor` - Diagnose workflow issues
- `/project:help` - Show available commands

**Documentation (docs/):**
- `/docs:readme` - Draft or update README.md
- `/docs:decision` - Log architectural decisions (ADR-style)
- `/docs:scaffold-advanced` - Create comprehensive open-source docs

**Operations (ops/):**
- `/ops:route` - Route unclear intent to appropriate command
- `/ops:adhoc` - Perform one-off micro-tasks

Typical Flow
- **Autopilot**: Run `/project:next` repeatedly until MVP complete
- **Manual**: init → plan → (build → review) × N → feature-freeze
- **All workflows**: Auto-generate `PROGRESS.md` for agent context

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
