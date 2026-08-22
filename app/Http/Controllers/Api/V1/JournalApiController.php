<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Journal;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class JournalApiController extends Controller
{
    /**
     * List all published journals
     */
    public function index(Request $request): JsonResponse
    {
        $journals = Journal::where('status', 'active')
            ->with(['settings'])
            ->select([
                'id', 'title', 'slug', 'short_title', 'description',
                'issn_print', 'issn_online', 'publisher', 'publication_frequency',
                'established_year', 'is_open_access'
            ])
            ->orderBy('sort_order')
            ->paginate(10);

        return response()->json([
            'status' => 'success',
            'data' => $journals,
        ]);
    }

    /**
     * Get specific journal with volumes, issues and board
     */
    public function show(string $slug): JsonResponse
    {
        $journal = Journal::where('slug', $slug)
            ->where('status', 'active')
            ->with([
                'settings',
                'editorialMembers' => fn ($q) => $q->where('is_active', true)->orderBy('sort_order'),
                'volumes.issues' => fn ($q) => $q->where('status', 'published')->orderByDesc('number'),
            ])
            ->firstOrFail();

        return response()->json([
            'status' => 'success',
            'data' => $journal,
        ]);
    }
}
