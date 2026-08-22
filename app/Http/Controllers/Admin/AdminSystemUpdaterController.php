<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\AuditLog;
use App\Services\SystemUpdaterService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use Inertia\Response;

class AdminSystemUpdaterController extends Controller
{
    protected SystemUpdaterService $updaterService;

    public function __construct(SystemUpdaterService $updaterService)
    {
        $this->updaterService = $updaterService;
    }

    /**
     * Display the System Updater Dashboard.
     */
    public function index(): Response
    {
        $diagnostics = $this->updaterService->getSystemDiagnostics();

        return Inertia::render('Admin/SystemUpdater/Index', [
            'diagnostics' => $diagnostics,
        ]);
    }

    /**
     * Process an uploaded update .zip package.
     */
    public function upload(Request $request): RedirectResponse
    {
        $request->validate([
            'update_zip' => 'required|file|mimes:zip|max:102400', // max 100MB
        ]);

        try {
            $result = $this->updaterService->processZipUpdate($request->file('update_zip'));

            // Safely log update action in audit log
            try {
                AuditLog::record(
                    'system_update',
                    null,
                    null,
                    ['files_count' => $result['files_count'] ?? 0, 'status' => 'success']
                );
            } catch (\Throwable $logEx) {
                // Ignore audit log error so update succeeds
            }

            return back()->with('success', $result['message']);
        } catch (\Throwable $e) {
            return back()->with('error', 'Update Failed: ' . $e->getMessage());
        }
    }

    /**
     * 1-Click Run Database Migrations.
     */
    public function migrate(): RedirectResponse
    {
        try {
            Artisan::call('migrate', ['--force' => true]);
            $output = Artisan::output() ?: 'All database tables are up to date.';

            return back()->with('success', 'Database migrations executed: ' . trim($output));
        } catch (\Throwable $e) {
            return back()->with('error', 'Migration error: ' . $e->getMessage());
        }
    }

    /**
     * 1-Click Clear and Optimize Caches.
     */
    public function clearCache(): RedirectResponse
    {
        try {
            Artisan::call('config:clear');
            Artisan::call('cache:clear');
            Artisan::call('view:clear');
            Artisan::call('route:clear');

            return back()->with('success', 'All system, route, config, and view caches have been cleared.');
        } catch (\Throwable $e) {
            return back()->with('error', 'Cache error: ' . $e->getMessage());
        }
    }

    /**
     * 1-Click Database & Storage Health Check.
     */
    public function healthCheck(): JsonResponse
    {
        $diagnostics = $this->updaterService->getSystemDiagnostics();
        return response()->json($diagnostics);
    }
}
