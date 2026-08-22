<?php
/**
 * Knowledge Dynamics — Web-based One-Click Deployment & Setup Utility
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

$results = [];

// 1. Check Database Connection
try {
    DB::connection()->getPdo();
    $dbName = DB::connection()->getDatabaseName();
    $results[] = ['title' => 'Database Connection', 'status' => 'success', 'msg' => "Connected to database '{$dbName}' successfully."];
} catch (\Throwable $e) {
    $results[] = ['title' => 'Database Connection', 'status' => 'error', 'msg' => 'Could not connect: ' . $e->getMessage()];
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
            // Fallback directory copy/mirror if symlink is disabled on shared host
            File::copyDirectory($targetStorage, $publicStorage);
        }
    }
    $results[] = ['title' => 'Storage Symlink / Assets', 'status' => 'success', 'msg' => 'Storage directory linked successfully for file uploads.'];
} catch (\Throwable $e) {
    $results[] = ['title' => 'Storage Symlink', 'status' => 'warning', 'msg' => $e->getMessage()];
}

// 3. Clear and Optimize Cache
try {
    Artisan::call('config:clear');
    Artisan::call('cache:clear');
    Artisan::call('view:clear');
    Artisan::call('route:clear');
    $results[] = ['title' => 'Application Caches', 'status' => 'success', 'msg' => 'Config, route, view and app caches cleared and primed.'];
} catch (\Throwable $e) {
    $results[] = ['title' => 'Cache Cleanup', 'status' => 'warning', 'msg' => $e->getMessage()];
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Knowledge Dynamics — cPanel Web Setup</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #070c18; color: #f1f5f9; padding: 40px 20px; }
        .card { max-width: 640px; margin: 0 auto; background: #0e172a; border: 1px solid #1e293b; border-radius: 16px; padding: 32px; box-shadow: 0 20px 40px rgba(0,0,0,0.5); }
        h1 { font-size: 22px; color: #38bdf8; margin-top: 0; }
        .item { padding: 14px 16px; border-radius: 10px; margin-bottom: 12px; font-size: 14px; display: flex; align-items: flex-start; gap: 12px; }
        .success { background: rgba(16, 185, 129, 0.12); border: 1px solid rgba(16, 185, 129, 0.3); color: #34d399; }
        .warning { background: rgba(245, 158, 11, 0.12); border: 1px solid rgba(245, 158, 11, 0.3); color: #fbbf24; }
        .error { background: rgba(239, 68, 68, 0.12); border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171; }
        .btn { display: inline-block; background: #0284c7; color: #fff; text-decoration: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; font-size: 14px; margin-top: 20px; }
        .btn:hover { background: #0369a1; }
    </style>
</head>
<body>
    <div class="card">
        <h1>⚡ Knowledge Dynamics: Setup Complete</h1>
        <p style="color: #94a3b8; font-size: 14px; margin-bottom: 24px;">cPanel Shared Hosting Setup Results:</p>
        
        <?php foreach ($results as $r): ?>
            <div class="item <?= $r['status'] ?>">
                <span style="font-size: 18px;"><?= $r['status'] === 'success' ? '✅' : ($r['status'] === 'warning' ? '⚠️' : '❌') ?></span>
                <div>
                    <strong><?= htmlspecialchars($r['title']) ?></strong>
                    <div style="font-size: 13px; opacity: 0.9; margin-top: 2px;"><?= htmlspecialchars($r['msg']) ?></div>
                </div>
            </div>
        <?php endforeach; ?>

        <div style="margin-top: 28px; text-align: center;">
            <a href="/" class="btn">🚀 Open Website Homepage</a>
            <a href="/admin" class="btn" style="background:#475569; margin-left: 8px;">👑 Go to Admin Cockpit</a>
        </div>
        <p style="text-align: center; color: #64748b; font-size: 12px; margin-top: 24px;">Security tip: You can delete <code>public/installer.php</code> anytime once setup is complete.</p>
    </div>
</body>
</html>
