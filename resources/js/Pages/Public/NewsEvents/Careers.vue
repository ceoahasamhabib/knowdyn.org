<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    positions: {
        type: Array,
        default: () => [],
    },
});
</script>

<template>
    <Head>
        <title>Careers & Editorial Fellowships — Knowledge Dynamics</title>
        <meta name="description" content="Explore career opportunities, editorial board fellowships, and freelance proofreading positions with Knowledge Dynamics Publishing." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Join Our Academic Network</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Careers & Editorial Roles</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Contribute your scientific expertise to high-impact international publishing. Explore editorial board appointments, manuscript copyediting, and freelance proofreading positions.
                    </p>
                </div>
            </div>
        </section>

        <!-- Positions List -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-4xl space-y-6">
                <div
                    v-for="pos in positions"
                    :key="pos.id"
                    class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-3"
                >
                    <div class="flex items-center justify-between">
                        <span class="text-[11px] font-bold text-navy-700 bg-navy-50 px-2.5 py-0.5 rounded border border-navy-100 uppercase">
                            {{ pos.department }}
                        </span>
                        <span class="text-xs text-academic-600 font-semibold">{{ pos.type }}</span>
                    </div>

                    <h3 class="text-xl font-bold text-gray-900 leading-snug">{{ pos.title }}</h3>
                    <p class="text-xs md:text-sm text-gray-600 leading-relaxed">{{ pos.summary }}</p>

                    <div class="pt-3 flex items-center justify-between border-t border-gray-100">
                        <span class="text-xs text-gray-500">Requirements: PhD or equivalent scholarly track record</span>
                        <Link :href="route('contact')" class="btn-primary text-xs py-2 px-5 shadow-sm">
                            Apply for Role →
                        </Link>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
