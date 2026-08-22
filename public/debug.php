<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

echo "<h2>Knowledge Dynamics Server Diagnostic</h2>";

echo "<b>PHP Version:</b> " . PHP_VERSION . "<br>";
echo "<b>Current Directory:</b> " . __DIR__ . "<br>";
echo "<b>Base Directory:</b> " . realpath(__DIR__ . '/..') . "<br>";

$basePath = realpath(__DIR__ . '/..');

echo "<h3>Files Check</h3>";
echo ".env exists: " . (file_exists($basePath . '/.env') ? 'YES' : 'NO') . "<br>";
echo "vendor/autoload.php exists: " . (file_exists($basePath . '/vendor/autoload.php') ? 'YES' : 'NO') . "<br>";
echo "bootstrap/app.php exists: " . (file_exists($basePath . '/bootstrap/app.php') ? 'YES' : 'NO') . "<br>";
echo "public/build/manifest.json exists: " . (file_exists(__DIR__ . '/build/manifest.json') ? 'YES' : 'NO') . "<br>";

echo "<h3>Trying Laravel Bootstrap</h3>";
try {
    require $basePath . '/vendor/autoload.php';
    echo "Vendor autoload: SUCCESS<br>";
    
    $app = require_once $basePath . '/bootstrap/app.php';
    echo "Bootstrap app: SUCCESS<br>";
    
    $kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);
    echo "Kernel make: SUCCESS<br>";
    
    // Check DB connection
    $pdo = Illuminate\Support\Facades\DB::connection()->getPdo();
    echo "Database connection: SUCCESS (" . $pdo->getAttribute(PDO::ATTR_DRIVER_NAME) . ")<br>";
    
    $userCount = Illuminate\Support\Facades\DB::table('users')->count();
    echo "Users count in DB: " . $userCount . "<br>";
    
    $journalCount = Illuminate\Support\Facades\DB::table('journals')->count();
    echo "Journals count in DB: " . $journalCount . "<br>";
    
} catch (Throwable $e) {
    echo "<div style='color:red; background:#fee; padding:15px; border-radius:8px;'>";
    echo "<b>EXCEPTION:</b> " . get_class($e) . "<br>";
    echo "<b>MESSAGE:</b> " . htmlspecialchars($e->getMessage()) . "<br>";
    echo "<b>FILE:</b> " . $e->getFile() . " on line " . $e->getLine() . "<br>";
    echo "<pre>" . htmlspecialchars($e->getTraceAsString()) . "</pre>";
    echo "</div>";
}
