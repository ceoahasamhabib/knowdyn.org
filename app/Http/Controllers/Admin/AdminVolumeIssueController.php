<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreIssueRequest;
use App\Http\Requests\StoreVolumeRequest;
use App\Models\Issue;
use App\Models\Journal;
use App\Models\Volume;
use App\Services\VolumeIssueService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminVolumeIssueController extends Controller
{
    public function __construct(
        protected VolumeIssueService $volumeIssueService
    ) {}

    /**
     * Volume and Issue Manager for a Journal
     */
    public function index(Journal $journal): Response
    {
        $journal->load([
            'volumes' => function ($q) {
                $q->with(['issues' => function ($iq) {
                    $iq->withCount('articles')->orderByDesc('number');
                }])->orderByDesc('year')->orderByDesc('number');
            },
        ]);

        return Inertia::render('Admin/Journals/VolumesIssues', [
            'journal' => $journal,
        ]);
    }

    /**
     * Store Volume
     */
    public function storeVolume(StoreVolumeRequest $request, Journal $journal): RedirectResponse
    {
        $this->volumeIssueService->createVolume($journal, $request->validated());

        return back()->with('success', 'Volume created successfully.');
    }

    /**
     * Update Volume
     */
    public function updateVolume(Request $request, Volume $volume): RedirectResponse
    {
        $data = $request->validate([
            'number' => 'required|integer|min:1',
            'year' => 'required|integer|min:1900|max:' . (date('Y') + 5),
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string|max:2000',
        ]);

        $this->volumeIssueService->updateVolume($volume, $data);

        return back()->with('success', 'Volume updated successfully.');
    }

    /**
     * Delete Volume
     */
    public function destroyVolume(Volume $volume): RedirectResponse
    {
        $this->volumeIssueService->deleteVolume($volume);

        return back()->with('success', 'Volume deleted successfully.');
    }

    /**
     * Store Issue
     */
    public function storeIssue(StoreIssueRequest $request, Volume $volume): RedirectResponse
    {
        $this->volumeIssueService->createIssue($volume, $request->validated());

        return back()->with('success', 'Issue created successfully.');
    }

    /**
     * Update Issue
     */
    public function updateIssue(Request $request, Issue $issue): RedirectResponse
    {
        $data = $request->validate([
            'number' => 'required|string|max:50',
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string|max:2000',
            'cover_image' => 'nullable|string|max:1000',
            'published_at' => 'nullable|date',
            'is_current' => 'boolean',
            'status' => 'required|in:draft,published,archived',
            'sort_order' => 'integer',
        ]);

        $this->volumeIssueService->updateIssue($issue, $data);

        return back()->with('success', 'Issue updated successfully.');
    }

    /**
     * Delete Issue
     */
    public function destroyIssue(Issue $issue): RedirectResponse
    {
        $this->volumeIssueService->deleteIssue($issue);

        return back()->with('success', 'Issue deleted successfully.');
    }

    /**
     * Set Current Issue
     */
    public function setCurrentIssue(Issue $issue): RedirectResponse
    {
        $this->volumeIssueService->setCurrentIssue($issue);

        return back()->with('success', 'Current issue updated successfully.');
    }
}
