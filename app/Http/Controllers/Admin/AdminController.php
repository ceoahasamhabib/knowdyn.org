<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Article;
use App\Models\AuditLog;
use App\Models\Journal;
use App\Models\Manuscript;
use App\Models\ResearcherProfile;
use App\Models\Review;
use App\Models\ServiceRequest;
use App\Models\User;
use Inertia\Inertia;

class AdminController extends Controller
{
    public function dashboard()
    {
        $stats = [
            'users' => User::count(),
            'journals' => Journal::count(),
            'articles' => Article::count(),
            'manuscripts' => Manuscript::count(),
            'reviews' => Review::count(),
            'researchers' => ResearcherProfile::count(),
            'serviceRequests' => ServiceRequest::count(),
            'recentLogs' => AuditLog::with('user')
                ->latest('created_at')
                ->take(10)
                ->get()
                ->map(fn ($log) => [
                    'id' => $log->id,
                    'action' => ($log->user?->name ?? 'System') . ' — ' . $log->action,
                    'created_at' => $log->created_at?->diffForHumans(),
                ]),
        ];

        return Inertia::render('Admin/Dashboard', [
            'stats' => $stats,
        ]);
    }
}
