<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ManuscriptAuthor extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'manuscript_id', 'first_name', 'last_name',
        'email', 'affiliation', 'orcid',
        'is_corresponding', 'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'is_corresponding' => 'boolean',
            'sort_order' => 'integer',
        ];
    }

    public function manuscript(): BelongsTo
    {
        return $this->belongsTo(Manuscript::class);
    }

    public function getFullNameAttribute(): string
    {
        return trim("{$this->first_name} {$this->last_name}");
    }
}
