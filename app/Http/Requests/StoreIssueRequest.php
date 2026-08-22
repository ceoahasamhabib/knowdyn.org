<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreIssueRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() && $this->user()->can('manage journals');
    }

    public function rules(): array
    {
        return [
            'number' => 'required|string|max:50',
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string|max:2000',
            'cover_image' => 'nullable|string|max:1000',
            'published_at' => 'nullable|date',
            'is_current' => 'boolean',
            'status' => 'required|in:draft,published,archived',
            'sort_order' => 'integer',
        ];
    }
}
