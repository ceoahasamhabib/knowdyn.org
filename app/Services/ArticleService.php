<?php

namespace App\Services;

use App\Models\Article;
use App\Models\ArticleAuthor;
use App\Models\ArticleReference;
use App\Models\Issue;
use App\Models\Journal;
use App\Models\Keyword;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class ArticleService
{
    /**
     * Get published articles with filters and search
     */
    public function getPublishedArticles(?string $search = null, ?string $journalSlug = null, int $perPage = 12): LengthAwarePaginator
    {
        $query = Article::published()
            ->with([
                'journal:id,title,slug,short_title,issn_online',
                'authors' => fn ($q) => $q->orderBy('sort_order'),
                'issues' => fn ($q) => $q->with('volume:id,number,year')->orderByDesc('number'),
                'keywords',
            ])
            ->orderByDesc('published_at');

        if ($journalSlug) {
            $query->whereHas('journal', fn ($q) => $q->where('slug', $journalSlug));
        }

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('abstract', 'like', "%{$search}%")
                  ->orWhere('doi', 'like', "%{$search}%")
                  ->orWhereHas('authors', function ($aq) use ($search) {
                      $aq->where('first_name', 'like', "%{$search}%")
                         ->orWhere('last_name', 'like', "%{$search}%")
                         ->orWhere('affiliation', 'like', "%{$search}%");
                  })
                  ->orWhereHas('keywords', function ($kq) use ($search) {
                      $kq->where('name', 'like', "%{$search}%");
                  });
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Get single article for public view and track views
     */
    public function getArticleBySlug(string $slug): Article
    {
        $article = Article::where('slug', $slug)
            ->where('status', 'published')
            ->with([
                'journal:id,title,slug,short_title,issn_online,issn_print,publisher',
                'authors' => fn ($q) => $q->orderBy('sort_order'),
                'issues' => fn ($q) => $q->with('volume:id,number,year')->orderByDesc('number'),
                'keywords',
                'references' => fn ($q) => $q->orderBy('sort_order'),
                'files',
            ])
            ->firstOrFail();

        // Increment view count quietly
        $article->increment('view_count');

        return $article;
    }

    /**
     * Create new article with authors, references, keywords and issue attachment
     */
    public function createArticle(array $data, array $authors = [], array $references = [], array $keywords = [], ?int $issueId = null): Article
    {
        return DB::transaction(function () use ($data, $authors, $references, $keywords, $issueId) {
            if (empty($data['slug'])) {
                $data['slug'] = Str::slug($data['title']);
            }

            if (empty($data['license'])) {
                $data['license'] = 'CC BY 4.0';
            }

            $article = Article::create($data);

            // Authors
            foreach ($authors as $index => $authorData) {
                $authorData['sort_order'] = $authorData['sort_order'] ?? ($index + 1);
                $article->authors()->create($authorData);
            }

            // References
            foreach ($references as $index => $refText) {
                if (is_array($refText)) {
                    $refText['sort_order'] = $index + 1;
                    $article->references()->create($refText);
                } elseif (is_string($refText) && trim($refText)) {
                    $article->references()->create([
                        'reference_text' => trim($refText),
                        'sort_order' => $index + 1,
                    ]);
                }
            }

            // Keywords
            if (!empty($keywords)) {
                $keywordIds = [];
                foreach ($keywords as $kw) {
                    $kwName = trim($kw);
                    if ($kwName) {
                        $keywordModel = Keyword::firstOrCreate(
                            ['slug' => Str::slug($kwName)],
                            ['name' => $kwName]
                        );
                        $keywordIds[] = $keywordModel->id;
                    }
                }
                $article->keywords()->sync($keywordIds);
            }

            // Attach to Issue
            if ($issueId) {
                $article->issues()->sync([$issueId => ['sort_order' => 1]]);
            }

            return $article->load(['authors', 'references', 'keywords', 'issues.volume']);
        });
    }

    /**
     * Update existing article
     */
    public function updateArticle(Article $article, array $data, ?array $authors = null, ?array $references = null, ?array $keywords = null, ?int $issueId = null): Article
    {
        return DB::transaction(function () use ($article, $data, $authors, $references, $keywords, $issueId) {
            if (isset($data['title']) && empty($data['slug'])) {
                $data['slug'] = Str::slug($data['title']);
            }

            $article->update($data);

            // Authors sync if provided
            if ($authors !== null) {
                $article->authors()->delete();
                foreach ($authors as $index => $authorData) {
                    $authorData['sort_order'] = $authorData['sort_order'] ?? ($index + 1);
                    $article->authors()->create($authorData);
                }
            }

            // References sync if provided
            if ($references !== null) {
                $article->references()->delete();
                foreach ($references as $index => $refText) {
                    if (is_array($refText)) {
                        $refText['sort_order'] = $index + 1;
                        $article->references()->create($refText);
                    } elseif (is_string($refText) && trim($refText)) {
                        $article->references()->create([
                            'reference_text' => trim($refText),
                            'sort_order' => $index + 1,
                        ]);
                    }
                }
            }

            // Keywords sync if provided
            if ($keywords !== null) {
                $keywordIds = [];
                foreach ($keywords as $kw) {
                    $kwName = trim($kw);
                    if ($kwName) {
                        $keywordModel = Keyword::firstOrCreate(
                            ['slug' => Str::slug($kwName)],
                            ['name' => $kwName]
                        );
                        $keywordIds[] = $keywordModel->id;
                    }
                }
                $article->keywords()->sync($keywordIds);
            }

            // Issue sync
            if ($issueId !== null) {
                if ($issueId > 0) {
                    $article->issues()->sync([$issueId => ['sort_order' => 1]]);
                } else {
                    $article->issues()->detach();
                }
            }

            return $article->fresh(['authors', 'references', 'keywords', 'issues.volume']);
        });
    }

    /**
     * Delete article
     */
    public function deleteArticle(Article $article): bool
    {
        return $article->delete();
    }

    /**
     * Increment download count
     */
    public function incrementDownload(Article $article): void
    {
        $article->increment('download_count');
    }
}
