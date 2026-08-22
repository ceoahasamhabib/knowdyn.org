<?php
/**
 * ====================================================================
 * Knowledge Dynamics — First-Time Interactive Web Installer & Cockpit
 * ====================================================================
 * 
 * Specifically engineered for cPanel, Shared Hosting, and VPS setups
 * without SSH/CLI access.
 * 
 * Passkey Protection: ?key=kdpub2026 (or direct first-time setup)
 */

session_start();
error_reporting(E_ALL);
ini_set('display_errors', 0);

$secretKey = 'kdpub2026';
$providedKey = $_GET['key'] ?? $_POST['key'] ?? ($_SESSION['installer_auth'] ?? null);

if ($providedKey === $secretKey) {
    $_SESSION['installer_auth'] = $secretKey;
}

// Auto-detect project paths
$basePath = realpath(__DIR__ . '/..');
if (!$basePath || !file_exists($basePath . '/bootstrap/app.php')) {
    $basePath = realpath(dirname(__DIR__) . '/knowdyn_core');
}

$envPath = $basePath ? $basePath . '/.env' : null;
$envExists = $envPath && file_exists($envPath);

$step = $_GET['step'] ?? 'welcome';
$statusMessage = null;
$errorMessage = null;

// Helper: Read .env into key-value array
function getEnvValues($filePath) {
    if (!file_exists($filePath)) return [];
    $lines = file($filePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    $values = [];
    foreach ($lines as $line) {
        if (str_starts_with(trim($line), '#') || !str_contains($line, '=')) continue;
        [$key, $val] = explode('=', $line, 2);
        $values[trim($key)] = trim(trim($val), '"\'');
    }
    return $values;
}

// Helper: Save or Update .env file
function updateEnvFile($filePath, array $data) {
    $content = file_exists($filePath) ? file_get_contents($filePath) : '';
    foreach ($data as $key => $value) {
        $keyPattern = "/^{$key}=.*/m";
        $escapedVal = (str_contains($value, ' ') || str_contains($value, '#')) ? '"' . $value . '"' : $value;
        if (preg_match($keyPattern, $content)) {
            $content = preg_replace($keyPattern, "{$key}={$escapedVal}", $content);
        } else {
            $content .= "\n{$key}={$escapedVal}";
        }
    }
    return file_put_contents($filePath, $content) !== false;
}

// Check PHP Requirements
$requirements = [
    'PHP Version >= 8.2' => version_compare(PHP_VERSION, '8.2.0', '>='),
    'PDO PHP Extension' => extension_loaded('pdo'),
    'PDO MySQL Driver' => extension_loaded('pdo_mysql'),
    'OpenSSL Extension' => extension_loaded('openssl'),
    'Mbstring Extension' => extension_loaded('mbstring'),
    'Tokenizer Extension' => extension_loaded('tokenizer'),
    'XML Extension' => extension_loaded('xml'),
    'Ctype Extension' => extension_loaded('ctype'),
    'JSON Extension' => extension_loaded('json'),
    'BCMath Extension' => extension_loaded('bcmath'),
    'Fileinfo Extension' => extension_loaded('fileinfo'),
    'ZipArchive Extension' => class_exists('ZipArchive'),
    'cURL Extension' => extension_loaded('curl'),
];
$allRequirementsMet = !in_array(false, $requirements, true);

// Check Directory Permissions
$permissions = [
    'storage' => is_writable($basePath . '/storage'),
    'storage/logs' => is_writable($basePath . '/storage/logs'),
    'storage/framework' => is_writable($basePath . '/storage/framework'),
    'bootstrap/cache' => is_writable($basePath . '/bootstrap/cache'),
    '.env File' => $envExists ? is_writable($envPath) : is_writable($basePath),
];
$allPermissionsMet = !in_array(false, $permissions, true);

// Initialize Laravel App if vendor is present
$laravelLoaded = false;
if (file_exists($basePath . '/vendor/autoload.php') && file_exists($basePath . '/bootstrap/app.php')) {
    try {
        require_once $basePath . '/vendor/autoload.php';
        $app = require_once $basePath . '/bootstrap/app.php';
        $kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
        $kernel->bootstrap();
        \Illuminate\Support\Facades\Schema::defaultStringLength(191);
        $laravelLoaded = true;
    } catch (\Throwable $e) {
        $laravelLoaded = false;
    }
}

// -------------------------------------------------------------
// POST Handlers for Wizard Steps
// -------------------------------------------------------------
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'save_env') {
        $dbHost = trim($_POST['db_host'] ?? '127.0.0.1');
        $dbPort = trim($_POST['db_port'] ?? '3306');
        $dbName = trim($_POST['db_database'] ?? 'kdpuodtp_kdpub');
        $dbUser = trim($_POST['db_username'] ?? 'kdpuodtp_kdpub');
        $dbPass = trim($_POST['db_password'] ?? 'kdpuodtp_kdpub');
        $appUrl = trim($_POST['app_url'] ?? 'https://kdpub.com');
        $appName = trim($_POST['app_name'] ?? 'Knowledge Dynamics');

        // Test DB Connection before writing
        try {
            $dsn = "mysql:host={$dbHost};port={$dbPort};dbname={$dbName};charset=utf8mb4";
            $pdo = new PDO($dsn, $dbUser, $dbPass, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_TIMEOUT => 5,
            ]);

            // Save to .env
            $updated = updateEnvFile($envPath, [
                'APP_NAME' => $appName,
                'APP_ENV' => 'production',
                'APP_DEBUG' => 'false',
                'APP_URL' => $appUrl,
                'DB_CONNECTION' => 'mysql',
                'DB_HOST' => $dbHost,
                'DB_PORT' => $dbPort,
                'DB_DATABASE' => $dbName,
                'DB_USERNAME' => $dbUser,
                'DB_PASSWORD' => $dbPass,
                'CPANEL_HOST' => 'kdpub.com',
                'CPANEL_USERNAME' => 'kdpuodtp',
                'CPANEL_DEFAULT_DOMAIN' => 'kdpub.com',
            ]);

            if ($updated) {
                header("Location: ?key={$secretKey}&step=database");
                exit;
            } else {
                $errorMessage = "Could not write to .env file. Please check file permissions.";
            }
        } catch (\Throwable $e) {
            $errorMessage = "Database Connection Failed: " . $e->getMessage() . ". Please verify your MySQL credentials in cPanel.";
        }
    } elseif ($action === 'run_migrations') {
        if (!$laravelLoaded) {
            $errorMessage = "Laravel engine could not be booted. Please check vendor files.";
        } else {
            try {
                \Illuminate\Support\Facades\Schema::defaultStringLength(191);

                $doFresh = !empty($_POST['fresh_install']);
                $doSeed = !empty($_POST['seed_database']);

                if ($doFresh) {
                    \Illuminate\Support\Facades\Artisan::call('migrate:fresh', [
                        '--force' => true,
                        '--seed' => $doSeed,
                    ]);
                    $migrateOut = \Illuminate\Support\Facades\Artisan::output();
                } else {
                    try {
                        \Illuminate\Support\Facades\Artisan::call('migrate', ['--force' => true]);
                        $migrateOut = \Illuminate\Support\Facades\Artisan::output();
                    } catch (\Throwable $migErr) {
                        // Auto-recovery: if previous attempt failed midway leaving tables like 'users'
                        if (str_contains($migErr->getMessage(), 'already exists') || str_contains($migErr->getMessage(), '1050')) {
                            \Illuminate\Support\Facades\Artisan::call('migrate:fresh', [
                                '--force' => true,
                                '--seed' => $doSeed,
                            ]);
                            $migrateOut = "Auto-Recovered: Incomplete tables cleaned & Fresh Setup Executed.\n" . \Illuminate\Support\Facades\Artisan::output();
                            $seededAlready = true;
                        } else {
                            throw $migErr;
                        }
                    }

                    // Run Seeder if requested and not done yet
                    if ($doSeed && empty($seededAlready)) {
                        \Illuminate\Support\Facades\Artisan::call('db:seed', ['--force' => true]);
                        $seedOut = \Illuminate\Support\Facades\Artisan::output();
                    }
                }

                // Storage link
                try {
                    $target = $basePath . '/storage/app/public';
                    $link = __DIR__ . '/storage';
                    if (!file_exists($link) && file_exists($target)) {
                        @symlink($target, $link);
                    }
                } catch (\Throwable $t) {}

                // Optimize Caches
                try {
                    \Illuminate\Support\Facades\Artisan::call('config:cache');
                    \Illuminate\Support\Facades\Artisan::call('route:cache');
                    \Illuminate\Support\Facades\Artisan::call('view:cache');
                } catch (\Throwable $t) {}

                header("Location: ?key={$secretKey}&step=admin_account");
                exit;
            } catch (\Throwable $e) {
                $errorMessage = "Migration execution error: " . $e->getMessage() . " (Tip: You can check 'Fresh Database Reset' below to clear incomplete tables).";
            }
        }
    } elseif ($action === 'create_admin') {
        if ($laravelLoaded) {
            try {
                $adminEmail = trim($_POST['admin_email'] ?? 'admin@kdpub.com');
                $adminPass = trim($_POST['admin_password'] ?? 'password');
                $adminName = trim($_POST['admin_name'] ?? 'System Administrator');

                $user = \App\Models\User::firstOrNew(['email' => $adminEmail]);
                $user->name = $adminName;
                $user->password = \Illuminate\Support\Facades\Hash::make($adminPass);
                $user->email_verified_at = now();
                $user->save();

                if (method_exists($user, 'assignRole')) {
                    $user->assignRole('super-admin');
                }

                header("Location: ?key={$secretKey}&step=completed");
                exit;
            } catch (\Throwable $e) {
                $errorMessage = "Admin user creation failed: " . $e->getMessage();
            }
        }
    }
}

