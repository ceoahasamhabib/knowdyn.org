<?php

use App\Http\Controllers\Api\V1\ArticleApiController;
use App\Http\Controllers\Api\V1\JournalApiController;
use App\Http\Controllers\Api\V1\ResearcherApiController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Knowledge Dynamics REST API v1
|--------------------------------------------------------------------------
*/

Route::prefix('v1')->name('api.v1.')->group(function () {
    // Journals API
    Route::get('/journals', [JournalApiController::class, 'index'])->name('journals.index');
    Route::get('/journals/{slug}', [JournalApiController::class, 'show'])->name('journals.show');

    // Articles API
    Route::get('/articles', [ArticleApiController::class, 'index'])->name('articles.index');
    Route::get('/articles/{slug}', [ArticleApiController::class, 'show'])->name('articles.show');

    // Researchers API
    Route::get('/researchers', [ResearcherApiController::class, 'index'])->name('researchers.index');
    Route::get('/researchers/{username}', [ResearcherApiController::class, 'show'])->name('researchers.show');
});
