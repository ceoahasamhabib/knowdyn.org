# Knowledge Dynamics — Deployment & First-Time Setup Guide
**Domain**: `https://kdpub.com` &bull; **cPanel User**: `kdpuodtp` &bull; **Database**: `kdpuodtp_kdpub`

---

## 📦 Package Files Included in `installable/`

| File | Purpose |
|------|---------|
| `kdpub_production_installer.zip` (~37 MB) | Complete standalone project archive (includes `vendor/`, `public/build/`, `.htaccess`, `.env`). Ready to extract into `public_html`. |
| `database_schema_initial.sql` (186 KB) | Complete MySQL dump with 29+ tables, default academic journals, editorial roles, and admin user for 1-click phpMyAdmin import. |
| `INSTALLATION_GUIDE.md` | This installation document. |

---

## 🚀 Method 1: 1-Click Interactive Web Installer (Recommended)

1. **Upload Archive to cPanel**:
   - Log in to your cPanel File Manager (`https://kdpub.com:2083`).
   - Go to `public_html/` (or your domain root).
   - Upload `installable/kdpub_production_installer.zip` and extract it directly into `public_html/`.

2. **Launch the Web Installer**:
   - Open your browser and navigate to:
     👉 **`https://kdpub.com/installer.php?key=kdpub2026`**

3. **Follow the 5-Step Setup Wizard**:
   - **Step 1 (Overview)**: Review system capabilities.
   - **Step 2 (Server Check)**: Confirms PHP 8.2+ and extensions (PDO, Mbstring, ZipArchive, OpenSSL).
   - **Step 3 (Database Setup)**: Pre-filled with `kdpuodtp_kdpub`. Click **Save & Test Database**.
   - **Step 4 (Migrations & Seeders)**: Executes all 29+ tables and seeders automatically.
   - **Step 5 (Admin Account)**: Creates the Super Administrator account (`admin@kdpub.com` / `password`).

4. **Done**:
   - Your site is now live at `https://kdpub.com`!

---

## ⚡ Future Updates via Universal Bulletproof Updater

For any future code updates, new features, or modifications:
1. Log in to the Admin Panel: `https://kdpub.com/admin`
2. Go to **⚡ Universal Updater** (`/admin/system-updater`).
3. Upload your updated `.zip` file.
4. The system will create an automatic rollback snapshot, atomically replace files, run non-destructive database migrations, and clear cache without downtime or data loss!
