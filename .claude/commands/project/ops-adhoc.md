# /ops:adhoc — One-off micro-task

Use this for small, ad-hoc changes not covered by the main workflow.

**Delegate**
- Sub-agent: **coder** (default)
- Optionally escalate to **reviewer** if verification is requested.

**Goal**
Perform a single, minimal change while respecting simplicity.

**Input**
- A short description of the desired change.

**Procedure**
1. Restate the task and acceptance in one line.
2. Propose the smallest possible change (file + lines). Ask for approval.
3. Apply the change. Show evidence (output or snippet).
4. Suggest review if appropriate.

**Notes**
- No new dependencies unless explicitly approved.
- Keep changes tiny and reversible.

