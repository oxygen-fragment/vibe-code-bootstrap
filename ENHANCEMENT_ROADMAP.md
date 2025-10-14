# vibe-code-bootstrap Enhancement Roadmap

**Generated:** 2025-10-14
**Research Sources:**
- "Empirical and Practical Methodologies for Vibe Coding.md" (prompt chaining, selective test-first)
- "Project Kickoff Documentation (Generic Scaffold, Enhanced).pdf" (comprehensive templates)
- GitHub research: Ignite (19K⭐), Generate, agent frameworks
- Sequential thinking analysis (12-step deep dive)

---

## Executive Summary

**Current State:** Well-architected file-based command system with clean phase progression (init → plan → build → review). Already follows industry best practices for scaffold tools.

**Core Philosophy:** "Accordion" design - collapses to 4 simple commands, expands to 15+ features when needed. Everything advanced is **opt-in**, never forced.

**Key Insight:** The file-based command architecture IS the simplicity pattern. Don't over-engineer. Focus on UX improvements and optional power features.

---

## Implementation Status Tracker

### TIER 1: Quick Wins (High Impact, Low Complexity)

#### [x] 1. Add `/project:next` Command ⭐ HIGHEST PRIORITY
- **Status:** ✅ Completed (2025-10-14)
- **Priority:** P0 - Do this first
- **Impact:** Transforms UX from "which command?" to "just run /project:next"
- **Effort:** ~1 hour (actual: 1 hour)
- **Files created:**
  - ✅ `template/.claude/commands/project/next.md` (174 lines)
- **Implementation notes:**
  - Router reads SPEC.md, PLAN.md, PROGRESS.md existence/content
  - Returns explicit "Run /project:X" recommendation with state summary
  - Heuristics implemented:
    - No SPEC.md → `/project:init`
    - SPEC exists, no PLAN → `/project:plan`
    - PLAN exists, incomplete tasks → `/project:build`
    - All tasks done → `/project:review`
    - MVP complete → suggest feature freeze or new planning
    - Unclear state → `/project:doctor`
  - Handles edge cases: empty files, missing status markers, malformed plans
  - Includes detailed output format with emojis for clarity
  - Delegates to router agent for decision logic
- **Validation:** ✅ Logic tested against vibe-bootstrap's own PLAN.md
- **Testing notes:** Command correctly handles plans without explicit status markers (treats as pending)

#### [x] 2. Add Auto-Generated PROGRESS.md
- **Status:** ✅ Completed (2025-10-14)
- **Priority:** P0
- **Impact:** Enables agent-to-agent context, creates audit trail
- **Effort:** ~2 hours (actual: 2 hours)
- **Files modified:**
  - ✅ `template/.claude/commands/project/init.md` (added Progress Logging section)
  - ✅ `template/.claude/commands/project/plan.md` (added Progress Logging section)
  - ✅ `template/.claude/commands/project/build.md` (added Progress Logging section with success/failure handling)
  - ✅ `template/.claude/commands/project/review.md` (added Progress Logging section with PASS/FAIL handling)
  - ✅ `template/.claude/commands/project/next.md` (added optional Progress Logging section)
- **Files created:**
  - ✅ `template/templates/PROGRESS.md` (starter template with 6 example entries)
- **Format implemented:**
  ```markdown
  ### YYYY-MM-DD HH:MM - /project:command
  **Agent:** agent-name
  **Status:** completed|failed|in-progress
  **Summary:** brief description
  **Files:** files affected
  **Evidence/Outcome:** verification output or result
  ```
- **Implementation details:**
  - Each command checks if PROGRESS.md exists, creates from template if missing
  - Entries are lightweight (3-7 lines each depending on outcome)
  - Append-only, never overwrites
  - Handles success and failure cases appropriately
  - `/project:build` logs both completed and failed attempts with rationale
  - `/project:review` logs PASS/FAIL verdicts with gate check results
  - `/project:next` optionally logs (default: no logging for read-only navigator)
  - Archive recommendation: move to `docs/progress-archive/` after 50+ entries
