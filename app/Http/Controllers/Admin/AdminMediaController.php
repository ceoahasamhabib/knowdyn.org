<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\MediaFile;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;

class AdminMediaController extends Controller
{
    public function index(Request $request): Response|JsonResponse
    {
        $folder = $request->query('folder', 'all');
        $type = $request->query('type', 'all');
        $search = $request->query('q', '');
        $sort = $request->query('sort', 'latest');

        $query = MediaFile::query();

        if ($folder && $folder !== 'all') {
            $query->where('folder', $folder);
        }

        if ($type === 'image') {
            $query->where(function ($q) {
                $q->where('mime_type', 'like', 'image/%')
                  ->orWhere('file_name', 'like', '%.svg')
                  ->orWhere('file_name', 'like', '%.ico')
                  ->orWhere('file_name', 'like', '%.png')
                  ->orWhere('file_name', 'like', '%.jpg')
                  ->orWhere('file_name', 'like', '%.jpeg')
                  ->orWhere('file_name', 'like', '%.webp');
            });
        } elseif ($type === 'pdf') {
            $query->where('mime_type', 'application/pdf')
                  ->orWhere('file_name', 'like', '%.pdf');
        } elseif ($type === 'document') {
            $query->where('mime_type', 'not like', 'image/%');
        }

        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('file_name', 'like', "%{$search}%")
                  ->orWhere('alt_text', 'like', "%{$search}%");
            });
        }

        switch ($sort) {
            case 'oldest':
                $query->orderBy('created_at', 'asc');
                break;
            case 'name_asc':
                $query->orderBy('name', 'asc');
                break;
            case 'name_desc':
                $query->orderBy('name', 'desc');
                break;
            case 'size_desc':
                $query->orderBy('size', 'desc');
                break;
            case 'size_asc':
                $query->orderBy('size', 'asc');
                break;
            case 'latest':
            default:
                $query->orderBy('created_at', 'desc');
                break;
        }

        $files = $query->paginate(36)->withQueryString();

        // Calculate Overall Statistics
        $totalFiles = MediaFile::count();
        $totalBytes = MediaFile::sum('size');
        $imagesCount = MediaFile::where('mime_type', 'like', 'image/%')->count();
        $docsCount = MediaFile::where('mime_type', 'not like', 'image/%')->count();

        // Folder breakdown counts
        $folders = [
            'all' => $totalFiles,
            'branding' => MediaFile::where('folder', 'branding')->count(),
            'journals' => MediaFile::where('folder', 'journals')->count(),
            'books' => MediaFile::where('folder', 'books')->count(),
            'manuscripts' => MediaFile::where('folder', 'manuscripts')->count(),
            'general' => MediaFile::where('folder', 'general')->count(),
        ];

        $stats = [
            'total_files' => $totalFiles,
            'total_size' => $this->formatBytes($totalBytes),
            'images_count' => $imagesCount,
            'docs_count' => $docsCount,
            'folders' => $folders,
        ];

        if ($request->wantsJson() || $request->query('json') == 1) {
            return response()->json([
                'files' => $files,
                'stats' => $stats,
            ]);
        }

        return Inertia::render('Admin/Media/Index', [
            'files' => $files,
            'stats' => $stats,
            'filters' => [
                'folder' => $folder,
                'type' => $type,
                'q' => $search,
                'sort' => $sort,
            ],
        ]);
    }

    public function store(Request $request): RedirectResponse|JsonResponse
    {
        $request->validate([
            'files' => 'nullable|array',
            'files.*' => 'file|max:51200', // 50MB max per file
            'file' => 'nullable|file|max:51200',
            'folder' => 'nullable|string|max:50',
        ]);

        $uploadedFiles = [];
        $filesToProcess = [];

        if ($request->hasFile('files')) {
            $filesToProcess = $request->file('files');
        } elseif ($request->hasFile('file')) {
            $filesToProcess = [$request->file('file')];
        }

        $targetFolder = $request->input('folder', 'general');
        if (!in_array($targetFolder, ['branding', 'journals', 'books', 'manuscripts', 'general'])) {
            $targetFolder = 'general';
        }

        foreach ($filesToProcess as $file) {
            $origName = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
            $ext = strtolower($file->getClientOriginalExtension());
            $cleanName = preg_replace('/[^A-Za-z0-9_\-]/', '_', $origName);
            $fileName = $cleanName . '_' . time() . '_' . rand(100, 999) . '.' . $ext;

            $path = $file->storeAs($targetFolder, $fileName, 'public');
            $size = $file->getSize();
            $mime = $file->getMimeType();

            // Dimensions if image
            $dimensions = null;
            if (str_starts_with($mime, 'image/') && $ext !== 'svg') {
                $imageInfo = @getimagesize($file->getRealPath());
                if ($imageInfo) {
                    $dimensions = $imageInfo[0] . 'x' . $imageInfo[1];
                }
            }

            $mediaFile = MediaFile::create([
                'user_id' => $request->user()?->id,
                'name' => $file->getClientOriginalName(),
                'file_name' => $fileName,
                'disk' => 'public',
                'path' => $path,
                'mime_type' => $mime,
                'size' => $size,
                'folder' => $targetFolder,
                'dimensions' => $dimensions,
            ]);

            $uploadedFiles[] = $mediaFile;
        }

        if ($request->wantsJson() || $request->query('json') == 1) {
            return response()->json([
                'success' => true,
                'message' => count($uploadedFiles) . ' file(s) uploaded successfully.',
                'files' => $uploadedFiles,
            ]);
        }

        return back()->with('success', count($uploadedFiles) . ' file(s) uploaded successfully to Media Library.');
    }

    public function update(Request $request, MediaFile $media): RedirectResponse|JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'alt_text' => 'nullable|string|max:255',
            'folder' => 'nullable|string|max:50',
        ]);

        $media->update($validated);

        if ($request->wantsJson()) {
            return response()->json([
                'success' => true,
                'media' => $media,
            ]);
        }

        return back()->with('success', 'Media file information updated.');
    }

    public function destroy(MediaFile $media): RedirectResponse|JsonResponse
    {
        if (Storage::disk('public')->exists($media->path)) {
            Storage::disk('public')->delete($media->path);
        }

        $media->delete();

        return back()->with('success', 'File deleted from Media Library.');
    }

    public function bulkDestroy(Request $request): RedirectResponse|JsonResponse
    {
        $request->validate([
            'ids' => 'required|array',
            'ids.*' => 'exists:media_files,id',
        ]);

        $files = MediaFile::whereIn('id', $request->input('ids'))->get();

        foreach ($files as $f) {
            if (Storage::disk('public')->exists($f->path)) {
                Storage::disk('public')->delete($f->path);
            }
            $f->delete();
        }

        return back()->with('success', count($files) . ' files deleted permanently.');
    }

    protected function formatBytes(int $bytes): string
    {
        $units = ['B', 'KB', 'MB', 'GB', 'TB'];
        for ($i = 0; $bytes > 1024 && $i < count($units) - 1; $i++) {
            $bytes /= 1024;
        }
        return round($bytes, 2) . ' ' . $units[$i];
    }
}
