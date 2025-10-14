# Project Vibe

**Purpose:** This file captures the creative direction, tone, and stylistic constraints for this project. It helps maintain consistency across iterations and guides AI agents on how to approach implementation.

**When to use:** Define a vibe when your project has specific aesthetic, tonal, or philosophical constraints that should persist throughout development.

---

## Tone & Voice

**Overall feeling:** [e.g., Professional but approachable / Playful and experimental / Minimalist and zen]

**Communication style:** [e.g., Clear and concise / Verbose and explanatory / Technical and precise]

**Examples:**
- Good: [Example of desired tone]
- Avoid: [Example of what doesn't fit]

---

## Design Philosophy

**Core principles:**
- [e.g., Simplicity over features]
- [e.g., User experience first]
- [e.g., Progressive disclosure of complexity]

**Style preferences:**
- [e.g., Minimal UI, clean lines]
- [e.g., Colorful and expressive]
- [e.g., Terminal-first, no GUI]

---

## Technical Constraints

**Must have:**
- [e.g., Zero dependencies]
- [e.g., Works offline]
- [e.g., Pure vanilla JavaScript]

**Must avoid:**
- [e.g., No frameworks]
- [e.g., No build step]
- [e.g., No databases]

---

## Target Audience

**Primary users:** [e.g., Solo developers / Enterprise teams / Students]

**Skill level:** [e.g., Beginner-friendly / Assumes CLI familiarity / Expert-level]

**Use cases:** [e.g., Side projects / Production systems / Learning tool]

---

## Creative Guardrails

**Always:**
- [e.g., Ask before adding complexity]
- [e.g., Prefer composition over inheritance]
- [e.g., Write comments that explain "why"]

**Never:**
- [e.g., Sacrifice simplicity for cleverness]
- [e.g., Add features not in SPEC.md]
- [e.g., Use deprecated APIs]

---

## Example Vibe Definitions

### Example 1: Minimalist CLI Tool
```markdown
**Tone:** Unix philosophy - do one thing well
**Philosophy:** Composability, small footprint, plain text
**Constraints:** Pure Bash, no dependencies, < 200 lines
**Audience:** DevOps engineers, automation scripters
**Guardrails:** Never add GUI, keep under 1MB, POSIX-compliant
```

### Example 2: Playful Web Toy
```markdown
**Tone:** Whimsical, experimental, delightful interactions
**Philosophy:** Joy over utility, animations matter, no login walls
**Constraints:** Browser-only, no backend, works on mobile
**Audience:** Creative coders, generative artists, tinkerers
**Guardrails:** Always include Easter eggs, prioritize fun over speed
```

### Example 3: Enterprise-Grade API
```markdown
**Tone:** Professional, reliable, well-documented
**Philosophy:** Stability over novelty, backward compatibility
**Constraints:** TypeScript, comprehensive tests, semantic versioning
**Audience:** Enterprise developers, integration partners
**Guardrails:** Never break APIs, maintain 95%+ test coverage, changelog required
```

---

## How Agents Use This

When implementing features, agents should:
1. **Read vibe.md first** to understand project philosophy
2. **Align implementation** with tone and constraints
3. **Question deviations** from stated principles
4. **Maintain consistency** across all code and documentation

If a feature request conflicts with the vibe, flag it for discussion before implementing.

---

**Remember:** The vibe is a guide, not a prison. It can evolve, but changes should be intentional and documented.
