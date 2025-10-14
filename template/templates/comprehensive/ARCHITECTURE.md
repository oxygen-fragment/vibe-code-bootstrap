# {{PROJECT_NAME}} — Architecture

This document describes how the project is organized and how components interact.

## Project Structure

```
{{PROJECT_NAME}}/
│
├── src/                # Source code
├── tests/              # Test suites
├── docs/               # Documentation
├── scripts/            # Utility scripts
├── config/             # Configuration files
├── .claude/            # Claude Code commands and agents
│   ├── commands/       # Slash commands
│   ├── agents/         # Specialized agents
│   └── templates/      # Document templates
│
├── README.md           # Project overview
├── SPEC.md             # Current specification
├── PLAN.md             # Task breakdown
├── PROGRESS.md         # Work log
├── ACCEPTANCE.md       # Success criteria
└── DECISIONS.md        # Decision log
```

*Adapt this structure to match your actual project layout.*

## Module Breakdown

### Core Modules

**Module A**: [Description of what this module does]
- **Purpose**: [Core responsibility]
- **Key files**: [List main files]
- **Dependencies**: [What it depends on]
- **Interfaces**: [How other modules interact with it]

**Module B**: [Description]
- **Purpose**: [Core responsibility]
- **Key files**: [List main files]
- **Dependencies**: [What it depends on]
- **Interfaces**: [How other modules interact with it]

*Add entries for each major module or component in your project.*

### Support Components

**Configuration**: How settings and environment variables are managed
**Logging**: How events and errors are logged
**Testing**: Test framework and structure
**Build/Deploy**: How the project is built and deployed

## Data Flow

*Describe how data moves through your system. Consider adding diagrams:*

1. **User Input** → Validation → Processing → Storage
2. **External API** → Authentication → Data Transform → Response
3. [Add your actual data flow]

### Example Diagram

```
User Request
     ↓
  Router
     ↓
  Controller
     ↓
  Service Layer
     ↓
  Database
```

*Replace with actual architecture. Use ASCII diagrams, Mermaid, or link to image files.*

## Technology Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Language** | [e.g., JavaScript, Python] | Core implementation |
| **Runtime** | [e.g., Node.js, Python 3.9+] | Execution environment |
| **Framework** | [e.g., Express, Flask] | Web framework |
| **Database** | [e.g., PostgreSQL, SQLite] | Data persistence |
| **Testing** | [e.g., Jest, pytest] | Test framework |
| **Build** | [e.g., Webpack, setuptools] | Build tooling |

*Update with your actual stack.*

## Design Principles

### 1. Simplicity First
- Prefer simple solutions over complex ones
- No premature optimization
- Clear, readable code over clever code

### 2. Modularity
- Components have single responsibility
- Clear interfaces between modules
- Easy to test in isolation

### 3. Documentation as Code
- Keep docs in sync with implementation
- Document "why" not just "what"
- Use decision logs for architectural choices

### 4. Security by Design
- Validate all inputs
- Principle of least privilege
- Secure defaults

### 5. AI-Assisted, Human-Led
- AI generates drafts, humans review and refine
- All architectural decisions made by humans
- Transparent about AI involvement

## API Design

*If your project has an API, document it here:*

### Endpoints

```
GET    /api/resource       List resources
POST   /api/resource       Create resource
GET    /api/resource/:id   Get resource
PUT    /api/resource/:id   Update resource
DELETE /api/resource/:id   Delete resource
```

### Authentication
[Describe authentication approach]

### Response Format
```json
{
  "data": {},
  "meta": {},
  "errors": []
}
```

## Database Schema

*Document your database structure:*

### Users Table
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

*Add actual schema for your project.*

## Deployment Architecture

### Development
- Local SQLite database
- No external services required
- Environment: `.env.development`

### Production
- Hosted on [platform]
- Database: [production database]
- Environment: `.env.production`
- CI/CD: [GitHub Actions, etc.]

## Scalability Considerations

*Document how the system scales and known limitations:*

- **Current capacity**: [e.g., "Handles ~100 concurrent users"]
- **Bottlenecks**: [e.g., "Database queries on large datasets"]
- **Future improvements**: [e.g., "Add caching layer, database indexing"]

## Development Phases

### Phase 1: MVP (Current)
- Core functionality
- Basic UI
- Local-only

### Phase 2: Enhancement
- Additional features
- Improved UX
- Performance optimization

### Phase 3: Scale
- Multi-user support
- Cloud deployment
- API for integrations

*Adjust phases to match your roadmap.*

## Testing Strategy

- **Unit tests**: Test individual functions and modules
- **Integration tests**: Test module interactions
- **End-to-end tests**: Test full user workflows
- **Manual testing**: Exploratory testing before release

Target coverage: [e.g., "80% for critical paths"]

## Known Limitations

*Be honest about current limitations:*

- [e.g., "Single-user only in v1.0"]
- [e.g., "No offline support"]
- [e.g., "Limited to 10,000 records"]

These will be addressed in future versions (see DECISIONS.md for rationale).

## Architecture Decision Records

For detailed decision history, see DECISIONS.md. Key architectural decisions:

- [Link to decision: "Why we chose X over Y"]
- [Link to decision: "Database selection rationale"]
- [Link to decision: "Authentication approach"]

## Diagrams

*Add architecture diagrams here or link to them:*

### System Context
[High-level diagram showing system and external dependencies]

### Component Diagram
[Detailed diagram of internal components]

### Deployment Diagram
[How system is deployed across environments]

*Use tools like draw.io, Mermaid, or PlantUML for diagrams.*

## References

- [Link to external API docs]
- [Link to framework documentation]
- [Link to relevant blog posts or papers]

---

*Last updated: {{YEAR}}*
*Update this document as architecture evolves.*
*Keep it in sync with actual codebase structure.*
