<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

defineProps({
    projects: Object,
});

const statusColors = {
    active: 'success',
    completed: 'info',
    planned: 'warning',
    cancelled: 'danger',
};
</script>

<template>
    <Head>
        <title>Research Projects — Knowledge Dynamics</title>
        <meta name="description" content="Explore research projects on Knowledge Dynamics. Discover active and completed research initiatives by our academic community." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">Research</p>
                <h1 class="text-3xl md:text-4xl font-bold text-white">Research Projects</h1>
                <p class="mt-4 text-navy-200 max-w-xl text-base leading-relaxed">
                    Discover active and completed research initiatives across our academic community.
                </p>
            </div>
        </section>

        <section class="section bg-white">
            <div class="container-wide">
                <div v-if="projects.data && projects.data.length" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    <KdCard hover padding="none" v-for="project in projects.data" :key="project.id">
                        <div class="p-6">
                            <div class="flex items-center gap-2 mb-3">
                                <KdBadge :variant="statusColors[project.status] || 'default'" size="sm">{{ project.status }}</KdBadge>
                                <span v-if="project.research_area" class="text-xs text-gray-400">{{ project.research_area }}</span>
                            </div>
                            <h3 class="text-base font-semibold text-gray-900 line-clamp-2">{{ project.title }}</h3>
                            <p v-if="project.summary" class="mt-2 text-sm text-gray-500 line-clamp-3">{{ project.summary }}</p>
                            <div class="mt-3 text-xs text-gray-400">
                                <span v-if="project.institution">{{ project.institution }}</span>
                                <span v-if="project.start_date"> • {{ project.start_date }}</span>
                            </div>
                            <div v-if="project.lead_researcher" class="mt-3 flex items-center gap-2">
                                <div class="w-6 h-6 rounded-full bg-navy-100 flex items-center justify-center text-navy-600 text-xs font-bold">
                                    {{ (project.lead_researcher.first_name?.[0] || project.lead_researcher.name?.[0] || '?').toUpperCase() }}
                                </div>
                                <span class="text-xs text-gray-500">
                                    {{ project.lead_researcher.first_name ? `${project.lead_researcher.first_name} ${project.lead_researcher.last_name || ''}` : project.lead_researcher.name }}
                                </span>
                            </div>
                        </div>
                        <div class="border-t border-gray-100 px-6 py-3">
                            <Link :href="`/projects/${project.slug}`" class="text-sm font-medium text-navy-600 hover:text-academic-500 transition-colors">
                                View Project →
                            </Link>
                        </div>
                    </KdCard>
                </div>

                <div v-else class="text-center py-16">
                    <div class="w-16 h-16 mx-auto rounded-full bg-gray-100 flex items-center justify-center mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8 text-gray-300">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 9.776c.112-.017.227-.026.344-.026h15.812c.117 0 .232.009.344.026m-16.5 0a2.25 2.25 0 0 0-1.883 2.542l.857 6a2.25 2.25 0 0 0 2.227 1.932H19.05a2.25 2.25 0 0 0 2.227-1.932l.857-6a2.25 2.25 0 0 0-1.883-2.542m-16.5 0V6A2.25 2.25 0 0 1 6 3.75h3.879a1.5 1.5 0 0 1 1.06.44l2.122 2.12a1.5 1.5 0 0 0 1.06.44H18A2.25 2.25 0 0 1 20.25 9v.776" />
                        </svg>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900">No Projects Yet</h3>
                    <p class="mt-1 text-sm text-gray-500 max-w-sm mx-auto">Research projects will appear here once researchers publish their ongoing work.</p>
                </div>

                <!-- Pagination -->
                <nav v-if="projects.last_page > 1" class="mt-8 flex justify-center gap-1">
                    <Link
                        v-for="link in projects.links"
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
