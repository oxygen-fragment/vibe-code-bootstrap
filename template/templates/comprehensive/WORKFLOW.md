# {{PROJECT_NAME}} — Workflow Guide

This project uses **AI-assisted development** in our workflow. AI accelerates development by generating code, documentation, and ideas, but we integrate it with human oversight to maintain quality and authenticity.

## Roles & Tools

### AI Assistant
**Claude Code** (via CLI) – We use Claude as an AI coding assistant to:
- Brainstorm ideas and generate initial code drafts
- Create documentation and templates
- Assist with repetitive tasks and boilerplate
- Suggest implementations based on specifications

The AI helps improve clarity and speed, but all outputs are reviewed by humans before merging.

### Development Environment
**Your preferred editor** – Human developers use their choice of editor (VSCode, Vim, etc.). AI suggestions can be integrated via Claude Code CLI commands.

### Repository (Git & GitHub)
The source of truth for all code and documentation. We use standard GitHub workflows:
- **Branching**: Feature branches for new work
- **Pull Requests**: All changes reviewed before merging
- **Issues**: Track tasks, bugs, and feature requests
- **Code Review**: Required for all contributions

## Development Cycle

### 1. Define Intent or Feature
Start by clearly defining what you want to achieve:
- Create a GitHub issue describing the feature or fix
- Reference tasks from project documentation (SPEC.md, PLAN.md)
- Provide clear acceptance criteria

### 2. Break Down Tasks
Break the feature into small, independently verifiable tasks:
- Add tasks to PLAN.md or issue tracker
- Each task should be completable in one session
- Define how to verify each task is complete

### 3. AI Generation & Drafting
Leverage Claude Code to generate initial implementations:
```bash
# Example: Generate code for a specific task
claude .claude/commands/project/build.md
```

The AI is prompted with context (existing codebase, task description, acceptance criteria) and produces a draft or suggestions.

**Important**: All AI-generated outputs are considered **drafts**. Treat AI as a junior pair-programmer – it can write boilerplate or suggest solutions, but it does not make final decisions.

### 4. Human Review & Refinement
A human developer reviews the AI's output thoroughly:
- Check logic and correctness
- Fix any errors or insecure patterns
- Ensure solution fits project's architecture and style
- Test the changes (automated tests or manual testing)
- Refactor for clarity if needed

**AI can sometimes introduce errors or insecure patterns if not checked.** The developer must understand everything that goes into the codebase.

### 5. Update Documentation
After implementing a change, update relevant docs **before committing**:
- Update PROGRESS.md with what was done
- Mark tasks complete in PLAN.md or issue tracker
- Update user-facing docs (README, usage guides) if needed

Keeping docs in sync with code is vital to avoid outdated information.

### 6. Commit & Pull Request
Commit changes to a feature branch with a descriptive message:
```bash
git checkout -b feature/add-authentication
git add src/auth.js tests/auth.test.js
git commit -m "feat: add user authentication with password hashing"
git push origin feature/add-authentication
```

Open a Pull Request with:
- Summary of what was done and why
- Link to related issues
- **Highlight any AI involvement** (see AI Transparency section)
- Test results or screenshots if applicable

### 7. Code Review
Team members review the pull request:
- Verify code works and is clear
- Check that documentation and tests are sufficient
- Ensure coding standards are followed
- Request changes if needed

Code review is crucial – even more so with AI-generated code, as reviewers might catch subtle bugs or security issues.

### 8. Merge & Deploy
Once approved and CI checks pass:
- Merge the PR (typically squash commits for clean history)
- CI/CD processes run (tests, builds, deployments)
- Update PROGRESS.md if needed
- Close related issues

### 9. Repeat
Continue with the next task or feature, keeping documentation and issue tracker updated.

## Collaboration Guidelines

### Branching Model
- Use feature branches for new work: `feature/`, `fix/`, `docs/`
- Do not commit directly to `main` branch
- Keep branches short-lived (1-3 days ideally)

### Pull Requests
- All changes go through PR and code review before merging
- Use PR template to ensure consistency
- Include tests and documentation updates
- Disclose AI assistance in PR description

### Issue Tracking
- Use GitHub Issues for bugs, features, and discussions
- Label issues for organization: `bug`, `enhancement`, `good first issue`, `documentation`
- Link PRs to issues for traceability

