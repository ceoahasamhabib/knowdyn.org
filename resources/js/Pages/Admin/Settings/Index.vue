<script setup>
import { ref, computed } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import MediaPickerModal from '@/Components/KD/MediaPickerModal.vue';

const props = defineProps({
    settings: {
        type: Array,
        default: () => [],
    },
});

const initialMap = {};
props.settings.forEach(s => {
    initialMap[s.key] = s.value || '';
});

// Set sensible defaults
if (!initialMap.theme_preset) initialMap.theme_preset = 'oxford-navy';
if (!initialMap.theme_primary_color) initialMap.theme_primary_color = '#0F2A4A';
if (!initialMap.theme_accent_color) initialMap.theme_accent_color = '#BE123C';
if (!initialMap.theme_font_sans) initialMap.theme_font_sans = 'Inter';
if (!initialMap.theme_font_heading) initialMap.theme_font_heading = 'Playfair Display';
if (!initialMap.theme_border_radius) initialMap.theme_border_radius = '12px';

if (!initialMap.site_name) initialMap.site_name = 'Knowledge Dynamics';
if (!initialMap.publisher_name) initialMap.publisher_name = 'Knowledge Dynamics Publishing';
if (!initialMap.doi_prefix) initialMap.doi_prefix = '10.69598';
if (!initialMap.contact_email) initialMap.contact_email = 'editor@kdpub.com';

if (!initialMap.brand_favicon) initialMap.brand_favicon = '/favicon.svg';
if (!initialMap.seo_meta_description) {
    initialMap.seo_meta_description = 'Knowledge Dynamics is an international academic publisher for peer-reviewed open access journals, books, scholar profiles, and editorial proofreading services.';
}
if (!initialMap.seo_meta_keywords) {
    initialMap.seo_meta_keywords = 'academic publishing, open access journals, peer review, crossref doi, proofreading, research papers, knowledge dynamics, kdpub, medical journals, health dynamics';
}
if (!initialMap.seo_robots) initialMap.seo_robots = 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1';
if (!initialMap.seo_twitter_handle) initialMap.seo_twitter_handle = '@kdpub';
if (!initialMap.seo_og_image) initialMap.seo_og_image = '/apple-touch-icon.png';

const form = useForm({
    settings: { ...initialMap },
    brand_logo: null,
    brand_logo_dark: null,
    brand_favicon: null,
    seo_og_image: null,
    remove_brand_logo: false,
    remove_brand_logo_dark: false,
    remove_brand_favicon: false,
});

const activeTab = ref('branding');

// Previews for uploaded files
const logoPreview = ref(initialMap.brand_logo || null);
const logoDarkPreview = ref(initialMap.brand_logo_dark || null);
const faviconPreview = ref(initialMap.brand_favicon || '/favicon.svg');
const ogImagePreview = ref(initialMap.seo_og_image || '/apple-touch-icon.png');

// File inputs refs
const logoInput = ref(null);
const logoDarkInput = ref(null);
const faviconInput = ref(null);
const ogImageInput = ref(null);

// Media Picker Modal State
const showMediaPicker = ref(false);
const activeMediaTarget = ref(null); // 'logo' | 'logo_dark' | 'favicon' | 'og_image'

const openMediaPicker = (target) => {
    activeMediaTarget.value = target;
    showMediaPicker.value = true;
};

const onMediaSelected = (media) => {
    if (activeMediaTarget.value === 'logo') {
        form.settings.brand_logo = media.url;
        logoPreview.value = media.url;
        form.remove_brand_logo = false;
    } else if (activeMediaTarget.value === 'logo_dark') {
        form.settings.brand_logo_dark = media.url;
        logoDarkPreview.value = media.url;
        form.remove_brand_logo_dark = false;
    } else if (activeMediaTarget.value === 'favicon') {
        form.settings.brand_favicon = media.url;
        faviconPreview.value = media.url;
        form.remove_brand_favicon = false;
    } else if (activeMediaTarget.value === 'og_image') {
        form.settings.seo_og_image = media.url;
        ogImagePreview.value = media.url;
    }
};

