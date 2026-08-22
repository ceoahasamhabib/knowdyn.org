<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookProposal extends Model
{
    use HasFactory;

    protected $fillable = [
        'author_name', 'author_email', 'institution',
        'book_title', 'subject_discipline', 'estimated_word_count',
        'target_completion_date', 'synopsis_and_toc', 'status', 'notes',
    ];
}
