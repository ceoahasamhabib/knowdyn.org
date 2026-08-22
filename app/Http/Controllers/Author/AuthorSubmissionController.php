<?php

namespace App\Http\Controllers\Author;

use App\Http\Controllers\Controller;
use App\Services\ManuscriptSubmissionService;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AuthorSubmissionController extends Controller
{
    public function __construct(
        protected ManuscriptSubmissionService $submissionService
    ) {}

    /**
     * Author Submissions List (/dashboard/submissions)
     */
    public function index(Request $request): Response
    {
        $user = $request->user();
        $submissions = $this->submissionService->getUserSubmissions($user, 10);

        return Inertia::render('Author/Submissions/Index', [
            'submissions' => $submissions,
        ]);
    }

    /**
     * Author Submission Tracker & Details (/dashboard/submissions/{id})
     */
    public function show(Request $request, int $id): Response
    {
        $user = $request->user();
        $manuscript = $this->submissionService->getUserSubmissionById($user, $id);

        return Inertia::render('Author/Submissions/Show', [
            'manuscript' => $manuscript,
        ]);
    }
}
