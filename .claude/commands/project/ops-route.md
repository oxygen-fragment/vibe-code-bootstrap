# /ops:route — Pick the next command

Use this when the next step is unclear. The command name is derived from this filename.

**Delegate**
- Sub-agent: **router** (`.claude/agents/router.md`)

**Input**
- A short description of what the user wants to do.

**Procedure**
1. Classify intent using the router’s heuristics.
2. Return a single recommended command + agent with a one-line explanation.

**Output format**
```
Next
command: /project:plan
agent: task-decomposer
why: You asked for a breakdown of tasks.
```

