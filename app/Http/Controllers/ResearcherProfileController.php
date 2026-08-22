<?php

namespace App\Http\Controllers;

use App\Models\ResearcherAffiliation;
use App\Models\ResearcherInterest;
use App\Models\ResearcherProfile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ResearcherProfileController extends Controller
{
    /**
     * Show researcher profile edit/dashboard
     */
    public function edit()
    {
        $user = Auth::user();
        $profile = $user->researcherProfile ?? $user->researcherProfile()->create(['is_public' => true]);
        $profile->load(['interests', 'affiliations']);

        return Inertia::render('Researcher/ProfileEdit', [
            'profile' => $profile,
            'user' => $user,
        ]);
    }

    /**
     * Update researcher profile
     */
    public function update(Request $request)
    {
        $user = Auth::user();

        // Validate user fields
        $userData = $request->validate([
            'first_name' => 'nullable|string|max:255',
            'last_name' => 'nullable|string|max:255',
            'username' => [
                'required', 'string', 'max:50', 'alpha_dash:ascii',
                'unique:users,username,' . $user->id,
                function ($attribute, $value, $fail) {
                    if (in_array(strtolower($value), \App\Models\User::$reservedUsernames)) {
                        $fail('This username is reserved.');
                    }
                },
            ],
        ]);

        // Validate profile fields
        $profileData = $request->validate([
            'biography' => 'nullable|string|max:5000',
            'institution' => 'nullable|string|max:500',
            'department' => 'nullable|string|max:255',
            'country' => 'nullable|string|max:100',
            'city' => 'nullable|string|max:100',
            'orcid' => ['nullable', 'string', 'max:50', 'regex:/^\d{4}-\d{4}-\d{4}-\d{3}[\dX]$/'],
            'google_scholar' => 'nullable|url|max:500',
            'linkedin' => 'nullable|url|max:500',
            'website' => 'nullable|url|max:500',
            'research_gate' => 'nullable|url|max:500',
            'expertise' => 'nullable|string|max:2000',
            'is_public' => 'boolean',
        ]);

        $user->update($userData);

        $profile = $user->researcherProfile ?? $user->researcherProfile()->create([]);
        $profile->update($profileData);

        return back()->with('success', 'Profile updated successfully.');
    }

    /**
     * Update research interests
     */
    public function updateInterests(Request $request)
    {
        $request->validate([
            'interests' => 'array|max:20',
            'interests.*' => 'string|max:255',
        ]);

        $user = Auth::user();
        $profile = $user->researcherProfile;

        if (!$profile) {
            return back()->withErrors(['profile' => 'Please create your profile first.']);
        }

        // Sync interests — delete old, insert new
        $profile->interests()->delete();

        foreach ($request->interests as $interest) {
            if (trim($interest)) {
                $profile->interests()->create(['interest' => trim($interest)]);
            }
        }

        return back()->with('success', 'Research interests updated.');
    }

    /**
     * Add affiliation
     */
    public function addAffiliation(Request $request)
    {
        $data = $request->validate([
            'institution' => 'required|string|max:500',
            'department' => 'nullable|string|max:255',
            'position' => 'nullable|string|max:255',
            'country' => 'nullable|string|max:100',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'is_current' => 'boolean',
        ]);

        $user = Auth::user();
        $profile = $user->researcherProfile;

        if (!$profile) {
            return back()->withErrors(['profile' => 'Please create your profile first.']);
        }

        $profile->affiliations()->create($data);

        return back()->with('success', 'Affiliation added.');
    }

    /**
     * Remove affiliation
     */
    public function removeAffiliation(ResearcherAffiliation $affiliation)
    {
        $user = Auth::user();

        if ($affiliation->researcher_profile_id !== $user->researcherProfile?->id) {
            abort(403);
        }

        $affiliation->delete();

        return back()->with('success', 'Affiliation removed.');
    }
}