const handleLogoChange = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.brand_logo = file;
        form.remove_brand_logo = false;
        logoPreview.value = URL.createObjectURL(file);
    }
};

const removeLogo = () => {
    form.brand_logo = null;
    form.remove_brand_logo = true;
    form.settings.brand_logo = '';
    logoPreview.value = null;
    if (logoInput.value) logoInput.value.value = '';
};

const handleLogoDarkChange = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.brand_logo_dark = file;
        form.remove_brand_logo_dark = false;
        logoDarkPreview.value = URL.createObjectURL(file);
    }
};

const removeLogoDark = () => {
    form.brand_logo_dark = null;
    form.remove_brand_logo_dark = true;
    form.settings.brand_logo_dark = '';
    logoDarkPreview.value = null;
    if (logoDarkInput.value) logoDarkInput.value.value = '';
};

const handleFaviconChange = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.brand_favicon = file;
        form.remove_brand_favicon = false;
        faviconPreview.value = URL.createObjectURL(file);
    }
};

const removeFavicon = () => {
    form.brand_favicon = null;
    form.remove_brand_favicon = true;
    form.settings.brand_favicon = '/favicon.svg';
    faviconPreview.value = '/favicon.svg';
    if (faviconInput.value) faviconInput.value.value = '';
};

const handleOgImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.seo_og_image = file;
        ogImagePreview.value = URL.createObjectURL(file);
    }
};

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

const descLength = computed(() => (form.settings.seo_meta_description || '').length);

const submit = () => {
    form.post(route('admin.settings.update'), {
        forceFormData: true,
        preserveScroll: true,
        onSuccess: () => {
            // Updated successfully
        },
    });
};
</script>

