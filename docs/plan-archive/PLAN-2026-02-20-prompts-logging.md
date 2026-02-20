# PLAN: Optional PROMPTS.md Logging (Tier 3 #9)

## Complexity Budget
- Files changed: <= 7
- New content: <= 120 LOC
- New dependencies: 0
- Feature gate: Must be disabled by default unless `VIBE_LOG_PROMPTS=1`

## Micro-Tasks

### Task 1: Define logging contract and guardrail
**Goal**: Establish one canonical format and enable condition for PROMPTS logging.
**Changes**:
- Add a short "PROMPTS logging contract" section to command docs that emit prompts.
- Define required gate: only log when env var `VIBE_LOG_PROMPTS=1`.
- Define required fields: timestamp, command, prompt summary, outcome.
**Acceptance**: `rg -n "VIBE_LOG_PROMPTS=1|timestamp|prompt summary|outcome" template/.claude/commands/project/*.md` returns matches.

### Task 2: Instrument `/project:init` and `/project:plan`
**Goal**: Add optional PROMPTS append instructions to spec and planning stages.
**Changes**:
- Update `template/.claude/commands/project/init.md`.
- Update `template/.claude/commands/project/plan.md`.
- Include append format examples targeting `PROMPTS.md`.
**Acceptance**: `rg -n "PROMPTS.md|/project:init|/project:plan|VIBE_LOG_PROMPTS" template/.claude/commands/project/{init,plan}.md` returns matches.

### Task 3: Instrument `/project:build` and `/project:review`
**Goal**: Capture implementation/review prompt traces under the same env gate.
**Changes**:
- Update `template/.claude/commands/project/build.md`.
- Update `template/.claude/commands/project/review.md`.
- Ensure logging remains lightweight and does not replace PROGRESS logging.
**Acceptance**: `rg -n "PROMPTS.md|/project:build|/project:review|VIBE_LOG_PROMPTS" template/.claude/commands/project/{build,review}.md` returns matches.

### Task 4: Add optional router logging note for `/project:next`
**Goal**: Keep `/project:next` behavior consistent with env-gated PROMPTS logging.
**Changes**:
- Update `template/.claude/commands/project/next.md` to reference PROMPTS logging only when enabled.
- Clarify default behavior remains no logging.
**Acceptance**: `rg -n "PROMPTS.md|VIBE_LOG_PROMPTS|default" template/.claude/commands/project/next.md` returns matches.

### Task 5: Add user-facing docs and verification snippet
**Goal**: Document how to enable and inspect PROMPTS logging.
**Changes**:
- Update `README.md` with a short "Optional prompt logging" section.
- Include one-line enablement and sample grep check.
**Acceptance**: `rg -n "PROMPTS.md|VIBE_LOG_PROMPTS" README.md` returns matches.

### Task 6: End-to-end dry-run validation
**Goal**: Verify the feature is explicit, opt-in, and non-disruptive.
**Changes**:
- No code changes; run inspection checks only.
- Confirm all command docs mention the same gate and destination file.
**Acceptance**:
```bash
rg -n "VIBE_LOG_PROMPTS=1" template/.claude/commands/project/*.md
rg -n "PROMPTS.md" template/.claude/commands/project/*.md README.md
```
Both commands must show expected coverage without conflicting instructions.

## Dependencies
- None new
- Uses existing markdown command files and README only

## Task Execution Order
Task 1 -> Task 2 -> Task 3 -> Task 4 -> Task 5 -> Task 6

## Notes
- Keep this feature strictly opt-in to preserve the default low-friction workflow.
- Do not add automatic logging outside the explicit environment variable gate.
- Keep wording consistent across all commands to avoid agent ambiguity.
