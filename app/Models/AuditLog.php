<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditLog extends Model
{
    public $timestamps = false;
    const UPDATED_AT = null;

    protected $fillable = [
        'user_id', 'action', 'auditable_type', 'auditable_id',
        'old_values', 'new_values', 'ip_address', 'user_agent',
    ];

    protected function casts(): array
    {
        return [
            'old_values' => 'array',
            'new_values' => 'array',
            'created_at' => 'datetime',
        ];
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function auditable()
    {
        return $this->morphTo();
    }

    /**
     * Record an audit log entry.
     */
    public static function record(
        string $action,
        mixed $model = null,
        ?array $oldValues = null,
        ?array $newValues = null,
    ): ?self {
        try {
            $auditableType = null;
            $auditableId = null;

            if ($model instanceof Model) {
                $auditableType = get_class($model);
                $auditableId = $model->getKey();
            } elseif (is_string($model)) {
                $auditableType = $model;
            }

            return self::create([
                'user_id' => auth()->id(),
                'action' => $action,
                'auditable_type' => $auditableType,
                'auditable_id' => $auditableId,
                'old_values' => $oldValues,
                'new_values' => $newValues,
                'ip_address' => request()->ip(),
                'user_agent' => request()->userAgent(),
            ]);
        } catch (\Throwable $e) {
            return null;
        }
    }
}
