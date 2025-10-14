# /project:plan — Produce a tiny, linear plan

Delegate all authoring to sub-agent task-decomposer (.claude/agents/task-decomposer.md). If delegation fails, stop and ask me to activate task-decomposer via /agents.

You are acting inside Claude Code via a custom slash command. **Do not run tools unless asked.**

## Goal
Create `PLAN.md` with **3–7 micro-tasks**, each with **exactly one acceptance check** and a clear deliverable.

## Inputs
- `SPEC.md`
- `ACCEPTANCE.md`

## Procedure
1) Read the spec and acceptance criteria. Extract the **smallest path to an MVP**.
2) Draft a strictly ordered list of micro-tasks. Each task must:
   - deliver a user-visible or test-able outcome,
   - have one acceptance check (command, output, or inspection),
   - avoid introducing new dependencies unless essential.
3) Include a short **Complexity Budget** at the top (e.g., “≤ N files changed, ≤ M LOC”).
4) Present the proposed `PLAN.md` content for approval before writing.

## Output
- A preview of `PLAN.md` (code block), then ask: "Approve to write `PLAN.md`?".
- If approved, ask about TDD mode (see below).
- Confirm PLAN.md is written (and tests if applicable).

## Optional: Test-Driven Development Mode

After user approves PLAN.md, **optionally** offer to generate precode test stubs:

### Prompt Format
```
PLAN.md approved.

Optional: Generate precode test stubs from ACCEPTANCE.md? [y/N]

This creates 1-3 minimal failing tests in tests/precode/ as behavioral anchors.
- Default: N (pure vibe mode - skip tests)
- Choose Y for test-driven development approach

Your choice:
```

### If User Chooses N (Default)
- Skip test generation
- Write PLAN.md
- Proceed to Progress Logging

### If User Chooses Y (TDD Mode)
1. **Read ACCEPTANCE.md** to identify 1-3 core acceptance criteria
2. **Detect language** from SPEC.md (Python, JavaScript, Go, Rust, etc.)
3. **Create tests/precode/** directory
4. **Generate test stubs** (1-3 files, one per core criterion)
   - Use examples from `template/templates/precode-test-stub.md`
   - Each test should import not-yet-implemented modules and assert expected behavior
   - Mark with TODO comments that they WILL fail until implementation
5. **Show preview** of generated tests
6. **Write tests** to tests/precode/ directory
7. **Update PLAN.md** to include precode validation step:
   ```markdown
   ## Task 0: Verify Precode Tests
   **Goal:** Confirm test stubs fail before implementation
   **Acceptance:** Run test command and verify expected failures
   **Command:** `[pytest/npm test/go test] tests/precode/`
   ```

### Test Generation Guidelines
- **Selective**: Only 1-3 tests for core behaviors (not exhaustive)
- **Minimal**: Simple assertions, no complex framework setup
- **Language-aware**: Use pytest (Python), jest (JS), go test (Go), etc.
- **Intentionally failing**: Tests MUST fail before implementation

### Example Test Stub (Python)
```python
# tests/precode/test_user_auth.py
"""Precode test: User authentication - WILL FAIL until implementation"""

def test_user_can_authenticate():
    from src.auth import authenticate_user  # Will fail - module doesn't exist yet

    result = authenticate_user("user@example.com", "password123")
    assert result.success is True
    assert result.user_id is not None
```

### After Test Generation
- Confirm to user: "Created N precode test stubs in tests/precode/"
- List files created
- Remind: "These tests WILL fail until you run /project:build. This is expected and correct."

## Progress Logging

After successfully creating PLAN.md, append a progress entry to `PROGRESS.md`:

1. **Check if PROGRESS.md exists** at project root:
   - If missing: Copy from `template/templates/PROGRESS.md` OR create minimal version
   - If exists: Append to existing file

2. **Append this entry format:**

```markdown
### YYYY-MM-DD HH:MM - /project:plan
**Agent:** task-decomposer
**Status:** completed
**Summary:** [Brief summary: number of tasks created]
**Files:** PLAN.md (created)
**Outcome:** [Complexity budget, task count, key milestones]
```

3. **Example entries:**

**Without TDD mode:**
```markdown
### 2025-10-14 14:30 - /project:plan
**Agent:** task-decomposer
**Status:** completed
**Summary:** Broke down MVP into 5 micro-tasks
**Files:** PLAN.md (created)
**Outcome:** Complexity budget: ≤5 files, ≤200 LOC. Tasks ordered: schema → API → tests → docs → deploy
```

**With TDD mode:**
```markdown
### 2025-10-14 14:30 - /project:plan
**Agent:** task-decomposer
**Status:** completed
**Summary:** Broke down MVP into 5 micro-tasks + generated 3 precode test stubs
**Files:** PLAN.md, tests/precode/test_auth.py, tests/precode/test_validation.py, tests/precode/test_api.py (created)
**Outcome:** Complexity budget: ≤5 files, ≤200 LOC. TDD mode: 3 failing tests as behavioral anchors
```

4. **After logging**, inform the user:
```
✓ Done! Plan created and logged to PROGRESS.md
Run '/project:next' to continue
```

## Notes
- Keep tasks shippable after each step.
- Prefer splitting tasks over increasing scope.
- Progress logging is lightweight and appended, never overwrites