- **Validation:** ✅ All commands instrumented with clear logging instructions
- **Testing notes:** Template provides 6 realistic example entries showing both success and failure patterns

#### [x] 3. Add "Next Step" Hints to Commands
- **Status:** ✅ Completed (2025-10-14) - Implemented as part of Tier 1 #2
- **Priority:** P1
- **Impact:** Clear workflow guidance
- **Effort:** 0 minutes (already included in Progress Logging sections)
- **Files modified:**
  - ✅ `template/.claude/commands/project/init.md` (line 62-63)
  - ✅ `template/.claude/commands/project/plan.md` (line 58-59)
  - ✅ `template/.claude/commands/project/build.md` (line 86-87)
  - ✅ `template/.claude/commands/project/review.md` (line 98-99)
- **Implementation notes:**
  - Hints embedded in Progress Logging "After logging" sections
  - Format: `✓ Done! [Context message]\nRun '/project:next' to continue`
  - Consistent across all commands
  - Build and review have conditional hints (success/failure, pass/fail)
- **Validation:** ✅ All commands guide users to /project:next after completion

#### [x] 4. Add PROGRESS.md Template
- **Status:** ✅ Completed (2025-10-14) - Implemented as part of Tier 1 #2
- **Priority:** P1
- **Impact:** Sets expectations for progress tracking
- **Effort:** 0 minutes (created as part of PROGRESS.md feature)
- **Files created:**
  - ✅ `template/templates/PROGRESS.md` (with 6 comprehensive example entries)
- **Content:** Header explaining purpose, 6 example entries showing success/failure patterns
- **Validation:** ✅ Format is clear with realistic examples for all command types

---

### TIER 2: Optional Power Features (Maintain Simplicity)

#### [x] 5. Optional Test Generation in `/project:plan`
- **Status:** ✅ Completed (2025-10-14)
- **Priority:** P2
- **Impact:** Enables TDD for power users without forcing it
- **Effort:** ~3 hours (actual: 3 hours)
- **Research alignment:** "Selective Test-First Anchors" (Vibe Coding paper, lines 51-96)
- **Files modified:**
  - ✅ `template/.claude/agents/task-decomposer.md` (added 47-line TDD section with guidelines)
  - ✅ `template/.claude/commands/project/plan.md` (added 63-line TDD opt-in flow)
- **Files created:**
  - ✅ `template/templates/precode-test-stub.md` (236 lines - comprehensive guide with Python/JS/Go examples)
- **Implementation details:**
  - **Opt-in prompt** after PLAN.md approval: `Generate precode test stubs from ACCEPTANCE.md? [y/N]`
  - **Default: N** (pure vibe mode - no tests generated)
  - **If yes**:
    - Reads ACCEPTANCE.md to identify 1-3 core behaviors
    - Detects language from SPEC.md (Python/JS/Go/Rust/etc.)
    - Creates `tests/precode/` directory
    - Generates 1-3 minimal test files with intentionally failing assertions
    - Adds Task 0 to PLAN.md: "Verify Precode Tests" (confirms they fail before implementation)
  - **Test characteristics**:
    - Selective (not exhaustive)
    - Minimal (simple assertions, no complex frameworks)
    - Language-aware (pytest, jest, go test, etc.)
    - Intentionally failing (import not-yet-implemented modules)
  - **Template includes**:
    - Purpose and when to use/skip precode tests
    - Python, JavaScript, and Go examples
    - Generation guidelines
    - Validation commands before/after implementation
- **Progress logging**: Updated to show TDD mode with file list when tests generated
- **Validation:** ✅ Power users can enable TDD with single prompt; vibe coders can ignore (default N)

