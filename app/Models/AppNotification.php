<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AppNotification extends Model
{
    use HasFactory;

    protected $table = 'app_notifications';

    protected $fillable = [
        'user_id',
        'type',
        'title',
        'message',
        'link',
        'icon',
        'is_read',
        'read_at',
    ];

    protected $casts = [
        'is_read' => 'boolean',
        'read_at' => 'datetime',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Send notification to a specific user
     */
    public static function send(
        int $userId,
        string $title,
        string $message,
        ?string $link = null,
        string $type = 'system',
        string $icon = '🔔'
    ): self {
        return self::create([
            'user_id' => $userId,
            'title' => $title,
            'message' => $message,
            'link' => $link,
            'type' => $type,
            'icon' => $icon,
            'is_read' => false,
        ]);
    }

    /**
     * Notify all administrators and editors
     */
    public static function notifyAdmins(
        string $title,
        string $message,
        ?string $link = null,
        string $type = 'admin_alert',
        string $icon = '⚡'
    ): void {
        try {
            $existingRoles = \Spatie\Permission\Models\Role::whereIn('name', ['super-admin', 'admin', 'editor'])->pluck('name')->toArray();
            if (empty($existingRoles)) {
                return;
            }

            $admins = User::role($existingRoles)->get();

            foreach ($admins as $admin) {
                self::create([
                    'user_id' => $admin->id,
                    'title' => $title,
                    'message' => $message,
                    'link' => $link,
                    'type' => $type,
                    'icon' => $icon,
                    'is_read' => false,
                ]);
            }
        } catch (\Throwable $e) {
            // Silently bypass if roles table is not populated yet
        }
    }

    /**
     * Mark notification as read
     */
    public function markRead(): void
    {
        $this->update([
            'is_read' => true,
            'read_at' => now(),
        ]);
    }
}