<template>
    <Head title="System, SEO & Branding Settings — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 w-full">
                <div>
                    <div class="flex items-center gap-2 mb-1">
                        <span class="px-2.5 py-0.5 text-[10px] font-extrabold uppercase tracking-wider bg-indigo-50 text-indigo-700 rounded-md border border-indigo-200">
                            Central System Management
                        </span>
                        <span class="text-xs text-slate-400">•</span>
                        <span class="text-xs text-slate-500 font-medium">KD Core Architecture</span>
                    </div>
                    <h1 class="text-2xl font-black text-slate-900 tracking-tight flex items-center gap-2.5">
                        <span>⚙️</span> System, SEO & Branding Settings
                    </h1>
                </div>

                <!-- Navigation Tabs Pills -->
                <div class="flex items-center gap-1.5 bg-slate-200/70 p-1.5 rounded-2xl overflow-x-auto">
                    <button
                        type="button"
                        @click="activeTab = 'branding'"
                        class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                        :class="activeTab === 'branding' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                    >
                        <span>🖼️</span> Brand Logos & Favicon
                    </button>
                    <button
                        type="button"
                        @click="activeTab = 'seo'"
                        class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                        :class="activeTab === 'seo' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                    >
                        <span>🔍</span> SEO & Social Meta
                    </button>
                    <button
                        type="button"
                        @click="activeTab = 'webmaster'"
                        class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                        :class="activeTab === 'webmaster' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                    >
                        <span>📊</span> Webmaster & Analytics
                    </button>
                    <button
                        type="button"
                        @click="activeTab = 'theme'"
                        class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                        :class="activeTab === 'theme' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                    >
                        <span>🎨</span> Theme & Colors
                    </button>
                    <button
                        type="button"
                        @click="activeTab = 'doi'"
                        class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                        :class="activeTab === 'doi' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                    >
                        <span>🏛️</span> Identity & Crossref
                    </button>
                </div>
            </div>
        </template>

        <div class="max-w-7xl mx-auto space-y-8 pb-16">
            <form @submit.prevent="submit" class="space-y-8">
                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 1: BRAND LOGOS & FAVICON UPLOAD                         -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'branding'" class="space-y-8">
                    <!-- Brand Identity Card -->
                    <div class="bg-white rounded-2xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-slate-100 pb-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <div>
                                <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                                    <span>🖼️</span> Platform Logos & Favicon Asset Management
                                </h2>
                                <p class="text-xs text-slate-500 mt-0.5">Pick from the central Media Library or upload directly for headers, dark footers, and tabs.</p>
                            </div>
                            <div class="flex items-center gap-2">
                                <a
                                    :href="route('admin.media.index')"
                                    target="_blank"
                                    class="text-xs font-bold text-indigo-600 hover:text-indigo-800 bg-indigo-50 border border-indigo-200 px-3.5 py-1.5 rounded-xl flex items-center gap-1.5 transition shadow-xs"
                                >
                                    <span>📁 Open Media Library</span>
                                    <span class="font-mono">↗</span>
                                </a>
                            </div>
                        </div>

                        <!-- 3-Column Upload Grids -->
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <!-- 1. Primary Header Logo (Light Canvas) -->
                            <div class="rounded-2xl border border-slate-200/90 bg-slate-50/50 p-5 flex flex-col justify-between space-y-4 hover:border-indigo-300 transition">
                                <div>
                                    <div class="flex items-center justify-between mb-2">
                                        <label class="text-xs font-bold text-slate-900 uppercase tracking-wider flex items-center gap-1.5">
                                            <span>☀️</span> Primary Logo
                                        </label>
                                        <span class="text-[10px] text-slate-400 font-mono">Light BG</span>
                                    </div>
                                    <p class="text-[11px] text-slate-500 mb-4">Used on light public navigation bars and headers.</p>

                                    <!-- Preview Box Light Background -->
                                    <div class="w-full h-32 rounded-xl bg-white border border-slate-200 flex items-center justify-center p-4 relative overflow-hidden shadow-inner group">
                                        <template v-if="logoPreview">
                                            <img :src="logoPreview" alt="Primary Logo Preview" class="max-h-20 max-w-full object-contain" />
                                        </template>
                                        <template v-else>
                                            <div class="flex items-center gap-2.5">
                                                <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-sm">
                                                    <div class="w-full h-full bg-[#0a101f] rounded-[8px] flex items-center justify-center font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-rose-300 text-xs">
                                                        KD
                                                    </div>
                                                </div>
                                                <span class="font-bold text-xs text-slate-800">Knowledge Dynamics</span>
                                            </div>
                                        </template>

                                        <div v-if="logoPreview" class="absolute top-2 right-2 flex gap-1">
                                            <button
                                                type="button"
                                                @click="removeLogo"
                                                class="px-2 py-1 bg-rose-50 hover:bg-rose-100 text-rose-600 border border-rose-200 rounded-md text-[10px] font-bold shadow-xs transition"
                                            >
                                                ✕ Remove
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="space-y-2">
                                    <button
                                        type="button"
                                        @click="openMediaPicker('logo')"
                                        class="w-full py-2 px-3 rounded-xl border border-indigo-200 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 text-xs font-bold flex items-center justify-center gap-1.5 transition shadow-xs"
                                    >
                                        <span>📁</span> Choose from Media Library
                                    </button>
                                    <input
                                        ref="logoInput"
                                        type="file"
                                        accept="image/svg+xml,image/png,image/jpeg,image/webp"
                                        @change="handleLogoChange"
                                        class="hidden"
                                        id="brand_logo_file"
                                    />
                                    <label
                                        for="brand_logo_file"
                                        class="w-full py-1.5 px-3 rounded-xl border border-slate-200 bg-white hover:bg-slate-50 text-slate-600 text-[11px] font-semibold flex items-center justify-center gap-1.5 cursor-pointer transition shadow-xs"
                                    >
                                        <span>⬆️</span> Direct Upload New
                                    </label>
                                </div>
                            </div>

                            <!-- 2. Dark / Footer Logo (Dark Canvas) -->
                            <div class="rounded-2xl border border-slate-200/90 bg-slate-50/50 p-5 flex flex-col justify-between space-y-4 hover:border-indigo-300 transition">
                                <div>
                                    <div class="flex items-center justify-between mb-2">
                                        <label class="text-xs font-bold text-slate-900 uppercase tracking-wider flex items-center gap-1.5">
                                            <span>🌙</span> Dark Mode / Footer Logo
                                        </label>
                                        <span class="text-[10px] text-slate-400 font-mono">Dark BG</span>
                                    </div>
                                    <p class="text-[11px] text-slate-500 mb-4">Used on dark footer and publisher cockpit sidebar.</p>

                                    <!-- Preview Box Dark Background -->
                                    <div class="w-full h-32 rounded-xl bg-[#070c18] border border-slate-800 flex items-center justify-center p-4 relative overflow-hidden shadow-inner group">
                                        <template v-if="logoDarkPreview">
                                            <img :src="logoDarkPreview" alt="Dark Logo Preview" class="max-h-20 max-w-full object-contain" />
                                        </template>
                                        <template v-else-if="logoPreview">
                                            <img :src="logoPreview" alt="Logo Preview" class="max-h-20 max-w-full object-contain brightness-110" />
                                        </template>
                                        <template v-else>
                                            <div class="flex items-center gap-2.5">
                                                <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-sm">
                                                    <div class="w-full h-full bg-[#0a101f] rounded-[8px] flex items-center justify-center font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-rose-300 text-xs">
                                                        KD
                                                    </div>
                                                </div>
                                                <span class="font-bold text-xs text-white">Knowledge Dynamics</span>
                                            </div>
                                        </template>

                                        <div v-if="logoDarkPreview" class="absolute top-2 right-2 flex gap-1">
                                            <button
                                                type="button"
                                                @click="removeLogoDark"
                                                class="px-2 py-1 bg-rose-950/80 hover:bg-rose-900 text-rose-300 border border-rose-800 rounded-md text-[10px] font-bold shadow-xs transition"
                                            >
                                                ✕ Remove
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="space-y-2">
                                    <button
                                        type="button"
                                        @click="openMediaPicker('logo_dark')"
                                        class="w-full py-2 px-3 rounded-xl border border-slate-700 bg-slate-900 hover:bg-slate-800 text-white text-xs font-bold flex items-center justify-center gap-1.5 transition shadow-xs"
                                    >
                                        <span>📁</span> Choose from Media Library
                                    </button>
                                    <input
                                        ref="logoDarkInput"
                                        type="file"
                                        accept="image/svg+xml,image/png,image/jpeg,image/webp"
                                        @change="handleLogoDarkChange"
                                        class="hidden"
                                        id="brand_logo_dark_file"
                                    />
                                    <label
                                        for="brand_logo_dark_file"
                                        class="w-full py-1.5 px-3 rounded-xl border border-slate-200 bg-white hover:bg-slate-50 text-slate-600 text-[11px] font-semibold flex items-center justify-center gap-1.5 cursor-pointer transition shadow-xs"
                                    >
                                        <span>⬆️</span> Direct Upload New
                                    </label>
                                </div>
                            </div>

                            <!-- 3. Favicon & Web App Icon -->
                            <div class="rounded-2xl border border-slate-200/90 bg-slate-50/50 p-5 flex flex-col justify-between space-y-4 hover:border-indigo-300 transition">
                                <div>
                                    <div class="flex items-center justify-between mb-2">
                                        <label class="text-xs font-bold text-slate-900 uppercase tracking-wider flex items-center gap-1.5">
                                            <span>⭐</span> Favicon & Tab Icon
                                        </label>
                                        <span class="text-[10px] text-slate-400 font-mono">Tab Icon</span>
                                    </div>
                                    <p class="text-[11px] text-slate-500 mb-4">Displayed in browser tabs, bookmarks, and PWA.</p>

                                    <!-- Browser Tab Simulation Preview -->
                                    <div class="w-full h-32 rounded-xl bg-slate-200/70 border border-slate-300/80 p-3 flex flex-col justify-between shadow-inner">
                                        <!-- Mock Browser Tab -->
                                        <div class="bg-white rounded-t-lg px-3 py-2 border-b border-slate-200 flex items-center gap-2 shadow-xs max-w-[220px]">
                                            <img :src="faviconPreview" alt="Favicon" class="w-4 h-4 object-contain rounded-xs" />
                                            <span class="text-[11px] font-bold text-slate-800 truncate">{{ form.settings.site_name || 'Knowledge Dynamics' }}</span>
                                            <span class="text-[9px] text-slate-400 ml-auto">✕</span>
                                        </div>

                                        <div class="flex items-center justify-between text-[10px] text-slate-500 font-mono px-1">
                                            <span class="truncate max-w-[140px]">{{ form.settings.brand_favicon || '/favicon.svg' }}</span>
                                            <button
                                                v-if="faviconPreview !== '/favicon.svg'"
                                                type="button"
                                                @click="removeFavicon"
                                                class="text-rose-600 font-bold hover:underline shrink-0"
                                            >
                                                Reset Default
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="space-y-2">
                                    <button
                                        type="button"
                                        @click="openMediaPicker('favicon')"
                                        class="w-full py-2 px-3 rounded-xl border border-indigo-200 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 text-xs font-bold flex items-center justify-center gap-1.5 transition shadow-xs"
                                    >
                                        <span>📁</span> Choose from Media Library
                                    </button>
                                    <input
                                        ref="faviconInput"
                                        type="file"
                                        accept="image/svg+xml,image/x-icon,image/vnd.microsoft.icon,image/png"
                                        @change="handleFaviconChange"
                                        class="hidden"
                                        id="brand_favicon_file"
                                    />
                                    <label
                                        for="brand_favicon_file"
                                        class="w-full py-1.5 px-3 rounded-xl border border-slate-200 bg-white hover:bg-slate-50 text-slate-600 text-[11px] font-semibold flex items-center justify-center gap-1.5 cursor-pointer transition shadow-xs"
                                    >
                                        <span>⬆️</span> Direct Upload New
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Live Real-Time SERP & Social Sharing Previews -->
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <!-- Google Search Preview -->
                        <div class="bg-white rounded-2xl border border-slate-200 p-6 shadow-sm space-y-4">
                            <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                                <h3 class="text-xs font-bold uppercase tracking-wider text-slate-800 flex items-center gap-2">
                                    <span>🔎</span> Google Search Result Preview (SERP)
                                </h3>
                                <span class="text-[10px] text-slate-400 font-mono">Real-time simulation</span>
                            </div>

                            <div class="p-4 rounded-xl bg-slate-50 border border-slate-200/80 space-y-1.5 font-sans">
                                <div class="flex items-center gap-2 text-xs text-slate-600">
                                    <img :src="faviconPreview" class="w-4 h-4 rounded-full border border-slate-200" />
                                    <span class="font-medium text-slate-800">{{ form.settings.site_name || 'Knowledge Dynamics' }}</span>
                                    <span class="text-slate-400 text-[10px]">https://kdpub.com</span>
                                </div>
                                <h4 class="text-base text-indigo-700 hover:underline font-semibold line-clamp-1 cursor-pointer">
                                    {{ form.settings.site_name || 'Knowledge Dynamics' }} — Global Open Access Academic Publishing
                                </h4>
                                <p class="text-xs text-slate-600 line-clamp-2 leading-relaxed">
                                    {{ form.settings.seo_meta_description || 'Knowledge Dynamics is an international academic publisher for peer-reviewed open access journals, books, scholar profiles, and editorial proofreading services.' }}
                                </p>
                            </div>
                        </div>

                        <!-- OpenGraph Social Share Card Preview -->
                        <div class="bg-white rounded-2xl border border-slate-200 p-6 shadow-sm space-y-4">
                            <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                                <h3 class="text-xs font-bold uppercase tracking-wider text-slate-800 flex items-center gap-2">
                                    <span>🌐</span> Facebook / LinkedIn / X Social Preview
                                </h3>
                                <button
                                    type="button"
                                    @click="openMediaPicker('og_image')"
                                    class="text-[11px] font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1"
                                >
                                    <span>📷 Choose from Media</span>
                                </button>
                            </div>

                            <div class="rounded-xl border border-slate-200 overflow-hidden bg-slate-50 font-sans shadow-xs">
                                <div class="h-32 bg-slate-900 relative overflow-hidden flex items-center justify-center">
                                    <img :src="ogImagePreview" alt="OG Image" class="w-full h-full object-cover" />
                                </div>
                                <div class="p-3.5 space-y-1">
                                    <span class="text-[10px] font-mono uppercase text-slate-400 tracking-wider">KDPUB.COM</span>
                                    <h5 class="text-xs font-bold text-slate-900 line-clamp-1">
                                        {{ form.settings.site_name || 'Knowledge Dynamics' }} — Academic Research & Journals
                                    </h5>
                                    <p class="text-[11px] text-slate-500 line-clamp-1">
                                        {{ form.settings.seo_meta_description }}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 2: SEO & SOCIAL METADATA                                -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'seo'" class="space-y-8">
                    <div class="bg-white rounded-2xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-slate-100 pb-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <div>
                                <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                                    <span>🔍</span> Global Search Engine Optimization (SEO)
                                </h2>
                                <p class="text-xs text-slate-500 mt-0.5">Control indexing, meta descriptions, search ranking keywords, and dynamic XML sitemap links.</p>
                            </div>
                            <a
                                href="/sitemap.xml"
                                target="_blank"
                                class="inline-flex items-center gap-1.5 px-3.5 py-1.5 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 border border-indigo-200 rounded-xl text-xs font-bold transition shadow-xs"
                            >
                                <span>🗺️ Dynamic Sitemap.xml</span>
                                <span class="font-mono">↗</span>
                            </a>
                        </div>

                        <div class="space-y-6">
                            <!-- Meta Description with live counter -->
                            <div>
                                <div class="flex items-center justify-between mb-1.5">
                                    <label class="text-xs font-bold text-slate-700 uppercase tracking-wider">
                                        Global Meta Description
                                    </label>
                                    <span
                                        class="text-xs font-mono font-bold"
                                        :class="descLength >= 120 && descLength <= 160 ? 'text-emerald-600' : 'text-amber-600'"
                                    >
                                        {{ descLength }} / 160 chars (Recommended: 120-160)
                                    </span>
                                </div>
                                <textarea
                                    v-model="form.settings.seo_meta_description"
                                    rows="3"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:border-indigo-600 focus:outline-none leading-relaxed transition"
                                    placeholder="Enter an authoritative description that represents Knowledge Dynamics in search engine results..."
                                ></textarea>
                            </div>

                            <!-- Meta Keywords -->
                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                    Global Meta Keywords (Comma Separated)
                                </label>
                                <input
                                    v-model="form.settings.seo_meta_keywords"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:border-indigo-600 focus:outline-none transition"
                                    placeholder="e.g. academic publishing, open access journals, peer review, crossref doi, proofreading, research papers, knowledge dynamics"
                                />
                            </div>

                            <!-- Twitter Handle & Robots Directive -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                                <div>
                                    <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                        Twitter / X Publisher Handle
                                    </label>
                                    <input
                                        v-model="form.settings.seo_twitter_handle"
                                        type="text"
                                        class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:border-indigo-600 focus:outline-none transition"
                                        placeholder="@kdpub"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                        Search Engine Robots Directive
                                    </label>
                                    <select
                                        v-model="form.settings.seo_robots"
                                        class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:border-indigo-600 focus:outline-none transition"
                                    >
                                        <option value="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">index, follow (Standard — Fully Index Content)</option>
                                        <option value="noindex, nofollow">noindex, nofollow (Disallow Search Engines)</option>
                                        <option value="noindex, follow">noindex, follow (Follow Links Only)</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 3: WEBMASTER TOOLS & ANALYTICS                          -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'webmaster'" class="space-y-8">
                    <div class="bg-white rounded-2xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-slate-100 pb-4">
                            <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                                <span>📊</span> Webmaster Verification & Google Analytics 4
                            </h2>
                            <p class="text-xs text-slate-500 mt-0.5">Authenticate domain ownership with Google Search Console and Bing Webmaster, and track live visitor metrics.</p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                    Google Site Verification
                                </label>
                                <input
                                    v-model="form.settings.seo_google_verification"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none transition"
                                    placeholder="google-site-verification token..."
                                />
                                <p class="text-[10px] text-slate-400 mt-1">HTML meta tag token from Google Search Console.</p>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                    Bing Webmaster Verification
                                </label>
                                <input
                                    v-model="form.settings.seo_bing_verification"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none transition"
                                    placeholder="msvalidate.01 token..."
                                />
                                <p class="text-[10px] text-slate-400 mt-1">Auth token from Bing Webmaster Tools.</p>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                    Google Analytics 4 (GA4 ID)
                                </label>
                                <input
                                    v-model="form.settings.seo_google_analytics_id"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none transition"
                                    placeholder="G-XXXXXXXXXX"
                                />
                                <p class="text-[10px] text-slate-400 mt-1">Automatically injects gtag.js script in document head.</p>
                            </div>
                        </div>

                        <!-- Custom Tracking Scripts -->
                        <div class="pt-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                Custom Header Tracking Scripts (Meta Pixel, Hotjar, Custom Scripts)
                            </label>
                            <textarea
                                v-model="form.settings.seo_custom_head_scripts"
                                rows="4"
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none transition"
                                placeholder="<!-- Paste custom tracking tags, Facebook Pixel, or external verification scripts here -->"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 4: THEME, COLORS & TYPOGRAPHY                           -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'theme'" class="space-y-8">
                    <div class="bg-white rounded-2xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-slate-100 pb-4 flex items-center justify-between">
                            <div>
                                <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                                    <span>🎨</span> Global Brand Theme & Color Palettes
                                </h2>
                                <p class="text-xs text-slate-500 mt-0.5">Select a curated academic luxury palette or define custom brand HEX colors.</p>
                            </div>
                            <span class="text-[11px] font-mono font-semibold bg-indigo-50 text-indigo-800 px-3 py-1 rounded-full border border-indigo-200">
                                Active: {{ form.settings.theme_preset }}
                            </span>
                        </div>

                        <!-- Preset Cards -->
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div
                                v-for="p in themePresets"
                                :key="p.id"
                                @click="applyPreset(p)"
                                class="p-4 rounded-xl border cursor-pointer transition-all duration-200 relative overflow-hidden"
                                :class="form.settings.theme_preset === p.id ? 'border-indigo-600 bg-indigo-50/40 ring-2 ring-indigo-600 shadow-sm' : 'border-slate-200 hover:border-slate-300 hover:bg-slate-50'"
                            >
                                <div class="flex items-center justify-between mb-2">
                                    <span class="font-bold text-xs text-slate-900">{{ p.name }}</span>
                                    <div class="flex items-center gap-1.5">
                                        <span class="w-4 h-4 rounded-full border border-white shadow-sm" :style="{ backgroundColor: p.primary }"></span>
                                        <span class="w-4 h-4 rounded-full border border-white shadow-sm" :style="{ backgroundColor: p.accent }"></span>
                                    </div>
                                </div>
                                <p class="text-[11px] text-slate-500 line-clamp-1 mb-2">{{ p.desc }}</p>
                                <div class="text-[10px] text-slate-400 font-mono">
                                    {{ p.heading }} + {{ p.sans }}
                                </div>
                            </div>
                        </div>

                        <!-- Custom Colors -->
                        <div class="pt-4 border-t border-slate-100 grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Primary Brand Color (HEX)</label>
                                <div class="flex items-center gap-3">
                                    <input
                                        v-model="form.settings.theme_primary_color"
                                        type="color"
                                        class="h-10 w-14 rounded-lg cursor-pointer border border-slate-300 p-0.5"
                                    />
                                    <input
                                        v-model="form.settings.theme_primary_color"
                                        type="text"
                                        class="flex-1 border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    />
                                </div>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Accent Interaction Color (HEX)</label>
                                <div class="flex items-center gap-3">
                                    <input
                                        v-model="form.settings.theme_accent_color"
                                        type="color"
                                        class="h-10 w-14 rounded-lg cursor-pointer border border-slate-300 p-0.5"
                                    />
                                    <input
                                        v-model="form.settings.theme_accent_color"
                                        type="text"
                                        class="flex-1 border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Typography & Geometry -->
                    <div class="bg-white rounded-2xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-slate-100 pb-4">
                            <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                                <span>🖋️</span> Typography & UI Geometry
                            </h2>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Body Text Font</label>
                                <select
                                    v-model="form.settings.theme_font_sans"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none font-medium"
                                >
                                    <option value="Inter">Inter (Sleek Clean Modern)</option>
                                    <option value="Plus Jakarta Sans">Plus Jakarta Sans (High-End SaaS)</option>
                                    <option value="Outfit">Outfit (Geometric & Friendly)</option>
                                    <option value="Roboto">Roboto (Clean Editorial)</option>
                                </select>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Editorial Heading Font</label>
                                <select
                                    v-model="form.settings.theme_font_heading"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none font-medium"
                                >
                                    <option value="Playfair Display">Playfair Display (Authoritative Serif)</option>
                                    <option value="Merriweather">Merriweather (Classic Academic)</option>
                                    <option value="Plus Jakarta Sans">Plus Jakarta Sans (Modern Headings)</option>
                                    <option value="Inter">Inter (Minimal Sans)</option>
                                </select>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Element Border Radius</label>
                                <select
                                    v-model="form.settings.theme_border_radius"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none font-medium"
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
                <!-- TAB 5: PLATFORM IDENTITY & CROSSREF DOI                     -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'doi'" class="space-y-8">
                    <div class="bg-white rounded-2xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="border-b border-slate-100 pb-4">
                            <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                                <span>🏛️</span> Platform Identity & Scholarly Crossref DOI
                            </h2>
                            <p class="text-xs text-slate-500 mt-0.5">Configure institutional details, publisher legal entity name, and Crossref prefix for official DOI minting.</p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Platform Name</label>
                                <input
                                    v-model="form.settings.site_name"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Publisher Legal Entity</label>
                                <input
                                    v-model="form.settings.publisher_name"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Crossref DOI Prefix *</label>
                                <input
                                    v-model="form.settings.doi_prefix"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Editorial Contact Email</label>
                                <input
                                    v-model="form.settings.contact_email"
                                    type="email"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>

                            <div class="sm:col-span-2">
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Headquarters Address</label>
                                <input
                                    v-model="form.settings.headquarters_address"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sticky Bottom Action Bar -->
                <div class="sticky bottom-4 z-30 bg-slate-900/90 backdrop-blur-md rounded-2xl border border-slate-800 px-6 py-4 flex items-center justify-between shadow-2xl text-white">
                    <div class="flex items-center gap-3">
                        <span class="w-2.5 h-2.5 rounded-full bg-emerald-400 animate-pulse"></span>
                        <span class="text-xs font-medium text-slate-300 hidden sm:inline">Settings ready to apply across all journals and public views.</span>
                    </div>

                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="px-8 py-3 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-black text-xs uppercase tracking-wider shadow-lg shadow-indigo-500/25 flex items-center gap-2 transition duration-200 disabled:opacity-50 cursor-pointer"
                    >
                        <span v-if="form.processing" class="animate-spin">🌀</span>
                        <span v-else>💾</span>
                        <span>{{ form.processing ? 'Saving & Uploading...' : 'Save All Settings & Brand Assets' }}</span>
                    </button>
                </div>
            </form>
        </div>

        <!-- ── Reusable Media Picker Modal for Brand Logos & Favicon ── -->
        <MediaPickerModal
            v-model="showMediaPicker"
            :default-folder="activeMediaTarget === 'favicon' ? 'branding' : 'branding'"
            :title="'Select ' + (activeMediaTarget === 'logo' ? 'Primary Logo' : (activeMediaTarget === 'logo_dark' ? 'Dark Logo' : (activeMediaTarget === 'favicon' ? 'Favicon' : 'Social Cover Image'))) + ' from Media Library'"
            @select="onMediaSelected"
        />
    </AdminLayout>
</template>
