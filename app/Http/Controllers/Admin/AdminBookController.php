<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Book;
use App\Models\BookProposal;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Inertia\Response;

class AdminBookController extends Controller
{
    public function index(Request $request): Response
    {
        $books = Book::orderBy('sort_order')
            ->orderByDesc('created_at')
            ->paginate(15);

        $pendingProposalsCount = BookProposal::where('status', 'pending')->count();

        return Inertia::render('Admin/Books/Index', [
            'books' => $books,
            'pendingProposalsCount' => $pendingProposalsCount,
        ]);
    }

    public function create(): Response
    {
        return Inertia::render('Admin/Books/Create');
    }

    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'author' => 'required|string|max:255',
            'isbn' => 'nullable|string|max:100',
            'year' => 'required|integer',
            'pages' => 'required|integer',
            'category' => 'required|string|max:255',
            'format' => 'required|string|max:100',
            'description' => 'nullable|string',
            'doi' => 'nullable|string|max:100',
            'is_open_access' => 'boolean',
            'sort_order' => 'integer',
        ]);

        $validated['slug'] = Str::slug($validated['title']) . '-' . rand(100, 999);

        Book::create($validated);

        return redirect()->route('admin.books.index')->with('success', 'Book monograph created successfully.');
    }

    public function edit(Book $book): Response
    {
        return Inertia::render('Admin/Books/Edit', [
            'book' => $book,
        ]);
    }

    public function update(Request $request, Book $book): RedirectResponse
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'author' => 'required|string|max:255',
            'isbn' => 'nullable|string|max:100',
            'year' => 'required|integer',
            'pages' => 'required|integer',
            'category' => 'required|string|max:255',
            'format' => 'required|string|max:100',
            'description' => 'nullable|string',
            'doi' => 'nullable|string|max:100',
            'is_open_access' => 'boolean',
            'sort_order' => 'integer',
        ]);

        $book->update($validated);

        return redirect()->route('admin.books.index')->with('success', 'Book monograph updated successfully.');
    }

    public function destroy(Book $book): RedirectResponse
    {
        $book->delete();

        return back()->with('success', 'Book monograph deleted.');
    }

    public function proposals(): Response
    {
        $proposals = BookProposal::orderByDesc('created_at')->paginate(15);

        return Inertia::render('Admin/Books/Proposals', [
            'proposals' => $proposals,
        ]);
    }

    public function updateProposalStatus(Request $request, BookProposal $proposal): RedirectResponse
    {
        $request->validate([
            'status' => 'required|in:pending,reviewed,accepted,declined',
            'notes' => 'nullable|string',
        ]);

        $proposal->update($request->only('status', 'notes'));

        return back()->with('success', 'Book proposal status updated.');
    }
}
