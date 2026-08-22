<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    mode: {
        type: String,
        default: 'news', // 'news' or 'events'
    },
    items: {
        type: Array,
        default: () => [],
    },
    currentCategory: {
        type: String,
        default: 'all',
    },
});
</script>

<template>
    <Head>
        <title>{{ mode === 'events' ? 'Seminars, Workshops & Events' : 'News & Announcements' }} — Knowledge Dynamics</title>
        <meta name="description" content="Stay updated with the latest academic news, call for papers, scholarly workshops, and international publishing symposiums from Knowledge Dynamics." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">
                        {{ mode === 'events' ? 'Symposia & Training' : 'Scholarly Bulletin' }}
                    </span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">
                        {{ mode === 'events' ? 'Seminars, Workshops & Events' : 'News & Announcements' }}
                    </h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        {{ mode === 'events'
                            ? 'Participate in scientific symposiums, author training workshops, and international interfaith dialogues organized by Knowledge Dynamics.'
                            : 'Latest publishing developments, journal indexing milestones, call for papers, and academic announcements.'
                        }}
                    </p>
                    <div class="mt-6 flex gap-3">
                        <Link
                            :href="route('news.index')"
                            :class="['text-xs py-2 px-4 rounded-lg font-semibold transition', mode === 'news' ? 'bg-white text-navy-800' : 'bg-navy-700 text-navy-200 hover:text-white']"
                        >
                            News & Call for Papers
                        </Link>
                        <Link
                            :href="route('events.index')"
                            :class="['text-xs py-2 px-4 rounded-lg font-semibold transition', mode === 'events' ? 'bg-white text-navy-800' : 'bg-navy-700 text-navy-200 hover:text-white']"
                        >
                            Seminars & Workshops
                        </Link>
                        <Link
                            :href="route('careers.index')"
                            class="bg-navy-700 text-navy-200 hover:text-white text-xs py-2 px-4 rounded-lg font-semibold transition"
                        >
                            Careers & Fellowships
                        </Link>
                    </div>
                </div>
            </div>
        </section>

        <!-- List Section -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-4xl space-y-6">
                <div
                    v-for="item in items"
                    :key="item.id"
                    class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm hover:shadow-md transition space-y-3"
                >
                    <div class="flex items-center justify-between">
                        <span class="text-[11px] font-bold text-navy-700 bg-navy-50 px-2.5 py-0.5 rounded border border-navy-100 uppercase">
                            {{ item.category }}
                        </span>
                        <span class="text-xs text-gray-500 font-medium">{{ item.date }}</span>
                    </div>

                    <h3 class="text-xl font-bold text-gray-900 leading-snug">{{ item.title }}</h3>
                    
                    <div v-if="item.journal || item.location" class="text-xs text-academic-600 font-semibold">
                        {{ item.journal || item.location }}
                    </div>

                    <p class="text-xs md:text-sm text-gray-600 leading-relaxed">{{ item.summary }}</p>

                    <div v-if="item.deadline" class="text-xs font-semibold text-rose-700 bg-rose-50 p-2.5 rounded border border-rose-100 inline-block">
                        Submission Deadline: {{ item.deadline }}
                    </div>

                    <div v-if="item.registration_open" class="pt-2 flex items-center justify-between border-t border-gray-100">
                        <span class="text-xs text-emerald-700 font-bold">● Registration Open</span>
                        <a href="#register" class="btn-primary text-xs py-1.5 px-4 shadow-sm">
                            Register for Event →
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
