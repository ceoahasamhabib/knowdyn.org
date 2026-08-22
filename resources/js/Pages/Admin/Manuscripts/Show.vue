<script setup>
import { ref } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    manuscript: {
        type: Object,
        required: true,
    },
    editors: {
        type: Array,
        default: () => [],
    },
    potentialReviewers: {
        type: Array,
        default: () => [],
    },
});

// Forms
const screeningForm = useForm({
    comment: 'Manuscript passed initial technical and ethical screening.',
});

const assignEditorForm = useForm({
    editor_id: props.manuscript.editor_id || props.editors?.[0]?.id || '',
    comment: '',
});

const inviteReviewerForm = useForm({
    reviewer_id: props.potentialReviewers?.[0]?.id || '',
    due_date: new Date(Date.now() + 21 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
});

const decisionForm = useForm({
    decision: 'accepted',
    comment: '',
});

const handleScreening = () => {
    screeningForm.post(route('admin.manuscripts.screening', props.manuscript.id));
};

const handleAssignEditor = () => {
    assignEditorForm.post(route('admin.manuscripts.assign_editor', props.manuscript.id));
};

const handleInviteReviewer = () => {
    inviteReviewerForm.post(route('admin.manuscripts.invite_reviewer', props.manuscript.id));
};

const handleDecision = () => {
    if (confirm(`Are you sure you want to record the editorial decision "${decisionForm.decision}" for this manuscript?`)) {
        decisionForm.post(route('admin.manuscripts.decision', props.manuscript.id));
    }
};
</script>

<template>
    <Head :title="`Editorial Cockpit — ${manuscript.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div class="flex items-center gap-3">
                    <Link :href="route('admin.manuscripts.index')" class="text-xs text-gray-500 hover:text-gray-700">
                        ← Manuscripts Queue
                    </Link>
                    <span class="text-gray-300">/</span>
                    <h1 class="text-lg font-bold text-gray-900 truncate max-w-lg">{{ manuscript.title }}</h1>
                </div>

                <div class="flex items-center gap-2">
                    <span class="text-xs font-semibold px-3 py-1 rounded-full border bg-navy-50 text-navy-800 border-navy-200 capitalize">
                        Status: {{ manuscript.status.replace('_', ' ') }}
                    </span>
                </div>
            </div>
        </template>

        <div class="max-w-6xl space-y-8">
            <!-- Top Grid: Manuscript Info & Primary Actions -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Left: Manuscript Details & Abstract -->
                <div class="lg:col-span-2 space-y-6">
                    <!-- Manuscript Summary -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4">
                        <div class="flex items-center justify-between border-b border-gray-100 pb-3">
                            <span class="text-xs font-bold text-gray-500 uppercase tracking-wider">Manuscript Details</span>
                            <span class="text-xs text-gray-400 font-mono">ID: #{{ manuscript.id }}</span>
                        </div>

                        <div>
                            <h2 class="text-lg font-bold text-gray-900 leading-snug">{{ manuscript.title }}</h2>
                            <p class="text-xs text-navy-700 font-semibold mt-1">
                                Target Journal: {{ manuscript.journal?.title }} • Type: {{ (manuscript.article_type || 'original-research').replace('-', ' ') }}
                            </p>
                        </div>

                        <div>
                            <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">Abstract</h3>
                            <p class="text-xs md:text-sm text-gray-700 leading-relaxed whitespace-pre-line bg-gray-50 p-4 rounded-lg border border-gray-100">
                                {{ manuscript.abstract }}
                            </p>
                        </div>

                        <div v-if="manuscript.cover_letter">
                            <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">Cover Letter</h3>
                            <p class="text-xs text-gray-600 italic bg-gray-50 p-3 rounded border border-gray-100">{{ manuscript.cover_letter }}</p>
                        </div>

                        <!-- Authors & Affiliations -->
                        <div class="pt-4 border-t border-gray-100">
                            <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Authors & Affiliations</h3>
                            <div class="divide-y divide-gray-100 text-xs">
                                <div v-for="(author, idx) in manuscript.authors" :key="author.id || idx" class="py-2 flex items-center justify-between">
                                    <div>
                                        <span class="font-bold text-gray-900">{{ idx + 1 }}. {{ author.first_name }} {{ author.last_name }}</span>
                                        <span v-if="author.is_corresponding" class="text-academic-700 font-bold ml-1.5">* (Corresponding)</span>
                                        <span v-if="author.email" class="text-gray-500 ml-1">({{ author.email }})</span>
                                        <div class="text-gray-500 mt-0.5">{{ author.affiliation }}</div>
                                    </div>
                                    <span v-if="author.orcid" class="font-mono text-emerald-600 text-[11px]">{{ author.orcid }}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Confidential Files -->
                        <div class="pt-4 border-t border-gray-100">
                            <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Confidential Manuscript Files</h3>
                            <div v-if="manuscript.files && manuscript.files.length > 0" class="space-y-2">
                                <div v-for="file in manuscript.files" :key="file.id" class="flex items-center justify-between p-3 bg-gray-50 border border-gray-200 rounded-lg text-xs">
                                    <div class="flex items-center gap-2">
                                        <svg class="w-4 h-4 text-navy-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                                        </svg>
                                        <span class="font-bold text-gray-800">{{ file.file_name }}</span>
                                        <span class="text-gray-400">({{ (file.file_size / 1024 / 1024).toFixed(2) }} MB)</span>
                                    </div>
                                    <span class="text-[11px] uppercase bg-gray-200 text-gray-700 px-2 py-0.5 rounded font-semibold">{{ file.file_type }}</span>
                                </div>
                            </div>
                            <div v-else class="text-xs text-gray-400 italic">No files attached to manuscript.</div>
                        </div>
                    </div>

                    <!-- Peer Review Section -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                        <div class="flex items-center justify-between border-b border-gray-100 pb-3">
                            <h2 class="text-base font-bold text-gray-900">Peer Review Management</h2>
                            <span class="text-xs text-gray-500">
                                Model: <strong class="capitalize">{{ (manuscript.journal?.settings?.review_model || 'double_blind').replace('_', ' ') }}</strong>
                            </span>
                        </div>

                        <!-- Review Assignments List -->
                        <div v-if="manuscript.review_assignments && manuscript.review_assignments.length > 0" class="space-y-4">
                            <div
                                v-for="assign in manuscript.review_assignments"
                                :key="assign.id"
                                class="p-4 rounded-lg border border-gray-200 bg-gray-50/70 text-xs space-y-2"
                            >
                                <div class="flex items-center justify-between">
                                    <div>
                                        <span class="font-bold text-gray-900 text-sm">{{ assign.reviewer?.name }}</span>
                                        <span class="text-gray-500 ml-1">({{ assign.reviewer?.email }})</span>
                                    </div>
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold capitalize"
                                        :class="{
                                            'bg-amber-100 text-amber-800': assign.status === 'pending',
                                            'bg-blue-100 text-blue-800': assign.status === 'accepted',
                                            'bg-emerald-100 text-emerald-800': assign.status === 'completed',
                                            'bg-rose-100 text-rose-800': assign.status === 'declined'
                                        }"
                                    >
                                        {{ assign.status }}
                                    </span>
                                </div>

                                <div class="text-gray-500">
                                    Assigned: {{ new Date(assign.assigned_at).toLocaleDateString() }} • Due: {{ assign.due_date || '21 days' }}
                                </div>

                                <!-- Review Details if completed -->
                                <div v-if="assign.review" class="mt-3 p-3 bg-white border border-gray-200 rounded space-y-2">
                                    <div class="flex items-center justify-between">
                                        <strong class="text-gray-900">Recommendation: <span class="capitalize text-navy-800">{{ assign.review.recommendation?.replace('_', ' ') }}</span></strong>
                                        <span v-if="assign.review.quality_score" class="font-semibold text-gray-700">Score: {{ assign.review.quality_score }}/10</span>
                                    </div>
                                    <div v-if="assign.review.comments_to_author" class="pt-1">
                                        <span class="font-semibold text-gray-700 block mb-0.5">Comments to Author:</span>
                                        <p class="text-gray-600 whitespace-pre-line">{{ assign.review.comments_to_author }}</p>
                                    </div>
                                    <div v-if="assign.review.comments_to_editor" class="pt-1 border-t border-gray-100">
                                        <span class="font-semibold text-rose-700 block mb-0.5">Confidential Comments to Editor:</span>
                                        <p class="text-gray-600 italic whitespace-pre-line">{{ assign.review.comments_to_editor }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div v-else class="text-xs text-gray-400 italic py-2">
                            No peer reviewers assigned yet.
                        </div>

                        <!-- Invite Reviewer Form -->
                        <form @submit.prevent="handleInviteReviewer" class="p-4 bg-navy-50/60 border border-navy-100 rounded-lg space-y-3">
                            <h3 class="text-xs font-bold text-navy-900 uppercase tracking-wider">Invite Peer Reviewer</h3>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div>
                                    <label class="block text-[11px] font-semibold text-gray-700 mb-1">Select Reviewer *</label>
                                    <select
                                        v-model="inviteReviewerForm.reviewer_id"
                                        required
                                        class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-xs focus:ring-2 focus:ring-navy-600"
                                    >
                                        <option v-for="r in potentialReviewers" :key="r.id" :value="r.id">
                                            {{ r.name }} ({{ r.email }})
                                        </option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-[11px] font-semibold text-gray-700 mb-1">Review Due Date</label>
                                    <input
                                        v-model="inviteReviewerForm.due_date"
                                        type="date"
                                        class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-xs focus:ring-2 focus:ring-navy-600"
                                    />
                                </div>
                            </div>
                            <div class="flex justify-end pt-1">
                                <button type="submit" :disabled="inviteReviewerForm.processing" class="btn-primary text-xs py-1.5 px-4">
                                    Send Review Invitation
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Right Sidebar: Editorial Actions & Decision Engine -->
                <div class="space-y-6">
                    <!-- Handling Editor Assignment -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-4 text-xs">
                        <h2 class="text-sm font-bold text-gray-900 border-b border-gray-100 pb-2">Handling Editor</h2>

                        <div v-if="manuscript.editor" class="p-3 bg-gray-50 rounded border border-gray-200">
                            <span class="text-gray-400 block text-[11px]">Assigned Editor</span>
                            <span class="font-bold text-gray-900 text-sm">{{ manuscript.editor.name }}</span>
                            <span class="text-gray-500 block text-[11px]">{{ manuscript.editor.email }}</span>
                        </div>

                        <form @submit.prevent="handleAssignEditor" class="space-y-3 pt-2">
                            <div>
                                <label class="block font-semibold text-gray-700 mb-1">Assign / Reassign Editor</label>
                                <select
                                    v-model="assignEditorForm.editor_id"
                                    required
                                    class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-xs"
                                >
                                    <option v-for="ed in editors" :key="ed.id" :value="ed.id">
                                        {{ ed.name }} ({{ ed.email }})
                                    </option>
                                </select>
                            </div>
                            <button type="submit" :disabled="assignEditorForm.processing" class="btn-secondary text-xs w-full py-1.5">
                                Assign Editor
                            </button>
                        </form>
                    </div>

                    <!-- Initial Screening Action -->
                    <div v-if="manuscript.status === 'submitted'" class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-3 text-xs">
                        <h2 class="text-sm font-bold text-gray-900 border-b border-gray-100 pb-2">Initial Screening</h2>
                        <p class="text-gray-600">Review aims, formatting, ethics, and plagiarism score.</p>
                        <button
                            type="button"
                            @click="handleScreening"
                            :disabled="screeningForm.processing"
                            class="btn-primary text-xs w-full py-2 bg-emerald-700 hover:bg-emerald-800"
                        >
                            Pass Initial Screening ✓
                        </button>
                    </div>

                    <!-- Final Editorial Decision Panel -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-4 text-xs">
                        <h2 class="text-sm font-bold text-gray-900 border-b border-gray-100 pb-2">Editorial Decision</h2>

                        <form @submit.prevent="handleDecision" class="space-y-3">
                            <div>
                                <label class="block font-semibold text-gray-700 mb-1">Decision *</label>
                                <select
                                    v-model="decisionForm.decision"
                                    required
                                    class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-xs font-semibold"
                                >
                                    <option value="accepted">Accept Manuscript</option>
                                    <option value="revision_required">Request Minor / Major Revision</option>
                                    <option value="rejected">Reject Manuscript</option>
                                    <option value="production">Send to Production</option>
                                    <option value="published">Mark as Published</option>
                                </select>
                            </div>

                            <div>
                                <label class="block font-semibold text-gray-700 mb-1">Editorial Decision Comments</label>
                                <textarea
                                    v-model="decisionForm.comment"
                                    rows="3"
                                    placeholder="Provide decision rationales or revision requirements..."
                                    class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-xs"
                                ></textarea>
                            </div>

                            <button
                                type="submit"
                                :disabled="decisionForm.processing"
                                class="btn-primary text-xs w-full py-2.5"
                            >
                                Record Decision
                            </button>
                        </form>
                    </div>

                    <!-- Status History Log -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm space-y-3 text-xs">
                        <h2 class="text-sm font-bold text-gray-900 border-b border-gray-100 pb-2">Status Audit Trail</h2>
                        <div class="space-y-3 max-h-60 overflow-y-auto pr-1">
                            <div v-for="log in manuscript.status_history" :key="log.id" class="border-l-2 border-navy-700 pl-3 py-1">
                                <div class="font-bold text-gray-900 capitalize">{{ log.to_status?.replace('_', ' ') }}</div>
                                <div class="text-gray-500 text-[11px]">{{ log.comment }}</div>
                                <div class="text-gray-400 text-[10px]">{{ new Date(log.created_at).toLocaleString() }} • {{ log.user?.name || 'System' }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
