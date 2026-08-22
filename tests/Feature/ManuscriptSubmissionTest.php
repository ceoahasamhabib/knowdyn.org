<?php

namespace Tests\Feature;

use App\Models\Journal;
use App\Models\Manuscript;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class ManuscriptSubmissionTest extends TestCase
{
    use RefreshDatabase;

    protected User $author;
    protected User $otherUser;
    protected Journal $journal;

    protected function setUp(): void
    {
        parent::setUp();

        $this->author = User::factory()->create([
            'email' => 'author@knowdyn.org',
            'name' => 'Dr. Alexander Wright',
        ]);

        $this->otherUser = User::factory()->create([
            'email' => 'other@knowdyn.org',
            'name' => 'Dr. Jane Doe',
        ]);

        $this->journal = Journal::create([
            'title' => 'Health Dynamics',
            'slug' => 'health-dynamics',
            'short_title' => 'Health Dyn',
            'issn_online' => '3006-5518',
            'publisher' => 'Knowledge Dynamics',
            'status' => 'active',
        ]);
    }

    public function test_submit_wizard_page_renders_successfully(): void
    {
        $response = $this->get(route('manuscripts.create'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Author/Submit')
                ->has('journals')
            );
    }

    public function test_guest_cannot_submit_manuscript_without_login(): void
    {
        $payload = [
            'journal_id' => $this->journal->id,
            'title' => 'Novel AI Diagnostics in Healthcare',
            'abstract' => 'This is a test abstract.',
            'article_type' => 'original-research',
            'authors' => [
                ['first_name' => 'Alex', 'last_name' => 'Wright', 'email' => 'alex@test.com'],
            ],
        ];

        $response = $this->post(route('manuscripts.store'), $payload);
        $response->assertRedirect(route('login'));
        $this->assertDatabaseMissing('manuscripts', ['title' => 'Novel AI Diagnostics in Healthcare']);
    }

    public function test_authenticated_author_can_submit_manuscript_with_authors_and_files(): void
    {
        Storage::fake('local');

        $fakeFile = UploadedFile::fake()->create('manuscript.pdf', 1024, 'application/pdf');

        $payload = [
            'journal_id' => $this->journal->id,
            'title' => 'Longitudinal Analysis of Healthcare Policy Outcomes',
            'abstract' => 'A comprehensive review of decentralized hospital systems across regional clinics.',
            'article_type' => 'original-research',
            'cover_letter' => 'Dear Editor, We are pleased to submit this manuscript.',
            'funding' => 'Supported by the Global Health Research Foundation.',
            'conflict_of_interest' => 'None.',
            'ethics_statement' => 'IRB Protocol #2026-991.',
            'authors' => [
                [
                    'first_name' => 'Alexander',
                    'last_name' => 'Wright',
                    'email' => 'author@knowdyn.org',
                    'affiliation' => 'Imperial College London',
                    'country' => 'United Kingdom',
                    'orcid' => '0000-0002-1825-0097',
                    'is_corresponding' => true,
                    'sort_order' => 1,
                ],
                [
                    'first_name' => 'Maria',
                    'last_name' => 'Santos',
                    'email' => 'msantos@usp.br',
                    'affiliation' => 'University of Sao Paulo',
                    'country' => 'Brazil',
                    'orcid' => '0000-0003-9182-7364',
                    'is_corresponding' => false,
                    'sort_order' => 2,
                ],
            ],
            'manuscript_file' => $fakeFile,
        ];

        $response = $this->actingAs($this->author)->post(route('manuscripts.store'), $payload);

        $this->assertDatabaseHas('manuscripts', [
            'title' => 'Longitudinal Analysis of Healthcare Policy Outcomes',
            'journal_id' => $this->journal->id,
            'user_id' => $this->author->id,
            'status' => 'submitted',
        ]);

        $manuscript = Manuscript::where('title', 'Longitudinal Analysis of Healthcare Policy Outcomes')->first();
        $response->assertRedirect(route('author.submissions.show', $manuscript->id));

        // Authors verification
        $this->assertCount(2, $manuscript->authors);
        $this->assertEquals('Alexander', $manuscript->authors->first()->first_name);

        // Status history verification
        $this->assertDatabaseHas('manuscript_status_history', [
            'manuscript_id' => $manuscript->id,
            'to_status' => 'submitted',
        ]);

        // File upload verification
        $this->assertCount(1, $manuscript->files);
        $this->assertEquals('manuscript.pdf', $manuscript->files->first()->file_name);
        Storage::disk('local')->assertExists($manuscript->files->first()->file_path);
    }

    public function test_author_can_view_submissions_list(): void
    {
        Manuscript::create([
            'journal_id' => $this->journal->id,
            'user_id' => $this->author->id,
            'title' => 'Author Research Paper A',
            'abstract' => 'Abstract A',
            'article_type' => 'original-research',
            'status' => 'submitted',
            'submitted_at' => now(),
        ]);

        $response = $this->actingAs($this->author)->get(route('author.submissions.index'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Author/Submissions/Index')
                ->has('submissions.data', 1)
                ->where('submissions.data.0.title', 'Author Research Paper A')
            );
    }

    public function test_author_can_view_detailed_submission_tracker(): void
    {
        $manuscript = Manuscript::create([
            'journal_id' => $this->journal->id,
            'user_id' => $this->author->id,
            'title' => 'Tracked Manuscript Paper B',
            'abstract' => 'Abstract B',
            'article_type' => 'original-research',
            'status' => 'screening',
            'submitted_at' => now(),
        ]);

        $response = $this->actingAs($this->author)->get(route('author.submissions.show', $manuscript->id));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Author/Submissions/Show')
                ->has('manuscript')
                ->where('manuscript.id', $manuscript->id)
                ->where('manuscript.status', 'screening')
            );
    }

    public function test_other_users_cannot_access_confidential_submission(): void
    {
        $manuscript = Manuscript::create([
            'journal_id' => $this->journal->id,
            'user_id' => $this->author->id,
            'title' => 'Confidential Author Submission',
            'abstract' => 'Confidential Abstract',
            'article_type' => 'original-research',
            'status' => 'submitted',
            'submitted_at' => now(),
        ]);

        $response = $this->actingAs($this->otherUser)->get(route('author.submissions.show', $manuscript->id));
        $response->assertStatus(404); // Scoped to user_id in service
    }
}
