<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\BookProposal;
use App\Models\Career;
use App\Models\GuidelinePage;
use App\Models\Journal;
use App\Models\NewsEvent;
use App\Models\Service;
use App\Models\SiteSetting;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class InformationArchitectureController extends Controller
{
    /**
     * Open Access Policy (/publish/open-access)
     */
    public function openAccess(): Response
    {
        $guideline = GuidelinePage::where('key', 'open-access')->first();

        return Inertia::render('Public/OpenAccess', [
            'guideline' => $guideline,
        ]);
    }

    /**
     * Books & eBooks Catalog (/books, /publish/books)
     */
    public function books(Request $request): Response
    {
        $category = $request->query('category', 'all');
        $format = $request->query('format', 'all');

        $query = Book::orderBy('sort_order');

        if ($category !== 'all') {
            $query->where('category', $category);
        }

        if ($format === 'ebook') {
            $query->where('format', 'like', '%eBook%');
        } elseif ($format === 'print') {
            $query->where('format', 'like', '%Print%');
        }

        $books = $query->get();

        return Inertia::render('Public/Books/Index', [
            'books' => $books,
            'filters' => [
                'category' => $category,
                'format' => $format,
            ],
        ]);
    }

    /**
     * Propose a Book Portal (/books/propose)
     */
    public function proposeBook(): Response
    {
        return Inertia::render('Public/Books/Propose');
    }

    /**
     * Store Book Proposal (/books/propose)
     */
    public function storeBookProposal(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'author_name' => 'required|string|max:255',
            'author_email' => 'required|email|max:255',
            'institution' => 'required|string|max:255',
            'book_title' => 'required|string|max:255',
            'subject_discipline' => 'required|string|max:255',
            'estimated_word_count' => 'nullable|string|max:50',
            'target_completion_date' => 'nullable|string|max:50',
            'synopsis_and_toc' => 'required|string|max:5000',
        ]);

        BookProposal::create($validated);

        \App\Models\AppNotification::notifyAdmins(
            'New Book Monograph Proposal',
            "New book proposal \"{$validated['book_title']}\" submitted by {$validated['author_name']}.",
            route('admin.books.proposals'),
            'book',
            '📚'
        );

        return back()->with('success', 'Thank you! Your academic book proposal has been submitted to the Knowledge Dynamics Monograph & Editorial Board.');
    }

    /**
     * News, Announcements & Call for Papers (/news)
     */
    public function news(Request $request): Response
    {
        $category = $request->query('category', 'all');

        $query = NewsEvent::where('is_published', true)
            ->whereIn('type', ['news', 'announcement'])
            ->orderByDesc('created_at');

        if ($category !== 'all') {
            $query->where('category', $category);
        }

        $newsItems = $query->get();

        return Inertia::render('Public/NewsEvents/Index', [
            'mode' => 'news',
            'items' => $newsItems,
            'currentCategory' => $category,
        ]);
    }

    /**
     * Seminars, Workshops & Academic Events (/events)
     */
    public function events(Request $request): Response
    {
        $query = NewsEvent::where('is_published', true)
            ->whereIn('type', ['event', 'workshop'])
            ->orderByDesc('created_at');

        $events = $query->get();

        return Inertia::render('Public/NewsEvents/Index', [
            'mode' => 'events',
            'items' => $events,
            'currentCategory' => $request->query('category', 'all'),
        ]);
    }

    /**
     * Academic Careers & Editorial Fellowships (/careers)
     */
    public function careers(): Response
    {
        $positions = Career::where('is_active', true)
            ->orderByDesc('created_at')
            ->get();

        return Inertia::render('Public/NewsEvents/Careers', [
            'positions' => $positions,
        ]);
    }

    /**
     * Resource Center for Librarians (/librarians, /librarians/faqs, /librarians/catalogue, /librarians/order-print)
     */
    public function librarians(Request $request): Response
    {
        $journals = Journal::where('status', 'active')
            ->select('title', 'slug', 'issn_print', 'issn_online', 'publication_frequency', 'is_open_access')
            ->orderBy('sort_order')
            ->get();

        return Inertia::render('Public/Librarians/Index', [
            'journals' => $journals,
            'activeTab' => $request->query('tab', 'overview'),
        ]);
    }

    /**
     * Guidelines for Authors, Editors & Reviewers (/guidelines/{type})
     */
    public function guidelines(string $type): Response
    {
        $allowed = ['authors', 'editors', 'reviewers', 'editorial-policies'];
        if (!in_array($type, $allowed)) {
            $type = 'authors';
        }

        $guideline = GuidelinePage::where('key', $type)->first();

        return Inertia::render('Public/Guidelines/Show', [
            'type' => $type,
            'guideline' => $guideline,
        ]);
    }

    /**
     * Our Freelancer Editors Roster (/proofreading/freelancers)
     */
    public function freelancers(): Response
    {
        return Inertia::render('Public/Freelancers');
    }

    /**
     * Help & Support Desk (/support)
     */
    public function support(): Response
    {
        return Inertia::render('Public/Support');
    }

    /**
     * Feedback Portal (/feedback)
     */
    public function feedback(): Response
    {
        return Inertia::render('Public/Feedback');
    }

    /**
     * Store Feedback / Support Inquiry (/feedback)
     */
    public function storeFeedback(Request $request): RedirectResponse
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'subject' => 'required|string|max:255',
            'category' => 'required|string|max:100',
            'message' => 'required|string|max:5000',
        ]);

        return back()->with('success', 'Thank you for your feedback! The Knowledge Dynamics administrative team will review your message.');
    }
}
