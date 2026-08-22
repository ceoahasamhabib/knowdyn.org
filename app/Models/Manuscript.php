<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class Manuscript extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'journal_id', 'user_id', 'title', 'abstract', 'article_type',
        'status', 'editor_id', 'article_id', 'funding',
        'conflict_of_interest', 'ethics_statement', 'cover_letter',
        'submitted_at', 'decided_at',
    ];

    protected function casts(): array
    {
        return [
            'submitted_at' => 'datetime',
            'decided_at' => 'datetime',
        ];
    }

    public function journal(): BelongsTo
    {
        return $this->belongsTo(Journal::class);
    }

    public function submitter(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function editor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'editor_id');
    }

    public function article(): BelongsTo
    {
        return $this->belongsTo(Article::class);
    }

    public function authors(): HasMany
    {
        return $this->hasMany(ManuscriptAuthor::class)->orderBy('sort_order');
    }

    public function files(): HasMany
    {
        return $this->hasMany(ManuscriptFile::class);
    }

    public function statusHistory(): HasMany
    {
        return $this->hasMany(ManuscriptStatusHistory::class)->orderByDesc('created_at');
    }

    public function reviewAssignments(): HasMany
    {
        return $this->hasMany(ReviewAssignment::class);
    }
}
