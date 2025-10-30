# GitHub Security Setup - Quick Guide

This is a **template/scaffold repository** with bash scripts and markdown files. Here's what actually matters for security.

## What This Repo Is

- Template files for Claude Code CLI workflows
- Bash install script and Python configuration helper
- Documentation and agent prompts (markdown)
- **No runtime code, no dependencies, no deployment**

## Essential Security (5 minutes)

### After Pushing to GitHub

**1. Enable Secret Scanning (2 minutes)**
- Go to: Repository → Settings → Code security and analysis
- Enable: **Secret scanning**
- Enable: **Push protection** (blocks accidental credential commits)

**Why**: Prevents accidentally committing API keys or tokens in examples/docs.

**2. Add Basic .gitignore (1 minute)**
Already done! The root `.gitignore` prevents common mistakes:
- `.env` files
- API keys and credentials
- User-specific config files

**3. Optional: Enable Dependabot (2 minutes)**
- Same location: Settings → Code security and analysis
- Enable: **Dependabot alerts**

**Why**: If you ever add dependencies later, you'll get notified of vulnerabilities.

That's it. You're done.

## Optional Extras (If You Want Them)

### Dependabot Auto-Updates
**What**: Automatically opens PRs to update vulnerable dependencies
**Config**: Already set up in `.github/dependabot.yml`
**To enable**: Settings → Code security and analysis → Dependabot security updates → Enable

### Security Scanning Workflow
**What**: Runs secret detection, shellcheck, and other scans on every push
**Config**: Already set up in `.github/workflows/security.yml`
**To enable**: Just push - it'll run automatically via GitHub Actions

**Note**: The workflow is thorough but might be overkill for a template repo. Feel free to delete `.github/workflows/security.yml` if you don't want it.

### Branch Protection
**What**: Requires PR reviews before merging to main
**When to use**: If you have collaborators
**Setup**: Settings → Branches → Add rule
  - Branch name: `main`
  - Check: "Require pull request before merging"

## What We Already Did

Created these files (feel free to delete what you don't need):
- `SECURITY.md` - How to report vulnerabilities
- `.gitignore` - Prevents committing secrets
- `.github/dependabot.yml` - Dependency update config
- `.github/workflows/security.yml` - Automated security scans
- `.github/SECURITY_SETUP_CHECKLIST.md` - Detailed setup guide

## Realistic Threat Model

**What could go wrong:**
- ✅ Accidentally commit API key in example → Secret scanning catches it
- ✅ Someone copies template with hardcoded credentials → Push protection blocks it
- ⚠️ Malicious install.sh script → Code review, shellcheck helps

**What won't happen:**
- Database breach (there's no database)
- RCE vulnerabilities (no runtime code)
- Dependency exploits (minimal dependencies)

## Too Much Security Theater?

If you think this is overkill, you're probably right. Here's the minimal version:

**Absolute minimum:**
1. Enable secret scanning with push protection
2. Keep the `.gitignore` file
3. Delete everything in `.github/` if you want

**That's it.** The rest is optional.

## FAQ

**Q: Do I need CodeQL scanning?**
A: No, not for a template repo with bash scripts and markdown.

**Q: Do I need branch protection?**
A: Only if you have collaborators or want to enforce PR reviews on yourself.

**Q: Do I need the security workflow?**
A: No, it's nice-to-have. Secret scanning at the GitHub level is enough.

**Q: What about that 5000-line security report?**
A: That was the security agent being thorough. The repo is safe, the report is comprehensive, but you don't need to action everything in it for a template repo.

**Q: Should I delete some of these security files?**
A: Up to you! Keep what makes sense:
  - Keep: `SECURITY.md`, `.gitignore`
  - Optional: `.github/dependabot.yml`
  - Optional: `.github/workflows/security.yml`
  - Can delete: `.github/SECURITY_SETUP_CHECKLIST.md`, other generated reports

## Summary

**Critical**: Secret scanning + push protection
**Useful**: Dependabot alerts, `.gitignore`
**Nice-to-have**: Security workflow, branch protection
**Overkill**: Everything else

You're publishing templates and docs, not deploying infrastructure. Keep it simple.

---

**Last Updated**: 2025-10-20
