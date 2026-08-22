<?php

namespace Tests\Feature;

use App\Models\AppNotification;
use App\Models\EmailAccountRequest;
use App\Models\Journal;
use App\Models\Manuscript;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class NotificationSystemTest extends TestCase
{
    use RefreshDatabase;

    protected User $admin;
    protected User $author;

    protected function setUp(): void
    {
        parent::setUp();

        Role::firstOrCreate(['name' => 'super-admin']);
        Role::firstOrCreate(['name' => 'admin']);
        Role::firstOrCreate(['name' => 'editor']);
        Role::firstOrCreate(['name' => 'reviewer']);
        Role::firstOrCreate(['name' => 'author']);

        $this->admin = User::factory()->create([
            'name' => 'Managing Editor',
            'email' => 'admin@knowdyn.org',
        ]);
        $this->admin->assignRole('super-admin');

        $this->author = User::factory()->create([
            'name' => 'Prof. Rahim',
            'email' => 'rahim@university.edu',
        ]);
        $this->author->assignRole('author');
    }

    public function test_can_send_and_retrieve_notifications(): void
    {
        $notification = AppNotification::send(
            $this->author->id,
            'Welcome to Knowledge Dynamics',
            'Your author workspace is active.',
            '/dashboard',
            'system',
            '🎉'
        );

        $this->assertDatabaseHas('app_notifications', [
            'id' => $notification->id,
            'user_id' => $this->author->id,
            'title' => 'Welcome to Knowledge Dynamics',
            'is_read' => false,
        ]);

        $response = $this->actingAs($this->author)->get(route('dashboard'));
        $response->assertOk();
        $response->assertInertia(fn ($page) => $page
            ->has('notifications')
            ->where('notifications.unread_count', 1)
        );
    }

    public function test_can_mark_single_notification_as_read(): void
    {
        $notification = AppNotification::send(
            $this->author->id,
            'Paper Status Update',
            'Your manuscript has passed initial screening.',
            '/dashboard/submissions/1',
            'manuscript',
            '📝'
        );

        $response = $this->actingAs($this->author)->post(route('notifications.read', $notification->id));
        $response->assertRedirect();

        $this->assertTrue($notification->fresh()->is_read);
        $this->assertNotNull($notification->fresh()->read_at);
    }

    public function test_can_mark_all_notifications_as_read(): void
    {
        AppNotification::send($this->author->id, 'Alert 1', 'Message 1');
        AppNotification::send($this->author->id, 'Alert 2', 'Message 2');
        AppNotification::send($this->author->id, 'Alert 3', 'Message 3');

        $this->assertEquals(3, AppNotification::where('user_id', $this->author->id)->where('is_read', false)->count());

        $response = $this->actingAs($this->author)->post(route('notifications.mark_all_read'));
        $response->assertRedirect();

        $this->assertEquals(0, AppNotification::where('user_id', $this->author->id)->where('is_read', false)->count());
    }

    public function test_notify_admins_delivers_to_all_admin_roles(): void
    {
        $editor = User::factory()->create(['email' => 'editor@knowdyn.org']);
        $editor->assignRole('editor');

        AppNotification::notifyAdmins(
            'New Monograph Proposal',
            'Dr. Smith proposed a new oncology book.',
            '/admin/books/proposals',
            'book',
            '📚'
        );

        $this->assertDatabaseHas('app_notifications', [
            'user_id' => $this->admin->id,
            'title' => 'New Monograph Proposal',
        ]);

        $this->assertDatabaseHas('app_notifications', [
            'user_id' => $editor->id,
            'title' => 'New Monograph Proposal',
        ]);
    }
}
