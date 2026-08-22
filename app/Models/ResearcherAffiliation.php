<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ResearcherAffiliation extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'researcher_profile_id', 'institution', 'department',
        'position', 'country', 'start_date', 'end_date', 'is_current',
    ];

    protected function casts(): array
    {
        return [
            'start_date' => 'date',
            'end_date' => 'date',
            'is_current' => 'boolean',
        ];
    }

    public function profile(): BelongsTo
    {
        return $this->belongsTo(ResearcherProfile::class, 'researcher_profile_id');
    }
}
