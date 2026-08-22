<?php

namespace App\Services;

use App\Models\Journal;
use App\Models\JournalSettings;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Str;

class JournalService
{
    /**
     * Get published journals with optional search and filters
     */
    public function getPublishedJournals(?string $search = null, int $perPage = 12): LengthAwarePaginator
    {
        $query = Journal::where('status', 'active')
            ->with(['volumes' => function ($q) {
                $q->with(['issues' => function ($iq) {
                    $iq->where('status', 'published')->orderByDesc('published_at');
                }]);
            }])
            ->orderBy('sort_order')
            ->orderBy('title');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('short_title', 'like', "%{$search}%")
                  ->orWhere('issn_print', 'like', "%{$search}%")
                  ->orWhere('issn_online', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%");
            });
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Get single journal by slug with complete relationships for public view
     */
    public function getJournalBySlug(string $slug): Journal
    {
        return Journal::where('slug', $slug)
            ->where('status', 'active')
            ->with([
                'settings',
                'editorialMembers' => fn ($q) => $q->where('is_active', true)->orderBy('sort_order'),
                'volumes' => function ($q) {
                    $q->with(['issues' => function ($iq) {
                        $iq->where('status', 'published')
                           ->withCount('articles')
                           ->orderByDesc('number');
                    }])->orderByDesc('year')->orderByDesc('number');
                },
            ])
            ->firstOrFail();
    }

    /**
     * Get journal archive (volumes and issues)
     */
    public function getJournalArchive(Journal $journal): array
    {
        $volumes = $journal->volumes()
            ->with(['issues' => function ($q) {
                $q->where('status', 'published')
                  ->with(['articles' => function ($aq) {
                      $aq->where('status', 'published')
                         ->with(['authors'])
                         ->orderBy('id');
                  }])
                  ->withCount('articles')
                  ->orderByDesc('number');
            }])
            ->orderByDesc('year')
            ->orderByDesc('number')
            ->get();

        return [
            'journal' => $journal,
            'volumes' => $volumes,
            'total_volumes' => $volumes->count(),
            'total_issues' => $volumes->sum(fn ($v) => $v->issues->count()),
            'total_articles' => $volumes->sum(fn ($v) => $v->issues->sum('articles_count')),
        ];
    }

    /**
     * Create journal with settings
     */
    public function createJournal(array $journalData, array $settingsData = []): Journal
    {
        if (empty($journalData['slug'])) {
            $journalData['slug'] = Str::slug($journalData['title']);
        }

        $journal = Journal::create($journalData);

        // Create default or custom settings
        $journal->settings()->create(array_merge([
            'review_model' => 'double_blind',
            'peer_review_process' => 'All submitted manuscripts undergo a rigorous double-blind peer-review process.',
            'open_access_policy' => 'This journal provides immediate open access to its content on the principle that making research freely available to the public supports a greater global exchange of knowledge.',
            'copyright_notice' => 'Authors retain copyright and grant the journal right of first publication with the work simultaneously licensed under a Creative Commons Attribution (CC BY 4.0) License.',
        ], $settingsData));

        return $journal->load('settings');
    }

    /**
     * Update journal and settings
     */
    public function updateJournal(Journal $journal, array $journalData, array $settingsData = []): Journal
    {
        if (isset($journalData['title']) && empty($journalData['slug'])) {
            $journalData['slug'] = Str::slug($journalData['title']);
        }

        $journal->update($journalData);

        if (!empty($settingsData)) {
            $journal->settings()->updateOrCreate(
                ['journal_id' => $journal->id],
                $settingsData
            );
        }

        return $journal->fresh(['settings']);
    }

    /**
     * Soft delete journal
     */
    public function deleteJournal(Journal $journal): bool
    {
        return $journal->delete();
    }
}
