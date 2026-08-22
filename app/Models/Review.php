<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Review extends Model
{
    protected $fillable = [
        'review_assignment_id', 'recommendation',
        'comments_to_editor', 'comments_to_author', 'quality_score',
    ];

    protected function casts(): array
    {
        return [
            'quality_score' => 'integer',
        ];
    }

    public function assignment(): BelongsTo
    {
        return $this->belongsTo(ReviewAssignment::class, 'review_assignment_id');
    }
}
