<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const values = [
    { title: 'Academic Excellence', description: 'We uphold the highest standards of scholarly publishing through rigorous peer review and editorial oversight.', icon: 'star' },
    { title: 'Open Access', description: 'Research should be freely accessible to all. We are committed to making knowledge available without barriers.', icon: 'open' },
    { title: 'Research Integrity', description: 'We maintain strict ethical standards in publishing, ensuring transparency and accountability in every publication.', icon: 'shield' },
    { title: 'Innovation', description: 'We leverage modern technology to improve the academic publishing experience for researchers, editors, and readers.', icon: 'spark' },
];

const milestones = [
    { year: '2024', event: 'Knowledge Dynamics founded as an academic publishing initiative.' },
    { year: '2024', event: 'Launched Health Dynamics — our first peer-reviewed journal.' },
    { year: '2025', event: 'Published 189+ research articles across multiple health science disciplines.' },
    { year: '2026', event: 'Platform modernisation — transitioning to a full academic publishing ecosystem.' },
];
</script>

<template>
    <Head>
        <title>About Us — Knowledge Dynamics</title>
        <meta name="description" content="Learn about Knowledge Dynamics — an academic publishing platform committed to advancing research through rigorous peer review, open access, and researcher empowerment." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">About Us</p>
                <h1 class="text-3xl md:text-4xl font-bold text-white max-w-2xl">Advancing Research Through Academic Publishing</h1>
                <p class="mt-4 text-navy-200 max-w-2xl text-base md:text-lg leading-relaxed">
                    Knowledge Dynamics is an academic publishing platform dedicated to empowering researchers, strengthening peer review, and making scholarly knowledge accessible to all.
                </p>
            </div>
        </section>

        <!-- Mission -->
        <section class="section bg-white">
            <div class="container-wide">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                    <div>
                        <p class="text-xs font-semibold uppercase tracking-widest text-academic-500 mb-2">Our Mission</p>
                        <h2 class="text-2xl md:text-3xl font-bold text-gray-900">Building the Future of Academic Publishing</h2>
                        <p class="mt-4 text-gray-600 leading-relaxed">
                            We believe that academic publishing should serve the research community — not the other way around. Knowledge Dynamics exists to provide researchers with a modern, transparent, and researcher-friendly platform for sharing their work with the world.
                        </p>
                        <p class="mt-3 text-gray-600 leading-relaxed">
                            Our platform combines rigorous peer review, open access principles, and modern technology to create a publishing experience that respects the effort and integrity of academic research.
                        </p>
                    </div>
                    <div class="bg-navy-50 rounded-xl p-8 md:p-10">
                        <blockquote class="text-lg font-medium text-navy-700 italic leading-relaxed">
                            "Research advances when knowledge flows freely. Our mission is to remove barriers between researchers and the communities that need their discoveries."
                        </blockquote>
                        <p class="mt-4 text-sm font-semibold text-navy-600">— Knowledge Dynamics Team</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Values -->
        <section class="section bg-gray-50">
            <div class="container-wide">
                <div class="section-header text-center">
                    <p class="text-xs font-semibold uppercase tracking-widest text-academic-500 mb-2">Our Values</p>
                    <h2 class="text-2xl md:text-3xl font-bold text-gray-900">What We Stand For</h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
                    <KdCard padding="normal" v-for="value in values" :key="value.title">
                        <div class="w-10 h-10 rounded-lg bg-navy-50 flex items-center justify-center mb-4">
                            <svg v-if="value.icon === 'star'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-navy-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11.48 3.499a.562.562 0 0 1 1.04 0l2.125 5.111a.563.563 0 0 0 .475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 0 0-.182.557l1.285 5.385a.562.562 0 0 1-.84.61l-4.725-2.885a.562.562 0 0 0-.586 0L6.982 20.54a.562.562 0 0 1-.84-.61l1.285-5.386a.562.562 0 0 0-.182-.557l-4.204-3.602a.562.562 0 0 1 .321-.988l5.518-.442a.563.563 0 0 0 .475-.345L11.48 3.5Z" />
                            </svg>
                            <svg v-if="value.icon === 'open'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-navy-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 10.5V6.75a4.5 4.5 0 1 1 9 0v3.75M3.75 21.75h10.5a2.25 2.25 0 0 0 2.25-2.25v-6.75a2.25 2.25 0 0 0-2.25-2.25H3.75a2.25 2.25 0 0 0-2.25 2.25v6.75a2.25 2.25 0 0 0 2.25 2.25Z" />
                            </svg>
                            <svg v-if="value.icon === 'shield'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-navy-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75m-3-7.036A11.959 11.959 0 0 1 3.598 6 11.99 11.99 0 0 0 3 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285Z" />
                            </svg>
                            <svg v-if="value.icon === 'spark'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-navy-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9.813 15.904 9 18.75l-.813-2.846a4.5 4.5 0 0 0-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 0 0 3.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 0 0 3.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 0 0-3.09 3.09ZM18.259 8.715 18 9.75l-.259-1.035a3.375 3.375 0 0 0-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 0 0 2.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 0 0 2.455 2.456L21.75 6l-1.036.259a3.375 3.375 0 0 0-2.455 2.456ZM16.894 20.567 16.5 21.75l-.394-1.183a2.25 2.25 0 0 0-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 0 0 1.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 0 0 1.423 1.423l1.183.394-1.183.394a2.25 2.25 0 0 0-1.423 1.423Z" />
                            </svg>
                        </div>
                        <h3 class="text-base font-semibold text-gray-900">{{ value.title }}</h3>
                        <p class="mt-2 text-sm text-gray-500">{{ value.description }}</p>
                    </KdCard>
                </div>
            </div>
        </section>

        <!-- Timeline -->
        <section class="section bg-white">
            <div class="container-narrow">
                <div class="section-header text-center">
                    <p class="text-xs font-semibold uppercase tracking-widest text-academic-500 mb-2">Our Journey</p>
                    <h2 class="text-2xl md:text-3xl font-bold text-gray-900">Milestones</h2>
                </div>

                <div class="relative">
                    <div class="absolute left-4 md:left-1/2 top-0 bottom-0 w-px bg-gray-200" />
                    <div class="space-y-10">
                        <div v-for="(milestone, i) in milestones" :key="i" class="relative flex items-start gap-6 md:gap-8" :class="i % 2 === 0 ? 'md:flex-row' : 'md:flex-row-reverse'">
                            <div class="absolute left-4 md:left-1/2 w-3 h-3 bg-navy-600 rounded-full -translate-x-1.5 mt-1.5 ring-4 ring-white" />
                            <div class="pl-10 md:pl-0 md:w-1/2" :class="i % 2 === 0 ? 'md:pr-12 md:text-right' : 'md:pl-12'">
                                <span class="text-sm font-bold text-academic-500">{{ milestone.year }}</span>
                                <p class="mt-1 text-gray-700">{{ milestone.event }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <section class="bg-navy-700">
            <div class="container-wide py-12 md:py-16 text-center">
                <h2 class="text-2xl md:text-3xl font-bold text-white">Join the Knowledge Dynamics Community</h2>
                <p class="mt-3 text-navy-200 max-w-lg mx-auto">
                    Whether you are a researcher, an author, or an editor — we welcome you.
                </p>
                <div class="mt-8 flex flex-wrap justify-center gap-3">
                    <Link href="/register" class="btn bg-white text-navy-700 hover:bg-gray-100 focus:ring-white btn-lg font-semibold">
                        Create Account
                    </Link>
                    <Link href="/contact" class="btn border-2 border-white/30 text-white hover:bg-white/10 focus:ring-white btn-lg font-medium">
                        Contact Us
                    </Link>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
