<?php
/**
 * Knowledge Dynamics — Web-based Deployment, Database Updater & Maintenance Cockpit
 * For cPanel environments without SSH/Terminal access.
 * Access: https://kdpub.com/installer.php?key=kdpub2026
 */

$secretKey = 'kdpub2026';

if (empty($_GET['key']) || $_GET['key'] !== $secretKey) {
    http_response_code(403);
    die('<div style="font-family:sans-serif;padding:40px;text-align:center;"><h2>403 Forbidden</h2><p>Access key required. Use <code>?key=kdpub2026</code></p></div>');
}

define('LARAVEL_START', microtime(true));

// Auto-detect project root
$basePath = __DIR__ . '/..';
if (!file_exists($basePath . '/vendor/autoload.php')) {
    $basePath = dirname(__DIR__) . '/knowdyn_core';
}

if (!file_exists($basePath . '/vendor/autoload.php')) {
    die('<div style="font-family:sans-serif;padding:40px;color:red;"><h2>Error: vendor/autoload.php not found</h2><p>Please ensure all files are uploaded and paths are correct.</p></div>');
}

require $basePath . '/vendor/autoload.php';
$app = require_once $basePath . '/bootstrap/app.php';

use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

$action = $_GET['action'] ?? 'status';
$results = [];
$actionMessage = null;

// Handle Specific Actions
if ($action === 'migrate') {
    try {
        Artisan::call('migrate', ['--force' => true]);
        $output = Artisan::output();
        $actionMessage = ['type' => 'success', 'title' => 'Database Migrations Executed', 'msg' => $output ?: 'All database tables and new migrations are fully up to date!'];
    } catch (\Throwable $e) {
        $actionMessage = ['type' => 'error', 'title' => 'Migration Error', 'msg' => $e->getMessage()];
    }
} elseif ($action === 'seed') {
    try {
        Artisan::call('db:seed', ['--force' => true]);
        $output = Artisan::output();
        $actionMessage = ['type' => 'success', 'title' => 'Database Seeders Executed', 'msg' => $output ?: 'Default settings, journals, and roles synced!'];
    } catch (\Throwable $e) {
        $actionMessage = ['type' => 'error', 'title' => 'Seeder Error', 'msg' => $e->getMessage()];
    }
} elseif ($action === 'optimize') {
    try {
        Artisan::call('config:cache');
        Artisan::call('route:cache');
        Artisan::call('view:cache');
        $actionMessage = ['type' => 'success', 'title' => 'Cache Optimized', 'msg' => 'Config, routes, and views compiled for high speed.'];
    } catch (\Throwable $e) {
        $actionMessage = ['type' => 'error', 'title' => 'Optimization Error', 'msg' => $e->getMessage()];
    }
} elseif ($action === 'clear') {
    try {
        Artisan::call('config:clear');
        Artisan::call('cache:clear');
        Artisan::call('view:clear');
        Artisan::call('route:clear');
        $actionMessage = ['type' => 'success', 'title' => 'All Caches Cleared', 'msg' => 'Application caches flushed clean.'];
    } catch (\Throwable $e) {
        $actionMessage = ['type' => 'error', 'title' => 'Clear Cache Error', 'msg' => $e->getMessage()];
    }
}

// 1. Check Database Connection
try {
    DB::connection()->getPdo();
    $dbName = DB::connection()->getDatabaseName();
    $tableCount = count(DB::select('SHOW TABLES'));
    $results[] = [
        'title' => 'MySQL Database Connection',
        'status' => 'success',
        'msg' => "Connected to database '{$dbName}' successfully ({$tableCount} active tables detected)."
    ];
} catch (\Throwable $e) {
    $results[] = [
        'title' => 'MySQL Database Connection',
        'status' => 'error',
        'msg' => 'Could not connect: ' . $e->getMessage()
    ];
}

// 2. Storage Symlink
try {
    $publicStorage = __DIR__ . '/storage';
    $targetStorage = $basePath . '/storage/app/public';
    
    if (!file_exists($publicStorage)) {
        if (function_exists('symlink')) {
            @symlink($targetStorage, $publicStorage);
        }
        if (!file_exists($publicStorage)) {
            File::copyDirectory($targetStorage, $publicStorage);
        }
    }
    $results[] = [
        'title' => 'Public Storage / Media Assets',
        'status' => 'success',
        'msg' => 'Storage directory linked and active for user file uploads & manuscripts.'
    ];
} catch (\Throwable $e) {
    $results[] = ['title' => 'Public Storage', 'status' => 'warning', 'msg' => $e->getMessage()];
}

