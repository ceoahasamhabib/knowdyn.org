<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class EmailAccountRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'requested_username',
        'domain',
        'full_email',
        'quota_mb',
        'status',
        'password_encrypted',
        'rejection_reason',
        'admin_notes',
        'cpanel_account_created_at',
    ];

    protected function casts(): array
    {
        return [
            'quota_mb' => 'integer',
            'cpanel_account_created_at' => 'datetime',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function messages(): HasMany
    {
        return $this->hasMany(WebmailMessage::class);
    }
}
