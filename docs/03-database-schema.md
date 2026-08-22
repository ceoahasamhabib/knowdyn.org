# Knowledge Dynamics — Database Schema

## Core Tables

### users
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | Auto-increment |
| first_name | varchar(100) | |
| last_name | varchar(100) | |
| username | varchar(50) unique | Reserved routes excluded |
| email | varchar(255) unique | |
| email_verified_at | timestamp nullable | |
| password | varchar(255) | |
| avatar | varchar(500) nullable | |
| phone | varchar(20) nullable | |
| status | enum(active,inactive,suspended) | Default: active |
| remember_token | varchar(100) nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |
| deleted_at | timestamp nullable | Soft delete |

### researcher_profiles
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| user_id | bigint FK unique | users.id |
| biography | text nullable | |
| institution | varchar(500) nullable | |
| department | varchar(255) nullable | |
| country | varchar(100) nullable | |
| city | varchar(100) nullable | |
| orcid | varchar(50) nullable | |
| google_scholar | varchar(500) nullable | |
| linkedin | varchar(500) nullable | |
| website | varchar(500) nullable | |
| research_gate | varchar(500) nullable | |
| expertise | text nullable | |
| is_public | boolean | Default: true |
| created_at | timestamp | |
| updated_at | timestamp | |

### researcher_interests
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| researcher_profile_id | bigint FK | |
| interest | varchar(255) | |

### researcher_affiliations
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| researcher_profile_id | bigint FK | |
| institution | varchar(500) | |
| department | varchar(255) nullable | |
| position | varchar(255) nullable | |
| country | varchar(100) nullable | |
| start_date | date nullable | |
| end_date | date nullable | |
| is_current | boolean | Default: false |

### journals
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| title | varchar(500) | |
| slug | varchar(500) unique | |
| short_title | varchar(100) nullable | |
| description | text nullable | |
| aims_and_scope | text nullable | |
| issn_print | varchar(20) nullable | |
| issn_online | varchar(20) nullable | |
| publisher | varchar(255) | Default: Knowledge Dynamics |
| publication_frequency | varchar(100) nullable | |
| cover_image | varchar(500) nullable | |
| thumbnail | varchar(500) nullable | |
| contact_email | varchar(255) nullable | |
| contact_phone | varchar(50) nullable | |
| website | varchar(500) nullable | |
| status | enum(active,inactive,archived) | Default: active |
| is_open_access | boolean | Default: true |
| established_year | smallint nullable | |
| meta_title | varchar(255) nullable | |
| meta_description | text nullable | |
| sort_order | int | Default: 0 |
| created_at | timestamp | |
| updated_at | timestamp | |
| deleted_at | timestamp nullable | |

### journal_settings
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| journal_id | bigint FK unique | |
| peer_review_process | text nullable | |
| publication_ethics | text nullable | |
| author_guidelines | text nullable | |
| copyright_notice | text nullable | |
| privacy_statement | text nullable | |
| author_fees | text nullable | |
| open_access_policy | text nullable | |
| archiving_policy | text nullable | |
| plagiarism_policy | text nullable | |
| section_policies | text nullable | |
| journal_history | text nullable | |
| review_model | enum(single_blind,double_blind,open) | Default: double_blind |

### journal_editorial_members
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| journal_id | bigint FK | |
| user_id | bigint FK nullable | Link to registered user |
| name | varchar(255) | |
| email | varchar(255) nullable | |
| institution | varchar(500) nullable | |
| country | varchar(100) nullable | |
| role | varchar(100) | e.g., Editor-in-Chief |
| biography | text nullable | |
| orcid | varchar(50) nullable | |
| sort_order | int | Default: 0 |
| is_active | boolean | Default: true |

### volumes
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| journal_id | bigint FK | |
| number | smallint | |
| year | smallint | |
| title | varchar(255) nullable | |
| description | text nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |
| unique(journal_id, number) | | |

