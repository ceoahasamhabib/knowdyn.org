<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateArticleRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() && $this->user()->can('manage articles');
    }

    public function rules(): array
    {
        $articleId = $this->route('article')?->id ?? $this->route('article');

        return [
            'journal_id' => 'required|exists:journals,id',
            'title' => 'required|string|max:1000',
            'slug' => 'nullable|string|max:1000|unique:articles,slug,' . $articleId,
            'abstract' => 'nullable|string|max:10000',
            'article_type' => 'required|string|max:50',
            'doi' => 'nullable|string|max:255|unique:articles,doi,' . $articleId,
            'pages' => 'nullable|string|max:50',
            'submission_date' => 'nullable|date',
            'acceptance_date' => 'nullable|date',
            'published_at' => 'nullable|date',
            'funding' => 'nullable|string|max:5000',
            'conflict_of_interest' => 'nullable|string|max:5000',
            'ethics_statement' => 'nullable|string|max:5000',
            'license' => 'nullable|string|max:100',
            'status' => 'required|in:draft,published,retracted',

            // Authors Array
            'authors' => 'nullable|array',
            'authors.*.first_name' => 'required|string|max:100',
            'authors.*.last_name' => 'required|string|max:100',
            'authors.*.email' => 'nullable|email|max:255',
            'authors.*.affiliation' => 'nullable|string|max:500',
            'authors.*.country' => 'nullable|string|max:100',
            'authors.*.orcid' => ['nullable', 'string', 'max:50', 'regex:/^\d{4}-\d{4}-\d{4}-\d{3}[\dX]$/'],
            'authors.*.is_corresponding' => 'boolean',
            'authors.*.sort_order' => 'integer',

            // Keywords Array
            'keywords' => 'nullable|array',
            'keywords.*' => 'string|max:100',

            // References Array
            'references' => 'nullable|array',
            'references.*' => 'nullable|string|max:2000',

            // Issue association
            'issue_id' => 'nullable|exists:issues,id',
        ];
    }
}
