<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreJournalRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() && $this->user()->can('manage journals');
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:500',
            'slug' => 'nullable|string|max:500|unique:journals,slug',
            'short_title' => 'nullable|string|max:100',
            'description' => 'nullable|string|max:5000',
            'aims_and_scope' => 'nullable|string|max:10000',
            'issn_print' => 'nullable|string|max:20',
            'issn_online' => 'nullable|string|max:20',
            'publisher' => 'nullable|string|max:255',
            'publication_frequency' => 'nullable|string|max:100',
            'cover_image' => 'nullable|string|max:1000',
            'thumbnail' => 'nullable|string|max:1000',
            'contact_email' => 'nullable|email|max:255',
            'contact_phone' => 'nullable|string|max:50',
            'website' => 'nullable|url|max:500',
            'status' => 'required|in:active,inactive,archived',
            'is_open_access' => 'boolean',
            'established_year' => 'nullable|integer|min:1900|max:' . (date('Y') + 1),
            'meta_title' => 'nullable|string|max:255',
            'meta_description' => 'nullable|string|max:1000',

            // Settings
            'settings' => 'nullable|array',
            'settings.review_model' => 'nullable|in:single_blind,double_blind,open_review',
            'settings.peer_review_process' => 'nullable|string|max:5000',
            'settings.publication_ethics' => 'nullable|string|max:5000',
            'settings.author_guidelines' => 'nullable|string|max:10000',
            'settings.copyright_notice' => 'nullable|string|max:5000',
            'settings.privacy_statement' => 'nullable|string|max:5000',
            'settings.author_fees' => 'nullable|string|max:2000',
            'settings.open_access_policy' => 'nullable|string|max:5000',
            'settings.archiving_policy' => 'nullable|string|max:5000',
            'settings.plagiarism_policy' => 'nullable|string|max:5000',
        ];
    }
}
