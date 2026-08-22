# Knowledge Dynamics — URL Redirect Map

## Redirect Strategy

All existing OJS URLs will be mapped to new Laravel URLs via the `legacy_url_mappings` table.
Redirects use **HTTP 301** (permanent) to preserve SEO equity.

## URL Pattern Mapping

| Old OJS URL Pattern | New Laravel URL | Entity |
|---|---|---|
| `/index.php/hd/` | `/journals/health-dynamics` | Journal |
| `/index.php/hd/issue/archive` | `/journals/health-dynamics/archive` | Journal Archive |
| `/index.php/hd/issue/view/Vol.{v}No.{n}` | `/journals/health-dynamics/vol-{v}/issue-{n}` | Issue |
| `/index.php/hd/article/view/{id}` | `/articles/{slug}` | Article |
| `/index.php/hd/article/view/{id}/{galley}` | `/articles/{slug}/pdf` | Article PDF |
| `/index.php/hd/about` | `/journals/health-dynamics/about` | About |
| `/index.php/hd/about/editorialTeam` | `/journals/health-dynamics/editorial-board` | Editorial Board |
| `/index.php/hd/about/submissions` | `/journals/health-dynamics/author-guidelines` | Author Guidelines |
| `/index.php/hd/about/contact` | `/contact` | Contact |
| `/index.php/hd/announcement` | `/journals/health-dynamics/announcements` | Announcements |
| `/index.php/hd/search` | `/search` | Search |
| `/index.php/hd/login` | `/login` | Login |
| `/index.php/hd/user/register` | `/register` | Register |

## Implementation

The `LegacyRedirectMiddleware` will:
1. Check if the incoming URL matches any `legacy_url_mappings.old_url`
2. If matched, issue a 301 redirect to `new_url`
3. Log the redirect for verification

```php
// Middleware pseudo-code
if ($mapping = LegacyUrlMapping::where('old_url', $request->path())->first()) {
    return redirect($mapping->new_url, $mapping->status_code);
}
```
