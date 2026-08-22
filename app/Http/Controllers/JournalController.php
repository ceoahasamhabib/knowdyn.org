<?php

namespace App\Http\Controllers;

use App\Models\Journal;
use App\Services\EditorialBoardService;
use App\Services\JournalService;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class JournalController extends Controller
{
    public function __construct(
        protected JournalService $journalService,
        protected EditorialBoardService $editorialBoardService
    ) {}

    /**
     * Public Journal Catalog (/journals)
     */
    public function index(Request $request): Response
    {
        $search = $request->input('search');
        $journals = $this->journalService->getPublishedJournals($search, 12);

        return Inertia::render('Public/Journals/Index', [
            'journals' => $journals,
            'filters' => [
                'search' => $search,
            ],
        ]);
    }

    /**
     * Public Journal Homepage (/journals/{journal-slug})
     */
    public function show(string $slug): Response
    {
        $journal = $this->journalService->getJournalBySlug($slug);

        // Get latest current issue or most recent published issue
        $currentIssue = $journal->currentIssue()
            ?? $journal->volumes->flatMap->issues->first();

        if ($currentIssue) {
            $currentIssue->load(['articles' => fn ($q) => $q->where('status', 'published')->with('authors')->orderBy('id')]);
        }

        return Inertia::render('Public/Journals/Show', [
            'journal' => $journal,
            'currentIssue' => $currentIssue,
            'recentIssues' => $journal->volumes->flatMap->issues->take(5),
            'boardPreview' => $journal->editorialMembers->take(6),
        ]);
    }

    /**
     * Public Journal Issues List (/journals/{journal-slug}/issues)
     */
    public function issues(string $slug): Response
    {
        $journal = $this->journalService->getJournalBySlug($slug);

        $volumes = $journal->volumes()
            ->with(['issues' => function ($q) {
                $q->where('status', 'published')
                  ->withCount('articles')
                  ->orderByDesc('number');
            }])
            ->orderByDesc('year')
            ->orderByDesc('number')
            ->get();

        return Inertia::render('Public/Journals/Issues', [
            'journal' => $journal,
            'volumes' => $volumes,
        ]);
    }

    /**
     * Public Journal Archive (/journals/{journal-slug}/archive)
     */
    public function archive(string $slug): Response
    {
        $journal = $this->journalService->getJournalBySlug($slug);
        $archiveData = $this->journalService->getJournalArchive($journal);

        return Inertia::render('Public/Journals/Archive', [
            'journal' => $archiveData['journal'],
            'volumes' => $archiveData['volumes'],
            'stats' => [
                'total_volumes' => $archiveData['total_volumes'],
                'total_issues' => $archiveData['total_issues'],
                'total_articles' => $archiveData['total_articles'],
            ],
        ]);
    }

    /**
     * Public Journal Editorial Board (/journals/{journal-slug}/editorial-board)
     */
    public function editorialBoard(string $slug): Response
    {
        $journal = $this->journalService->getJournalBySlug($slug);
        $groupedBoard = $this->editorialBoardService->getGroupedEditorialBoard($journal);

        return Inertia::render('Public/Journals/EditorialBoard', [
            'journal' => $journal,
            'groupedBoard' => $groupedBoard,
        ]);
    }
}
