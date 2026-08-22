<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ArticleAuthor extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'article_id', 'user_id', 'first_name', 'last_name',
        'email', 'affiliation', 'country', 'orcid',
        'is_corresponding', 'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'is_corresponding' => 'boolean',
            'sort_order' => 'integer',
        ];
    }

    public function article(): BelongsTo
    {
        return $this->belongsTo(Article::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function getFullNameAttribute(): string
    {
        return trim("{$this->first_name} {$this->last_name}");
    }
}
