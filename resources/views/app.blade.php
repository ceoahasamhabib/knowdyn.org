<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title inertia>{{ config('app.name', 'Knowledge Dynamics') }}</title>

        <!-- Google Fonts: Curated Sans & Editorial Serif Pairings -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Merriweather:ital,wght@0,300;0,400;0,700;1,400&family=Outfit:wght@400;500;600;700;800&family=Playfair+Display:ital,wght@0,500;0,600;0,700;0,800;1,400;1,600&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Roboto:wght@400;500;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">

        <!-- Global Theme Variable Definitions -->
        <style>
            :root {
                --theme-primary: {{ \App\Models\SiteSetting::get('theme_primary_color', '#0F2A4A') }};
                --theme-accent: {{ \App\Models\SiteSetting::get('theme_accent_color', '#BE123C') }};
                --theme-font-sans: '{{ \App\Models\SiteSetting::get('theme_font_sans', 'Inter') }}', sans-serif;
                --theme-font-heading: '{{ \App\Models\SiteSetting::get('theme_font_heading', 'Playfair Display') }}', Georgia, serif;
                --theme-radius: {{ \App\Models\SiteSetting::get('theme_border_radius', '12px') }};
            }

            body {
                font-family: var(--theme-font-sans);
            }

            .font-serif, h1, h2, h3, .font-heading {
                font-family: var(--theme-font-heading);
            }
        </style>

        <!-- Scripts -->
        @routes
        @vite(['resources/js/app.js', "resources/js/Pages/{$page['component']}.vue"])
        @inertiaHead
    </head>
    <body class="font-sans antialiased text-gray-800 bg-gray-50/50">
        @inertia
    </body>
</html>
