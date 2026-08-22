<?php

namespace Tests\Feature;

use App\Models\Issue;
use App\Models\Journal;
use App\Models\JournalEditorialMember;
use App\Models\User;
use App\Models\Volume;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class JournalTest extends TestCase
{
    use RefreshDatabase;

    protected User $adminUser;
    protected User $regularUser;
    protected Journal $journal;

    protected function setUp(): void
    {
        parent::setUp();

        $this->seed(RolesAndPermissionsSeeder::class);

        $this->adminUser = User::factory()->create(['username' => 'admin-user']);
        $this->adminUser->assignRole('admin');

        $this->regularUser = User::factory()->create(['username' => 'regular-user']);
        $this->regularUser->assignRole('reader');

        $this->journal = Journal::create([
            'title' => 'International Journal of Quantum Dynamics',
            'short_title' => 'IJQD',
            'slug' => 'international-journal-of-quantum-dynamics',
            'description' => 'A premier publication on quantum computing, condensed matter physics, and informational entropy.',
            'aims_and_scope' => 'Covers theoretical and applied quantum dynamics.',
            'issn_online' => '4001-9982',
            'issn_print' => '4001-9974',
            'publisher' => 'Knowledge Dynamics',
            'publication_frequency' => 'Bi-monthly',
            'established_year' => 2022,
            'status' => 'active',
            'is_open_access' => true,
        ]);

        $this->journal->settings()->create([
            'review_model' => 'double_blind',
            'peer_review_process' => 'Rigorous double-blind peer review.',
            'open_access_policy' => 'Open access under CC-BY 4.0.',
        ]);
    }

    public function test_public_journals_catalog_page_renders(): void
    {
        $response = $this->get(route('journals.index'));

        $response->assertOk();
    }

    public function test_public_journals_catalog_search_filters_results(): void
    {
        $response = $this->get(route('journals.index', ['search' => 'Quantum']));

        $response->assertOk();
    }

    public function test_public_journal_show_page_renders_with_details(): void
    {
        $response = $this->get(route('journals.show', $this->journal->slug));

        $response->assertOk();
    }

    public function test_public_journal_issues_page_renders(): void
    {
        $volume = Volume::create([
            'journal_id' => $this->journal->id,
            'number' => 1,
            'year' => 2022,
        ]);

        Issue::create([
            'volume_id' => $volume->id,
            'number' => '1',
            'title' => 'Inaugural Issue',
            'published_at' => '2022-03-01',
            'is_current' => true,
            'status' => 'published',
        ]);

        $response = $this->get(route('journals.issues', $this->journal->slug));

        $response->assertOk();
    }

    public function test_public_journal_archive_page_renders(): void
    {
        $volume = Volume::create([
            'journal_id' => $this->journal->id,
            'number' => 1,
            'year' => 2022,
        ]);

        Issue::create([
            'volume_id' => $volume->id,
            'number' => '1',
            'title' => 'Archived Issue 1',
            'published_at' => '2022-03-01',
            'status' => 'published',
        ]);

        $response = $this->get(route('journals.archive', $this->journal->slug));

        $response->assertOk();
    }

    public function test_public_journal_editorial_board_page_renders_grouped_members(): void
    {
        JournalEditorialMember::create([
            'journal_id' => $this->journal->id,
            'name' => 'Prof. Dr. Richard Feynman II',
            'role' => 'Editor-in-Chief',
            'institution' => 'Caltech',
            'country' => 'United States',
            'orcid' => '0000-0002-1825-0097',
            'sort_order' => 1,
            'is_active' => true,
        ]);

        $response = $this->get(route('journals.editorial_board', $this->journal->slug));

        $response->assertOk();
    }

    public function test_non_admin_cannot_access_admin_journals_management(): void
    {
        // Guest
        $guestResponse = $this->get(route('admin.journals.index'));
        $guestResponse->assertRedirect(route('login'));

        // Regular user without admin role
        $userResponse = $this->actingAs($this->regularUser)->get(route('admin.journals.index'));
        $userResponse->assertForbidden();
    }

    public function test_admin_can_view_and_create_journal(): void
    {
        $indexResponse = $this->actingAs($this->adminUser)->get(route('admin.journals.index'));
        $indexResponse->assertOk();

        $createResponse = $this->actingAs($this->adminUser)->get(route('admin.journals.create'));
        $createResponse->assertOk();

        $storeResponse = $this->actingAs($this->adminUser)->post(route('admin.journals.store'), [
            'title' => 'Journal of AI & Knowledge Discovery',
            'short_title' => 'JAKD',
            'slug' => 'journal-of-ai-knowledge-discovery',
            'description' => 'Leading international journal in artificial intelligence.',
            'aims_and_scope' => 'Explores neural networks, NLP, and agentic workflows.',
            'issn_online' => '5002-1144',
            'issn_print' => '5002-1145',
            'publication_frequency' => 'Quarterly',
            'status' => 'active',
            'is_open_access' => true,
            'established_year' => 2023,
            'settings' => [
                'review_model' => 'double_blind',
                'peer_review_process' => 'Standard double blind review process.',
            ],
        ]);

        $storeResponse->assertSessionHasNoErrors();
        $this->assertDatabaseHas('journals', [
            'slug' => 'journal-of-ai-knowledge-discovery',
            'short_title' => 'JAKD',
        ]);
        $this->assertDatabaseHas('journal_settings', [
            'review_model' => 'double_blind',
        ]);
    }

    public function test_admin_can_update_and_delete_journal(): void
    {
        $updateResponse = $this->actingAs($this->adminUser)->put(route('admin.journals.update', $this->journal->id), [
            'title' => 'Updated International Journal of Quantum Dynamics',
            'short_title' => 'UIJQD',
            'slug' => $this->journal->slug,
            'status' => 'active',
            'is_open_access' => true,
            'settings' => [
                'review_model' => 'open_review',
                'peer_review_process' => 'Open peer review with public reviewer commentary.',
            ],
        ]);

        $updateResponse->assertSessionHasNoErrors();
        $this->journal->refresh()->load('settings');
        $this->assertSame('Updated International Journal of Quantum Dynamics', $this->journal->title);
        $this->assertSame('open_review', $this->journal->settings->review_model);

        // Delete
        $deleteResponse = $this->actingAs($this->adminUser)->delete(route('admin.journals.destroy', $this->journal->id));
        $deleteResponse->assertRedirect(route('admin.journals.index'));
        $this->assertSoftDeleted($this->journal);
    }

    public function test_admin_can_manage_volumes_and_issues(): void
    {
        // View Volume/Issue manager
        $response = $this->actingAs($this->adminUser)->get(route('admin.journals.volumes.index', $this->journal->id));
        $response->assertOk();

        // Create Volume
        $volResponse = $this->actingAs($this->adminUser)->post(route('admin.journals.volumes.store', $this->journal->id), [
            'number' => 1,
            'year' => 2024,
            'title' => 'Volume 1 (2024)',
        ]);
        $volResponse->assertSessionHasNoErrors();
        $volume = Volume::where('journal_id', $this->journal->id)->first();
        $this->assertNotNull($volume);

        // Create Issue
        $issueResponse = $this->actingAs($this->adminUser)->post(route('admin.volumes.issues.store', $volume->id), [
            'number' => '1',
            'title' => 'Issue 1: Foundation and Advances',
            'published_at' => '2024-04-15',
            'is_current' => true,
            'status' => 'published',
            'sort_order' => 1,
        ]);
        $issueResponse->assertSessionHasNoErrors();
        $issue = Issue::where('volume_id', $volume->id)->first();
        $this->assertNotNull($issue);
        $this->assertTrue($issue->is_current);

        // Set Current Issue
        $issue2Response = $this->actingAs($this->adminUser)->post(route('admin.volumes.issues.store', $volume->id), [
            'number' => '2',
            'title' => 'Issue 2: Emerging Trends',
            'status' => 'published',
        ]);
        $issue2 = Issue::where('volume_id', $volume->id)->where('number', '2')->first();
        $this->actingAs($this->adminUser)->post(route('admin.issues.set_current', $issue2->id));

        $this->assertFalse($issue->fresh()->is_current);
        $this->assertTrue($issue2->fresh()->is_current);
    }

    public function test_admin_can_manage_editorial_board(): void
    {
        // View Editorial Board manager
        $response = $this->actingAs($this->adminUser)->get(route('admin.journals.editorial_board.index', $this->journal->id));
        $response->assertOk();

        // Add Member
        $addResponse = $this->actingAs($this->adminUser)->post(route('admin.journals.editorial_board.store', $this->journal->id), [
            'name' => 'Prof. Alan Turing',
            'role' => 'Editor-in-Chief',
            'institution' => 'University of Manchester',
            'country' => 'United Kingdom',
            'orcid' => '0000-0002-1825-0097',
            'email' => 'turing@manchester.ac.uk',
            'is_active' => true,
        ]);
        $addResponse->assertSessionHasNoErrors();

        $member = JournalEditorialMember::where('journal_id', $this->journal->id)->first();
        $this->assertNotNull($member);
        $this->assertSame('Prof. Alan Turing', $member->name);

        // Update Member
        $updateResponse = $this->actingAs($this->adminUser)->put(route('admin.editorial_members.update', $member->id), [
            'name' => 'Prof. Alan M. Turing, FRS',
            'role' => 'Editor-in-Chief',
            'institution' => 'Cambridge & Manchester',
            'country' => 'United Kingdom',
            'is_active' => true,
        ]);
        $updateResponse->assertSessionHasNoErrors();
        $this->assertSame('Prof. Alan M. Turing, FRS', $member->fresh()->name);

        // Remove Member
        $deleteResponse = $this->actingAs($this->adminUser)->delete(route('admin.editorial_members.destroy', $member->id));
        $deleteResponse->assertSessionHasNoErrors();
        $this->assertNull(JournalEditorialMember::find($member->id));
    }
}
