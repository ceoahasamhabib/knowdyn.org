<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Volume extends Model
{
    protected $fillable = [
        'journal_id', 'number', 'year', 'title', 'description',
    ];

    protected function casts(): array
    {
        return [
            'number' => 'integer',
            'year' => 'integer',
        ];
    }

    public function journal(): BelongsTo
    {
        return $this->belongsTo(Journal::class);
    }

    public function issues(): HasMany
    {
        return $this->hasMany(Issue::class)->orderByDesc('number');
    }
}
