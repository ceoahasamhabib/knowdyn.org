<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    project: Object,
});

const statusColors = {
    active: 'success',
    completed: 'info',
    planned: 'warning',
    cancelled: 'danger',
};

const lead = props.project?.lead_researcher;
const leadName = lead?.first_name ? `${lead.first_name} ${lead.last_name || ''}` : lead?.name || '';
</script>

<template>
    <Head>
        <title>{{ project.title }} — Knowledge Dynamics</title>
        <meta :content="`${project.summary || project.title} — Research project on Knowledge Dynamics.`" name="description" />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <div class="flex items-center gap-2 mb-3">
                    <KdBadge :variant="statusColors[project.status] || 'default'" size="sm">{{ project.status }}</KdBadge>
                    <span v-if="project.research_area" class="text-xs text-navy-300">{{ project.research_area }}</span>
                </div>
                <h1 class="text-2xl sm:text-3xl md:text-4xl font-bold text-white max-w-3xl">{{ project.title }}</h1>
                <p v-if="project.institution" class="mt-2 text-navy-200 text-sm">{{ project.institution }}</p>
                <div class="mt-3 flex flex-wrap gap-4 text-xs text-navy-300">
                    <span v-if="project.start_date">Started: {{ project.start_date }}</span>
                    <span v-if="project.end_date">Ended: {{ project.end_date }}</span>
                </div>
            </div>
        </section>

        <section class="section bg-white">
            <div class="container-wide">
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Main content -->
                    <div class="lg:col-span-2">
                        <div v-if="project.summary">
                            <h2 class="text-lg font-semibold text-gray-900 mb-3">Summary</h2>
                            <p class="text-sm text-gray-600 leading-relaxed whitespace-pre-line">{{ project.summary }}</p>
                        </div>

                        <!-- Members -->
                        <div v-if="project.members?.length" class="mt-8">
                            <h2 class="text-lg font-semibold text-gray-900 mb-3">Team Members</h2>
                            <div class="space-y-3">
                                <div v-for="member in project.members" :key="member.id" class="flex items-center gap-3 p-3 rounded-lg bg-gray-50">
                                    <div class="w-8 h-8 rounded-full bg-navy-100 flex items-center justify-center text-navy-600 text-xs font-bold shrink-0">
                                        {{ (member.first_name?.[0] || member.name?.[0] || '?').toUpperCase() }}
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-sm font-medium text-gray-900">
                                            {{ member.first_name ? `${member.first_name} ${member.last_name || ''}` : member.name }}
                                        </p>
                                        <p v-if="member.pivot?.role" class="text-xs text-gray-500">{{ member.pivot.role }}</p>
                                    </div>
                                    <Link v-if="member.username" :href="`/researchers/${member.username}`" class="text-xs text-navy-600 hover:text-academic-500">
                                        Profile →
                                    </Link>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <div class="space-y-6">
                        <!-- Lead Researcher -->
                        <KdCard padding="normal" v-if="lead">
                            <h3 class="text-sm font-semibold text-gray-900 mb-3">Lead Researcher</h3>
                            <div class="flex items-center gap-3">
                                <div class="w-10 h-10 rounded-full bg-navy-100 flex items-center justify-center text-navy-600 font-bold shrink-0">
                                    {{ (lead.first_name?.[0] || lead.name?.[0] || '?').toUpperCase() }}
                                </div>
                                <div>
                                    <p class="text-sm font-medium text-gray-900">{{ leadName }}</p>
                                    <Link v-if="lead.username" :href="`/researchers/${lead.username}`" class="text-xs text-navy-600 hover:text-academic-500">
                                        View Profile
                                    </Link>
                                </div>
                            </div>
                        </KdCard>

                        <!-- Details -->
                        <KdCard padding="normal">
                            <h3 class="text-sm font-semibold text-gray-900 mb-3">Project Details</h3>
                            <div class="space-y-2.5 text-sm">
                                <div>
                                    <p class="text-xs text-gray-400">Status</p>
                                    <KdBadge :variant="statusColors[project.status] || 'default'" size="sm">{{ project.status }}</KdBadge>
                                </div>
                                <div v-if="project.research_area">
                                    <p class="text-xs text-gray-400">Research Area</p>
                                    <p class="text-gray-700">{{ project.research_area }}</p>
                                </div>
                                <div v-if="project.institution">
                                    <p class="text-xs text-gray-400">Institution</p>
                                    <p class="text-gray-700">{{ project.institution }}</p>
                                </div>
                                <div v-if="project.external_url">
                                    <p class="text-xs text-gray-400">External Link</p>
                                    <a :href="project.external_url" target="_blank" rel="noopener" class="text-academic-600 hover:text-academic-700 text-sm">Visit →</a>
                                </div>
                            </div>
                        </KdCard>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
