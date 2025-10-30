# GitHub Security Setup Checklist

Complete this checklist after pushing this repository to GitHub to ensure all security features are properly configured.

## Pre-Push Checklist

- [x] Security assessment completed (see `SECURITY_ASSESSMENT_REPORT.md`)
- [x] `.gitignore` configured to prevent secret commits
- [x] `SECURITY.md` policy created
- [x] Dependabot configuration added (`.github/dependabot.yml`)
- [x] Security scanning workflow created (`.github/workflows/security.yml`)
- [ ] Final review of all files before initial push

## Initial GitHub Repository Setup

### 1. Repository Settings

Visit: `https://github.com/[username]/[repo]/settings`

- [ ] **Description**: Add a clear repository description
- [ ] **Topics**: Add relevant topics (e.g., `claude-code`, `ai-agents`, `security`, `templates`)
- [ ] **Website**: Add documentation URL if available
- [ ] **Visibility**: Confirm "Public" setting

### 2. Code Security and Analysis Features

**Navigation**: Repository page → **Settings** tab → **Code security and analysis** (in left sidebar under "Security" section)

**Direct URL**: `https://github.com/[username]/[repo]/settings/security_analysis`

**Note**: For public repositories, most features are free. For private repositories, some features require GitHub Advanced Security.

#### Enable These Features

- [ ] **Dependency graph**:
  - Should be automatically enabled for public repos
  - If not enabled, click **Enable**

- [ ] **Dependabot**:
  - **Dependabot alerts**: Click **Enable**
  - **Dependabot security updates**: Click **Enable** (enables automatic PRs for vulnerabilities)

- [ ] **Code scanning**:
  - Click **Set up** dropdown next to "Code scanning"
  - Select **Advanced** (since we have a custom `.github/workflows/security.yml`)
  - Or select **Default** to use GitHub's default CodeQL setup

- [ ] **Secret scanning**:
  - Click **Enable** (critical for public repositories)
  - **Push protection**: Click **Enable** (blocks commits with secrets)

**Important**: Some features may show "Not available" until the repository is public or if you don't have admin access.

### 3. Branch Protection Rules

**Navigation**: Settings tab → Branches (in sidebar under "Code and automation")

**URL**: `https://github.com/[username]/[repo]/settings/branches`

**Steps**: Click "Add rule" next to "Branch protection rules"

Create protection rule for `main` branch:

- [ ] **Branch name pattern**: Enter `main`
- [ ] **Require a pull request before merging**: Enable
  - [x] Require approvals: 1
  - [x] Dismiss stale pull request approvals when new commits are pushed
  - [ ] Require review from Code Owners (optional)
- [ ] **Require status checks to pass before merging**: Enable
  - [x] Require branches to be up to date before merging
  - Search for and add these required checks:
    - `Secret Detection`
    - `Shell Script Security`
    - `Python Security Scan`
    - `Check File Permissions`
    - `Security Summary`
- [ ] **Require conversation resolution before merging**: Enable
- [ ] **Require signed commits**: Enable (recommended)
- [ ] **Include administrators**: Enable (recommended)
- [ ] **Restrict who can push to matching branches**: Enable (optional)

### 4. GitHub Actions Permissions

Visit: `https://github.com/[username]/[repo]/settings/actions`

- [ ] **Actions permissions**: Allow all actions and reusable workflows
- [ ] **Workflow permissions**: Read and write permissions
  - Required for security scanning results
- [ ] **Allow GitHub Actions to create and approve pull requests**: Enable
  - Required for Dependabot

### 5. Security Advisories

Visit: `https://github.com/[username]/[repo]/security/advisories`

- [ ] Review the "Security" tab to confirm policy is visible
- [ ] Verify "Report a vulnerability" button works
- [ ] Set up notification preferences

### 6. Code Scanning Alerts

Visit: `https://github.com/[username]/[repo]/security/code-scanning`

After first workflow run:
- [ ] Review initial CodeQL scan results
- [ ] Dismiss any false positives with explanations
- [ ] Create issues for legitimate findings

### 7. Secret Scanning Alerts

Visit: `https://github.com/[username]/[repo]/security/secret-scanning`

- [ ] Confirm no secrets detected in initial scan
- [ ] Set up notification preferences
- [ ] Test push protection (try committing a fake AWS key locally)

