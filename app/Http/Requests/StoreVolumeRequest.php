<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreVolumeRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user() && $this->user()->can('manage journals');
    }

    public function rules(): array
    {
        return [
            'number' => 'required|integer|min:1',
            'year' => 'required|integer|min:1900|max:' . (date('Y') + 5),
            'title' => 'nullable|string|max:255',
            'description' => 'nullable|string|max:2000',
        ];
    }
}
