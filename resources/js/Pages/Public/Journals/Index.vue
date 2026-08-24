<script setup>
import { computed, ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';

const props = defineProps({
    journals: {
        type: Object,
        default: () => ({ data: [] }),
    },
    filters: {
        type: Object,
        default: () => ({ search: '' }),
    },
});

const searchQuery = ref(props.filters?.search || '');
const selectedDiscipline = ref('all');

const journalsList = computed(() => {
    const list = props.journals?.data || (Array.isArray(props.journals) ? props.journals : []);
    if (selectedDiscipline.value === 'all') return list;

    return list.filter(j => {
        if (!j.disciplines || !Array.isArray(j.disciplines)) return true;
        return j.disciplines.some(d => d.toLowerCase().includes(selectedDiscipline.value.toLowerCase()));
    });
});

const handleSearch = () => {
    router.get(route('journals.index'), { search: searchQuery.value }, { preserveState: true, replace: true });
};

const disciplinesList = [
    { id: 'all', name: 'All Disciplines' },
    { id: 'medicine', name: 'Medicine & Health' },
    { id: 'food', name: 'Food & Nutrition' },
    { id: 'asian', name: 'Asian Studies & Humanities' },
    { id: 'business', name: 'Business & Finance' },
    { id: 'theology', name: 'Religion & Ethics' },
];
</script>

<template>
    <Head>
        <title>Peer-Reviewed Academic Journals — Knowledge Dynamics</title>
        <meta name="description" content="Explore international peer-reviewed, open-access scholarly journals published by Knowledge Dynamics across medical sciences, health dynamics, food nutrition, Asian studies, and finance." />
    </Head>

    <PublicLayout>
        <!-- Scholarly Hero Header -->
        <section class="relative bg-[#070d1e] text-white py-16 md:py-24 overflow-hidden border-b border-slate-800">
            <!-- Background Glows and Grid -->
            <div class="absolute inset-0 bg-[radial-gradient(#1e293b_1px,transparent_1px)] [background-size:24px_24px] opacity-25"></div>
            <div class="absolute -top-40 -right-40 w-96 h-96 bg-indigo-600/20 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute -bottom-40 -left-40 w-96 h-96 bg-rose-600/15 rounded-full blur-3xl pointer-events-none"></div>

            <div class="container-wide relative z-10">
                <div class="max-w-4xl mx-auto text-center space-y-6">
                    <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-indigo-950/80 border border-indigo-700/50 text-indigo-300 text-xs font-bold uppercase tracking-wider shadow-inner">
                        <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
                        <span>Open Access Journal Repository</span>
                        <span class="text-indigo-500">•</span>
                        <span>Crossref DOI Indexed</span>
                    </div>

                    <h1 class="text-3xl sm:text-5xl md:text-6xl font-black tracking-tight text-white leading-tight">
                        Scholarly Peer-Reviewed <br class="hidden sm:block" />
                        <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-300 via-indigo-200 to-rose-300">
                            Academic Journals
                        </span>
                    </h1>

                    <p class="text-slate-300 text-sm sm:text-base md:text-lg leading-relaxed max-w-2xl mx-auto">
                        Discover authoritative open-access publications upholding international COPE ethical guidelines, rapid expert peer review, and worldwide Crossref DOI digital preservation.
                    </p>

                    <!-- Search Bar -->
                    <div class="pt-4 max-w-2xl mx-auto">
                        <form @submit.prevent="handleSearch" class="flex flex-col sm:flex-row items-center gap-2.5 bg-slate-900/90 p-2 rounded-2xl border border-slate-700 shadow-2xl backdrop-blur-md">
                            <div class="relative flex-1 w-full">
                                <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-sm">🔍</span>
                                <input
                                    v-model="searchQuery"
                                    type="text"
                                    placeholder="Search by title, ISSN, discipline, or keywords..."
                                    class="w-full bg-transparent text-white placeholder-slate-400 pl-10 pr-4 py-3 text-xs sm:text-sm focus:outline-none"
                                />
                            </div>
                            <button
                                type="submit"
                                class="w-full sm:w-auto px-6 py-3 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-bold text-xs sm:text-sm shadow-md transition whitespace-nowrap cursor-pointer"
                            >
                                Search Journals
                            </button>
                        </form>
                    </div>

                    <!-- Category Pills -->
                    <div class="flex items-center justify-center gap-2 flex-wrap pt-2">
                        <button
                            v-for="disc in disciplinesList"
                            :key="disc.id"
                            type="button"
                            @click="selectedDiscipline = disc.id"
                            class="px-3.5 py-1.5 rounded-full text-xs font-semibold transition cursor-pointer"
                            :class="selectedDiscipline === disc.id ? 'bg-indigo-600 text-white shadow-sm' : 'bg-slate-800/80 text-slate-300 hover:bg-slate-700 border border-slate-700'"
                        >
                            {{ disc.name }}
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Journals Catalog Grid -->
        <section class="section bg-slate-50/70 py-12 md:py-16">
            <div class="container-wide">
                <!-- Zero State -->
                <div v-if="journalsList.length === 0" class="text-center py-20 bg-white rounded-3xl border border-slate-200 shadow-xs max-w-2xl mx-auto p-8">
                    <div class="w-16 h-16 rounded-2xl bg-indigo-50 text-indigo-600 flex items-center justify-center mx-auto text-2xl mb-4">
                        📚
                    </div>
                    <h3 class="text-xl font-bold text-slate-900">No journals found</h3>
                    <p class="text-sm text-slate-500 mt-2 mb-6">No published journals match your selected search keywords or discipline filter.</p>
                    <button
                        @click="searchQuery = ''; selectedDiscipline = 'all'; handleSearch()"
                        class="px-5 py-2.5 bg-slate-900 text-white rounded-xl text-xs font-bold hover:bg-slate-800 transition"
                    >
                        Reset All Filters
                    </button>
                </div>

                <!-- Journal Cards List -->
                <div v-else class="grid grid-cols-1 gap-8">
                    <article
                        v-for="journal in journalsList"
                        :key="journal.slug"
                        class="bg-white rounded-3xl border border-slate-200/90 shadow-sm hover:shadow-xl transition-all duration-300 overflow-hidden flex flex-col justify-between group"
                    >
                        <!-- Top Header & Badges -->
                        <div class="p-6 md:p-8 space-y-6">
                            <!-- Badges row -->
                            <div class="flex flex-wrap items-center justify-between gap-3">
                                <div class="flex flex-wrap items-center gap-2">
                                    <span v-if="journal.is_open_access" class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-extrabold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                        Open Access (CC BY 4.0)
                                    </span>
                                    <span class="px-2.5 py-1 rounded-full text-xs font-semibold bg-slate-100 text-slate-700 border border-slate-200">
                                        {{ journal.publication_frequency || 'Quarterly' }}
                                    </span>
                                    <span class="px-2.5 py-1 rounded-full text-xs font-semibold bg-indigo-50 text-indigo-700 border border-indigo-200 font-mono">
                                        Est. {{ journal.established_year || '2021' }}
                                    </span>
                                </div>

                                <!-- Fast Website Action Indicator -->
                                <a
                                    :href="journal.effective_website_url"
                                    :target="journal.website_url ? '_blank' : '_self'"
                                    class="inline-flex items-center gap-1.5 text-xs font-bold text-indigo-600 hover:text-indigo-800 bg-indigo-50 hover:bg-indigo-100 px-3.5 py-1.5 rounded-xl border border-indigo-200 transition shadow-xs"
                                >
                                    <span>🌐 Visit Official Journal Website</span>
                                    <span class="font-mono">↗</span>
                                </a>
                            </div>

                            <!-- Main Title & Short Title -->
                            <div class="space-y-1.5">
                                <h2 class="text-2xl sm:text-3xl font-black text-slate-900 group-hover:text-indigo-600 transition">
                                    <Link :href="route('journals.show', journal.slug)">
                                        {{ journal.title }}
                                    </Link>
                                </h2>
                                <div class="flex flex-wrap items-center gap-3 text-xs text-slate-500 font-mono">
                                    <span v-if="journal.short_title" class="font-bold text-slate-700">Abbreviation: {{ journal.short_title }}</span>
                                    <span>•</span>
                                    <span>Online ISSN: <strong class="text-slate-800">{{ journal.issn_online || 'Pending' }}</strong></span>
                                    <span v-if="journal.issn_print">• Print ISSN: <strong class="text-slate-800">{{ journal.issn_print }}</strong></span>
                                </div>
                            </div>

                            <!-- Description -->
                            <p class="text-sm text-slate-600 leading-relaxed line-clamp-3">
                                {{ journal.description || journal.aims_and_scope }}
                            </p>

                            <!-- Academic Speed & Metric Highlights Cards -->
                            <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 pt-2">
                                <div class="bg-slate-50/80 rounded-2xl p-3.5 border border-slate-200/80">
                                    <span class="text-[10px] uppercase font-bold text-slate-400 tracking-wider block">Citation Metric</span>
                                    <span class="text-base font-black text-slate-900 block mt-0.5">CiteScore {{ journal.citescore || '3.5' }}</span>
                                    <span class="text-[10px] text-indigo-600 font-semibold">Impact: {{ journal.impact_factor || '2.4' }}</span>
                                </div>

                                <div class="bg-slate-50/80 rounded-2xl p-3.5 border border-slate-200/80">
                                    <span class="text-[10px] uppercase font-bold text-slate-400 tracking-wider block">First Decision</span>
                                    <span class="text-base font-black text-slate-900 block mt-0.5">{{ journal.review_time_days || '18' }} Days</span>
                                    <span class="text-[10px] text-emerald-600 font-semibold">⚡ Rapid Peer Review</span>
                                </div>

                                <div class="bg-slate-50/80 rounded-2xl p-3.5 border border-slate-200/80">
                                    <span class="text-[10px] uppercase font-bold text-slate-400 tracking-wider block">Acceptance Rate</span>
                                    <span class="text-base font-black text-slate-900 block mt-0.5">{{ journal.acceptance_rate || '28' }}%</span>
                                    <span class="text-[10px] text-slate-500 font-medium">Selective Rigor</span>
                                </div>

                                <div class="bg-slate-50/80 rounded-2xl p-3.5 border border-slate-200/80">
                                    <span class="text-[10px] uppercase font-bold text-slate-400 tracking-wider block">Publication Time</span>
                                    <span class="text-base font-black text-slate-900 block mt-0.5">{{ journal.publication_time_days || '7' }} Days</span>
                                    <span class="text-[10px] text-blue-600 font-semibold">Acceptance to Online</span>
                                </div>
                            </div>

                            <!-- Subject Disciplines Tags -->
                            <div v-if="journal.disciplines && journal.disciplines.length > 0" class="flex flex-wrap items-center gap-1.5 pt-1">
                                <span class="text-[11px] font-bold text-slate-400 uppercase tracking-wider mr-1">Scope:</span>
                                <span
                                    v-for="(disc, dIdx) in journal.disciplines"
                                    :key="dIdx"
                                    class="px-2.5 py-1 rounded-lg bg-indigo-50/60 text-indigo-800 text-[11px] font-medium border border-indigo-100"
                                >
                                    {{ disc }}
                                </span>
                            </div>

                            <!-- Indexing Badges Chips -->
                            <div class="flex flex-wrap items-center gap-2 pt-2 border-t border-slate-100">
                                <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Indexed in:</span>
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-md bg-slate-100 text-slate-700 text-[11px] font-medium">
                                    <span>🏛️</span> Crossref DOI
                                </span>
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-md bg-slate-100 text-slate-700 text-[11px] font-medium">
                                    <span>🔍</span> Google Scholar
                                </span>
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-md bg-slate-100 text-slate-700 text-[11px] font-medium">
                                    <span>📖</span> DOAJ Compatible
                                </span>
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-md bg-slate-100 text-slate-700 text-[11px] font-medium">
                                    <span>🛡️</span> COPE Member
                                </span>
                                <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-md bg-slate-100 text-slate-700 text-[11px] font-medium">
                                    <span>💾</span> Portico Preserved
                                </span>
                            </div>
                        </div>

                        <!-- Bottom Interactive Action Bar -->
                        <div class="bg-slate-900 px-6 md:px-8 py-4 border-t border-slate-800 flex flex-col sm:flex-row items-center justify-between gap-4 text-white">
                            <div class="flex flex-wrap items-center gap-2.5 w-full sm:w-auto">
                                <!-- Primary Action: Visit Journal Website -->
                                <a
                                    :href="journal.effective_website_url"
                                    :target="journal.website_url ? '_blank' : '_self'"
                                    class="flex-1 sm:flex-none px-4 py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-xs shadow-md flex items-center justify-center gap-1.5 transition cursor-pointer"
                                >
                                    <span>🌐 Visit Journal Website</span>
                                    <span class="font-mono text-[10px]">↗</span>
                                </a>

                                <Link
                                    :href="journal.effective_submission_url"
                                    class="flex-1 sm:flex-none px-4 py-2.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs border border-slate-700 flex items-center justify-center gap-1.5 transition"
                                >
                                    <span>📝 Submit Manuscript</span>
                                </Link>

                                <Link
                                    :href="route('journals.archive', journal.slug)"
                                    class="flex-1 sm:flex-none px-3.5 py-2.5 rounded-xl bg-slate-800/80 hover:bg-slate-700 text-slate-300 hover:text-white font-semibold text-xs border border-slate-700 flex items-center justify-center gap-1 transition"
                                >
                                    <span>📚 Archive</span>
                                </Link>
                            </div>

                            <div class="flex items-center gap-4 text-xs font-semibold text-slate-300 w-full sm:w-auto justify-between sm:justify-end">
                                <Link :href="route('journals.editorial_board', journal.slug)" class="hover:text-white underline underline-offset-4 transition">
                                    Editorial Board →
                                </Link>
                                <Link :href="route('journals.show', journal.slug)" class="text-indigo-400 hover:text-indigo-300 transition flex items-center gap-1">
                                    <span>Journal Portal</span>
                                    <span>→</span>
                                </Link>
                            </div>
                        </div>
                    </article>
                </div>

                <!-- Pagination -->
                <div v-if="props.journals?.links && props.journals.links.length > 3" class="mt-12 flex justify-center">
                    <div class="flex gap-1.5 bg-white p-2 rounded-2xl border border-slate-200 shadow-sm">
                        <template v-for="(link, i) in props.journals.links" :key="i">
                            <Link
                                v-if="link.url"
                                :href="link.url"
                                v-html="link.label"
                                class="px-4 py-2 text-xs font-bold rounded-xl transition"
                                :class="link.active ? 'bg-indigo-600 text-white shadow-sm' : 'text-slate-700 hover:bg-slate-100'"
                            />
                            <span v-else v-html="link.label" class="px-4 py-2 text-xs text-slate-400 rounded-xl" />
                        </template>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
