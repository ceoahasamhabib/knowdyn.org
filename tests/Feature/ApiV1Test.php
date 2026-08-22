<?php

namespace Tests\Feature;

use App\Models\Article;
use App\Models\Journal;
use App\Models\ResearcherProfile;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ApiV1Test extends TestCase
{
    use RefreshDatabase;

    protected Journal $journal;
    protected Article $article;
    protected User $researcherUser;

    protected function setUp(): void
    {
        parent::setUp();

        $this->journal = Journal::create([
            'title' => 'Health Dynamics',
            'slug' => 'health-dynamics',
            'short_title' => 'Health Dyn',
            'issn_online' => '3006-5518',
            'publisher' => 'Knowledge Dynamics',
            'status' => 'active',
        ]);

        $this->article = Article::create([
            'journal_id' => $this->journal->id,
            'title' => 'Epidemiological Surveillance and Digital Healthcare Interventions',
            'slug' => 'epidemiological-surveillance-digital-healthcare',
            'abstract' => 'Evaluating community health data across regional clusters.',
            'article_type' => 'original-research',
            'doi' => '10.58421/hd.v1i1.01',
            'status' => 'published',
            'published_at' => now(),
        ]);

        $this->article->authors()->create([
            'first_name' => 'Sarah',
            'last_name' => 'Al-Mansoor',
            'email' => 'sarah@ki.se',
            'affiliation' => 'Karolinska Institute',
            'orcid' => '0000-0001-5234-9981',
            'is_corresponding' => true,
            'sort_order' => 1,
        ]);

        $this->researcherUser = User::factory()->create([
            'name' => 'Prof. Sarah Al-Mansoor',
            'username' => 'sarah-al-mansoor',
            'email' => 'sarah.mansoor@ki.se',
        ]);

        $this->researcherUser->researcherProfile()->create([
            'title' => 'Prof. Dr.',
            'institution' => 'Karolinska Institute',
            'country' => 'Sweden',
            'orcid' => '0000-0001-5234-9981',
            'is_public' => true,
        ]);
    }

    public function test_api_v1_journals_list(): void
    {
        $response = $this->getJson(route('api.v1.journals.index'));

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('data.data.0.slug', 'health-dynamics');
    }

    public function test_api_v1_journal_show(): void
    {
        $response = $this->getJson(route('api.v1.journals.show', 'health-dynamics'));

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('data.title', 'Health Dynamics');
    }

    public function test_api_v1_articles_list(): void
    {
        $response = $this->getJson(route('api.v1.articles.index'));

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('data.data.0.slug', 'epidemiological-surveillance-digital-healthcare');
    }

    public function test_api_v1_article_show(): void
    {
        $response = $this->getJson(route('api.v1.articles.show', 'epidemiological-surveillance-digital-healthcare'));

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('data.doi', '10.58421/hd.v1i1.01')
            ->assertJsonPath('data.authors.0.first_name', 'Sarah');
    }

    public function test_api_v1_researchers_list(): void
    {
        $response = $this->getJson(route('api.v1.researchers.index'));

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('data.data.0.institution', 'Karolinska Institute');
    }

    public function test_api_v1_researcher_show_by_username(): void
    {
        $response = $this->getJson(route('api.v1.researchers.show', 'sarah-al-mansoor'));

        $response->assertStatus(200)
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('data.username', 'sarah-al-mansoor')
            ->assertJsonPath('data.profile.orcid', '0000-0001-5234-9981');
    }
}
