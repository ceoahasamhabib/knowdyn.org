<?php

namespace App\Services;

use App\Models\Issue;
use App\Models\Journal;
use App\Models\Volume;
use Illuminate\Support\Facades\DB;

class VolumeIssueService
{
    /**
     * Create Volume for Journal
     */
    public function createVolume(Journal $journal, array $data): Volume
    {
        return $journal->volumes()->create($data);
    }

    /**
     * Update Volume
     */
    public function updateVolume(Volume $volume, array $data): Volume
    {
        $volume->update($data);
        return $volume->fresh();
    }

    /**
     * Delete Volume
     */
    public function deleteVolume(Volume $volume): bool
    {
        return $volume->delete();
    }

    /**
     * Create Issue for Volume
     */
    public function createIssue(Volume $volume, array $data): Issue
    {
        return DB::transaction(function () use ($volume, $data) {
            if (!empty($data['is_current'])) {
                // Remove current flag from other issues of this journal's volumes
                $journalId = $volume->journal_id;
                Issue::whereHas('volume', fn ($q) => $q->where('journal_id', $journalId))
                    ->update(['is_current' => false]);
            }

            return $volume->issues()->create($data);
        });
    }

    /**
     * Update Issue
     */
    public function updateIssue(Issue $issue, array $data): Issue
    {
        return DB::transaction(function () use ($issue, $data) {
            if (!empty($data['is_current']) && !$issue->is_current) {
                $journalId = $issue->volume->journal_id;
                Issue::whereHas('volume', fn ($q) => $q->where('journal_id', $journalId))
                    ->update(['is_current' => false]);
            }

            $issue->update($data);
            return $issue->fresh();
        });
    }

    /**
     * Delete Issue
     */
    public function deleteIssue(Issue $issue): bool
    {
        return $issue->delete();
    }

    /**
     * Set specific issue as current
     */
    public function setCurrentIssue(Issue $issue): Issue
    {
        return DB::transaction(function () use ($issue) {
            $journalId = $issue->volume->journal_id;

            Issue::whereHas('volume', fn ($q) => $q->where('journal_id', $journalId))
                ->update(['is_current' => false]);

            $issue->update(['is_current' => true, 'status' => 'published']);

            return $issue->fresh();
        });
    }
}
