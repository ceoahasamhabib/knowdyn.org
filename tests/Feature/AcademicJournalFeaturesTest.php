<?php

namespace Tests\Feature;

use App\Models\Journal;
use App\Models\User;
use Database\Seeders\RolesAndPermissionsSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AcademicJournalFeaturesTest extends TestCase
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

    public function test_public_journal_index_displays_academic_journals_and_website_urls(): void
    {
        $journal = Journal::create([
            'title' => 'Test Health Journal',
            'slug' => 'test-health-journal',
            'issn_online' => '3006-5518',
            'status' => 'active',
            'website_url' => 'https://healthdynamics.org',
            'citescore' => '3.8',
            'impact_factor' => '2.9',
            'acceptance_rate' => 28,
            'review_time_days' => 18,
            'disciplines' => ['Clinical Medicine', 'Public Health'],
            'indexing_sources' => ['Crossref (DOI Minting)', 'DOAJ (Open Access)'],
        ]);

        $response = $this->get(route('journals.index'));

        $response->assertOk();
        $response->assertInertia(fn ($page) => $page
            ->component('Public/Journals/Index')
            ->has('journals.data', 1)
            ->where('journals.data.0.effective_website_url', 'https://healthdynamics.org')
            ->where('journals.data.0.citescore', '3.8')
            ->where('journals.data.0.acceptance_rate', 28)
        );
    }

    public function test_public_journal_show_displays_hero_website_button_and_indexing_badges(): void
    {
        $journal = Journal::create([
            'title' => 'Global Biomedical Engineering',
            'slug' => 'global-biomedical-engineering',
            'issn_online' => '3007-1234',
            'status' => 'active',
            'website_url' => 'https://biomed.kdpub.com',
            'citescore' => '4.2',
            'impact_factor' => '3.1',
            'special_issue_title' => 'Special Issue on Neural Interfaces',
            'special_issue_deadline' => '2026-12-31',
            'disciplines' => ['Bioengineering', 'Neural Systems'],
            'indexing_sources' => ['Crossref (DOI Minting)', 'PubMed Central Ready'],
        ]);

        $response = $this->get(route('journals.show', $journal->slug));

        $response->assertOk();
        $response->assertInertia(fn ($page) => $page
            ->component('Public/Journals/Show')
            ->where('journal.title', 'Global Biomedical Engineering')
            ->where('journal.effective_website_url', 'https://biomed.kdpub.com')
            ->where('journal.special_issue_title', 'Special Issue on Neural Interfaces')
        );
    }

    public function test_admin_can_toggle_journal_publication_status(): void
    {
        $journal = Journal::create([
            'title' => 'Draft Journal',
            'slug' => 'draft-journal',
            'status' => 'inactive',
        ]);

        // Toggle from inactive to active
        $response = $this->actingAs($this->admin)
            ->post(route('admin.journals.toggle_status', $journal->id));

        $response->assertRedirect();
        $journal->refresh();
        $this->assertEquals('active', $journal->status);

        // Toggle from active back to inactive
        $response = $this->actingAs($this->admin)
            ->post(route('admin.journals.toggle_status', $journal->id));

        $response->assertRedirect();
        $journal->refresh();
        $this->assertEquals('inactive', $journal->status);
    }

    public function test_admin_can_create_journal_with_academic_metrics_and_website_url(): void
    {
        $payload = [
            'title' => 'International Journal of AI in Medicine',
            'short_title' => 'Int. J. AI Med.',
            'slug' => 'int-j-ai-med',
            'description' => 'Publishing artificial intelligence research in diagnostics and clinical workflows.',
            'aims_and_scope' => 'Covers neural networks, radiological AI, and predictive healthcare models.',
            'issn_online' => '3008-9999',
            'publication_frequency' => 'Quarterly',
            'established_year' => 2024,
            'status' => 'active',
            'website_url' => 'https://ai-med.kdpub.com',
            'submission_url' => '/submit?journal=int-j-ai-med',
            'citescore' => '4.5',
            'impact_factor' => '3.6',
            'acceptance_rate' => 22,
            'review_time_days' => 14,
            'publication_time_days' => 5,
            'apc_amount' => '$500 USD',
            'disciplines' => ['Artificial Intelligence', 'Medical Informatics'],
            'indexing_sources' => ['Crossref (DOI Minting)', 'Google Scholar', 'DOAJ (Open Access)'],
            'special_issue_title' => 'Special Issue: Large Language Models in Clinical Practice',
            'special_issue_deadline' => '2026-11-30',
            'special_issue_description' => 'Focusing on clinical LLMs, HIPAA safety, and patient diagnostics.',
        ];

        $response = $this->actingAs($this->admin)
            ->post(route('admin.journals.store'), $payload);

        $response->assertRedirect();
        $this->assertDatabaseHas('journals', [
            'slug' => 'int-j-ai-med',
            'website_url' => 'https://ai-med.kdpub.com',
            'citescore' => '4.5',
            'acceptance_rate' => 22,
        ]);
    }
}
