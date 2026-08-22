<?php

namespace Tests\Feature;

use App\Models\Journal;
use Database\Seeders\JournalSeeder;
use Database\Seeders\ServiceSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class InformationArchitectureTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed([
            JournalSeeder::class,
            ServiceSeeder::class,
        ]);
    }

    public function test_all_five_journals_exist_and_render_successfully(): void
    {
        $expectedSlugs = [
            'health-dynamics',
            'kd-food-science-nutrition',
            'kd-asian-studies',
            'kd-accounting-business-management-finance',
            'kd-comparative-religion',
        ];

        foreach ($expectedSlugs as $slug) {
            $journal = Journal::where('slug', $slug)->first();
            $this->assertNotNull($journal, "Journal with slug '{$slug}' should exist.");

            $response = $this->get(route('journals.show', $slug));
            $response->assertStatus(200);

            $archiveResponse = $this->get(route('journals.archive', $slug));
            $archiveResponse->assertStatus(200);
        }
    }

    public function test_books_and_monographs_portal_renders(): void
    {
        $response = $this->get(route('books.index'));
        $response->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Public/Books/Index'));

        $proposeResponse = $this->get(route('books.propose'));
        $proposeResponse->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Public/Books/Propose'));

        $submitProposalResponse = $this->post(route('books.propose.store'), [
            'author_name' => 'Prof. Dr. Elizabeth Warren',
            'author_email' => 'ewarren@cambridge.ac.uk',
            'institution' => 'University of Cambridge',
            'book_title' => 'Epistemologies of Digital Health In Global South',
            'subject_discipline' => 'Biomedical & Health Sciences',
            'estimated_word_count' => '75,000 words',
            'synopsis_and_toc' => 'Comprehensive evaluation of decentralized public health systems.',
        ]);

        $submitProposalResponse->assertRedirect();
    }

    public function test_news_events_and_careers_portals_render(): void
    {
        $newsResponse = $this->get(route('news.index'));
        $newsResponse->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Public/NewsEvents/Index'));

        $eventsResponse = $this->get(route('events.index'));
        $eventsResponse->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Public/NewsEvents/Index'));

        $careersResponse = $this->get(route('careers.index'));
        $careersResponse->assertStatus(200)
            ->assertInertia(fn ($page) => $page->component('Public/NewsEvents/Careers'));
    }

    public function test_guidelines_and_policies_portals_render(): void
    {
        $guidelines = ['authors', 'editors', 'reviewers', 'editorial-policies'];

        foreach ($guidelines as $type) {
            $response = $this->get(route('guidelines.show', $type));
            $response->assertStatus(200)
                ->assertInertia(fn ($page) => $page->component('Public/Guidelines/Show'));
        }
    }

    public function test_librarians_open_access_support_and_feedback_portals_render(): void
    {
        $this->get(route('librarians.index'))->assertStatus(200);
        $this->get(route('librarians.faqs'))->assertStatus(200);
        $this->get(route('librarians.catalogue'))->assertStatus(200);
        $this->get(route('librarians.order_print'))->assertStatus(200);

        $this->get(route('publish.open_access'))->assertStatus(200);
        $this->get(route('proofreading.freelancers'))->assertStatus(200);
        $this->get(route('support.index'))->assertStatus(200);
        $this->get(route('feedback.index'))->assertStatus(200);

        $feedbackResponse = $this->post(route('feedback.store'), [
            'name' => 'Dr. Robert Zhang',
            'email' => 'rzhang@nus.edu.sg',
            'subject' => 'Peer review workflow suggestion',
            'category' => 'Peer Review Interface',
            'message' => 'The blinded evaluation form is exceptionally smooth.',
        ]);

        $feedbackResponse->assertRedirect();
    }
}
