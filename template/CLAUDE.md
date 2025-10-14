# vibe-code-bootstrap

Purpose
- Enforce “simplest working solution wins.”
- Run entirely in Claude Code CLI using slash-commands and agent Markdown.
- Keep outputs small, auditable, and doc-backed.
- Provide a generic, project-agnostic workflow users can drop into any repo.

Scope
- Coordinates core agents: spec-writer → task-decomposer → coder → reviewer.
- Adds supporting agents: router (routes intent) and documentarian (docs).
- **Autopilot mode**: `/project:next` analyzes state and guides workflow
- **Progress tracking**: PROGRESS.md auto-generated for agent-to-agent context
- Provides project slash-commands in `.claude/commands/project/`:
  - `/project:next` → autopilot navigator (recommended workflow)
  - `/project:init` → create SPEC.md and ACCEPTANCE.md (optional: vibe.md)
  - `/project:plan` → break down spec into micro-tasks (optional: TDD mode)
  - `/project:build` → implement next task
  - `/project:review` → gate check and approve/reject
  - `/project:doctor` → diagnose workflow issues
  - `/project:help` → show available commands
- Provides documentation commands in `.claude/commands/docs/`:
  - `/docs:readme` → draft or update README.md
  - `/docs:decision` → log architectural decisions (ADR-style)
  - `/docs:scaffold-advanced` → create comprehensive open-source docs
- Provides operations commands for in-between workflows:
  - `/ops:route` → route unclear intent to appropriate command
  - `/ops:adhoc` → perform one-off micro-tasks

References (Anthropic)
- Claude Code overview/reference & quickstart: [5], [1], [2]
- Slash commands structure & best practices incl. CLAUDE.md: [3], [6]
- Tool use, agents, prompt best practices: [4], [6]

Assumptions
- Slash command file structure and headers in Markdown are documented in [3].
- Some editor integrations discover commands by path; others require pasting the content.
- Tool names available by default (e.g., shell, editor/patch) may vary by environment.
- Assume end users may have zero MCP servers configured; external servers are optional.

CLI Quickstart
- Install and auth per [2].
- Verify install: run `claude --help` and `claude code --help` [1][5].
- Run slash commands by path:  
  `claude .claude/commands/project/init.md` [3]  
  If unsupported, open the file in Claude Code and execute it as a slash command (paste the file contents).

Slash Commands Conventions
- Commands are Markdown files invoking a structured prompt [3].
- **Recommended workflow**: Use `/project:next` as autopilot (eliminates decision fatigue)
- **Manual workflow**: Chain commands: init → plan → build → review
- Each command describes: role, inputs, required outputs, stop conditions, allowed tools [3][4].
- All commands log progress to PROGRESS.md for agent context sharing

Tool Use Policy
- Agents declare allowed tools in front-matter (`tools: filesystem, memory, …`) [4].
- Tools must be explicitly named and invoked with purpose [4].
- Prefer minimal, deterministic shell steps; avoid network unless required [6].
- Summarize tool output concisely (diffs, small snippets) [4][6].

Dependency & Complexity Policy
- Default: no new dependencies unless mandated by acceptance tests [6].
- Complexity budget: max 1 file changed per micro-task unless mechanically safe [6].
- MVP-first: stop adding features after first passing acceptance unless explicitly approved [6].

Rollback / MVP Gate
- If a change increases deps or crosses budget, revert and propose a simpler path [6].
- Reviewer may include a revert step (via patch or git) if gates fail [6].

Test: Slash Commands
- Run: `claude .claude/commands/project/init.md`. If not recognized, consult `claude --help` or paste the file content into Claude Code directly [1][3].

Test: Tools
- In a temp project, run a command that calls `shell` to `echo` a file and `git status`.
- Confirm output is summarized [4]. If `shell` is unavailable, provide a manual inspection step instead.

Optional Features (Accordion Design)
All advanced features are opt-in and never forced:
- **Vibe Definition**: Define creative direction in `.claude/vibe.md` (offered during init)
- **TDD Mode**: Generate precode test stubs (offered during plan)
- **Comprehensive Docs**: Full open-source structure via `/docs:scaffold-advanced`
- **Decision Logging**: Track architectural decisions via `/docs:decision`
- **Progress Tracking**: PROGRESS.md auto-generated (always enabled for agent context)

Local Policies
- Keep prompts terse with crisp acceptance tests [4][6].
- Prefer patch edits over complex generators [6].
- Document new tool/flag usage here with a rationale and citation.
- **Workflow shortcuts**:
  - Use `/project:next` for autopilot (recommended)
  - Use `/ops:route` to decide next step if unsure
  - Use `/docs:readme` to maintain docs
  - Use `/ops:adhoc` for one-off, minimal changes

