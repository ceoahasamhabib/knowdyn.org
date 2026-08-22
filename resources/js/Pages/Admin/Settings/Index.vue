<script setup>
import { ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';

const props = defineProps({
    settings: {
        type: Array,
        default: () => [],
    },
});

const initialSettingsMap = {};
props.settings.forEach(s => {
    initialSettingsMap[s.key] = s.value || '';
});

// Set sensible defaults if empty
if (!initialSettingsMap.theme_preset) initialSettingsMap.theme_preset = 'oxford-navy';
if (!initialSettingsMap.theme_primary_color) initialSettingsMap.theme_primary_color = '#0F2A4A';
if (!initialSettingsMap.theme_accent_color) initialSettingsMap.theme_accent_color = '#BE123C';
if (!initialSettingsMap.theme_font_sans) initialSettingsMap.theme_font_sans = 'Inter';
if (!initialSettingsMap.theme_font_heading) initialSettingsMap.theme_font_heading = 'Playfair Display';
if (!initialSettingsMap.theme_border_radius) initialSettingsMap.theme_border_radius = '12px';

if (!initialSettingsMap.site_name) initialSettingsMap.site_name = 'Knowledge Dynamics';
if (!initialSettingsMap.publisher_name) initialSettingsMap.publisher_name = 'Knowledge Dynamics Publishing';
if (!initialSettingsMap.doi_prefix) initialSettingsMap.doi_prefix = '10.69598';
if (!initialSettingsMap.contact_email) initialSettingsMap.contact_email = 'editor@kdpub.com';

// SEO Defaults
if (!initialSettingsMap.seo_meta_description) {
    initialSettingsMap.seo_meta_description = 'Knowledge Dynamics is an international academic publisher for peer-reviewed open access journals, books, scholar profiles, and editorial proofreading services.';
}
if (!initialSettingsMap.seo_meta_keywords) {
    initialSettingsMap.seo_meta_keywords = 'academic publishing, open access journals, peer review, crossref doi, proofreading, research papers, knowledge dynamics, kdpub, health dynamics';
}
if (!initialSettingsMap.seo_robots) initialSettingsMap.seo_robots = 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1';
if (!initialSettingsMap.seo_twitter_handle) initialSettingsMap.seo_twitter_handle = '@kdpub';
if (!initialSettingsMap.seo_og_image) initialSettingsMap.seo_og_image = '/apple-touch-icon.png';

const form = useForm({
    settings: initialSettingsMap,
});

const activeTab = ref('theme');

const themePresets = [
    {
        id: 'oxford-navy',
        name: 'Oxford Navy & Crimson',
        desc: 'Scholarly Luxury & Academic Authority',
        primary: '#0F2A4A',
        accent: '#BE123C',
        sans: 'Inter',
        heading: 'Playfair Display',
    },
    {
        id: 'royal-indigo',
        name: 'Royal Indigo SaaS',
        desc: 'Modern Tech, Data Science & Analytics',
        primary: '#312E81',
        accent: '#4F46E5',
        sans: 'Plus Jakarta Sans',
        heading: 'Plus Jakarta Sans',
    },
    {
        id: 'emerald-bio',
        name: 'BioScience Emerald & Teal',
        desc: 'Life Sciences, Medicine & Nature Style',
        primary: '#064E3B',
        accent: '#0D9488',
        sans: 'Outfit',
        heading: 'Merriweather',
    },
    {
        id: 'midnight-obsidian',
        name: 'Midnight Obsidian & Amber',
        desc: 'High-Contrast Executive Academic Dark',
        primary: '#0F172A',
        accent: '#D97706',
        sans: 'Inter',
        heading: 'Playfair Display',
    },
    {
        id: 'burgundy-heritage',
        name: 'Burgundy Heritage & Rose',
        desc: 'Classical University Press & Humanities',
        primary: '#4C0519',
        accent: '#E11D48',
        sans: 'Inter',
        heading: 'Merriweather',
    },
];

const applyPreset = (preset) => {
    form.settings.theme_preset = preset.id;
    form.settings.theme_primary_color = preset.primary;
    form.settings.theme_accent_color = preset.accent;
    form.settings.theme_font_sans = preset.sans;
    form.settings.theme_font_heading = preset.heading;
};

const submit = () => {
    form.post(route('admin.settings.update'));
};
</script>

<template>
    <Head title="System, SEO & Branding Settings — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900 flex items-center gap-2">
                        <span>⚙️</span> System, SEO & Branding Settings
                    </h1>
                    <p class="text-xs text-gray-500">Live customization of brand identity, SEO meta engine, Google verification, GA4 analytics, and Crossref DOI.</p>
                </div>

                <!-- Navigation Tabs -->
                <div class="flex items-center gap-2 bg-gray-100 p-1 rounded-xl">
                    <button
                        type="button"
                        @click="activeTab = 'theme'"
                        class="px-3.5 py-1.5 rounded-lg text-xs font-bold transition"
                        :class="activeTab === 'theme' ? 'bg-white text-navy-900 shadow-sm' : 'text-gray-600 hover:text-gray-900'"
                    >
                        🎨 Theme & Typography
                    </button>
                    <button
                        type="button"
                        @click="activeTab = 'seo'"
                        class="px-3.5 py-1.5 rounded-lg text-xs font-bold transition flex items-center gap-1"
                        :class="activeTab === 'seo' ? 'bg-white text-indigo-700 shadow-sm' : 'text-gray-600 hover:text-gray-900'"
                    >
                        <span>🔍</span> SEO & Webmaster
                    </button>
                    <button
                        type="button"
                        @click="activeTab = 'branding'"
                        class="px-3.5 py-1.5 rounded-lg text-xs font-bold transition"
                        :class="activeTab === 'branding' ? 'bg-white text-navy-900 shadow-sm' : 'text-gray-600 hover:text-gray-900'"
                    >
                        🏛️ Identity & DOI
                    </button>
                </div>
            </div>
        </template>

        <div class="max-w-5xl mx-auto space-y-8">
            <form @submit.prevent="submit" class="space-y-8">
                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 1: THEME & TYPOGRAPHY                                   -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'theme'" class="space-y-8">
                    <!-- Global Brand Theme & Color Presets -->
                    <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-gray-100 pb-3 flex items-center justify-between">
                            <div>
                                <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                                    🎨 Global Brand Theme & Color Presets
                                </h2>
                                <p class="text-xs text-gray-500">Choose a curated luxury palette or define custom brand HEX colors.</p>
                            </div>
                            <span class="text-[11px] font-mono font-semibold bg-navy-50 text-navy-800 px-2.5 py-0.5 rounded-full border border-navy-200">
                                Active: {{ form.settings.theme_preset }}
                            </span>
                        </div>

                        <!-- Preset Cards Grid -->
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div
                                v-for="p in themePresets"
                                :key="p.id"
                                @click="applyPreset(p)"
                                class="p-4 rounded-xl border cursor-pointer transition-all duration-200 relative overflow-hidden"
                                :class="form.settings.theme_preset === p.id ? 'border-navy-700 bg-navy-50/40 ring-2 ring-navy-700 shadow-sm' : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50/50'"
                            >
                                <div class="flex items-center justify-between mb-2">
                                    <span class="font-bold text-xs text-gray-900">{{ p.name }}</span>
                                    <div class="flex items-center gap-1.5">
                                        <span class="w-4 h-4 rounded-full border border-white shadow-sm" :style="{ backgroundColor: p.primary }"></span>
                                        <span class="w-4 h-4 rounded-full border border-white shadow-sm" :style="{ backgroundColor: p.accent }"></span>
                                    </div>
                                </div>
                                <p class="text-[11px] text-gray-500 line-clamp-1 mb-3">{{ p.desc }}</p>
                                <div class="text-[10px] text-gray-400 font-mono">
                                    Font: {{ p.heading }} + {{ p.sans }}
                                </div>
                            </div>
                        </div>

                        <!-- Custom Color Pickers -->
                        <div class="pt-4 border-t border-gray-100 grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Primary Brand Color (HEX)</label>
                                <div class="flex items-center gap-3">
                                    <input
                                        v-model="form.settings.theme_primary_color"
                                        type="color"
                                        class="h-9 w-12 rounded cursor-pointer border border-gray-300 p-0.5"
                                    />
                                    <input
                                        v-model="form.settings.theme_primary_color"
                                        type="text"
                                        class="flex-1 border border-gray-300 rounded-lg px-3 py-2 text-xs font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Accent Interaction Color (HEX)</label>
                                <div class="flex items-center gap-3">
                                    <input
                                        v-model="form.settings.theme_accent_color"
                                        type="color"
                                        class="h-9 w-12 rounded cursor-pointer border border-gray-300 p-0.5"
                                    />
                                    <input
                                        v-model="form.settings.theme_accent_color"
                                        type="text"
                                        class="flex-1 border border-gray-300 rounded-lg px-3 py-2 text-xs font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Typography & UI Geometry -->
                    <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-gray-100 pb-3">
                            <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                                🖋️ Typography & UI Geometry
                            </h2>
                            <p class="text-xs text-gray-500">Live Google Fonts pairings and corner radius geometry across buttons and cards.</p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Body Text Font</label>
                                <select
                                    v-model="form.settings.theme_font_sans"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none font-medium"
                                >
                                    <option value="Inter">Inter (Sleek Clean Modern)</option>
                                    <option value="Plus Jakarta Sans">Plus Jakarta Sans (High-End SaaS)</option>
                                    <option value="Outfit">Outfit (Geometric & Friendly)</option>
                                    <option value="Roboto">Roboto (Clean Editorial)</option>
                                </select>
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Editorial Heading Font</label>
                                <select
                                    v-model="form.settings.theme_font_heading"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none font-medium"
                                >
                                    <option value="Playfair Display">Playfair Display (Authoritative Serif)</option>
                                    <option value="Merriweather">Merriweather (Classic Academic)</option>
                                    <option value="Plus Jakarta Sans">Plus Jakarta Sans (Modern Headings)</option>
                                    <option value="Inter">Inter (Minimal Sans)</option>
                                </select>
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Element Border Radius</label>
                                <select
                                    v-model="form.settings.theme_border_radius"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none font-medium"
                                >
                                    <option value="8px">8px (Sleek Professional)</option>
                                    <option value="12px">12px (Modern SaaS Standard)</option>
                                    <option value="16px">16px (Smooth Rounded Pill)</option>
                                    <option value="4px">4px (Traditional Sharp)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 2: SEO, META TAGS & WEBMASTER VERIFICATION             -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'seo'" class="space-y-8">
                    <!-- Global SEO & Meta Tags Card -->
                    <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-gray-100 pb-3 flex items-center justify-between">
                            <div>
                                <h2 class="text-sm font-bold uppercase tracking-wider text-indigo-900 flex items-center gap-2">
                                    🔍 Global Search Engine Optimization (SEO)
                                </h2>
                                <p class="text-xs text-gray-500">Configure global metadata, search engine crawling rules, and social share previews.</p>
                            </div>
                            <a
                                href="/sitemap.xml"
                                target="_blank"
                                class="inline-flex items-center gap-1.5 px-3 py-1 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 border border-indigo-200 rounded-lg text-xs font-bold transition"
                            >
                                <span>🗺️ View Sitemap.xml</span>
                                <span class="font-mono">↗</span>
                            </a>
                        </div>

                        <div class="space-y-5">
                            <!-- Meta Description -->
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Global Meta Description (Max 160 Characters)</label>
                                <textarea
                                    v-model="form.settings.seo_meta_description"
                                    rows="3"
                                    class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none leading-relaxed"
                                    placeholder="Enter a compelling academic description for Google search results..."
                                ></textarea>
                                <p class="text-[11px] text-gray-400 mt-1">Characters: {{ (form.settings.seo_meta_description || '').length }} / 160</p>
                            </div>

                            <!-- Meta Keywords -->
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Global Meta Keywords (Comma Separated)</label>
                                <input
                                    v-model="form.settings.seo_meta_keywords"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    placeholder="e.g. academic publishing, open access, peer review, crossref doi, kdpub"
                                />
                            </div>

                            <!-- Social OpenGraph Image & Twitter -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 pt-2">
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Social Share Image URL (og:image)</label>
                                    <input
                                        v-model="form.settings.seo_og_image"
                                        type="text"
                                        class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                        placeholder="/apple-touch-icon.png or full https://... URL"
                                    />
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Twitter / X Handle</label>
                                    <input
                                        v-model="form.settings.seo_twitter_handle"
                                        type="text"
                                        class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none font-mono"
                                        placeholder="@kdpub"
                                    />
                                </div>
                            </div>

                            <!-- Search Engine Robots Directive -->
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Search Engine Robots Indexing Directive</label>
                                <select
                                    v-model="form.settings.seo_robots"
                                    class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none font-mono"
                                >
                                    <option value="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">index, follow (Recommended — Fully Indexed)</option>
                                    <option value="noindex, nofollow">noindex, nofollow (Disallow Indexing)</option>
                                    <option value="noindex, follow">noindex, follow (Index Links Only)</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Webmaster Verification & GA4 Analytics -->
                    <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-gray-100 pb-3">
                            <h2 class="text-sm font-bold uppercase tracking-wider text-indigo-900 flex items-center gap-2">
                                📊 Webmaster Verification & Google Analytics
                            </h2>
                            <p class="text-xs text-gray-500">Connect Google Search Console, Bing Webmaster Tools, and Google Analytics 4 tracking.</p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Google Site Verification Code</label>
                                <input
                                    v-model="form.settings.seo_google_verification"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    placeholder="e.g. AbCdEfGhIjKlMnOpQrStUvWxYz..."
                                />
                                <p class="text-[10px] text-gray-400 mt-1">Found in Google Search Console meta tag method.</p>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Bing Webmaster Auth Code</label>
                                <input
                                    v-model="form.settings.seo_bing_verification"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    placeholder="e.g. 1234567890ABCDEF..."
                                />
                                <p class="text-[10px] text-gray-400 mt-1">Found in Bing Webmaster Tools.</p>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Google Analytics 4 (GA4 ID)</label>
                                <input
                                    v-model="form.settings.seo_google_analytics_id"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    placeholder="G-XXXXXXXXXX"
                                />
                                <p class="text-[10px] text-gray-400 mt-1">Auto-injects gtag.js script across all pages.</p>
                            </div>
                        </div>

                        <!-- Custom Head Scripts -->
                        <div class="pt-2">
                            <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Custom Header Tracking Scripts &amp; Schema</label>
                            <textarea
                                v-model="form.settings.seo_custom_head_scripts"
                                rows="3"
                                class="w-full border border-gray-300 rounded-xl px-3.5 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="<!-- Paste custom tracking scripts, Meta Pixel, or JSON-LD tags here -->"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 3: PLATFORM IDENTITY, LOGOS & DOI                       -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'branding'" class="space-y-8">
                    <!-- Brand Assets & Favicon Showcase -->
                    <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-gray-100 pb-3">
                            <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                                🖼️ Brand Logo & Favicon Assets
                            </h2>
                            <p class="text-xs text-gray-500">Live vector SVGs and touch icons registered in application head.</p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <!-- Favicon Preview -->
                            <div class="p-5 rounded-2xl bg-slate-50 border border-slate-200 text-center space-y-3">
                                <div class="w-16 h-16 rounded-2xl mx-auto bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-md flex items-center justify-center">
                                    <div class="w-full h-full bg-[#0a101f] rounded-[14px] flex items-center justify-center font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-rose-300 text-lg">
                                        KD
                                    </div>
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-slate-800">Primary Favicon (SVG)</p>
                                    <p class="text-[10px] text-slate-500 font-mono">/favicon.svg</p>
                                </div>
                            </div>

                            <!-- Touch Icon Preview -->
                            <div class="p-5 rounded-2xl bg-slate-50 border border-slate-200 text-center space-y-3">
                                <div class="w-16 h-16 rounded-2xl mx-auto bg-[#070c18] border border-indigo-500/50 shadow-md flex items-center justify-center text-indigo-400 font-black text-lg">
                                    KD
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-slate-800">Apple Touch Icon (PNG)</p>
                                    <p class="text-[10px] text-slate-500 font-mono">/apple-touch-icon.png</p>
                                </div>
                            </div>

                            <!-- Full Logo Preview -->
                            <div class="p-5 rounded-2xl bg-slate-50 border border-slate-200 text-center space-y-3">
                                <div class="h-16 flex items-center justify-center">
                                    <div class="flex items-center gap-2">
                                        <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5">
                                            <div class="w-full h-full bg-[#0a101f] rounded-[6px] flex items-center justify-center text-[10px] font-black text-white">
                                                KD
                                            </div>
                                        </div>
                                        <span class="text-xs font-extrabold text-slate-900">Knowledge Dynamics</span>
                                    </div>
                                </div>
                                <div>
                                    <p class="text-xs font-bold text-slate-800">Horizontal Logo (SVG)</p>
                                    <p class="text-[10px] text-slate-500 font-mono">/images/logo.svg</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Platform Identity & Crossref DOI -->
                    <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-gray-100 pb-3">
                            <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                                🏛️ Platform Identity & Scholarly DOI
                            </h2>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Platform Name</label>
                                <input
                                    v-model="form.settings.site_name"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                />
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publisher Legal Entity</label>
                                <input
                                    v-model="form.settings.publisher_name"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Crossref DOI Prefix *</label>
                                <input
                                    v-model="form.settings.doi_prefix"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none font-mono"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Editorial Contact Email</label>
                                <input
                                    v-model="form.settings.contact_email"
                                    type="email"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                />
                            </div>

                            <div class="sm:col-span-2">
                                <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Headquarters Address</label>
                                <input
                                    v-model="form.settings.headquarters_address"
                                    type="text"
                                    class="w-full border border-gray-300 rounded-lg px-3 py-2 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Submit Action Bar -->
                <div class="flex justify-end pt-4">
                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="btn-primary text-xs py-3 px-8 shadow-md flex items-center gap-2 font-bold"
                        :style="{ backgroundColor: form.settings.theme_primary_color || '#0F2A4A' }"
                    >
                        <span>💾</span>
                        <span>{{ form.processing ? 'Saving Settings...' : 'Save All Settings & SEO Engine →' }}</span>
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
