<?php

namespace Tests\Feature;

use App\Models\Service;
use App\Models\ServiceRequest;
use App\Models\User;
use Database\Seeders\ServiceSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class PublishingServiceTest extends TestCase
{
    use RefreshDatabase;

    protected User $adminUser;
    protected Service $service;

    protected function setUp(): void
    {
        parent::setUp();

        $adminRole = Role::firstOrCreate(['name' => 'Admin']);
        $this->adminUser = User::factory()->create([
            'email' => 'admin@knowdyn.org',
            'email_verified_at' => now(),
        ]);
        $this->adminUser->assignRole('Admin');

        $this->seed(ServiceSeeder::class);
        $this->service = Service::where('slug', 'kd-proofreading')->firstOrFail();
    }

    public function test_services_catalog_page_renders_successfully(): void
    {
        $response = $this->get(route('services'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/Services')
                ->has('services', 9)
            );
    }

    public function test_dedicated_proofreading_portal_renders_successfully(): void
    {
        $response = $this->get(route('proofreading.index'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/Proofreading')
                ->has('service')
                ->where('service.slug', 'kd-proofreading')
            );
    }

    public function test_service_detail_page_renders_successfully(): void
    {
        $response = $this->get(route('services.show', 'academic-formatting'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/ServiceShow')
                ->has('service')
                ->where('service.slug', 'academic-formatting')
            );
    }

    public function test_client_can_submit_service_inquiry(): void
    {
        $payload = [
            'service_id' => $this->service->id,
            'name' => 'Dr. Jessica Taylor',
            'email' => 'jtaylor@stanford.edu',
            'phone' => '+1 (555) 234-5678',
            'message' => '5,000 words manuscript requiring urgent 48-hour editing.',
        ];

        $response = $this->post(route('services.request.store'), $payload);

        $response->assertRedirect();
        $this->assertDatabaseHas('service_requests', [
            'service_id' => $this->service->id,
            'name' => 'Dr. Jessica Taylor',
            'email' => 'jtaylor@stanford.edu',
            'status' => 'submitted',
        ]);
    }

    public function test_admin_can_view_and_update_service_requests(): void
    {
        $request = ServiceRequest::create([
            'service_id' => $this->service->id,
            'name' => 'Dr. Jessica Taylor',
            'email' => 'jtaylor@stanford.edu',
            'message' => 'Test message',
            'status' => 'submitted',
        ]);

        $response = $this->actingAs($this->adminUser)->get(route('admin.services.index'));
        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Admin/Services/Index'));

        $updateResponse = $this->actingAs($this->adminUser)->post(
            route('admin.services.update_status', $request->id),
            [
                'status' => 'in_progress',
                'assigned_to' => $this->adminUser->id,
            ]
        );

        $updateResponse->assertRedirect();
        $this->assertEquals('in_progress', $request->fresh()->status);
        $this->assertEquals($this->adminUser->id, $request->fresh()->assigned_to);
    }
}
