# Knowledge Dynamics — Product Architecture

## Overview

Knowledge Dynamics is an academic publishing ecosystem comprising:

1. **Public Website** — Homepage, journal directory, article pages, researcher profiles, project pages, services
2. **Authentication System** — Registration, login, email verification, password reset, OAuth-ready
3. **Researcher Network** — Public profiles, research interests, affiliations, publications, co-authors
4. **Journal Management** — Multi-journal architecture, volumes, issues, editorial boards, policies
5. **Article Publishing** — Scholarly metadata, PDFs, references, keywords, DOI-ready, ORCID-ready
6. **Manuscript Submission** — Multi-step submission workflow, author dashboard, file management
7. **Editorial Workflow** — Editor dashboard, assignment, decisions, revision requests
8. **Peer Review** — Reviewer dashboard, blind review modes, configurable review forms
9. **Research Projects** — Project pages, members, publications, status tracking
10. **Publishing Services** — KD Proofreading, manuscript editing, formatting, consultancy
11. **Admin Panel** — Dashboard, user/role management, CMS, settings, audit logs
12. **SEO & Scholarly Metadata** — Structured data, sitemaps, canonical URLs, Open Graph
13. **Notification System** — Email, in-app, queued processing
14. **API** — `/api/v1/` for future mobile apps and integrations

## Technology Stack

- **Backend**: Laravel 12 (PHP 8.3+)
- **Database**: MariaDB 10.4 (dev) / MySQL 8+ (production)
- **Frontend**: Inertia.js + Vue 3
- **CSS**: Tailwind CSS 4
- **Cache/Queue**: File/Database (dev) → Redis (production)
- **Search**: MySQL FULLTEXT → Meilisearch/Typesense (future)
- **Storage**: Local → S3-compatible (production)

## Architectural Principles

1. **Service Layer**: Business logic in service classes, not controllers
2. **Actions**: Single-responsibility action classes for complex operations
3. **Policies**: Laravel authorization policies for every model
4. **Form Requests**: Validation in dedicated request classes
5. **Events/Listeners**: Decoupled event handling for workflows
6. **Jobs/Queues**: Background processing for emails, heavy operations
7. **Repository Pattern**: Search abstracted behind service layer
8. **API-First Thinking**: Domain logic structured for future API consumption
