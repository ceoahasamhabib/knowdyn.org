<?php

namespace Tests\Feature;

use App\Models\User;
use App\Services\SystemUpdaterService;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\File;
use Tests\TestCase;
use ZipArchive;

class SystemUpdaterTest extends TestCase
{
    use RefreshDatabase;

    protected User $admin;
    protected User $regularUser;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);

        $this->admin = User::factory()->create(['email' => 'admin@kdpub.com']);
        $this->admin->assignRole('super-admin');

        $this->regularUser = User::factory()->create(['email' => 'author@univ.edu']);
    }

    public function test_admin_can_access_system_updater_page(): void
    {
        $response = $this->actingAs($this->admin)->get(route('admin.system_updater.index'));
        $response->assertOk();
    }

    public function test_regular_user_cannot_access_system_updater(): void
    {
        $response = $this->actingAs($this->regularUser)->get(route('admin.system_updater.index'));
        $response->assertForbidden();
    }

    public function test_system_updater_diagnostics_returns_valid_structure(): void
    {
        $service = app(SystemUpdaterService::class);
        $diagnostics = $service->getSystemDiagnostics();

        $this->assertArrayHasKey('php_version', $diagnostics);
        $this->assertArrayHasKey('laravel_version', $diagnostics);
        $this->assertArrayHasKey('db_connected', $diagnostics);
        $this->assertArrayHasKey('zip_enabled', $diagnostics);
        $this->assertArrayHasKey('history', $diagnostics);
    }

    public function test_updater_service_processes_valid_zip_payload_safely(): void
    {
        $testZipPath = storage_path('app/test_update.zip');
        $zip = new ZipArchive();
        $zip->open($testZipPath, ZipArchive::CREATE | ZipArchive::OVERWRITE);
        
        // Add a mock test file
        $zip->addFromString('resources/test_updater_mock.txt', 'Updater mock payload v1.2.0');
        $zip->close();

        $service = app(SystemUpdaterService::class);
        $result = $service->processZipUpdate($testZipPath);

        $this->assertTrue($result['success']);
        $this->assertGreaterThanOrEqual(1, $result['files_count']);
        $this->assertFileExists(base_path('resources/test_updater_mock.txt'));

        // Cleanup mock
        File::delete(base_path('resources/test_updater_mock.txt'));
        File::delete($testZipPath);
    }

    public function test_updater_rejects_malicious_path_traversal(): void
    {
        $maliciousZip = storage_path('app/malicious.zip');
        $zip = new ZipArchive();
        $zip->open($maliciousZip, ZipArchive::CREATE | ZipArchive::OVERWRITE);
        $zip->addFromString('../../../secret.txt', 'malicious data');
        $zip->close();

        $service = app(SystemUpdaterService::class);

        $this->expectException(\Exception::class);
        $this->expectExceptionMessage('Security violation detected');

        try {
            $service->processZipUpdate($maliciousZip);
        } finally {
            File::delete($maliciousZip);
        }
    }

    public function test_admin_can_trigger_db_migrations_and_cache_cleanup(): void
    {
        $migrateResponse = $this->actingAs($this->admin)->post(route('admin.system_updater.migrate'));
        $migrateResponse->assertRedirect();

        $cacheResponse = $this->actingAs($this->admin)->post(route('admin.system_updater.clear_cache'));
        $cacheResponse->assertRedirect();
    }
}
