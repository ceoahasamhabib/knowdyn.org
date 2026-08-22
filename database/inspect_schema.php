<?php
putenv('DB_CONNECTION=sqlite');
$_ENV['DB_CONNECTION'] = 'sqlite';
$_SERVER['DB_CONNECTION'] = 'sqlite';

require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

config([
    'database.default' => 'sqlite',
    'database.connections.sqlite.database' => database_path('database.sqlite'),
]);

DB::purge();
DB::reconnect();

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

$tables = DB::select("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
foreach ($tables as $t) {
    $tableName = $t->name;
    echo "=== Table: {$tableName} ===\n";
    $columns = Schema::getColumnListing($tableName);
    echo implode(", ", $columns) . "\n\n";
}
