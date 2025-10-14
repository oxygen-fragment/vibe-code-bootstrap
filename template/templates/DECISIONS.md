# Project Decisions

**Purpose:** This file records **why** significant choices were made in the project. It acts as an Architecture Decision Record (ADR) log, providing a transparent history of decisions for future contributors.

**When to log a decision:**
- Architectural choices (frameworks, databases, patterns)
- Process changes (workflow, tooling, practices)
- Significant product decisions (features, scope, priorities)
- Dependency additions/removals
- Security or privacy approaches

**When to skip:**
- Routine code changes or bug fixes
- Minor adjustments or refactoring
- Implementation details (save those for code comments)

**How to add a decision:** Run `/docs:decision "<Decision Title>"` to interactively create a new entry, or manually add an entry using the format below.

---

## Entry Format Template

```markdown
## YYYY-MM-DD — Decision Title

**Status:** Pending | Finalized | Revisited | Superseded

**Context:** Why this decision matters and what prompted it.

**Options Considered:**
- **Option 1**: Brief description
- **Option 2**: Brief description
- **Option 3**: Brief description

**Decision:** What was chosen and the primary reasoning (2-3 sentences).

**Consequences:**
- ✓ Benefit or positive trade-off
- ✗ Drawback or cost
- ➡ Follow-up action needed

---
```

**Example Entries Below** — Replace or remove these once you have real decisions.

---

## 2025-10-14 — Documentation-First Approach

**Status:** Finalized

**Context:** At project start, requirements were uncertain and coding felt risky. Clear documentation was needed to align contributors and AI agents on project goals before writing code.

**Options Considered:**
- **Code-first**: Jump into implementation, document later
- **Documentation-first**: Write specs, workflow, and templates before code
- **Hybrid**: Minimal docs, iterate with code

**Decision:** Prioritize comprehensive documentation (SPEC, WORKFLOW, ACCEPTANCE) before writing any feature code. This ensures all contributors (human and AI) have a shared reference for structure and goals.

**Consequences:**
- ✓ Faster onboarding - new contributors understand project immediately
- ✓ Clearer expectations - agents have explicit instructions
- ✗ Delays initial coding by 1-2 days
- ➡ Must keep docs updated as project evolves (treat as living documents)

---

## 2025-10-14 — Use Markdown for All Documentation

**Status:** Finalized

**Context:** Needed a documentation format that is human-readable, version-controllable, and AI-friendly. Common options were markdown, org-mode, or custom formats.

**Options Considered:**
- **Markdown**: Widely supported, GitHub-native, simple syntax
- **Org-mode**: Powerful but Emacs-specific, limited tool support
- **Custom format**: Maximum control, but creates learning curve

**Decision:** Use GitHub-flavored Markdown for all documentation files. It's the industry standard for open-source projects, renders natively on GitHub, and is supported by virtually all editors and AI tools.

**Consequences:**
- ✓ Zero learning curve - most developers know markdown
- ✓ Native GitHub rendering with good formatting
- ✓ AI agents handle markdown extremely well
- ➡ Use consistent heading levels and formatting across all docs

---

## 2025-10-14 — Agent-Based Command Structure

**Status:** Finalized

**Context:** Claude Code supports slash commands via markdown files. We could use monolithic commands or delegate to specialized agents. Need to decide on command architecture.

**Options Considered:**
- **Monolithic commands**: All logic in command files
- **Agent delegation**: Commands delegate to specialized agents
- **Hybrid**: Simple commands are monolithic, complex ones delegate

**Decision:** Use agent delegation pattern - each command file (`/project:init`, `/project:plan`, etc.) delegates to a specialized agent (`spec-writer`, `task-decomposer`, etc.). Commands contain instructions and goals; agents contain the actual working logic.

**Consequences:**
- ✓ Cleaner separation of concerns
- ✓ Agents are reusable across commands
- ✓ Easier to test and iterate on agent behavior
- ✗ Slight learning curve for understanding two-layer architecture
- ➡ Document delegation pattern in CLAUDE.md

---

## Tips for Writing Good Decision Entries

1. **Date consistently**: Use YYYY-MM-DD format for sortability
2. **Focus on "why"**: Future contributors need context, not just "what"
3. **Be concise**: 3-5 sentences per section keeps entries scannable
4. **Include trade-offs**: Acknowledge cons honestly - perfect decisions are rare
5. **Link related decisions**: Reference earlier entries when relevant
6. **Update status**: If revisiting a decision, update the original and add a new entry

---

## Decision Status Definitions

| Status | Meaning |
|--------|---------|
| **Pending** | Under discussion, not yet finalized |
| **Finalized** | Approved and being implemented |
| **Revisited** | Being reconsidered or modified |
| **Superseded** | Replaced by a later decision (link to new entry) |

---

## When to Update This File

- **After major decisions**: Add entry as soon as decision is made
- **During PR review**: If a PR introduces a significant choice, document it
- **During retrospectives**: Capture lessons learned from experiments
- **When overturning decisions**: Update old status and add new entry

**Treat this file as a living history** - it's okay to update entries as understanding deepens.

---

**Related Documentation:**
- `/docs:decision` command - Interactive decision logging
- WORKFLOW.md - How decisions flow through the development process
- ARCHITECTURE.md - Technical decisions about project structure
- CONTRIBUTING.md - How to propose and discuss decisions

**Reference:** Architecture Decision Records (ADRs) - https://adr.github.io/

---

*Delete or replace the example entries above once you have real project decisions to log.*
