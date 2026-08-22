<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ResearcherInterest extends Model
{
    public $timestamps = false;

    protected $fillable = ['researcher_profile_id', 'interest'];

    public function profile(): BelongsTo
    {
        return $this->belongsTo(ResearcherProfile::class, 'researcher_profile_id');
    }
}
