<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreManuscriptSubmissionRequest;
use App\Models\Journal;
use App\Services\ManuscriptSubmissionService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class ManuscriptSubmissionController extends Controller
{
    public function __construct(
        protected ManuscriptSubmissionService $submissionService
    ) {}

    /**
     * Public / Author Manuscript Submission Wizard (/submit)
     */
    public function create(Request $request): Response
    {
        $journals = Journal::where('status', 'active')
            ->with(['settings'])
            ->select('id', 'title', 'slug', 'short_title', 'issn_online')
            ->get();

        $selectedJournalSlug = $request->query('journal');
        $user = $request->user();

        return Inertia::render('Author/Submit', [
            'journals' => $journals,
            'initialJournalSlug' => $selectedJournalSlug,
            'user' => $user ? [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'affiliation' => $user->researcherProfile?->institution,
                'orcid' => $user->researcherProfile?->orcid,
                'country' => $user->researcherProfile?->country,
            ] : null,
        ]);
    }

    /**
     * Process Manuscript Submission
     */
    public function store(StoreManuscriptSubmissionRequest $request): RedirectResponse
    {
        $user = $request->user();
        $validated = $request->validated();

        $authors = $validated['authors'] ?? [];
        unset($validated['authors']);

        $files = [];
        if ($request->hasFile('manuscript_file')) {
            $files['manuscript'] = $request->file('manuscript_file');
        }
        if ($request->hasFile('supplementary_file')) {
            $files['supplementary'] = $request->file('supplementary_file');
        }

        $manuscript = $this->submissionService->submitNewManuscript($user, $validated, $authors, $files);

        // Dispatch real-time in-app notifications
        \App\Models\AppNotification::send(
            $user->id,
            'Manuscript Submitted Successfully',
            "Your manuscript \"{$manuscript->title}\" has been submitted (Ref: {$manuscript->tracking_code}).",
            route('author.submissions.show', $manuscript->id),
            'manuscript',
            '📝'
        );

        \App\Models\AppNotification::notifyAdmins(
            'New Manuscript Submission',
            "New manuscript \"{$manuscript->title}\" submitted by {$user->name}.",
            route('admin.manuscripts.show', $manuscript->id),
            'manuscript',
            '📝'
        );

        return redirect()->route('author.submissions.show', $manuscript->id)
            ->with('success', "Manuscript \"{$manuscript->title}\" submitted successfully for editorial screening.");
    }
}