#### [x] 6. Add `/docs:decision` Command
- **Status:** ✅ Completed (2025-10-14)
- **Priority:** P2
- **Impact:** Captures architectural rationale without ceremony
- **Effort:** ~1 hour (actual: 1 hour)
- **Research alignment:** DECISIONS.md pattern (Project Kickoff PDF, page 10)
- **Files created:**
  - ✅ `template/.claude/commands/docs/decision.md` (196 lines - interactive decision logging)
  - ✅ `template/templates/DECISIONS.md` (145 lines - starter template with examples and guidance)
- **Usage:** `claude .claude/commands/docs/decision.md "<Decision Title>"`
- **Implementation details:**
  - **Interactive interview**: Command asks 4 concise questions (Context, Options, Decision, Consequences)
  - **Format follows ADR pattern**:
    ```markdown
    ## YYYY-MM-DD — Decision Title
    **Status:** Finalized | Pending | Revisited | Superseded
    **Context:** Why this matters
    **Options Considered:** What alternatives were evaluated
    **Decision:** What was chosen and why
    **Consequences:** Trade-offs, benefits, follow-ups
    ---
    ```
  - **Status values**: Pending, Finalized, Revisited, Superseded
  - **Append-only**: New entries added to DECISIONS.md (top or bottom based on convention)
  - **Preview before commit**: Shows generated entry for approval
  - **Template includes**:
    - Purpose and when to use/skip
    - 3 complete example entries (architecture, process, product decisions)
    - Entry format template
    - Status definitions table
    - Tips for writing good decision entries
    - Related documentation links
  - **Examples provided**:
    - Architecture: "Use SQLite for Local Development"
    - Process: "Adopt Conventional Commits"
    - Product: "Defer User Authentication to v2.0"
  - **Alignment with ADR best practices**: References https://adr.github.io/
- **Validation:** ✅ Decision-logging is frictionless with interactive prompts and clear examples

#### [x] 7. Add `/docs:scaffold-advanced` Command
- **Status:** ✅ Completed (2025-10-14)
- **Priority:** P3
- **Impact:** Growth path for projects that outgrow simplicity
- **Effort:** ~2 hours (actual: 2 hours)
- **Research alignment:** Full Project Kickoff PDF templates (all pages)
- **Files created:**
  - ✅ `template/.claude/commands/docs/scaffold-advanced.md` (206 lines)
  - ✅ `template/templates/comprehensive/WORKFLOW.md` (230 lines)
  - ✅ `template/templates/comprehensive/ARCHITECTURE.md` (170 lines)
  - ✅ `template/templates/comprehensive/SECURITY.md` (165 lines)
  - ✅ `template/templates/comprehensive/CONTRIBUTING.md` (180 lines)
  - ✅ `template/templates/comprehensive/LICENSE.md` (21 lines)
  - ✅ `template/templates/comprehensive/CODE_OF_CONDUCT.md` (85 lines)
- **Total:** ~1,057 lines of comprehensive open-source documentation
- **Implementation details:**
  - **Opt-in design**: Only runs when explicitly invoked
  - **Checks existing files**: Warns if files exist, offers skip/backup/cancel
  - **Customization prompts**: Project name, maintainer, security email, communication channels
  - **Placeholder replacement**: `{{PROJECT_NAME}}`, `{{MAINTAINER_NAME}}`, `{{SECURITY_EMAIL}}`, `{{YEAR}}`, `{{COMMUNICATION}}`
  - **6 comprehensive templates**:
    - WORKFLOW.md: AI-assisted development process, 9-step cycle, transparency guidelines
    - ARCHITECTURE.md: Project structure, modules, data flow, tech stack, design principles
    - SECURITY.md: Vulnerability reporting, AI code review considerations, threat model
    - CONTRIBUTING.md: How to contribute, testing, PR process, AI transparency
    - LICENSE.md: MIT License with placeholders
    - CODE_OF_CONDUCT.md: Contributor Covenant v2.0 with enforcement ladder
  - **AI transparency**: All docs include sections on AI involvement and review practices
  - **Edge cases**: Validates template directory, warns before overwriting, suggests next steps
- **Validation:** ✅ Entirely optional; templates include proper placeholders for customization

