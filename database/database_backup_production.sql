-- Knowledge Dynamics Complete Production Database Dump
-- Ready for cPanel / phpMyAdmin 1-Click Import
-- Domain: https://kdpub.com

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `app_notifications`;
CREATE TABLE `app_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'system',
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `icon` varchar(20) NOT NULL DEFAULT '?',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_notifications_user_id_foreign` (`user_id`),
  KEY `app_notifications_is_read_index` (`is_read`),
  CONSTRAINT `app_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('1', '2', 'email', 'New Academic Email Request', 'Prof. S. Rahman submitted an application for s.rahman@knowdyn.org.', '/admin/cpanel-email', '✉️', '1', '2026-08-22 17:05:45', '2026-08-22 17:01:36', '2026-08-22 17:05:45');
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('2', '2', 'manuscript', 'Manuscript Submission #KD-8821', 'New paper \"Genomic Epidemiology of Infectious Diseases\" submitted for editorial screening.', '/admin/manuscripts', '📝', '1', '2026-08-22 17:05:45', '2026-08-22 17:01:36', '2026-08-22 17:05:45');
INSERT INTO `app_notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `icon`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES ('3', '2', 'system', 'Crossref DOI XML Verified', 'Automated schema deposit confirmed for Volume 4, Issue 2.', '/admin/articles', '⚡', '1', '2026-08-22 17:01:36', '2026-08-22 17:01:36', '2026-08-22 17:01:36');

