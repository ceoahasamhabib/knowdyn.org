<?php

namespace App\Services;

use App\Models\Manuscript;
use App\Models\ManuscriptAuthor;
use App\Models\ManuscriptFile;
use App\Models\ManuscriptStatusHistory;
use App\Models\User;
use Illuminate\Http\UploadedFile;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ManuscriptSubmissionService
{
    /**
     * Create and submit a manuscript
     */
    public function submitNewManuscript(User $user, array $data, array $authors = [], array $files = []): Manuscript
    {
        return DB::transaction(function () use ($user, $data, $authors, $files) {
            $data['user_id'] = $user->id;
            $data['status'] = 'submitted';
            $data['submitted_at'] = now();

            $manuscript = Manuscript::create($data);

            // Record initial status history
            ManuscriptStatusHistory::create([
                'manuscript_id' => $manuscript->id,
                'user_id' => $user->id,
                'from_status' => null,
                'to_status' => 'submitted',
                'comment' => 'Initial manuscript submission completed by author.',
                'created_at' => now(),
            ]);

            // Add Authors
            if (empty($authors)) {
                // Default author is the submitting user
                $nameParts = explode(' ', $user->name, 2);
                $manuscript->authors()->create([
                    'first_name' => $nameParts[0],
                    'last_name' => $nameParts[1] ?? '',
                    'email' => $user->email,
                    'affiliation' => $user->researcherProfile?->institution ?? 'Academic Institute',
                    'orcid' => $user->researcherProfile?->orcid,
                    'is_corresponding' => true,
                    'sort_order' => 1,
                ]);
            } else {
                foreach ($authors as $index => $authorData) {
                    $authorData['sort_order'] = $authorData['sort_order'] ?? ($index + 1);
                    $manuscript->authors()->create($authorData);
                }
            }

            // Handle Files Upload
            foreach ($files as $type => $uploadedFile) {
                if ($uploadedFile instanceof UploadedFile) {
                    $this->storeManuscriptFile($manuscript, $uploadedFile, $type);
                }
            }

            return $manuscript->load(['journal', 'authors', 'files', 'statusHistory']);
        });
    }

    /**
     * Store a confidential manuscript file in private storage
     */
    public function storeManuscriptFile(Manuscript $manuscript, UploadedFile $file, string $type = 'manuscript'): ManuscriptFile
    {
        $path = $file->store("manuscripts/{$manuscript->id}", 'local');

        return $manuscript->files()->create([
            'file_path' => $path,
            'file_name' => $file->getClientOriginalName(),
            'file_type' => $type,
            'file_size' => $file->getSize(),
            'version' => 1,
        ]);
    }

    /**
     * Get paginated submissions for a specific author
     */
    public function getUserSubmissions(User $user, int $perPage = 10): LengthAwarePaginator
    {
        return Manuscript::where('user_id', $user->id)
            ->with(['journal:id,title,slug,short_title', 'authors'])
            ->orderByDesc('created_at')
            ->paginate($perPage);
    }

    /**
     * Get single submission for an author with authorization check
     */
    public function getUserSubmissionById(User $user, int $id): Manuscript
    {
        return Manuscript::where('id', $id)
            ->where('user_id', $user->id)
            ->with([
                'journal:id,title,slug,short_title',
                'authors' => fn ($q) => $q->orderBy('sort_order'),
                'files',
                'statusHistory.user:id,name',
            ])
            ->firstOrFail();
    }
}
