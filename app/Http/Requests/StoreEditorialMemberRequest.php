<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreEditorialMemberRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() && $this->user()->can('manage journals');
    }

    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|max:255',
            'institution' => 'nullable|string|max:500',
            'country' => 'nullable|string|max:100',
            'role' => 'required|string|max:100',
            'biography' => 'nullable|string|max:3000',
            'orcid' => ['nullable', 'string', 'max:50', 'regex:/^\d{4}-\d{4}-\d{4}-\d{3}[\dX]$/'],
            'sort_order' => 'nullable|integer|min:0',
            'is_active' => 'boolean',
        ];
    }
}
