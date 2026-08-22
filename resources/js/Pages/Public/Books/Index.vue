<script setup>
import { ref } from 'vue';
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    books: {
        type: Array,
        default: () => [],
    },
    filters: {
        type: Object,
        default: () => ({ category: 'all', format: 'all' }),
    },
});

const selectedCategory = ref(props.filters?.category || 'all');
</script>

<template>
    <Head>
        <title>Academic Books & Monographs — Knowledge Dynamics</title>
        <meta name="description" content="Explore peer-reviewed academic books, open access monographs, and digital scholarly reference texts published by Knowledge Dynamics." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Scholarly Publications</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Books & Academic Monographs</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Peer-reviewed academic reference books, edited collections, and open-access monographs across scientific, economic, and humanitarian disciplines.
                    </p>
                    <div class="mt-6 flex flex-wrap gap-3">
                        <Link :href="route('books.propose')" class="btn-primary text-xs py-2 px-5 shadow-sm">
                            Propose a Book / Monograph →
                        </Link>
                    </div>
                </div>
            </div>
        </section>

        <!-- Books Directory -->
        <section class="section bg-gray-50/50">
            <div class="container-wide">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div
                        v-for="book in books"
                        :key="book.id"
                        class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm hover:shadow-md transition flex flex-col justify-between"
                    >
                        <div class="p-6 space-y-3">
                            <div class="flex items-center justify-between">
                                <span class="text-[11px] font-bold text-navy-700 bg-navy-50 px-2 py-0.5 rounded border border-navy-100 uppercase">
                                    {{ book.category }}
                                </span>
                                <span v-if="book.is_open_access" class="text-[11px] font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded border border-emerald-200">
                                    Open Access
                                </span>
                                <span v-else class="text-[11px] font-bold text-gray-500 bg-gray-100 px-2 py-0.5 rounded">
                                    {{ book.format }}
                                </span>
                            </div>

                            <h3 class="text-lg font-bold text-gray-900 leading-snug">{{ book.title }}</h3>
                            <p class="text-xs text-academic-600 font-semibold">By {{ book.author }}</p>
                            <p class="text-xs text-gray-600 leading-relaxed line-clamp-3">{{ book.description }}</p>

                            <div class="pt-2 text-[11px] text-gray-400 space-y-0.5 border-t border-gray-100">
                                <div>ISBN: <span class="font-mono text-gray-600">{{ book.isbn }}</span></div>
                                <div>Year: <span class="font-semibold text-gray-600">{{ book.year }}</span> ({{ book.pages }} pages)</div>
                                <div>DOI: <span class="font-mono text-navy-700">{{ book.doi }}</span></div>
                            </div>
                        </div>

                        <div class="p-4 bg-gray-50/80 border-t border-gray-100 flex items-center justify-between">
                            <span class="text-xs font-semibold text-navy-800">Available in Print & PDF</span>
                            <a href="#order" class="btn-secondary text-[11px] py-1.5 px-3">
                                Access Details
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
