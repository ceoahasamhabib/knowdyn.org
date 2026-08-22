# Hostinger & cPanel Shared Hosting Deployment Manual
## Knowledge Dynamics Academic Publishing Platform

This guide provides step-by-step instructions to deploy Knowledge Dynamics to Hostinger Shared Hosting (or any standard cPanel web hosting environment).

---

### 1. Prerequisites on Hostinger / cPanel

1. **PHP Version**: Select **PHP 8.2** or **PHP 8.3** in your Hostinger cPanel / hPanel under *PHP Configuration*.
2. **PHP Extensions**: Enable the following extensions in cPanel (*PHP Select Extensions*):
   - `pdo_mysql`
   - `mbstring`
   - `fileinfo`
   - `intl`
   - `gd`
   - `zip`
   - `curl`
   - `xml`
   - `bcmath`
   - `ctype`
   - `openssl`
3. **MySQL Database**:
   - Go to *MySQL Databases* in cPanel.
   - Create a database (e.g. `u123456_knowdyn`).
   - Create a database user with a strong password and assign **ALL PRIVILEGES** to the database.

---

### 2. Deployment Architecture (Recommended Standard)

For security and optimal isolation, follow the standard Laravel cPanel folder structure:

```
/home/u123456789/
├── knowdyn_core/           <-- Upload all project files HERE (except public folder)
│   ├── app/
│   ├── bootstrap/
│   ├── config/
│   ├── database/
│   ├── routes/
│   ├── storage/
│   ├── vendor/
│   ├── .env
│   ├── artisan
│   └── ...
└── public_html/            <-- Place contents of /public folder HERE
    ├── build/              <-- Pre-compiled Vue assets (manifest.json, CSS, JS)
    ├── index.php           <-- Edited to point to knowdyn_core
    ├── .htaccess           <-- Apache rewrite rules
    ├── favicon.ico
    └── robots.txt
```

#### Step-by-Step File Setup:
1. **Compress project files locally**:
   - Run `npm run build` locally to compile the latest frontend bundle into `public/build`.
   - Zip the entire project folder (including `vendor/`, `public/build/`, and all source code).
2. **Upload to cPanel**:
   - Use cPanel *File Manager* to upload the zip to `/home/uXXXX/`.
   - Extract it to `/home/uXXXX/knowdyn_core`.
3. **Move Public Assets**:
   - Move all files from `knowdyn_core/public/*` into `/home/uXXXX/public_html/`.
4. **Update `public_html/index.php` paths**:
   In `public_html/index.php`, update lines 12 & 18:
   ```php
   // From:
   require __DIR__.'/../vendor/autoload.php';
   $app = require_once __DIR__.'/../bootstrap/app.php';

   // Change To:
   require __DIR__.'/../knowdyn_core/vendor/autoload.php';
   $app = require_once __DIR__.'/../knowdyn_core/bootstrap/app.php';
   ```

---

### 3. Alternate Fast Method (Direct `public_html` Upload)

If your hosting requires placing the entire repository in `public_html`:
1. Upload the entire project directly inside `public_html/`.
2. The root `.htaccess` (already included in this build) will automatically route all incoming traffic directly to `/public`:
   ```apache
   <IfModule mod_rewrite.c>
       RewriteEngine On
       RewriteRule ^(.*)$ public/$1 [L]
   </IfModule>
   ```

---

### 4. `.env` Production Configuration

Create/update your `.env` file in the root folder with production credentials:

```env
APP_NAME="Knowledge Dynamics"
APP_ENV=production
APP_KEY=base64:YOUR_GENERATED_APP_KEY
APP_DEBUG=false
APP_URL=https://yourdomain.com

LOG_CHANNEL=stack
LOG_LEVEL=error

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=u123456_knowdyn
DB_USERNAME=u123456_user
DB_PASSWORD=YourStrongDatabasePassword

SESSION_DRIVER=database
QUEUE_CONNECTION=database
CACHE_STORE=database

MAIL_MAILER=smtp
MAIL_HOST=smtp.hostinger.com
MAIL_PORT=465
MAIL_USERNAME=editorial@yourdomain.com
MAIL_PASSWORD=YourMailPassword
MAIL_ENCRYPTION=ssl
MAIL_FROM_ADDRESS="editorial@yourdomain.com"
MAIL_FROM_NAME="Knowledge Dynamics"
```

---

### 5. Running Database Migrations & Caching

Using cPanel **Terminal** or SSH, execute:

```bash
# 1. Run migrations and seed all 5 journals, books, services & admin users
php artisan migrate --force
php artisan db:seed --force

# 2. Link public storage for author avatars & media
php artisan storage:link

# 3. Optimize configuration and routes for speed
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

*(Note: If cPanel Terminal is disabled on your shared plan, you can run these once via a temporary single-execution PHP script or through phpMyAdmin SQL import).*

---

### 6. Background Queue & Scheduler Cron Job

In cPanel under **Cron Jobs**, add this 1-minute cron job to automate editorial email notifications and review reminders:

```bash
* * * * * cd /home/uXXXX/knowdyn_core && php artisan schedule:run >> /dev/null 2>&1
```

---

### 7. Super Admin Login Credentials

After running `php artisan db:seed`, your default Super Admin login is:
- **URL**: `https://kdpub.com/login`
- **Email**: `admin@kdpub.com` (or `admin@knowdyn.org`)
- **Password**: `password` (or custom password set in `.env`)
- **Admin Cockpit**: `https://kdpub.com/admin`

---

### 8. Automated Deployment via GitHub (Auto-Deploy)

There are two easy methods to auto-deploy changes from GitHub to cPanel:

#### Option A: GitHub Actions CI/CD (Pre-Configured in `.github/workflows/deploy.yml`)
1. Push this repository to your GitHub account (e.g. `github.com/your-username/kdpub`).
2. In GitHub, navigate to **Settings > Secrets and variables > Actions** and add 3 Repository Secrets:
   - `CPANEL_FTP_SERVER`: Your Hostinger/cPanel FTP host (e.g. `ftp.kdpub.com` or your server IP).
   - `CPANEL_FTP_USERNAME`: Your cPanel FTP username.
   - `CPANEL_FTP_PASSWORD`: Your cPanel FTP password.
3. Now, whenever you push code to the `main` branch, GitHub Actions will automatically install dependencies, build Vite assets (`npm run build`), and deploy the latest files to cPanel!

#### Option B: cPanel Built-In Git™ Version Control (`.cpanel.yml`)
1. Log in to cPanel and open **Git™ Version Control**.
2. Click **Create**, enter your GitHub Clone URL (`https://github.com/your-username/kdpub.git`), and set the path (e.g., `/home/username/repositories/kdpub`).
3. Click **Create** to clone the repository.
4. Copy the **Webhook URL** shown in cPanel, then go to your GitHub repository -> **Settings > Webhooks > Add webhook** and paste the URL.
5. In `.cpanel.yml`, update `DEPLOYPATH` to your `public_html` path.
6. Whenever you `git push`, cPanel will automatically pull changes and execute the deployment tasks.

