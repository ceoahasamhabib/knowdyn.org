<?php

namespace Tests\Feature;

use App\Models\Book;
use App\Models\BookProposal;
use App\Models\Career;
use App\Models\GuidelinePage;
use App\Models\NewsEvent;
use App\Models\SiteSetting;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AdminManagementSuiteTest extends TestCase
{
    use RefreshDatabase;

    protected User $admin;

    protected function setUp(): void
    {
        parent::setUp();

        $this->seed(RolesAndPermissionsSeeder::class);

        $this->admin = User::factory()->create([
            'email' => 'admin@knowdyn.org',
        ]);
        $this->admin->assignRole('super-admin');
    }

    public function test_admin_can_view_and_manage_books(): void
    {
        $book = Book::create([
            'title' => 'Test Monograph',
            'slug' => 'test-monograph',
            'author' => 'Dr. Researcher',
            'isbn' => '978-0-123-4567-8',
            'year' => 2025,
            'pages' => 350,
            'category' => 'Medicine & Health',
            'format' => 'Print & eBook',
            'description' => 'Test description',
            'is_open_access' => true,
        ]);

        $response = $this->actingAs($this->admin)->get(route('admin.books.index'));
        $response->assertOk();

        // Create new book
        $postResponse = $this->actingAs($this->admin)->post(route('admin.books.store'), [
            'title' => 'Another Monograph',
            'author' => 'Prof. Author',
            'year' => 2026,
            'pages' => 200,
            'category' => 'Asian Studies & History',
            'format' => 'eBook Only',
            'is_open_access' => true,
            'sort_order' => 1,
        ]);
        $postResponse->assertRedirect(route('admin.books.index'));
        $this->assertDatabaseHas('books', ['title' => 'Another Monograph']);

        // Update book
        $putResponse = $this->actingAs($this->admin)->put(route('admin.books.update', $book), [
            'title' => 'Updated Monograph Title',
            'author' => 'Dr. Researcher',
            'year' => 2025,
            'pages' => 360,
            'category' => 'Medicine & Health',
            'format' => 'Print & eBook',
            'is_open_access' => true,
            'sort_order' => 0,
        ]);
        $putResponse->assertRedirect(route('admin.books.index'));
        $this->assertDatabaseHas('books', ['title' => 'Updated Monograph Title']);

        // Delete book
        $deleteResponse = $this->actingAs($this->admin)->delete(route('admin.books.destroy', $book));
        $deleteResponse->assertRedirect();
        $this->assertDatabaseMissing('books', ['id' => $book->id]);
    }

    public function test_admin_can_review_and_update_book_proposals(): void
    {
        $proposal = BookProposal::create([
            'author_name' => 'Dr. Author',
            'author_email' => 'author@univ.edu',
            'institution' => 'University of Science',
            'book_title' => 'Proposed New Book',
            'subject_discipline' => 'Biomedical Science',
            'synopsis_and_toc' => 'Chapter 1: Intro...',
            'status' => 'pending',
        ]);

        $response = $this->actingAs($this->admin)->get(route('admin.books.proposals'));
        $response->assertOk();

        // Approve proposal
        $postResponse = $this->actingAs($this->admin)->post(route('admin.books.proposals.update_status', $proposal->id), [
            'status' => 'accepted',
            'notes' => 'Proposal accepted for publication pipeline.',
        ]);
        $postResponse->assertRedirect();
        $this->assertDatabaseHas('book_proposals', ['id' => $proposal->id, 'status' => 'accepted']);
    }

    public function test_admin_can_manage_news_and_events(): void
    {
        $item = NewsEvent::create([
            'title' => 'Call for Papers Test',
            'slug' => 'call-for-papers-test',
            'type' => 'announcement',
            'category' => 'CFP',
            'summary' => 'Test summary',
            'is_published' => true,
        ]);

        $response = $this->actingAs($this->admin)->get(route('admin.news_events.index'));
        $response->assertOk();

        // Update
        $putResponse = $this->actingAs($this->admin)->put(route('admin.news_events.update', $item), [
            'title' => 'Call for Papers Updated',
            'type' => 'announcement',
            'category' => 'CFP',
            'summary' => 'Updated summary',
            'is_published' => true,
            'is_featured' => true,
        ]);
        $putResponse->assertRedirect(route('admin.news_events.index'));
        $this->assertDatabaseHas('news_events', ['title' => 'Call for Papers Updated']);

        // Delete
        $this->actingAs($this->admin)->delete(route('admin.news_events.destroy', $item));
        $this->assertDatabaseMissing('news_events', ['id' => $item->id]);
    }

    public function test_admin_can_manage_careers(): void
    {
        $career = Career::create([
            'title' => 'Section Editor Position',
            'slug' => 'section-editor-position',
            'department' => 'Health Dynamics',
            'type' => 'Academic Editorial Role',
            'summary' => 'Test summary',
            'is_active' => true,
        ]);

        $response = $this->actingAs($this->admin)->get(route('admin.careers.index'));
        $response->assertOk();

        // Update
        $this->actingAs($this->admin)->put(route('admin.careers.update', $career), [
            'title' => 'Section Editor Position Updated',
            'department' => 'Health Dynamics',
            'type' => 'Academic Editorial Role',
            'summary' => 'Updated summary',
            'is_active' => false,
        ]);
        $this->assertDatabaseHas('careers', ['title' => 'Section Editor Position Updated', 'is_active' => false]);
    }

    public function test_admin_can_manage_guidelines_and_policies(): void
    {
        $page = GuidelinePage::create([
            'key' => 'authors',
            'title' => 'Author Instructions',
            'content' => 'Submit according to Vancouver style.',
        ]);

        $response = $this->actingAs($this->admin)->get(route('admin.guidelines.index'));
        $response->assertOk();

        // Update
        $this->actingAs($this->admin)->put(route('admin.guidelines.update', $page->id), [
            'title' => 'Author Instructions Revised',
            'content' => 'Revised content for 2026.',
        ]);
        $this->assertDatabaseHas('guidelines_pages', ['title' => 'Author Instructions Revised']);
    }

    public function test_admin_can_manage_users_and_roles(): void
    {
        $user = User::factory()->create(['name' => 'Scholar User', 'email' => 'scholar@univ.edu']);

        $response = $this->actingAs($this->admin)->get(route('admin.users.index'));
        $response->assertOk();

        // Update roles
        $this->actingAs($this->admin)->put(route('admin.users.update', $user->id), [
            'name' => 'Scholar User Updated',
            'email' => 'scholar@univ.edu',
            'roles' => ['reviewer'],
        ]);

        $user->refresh();
        $this->assertTrue($user->hasRole('reviewer'));
    }

    public function test_admin_can_update_system_and_doi_settings(): void
    {
        SiteSetting::create(['key' => 'doi_prefix', 'value' => '10.58421', 'group' => 'doi']);

        $response = $this->actingAs($this->admin)->get(route('admin.settings.index'));
        $response->assertOk();

        // Update setting
        $postResponse = $this->actingAs($this->admin)->post(route('admin.settings.update'), [
            'settings' => [
                'doi_prefix' => '10.58421.prod',
            ],
        ]);
        $postResponse->assertRedirect();
        $this->assertDatabaseHas('site_settings', ['key' => 'doi_prefix', 'value' => '10.58421.prod']);
    }
}
