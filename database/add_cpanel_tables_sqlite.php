<?php

$sqliteFiles = [
    __DIR__ . '/../kdpuodtp_kdpub',
    __DIR__ . '/../database/database_sqlite.sqlite',
    __DIR__ . '/../database/database.sqlite',
];

foreach ($sqliteFiles as $file) {
    if (!file_exists($file)) continue;
    $db = new PDO('sqlite:' . $file);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $db->exec("CREATE TABLE IF NOT EXISTS `email_account_requests` (
        `id` INTEGER PRIMARY KEY AUTOINCREMENT,
        `user_id` INTEGER NOT NULL,
        `requested_username` VARCHAR(255) NOT NULL,
        `domain` VARCHAR(255) NOT NULL DEFAULT 'kdpub.com',
        `full_email` VARCHAR(255) NOT NULL UNIQUE,
        `quota_mb` INTEGER NOT NULL DEFAULT 500,
        `status` VARCHAR(50) NOT NULL DEFAULT 'pending',
        `password_encrypted` TEXT,
        `rejection_reason` TEXT,
        `admin_notes` TEXT,
        `cpanel_account_created_at` DATETIME,
        `created_at` DATETIME,
        `updated_at` DATETIME,
        FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
    )");

    $db->exec("CREATE TABLE IF NOT EXISTS `webmail_messages` (
        `id` INTEGER PRIMARY KEY AUTOINCREMENT,
        `user_id` INTEGER NOT NULL,
        `email_account_request_id` INTEGER,
        `folder` VARCHAR(50) NOT NULL DEFAULT 'inbox',
        `from_name` VARCHAR(255),
        `from_email` VARCHAR(255) NOT NULL,
        `to_email` VARCHAR(255) NOT NULL,
        `cc_email` VARCHAR(255),
        `subject` VARCHAR(255) NOT NULL,
        `body_html` TEXT,
        `body_text` TEXT,
        `is_read` INTEGER NOT NULL DEFAULT 0,
        `is_starred` INTEGER NOT NULL DEFAULT 0,
        `has_attachments` INTEGER NOT NULL DEFAULT 0,
        `sent_at` DATETIME,
        `created_at` DATETIME,
        `updated_at` DATETIME,
        FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
        FOREIGN KEY (`email_account_request_id`) REFERENCES `email_account_requests`(`id`) ON DELETE SET NULL
    )");

    $db->exec("CREATE TABLE IF NOT EXISTS `app_notifications` (
        `id` INTEGER PRIMARY KEY AUTOINCREMENT,
        `user_id` INTEGER,
        `type` VARCHAR(50) NOT NULL DEFAULT 'system',
        `title` VARCHAR(255) NOT NULL,
        `message` TEXT NOT NULL,
        `link` VARCHAR(255),
        `icon` VARCHAR(20) NOT NULL DEFAULT '🔔',
        `is_read` INTEGER NOT NULL DEFAULT 0,
        `read_at` DATETIME,
        `created_at` DATETIME,
        `updated_at` DATETIME,
        FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
    )");
}

echo "Created tables in all SQLite databases successfully!\n";
