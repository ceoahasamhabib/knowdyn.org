<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\ResearcherProfile;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ResearcherApiController extends Controller
{
    /**
     * List public researcher profiles
     */
    public function index(Request $request): JsonResponse
    {
        $researchers = ResearcherProfile::where('is_public', true)
            ->with(['user:id,name,username', 'interests'])
            ->paginate(15);

        return response()->json([
            'status' => 'success',
            'data' => $researchers,
        ]);
    }

    /**
     * Get specific researcher profile by username
     */
    public function show(string $username): JsonResponse
    {
        $user = User::where('username', $username)
            ->with([
                'researcherProfile' => fn ($q) => $q->where('is_public', true),
                'researcherProfile.interests',
                'researcherProfile.affiliations',
                'projects' => fn ($q) => $q->where('is_public', true),
            ])
            ->firstOrFail();

        return response()->json([
            'status' => 'success',
            'data' => [
                'name' => $user->name,
                'username' => $user->username,
                'profile' => $user->researcherProfile,
                'affiliations' => $user->researcherProfile?->affiliations,
                'projects' => $user->projects,
            ],
        ]);
    }
}
