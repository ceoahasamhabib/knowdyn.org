<script setup>
import { Head, Link } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    manuscript: {
        type: Object,
        required: true,
    },
});

const workflowStages = [
    { key: 'submitted', label: 'Submitted' },
    { key: 'screening', label: 'Initial Screening' },
    { key: 'editor_assigned', label: 'Editor Assigned' },
    { key: 'under_review', label: 'Under Review' },
    { key: 'accepted', label: 'Editorial Decision' },
    { key: 'production', label: 'Production' },
    { key: 'published', label: 'Published' },
];

const getStageIndex = (status) => {
    const stageMap = {
        'draft': 0,
        'submitted': 1,
        'screening': 2,
        'editor_assigned': 3,
        'under_review': 4,
        'revision_required': 4,
        'resubmitted': 4,
        'accepted': 5,
        'rejected': 5,
        'production': 6,
        'published': 7,
    };
    return stageMap[status] || 1;
};

const currentStageIndex = getStageIndex(props.manuscript.status);
</script>

<template>
    <Head :title="`Submission Status — ${manuscript.title}`" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('author.submissions.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Submissions
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900 truncate max-w-xl">Manuscript Tracker: {{ manuscript.title }}</h1>
            </div>
        </template>

        <div class="max-w-5xl mx-auto space-y-8">
            <!-- Progress Tracker Bar -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm">
                <div class="flex items-center justify-between border-b border-gray-100 pb-4 mb-6">
                    <div>
                        <span class="text-xs font-bold text-gray-500 uppercase tracking-widest">Workflow Progress</span>
                        <h2 class="text-lg font-bold text-gray-900 mt-0.5">
                            Status: <span class="capitalize text-navy-800">{{ manuscript.status.replace('_', ' ') }}</span>
                        </h2>
                    </div>

                    <span class="text-xs font-mono bg-gray-100 text-gray-600 px-3 py-1 rounded-full">
                        Submitted {{ manuscript.submitted_at ? new Date(manuscript.submitted_at).toLocaleDateString() : 'Recent' }}
                    </span>
                </div>

                <!-- Stages Visualizer -->
                <div class="grid grid-cols-2 sm:grid-cols-7 gap-2">
                    <div
                        v-for="(stage, idx) in workflowStages"
                        :key="stage.key"
                        class="flex flex-col items-center text-center p-3 rounded-lg border text-xs"
                        :class="[
                            idx + 1 < currentStageIndex ? 'bg-emerald-50 border-emerald-200 text-emerald-800' :
                            idx + 1 === currentStageIndex ? 'bg-navy-800 border-navy-800 text-white font-bold shadow-md' :
                            'bg-gray-50 border-gray-200 text-gray-400'
                        ]"
                    >
                        <div class="w-6 h-6 rounded-full flex items-center justify-center mb-1 text-[11px]"
                             :class="idx + 1 < currentStageIndex ? 'bg-emerald-200 text-emerald-900' : idx + 1 === currentStageIndex ? 'bg-white text-navy-900 font-bold' : 'bg-gray-200 text-gray-600'">
                            <span v-if="idx + 1 < currentStageIndex">✓</span>
                            <span v-else>{{ idx + 1 }}</span>
                        </div>
                        <span class="text-[11px] leading-tight">{{ stage.label }}</span>
                    </div>
                </div>
            </div>

            <!-- Manuscript Summary & Details -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Left Details -->
                <div class="md:col-span-2 space-y-6">
                    <!-- Overview Card -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-4">
                        <div class="flex items-center gap-2">
                            <span class="w-2 h-5 bg-navy-700 rounded-full"></span>
                            <h3 class="font-bold text-gray-900 text-base">Manuscript Overview</h3>
                        </div>

                        <div>
                            <h4 class="text-xs font-semibold text-gray-400 uppercase">Title</h4>
                            <p class="text-sm font-bold text-gray-900 mt-0.5 leading-snug">{{ manuscript.title }}</p>
                        </div>

                        <div>
                            <h4 class="text-xs font-semibold text-gray-400 uppercase">Abstract</h4>
                            <p class="text-xs text-gray-700 mt-1 leading-relaxed whitespace-pre-line">{{ manuscript.abstract }}</p>
                        </div>

                        <div v-if="manuscript.cover_letter">
                            <h4 class="text-xs font-semibold text-gray-400 uppercase">Cover Letter</h4>
                            <p class="text-xs text-gray-600 mt-1 italic">{{ manuscript.cover_letter }}</p>
                        </div>
                    </div>

                    <!-- Authors Card -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-4">
                        <div class="flex items-center gap-2">
                            <span class="w-2 h-5 bg-navy-700 rounded-full"></span>
                            <h3 class="font-bold text-gray-900 text-base">Authors & Affiliations</h3>
                        </div>

                        <div class="divide-y divide-gray-100 text-xs">
                            <div v-for="(author, idx) in manuscript.authors" :key="author.id || idx" class="py-2.5 flex items-center justify-between">
                                <div>
                                    <span class="font-bold text-gray-900">{{ idx + 1 }}. {{ author.first_name }} {{ author.last_name }}</span>
                                    <span v-if="author.is_corresponding" class="ml-2 text-academic-700 font-bold">(Corresponding)</span>
                                    <div class="text-gray-500 mt-0.5">{{ author.affiliation }}</div>
                                </div>
                                <span v-if="author.orcid" class="font-mono text-emerald-600 text-[11px]">{{ author.orcid }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Sidebar: Journal & History -->
                <div class="space-y-6">
                    <!-- Journal Card -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-3 text-xs">
                        <h3 class="font-bold text-gray-900 text-sm border-b border-gray-100 pb-2">Target Journal</h3>
                        <div>
                            <span class="text-gray-400 block">Journal</span>
                            <span class="font-bold text-navy-900 text-sm">{{ manuscript.journal?.title }}</span>
                        </div>
                        <div>
                            <span class="text-gray-400 block">Article Type</span>
                            <span class="font-medium text-gray-800 capitalize">{{ (manuscript.article_type || 'original-research').replace('-', ' ') }}</span>
                        </div>
                        <div>
                            <span class="text-gray-400 block">Submission Date</span>
                            <span class="font-medium text-gray-800">{{ manuscript.submitted_at ? new Date(manuscript.submitted_at).toLocaleDateString() : 'N/A' }}</span>
                        </div>
                    </div>

                    <!-- Workflow History Log -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-4 text-xs">
                        <h3 class="font-bold text-gray-900 text-sm border-b border-gray-100 pb-2">Workflow Activity Log</h3>

                        <div v-if="manuscript.status_history && manuscript.status_history.length > 0" class="space-y-3">
                            <div v-for="log in manuscript.status_history" :key="log.id" class="border-l-2 border-navy-600 pl-3 py-1">
                                <div class="font-bold text-gray-800 capitalize">{{ log.to_status.replace('_', ' ') }}</div>
                                <div class="text-gray-500 text-[11px]">{{ log.comment }}</div>
                                <div class="text-gray-400 text-[10px] mt-0.5">{{ new Date(log.created_at).toLocaleString() }}</div>
                            </div>
                        </div>

                        <div v-else class="text-gray-400 italic">
                            Initial submission logged.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
