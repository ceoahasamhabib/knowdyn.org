<?php

namespace App\Http\Controllers\Reviewer;

use App\Http\Controllers\Controller;
use App\Models\ReviewAssignment;
use App\Services\PeerReviewService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class ReviewerDashboardController extends Controller
{
    public function __construct(
        protected PeerReviewService $peerReviewService
    ) {}

    /**
     * Reviewer Dashboard (/dashboard/reviews)
     */
    public function index(Request $request): Response
    {
        $dashboardData = $this->peerReviewService->getReviewerDashboard($request->user());

        return Inertia::render('Reviewer/Dashboard', [
            'assignments' => $dashboardData,
        ]);
    }

    /**
     * Respond to review invitation (Accept or Decline)
     */
    public function respond(Request $request, ReviewAssignment $assignment): RedirectResponse
    {
        // Authorization: only the assigned reviewer can respond
        if ($assignment->reviewer_id !== $request->user()->id) {
            abort(403, 'Unauthorized.');
        }

        $request->validate([
            'accept' => 'required|boolean',
        ]);

        $this->peerReviewService->respondToInvitation($assignment, $request->boolean('accept'));

        $statusMessage = $request->boolean('accept') ? 'Review invitation accepted.' : 'Review invitation declined.';

        return back()->with('success', $statusMessage);
    }

    /**
     * Show confidential review submission form
     */
    public function showReviewForm(Request $request, ReviewAssignment $assignment): Response
    {
        if ($assignment->reviewer_id !== $request->user()->id) {
            abort(403, 'Unauthorized.');
        }

        $assignment->load([
            'manuscript.journal.settings',
            'manuscript.files',
            'review',
        ]);

        return Inertia::render('Reviewer/ReviewForm', [
            'assignment' => $assignment,
        ]);
    }

    /**
     * Submit completed review
     */
    public function submitReview(Request $request, ReviewAssignment $assignment): RedirectResponse
    {
        if ($assignment->reviewer_id !== $request->user()->id) {
            abort(403, 'Unauthorized.');
        }

        $validated = $request->validate([
            'recommendation' => 'required|in:accept,minor_revision,major_revision,reject',
            'comments_to_author' => 'required|string|max:10000',
            'comments_to_editor' => 'nullable|string|max:5000',
            'quality_score' => 'nullable|integer|min:1|max:10',
        ]);

        $this->peerReviewService->submitReview($assignment, $validated);

        return redirect()->route('reviewer.dashboard')
            ->with('success', 'Peer review evaluation submitted successfully.');
    }
}
