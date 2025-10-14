# /docs:scaffold-advanced — Add comprehensive open-source structure

**Usage:** `claude .claude/commands/docs/scaffold-advanced.md`

You are acting inside Claude Code via a custom slash command. This command helps projects **opt into** full open-source documentation structure when they outgrow the minimal scaffold.

## Goal
Create comprehensive project documentation following open-source best practices. This is **entirely optional** - only use when a project is ready to be a full open-source project with external contributors.

## When to Use
Use this command when:
- ✓ Project is ready for external contributors
- ✓ Need formal CONTRIBUTING guidelines
- ✓ Want comprehensive SECURITY and ARCHITECTURE docs
- ✓ Planning to publish as open-source
- ✓ Team is growing beyond 1-2 people

**Skip this if:**
- ✗ Solo project or small team
- ✗ Not accepting external contributions yet
- ✗ Prefer minimal documentation
- ✗ MVP/prototype phase

## What Gets Created

This command will create **6 comprehensive documentation files**:

1. **WORKFLOW.md** - Full AI-assisted development workflow with roles, tools, and collaboration guidelines
2. **ARCHITECTURE.md** - Project structure, module breakdown, data flow diagrams
3. **SECURITY.md** - Security policy, vulnerability reporting, security practices
4. **CONTRIBUTING.md** - Contribution guide with ground rules and PR process
5. **LICENSE.md** - MIT License template (default, can be customized)
6. **CODE_OF_CONDUCT.md** - Community code of conduct

**Note:** These are more comprehensive than the minimal docs created by `/project:init`. They follow open-source best practices and include sections for AI transparency, security reporting, and community management.

## Procedure

### 1. Check Existing Files
First, check if any of these files already exist:
- WORKFLOW.md
- ARCHITECTURE.md
- SECURITY.md
- CONTRIBUTING.md
- LICENSE.md
- CODE_OF_CONDUCT.md

If any exist, warn the user and ask whether to:
- **Skip** existing files (don't overwrite)
- **Backup** and replace (rename existing to `.backup`)
- **Cancel** the operation

### 2. Show Preview
Display a summary of what will be created:

```
📦 Advanced Open-Source Scaffold

This will create 6 comprehensive documentation files:

✓ WORKFLOW.md (AI-assisted development process, ~200 lines)
✓ ARCHITECTURE.md (Project structure and design, ~150 lines)
✓ SECURITY.md (Security policy and practices, ~120 lines)
✓ CONTRIBUTING.md (Contribution guidelines, ~180 lines)
✓ LICENSE.md (MIT License template, ~20 lines)
✓ CODE_OF_CONDUCT.md (Community standards, ~80 lines)

Total: ~750 lines of comprehensive documentation

These files follow open-source best practices and include:
- AI transparency guidelines
- Security vulnerability reporting
- Contribution workflow
- Code review process
- Community standards

Continue? [y/N]
```

### 3. Get Project Details
If user approves, ask for a few key details to customize the templates:

```
I'll customize the templates for your project. Quick questions:

1. Project name: [current directory name]
2. Maintainer name(s): [for LICENSE and contacts]
3. Security contact email: [for vulnerability reports]
4. Communication channels: [Slack/Discord/None]

(Press Enter to use defaults shown in brackets)
```

### 4. Create Files
Copy templates from `template/templates/comprehensive/` to project root:
- Read each template file
- Replace placeholders:
  - `{{PROJECT_NAME}}` → user's project name
  - `{{MAINTAINER_NAME}}` → maintainer name
  - `{{SECURITY_EMAIL}}` → security contact
  - `{{YEAR}}` → current year (for LICENSE)
  - `{{COMMUNICATION}}` → communication channels
- Write to project root

### 5. Confirm Completion
```
✓ Advanced scaffold created successfully!

Created 6 files:
- WORKFLOW.md (202 lines)
- ARCHITECTURE.md (148 lines)
- SECURITY.md (115 lines)
- CONTRIBUTING.md (175 lines)
- LICENSE.md (21 lines)
- CODE_OF_CONDUCT.md (76 lines)

Next steps:
1. Review each file and customize for your project
2. Update ARCHITECTURE.md with your actual structure
3. Add your security contact to SECURITY.md
4. Commit these files: git add *.md && git commit -m "docs: add comprehensive open-source structure"

These files establish your project as a welcoming, professional open-source project. ✨
```

## Template Placeholders

When copying templates, replace these placeholders:

| Placeholder | Replace With | Example |
|-------------|--------------|---------|
| `{{PROJECT_NAME}}` | Project name | "vibe-code-bootstrap" |
| `{{MAINTAINER_NAME}}` | Maintainer name | "John Doe" |
| `{{SECURITY_EMAIL}}` | Security contact | "security@example.com" |
| `{{YEAR}}` | Current year | "2025" |
| `{{COMMUNICATION}}` | Comm channels | "GitHub Discussions" |

## Template Sources

Templates are located in:
```
template/templates/comprehensive/
├── WORKFLOW.md
├── ARCHITECTURE.md
├── SECURITY.md
├── CONTRIBUTING.md
├── LICENSE.md
└── CODE_OF_CONDUCT.md
```

These are comprehensive versions based on:
- Open Source Guides best practices
- Project Kickoff Documentation PDF
- Industry-standard open-source templates

## Edge Cases

**If files already exist:**
- List which files exist
- Offer to skip, backup, or cancel
- Never overwrite without confirmation

**If comprehensive/ templates don't exist:**
- Error message: "Templates not found. Run this command from vibe-bootstrap repository."
- Suggest cloning templates from GitHub

**If minimal docs already exist (SPEC.md, PLAN.md):**
- That's fine - this adds **additional** documentation
- SPEC.md and PLAN.md are for development workflow
- These new files are for **project governance** and **community**

## Customization Notes

After creation, users should customize:
- **ARCHITECTURE.md**: Add actual project structure, diagrams
- **SECURITY.md**: Add specific security considerations for their tech stack
- **WORKFLOW.md**: Adjust for their actual tools and process
- **CONTRIBUTING.md**: Add project-specific coding standards

## Optional Enhancements

If user wants even more structure, suggest:
- **docs/** directory for user guides
- **examples/** directory for usage examples
- **.github/ISSUE_TEMPLATE/** for issue templates
- **.github/PULL_REQUEST_TEMPLATE.md** for PR template
- **CHANGELOG.md** for version history

But don't create these automatically - keep the default conservative.

## Notes
- This command is **opt-in** - never runs automatically
- Created files are templates - encourage customization
- Follows industry best practices from Open Source Guides
- Includes AI transparency sections (aligns with vibe-coding philosophy)
- MIT License is default (permissive, widely used)
- User can change license after creation

---

**Related:** Project Kickoff Documentation PDF, Open Source Guides (https://opensource.guide/)
