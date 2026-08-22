<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <title inertia>{{ config('app.name', 'Knowledge Dynamics') }}</title>

        <!-- ── Favicon & App Icons ──────────────────────────── -->
        <link rel="icon" type="image/svg+xml" href="{{ asset('favicon.svg') }}">
        <link rel="alternate icon" type="image/x-icon" href="{{ asset('favicon.ico') }}">
        <link rel="apple-touch-icon" sizes="180x180" href="{{ asset('apple-touch-icon.png') }}">
        <link rel="manifest" href="{{ asset('site.webmanifest') }}">
        <meta name="theme-color" content="#070c18">
        <meta name="msapplication-TileColor" content="#070c18">

        <!-- ── Canonical & Search Engine Crawling ───────────── -->
        <link rel="canonical" href="{{ url()->current() }}">
        <meta name="robots" content="{{ \App\Models\SiteSetting::get('seo_robots', 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1') }}">
        <meta name="description" content="{{ \App\Models\SiteSetting::get('seo_meta_description', 'Knowledge Dynamics is an international academic publisher for peer-reviewed open access journals, books, scholar profiles, and editorial proofreading services.') }}">
        <meta name="keywords" content="{{ \App\Models\SiteSetting::get('seo_meta_keywords', 'academic publishing, open access journals, peer review, crossref doi, proofreading, research papers, knowledge dynamics, kdpub, medical journals, health dynamics') }}">
        <meta name="author" content="{{ \App\Models\SiteSetting::get('publisher_name', 'Knowledge Dynamics Publishing') }}">

        <!-- ── Search Engine Webmaster Verification ─────────── -->
        @php
            $googleVerification = \App\Models\SiteSetting::get('seo_google_verification');
            $bingVerification = \App\Models\SiteSetting::get('seo_bing_verification');
            $siteName = \App\Models\SiteSetting::get('site_name', 'Knowledge Dynamics');
            $metaDesc = \App\Models\SiteSetting::get('seo_meta_description', 'Elevating global research with open access peer-reviewed journals, Crossref DOI allocation, and academic proofreading.');
            $ogImage = \App\Models\SiteSetting::get('seo_og_image', asset('apple-touch-icon.png'));
            $twitterHandle = \App\Models\SiteSetting::get('seo_twitter_handle', '@kdpub');
            $gaId = \App\Models\SiteSetting::get('seo_google_analytics_id');
            $customHeadScripts = \App\Models\SiteSetting::get('seo_custom_head_scripts', '');
            $contactEmail = \App\Models\SiteSetting::get('contact_email', 'editor@kdpub.com');
            $publisherName = \App\Models\SiteSetting::get('publisher_name', 'Knowledge Dynamics Publishing');

            $schemaData = [
                '@context' => 'https://schema.org',
                '@type' => 'ResearchOrganization',
                'name' => $siteName,
                'alternateName' => 'KD Scholar',
                'url' => url('/'),
                'logo' => asset('favicon.svg'),
                'description' => $metaDesc,
                'email' => $contactEmail,
                'publishingPrinciples' => url('/publish/open-access'),
                'sameAs' => [
                    'https://twitter.com/kdpub',
                    'https://facebook.com/kdpub',
                ],
            ];
        @endphp

        @if(!empty($googleVerification))
            <meta name="google-site-verification" content="{{ $googleVerification }}">
        @endif
        @if(!empty($bingVerification))
            <meta name="msvalidate.01" content="{{ $bingVerification }}">
        @endif

        <!-- ── Open Graph / Social Sharing ───────────────────── -->
        <meta property="og:site_name" content="{{ $siteName }}">
        <meta property="og:type" content="website">
        <meta property="og:url" content="{{ url()->current() }}">
        <meta property="og:title" content="{{ $siteName }} — Global Open Access Academic Publishing">
        <meta property="og:description" content="{{ $metaDesc }}">
        <meta property="og:image" content="{{ $ogImage }}">

        <!-- ── Twitter Card Metadata ────────────────────────── -->
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:site" content="{{ $twitterHandle }}">
        <meta name="twitter:creator" content="{{ $twitterHandle }}">
        <meta name="twitter:title" content="{{ $siteName }} — Global Open Access Academic Publishing">
        <meta name="twitter:description" content="{{ $metaDesc }}">
        <meta name="twitter:image" content="{{ $ogImage }}">

        <!-- ── Schema.org Scholarly Research Organization JSON-LD ── -->
        <script type="application/ld+json">
        {!! json_encode($schemaData, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT) !!}
        </script>

        <!-- ── Google Analytics 4 (GA4) ──────────────────────── -->
        @if(!empty($gaId))
            <script async src="https://www.googletagmanager.com/gtag/js?id={{ $gaId }}"></script>
            <script>
                window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', '{{ $gaId }}');
            </script>
        @endif

        <!-- ── Custom Head Scripts (Injected from Admin Settings) ── -->
        @if(!empty($customHeadScripts))
            {!! $customHeadScripts !!}
        @endif

        <!-- ── Google Fonts ──────────────────────────────────── -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Merriweather:ital,wght@0,300;0,400;0,700;1,400&family=Outfit:wght@400;500;600;700;800&family=Playfair+Display:ital,wght@0,500;0,600;0,700;0,800;1,400;1,600&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Roboto:wght@400;500;700&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">

        <!-- ── Global Dynamic Theme CSS Variables ────────────── -->
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
