<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Journal;
use App\Models\ResearcherProfile;
use Inertia\Inertia;

class PublicController extends Controller
{
    public function home()
    {
        $stats = [
            'journals' => Journal::where('status', 'active')->count(),
            'articles' => Article::where('status', 'published')->count(),
            'researchers' => ResearcherProfile::count(),
        ];

        return Inertia::render('Welcome', [
            'stats' => $stats,
            'featuredJournals' => [],
            'latestArticles' => [],
            'featuredResearchers' => [],
        ]);
    }

    public function about()
    {
        return Inertia::render('Public/About');
    }

    public function contact()
    {
        return Inertia::render('Public/Contact');
    }

    public function contactStore()
    {
        request()->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'subject' => 'required|string|max:255',
            'message' => 'required|string|max:5000',
        ]);

        // TODO: Send notification email, store in DB
        // For now, just redirect back with success
        return back()->with('success', 'Thank you for your message. We will respond soon.');
    }

    public function services()
    {
        return Inertia::render('Public/Services');
    }

    public function journals()
    {
        $journals = Journal::where('status', 'active')
            ->withCount(['articles', 'volumes'])
            ->get()
            ->map(fn ($j) => [
                'title' => $j->title,
                'slug' => $j->slug,
                'issn' => $j->issn_online,
                'description' => $j->description,
                'frequency' => $j->publication_frequency,
                'subjects' => [],
                'articlesCount' => $j->articles_count,
                'volumesCount' => $j->volumes_count,
                'status' => $j->status,
            ]);

        return Inertia::render('Public/Journals/Index', [
            'journals' => $journals,
        ]);
    }
}