#### [x] 8. Optional `vibe.md` in `/project:init`
- **Status:** ✅ Completed (2025-10-14)
- **Priority:** P3
- **Impact:** Maintains creative alignment across iterations
- **Effort:** ~1 hour (actual: 1 hour)
- **Research alignment:** "Vibe Definition" (Vibe Coding paper, p. 44)
- **Files modified:**
  - ✅ `template/.claude/agents/spec-writer.md` (added 38-line "Optional: Vibe Definition" section)
  - ✅ `template/.claude/commands/project/init.md` (added vibe.md to Goal section + 34-line "Optional: Vibe Definition" section)
- **Files created:**
  - ✅ `template/templates/vibe.md` (117 lines - comprehensive template with examples)
- **Implementation details:**
  - **Opt-in design**: Spec-writer agent offers vibe definition after SPEC.md/ACCEPTANCE.md
  - **Default: Skip** (not needed for most projects)
  - **Prompt format**: "Would you like to define a creative vibe/tone for this project? [Skip/Define]"
  - **If Define**:
    - Spec-writer asks 5 concise questions:
      1. Tone & voice: How should the project feel?
      2. Design philosophy: What principles guide decisions?
      3. Technical constraints: Must-have or must-avoid patterns?
      4. Target audience: Who is this for?
      5. Creative guardrails: What should always/never be done?
    - Generates `.claude/vibe.md` from template
    - Places at `.claude/vibe.md` for agent reference
  - **Template includes**:
    - Purpose and when to use
    - 5 main sections: Tone & Voice, Design Philosophy, Technical Constraints, Target Audience, Creative Guardrails
    - 3 complete example vibes: Minimalist CLI Tool, Playful Web Toy, Enterprise-Grade API
    - "How Agents Use This" guidance section
  - **Agent workflow**:
    - Spec-writer reads vibe.md first to understand project philosophy
    - Aligns implementation with tone and constraints
    - Questions deviations from stated principles
    - Maintains consistency across all code and documentation
- **Validation:** ✅ Entirely optional; vibe can evolve with intentional documentation

---

### TIER 3: Nice-to-Have (Low Priority)

#### [ ] 9. PROMPTS.md Logging
- **Status:** Not started
- **Priority:** P4
- **Impact:** AI transparency for research
- **Effort:** ~2 hours
- **Implementation notes:**
  - Only if `VIBE_LOG_PROMPTS=1` env var set
  - Auto-logs significant AI prompts to PROMPTS.md
  - Format: timestamp, command, prompt, outcome
- **Validation:** Can researchers audit AI involvement?

#### [ ] 10. Onboarding Preference Detection
- **Status:** Not started
- **Priority:** P4
- **Impact:** Personalized experience from start
- **Effort:** ~1 hour
- **Files to modify:**
  - `scripts/vibe_onboarding.py`
- **Implementation notes:**
  - Ask: "Workflow style: Pure Vibe / Balanced / Test-Driven?"
  - Store preference in `.claude/settings.local.json`
  - Commands read and adjust defaults
- **Validation:** Do preferences persist across commands?

---

## What NOT to Implement

Based on GitHub research and complexity analysis:

- ❌ **Plugin system** - Too complex for target users
- ❌ **Event emitters** - File-based architecture is simpler
- ❌ **Sub-command chaining within build** - Over-engineering
- ❌ **Complex agent orchestration framework** - Defeats simplicity goal
- ❌ **Database/state management** - Files are sufficient

---

## Research Findings Summary