### issues
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| volume_id | bigint FK | |
| number | varchar(20) | |
| title | varchar(500) nullable | |
| description | text nullable | |
| cover_image | varchar(500) nullable | |
| published_at | date nullable | |
| is_current | boolean | Default: false |
| status | enum(draft,published) | Default: draft |
| sort_order | int | Default: 0 |
| created_at | timestamp | |
| updated_at | timestamp | |

### articles
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| journal_id | bigint FK | |
| title | varchar(1000) | |
| slug | varchar(1000) unique | |
| abstract | text nullable | |
| article_type | varchar(50) | Default: original-research |
| doi | varchar(255) nullable unique | |
| pages | varchar(50) nullable | e.g., 1-15 |
| submission_date | date nullable | |
| acceptance_date | date nullable | |
| published_at | timestamp nullable | |
| funding | text nullable | |
| conflict_of_interest | text nullable | |
| ethics_statement | text nullable | |
| license | varchar(100) nullable | e.g., CC BY 4.0 |
| citation_info | text nullable | |
| status | enum(draft,published,retracted) | Default: draft |
| view_count | int unsigned | Default: 0 |
| download_count | int unsigned | Default: 0 |
| meta_title | varchar(255) nullable | |
| meta_description | text nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |
| deleted_at | timestamp nullable | |

### article_issue (pivot)
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| article_id | bigint FK | |
| issue_id | bigint FK | |
| sort_order | int | Default: 0 |
| unique(article_id, issue_id) | | |

### article_authors
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| article_id | bigint FK | |
| user_id | bigint FK nullable | Link to registered user |
| first_name | varchar(100) | |
| last_name | varchar(100) | |
| email | varchar(255) nullable | |
| affiliation | varchar(500) nullable | |
| country | varchar(100) nullable | |
| orcid | varchar(50) nullable | |
| is_corresponding | boolean | Default: false |
| sort_order | int | Default: 0 |

### article_keywords
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| article_id | bigint FK | |
| keyword_id | bigint FK | |

### keywords
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| name | varchar(255) unique | |
| slug | varchar(255) unique | |

### article_references
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| article_id | bigint FK | |
| reference_text | text | |
| doi | varchar(255) nullable | |
| sort_order | int | Default: 0 |

### article_files
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| article_id | bigint FK | |
| file_path | varchar(1000) | |
| file_name | varchar(500) | |
| file_type | varchar(50) | e.g., pdf, supplementary |
| file_size | bigint nullable | Bytes |
| is_primary | boolean | Default: false |
| created_at | timestamp | |

### manuscripts
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| journal_id | bigint FK | |
| user_id | bigint FK | Submitting author |
| title | varchar(1000) | |
| abstract | text nullable | |
| article_type | varchar(50) | |
| status | enum(draft,submitted,screening,editor_assigned,under_review,revision_required,resubmitted,accepted,rejected,production,published) | Default: draft |
| editor_id | bigint FK nullable | Assigned editor |
| article_id | bigint FK nullable | Published article link |
| submitted_at | timestamp nullable | |
| decided_at | timestamp nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |
| deleted_at | timestamp nullable | |

### manuscript_authors
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| manuscript_id | bigint FK | |
| first_name | varchar(100) | |
| last_name | varchar(100) | |
| email | varchar(255) nullable | |
| affiliation | varchar(500) nullable | |
| orcid | varchar(50) nullable | |
| is_corresponding | boolean | Default: false |
| sort_order | int | Default: 0 |

### manuscript_files
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| manuscript_id | bigint FK | |
| file_path | varchar(1000) | Private storage |
| file_name | varchar(500) | |
| file_type | varchar(50) | manuscript, cover_letter, supplementary |
| file_size | bigint nullable | |
| version | smallint | Default: 1 |
| created_at | timestamp | |

### manuscript_status_history
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| manuscript_id | bigint FK | |
| user_id | bigint FK nullable | |
| from_status | varchar(50) nullable | |
| to_status | varchar(50) | |
| comment | text nullable | |
| created_at | timestamp | |

