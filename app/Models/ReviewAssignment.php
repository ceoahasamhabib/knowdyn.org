<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class ReviewAssignment extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'manuscript_id', 'reviewer_id', 'assigned_by',
        'status', 'due_date', 'assigned_at',
        'responded_at', 'completed_at',
    ];

    protected function casts(): array
    {
        return [
            'due_date' => 'date',
            'assigned_at' => 'datetime',
            'responded_at' => 'datetime',
            'completed_at' => 'datetime',
        ];
    }

    public function manuscript(): BelongsTo
    {
        return $this->belongsTo(Manuscript::class);
    }

    public function reviewer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'reviewer_id');
    }

    public function assignedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'assigned_by');
    }

    public function review(): HasOne
    {
        return $this->hasOne(Review::class);
    }
}