## Post-Setup Verification

### Automated Checks

Run these commands locally to verify configuration:

```bash
# 1. Verify GitHub Actions workflow syntax
cat .github/workflows/security.yml | grep -E "^name:|^on:|jobs:"

# 2. Check Dependabot configuration
cat .github/dependabot.yml | grep -E "package-ecosystem:|schedule:"

# 3. Verify .gitignore includes security patterns
grep -E "\.env|secret|credential|\.pem|\.key" .gitignore

# 4. Test shellcheck locally (if installed)
shellcheck install.sh scripts/*.sh

# 5. Test Python security locally (if bandit installed)
bandit -r scripts/
```

### Manual Verification

- [ ] Push test commit to trigger security workflow
- [ ] Verify all security jobs pass in Actions tab
- [ ] Check that Dependabot PRs appear (may take 24 hours)
- [ ] Test secret push protection:
  ```bash
  # Create a test file with fake secret
  echo "aws_access_key_id=AKIAIOSFODNN7EXAMPLE" > test-secret.txt
  git add test-secret.txt
  git commit -m "test: verify push protection"
  # Should be blocked by push protection
  ```
- [ ] Verify security badge in README (optional)

### Security Badge (Optional)

Add to README.md:

```markdown
[![Security Scan](https://github.com/[username]/[repo]/actions/workflows/security.yml/badge.svg)](https://github.com/[username]/[repo]/actions/workflows/security.yml)
```

## Ongoing Security Maintenance

### Weekly
- [ ] Review Dependabot PRs
- [ ] Check security workflow results
- [ ] Monitor secret scanning alerts

### Monthly
- [ ] Review open security advisories
- [ ] Update security documentation if needed
- [ ] Audit user permissions and access

### Quarterly
- [ ] Review and update `SECURITY.md`
- [ ] Audit branch protection rules
- [ ] Review and improve security workflows
- [ ] Update this checklist based on new GitHub features

## Additional Recommendations

### Documentation
- [ ] Add security badge to README.md
- [ ] Document security features in README.md
- [ ] Link to SECURITY.md from README.md

### Community
- [ ] Add CODE_OF_CONDUCT.md (use GitHub template)
- [ ] Add CONTRIBUTING.md with security guidelines
- [ ] Set up GitHub Discussions for security questions

### Monitoring
- [ ] Enable email notifications for security alerts
- [ ] Join GitHub Security Advisories mailing list
- [ ] Subscribe to Claude Code security announcements

### Advanced (Optional)
- [ ] Set up OSSF Scorecard monitoring
- [ ] Enable GitHub Advanced Security (if available)
- [ ] Configure custom CodeQL queries
- [ ] Set up third-party security scanning (Snyk, etc.)

## Troubleshooting

### Workflow Fails
1. Check Actions tab for error details
2. Verify all required secrets are set
3. Review workflow file syntax
4. Check action versions are current

### Dependabot Not Running
1. Verify settings enabled (24-hour delay normal)
2. Check `.github/dependabot.yml` syntax
3. Review Dependabot logs in Insights → Dependency graph

### Secret Scanning False Positives
1. Review alert details
2. Verify it's actually a false positive
3. Dismiss with clear explanation
4. Consider adding to .gitignore or secret patterns

### CodeQL Issues
1. Ensure languages correctly detected
2. Check for build errors in workflow
3. Review CodeQL configuration
4. Consult CodeQL documentation

## Resources

- [GitHub Security Features](https://docs.github.com/en/code-security)
- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [CodeQL Documentation](https://codeql.github.com/docs/)
- [Secret Scanning](https://docs.github.com/en/code-security/secret-scanning)
- [Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)

## Support

If you encounter issues:
1. Check GitHub Status: https://www.githubstatus.com/
2. Review GitHub Community: https://github.community/
3. Open an issue in this repository
4. Consult the security team

---

**Last Updated**: 2025-10-20
**Next Review**: After initial repository setup

## Completion Status

- [ ] All pre-push items completed
- [ ] Repository created on GitHub
- [ ] All security features enabled
- [ ] Branch protection configured
- [ ] First security workflow run successful
- [ ] Documentation updated
- [ ] Team notified of security setup

**Date Completed**: _______________
**Completed By**: _______________
**Notes**: _______________
