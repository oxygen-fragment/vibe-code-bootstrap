# vibe-code-bootstrap

Purpose
- Enforce “simplest working solution wins.”
- Run entirely in Claude Code CLI using slash-commands and agent Markdown.
- Keep outputs small, auditable, and doc-backed.
- Provide a generic, project-agnostic workflow users can drop into any repo.

Scope
- Coordinates core agents: spec-writer → task-decomposer → coder → reviewer.
- Adds supporting agents: router (routes intent) and documentarian (docs).
- Provides project slash-commands in `.claude/commands/project/` for:
  - `/project:init`
  - `/project:plan`
  - `/project:build`
  - `/project:review`
  - `/project:doctor`
  - `/project:help`
- Provides additional commands for in-between workflows:
  - `/ops:route` → routes intent when unclear
  - `/ops:adhoc` → perform one-off micro-tasks
  - `/docs:readme` → draft or update README.md

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
- Keep commands short, explicit, and chained (init → plan → build → review).
- Each command describes: role, inputs, required outputs, stop conditions, allowed tools [3][4].

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

Local Policies
- Keep prompts terse with crisp acceptance tests [4][6].
- Prefer patch edits over complex generators [6].
- Document new tool/flag usage here with a rationale and citation.
- For in-between work:
  - Use `/ops:route` to decide next step if unsure.
  - Use `/docs:readme` to maintain docs.
  - Use `/ops:adhoc` for one-off, minimal changes.

