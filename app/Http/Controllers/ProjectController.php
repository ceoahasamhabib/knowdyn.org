<?php

namespace App\Http\Controllers;

use App\Models\Project;
use Inertia\Inertia;

class ProjectController extends Controller
{
    /**
     * Public project directory
     */
    public function index()
    {
        $projects = Project::where('is_public', true)
            ->with(['leadResearcher', 'members'])
            ->orderByDesc('created_at')
            ->paginate(20);

        return Inertia::render('Public/Projects/Index', [
            'projects' => $projects,
        ]);
    }

    /**
     * Public project detail: /projects/{slug}
     */
    public function show(Project $project)
    {
        abort_unless($project->is_public, 404);

        $project->load(['leadResearcher', 'members']);

        return Inertia::render('Public/Projects/Show', [
            'project' => $project,
        ]);
    }
}
