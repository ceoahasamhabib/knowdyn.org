<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\SoftDeletes;

class Journal extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'title', 'slug', 'short_title', 'description', 'aims_and_scope',
        'issn_print', 'issn_online', 'publisher', 'publication_frequency',
        'cover_image', 'thumbnail', 'contact_email', 'contact_phone',
        'website', 'status', 'is_open_access', 'established_year',
        'meta_title', 'meta_description', 'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'is_open_access' => 'boolean',
            'established_year' => 'integer',
            'sort_order' => 'integer',
        ];
    }

    public function settings(): HasOne
    {
        return $this->hasOne(JournalSettings::class);
    }

    public function editorialMembers(): HasMany
    {
        return $this->hasMany(JournalEditorialMember::class)->orderBy('sort_order');
    }

    public function volumes(): HasMany
    {
        return $this->hasMany(Volume::class)->orderByDesc('number');
    }

    public function articles(): HasMany
    {
        return $this->hasMany(Article::class);
    }

    public function manuscripts(): HasMany
    {
        return $this->hasMany(Manuscript::class);
    }

    public function currentIssue()
    {
        return $this->hasManyThrough(Issue::class, Volume::class)
            ->where('issues.is_current', true)
            ->first();
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
