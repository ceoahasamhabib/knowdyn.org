<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GuidelinePage extends Model
{
    use HasFactory;

    protected $table = 'guidelines_pages';

    protected $fillable = [
        'key', 'title', 'content', 'meta_title', 'meta_description',
    ];
}
