# Security Policy

Security is taken seriously in {{PROJECT_NAME}}. This document outlines how to report vulnerabilities and our security practices.

## Reporting Vulnerabilities

If you discover a security vulnerability, please report it privately:

**Contact**: {{SECURITY_EMAIL}}

**Subject**: `Security Vulnerability in {{PROJECT_NAME}}`

**Include**:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if you have one)

**Do NOT**:
- Open a public GitHub issue for security concerns
- Disclose the vulnerability publicly before we've had time to address it

We follow **responsible disclosure**:
1. We'll acknowledge your report within 48 hours
2. We'll investigate and provide an initial assessment within 1 week
3. We'll work on a fix and keep you updated
4. We'll coordinate disclosure timing with you
5. We'll credit you in release notes (if desired)

## Security Practices

### Data Protection

**Data Storage**:
- Passwords are hashed using industry-standard algorithms (never plaintext)
- Sensitive data is encrypted at rest
- User data is minimized (collect only what's necessary)

**Data in Transit**:
- All API calls require HTTPS
- No sensitive data in URL parameters or logs

### Access Control

**Code Access**:
- Only maintainers have direct commit access
- All external contributions go through PR review
- Two-factor authentication required for maintainers

**Dependency Security**:
- We monitor dependencies for known vulnerabilities
- Critical security updates are prioritized
- Automated dependency scanning via [Dependabot/Snyk/etc.]

**Secret Management**:
- No secrets or credentials in repository
- Use environment variables or secrets manager
- `.env` files are gitignored
- Development docs explain how to set up secrets locally

### Input Validation

- All user inputs are validated and sanitized
- SQL injection prevention (parameterized queries)
- XSS prevention (output encoding)
- CSRF protection on state-changing operations

### AI-Generated Code Security

Since we use AI assistance in development:

**AI Code Review**:
- All AI-generated code undergoes human security review
- Extra scrutiny for authentication, authorization, and data handling
- Static analysis tools run on all code

**Known Risks**:
- AI might suggest outdated or insecure patterns
- AI lacks context on specific security requirements
- Humans are responsible for catching security issues

**Mitigation**:
- Security-sensitive code always reviewed by experienced developers
- We run security linters and scanners
- We follow security best practices documented here

### Security Testing

- **Static analysis**: Automated security scanning on PRs
- **Dependency scanning**: Check for vulnerable dependencies
- **Manual review**: Security-sensitive changes get manual review
- **Penetration testing**: [If applicable] performed annually

## Security Best Practices for Contributors

If you're contributing code, please:

1. **Validate inputs**: Never trust user input
2. **Use secure defaults**: Fail secure, not open
3. **Avoid hardcoding secrets**: Use environment variables
4. **Follow least privilege**: Only grant necessary permissions
5. **Keep dependencies updated**: Review security advisories
6. **Document security decisions**: Add notes for security-critical code

## Known Security Considerations

*Be transparent about security limitations or considerations:*

- [e.g., "Authentication currently uses session tokens; JWT implementation planned for v2"]
- [e.g., "Rate limiting not yet implemented; API is vulnerable to abuse"]
- [e.g., "Database encryption at rest requires manual configuration"]

We're working to address these (see DECISIONS.md for context).

## Security Updates

Security fixes are released as soon as possible:

- **Critical**: Released within 24-48 hours
- **High**: Released within 1 week
- **Medium**: Released in next scheduled release
- **Low**: Included in next minor version

Subscribe to releases on GitHub to get notified.

## Compliance

*If applicable, note compliance requirements:*

- [e.g., "GDPR: User data handling follows GDPR requirements"]
- [e.g., "SOC 2: Audit logs for all data access"]
- [e.g., "HIPAA: PHI data is encrypted and access is logged"]

## Security Checklist for New Features

When adding features, consider:

- [ ] Input validation and sanitization
- [ ] Output encoding to prevent XSS
- [ ] Authentication and authorization checks
- [ ] Secure data storage (encryption if sensitive)
- [ ] Audit logging for security-relevant actions
- [ ] Rate limiting for API endpoints
- [ ] CSRF protection for state-changing operations
- [ ] Dependencies vetted for vulnerabilities
- [ ] Security testing performed
- [ ] Documentation updated with security notes

## Threat Model

*Document potential threats and mitigations:*

### Threat: Unauthorized Access
- **Risk**: Attackers gain access to user accounts
- **Mitigation**: Strong password requirements, rate limiting on login, 2FA option

### Threat: Data Breach
- **Risk**: User data exposed through vulnerability
- **Mitigation**: Encryption at rest, regular security audits, minimal data collection

### Threat: Supply Chain Attack
- **Risk**: Malicious dependency introduced
- **Mitigation**: Dependency scanning, lock files, review dependency changes

*Add threats specific to your application.*

## Security Resources

- OWASP Top 10: https://owasp.org/www-project-top-ten/
- CWE Top 25: https://cwe.mitre.org/top25/
- Security best practices: [Link to relevant guides]

## Contact

For security concerns: {{SECURITY_EMAIL}}

For general questions: See README.md for maintainer contacts

---

*Last updated: {{YEAR}}*
*Review and update this document annually or after security incidents.*
