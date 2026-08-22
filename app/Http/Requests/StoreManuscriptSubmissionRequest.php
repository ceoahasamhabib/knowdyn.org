<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreManuscriptSubmissionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() !== null;
    }

    public function rules(): array
    {
        return [
            'journal_id' => 'required|exists:journals,id',
            'title' => 'required|string|max:1000',
            'abstract' => 'required|string|max:10000',
            'article_type' => 'required|string|max:50',
            'cover_letter' => 'nullable|string|max:5000',
            'funding' => 'nullable|string|max:5000',
            'conflict_of_interest' => 'nullable|string|max:5000',
            'ethics_statement' => 'nullable|string|max:5000',

            // Authors Array
            'authors' => 'required|array|min:1',
            'authors.*.first_name' => 'required|string|max:100',
            'authors.*.last_name' => 'required|string|max:100',
            'authors.*.email' => 'nullable|email|max:255',
            'authors.*.affiliation' => 'nullable|string|max:500',
            'authors.*.country' => 'nullable|string|max:100',
            'authors.*.orcid' => ['nullable', 'string', 'max:50', 'regex:/^\d{4}-\d{4}-\d{4}-\d{3}[\dX]$/'],
            'authors.*.is_corresponding' => 'boolean',
            'authors.*.sort_order' => 'integer',

            // Files (Optional or simulated if submitting via JSON)
            'manuscript_file' => 'nullable|file|mimes:pdf,doc,docx|max:20480',
            'supplementary_file' => 'nullable|file|max:20480',
        ];
    }
}
