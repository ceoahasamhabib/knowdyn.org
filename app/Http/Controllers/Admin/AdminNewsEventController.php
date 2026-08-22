<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\NewsEvent;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Inertia\Response;

class AdminNewsEventController extends Controller
{
    public function index(Request $request): Response
    {
        $type = $request->query('type');
        $query = NewsEvent::orderByDesc('created_at');

        if ($type) {
            $query->where('type', $type);
        }

        $items = $query->paginate(15)->withQueryString();

        return Inertia::render('Admin/NewsEvents/Index', [
            'items' => $items,
            'filters' => ['type' => $type],
        ]);
    }

    public function create(): Response
    {
        return Inertia::render('Admin/NewsEvents/Create');
    }

    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'type' => 'required|in:news,event,announcement,workshop',
            'category' => 'nullable|string|max:100',
            'summary' => 'required|string',
            'content' => 'nullable|string',
            'event_date' => 'nullable|string|max:100',
            'location' => 'nullable|string|max:255',
            'registration_url' => 'nullable|url|max:500',
            'deadline' => 'nullable|string|max:100',
            'is_featured' => 'boolean',
            'is_published' => 'boolean',
        ]);

        $validated['slug'] = Str::slug($validated['title']) . '-' . rand(100, 999);

        NewsEvent::create($validated);

        return redirect()->route('admin.news_events.index')->with('success', 'News/Event item published successfully.');
    }

    public function edit(NewsEvent $newsEvent): Response
    {
        return Inertia::render('Admin/NewsEvents/Edit', [
            'item' => $newsEvent,
        ]);
    }

    public function update(Request $request, NewsEvent $newsEvent): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'type' => 'required|in:news,event,announcement,workshop',
            'category' => 'nullable|string|max:100',
            'summary' => 'required|string',
            'content' => 'nullable|string',
            'event_date' => 'nullable|string|max:100',
            'location' => 'nullable|string|max:255',
            'registration_url' => 'nullable|url|max:500',
            'deadline' => 'nullable|string|max:100',
            'is_featured' => 'boolean',
            'is_published' => 'boolean',
        ]);

        $newsEvent->update($validated);

        return redirect()->route('admin.news_events.index')->with('success', 'News/Event item updated successfully.');
    }

    public function destroy(NewsEvent $newsEvent): RedirectResponse
    {
        $newsEvent->delete();

        return back()->with('success', 'News/Event item deleted.');
    }
}
