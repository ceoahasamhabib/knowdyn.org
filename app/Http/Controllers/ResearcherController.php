<?php

namespace App\Http\Controllers;

use App\Models\ResearcherProfile;
use App\Models\User;
use Inertia\Inertia;

class ResearcherController extends Controller
{
    /**
     * Public researcher directory
     */
    public function index()
    {
        $researchers = User::whereHas('researcherProfile', fn ($q) => $q->where('is_public', true))
            ->with(['researcherProfile', 'researcherProfile.interests', 'researcherProfile.affiliations' => fn ($q) => $q->where('is_current', true)])
            ->paginate(24);

        return Inertia::render('Public/Researchers/Index', [
            'researchers' => $researchers,
        ]);
    }

    /**
     * Public researcher profile: /researchers/{username}
     * Also handles /{username} route
     */
    public function show(string $username)
    {
        $user = User::where('username', $username)
            ->whereHas('researcherProfile', fn ($q) => $q->where('is_public', true))
            ->with([
                'researcherProfile',
                'researcherProfile.interests',
                'researcherProfile.affiliations',
            ])
            ->firstOrFail();

        return Inertia::render('Public/Researchers/Show', [
            'researcher' => $user,
        ]);
    }
}
