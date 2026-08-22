<?php

namespace Tests\Feature;

use App\Models\Article;
use App\Models\ArticleAuthor;
use App\Models\ArticleReference;
use App\Models\Issue;
use App\Models\Journal;
use App\Models\User;
use App\Models\Volume;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Tests\TestCase;

class ArticleTest extends TestCase
{
    use RefreshDatabase;

    protected User $adminUser;
    protected Journal $journal;
    protected Volume $volume;
    protected Issue $issue;
    protected Article $article;

    protected function setUp(): void
    {
        parent::setUp();

        // Create permissions and admin user
        $permission = Permission::firstOrCreate(['name' => 'manage articles']);
        $adminRole = Role::firstOrCreate(['name' => 'Admin']);
        $adminRole->givePermissionTo($permission);

        $this->adminUser = User::factory()->create([
            'email' => 'admin@knowdyn.org',
            'email_verified_at' => now(),
        ]);
        $this->adminUser->assignRole('Admin');

        // Create test journal, volume, issue, and article
        $this->journal = Journal::create([
            'title' => 'Health Dynamics Journal',
            'slug' => 'health-dynamics',
            'short_title' => 'Health Dyn',
            'issn_online' => '2980-4825',
            'publisher' => 'Knowledge Dynamics',
            'status' => 'active',
        ]);

        $this->volume = Volume::create([
            'journal_id' => $this->journal->id,
            'number' => 1,
            'year' => 2026,
            'status' => 'active',
        ]);

        $this->issue = Issue::create([
            'volume_id' => $this->volume->id,
            'number' => 1,
            'year' => 2026,
            'title' => 'Inaugural Issue',
            'status' => 'published',
            'is_current' => true,
            'published_at' => now(),
        ]);

        $this->article = Article::create([
            'journal_id' => $this->journal->id,
            'title' => 'Evaluation of Community-Based Health Interventions',
            'slug' => 'evaluation-of-community-health-interventions',
            'abstract' => 'This comprehensive study analyzes digital health interventions across decentralized care centers.',
            'article_type' => 'original-research',
            'doi' => '10.58421/hd.v1i1.01',
            'pages' => '1-12',
            'submission_date' => '2026-01-10',
            'acceptance_date' => '2026-02-15',
            'published_at' => '2026-03-01',
            'status' => 'published',
            'view_count' => 10,
            'download_count' => 5,
        ]);

        $this->article->issues()->attach($this->issue->id, ['sort_order' => 1]);

        $this->article->authors()->createMany([
            [
                'first_name' => 'Dr. Robert',
                'last_name' => 'Chen',
                'email' => 'rchen@oxford.ac.uk',
                'affiliation' => 'Oxford Global Health Institute',
                'country' => 'United Kingdom',
                'orcid' => '0000-0002-1825-0097',
                'is_corresponding' => true,
                'sort_order' => 1,
            ],
            [
                'first_name' => 'Dr. Sarah',
                'last_name' => 'Jenkins',
                'email' => 'sjenkins@jhu.edu',
                'affiliation' => 'Johns Hopkins Bloomberg School of Public Health',
                'country' => 'United States',
                'orcid' => '0000-0003-4567-8901',
                'is_corresponding' => false,
                'sort_order' => 2,
            ],
        ]);

        $this->article->references()->create([
            'reference_text' => 'World Health Organization. (2024). Global health strategies. Geneva: WHO.',
            'doi' => '10.1016/j.who.2024.01',
            'sort_order' => 1,
        ]);
    }

