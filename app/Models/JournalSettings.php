<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class JournalSettings extends Model
{
    protected $fillable = [
        'journal_id', 'peer_review_process', 'publication_ethics',
        'author_guidelines', 'copyright_notice', 'privacy_statement',
        'author_fees', 'open_access_policy', 'archiving_policy',
        'plagiarism_policy', 'section_policies', 'journal_history',
        'review_model',
    ];

    public function journal(): BelongsTo
    {
        return $this->belongsTo(Journal::class);
    }
}
