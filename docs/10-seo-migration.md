# Knowledge Dynamics — SEO Migration Plan

## Pre-Launch Checklist

### 1. Crawl Existing URLs
- [ ] Crawl all pages on knowdyn.org/index.php/hd/
- [ ] Collect page titles and meta descriptions
- [ ] Collect canonical URLs
- [ ] Record article URLs (estimated ~189)
- [ ] Record issue URLs (34 issues)
- [ ] Record PDF URLs

### 2. Structured Data
- [ ] Implement JSON-LD ScholarlyArticle for articles
- [ ] Implement Organization schema for Knowledge Dynamics
- [ ] Implement Periodical schema for journals
- [ ] Implement BreadcrumbList schema
- [ ] Implement SearchAction schema for search

### 3. Meta Tags
- [ ] Title tag on every page (unique, descriptive)
- [ ] Meta description on every page
- [ ] Canonical URLs on all pages
- [ ] Open Graph tags (og:title, og:description, og:image, og:type)
- [ ] Twitter Card tags
- [ ] Article-specific meta (authors, publication date, DOI)

### 4. Sitemap
- [ ] Generate XML sitemap
- [ ] Include all published articles
- [ ] Include journal pages
- [ ] Include researcher profiles
- [ ] Include project pages
- [ ] Auto-update on publish
- [ ] Register with Google Search Console

### 5. Robots.txt
- [ ] Allow all public pages
- [ ] Disallow admin, dashboard, manuscript areas
- [ ] Point to sitemap

### 6. URL Redirects
- [ ] Implement all 301 redirects (see 09-url-redirect-map.md)
- [ ] Test every redirect returns 301
- [ ] No redirect chains
- [ ] No redirect loops

### 7. Performance
- [ ] Page load under 3s
- [ ] Core Web Vitals pass
- [ ] Image optimization
- [ ] Asset minification (Vite handles this)
- [ ] HTTP/2 enabled on production

### 8. Post-Launch Verification
- [ ] Submit sitemap to Google Search Console
- [ ] Monitor 404 errors
- [ ] Monitor redirect performance
- [ ] Verify indexed pages after 2 weeks
- [ ] Check search rankings for key terms
