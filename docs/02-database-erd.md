# Knowledge Dynamics — Database ERD

```mermaid
erDiagram
    users ||--o| researcher_profiles : "has"
    users ||--o{ manuscripts : "submits"
    users ||--o{ projects : "leads"
    users ||--o{ review_assignments : "reviews"
    users ||--o{ audit_logs : "generates"

    researcher_profiles ||--o{ researcher_interests : "has"
    researcher_profiles ||--o{ researcher_affiliations : "has"

    journals ||--|| journal_settings : "has"
    journals ||--o{ journal_editorial_members : "has"
    journals ||--o{ volumes : "contains"
    journals ||--o{ articles : "publishes"
    journals ||--o{ manuscripts : "receives"

    volumes ||--o{ issues : "contains"

    issues }o--o{ articles : "article_issue"

    articles ||--o{ article_authors : "has"
    articles }o--o{ keywords : "article_keywords"
    articles ||--o{ article_references : "has"
    articles ||--o{ article_files : "has"

    manuscripts ||--o{ manuscript_authors : "has"
    manuscripts ||--o{ manuscript_files : "has"
    manuscripts ||--o{ manuscript_status_history : "tracks"
    manuscripts ||--o{ review_assignments : "has"

    review_assignments ||--o| reviews : "produces"

    projects }o--o{ users : "project_members"

    services ||--o{ service_requests : "receives"
```

## Entity Groups

### Public Content
- journals → volumes → issues → articles
- articles ↔ keywords, article_authors, article_files, article_references

### Researcher Network
- users → researcher_profiles → interests, affiliations
- users → projects → project_members

### Manuscript Workflow
- manuscripts → manuscript_authors, manuscript_files
- manuscripts → manuscript_status_history
- manuscripts → review_assignments → reviews

### Services
- services → service_requests

### System
- settings, pages, audit_logs, legacy_url_mappings, doi_records
