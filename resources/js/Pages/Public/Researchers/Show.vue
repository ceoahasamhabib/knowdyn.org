<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    researcher: Object,
});

const profile = props.researcher?.researcher_profile;
const fullName = props.researcher?.first_name
    ? `${props.researcher.first_name} ${props.researcher.last_name || ''}`
    : props.researcher?.name || '';
</script>

<template>
    <Head>
        <title>{{ fullName }} — Knowledge Dynamics</title>
        <meta :content="`Academic profile of ${fullName} on Knowledge Dynamics. ${profile?.institution || ''}`" name="description" />
    </Head>

    <PublicLayout>
        <!-- Header -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <div class="flex flex-col sm:flex-row items-start gap-6">
                    <!-- Avatar -->
                    <div class="w-20 h-20 sm:w-24 sm:h-24 rounded-full bg-navy-500 flex items-center justify-center text-white text-2xl sm:text-3xl font-bold ring-4 ring-white/20 shrink-0">
                        {{ (researcher?.first_name?.[0] || researcher?.name?.[0] || '?').toUpperCase() }}
                    </div>
                    <div>
                        <h1 class="text-2xl sm:text-3xl md:text-4xl font-bold text-white">{{ fullName }}</h1>
                        <p v-if="profile?.institution" class="text-navy-200 mt-1">{{ profile.institution }}</p>
                        <p v-if="profile?.department" class="text-navy-300 text-sm">{{ profile.department }}</p>
                        <p v-if="profile?.country" class="text-navy-300 text-sm mt-0.5">
                            {{ profile.city ? `${profile.city}, ` : '' }}{{ profile.country }}
                        </p>

                        <!-- Social links -->
                        <div class="mt-3 flex flex-wrap gap-2">
                            <a v-if="profile?.orcid" :href="`https://orcid.org/${profile.orcid}`" target="_blank" rel="noopener noreferrer"
                               class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-white/10 text-white/80 text-xs hover:bg-white/20 transition-colors">
                                ORCID
                            </a>
                            <a v-if="profile?.google_scholar" :href="profile.google_scholar" target="_blank" rel="noopener noreferrer"
                               class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-white/10 text-white/80 text-xs hover:bg-white/20 transition-colors">
                                Google Scholar
                            </a>
                            <a v-if="profile?.linkedin" :href="profile.linkedin" target="_blank" rel="noopener noreferrer"
                               class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-white/10 text-white/80 text-xs hover:bg-white/20 transition-colors">
                                LinkedIn
                            </a>
                            <a v-if="profile?.website" :href="profile.website" target="_blank" rel="noopener noreferrer"
                               class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-white/10 text-white/80 text-xs hover:bg-white/20 transition-colors">
                                Website
                            </a>
                            <a v-if="profile?.research_gate" :href="profile.research_gate" target="_blank" rel="noopener noreferrer"
                               class="inline-flex items-center gap-1 px-2.5 py-1 rounded-full bg-white/10 text-white/80 text-xs hover:bg-white/20 transition-colors">
                                ResearchGate
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section bg-white">
            <div class="container-wide">
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Main content -->
                    <div class="lg:col-span-2 space-y-8">
                        <!-- Biography -->
                        <div v-if="profile?.biography">
                            <h2 class="text-lg font-semibold text-gray-900 mb-3">Biography</h2>
                            <div class="text-sm text-gray-600 leading-relaxed whitespace-pre-line">{{ profile.biography }}</div>
                        </div>

                        <!-- Expertise -->
                        <div v-if="profile?.expertise">
                            <h2 class="text-lg font-semibold text-gray-900 mb-3">Expertise</h2>
                            <p class="text-sm text-gray-600 leading-relaxed">{{ profile.expertise }}</p>
                        </div>

                        <!-- Affiliations -->
                        <div v-if="profile?.affiliations?.length">
                            <h2 class="text-lg font-semibold text-gray-900 mb-3">Affiliations</h2>
                            <div class="space-y-3">
                                <KdCard padding="normal" v-for="aff in profile.affiliations" :key="aff.id">
                                    <div class="flex items-start gap-3">
                                        <div class="w-8 h-8 rounded bg-navy-50 flex items-center justify-center shrink-0 mt-0.5">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 text-navy-600">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.438 60.438 0 0 0-.491 6.347A48.62 48.62 0 0 1 12 20.904a48.62 48.62 0 0 1 8.232-4.41 60.46 60.46 0 0 0-.491-6.347m-15.482 0a50.636 50.636 0 0 0-2.658-.813A59.906 59.906 0 0 1 12 3.493a59.903 59.903 0 0 1 10.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.717 50.717 0 0 1 12 13.489a50.702 50.702 0 0 1 7.74-3.342M6.75 15a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Zm0 0v-3.675A55.378 55.378 0 0 1 12 8.443m-7.007 11.55A5.981 5.981 0 0 0 6.75 15.75v-1.5" />
                                            </svg>
                                        </div>
                                        <div>
                                            <p class="text-sm font-semibold text-gray-900">{{ aff.institution }}</p>
                                            <p v-if="aff.position" class="text-xs text-gray-600">{{ aff.position }}</p>
                                            <p v-if="aff.department" class="text-xs text-gray-500">{{ aff.department }}</p>
                                            <div class="flex items-center gap-2 mt-1">
                                                <KdBadge v-if="aff.is_current" variant="oa" size="sm">Current</KdBadge>
                                                <span v-if="aff.start_date" class="text-xs text-gray-400">
                                                    {{ aff.start_date }}{{ aff.end_date ? ` — ${aff.end_date}` : '' }}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </KdCard>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <div class="space-y-6">
                        <!-- Research Interests -->
                        <KdCard padding="normal" v-if="profile?.interests?.length">
                            <h3 class="text-sm font-semibold text-gray-900 mb-3">Research Interests</h3>
                            <div class="flex flex-wrap gap-1.5">
                                <KdBadge variant="primary" size="sm" v-for="interest in profile.interests" :key="interest.id">
                                    {{ interest.interest }}
                                </KdBadge>
                            </div>
                        </KdCard>

                        <!-- Quick info -->
                        <KdCard padding="normal">
                            <h3 class="text-sm font-semibold text-gray-900 mb-3">Profile</h3>
                            <div class="space-y-2.5 text-sm">
                                <div v-if="researcher.username">
                                    <p class="text-xs text-gray-400">Username</p>
                                    <p class="text-gray-700">@{{ researcher.username }}</p>
                                </div>
                                <div v-if="profile?.orcid">
                                    <p class="text-xs text-gray-400">ORCID</p>
                                    <a :href="`https://orcid.org/${profile.orcid}`" target="_blank" class="text-academic-600 hover:text-academic-700">{{ profile.orcid }}</a>
                                </div>
                                <div v-if="profile?.institution">
                                    <p class="text-xs text-gray-400">Institution</p>
                                    <p class="text-gray-700">{{ profile.institution }}</p>
                                </div>
                                <div v-if="profile?.country">
                                    <p class="text-xs text-gray-400">Location</p>
                                    <p class="text-gray-700">{{ profile.city ? `${profile.city}, ` : '' }}{{ profile.country }}</p>
                                </div>
                            </div>
                        </KdCard>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
