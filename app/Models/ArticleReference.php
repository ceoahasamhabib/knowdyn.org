<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ArticleReference extends Model
{
    public $timestamps = false;

    protected $fillable = ['article_id', 'reference_text', 'doi', 'sort_order'];

    public function article(): BelongsTo
    {
        return $this->belongsTo(Article::class);
    }
}
