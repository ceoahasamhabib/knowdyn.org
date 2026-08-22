<?php

namespace Tests\Feature;

use App\Models\MediaFile;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class AdminMediaLibraryTest extends TestCase
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

    public function test_admin_can_view_media_library_index(): void
    {
        MediaFile::create([
            'name' => 'Sample Image.png',
            'file_name' => 'sample_123.png',
            'disk' => 'public',
            'path' => 'branding/sample_123.png',
            'mime_type' => 'image/png',
            'size' => 10240,
            'folder' => 'branding',
        ]);

        $response = $this->actingAs($this->admin)->get(route('admin.media.index'));

        $response->assertOk();
        $response->assertInertia(fn ($page) => $page
            ->component('Admin/Media/Index')
            ->has('files.data', 1)
            ->has('stats')
        );
    }

    public function test_admin_can_upload_files_to_media_library(): void
    {
        Storage::fake('public');

        $file1 = UploadedFile::fake()->image('journal_cover.jpg', 600, 800);
        $file2 = UploadedFile::fake()->create('manuscript_draft.pdf', 500, 'application/pdf');

        $response = $this->actingAs($this->admin)->post(route('admin.media.store'), [
            'files' => [$file1, $file2],
            'folder' => 'journals',
        ]);

        $response->assertRedirect();
        $this->assertDatabaseCount('media_files', 2);

        $uploaded = MediaFile::where('name', 'journal_cover.jpg')->first();
        $this->assertNotNull($uploaded);
        $this->assertEquals('journals', $uploaded->folder);
        $this->assertTrue($uploaded->is_image);
        $this->assertNotEmpty($uploaded->url);
    }

    public function test_admin_can_query_media_via_json(): void
    {
        MediaFile::create([
            'name' => 'Logo White.svg',
            'file_name' => 'logo_white_456.svg',
            'disk' => 'public',
            'path' => 'branding/logo_white_456.svg',
            'mime_type' => 'image/svg+xml',
            'size' => 4096,
            'folder' => 'branding',
        ]);

        $response = $this->actingAs($this->admin)->getJson(route('admin.media.index', ['folder' => 'branding', 'json' => '1']));

        $response->assertOk();
        $response->assertJsonStructure([
            'files' => ['data'],
            'stats' => ['total_files', 'total_size', 'folders'],
        ]);
        $this->assertCount(1, $response->json('files.data'));
    }

    public function test_admin_can_update_media_metadata(): void
    {
        $file = MediaFile::create([
            'name' => 'Old Title.png',
            'file_name' => 'old_123.png',
            'disk' => 'public',
            'path' => 'general/old_123.png',
            'mime_type' => 'image/png',
            'size' => 2048,
            'folder' => 'general',
        ]);

        $response = $this->actingAs($this->admin)->put(route('admin.media.update', $file->id), [
            'name' => 'New Editorial Graphic.png',
            'alt_text' => 'High-resolution editorial banner',
            'folder' => 'branding',
        ]);

        $response->assertRedirect();
        $file->refresh();
        $this->assertEquals('New Editorial Graphic.png', $file->name);
        $this->assertEquals('High-resolution editorial banner', $file->alt_text);
        $this->assertEquals('branding', $file->folder);
    }

    public function test_admin_can_delete_media_file(): void
    {
        Storage::fake('public');
        Storage::disk('public')->put('general/test_delete.png', 'fake content');

        $file = MediaFile::create([
            'name' => 'Test Delete.png',
            'file_name' => 'test_delete.png',
            'disk' => 'public',
            'path' => 'general/test_delete.png',
            'mime_type' => 'image/png',
            'size' => 1024,
            'folder' => 'general',
        ]);

        $response = $this->actingAs($this->admin)->delete(route('admin.media.destroy', $file->id));

        $response->assertRedirect();
        $this->assertDatabaseMissing('media_files', ['id' => $file->id]);
        Storage::disk('public')->assertMissing('general/test_delete.png');
    }
}
