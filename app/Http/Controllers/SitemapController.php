<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Book;
use App\Models\Journal;
use App\Models\NewsEvent;
use Illuminate\Http\Response;

class SitemapController extends Controller
{
    public function index(): Response
    {
        $baseUrl = config('app.url', 'https://kdpub.com');
        $baseUrl = rtrim($baseUrl, '/');

        $staticRoutes = [
            '',
            '/about',
            '/journals',
            '/books',
            '/proofreading',
            '/services',
            '/news',
            '/events',
            '/contact',
            '/guidelines/authors',
            '/guidelines/reviewers',
            '/guidelines/editorial-policies',
            '/publish/open-access',
            '/librarians/catalogue',
        ];

        $urls = [];

        // 1. Static Routes
        foreach ($staticRoutes as $route) {
            $urls[] = [
                'loc' => $baseUrl . $route,
                'lastmod' => date('Y-m-d'),
                'changefreq' => 'weekly',
                'priority' => ($route === '' ? '1.0' : '0.8'),
            ];
        }

        // 2. Journals
        try {
            $journals = Journal::where('is_active', true)->get();
            foreach ($journals as $journal) {
                $urls[] = [
                    'loc' => $baseUrl . '/journals/' . $journal->slug,
                    'lastmod' => $journal->updated_at ? $journal->updated_at->format('Y-m-d') : date('Y-m-d'),
                    'changefreq' => 'daily',
                    'priority' => '0.9',
                ];
                $urls[] = [
                    'loc' => $baseUrl . '/journals/' . $journal->slug . '/archive',
                    'lastmod' => $journal->updated_at ? $journal->updated_at->format('Y-m-d') : date('Y-m-d'),
                    'changefreq' => 'weekly',
                    'priority' => '0.7',
                ];
            }
        } catch (\Throwable $e) {
            // Ignore DB errors
        }

        // 3. Books
        try {
            $books = Book::where('status', 'published')->get();
            foreach ($books as $book) {
                $urls[] = [
                    'loc' => $baseUrl . '/books/' . $book->slug,
                    'lastmod' => $book->updated_at ? $book->updated_at->format('Y-m-d') : date('Y-m-d'),
                    'changefreq' => 'monthly',
                    'priority' => '0.8',
                ];
            }
        } catch (\Throwable $e) {
        }

        // 4. Articles
        try {
            $articles = Article::where('status', 'published')->get();
            foreach ($articles as $article) {
                $urls[] = [
                    'loc' => $baseUrl . '/articles/' . ($article->slug ?: $article->id),
                    'lastmod' => $article->updated_at ? $article->updated_at->format('Y-m-d') : date('Y-m-d'),
                    'changefreq' => 'monthly',
                    'priority' => '0.8',
                ];
            }
        } catch (\Throwable $e) {
        }

        // 5. News / Events
        try {
            $news = NewsEvent::where('status', 'published')->get();
            foreach ($news as $item) {
                $urls[] = [
                    'loc' => $baseUrl . '/news/' . $item->slug,
                    'lastmod' => $item->updated_at ? $item->updated_at->format('Y-m-d') : date('Y-m-d'),
                    'changefreq' => 'weekly',
                    'priority' => '0.6',
                ];
            }
        } catch (\Throwable $e) {
        }

        // Generate XML string
        $xml = '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
        $xml .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

        foreach ($urls as $u) {
            $xml .= "  <url>\n";
            $xml .= '    <loc>' . htmlspecialchars($u['loc']) . "</loc>\n";
            $xml .= '    <lastmod>' . $u['lastmod'] . "</lastmod>\n";
            $xml .= '    <changefreq>' . $u['changefreq'] . "</changefreq>\n";
            $xml .= '    <priority>' . $u['priority'] . "</priority>\n";
            $xml .= "  </url>\n";
        }

        $xml .= '</urlset>';

        return response($xml, 200, [
            'Content-Type' => 'application/xml',
        ]);
    }
}
