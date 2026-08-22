<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Journal;
use App\Services\ArticleService;
use App\Services\CitationService;
use Illuminate\Http\Request;
use Illuminate\Http\Response as HttpResponse;
use Inertia\Inertia;
use Inertia\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;

class ArticleController extends Controller
{
    public function __construct(
        protected ArticleService $articleService,
        protected CitationService $citationService
    ) {}

    /**
     * Public Articles Repository (/articles)
     */
    public function index(Request $request): Response
    {
        $search = $request->input('search');
        $journalSlug = $request->input('journal');

        $articles = $this->articleService->getPublishedArticles($search, $journalSlug, 12);
        $journals = Journal::where('status', 'active')->select('id', 'title', 'slug', 'short_title')->get();

        return Inertia::render('Public/Articles/Index', [
            'articles' => $articles,
            'journals' => $journals,
            'filters' => [
                'search' => $search,
                'journal' => $journalSlug,
            ],
        ]);
    }

    /**
     * Public Article View (/articles/{article-slug})
     */
    public function show(string $slug): Response
    {
        $article = $this->articleService->getArticleBySlug($slug);

        // Generate citations
        $citations = [
            'apa' => $this->citationService->generateApa($article),
            'harvard' => $this->citationService->generateHarvard($article),
            'vancouver' => $this->citationService->generateVancouver($article),
            'bibtex' => $this->citationService->generateBibtex($article),
            'ris' => $this->citationService->generateRis($article),
        ];

        $googleScholarMeta = $this->citationService->getGoogleScholarMeta($article);

        return Inertia::render('Public/Articles/Show', [
            'article' => $article,
            'citations' => $citations,
            'scholarlyMeta' => $googleScholarMeta,
        ]);
    }

    /**
     * Export Citation File (bib, ris, txt)
     */
    public function exportCitation(string $slug, string $format)
    {
        $article = $this->articleService->getArticleBySlug($slug);

        switch (strtolower($format)) {
            case 'bibtex':
            case 'bib':
                $content = $this->citationService->generateBibtex($article);
                $filename = "{$article->slug}.bib";
                $mime = 'application/x-bibtex';
                break;
            case 'ris':
                $content = $this->citationService->generateRis($article);
                $filename = "{$article->slug}.ris";
                $mime = 'application/x-research-info-systems';
                break;
            case 'apa':
                $content = $this->citationService->generateApa($article);
                $filename = "{$article->slug}_apa.txt";
                $mime = 'text/plain';
                break;
            case 'vancouver':
                $content = $this->citationService->generateVancouver($article);
                $filename = "{$article->slug}_vancouver.txt";
                $mime = 'text/plain';
                break;
            default:
                $content = $this->citationService->generateApa($article);
                $filename = "{$article->slug}_citation.txt";
                $mime = 'text/plain';
        }

        return response($content, 200, [
            'Content-Type' => $mime,
            'Content-Disposition' => "attachment; filename=\"{$filename}\"",
        ]);
    }

    /**
     * Download Article PDF
     */
    public function downloadPdf(string $slug)
    {
        $article = $this->articleService->getArticleBySlug($slug);
        $this->articleService->incrementDownload($article);

        $primaryFile = $article->primaryFile();

        if ($primaryFile && file_exists(storage_path('app/' . $primaryFile->file_path))) {
            return response()->download(
                storage_path('app/' . $primaryFile->file_path),
                $primaryFile->file_name
            );
        }

        // If mock / sample without physical file, redirect to article view or return info
        return back()->with('info', 'Full PDF download initiated for scholarly publication: ' . $article->title);
    }
}
