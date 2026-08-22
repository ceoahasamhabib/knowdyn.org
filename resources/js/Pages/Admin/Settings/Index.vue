<script setup>
import { ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

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

// Set defaults if empty
if (!initialSettingsMap.theme_preset) initialSettingsMap.theme_preset = 'oxford-navy';
if (!initialSettingsMap.theme_primary_color) initialSettingsMap.theme_primary_color = '#0F2A4A';
if (!initialSettingsMap.theme_accent_color) initialSettingsMap.theme_accent_color = '#BE123C';
if (!initialSettingsMap.theme_font_sans) initialSettingsMap.theme_font_sans = 'Inter';
if (!initialSettingsMap.theme_font_heading) initialSettingsMap.theme_font_heading = 'Playfair Display';
if (!initialSettingsMap.theme_border_radius) initialSettingsMap.theme_border_radius = '12px';

const form = useForm({
    settings: initialSettingsMap,
});

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
    <Head title="System, Theme & Typography Settings — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">System, Theme & Branding Settings</h1>
                    <p class="text-xs text-gray-500">Live customization of brand colors, Google typography pairings, Crossref DOI, and publisher identity.</p>
                </div>
            </div>
        </template>

        <div class="max-w-5xl mx-auto space-y-8">
            <form @submit.prevent="submit" class="space-y-8">
                <!-- 1. LIVE THEME & COLOR PALETTES -->
                <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-3 flex items-center justify-between">
                        <div>
                            <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                                🎨 1. Global Brand Theme & Color Presets
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

                <!-- 2. TYPOGRAPHY & UI GEOMETRY -->
                <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-3">
                        <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                            🖋️ 2. Typography & UI Geometry
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

                    <!-- Live Preview Box -->
                    <div class="p-5 rounded-xl border border-gray-100 bg-gray-50/70 space-y-3">
                        <span class="text-[10px] uppercase tracking-widest text-gray-400 font-bold">Live Theme Preview</span>
                        <div class="flex flex-wrap items-center gap-4">
                            <button
                                type="button"
                                class="px-4 py-2 text-xs font-bold text-white shadow-sm"
                                :style="{ backgroundColor: form.settings.theme_primary_color, borderRadius: form.settings.theme_border_radius }"
                            >
                                Primary Action Button
                            </button>

                            <button
                                type="button"
                                class="px-4 py-2 text-xs font-bold text-white shadow-sm"
                                :style="{ backgroundColor: form.settings.theme_accent_color, borderRadius: form.settings.theme_border_radius }"
                            >
                                Accent Action Button
                            </button>

                            <span
                                class="px-3 py-1 text-xs font-semibold"
                                :style="{ color: form.settings.theme_primary_color, backgroundColor: form.settings.theme_primary_color + '15', borderRadius: form.settings.theme_border_radius }"
                            >
                                Scholarly Badge
                            </span>
                        </div>
                    </div>
                </div>

                <!-- 3. PLATFORM IDENTITY & DOI CONFIG -->
                <div class="bg-white rounded-2xl border border-gray-200/80 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-3">
                        <h2 class="text-sm font-bold uppercase tracking-wider text-navy-900 flex items-center gap-2">
                            🏛️ 3. Platform Identity & Scholarly DOI
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

                <!-- Submit Action -->
                <div class="flex justify-end pt-2">
                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="btn-primary text-xs py-3 px-8 shadow-md flex items-center gap-2"
                        :style="{ backgroundColor: form.settings.theme_primary_color }"
                    >
                        {{ form.processing ? 'Saving Theme & Settings...' : 'Save Theme & Settings →' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
