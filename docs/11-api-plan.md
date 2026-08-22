# Knowledge Dynamics — API Plan

## API Version
`/api/v1/`

## Authentication
- Laravel Sanctum (token-based for mobile apps)
- API tokens issued via login endpoint
- CSRF protection for SPA (cookie-based)

## Public Endpoints (no auth required)

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/v1/journals` | List all active journals |
| GET | `/api/v1/journals/{slug}` | Journal details |
| GET | `/api/v1/journals/{slug}/issues` | Journal issues |
| GET | `/api/v1/journals/{slug}/editorial-board` | Editorial board |
| GET | `/api/v1/articles` | List published articles (paginated) |
| GET | `/api/v1/articles/{slug}` | Article details with authors, keywords |
| GET | `/api/v1/articles/{slug}/references` | Article references |
| GET | `/api/v1/researchers` | List public researchers |
| GET | `/api/v1/researchers/{username}` | Researcher profile |
| GET | `/api/v1/projects` | List public projects |
| GET | `/api/v1/projects/{slug}` | Project details |
| GET | `/api/v1/search` | Global search |
| GET | `/api/v1/keywords` | Popular keywords |

## Authenticated Endpoints

| Method | Endpoint | Description | Role |
|---|---|---|---|
| POST | `/api/v1/auth/login` | Login | Any |
| POST | `/api/v1/auth/register` | Register | Any |
| POST | `/api/v1/auth/logout` | Logout | Any |
| GET | `/api/v1/me` | Current user profile | Any |
| PATCH | `/api/v1/me` | Update profile | Any |
| GET | `/api/v1/me/manuscripts` | My submissions | Author |
| POST | `/api/v1/manuscripts` | Create submission | Author |
| GET | `/api/v1/me/reviews` | My review assignments | Reviewer |
| GET | `/api/v1/me/notifications` | My notifications | Any |

## Rate Limiting
- Public: 60 requests/minute
- Authenticated: 120 requests/minute
- Search: 30 requests/minute

## Response Format
```json
{
  "data": { ... },
  "meta": {
    "current_page": 1,
    "per_page": 15,
    "total": 189
  }
}
```

## Error Format
```json
{
  "message": "Resource not found",
  "errors": {}
}
```
