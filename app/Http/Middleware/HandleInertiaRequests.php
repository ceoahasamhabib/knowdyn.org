<?php

namespace App\Http\Middleware;

use App\Models\AppNotification;
use App\Models\SiteSetting;
use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        $theme = [
            'preset' => SiteSetting::get('theme_preset', 'oxford-navy'),
            'primary_color' => SiteSetting::get('theme_primary_color', '#0F2A4A'),
            'accent_color' => SiteSetting::get('theme_accent_color', '#BE123C'),
            'font_sans' => SiteSetting::get('theme_font_sans', 'Inter'),
            'font_heading' => SiteSetting::get('theme_font_heading', 'Playfair Display'),
            'border_radius' => SiteSetting::get('theme_border_radius', '12px'),
        ];

        $notifications = [
            'unread_count' => 0,
            'recent' => [],
        ];

        if ($user = $request->user()) {
            $notifications['unread_count'] = AppNotification::where('user_id', $user->id)
                ->where('is_read', false)
                ->count();

            $notifications['recent'] = AppNotification::where('user_id', $user->id)
                ->orderByDesc('created_at')
                ->limit(8)
                ->get();
        }

        return [
            ...parent::share($request),
            'auth' => [
                'user' => $request->user() ? $request->user()->load('roles') : null,
            ],
            'theme' => $theme,
            'notifications' => $notifications,
            'flash' => [
                'success' => $request->session()->get('success'),
                'error' => $request->session()->get('error'),
            ],
        ];
    }
}