### From "Vibe Coding Methodologies" Paper
- **Prompt chaining** (analysis → skeleton → implementation → review) - Already present at workflow level
- **Selective test-first anchors** - Implement as optional in Tier 2 #5
- **Reflective documentation cycles** - Implement via PROGRESS.md (Tier 1 #2)
- **Vibe guidelines file** - Implement as optional in Tier 2 #8

### From "Project Kickoff Documentation" PDF
- **Comprehensive templates** - Implement as optional in Tier 2 #7
- **BUILDPROGRESS.md pattern** - Simplified to PROGRESS.md (Tier 1 #2)
- **DECISIONS.md pattern** - Implement in Tier 2 #6
- **AI transparency** - Partially addressed by PROGRESS.md, fully in Tier 3 #9

### From GitHub Research
- **Ignite (19K stars):** Optional generators, modular commands, CLI framework
- **Generate framework:** Plugin architecture, event-based, task registration
- **Key insight:** Successful scaffolds use file-based modularity (we already have this!)
- **Pattern:** Keep core minimal, make features discoverable not mandatory

### From Sequential Thinking Analysis
- **Layered complexity approach** - Validated by research
- **Router enhancement** - Critical UX improvement (Tier 1 #1)
- **Shared state via files** - Better than complex orchestration (Tier 1 #2)
- **Accordion metaphor** - Perfect for vibe coders (validated)

---

## Implementation Order

**Phase 1: Foundation** ✅ COMPLETE (Week 1)
1. ✅ `/project:next` command (Tier 1 #1)
2. ✅ PROGRESS.md auto-generation (Tier 1 #2)
3. ✅ "Next step" hints (Tier 1 #3) - completed as part of #2
4. ✅ PROGRESS.md template (Tier 1 #4) - completed as part of #2

**Phase 2: Power Features** (Week 2-3)
5. Optional test generation (Tier 2 #5)
6. `/docs:decision` command (Tier 2 #6)

**Phase 3: Advanced** (Week 4+)
7. `/docs:scaffold-advanced` (Tier 2 #7)
8. Optional vibe.md (Tier 2 #8)

**Phase 4: Polish** (As needed)
9. PROMPTS.md logging (Tier 3 #9)
10. Onboarding preferences (Tier 3 #10)

---

## Success Metrics

**Simplicity Validation:**
- [x] Can a new user complete a project with ONLY `/project:init` + `/project:next`? - YES (Tier 1 complete)
- [x] Do advanced features stay invisible unless explicitly sought? - YES (Tier 2+ are optional)
- [x] Is default behavior unchanged for existing users? - YES (only additions, no breaking changes)

**Value Validation:**
- [x] Do agents reference prior context appropriately? - YES (PROGRESS.md provides context)
- [x] Does workflow feel guided without being restrictive? - YES (next step hints + autopilot)
- [ ] Can power users enable advanced features easily? - PENDING (Tier 2 implementation)

**Foolproof Validation:**
- [x] Can someone with zero CLI experience use this? - YES (autopilot removes decision making)
- [x] Does running `/project:next` always give clear guidance? - YES (6 state heuristics + emoji output)
- [x] Are error messages actionable? - YES (progress logging includes failure handling)

---

## Session Resume Context

**Last Working Directory:** `/home/mang/Gits/vibe-code-bootstrap`

**Key Files Reference:**
- Commands: `template/.claude/commands/project/*.md`
- Agents: `template/.claude/agents/*.md`
- Templates: `template/templates/*.md`
- Scripts: `scripts/*.py`
- Bootstrap: `vibe_bootstrap.sh`

**MCP Tools Available:**
- `sequential-thinking` - Deep analysis
- `octocode` - GitHub research
- `memory` - Context storage
- `filesystem` - File operations

**Next Session Start Point:**
1. Review this roadmap
2. Confirm which tier to implement
3. Begin with `/project:next` command (highest priority)

---

## Notes & Observations

- Current architecture is fundamentally sound
- File-based modularity matches industry patterns
- Key opportunity: Reduce cognitive load via autopilot (/project:next)
- Critical insight: Don't force complexity on vibe coders
- Design validation: "Accordion" approach is exactly right
- Research validates: Keep defaults ultra-simple, make growth opt-in

**Last Updated:** 2025-10-14
**Status:** Tier 1 (Foundation) complete, ready for Tier 2
**Next Action:** Implement Tier 2 enhancements (optional power features)