    public function test_public_articles_repository_renders_successfully(): void
    {
        $response = $this->get(route('articles.index'));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/Articles/Index')
                ->has('articles.data', 1)
                ->where('articles.data.0.title', 'Evaluation of Community-Based Health Interventions')
            );
    }

    public function test_articles_can_be_filtered_by_search_query(): void
    {
        $response = $this->get(route('articles.index', ['search' => 'Community-Based']));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/Articles/Index')
                ->has('articles.data', 1)
            );

        $noMatchResponse = $this->get(route('articles.index', ['search' => 'NonExistentTopicXYZ']));
        $noMatchResponse->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/Articles/Index')
                ->has('articles.data', 0)
            );
    }

    public function test_public_article_show_renders_and_increments_views(): void
    {
        $initialViews = $this->article->fresh()->view_count;

        $response = $this->get(route('articles.show', $this->article->slug));

        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page
                ->component('Public/Articles/Show')
                ->has('article')
                ->where('article.title', $this->article->title)
                ->where('article.doi', $this->article->doi)
                ->has('citations.apa')
                ->has('citations.bibtex')
                ->has('citations.ris')
                ->has('scholarlyMeta')
            );

        $this->assertEquals($initialViews + 1, $this->article->fresh()->view_count);
    }

    public function test_export_citation_endpoints_generate_correct_formats(): void
    {
        // BibTeX
        $bibtexResponse = $this->get(route('articles.citation', ['slug' => $this->article->slug, 'format' => 'bibtex']));
        $bibtexResponse->assertStatus(200)
            ->assertSee('@article{chen2026_evaluati');

        // RIS
        $risResponse = $this->get(route('articles.citation', ['slug' => $this->article->slug, 'format' => 'ris']));
        $risResponse->assertStatus(200)
            ->assertSee('TY  - JOUR')
            ->assertSee('AU  - Chen, Dr. Robert');

        // APA
        $apaResponse = $this->get(route('articles.citation', ['slug' => $this->article->slug, 'format' => 'apa']));
        $apaResponse->assertStatus(200);
        $this->assertStringContainsString('Chen, D. R. & Jenkins, D. S.', $apaResponse->getContent());
    }

    public function test_pdf_download_increments_download_counter(): void
    {
        $initialDownloads = $this->article->fresh()->download_count;

        $response = $this->get(route('articles.download', $this->article->slug));

        $response->assertStatus(302); // Redirects back with info when file not on physical disk
        $this->assertEquals($initialDownloads + 1, $this->article->fresh()->download_count);
    }

    public function test_admin_articles_page_requires_authorization(): void
    {
        $guestResponse = $this->get(route('admin.articles.index'));
        $guestResponse->assertRedirect(route('login'));

        $authResponse = $this->actingAs($this->adminUser)->get(route('admin.articles.index'));
        $authResponse->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Admin/Articles/Index'));
    }

    public function test_admin_can_publish_new_article_with_authors_and_keywords(): void
    {
        $articleData = [
            'journal_id' => $this->journal->id,
            'issue_id' => $this->issue->id,
            'title' => 'Machine Learning for Early Disease Diagnostics',
            'slug' => 'machine-learning-early-disease-diagnostics',
            'abstract' => 'Investigating novel transformer neural architectures for clinical image segmentation.',
            'article_type' => 'original-research',
            'doi' => '10.58421/hd.v1i1.02',
            'pages' => '13-28',
            'submission_date' => '2026-02-01',
            'acceptance_date' => '2026-03-01',
            'published_at' => '2026-03-10',
            'status' => 'published',
            'authors' => [
                [
                    'first_name' => 'Alice',
                    'last_name' => 'Wong',
                    'email' => 'awong@mit.edu',
                    'affiliation' => 'MIT CSAIL',
                    'country' => 'United States',
                    'orcid' => '0000-0001-2345-6789',
                    'is_corresponding' => true,
                    'sort_order' => 1,
                ],
            ],
            'keywords' => ['Machine Learning', 'Healthcare AI', 'Diagnostics'],
            'references' => [
                'Vaswani, A. et al. (2017). Attention is all you need. NeurIPS.',
            ],
        ];

        $response = $this->actingAs($this->adminUser)->post(route('admin.articles.store'), $articleData);

        $response->assertRedirect();

        $this->assertDatabaseHas('articles', [
            'title' => 'Machine Learning for Early Disease Diagnostics',
            'doi' => '10.58421/hd.v1i1.02',
            'status' => 'published',
        ]);

        $newArticle = Article::where('doi', '10.58421/hd.v1i1.02')->first();
        $this->assertCount(1, $newArticle->authors);
        $this->assertEquals('Alice', $newArticle->authors->first()->first_name);
        $this->assertCount(3, $newArticle->keywords);
        $this->assertCount(1, $newArticle->references);
    }

    public function test_admin_can_update_article(): void
    {
        $updateData = [
            'journal_id' => $this->journal->id,
            'title' => 'Updated Evaluation of Community-Based Health Interventions',
            'article_type' => 'review-article',
            'doi' => '10.58421/hd.v1i1.01',
            'status' => 'published',
        ];

        $response = $this->actingAs($this->adminUser)->put(route('admin.articles.update', $this->article->id), $updateData);

        $response->assertRedirect();

        $this->assertDatabaseHas('articles', [
            'id' => $this->article->id,
            'title' => 'Updated Evaluation of Community-Based Health Interventions',
            'article_type' => 'review-article',
        ]);
    }

    public function test_admin_can_delete_article(): void
    {
        $response = $this->actingAs($this->adminUser)->delete(route('admin.articles.destroy', $this->article->id));

        $response->assertRedirect(route('admin.articles.index'));
        $this->assertSoftDeleted('articles', [
            'id' => $this->article->id,
        ]);
    }
}