### Communication
- Use project's communication channels ({{COMMUNICATION}})
- Be respectful and constructive in all interactions
- Follow Code of Conduct (see CODE_OF_CONDUCT.md)

### Testing
- Write tests for new features and bug fixes
- Run tests locally before pushing: `npm test` or equivalent
- Ensure CI tests pass before requesting review

### Commit Messages
- Write clear, descriptive commit messages
- Use conventional commits if project adopts them: `feat:`, `fix:`, `docs:`, etc.
- Credit AI assistance in commit if significant: `Co-authored-by: Claude AI`

## Human Oversight

AI is a powerful assistant but **human oversight is non-negotiable**:

### Critical Decision Making
- All architectural choices are made by humans
- Security decisions require human review and threat modeling
- Product direction and feature prioritization are human-led
- AI can suggest options, but humans make final calls

### Security and Privacy
- Security-sensitive code generated by AI gets extra scrutiny
- Use threat modeling for new features (see SECURITY.md)
- Never commit credentials or secrets
- Validate all inputs and sanitize outputs

### Code Quality
- AI might produce working code that isn't idiomatic
- Humans refactor for clarity, performance, and maintainability
- Long-term codebase health relies on human curation

### Community Interaction
- All community-facing interactions are handled by humans
- AI might help draft responses, but humans moderate and post
- Authentic human engagement builds trust

### Learning and Growth
- Team members should understand everything in the codebase
- If AI suggests something unclear, learn about it before merging
- Use AI as a tool to enhance productivity, not replace learning

## AI Transparency

We believe in transparency about AI involvement:

### In Pull Requests
Include a note if AI helped generate code or docs:
```
This PR adds user authentication.

AI Assistance: Used Claude to generate initial implementation
of password hashing and token generation. Reviewed and modified
for security best practices.
```

### In Commits
Credit AI in commit messages when appropriate:
```
git commit -m "feat: add JWT authentication

Co-authored-by: Claude <noreply@anthropic.com>"
```

### Optional: PROMPTS.md
For complex prompts or multi-step AI interactions, optionally log them in `PROMPTS.md`:
```markdown
## 2025-10-14 - Authentication Implementation

**Prompt**: "Implement JWT-based authentication with password hashing using native Node.js crypto"

**Output**: Generated auth.js with bcrypt usage

**Modifications**: Switched from bcrypt to native crypto.scrypt for zero dependencies

**Outcome**: Authentication working, all tests pass
```

**Note**: Don't include sensitive data in prompts if PROMPTS.md is public.

## Communication Norms

- **Be respectful**: Critique ideas and code, not people
- **Be constructive**: Suggest improvements, don't just point out problems
- **Be patient**: Contributors have different experience levels
- **Be transparent**: Share context and reasoning for decisions
- **Be welcoming**: Help newcomers get started

See CODE_OF_CONDUCT.md for full community standards.

## Tool-Specific Notes

### Using Claude Code
Run commands from project root:
```bash
# Initialize project
claude .claude/commands/project/init.md

# Create task plan
claude .claude/commands/project/plan.md

# Implement next task
claude .claude/commands/project/build.md

# Review changes
claude .claude/commands/project/review.md

# Get next step recommendation
claude .claude/commands/project/next.md
```

### Git Best Practices
```bash
# Create feature branch
git checkout -b feature/your-feature

# Make changes, test locally

# Stage and commit
git add changed-files
git commit -m "type: descriptive message"

# Push and create PR
git push -u origin feature/your-feature
# Then open PR on GitHub
```

## Getting Help

- **Documentation**: Check README.md, ARCHITECTURE.md, and other docs
- **Issues**: Search existing issues or open a new one
- **Discussions**: Use GitHub Discussions for questions
- **Contact**: Reach out to maintainers (see README contacts)

## References

- Open Source Guides: https://opensource.guide/
- Conventional Commits: https://www.conventionalcommits.org/
- GitHub Flow: https://docs.github.com/en/get-started/quickstart/github-flow
- AI in Open Source: Ethical considerations and transparency practices

---

*Last updated: {{YEAR}}*
*Treat this as a living document – update as the project evolves*
