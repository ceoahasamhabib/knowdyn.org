<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    use HasFactory;

    protected $fillable = [
        'title', 'slug', 'author', 'isbn', 'year',
        'pages', 'category', 'format', 'description',
        'doi', 'is_open_access', 'cover_image', 'file_path', 'sort_order',
    ];

    protected function casts(): array
    {
        return [
            'is_open_access' => 'boolean',
            'year' => 'integer',
            'pages' => 'integer',
            'sort_order' => 'integer',
        ];
    }

    public function getRouteKeyName(): string
    {
        return 'slug';
    }
}
