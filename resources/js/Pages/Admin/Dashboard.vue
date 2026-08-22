<script setup>
import { computed } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const props = defineProps({
    stats: {
        type: Object,
        default: () => ({
            users: 0,
            journals: 0,
            articles: 0,
            manuscripts: 0,
            reviews: 0,
            researchers: 0,
            serviceRequests: 0,
            recentLogs: [],
        }),
    },
});

const kpis = [
    { label: 'Active Users & Scholars', key: 'users', trend: '+14.8%', icon: 'users', color: 'from-blue-600 to-indigo-600' },
    { label: 'Indexed Journals', key: 'journals', trend: '5 Active', icon: 'journals', color: 'from-emerald-600 to-teal-600' },
    { label: 'Published Articles', key: 'articles', trend: '+22.5%', icon: 'articles', color: 'from-purple-600 to-indigo-600' },
    { label: 'Editorial Submissions', key: 'manuscripts', trend: 'Under Review', icon: 'manuscripts', color: 'from-amber-500 to-orange-600' },
    { label: 'Peer Reviews Completed', key: 'reviews', trend: '+9.4%', icon: 'reviews', color: 'from-rose-500 to-pink-600' },
    { label: 'Registered Authors', key: 'researchers', trend: '+18.1%', icon: 'researchers', color: 'from-cyan-600 to-blue-600' },
];
</script>

