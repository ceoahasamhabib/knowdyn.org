<?php

namespace Tests\Feature;

use App\Models\Journal;
use App\Models\Manuscript;
use App\Models\Review;
use App\Models\ReviewAssignment;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class EditorialAndReviewTest extends TestCase
{
    use RefreshDatabase;

    protected User $adminUser;
    protected User $author;
    protected User $editor;
    protected User $reviewer;
    protected Journal $journal;
    protected Manuscript $manuscript;

    protected function setUp(): void
    {
        parent::setUp();

        $adminRole = Role::firstOrCreate(['name' => 'Admin']);
        $editorRole = Role::firstOrCreate(['name' => 'Editor']);
        $reviewerRole = Role::firstOrCreate(['name' => 'Reviewer']);

        $this->adminUser = User::factory()->create([
            'email' => 'admin@knowdyn.org',
            'email_verified_at' => now(),
        ]);
        $this->adminUser->assignRole('Admin');

        $this->editor = User::factory()->create([
            'email' => 'editor@knowdyn.org',
            'email_verified_at' => now(),
            'name' => 'Prof. Marcus Vance',
        ]);
        $this->editor->assignRole('Admin');

        $this->author = User::factory()->create([
            'email' => 'author@oxford.ac.uk',
            'name' => 'Dr. Robert Chen',
        ]);

        $this->reviewer = User::factory()->create([
            'email' => 'reviewer@cambridge.ac.uk',
            'name' => 'Dr. Eleanor Rostova',
        ]);

        $this->journal = Journal::create([
            'title' => 'Health Dynamics',
            'slug' => 'health-dynamics',
            'short_title' => 'Health Dyn',
            'issn_online' => '3006-5518',
            'publisher' => 'Knowledge Dynamics',
            'status' => 'active',
        ]);

        $this->manuscript = Manuscript::create([
            'journal_id' => $this->journal->id,
            'user_id' => $this->author->id,
            'title' => 'Epidemiological Assessment of Novel Health Interventions',
            'abstract' => 'Comprehensive evaluation of community health outcomes.',
            'article_type' => 'original-research',
            'status' => 'submitted',
            'submitted_at' => now(),
        ]);
    }

    public function test_admin_can_view_manuscripts_queue(): void
    {
        $response = $this->actingAs($this->adminUser)->get(route('admin.manuscripts.index'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Admin/Manuscripts/Index')
                ->has('manuscripts.data', 1)
                ->where('manuscripts.data.0.title', 'Epidemiological Assessment of Novel Health Interventions')
            );
    }

    public function test_admin_can_pass_initial_screening(): void
    {
        $response = $this->actingAs($this->adminUser)->post(
            route('admin.manuscripts.screening', $this->manuscript->id),
            ['comment' => 'Format and plagiarism check passed.']
        );

        $response->assertRedirect();
        $this->assertEquals('screening', $this->manuscript->fresh()->status);
        $this->assertDatabaseHas('manuscript_status_history', [
            'manuscript_id' => $this->manuscript->id,
            'to_status' => 'screening',
        ]);
    }

    public function test_admin_can_assign_handling_editor(): void
    {
        $response = $this->actingAs($this->adminUser)->post(
            route('admin.manuscripts.assign_editor', $this->manuscript->id),
            [
                'editor_id' => $this->editor->id,
                'comment' => 'Assigned Prof. Marcus Vance.',
            ]
        );

        $response->assertRedirect();
        $this->assertEquals($this->editor->id, $this->manuscript->fresh()->editor_id);
        $this->assertEquals('editor_assigned', $this->manuscript->fresh()->status);
    }

    public function test_editor_can_invite_reviewer_and_move_to_under_review(): void
    {
        $response = $this->actingAs($this->adminUser)->post(
            route('admin.manuscripts.invite_reviewer', $this->manuscript->id),
            [
                'reviewer_id' => $this->reviewer->id,
                'due_date' => now()->addDays(21)->format('Y-m-d'),
            ]
        );

        $response->assertRedirect();
        $this->assertEquals('under_review', $this->manuscript->fresh()->status);

        $this->assertDatabaseHas('review_assignments', [
            'manuscript_id' => $this->manuscript->id,
            'reviewer_id' => $this->reviewer->id,
            'status' => 'pending',
        ]);
    }

    public function test_reviewer_can_accept_review_invitation(): void
    {
        $assignment = ReviewAssignment::create([
            'manuscript_id' => $this->manuscript->id,
            'reviewer_id' => $this->reviewer->id,
            'assigned_by' => $this->adminUser->id,
            'status' => 'pending',
            'assigned_at' => now(),
        ]);

        $response = $this->actingAs($this->reviewer)->post(
            route('reviewer.respond', $assignment->id),
            ['accept' => true]
        );

        $response->assertRedirect();
        $this->assertEquals('accepted', $assignment->fresh()->status);
        $this->assertNotNull($assignment->fresh()->responded_at);
    }

    public function test_reviewer_can_submit_peer_review_recommendation(): void
    {
        $assignment = ReviewAssignment::create([
            'manuscript_id' => $this->manuscript->id,
            'reviewer_id' => $this->reviewer->id,
            'assigned_by' => $this->adminUser->id,
            'status' => 'accepted',
            'assigned_at' => now(),
        ]);

        $reviewData = [
            'recommendation' => 'minor_revision',
            'comments_to_author' => 'Great methodology, minor typo in table 2.',
            'comments_to_editor' => 'Paper is solid, recommend acceptance after minor tweaks.',
            'quality_score' => 9,
        ];

        $response = $this->actingAs($this->reviewer)->post(
            route('reviewer.review.submit', $assignment->id),
            $reviewData
        );

        $response->assertRedirect(route('reviewer.dashboard'));
        $this->assertEquals('completed', $assignment->fresh()->status);

        $this->assertDatabaseHas('reviews', [
            'review_assignment_id' => $assignment->id,
            'recommendation' => 'minor_revision',
            'quality_score' => 9,
        ]);
    }

    public function test_admin_can_make_final_editorial_decision(): void
    {
        $response = $this->actingAs($this->adminUser)->post(
            route('admin.manuscripts.decision', $this->manuscript->id),
            [
                'decision' => 'accepted',
                'comment' => 'Manuscript accepted for publication in next issue.',
            ]
        );

        $response->assertRedirect();
        $this->assertEquals('accepted', $this->manuscript->fresh()->status);
        $this->assertNotNull($this->manuscript->fresh()->decided_at);
    }
}
