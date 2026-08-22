-- ========================================================
-- Knowledge Dynamics — Complete Production Database Dump
-- Database: kdpuodtp_kdpub | Domain: https://kdpub.com
-- Generated: 2026-08-22 19:52:02
-- Compatible with MySQL 5.7+, 8.0+, MariaDB 10.3+
-- ========================================================

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = '+00:00';

-- --------------------------------------------------------
-- Table structure for table `migrations`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `migrations`
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('1', '0001_01_01_000000_create_users_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('2', '0001_01_01_000001_create_cache_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('3', '0001_01_01_000002_create_jobs_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('4', '2026_08_22_124240_create_permission_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('5', '2026_08_22_130001_add_profile_fields_to_users_table', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('6', '2026_08_22_130002_create_researcher_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('7', '2026_08_22_130003_create_journal_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('8', '2026_08_22_130004_create_volume_issue_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('9', '2026_08_22_130005_create_article_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('10', '2026_08_22_130006_create_manuscript_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('11', '2026_08_22_130007_create_review_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('12', '2026_08_22_130008_create_project_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('13', '2026_08_22_130009_create_service_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('14', '2026_08_22_130010_create_system_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('15', '2026_08_22_150000_create_dynamic_content_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('16', '2026_08_22_160000_create_cpanel_and_webmail_tables', '1');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('17', '2026_08_22_170000_create_app_notifications_table', '1');

-- --------------------------------------------------------
-- Table structure for table `users`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive','suspended') NOT NULL DEFAULT 'active',
  `password` varchar(191) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `users`
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `username`, `phone`, `avatar`, `status`, `deleted_at`) VALUES ('1', 'KD Admin', 'admin@knowledge-dynamics.com', '2026-08-22 19:51:28', '$2y$12$41ehclOh0SOvUUSvACOQi.J10XKaLHg8dqtJ4qTHYrQrBuvs8wsDa', NULL, '2026-08-22 19:51:28', '2026-08-22 19:51:28', 'KD', 'Admin', 'kdadmin', NULL, NULL, 'active', NULL);
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `username`, `phone`, `avatar`, `status`, `deleted_at`) VALUES ('2', 'Super Administrator', 'admin@knowdyn.org', '2026-08-22 19:51:29', '$2y$12$TpWQtX8eRunb.GjbmY5vNuGXV7TRmdVZGJKdMIHhxtcbYRYBcq/xu', NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', 'Super', 'Admin', 'superadmin', NULL, NULL, 'active', NULL);

-- --------------------------------------------------------
-- Table structure for table `password_reset_tokens`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `sessions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `cache`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(191) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `cache_locks`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(191) NOT NULL,
  `owner` varchar(191) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `jobs`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `job_batches`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `failed_jobs`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `roles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `roles`
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('1', 'super-admin', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('2', 'admin', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('3', 'journal-manager', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('4', 'editor-in-chief', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('5', 'section-editor', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('6', 'reviewer', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('7', 'author', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('8', 'researcher', 'web', '2026-08-22 19:51:28', '2026-08-22 19:51:28');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('9', 'reader', 'web', '2026-08-22 19:51:28', '2026-08-22 19:51:28');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('10', 'proofreader', 'web', '2026-08-22 19:51:28', '2026-08-22 19:51:28');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('11', 'copyeditor', 'web', '2026-08-22 19:51:28', '2026-08-22 19:51:28');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('12', 'layout-editor', 'web', '2026-08-22 19:51:28', '2026-08-22 19:51:28');

-- --------------------------------------------------------
-- Table structure for table `permissions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `permissions`
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('1', 'manage users', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('2', 'view users', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('3', 'manage journals', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('4', 'view journals', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('5', 'manage articles', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('6', 'view articles', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('7', 'publish articles', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('8', 'submit manuscripts', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('9', 'screen manuscripts', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('10', 'assign editors', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('11', 'assign reviewers', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('12', 'make editorial decisions', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('13', 'view all manuscripts', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('14', 'view assigned manuscripts', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('15', 'review manuscripts', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('16', 'manage projects', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('17', 'view projects', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('18', 'manage services', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('19', 'view service requests', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('20', 'handle service requests', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('21', 'manage pages', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('22', 'manage settings', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('23', 'view audit logs', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('24', 'manage url mappings', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('25', 'manage doi records', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('26', 'manage own profile', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('27', 'manage researcher profiles', 'web', '2026-08-22 19:51:27', '2026-08-22 19:51:27');

-- --------------------------------------------------------
-- Table structure for table `model_has_roles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `model_has_roles`
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('1', 'App\\Models\\User', '1');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('2', 'App\\Models\\User', '1');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('1', 'App\\Models\\User', '2');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('2', 'App\\Models\\User', '2');

-- --------------------------------------------------------
-- Table structure for table `model_has_permissions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `role_has_permissions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `role_has_permissions`
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('1', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('2', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('3', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('5', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('7', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('8', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('9', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('10', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('13', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('15', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('16', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('18', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('19', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('20', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('21', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('22', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('23', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('24', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('25', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('27', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('3', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('5', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('7', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('13', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('9', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('10', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('24', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('5', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('7', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('13', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('9', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('10', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('15', '6');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '6');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '6');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('8', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('16', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('16', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '9');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '9');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '9');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('19', '10');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('20', '10');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '10');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '11');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '11');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '12');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '12');

-- --------------------------------------------------------
-- Table structure for table `researcher_profiles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `researcher_profiles`;
CREATE TABLE `researcher_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `affiliation` varchar(191) DEFAULT NULL,
  `department` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `orcid_id` varchar(191) DEFAULT NULL,
  `scopus_id` varchar(191) DEFAULT NULL,
  `researcher_id` varchar(191) DEFAULT NULL,
  `google_scholar_url` varchar(191) DEFAULT NULL,
  `research_interests` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `qualification` varchar(191) DEFAULT NULL,
  `h_index` int(11) NOT NULL DEFAULT 0,
  `i10_index` int(11) NOT NULL DEFAULT 0,
  `total_citations` int(11) NOT NULL DEFAULT 0,
  `total_publications` int(11) NOT NULL DEFAULT 0,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `researcher_profiles_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `publishers`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `publishers`;
CREATE TABLE `publishers` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `journals`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `journals`;
CREATE TABLE `journals` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `journals`
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('1', 'Health Dynamics', 'health-dynamics', 'Health Dyn.', 'A peer-reviewed, open-access multidisciplinary journal publishing high-impact research, clinical insights, and healthcare management innovations.', 'Health Dynamics is dedicated to advancing the frontiers of medical sciences, public health policy, epidemiology, biomedical innovations, and healthcare delivery systems.

The journal welcomes original research papers, systematic reviews, clinical trials, meta-analyses, and methodological advances addressing urgent global healthcare challenges.', '3006-550X', '3006-5518', 'Knowledge Dynamics', 'Bi-monthly', NULL, NULL, 'editor.hd@knowdyn.org', NULL, NULL, 'active', '1', '2021', NULL, NULL, '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('2', 'KD Food Science Nutrition', 'kd-food-science-nutrition', 'KD Food Sci. Nutr.', 'Advancing sustainable agricultural food processing, functional nutraceutical bioactives, molecular food safety, and global human nutritional health.', 'KD Food Science Nutrition provides a global peer-reviewed forum for groundbreaking discoveries in food biotechnology, nutrient bioavailability, sensory analysis, food chemistry, shelf-life modeling, and sustainable food packaging solutions.', '3007-8812', '3007-8820', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.fsn@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '2', '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('3', 'KD Asian Studies', 'kd-asian-studies', 'KD Asian Stud.', 'A premier international journal exploring Asian geopolitical dynamics, socioeconomic transformations, cultural heritage, history, and linguistic evolution.', 'KD Asian Studies publishes interdisciplinary scholarship covering East, South, Southeast, and Central Asia. The journal bridges contemporary sociopolitical analysis with historical, archaeological, and literary perspectives.', '3008-1123', '3008-1131', 'Knowledge Dynamics', 'Bi-annual', NULL, NULL, 'editor.as@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '3', '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('4', 'KD Accounting, Business, Management, Finance', 'kd-accounting-business-management-finance', 'KD ABMF', 'Fostering empirical research in corporate governance, financial econometrics, fintech disruptions, organizational management, and ESG sustainability reporting.', 'KD ABMF serves corporate leaders, financial economists, and management scholars by publishing rigorous research on capital markets, algorithmic trading, audit quality, executive leadership, and green business models.', '3009-4456', '3009-4464', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.abmf@knowdyn.org', NULL, NULL, 'active', '1', '2023', NULL, NULL, '4', '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('5', 'KD Comparative Religion', 'kd-comparative-religion', 'KD Comp. Relig.', 'A scholarly platform for interfaith dialogues, hermeneutical text studies, sociology of religion, ethics, and contemporary theological discourse.', 'KD Comparative Religion fosters rigorous critical scholarship examining religious traditions, historical theology, sacred texts, philosophical ethics, and the role of faith communities in contemporary global society.', '3010-7789', '3010-7797', 'Knowledge Dynamics', 'Bi-annual', NULL, NULL, 'editor.cr@knowdyn.org', NULL, NULL, 'active', '1', '2023', NULL, NULL, '5', '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);

-- --------------------------------------------------------
-- Table structure for table `editorial_board_members`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `editorial_board_members`;
CREATE TABLE `editorial_board_members` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `volumes`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;
CREATE TABLE `volumes` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `volumes`
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('1', '1', '1', '2021', 'Volume 1 (2021)', NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('2', '1', '2', '2022', 'Volume 2 (2022)', NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('3', '2', '1', '2022', 'Volume 1 (2022)', NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('4', '2', '2', '2023', 'Volume 2 (2023)', NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('5', '3', '1', '2022', 'Volume 1 (2022)', NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('6', '3', '2', '2023', 'Volume 2 (2023)', NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('7', '4', '1', '2023', 'Volume 1 (2023)', NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('8', '4', '2', '2024', 'Volume 2 (2024)', NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('9', '5', '1', '2023', 'Volume 1 (2023)', NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('10', '5', '2', '2024', 'Volume 2 (2024)', NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `issues`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `issues`
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('1', '1', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2021-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('2', '1', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2021-09-15 00:00:00', '0', 'published', '2', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('3', '2', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2022-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('4', '2', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2022-09-15 00:00:00', '1', 'published', '2', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('5', '3', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2022-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('6', '3', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2022-09-15 00:00:00', '0', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('7', '4', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2023-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('8', '4', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2023-09-15 00:00:00', '1', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('9', '5', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2022-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('10', '5', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2022-09-15 00:00:00', '0', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('11', '6', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2023-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('12', '6', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2023-09-15 00:00:00', '1', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('13', '7', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2023-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('14', '7', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2023-09-15 00:00:00', '0', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('15', '8', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2024-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('16', '8', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2024-09-15 00:00:00', '1', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('17', '9', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2023-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('18', '9', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2023-09-15 00:00:00', '0', 'published', '2', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('19', '10', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2024-03-15 00:00:00', '0', 'published', '1', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('20', '10', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2024-09-15 00:00:00', '1', 'published', '2', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `articles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `articles`
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('1', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 1, No. 1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v1-i1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v1i1.01', '1-16', '2021-01-15 00:00:00', '2021-02-28 00:00:00', '2021-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('2', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 1, No. 2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v1-i2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v1i2.01', '1-16', '2021-01-15 00:00:00', '2021-02-28 00:00:00', '2021-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('3', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 2, No. 1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v2-i1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v2i1.01', '1-16', '2022-01-15 00:00:00', '2022-02-28 00:00:00', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('4', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 2, No. 2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v2-i2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v2i2.01', '1-16', '2022-01-15 00:00:00', '2022-02-28 00:00:00', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('5', '2', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 1, No. 1)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v1-i1', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v1i1.01', '1-16', '2022-01-15 00:00:00', '2022-02-28 00:00:00', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2022, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('6', '2', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 1, No. 2)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v1-i2', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v1i2.01', '1-16', '2022-01-15 00:00:00', '2022-02-28 00:00:00', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2022, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('7', '2', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 2, No. 1)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v2-i1', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v2i1.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2023, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('8', '2', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 2, No. 2)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v2-i2', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v2i2.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2023, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('9', '3', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 1, No. 1)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v1-i1', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v1i1.01', '1-16', '2022-01-15 00:00:00', '2022-02-28 00:00:00', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2022, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('10', '3', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 1, No. 2)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v1-i2', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v1i2.01', '1-16', '2022-01-15 00:00:00', '2022-02-28 00:00:00', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2022, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('11', '3', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 2, No. 1)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v2-i1', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v2i1.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2023, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('12', '3', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 2, No. 2)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v2-i2', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v2i2.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2023, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('13', '4', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 1, No. 1)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v1-i1', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v1i1.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2023, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('14', '4', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 1, No. 2)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v1-i2', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v1i2.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2023, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('15', '4', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 2, No. 1)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v2-i1', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v2i1.01', '1-16', '2024-01-15 00:00:00', '2024-02-28 00:00:00', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2024, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('16', '4', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 2, No. 2)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v2-i2', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v2i2.01', '1-16', '2024-01-15 00:00:00', '2024-02-28 00:00:00', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2024, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('17', '5', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 1, No. 1)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v1-i1', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v1i1.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2023, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('18', '5', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 1, No. 2)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v1-i2', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v1i2.01', '1-16', '2023-01-15 00:00:00', '2023-02-28 00:00:00', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2023, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('19', '5', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 2, No. 1)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v2-i1', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v2i1.01', '1-16', '2024-01-15 00:00:00', '2024-02-28 00:00:00', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2024, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('20', '5', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 2, No. 2)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v2-i2', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v2i2.01', '1-16', '2024-01-15 00:00:00', '2024-02-28 00:00:00', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2024, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31', NULL);

-- --------------------------------------------------------
-- Table structure for table `article_authors`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_authors`;
CREATE TABLE `article_authors` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `article_authors`
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('1', '1', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('2', '2', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('3', '3', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('4', '4', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('5', '5', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('6', '6', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('7', '7', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('8', '8', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('9', '9', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('10', '10', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('11', '11', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('12', '12', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('13', '13', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('14', '14', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('15', '15', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('16', '16', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('17', '17', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('18', '18', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('19', '19', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('20', '20', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');

-- --------------------------------------------------------
-- Table structure for table `article_metrics`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_metrics`;
CREATE TABLE `article_metrics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `pdf_downloads` int(11) NOT NULL DEFAULT 0,
  `xml_downloads` int(11) NOT NULL DEFAULT 0,
  `citations` int(11) NOT NULL DEFAULT 0,
  `altmetric_score` int(11) NOT NULL DEFAULT 0,
  `recorded_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `article_metrics_article_id_foreign` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscript_submissions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscript_submissions`;
CREATE TABLE `manuscript_submissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(191) NOT NULL,
  `journal_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(500) NOT NULL,
  `abstract` longtext NOT NULL,
  `keywords` text DEFAULT NULL,
  `article_type` varchar(191) NOT NULL DEFAULT 'Research Article',
  `status` varchar(191) NOT NULL DEFAULT 'submitted',
  `current_round` int(11) NOT NULL DEFAULT 1,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `manuscript_submissions_tracking_number_unique` (`tracking_number`),
  KEY `manuscript_submissions_journal_id_foreign` (`journal_id`),
  KEY `manuscript_submissions_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscript_files`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscript_files`;
CREATE TABLE `manuscript_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_submission_id` bigint(20) unsigned NOT NULL,
  `file_type` varchar(191) NOT NULL DEFAULT 'manuscript',
  `file_path` varchar(191) NOT NULL,
  `original_name` varchar(191) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `mime_type` varchar(191) DEFAULT NULL,
  `round` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manuscript_files_manuscript_submission_id_foreign` (`manuscript_submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscript_reviewers`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscript_reviewers`;
CREATE TABLE `manuscript_reviewers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_submission_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `invited_at` timestamp NULL DEFAULT NULL,
  `responded_at` timestamp NULL DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manuscript_reviewers_manuscript_submission_id_foreign` (`manuscript_submission_id`),
  KEY `manuscript_reviewers_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `peer_reviews`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `peer_reviews`;
CREATE TABLE `peer_reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_submission_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `round` int(11) NOT NULL DEFAULT 1,
  `recommendation` varchar(191) NOT NULL,
  `comments_to_author` longtext DEFAULT NULL,
  `comments_to_editor` longtext DEFAULT NULL,
  `score_novelty` int(11) DEFAULT NULL,
  `score_methodology` int(11) DEFAULT NULL,
  `score_clarity` int(11) DEFAULT NULL,
  `score_overall` int(11) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'completed',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `peer_reviews_manuscript_submission_id_foreign` (`manuscript_submission_id`),
  KEY `peer_reviews_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `freelance_projects`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `freelance_projects`;
CREATE TABLE `freelance_projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `category` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `budget_min` decimal(8,2) DEFAULT NULL,
  `budget_max` decimal(8,2) DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `freelance_projects_slug_unique` (`slug`),
  KEY `freelance_projects_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `freelance_proposals`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `freelance_proposals`;
CREATE TABLE `freelance_proposals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `freelance_project_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `bid_amount` decimal(8,2) NOT NULL,
  `estimated_days` int(11) NOT NULL,
  `cover_letter` longtext NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `freelance_proposals_freelance_project_id_foreign` (`freelance_project_id`),
  KEY `freelance_proposals_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `publishing_services`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `publishing_services`;
CREATE TABLE `publishing_services` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `service_orders`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `service_orders`;
CREATE TABLE `service_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(191) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `publishing_service_id` bigint(20) unsigned NOT NULL,
  `total_amount` decimal(8,2) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `instructions` text DEFAULT NULL,
  `file_path` varchar(191) DEFAULT NULL,
  `completed_file_path` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_orders_order_number_unique` (`order_number`),
  KEY `service_orders_user_id_foreign` (`user_id`),
  KEY `service_orders_publishing_service_id_foreign` (`publishing_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `email_account_requests`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `email_account_requests`;
CREATE TABLE `email_account_requests` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `webmail_messages`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `webmail_messages`;
CREATE TABLE `webmail_messages` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `app_notifications`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `app_notifications`;
CREATE TABLE `app_notifications` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `app_notifications`
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('1', '2', 'email', 'New Academic Email Request', 'Prof. S. Rahman submitted an application for s.rahman@knowdyn.org.', '/admin/cpanel-email', '✉️', '0', NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('2', '2', 'manuscript', 'Manuscript Submission #KD-8821', 'New paper \"Genomic Epidemiology of Infectious Diseases\" submitted for editorial screening.', '/admin/manuscripts', '📝', '0', NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('3', '2', 'system', 'Crossref DOI XML Verified', 'Automated schema deposit confirmed for Volume 4, Issue 2.', '/admin/articles', '⚡', '1', '2026-08-22 19:51:31', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `site_settings`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) NOT NULL,
  `value` longtext DEFAULT NULL,
  `group` varchar(191) NOT NULL DEFAULT 'general',
  `label` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `site_settings`
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('1', 'site_name', 'Knowledge Dynamics', 'general', 'Platform name', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('2', 'publisher_name', 'Knowledge Dynamics Publishing', 'general', 'Official publisher entity', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('3', 'doi_prefix', '10.58421', 'doi', 'Registered Crossref DOI Prefix', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('4', 'contact_email', 'editorial@kdpub.com', 'contact', 'Primary editorial contact email', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('5', 'support_email', 'support@kdpub.com', 'contact', 'Technical support email', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('6', 'headquarters_address', 'Knowledge Dynamics Academic Center, Stockholm, Sweden & London, UK', 'contact', 'Publishing house address', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('7', 'crossref_deposit_mode', 'automated', 'doi', 'Crossref XML schema deposit mode', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('8', 'theme_preset', 'oxford-navy', 'theme', 'Active UI theme preset', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('9', 'theme_primary_color', '#0F2A4A', 'theme', 'Primary brand color', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('10', 'theme_accent_color', '#BE123C', 'theme', 'Accent interaction color', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('11', 'theme_font_sans', 'Inter', 'theme', 'Body typography family', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('12', 'theme_font_heading', 'Playfair Display', 'theme', 'Editorial heading typography family', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('13', 'theme_border_radius', '12px', 'theme', 'UI card and element corner radius', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('14', 'cpanel_host', 'kdpub.com', 'cpanel', 'cPanel Server Hostname', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('15', 'cpanel_username', 'kdpuodtp', 'cpanel', 'cPanel Account Username', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('16', 'cpanel_api_token', 'EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q', 'cpanel', 'cPanel UAPI Access Token', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('17', 'cpanel_default_domain', 'kdpub.com', 'cpanel', 'Default Academic Email Domain', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('18', 'cpanel_port', '2083', 'cpanel', 'cPanel SSL Port', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('19', 'cpanel_webmail_port', '2096', 'cpanel', 'cPanel Webmail SSL Port', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `dynamic_pages`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `dynamic_pages`;
CREATE TABLE `dynamic_pages` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `news_events`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `news_events`;
CREATE TABLE `news_events` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `news_events`
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('1', 'Call for Papers: Special Issue on Climate Resilient Food Processing Systems', 'call-for-papers-climate-resilient-food-processing', 'announcement', 'Special Issue CFP', 'KD Food Science Nutrition invites high-impact original research papers and critical systematic reviews for an upcoming special issue on sustainable food technology.', NULL, NULL, NULL, NULL, 'December 31, 2026', '1', '1', '0', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('2', 'Knowledge Dynamics Journals Achieve Full Crossref and DOAJ Indexing Compliance', 'kd-journals-crossref-doaj-indexing-milestone', 'news', 'Publisher News', 'All five flagship Knowledge Dynamics journals have integrated real-time Crossref DOI deposit schemas and adhere to strict DOAJ open-access criteria.', NULL, NULL, NULL, NULL, NULL, '1', '1', '0', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('3', 'International Symposium on Decentralized Digital Health & Epidemiology', 'symposium-decentralized-digital-health-epidemiology-2026', 'event', 'Academic Symposium', 'A three-day hybrid symposium gathering epidemiologists, public health directors, and biomedical data scientists.', NULL, 'October 14–16, 2026', 'Virtual & Stockholm, Sweden', 'https://knowdyn.org/events/register/1', NULL, '1', '1', '0', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('4', 'Workshop: Writing for High-Impact International Open Access Journals', 'workshop-writing-for-high-impact-open-access-journals', 'workshop', 'Author Masterclass', 'Practical masterclass by Knowledge Dynamics Editors-in-Chief on structuring manuscripts, navigating peer review, and responding to reviewer critiques.', NULL, 'November 05, 2026', 'Interactive Webinar', 'https://knowdyn.org/events/register/2', NULL, '0', '1', '0', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `career_positions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `career_positions`;
CREATE TABLE `career_positions` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `activity_audit_logs`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `activity_audit_logs`;
CREATE TABLE `activity_audit_logs` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;
