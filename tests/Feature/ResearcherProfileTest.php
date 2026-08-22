<?php

namespace Tests\Feature;

use App\Models\Project;
use App\Models\ResearcherAffiliation;
use App\Models\ResearcherInterest;
use App\Models\ResearcherProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ResearcherProfileTest extends TestCase
{
    use RefreshDatabase;

    public function test_researcher_profile_edit_screen_can_be_rendered(): void
    {
        $user = User::factory()->create([
            'username' => 'dr-al-mamun',
        ]);

        $response = $this->actingAs($user)->get(route('researcher.profile.edit'));

        $response->assertOk();
    }

    public function test_researcher_profile_can_be_updated_with_valid_data(): void
    {
        $user = User::factory()->create([
            'username' => 'dr-smith',
        ]);

        $response = $this->actingAs($user)->put(route('researcher.profile.update'), [
            'first_name' => 'John',
            'last_name' => 'Smith',
            'username' => 'john-smith-phd',
            'biography' => 'Leading researcher in artificial intelligence and bioinformatics.',
            'institution' => 'Oxford University',
            'department' => 'Department of Computer Science',
            'country' => 'United Kingdom',
            'city' => 'Oxford',
            'orcid' => '0000-0002-1825-0097',
            'google_scholar' => 'https://scholar.google.com/citations?user=test',
            'expertise' => 'Machine Learning, Computational Biology, Deep Learning',
            'is_public' => true,
        ]);

        $response->assertSessionHasNoErrors();
        $response->assertRedirect();

        $user->refresh();
        $this->assertSame('john-smith-phd', $user->username);
        $this->assertSame('John', $user->first_name);
        $this->assertNotNull($user->researcherProfile);
        $this->assertSame('Oxford University', $user->researcherProfile->institution);
        $this->assertSame('0000-0002-1825-0097', $user->researcherProfile->orcid);
    }

    public function test_reserved_usernames_are_rejected(): void
    {
        $user = User::factory()->create([
            'username' => 'valid-user',
        ]);

        $reservedNames = ['admin', 'login', 'register', 'journals', 'articles', 'projects', 'services', 'search', 'dashboard', 'api'];

        foreach ($reservedNames as $reserved) {
            $response = $this->actingAs($user)->put(route('researcher.profile.update'), [
                'username' => $reserved,
                'institution' => 'Test Uni',
            ]);

            $response->assertSessionHasErrors('username');
        }
    }

    public function test_invalid_orcid_format_is_rejected(): void
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->put(route('researcher.profile.update'), [
            'username' => 'test-user',
            'orcid' => 'invalid-orcid-1234',
        ]);

        $response->assertSessionHasErrors('orcid');
    }

    public function test_research_interests_can_be_synced(): void
    {
        $user = User::factory()->create(['username' => 'scientist-one']);
        $profile = ResearcherProfile::create([
            'user_id' => $user->id,
            'is_public' => true,
        ]);

        $response = $this->actingAs($user)->put(route('researcher.interests.update'), [
            'interests' => ['Nanotechnology', 'Quantum Computing', 'Applied Physics'],
        ]);

        $response->assertSessionHasNoErrors();
        $this->assertCount(3, $profile->fresh()->interests);
        $this->assertDatabaseHas('researcher_interests', [
            'researcher_profile_id' => $profile->id,
            'interest' => 'Nanotechnology',
        ]);
    }

    public function test_researcher_affiliation_can_be_added_and_removed(): void
    {
        $user = User::factory()->create(['username' => 'scientist-two']);
        $profile = ResearcherProfile::create([
            'user_id' => $user->id,
            'is_public' => true,
        ]);

        $response = $this->actingAs($user)->post(route('researcher.affiliations.store'), [
            'institution' => 'Cambridge University',
            'department' => 'Biotechnology',
            'position' => 'Senior Research Fellow',
            'country' => 'United Kingdom',
            'is_current' => true,
        ]);

        $response->assertSessionHasNoErrors();
        $this->assertCount(1, $profile->fresh()->affiliations);

        $affiliation = $profile->affiliations->first();

        // Attempt delete by another user should be forbidden
        $otherUser = User::factory()->create(['username' => 'other-user']);
        $forbiddenResponse = $this->actingAs($otherUser)->delete(route('researcher.affiliations.destroy', $affiliation));
        $forbiddenResponse->assertForbidden();

        // Delete by owner should succeed
        $deleteResponse = $this->actingAs($user)->delete(route('researcher.affiliations.destroy', $affiliation));
        $deleteResponse->assertSessionHasNoErrors();
        $this->assertCount(0, $profile->fresh()->affiliations);
    }

    public function test_public_researcher_profile_and_directory_are_accessible(): void
    {
        $user = User::factory()->create([
            'username' => 'dr-abdullah-al-mamun',
            'first_name' => 'Abdullah',
            'last_name' => 'Al Mamun',
        ]);

        ResearcherProfile::create([
            'user_id' => $user->id,
            'institution' => 'University of Malaya',
            'biography' => 'Professor of Applied Economics & Sustainable Development',
            'is_public' => true,
        ]);

        // Directory index
        $indexResponse = $this->get(route('researchers.index'));
        $indexResponse->assertOk();

        // Standard profile route
        $stdResponse = $this->get(route('researchers.show', 'dr-abdullah-al-mamun'));
        $stdResponse->assertOk();

        // Public vanity profile page at /{username}
        $profileResponse = $this->get('/dr-abdullah-al-mamun');
        $profileResponse->assertOk();
    }

    public function test_public_research_projects_directory_and_show_page(): void
    {
        $user = User::factory()->create(['username' => 'lead-pi']);

        $project = Project::create([
            'user_id' => $user->id,
            'title' => 'Sustainable Urban Mobility in Southeast Asia',
            'slug' => 'sustainable-urban-mobility-sea',
            'summary' => 'Comprehensive framework for evaluating low-carbon transportation infrastructure.',
            'research_area' => 'Urban Planning',
            'status' => 'active',
            'institution' => 'National University of Singapore',
            'is_public' => true,
        ]);

        $directoryResponse = $this->get(route('projects.index'));
        $directoryResponse->assertOk();

        $showResponse = $this->get(route('projects.show', $project->slug));
        $showResponse->assertOk();
    }
}
