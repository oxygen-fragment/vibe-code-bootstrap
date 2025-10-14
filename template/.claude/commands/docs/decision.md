# /docs:decision — Log an architectural or process decision

**Usage:** `claude .claude/commands/docs/decision.md "<Decision Title>"`

You are acting inside Claude Code via a custom slash command. This command helps capture **why** important choices were made in the project, creating a transparent history that future contributors can reference.

## Goal
Append a new decision entry to `DECISIONS.md` documenting an architectural, process, or significant product choice. This creates an audit trail similar to Architecture Decision Records (ADRs).

## When to Use
Log decisions about:
- **Architecture**: Choosing frameworks, databases, patterns, or system design
- **Process**: Workflow changes, tooling choices, development practices
- **Product**: Feature prioritization, scope changes, user-facing decisions
- **Dependencies**: Adding/removing libraries or external services
- **Security**: Authentication approaches, data handling, privacy choices

**Skip logging** routine code changes, bug fixes, or minor adjustments.

## Input Required
The decision title is passed as an argument (e.g., "Use SQLite for local development").

You will need to gather:
1. **Context**: Why this decision matters, what problem it solves
2. **Options considered**: What alternatives were evaluated
3. **Decision**: What was chosen and the primary reasoning
4. **Consequences**: Trade-offs, benefits, follow-up actions needed

## Procedure

### 1. Check for DECISIONS.md
- If missing: Copy from `template/templates/DECISIONS.md` OR create with header
- If exists: Prepare to append new entry

### 2. Interview for Details
Ask the user concise questions to gather the required information:

```
I'll help document this decision. Let me ask a few questions:

1. Context: What problem or need prompted this decision?

2. Options: What alternatives did you consider? (e.g., "Considered PostgreSQL, MongoDB, or SQLite")

3. Decision: What did you choose and why? (Focus on the primary reasoning)

4. Consequences: What are the trade-offs or follow-up actions? (e.g., "Simplifies local dev, but may need migration for production")
```

**Keep it concise**: Aim for 2-4 sentences per section. Decision logs should be scannable, not essays.

### 3. Generate Entry
Create the entry using this format:

```markdown
## YYYY-MM-DD — Decision Title

**Status:** Finalized

**Context:** [Why this decision matters and what prompted it]

**Options Considered:**
- [Option 1]: [Brief note]
- [Option 2]: [Brief note]
- [Option 3]: [Brief note]

**Decision:** [What was chosen and the primary reasoning in 2-3 sentences]

**Consequences:**
- [Trade-off or benefit 1]
- [Trade-off or benefit 2]
- [Follow-up actions if any]

---

```

**Note the trailing `---` separator** - this visually separates decision entries.

### 4. Show Preview
Display the generated entry and ask:
```
Here's the decision entry I'll add to DECISIONS.md:

[show the markdown entry]

Approve to append? [y/N]
```

### 5. Append to DECISIONS.md
If approved:
- Open DECISIONS.md
- Append the new entry (newest entries typically go at the **top** after the header, or at bottom - check existing convention)
- Save the file

### 6. Confirm Completion
```
✓ Decision logged to DECISIONS.md

This decision is now part of the project's permanent record.
Future contributors can reference it to understand the reasoning.
```

## Format Examples

### Example 1: Architecture Decision
```markdown
## 2025-10-14 — Use SQLite for Local Development

**Status:** Finalized

**Context:** Needed a database for local development that works without external services. Team members have varying levels of database administration experience.

**Options Considered:**
- **PostgreSQL**: Full-featured, production-like, but requires installation and management
- **MongoDB**: Document store, flexible schema, but overkill for current needs
- **SQLite**: File-based, zero-config, widely supported

**Decision:** Use SQLite for local development database. It requires zero setup, is built into Python/Node, and keeps the development environment simple. Data is stored in a single file (`dev.db`) that can be easily reset.

**Consequences:**
- ✓ Simplifies onboarding - no database server to install
- ✓ Enables faster iteration - reset database by deleting a file
- ✗ May diverge from production database features (will use PostgreSQL in prod)
- ➡ Need to document schema and migrations to ensure prod compatibility

---

```

### Example 2: Process Decision
```markdown
## 2025-10-14 — Adopt Conventional Commits

**Status:** Finalized

**Context:** Git history is becoming difficult to scan. Need better commit organization for automated changelog generation and issue linking.

**Options Considered:**
- **Free-form**: Current approach, flexible but inconsistent
- **Conventional Commits**: Structured format (feat:, fix:, docs:, etc.)
- **Custom format**: Define our own, but reinvents the wheel

**Decision:** Adopt Conventional Commits (https://www.conventionalcommits.org/) for all commit messages. Format: `type(scope): description` where type is feat, fix, docs, refactor, test, chore, etc.

**Consequences:**
- ✓ Enables automated changelog generation via tools
- ✓ Makes git log scannable and searchable
- ✓ Industry standard with good tooling support
- ➡ Need to update CONTRIBUTING.md with examples
- ➡ Add commit message linter to PR checks

---

```

### Example 3: Product Decision
```markdown
## 2025-10-14 — Defer User Authentication to v2.0

**Status:** Finalized

**Context:** Initial MVP scope included user authentication, but implementation complexity is delaying core features. Need to decide on MVP feature set.

**Options Considered:**
- **Build auth now**: Complete but delays MVP launch by 2-3 weeks
- **Defer to v2.0**: Ship core features first, add auth in next version
- **Use third-party**: OAuth via Google/GitHub, but adds external dependency

**Decision:** Defer user authentication to v2.0. The core value prop (data visualization) doesn't require user accounts for single-user mode. We'll ship v1.0 as a local-only tool, then add auth and cloud sync in v2.0.

**Consequences:**
- ✓ Faster MVP launch - can ship in 1 week instead of 3-4
- ✓ Validates core features before investing in auth infrastructure
- ✗ v1.0 limited to single-user, local-only usage
- ➡ Need to design data model with future multi-user support in mind
- ➡ Add "Authentication & Cloud Sync" to v2.0 roadmap

---

```

## Status Values

Use these standard status values:

- **Pending**: Decision is under discussion, not yet finalized
- **Finalized**: Decision is approved and being implemented
- **Revisited**: Decision is being reconsidered or was overturned
- **Superseded**: Replaced by a later decision (link to new entry)

Most new entries will be **Finalized** (the decision has been made).

## Tips for Good Decision Logs

- **Be concise**: 3-5 sentences per section is ideal
- **Focus on "why"**: Future contributors need context, not just "what"
- **Include date**: Decisions age, and context changes over time
- **Link related decisions**: Reference other entries if relevant
- **Update status**: If a decision is revisited, update the original entry and add a new one
- **Don't overthink**: Not every code change needs a decision log - save it for significant choices

## Edge Cases

**If DECISIONS.md doesn't exist:**
- Create it with a header explaining the purpose
- Add the first entry

**If decision was already made but not documented:**
- That's fine! Log it retroactively with the current date
- Note in Context: "Documenting a decision made previously..."

**If decision is being overturned:**
- Create a new entry explaining the change
- Update the old entry's status to "Superseded" with a link to the new entry

## Notes
- This command does NOT commit changes - user must commit manually
- Keep decision logs in the repository root for easy discovery
- Decision logs are living documents - it's ok to update them
- Align with open-source ADR best practices (see https://adr.github.io/)

---

**Related docs:** DECISIONS.md template, CONTRIBUTING.md, WORKFLOW.md
