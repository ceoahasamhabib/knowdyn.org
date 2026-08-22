<?php

namespace Tests\Feature;

use App\Models\EmailAccountRequest;
use App\Models\SiteSetting;
use App\Models\User;
use App\Models\WebmailMessage;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class CpanelEmailAndWebmailTest extends TestCase
{
    use RefreshDatabase;

    protected User $admin;
    protected User $user;

    protected function setUp(): void
    {
        parent::setUp();

        $this->seed(RolesAndPermissionsSeeder::class);

        $this->admin = User::factory()->create(['email' => 'admin@kdpub.com']);
        $this->admin->assignRole('super-admin');

        $this->user = User::factory()->create(['email' => 'scholar@univ.edu', 'name' => 'Dr. Scholar']);
    }

    public function test_user_can_apply_for_academic_email(): void
    {
        SiteSetting::set('cpanel_default_domain', 'kdpub.com');

        $response = $this->actingAs($this->user)->post(route('webmail.apply'), [
            'requested_username' => 'dr.scholar',
        ]);

        $response->assertRedirect();
        $this->assertDatabaseHas('email_account_requests', [
            'user_id' => $this->user->id,
            'requested_username' => 'dr.scholar',
            'full_email' => 'dr.scholar@kdpub.com',
            'status' => 'pending',
        ]);
    }

    public function test_admin_can_update_cpanel_api_settings(): void
    {
        $response = $this->actingAs($this->admin)->post(route('admin.cpanel.settings'), [
            'cpanel_host' => 'cpanel.kdpub.com',
            'cpanel_username' => 'knowdyn',
            'cpanel_api_token' => 'EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q',
            'cpanel_default_domain' => 'kdpub.com',
            'cpanel_port' => 2083,
        ]);

        $response->assertRedirect();
        $this->assertEquals('EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q', SiteSetting::get('cpanel_api_token'));
    }

    public function test_admin_can_test_cpanel_api_connection(): void
    {
        $response = $this->actingAs($this->admin)->post(route('admin.cpanel.test_connection'));
        $response->assertRedirect();
    }

    public function test_admin_can_approve_email_request(): void
    {
        $mockCpanel = \Mockery::mock(\App\Services\CpanelApiService::class);
        $mockCpanel->shouldReceive('createEmailAccount')->andReturn(['success' => true, 'message' => 'Created']);
        $this->app->instance(\App\Services\CpanelApiService::class, $mockCpanel);

        $request = EmailAccountRequest::create([
            'user_id' => $this->user->id,
            'requested_username' => 'dr.scholar',
            'domain' => 'kdpub.com',
            'full_email' => 'dr.scholar@kdpub.com',
            'quota_mb' => 500,
            'status' => 'pending',
        ]);

        $response = $this->actingAs($this->admin)->post(route('admin.cpanel.approve', $request->id), [
            'quota_mb' => 1000,
            'admin_notes' => 'Approved for senior researcher.',
        ]);

        $response->assertRedirect();
        $this->assertDatabaseHas('email_account_requests', [
            'id' => $request->id,
            'status' => 'active',
            'quota_mb' => 1000,
        ]);

        // Welcome message created in user inbox
        $this->assertDatabaseHas('webmail_messages', [
            'user_id' => $this->user->id,
            'folder' => 'inbox',
            'to_email' => 'dr.scholar@kdpub.com',
        ]);
    }

    public function test_admin_can_reject_email_request(): void
    {
        $request = EmailAccountRequest::create([
            'user_id' => $this->user->id,
            'requested_username' => 'dr.fake',
            'domain' => 'kdpub.com',
            'full_email' => 'dr.fake@kdpub.com',
            'status' => 'pending',
        ]);

        $response = $this->actingAs($this->admin)->post(route('admin.cpanel.reject', $request->id), [
            'rejection_reason' => 'Invalid credentials.',
        ]);

        $response->assertRedirect();
        $this->assertDatabaseHas('email_account_requests', [
            'id' => $request->id,
            'status' => 'rejected',
            'rejection_reason' => 'Invalid credentials.',
        ]);
    }

    public function test_active_user_can_view_inbox_and_send_messages(): void
    {
        $account = EmailAccountRequest::create([
            'user_id' => $this->user->id,
            'requested_username' => 'dr.scholar',
            'domain' => 'kdpub.com',
            'full_email' => 'dr.scholar@kdpub.com',
            'quota_mb' => 500,
            'status' => 'active',
        ]);

        $inboxMsg = WebmailMessage::create([
            'user_id' => $this->user->id,
            'email_account_request_id' => $account->id,
            'folder' => 'inbox',
            'from_name' => 'Editor in Chief',
            'from_email' => 'editor@kdpub.com',
            'to_email' => 'dr.scholar@kdpub.com',
            'subject' => 'Manuscript Review Request',
            'body_text' => 'Please review this paper.',
            'is_read' => false,
            'sent_at' => now(),
        ]);

        // View webmail inbox
        $response = $this->actingAs($this->user)->get(route('webmail.index'));
        $response->assertOk();

        // Star message
        $starResponse = $this->actingAs($this->user)->post(route('webmail.star', $inboxMsg->id));
        $starResponse->assertRedirect();
        $this->assertTrue($inboxMsg->fresh()->is_starred);

        // Send a message
        $sendResponse = $this->actingAs($this->user)->post(route('webmail.send'), [
            'to_email' => 'editor@kdpub.com',
            'subject' => 'Accepted Review Assignment',
            'body' => 'I would be happy to review this manuscript.',
        ]);
        $sendResponse->assertRedirect();

        $this->assertDatabaseHas('webmail_messages', [
            'user_id' => $this->user->id,
            'folder' => 'sent',
            'subject' => 'Accepted Review Assignment',
        ]);

        // Delete message
        $deleteResponse = $this->actingAs($this->user)->delete(route('webmail.delete', $inboxMsg->id));
        $deleteResponse->assertRedirect();
        $this->assertEquals('trash', $inboxMsg->fresh()->folder);

        // 1-Click cPanel SSO
        $ssoResponse = $this->actingAs($this->user)->get(route('webmail.cpanel_sso'));
        $ssoResponse->assertRedirect();
    }
}
