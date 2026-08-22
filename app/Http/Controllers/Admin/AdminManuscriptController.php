<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\Manuscript;
use App\Models\User;
use App\Services\EditorialManagementService;
use App\Services\PeerReviewService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminManuscriptController extends Controller
{
    public function __construct(
        protected EditorialManagementService $editorialService,
        protected PeerReviewService $peerReviewService
    ) {}

    /**
     * Admin Manuscripts Queue (/admin/manuscripts)
     */
    public function index(Request $request): Response
    {
        $search = $request->input('search');
        $status = $request->input('status');
        $journalId = $request->input('journal_id');

        $manuscripts = $this->editorialService->getSubmissionsList($search, $status, $journalId, 15);
        $journals = Journal::select('id', 'title', 'short_title')->get();

        return Inertia::render('Admin/Manuscripts/Index', [
            'manuscripts' => $manuscripts,
            'journals' => $journals,
            'filters' => [
                'search' => $search,
                'status' => $status,
                'journal_id' => $journalId,
            ],
        ]);
    }

    /**
     * Editorial Cockpit for a single manuscript (/admin/manuscripts/{id})
     */
    public function show(int $id): Response
    {
        $manuscript = $this->editorialService->getSubmissionDetails($id);
        $editors = User::select('id', 'name', 'email')->get();
        $potentialReviewers = User::select('id', 'name', 'email')->get();

        return Inertia::render('Admin/Manuscripts/Show', [
            'manuscript' => $manuscript,
            'editors' => $editors,
            'potentialReviewers' => $potentialReviewers,
        ]);
    }

    /**
     * Pass Initial Screening
     */
    public function passScreening(Request $request, Manuscript $manuscript): RedirectResponse
    {
        $comment = $request->input('comment');
        $this->editorialService->passScreening($manuscript, $request->user(), $comment);

        return back()->with('success', 'Manuscript passed initial screening.');
    }

    /**
     * Assign Handling Editor
     */
    public function assignEditor(Request $request, Manuscript $manuscript): RedirectResponse
    {
        $request->validate([
            'editor_id' => 'required|exists:users,id',
            'comment' => 'nullable|string|max:1000',
        ]);

        $editor = User::findOrFail($request->input('editor_id'));
        $this->editorialService->assignEditor($manuscript, $editor, $request->user(), $request->input('comment'));

        return back()->with('success', "Assigned handling editor: {$editor->name}.");
    }

    /**
     * Make Editorial Decision
     */
    public function makeDecision(Request $request, Manuscript $manuscript): RedirectResponse
    {
        $request->validate([
            'decision' => 'required|in:accepted,rejected,revision_required,production,published',
            'comment' => 'nullable|string|max:2000',
        ]);

        $decision = $request->input('decision');
        $this->editorialService->makeDecision($manuscript, $decision, $request->user(), $request->input('comment'));

        if ($manuscript->submitter_id) {
            \App\Models\AppNotification::send(
                $manuscript->submitter_id,
                "Editorial Decision: " . ucfirst(str_replace('_', ' ', $decision)),
                "An editorial decision was recorded for your manuscript \"{$manuscript->title}\".",
                route('author.submissions.show', $manuscript->id),
                'manuscript',
                '⚖️'
            );
        }

        return back()->with('success', 'Editorial decision successfully recorded.');
    }

    /**
     * Invite Reviewer
     */
    public function inviteReviewer(Request $request, Manuscript $manuscript): RedirectResponse
    {
        $request->validate([
            'reviewer_id' => 'required|exists:users,id',
            'due_date' => 'nullable|date',
        ]);

        $reviewer = User::findOrFail($request->input('reviewer_id'));
        $this->peerReviewService->inviteReviewer($manuscript, $reviewer, $request->user(), $request->input('due_date'));

        \App\Models\AppNotification::send(
            $reviewer->id,
            'New Peer Review Invitation',
            "You were invited to evaluate \"{$manuscript->title}\".",
            route('reviewer.dashboard'),
            'review',
            '🔍'
        );

        return back()->with('success', "Review invitation sent to {$reviewer->name}.");
    }
}
