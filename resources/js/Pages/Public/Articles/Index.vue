<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    articles: {
        type: Object,
        required: true,
    },
    journals: {
        type: Array,
        default: () => [],
    },
    filters: {
        type: Object,
        default: () => ({ search: '', journal: '' }),
    },
});

const searchQuery = ref(props.filters?.search || '');
const selectedJournal = ref(props.filters?.journal || '');

const handleFilter = () => {
    router.get(route('articles.index'), {
        search: searchQuery.value,
        journal: selectedJournal.value,
    }, { preserveState: true, replace: true });
};

const clearFilters = () => {
    searchQuery.value = '';
    selectedJournal.value = '';
    handleFilter();
};
</script>

<template>
    <Head>
        <title>Articles & Publications — Knowledge Dynamics</title>
        <meta name="description" content="Explore peer-reviewed academic publications and research articles across all Knowledge Dynamics open-access journals." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#38bdf8_1px,transparent_1px)] [background-size:16px_16px]"></div>
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">Scholarly Repository</p>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white">Articles & Publications</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Discover peer-reviewed original research, clinical evaluations, review articles, and scientific breakthroughs published under open access.
                    </p>

                    <!-- Search & Filter Bar -->
                    <div class="mt-8 bg-navy-900/90 p-3 rounded-xl border border-navy-700 max-w-2xl shadow-lg">
                        <form @submit.prevent="handleFilter" class="flex flex-col sm:flex-row gap-2.5">
                            <div class="relative flex-1">
                                <input
                                    v-model="searchQuery"
                                    type="text"
                                    placeholder="Search by article title, keyword, author, DOI..."
                                    class="w-full bg-navy-800/80 text-white placeholder-navy-300 border border-navy-600 rounded-lg px-3.5 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-academic-400"
                                />
                            </div>
                            <div class="w-full sm:w-48">
                                <select
                                    v-model="selectedJournal"
                                    class="w-full bg-navy-800/80 text-white border border-navy-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-academic-400"
                                >
                                    <option value="">All Journals</option>
                                    <option v-for="j in journals" :key="j.id" :value="j.slug">
                                        {{ j.short_title || j.title }}
                                    </option>
                                </select>
                            </div>
                            <button type="submit" class="btn-primary text-xs py-2 px-4 shrink-0">
                                Search
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Articles List Section -->
        <section class="section bg-gray-50/50">
            <div class="container-wide">
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
                    <div>
                        <h2 class="text-xl font-bold text-gray-900">
                            {{ filters.search || filters.journal ? 'Search Results' : 'Latest Published Research' }}
                        </h2>
                        <p class="text-xs text-gray-500 mt-0.5">
                            Showing {{ articles.total || articles.data?.length || 0 }} peer-reviewed articles
                        </p>
                    </div>

                    <button
                        v-if="filters.search || filters.journal"
                        @click="clearFilters"
                        class="text-xs font-semibold text-rose-600 hover:text-rose-800 self-start sm:self-auto"
                    >
                        Clear Filters ✕
                    </button>
                </div>

                <!-- Articles Grid/List -->
                <div v-if="articles.data.length === 0" class="bg-white rounded-xl border border-gray-200 p-12 text-center text-gray-500">
                    <svg xmlns="http://www.w3.org/2000/svg" class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                    </svg>
                    <h3 class="mt-3 text-base font-bold text-gray-900">No articles matched your criteria</h3>
                    <p class="mt-1 text-xs text-gray-500">Try broadening your search keywords or browsing all journals.</p>
                </div>

                <div v-else class="space-y-6">
                    <article
                        v-for="article in articles.data"
                        :key="article.id"
                        class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm hover:shadow-md transition flex flex-col justify-between"
                    >
                        <div>
                            <!-- Header metadata row -->
                            <div class="flex flex-wrap items-center gap-2 text-xs text-gray-500 mb-3">
                                <Link
                                    v-if="article.journal"
                                    :href="route('journals.show', article.journal.slug)"
                                    class="font-bold text-navy-800 hover:text-navy-950 transition"
                                >
                                    {{ article.journal.title }}
                                </Link>
                                <span v-if="article.journal">•</span>
                                <span class="capitalize bg-gray-100 text-gray-700 px-2 py-0.5 rounded font-medium text-[11px]">
                                    {{ (article.article_type || 'Original Research').replace('-', ' ') }}
                                </span>
                                <span>•</span>
                                <span class="text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded text-[11px] font-semibold">
                                    Open Access
                                </span>
                                <span v-if="article.doi" class="text-gray-400 font-mono text-[11px] ml-auto hidden sm:inline">
                                    DOI: {{ article.doi }}
                                </span>
                            </div>

                            <!-- Title -->
                            <h3 class="text-lg md:text-xl font-bold text-gray-900 hover:text-navy-700 transition leading-snug">
                                <Link :href="route('articles.show', article.slug)">
                                    {{ article.title }}
                                </Link>
                            </h3>

                            <!-- Authors -->
                            <div class="mt-2 text-xs text-gray-600">
                                <span v-for="(author, aIdx) in article.authors" :key="author.id">
                                    <span class="font-medium text-gray-800">{{ author.first_name }} {{ author.last_name }}</span>
                                    <span v-if="author.is_corresponding" class="text-academic-700 font-bold" title="Corresponding Author">*</span>
                                    <span v-if="aIdx < article.authors.length - 1">, </span>
                                </span>
                            </div>

                            <!-- Abstract Preview -->
                            <p v-if="article.abstract" class="mt-3 text-xs md:text-sm text-gray-600 line-clamp-3 leading-relaxed">
                                {{ article.abstract }}
                            </p>

                            <!-- Keywords -->
                            <div v-if="article.keywords && article.keywords.length > 0" class="mt-4 flex flex-wrap gap-1.5">
                                <span
                                    v-for="kw in article.keywords"
                                    :key="kw.id"
                                    class="text-[11px] bg-navy-50 text-navy-800 px-2 py-0.5 rounded border border-navy-100/60"
                                >
                                    #{{ kw.name }}
                                </span>
                            </div>
                        </div>

                        <!-- Footer Actions & Metadata -->
                        <div class="mt-6 pt-4 border-t border-gray-100 flex flex-wrap items-center justify-between gap-3 text-xs">
                            <div class="text-gray-500">
                                <span>Published: {{ article.published_at ? new Date(article.published_at).toLocaleDateString() : 'Recent' }}</span>
                                <span v-if="article.pages" class="ml-2">• Pages: {{ article.pages }}</span>
                            </div>

                            <div class="flex items-center gap-2">
                                <Link :href="route('articles.show', article.slug)" class="btn-primary text-xs py-1.5 px-3">
                                    Read Article →
                                </Link>
                                <a
                                    :href="route('articles.download', article.slug)"
                                    class="btn-secondary text-xs py-1.5 px-3 flex items-center gap-1"
                                >
                                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                                    </svg>
                                    PDF
                                </a>
                            </div>
                        </div>
                    </article>
                </div>

                <!-- Pagination -->
                <div v-if="articles.links && articles.links.length > 3" class="mt-10 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in articles.links" :key="i">
                            <Link
                                v-if="link.url"
                                :href="link.url"
                                v-html="link.label"
                                class="px-3 py-1.5 text-xs rounded border"
                                :class="link.active ? 'bg-navy-700 text-white border-navy-700' : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'"
                            />
                            <span v-else v-html="link.label" class="px-3 py-1.5 text-xs rounded border border-gray-200 text-gray-400" />
                        </template>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
