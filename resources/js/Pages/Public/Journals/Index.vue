<script setup>
import { computed, ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

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

const journalsList = computed(() => {
    return props.journals?.data || (Array.isArray(props.journals) ? props.journals : []);
});

const handleSearch = () => {
    router.get(route('journals.index'), { search: searchQuery.value }, { preserveState: true, replace: true });
};
</script>

<template>
    <Head>
        <title>Academic Journals — Knowledge Dynamics</title>
        <meta name="description" content="Explore peer-reviewed, open-access journals published by Knowledge Dynamics across engineering, economics, healthcare, and sustainable science." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20 text-white relative overflow-hidden">
            <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#38bdf8_1px,transparent_1px)] [background-size:16px_16px]"></div>
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">Academic Publishing</p>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white">Peer-Reviewed Journals</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        High-impact, international open-access journals committed to rigorous peer review, rapid dissemination, and ethical scholarly standards.
                    </p>

                    <!-- Search bar -->
                    <div class="mt-8 max-w-xl">
                        <form @submit.prevent="handleSearch" class="flex gap-2">
                            <div class="relative flex-1">
                                <input
                                    v-model="searchQuery"
                                    type="text"
                                    placeholder="Search by title, ISSN, discipline..."
                                    class="w-full bg-navy-800/80 text-white placeholder-navy-300 border border-navy-600 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:border-academic-400 focus:ring-2 focus:ring-academic-400/20"
                                />
                            </div>
                            <button type="submit" class="btn-primary shrink-0">Search</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Journals Catalog -->
        <section class="section bg-gray-50/50">
            <div class="container-wide">
                <div v-if="journalsList.length === 0" class="text-center py-16 bg-white rounded-xl border border-gray-200">
                    <svg xmlns="http://www.w3.org/2000/svg" class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" />
                    </svg>
                    <h3 class="mt-3 text-lg font-semibold text-gray-900">No journals found</h3>
                    <p class="mt-1 text-sm text-gray-500">Try adjusting your search criteria or browse all disciplines.</p>
                </div>

                <div v-else class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <div
                        v-for="journal in journalsList"
                        :key="journal.slug"
                        class="bg-white rounded-xl border border-gray-200 shadow-sm hover:shadow-md transition-shadow duration-200 flex flex-col justify-between overflow-hidden"
                    >
                        <div class="p-6 md:p-8">
                            <div class="flex items-start justify-between gap-4 mb-4">
                                <div>
                                    <span v-if="journal.is_open_access" class="inline-flex items-center gap-1 text-[11px] font-semibold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200 mb-2">
                                        <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 1a4.5 4.5 0 00-4.5 4.5V9H5a2 2 0 00-2 2v6a2 2 0 002 2h10a2 2 0 002-2v-6a2 2 0 00-2-2h-.5V5.5A4.5 4.5 0 0010 1zm3 8V5.5a3 3 0 10-6 0V9h6z" clip-rule="evenodd" />
                                        </svg>
                                        Open Access
                                    </span>
                                    <h2 class="text-xl font-bold text-gray-900 hover:text-navy-700 transition">
                                        <Link :href="route('journals.show', journal.slug)">
                                            {{ journal.title }}
                                        </Link>
                                    </h2>
                                    <p v-if="journal.short_title" class="text-xs text-gray-500 font-mono mt-0.5">Short Title: {{ journal.short_title }}</p>
                                </div>

                                <div class="w-14 h-14 rounded-lg bg-navy-50 flex items-center justify-center shrink-0 border border-navy-100">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-7 h-7 text-navy-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" />
                                    </svg>
                                </div>
                            </div>

                            <p class="text-sm text-gray-600 line-clamp-3 leading-relaxed mb-6">
                                {{ journal.description || journal.aims_and_scope }}
                            </p>

                            <!-- Metadata row -->
                            <div class="grid grid-cols-2 sm:grid-cols-3 gap-4 pt-4 border-t border-gray-100 text-xs">
                                <div>
                                    <span class="text-gray-400 block mb-0.5">ISSN Online</span>
                                    <span class="font-mono font-medium text-gray-800">{{ journal.issn_online || 'Pending' }}</span>
                                </div>
                                <div>
                                    <span class="text-gray-400 block mb-0.5">Frequency</span>
                                    <span class="font-medium text-gray-800">{{ journal.publication_frequency || 'Quarterly' }}</span>
                                </div>
                                <div>
                                    <span class="text-gray-400 block mb-0.5">Established</span>
                                    <span class="font-medium text-gray-800">{{ journal.established_year || '2021' }}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Actions bar -->
                        <div class="bg-gray-50/80 px-6 md:px-8 py-3.5 border-t border-gray-100 flex items-center justify-between gap-3">
                            <div class="flex items-center gap-2">
                                <Link :href="route('journals.show', journal.slug)" class="btn-primary text-xs py-1.5 px-3">
                                    View Journal
                                </Link>
                                <Link :href="route('journals.archive', journal.slug)" class="btn-secondary text-xs py-1.5 px-3">
                                    Archive
                                </Link>
                            </div>
                            <Link :href="route('journals.editorial_board', journal.slug)" class="text-xs font-medium text-navy-700 hover:text-navy-900 transition">
                                Editorial Board →
                            </Link>
                        </div>
                    </div>
                </div>

                <!-- Pagination if applicable -->
                <div v-if="props.journals?.links && props.journals.links.length > 3" class="mt-10 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in props.journals.links" :key="i">
                            <Link
                                v-if="link.url"
                                :href="link.url"
                                v-html="link.label"
                                class="px-3 py-1.5 text-sm rounded border"
                                :class="link.active ? 'bg-navy-700 text-white border-navy-700' : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'"
                            />
                            <span v-else v-html="link.label" class="px-3 py-1.5 text-sm rounded border border-gray-200 text-gray-400" />
                        </template>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
