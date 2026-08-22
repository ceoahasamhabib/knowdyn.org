<?php

namespace Tests\Feature;

use App\Models\SiteSetting;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ThemeCustomizationTest extends TestCase
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

    public function test_admin_can_update_theme_preset_and_typography(): void
    {
        $response = $this->actingAs($this->admin)->post(route('admin.settings.update'), [
            'settings' => [
                'theme_preset' => 'royal-indigo',
                'theme_primary_color' => '#312E81',
                'theme_accent_color' => '#4F46E5',
                'theme_font_sans' => 'Plus Jakarta Sans',
                'theme_font_heading' => 'Plus Jakarta Sans',
                'theme_border_radius' => '16px',
            ],
        ]);

        $response->assertRedirect();
        $this->assertEquals('royal-indigo', SiteSetting::get('theme_preset'));
        $this->assertEquals('#312E81', SiteSetting::get('theme_primary_color'));
        $this->assertEquals('#4F46E5', SiteSetting::get('theme_accent_color'));
        $this->assertEquals('Plus Jakarta Sans', SiteSetting::get('theme_font_sans'));
    }

    public function test_inertia_middleware_shares_theme_data(): void
    {
        SiteSetting::set('theme_preset', 'emerald-bio');
        SiteSetting::set('theme_primary_color', '#064E3B');

        $response = $this->actingAs($this->admin)->get(route('admin.dashboard'));
        $response->assertOk();

        $response->assertInertia(fn ($page) => $page
            ->has('theme')
            ->where('theme.preset', 'emerald-bio')
            ->where('theme.primary_color', '#064E3B')
        );
    }
}
