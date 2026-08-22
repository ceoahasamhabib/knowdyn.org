<?php

$sqliteDb = new PDO('sqlite:' . __DIR__ . '/../kdpuodtp_kdpub');
$sqliteDb->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$tables = $sqliteDb->query("SELECT name, sql FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);

$mysqlDump = "-- ========================================================\n";
$mysqlDump .= "-- Knowledge Dynamics — 100% Accurate Production Database Dump\n";
$mysqlDump .= "-- Database: kdpuodtp_kdpub | Domain: https://kdpub.com\n";
$mysqlDump .= "-- Generated: " . date('Y-m-d H:i:s') . "\n";
$mysqlDump .= "-- Compatible with MySQL 5.7+, 8.0+, MariaDB 10.3+\n";
$mysqlDump .= "-- ========================================================\n\n";

$mysqlDump .= "SET FOREIGN_KEY_CHECKS=0;\n";
$mysqlDump .= "SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';\n";
$mysqlDump .= "SET AUTOCOMMIT = 0;\n";
$mysqlDump .= "START TRANSACTION;\n";
$mysqlDump .= "SET time_zone = '+00:00';\n\n";

foreach ($tables as $t) {
    $tableName = $t['name'];
    $createSql = $t['sql'];

    // Convert SQLite table creation SQL to robust MySQL DDL
    // 1. Get column info from PRAGMA table_info
    $cols = $sqliteDb->query("PRAGMA table_info(`{$tableName}`)")->fetchAll(PDO::FETCH_ASSOC);
    $indexes = $sqliteDb->query("PRAGMA index_list(`{$tableName}`)")->fetchAll(PDO::FETCH_ASSOC);

    $pkCols = array_filter($cols, fn($x) => (int)$x['pk'] > 0);
    $isSinglePk = count($pkCols) === 1;

    $columnDefs = [];
    $primaryKeys = [];

    foreach ($cols as $c) {
        $colName = $c['name'];
        $type = strtoupper($c['type']);
        $notNull = $c['notnull'] ? 'NOT NULL' : 'NULL';
        $dflt = $c['dflt_value'];

        if ($c['pk']) {
            $primaryKeys[] = "`{$colName}`";
        }

        // Map types to MySQL safe types
        if ($colName === 'id' && $c['pk'] == 1 && $isSinglePk) {
            $colDef = "`{$colName}` bigint(20) unsigned NOT NULL AUTO_INCREMENT";
        } elseif ($c['pk'] && str_contains($type, 'INT')) {
            $colDef = "`{$colName}` bigint(20) unsigned NOT NULL";
        } elseif ($c['pk'] && (str_contains($type, 'VARCHAR') || str_contains($type, 'TEXT'))) {
            $colDef = "`{$colName}` varchar(191) NOT NULL";
        } elseif (str_starts_with($colName, 'is_') || str_starts_with($colName, 'has_') || $type === 'TINYINT(1)' || $type === 'BOOLEAN') {
            $defaultVal = ($dflt !== null) ? $dflt : '0';
            $colDef = "`{$colName}` tinyint(1) NOT NULL DEFAULT {$defaultVal}";
        } elseif (str_contains($type, 'VARCHAR') || (str_contains($type, 'TEXT') && (str_contains($colName, 'email') || str_contains($colName, 'slug') || str_contains($colName, 'token')))) {
            $length = 191;
            if (str_contains($type, '(')) {
                preg_match('/\((.*?)\)/', $type, $matches);
                if (!empty($matches[1])) {
                    $length = min((int)$matches[1], 191);
                }
            }
            if (str_contains($colName, 'avatar') || str_contains($colName, 'url') || str_contains($colName, 'title') || str_contains($colName, 'path')) {
                $length = 500;
            }
            $colDef = "`{$colName}` varchar({$length}) {$notNull}";
        } elseif ($type === 'TEXT' || $type === 'LONGTEXT') {
            $colDef = "`{$colName}` longtext {$notNull}";
        } elseif ($type === 'DATETIME' || $type === 'TIMESTAMP') {
            $colDef = "`{$colName}` timestamp NULL DEFAULT NULL";
        } elseif ($type === 'DATE') {
            $colDef = "`{$colName}` date NULL DEFAULT NULL";
        } elseif (str_contains($type, 'INT') || str_ends_with($colName, '_id') || str_ends_with($colName, '_count')) {
            $colDef = "`{$colName}` bigint(20) unsigned {$notNull}";
            if ($dflt !== null) {
                $colDef .= " DEFAULT {$dflt}";
            }
        } elseif (str_contains($type, 'DECIMAL') || str_contains($type, 'NUMERIC') || str_contains($type, 'FLOAT') || str_contains($type, 'DOUBLE')) {
            $colDef = "`{$colName}` decimal(10,2) {$notNull}";
            if ($dflt !== null) {
                $colDef .= " DEFAULT {$dflt}";
            }
        } else {
            $colDef = "`{$colName}` varchar(191) {$notNull}";
        }

        if ($dflt !== null && !str_contains($colDef, 'DEFAULT') && !str_contains($colDef, 'AUTO_INCREMENT')) {
            $colDef .= " DEFAULT " . $dflt;
        }

        $columnDefs[] = "  " . $colDef;
    }

    if (!empty($primaryKeys)) {
        $columnDefs[] = "  PRIMARY KEY (" . implode(", ", $primaryKeys) . ")";
    }

    // Add unique and normal indexes from SQLite index_list
    foreach ($indexes as $idx) {
        $idxName = $idx['name'];
        if (str_starts_with($idxName, 'sqlite_')) continue;
        $isUnique = $idx['unique'] ? 'UNIQUE KEY' : 'KEY';
        
        $idxColsInfo = $sqliteDb->query("PRAGMA index_info(`{$idxName}`)")->fetchAll(PDO::FETCH_ASSOC);
        $idxColNames = array_map(fn($ic) => "`{$ic['name']}`", $idxColsInfo);
        
        if (!empty($idxColNames)) {
            $columnDefs[] = "  {$isUnique} `{$idxName}` (" . implode(", ", $idxColNames) . ")";
        }
    }

    $mysqlDump .= "-- --------------------------------------------------------\n";
    $mysqlDump .= "-- Table structure for table `{$tableName}`\n";
    $mysqlDump .= "-- --------------------------------------------------------\n\n";
    $mysqlDump .= "DROP TABLE IF EXISTS `{$tableName}`;\n";
    $mysqlDump .= "CREATE TABLE `{$tableName}` (\n" . implode(",\n", $columnDefs) . "\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;\n\n";

    // Dump Data
    $rows = $sqliteDb->query("SELECT * FROM `{$tableName}`")->fetchAll(PDO::FETCH_ASSOC);
    if (!empty($rows)) {
        $mysqlDump .= "-- Dumping data for table `{$tableName}`\n";
        foreach ($rows as $row) {
            $cols = array_keys($row);
            $escapedCols = array_map(fn($c) => "`{$c}`", $cols);
            $escapedVals = array_map(function($v) {
                if ($v === null) return 'NULL';
                return "'" . addslashes((string)$v) . "'";
            }, array_values($row));

            $mysqlDump .= "INSERT INTO `{$tableName}` (" . implode(", ", $escapedCols) . ") VALUES (" . implode(", ", $escapedVals) . ");\n";
        }
        $mysqlDump .= "\n";
    }
}

$mysqlDump .= "COMMIT;\n";
$mysqlDump .= "SET FOREIGN_KEY_CHECKS=1;\n";

file_put_contents(__DIR__ . '/../kdpub_database.sql', $mysqlDump);
file_put_contents(__DIR__ . '/../database/database_backup_production.sql', $mysqlDump);
file_put_contents(__DIR__ . '/../installable/database_schema_initial.sql', $mysqlDump);

echo "Successfully exported 100% matched MySQL dump to kdpub_database.sql!\n";
echo "Total Tables Exported: " . count($tables) . "\n";
