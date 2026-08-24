<script setup>
import { computed } from 'vue';
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
    currentIssue: {
        type: Object,
        default: null,
    },
    recentIssues: {
        type: Array,
        default: () => [],
    },
    boardPreview: {
        type: Array,
        default: () => [],
    },
});

const isExternalWebsite = computed(() => {
    return !!(props.journal.website_url && !props.journal.website_url.includes('/journals/' + props.journal.slug));
});
</script>

<template>
    <Head>
        <title>{{ journal.title }} — Knowledge Dynamics</title>
        <meta name="description" :content="journal.description || journal.aims_and_scope" />
        <meta name="citation_journal_title" :content="journal.title" />
        <meta v-if="journal.issn_online" name="citation_issn" :content="journal.issn_online" />
        <meta name="citation_publisher" :content="journal.publisher || 'Knowledge Dynamics'" />
    </Head>

    <PublicLayout>
        <!-- Journal Hero Header -->
        <section class="relative bg-[#070d1e] text-white pt-12 pb-12 border-b border-slate-800 overflow-hidden">
            <!-- Background Glows -->
            <div class="absolute inset-0 bg-[radial-gradient(#1e293b_1px,transparent_1px)] [background-size:24px_24px] opacity-25"></div>
            <div class="absolute -top-32 -right-32 w-96 h-96 bg-indigo-600/20 rounded-full blur-3xl pointer-events-none"></div>

            <div class="container-wide relative z-10">
                <!-- Breadcrumbs -->
                <nav class="flex items-center gap-2 text-xs text-slate-400 mb-6 font-medium">
                    <Link :href="route('home')" class="hover:text-white transition">Home</Link>
                    <span>/</span>
                    <Link :href="route('journals.index')" class="hover:text-white transition">Journals</Link>
                    <span>/</span>
                    <span class="text-indigo-300 font-semibold truncate max-w-xs sm:max-w-md">{{ journal.title }}</span>
                </nav>

                <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-8">
                    <!-- Left Hero Content -->
                    <div class="max-w-3xl space-y-4">
                        <!-- Badges -->
                        <div class="flex flex-wrap items-center gap-2">
                            <span v-if="journal.is_open_access" class="inline-flex items-center gap-1 text-xs font-bold text-emerald-400 bg-emerald-950/80 px-3 py-1 rounded-full border border-emerald-500/30">
                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                                Open Access (CC BY 4.0)
                            </span>
                            <span class="text-xs text-indigo-300 font-mono bg-indigo-950/80 px-3 py-1 rounded-full border border-indigo-700/50">
                                ISSN: {{ journal.issn_online || 'Pending' }} (Online)
                            </span>
                            <span v-if="journal.issn_print" class="text-xs text-slate-400 font-mono bg-slate-900 px-3 py-1 rounded-full border border-slate-800">
                                Print: {{ journal.issn_print }}
                            </span>
                            <span class="text-xs text-slate-300 font-semibold bg-slate-800 px-3 py-1 rounded-full border border-slate-700">
                                {{ journal.publication_frequency || 'Quarterly' }}
                            </span>
                        </div>

                        <!-- Journal Title -->
                        <h1 class="text-3xl sm:text-4xl md:text-5xl font-black tracking-tight text-white leading-tight">
                            {{ journal.title }}
                        </h1>
                        <p v-if="journal.short_title" class="text-sm font-mono text-indigo-300 font-semibold">
                            ISO Abbreviation: {{ journal.short_title }}
                        </p>

                        <!-- Journal Description -->
                        <p class="text-sm sm:text-base text-slate-300 leading-relaxed max-w-2xl">
                            {{ journal.description }}
                        </p>

                        <!-- Hero Primary Action Buttons -->
                        <div class="pt-4 flex flex-wrap items-center gap-3">
                            <!-- 1. Visit Official Journal Website Button -->
                            <a
                                :href="journal.effective_website_url"
                                :target="isExternalWebsite ? '_blank' : '_self'"
                                class="px-6 py-3 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-xs sm:text-sm shadow-xl shadow-indigo-500/20 flex items-center gap-2 transition duration-200 cursor-pointer"
                            >
                                <span>🌐 Visit Official Journal Website</span>
                                <span class="font-mono text-xs">↗</span>
                            </a>

                            <!-- 2. Submit Manuscript to this Journal -->
                            <Link
                                :href="journal.effective_submission_url"
                                class="px-5 py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs sm:text-sm border border-slate-700 shadow-md flex items-center gap-2 transition"
                            >
                                <span>📝 Submit Manuscript</span>
                            </Link>

                            <!-- 3. Current Issue -->
                            <a
                                href="#current-issue"
                                class="px-4 py-3 rounded-xl bg-slate-900/80 hover:bg-slate-800 text-slate-300 hover:text-white font-semibold text-xs sm:text-sm border border-slate-800 transition"
                            >
                                <span>📖 Current Issue</span>
                            </a>
                        </div>
                    </div>

                    <!-- Right Key Metrics Card -->
                    <div class="bg-slate-900/90 border border-slate-800 rounded-3xl p-6 shrink-0 w-full lg:w-80 shadow-2xl backdrop-blur-md space-y-4">
                        <div class="flex items-center justify-between border-b border-slate-800 pb-3">
                            <span class="text-xs uppercase tracking-wider font-extrabold text-indigo-400 flex items-center gap-1.5">
                                <span>⚡</span> Journal Metrics
                            </span>
                            <span class="text-[10px] font-mono text-emerald-400 bg-emerald-950/60 px-2 py-0.5 rounded-full border border-emerald-500/30">
                                Verified 2026
                            </span>
                        </div>

                        <div class="grid grid-cols-2 gap-3 text-xs">
                            <div class="bg-slate-950/60 p-3 rounded-2xl border border-slate-800/80">
                                <span class="text-[10px] text-slate-400 font-bold uppercase block">CiteScore</span>
                                <span class="text-lg font-black text-white block mt-0.5">{{ journal.citescore || '3.8' }}</span>
                                <span class="text-[10px] text-indigo-400">Impact: {{ journal.impact_factor || '2.9' }}</span>
                            </div>

                            <div class="bg-slate-950/60 p-3 rounded-2xl border border-slate-800/80">
                                <span class="text-[10px] text-slate-400 font-bold uppercase block">First Decision</span>
                                <span class="text-lg font-black text-emerald-400 block mt-0.5">{{ journal.review_time_days || '18' }}d</span>
                                <span class="text-[10px] text-slate-400">Peer Review</span>
                            </div>

                            <div class="bg-slate-950/60 p-3 rounded-2xl border border-slate-800/80">
                                <span class="text-[10px] text-slate-400 font-bold uppercase block">Acceptance</span>
                                <span class="text-lg font-black text-white block mt-0.5">{{ journal.acceptance_rate || '28' }}%</span>
                                <span class="text-[10px] text-slate-400">Selective</span>
                            </div>

                            <div class="bg-slate-950/60 p-3 rounded-2xl border border-slate-800/80">
                                <span class="text-[10px] text-slate-400 font-bold uppercase block">Production</span>
                                <span class="text-lg font-black text-blue-400 block mt-0.5">{{ journal.publication_time_days || '7' }}d</span>
                                <span class="text-[10px] text-slate-400">Online Release</span>
                            </div>
                        </div>

                        <div class="space-y-2 pt-2 border-t border-slate-800 text-xs">
                            <div class="flex justify-between py-1 border-b border-slate-800/50">
                                <span class="text-slate-400">Publisher:</span>
                                <span class="text-white font-semibold">{{ journal.publisher || 'Knowledge Dynamics' }}</span>
                            </div>
                            <div class="flex justify-between py-1 border-b border-slate-800/50">
                                <span class="text-slate-400">Review Model:</span>
                                <span class="text-indigo-300 font-medium capitalize">{{ (journal.settings?.review_model || 'Double Blind').replace('_', ' ') }}</span>
                            </div>
                            <div class="flex justify-between py-1">
                                <span class="text-slate-400">Article Fee (APC):</span>
                                <span class="text-white font-semibold">{{ journal.apc_amount || '$450 USD' }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab Navigation Anchor Bar -->
                <div class="mt-10 pt-4 border-t border-slate-800/80 flex flex-wrap gap-2 text-xs sm:text-sm font-semibold">
                    <a href="#aims" class="px-4 py-2 rounded-xl bg-indigo-600 text-white shadow-sm">Overview & Aims</a>
                    <a href="#current-issue" class="px-4 py-2 rounded-xl bg-slate-900 text-slate-300 hover:bg-slate-800 hover:text-white transition">Current Issue</a>
                    <Link :href="route('journals.issues', journal.slug)" class="px-4 py-2 rounded-xl bg-slate-900 text-slate-300 hover:bg-slate-800 hover:text-white transition">All Issues</Link>
                    <Link :href="route('journals.archive', journal.slug)" class="px-4 py-2 rounded-xl bg-slate-900 text-slate-300 hover:bg-slate-800 hover:text-white transition">Archive</Link>
                    <Link :href="route('journals.editorial_board', journal.slug)" class="px-4 py-2 rounded-xl bg-slate-900 text-slate-300 hover:bg-slate-800 hover:text-white transition">Editorial Board</Link>
                    <a href="#guidelines" class="px-4 py-2 rounded-xl bg-slate-900 text-slate-300 hover:bg-slate-800 hover:text-white transition">Author Guidelines</a>
                    <a href="#indexing" class="px-4 py-2 rounded-xl bg-slate-900 text-slate-300 hover:bg-slate-800 hover:text-white transition">Indexing & Preservation</a>
                </div>
            </div>
        </section>

        <!-- Call For Papers / Special Issue Banner -->
        <section v-if="journal.special_issue_title" class="bg-gradient-to-r from-indigo-900 via-blue-900 to-slate-900 text-white py-6 border-b border-indigo-800/60">
            <div class="container-wide">
                <div class="bg-white/10 rounded-2xl p-5 border border-white/15 backdrop-blur-md flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div class="space-y-1">
                        <div class="flex items-center gap-2">
                            <span class="px-2.5 py-0.5 rounded-md bg-rose-500 text-white text-[10px] font-black uppercase tracking-wider">
                                Active Call For Papers
                            </span>
                            <span v-if="journal.special_issue_deadline" class="text-xs text-indigo-200 font-mono">
                                Submission Deadline: <strong>{{ journal.special_issue_deadline }}</strong>
                            </span>
                        </div>
                        <h3 class="text-lg font-black text-white">{{ journal.special_issue_title }}</h3>
                        <p class="text-xs text-slate-200 line-clamp-2 max-w-3xl leading-relaxed">{{ journal.special_issue_description }}</p>
                    </div>

                    <Link
                        :href="journal.effective_submission_url"
                        class="px-5 py-2.5 rounded-xl bg-white hover:bg-slate-100 text-indigo-900 font-black text-xs shadow-lg transition whitespace-nowrap shrink-0 flex items-center justify-center gap-1.5"
                    >
                        <span>Submit to Special Issue</span>
                        <span class="font-mono">→</span>
                    </Link>
                </div>
            </div>
        </section>

        <!-- Main Body Grid -->
        <div class="container-wide py-12 md:py-16">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
                <!-- Left 2 Columns -->
                <div class="lg:col-span-2 space-y-10">
                    <!-- Aims and Scope -->
                    <section id="aims" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="flex items-center gap-3 border-b border-slate-100 pb-4">
                            <span class="text-2xl">🎯</span>
                            <div>
                                <h2 class="text-xl md:text-2xl font-black text-slate-900">Aims & Scholarly Scope</h2>
                                <p class="text-xs text-slate-500">Mission, disciplinary focus, and research publication criteria.</p>
                            </div>
                        </div>

                        <div class="prose prose-sm max-w-none text-slate-700 leading-relaxed whitespace-pre-line text-sm">
                            {{ journal.aims_and_scope || journal.description }}
                        </div>

                        <!-- Subject Disciplines Tags -->
                        <div v-if="journal.disciplines && journal.disciplines.length > 0" class="pt-4 border-t border-slate-100">
                            <h4 class="text-xs font-bold text-slate-900 uppercase tracking-wider mb-3">Key Subject Disciplines & Coverage</h4>
                            <div class="flex flex-wrap gap-2">
                                <span
                                    v-for="(disc, dIdx) in journal.disciplines"
                                    :key="dIdx"
                                    class="px-3.5 py-1.5 rounded-xl bg-indigo-50 text-indigo-900 text-xs font-semibold border border-indigo-200 flex items-center gap-1.5"
                                >
                                    <span>🔬</span>
                                    <span>{{ disc }}</span>
                                </span>
                            </div>
                        </div>
                    </section>

                    <!-- Current / Latest Issue -->
                    <section id="current-issue" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 border-b border-slate-100 pb-4">
                            <div class="flex items-center gap-3">
                                <span class="text-2xl">📖</span>
                                <div>
                                    <span class="text-[10px] uppercase tracking-wider text-indigo-600 font-extrabold">Current Issue</span>
                                    <h2 class="text-xl md:text-2xl font-black text-slate-900">
                                        {{ currentIssue ? `Vol. ${currentIssue.volume?.number || 1}, Issue ${currentIssue.number} (${currentIssue.volume?.year || '2026'})` : 'Current Issue' }}
                                    </h2>
                                </div>
                            </div>
                            <Link :href="route('journals.archive', journal.slug)" class="text-xs font-bold text-indigo-600 hover:text-indigo-800 bg-indigo-50 px-3.5 py-1.5 rounded-xl border border-indigo-200 transition">
                                Browse All Volumes →
                            </Link>
                        </div>

                        <!-- Articles in current issue -->
                        <div v-if="currentIssue && currentIssue.articles && currentIssue.articles.length > 0" class="space-y-4">
                            <article
                                v-for="article in currentIssue.articles"
                                :key="article.id"
                                class="p-5 rounded-2xl bg-slate-50/80 border border-slate-200/80 hover:bg-slate-100/80 hover:border-indigo-200 transition group space-y-3"
                            >
                                <div class="flex flex-wrap items-center justify-between gap-2 text-xs text-slate-500 font-medium">
                                    <div class="flex items-center gap-2">
                                        <span class="px-2.5 py-0.5 rounded-md bg-indigo-100 text-indigo-800 font-bold text-[10px] uppercase tracking-wider">
                                            {{ article.article_type || 'Research Article' }}
                                        </span>
                                        <span>Pages: {{ article.pages || '1-16' }}</span>
                                    </div>
                                    <span v-if="article.doi" class="font-mono text-slate-600 text-[11px]">
                                        DOI: {{ article.doi }}
                                    </span>
                                </div>

                                <h3 class="text-base font-bold text-slate-900 group-hover:text-indigo-600 transition">
                                    <Link :href="route('articles.show', article.slug)">
                                        {{ article.title }}
                                    </Link>
                                </h3>

                                <p class="text-xs text-slate-600 font-medium">
                                    <span v-for="(author, aIdx) in article.authors" :key="author.id">
                                        {{ author.first_name }} {{ author.last_name }}<span v-if="aIdx < article.authors.length - 1">, </span>
                                    </span>
                                </p>

                                <p v-if="article.abstract" class="text-xs text-slate-600 line-clamp-2 leading-relaxed">
                                    {{ article.abstract }}
                                </p>

                                <div class="pt-2 flex items-center justify-between border-t border-slate-200/60">
                                    <Link :href="route('articles.show', article.slug)" class="text-xs font-bold text-indigo-600 hover:text-indigo-800">
                                        Read Full Article & PDF →
                                    </Link>
                                    <span class="text-[11px] text-emerald-600 font-semibold">Open Access CC BY 4.0</span>
                                </div>
                            </article>
                        </div>

                        <div v-else class="text-center py-10 bg-slate-50 rounded-2xl border border-slate-200/70 p-6 space-y-2">
                            <p class="text-sm font-bold text-slate-800">Articles for this issue are currently in editorial peer review and layout production.</p>
                            <p class="text-xs text-slate-500">Explore past published volumes in the archive or submit your own research manuscript.</p>
                        </div>
                    </section>

                    <!-- Author Guidelines & Editorial Ethics -->
                    <section id="guidelines" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="flex items-center gap-3 border-b border-slate-100 pb-4">
                            <span class="text-2xl">✍️</span>
                            <div>
                                <h2 class="text-xl md:text-2xl font-black text-slate-900">Author Guidelines & Editorial Policies</h2>
                                <p class="text-xs text-slate-500">Manuscript preparation standards, ethics, and licensing criteria.</p>
                            </div>
                        </div>

                        <div class="space-y-6 text-sm text-slate-700">
                            <!-- Peer Review Process -->
                            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200/80 space-y-1.5">
                                <h3 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <span>🔍</span> Peer Review Model & Turnaround
                                </h3>
                                <p class="text-slate-600 text-xs sm:text-sm leading-relaxed">
                                    {{ journal.settings?.peer_review_process || 'All submitted manuscripts undergo double-blind peer review by at least two independent international experts. Authors receive first decision within 18 days on average.' }}
                                </p>
                            </div>

                            <!-- Open Access Policy -->
                            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200/80 space-y-1.5">
                                <h3 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <span>🌐</span> Open Access & Creative Commons Licensing
                                </h3>
                                <p class="text-slate-600 text-xs sm:text-sm leading-relaxed">
                                    {{ journal.settings?.open_access_policy || 'Articles are published under the Creative Commons Attribution 4.0 International (CC BY 4.0) License. Authors retain copyright without restrictions.' }}
                                </p>
                            </div>

                            <!-- Author Fees & APC -->
                            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200/80 space-y-1.5">
                                <h3 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <span>💳</span> Article Processing Charges (APC) & Waivers
                                </h3>
                                <p class="text-slate-600 text-xs sm:text-sm leading-relaxed">
                                    {{ journal.settings?.author_fees || 'Standard APC is ' + (journal.apc_amount || '$450 USD') + '. Full fee waivers are provided for scholars from developing economies and institutions facing financial constraints.' }}
                                </p>
                            </div>

                            <!-- Publication Ethics -->
                            <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200/80 space-y-1.5">
                                <h3 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <span>🛡️</span> Publication Ethics & Plagiarism Screening
                                </h3>
                                <p class="text-slate-600 text-xs sm:text-sm leading-relaxed">
                                    {{ journal.settings?.publication_ethics || 'Knowledge Dynamics strictly adheres to COPE guidelines. All submitted manuscripts are screened using Crossref Similarity Check (iThenticate) before peer review.' }}
                                </p>
                            </div>
                        </div>
                    </section>

                    <!-- Official Indexing & Preservation Section -->
                    <section id="indexing" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="flex items-center gap-3 border-b border-slate-100 pb-4">
                            <span class="text-2xl">🏛️</span>
                            <div>
                                <h2 class="text-xl md:text-2xl font-black text-slate-900">Indexing, Abstracting & Preservation</h2>
                                <p class="text-xs text-slate-500">Official repositories and preservation networks indexing this journal.</p>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-3">
                                <span class="text-xl">🔗</span>
                                <div>
                                    <h4 class="text-xs font-bold text-slate-900">Crossref DOI Minting</h4>
                                    <p class="text-[11px] text-slate-500 mt-0.5">Every article receives a permanent Crossref DOI for global citation tracking.</p>
                                </div>
                            </div>

                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-3">
                                <span class="text-xl">🔍</span>
                                <div>
                                    <h4 class="text-xs font-bold text-slate-900">Google Scholar Indexed</h4>
                                    <p class="text-[11px] text-slate-500 mt-0.5">Automated Highwire Press metadata feeds for immediate indexing.</p>
                                </div>
                            </div>

                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-3">
                                <span class="text-xl">📖</span>
                                <div>
                                    <h4 class="text-xs font-bold text-slate-900">DOAJ Open Access Compatible</h4>
                                    <p class="text-[11px] text-slate-500 mt-0.5">Complies with all Directory of Open Access Journals standards.</p>
                                </div>
                            </div>

                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-3">
                                <span class="text-xl">💾</span>
                                <div>
                                    <h4 class="text-xs font-bold text-slate-900">Portico Digital Preservation</h4>
                                    <p class="text-[11px] text-slate-500 mt-0.5">Permanent digital archival preservation ensures long-term scholarly access.</p>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Right Sidebar -->
                <div class="space-y-8">
                    <!-- Submission Action Box -->
                    <div class="bg-gradient-to-br from-indigo-950 via-slate-900 to-slate-950 text-white rounded-3xl p-6 shadow-xl border border-slate-800 space-y-4">
                        <span class="text-[10px] font-extrabold uppercase tracking-wider text-indigo-400 bg-indigo-950 px-2.5 py-1 rounded-md border border-indigo-800">
                            Author Portal
                        </span>
                        <h3 class="text-xl font-black text-white">Submit to {{ journal.short_title || journal.title }}</h3>
                        <p class="text-xs text-slate-300 leading-relaxed">
                            Original empirical investigations, systematic reviews, and critical studies are welcomed for peer review.
                        </p>

                        <div class="pt-2 space-y-2">
                            <Link
                                :href="journal.effective_submission_url"
                                class="w-full py-3 px-4 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-xs text-center block shadow-lg shadow-indigo-500/25 transition"
                            >
                                <span>🚀 Start Manuscript Submission</span>
                            </Link>

                            <a
                                :href="journal.effective_website_url"
                                :target="isExternalWebsite ? '_blank' : '_self'"
                                class="w-full py-2.5 px-4 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-200 font-bold text-xs text-center block border border-slate-700 transition"
                            >
                                <span>🌐 Visit Journal Website ↗</span>
                            </a>
                        </div>

                        <div class="pt-3 border-t border-slate-800 text-[11px] text-slate-400 space-y-1">
                            <div class="flex items-center gap-1.5">
                                <span class="text-emerald-400">✓</span>
                                <span>{{ journal.review_time_days || '18' }} days average peer review</span>
                            </div>
                            <div class="flex items-center gap-1.5">
                                <span class="text-emerald-400">✓</span>
                                <span>Immediate Crossref DOI assignment</span>
                            </div>
                        </div>
                    </div>

                    <!-- Editorial Board Leadership Preview -->
                    <div class="bg-white rounded-3xl border border-slate-200 p-6 shadow-sm space-y-4">
                        <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                            <h3 class="font-black text-slate-900 text-base flex items-center gap-2">
                                <span>👥</span> Editorial Leadership
                            </h3>
                            <Link :href="route('journals.editorial_board', journal.slug)" class="text-xs font-bold text-indigo-600 hover:text-indigo-800">
                                View All →
                            </Link>
                        </div>

                        <div v-if="boardPreview.length > 0" class="space-y-4">
                            <div
                                v-for="member in boardPreview"
                                :key="member.id"
                                class="pb-3 border-b border-slate-100 last:border-0 last:pb-0 space-y-0.5"
                            >
                                <p class="text-xs font-bold text-slate-900">{{ member.name }}</p>
                                <p class="text-[11px] font-semibold text-indigo-600">{{ member.role }}</p>
                                <p v-if="member.institution" class="text-[11px] text-slate-500">{{ member.institution }}<span v-if="member.country">, {{ member.country }}</span></p>
                            </div>
                        </div>

                        <div v-else class="text-xs text-slate-400 py-4 text-center">
                            Editorial board members will be listed here.
                        </div>
                    </div>

                    <!-- Editorial Office Contact Box -->
                    <div class="bg-white rounded-3xl border border-slate-200 p-6 shadow-sm space-y-3">
                        <h3 class="font-black text-slate-900 text-sm flex items-center gap-2">
                            <span>📬</span> Editorial Secretariat
                        </h3>
                        <p class="text-xs text-slate-600 leading-relaxed">
                            For manuscript inquiries, special issue proposals, and editorial questions:
                        </p>
                        <div class="space-y-1.5 text-xs font-medium text-slate-700">
                            <div>
                                <span class="text-slate-400 block text-[10px] uppercase font-bold">Email Inquiries:</span>
                                <a :href="'mailto:' + (journal.contact_email || 'editor@knowdyn.org')" class="text-indigo-600 hover:underline font-mono">
                                    {{ journal.contact_email || 'editor@knowdyn.org' }}
                                </a>
                            </div>
                            <div class="pt-2 border-t border-slate-100">
                                <span class="text-slate-400 block text-[10px] uppercase font-bold">Publisher:</span>
                                <span class="text-slate-800 font-semibold">{{ journal.publisher || 'Knowledge Dynamics' }}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
