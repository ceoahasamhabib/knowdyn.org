<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\GuidelinePage;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminGuidelineController extends Controller
{
    public function index(): Response
    {
        $pages = GuidelinePage::orderBy('title')->get();

        return Inertia::render('Admin/Guidelines/Index', [
            'pages' => $pages,
        ]);
    }

    public function edit(GuidelinePage $guidelinePage): Response
    {
        return Inertia::render('Admin/Guidelines/Edit', [
            'page' => $guidelinePage,
        ]);
    }

    public function update(Request $request, GuidelinePage $guidelinePage): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'meta_title' => 'nullable|string|max:255',
            'meta_description' => 'nullable|string',
        ]);

        $guidelinePage->update($validated);

        return redirect()->route('admin.guidelines.index')->with('success', 'Guideline / Policy page updated successfully.');
    }
}
