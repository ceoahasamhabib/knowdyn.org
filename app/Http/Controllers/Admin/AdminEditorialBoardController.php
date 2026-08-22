<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreEditorialMemberRequest;
use App\Models\Journal;
use App\Models\JournalEditorialMember;
use App\Services\EditorialBoardService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminEditorialBoardController extends Controller
{
    public function __construct(
        protected EditorialBoardService $editorialBoardService
    ) {}

    /**
     * Editorial Board Manager for a Journal
     */
    public function index(Journal $journal): Response
    {
        $members = $journal->editorialMembers()->orderBy('sort_order')->get();

        return Inertia::render('Admin/Journals/EditorialBoard', [
            'journal' => $journal,
            'members' => $members,
        ]);
    }

    /**
     * Store Member
     */
    public function store(StoreEditorialMemberRequest $request, Journal $journal): RedirectResponse
    {
        $this->editorialBoardService->addMember($journal, $request->validated());

        return back()->with('success', 'Editorial board member added successfully.');
    }

    /**
     * Update Member
     */
    public function update(Request $request, JournalEditorialMember $member): RedirectResponse
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|max:255',
            'institution' => 'nullable|string|max:500',
            'country' => 'nullable|string|max:100',
            'role' => 'required|string|max:100',
            'biography' => 'nullable|string|max:3000',
            'orcid' => ['nullable', 'string', 'max:50', 'regex:/^\d{4}-\d{4}-\d{4}-\d{3}[\dX]$/'],
            'sort_order' => 'nullable|integer|min:0',
            'is_active' => 'boolean',
        ]);

        $this->editorialBoardService->updateMember($member, $data);

        return back()->with('success', 'Editorial board member updated.');
    }

    /**
     * Remove Member
     */
    public function destroy(JournalEditorialMember $member): RedirectResponse
    {
        $this->editorialBoardService->removeMember($member);

        return back()->with('success', 'Editorial board member removed.');
    }

    /**
     * Reorder Members
     */
    public function reorder(Request $request, Journal $journal): RedirectResponse
    {
        $request->validate([
            'ordered_ids' => 'required|array',
            'ordered_ids.*' => 'integer|exists:journal_editorial_members,id',
        ]);

        $this->editorialBoardService->reorderMembers($journal, $request->ordered_ids);

        return back()->with('success', 'Board order saved.');
    }
}
