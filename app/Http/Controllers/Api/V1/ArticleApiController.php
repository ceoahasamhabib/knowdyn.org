<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Article;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ArticleApiController extends Controller
{
    /**
     * List all published articles with metadata
     */
    public function index(Request $request): JsonResponse
    {
        $query = Article::published()
            ->with([
                'journal:id,title,slug,short_title,issn_online',
                'authors' => fn ($q) => $q->orderBy('sort_order'),
                'keywords',
            ])
            ->orderByDesc('published_at');

        if ($request->has('journal')) {
            $query->whereHas('journal', fn ($q) => $q->where('slug', $request->query('journal')));
        }

        if ($request->has('search')) {
            $search = $request->query('search');
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('abstract', 'like', "%{$search}%")
                  ->orWhere('doi', 'like', "%{$search}%");
            });
        }

        $articles = $query->paginate(15);

        return response()->json([
            'status' => 'success',
            'data' => $articles,
        ]);
    }

    /**
     * Get specific published article with DOI and references
     */
    public function show(string $slug): JsonResponse
    {
        $article = Article::where('slug', $slug)
            ->where('status', 'published')
            ->with([
                'journal:id,title,slug,issn_online,publisher',
                'authors' => fn ($q) => $q->orderBy('sort_order'),
                'keywords',
                'references' => fn ($q) => $q->orderBy('sort_order'),
                'issues.volume',
            ])
            ->firstOrFail();

        return response()->json([
            'status' => 'success',
            'data' => $article,
        ]);
    }
}
