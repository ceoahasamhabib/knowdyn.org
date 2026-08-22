# Knowledge Dynamics — Deployment Plan

## Development Environment
- **OS**: Windows (XAMPP)
- **PHP**: 8.3.33
- **Database**: MariaDB 10.4.32
- **Node**: 24.x
- **Server**: `php artisan serve`

## Staging Environment (Recommended)
- **Provider**: DigitalOcean / Hetzner / AWS Lightsail
- **OS**: Ubuntu 24.04 LTS
- **Web Server**: Nginx
- **PHP**: 8.3+ (PHP-FPM)
- **Database**: MySQL 8.0+
- **Cache**: Redis 7+
- **Queue**: Redis + Laravel Horizon
- **Storage**: S3-compatible (DigitalOcean Spaces / AWS S3)
- **SSL**: Let's Encrypt

## Production Environment
- Same as staging with:
  - **CDN**: Cloudflare
  - **Email**: SMTP (Postmark / Mailgun / SES)
  - **Monitoring**: Laravel Pulse / Sentry
  - **Backups**: Automated daily DB + file backups

## Deployment Steps

### 1. Server Setup
```bash
# Install PHP 8.3, Nginx, MySQL 8, Redis, Node, Composer
# Configure PHP-FPM pool
# Configure Nginx virtual host
# Set up SSL with Certbot
```

### 2. Application Deploy
```bash
git clone <repo> /var/www/knowledge-dynamics
cd /var/www/knowledge-dynamics
composer install --optimize-autoloader --no-dev
npm ci && npm run build
cp .env.example .env  # Configure production values
php artisan key:generate
php artisan migrate --force
php artisan db:seed --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan storage:link
```

### 3. Queue & Scheduler
```bash
# Supervisor for queue workers
php artisan queue:work --daemon

# Cron for scheduler
* * * * * cd /var/www/knowledge-dynamics && php artisan schedule:run >> /dev/null 2>&1
```

### 4. Domain Configuration
- Primary: `knowledge-dynamics.com`
- DNS: A record → server IP
- SSL: Full (Strict) via Cloudflare

## Pre-Launch Checklist
- [ ] All migrations run on production DB
- [ ] Roles and permissions seeded
- [ ] Admin user created
- [ ] OJS data imported and verified
- [ ] URL redirects configured and tested
- [ ] SSL enabled and enforced
- [ ] Sitemap generated and submitted
- [ ] Email delivery tested
- [ ] Error pages (404, 500) working
- [ ] Monitoring set up
- [ ] Backups configured
- [ ] Performance tested
