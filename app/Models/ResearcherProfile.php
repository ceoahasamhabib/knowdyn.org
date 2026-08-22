<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ResearcherProfile extends Model
{
    protected $fillable = [
        'user_id', 'biography', 'institution', 'department',
        'country', 'city', 'orcid', 'google_scholar',
        'linkedin', 'website', 'research_gate', 'expertise',
        'is_public',
    ];

    protected function casts(): array
    {
        return [
            'is_public' => 'boolean',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function interests(): HasMany
    {
        return $this->hasMany(ResearcherInterest::class);
    }

    public function affiliations(): HasMany
    {
        return $this->hasMany(ResearcherAffiliation::class);
    }
}
