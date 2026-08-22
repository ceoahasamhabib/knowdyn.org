<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Article extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'journal_id', 'title', 'slug', 'abstract', 'article_type',
        'doi', 'pages', 'submission_date', 'acceptance_date',
        'published_at', 'funding', 'conflict_of_interest',
        'ethics_statement', 'license', 'citation_info', 'status',
        'view_count', 'download_count', 'meta_title', 'meta_description',
    ];

    protected function casts(): array
    {
        return [
            'submission_date' => 'date',
            'acceptance_date' => 'date',
            'published_at' => 'datetime',
            'view_count' => 'integer',
            'download_count' => 'integer',
        ];
    }

    public function journal(): BelongsTo
    {
        return $this->belongsTo(Journal::class);
    }

    public function issues(): BelongsToMany
    {
        return $this->belongsToMany(Issue::class, 'article_issue')
            ->withPivot('sort_order');
    }

    public function authors(): HasMany
    {
        return $this->hasMany(ArticleAuthor::class)->orderBy('sort_order');
    }

    public function keywords(): BelongsToMany
    {
        return $this->belongsToMany(Keyword::class, 'article_keywords');
    }

    public function references(): HasMany
    {
        return $this->hasMany(ArticleReference::class)->orderBy('sort_order');
    }

    public function files(): HasMany
    {
        return $this->hasMany(ArticleFile::class);
    }

    public function primaryFile()
    {
        return $this->files()->where('is_primary', true)->first();
    }

    public function scopePublished($query)
    {
        return $query->where('status', 'published');
    }

    public function resolveRouteBinding($value, $field = null)
    {
        if ($field) {
            return $this->where($field, $value)->firstOrFail();
        }

        if (is_numeric($value)) {
            return $this->where('id', $value)->firstOrFail();
        }

        return $this->where('slug', $value)->firstOrFail();
    }
}
