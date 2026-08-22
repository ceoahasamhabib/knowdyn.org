<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

defineProps({
    researchers: Object,
});
</script>

<template>
    <Head>
        <title>Researchers — Knowledge Dynamics</title>
        <meta name="description" content="Discover researchers, academics, and scientists on Knowledge Dynamics. Explore profiles, publications, and research projects." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">Researcher Network</p>
                <h1 class="text-3xl md:text-4xl font-bold text-white">Researchers</h1>
                <p class="mt-4 text-navy-200 max-w-xl text-base leading-relaxed">
                    Explore researcher profiles, publications, and research projects on Knowledge Dynamics.
                </p>
            </div>
        </section>

        <section class="section bg-white">
            <div class="container-wide">
                <div v-if="researchers.data && researchers.data.length" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
                    <KdCard hover padding="normal" v-for="user in researchers.data" :key="user.id">
                        <div class="text-center">
                            <!-- Avatar -->
                            <div class="w-16 h-16 mx-auto rounded-full bg-navy-100 flex items-center justify-center text-navy-600 text-xl font-bold mb-3">
                                {{ (user.first_name?.[0] || user.name?.[0] || '?').toUpperCase() }}
                            </div>
                            <h3 class="text-base font-semibold text-gray-900">
                                {{ user.first_name ? `${user.first_name} ${user.last_name || ''}` : user.name }}
                            </h3>
                            <p v-if="user.researcher_profile?.institution" class="text-xs text-gray-500 mt-0.5">
                                {{ user.researcher_profile.institution }}
                            </p>
                            <p v-if="user.researcher_profile?.country" class="text-xs text-gray-400">
                                {{ user.researcher_profile.country }}
                            </p>

                            <!-- Interests -->
                            <div v-if="user.researcher_profile?.interests?.length" class="mt-3 flex flex-wrap justify-center gap-1">
                                <KdBadge variant="primary" size="sm" v-for="interest in user.researcher_profile.interests.slice(0, 3)" :key="interest.id">
                                    {{ interest.interest }}
                                </KdBadge>
                            </div>

                            <Link v-if="user.username" :href="`/researchers/${user.username}`" class="btn-secondary btn-sm mt-4 w-full justify-center">
                                View Profile
                            </Link>
                        </div>
                    </KdCard>
                </div>

                <div v-else class="text-center py-16">
                    <div class="w-16 h-16 mx-auto rounded-full bg-gray-100 flex items-center justify-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8 text-gray-300">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z" />
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900">No Researchers Yet</h3>
                    <p class="mt-1 text-sm text-gray-500 max-w-sm mx-auto">Researcher profiles will appear here once members create their academic profiles.</p>
                    <Link href="/register" class="btn-primary btn-sm mt-4">Join as Researcher</Link>
                </div>

                <!-- Pagination -->
                <nav v-if="researchers.last_page > 1" class="mt-8 flex justify-center gap-1">
                    <Link
                        v-for="link in researchers.links"
                        :key="link.label"
                        :href="link.url || '#'"
                        v-html="link.label"
                        class="px-3 py-1.5 text-sm rounded-md"
                        :class="link.active ? 'bg-navy-700 text-white' : (link.url ? 'text-gray-600 hover:bg-gray-100' : 'text-gray-300 cursor-not-allowed')"
                    />
                </nav>
            </div>
        </section>
    </PublicLayout>
</template>
