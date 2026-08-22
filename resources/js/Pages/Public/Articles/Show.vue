<script setup>
import { ref } from 'vue';
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    article: {
        type: Object,
        required: true,
    },
    citations: {
        type: Object,
        required: true,
    },
    scholarlyMeta: {
        type: Object,
        default: () => ({}),
    },
});

const showCiteModal = ref(false);
const activeCiteTab = ref('apa');
const copied = ref(false);

const copyCitation = (text) => {
    navigator.clipboard.writeText(text);
    copied.value = true;
    setTimeout(() => {
        copied.value = false;
    }, 2000);
};

const activeTab = ref('abstract');
</script>

<template>
    <Head>
        <title>{{ article.title }} — {{ article.journal?.short_title || 'Knowledge Dynamics' }}</title>
        <meta name="description" :content="article.abstract || article.title" />

        <!-- Google Scholar & Scholarly SEO Meta Tags -->
        <meta name="citation_title" :content="article.title" />
        <meta v-if="article.journal" name="citation_journal_title" :content="article.journal.title" />
        <meta v-if="scholarlyMeta.citation_publication_date" name="citation_publication_date" :content="scholarlyMeta.citation_publication_date" />
        <meta v-if="article.doi" name="citation_doi" :content="article.doi" />
        <meta v-if="scholarlyMeta.citation_volume" name="citation_volume" :content="scholarlyMeta.citation_volume" />
        <meta v-if="scholarlyMeta.citation_issue" name="citation_issue" :content="scholarlyMeta.citation_issue" />
        <meta v-if="scholarlyMeta.citation_firstpage" name="citation_firstpage" :content="scholarlyMeta.citation_firstpage" />
        <meta v-if="scholarlyMeta.citation_lastpage" name="citation_lastpage" :content="scholarlyMeta.citation_lastpage" />

        <template v-for="author in article.authors" :key="author.id">
            <meta name="citation_author" :content="`${author.last_name}, ${author.first_name}`" />
            <meta v-if="author.affiliation" name="citation_author_institution" :content="author.affiliation" />
            <meta v-if="author.orcid" name="citation_author_orcid" :content="author.orcid" />
        </template>
    </Head>

    <PublicLayout>
        <!-- Scholarly Top Navigation Bar -->
        <div class="bg-navy-900 text-white border-b border-navy-800 py-3 text-xs">
            <div class="container-wide flex flex-wrap items-center justify-between gap-4">
                <nav class="flex items-center gap-2 text-navy-300">
                    <Link :href="route('home')" class="hover:text-white transition">Home</Link>
                    <span>/</span>
                    <Link :href="route('journals.index')" class="hover:text-white transition">Journals</Link>
                    <span v-if="article.journal">/</span>
                    <Link
                        v-if="article.journal"
                        :href="route('journals.show', article.journal.slug)"
                        class="hover:text-white transition text-academic-300"
                    >
                        {{ article.journal.short_title || article.journal.title }}
                    </Link>
                    <span>/</span>
                    <span class="text-white truncate max-w-xs sm:max-w-md">{{ article.title }}</span>
                </nav>

                <div class="flex items-center gap-3">
                    <span class="text-navy-300 font-mono text-[11px]">{{ article.doi ? `DOI: ${article.doi}` : 'Scholarly Article' }}</span>
                </div>
            </div>
        </div>

        <!-- Article Presentation Header -->
        <header class="bg-white border-b border-gray-200 py-10">
            <div class="container-wide max-w-5xl">
                <!-- Badges -->
                <div class="flex flex-wrap items-center gap-2 mb-4">
                    <span class="inline-flex items-center gap-1 text-xs font-semibold text-emerald-700 bg-emerald-50 px-2.5 py-0.5 rounded-full border border-emerald-200">
                        <svg class="w-3.5 h-3.5" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 1a4.5 4.5 0 00-4.5 4.5V9H5a2 2 0 00-2 2v6a2 2 0 002 2h10a2 2 0 002-2v-6a2 2 0 00-2-2h-.5V5.5A4.5 4.5 0 0010 1zm3 8V5.5a3 3 0 10-6 0V9h6z" clip-rule="evenodd" />
                        </svg>
                        Open Access
                    </span>

                    <span class="capitalize bg-navy-50 text-navy-800 px-2.5 py-0.5 rounded text-xs font-semibold border border-navy-100">
                        {{ (article.article_type || 'Original Research').replace('-', ' ') }}
                    </span>

                    <span v-if="article.issues && article.issues.length > 0" class="text-xs text-gray-500 font-medium">
                        Volume {{ article.issues[0]?.volume?.number || 1 }}, Issue {{ article.issues[0]?.number }} ({{ article.issues[0]?.volume?.year || 2026 }})
                    </span>
                </div>

                <!-- Article Title -->
                <h1 class="text-2xl sm:text-3xl md:text-4xl font-bold text-gray-900 leading-tight tracking-tight">
                    {{ article.title }}
                </h1>

                <!-- Authors Ribbon -->
                <div class="mt-6 flex flex-wrap items-center gap-x-4 gap-y-2 text-sm text-gray-700">
                    <div
                        v-for="(author, index) in article.authors"
                        :key="author.id"
                        class="inline-flex items-center gap-1.5"
                    >
                        <span class="font-bold text-gray-900">{{ author.first_name }} {{ author.last_name }}</span>
                        <span class="text-xs text-academic-700 font-bold" :title="author.affiliation">{{ index + 1 }}</span>
                        <a
                            v-if="author.orcid"
                            :href="`https://orcid.org/${author.orcid}`"
                            target="_blank"
                            rel="noopener noreferrer"
                            class="text-emerald-600 hover:text-emerald-700 inline-block"
                            title="ORCID ID"
                        >
                            <svg class="w-3.5 h-3.5 fill-current" viewBox="0 0 256 256">
                                <path d="M128 0C57.3 0 0 57.3 0 128s57.3 128 128 128 128-57.3 128-128S198.7 0 128 0zm-38.3 189.6h-21.7V93.3h21.7v96.3zm-10.9-109.4c-6.9 0-12.6-5.6-12.6-12.6s5.6-12.6 12.6-12.6 12.6 5.6 12.6 12.6-5.6 12.6-12.6 12.6zm106.8 62.9c0 26.6-21.6 48.2-48.2 48.2h-36.4V93.3h36.4c26.6 0 48.2 21.6 48.2 48.2v.2zm-21.7 0c0-14.6-11.9-26.5-26.5-26.5h-14.7v53h14.7c14.6 0 26.5-11.9 26.5-26.5z" />
                            </svg>
                        </a>
                        <span v-if="author.is_corresponding" class="text-academic-700 text-xs font-bold" title="Corresponding Author">*</span>
                        <span v-if="index < article.authors.length - 1" class="text-gray-300">,</span>
                    </div>
                </div>

                <!-- Affiliations List -->
                <div class="mt-4 pt-3 border-t border-gray-100 text-xs text-gray-600 space-y-1">
                    <div v-for="(author, index) in article.authors" :key="`aff-${author.id}`">
                        <span class="font-bold text-gray-500 mr-1.5">{{ index + 1 }}.</span>
                        <span>{{ author.affiliation || 'Department of Research, Academic Center' }}</span>
                        <span v-if="author.country">, {{ author.country }}</span>
                        <span v-if="author.email && author.is_corresponding" class="ml-2 text-navy-700 font-mono">
                            (Corresponding: {{ author.email }})
                        </span>
                    </div>
                </div>

                <!-- Quick Action Buttons Bar -->
                <div class="mt-8 pt-6 border-t border-gray-200 flex flex-wrap items-center justify-between gap-4">
                    <div class="flex flex-wrap items-center gap-3">
                        <a
                            :href="route('articles.download', article.slug)"
                            class="btn-primary text-xs py-2 px-4 flex items-center gap-2 shadow-sm"
                        >
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                            </svg>
                            Download Full PDF
                        </a>

                        <button
                            @click="showCiteModal = true"
                            class="btn-secondary text-xs py-2 px-4 flex items-center gap-2"
                        >
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                            </svg>
                            Cite This Article
                        </button>
                    </div>

                    <!-- Metrics -->
                    <div class="flex items-center gap-4 text-xs text-gray-500 bg-gray-50 px-4 py-2 rounded-lg border border-gray-200">
                        <div>
                            <span class="font-bold text-gray-900">{{ article.view_count || 1 }}</span> Views
                        </div>
                        <div class="w-px h-4 bg-gray-300"></div>
                        <div>
                            <span class="font-bold text-gray-900">{{ article.download_count || 0 }}</span> Downloads
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- Main Article Content Body -->
        <main class="container-wide max-w-5xl py-10 space-y-10">
            <!-- Navigation Tabs for Article Sections -->
            <div class="flex border-b border-gray-200 gap-6 text-sm font-semibold sticky top-16 bg-white/95 backdrop-blur z-20 pt-2">
                <button
                    @click="activeTab = 'abstract'"
                    :class="['pb-3 border-b-2 transition', activeTab === 'abstract' ? 'border-navy-800 text-navy-900' : 'border-transparent text-gray-500 hover:text-gray-800']"
                >
                    Abstract & Keywords
                </button>
                <button
                    @click="activeTab = 'references'"
                    :class="['pb-3 border-b-2 transition', activeTab === 'references' ? 'border-navy-800 text-navy-900' : 'border-transparent text-gray-500 hover:text-gray-800']"
                >
                    References ({{ article.references?.length || 0 }})
                </button>
                <button
                    @click="activeTab = 'metadata'"
                    :class="['pb-3 border-b-2 transition', activeTab === 'metadata' ? 'border-navy-800 text-navy-900' : 'border-transparent text-gray-500 hover:text-gray-800']"
                >
                    Article Info & Ethics
                </button>
            </div>

            <!-- Tab 1: Abstract & Full Text Preview -->
            <div v-show="activeTab === 'abstract'" class="space-y-8">
                <!-- Abstract Card -->
                <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm">
                    <div class="flex items-center gap-2 mb-4">
                        <span class="w-2 h-6 bg-navy-700 rounded-full"></span>
                        <h2 class="text-xl font-bold text-gray-900">Abstract</h2>
                    </div>

                    <div class="prose prose-sm max-w-none text-gray-700 leading-relaxed text-sm md:text-base whitespace-pre-line">
                        {{ article.abstract || 'The full abstract of this scholarly article is provided in the official publication PDF.' }}
                    </div>

                    <!-- Keywords Tags -->
                    <div v-if="article.keywords && article.keywords.length > 0" class="mt-6 pt-6 border-t border-gray-100">
                        <span class="text-xs font-bold text-gray-700 uppercase tracking-wider block mb-2">Keywords:</span>
                        <div class="flex flex-wrap gap-2">
                            <Link
                                v-for="kw in article.keywords"
                                :key="kw.id"
                                :href="route('articles.index', { search: kw.name })"
                                class="text-xs bg-navy-50 text-navy-800 hover:bg-navy-100 transition px-3 py-1 rounded-full border border-navy-100"
                            >
                                {{ kw.name }}
                            </Link>
                        </div>
                    </div>
                </div>

                <!-- Open Access Callout -->
                <div class="bg-gradient-to-r from-navy-800 to-navy-900 text-white rounded-xl p-6 shadow-md flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                    <div>
                        <h3 class="text-base font-bold text-white">Full-Text PDF Available</h3>
                        <p class="text-xs text-navy-200 mt-1">Download and read the complete peer-reviewed manuscript including high-resolution figures, tables, and supplementary data.</p>
                    </div>
                    <a :href="route('articles.download', article.slug)" class="btn-primary text-xs py-2.5 px-5 shrink-0 text-center">
                        Download PDF
                    </a>
                </div>
            </div>

            <!-- Tab 2: References -->
            <div v-show="activeTab === 'references'" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm">
                <div class="flex items-center gap-2 mb-6">
                    <span class="w-2 h-6 bg-navy-700 rounded-full"></span>
                    <h2 class="text-xl font-bold text-gray-900">References</h2>
                </div>

                <div v-if="article.references && article.references.length > 0" class="space-y-4 text-xs md:text-sm text-gray-700">
                    <div
                        v-for="(ref, index) in article.references"
                        :key="ref.id || index"
                        class="flex items-start gap-3 pb-3 border-b border-gray-100 last:border-0"
                    >
                        <span class="font-bold text-gray-400 shrink-0">{{ index + 1 }}.</span>
                        <div class="flex-1">
                            <p class="leading-relaxed">{{ ref.reference_text }}</p>
                            <a
                                v-if="ref.doi"
                                :href="`https://doi.org/${ref.doi}`"
                                target="_blank"
                                rel="noopener noreferrer"
                                class="inline-flex items-center gap-1 text-xs text-academic-700 hover:text-academic-900 font-mono mt-1"
                            >
                                [Crossref DOI: {{ ref.doi }}] ↗
                            </a>
                        </div>
                    </div>
                </div>

                <div v-else class="text-center py-8 text-gray-500 text-xs">
                    References for this manuscript are formatted within the published article PDF.
                </div>
            </div>

            <!-- Tab 3: Article Info, Funding & Ethics -->
            <div v-show="activeTab === 'metadata'" class="space-y-6">
                <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6 text-xs sm:text-sm text-gray-700">
                    <div>
                        <h3 class="font-bold text-gray-900 text-base mb-2">Publication Timeline</h3>
                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 bg-gray-50 p-4 rounded-lg border border-gray-200">
                            <div>
                                <span class="text-gray-400 block text-xs">Received</span>
                                <span class="font-medium text-gray-800">{{ article.submission_date || 'N/A' }}</span>
                            </div>
                            <div>
                                <span class="text-gray-400 block text-xs">Accepted</span>
                                <span class="font-medium text-gray-800">{{ article.acceptance_date || 'N/A' }}</span>
                            </div>
                            <div>
                                <span class="text-gray-400 block text-xs">Published Online</span>
                                <span class="font-medium text-gray-800">{{ article.published_at ? new Date(article.published_at).toLocaleDateString() : 'Recent' }}</span>
                            </div>
                        </div>
                    </div>

                    <div v-if="article.funding" class="pt-4 border-t border-gray-100">
                        <h3 class="font-bold text-gray-900 text-sm mb-1">Funding Statement</h3>
                        <p class="text-gray-600 leading-relaxed">{{ article.funding }}</p>
                    </div>

                    <div v-if="article.conflict_of_interest" class="pt-4 border-t border-gray-100">
                        <h3 class="font-bold text-gray-900 text-sm mb-1">Conflict of Interest</h3>
                        <p class="text-gray-600 leading-relaxed">{{ article.conflict_of_interest }}</p>
                    </div>

                    <div v-if="article.ethics_statement" class="pt-4 border-t border-gray-100">
                        <h3 class="font-bold text-gray-900 text-sm mb-1">Ethics & Consent</h3>
                        <p class="text-gray-600 leading-relaxed">{{ article.ethics_statement }}</p>
                    </div>

                    <div class="pt-4 border-t border-gray-100">
                        <h3 class="font-bold text-gray-900 text-sm mb-1">Copyright & Licensing</h3>
                        <p class="text-gray-600 leading-relaxed">
                            © {{ article.published_at ? new Date(article.published_at).getFullYear() : 2026 }} The Authors. Published by Knowledge Dynamics under the terms of the Creative Commons Attribution 4.0 International (CC BY 4.0) License.
                        </p>
                    </div>
                </div>
            </div>
        </main>

        <!-- Citation Modal -->
        <div v-if="showCiteModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
            <div class="bg-white rounded-xl max-w-2xl w-full p-6 shadow-2xl space-y-5">
                <div class="flex items-center justify-between border-b border-gray-100 pb-3">
                    <h3 class="text-base font-bold text-gray-900">Cite This Article</h3>
                    <button @click="showCiteModal = false" class="text-gray-400 hover:text-gray-600 text-lg">✕</button>
                </div>

                <!-- Citation Format Tabs -->
                <div class="flex gap-2 border-b border-gray-200 text-xs font-semibold pb-1">
                    <button
                        v-for="format in ['apa', 'harvard', 'vancouver', 'bibtex', 'ris']"
                        :key="format"
                        @click="activeCiteTab = format"
                        :class="['px-3 py-1.5 rounded-t transition uppercase', activeCiteTab === format ? 'bg-navy-800 text-white' : 'text-gray-600 hover:bg-gray-100']"
                    >
                        {{ format }}
                    </button>
                </div>

                <!-- Citation Text Box -->
                <div class="relative">
                    <textarea
                        readonly
                        rows="4"
                        :value="citations[activeCiteTab]"
                        class="w-full bg-gray-50 border border-gray-300 rounded-lg p-3 text-xs font-mono text-gray-800 focus:outline-none"
                    ></textarea>
                </div>

                <!-- Actions -->
                <div class="flex flex-wrap items-center justify-between gap-3 pt-2">
                    <div class="flex gap-2">
                        <a
                            :href="route('articles.citation', { slug: article.slug, format: 'bibtex' })"
                            class="btn-secondary text-[11px] py-1.5 px-2.5"
                        >
                            Download .BIB
                        </a>
                        <a
                            :href="route('articles.citation', { slug: article.slug, format: 'ris' })"
                            class="btn-secondary text-[11px] py-1.5 px-2.5"
                        >
                            Download .RIS (EndNote)
                        </a>
                    </div>

                    <button
                        @click="copyCitation(citations[activeCiteTab])"
                        class="btn-primary text-xs py-2 px-4 flex items-center gap-1.5"
                    >
                        <svg v-if="!copied" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-1M8 5a2 2 0 002 2h2a2 2 0 002-2M8 5a2 2 0 012-2h2a2 2 0 012 2m0 0h2a2 2 0 012 2v3m2 4H10m0 0l3-3m-3 3l3 3" />
                        </svg>
                        <span v-if="copied">Copied to Clipboard!</span>
                        <span v-else>Copy Citation</span>
                    </button>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
