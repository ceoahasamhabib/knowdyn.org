<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\SiteSetting;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;
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
        $request->validate([
            'brand_logo' => 'nullable|file|mimes:svg,png,jpg,jpeg,webp|max:4096',
            'brand_logo_dark' => 'nullable|file|mimes:svg,png,jpg,jpeg,webp|max:4096',
            'brand_favicon' => 'nullable|file|mimes:svg,png,ico,jpg,jpeg,webp|max:2048',
            'seo_og_image' => 'nullable|file|mimes:png,jpg,jpeg,webp,svg|max:4096',
        ]);

        $data = $request->input('settings', []);

        // Ensure branding directory exists
        if (!Storage::disk('public')->exists('branding')) {
            Storage::disk('public')->makeDirectory('branding');
        }

        // 1. Handle Primary Logo Upload
        if ($request->hasFile('brand_logo')) {
            $file = $request->file('brand_logo');
            $filename = 'logo_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('branding', $filename, 'public');
            $data['brand_logo'] = '/storage/' . $path;
        } elseif ($request->boolean('remove_brand_logo')) {
            $data['brand_logo'] = '';
        }

        // 2. Handle Dark Mode / Inverted Logo Upload
        if ($request->hasFile('brand_logo_dark')) {
            $file = $request->file('brand_logo_dark');
            $filename = 'logo_dark_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('branding', $filename, 'public');
            $data['brand_logo_dark'] = '/storage/' . $path;
        } elseif ($request->boolean('remove_brand_logo_dark')) {
            $data['brand_logo_dark'] = '';
        }

        // 3. Handle Favicon Upload
        if ($request->hasFile('brand_favicon')) {
            $file = $request->file('brand_favicon');
            $ext = strtolower($file->getClientOriginalExtension());
            $filename = 'favicon_' . time() . '.' . $ext;
            $path = $file->storeAs('branding', $filename, 'public');
            $data['brand_favicon'] = '/storage/' . $path;

            // Also synchronize root public/favicon.svg / public/favicon.ico if applicable
            try {
                if ($ext === 'svg') {
                    File::copy($file->getRealPath(), public_path('favicon.svg'));
                } elseif ($ext === 'ico') {
                    File::copy($file->getRealPath(), public_path('favicon.ico'));
                } elseif (in_array($ext, ['png', 'jpg', 'webp'])) {
                    File::copy($file->getRealPath(), public_path('apple-touch-icon.png'));
                }
            } catch (\Throwable $e) {
                // Ignore file copy failures on restricted permissions
            }
        } elseif ($request->boolean('remove_brand_favicon')) {
            $data['brand_favicon'] = '/favicon.svg';
        }

        // 4. Handle OpenGraph Social Share Image Upload
        if ($request->hasFile('seo_og_image')) {
            $file = $request->file('seo_og_image');
            $filename = 'og_cover_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('branding', $filename, 'public');
            $data['seo_og_image'] = '/storage/' . $path;
        }

        // Save all key-values to SiteSetting
        foreach ($data as $key => $value) {
            SiteSetting::updateOrCreate(
                ['key' => $key],
                [
                    'value' => $value ?? '',
                    'group' => $this->inferGroup($key),
                ]
            );
        }

        return back()->with('success', 'System, Brand Logos, SEO Engine & Theme settings updated successfully.');
    }

    protected function inferGroup(string $key): string
    {
        if (str_starts_with($key, 'theme_')) return 'theme';
        if (str_starts_with($key, 'seo_')) return 'seo';
        if (str_starts_with($key, 'doi_')) return 'doi';
        if (str_starts_with($key, 'brand_')) return 'branding';
        if (str_starts_with($key, 'cpanel_')) return 'cpanel';
        return 'general';
    }
}
