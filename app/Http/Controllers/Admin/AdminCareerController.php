<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Career;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Inertia\Response;

class AdminCareerController extends Controller
{
    public function index(): Response
    {
        $careers = Career::orderByDesc('created_at')->paginate(15);

        return Inertia::render('Admin/Careers/Index', [
            'careers' => $careers,
        ]);
    }

    public function create(): Response
    {
        return Inertia::render('Admin/Careers/Create');
    }

    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'department' => 'required|string|max:255',
            'type' => 'required|string|max:100',
            'summary' => 'required|string',
            'requirements' => 'nullable|string',
            'is_active' => 'boolean',
            'deadline' => 'nullable|string|max:100',
        ]);

        $validated['slug'] = Str::slug($validated['title']) . '-' . rand(100, 999);

        Career::create($validated);

        return redirect()->route('admin.careers.index')->with('success', 'Career opportunity posted successfully.');
    }

    public function edit(Career $career): Response
    {
        return Inertia::render('Admin/Careers/Edit', [
            'career' => $career,
        ]);
    }

    public function update(Request $request, Career $career): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'department' => 'required|string|max:255',
            'type' => 'required|string|max:100',
            'summary' => 'required|string',
            'requirements' => 'nullable|string',
            'is_active' => 'boolean',
            'deadline' => 'nullable|string|max:100',
        ]);

        $career->update($validated);

        return redirect()->route('admin.careers.index')->with('success', 'Career opportunity updated successfully.');
    }

    public function destroy(Career $career): RedirectResponse
    {
        $career->delete();

        return back()->with('success', 'Career opening deleted.');
    }
}