<template>
    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-slate-900">Publisher Operations Dashboard</h1>
                    <p class="text-xs text-slate-500">Live system performance, editorial pipeline throughput, and scholarly publishing metrics.</p>
                </div>
                <div class="flex items-center gap-2">
                    <Link
                        href="/admin/settings"
                        class="px-3.5 py-1.5 rounded-lg text-xs font-bold text-white shadow-sm flex items-center gap-1.5 transition"
                        :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                    >
                        <span>🎨</span> Customize Theme
                    </Link>
                </div>
            </div>
        </template>

        <div class="space-y-8">
            <!-- 1. KPI Cards Grid with SaaS Trends -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-4">
                <div
                    v-for="kpi in kpis"
                    :key="kpi.key"
                    class="bg-white rounded-2xl border border-slate-200/80 p-4 shadow-xs hover:shadow-md transition duration-200 flex flex-col justify-between"
                >
                    <div class="flex items-center justify-between mb-3">
                        <div :class="['w-9 h-9 rounded-xl bg-gradient-to-br flex items-center justify-center text-white shadow-xs', kpi.color]">
                            <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                            </svg>
                        </div>
                        <span class="text-[10px] font-bold font-mono px-2 py-0.5 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
                            {{ kpi.trend }}
                        </span>
                    </div>

                    <div>
                        <span class="text-2xl font-extrabold text-slate-900 tracking-tight">
                            {{ stats[kpi.key] || 0 }}
                        </span>
                        <p class="text-xs font-semibold text-slate-500 mt-0.5 truncate">{{ kpi.label }}</p>
                    </div>
                </div>
            </div>

            <!-- 2. Main Operational Launchpad & Activity Split -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Quick Launchpad (2 Columns Wide on LG) -->
                <div class="lg:col-span-2 bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-6">
                    <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                        <div>
                            <h2 class="text-sm font-bold uppercase tracking-wider text-slate-900">
                                🚀 Publisher Quick Launchpad
                            </h2>
                            <p class="text-xs text-slate-500">Fast workflows for journal operations, monograph deposits, and editorial queues.</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                        <Link
                            href="/admin/journals"
                            class="p-4 rounded-xl border border-slate-200 hover:border-indigo-400 hover:bg-indigo-50/30 transition group flex items-start gap-3.5"
                        >
                            <div class="w-9 h-9 rounded-lg bg-indigo-100 text-indigo-700 flex items-center justify-center font-bold text-sm shrink-0 group-hover:scale-105 transition">
                                📚
                            </div>
                            <div>
                                <h4 class="text-xs font-bold text-slate-900 group-hover:text-indigo-700">Manage Journals</h4>
                                <p class="text-[11px] text-slate-500 mt-0.5">5 active international scholarly journals and volumes.</p>
                            </div>
                        </Link>

                        <Link
                            href="/admin/articles"
                            class="p-4 rounded-xl border border-slate-200 hover:border-purple-400 hover:bg-purple-50/30 transition group flex items-start gap-3.5"
                        >
                            <div class="w-9 h-9 rounded-lg bg-purple-100 text-purple-700 flex items-center justify-center font-bold text-sm shrink-0 group-hover:scale-105 transition">
                                📄
                            </div>
                            <div>
                                <h4 class="text-xs font-bold text-slate-900 group-hover:text-purple-700">Articles & DOIs</h4>
                                <p class="text-[11px] text-slate-500 mt-0.5">Crossref XML deposit and full-text metadata indexing.</p>
                            </div>
                        </Link>

                        <Link
                            href="/admin/cpanel-email"
                            class="p-4 rounded-xl border border-slate-200 hover:border-rose-400 hover:bg-rose-50/30 transition group flex items-start gap-3.5"
                        >
                            <div class="w-9 h-9 rounded-lg bg-rose-100 text-rose-700 flex items-center justify-center font-bold text-sm shrink-0 group-hover:scale-105 transition">
                                ✉️
                            </div>
                            <div>
                                <h4 class="text-xs font-bold text-slate-900 group-hover:text-rose-700">cPanel Email Suite</h4>
                                <p class="text-[11px] text-slate-500 mt-0.5">Approve academic email requests & UAPI settings.</p>
                            </div>
                        </Link>

                        <Link
                            href="/admin/settings"
                            class="p-4 rounded-xl border border-slate-200 hover:border-amber-400 hover:bg-amber-50/30 transition group flex items-start gap-3.5"
                        >
                            <div class="w-9 h-9 rounded-lg bg-amber-100 text-amber-700 flex items-center justify-center font-bold text-sm shrink-0 group-hover:scale-105 transition">
                                🎨
                            </div>
                            <div>
                                <h4 class="text-xs font-bold text-slate-900 group-hover:text-amber-700">Theme & Typography</h4>
                                <p class="text-[11px] text-slate-500 mt-0.5">Live color palette presets and Google Font pairings.</p>
                            </div>
                        </Link>
                    </div>
                </div>

                <!-- Platform Telemetry & Status (1 Column Wide) -->
                <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-5">
                    <div class="border-b border-slate-100 pb-3">
                        <h2 class="text-sm font-bold uppercase tracking-wider text-slate-900">
                            ⚡ System Status
                        </h2>
                    </div>

                    <div class="space-y-3.5 text-xs">
                        <div class="flex items-center justify-between p-2.5 rounded-lg bg-slate-50 border border-slate-100">
                            <span class="text-slate-600 font-medium">Hosting Target</span>
                            <span class="font-bold text-slate-900 font-mono">Hostinger Shared cPanel</span>
                        </div>

                        <div class="flex items-center justify-between p-2.5 rounded-lg bg-slate-50 border border-slate-100">
                            <span class="text-slate-600 font-medium">cPanel API Port</span>
                            <span class="font-bold text-slate-900 font-mono">2083 (UAPI SSL)</span>
                        </div>

                        <div class="flex items-center justify-between p-2.5 rounded-lg bg-slate-50 border border-slate-100">
                            <span class="text-slate-600 font-medium">Crossref DOI Prefix</span>
                            <span class="font-bold text-indigo-700 font-mono">10.58421</span>
                        </div>

                        <div class="flex items-center justify-between p-2.5 rounded-lg bg-slate-50 border border-slate-100">
                            <span class="text-slate-600 font-medium">Active Theme Preset</span>
                            <span class="font-bold text-slate-900 uppercase font-mono">{{ theme.preset || 'Oxford Navy' }}</span>
                        </div>
                    </div>

                    <div class="pt-2">
                        <a
                            href="/"
                            target="_blank"
                            class="w-full py-2.5 bg-slate-900 hover:bg-slate-800 text-white rounded-lg font-bold text-xs transition flex items-center justify-center gap-1.5 shadow-xs"
                        >
                            Open Public Site ↗
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
