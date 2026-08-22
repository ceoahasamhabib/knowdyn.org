<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

defineProps({
    services: {
        type: Array,
        default: () => [],
    },
});

const defaultServices = [
    {
        title: 'Manuscript Editing',
        slug: 'manuscript-editing',
        description: 'Professional academic editing to refine language, clarity, and structure for journal submission. Our editors specialize in research manuscripts across health sciences, social sciences, and applied disciplines.',
        features: ['Language and grammar review', 'Structural consistency', 'Academic tone adjustment', 'Reference formatting'],
        icon: 'edit',
    },
    {
        title: 'Proofreading',
        slug: 'proofreading',
        description: 'Meticulous proofreading for spelling, punctuation, formatting, and consistency. The final quality check before journal submission.',
        features: ['Spelling and grammar', 'Punctuation and typography', 'Table and figure formatting', 'Reference accuracy'],
        icon: 'check',
        featured: true,
    },
    {
        title: 'Academic Formatting',
        slug: 'academic-formatting',
        description: 'Precision formatting according to APA, AMA, Vancouver, Chicago, or journal-specific style guides. Ensure your manuscript meets all formatting requirements.',
        features: ['APA, AMA, Vancouver, Chicago', 'Journal-specific templates', 'Table and figure formatting', 'Citation formatting'],
        icon: 'format',
    },
    {
        title: 'Journal Publishing Support',
        slug: 'journal-publishing-support',
        description: 'End-to-end guidance for journal setup, editorial workflow, indexing strategy, and operational management for academic institutions and publishers.',
        features: ['Journal setup and design', 'Editorial workflow', 'Indexing strategy', 'DOI and metadata'],
        icon: 'publish',
    },
    {
        title: 'Research Support',
        slug: 'research-support',
        description: 'Guidance and support for research methodology, data analysis, literature review, and manuscript preparation from experienced academics.',
        features: ['Research methodology', 'Literature review', 'Data analysis guidance', 'Manuscript structuring'],
        icon: 'research',
    },
    {
        title: 'Publication Consultancy',
        slug: 'publication-consultancy',
        description: 'Strategic guidance on journal selection, publication strategy, manuscript positioning, and maximizing research impact.',
        features: ['Journal selection', 'Impact strategy', 'Submission planning', 'Revision guidance'],
        icon: 'consult',
    },
];
</script>

<template>
    <Head>
        <title>Publishing Services — Knowledge Dynamics</title>
        <meta name="description" content="Knowledge Dynamics offers professional manuscript editing, proofreading, academic formatting, journal publishing support, research support, and publication consultancy services." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">Our Services</p>
                <h1 class="text-3xl md:text-4xl font-bold text-white max-w-2xl">Professional Publishing Services</h1>
                <p class="mt-4 text-navy-200 max-w-2xl text-base md:text-lg leading-relaxed">
                    Expert academic support from manuscript to publication. We help researchers prepare, refine, and publish their work at the highest standard.
                </p>
            </div>
        </section>

        <!-- Services grid -->
        <section class="section bg-white">
            <div class="container-wide">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <KdCard hover padding="normal" v-for="service in (services.length ? services : defaultServices)" :key="service.slug">
                        <div class="flex items-start gap-3 mb-4">
                            <div class="w-10 h-10 rounded-lg bg-academic-50 flex items-center justify-center shrink-0">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-academic-600">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M11.42 15.17 17.25 21A2.652 2.652 0 0 0 21 17.25l-5.877-5.877M11.42 15.17l2.496-3.03c.317-.384.74-.626 1.208-.766M11.42 15.17l-4.655 5.653a2.548 2.548 0 1 1-3.586-3.586l6.837-5.63m5.108-.233c.55-.164 1.163-.188 1.743-.14a4.5 4.5 0 0 0 4.486-6.336l-3.276 3.277a3.004 3.004 0 0 1-2.25-2.25l3.276-3.276a4.5 4.5 0 0 0-6.336 4.486c.091 1.076-.071 2.264-.904 2.95l-.102.085m-1.745 1.437L5.909 7.5H4.5L2.25 3.75l1.5-1.5L7.5 4.5v1.409l4.26 4.26m-1.745 1.437 1.745-1.437m6.615 8.206L15.75 15.75M4.867 19.125h.008v.008h-.008v-.008Z" />
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-base font-semibold text-gray-900">{{ service.title }}</h3>
                                <KdBadge v-if="service.featured" variant="oa" size="sm" class="mt-1">Popular</KdBadge>
                            </div>
                        </div>
                        <p class="text-sm text-gray-600 mb-4">{{ service.description }}</p>
                        <ul class="space-y-1.5 mb-5">
                            <li v-for="feature in service.features" :key="feature" class="flex items-center gap-2 text-sm text-gray-500">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-3.5 h-3.5 text-emerald-500 shrink-0"><path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5" /></svg>
                                {{ feature }}
                            </li>
                        </ul>
                        <Link href="/contact" class="btn-secondary w-full justify-center text-sm">
                            Request Service
                        </Link>
                    </KdCard>
                </div>
            </div>
        </section>

        <!-- Process -->
        <section class="section bg-gray-50">
            <div class="container-narrow">
                <div class="section-header text-center">
                    <p class="text-xs font-semibold uppercase tracking-widest text-academic-500 mb-2">How It Works</p>
                    <h2 class="text-2xl md:text-3xl font-bold text-gray-900">Our Process</h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div v-for="(step, i) in [
                        { title: 'Submit Request', description: 'Tell us about your manuscript and select the service you need.' },
                        { title: 'Get a Quote', description: 'We review your requirements and provide a transparent estimate.' },
                        { title: 'Work Begins', description: 'Our expert team works on your manuscript with care and precision.' },
                        { title: 'Delivery', description: 'Receive your polished manuscript, ready for submission.' },
                    ]" :key="i" class="text-center relative">
                        <div class="w-10 h-10 rounded-full bg-navy-700 text-white font-bold text-sm flex items-center justify-center mx-auto mb-3">
                            {{ i + 1 }}
                        </div>
                        <h3 class="text-sm font-semibold text-gray-900">{{ step.title }}</h3>
                        <p class="mt-1 text-xs text-gray-500">{{ step.description }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <section class="bg-navy-700">
            <div class="container-wide py-12 md:py-16 text-center">
                <h2 class="text-2xl md:text-3xl font-bold text-white">Need Help With Your Manuscript?</h2>
                <p class="mt-3 text-navy-200 max-w-lg mx-auto">
                    Contact us to discuss your requirements and get a personalized quote.
                </p>
                <div class="mt-8">
                    <Link href="/contact" class="btn bg-white text-navy-700 hover:bg-gray-100 focus:ring-white btn-lg font-semibold">
                        Contact Us
                    </Link>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
