<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreJournalRequest;
use App\Http\Requests\UpdateJournalRequest;
use App\Models\Journal;
use App\Services\JournalService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminJournalController extends Controller
{
    public function __construct(
        protected JournalService $journalService
    ) {}

    /**
     * Admin Journals List
     */
    public function index(Request $request): Response
    {
        $search = $request->input('search');

        $query = Journal::withCount(['volumes', 'articles', 'editorialMembers'])
            ->orderBy('sort_order')
            ->orderBy('title');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('short_title', 'like', "%{$search}%")
                  ->orWhere('issn_print', 'like', "%{$search}%")
                  ->orWhere('issn_online', 'like', "%{$search}%");
            });
        }

        $journals = $query->paginate(15)->withQueryString();

        return Inertia::render('Admin/Journals/Index', [
            'journals' => $journals,
            'filters' => [
                'search' => $search,
            ],
        ]);
    }

    /**
     * Show create journal form
     */
    public function create(): Response
    {
        return Inertia::render('Admin/Journals/Create');
    }

    /**
     * Store new journal
     */
    public function store(StoreJournalRequest $request): RedirectResponse
    {
        $validated = $request->validated();
        $settingsData = $validated['settings'] ?? [];
        unset($validated['settings']);

        $journal = $this->journalService->createJournal($validated, $settingsData);

        return redirect()->route('admin.journals.edit', $journal)
            ->with('success', 'Journal created successfully.');
    }

    /**
     * Show edit journal form
     */
    public function edit(Journal $journal): Response
    {
        $journal->load(['settings', 'volumes.issues']);

        return Inertia::render('Admin/Journals/Edit', [
            'journal' => $journal,
        ]);
    }

    /**
     * Update journal
     */
    public function update(UpdateJournalRequest $request, Journal $journal): RedirectResponse
    {
        $validated = $request->validated();
        $settingsData = $validated['settings'] ?? [];
        unset($validated['settings']);

        $this->journalService->updateJournal($journal, $validated, $settingsData);

        return back()->with('success', 'Journal updated successfully.');
    }

    /**
     * Delete journal
     */
    public function destroy(Journal $journal): RedirectResponse
    {
        $this->journalService->deleteJournal($journal);

        return redirect()->route('admin.journals.index')
            ->with('success', 'Journal deleted successfully.');
    }
}
