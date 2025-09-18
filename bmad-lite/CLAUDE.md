# bmad-lite (Bootstrap Minimal Anthropic Design – Lite)

Purpose
- Enforce “simplest working solution wins.”
- Run entirely in Claude Code CLI using slash-commands and agent Markdown.
- Keep outputs small, auditable, and doc-backed.

Scope
- Coordinates four agents: spec-writer → task-decomposer → coder → reviewer.
- Provides project slash-commands for init, plan, build, review.

References (Anthropic)
- Claude Code overview/reference & quickstart: [5], [1], [2]
- Slash commands structure & best practices incl. CLAUDE.md: [3], [6]
- Tool use, agents, prompt best practices: [4], [6]

Assumptions and Unknowns
- Slash command file structure and headers in Markdown are documented in [3], but exact front‑matter keys for CLI discovery can vary by release. Marked unknown—verification needed.
- Tool names available by default (e.g., shell, fs, apply_patch) may vary by environment. Marked unknown—verification needed. See Test: Tools below.

CLI Quickstart
- Install and auth per [2].
- Verify install: run `claude --help` and `claude code --help` [1][5].
- Discover slash commands: `claude --help` (unknown—verification needed). If discovery is not automatic, run commands by path: `claude bmad-lite/commands/project/init.md` [3].

Slash Commands Conventions (doc-backed)
- Commands are Markdown files invoking a structured prompt for Claude Code [3].
- Keep commands short, explicit, and scoped; prefer chained commands per phase (init → plan → build → review) [3][6].
- Each command lists: role, inputs, required outputs, stop conditions, allowed tools [3][4].

Tool Use Policy (doc-backed)
- Tools should be explicit by name and purpose within prompts [4].
- Prefer minimal, deterministic shell steps; avoid network unless required [6].
- Before invoking tools, the agent must state intent and expected outputs [4].
- Capture tool outputs concisely; summarize deltas (diffs) for audit [4][6].

Dependency & Complexity Policy
- Default: no new dependencies for MVP unless mandated by acceptance tests [6].
- Complexity budget: max 1 file changed per micro‑task unless the change is purely mechanical and risk‑free (unknown—verification needed across diverse repos; enforce via reviewer command’s gate).
- Feature freeze after first green acceptance tests; additional work must pass a “MVP-first” gate [6].

Rollback / MVP Gate
- If a change increases deps or crosses complexity budget, revert and propose a simpler path [6].
- Reviewer command includes a Revert Step that restores previous state (via git or patch) if gates fail [6].

Test: Slash Commands
- Create a minimal command (provided in this repo). Run: `claude bmad-lite/commands/project/init.md` (unknown—verification needed per CLI version). If not recognized, consult `claude --help` for slash-command invocation [1][3].

Test: Tools
- In a temp project, run a command that calls `shell` to `echo` a file and `git status`. Confirm the tool output appears inline in Claude and is summarized [4].

Local Policies
- Keep prompts terse with crisp acceptance tests [4][6].
- Prefer editing files via Claude’s editor / patch mechanism rather than complex generators [6].
- Document any new tool/flag usage here with a rationale and citation.