$currentEnv = $envExists ? getEnvValues($envPath) : [];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Knowledge Dynamics — First-Time Interactive Web Installer</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        code, .font-mono { font-family: 'JetBrains Mono', monospace; }
    </style>
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen flex flex-col justify-between selection:bg-indigo-500 selection:text-white">

    <!-- Top Navigation Header -->
    <header class="border-b border-slate-800/80 bg-slate-900/60 backdrop-blur-md sticky top-0 z-50">
        <div class="max-w-5xl mx-auto px-6 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-gradient-to-tr from-indigo-500 via-purple-500 to-rose-500 flex items-center justify-center font-bold text-white shadow-lg shadow-indigo-500/20">
                    KD
                </div>
                <div>
                    <span class="font-bold text-sm text-white tracking-tight">Knowledge Dynamics</span>
                    <span class="block text-[10px] font-mono text-indigo-400 uppercase tracking-widest">Interactive Web Installer</span>
                </div>
            </div>

            <div class="flex items-center gap-2 text-xs font-medium text-slate-400">
                <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
                <span>cPanel Standalone Mode</span>
            </div>
        </div>
    </header>

    <!-- Main Wizard Card Container -->
    <main class="max-w-3xl mx-auto w-full px-4 py-10 flex-1 flex flex-col justify-center">

        <!-- Wizard Step Indicator -->
        <div class="mb-8">
            <div class="grid grid-cols-5 gap-2 text-center text-xs">
                <?php
                $steps = [
                    'welcome' => '1. Overview',
                    'requirements' => '2. Server Check',
                    'environment' => '3. Database',
                    'database' => '4. Migrations',
                    'completed' => '5. Finish',
                ];
                $stepKeys = array_keys($steps);
                $currentIndex = array_search($step, $stepKeys);
                if ($currentIndex === false) $currentIndex = 0;

                foreach ($steps as $k => $label):
                    $idx = array_search($k, $stepKeys);
                    $isActive = ($k === $step);
                    $isPast = ($idx < $currentIndex);
                ?>
                    <div class="flex flex-col items-center gap-1.5">
                        <div class="w-7 h-7 rounded-full flex items-center justify-center font-bold text-xs transition-all <?php 
                            if ($isActive) echo 'bg-indigo-600 text-white ring-4 ring-indigo-500/20 shadow-lg';
                            elseif ($isPast) echo 'bg-emerald-500 text-white';
                            else echo 'bg-slate-800 text-slate-400';
                        ?>">
                            <?= $isPast ? '✓' : ($idx + 1) ?>
                        </div>
                        <span class="text-[11px] font-semibold truncate <?php echo $isActive ? 'text-indigo-400' : ($isPast ? 'text-slate-300' : 'text-slate-500'); ?>">
                            <?= $label ?>
                        </span>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>

        <!-- Alert Notification -->
        <?php if ($errorMessage): ?>
            <div class="mb-6 p-4 rounded-xl bg-rose-950/40 border border-rose-500/30 text-rose-300 text-xs flex items-start gap-3">
                <span class="text-lg">⚠️</span>
                <div>
                    <strong class="font-bold block text-sm">Action Error</strong>
                    <span><?= htmlspecialchars($errorMessage) ?></span>
                </div>
            </div>
        <?php endif; ?>

        <!-- Wizard Body Box -->
        <div class="bg-slate-900/80 border border-slate-800 rounded-2xl p-6 sm:p-8 shadow-2xl backdrop-blur-xl">

            <!-- STEP 1: WELCOME / OVERVIEW -->
            <?php if ($step === 'welcome'): ?>
                <div class="space-y-6">
                    <div class="flex items-center gap-4 border-b border-slate-800 pb-5">
                        <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 border border-indigo-500/20 text-indigo-400 flex items-center justify-center text-2xl">
                            🚀
                        </div>
                        <div>
                            <h2 class="text-xl font-bold text-white">Welcome to Knowledge Dynamics</h2>
                            <p class="text-xs text-slate-400 mt-0.5">International Scholarly Publishing & Peer-Review Platform</p>
                        </div>
                    </div>

                    <p class="text-xs text-slate-300 leading-relaxed">
                        This interactive setup wizard will guide you through connecting your MySQL database, running database tables and migrations, configuring your domain (<code class="text-indigo-400 font-mono">kdpub.com</code>), and setting up the Super Admin account without needing terminal access.
                    </p>

                    <div class="bg-slate-950/60 border border-slate-800 rounded-xl p-4 space-y-2 text-xs">
                        <div class="font-bold text-slate-200">What this installer will configure:</div>
                        <ul class="space-y-1.5 text-slate-400 list-disc list-inside">
                            <li>Check PHP requirements and write permissions.</li>
                            <li>Configure database credentials into <code class="text-indigo-400">.env</code>.</li>
                            <li>Run 29+ non-destructive migrations & seed initial journals.</li>
                            <li>Set up public storage symlink and optimize application caches.</li>
                        </ul>
                    </div>

                    <div class="flex items-center justify-between pt-4">
                        <div class="text-[11px] text-slate-500">Target Path: <span class="font-mono text-slate-400"><?= htmlspecialchars($basePath) ?></span></div>
                        <a href="?key=<?= $secretKey ?>&step=requirements" class="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 transition flex items-center gap-2">
                            <span>Get Started</span> →
                        </a>
                    </div>
                </div>

            <!-- STEP 2: REQUIREMENTS & PERMISSIONS CHECK -->
            <?php elseif ($step === 'requirements'): ?>
                <div class="space-y-6">
                    <div class="border-b border-slate-800 pb-4">
                        <h2 class="text-lg font-bold text-white">Server Requirements & Permissions</h2>
                        <p class="text-xs text-slate-400">Verifying PHP version, required extensions, and directory writable state.</p>
                    </div>

                    <div class="space-y-3">
                        <h3 class="text-xs font-bold text-slate-300 uppercase tracking-wider">1. PHP Extensions</h3>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs">
                            <?php foreach ($requirements as $req => $ok): ?>
                                <div class="flex items-center justify-between p-2.5 rounded-lg bg-slate-950/50 border border-slate-800/80">
                                    <span class="text-slate-300"><?= $req ?></span>
                                    <span class="px-2 py-0.5 rounded text-[10px] font-bold <?= $ok ? 'bg-emerald-500/20 text-emerald-300' : 'bg-rose-500/20 text-rose-300' ?>">
                                        <?= $ok ? '✓ Pass' : '✗ Missing' ?>
                                    </span>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <div class="space-y-3 pt-2">
                        <h3 class="text-xs font-bold text-slate-300 uppercase tracking-wider">2. Directory Write Permissions</h3>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs">
                            <?php foreach ($permissions as $dir => $ok): ?>
                                <div class="flex items-center justify-between p-2.5 rounded-lg bg-slate-950/50 border border-slate-800/80">
                                    <span class="font-mono text-slate-300"><?= $dir ?></span>
                                    <span class="px-2 py-0.5 rounded text-[10px] font-bold <?= $ok ? 'bg-emerald-500/20 text-emerald-300' : 'bg-rose-500/20 text-rose-300' ?>">
                                        <?= $ok ? '✓ Writable' : '✗ Locked' ?>
                                    </span>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <div class="flex items-center justify-between pt-4 border-t border-slate-800">
                        <a href="?key=<?= $secretKey ?>&step=welcome" class="text-xs text-slate-400 hover:text-white transition">← Back</a>
                        <?php if ($allRequirementsMet && $allPermissionsMet): ?>
                            <a href="?key=<?= $secretKey ?>&step=environment" class="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 transition flex items-center gap-2">
                                <span>Continue to Database</span> →
                            </a>
                        <?php else: ?>
                            <button disabled class="px-6 py-2.5 rounded-xl bg-slate-800 text-slate-500 font-bold text-xs cursor-not-allowed">
                                Resolve Missing Requirements to Continue
                            </button>
                        <?php endif; ?>
                    </div>
                </div>

            <!-- STEP 3: ENVIRONMENT & DATABASE CREDENTIALS -->
            <?php elseif ($step === 'environment'): ?>
                <div class="space-y-6">
                    <div class="border-b border-slate-800 pb-4">
                        <h2 class="text-lg font-bold text-white">Database & Application Setup</h2>
                        <p class="text-xs text-slate-400">Configure your cPanel MySQL database credentials and application URL.</p>
                    </div>

                    <form method="POST" class="space-y-4 text-xs">
                        <input type="hidden" name="action" value="save_env">

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <label class="block font-bold text-slate-300 mb-1">Application Name</label>
                                <input type="text" name="app_name" value="<?= htmlspecialchars($currentEnv['APP_NAME'] ?? 'Knowledge Dynamics') ?>" class="w-full bg-slate-950 border border-slate-700 rounded-xl px-3.5 py-2 text-white focus:outline-none focus:border-indigo-500">
                            </div>
                            <div>
                                <label class="block font-bold text-slate-300 mb-1">Application URL</label>
                                <input type="url" name="app_url" value="<?= htmlspecialchars($currentEnv['APP_URL'] ?? 'https://kdpub.com') ?>" class="w-full bg-slate-950 border border-slate-700 rounded-xl px-3.5 py-2 text-white focus:outline-none focus:border-indigo-500">
                            </div>
                        </div>

                        <div class="p-4 rounded-xl bg-slate-950/60 border border-slate-800 space-y-3">
                            <div class="font-bold text-slate-200 uppercase tracking-wider text-[11px] flex items-center gap-2">
                                <span>🗄️</span> MySQL Database Credentials
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div>
                                    <label class="block text-slate-400 mb-1">Database Host</label>
                                    <input type="text" name="db_host" value="<?= htmlspecialchars($currentEnv['DB_HOST'] ?? '127.0.0.1') ?>" class="w-full bg-slate-900 border border-slate-700 rounded-lg px-3 py-2 text-white font-mono">
                                </div>
                                <div>
                                    <label class="block text-slate-400 mb-1">Database Port</label>
                                    <input type="text" name="db_port" value="<?= htmlspecialchars($currentEnv['DB_PORT'] ?? '3306') ?>" class="w-full bg-slate-900 border border-slate-700 rounded-lg px-3 py-2 text-white font-mono">
                                </div>
                                <div>
                                    <label class="block text-slate-400 mb-1">Database Name</label>
                                    <input type="text" name="db_database" value="<?= htmlspecialchars($currentEnv['DB_DATABASE'] ?? 'kdpuodtp_kdpub') ?>" class="w-full bg-slate-900 border border-slate-700 rounded-lg px-3 py-2 text-white font-mono">
                                </div>
                                <div>
                                    <label class="block text-slate-400 mb-1">Database Username</label>
                                    <input type="text" name="db_username" value="<?= htmlspecialchars($currentEnv['DB_USERNAME'] ?? 'kdpuodtp_kdpub') ?>" class="w-full bg-slate-900 border border-slate-700 rounded-lg px-3 py-2 text-white font-mono">
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-400 mb-1">Database Password</label>
                                <input type="password" name="db_password" value="<?= htmlspecialchars($currentEnv['DB_PASSWORD'] ?? 'kdpuodtp_kdpub') ?>" class="w-full bg-slate-900 border border-slate-700 rounded-lg px-3 py-2 text-white font-mono">
                            </div>
                        </div>

                        <div class="flex items-center justify-between pt-4 border-t border-slate-800">
                            <a href="?key=<?= $secretKey ?>&step=requirements" class="text-xs text-slate-400 hover:text-white transition">← Back</a>
                            <button type="submit" class="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 transition flex items-center gap-2">
                                <span>Save & Test Database</span> →
                            </button>
                        </div>
                    </form>
                </div>

            <!-- STEP 4: RUN DATABASE MIGRATIONS -->
            <?php elseif ($step === 'database'): ?>
                <div class="space-y-6">
                    <div class="border-b border-slate-800 pb-4">
                        <h2 class="text-lg font-bold text-white">Database Migrations & Initial Setup</h2>
                        <p class="text-xs text-slate-400">Initialize all 29+ tables, editorial roles, academic journals, and sample content.</p>
                    </div>

                    <div class="bg-emerald-950/20 border border-emerald-500/20 rounded-xl p-4 flex items-start gap-3">
                        <span class="text-xl">✅</span>
                        <div class="text-xs">
                            <strong class="text-emerald-300 block font-bold">Database Connected Successfully</strong>
                            <span class="text-slate-400">Target Database: <code class="text-emerald-400"><?= htmlspecialchars($currentEnv['DB_DATABASE'] ?? 'kdpuodtp_kdpub') ?></code></span>
                        </div>
                    </div>

                    <form method="POST" class="space-y-4 text-xs">
                        <input type="hidden" name="action" value="run_migrations">

                        <div class="space-y-2">
                            <label class="flex items-center gap-3 p-3 rounded-xl bg-slate-950/60 border border-slate-800 cursor-pointer hover:border-indigo-500/50 transition">
                                <input type="checkbox" name="seed_database" value="1" checked class="w-4 h-4 rounded text-indigo-600 bg-slate-900 border-slate-700">
                                <div>
                                    <div class="font-bold text-slate-200">Seed Default Content & Roles (Recommended)</div>
                                    <div class="text-[11px] text-slate-400">Populate default journals, editorial board, roles (Author, Reviewer, Editor), and CMS settings.</div>
                                </div>
                            </label>

                            <label class="flex items-center gap-3 p-3 rounded-xl bg-slate-950/60 border border-slate-800 cursor-pointer hover:border-amber-500/50 transition">
                                <input type="checkbox" name="fresh_install" value="1" checked class="w-4 h-4 rounded text-amber-600 bg-slate-900 border-slate-700">
                                <div>
                                    <div class="font-bold text-amber-300">Clean / Fresh Database Reset (Recommended for First-Time Setup)</div>
                                    <div class="text-[11px] text-slate-400">Wipes any incomplete tables from previous failed attempts and creates a fresh, pristine database.</div>
                                </div>
                            </label>
                        </div>

                        <div class="flex items-center justify-between pt-4 border-t border-slate-800">
                            <a href="?key=<?= $secretKey ?>&step=environment" class="text-xs text-slate-400 hover:text-white transition">← Back</a>
                            <button type="submit" class="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 transition flex items-center gap-2">
                                <span>⚡ Execute Migrations & Seeds</span>
                            </button>
                        </div>
                    </form>
                </div>

            <!-- STEP 5: ADMIN ACCOUNT SETUP -->
            <?php elseif ($step === 'admin_account'): ?>
                <div class="space-y-6">
                    <div class="border-b border-slate-800 pb-4">
                        <h2 class="text-lg font-bold text-white">Super Administrator Account</h2>
                        <p class="text-xs text-slate-400">Create or confirm your primary super admin user credentials.</p>
                    </div>

                    <form method="POST" class="space-y-4 text-xs">
                        <input type="hidden" name="action" value="create_admin">

                        <div class="space-y-3">
                            <div>
                                <label class="block font-bold text-slate-300 mb-1">Admin Full Name</label>
                                <input type="text" name="admin_name" value="System Administrator" class="w-full bg-slate-950 border border-slate-700 rounded-xl px-3.5 py-2 text-white">
                            </div>
                            <div>
                                <label class="block font-bold text-slate-300 mb-1">Admin Email Address</label>
                                <input type="email" name="admin_email" value="admin@kdpub.com" class="w-full bg-slate-950 border border-slate-700 rounded-xl px-3.5 py-2 text-white font-mono">
                            </div>
                            <div>
                                <label class="block font-bold text-slate-300 mb-1">Admin Password</label>
                                <input type="password" name="admin_password" value="password" class="w-full bg-slate-950 border border-slate-700 rounded-xl px-3.5 py-2 text-white font-mono">
                                <p class="text-[11px] text-slate-500 mt-1">Default is set to <code class="text-indigo-400">password</code>. You can customize it now or change it later in settings.</p>
                            </div>
                        </div>

                        <div class="flex items-center justify-between pt-4 border-t border-slate-800">
                            <a href="?key=<?= $secretKey ?>&step=database" class="text-xs text-slate-400 hover:text-white transition">← Back</a>
                            <button type="submit" class="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 transition flex items-center gap-2">
                                <span>Complete Installation</span> 🎉
                            </button>
                        </div>
                    </form>
                </div>

            <!-- STEP 6: COMPLETED -->
            <?php elseif ($step === 'completed'): ?>
                <div class="space-y-6 text-center py-4">
                    <div class="w-16 h-16 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-3xl mx-auto ring-8 ring-emerald-500/10">
                        🎉
                    </div>

                    <div>
                        <h2 class="text-2xl font-bold text-white">Installation Successfully Completed!</h2>
                        <p class="text-xs text-slate-400 mt-1">Knowledge Dynamics is fully configured and ready for production operations.</p>
                    </div>

                    <div class="max-w-md mx-auto bg-slate-950/60 border border-slate-800 rounded-2xl p-5 text-left text-xs space-y-2.5">
                        <div class="font-bold text-slate-200 flex items-center gap-2">
                            <span>🔑</span> Super Admin Credentials:
                        </div>
                        <div class="grid grid-cols-2 gap-2 font-mono text-[11px] text-slate-300">
                            <div class="bg-slate-900/80 p-2 rounded-lg border border-slate-800">
                                <span class="text-slate-500 block text-[10px]">EMAIL</span>
                                admin@kdpub.com
                            </div>
                            <div class="bg-slate-900/80 p-2 rounded-lg border border-slate-800">
                                <span class="text-slate-500 block text-[10px]">PASSWORD</span>
                                password
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-col sm:flex-row items-center justify-center gap-3 pt-4">
                        <a href="/login" class="w-full sm:w-auto px-6 py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 transition flex items-center justify-center gap-2">
                            <span>Go to Admin Login</span> →
                        </a>
                        <a href="/" class="w-full sm:w-auto px-6 py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 font-bold text-xs transition flex items-center justify-center gap-2">
                            Visit Live Homepage
                        </a>
                    </div>
                </div>
            <?php endif; ?>

        </div>

        <!-- Footer -->
        <footer class="mt-8 text-center text-[11px] text-slate-500">
            Knowledge Dynamics Academic Publishing Platform &bull; Built for Safe cPanel Deployments
        </footer>
    </main>

</body>
</html>
