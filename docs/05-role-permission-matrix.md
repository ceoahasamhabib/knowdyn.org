# Knowledge Dynamics — Role & Permission Matrix

## Roles (12)

| # | Role | Description |
|---|---|---|
| 1 | super-admin | Full platform access, bypasses all authorization via Gate::before |
| 2 | admin | Platform-wide administration, has all permissions |
| 3 | journal-manager | Manages specific journals end-to-end |
| 4 | editor-in-chief | Top editorial role for a journal |
| 5 | section-editor | Handles assigned manuscripts within a section |
| 6 | reviewer | Performs peer review on assigned manuscripts |
| 7 | author | Submits manuscripts, manages own profile/projects |
| 8 | researcher | Public researcher profile, projects (no submission) |
| 9 | reader | Authenticated user with basic read access |
| 10 | proofreader | Handles service requests (KD Proofreading) |
| 11 | copyeditor | Copyediting stage in production workflow |
| 12 | layout-editor | Layout and formatting in production workflow |

## Permissions (27)

| Permission | super-admin | admin | journal-mgr | editor-in-chief | section-editor | reviewer | author | researcher | reader | proofreader | copyeditor | layout-editor |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| manage users | ✓ | ✓ | | | | | | | | | | |
| view users | ✓ | ✓ | | | | | | | | | | |
| manage journals | ✓ | ✓ | ✓ | | | | | | | | | |
| view journals | ✓ | ✓ | ✓ | ✓ | ✓ | | | | ✓ | | | |
| manage articles | ✓ | ✓ | ✓ | ✓ | | | | | | | | |
| view articles | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | | | |
| publish articles | ✓ | ✓ | ✓ | ✓ | | | | | | | | |
| submit manuscripts | ✓ | ✓ | | | | | ✓ | | | | | |
| screen manuscripts | ✓ | ✓ | ✓ | ✓ | | | | | | | | |
| assign editors | ✓ | ✓ | ✓ | ✓ | | | | | | | | |
| assign reviewers | ✓ | ✓ | ✓ | ✓ | ✓ | | | | | | | |
| make editorial decisions | ✓ | ✓ | ✓ | ✓ | ✓ | | | | | | | |
| view all manuscripts | ✓ | ✓ | ✓ | ✓ | | | | | | | | |
| view assigned manuscripts | ✓ | ✓ | | | ✓ | | | | | | ✓ | ✓ |
| review manuscripts | ✓ | ✓ | | | | ✓ | | | | | | |
| manage projects | ✓ | ✓ | | | | | ✓ | ✓ | | | | |
| view projects | ✓ | ✓ | | | | | ✓ | ✓ | ✓ | | | |
| manage services | ✓ | ✓ | | | | | | | | | | |
| view service requests | ✓ | ✓ | | | | | | | | ✓ | | |
| handle service requests | ✓ | ✓ | | | | | | | | ✓ | | |
| manage pages | ✓ | ✓ | | | | | | | | | | |
| manage settings | ✓ | ✓ | | | | | | | | | | |
| view audit logs | ✓ | ✓ | | | | | | | | | | |
| manage url mappings | ✓ | ✓ | ✓ | | | | | | | | | |
| manage doi records | ✓ | ✓ | | | | | | | | | | |
| manage own profile | ✓ | ✓ | | | | ✓ | ✓ | ✓ | | ✓ | ✓ | ✓ |
| manage researcher profiles | ✓ | ✓ | | | | | | | | | | |

## Role Assignment Logic

- **Registration**: New users get the `reader` role by default
- **Author upgrade**: User gets `author` role when they first submit a manuscript
- **Reviewer**: Assigned by editors when invited to review
- **Editor roles**: Assigned by journal-manager or admin
- **Admin roles**: Assigned by super-admin only
