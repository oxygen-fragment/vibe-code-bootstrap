# Precode Test Stub Template

*Minimal failing tests as behavioral anchors — not exhaustive test suites*

## Purpose

Precode tests are **selective anchors** that specify core behavioral expectations before implementation. They:
- Capture 1-3 critical behaviors from ACCEPTANCE.md
- Intentionally **fail** until implementation is complete
- Are **minimal** (not exhaustive test coverage)
- Guide implementation without constraining creativity

## When to Use

Use precode tests for:
- ✓ API boundaries with specific input/output contracts
- ✓ Core logic with non-obvious edge cases
- ✓ Data transformations with clear before/after states
- ✓ Security or validation rules that must be enforced

**Skip precode tests for:**
- ✗ Simple CRUD operations
- ✗ UI layout or visual design (use mockups instead)
- ✗ Exploratory features where behavior is uncertain

## Structure

```
tests/precode/
├── test_acceptance_1.{ext}  # First acceptance criterion
├── test_acceptance_2.{ext}  # Second acceptance criterion
└── test_acceptance_3.{ext}  # Third acceptance criterion (if applicable)
```

**Language-specific extensions:**
- Python: `.py`
- JavaScript/TypeScript: `.js` or `.test.js`
- Go: `_test.go`
- Rust: `.rs` (in `tests/` dir)

## Template Examples

### Python (pytest style)
```python
# tests/precode/test_user_authentication.py
"""
Precode test: User authentication with password hash
Acceptance: Users can authenticate with email and password

This test SHOULD FAIL until implementation is complete.
"""

def test_user_can_authenticate_with_valid_credentials():
    # TODO: This will fail until auth.py is implemented
    from src.auth import authenticate_user

    result = authenticate_user(
        email="user@example.com",
        password="secure_password123"
    )

    assert result.success is True
    assert result.user_id is not None
    assert result.session_token is not None

def test_user_cannot_authenticate_with_invalid_password():
    from src.auth import authenticate_user

    result = authenticate_user(
        email="user@example.com",
        password="wrong_password"
    )

    assert result.success is False
    assert result.error == "Invalid credentials"
```

### JavaScript (Node.js / Jest style)
```javascript
// tests/precode/test_user_authentication.test.js
/**
 * Precode test: User authentication with password hash
 * Acceptance: Users can authenticate with email and password
 *
 * This test SHOULD FAIL until implementation is complete.
 */

const { authenticateUser } = require('../src/auth');

describe('User Authentication', () => {
  test('user can authenticate with valid credentials', () => {
    // TODO: This will fail until auth.js is implemented
    const result = authenticateUser({
      email: 'user@example.com',
      password: 'secure_password123'
    });

    expect(result.success).toBe(true);
    expect(result.userId).toBeDefined();
    expect(result.sessionToken).toBeDefined();
  });

  test('user cannot authenticate with invalid password', () => {
    const result = authenticateUser({
      email: 'user@example.com',
      password: 'wrong_password'
    });

    expect(result.success).toBe(false);
    expect(result.error).toBe('Invalid credentials');
  });
});
```

### Go (testing package)
```go
// tests/precode/user_authentication_test.go
/*
Precode test: User authentication with password hash
Acceptance: Users can authenticate with email and password

This test SHOULD FAIL until implementation is complete.
*/

package precode

import (
    "testing"
    "myproject/auth"
)

func TestUserCanAuthenticateWithValidCredentials(t *testing.T) {
    // TODO: This will fail until auth package is implemented
    result := auth.AuthenticateUser(
        "user@example.com",
        "secure_password123",
    )

    if !result.Success {
        t.Error("Expected authentication to succeed")
    }
    if result.UserID == "" {
        t.Error("Expected user ID to be set")
    }
    if result.SessionToken == "" {
        t.Error("Expected session token to be set")
    }
}

func TestUserCannotAuthenticateWithInvalidPassword(t *testing.T) {
    result := auth.AuthenticateUser(
        "user@example.com",
        "wrong_password",
    )

    if result.Success {
        t.Error("Expected authentication to fail")
    }
    if result.Error != "Invalid credentials" {
        t.Errorf("Expected error 'Invalid credentials', got '%s'", result.Error)
    }
}
```

## Generation Guidelines

When generating precode tests from ACCEPTANCE.md:

1. **Read acceptance criteria** - Extract 1-3 core behaviors
2. **Identify language** - Check SPEC.md for runtime/language hints
3. **Create minimal stubs** - One file per criterion, 1-2 test cases each
4. **Use TODO comments** - Mark that tests WILL fail until implementation
5. **Specify exact expectations** - Clear assertions on inputs/outputs
6. **Keep it simple** - No complex setup, mocking, or test frameworks unless essential

## Validation Before Implementation

Before running `/project:build`, verify precode tests:

```bash
# Python
pytest tests/precode/  # Should fail with import or assertion errors

# JavaScript
npm test tests/precode/  # Should fail with module not found or assertion errors

# Go
go test ./tests/precode/...  # Should fail with import or assertion errors
```

**Expected outcome:** Tests should fail cleanly with:
- Import/module errors (implementation doesn't exist yet)
- Assertion failures (behavior not implemented)

**Do NOT proceed** if tests pass before implementation - they're not anchoring anything!

## After Implementation

Once tasks are implemented, rerun precode tests:

```bash
# They should now PASS
pytest tests/precode/  # All tests pass
npm test tests/precode/  # All tests pass
go test ./tests/precode/...  # PASS
```

This confirms that implementation satisfies the behavioral anchors.

## Notes

- Precode tests are NOT a replacement for comprehensive test suites
- They are minimal anchors to guide initial implementation
- After MVP, write full test coverage separately
- Keep precode tests simple - avoid complex frameworks or dependencies
- If a test is hard to write, the acceptance criterion may be ambiguous

---

**Related:** See "Empirical and Practical Methodologies for Vibe Coding.md" (§3: Selective Test-First Anchors)
