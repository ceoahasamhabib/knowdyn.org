<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

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
</script>

<template>
    <Head>
        <title>{{ journal.title }} — Knowledge Dynamics</title>
        <meta name="description" :content="journal.description || journal.aims_and_scope" />
    </Head>

    <PublicLayout>
        <!-- Journal Hero Header -->
        <section class="bg-navy-800 text-white pt-10 pb-8 border-b border-navy-700">
            <div class="container-wide">
                <!-- Breadcrumbs -->
                <nav class="flex items-center gap-2 text-xs text-navy-300 mb-6">
                    <Link :href="route('home')" class="hover:text-white transition">Home</Link>
                    <span>/</span>
                    <Link :href="route('journals.index')" class="hover:text-white transition">Journals</Link>
                    <span>/</span>
                    <span class="text-white font-medium truncate max-w-xs sm:max-w-md">{{ journal.title }}</span>
                </nav>

                <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-8">
                    <div class="max-w-3xl">
                        <div class="flex flex-wrap items-center gap-2 mb-3">
                            <span v-if="journal.is_open_access" class="inline-flex items-center gap-1 text-xs font-semibold text-emerald-400 bg-emerald-950/60 px-2.5 py-0.5 rounded-full border border-emerald-500/30">
                                Open Access
                            </span>
                            <span class="text-xs text-academic-300 font-mono">
                                ISSN: {{ journal.issn_online || journal.issn_print || 'Pending' }} (Online)
                            </span>
                            <span v-if="journal.issn_print" class="text-xs text-navy-300 font-mono">
                                • Print: {{ journal.issn_print }}
                            </span>
                        </div>

                        <h1 class="text-2xl sm:text-3xl md:text-4xl font-bold tracking-tight text-white leading-tight">
                            {{ journal.title }}
                        </h1>
                        <p v-if="journal.short_title" class="text-sm font-mono text-academic-300 mt-1">
                            {{ journal.short_title }}
                        </p>

                        <p class="mt-4 text-sm sm:text-base text-navy-200 leading-relaxed max-w-2xl">
                            {{ journal.description }}
                        </p>
                    </div>

                    <!-- Journal Quick Stats Card -->
                    <div class="bg-navy-900/90 border border-navy-700 rounded-xl p-5 shrink-0 w-full lg:w-72 shadow-lg">
                        <h3 class="text-xs uppercase tracking-wider font-semibold text-academic-300 mb-3">Journal Information</h3>
                        <div class="space-y-2.5 text-xs">
                            <div class="flex justify-between py-1 border-b border-navy-800">
                                <span class="text-navy-300">Publisher:</span>
                                <span class="text-white font-medium">{{ journal.publisher || 'Knowledge Dynamics' }}</span>
                            </div>
                            <div class="flex justify-between py-1 border-b border-navy-800">
                                <span class="text-navy-300">Frequency:</span>
                                <span class="text-white font-medium">{{ journal.publication_frequency || 'Quarterly' }}</span>
                            </div>
                            <div class="flex justify-between py-1 border-b border-navy-800">
                                <span class="text-navy-300">Peer Review:</span>
                                <span class="text-white font-medium capitalize">{{ (journal.settings?.review_model || 'Double Blind').replace('_', ' ') }}</span>
                            </div>
                            <div class="flex justify-between py-1">
                                <span class="text-navy-300">Established:</span>
                                <span class="text-white font-medium">{{ journal.established_year || '2021' }}</span>
                            </div>
                        </div>

                        <div class="mt-5 pt-4 border-t border-navy-800 flex flex-col gap-2">
                            <a href="#submit" class="btn-primary text-center text-xs py-2 w-full">
                                Submit Manuscript
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Secondary Tab Navigation -->
                <div class="mt-8 pt-4 border-t border-navy-700/60 flex flex-wrap gap-2 sm:gap-4 text-xs sm:text-sm">
                    <a href="#aims" class="px-3 py-1.5 rounded-lg bg-navy-700 text-white font-medium">Overview & Aims</a>
                    <a href="#current-issue" class="px-3 py-1.5 rounded-lg text-navy-200 hover:bg-navy-700/60 hover:text-white transition">Current Issue</a>
                    <Link :href="route('journals.issues', journal.slug)" class="px-3 py-1.5 rounded-lg text-navy-200 hover:bg-navy-700/60 hover:text-white transition">All Issues</Link>
                    <Link :href="route('journals.archive', journal.slug)" class="px-3 py-1.5 rounded-lg text-navy-200 hover:bg-navy-700/60 hover:text-white transition">Archive</Link>
                    <Link :href="route('journals.editorial_board', journal.slug)" class="px-3 py-1.5 rounded-lg text-navy-200 hover:bg-navy-700/60 hover:text-white transition">Editorial Board</Link>
                    <a href="#guidelines" class="px-3 py-1.5 rounded-lg text-navy-200 hover:bg-navy-700/60 hover:text-white transition">Author Guidelines</a>
                </div>
            </div>
        </section>

        <!-- Main Content Layout -->
        <div class="container-wide py-10">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
                <!-- Left 2 Columns -->
                <div class="lg:col-span-2 space-y-12">
                    <!-- Aims and Scope -->
                    <section id="aims" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm">
                        <div class="flex items-center gap-2 mb-4">
                            <span class="w-2 h-6 bg-navy-700 rounded-full"></span>
                            <h2 class="text-xl md:text-2xl font-bold text-gray-900">Aims & Scope</h2>
                        </div>
                        <div class="prose prose-sm max-w-none text-gray-700 leading-relaxed whitespace-pre-line">
                            {{ journal.aims_and_scope || journal.description }}
                        </div>
                    </section>

                    <!-- Current / Latest Issue -->
                    <section id="current-issue" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 mb-6 pb-4 border-b border-gray-100">
                            <div>
                                <span class="text-xs uppercase tracking-wider text-academic-700 font-semibold">Latest Publication</span>
                                <h2 class="text-xl md:text-2xl font-bold text-gray-900">
                                    {{ currentIssue ? `Vol. ${currentIssue.volume?.number || 1}, Issue ${currentIssue.number} (${currentIssue.volume?.year || '2026'})` : 'Current Issue' }}
                                </h2>
                            </div>
                            <div class="flex items-center gap-2">
                                <Link :href="route('journals.archive', journal.slug)" class="text-xs font-semibold text-navy-700 hover:text-navy-900">
                                    Browse Archive →
                                </Link>
                            </div>
                        </div>

                        <!-- Articles in current issue -->
                        <div v-if="currentIssue && currentIssue.articles && currentIssue.articles.length > 0" class="space-y-6">
                            <article
                                v-for="article in currentIssue.articles"
                                :key="article.id"
                                class="p-4 rounded-lg bg-gray-50/70 border border-gray-200/80 hover:bg-gray-50 transition"
                            >
                                <div class="flex items-center gap-2 text-xs text-gray-500 mb-2">
                                    <span class="font-medium text-navy-700 uppercase tracking-wider">{{ article.article_type || 'Research Article' }}</span>
                                    <span>•</span>
                                    <span>Pages: {{ article.pages || '1-15' }}</span>
                                    <span v-if="article.doi">• DOI: {{ article.doi }}</span>
                                </div>
                                <h3 class="text-base font-bold text-gray-900 hover:text-navy-700 transition">
                                    {{ article.title }}
                                </h3>
                                <p class="text-xs text-gray-600 mt-1">
                                    <span v-for="(author, aIdx) in article.authors" :key="author.id">
                                        {{ author.first_name }} {{ author.last_name }}<span v-if="aIdx < article.authors.length - 1">, </span>
                                    </span>
                                </p>
                                <p v-if="article.abstract" class="text-xs text-gray-600 mt-2 line-clamp-2 leading-relaxed">
                                    {{ article.abstract }}
                                </p>
                            </article>
                        </div>

                        <div v-else class="text-center py-8 text-gray-500 text-sm">
                            <p>Articles for the current issue are undergoing editorial production and peer review.</p>
                            <p class="text-xs text-gray-400 mt-1">Check back soon or explore past archives.</p>
                        </div>
                    </section>

                    <!-- Author Guidelines & Editorial Policies -->
                    <section id="guidelines" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm">
                        <div class="flex items-center gap-2 mb-4">
                            <span class="w-2 h-6 bg-navy-700 rounded-full"></span>
                            <h2 class="text-xl md:text-2xl font-bold text-gray-900">Author Guidelines & Ethics</h2>
                        </div>
                        <div class="space-y-4 text-sm text-gray-700 leading-relaxed">
                            <div>
                                <h3 class="font-semibold text-gray-900 text-sm mb-1">Peer Review Policy</h3>
                                <p class="text-gray-600 text-xs sm:text-sm">
                                    {{ journal.settings?.peer_review_process || 'All submitted manuscripts undergo a rigorous peer-review evaluation by international experts in the field.' }}
                                </p>
                            </div>
                            <div class="pt-3 border-t border-gray-100">
                                <h3 class="font-semibold text-gray-900 text-sm mb-1">Open Access & Licensing</h3>
                                <p class="text-gray-600 text-xs sm:text-sm">
                                    {{ journal.settings?.open_access_policy || 'Articles are published under the Creative Commons Attribution 4.0 International (CC BY 4.0) License, allowing immediate worldwide access.' }}
                                </p>
                            </div>
                            <div class="pt-3 border-t border-gray-100">
                                <h3 class="font-semibold text-gray-900 text-sm mb-1">Publication Ethics</h3>
                                <p class="text-gray-600 text-xs sm:text-sm">
                                    {{ journal.settings?.publication_ethics || 'Knowledge Dynamics strictly adheres to COPE (Committee on Publication Ethics) guidelines regarding research integrity, plagiarism screening, and authorship standards.' }}
                                </p>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Right Sidebar -->
                <div class="space-y-8">
                    <!-- Submission CTA Box -->
                    <div id="submit" class="bg-navy-900 text-white rounded-xl p-6 shadow-md border border-navy-800">
                        <span class="text-[11px] font-bold uppercase tracking-wider text-academic-300 block mb-2">Call For Papers</span>
                        <h3 class="text-lg font-bold text-white mb-2">Submit Your Manuscript</h3>
                        <p class="text-xs text-navy-200 leading-relaxed mb-5">
                            We welcome original research, critical reviews, and empirical studies adhering to international scientific rigor.
                        </p>
                        <Link href="/login" class="btn-primary w-full text-center text-xs py-2.5 block">
                            Start Submission
                        </Link>
                        <p class="text-[11px] text-navy-300 text-center mt-3">
                            Fast initial screening • Rigorous peer review
                        </p>
                    </div>

                    <!-- Editorial Board Preview -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="font-bold text-gray-900 text-base">Editorial Leadership</h3>
                            <Link :href="route('journals.editorial_board', journal.slug)" class="text-xs font-semibold text-navy-700 hover:text-navy-900">
                                View All
                            </Link>
                        </div>

                        <div v-if="boardPreview.length > 0" class="space-y-4">
                            <div
                                v-for="member in boardPreview"
                                :key="member.id"
                                class="pb-3 border-b border-gray-100 last:border-0 last:pb-0"
                            >
                                <p class="text-sm font-bold text-gray-900">{{ member.name }}</p>
                                <p class="text-xs font-medium text-navy-700">{{ member.role }}</p>
                                <p v-if="member.institution" class="text-xs text-gray-500 mt-0.5">{{ member.institution }}<span v-if="member.country">, {{ member.country }}</span></p>
                            </div>
                        </div>

                        <div v-else class="text-xs text-gray-500 py-3 text-center">
                            Editorial board members will be listed here.
                        </div>
                    </div>

                    <!-- Indexing & Archiving -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm">
                        <h3 class="font-bold text-gray-900 text-base mb-3">Scholarly Preservation</h3>
                        <ul class="space-y-2 text-xs text-gray-600">
                            <li class="flex items-center gap-2">
                                <span class="w-1.5 h-1.5 rounded-full bg-academic-600"></span>
                                <span>DOI Assignment Ready (Crossref)</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <span class="w-1.5 h-1.5 rounded-full bg-academic-600"></span>
                                <span>Open Access Directory (DOAJ Compatible)</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <span class="w-1.5 h-1.5 rounded-full bg-academic-600"></span>
                                <span>Digital Preservation & Archiving</span>
                            </li>
                            <li class="flex items-center gap-2">
                                <span class="w-1.5 h-1.5 rounded-full bg-academic-600"></span>
                                <span>Google Scholar & Academic Aggregators</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
