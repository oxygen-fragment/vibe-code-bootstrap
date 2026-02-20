# PLAN: Layman-Friendly Project Customization with Minimal Tokens

## Product Constraint (Non-Negotiable)
- Assume limited technical knowledge by default.
- Commands must be understandable by non-experts.
- Safe defaults must apply when users are unsure or skip choices.

## Planning Constraint (Adaptive Sizing)
- Microtask count must scale with project complexity.
- Do not force all projects into the same fixed 3-7 task range.
- Keep each task atomic, but allow more tasks for larger scope.

## Complexity Budget
- Files changed: <= 10
- New content: <= 240 LOC
- New dependencies: 0
- Token goal: reduce repeated prompt context by using compact project profile data

## Success Criteria
- New users can configure a project via simple choices without knowing technical jargon.
- Generated command/agent behavior adapts to project needs without long repeated instructions.
- `/project:plan` outputs an appropriate number of microtasks for simple, medium, and complex projects.
- Default flow stays simple: run `/project:init` then `/project:next`.

## Adaptive Microtask Policy (Target Behavior)
- Simple projects: 3-7 microtasks
- Medium projects: 8-15 microtasks
- Complex projects: 16-30 microtasks
- If estimated tasks exceed 30, planner should split into phased plans (Phase 1, Phase 2) instead of one oversized plan.

## Micro-Tasks

### Task 1: Define layman-first customization model
**Goal**: Create a compact profile schema that captures project preferences with plain-language options.
**Changes**:
- Add `template/templates/project-profile.yml` with small structured fields.
- Fields use enums/booleans (example: `workflow_mode`, `testing_mode`, `risk_level`, `dependency_policy`, `tone`).
- Include safe defaults for each field.
**Acceptance**: `rg -n "workflow_mode|testing_mode|risk_level|dependency_policy|safe default" template/templates/project-profile.yml` returns matches.

### Task 2: Add beginner-friendly onboarding questions in `/project:init`
**Goal**: Collect 3-5 simple setup choices and write `.claude/project-profile.yml`.
**Changes**:
- Update `template/.claude/commands/project/init.md` with a short multiple-choice onboarding flow.
- Questions avoid jargon and include one-line impact notes.
- Add fallback path: if user skips, write defaults.
**Acceptance**: `rg -n "project-profile.yml|multiple-choice|If user skips|default" template/.claude/commands/project/init.md` returns matches.

### Task 3: Make agents read profile first (minimal context)
**Goal**: Ensure behavior is customized via profile, not long repeated prompt text.
**Changes**:
- Update `template/.claude/agents/spec-writer.md` and `template/.claude/agents/task-decomposer.md` to read `.claude/project-profile.yml` first.
- Add instruction: read only profile + required task files (avoid full-repo scans).
**Acceptance**: `rg -n "project-profile.yml|read only|minimal context" template/.claude/agents/spec-writer.md template/.claude/agents/task-decomposer.md` returns matches.

### Task 4: Implement adaptive microtask sizing in `/project:plan`
**Goal**: Replace fixed microtask count with complexity-based task count guidance.
**Changes**:
- Update `template/.claude/commands/project/plan.md` to require complexity-tier selection (simple/medium/complex).
- Add explicit target microtask ranges by tier.
- Require planner to state why chosen range fits project complexity.
**Acceptance**: `rg -n "simple|medium|complex|3-7|8-15|16-30|phased" template/.claude/commands/project/plan.md` returns matches.

### Task 5: Add adaptive decomposition rubric to task-decomposer agent
**Goal**: Give agent concrete scoring signals so task counts grow with scope.
**Changes**:
- Update `template/.claude/agents/task-decomposer.md` with a lightweight complexity rubric:
  - feature count
  - integration points
  - data model changes
  - risk/unknowns
  - non-functional constraints (security/perf)
- Map rubric outcome to task count range.
**Acceptance**: `rg -n "complexity rubric|integration|risk|task count|range" template/.claude/agents/task-decomposer.md` returns matches.

### Task 6: Add plain-language response format guardrail
**Goal**: Keep outputs easy for non-technical users.
**Changes**:
- Update project command docs (`init`, `plan`, `build`, `review`, `next`) to use a 3-part output:
  - What happened
  - Why it matters
  - What to do next
- Require low-jargon wording by default.
**Acceptance**: `rg -n "What happened|Why it matters|What to do next|plain language|low-jargon" template/.claude/commands/project/*.md` returns matches.

### Task 7: Add README section for customization + adaptive planning + token efficiency
**Goal**: Document how profile-driven customization and adaptive planning work.
**Changes**:
- Add short section to `README.md`:
  - where profile lives (`.claude/project-profile.yml`)
  - when it is created (`/project:init`)
  - how adaptive task sizing works (`/project:plan`)
  - how it reduces token usage (structured defaults + minimal file reads)
**Acceptance**: `rg -n "project-profile.yml|adaptive|microtask|token|minimal context|/project:init|/project:plan" README.md` returns matches.

### Task 8: Validation sweep (consistency and beginner safety)
**Goal**: Confirm docs align on defaults, profile usage, adaptive planning, and plain language.
**Changes**:
- No code changes; verify consistency with grep checks.
- Confirm no contradictory instructions across commands/agents/docs.
**Acceptance**:
```bash
rg -n "project-profile.yml|safe default|default" template/.claude/commands/project/*.md template/.claude/agents/*.md README.md
rg -n "simple|medium|complex|3-7|8-15|16-30|phased" template/.claude/commands/project/plan.md template/.claude/agents/task-decomposer.md README.md
rg -n "What happened|Why it matters|What to do next" template/.claude/commands/project/*.md
```
All commands must return expected coverage without contradictions.

## Dependencies
- None new
- Markdown-only changes for templates, agents, and command docs

## Task Execution Order
Task 1 -> Task 2 -> Task 3 -> Task 4 -> Task 5 -> Task 6 -> Task 7 -> Task 8

## Notes
- Keep customization opt-in by interaction, but default to safe values automatically.
- Prefer compact structured profile fields over long narrative settings.
- Preserve the existing simple command experience for first-time users.
- PROMPTS.md logging remains deferred until this higher-impact usability work is complete.
