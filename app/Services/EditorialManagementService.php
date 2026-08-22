<?php

namespace App\Services;

use App\Models\Manuscript;
use App\Models\ManuscriptStatusHistory;
use App\Models\User;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class EditorialManagementService
{
    /**
     * Get paginated submissions for editorial queue
     */
    public function getSubmissionsList(?string $search = null, ?string $status = null, ?int $journalId = null, int $perPage = 15): LengthAwarePaginator
    {
        $query = Manuscript::with([
            'journal:id,title,short_title,slug',
            'submitter:id,name,email',
            'editor:id,name',
            'authors' => fn ($q) => $q->orderBy('sort_order'),
        ])->orderByDesc('created_at');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhereHas('authors', function ($aq) use ($search) {
                      $aq->where('first_name', 'like', "%{$search}%")
                         ->orWhere('last_name', 'like', "%{$search}%");
                  });
            });
        }

        if ($status) {
            $query->where('status', $status);
        }

        if ($journalId) {
            $query->where('journal_id', $journalId);
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Get full details of a manuscript for the editorial cockpit
     */
    public function getSubmissionDetails(int $id): Manuscript
    {
        return Manuscript::with([
            'journal.settings',
            'submitter:id,name,email',
            'editor:id,name,email',
            'authors' => fn ($q) => $q->orderBy('sort_order'),
            'files',
            'statusHistory.user:id,name',
            'reviewAssignments' => fn ($q) => $q->with(['reviewer:id,name,email', 'review']),
        ])->findOrFail($id);
    }

    /**
     * Pass initial screening
     */
    public function passScreening(Manuscript $manuscript, User $actor, ?string $comment = 'Manuscript passed initial editorial screening.'): Manuscript
    {
        return DB::transaction(function () use ($manuscript, $actor, $comment) {
            $fromStatus = $manuscript->status;
            $manuscript->update(['status' => 'screening']);

            ManuscriptStatusHistory::create([
                'manuscript_id' => $manuscript->id,
                'user_id' => $actor->id,
                'from_status' => $fromStatus,
                'to_status' => 'screening',
                'comment' => $comment,
                'created_at' => now(),
            ]);

            return $manuscript;
        });
    }

    /**
     * Assign handling editor
     */
    public function assignEditor(Manuscript $manuscript, User $editor, User $actor, ?string $comment = null): Manuscript
    {
        return DB::transaction(function () use ($manuscript, $editor, $actor, $comment) {
            $fromStatus = $manuscript->status;
            $manuscript->update([
                'editor_id' => $editor->id,
                'status' => 'editor_assigned',
            ]);

            ManuscriptStatusHistory::create([
                'manuscript_id' => $manuscript->id,
                'user_id' => $actor->id,
                'from_status' => $fromStatus,
                'to_status' => 'editor_assigned',
                'comment' => $comment ?: "Assigned handling editor: {$editor->name}.",
                'created_at' => now(),
            ]);

            return $manuscript->load('editor');
        });
    }

    /**
     * Make editorial decision (Accept, Reject, Minor Revision, Major Revision, Production, Published)
     */
    public function makeDecision(Manuscript $manuscript, string $decision, User $actor, ?string $comment = null): Manuscript
    {
        return DB::transaction(function () use ($manuscript, $decision, $actor, $comment) {
            $fromStatus = $manuscript->status;
            $updates = ['status' => $decision];

            if (in_array($decision, ['accepted', 'rejected'])) {
                $updates['decided_at'] = now();
            }

            $manuscript->update($updates);

            ManuscriptStatusHistory::create([
                'manuscript_id' => $manuscript->id,
                'user_id' => $actor->id,
                'from_status' => $fromStatus,
                'to_status' => $decision,
                'comment' => $comment ?: "Editorial decision recorded: " . ucfirst(str_replace('_', ' ', $decision)),
                'created_at' => now(),
            ]);

            return $manuscript;
        });
    }
}