// 3. Environment & Key Status
$appKey = config('app.key');
$results[] = [
    'title' => 'Application Key & Environment',
    'status' => $appKey ? 'success' : 'error',
    'msg' => $appKey ? 'App Key is configured. Environment: ' . config('app.env') : 'Missing APP_KEY in .env file.'
];

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Knowledge Dynamics — cPanel Operations & Updater</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #070c18; color: #f1f5f9; padding: 30px 16px; margin: 0; }
        .card { max-width: 680px; margin: 0 auto; background: #0e172a; border: 1px solid #1e293b; border-radius: 16px; padding: 28px; box-shadow: 0 20px 40px rgba(0,0,0,0.5); }
        h1 { font-size: 20px; color: #38bdf8; margin-top: 0; display: flex; align-items: center; gap: 8px; }
        .item { padding: 12px 16px; border-radius: 10px; margin-bottom: 10px; font-size: 13.5px; display: flex; align-items: flex-start; gap: 12px; }
        .success { background: rgba(16, 185, 129, 0.12); border: 1px solid rgba(16, 185, 129, 0.3); color: #34d399; }
        .warning { background: rgba(245, 158, 11, 0.12); border: 1px solid rgba(245, 158, 11, 0.3); color: #fbbf24; }
        .error { background: rgba(239, 68, 68, 0.12); border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171; }
        .action-banner { padding: 14px 18px; border-radius: 10px; margin-bottom: 20px; font-size: 13.5px; }
        .actions-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 10px; margin: 24px 0 16px; }
        .btn-action { display: block; text-align: center; background: #1e293b; border: 1px solid #334155; color: #f8fafc; text-decoration: none; padding: 11px 14px; border-radius: 9px; font-size: 13px; font-weight: 600; transition: all 0.15s ease; }
        .btn-action:hover { background: #334155; border-color: #38bdf8; color: #38bdf8; transform: translateY(-1px); }
        .btn-action.primary { background: #0284c7; border-color: #0284c7; color: #fff; }
        .btn-action.primary:hover { background: #0369a1; }
        .nav-links { margin-top: 24px; padding-top: 20px; border-top: 1px solid #1e293b; display: flex; justify-content: space-between; align-items: center; }
        .nav-links a { color: #38bdf8; text-decoration: none; font-size: 13px; font-weight: 500; }
        .nav-links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="card">
        <h1>⚡ Knowledge Dynamics — Deployment & Updater Cockpit</h1>
        <p style="color: #94a3b8; font-size: 13.5px; margin-bottom: 20px;">Web-based system maintenance tool for cPanel (Terminal-Free).</p>
        
        <?php if ($actionMessage): ?>
            <div class="action-banner <?= $actionMessage['type'] ?>">
                <strong><?= htmlspecialchars($actionMessage['title']) ?>:</strong>
                <pre style="margin: 6px 0 0; white-space: pre-wrap; font-family: monospace; font-size: 12px;"><?= htmlspecialchars($actionMessage['msg']) ?></pre>
            </div>
        <?php endif; ?>

        <?php foreach ($results as $r): ?>
            <div class="item <?= $r['status'] ?>">
                <span style="font-size: 16px;"><?= $r['status'] === 'success' ? '✅' : ($r['status'] === 'warning' ? '⚠️' : '❌') ?></span>
                <div>
                    <strong><?= htmlspecialchars($r['title']) ?></strong>
                    <div style="font-size: 12.5px; opacity: 0.9; margin-top: 2px;"><?= htmlspecialchars($r['msg']) ?></div>
                </div>
            </div>
        <?php endforeach; ?>

        <h3 style="font-size: 14px; color: #cbd5e1; margin: 22px 0 8px;">🛠️ 1-Click Operations (Terminal-Free):</h3>
        <div class="actions-grid">
            <a href="?key=<?= $secretKey ?>&action=migrate" class="btn-action primary">🔄 Run DB Migrations</a>
            <a href="?key=<?= $secretKey ?>&action=seed" class="btn-action">🌱 Sync Seed Data</a>
            <a href="?key=<?= $secretKey ?>&action=clear" class="btn-action">🧹 Clear All Caches</a>
            <a href="?key=<?= $secretKey ?>&action=optimize" class="btn-action">🚀 Optimize Caches</a>
        </div>

        <div class="nav-links">
            <a href="/" target="_blank">🌐 View Website Homepage ↗</a>
            <a href="/admin" target="_blank">👑 Admin Control Cockpit ↗</a>
        </div>
    </div>
</body>
</html>