### review_assignments
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| manuscript_id | bigint FK | |
| reviewer_id | bigint FK | users.id |
| assigned_by | bigint FK | users.id |
| status | enum(pending,accepted,declined,completed) | Default: pending |
| due_date | date nullable | |
| assigned_at | timestamp | |
| responded_at | timestamp nullable | |
| completed_at | timestamp nullable | |

### reviews
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| review_assignment_id | bigint FK unique | |
| recommendation | enum(accept,minor_revision,major_revision,reject) | |
| comments_to_editor | text nullable | Confidential |
| comments_to_author | text nullable | |
| quality_score | tinyint nullable | 1-10 |
| created_at | timestamp | |
| updated_at | timestamp | |

### projects
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| user_id | bigint FK | Lead researcher |
| title | varchar(500) | |
| slug | varchar(500) unique | |
| summary | text nullable | |
| research_area | varchar(255) nullable | |
| status | enum(planning,active,completed,on_hold) | Default: planning |
| start_date | date nullable | |
| end_date | date nullable | |
| institution | varchar(500) nullable | |
| external_url | varchar(500) nullable | |
| is_public | boolean | Default: true |
| meta_title | varchar(255) nullable | |
| meta_description | text nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |
| deleted_at | timestamp nullable | |

### project_members
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| project_id | bigint FK | |
| user_id | bigint FK | |
| role | varchar(100) nullable | |
| unique(project_id, user_id) | | |

### services
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| title | varchar(255) | |
| slug | varchar(255) unique | |
| description | text nullable | |
| features | json nullable | |
| process | text nullable | |
| faq | json nullable | |
| cta_text | varchar(100) nullable | |
| cta_url | varchar(500) nullable | |
| icon | varchar(100) nullable | |
| is_active | boolean | Default: true |
| sort_order | int | Default: 0 |
| meta_title | varchar(255) nullable | |
| meta_description | text nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |

### service_requests
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| service_id | bigint FK | |
| user_id | bigint FK nullable | |
| name | varchar(255) | |
| email | varchar(255) | |
| phone | varchar(50) nullable | |
| message | text nullable | |
| status | enum(submitted,assigned,in_progress,quality_check,completed,cancelled) | Default: submitted |
| assigned_to | bigint FK nullable | Staff user |
| created_at | timestamp | |
| updated_at | timestamp | |

### pages
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| title | varchar(255) | |
| slug | varchar(255) unique | |
| content | longtext nullable | |
| is_published | boolean | Default: false |
| meta_title | varchar(255) nullable | |
| meta_description | text nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |

### settings
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| group | varchar(100) | |
| key | varchar(100) | |
| value | text nullable | |
| unique(group, key) | | |

### audit_logs
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| user_id | bigint FK nullable | |
| action | varchar(100) | create, update, delete, login, etc. |
| auditable_type | varchar(255) nullable | Polymorphic model |
| auditable_id | bigint nullable | |
| old_values | json nullable | |
| new_values | json nullable | |
| ip_address | varchar(45) nullable | |
| user_agent | text nullable | |
| created_at | timestamp | |

### legacy_url_mappings
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| old_url | varchar(2000) | |
| new_url | varchar(2000) | |
| status_code | smallint | Default: 301 |
| entity_type | varchar(100) nullable | |
| entity_id | bigint nullable | |
| verified_at | timestamp nullable | |
| created_at | timestamp | |

### doi_records
| Column | Type | Notes |
|---|---|---|
| id | bigint PK | |
| doi | varchar(255) unique | |
| doiable_type | varchar(255) | Polymorphic |
| doiable_id | bigint | |
| provider | varchar(50) nullable | e.g., crossref |
| status | enum(pending,registered,failed) | Default: pending |
| registered_at | timestamp nullable | |
| created_at | timestamp | |
| updated_at | timestamp | |
