<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
    volumes: {
        type: Array,
        default: () => [],
    },
    stats: {
        type: Object,
        default: () => ({ total_volumes: 0, total_issues: 0, total_articles: 0 }),
    },
});
</script>

<template>
    <Head>
        <title>Archive — {{ journal.title }} — Knowledge Dynamics</title>
        <meta name="description" :content="`Browse the complete academic publication archive for ${journal.title}.`" />
    </Head>

    <PublicLayout>
        <!-- Header -->
        <section class="bg-navy-800 text-white py-12 border-b border-navy-700">
            <div class="container-wide">
                <nav class="flex items-center gap-2 text-xs text-navy-300 mb-4">
                    <Link :href="route('home')" class="hover:text-white transition">Home</Link>
                    <span>/</span>
                    <Link :href="route('journals.index')" class="hover:text-white transition">Journals</Link>
                    <span>/</span>
                    <Link :href="route('journals.show', journal.slug)" class="hover:text-white transition">{{ journal.short_title || journal.title }}</Link>
                    <span>/</span>
                    <span class="text-white font-medium">Archive</span>
                </nav>

                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
                    <div>
                        <h1 class="text-2xl sm:text-4xl font-bold tracking-tight text-white">
                            Journal Archive
                        </h1>
                        <p class="mt-2 text-sm text-navy-200">
                            {{ journal.title }} • Established {{ journal.established_year || '2021' }}
                        </p>
                    </div>

                    <!-- Archive Stats -->
                    <div class="flex items-center gap-6 bg-navy-900/80 px-6 py-3 rounded-xl border border-navy-700">
                        <div class="text-center">
                            <span class="block text-lg font-bold text-white">{{ stats.total_volumes }}</span>
                            <span class="text-[11px] text-navy-300 uppercase tracking-wider">Volumes</span>
                        </div>
                        <div class="w-px h-8 bg-navy-800"></div>
                        <div class="text-center">
                            <span class="block text-lg font-bold text-white">{{ stats.total_issues }}</span>
                            <span class="text-[11px] text-navy-300 uppercase tracking-wider">Issues</span>
                        </div>
                        <div class="w-px h-8 bg-navy-800"></div>
                        <div class="text-center">
                            <span class="block text-lg font-bold text-academic-300">{{ stats.total_articles }}</span>
                            <span class="text-[11px] text-navy-300 uppercase tracking-wider">Articles</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Archive Content -->
        <div class="container-wide py-12">
            <div v-if="volumes.length === 0" class="text-center py-16 bg-white rounded-xl border border-gray-200">
                <p class="text-gray-500">No archived issues found for this journal.</p>
            </div>

            <div v-else class="space-y-12">
                <div
                    v-for="volume in volumes"
                    :key="volume.id"
                    class="space-y-6"
                >
                    <!-- Volume Heading -->
                    <div class="flex items-center gap-4 pb-2 border-b-2 border-navy-800">
                        <h2 class="text-xl sm:text-2xl font-bold text-gray-900">
                            Volume {{ volume.number }} ({{ volume.year }})
                        </h2>
                        <span v-if="volume.title" class="text-sm text-gray-500 font-medium italic">
                            — {{ volume.title }}
                        </span>
                    </div>

                    <!-- Issues under this Volume -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div
                            v-for="issue in volume.issues"
                            :key="issue.id"
                            class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm hover:shadow-md transition"
                        >
                            <div class="flex items-start justify-between gap-4 mb-3">
                                <div>
                                    <span class="text-xs uppercase font-bold tracking-wider text-academic-700">
                                        Issue {{ issue.number }}
                                    </span>
                                    <h3 class="text-lg font-bold text-gray-900 mt-1">
                                        {{ issue.title || `Volume ${volume.number}, Issue ${issue.number}` }}
                                    </h3>
                                    <p v-if="issue.published_at" class="text-xs text-gray-500 mt-0.5">
                                        Date of Publication: {{ issue.published_at }}
                                    </p>
                                </div>

                                <span v-if="issue.is_current" class="text-[10px] font-bold bg-academic-100 text-academic-800 px-2 py-0.5 rounded-full shrink-0">
                                    Current
                                </span>
                            </div>

                            <p v-if="issue.description" class="text-xs text-gray-600 mb-4 line-clamp-2 leading-relaxed">
                                {{ issue.description }}
                            </p>

                            <!-- Articles in this issue snippet -->
                            <div v-if="issue.articles && issue.articles.length > 0" class="mt-4 pt-4 border-t border-gray-100 space-y-3">
                                <p class="text-xs font-semibold text-gray-700 uppercase tracking-wider">
                                    Articles ({{ issue.articles.length }}):
                                </p>
                                <div
                                    v-for="article in issue.articles"
                                    :key="article.id"
                                    class="text-xs pb-2 border-b border-gray-50 last:border-0"
                                >
                                    <p class="font-medium text-gray-900 hover:text-navy-700 transition">
                                        {{ article.title }}
                                    </p>
                                    <p class="text-[11px] text-gray-500 mt-0.5">
                                        <span v-for="(author, aIdx) in article.authors" :key="author.id">
                                            {{ author.first_name }} {{ author.last_name }}<span v-if="aIdx < article.authors.length - 1">, </span>
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
