<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class WebmailMessage extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'email_account_request_id',
        'folder',
        'from_name',
        'from_email',
        'to_email',
        'cc_email',
        'subject',
        'body_html',
        'body_text',
        'is_read',
        'is_starred',
        'has_attachments',
        'sent_at',
    ];

    protected function casts(): array
    {
        return [
            'is_read' => 'boolean',
            'is_starred' => 'boolean',
            'has_attachments' => 'boolean',
            'sent_at' => 'datetime',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function emailAccount(): BelongsTo
    {
        return $this->belongsTo(EmailAccountRequest::class, 'email_account_request_id');
    }
}
