<?php

namespace App\Services;

use App\Models\Manuscript;
use App\Models\ManuscriptStatusHistory;
use App\Models\Review;
use App\Models\ReviewAssignment;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class PeerReviewService
{
    /**
     * Invite a reviewer to evaluate a manuscript
     */
    public function inviteReviewer(Manuscript $manuscript, User $reviewer, User $assignedBy, ?string $dueDate = null): ReviewAssignment
    {
        return DB::transaction(function () use ($manuscript, $reviewer, $assignedBy, $dueDate) {
            $assignment = ReviewAssignment::create([
                'manuscript_id' => $manuscript->id,
                'reviewer_id' => $reviewer->id,
                'assigned_by' => $assignedBy->id,
                'status' => 'pending',
                'due_date' => $dueDate ?: now()->addDays(21),
                'assigned_at' => now(),
            ]);

            // Update manuscript status to under_review if not already
            if ($manuscript->status !== 'under_review') {
                $fromStatus = $manuscript->status;
                $manuscript->update(['status' => 'under_review']);

                ManuscriptStatusHistory::create([
                    'manuscript_id' => $manuscript->id,
                    'user_id' => $assignedBy->id,
                    'from_status' => $fromStatus,
                    'to_status' => 'under_review',
                    'comment' => "Reviewer {$reviewer->name} invited for peer review.",
                    'created_at' => now(),
                ]);
            }

            return $assignment->load(['reviewer', 'manuscript']);
        });
    }

    /**
     * Reviewer responds to invitation (Accept or Decline)
     */
    public function respondToInvitation(ReviewAssignment $assignment, bool $accepted): ReviewAssignment
    {
        $status = $accepted ? 'accepted' : 'declined';

        $assignment->update([
            'status' => $status,
            'responded_at' => now(),
        ]);

        return $assignment;
    }

    /**
     * Submit completed peer review
     */
    public function submitReview(ReviewAssignment $assignment, array $data): Review
    {
        return DB::transaction(function () use ($assignment, $data) {
            $review = Review::updateOrCreate(
                ['review_assignment_id' => $assignment->id],
                [
                    'recommendation' => $data['recommendation'],
                    'comments_to_editor' => $data['comments_to_editor'] ?? null,
                    'comments_to_author' => $data['comments_to_author'] ?? null,
                    'quality_score' => $data['quality_score'] ?? 8,
                ]
            );

            $assignment->update([
                'status' => 'completed',
                'completed_at' => now(),
            ]);

            ManuscriptStatusHistory::create([
                'manuscript_id' => $assignment->manuscript_id,
                'user_id' => $assignment->reviewer_id,
                'from_status' => 'under_review',
                'to_status' => 'under_review',
                'comment' => "Peer review recommendation submitted: " . ucfirst(str_replace('_', ' ', $data['recommendation'])),
                'created_at' => now(),
            ]);

            return $review;
        });
    }

    /**
     * Get reviewer dashboard with invitations, active, and completed reviews
     */
    public function getReviewerDashboard(User $reviewer): array
    {
        $assignments = ReviewAssignment::where('reviewer_id', $reviewer->id)
            ->with([
                'manuscript.journal:id,title,short_title',
                'manuscript.files',
                'review',
            ])
            ->orderByDesc('assigned_at')
            ->get();

        return [
            'pending' => $assignments->where('status', 'pending')->values(),
            'active' => $assignments->where('status', 'accepted')->values(),
            'completed' => $assignments->where('status', 'completed')->values(),
            'declined' => $assignments->where('status', 'declined')->values(),
        ];
    }
}
