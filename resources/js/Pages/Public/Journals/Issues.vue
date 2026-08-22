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
});
</script>

<template>
    <Head>
        <title>All Issues — {{ journal.title }} — Knowledge Dynamics</title>
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
                    <span class="text-white font-medium">Issues</span>
                </nav>

                <h1 class="text-2xl sm:text-4xl font-bold tracking-tight text-white">
                    All Published Issues
                </h1>
                <p class="mt-2 text-sm text-navy-200">
                    {{ journal.title }} • ISSN: {{ journal.issn_online || journal.issn_print || 'Pending' }}
                </p>
            </div>
        </section>

        <!-- Issues List grouped by Volume -->
        <div class="container-wide py-12">
            <div v-if="volumes.length === 0" class="text-center py-16 bg-white rounded-xl border border-gray-200">
                <p class="text-gray-500">No issues published yet for this journal.</p>
            </div>

            <div v-else class="space-y-10">
                <div
                    v-for="volume in volumes"
                    :key="volume.id"
                    class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm"
                >
                    <div class="bg-navy-900 text-white px-6 py-4 flex items-center justify-between">
                        <div class="flex items-center gap-3">
                            <span class="font-bold text-lg">Volume {{ volume.number }}</span>
                            <span class="text-xs bg-navy-800 text-academic-300 px-2 py-0.5 rounded border border-navy-700 font-mono">
                                Year {{ volume.year }}
                            </span>
                        </div>
                        <span class="text-xs text-navy-300">{{ volume.issues?.length || 0 }} Issues</span>
                    </div>

                    <div class="p-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <div
                            v-for="issue in volume.issues"
                            :key="issue.id"
                            class="p-5 rounded-lg border border-gray-200 bg-gray-50/50 hover:bg-white hover:border-academic-400 transition flex flex-col justify-between"
                        >
                            <div>
                                <div class="flex items-center justify-between mb-2">
                                    <span class="text-xs font-bold text-navy-800 uppercase tracking-wider">Issue {{ issue.number }}</span>
                                    <span v-if="issue.is_current" class="text-[10px] font-bold bg-academic-100 text-academic-800 px-2 py-0.5 rounded-full">
                                        Current
                                    </span>
                                </div>
                                <h3 class="text-base font-bold text-gray-900 mb-1">
                                    {{ issue.title || `Vol. ${volume.number}, No. ${issue.number}` }}
                                </h3>
                                <p v-if="issue.published_at" class="text-xs text-gray-500 mb-3">
                                    Published: {{ issue.published_at }}
                                </p>
                                <p v-if="issue.description" class="text-xs text-gray-600 line-clamp-2 mb-3">
                                    {{ issue.description }}
                                </p>
                            </div>

                            <div class="pt-3 border-t border-gray-200/60 flex items-center justify-between text-xs">
                                <span class="text-gray-500">{{ issue.articles_count || 0 }} Articles</span>
                                <Link :href="route('journals.show', journal.slug)" class="font-semibold text-navy-700 hover:text-navy-900">
                                    View Issue →
                                </Link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
