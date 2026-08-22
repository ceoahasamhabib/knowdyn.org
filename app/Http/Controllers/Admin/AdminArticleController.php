<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreArticleRequest;
use App\Http\Requests\UpdateArticleRequest;
use App\Models\Article;
use App\Models\Journal;
use App\Models\Volume;
use App\Services\ArticleService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminArticleController extends Controller
{
    public function __construct(
        protected ArticleService $articleService
    ) {}

    /**
     * Admin Articles List
     */
    public function index(Request $request): Response
    {
        $search = $request->input('search');
        $journalId = $request->input('journal_id');
        $status = $request->input('status');

        $query = Article::with([
            'journal:id,title,short_title',
            'authors' => fn ($q) => $q->orderBy('sort_order'),
            'issues.volume',
        ])->orderByDesc('created_at');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('doi', 'like', "%{$search}%");
            });
        }

        if ($journalId) {
            $query->where('journal_id', $journalId);
        }

        if ($status) {
            $query->where('status', $status);
        }

        $articles = $query->paginate(15)->withQueryString();
        $journals = Journal::select('id', 'title', 'short_title')->get();

        return Inertia::render('Admin/Articles/Index', [
            'articles' => $articles,
            'journals' => $journals,
            'filters' => [
                'search' => $search,
                'journal_id' => $journalId,
                'status' => $status,
            ],
        ]);
    }

    /**
     * Show create article form
     */
    public function create(): Response
    {
        $journals = Journal::with(['volumes.issues'])->where('status', 'active')->get();

        return Inertia::render('Admin/Articles/Create', [
            'journals' => $journals,
        ]);
    }

    /**
     * Store new article
     */
    public function store(StoreArticleRequest $request): RedirectResponse
    {
        $validated = $request->validated();
        $authors = $validated['authors'] ?? [];
        $references = $validated['references'] ?? [];
        $keywords = $validated['keywords'] ?? [];
        $issueId = $validated['issue_id'] ?? null;

        unset($validated['authors'], $validated['references'], $validated['keywords'], $validated['issue_id']);

        $article = $this->articleService->createArticle($validated, $authors, $references, $keywords, $issueId);

        return redirect()->route('admin.articles.edit', $article->id)
            ->with('success', 'Article published successfully.');
    }

    /**
     * Show edit article form
     */
    public function edit(Article $article): Response
    {
        $article->load(['journal', 'authors', 'references', 'keywords', 'issues.volume', 'files']);
        $journals = Journal::with(['volumes.issues'])->get();

        return Inertia::render('Admin/Articles/Edit', [
            'article' => $article,
            'journals' => $journals,
        ]);
    }

    /**
     * Update article
     */
    public function update(UpdateArticleRequest $request, Article $article): RedirectResponse
    {
        $validated = $request->validated();
        $authors = $validated['authors'] ?? null;
        $references = $validated['references'] ?? null;
        $keywords = $validated['keywords'] ?? null;
        $issueId = $validated['issue_id'] ?? null;

        unset($validated['authors'], $validated['references'], $validated['keywords'], $validated['issue_id']);

        $this->articleService->updateArticle($article, $validated, $authors, $references, $keywords, $issueId);

        return back()->with('success', 'Article updated successfully.');
    }

    /**
     * Delete article
     */
    public function destroy(Article $article): RedirectResponse
    {
        $this->articleService->deleteArticle($article);

        return redirect()->route('admin.articles.index')
            ->with('success', 'Article deleted successfully.');
    }
}
