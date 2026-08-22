<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\SiteSetting;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminSettingController extends Controller
{
    public function index(): Response
    {
        $settings = SiteSetting::orderBy('group')->orderBy('key')->get();

        return Inertia::render('Admin/Settings/Index', [
            'settings' => $settings,
        ]);
    }

    public function update(Request $request): RedirectResponse
    {
        $data = $request->input('settings', []);

        foreach ($data as $key => $value) {
            SiteSetting::updateOrCreate(
                ['key' => $key],
                [
                    'value' => $value,
                    'group' => $this->inferGroup($key),
                ]
            );
        }

        return back()->with('success', 'System, SEO, Theme & Scholarly settings updated successfully.');
    }

    protected function inferGroup(string $key): string
    {
        if (str_starts_with($key, 'theme_')) return 'theme';
        if (str_starts_with($key, 'seo_')) return 'seo';
        if (str_starts_with($key, 'doi_')) return 'doi';
        if (str_starts_with($key, 'cpanel_')) return 'cpanel';
        return 'general';
    }
}
