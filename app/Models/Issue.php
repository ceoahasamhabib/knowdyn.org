<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Issue extends Model
{
    protected $fillable = [
        'volume_id', 'number', 'title', 'description',
        'cover_image', 'published_at', 'is_current', 'status', 'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'published_at' => 'date',
            'is_current' => 'boolean',
            'sort_order' => 'integer',
        ];
    }

    public function volume(): BelongsTo
    {
        return $this->belongsTo(Volume::class);
    }

    public function articles(): BelongsToMany
    {
        return $this->belongsToMany(Article::class, 'article_issue')
            ->withPivot('sort_order')
            ->orderByPivot('sort_order');
    }

    public function journal()
    {
        return $this->volume->journal ?? null;
    }
}
