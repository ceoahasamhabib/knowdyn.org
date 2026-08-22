# Knowledge Dynamics — Live Journal Migration

## Source System
- **Platform**: Open Journal Systems (OJS) 2.4.8.3
- **URL**: https://knowdyn.org/index.php/hd/
- **Journal**: Health Dynamics
- **ISSN**: 3006-5518 (online)
- **Publisher**: Knowledge Dynamics
- **Data range**: January 2024 – present

## Migration Mapping

| OJS Field | New Table.Column | Notes |
|---|---|---|
| Journal Title | journals.title | "Health Dynamics" |
| Journal Description | journals.description | |
| ISSN | journals.issn_online | 3006-5518 |
| Publisher | journals.publisher | Knowledge Dynamics |
| About / Aims & Scope | journal_settings.aims_and_scope | HTML content |
| Peer Review Process | journal_settings.peer_review_process | |
| Publication Frequency | journals.publication_frequency | |
| Open Access Policy | journal_settings.open_access_policy | |
| Archiving Policy | journal_settings.archiving_policy | |
| Plagiarism Policy | journal_settings.plagiarism_policy | |
| Author Guidelines | journal_settings.author_guidelines | |
| Copyright Notice | journal_settings.copyright_notice | |
| Privacy Statement | journal_settings.privacy_statement | |
| Author Fees | journal_settings.author_fees | |
| Journal History | journal_settings.journal_history | |
| Volume Number | volumes.number | |
| Volume Year | volumes.year | |
| Issue Number | issues.number | |
| Issue Publication Date | issues.published_at | |
| Article Title | articles.title | |
| Article Abstract | articles.abstract | |
| Article Keywords | keywords.name + article_keywords | Split on comma/semicolon |
| Article Publication Date | articles.published_at | |
| Article PDF | article_files.file_path | Download and store locally |
| Author Name | article_authors.first_name/last_name | Split name |
| Author Affiliation | article_authors.affiliation | |
| Author Email | article_authors.email | |
| Editorial Team Member | journal_editorial_members.name | |
| Editorial Role | journal_editorial_members.role | |
| Editorial Institution | journal_editorial_members.institution | |
| Contact Email | journals.contact_email | |
| Contact Phone | journals.contact_phone | |

## Migration Phases

### Phase A: Audit (COMPLETED)
- [x] Identified OJS version (2.4.8.3)
- [x] Counted volumes/issues (3 volumes, 34 issues)
- [x] Estimated articles (~189)
- [x] Identified editorial team (16 members)
- [x] Documented journal policies/pages

### Phase B: Data Mapping (THIS DOCUMENT)
- [x] Created field mapping table above

### Phase C: Import Tool
- [ ] Create artisan command `php artisan kd:import-ojs`
- [ ] Parse OJS HTML pages (archive, article, about)
- [ ] Map to Laravel models
- [ ] Handle PDF downloads
- [ ] Handle name splitting
- [ ] Handle keyword parsing

### Phase D: Staging Import
- [ ] Run import against dev database
- [ ] Review imported data quality
- [ ] Fix mapping issues

### Phase E: Verification
- [ ] Compare article counts
- [ ] Verify author names
- [ ] Verify PDF files
- [ ] Check date accuracy
- [ ] Validate keyword assignments

### Phase F: Production Migration
- [ ] Run final import
- [ ] Create URL redirect mappings

### Phase G: URL Redirect Verification
- [ ] Test all old URLs redirect correctly
- [ ] Verify 301 status codes

### Phase H: SEO Verification
- [ ] Generate sitemap
- [ ] Verify canonical tags
- [ ] Test search engine indexing
