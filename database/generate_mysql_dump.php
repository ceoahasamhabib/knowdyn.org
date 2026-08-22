<?php

require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

$outputSql = "-- ========================================================\n";
$outputSql .= "-- Knowledge Dynamics — Complete Production Database Dump\n";
$outputSql .= "-- Database: kdpuodtp_kdpub | Domain: https://kdpub.com\n";
$outputSql .= "-- Generated: " . date('Y-m-d H:i:s') . "\n";
$outputSql .= "-- Compatible with MySQL 5.7+, 8.0+, MariaDB 10.3+\n";
$outputSql .= "-- ========================================================\n\n";

$outputSql .= "SET FOREIGN_KEY_CHECKS=0;\n";
$outputSql .= "SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';\n";
$outputSql .= "SET AUTOCOMMIT = 0;\n";
$outputSql .= "START TRANSACTION;\n";
$outputSql .= "SET time_zone = '+00:00';\n\n";

// Table Creation Definitions tailored for standard MySQL with utf8mb4 and safe index lengths (<=191 chars)
$tableSchemas = [
    'migrations' => "CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'roles' => "CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'permissions' => "CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'model_has_roles' => "CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'model_has_permissions' => "CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'role_has_permissions' => "CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'users' => "CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `affiliation` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `orcid_id` varchar(191) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `avatar_url` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `google_scholar_url` varchar(191) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'password_reset_tokens' => "CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'sessions' => "CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'cache' => "CREATE TABLE `cache` (
  `key` varchar(191) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'cache_locks' => "CREATE TABLE `cache_locks` (
  `key` varchar(191) NOT NULL,
  `owner` varchar(191) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'jobs' => "CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'job_batches' => "CREATE TABLE `job_batches` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'failed_jobs' => "CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'publishers' => "CREATE TABLE `publishers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `logo_url` varchar(191) DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `contact_email` varchar(191) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publishers_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'journals' => "CREATE TABLE `journals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `publisher_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `issn_print` varchar(191) DEFAULT NULL,
  `issn_online` varchar(191) DEFAULT NULL,
  `aims_and_scope` longtext DEFAULT NULL,
  `editorial_guidelines` longtext DEFAULT NULL,
  `peer_review_policy` longtext DEFAULT NULL,
  `cover_image_url` varchar(191) DEFAULT NULL,
  `impact_factor` decimal(4,2) DEFAULT NULL,
  `cite_score` decimal(4,2) DEFAULT NULL,
  `h_index` int(11) DEFAULT NULL,
  `frequency` varchar(191) NOT NULL DEFAULT 'Quarterly',
  `is_open_access` tinyint(1) NOT NULL DEFAULT 1,
  `apc_amount` decimal(8,2) DEFAULT NULL,
  `apc_currency` varchar(10) NOT NULL DEFAULT 'USD',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `journals_slug_unique` (`slug`),
  KEY `journals_publisher_id_foreign` (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'editorial_board_members' => "CREATE TABLE `editorial_board_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `role_title` varchar(191) NOT NULL DEFAULT 'Editorial Board Member',
  `affiliation` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `orcid_id` varchar(191) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `avatar_url` varchar(191) DEFAULT NULL,
  `display_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `editorial_board_members_journal_id_foreign` (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'volumes' => "CREATE TABLE `volumes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `volume_number` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volumes_journal_id_foreign` (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'issues' => "CREATE TABLE `issues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `volume_id` bigint(20) unsigned NOT NULL,
  `issue_number` int(11) NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `cover_image_url` varchar(191) DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `is_special_issue` tinyint(1) NOT NULL DEFAULT 0,
  `special_issue_title` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'published',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issues_volume_id_foreign` (`volume_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'articles' => "CREATE TABLE `articles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `volume_id` bigint(20) unsigned DEFAULT NULL,
  `issue_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `abstract` longtext NOT NULL,
  `keywords` text DEFAULT NULL,
  `doi` varchar(191) DEFAULT NULL,
  `article_type` varchar(191) NOT NULL DEFAULT 'Research Article',
  `page_start` varchar(50) DEFAULT NULL,
  `page_end` varchar(50) DEFAULT NULL,
  `pdf_url` varchar(191) DEFAULT NULL,
  `html_content` longtext DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `received_at` date DEFAULT NULL,
  `accepted_at` date DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'published',
  `license_type` varchar(191) NOT NULL DEFAULT 'CC-BY-4.0',
  `views_count` int(11) NOT NULL DEFAULT 0,
  `downloads_count` int(11) NOT NULL DEFAULT 0,
  `citations_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articles_slug_unique` (`slug`),
  KEY `articles_journal_id_foreign` (`journal_id`),
  KEY `articles_issue_id_foreign` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'article_authors' => "CREATE TABLE `article_authors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `affiliation` varchar(191) DEFAULT NULL,
  `orcid_id` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `is_corresponding` tinyint(1) NOT NULL DEFAULT 0,
  `display_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `article_authors_article_id_foreign` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'publishing_services' => "CREATE TABLE `publishing_services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `category` varchar(191) NOT NULL DEFAULT 'Language & Editing',
  `tagline` varchar(191) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `features_json` text DEFAULT NULL,
  `base_price` decimal(8,2) DEFAULT NULL,
  `pricing_type` varchar(191) NOT NULL DEFAULT 'per_page',
  `icon_svg` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publishing_services_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'email_account_requests' => "CREATE TABLE `email_account_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `requested_username` varchar(191) NOT NULL,
  `domain` varchar(191) NOT NULL DEFAULT 'kdpub.com',
  `full_email` varchar(191) NOT NULL,
  `purpose` text DEFAULT NULL,
  `quota_mb` int(11) NOT NULL DEFAULT 500,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `password_encrypted` text DEFAULT NULL,
  `cpanel_account_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_account_requests_full_email_unique` (`full_email`),
  KEY `email_account_requests_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'webmail_messages' => "CREATE TABLE `webmail_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `folder` varchar(191) NOT NULL DEFAULT 'inbox',
  `from_email` varchar(191) NOT NULL,
  `from_name` varchar(191) DEFAULT NULL,
  `to_email` varchar(191) NOT NULL,
  `subject` varchar(191) NOT NULL,
  `body_html` longtext DEFAULT NULL,
  `body_plain` longtext DEFAULT NULL,
  `has_attachments` tinyint(1) NOT NULL DEFAULT 0,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `is_starred` tinyint(1) NOT NULL DEFAULT 0,
  `received_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webmail_messages_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'app_notifications' => "CREATE TABLE `app_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'system',
  `title` varchar(191) NOT NULL,
  `message` text NOT NULL,
  `action_url` varchar(191) DEFAULT NULL,
  `icon` varchar(191) DEFAULT 'bell',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_notifications_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'site_settings' => "CREATE TABLE `site_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) NOT NULL,
  `value` longtext DEFAULT NULL,
  `group` varchar(191) NOT NULL DEFAULT 'general',
  `label` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'dynamic_pages' => "CREATE TABLE `dynamic_pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `category` varchar(191) NOT NULL DEFAULT 'general',
  `content` longtext NOT NULL,
  `meta_description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dynamic_pages_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'news_events' => "CREATE TABLE `news_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'news',
  `summary` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `cover_image` varchar(191) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `event_location` varchar(191) DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_published` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `news_events_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'career_positions' => "CREATE TABLE `career_positions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `department` varchar(191) NOT NULL DEFAULT 'Editorial',
  `type` varchar(191) NOT NULL DEFAULT 'Full-time',
  `location` varchar(191) NOT NULL DEFAULT 'Remote',
  `description` longtext NOT NULL,
  `requirements` text DEFAULT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `career_positions_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;",

    'activity_audit_logs' => "CREATE TABLE `activity_audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `action` varchar(191) NOT NULL,
  `entity_type` varchar(191) DEFAULT NULL,
  `entity_id` bigint(20) unsigned DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_audit_logs_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;"
];

foreach ($tableSchemas as $tableName => $createSql) {
    $outputSql .= "-- --------------------------------------------------------\n";
    $outputSql .= "-- Table structure for table `{$tableName}`\n";
    $outputSql .= "-- --------------------------------------------------------\n\n";
    $outputSql .= "DROP TABLE IF EXISTS `{$tableName}`;\n";
    $outputSql .= $createSql . "\n\n";

    if (Schema::hasTable($tableName)) {
        $rows = DB::table($tableName)->get();
        if ($rows->count() > 0) {
            $outputSql .= "-- Dumping data for table `{$tableName}`\n";
            foreach ($rows as $row) {
                $rowArray = (array) $row;
                $columns = array_keys($rowArray);
                $escapedColumns = array_map(fn($c) => "`{$c}`", $columns);
                $escapedValues = array_map(function($v) {
                    if (is_null($v)) return "NULL";
                    return "'" . addslashes((string)$v) . "'";
                }, array_values($rowArray));

                $outputSql .= "INSERT INTO `{$tableName}` (" . implode(", ", $escapedColumns) . ") VALUES (" . implode(", ", $escapedValues) . ");\n";
            }
            $outputSql .= "\n";
        }
    }
}

$outputSql .= "COMMIT;\n";
$outputSql .= "SET FOREIGN_KEY_CHECKS=1;\n";

// Save dump in database/ and installable/ and Desktop
file_put_contents(__DIR__ . '/database_backup_production.sql', $outputSql);
file_put_contents(__DIR__ . '/../installable/database_schema_initial.sql', $outputSql);
file_put_contents('C:/Users/User/Desktop/kdpub_database.sql', $outputSql);

echo "Successfully generated database_backup_production.sql, installable/database_schema_initial.sql, and C:/Users/User/Desktop/kdpub_database.sql!\n";
