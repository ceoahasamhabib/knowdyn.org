<?php

namespace Tests\Feature;

use App\Models\SiteSetting;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class BrandLogoUploadTest extends TestCase
{
    use RefreshDatabase;

    protected User $admin;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(RolesAndPermissionsSeeder::class);

        $this->admin = User::factory()->create(['email' => 'admin@knowdyn.org']);
        $this->admin->assignRole('super-admin');
    }

    public function test_admin_can_upload_brand_logo_and_favicon(): void
    {
        Storage::fake('public');

        $logo = UploadedFile::fake()->image('custom_logo.png', 400, 100);
        $favicon = UploadedFile::fake()->create('custom_favicon.svg', 10, 'image/svg+xml');

        $response = $this->actingAs($this->admin)->post(route('admin.settings.update'), [
            'brand_logo' => $logo,
            'brand_favicon' => $favicon,
            'settings' => [
                'site_name' => 'Knowledge Dynamics Scholarly',
                'seo_meta_description' => 'A test SEO meta description for KD platform.',
            ],
        ]);

        $response->assertRedirect();

        $savedLogo = SiteSetting::get('brand_logo');
        $savedFavicon = SiteSetting::get('brand_favicon');

        $this->assertNotEmpty($savedLogo);
        $this->assertStringContainsString('branding/logo_', $savedLogo);

        $this->assertNotEmpty($savedFavicon);
        $this->assertStringContainsString('branding/favicon_', $savedFavicon);

        $this->assertEquals('Knowledge Dynamics Scholarly', SiteSetting::get('site_name'));
    }
}
