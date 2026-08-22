<?php

namespace App\Services;

use App\Models\Article;

class CitationService
{
    /**
     * Format Authors string for APA / Harvard: "Lastname, F. M., & Lastname, A."
     */
    protected function formatAuthorList(Article $article, bool $ampersand = true): string
    {
        $authors = $article->authors;
        if ($authors->isEmpty()) {
            return 'Knowledge Dynamics Editorial Team';
        }

        $formatted = [];
        foreach ($authors as $author) {
            $initials = '';
            if ($author->first_name) {
                $parts = explode(' ', $author->first_name);
                foreach ($parts as $part) {
                    if ($part) {
                        $initials .= strtoupper($part[0]) . '. ';
                    }
                }
            }
            $formatted[] = trim("{$author->last_name}, " . trim($initials));
        }

        $count = count($formatted);
        if ($count === 1) {
            return $formatted[0];
        }

        if ($count === 2) {
            $joiner = $ampersand ? ' & ' : ' and ';
            return $formatted[0] . $joiner . $formatted[1];
        }

        $lastAuthor = array_pop($formatted);
        $joiner = $ampersand ? ', & ' : ', and ';
        return implode(', ', $formatted) . $joiner . $lastAuthor;
    }

    /**
     * Generate APA 7th Edition Citation
     */
    public function generateApa(Article $article): string
    {
        $authors = $this->formatAuthorList($article, true);
        $year = $article->published_at ? $article->published_at->format('Y') : date('Y');
        $journal = $article->journal->title ?? 'Knowledge Dynamics';
        $issue = $article->issues->first();
        $volNum = $issue?->volume?->number;
        $issueNum = $issue?->number;

        $volIssue = '';
        if ($volNum && $issueNum) {
            $volIssue = "{$volNum}({$issueNum})";
        } elseif ($volNum) {
            $volIssue = "{$volNum}";
        }

        $pages = $article->pages ? ", {$article->pages}" : '';
        $doi = $article->doi ? " https://doi.org/{$article->doi}" : '';

        return "{$authors} ({$year}). {$article->title}. {$journal}, {$volIssue}{$pages}.{$doi}";
    }

    /**
     * Generate Harvard Style Citation
     */
    public function generateHarvard(Article $article): string
    {
        $authors = $this->formatAuthorList($article, false);
        $year = $article->published_at ? $article->published_at->format('Y') : date('Y');
        $journal = $article->journal->title ?? 'Knowledge Dynamics';
        $issue = $article->issues->first();
        $volNum = $issue?->volume?->number;
        $issueNum = $issue?->number;

        $volIssue = '';
        if ($volNum && $issueNum) {
            $volIssue = ", {$volNum}({$issueNum})";
        }

        $pages = $article->pages ? ", pp. {$article->pages}" : '';
        $doi = $article->doi ? " Available at: https://doi.org/{$article->doi}" : '';

        return "{$authors}, {$year}. {$article->title}. {$journal}{$volIssue}{$pages}.{$doi}";
    }

    /**
     * Generate Vancouver Style Citation
     */
    public function generateVancouver(Article $article): string
    {
        $authors = [];
        foreach ($article->authors as $author) {
            $initials = '';
            if ($author->first_name) {
                $parts = explode(' ', $author->first_name);
                foreach ($parts as $part) {
                    if ($part) {
                        $initials .= strtoupper($part[0]);
                    }
                }
            }
            $authors[] = "{$author->last_name} {$initials}";
        }

        $authorsStr = count($authors) > 6
            ? implode(', ', array_slice($authors, 0, 6)) . ', et al'
            : implode(', ', $authors);

        if (empty($authorsStr)) {
            $authorsStr = 'Knowledge Dynamics';
        }

        $year = $article->published_at ? $article->published_at->format('Y') : date('Y');
        $journal = $article->journal->short_title ?? $article->journal->title ?? 'Know Dyn';
        $issue = $article->issues->first();
        $volNum = $issue?->volume?->number;
        $issueNum = $issue?->number;

        $volIssue = '';
        if ($volNum && $issueNum) {
            $volIssue = ";{$volNum}({$issueNum})";
        } elseif ($volNum) {
            $volIssue = ";{$volNum}";
        }

        $pages = $article->pages ? ":{$article->pages}" : '';
        $doi = $article->doi ? " doi:{$article->doi}" : '';

        return "{$authorsStr}. {$article->title}. {$journal}. {$year}{$volIssue}{$pages}.{$doi}";
    }

