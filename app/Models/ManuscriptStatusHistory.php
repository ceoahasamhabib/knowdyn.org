<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ManuscriptStatusHistory extends Model
{
    public $timestamps = false;
    const UPDATED_AT = null;

    protected $table = 'manuscript_status_history';

    protected $fillable = [
        'manuscript_id', 'user_id', 'from_status',
        'to_status', 'comment',
    ];

    protected function casts(): array
    {
        return [
            'created_at' => 'datetime',
        ];
    }

    public function manuscript(): BelongsTo
    {
        return $this->belongsTo(Manuscript::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
