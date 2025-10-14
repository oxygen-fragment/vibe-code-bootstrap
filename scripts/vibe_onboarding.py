#!/usr/bin/env python3
"""
vibe-code-bootstrap — Onboarding helper

Guides users through the 4-phase workflow and sanity-checks that the
boilerplate files are present.
"""
import os, sys, textwrap, shutil

def p(s=""): print(s)
def header(t): print("\n" + "="*len(t) + f"\n{t}\n" + "="*len(t))

def exists(path): return os.path.exists(path)

def main():
    header("vibe-code-bootstrap — Onboarding")
    p(textwrap.dedent("""
      This project guides you through a simple, four-phase loop:
        1) /project:init   — capture a tiny MVP spec + acceptance checks
        2) /project:plan   — draft 3–7 micro-tasks (one check each)
        3) /project:build  — implement exactly one task
        4) /project:review — gate it (PASS/FAIL) and decide the next step

      You'll run these as *slash commands* in Claude Code.
      Tip: If a command doesn't delegate to the right sub-agent, run /agents and select it, or paste the command body into that agent.
    """).strip())

    problems = []
    for path in [
        ".claude/agents/spec-writer.md",
        ".claude/agents/task-decomposer.md",
        ".claude/agents/coder.md",
        ".claude/agents/reviewer.md",
        ".claude/commands/project/init.md",
        ".claude/commands/project/plan.md",
        ".claude/commands/project/build.md",
        ".claude/commands/project/review.md",
        ".claude/commands/project/help.md",
        ".claude/commands/project/doctor.md",
        "CLAUDE.md",
    ]:
        if not exists(path): problems.append(path)

    if problems:
        header("Checks")
        p("Some required files are missing:")
        for x in problems: p(f"  - {x}")
        p("Re-run ./vibe_bootstrap.sh or recopy the boilerplate.")
        sys.exit(1)

    header("Ready to begin?")
    p("Open Claude Code in this folder, then paste this command:\n")
    print("/project:init")
    p("\nWhen /project:init finishes, paste:")
    print("/project:plan")
    p("\nThen iterate with:")
    print("/project:build   # implements exactly one task")
    print("/project:review  # PASS/FAIL gate with next action")
    p("\nNeed help at any point? Try:")
    print("/project:help")
    print("/project:doctor")

if __name__ == "__main__":
    main()
