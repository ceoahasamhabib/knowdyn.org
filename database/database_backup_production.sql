-- ========================================================
-- Knowledge Dynamics — 100% Accurate Production Database Dump
-- Database: kdpuodtp_kdpub | Domain: https://kdpub.com
-- Generated: 2026-08-22 20:04:01
-- Compatible with MySQL 5.7+, 8.0+, MariaDB 10.3+
-- ========================================================

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = '+00:00';

-- --------------------------------------------------------
-- Table structure for table `app_notifications`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `app_notifications`;
CREATE TABLE `app_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL,
  `type` varchar(191) NOT NULL DEFAULT 'system',
  `title` varchar(500) NOT NULL,
  `message` longtext NOT NULL,
  `link` varchar(191) NULL,
  `icon` varchar(191) NOT NULL DEFAULT '🔔',
  `is_read` int(11) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_notifications_is_read_index` (`is_read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `app_notifications`
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('1', '2', 'email', 'New Academic Email Request', 'Prof. S. Rahman submitted an application for s.rahman@knowdyn.org.', '/admin/cpanel-email', '✉️', '0', NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('2', '2', 'manuscript', 'Manuscript Submission #KD-8821', 'New paper \"Genomic Epidemiology of Infectious Diseases\" submitted for editorial screening.', '/admin/manuscripts', '📝', '0', NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('3', '2', 'system', 'Crossref DOI XML Verified', 'Automated schema deposit confirmed for Volume 4, Issue 2.', '/admin/articles', '⚡', '1', '2026-08-22 19:51:31', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `article_authors`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_authors`;
CREATE TABLE `article_authors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `email` varchar(191) NULL,
  `affiliation` varchar(191) NULL,
  `country` varchar(191) NULL,
  `orcid` varchar(191) NULL,
  `is_corresponding` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `article_authors_article_id_index` (`article_id`)
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
-- Table structure for table `article_files`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_files`;
CREATE TABLE `article_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `file_type` varchar(191) NOT NULL,
  `file_size` int(11) NULL,
  `is_primary` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `article_issue`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_issue`;
CREATE TABLE `article_issue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_issue_article_id_issue_id_unique` (`article_id`, `issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `article_issue`
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('1', '1', '1', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('2', '2', '2', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('3', '3', '3', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('4', '4', '4', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('5', '5', '5', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('6', '6', '6', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('7', '7', '7', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('8', '8', '8', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('9', '9', '9', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('10', '10', '10', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('11', '11', '11', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('12', '12', '12', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('13', '13', '13', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('14', '14', '14', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('15', '15', '15', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('16', '16', '16', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('17', '17', '17', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('18', '18', '18', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('19', '19', '19', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('20', '20', '20', '1');

-- --------------------------------------------------------
-- Table structure for table `article_keywords`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_keywords`;
CREATE TABLE `article_keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_keywords_article_id_keyword_id_unique` (`article_id`, `keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `article_references`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `article_references`;
CREATE TABLE `article_references` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `reference_text` longtext NOT NULL,
  `doi` varchar(191) NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `article_references`
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('1', '1', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('2', '2', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('3', '3', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('4', '4', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('5', '5', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('6', '6', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('7', '7', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('8', '8', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('9', '9', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('10', '10', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('11', '11', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('12', '12', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('13', '13', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('14', '14', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('15', '15', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('16', '16', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('17', '17', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('18', '18', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('19', '19', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('20', '20', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');

-- --------------------------------------------------------
-- Table structure for table `articles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `abstract` longtext NULL,
  `article_type` varchar(191) NOT NULL DEFAULT 'original-research',
  `doi` varchar(191) NULL,
  `pages` varchar(191) NULL,
  `submission_date` date NULL DEFAULT NULL,
  `acceptance_date` date NULL DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `funding` longtext NULL,
  `conflict_of_interest` longtext NULL,
  `ethics_statement` longtext NULL,
  `license` varchar(191) NULL,
  `citation_info` longtext NULL,
  `status` varchar(191) NOT NULL DEFAULT 'draft',
  `view_count` int(11) NOT NULL DEFAULT '0',
  `download_count` int(11) NOT NULL DEFAULT '0',
  `meta_title` varchar(500) NULL,
  `meta_description` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articles_doi_unique` (`doi`),
  UNIQUE KEY `articles_slug_unique` (`slug`),
  KEY `articles_published_at_index` (`published_at`),
  KEY `articles_status_index` (`status`)
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
-- Table structure for table `audit_logs`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL,
  `action` varchar(191) NOT NULL,
  `auditable_type` varchar(191) NULL,
  `auditable_id` int(11) NULL,
  `old_values` longtext NULL,
  `new_values` longtext NULL,
  `ip_address` varchar(191) NULL,
  `user_agent` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_logs_created_at_index` (`created_at`),
  KEY `audit_logs_action_index` (`action`),
  KEY `audit_logs_user_id_index` (`user_id`),
  KEY `audit_logs_auditable_type_auditable_id_index` (`auditable_type`, `auditable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `book_proposals`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `book_proposals`;
CREATE TABLE `book_proposals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `author_name` varchar(191) NOT NULL,
  `author_email` varchar(191) NOT NULL,
  `institution` varchar(191) NOT NULL,
  `book_title` varchar(500) NOT NULL,
  `subject_discipline` varchar(191) NOT NULL,
  `estimated_word_count` varchar(191) NULL,
  `target_completion_date` varchar(191) NULL,
  `synopsis_and_toc` longtext NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `notes` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `books`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `author` varchar(191) NOT NULL,
  `isbn` varchar(191) NULL,
  `year` int(11) NOT NULL DEFAULT '2024',
  `pages` int(11) NOT NULL DEFAULT '300',
  `category` varchar(191) NOT NULL DEFAULT 'Medicine & Health',
  `format` varchar(191) NOT NULL DEFAULT 'Print & eBook',
  `description` longtext NULL,
  `doi` varchar(191) NULL,
  `is_open_access` int(11) NOT NULL DEFAULT '0',
  `cover_image` varchar(191) NULL,
  `file_path` varchar(500) NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `books`
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('1', 'Advanced Methodologies in Public Health Surveillance', 'advanced-methodologies-in-public-health-surveillance', 'Prof. Dr. Sarah Al-Mansoor', '978-3-006-5501-2', '2024', '384', 'Medicine & Health', 'Print & eBook', 'A comprehensive reference text exploring epidemiological modeling, decentralized healthcare analytics, and predictive pandemic response frameworks.', '10.58421/books.2024.01', '1', NULL, NULL, '1', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('2', 'Sustainable Agricultural Systems and Functional Nutrition', 'sustainable-agricultural-systems-functional-nutrition', 'Prof. Dr. Giovanni Rossi & Dr. Lin Wei', '978-3-007-8812-9', '2024', '450', 'Food Science & Agriculture', 'Print & eBook', 'Fundamental principles of functional bioactives, micro-encapsulation technologies, and green agricultural processing paradigms.', '10.58421/books.2024.02', '0', NULL, NULL, '2', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('3', 'Maritime Trade and Cultural Synthesis in Southeast Asia', 'maritime-trade-cultural-synthesis-southeast-asia', 'Prof. Kenji Takahashi', '978-3-008-1123-6', '2023', '312', 'Asian Studies & History', 'Print & eBook', 'Archival reconstruction of historical mercantile circuits and cross-cultural synthesis across the Straits of Malacca from the 14th to 18th century.', '10.58421/books.2023.01', '1', NULL, NULL, '3', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('4', 'Econometric Modeling of ESG Integration and Capital Cost', 'econometric-modeling-esg-integration-capital-cost', 'Prof. Dr. Michael Sterling', '978-3-009-4456-3', '2023', '290', 'Business, Economics & Finance', 'eBook Only', 'Quantitative econometric frameworks evaluating how non-financial sustainability metrics influence firm debt pricing and equity volatility.', '10.58421/books.2023.02', '0', NULL, NULL, '4', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('5', 'Comparative Hermeneutics in Abrahamic Ethical Traditions', 'comparative-hermeneutics-abrahamic-ethical-traditions', 'Prof. Dr. Tariq Al-Hashimi & Dr. Miriam Cohen', '978-3-010-7789-0', '2024', '340', 'Theology & Comparative Religion', 'Print & eBook', 'Interdisciplinary textual exegesis examining ethical convergence, restorative justice, and peacebuilding principles in sacred texts.', '10.58421/books.2024.03', '1', NULL, NULL, '5', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `cache`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(191) NOT NULL,
  `value` longtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `cache_locks`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(191) NOT NULL,
  `owner` varchar(191) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `careers`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `careers`;
CREATE TABLE `careers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `department` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'Academic Editorial Role',
  `summary` longtext NULL,
  `requirements` longtext NULL,
  `is_active` int(11) NOT NULL DEFAULT '1',
  `deadline` varchar(191) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `careers_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `careers`
INSERT INTO `careers` (`id`, `title`, `slug`, `department`, `type`, `summary`, `requirements`, `is_active`, `deadline`, `created_at`, `updated_at`) VALUES ('1', 'Section Editor — Biomedical & Health Sciences', 'section-editor-biomedical-health-sciences', 'Health Dynamics Editorial Office', 'Academic Editorial Role (Part-Time / Remote)', 'We are seeking an active PhD researcher with a track record of peer-reviewed publications to oversee peer review workflows in epidemiological and clinical sciences.', '• PhD in Medicine, Public Health, Epidemiology, or related biomedical discipline.
• Minimum 5 publications in indexed Q1/Q2 journals.
• Experience in handling peer review cycles.', '1', 'Open until filled', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `careers` (`id`, `title`, `slug`, `department`, `type`, `summary`, `requirements`, `is_active`, `deadline`, `created_at`, `updated_at`) VALUES ('2', 'Managing Editor — Business, Management & Finance', 'managing-editor-business-management-finance', 'KD ABMF Publishing Group', 'Full-Time / Hybrid', 'Coordinate editorial peer review cycles, oversee reviewer assignments, and liaise with authors for high-impact empirical business research.', '• PhD or Master\'s degree in Economics, Finance, or Management.
• Minimum 3 years editorial operations experience.
• Exceptional communication and project management skills.', '1', 'September 30, 2026', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `careers` (`id`, `title`, `slug`, `department`, `type`, `summary`, `requirements`, `is_active`, `deadline`, `created_at`, `updated_at`) VALUES ('3', 'Senior Scientific Proofreader & Academic Copyeditor', 'senior-scientific-proofreader-copyeditor', 'KD Proofreading Network', 'Freelance / Remote', 'Native English PhD specialists in STEM, Economics, or Humanities to perform line-by-line language editing, structural styling, and reference validation.', '• PhD or MD from an accredited international university.
• Native English speaker.
• Demonstrated academic copyediting and proofreading proficiency.', '1', 'Continuous recruitment', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `doi_records`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `doi_records`;
CREATE TABLE `doi_records` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doi` varchar(191) NOT NULL,
  `doiable_type` varchar(191) NOT NULL,
  `doiable_id` int(11) NOT NULL,
  `provider` varchar(191) NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `registered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doi_records_doi_unique` (`doi`),
  KEY `doi_records_doiable_type_doiable_id_index` (`doiable_type`, `doiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `email_account_requests`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `email_account_requests`;
CREATE TABLE `email_account_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `requested_username` varchar(191) NOT NULL,
  `domain` varchar(191) NOT NULL DEFAULT 'knowdyn.org',
  `full_email` varchar(191) NOT NULL,
  `quota_mb` int(11) NOT NULL DEFAULT '500',
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `password_encrypted` longtext NULL,
  `rejection_reason` longtext NULL,
  `admin_notes` longtext NULL,
  `cpanel_account_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_account_requests_full_email_unique` (`full_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `failed_jobs`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` varchar(191) NOT NULL,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`, `queue`, `failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `guidelines_pages`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `guidelines_pages`;
CREATE TABLE `guidelines_pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) NOT NULL,
  `title` varchar(500) NOT NULL,
  `content` longtext NOT NULL,
  `meta_title` varchar(500) NULL,
  `meta_description` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guidelines_pages_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `guidelines_pages`
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('1', 'authors', 'Author Guidelines & Submission Instructions', '## 1. Manuscript Preparation
Authors submitting to Knowledge Dynamics journals must ensure their work is original, unpublished, and not under consideration elsewhere.

### Required Structure:
- **Title Page:** Concise title, author full names, affiliations, ORCID IDs, and designated corresponding author.
- **Structured Abstract:** Maximum 250–300 words comprising Background, Methods, Results, and Conclusions.
- **Keywords:** 4 to 6 indexing terms matching MeSH or disciplinary thesauri.
- **Main Text:** Introduction, Methods, Results, Discussion, and Conclusions.
- **Declarations:** Funding, Competing Interests, Ethics Approval, and Data Availability.

## 2. Reference Formatting
- Health Dynamics & KD Food Science: Vancouver style.
- KD Accounting, Business, Management, Finance: APA 7th Edition.
- KD Asian Studies & KD Comparative Religion: Chicago Notes & Bibliography.', 'Author Guidelines — Knowledge Dynamics', 'Official author submission instructions, referencing style guides, and manuscript structure requirements.', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('2', 'editorial-policies', 'Publication Ethics & Editorial Policies', '## 1. COPE Ethical Compliance
Knowledge Dynamics upholds zero tolerance for academic malpractice, data falsification, fraudulent authorship, and uncredited intellectual overlap.

## 2. Plagiarism Screening
All submissions undergo automated similarity screening. Duplication exceeding journal thresholds without proper citation results in immediate desk rejection.

## 3. Generative AI Transparency
AI tools cannot be listed as authors. Any AI assistance utilized in drafting or data visualization must be explicitly declared in the Methodology.', 'Publication Ethics & Policies — Knowledge Dynamics', 'COPE compliance standards, plagiarism thresholds, and authorship criteria across Knowledge Dynamics.', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('3', 'reviewers', 'Peer Reviewer Guidelines & Code of Conduct', '## 1. Confidentiality
Manuscripts under review are strictly confidential documents. Reviewers must not share drafts, datasets, or evaluation remarks with third parties.

## 2. Timeliness & Conflict of Interest
Reviewers are expected to submit thorough, constructive evaluations within 3 to 4 weeks. If a personal, financial, or institutional conflict of interest exists, reviewers must immediately recuse themselves.', 'Reviewer Guidelines — Knowledge Dynamics', 'Code of conduct, evaluation criteria, and confidentiality standards for peer reviewers.', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('4', 'editors', 'Editorial Board Roles & Responsibilities', '## 1. Editorial Independence
Editors-in-Chief and Section Editors exercise complete editorial independence. Decisions to accept or reject are grounded exclusively in academic merit, novelty, and scientific validity.

## 2. Peer Review Oversight
Handling editors ensure at least two independent double-blind peer reviews are completed before rendering editorial decisions.', 'Editor Guidelines — Knowledge Dynamics', 'Responsibilities, ethical oversight, and decision-making workflows for editorial board members.', '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('5', 'open-access', 'Open Access Statement & Policy', 'Knowledge Dynamics publishes all journal articles under the Creative Commons Attribution 4.0 International (CC BY 4.0) License. Authors retain copyright without restrictions. Content is immediately and permanently free to access worldwide.', 'Open Access Policy — Knowledge Dynamics', 'Creative Commons CC BY 4.0 licensing, author rights, and self-archiving policies.', '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `issues`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `volume_id` int(11) NOT NULL,
  `number` varchar(191) NOT NULL,
  `title` varchar(500) NULL,
  `description` longtext NULL,
  `cover_image` varchar(191) NULL,
  `published_at` date NULL DEFAULT NULL,
  `is_current` int(11) NOT NULL DEFAULT '0',
  `status` varchar(191) NOT NULL DEFAULT 'draft',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issues_published_at_index` (`published_at`),
  KEY `issues_status_index` (`status`),
  KEY `issues_volume_id_number_index` (`volume_id`, `number`)
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
-- Table structure for table `job_batches`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` longtext NULL,
  `cancelled_at` int(11) NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `jobs`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` int(11) NOT NULL,
  `reserved_at` int(11) NULL,
  `available_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `journal_editorial_members`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `journal_editorial_members`;
CREATE TABLE `journal_editorial_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL,
  `user_id` int(11) NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NULL,
  `institution` varchar(191) NULL,
  `country` varchar(191) NULL,
  `role` varchar(191) NOT NULL,
  `biography` longtext NULL,
  `orcid` varchar(191) NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `is_active` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journal_editorial_members_sort_order_index` (`sort_order`),
  KEY `journal_editorial_members_journal_id_role_index` (`journal_id`, `role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `journal_editorial_members`
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('1', '1', NULL, 'Prof. Dr. Sarah Al-Mansoor', NULL, 'Karolinska Institute', 'Sweden', 'Editor-in-Chief', NULL, '0000-0001-5234-9981', '1', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('2', '1', NULL, 'Dr. Marcus Vance', NULL, 'Johns Hopkins University', 'United States', 'Associate Editor', NULL, '0000-0002-3984-1102', '2', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('3', '1', NULL, 'Dr. Elena Rostova', NULL, 'University of Zurich', 'Switzerland', 'Managing Editor', NULL, '0000-0003-8812-4431', '3', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('4', '1', NULL, 'Prof. Hiroshi Tanaka', NULL, 'University of Tokyo', 'Japan', 'Section Editor', NULL, '0000-0002-9901-7764', '4', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('5', '2', NULL, 'Prof. Dr. Giovanni Rossi', NULL, 'University of Bologna', 'Italy', 'Editor-in-Chief', NULL, '0000-0002-4112-9988', '1', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('6', '2', NULL, 'Dr. Lin Wei', NULL, 'Zhejiang University', 'China', 'Associate Editor', NULL, '0000-0003-1288-7734', '2', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('7', '2', NULL, 'Dr. Rachel Green', NULL, 'University of Melbourne', 'Australia', 'Editorial Board Member', NULL, '0000-0001-9923-4512', '3', '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('8', '3', NULL, 'Prof. Kenji Takahashi', NULL, 'Kyoto University', 'Japan', 'Editor-in-Chief', NULL, '0000-0002-8819-2341', '1', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('9', '3', NULL, 'Dr. Sunita Sharma', NULL, 'Jawaharlal Nehru University', 'India', 'Managing Editor', NULL, '0000-0001-6542-8890', '2', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('10', '3', NULL, 'Dr. Arthur Pendelton', NULL, 'SOAS University of London', 'United Kingdom', 'Editorial Board Member', NULL, '0000-0003-4412-0091', '3', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('11', '4', NULL, 'Prof. Dr. Michael Sterling', NULL, 'London School of Economics', 'United Kingdom', 'Editor-in-Chief', NULL, '0000-0002-1200-9832', '1', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('12', '4', NULL, 'Dr. Fatima Zahra', NULL, 'INSEAD', 'France', 'Associate Editor', NULL, '0000-0003-8821-4329', '2', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('13', '4', NULL, 'Dr. Robert Zhang', NULL, 'National University of Singapore', 'Singapore', 'Editorial Board Member', NULL, '0000-0001-9923-0012', '3', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('14', '5', NULL, 'Prof. Dr. Tariq Al-Hashimi', NULL, 'Oxford University', 'United Kingdom', 'Editor-in-Chief', NULL, '0000-0002-3321-7788', '1', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('15', '5', NULL, 'Dr. Miriam Cohen', NULL, 'Hebrew University of Jerusalem', 'Israel', 'Associate Editor', NULL, '0000-0001-7721-3490', '2', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('16', '5', NULL, 'Prof. Peter Holmgren', NULL, 'Uppsala University', 'Sweden', 'Editorial Board Member', NULL, '0000-0003-1288-0044', '3', '1', '2026-08-22 19:51:30', '2026-08-22 19:51:30');

-- --------------------------------------------------------
-- Table structure for table `journal_settings`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `journal_settings`;
CREATE TABLE `journal_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL,
  `peer_review_process` longtext NULL,
  `publication_ethics` longtext NULL,
  `author_guidelines` longtext NULL,
  `copyright_notice` longtext NULL,
  `privacy_statement` longtext NULL,
  `author_fees` longtext NULL,
  `open_access_policy` longtext NULL,
  `archiving_policy` longtext NULL,
  `plagiarism_policy` longtext NULL,
  `section_policies` longtext NULL,
  `journal_history` longtext NULL,
  `review_model` varchar(191) NOT NULL DEFAULT 'double_blind',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `journal_settings_journal_id_unique` (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `journal_settings`
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('1', '1', 'All manuscripts undergo rigorous double-blind peer review by at least two independent expert reviewers with a typical turnaround time of 4-6 weeks.', 'Health Dynamics strictly adheres to COPE guidelines and ICMJE standards for ethical medical publishing and research integrity.', 'Articles must follow Vancouver referencing style, provide structured abstracts (Background, Methods, Results, Conclusion), and disclose all funding sources.', 'Authors retain copyright without restrictions.', NULL, NULL, 'Immediate open access under CC BY 4.0 license.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('2', '2', 'Independent double-blind peer review by international nutrition and food chemistry scholars.', 'Strict adherence to COPE and food research integrity guidelines.', 'Follow APA 7th Edition style. Detailed nutritional tables and chemical purity analytical standards must be supplied.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 19:51:29', '2026-08-22 19:51:29');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('3', '3', 'Rigorous double-blind peer review by regional specialists and area-studies academics.', 'Full COPE compliance.', 'Chicago Manual of Style (Notes & Bibliography or Author-Date) referencing required.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('4', '4', 'Rigorous double-blind peer review emphasizing methodological rigor and empirical econometric validation.', 'Full COPE compliance.', 'APA 7th Edition or Harvard referencing style. Data replication packages are encouraged.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 19:51:30', '2026-08-22 19:51:30');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('5', '5', 'Standard double-blind peer review by international theologians, philosophers, and religious studies scholars.', 'Full COPE compliance.', 'Chicago Manual of Style (Notes & Bibliography) required for text citations and source references.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 19:51:30', '2026-08-22 19:51:30');

-- --------------------------------------------------------
-- Table structure for table `journals`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `journals`;
CREATE TABLE `journals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `short_title` varchar(500) NULL,
  `description` longtext NULL,
  `aims_and_scope` longtext NULL,
  `issn_print` varchar(191) NULL,
  `issn_online` varchar(191) NULL,
  `publisher` varchar(191) NOT NULL DEFAULT 'Knowledge Dynamics',
  `publication_frequency` varchar(191) NULL,
  `cover_image` varchar(191) NULL,
  `thumbnail` varchar(191) NULL,
  `contact_email` varchar(191) NULL,
  `contact_phone` varchar(191) NULL,
  `website` varchar(191) NULL,
  `status` varchar(191) NOT NULL DEFAULT 'active',
  `is_open_access` int(11) NOT NULL DEFAULT '1',
  `established_year` int(11) NULL,
  `meta_title` varchar(500) NULL,
  `meta_description` longtext NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `journals_slug_unique` (`slug`),
  KEY `journals_sort_order_index` (`sort_order`),
  KEY `journals_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `journals`
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('1', 'Health Dynamics', 'health-dynamics', 'Health Dyn.', 'A peer-reviewed, open-access multidisciplinary journal publishing high-impact research, clinical insights, and healthcare management innovations.', 'Health Dynamics is dedicated to advancing the frontiers of medical sciences, public health policy, epidemiology, biomedical innovations, and healthcare delivery systems.

The journal welcomes original research papers, systematic reviews, clinical trials, meta-analyses, and methodological advances addressing urgent global healthcare challenges.', '3006-550X', '3006-5518', 'Knowledge Dynamics', 'Bi-monthly', NULL, NULL, 'editor.hd@knowdyn.org', NULL, NULL, 'active', '1', '2021', NULL, NULL, '1', '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('2', 'KD Food Science Nutrition', 'kd-food-science-nutrition', 'KD Food Sci. Nutr.', 'Advancing sustainable agricultural food processing, functional nutraceutical bioactives, molecular food safety, and global human nutritional health.', 'KD Food Science Nutrition provides a global peer-reviewed forum for groundbreaking discoveries in food biotechnology, nutrient bioavailability, sensory analysis, food chemistry, shelf-life modeling, and sustainable food packaging solutions.', '3007-8812', '3007-8820', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.fsn@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '2', '2026-08-22 19:51:29', '2026-08-22 19:51:29', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('3', 'KD Asian Studies', 'kd-asian-studies', 'KD Asian Stud.', 'A premier international journal exploring Asian geopolitical dynamics, socioeconomic transformations, cultural heritage, history, and linguistic evolution.', 'KD Asian Studies publishes interdisciplinary scholarship covering East, South, Southeast, and Central Asia. The journal bridges contemporary sociopolitical analysis with historical, archaeological, and literary perspectives.', '3008-1123', '3008-1131', 'Knowledge Dynamics', 'Bi-annual', NULL, NULL, 'editor.as@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '3', '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('4', 'KD Accounting, Business, Management, Finance', 'kd-accounting-business-management-finance', 'KD ABMF', 'Fostering empirical research in corporate governance, financial econometrics, fintech disruptions, organizational management, and ESG sustainability reporting.', 'KD ABMF serves corporate leaders, financial economists, and management scholars by publishing rigorous research on capital markets, algorithmic trading, audit quality, executive leadership, and green business models.', '3009-4456', '3009-4464', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.abmf@knowdyn.org', NULL, NULL, 'active', '1', '2023', NULL, NULL, '4', '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('5', 'KD Comparative Religion', 'kd-comparative-religion', 'KD Comp. Relig.', 'A scholarly platform for interfaith dialogues, hermeneutical text studies, sociology of religion, ethics, and contemporary theological discourse.', 'KD Comparative Religion fosters rigorous critical scholarship examining religious traditions, historical theology, sacred texts, philosophical ethics, and the role of faith communities in contemporary global society.', '3010-7789', '3010-7797', 'Knowledge Dynamics', 'Bi-annual', NULL, NULL, 'editor.cr@knowdyn.org', NULL, NULL, 'active', '1', '2023', NULL, NULL, '5', '2026-08-22 19:51:30', '2026-08-22 19:51:30', NULL);

-- --------------------------------------------------------
-- Table structure for table `keywords`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keywords_slug_unique` (`slug`),
  UNIQUE KEY `keywords_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `legacy_url_mappings`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `legacy_url_mappings`;
CREATE TABLE `legacy_url_mappings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(500) NOT NULL,
  `new_url` varchar(500) NOT NULL,
  `status_code` int(11) NOT NULL DEFAULT '301',
  `entity_type` varchar(191) NULL,
  `entity_id` int(11) NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `legacy_url_mappings_old_url_index` (`old_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscript_authors`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscript_authors`;
CREATE TABLE `manuscript_authors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` int(11) NOT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `email` varchar(191) NULL,
  `affiliation` varchar(191) NULL,
  `orcid` varchar(191) NULL,
  `is_corresponding` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscript_files`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscript_files`;
CREATE TABLE `manuscript_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` int(11) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `file_type` varchar(191) NOT NULL,
  `file_size` int(11) NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscript_status_history`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscript_status_history`;
CREATE TABLE `manuscript_status_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` int(11) NOT NULL,
  `user_id` int(11) NULL,
  `from_status` varchar(191) NULL,
  `to_status` varchar(191) NOT NULL,
  `comment` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `manuscripts`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `manuscripts`;
CREATE TABLE `manuscripts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `abstract` longtext NULL,
  `article_type` varchar(191) NOT NULL DEFAULT 'original-research',
  `status` varchar(191) NOT NULL DEFAULT 'draft',
  `editor_id` int(11) NULL,
  `article_id` int(11) NULL,
  `funding` longtext NULL,
  `conflict_of_interest` longtext NULL,
  `ethics_statement` longtext NULL,
  `cover_letter` longtext NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `decided_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manuscripts_submitted_at_index` (`submitted_at`),
  KEY `manuscripts_journal_id_status_index` (`journal_id`, `status`),
  KEY `manuscripts_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `migrations`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
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
-- Table structure for table `model_has_permissions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`permission_id`, `model_type`, `model_id`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`, `model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `model_has_roles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`role_id`, `model_type`, `model_id`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`, `model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `model_has_roles`
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('1', 'App\\Models\\User', '1');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('2', 'App\\Models\\User', '1');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('1', 'App\\Models\\User', '2');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('2', 'App\\Models\\User', '2');

-- --------------------------------------------------------
-- Table structure for table `news_events`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `news_events`;
CREATE TABLE `news_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'news',
  `category` varchar(191) NULL,
  `summary` longtext NULL,
  `content` longtext NULL,
  `event_date` varchar(191) NULL,
  `location` varchar(191) NULL,
  `registration_url` varchar(500) NULL,
  `deadline` varchar(191) NULL,
  `is_featured` int(11) NOT NULL DEFAULT '0',
  `is_published` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
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
-- Table structure for table `pages`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `content` longtext NULL,
  `is_published` int(11) NOT NULL DEFAULT '0',
  `meta_title` varchar(500) NULL,
  `meta_description` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`, `guard_name`)
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
-- Table structure for table `project_members`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `project_members`;
CREATE TABLE `project_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(191) NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_members_project_id_user_id_unique` (`project_id`, `user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `projects`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `summary` longtext NULL,
  `research_area` varchar(191) NULL,
  `status` varchar(191) NOT NULL DEFAULT 'planning',
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `institution` varchar(191) NULL,
  `external_url` varchar(500) NULL,
  `is_public` int(11) NOT NULL DEFAULT '1',
  `meta_title` varchar(500) NULL,
  `meta_description` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_slug_unique` (`slug`),
  KEY `projects_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `researcher_affiliations`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `researcher_affiliations`;
CREATE TABLE `researcher_affiliations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `researcher_profile_id` int(11) NOT NULL,
  `institution` varchar(191) NOT NULL,
  `department` varchar(191) NULL,
  `position` varchar(191) NULL,
  `country` varchar(191) NULL,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `is_current` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `researcher_interests`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `researcher_interests`;
CREATE TABLE `researcher_interests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `researcher_profile_id` int(11) NOT NULL,
  `interest` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `researcher_interests_interest_index` (`interest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `researcher_profiles`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `researcher_profiles`;
CREATE TABLE `researcher_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `biography` longtext NULL,
  `institution` varchar(191) NULL,
  `department` varchar(191) NULL,
  `country` varchar(191) NULL,
  `city` varchar(191) NULL,
  `orcid` varchar(191) NULL,
  `google_scholar` varchar(191) NULL,
  `linkedin` varchar(191) NULL,
  `website` varchar(191) NULL,
  `research_gate` varchar(191) NULL,
  `expertise` longtext NULL,
  `is_public` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `researcher_profiles_user_id_unique` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `review_assignments`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `review_assignments`;
CREATE TABLE `review_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'pending',
  `due_date` date NULL DEFAULT NULL,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `responded_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_assignments_reviewer_id_index` (`reviewer_id`),
  KEY `review_assignments_manuscript_id_status_index` (`manuscript_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `reviews`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `review_assignment_id` int(11) NOT NULL,
  `recommendation` varchar(191) NOT NULL,
  `comments_to_editor` longtext NULL,
  `comments_to_author` longtext NULL,
  `quality_score` int(11) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_review_assignment_id_unique` (`review_assignment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `role_has_permissions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`permission_id`, `role_id`)
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
  UNIQUE KEY `roles_name_guard_name_unique` (`name`, `guard_name`)
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
-- Table structure for table `service_requests`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `service_requests`;
CREATE TABLE `service_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `user_id` int(11) NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NULL,
  `message` longtext NULL,
  `status` varchar(191) NOT NULL DEFAULT 'submitted',
  `assigned_to` int(11) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_requests_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `services`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` longtext NULL,
  `features` longtext NULL,
  `process` longtext NULL,
  `faq` longtext NULL,
  `cta_text` varchar(191) NULL,
  `cta_url` varchar(500) NULL,
  `icon` varchar(191) NULL,
  `is_active` int(11) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `meta_title` varchar(500) NULL,
  `meta_description` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `services_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `services`
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('1', 'KD Proofreading & Language Editing', 'kd-proofreading', 'Comprehensive academic English editing and proofreading by native PhD subject specialists. Ensures 100% grammar accuracy, natural academic flow, and adherence to target journal guidelines.', '[\"Native PhD subject-matter editors\",\"Grammar, syntax, and punctuation refinement\",\"Discipline-specific terminology verification\",\"Target journal guideline alignment (APA, Vancouver, IEEE)\",\"Official Certificate of Academic Editing\",\"Free re-editing support for revised submissions\"]', '1. Submit your manuscript and select turnaround (Standard 5-7d, Express 48h, Rush 24h).
2. Assigned to a certified PhD editor in your scientific domain.
3. Detailed two-pass editorial review and track-changes markup.
4. Quality assurance check by senior managing editor.
5. Download edited manuscript and official editing certificate.', NULL, NULL, NULL, 'proofreading', '1', '1', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('2', 'Manuscript Copyediting & Styling', 'manuscript-editing', 'Structural, developmental, and stylistic editing to enhance manuscript clarity, logical argumentation, and narrative cohesion before submission to high-impact journals.', '[\"Macro-structural flow and argumentation review\",\"Abstract and introduction impact optimization\",\"Clarity and conciseness improvements\",\"Journal cover letter crafting\"]', '1. Manuscript submission and target journal evaluation.
2. In-depth structural and stylistic review by senior editor.
3. Author query resolution and final delivery.', NULL, NULL, NULL, 'editing', '1', '2', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('3', 'Academic Translation Services', 'academic-translation', 'Discipline-specific scholarly translation between English and 15+ major global academic languages by bilingual PhD researchers.', '[\"Bilingual academic subject-matter translators\",\"Preservation of nuanced technical terminology\",\"Two-step translation + native English copyedit\",\"Quality guarantee for journal peer review\"]', '1. Upload source language manuscript.
2. Primary translation by domain expert scholar.
3. Native English editorial refinement and terminological consistency check.
4. Final quality inspection and delivery.', NULL, NULL, NULL, 'translation', '1', '3', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('4', 'Academic Figure & Illustration Formatting', 'academic-formatting', 'High-resolution graphical abstract design, figure enhancement, statistical chart styling, and typography formatting meeting strict publisher raster (300+ DPI) and vector requirements.', '[\"Publication-quality 300\\/600 DPI vector and raster figures\",\"Custom Graphical Abstract design\",\"Scientific infographic visualization\",\"TIFF, EPS, PDF, and high-res PNG export\"]', '1. Upload draft figures, sketches, or raw datasets.
2. Scientific illustrator crafts publication-ready graphics.
3. Author review and unlimited minor revisions.', NULL, NULL, NULL, 'figures', '1', '4', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('5', 'Similarity Index & Plagiarism Reduction', 'plagiarism-screening', 'Pre-submission similarity screening and ethical rewording to resolve flagged overlapping passages and ensure high academic integrity without altering empirical findings.', '[\"Comprehensive similarity index percentage report\",\"Sentence-by-sentence flagged overlap analysis\",\"Expert academic rephrasing of duplicate phrases\",\"Confidential scanning without repository storage\"]', '1. Upload manuscript file for confidential screening.
2. Automated scan against global academic databases.
3. Editorial rephrasing of overlapping text.
4. Receive similarity report under target journal threshold (< 10-15%).', NULL, NULL, NULL, 'plagiarism', '1', '5', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('6', 'AI Index & Paraphrasing Reduction', 'ai-index-reduction', 'Humanizing and academically refining AI-assisted text to remove formulaic syntax, repetitive phrasing, and generic patterns while elevating human scientific voice.', '[\"Deep editorial rewrite of AI-generated\\/assisted drafts\",\"Restoration of natural, authoritative scientific voice\",\"Verification of factual and citation authenticity\",\"Pre-submission AI detection screening validation\"]', '1. Upload manuscript containing AI-drafted sections.
2. PhD specialist manually rewrites and enriches context.
3. Rigorous cross-check against AI pattern detectors.
4. Clean, authentic academic manuscript delivery.', NULL, NULL, NULL, 'ai-reduction', '1', '6', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('7', 'Research Grant & Publication Consultancy', 'publication-consultancy', 'Strategic publication planning, journal selection advisory, grant proposal review, and response-to-reviewers rebuttal consultation to maximize research reach and funding success.', '[\"Aims and scope journal matching matrix\",\"Grant proposal competitiveness review\",\"Editorial rebuttal letter strategizing\",\"Post-publication research impact amplification\"]', '1. Initial research portfolio assessment.
2. 1-on-1 strategy session with senior publication consultant.
3. Actionable roadmap and submission guidance report.', NULL, NULL, NULL, 'consultancy', '1', '7', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('8', 'Journal Publishing & Hosting Solutions', 'journal-publishing', 'End-to-end open-access journal publishing infrastructure, editorial workflow management, OJS/custom platform hosting, indexing support, and digital preservation.', '[\"Full journal setup with custom domain and ISSN\",\"Automated editorial and peer-review workflows\",\"DOAJ, Scopus, and WoS indexing readiness\",\"Long-term archival preservation (Portico\\/CLOCKSS ready)\"]', '1. Initial institutional consultation and journal scoping.
2. Technical setup and editorial board configuration.
3. Launch, indexing application, and ongoing publishing operations.', NULL, NULL, NULL, 'journal', '1', '8', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('9', 'DOI & Crossref Metadata Deposit Service', 'doi-metadata-support', 'Digital Object Identifier (DOI) minting, Crossref XML schema deposit, scholarly metadata enrichment, and citation tracking integration for academic publishers and institutions.', '[\"Crossref DOI prefix allocation and registration\",\"Automated XML deposit with rich metadata\",\"Reference linking and Cited-by tracking\",\"ORCID auto-update integration\"]', '1. Connect journal or repository archive.
2. Automated metadata extraction and schema validation.
3. Official Crossref deposit and permanent DOI resolution.', NULL, NULL, NULL, 'doi', '1', '9', NULL, NULL, '2026-08-22 19:51:31', '2026-08-22 19:51:31');

-- --------------------------------------------------------
-- Table structure for table `sessions`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL,
  `ip_address` varchar(191) NULL,
  `user_agent` longtext NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_last_activity_index` (`last_activity`),
  KEY `sessions_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `settings`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` longtext NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_group_key_unique` (`group`, `key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table `site_settings`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) NOT NULL,
  `value` longtext NULL,
  `group` varchar(191) NOT NULL DEFAULT 'general',
  `description` varchar(191) NULL,
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
-- Table structure for table `users`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `remember_token` varchar(191) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(191) NULL,
  `last_name` varchar(191) NULL,
  `username` varchar(191) NULL,
  `phone` varchar(191) NULL,
  `avatar` varchar(500) NULL,
  `status` varchar(191) NOT NULL DEFAULT 'active',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `users`
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `username`, `phone`, `avatar`, `status`, `deleted_at`) VALUES ('1', 'KD Admin', 'admin@knowledge-dynamics.com', '2026-08-22 19:51:28', '$2y$12$41ehclOh0SOvUUSvACOQi.J10XKaLHg8dqtJ4qTHYrQrBuvs8wsDa', NULL, '2026-08-22 19:51:28', '2026-08-22 19:51:28', 'KD', 'Admin', 'kdadmin', NULL, NULL, 'active', NULL);
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `first_name`, `last_name`, `username`, `phone`, `avatar`, `status`, `deleted_at`) VALUES ('2', 'Super Administrator', 'admin@knowdyn.org', '2026-08-22 19:51:29', '$2y$12$TpWQtX8eRunb.GjbmY5vNuGXV7TRmdVZGJKdMIHhxtcbYRYBcq/xu', NULL, '2026-08-22 19:51:29', '2026-08-22 19:51:29', 'Super', 'Admin', 'superadmin', NULL, NULL, 'active', NULL);

-- --------------------------------------------------------
-- Table structure for table `volumes`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;
CREATE TABLE `volumes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `title` varchar(500) NULL,
  `description` longtext NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volumes_year_index` (`year`),
  UNIQUE KEY `volumes_journal_id_number_unique` (`journal_id`, `number`)
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
-- Table structure for table `webmail_messages`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `webmail_messages`;
CREATE TABLE `webmail_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email_account_request_id` int(11) NULL,
  `folder` varchar(191) NOT NULL DEFAULT 'inbox',
  `from_name` varchar(191) NULL,
  `from_email` varchar(191) NOT NULL,
  `to_email` varchar(191) NOT NULL,
  `cc_email` varchar(191) NULL,
  `subject` varchar(191) NOT NULL,
  `body_html` longtext NULL,
  `body_text` longtext NULL,
  `is_read` int(11) NOT NULL DEFAULT '0',
  `is_starred` int(11) NOT NULL DEFAULT '0',
  `has_attachments` int(11) NOT NULL DEFAULT '0',
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;