DROP TABLE IF EXISTS `article_authors`;
CREATE TABLE `article_authors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `affiliation` varchar(500) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `orcid` varchar(50) DEFAULT NULL,
  `is_corresponding` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `article_authors_user_id_foreign` (`user_id`),
  KEY `article_authors_article_id_index` (`article_id`),
  CONSTRAINT `article_authors_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `article_authors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('1', '1', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('2', '1', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('3', '2', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('4', '2', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('5', '3', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('6', '3', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('7', '4', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('8', '4', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('9', '5', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('10', '5', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('11', '6', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('12', '6', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('13', '7', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('14', '7', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('15', '8', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('16', '8', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('17', '9', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('18', '9', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('19', '10', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('20', '10', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('21', '11', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('22', '11', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('23', '12', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@ki.se', 'Department of Public Health, Karolinska Institute', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('24', '12', NULL, 'Dr. Marcus', 'Vance', 'mvance@jhu.edu', 'Johns Hopkins Bloomberg School of Public Health', 'United States', '0000-0002-3984-1102', '0', '2');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('25', '13', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('26', '14', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('27', '15', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('28', '16', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('29', '17', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('30', '18', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('31', '19', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('32', '20', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('33', '21', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('34', '22', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('35', '23', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('36', '24', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('37', '25', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('38', '26', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('39', '27', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('40', '28', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('41', '29', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('42', '30', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('43', '31', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');
INSERT INTO `article_authors` (`id`, `article_id`, `user_id`, `first_name`, `last_name`, `email`, `affiliation`, `country`, `orcid`, `is_corresponding`, `sort_order`) VALUES ('44', '32', NULL, 'Prof. Dr. Sarah', 'Al-Mansoor', 'sarah.mansoor@knowdyn.org', 'International Institute of Advanced Studies', 'Sweden', '0000-0001-5234-9981', '1', '1');

DROP TABLE IF EXISTS `article_files`;
CREATE TABLE `article_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `file_path` varchar(1000) NOT NULL,
  `file_name` varchar(500) NOT NULL,
  `file_type` varchar(50) NOT NULL,
  `file_size` bigint(20) unsigned DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `article_files_article_id_foreign` (`article_id`),
  CONSTRAINT `article_files_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `article_issue`;
CREATE TABLE `article_issue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `issue_id` bigint(20) unsigned NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_issue_article_id_issue_id_unique` (`article_id`,`issue_id`),
  KEY `article_issue_issue_id_foreign` (`issue_id`),
  CONSTRAINT `article_issue_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `article_issue_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('13', '13', '1', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('14', '14', '2', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('15', '15', '4', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('16', '16', '5', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('17', '17', '19', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('18', '18', '20', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('19', '19', '21', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('20', '20', '22', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('21', '21', '23', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('22', '22', '24', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('23', '23', '25', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('24', '24', '26', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('25', '25', '27', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('26', '26', '28', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('27', '27', '29', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('28', '28', '30', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('29', '29', '31', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('30', '30', '32', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('31', '31', '33', '1');
INSERT INTO `article_issue` (`id`, `article_id`, `issue_id`, `sort_order`) VALUES ('32', '32', '34', '1');

DROP TABLE IF EXISTS `article_keywords`;
CREATE TABLE `article_keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `keyword_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_keywords_article_id_keyword_id_unique` (`article_id`,`keyword_id`),
  KEY `article_keywords_keyword_id_foreign` (`keyword_id`),
  CONSTRAINT `article_keywords_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `article_keywords_keyword_id_foreign` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('1', '1', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('2', '1', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('3', '1', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('4', '2', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('5', '2', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('6', '2', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('7', '3', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('8', '3', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('9', '3', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('10', '4', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('11', '4', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('12', '4', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('13', '5', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('14', '5', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('15', '5', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('16', '6', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('17', '6', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('18', '6', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('19', '7', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('20', '7', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('21', '7', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('22', '8', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('23', '8', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('24', '8', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('25', '9', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('26', '9', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('27', '9', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('28', '10', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('29', '10', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('30', '10', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('31', '11', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('32', '11', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('33', '11', '3');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('34', '12', '1');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('35', '12', '2');
INSERT INTO `article_keywords` (`id`, `article_id`, `keyword_id`) VALUES ('36', '12', '3');

DROP TABLE IF EXISTS `article_references`;
CREATE TABLE `article_references` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) unsigned NOT NULL,
  `reference_text` text NOT NULL,
  `doi` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `article_references_article_id_foreign` (`article_id`),
  CONSTRAINT `article_references_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('1', '1', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('2', '1', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('3', '2', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('4', '2', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('5', '3', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('6', '3', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('7', '4', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('8', '4', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('9', '5', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('10', '5', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('11', '6', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('12', '6', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('13', '7', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('14', '7', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('15', '8', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('16', '8', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('17', '9', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('18', '9', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('19', '10', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('20', '10', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('21', '11', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('22', '11', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('23', '12', 'World Health Organization. (2024). Global health strategies and epidemiological monitoring frameworks. Geneva: WHO.', '10.1016/j.who.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('24', '12', 'Campbell, D. K., & Chen, R. (2023). Decentralized clinical decision support systems. Lancet Digital Health, 5(4), e210-e221.', '10.1016/S2589-7500(23)00045-8', '2');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('25', '13', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('26', '14', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('27', '15', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('28', '16', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('29', '17', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('30', '18', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('31', '19', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('32', '20', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('33', '21', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('34', '22', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('35', '23', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('36', '24', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('37', '25', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('38', '26', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('39', '27', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('40', '28', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('41', '29', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('42', '30', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('43', '31', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');
INSERT INTO `article_references` (`id`, `article_id`, `reference_text`, `doi`, `sort_order`) VALUES ('44', '32', 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.', '10.58421/ref.2024.01', '1');

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `title` varchar(1000) NOT NULL,
  `slug` varchar(1000) NOT NULL,
  `abstract` text DEFAULT NULL,
  `article_type` varchar(50) NOT NULL DEFAULT 'original-research',
  `doi` varchar(255) DEFAULT NULL,
  `pages` varchar(50) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `acceptance_date` date DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `funding` text DEFAULT NULL,
  `conflict_of_interest` text DEFAULT NULL,
  `ethics_statement` text DEFAULT NULL,
  `license` varchar(100) DEFAULT NULL,
  `citation_info` text DEFAULT NULL,
  `status` enum('draft','published','retracted') NOT NULL DEFAULT 'draft',
  `view_count` int(10) unsigned NOT NULL DEFAULT 0,
  `download_count` int(10) unsigned NOT NULL DEFAULT 0,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articles_doi_unique` (`doi`),
  UNIQUE KEY `articles_slug_unique` (`slug`) USING HASH,
  KEY `articles_journal_id_foreign` (`journal_id`),
  KEY `articles_status_index` (`status`),
  KEY `articles_published_at_index` (`published_at`),
  FULLTEXT KEY `articles_title_fulltext` (`title`),
  FULLTEXT KEY `articles_abstract_fulltext` (`abstract`),
  CONSTRAINT `articles_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('1', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (1.1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-1-1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v1i1.01', '1-18', '2021-01-10', '2021-02-28', '2021-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(1), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('2', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (1.2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-1-2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v1i2.01', '1-18', '2021-01-10', '2021-02-28', '2021-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(2), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('3', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (1.3)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-1-3', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v1i3.01', '1-18', '2021-01-10', '2021-02-28', '2021-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(3), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('4', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (2.1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-2-1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v2i1.01', '1-18', '2022-01-10', '2022-02-28', '2022-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(1), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('5', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (2.2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-2-2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v2i2.01', '1-18', '2022-01-10', '2022-02-28', '2022-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(2), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('6', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (2.3)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-2-3', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v2i3.01', '1-18', '2022-01-10', '2022-02-28', '2022-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(3), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('7', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (3.1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-3-1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v3i1.01', '1-18', '2023-01-10', '2023-02-28', '2023-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2023, 3(1), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('8', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (3.2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-3-2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v3i2.01', '1-18', '2023-01-10', '2023-02-28', '2023-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2023, 3(2), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('9', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (3.3)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-3-3', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v3i3.01', '1-18', '2023-01-10', '2023-02-28', '2023-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2023, 3(3), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('10', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (4.1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-4-1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v4i1.01', '1-18', '2024-01-10', '2024-02-28', '2024-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2024, 4(1), 1-18.', 'published', '7', '0', NULL, NULL, '2026-08-22 14:13:32', '2026-08-22 14:20:28', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('11', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (4.2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-4-2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v4i2.01', '1-18', '2024-01-10', '2024-02-28', '2024-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2024, 4(2), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('12', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (4.3)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-4-3', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/healthdynamics.v4i3.01', '1-18', '2024-01-10', '2024-02-28', '2024-03-15 10:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2024, 4(3), 1-18.', 'published', '0', '0', NULL, NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('13', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 1, No. 1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v1-i1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v1i1.01', '1-16', '2021-01-15', '2021-02-28', '2021-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:51', '2026-08-22 15:13:51', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('14', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 1, No. 2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v1-i2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v1i2.01', '1-16', '2021-01-15', '2021-02-28', '2021-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2021, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:51', '2026-08-22 15:13:51', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('15', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 2, No. 1)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v2-i1', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v2i1.01', '1-16', '2022-01-15', '2022-02-28', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:51', '2026-08-22 15:13:51', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('16', '1', 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems (Vol. 2, No. 2)', 'epidemiological-surveillance-and-digital-healthcare-interventions-in-post-pandemic-systems-health-dynamics-v2-i2', 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.', 'original-research', '10.58421/health-dynamics.v2i2.01', '1-16', '2022-01-15', '2022-02-28', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'Health Dynamics 2022, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:51', '2026-08-22 15:13:51', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('17', '3', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 1, No. 1)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v1-i1', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v1i1.01', '1-16', '2022-01-15', '2022-02-28', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2022, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('18', '3', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 1, No. 2)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v1-i2', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v1i2.01', '1-16', '2022-01-15', '2022-02-28', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2022, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('19', '3', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 2, No. 1)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v2-i1', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v2i1.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2023, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('20', '3', 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability (Vol. 2, No. 2)', 'encapsulation-of-bioactive-polyphenols-for-enhanced-intestinal-bioavailability-and-oxidative-stability-kd-food-science-nutrition-v2-i2', 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.', 'original-research', '10.58421/kd-food-science-nutrition.v2i2.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Food Science Nutrition 2023, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('21', '4', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 1, No. 1)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v1-i1', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v1i1.01', '1-16', '2022-01-15', '2022-02-28', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2022, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('22', '4', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 1, No. 2)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v1-i2', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v1i2.01', '1-16', '2022-01-15', '2022-02-28', '2022-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2022, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('23', '4', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 2, No. 1)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v2-i1', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v2i1.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2023, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('24', '4', 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century) (Vol. 2, No. 2)', 'maritime-trade-networks-and-cultural-synthesis-across-southeast-asian-straits-14th-18th-century-kd-asian-studies-v2-i2', 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.', 'review-article', '10.58421/kd-asian-studies.v2i2.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Asian Studies 2023, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('25', '5', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 1, No. 1)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v1-i1', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v1i1.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2023, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('26', '5', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 1, No. 2)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v1-i2', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v1i2.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2023, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('27', '5', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 2, No. 1)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v2-i1', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v2i1.01', '1-16', '2024-01-15', '2024-02-28', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2024, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('28', '5', 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets (Vol. 2, No. 2)', 'esg-disclosure-transparency-cost-of-equity-capital-and-firm-valuation-in-volatile-markets-kd-accounting-business-management-finance-v2-i2', 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.', 'original-research', '10.58421/kd-accounting-business-management-finance.v2i2.01', '1-16', '2024-01-15', '2024-02-28', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Accounting, Business, Management, Finance 2024, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('29', '6', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 1, No. 1)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v1-i1', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v1i1.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2023, 1(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('30', '6', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 1, No. 2)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v1-i2', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v1i2.01', '1-16', '2023-01-15', '2023-02-28', '2023-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2023, 1(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('31', '6', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 2, No. 1)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v2-i1', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v2i1.01', '1-16', '2024-01-15', '2024-02-28', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2024, 2(1), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `articles` (`id`, `journal_id`, `title`, `slug`, `abstract`, `article_type`, `doi`, `pages`, `submission_date`, `acceptance_date`, `published_at`, `funding`, `conflict_of_interest`, `ethics_statement`, `license`, `citation_info`, `status`, `view_count`, `download_count`, `meta_title`, `meta_description`, `created_at`, `updated_at`, `deleted_at`) VALUES ('32', '6', 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions (Vol. 2, No. 2)', 'hermeneutics-of-mercy-comparative-textual-exegesis-in-abrahamic-ethical-traditions-kd-comparative-religion-v2-i2', 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.', 'original-research', '10.58421/kd-comparative-religion.v2i2.01', '1-16', '2024-01-15', '2024-02-28', '2024-03-15 09:00:00', NULL, NULL, NULL, NULL, 'KD Comparative Religion 2024, 2(2), 1-16.', 'published', '0', '0', NULL, NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);

DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `auditable_type` varchar(255) DEFAULT NULL,
  `auditable_id` bigint(20) unsigned DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `audit_logs_auditable_type_auditable_id_index` (`auditable_type`,`auditable_id`),
  KEY `audit_logs_user_id_index` (`user_id`),
  KEY `audit_logs_action_index` (`action`),
  KEY `audit_logs_created_at_index` (`created_at`),
  CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `book_proposals`;
CREATE TABLE `book_proposals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `author_name` varchar(255) NOT NULL,
  `author_email` varchar(255) NOT NULL,
  `institution` varchar(255) NOT NULL,
  `book_title` varchar(255) NOT NULL,
  `subject_discipline` varchar(255) NOT NULL,
  `estimated_word_count` varchar(255) DEFAULT NULL,
  `target_completion_date` varchar(255) DEFAULT NULL,
  `synopsis_and_toc` text NOT NULL,
  `status` enum('pending','reviewed','accepted','declined') NOT NULL DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `isbn` varchar(255) DEFAULT NULL,
  `year` int(11) NOT NULL DEFAULT 2024,
  `pages` int(11) NOT NULL DEFAULT 300,
  `category` varchar(255) NOT NULL DEFAULT 'Medicine & Health',
  `format` varchar(255) NOT NULL DEFAULT 'Print & eBook',
  `description` text DEFAULT NULL,
  `doi` varchar(255) DEFAULT NULL,
  `is_open_access` tinyint(1) NOT NULL DEFAULT 0,
  `cover_image` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `books_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('1', 'Advanced Methodologies in Public Health Surveillance', 'advanced-methodologies-in-public-health-surveillance', 'Prof. Dr. Sarah Al-Mansoor', '978-3-006-5501-2', '2024', '384', 'Medicine & Health', 'Print & eBook', 'A comprehensive reference text exploring epidemiological modeling, decentralized healthcare analytics, and predictive pandemic response frameworks.', '10.58421/books.2024.01', '1', NULL, NULL, '1', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('2', 'Sustainable Agricultural Systems and Functional Nutrition', 'sustainable-agricultural-systems-functional-nutrition', 'Prof. Dr. Giovanni Rossi & Dr. Lin Wei', '978-3-007-8812-9', '2024', '450', 'Food Science & Agriculture', 'Print & eBook', 'Fundamental principles of functional bioactives, micro-encapsulation technologies, and green agricultural processing paradigms.', '10.58421/books.2024.02', '0', NULL, NULL, '2', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('3', 'Maritime Trade and Cultural Synthesis in Southeast Asia', 'maritime-trade-cultural-synthesis-southeast-asia', 'Prof. Kenji Takahashi', '978-3-008-1123-6', '2023', '312', 'Asian Studies & History', 'Print & eBook', 'Archival reconstruction of historical mercantile circuits and cross-cultural synthesis across the Straits of Malacca from the 14th to 18th century.', '10.58421/books.2023.01', '1', NULL, NULL, '3', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('4', 'Econometric Modeling of ESG Integration and Capital Cost', 'econometric-modeling-esg-integration-capital-cost', 'Prof. Dr. Michael Sterling', '978-3-009-4456-3', '2023', '290', 'Business, Economics & Finance', 'eBook Only', 'Quantitative econometric frameworks evaluating how non-financial sustainability metrics influence firm debt pricing and equity volatility.', '10.58421/books.2023.02', '0', NULL, NULL, '4', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `books` (`id`, `title`, `slug`, `author`, `isbn`, `year`, `pages`, `category`, `format`, `description`, `doi`, `is_open_access`, `cover_image`, `file_path`, `sort_order`, `created_at`, `updated_at`) VALUES ('5', 'Comparative Hermeneutics in Abrahamic Ethical Traditions', 'comparative-hermeneutics-abrahamic-ethical-traditions', 'Prof. Dr. Tariq Al-Hashimi & Dr. Miriam Cohen', '978-3-010-7789-0', '2024', '340', 'Theology & Comparative Religion', 'Print & eBook', 'Interdisciplinary textual exegesis examining ethical convergence, restorative justice, and peacebuilding principles in sacred texts.', '10.58421/books.2024.03', '1', NULL, NULL, '5', '2026-08-22 15:27:17', '2026-08-22 15:27:17');

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `careers`;
CREATE TABLE `careers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Academic Editorial Role',
  `summary` text DEFAULT NULL,
  `requirements` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deadline` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `careers_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `careers` (`id`, `title`, `slug`, `department`, `type`, `summary`, `requirements`, `is_active`, `deadline`, `created_at`, `updated_at`) VALUES ('1', 'Section Editor — Biomedical & Health Sciences', 'section-editor-biomedical-health-sciences', 'Health Dynamics Editorial Office', 'Academic Editorial Role (Part-Time / Remote)', 'We are seeking an active PhD researcher with a track record of peer-reviewed publications to oversee peer review workflows in epidemiological and clinical sciences.', '• PhD in Medicine, Public Health, Epidemiology, or related biomedical discipline.\n• Minimum 5 publications in indexed Q1/Q2 journals.\n• Experience in handling peer review cycles.', '1', 'Open until filled', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `careers` (`id`, `title`, `slug`, `department`, `type`, `summary`, `requirements`, `is_active`, `deadline`, `created_at`, `updated_at`) VALUES ('2', 'Managing Editor — Business, Management & Finance', 'managing-editor-business-management-finance', 'KD ABMF Publishing Group', 'Full-Time / Hybrid', 'Coordinate editorial peer review cycles, oversee reviewer assignments, and liaise with authors for high-impact empirical business research.', '• PhD or Master\'s degree in Economics, Finance, or Management.\n• Minimum 3 years editorial operations experience.\n• Exceptional communication and project management skills.', '1', 'September 30, 2026', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `careers` (`id`, `title`, `slug`, `department`, `type`, `summary`, `requirements`, `is_active`, `deadline`, `created_at`, `updated_at`) VALUES ('3', 'Senior Scientific Proofreader & Academic Copyeditor', 'senior-scientific-proofreader-copyeditor', 'KD Proofreading Network', 'Freelance / Remote', 'Native English PhD specialists in STEM, Economics, or Humanities to perform line-by-line language editing, structural styling, and reference validation.', '• PhD or MD from an accredited international university.\n• Native English speaker.\n• Demonstrated academic copyediting and proofreading proficiency.', '1', 'Continuous recruitment', '2026-08-22 15:27:17', '2026-08-22 15:27:17');

DROP TABLE IF EXISTS `doi_records`;
CREATE TABLE `doi_records` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doi` varchar(255) NOT NULL,
  `doiable_type` varchar(255) NOT NULL,
  `doiable_id` bigint(20) unsigned NOT NULL,
  `provider` varchar(50) DEFAULT NULL,
  `status` enum('pending','registered','failed') NOT NULL DEFAULT 'pending',
  `registered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `doi_records_doi_unique` (`doi`),
  KEY `doi_records_doiable_type_doiable_id_index` (`doiable_type`,`doiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `email_account_requests`;
CREATE TABLE `email_account_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `requested_username` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL DEFAULT 'knowdyn.org',
  `full_email` varchar(255) NOT NULL,
  `quota_mb` int(11) NOT NULL DEFAULT 500,
  `status` enum('pending','approved','rejected','active','suspended') NOT NULL DEFAULT 'pending',
  `password_encrypted` text DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `admin_notes` text DEFAULT NULL,
  `cpanel_account_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_account_requests_full_email_unique` (`full_email`),
  KEY `email_account_requests_user_id_foreign` (`user_id`),
  CONSTRAINT `email_account_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `email_account_requests` (`id`, `user_id`, `requested_username`, `domain`, `full_email`, `quota_mb`, `status`, `password_encrypted`, `rejection_reason`, `admin_notes`, `cpanel_account_created_at`, `created_at`, `updated_at`) VALUES ('1', '2', 'prof.editorial', 'knowdyn.org', 'prof.editorial@knowdyn.org', '500', 'active', 'eyJpdiI6ImZ4d1VDb2JFa2NMbUVqR1pYL1B1T3c9PSIsInZhbHVlIjoiRzJiL1Yzb3NBa0F6MUg0eitpQUdQZz09IiwibWFjIjoiOTgxOGMwMmNhNzYzMjc4Yjk2ZDBiYWUyNmE0ZjllYmZkNWMyNWQ1MWMyZTlhYmRhZmU3MjQ1NWExZThkZmZiOCIsInRhZyI6IiJ9', NULL, 'Approved by administrator.', '2026-08-22 15:51:50', '2026-08-22 15:47:55', '2026-08-22 15:51:50');

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` varchar(255) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `guidelines_pages`;
CREATE TABLE `guidelines_pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guidelines_pages_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('1', 'authors', 'Author Guidelines & Submission Instructions', '## 1. Manuscript Preparation\nAuthors submitting to Knowledge Dynamics journals must ensure their work is original, unpublished, and not under consideration elsewhere.\n\n### Required Structure:\n- **Title Page:** Concise title, author full names, affiliations, ORCID IDs, and designated corresponding author.\n- **Structured Abstract:** Maximum 250–300 words comprising Background, Methods, Results, and Conclusions.\n- **Keywords:** 4 to 6 indexing terms matching MeSH or disciplinary thesauri.\n- **Main Text:** Introduction, Methods, Results, Discussion, and Conclusions.\n- **Declarations:** Funding, Competing Interests, Ethics Approval, and Data Availability.\n\n## 2. Reference Formatting\n- Health Dynamics & KD Food Science: Vancouver style.\n- KD Accounting, Business, Management, Finance: APA 7th Edition.\n- KD Asian Studies & KD Comparative Religion: Chicago Notes & Bibliography.', 'Author Guidelines — Knowledge Dynamics', 'Official author submission instructions, referencing style guides, and manuscript structure requirements.', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('2', 'editorial-policies', 'Publication Ethics & Editorial Policies', '## 1. COPE Ethical Compliance\nKnowledge Dynamics upholds zero tolerance for academic malpractice, data falsification, fraudulent authorship, and uncredited intellectual overlap.\n\n## 2. Plagiarism Screening\nAll submissions undergo automated similarity screening. Duplication exceeding journal thresholds without proper citation results in immediate desk rejection.\n\n## 3. Generative AI Transparency\nAI tools cannot be listed as authors. Any AI assistance utilized in drafting or data visualization must be explicitly declared in the Methodology.', 'Publication Ethics & Policies — Knowledge Dynamics', 'COPE compliance standards, plagiarism thresholds, and authorship criteria across Knowledge Dynamics.', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('3', 'reviewers', 'Peer Reviewer Guidelines & Code of Conduct', '## 1. Confidentiality\nManuscripts under review are strictly confidential documents. Reviewers must not share drafts, datasets, or evaluation remarks with third parties.\n\n## 2. Timeliness & Conflict of Interest\nReviewers are expected to submit thorough, constructive evaluations within 3 to 4 weeks. If a personal, financial, or institutional conflict of interest exists, reviewers must immediately recuse themselves.', 'Reviewer Guidelines — Knowledge Dynamics', 'Code of conduct, evaluation criteria, and confidentiality standards for peer reviewers.', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('4', 'editors', 'Editorial Board Roles & Responsibilities', '## 1. Editorial Independence\nEditors-in-Chief and Section Editors exercise complete editorial independence. Decisions to accept or reject are grounded exclusively in academic merit, novelty, and scientific validity.\n\n## 2. Peer Review Oversight\nHandling editors ensure at least two independent double-blind peer reviews are completed before rendering editorial decisions.', 'Editor Guidelines — Knowledge Dynamics', 'Responsibilities, ethical oversight, and decision-making workflows for editorial board members.', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `guidelines_pages` (`id`, `key`, `title`, `content`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('5', 'open-access', 'Open Access Statement & Policy', 'Knowledge Dynamics publishes all journal articles under the Creative Commons Attribution 4.0 International (CC BY 4.0) License. Authors retain copyright without restrictions. Content is immediately and permanently free to access worldwide.', 'Open Access Policy — Knowledge Dynamics', 'Creative Commons CC BY 4.0 licensing, author rights, and self-archiving policies.', '2026-08-22 15:27:17', '2026-08-22 15:27:17');

DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `volume_id` bigint(20) unsigned NOT NULL,
  `number` varchar(20) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `cover_image` varchar(500) DEFAULT NULL,
  `published_at` date DEFAULT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('draft','published') NOT NULL DEFAULT 'draft',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issues_volume_id_number_index` (`volume_id`,`number`),
  KEY `issues_status_index` (`status`),
  KEY `issues_published_at_index` (`published_at`),
  CONSTRAINT `issues_volume_id_foreign` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('1', '1', '1', 'Vol. 1, Issue 1', 'Regular research articles and review papers published in Volume 1, Issue 1.', NULL, '2021-02-15', '0', 'published', '1', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('2', '1', '2', 'Vol. 1, Issue 2', 'Regular research articles and review papers published in Volume 1, Issue 2.', NULL, '2021-06-15', '0', 'published', '2', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('3', '1', '3', 'Vol. 1, Issue 3', 'Regular research articles and review papers published in Volume 1, Issue 3.', NULL, '2021-10-15', '0', 'published', '3', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('4', '2', '1', 'Vol. 2, Issue 1', 'Regular research articles and review papers published in Volume 2, Issue 1.', NULL, '2022-02-15', '0', 'published', '1', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('5', '2', '2', 'Vol. 2, Issue 2', 'Regular research articles and review papers published in Volume 2, Issue 2.', NULL, '2022-06-15', '0', 'published', '2', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('6', '2', '3', 'Vol. 2, Issue 3', 'Regular research articles and review papers published in Volume 2, Issue 3.', NULL, '2022-10-15', '0', 'published', '3', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('7', '3', '1', 'Vol. 3, Issue 1', 'Regular research articles and review papers published in Volume 3, Issue 1.', NULL, '2023-02-15', '0', 'published', '1', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('8', '3', '2', 'Vol. 3, Issue 2', 'Regular research articles and review papers published in Volume 3, Issue 2.', NULL, '2023-06-15', '0', 'published', '2', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('9', '3', '3', 'Vol. 3, Issue 3', 'Regular research articles and review papers published in Volume 3, Issue 3.', NULL, '2023-10-15', '0', 'published', '3', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('10', '4', '1', 'Vol. 4, Issue 1', 'Regular research articles and review papers published in Volume 4, Issue 1.', NULL, '2024-02-15', '0', 'published', '1', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('11', '4', '2', 'Vol. 4, Issue 2', 'Regular research articles and review papers published in Volume 4, Issue 2.', NULL, '2024-06-15', '0', 'published', '2', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('12', '4', '3', 'Vol. 4, Issue 3', 'Regular research articles and review papers published in Volume 4, Issue 3.', NULL, '2024-10-15', '1', 'published', '3', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('13', '5', '1', 'Vol. 1, Issue 1', 'Applied economics and policy papers.', NULL, '2022-06-20', '0', 'published', '1', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('14', '5', '2', 'Vol. 1, Issue 2', 'Applied economics and policy papers.', NULL, '2022-06-20', '0', 'published', '2', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('15', '6', '1', 'Vol. 2, Issue 1', 'Applied economics and policy papers.', NULL, '2023-06-20', '0', 'published', '1', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('16', '6', '2', 'Vol. 2, Issue 2', 'Applied economics and policy papers.', NULL, '2023-06-20', '0', 'published', '2', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('17', '7', '1', 'Vol. 3, Issue 1', 'Applied economics and policy papers.', NULL, '2024-06-20', '0', 'published', '1', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('18', '7', '2', 'Vol. 3, Issue 2', 'Applied economics and policy papers.', NULL, '2024-06-20', '1', 'published', '2', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('19', '8', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2022-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('20', '8', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2022-09-15', '0', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('21', '9', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2023-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('22', '9', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2023-09-15', '1', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('23', '10', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2022-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('24', '10', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2022-09-15', '0', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('25', '11', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2023-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('26', '11', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2023-09-15', '1', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('27', '12', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2023-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('28', '12', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2023-09-15', '0', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('29', '13', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2024-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('30', '13', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2024-09-15', '1', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('31', '14', '1', 'Vol. 1, Issue 1', 'Published research articles and reviews in Volume 1, Issue 1.', NULL, '2023-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('32', '14', '2', 'Vol. 1, Issue 2', 'Published research articles and reviews in Volume 1, Issue 2.', NULL, '2023-09-15', '0', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('33', '15', '1', 'Vol. 2, Issue 1', 'Published research articles and reviews in Volume 2, Issue 1.', NULL, '2024-03-15', '0', 'published', '1', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `issues` (`id`, `volume_id`, `number`, `title`, `description`, `cover_image`, `published_at`, `is_current`, `status`, `sort_order`, `created_at`, `updated_at`) VALUES ('34', '15', '2', 'Vol. 2, Issue 2', 'Published research articles and reviews in Volume 2, Issue 2.', NULL, '2024-09-15', '1', 'published', '2', '2026-08-22 15:13:52', '2026-08-22 15:13:52');

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
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

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint(5) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `journal_editorial_members`;
CREATE TABLE `journal_editorial_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `institution` varchar(500) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `role` varchar(100) NOT NULL,
  `biography` text DEFAULT NULL,
  `orcid` varchar(50) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `journal_editorial_members_user_id_foreign` (`user_id`),
  KEY `journal_editorial_members_journal_id_role_index` (`journal_id`,`role`),
  KEY `journal_editorial_members_sort_order_index` (`sort_order`),
  CONSTRAINT `journal_editorial_members_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `journal_editorial_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('183', '1', NULL, 'Prof. Dr. Sarah Al-Mansoor', NULL, 'Karolinska Institute', 'Sweden', 'Editor-in-Chief', NULL, '0000-0001-5234-9981', '1', '1', '2026-08-22 17:33:00', '2026-08-22 17:33:00');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('184', '1', NULL, 'Dr. Marcus Vance', NULL, 'Johns Hopkins University', 'United States', 'Associate Editor', NULL, '0000-0002-3984-1102', '2', '1', '2026-08-22 17:33:00', '2026-08-22 17:33:00');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('185', '1', NULL, 'Dr. Elena Rostova', NULL, 'University of Zurich', 'Switzerland', 'Managing Editor', NULL, '0000-0003-8812-4431', '3', '1', '2026-08-22 17:33:00', '2026-08-22 17:33:00');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('186', '1', NULL, 'Prof. Hiroshi Tanaka', NULL, 'University of Tokyo', 'Japan', 'Section Editor', NULL, '0000-0002-9901-7764', '4', '1', '2026-08-22 17:33:00', '2026-08-22 17:33:00');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('187', '3', NULL, 'Prof. Dr. Giovanni Rossi', NULL, 'University of Bologna', 'Italy', 'Editor-in-Chief', NULL, '0000-0002-4112-9988', '1', '1', '2026-08-22 17:33:00', '2026-08-22 17:33:00');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('188', '3', NULL, 'Dr. Lin Wei', NULL, 'Zhejiang University', 'China', 'Associate Editor', NULL, '0000-0003-1288-7734', '2', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('189', '3', NULL, 'Dr. Rachel Green', NULL, 'University of Melbourne', 'Australia', 'Editorial Board Member', NULL, '0000-0001-9923-4512', '3', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('190', '4', NULL, 'Prof. Kenji Takahashi', NULL, 'Kyoto University', 'Japan', 'Editor-in-Chief', NULL, '0000-0002-8819-2341', '1', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('191', '4', NULL, 'Dr. Sunita Sharma', NULL, 'Jawaharlal Nehru University', 'India', 'Managing Editor', NULL, '0000-0001-6542-8890', '2', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('192', '4', NULL, 'Dr. Arthur Pendelton', NULL, 'SOAS University of London', 'United Kingdom', 'Editorial Board Member', NULL, '0000-0003-4412-0091', '3', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('193', '5', NULL, 'Prof. Dr. Michael Sterling', NULL, 'London School of Economics', 'United Kingdom', 'Editor-in-Chief', NULL, '0000-0002-1200-9832', '1', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('194', '5', NULL, 'Dr. Fatima Zahra', NULL, 'INSEAD', 'France', 'Associate Editor', NULL, '0000-0003-8821-4329', '2', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('195', '5', NULL, 'Dr. Robert Zhang', NULL, 'National University of Singapore', 'Singapore', 'Editorial Board Member', NULL, '0000-0001-9923-0012', '3', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('196', '6', NULL, 'Prof. Dr. Tariq Al-Hashimi', NULL, 'Oxford University', 'United Kingdom', 'Editor-in-Chief', NULL, '0000-0002-3321-7788', '1', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('197', '6', NULL, 'Dr. Miriam Cohen', NULL, 'Hebrew University of Jerusalem', 'Israel', 'Associate Editor', NULL, '0000-0001-7721-3490', '2', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');
INSERT INTO `journal_editorial_members` (`id`, `journal_id`, `user_id`, `name`, `email`, `institution`, `country`, `role`, `biography`, `orcid`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES ('198', '6', NULL, 'Prof. Peter Holmgren', NULL, 'Uppsala University', 'Sweden', 'Editorial Board Member', NULL, '0000-0003-1288-0044', '3', '1', '2026-08-22 17:33:01', '2026-08-22 17:33:01');

DROP TABLE IF EXISTS `journal_settings`;
CREATE TABLE `journal_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `peer_review_process` text DEFAULT NULL,
  `publication_ethics` text DEFAULT NULL,
  `author_guidelines` text DEFAULT NULL,
  `copyright_notice` text DEFAULT NULL,
  `privacy_statement` text DEFAULT NULL,
  `author_fees` text DEFAULT NULL,
  `open_access_policy` text DEFAULT NULL,
  `archiving_policy` text DEFAULT NULL,
  `plagiarism_policy` text DEFAULT NULL,
  `section_policies` text DEFAULT NULL,
  `journal_history` text DEFAULT NULL,
  `review_model` varchar(50) NOT NULL DEFAULT 'double_blind',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `journal_settings_journal_id_unique` (`journal_id`),
  CONSTRAINT `journal_settings_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('1', '1', 'All manuscripts undergo rigorous double-blind peer review by at least two independent expert reviewers with a typical turnaround time of 4-6 weeks.', 'Health Dynamics strictly adheres to COPE guidelines and ICMJE standards for ethical medical publishing and research integrity.', 'Articles must follow Vancouver referencing style, provide structured abstracts (Background, Methods, Results, Conclusion), and disclose all funding sources.', 'Authors retain copyright without restrictions.', NULL, NULL, 'Immediate open access under CC BY 4.0 license.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('2', '2', 'Standard double-blind evaluation with rigorous statistical review.', 'Full COPE compliance.', 'APA 7th Edition referencing required.', 'Authors retain copyright.', NULL, NULL, 'CC BY 4.0 Open Access.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('3', '3', 'Independent double-blind peer review by international nutrition and food chemistry scholars.', 'Strict adherence to COPE and food research integrity guidelines.', 'Follow APA 7th Edition style. Detailed nutritional tables and chemical purity analytical standards must be supplied.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 15:13:51', '2026-08-22 15:13:51');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('4', '4', 'Rigorous double-blind peer review by regional specialists and area-studies academics.', 'Full COPE compliance.', 'Chicago Manual of Style (Notes & Bibliography or Author-Date) referencing required.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('5', '5', 'Rigorous double-blind peer review emphasizing methodological rigor and empirical econometric validation.', 'Full COPE compliance.', 'APA 7th Edition or Harvard referencing style. Data replication packages are encouraged.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `journal_settings` (`id`, `journal_id`, `peer_review_process`, `publication_ethics`, `author_guidelines`, `copyright_notice`, `privacy_statement`, `author_fees`, `open_access_policy`, `archiving_policy`, `plagiarism_policy`, `section_policies`, `journal_history`, `review_model`, `created_at`, `updated_at`) VALUES ('6', '6', 'Standard double-blind peer review by international theologians, philosophers, and religious studies scholars.', 'Full COPE compliance.', 'Chicago Manual of Style (Notes & Bibliography) required for text citations and source references.', 'Authors retain copyright without restriction.', NULL, NULL, 'Open Access under CC BY 4.0.', NULL, NULL, NULL, NULL, 'double_blind', '2026-08-22 15:13:52', '2026-08-22 15:13:52');

DROP TABLE IF EXISTS `journals`;
CREATE TABLE `journals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `slug` varchar(500) NOT NULL,
  `short_title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `aims_and_scope` text DEFAULT NULL,
  `issn_print` varchar(20) DEFAULT NULL,
  `issn_online` varchar(20) DEFAULT NULL,
  `publisher` varchar(255) NOT NULL DEFAULT 'Knowledge Dynamics',
  `publication_frequency` varchar(100) DEFAULT NULL,
  `cover_image` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `is_open_access` tinyint(1) NOT NULL DEFAULT 1,
  `established_year` smallint(6) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `journals_slug_unique` (`slug`),
  KEY `journals_status_index` (`status`),
  KEY `journals_sort_order_index` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('1', 'Health Dynamics', 'health-dynamics', 'Health Dyn.', 'A peer-reviewed, open-access multidisciplinary journal publishing high-impact research, clinical insights, and healthcare management innovations.', 'Health Dynamics is dedicated to advancing the frontiers of medical sciences, public health policy, epidemiology, biomedical innovations, and healthcare delivery systems.\n\nThe journal welcomes original research papers, systematic reviews, clinical trials, meta-analyses, and methodological advances addressing urgent global healthcare challenges.', '3006-550X', '3006-5518', 'Knowledge Dynamics', 'Bi-monthly', NULL, NULL, 'editor.hd@knowdyn.org', NULL, NULL, 'active', '1', '2021', NULL, NULL, '1', '2026-08-22 14:13:31', '2026-08-22 14:13:31', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('2', 'Journal of Knowledge Dynamics & Applied Economics', 'journal-of-knowledge-dynamics-applied-economics', 'JKDAE', 'Dedicated to macro/micro economic modeling, sustainable development finance, technology transfer dynamics, and knowledge economy frameworks.', 'JKDAE publishes empirical and theoretical research in behavioral finance, econometric policy modeling, green economy transitions, and organizational knowledge dynamics.', '2812-4411', '2812-4419', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.jkdae@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '2', '2026-08-22 14:13:32', '2026-08-22 14:13:32', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('3', 'KD Food Science Nutrition', 'kd-food-science-nutrition', 'KD Food Sci. Nutr.', 'Advancing sustainable agricultural food processing, functional nutraceutical bioactives, molecular food safety, and global human nutritional health.', 'KD Food Science Nutrition provides a global peer-reviewed forum for groundbreaking discoveries in food biotechnology, nutrient bioavailability, sensory analysis, food chemistry, shelf-life modeling, and sustainable food packaging solutions.', '3007-8812', '3007-8820', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.fsn@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '2', '2026-08-22 15:13:51', '2026-08-22 15:13:51', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('4', 'KD Asian Studies', 'kd-asian-studies', 'KD Asian Stud.', 'A premier international journal exploring Asian geopolitical dynamics, socioeconomic transformations, cultural heritage, history, and linguistic evolution.', 'KD Asian Studies publishes interdisciplinary scholarship covering East, South, Southeast, and Central Asia. The journal bridges contemporary sociopolitical analysis with historical, archaeological, and literary perspectives.', '3008-1123', '3008-1131', 'Knowledge Dynamics', 'Bi-annual', NULL, NULL, 'editor.as@knowdyn.org', NULL, NULL, 'active', '1', '2022', NULL, NULL, '3', '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('5', 'KD Accounting, Business, Management, Finance', 'kd-accounting-business-management-finance', 'KD ABMF', 'Fostering empirical research in corporate governance, financial econometrics, fintech disruptions, organizational management, and ESG sustainability reporting.', 'KD ABMF serves corporate leaders, financial economists, and management scholars by publishing rigorous research on capital markets, algorithmic trading, audit quality, executive leadership, and green business models.', '3009-4456', '3009-4464', 'Knowledge Dynamics', 'Quarterly', NULL, NULL, 'editor.abmf@knowdyn.org', NULL, NULL, 'active', '1', '2023', NULL, NULL, '4', '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);
INSERT INTO `journals` (`id`, `title`, `slug`, `short_title`, `description`, `aims_and_scope`, `issn_print`, `issn_online`, `publisher`, `publication_frequency`, `cover_image`, `thumbnail`, `contact_email`, `contact_phone`, `website`, `status`, `is_open_access`, `established_year`, `meta_title`, `meta_description`, `sort_order`, `created_at`, `updated_at`, `deleted_at`) VALUES ('6', 'KD Comparative Religion', 'kd-comparative-religion', 'KD Comp. Relig.', 'A scholarly platform for interfaith dialogues, hermeneutical text studies, sociology of religion, ethics, and contemporary theological discourse.', 'KD Comparative Religion fosters rigorous critical scholarship examining religious traditions, historical theology, sacred texts, philosophical ethics, and the role of faith communities in contemporary global society.', '3010-7789', '3010-7797', 'Knowledge Dynamics', 'Bi-annual', NULL, NULL, 'editor.cr@knowdyn.org', NULL, NULL, 'active', '1', '2023', NULL, NULL, '5', '2026-08-22 15:13:52', '2026-08-22 15:13:52', NULL);

DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `keywords_name_unique` (`name`),
  UNIQUE KEY `keywords_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `keywords` (`id`, `name`, `slug`) VALUES ('1', 'Epidemiology', 'epidemiology');
INSERT INTO `keywords` (`id`, `name`, `slug`) VALUES ('2', 'Digital Health', 'digital-health');
INSERT INTO `keywords` (`id`, `name`, `slug`) VALUES ('3', 'Public Health Policy', 'public-health-policy');

DROP TABLE IF EXISTS `legacy_url_mappings`;
CREATE TABLE `legacy_url_mappings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(2000) NOT NULL,
  `new_url` varchar(2000) NOT NULL,
  `status_code` smallint(6) NOT NULL DEFAULT 301,
  `entity_type` varchar(100) DEFAULT NULL,
  `entity_id` bigint(20) unsigned DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `legacy_url_mappings_old_url_index` (`old_url`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `manuscript_authors`;
CREATE TABLE `manuscript_authors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` bigint(20) unsigned NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `affiliation` varchar(500) DEFAULT NULL,
  `orcid` varchar(50) DEFAULT NULL,
  `is_corresponding` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `manuscript_authors_manuscript_id_foreign` (`manuscript_id`),
  CONSTRAINT `manuscript_authors_manuscript_id_foreign` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `manuscript_files`;
CREATE TABLE `manuscript_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` bigint(20) unsigned NOT NULL,
  `file_path` varchar(1000) NOT NULL,
  `file_name` varchar(500) NOT NULL,
  `file_type` varchar(50) NOT NULL,
  `file_size` bigint(20) unsigned DEFAULT NULL,
  `version` smallint(6) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manuscript_files_manuscript_id_foreign` (`manuscript_id`),
  CONSTRAINT `manuscript_files_manuscript_id_foreign` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `manuscript_status_history`;
CREATE TABLE `manuscript_status_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `manuscript_status_history_manuscript_id_foreign` (`manuscript_id`),
  KEY `manuscript_status_history_user_id_foreign` (`user_id`),
  CONSTRAINT `manuscript_status_history_manuscript_id_foreign` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `manuscript_status_history_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `manuscripts`;
CREATE TABLE `manuscripts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(1000) NOT NULL,
  `abstract` text DEFAULT NULL,
  `article_type` varchar(50) NOT NULL DEFAULT 'original-research',
  `status` enum('draft','submitted','screening','editor_assigned','under_review','revision_required','resubmitted','accepted','rejected','production','published') NOT NULL DEFAULT 'draft',
  `editor_id` bigint(20) unsigned DEFAULT NULL,
  `article_id` bigint(20) unsigned DEFAULT NULL,
  `funding` text DEFAULT NULL,
  `conflict_of_interest` text DEFAULT NULL,
  `ethics_statement` text DEFAULT NULL,
  `cover_letter` text DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `decided_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manuscripts_user_id_foreign` (`user_id`),
  KEY `manuscripts_editor_id_foreign` (`editor_id`),
  KEY `manuscripts_article_id_foreign` (`article_id`),
  KEY `manuscripts_status_index` (`status`),
  KEY `manuscripts_journal_id_status_index` (`journal_id`,`status`),
  KEY `manuscripts_submitted_at_index` (`submitted_at`),
  CONSTRAINT `manuscripts_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `manuscripts_editor_id_foreign` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `manuscripts_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `manuscripts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('15', '2026_08_22_150000_create_dynamic_content_tables', '2');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('16', '2026_08_22_160000_create_cpanel_and_webmail_tables', '3');
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES ('17', '2026_08_22_170000_create_app_notifications_table', '4');

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('1', 'App\\Models\\User', '1');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('1', 'App\\Models\\User', '2');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('2', 'App\\Models\\User', '1');
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES ('2', 'App\\Models\\User', '2');

DROP TABLE IF EXISTS `news_events`;
CREATE TABLE `news_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` enum('news','event','announcement','workshop') NOT NULL DEFAULT 'news',
  `category` varchar(255) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `event_date` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `registration_url` varchar(255) DEFAULT NULL,
  `deadline` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_published` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `news_events_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('1', 'Call for Papers: Special Issue on Climate Resilient Food Processing Systems', 'call-for-papers-climate-resilient-food-processing', 'announcement', 'Special Issue CFP', 'KD Food Science Nutrition invites high-impact original research papers and critical systematic reviews for an upcoming special issue on sustainable food technology.', NULL, NULL, NULL, NULL, 'December 31, 2026', '1', '1', '0', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('2', 'Knowledge Dynamics Journals Achieve Full Crossref and DOAJ Indexing Compliance', 'kd-journals-crossref-doaj-indexing-milestone', 'news', 'Publisher News', 'All five flagship Knowledge Dynamics journals have integrated real-time Crossref DOI deposit schemas and adhere to strict DOAJ open-access criteria.', NULL, NULL, NULL, NULL, NULL, '1', '1', '0', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('3', 'International Symposium on Decentralized Digital Health & Epidemiology', 'symposium-decentralized-digital-health-epidemiology-2026', 'event', 'Academic Symposium', 'A three-day hybrid symposium gathering epidemiologists, public health directors, and biomedical data scientists.', NULL, 'October 14–16, 2026', 'Virtual & Stockholm, Sweden', 'https://knowdyn.org/events/register/1', NULL, '1', '1', '0', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `news_events` (`id`, `title`, `slug`, `type`, `category`, `summary`, `content`, `event_date`, `location`, `registration_url`, `deadline`, `is_featured`, `is_published`, `sort_order`, `created_at`, `updated_at`) VALUES ('4', 'Workshop: Writing for High-Impact International Open Access Journals', 'workshop-writing-for-high-impact-open-access-journals', 'workshop', 'Author Masterclass', 'Practical masterclass by Knowledge Dynamics Editors-in-Chief on structuring manuscripts, navigating peer review, and responding to reviewer critiques.', NULL, 'November 05, 2026', 'Interactive Webinar', 'https://knowdyn.org/events/register/2', NULL, '0', '1', '0', '2026-08-22 15:27:17', '2026-08-22 15:27:17');

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT 0,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('1', 'manage users', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('2', 'view users', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('3', 'manage journals', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('4', 'view journals', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('5', 'manage articles', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('6', 'view articles', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('7', 'publish articles', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('8', 'submit manuscripts', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('9', 'screen manuscripts', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('10', 'assign editors', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('11', 'assign reviewers', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('12', 'make editorial decisions', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('13', 'view all manuscripts', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('14', 'view assigned manuscripts', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('15', 'review manuscripts', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('16', 'manage projects', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('17', 'view projects', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('18', 'manage services', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('19', 'view service requests', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('20', 'handle service requests', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('21', 'manage pages', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('22', 'manage settings', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('23', 'view audit logs', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('24', 'manage url mappings', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('25', 'manage doi records', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('26', 'manage own profile', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('27', 'manage researcher profiles', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');

DROP TABLE IF EXISTS `project_members`;
CREATE TABLE `project_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_members_project_id_user_id_unique` (`project_id`,`user_id`),
  KEY `project_members_user_id_foreign` (`user_id`),
  CONSTRAINT `project_members_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(500) NOT NULL,
  `slug` varchar(500) NOT NULL,
  `summary` text DEFAULT NULL,
  `research_area` varchar(255) DEFAULT NULL,
  `status` enum('planning','active','completed','on_hold') NOT NULL DEFAULT 'planning',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `institution` varchar(500) DEFAULT NULL,
  `external_url` varchar(500) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_slug_unique` (`slug`),
  KEY `projects_user_id_foreign` (`user_id`),
  KEY `projects_status_index` (`status`),
  FULLTEXT KEY `projects_title_fulltext` (`title`),
  CONSTRAINT `projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `researcher_affiliations`;
CREATE TABLE `researcher_affiliations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `researcher_profile_id` bigint(20) unsigned NOT NULL,
  `institution` varchar(500) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `researcher_affiliations_researcher_profile_id_foreign` (`researcher_profile_id`),
  CONSTRAINT `researcher_affiliations_researcher_profile_id_foreign` FOREIGN KEY (`researcher_profile_id`) REFERENCES `researcher_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `researcher_interests`;
CREATE TABLE `researcher_interests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `researcher_profile_id` bigint(20) unsigned NOT NULL,
  `interest` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `researcher_interests_researcher_profile_id_foreign` (`researcher_profile_id`),
  KEY `researcher_interests_interest_index` (`interest`),
  CONSTRAINT `researcher_interests_researcher_profile_id_foreign` FOREIGN KEY (`researcher_profile_id`) REFERENCES `researcher_profiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `researcher_profiles`;
CREATE TABLE `researcher_profiles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `biography` text DEFAULT NULL,
  `institution` varchar(500) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `orcid` varchar(50) DEFAULT NULL,
  `google_scholar` varchar(500) DEFAULT NULL,
  `linkedin` varchar(500) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `research_gate` varchar(500) DEFAULT NULL,
  `expertise` text DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `researcher_profiles_user_id_unique` (`user_id`),
  CONSTRAINT `researcher_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `review_assignments`;
CREATE TABLE `review_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `manuscript_id` bigint(20) unsigned NOT NULL,
  `reviewer_id` bigint(20) unsigned NOT NULL,
  `assigned_by` bigint(20) unsigned NOT NULL,
  `status` enum('pending','accepted','declined','completed') NOT NULL DEFAULT 'pending',
  `due_date` date DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `responded_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `review_assignments_assigned_by_foreign` (`assigned_by`),
  KEY `review_assignments_manuscript_id_status_index` (`manuscript_id`,`status`),
  KEY `review_assignments_reviewer_id_index` (`reviewer_id`),
  CONSTRAINT `review_assignments_assigned_by_foreign` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `review_assignments_manuscript_id_foreign` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `review_assignments_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `review_assignment_id` bigint(20) unsigned NOT NULL,
  `recommendation` enum('accept','minor_revision','major_revision','reject') NOT NULL,
  `comments_to_editor` text DEFAULT NULL,
  `comments_to_author` text DEFAULT NULL,
  `quality_score` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_review_assignment_id_unique` (`review_assignment_id`),
  CONSTRAINT `reviews_review_assignment_id_foreign` FOREIGN KEY (`review_assignment_id`) REFERENCES `review_assignments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('1', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('2', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('3', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('3', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('4', '9');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('5', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('5', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('5', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '6');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('6', '9');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('7', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('7', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('7', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('8', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('8', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('9', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('9', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('9', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('10', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('10', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('10', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('11', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('12', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('13', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('13', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('13', '4');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '5');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '11');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('14', '12');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('15', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('15', '6');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('16', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('16', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('16', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('17', '9');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('18', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('19', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('19', '10');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('20', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('20', '10');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('21', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('22', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('23', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('24', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('24', '3');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('25', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '2');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '6');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '7');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '8');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '10');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '11');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('26', '12');
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES ('27', '2');

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('1', 'super-admin', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('2', 'admin', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('3', 'journal-manager', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('4', 'editor-in-chief', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('5', 'section-editor', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('6', 'reviewer', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('7', 'author', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('8', 'researcher', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('9', 'reader', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('10', 'proofreader', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('11', 'copyeditor', 'web', '2026-08-22 14:13:30', '2026-08-22 14:13:30');
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES ('12', 'layout-editor', 'web', '2026-08-22 14:13:31', '2026-08-22 14:13:31');

DROP TABLE IF EXISTS `service_requests`;
CREATE TABLE `service_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('submitted','assigned','in_progress','quality_check','completed','cancelled') NOT NULL DEFAULT 'submitted',
  `assigned_to` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_requests_service_id_foreign` (`service_id`),
  KEY `service_requests_user_id_foreign` (`user_id`),
  KEY `service_requests_assigned_to_foreign` (`assigned_to`),
  KEY `service_requests_status_index` (`status`),
  CONSTRAINT `service_requests_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `service_requests_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  CONSTRAINT `service_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`)),
  `process` text DEFAULT NULL,
  `faq` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`faq`)),
  `cta_text` varchar(100) DEFAULT NULL,
  `cta_url` varchar(500) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `services_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('1', 'KD Proofreading & Language Editing', 'kd-proofreading', 'Comprehensive academic English editing and proofreading by native PhD subject specialists. Ensures 100% grammar accuracy, natural academic flow, and adherence to target journal guidelines.', '[\"Native PhD subject-matter editors\",\"Grammar, syntax, and punctuation refinement\",\"Discipline-specific terminology verification\",\"Target journal guideline alignment (APA, Vancouver, IEEE)\",\"Official Certificate of Academic Editing\",\"Free re-editing support for revised submissions\"]', '1. Submit your manuscript and select turnaround (Standard 5-7d, Express 48h, Rush 24h).\n2. Assigned to a certified PhD editor in your scientific domain.\n3. Detailed two-pass editorial review and track-changes markup.\n4. Quality assurance check by senior managing editor.\n5. Download edited manuscript and official editing certificate.', NULL, NULL, NULL, 'proofreading', '1', '1', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 14:25:22');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('2', 'Manuscript Copyediting & Styling', 'manuscript-editing', 'Structural, developmental, and stylistic editing to enhance manuscript clarity, logical argumentation, and narrative cohesion before submission to high-impact journals.', '[\"Macro-structural flow and argumentation review\",\"Abstract and introduction impact optimization\",\"Clarity and conciseness improvements\",\"Journal cover letter crafting\"]', '1. Manuscript submission and target journal evaluation.\n2. In-depth structural and stylistic review by senior editor.\n3. Author query resolution and final delivery.', NULL, NULL, NULL, 'editing', '1', '2', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 14:25:22');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('3', 'Academic Figure & Illustration Formatting', 'academic-formatting', 'High-resolution graphical abstract design, figure enhancement, statistical chart styling, and typography formatting meeting strict publisher raster (300+ DPI) and vector requirements.', '[\"Publication-quality 300\\/600 DPI vector and raster figures\",\"Custom Graphical Abstract design\",\"Scientific infographic visualization\",\"TIFF, EPS, PDF, and high-res PNG export\"]', '1. Upload draft figures, sketches, or raw datasets.\n2. Scientific illustrator crafts publication-ready graphics.\n3. Author review and unlimited minor revisions.', NULL, NULL, NULL, 'figures', '1', '4', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 15:13:53');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('4', 'Journal Publishing & Hosting Solutions', 'journal-publishing', 'End-to-end open-access journal publishing infrastructure, editorial workflow management, OJS/custom platform hosting, indexing support, and digital preservation.', '[\"Full journal setup with custom domain and ISSN\",\"Automated editorial and peer-review workflows\",\"DOAJ, Scopus, and WoS indexing readiness\",\"Long-term archival preservation (Portico\\/CLOCKSS ready)\"]', '1. Initial institutional consultation and journal scoping.\n2. Technical setup and editorial board configuration.\n3. Launch, indexing application, and ongoing publishing operations.', NULL, NULL, NULL, 'journal', '1', '8', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 15:13:53');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('5', 'DOI & Crossref Metadata Deposit Service', 'doi-metadata-support', 'Digital Object Identifier (DOI) minting, Crossref XML schema deposit, scholarly metadata enrichment, and citation tracking integration for academic publishers and institutions.', '[\"Crossref DOI prefix allocation and registration\",\"Automated XML deposit with rich metadata\",\"Reference linking and Cited-by tracking\",\"ORCID auto-update integration\"]', '1. Connect journal or repository archive.\n2. Automated metadata extraction and schema validation.\n3. Official Crossref deposit and permanent DOI resolution.', NULL, NULL, NULL, 'doi', '1', '9', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 15:13:53');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('6', 'Similarity Index & Plagiarism Reduction', 'plagiarism-screening', 'Pre-submission similarity screening and ethical rewording to resolve flagged overlapping passages and ensure high academic integrity without altering empirical findings.', '[\"Comprehensive similarity index percentage report\",\"Sentence-by-sentence flagged overlap analysis\",\"Expert academic rephrasing of duplicate phrases\",\"Confidential scanning without repository storage\"]', '1. Upload manuscript file for confidential screening.\n2. Automated scan against global academic databases.\n3. Editorial rephrasing of overlapping text.\n4. Receive similarity report under target journal threshold (< 10-15%).', NULL, NULL, NULL, 'plagiarism', '1', '5', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 15:13:53');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('7', 'Research Grant & Publication Consultancy', 'publication-consultancy', 'Strategic publication planning, journal selection advisory, grant proposal review, and response-to-reviewers rebuttal consultation to maximize research reach and funding success.', '[\"Aims and scope journal matching matrix\",\"Grant proposal competitiveness review\",\"Editorial rebuttal letter strategizing\",\"Post-publication research impact amplification\"]', '1. Initial research portfolio assessment.\n2. 1-on-1 strategy session with senior publication consultant.\n3. Actionable roadmap and submission guidance report.', NULL, NULL, NULL, 'consultancy', '1', '7', NULL, NULL, '2026-08-22 14:25:22', '2026-08-22 14:25:22');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('8', 'Academic Translation Services', 'academic-translation', 'Discipline-specific scholarly translation between English and 15+ major global academic languages by bilingual PhD researchers.', '[\"Bilingual academic subject-matter translators\",\"Preservation of nuanced technical terminology\",\"Two-step translation + native English copyedit\",\"Quality guarantee for journal peer review\"]', '1. Upload source language manuscript.\n2. Primary translation by domain expert scholar.\n3. Native English editorial refinement and terminological consistency check.\n4. Final quality inspection and delivery.', NULL, NULL, NULL, 'translation', '1', '3', NULL, NULL, '2026-08-22 15:13:53', '2026-08-22 15:13:53');
INSERT INTO `services` (`id`, `title`, `slug`, `description`, `features`, `process`, `faq`, `cta_text`, `cta_url`, `icon`, `is_active`, `sort_order`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES ('9', 'AI Index & Paraphrasing Reduction', 'ai-index-reduction', 'Humanizing and academically refining AI-assisted text to remove formulaic syntax, repetitive phrasing, and generic patterns while elevating human scientific voice.', '[\"Deep editorial rewrite of AI-generated\\/assisted drafts\",\"Restoration of natural, authoritative scientific voice\",\"Verification of factual and citation authenticity\",\"Pre-submission AI detection screening validation\"]', '1. Upload manuscript containing AI-drafted sections.\n2. PhD specialist manually rewrites and enriches context.\n3. Rigorous cross-check against AI pattern detectors.\n4. Clean, authentic academic manuscript delivery.', NULL, NULL, NULL, 'ai-reduction', '1', '6', NULL, NULL, '2026-08-22 15:13:53', '2026-08-22 15:13:53');

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('3WsjrTUwXUHXjnCusKSUT3PqyULJOO76oHLLiBSY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJkdUxWS2VmWHpRSnJ4WldUV2lkSEdudWEyOHhsTThJVmw5N1NIclN2IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOiJob21lIn0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', '1787417848');
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES ('iqsTGPzhblJSE0zzPPXjtSPBDgLP56n6Ys9aQkBL', '2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJSb0pnYnJCbXY4eEhua2N4ckx1THptNDNGWkw1YmJ4eWVWUEs0MHQ2IiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvbG9jYWxob3N0OjgwMDBcL2FkbWluXC9jcGFuZWwtZW1haWwiLCJyb3V0ZSI6ImFkbWluLmNwYW5lbC5pbmRleCJ9LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6Mn0=', '1787419963');

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(100) NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_group_key_unique` (`group`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `group` varchar(255) NOT NULL DEFAULT 'general',
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('1', 'site_name', 'Knowledge Dynamics', 'general', 'Platform name', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('2', 'publisher_name', 'Knowledge Dynamics Publishing', 'general', 'Official publisher entity', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('3', 'doi_prefix', '10.58421', 'doi', 'Registered Crossref DOI Prefix', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('4', 'contact_email', 'editorial@kdpub.com', 'contact', 'Primary editorial contact email', '2026-08-22 15:27:17', '2026-08-22 17:19:11');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('5', 'support_email', 'support@kdpub.com', 'contact', 'Technical support email', '2026-08-22 15:27:17', '2026-08-22 17:19:11');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('6', 'headquarters_address', 'Knowledge Dynamics Academic Center, Stockholm, Sweden & London, UK', 'contact', 'Publishing house address', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('7', 'crossref_deposit_mode', 'automated', 'doi', 'Crossref XML schema deposit mode', '2026-08-22 15:27:17', '2026-08-22 15:27:17');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('8', 'cpanel_host', 'kdpub.com', 'cpanel', 'cPanel Server Hostname', '2026-08-22 15:50:44', '2026-08-22 17:19:12');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('9', 'cpanel_username', 'kdpuodtp', 'cpanel', 'cPanel Account Username', '2026-08-22 15:50:44', '2026-08-22 17:33:01');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('10', 'cpanel_api_token', 'EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q', 'cpanel', 'cPanel UAPI Access Token', '2026-08-22 15:50:44', '2026-08-22 17:19:12');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('11', 'cpanel_default_domain', 'kdpub.com', 'cpanel', 'Default Academic Email Domain', '2026-08-22 15:50:44', '2026-08-22 17:19:12');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('12', 'cpanel_port', '2083', 'cpanel', 'cPanel SSL Port', '2026-08-22 15:50:44', '2026-08-22 17:19:12');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('13', 'theme_preset', 'oxford-navy', 'theme', 'Active UI theme preset', '2026-08-22 16:08:17', '2026-08-22 16:27:19');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('14', 'theme_primary_color', '#0F2A4A', 'theme', 'Primary brand color', '2026-08-22 16:08:17', '2026-08-22 16:27:19');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('15', 'theme_accent_color', '#BE123C', 'theme', 'Accent interaction color', '2026-08-22 16:08:17', '2026-08-22 16:27:19');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('16', 'theme_font_sans', 'Inter', 'theme', 'Body typography family', '2026-08-22 16:08:17', '2026-08-22 16:27:19');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('17', 'theme_font_heading', 'Playfair Display', 'theme', 'Editorial heading typography family', '2026-08-22 16:08:17', '2026-08-22 16:27:19');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('18', 'theme_border_radius', '12px', 'theme', 'UI card and element corner radius', '2026-08-22 16:08:17', '2026-08-22 16:08:17');
INSERT INTO `site_settings` (`id`, `key`, `value`, `group`, `description`, `created_at`, `updated_at`) VALUES ('19', 'cpanel_webmail_port', '2096', 'cpanel', 'cPanel Webmail SSL Port', '2026-08-22 17:19:12', '2026-08-22 17:19:12');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive','suspended') NOT NULL DEFAULT 'active',
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `username`, `email`, `email_verified_at`, `phone`, `avatar`, `status`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES ('1', 'KD Admin', 'KD', 'Admin', 'kdadmin', 'admin@knowledge-dynamics.com', '2026-08-22 17:33:00', NULL, NULL, 'active', '$2y$12$8Fej42JBOfxfCGYx.YjVl.vGW0do7kpYrTqvsC2TJjpt0viHZCvIa', NULL, '2026-08-22 14:13:31', '2026-08-22 17:33:00', NULL);
INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `username`, `email`, `email_verified_at`, `phone`, `avatar`, `status`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES ('2', 'Super Administrator', 'Super', 'Admin', 'superadmin', 'admin@knowdyn.org', '2026-08-22 17:33:00', NULL, NULL, 'active', '$2y$12$x.Mr1a2B/optcrZqdhFbMeDJBpaNxA9hV7RtpFqnEgAWH.5CaHQYy', NULL, '2026-08-22 15:35:18', '2026-08-22 17:33:00', NULL);
INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `username`, `email`, `email_verified_at`, `phone`, `avatar`, `status`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES ('3', 'Super Admin', NULL, NULL, NULL, 'superadmin@knowdyn.org', NULL, NULL, NULL, 'active', '$2y$12$GUEFOg3zJhLNCd.MZ8Yt6OIiX6kqUCYz82fw/4wUQ1xXPqIDaxTpC', NULL, '2026-08-22 15:36:57', '2026-08-22 15:36:57', NULL);

DROP TABLE IF EXISTS `volumes`;
CREATE TABLE `volumes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint(20) unsigned NOT NULL,
  `number` smallint(6) NOT NULL,
  `year` smallint(6) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_journal_id_number_unique` (`journal_id`,`number`),
  KEY `volumes_year_index` (`year`),
  CONSTRAINT `volumes_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('1', '1', '1', '2021', 'Volume 1 (2021)', NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('2', '1', '2', '2022', 'Volume 2 (2022)', NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('3', '1', '3', '2023', 'Volume 3 (2023)', NULL, '2026-08-22 14:13:31', '2026-08-22 14:13:31');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('4', '1', '4', '2024', 'Volume 4 (2024)', NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('5', '2', '1', '2022', 'Volume 1 (2022)', NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('6', '2', '2', '2023', 'Volume 2 (2023)', NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('7', '2', '3', '2024', 'Volume 3 (2024)', NULL, '2026-08-22 14:13:32', '2026-08-22 14:13:32');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('8', '3', '1', '2022', 'Volume 1 (2022)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('9', '3', '2', '2023', 'Volume 2 (2023)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('10', '4', '1', '2022', 'Volume 1 (2022)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('11', '4', '2', '2023', 'Volume 2 (2023)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('12', '5', '1', '2023', 'Volume 1 (2023)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('13', '5', '2', '2024', 'Volume 2 (2024)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('14', '6', '1', '2023', 'Volume 1 (2023)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');
INSERT INTO `volumes` (`id`, `journal_id`, `number`, `year`, `title`, `description`, `created_at`, `updated_at`) VALUES ('15', '6', '2', '2024', 'Volume 2 (2024)', NULL, '2026-08-22 15:13:52', '2026-08-22 15:13:52');

DROP TABLE IF EXISTS `webmail_messages`;
CREATE TABLE `webmail_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `email_account_request_id` bigint(20) unsigned DEFAULT NULL,
  `folder` enum('inbox','sent','drafts','trash') NOT NULL DEFAULT 'inbox',
  `from_name` varchar(255) DEFAULT NULL,
  `from_email` varchar(255) NOT NULL,
  `to_email` varchar(255) NOT NULL,
  `cc_email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `body_html` longtext DEFAULT NULL,
  `body_text` longtext DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `is_starred` tinyint(1) NOT NULL DEFAULT 0,
  `has_attachments` tinyint(1) NOT NULL DEFAULT 0,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webmail_messages_user_id_foreign` (`user_id`),
  KEY `webmail_messages_email_account_request_id_foreign` (`email_account_request_id`),
  CONSTRAINT `webmail_messages_email_account_request_id_foreign` FOREIGN KEY (`email_account_request_id`) REFERENCES `email_account_requests` (`id`) ON DELETE SET NULL,
  CONSTRAINT `webmail_messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `webmail_messages` (`id`, `user_id`, `email_account_request_id`, `folder`, `from_name`, `from_email`, `to_email`, `cc_email`, `subject`, `body_html`, `body_text`, `is_read`, `is_starred`, `has_attachments`, `sent_at`, `created_at`, `updated_at`) VALUES ('1', '2', '1', 'inbox', 'Knowledge Dynamics Editorial Desk', 'editorial@knowdyn.org', 'prof.editorial@knowdyn.org', NULL, 'Welcome to Your Knowledge Dynamics Academic Email Account', '<p>Dear Super Administrator,</p><p>Your official academic email account <strong>prof.editorial@knowdyn.org</strong> has been provisioned on the Knowledge Dynamics server.</p><p>You can now send, receive, and manage your scholarly correspondence directly through your in-app Webmail dashboard or connect via IMAP/SMTP client.</p><p>Warm regards,<br>Knowledge Dynamics Editorial & IT Office</p>', 'Welcome to your official academic email account prof.editorial@knowdyn.org.', '1', '1', '0', '2026-08-22 15:51:50', '2026-08-22 15:51:50', '2026-08-22 15:52:02');
INSERT INTO `webmail_messages` (`id`, `user_id`, `email_account_request_id`, `folder`, `from_name`, `from_email`, `to_email`, `cc_email`, `subject`, `body_html`, `body_text`, `is_read`, `is_starred`, `has_attachments`, `sent_at`, `created_at`, `updated_at`) VALUES ('2', '2', '1', 'sent', 'Super Administrator', 'prof.editorial@knowdyn.org', 'ceo.ahasanhabib@gmail.com', NULL, 'ass', 'ewrewrwer', 'ewrewrwer', '1', '0', '0', '2026-08-22 15:53:53', '2026-08-22 15:53:53', '2026-08-22 15:53:53');
INSERT INTO `webmail_messages` (`id`, `user_id`, `email_account_request_id`, `folder`, `from_name`, `from_email`, `to_email`, `cc_email`, `subject`, `body_html`, `body_text`, `is_read`, `is_starred`, `has_attachments`, `sent_at`, `created_at`, `updated_at`) VALUES ('3', '2', '1', 'sent', 'Super Administrator', 'prof.editorial@knowdyn.org', 'editor@knowdyn.org', NULL, 'Peer Review Assignment #KD-8821', 'Dear Editor, I have completed the double-blind review for this manuscript.', 'Dear Editor, I have completed the double-blind review for this manuscript.', '1', '0', '0', '2026-08-22 16:28:30', '2026-08-22 16:28:30', '2026-08-22 16:28:30');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