    /**
     * Generate BibTeX Citation
     */
    public function generateBibtex(Article $article): string
    {
        $firstAuthorLastName = $article->authors->first()?->last_name ?? 'KD';
        $year = $article->published_at ? $article->published_at->format('Y') : date('Y');
        $key = strtolower(preg_replace('/[^a-zA-Z0-9]/', '', $firstAuthorLastName)) . $year . '_' . substr($article->slug, 0, 8);

        $authorsList = [];
        foreach ($article->authors as $author) {
            $authorsList[] = "{$author->last_name}, {$author->first_name}";
        }
        $authorField = implode(' and ', $authorsList);

        $issue = $article->issues->first();
        $volume = $issue?->volume?->number ?? '';
        $number = $issue?->number ?? '';

        $bib = "@article{{$key},\n";
        $bib .= "  title = {{" . addslashes($article->title) . "}},\n";
        $bib .= "  author = {{$authorField}},\n";
        $bib .= "  journal = {{" . ($article->journal->title ?? 'Knowledge Dynamics') . "}},\n";
        if ($volume) $bib .= "  volume = {{$volume}},\n";
        if ($number) $bib .= "  number = {{$number}},\n";
        if ($article->pages) $bib .= "  pages = {{$article->pages}},\n";
        $bib .= "  year = {{$year}},\n";
        if ($article->doi) $bib .= "  doi = {{$article->doi}},\n";
        $bib .= "  publisher = {{" . ($article->journal->publisher ?? 'Knowledge Dynamics') . "}}\n";
        $bib .= "}";

        return $bib;
    }

    /**
     * Generate RIS Format (EndNote / Zotero / Mendeley)
     */
    public function generateRis(Article $article): string
    {
        $year = $article->published_at ? $article->published_at->format('Y/m/d') : date('Y/m/d');
        $issue = $article->issues->first();

        $ris = "TY  - JOUR\n";
        $ris .= "TI  - {$article->title}\n";

        foreach ($article->authors as $author) {
            $ris .= "AU  - {$author->last_name}, {$author->first_name}\n";
            if ($author->affiliation) {
                $ris .= "AD  - {$author->affiliation}\n";
            }
        }

        $ris .= "JO  - " . ($article->journal->title ?? 'Knowledge Dynamics') . "\n";
        if ($article->journal->issn_online) {
            $ris .= "SN  - {$article->journal->issn_online}\n";
        }
        if ($issue?->volume?->number) {
            $ris .= "VL  - {$issue->volume->number}\n";
        }
        if ($issue?->number) {
            $ris .= "IS  - {$issue->number}\n";
        }
        if ($article->pages) {
            $parts = explode('-', $article->pages);
            $ris .= "SP  - " . trim($parts[0]) . "\n";
            if (isset($parts[1])) {
                $ris .= "EP  - " . trim($parts[1]) . "\n";
            }
        }
        $ris .= "DA  - {$year}\n";
        $ris .= "PY  - " . ($article->published_at ? $article->published_at->format('Y') : date('Y')) . "\n";
        if ($article->abstract) {
            $ris .= "AB  - {$article->abstract}\n";
        }
        if ($article->doi) {
            $ris .= "DO  - {$article->doi}\n";
            $ris .= "UR  - https://doi.org/{$article->doi}\n";
        }
        $ris .= "ER  - \n";

        return $ris;
    }

    /**
     * Get Google Scholar Meta tags array for SEO
     */
    public function getGoogleScholarMeta(Article $article): array
    {
        $meta = [
            'citation_title' => $article->title,
            'citation_journal_title' => $article->journal->title ?? 'Knowledge Dynamics',
            'citation_publication_date' => $article->published_at ? $article->published_at->format('Y/m/d') : date('Y/m/d'),
        ];

        if ($article->journal->issn_online) {
            $meta['citation_issn'] = $article->journal->issn_online;
        }

        $issue = $article->issues->first();
        if ($issue?->volume?->number) {
            $meta['citation_volume'] = (string) $issue->volume->number;
        }
        if ($issue?->number) {
            $meta['citation_issue'] = (string) $issue->number;
        }
        if ($article->doi) {
            $meta['citation_doi'] = $article->doi;
        }
        if ($article->pages) {
            $parts = explode('-', $article->pages);
            $meta['citation_firstpage'] = trim($parts[0]);
            if (isset($parts[1])) {
                $meta['citation_lastpage'] = trim($parts[1]);
            }
        }

        $authors = [];
        foreach ($article->authors as $author) {
            $authors[] = [
                'name' => "{$author->last_name}, {$author->first_name}",
                'institution' => $author->affiliation,
                'orcid' => $author->orcid,
            ];
        }
        $meta['citation_authors'] = $authors;

        return $meta;
    }
}
