<script setup>
import { ref } from 'vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
});

// Modal states
const showVolumeModal = ref(false);
const showIssueModal = ref(false);
const selectedVolume = ref(null);

const volumeForm = useForm({
    number: (props.journal.volumes?.[0]?.number || 0) + 1,
    year: new Date().getFullYear(),
    title: '',
    description: '',
});

const issueForm = useForm({
    number: '1',
    title: '',
    description: '',
    published_at: new Date().toISOString().split('T')[0],
    is_current: false,
    status: 'published',
    sort_order: 0,
});

const openCreateVolume = () => {
    volumeForm.reset();
    volumeForm.number = (props.journal.volumes?.[0]?.number || 0) + 1;
    volumeForm.year = new Date().getFullYear();
    showVolumeModal.value = true;
};

const submitVolume = () => {
    volumeForm.post(route('admin.journals.volumes.store', props.journal.id), {
        onSuccess: () => {
            showVolumeModal.value = false;
        },
    });
};

const deleteVolume = (volume) => {
    if (confirm(`Delete Volume ${volume.number} (${volume.year}) and all its issues?`)) {
        router.delete(route('admin.volumes.destroy', volume.id));
    }
};

const openCreateIssue = (volume) => {
    selectedVolume.value = volume;
    issueForm.reset();
    issueForm.number = String((volume.issues?.length || 0) + 1);
    issueForm.published_at = new Date().toISOString().split('T')[0];
    showIssueModal.value = true;
};

const submitIssue = () => {
    if (!selectedVolume.value) return;
    issueForm.post(route('admin.volumes.issues.store', selectedVolume.value.id), {
        onSuccess: () => {
            showIssueModal.value = false;
        },
    });
};

const deleteIssue = (issue) => {
    if (confirm(`Delete Issue ${issue.number}?`)) {
        router.delete(route('admin.issues.destroy', issue.id));
    }
};

const setCurrent = (issue) => {
    router.post(route('admin.issues.set_current', issue.id));
};
</script>

<template>
    <Head :title="`Volumes & Issues — ${journal.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div class="flex items-center gap-3">
                    <Link :href="route('admin.journals.edit', journal.id)" class="text-xs text-gray-500 hover:text-gray-700">
                        ← Back to Edit Journal
                    </Link>
                    <span class="text-gray-300">/</span>
                    <h1 class="text-lg font-bold text-gray-900 truncate max-w-md">Volumes & Issues: {{ journal.short_title || journal.title }}</h1>
                </div>

                <button @click="openCreateVolume" class="btn-primary text-xs py-2 px-4 flex items-center gap-1.5 shrink-0">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    Create New Volume
                </button>
            </div>
        </template>

        <div class="space-y-8 max-w-5xl">
            <!-- Volumes List -->
            <div v-if="!journal.volumes || journal.volumes.length === 0" class="bg-white rounded-xl border border-gray-200 p-12 text-center text-gray-500">
                <p class="text-base font-semibold text-gray-800 mb-1">No Volumes Configured</p>
                <p class="text-xs text-gray-500 mb-4">Start publishing by creating Volume 1 for this journal.</p>
                <button @click="openCreateVolume" class="btn-primary text-xs py-2 px-4">
                    Create Volume 1
                </button>
            </div>

            <div v-else class="space-y-6">
                <div
                    v-for="volume in journal.volumes"
                    :key="volume.id"
                    class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm"
                >
                    <!-- Volume Header -->
                    <div class="bg-gray-50 px-6 py-4 border-b border-gray-200 flex items-center justify-between">
                        <div class="flex items-center gap-3">
                            <span class="text-base font-bold text-gray-900">Volume {{ volume.number }}</span>
                            <span class="text-xs font-mono bg-white border border-gray-200 text-gray-700 px-2.5 py-0.5 rounded-full font-semibold">
                                {{ volume.year }}
                            </span>
                            <span v-if="volume.title" class="text-xs text-gray-500 italic">
                                — {{ volume.title }}
                            </span>
                        </div>

                        <div class="flex items-center gap-3">
                            <button @click="openCreateIssue(volume)" class="btn-secondary text-xs py-1.5 px-3 flex items-center gap-1">
                                + Add Issue
                            </button>
                            <button @click="deleteVolume(volume)" class="text-xs text-rose-600 hover:text-rose-800 font-medium">
                                Delete Volume
                            </button>
                        </div>
                    </div>

                    <!-- Issues Table -->
                    <div class="p-6">
                        <div v-if="!volume.issues || volume.issues.length === 0" class="text-center py-6 text-xs text-gray-400">
                            No issues in this volume yet. Click "+ Add Issue" to publish an issue.
                        </div>

                        <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                            <div
                                v-for="issue in volume.issues"
                                :key="issue.id"
                                class="border rounded-lg p-4 bg-white hover:border-academic-400 transition flex flex-col justify-between"
                                :class="issue.is_current ? 'border-academic-400 bg-academic-50/20' : 'border-gray-200'"
                            >
                                <div>
                                    <div class="flex items-center justify-between mb-1.5">
                                        <span class="text-xs font-bold text-gray-900">Issue {{ issue.number }}</span>
                                        <span
                                            v-if="issue.is_current"
                                            class="text-[10px] font-bold bg-academic-100 text-academic-800 px-2 py-0.5 rounded-full"
                                        >
                                            CURRENT
                                        </span>
                                    </div>
                                    <h4 class="text-xs font-medium text-gray-800 truncate mb-1">
                                        {{ issue.title || `Vol. ${volume.number}, Issue ${issue.number}` }}
                                    </h4>
                                    <p class="text-[11px] text-gray-400 mb-2">
                                        Published: {{ issue.published_at || 'Pending' }}
                                    </p>
                                    <p class="text-[11px] text-gray-600">
                                        {{ issue.articles_count || 0 }} Articles assigned
                                    </p>
                                </div>

                                <div class="mt-4 pt-3 border-t border-gray-100 flex items-center justify-between text-xs">
                                    <button
                                        v-if="!issue.is_current"
                                        @click="setCurrent(issue)"
                                        class="text-academic-700 hover:text-academic-900 font-semibold"
                                    >
                                        Set as Current
                                    </button>
                                    <span v-else class="text-emerald-600 text-[11px] font-medium">● Active Issue</span>

                                    <button @click="deleteIssue(issue)" class="text-rose-600 hover:text-rose-800">
                                        Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Volume Modal -->
        <div v-if="showVolumeModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4">
            <div class="bg-white rounded-xl max-w-md w-full p-6 shadow-xl space-y-4">
                <h3 class="text-base font-bold text-gray-900">Create New Volume</h3>
                <form @submit.prevent="submitVolume" class="space-y-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Volume Number *</label>
                        <input v-model="volumeForm.number" type="number" required min="1" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publication Year *</label>
                        <input v-model="volumeForm.year" type="number" required min="1900" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Title (Optional)</label>
                        <input v-model="volumeForm.title" type="text" placeholder="e.g. Special Anniversary Volume" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>

                    <div class="flex justify-end gap-2 pt-2">
                        <button type="button" @click="showVolumeModal = false" class="btn-secondary text-xs py-2 px-4">Cancel</button>
                        <button type="submit" :disabled="volumeForm.processing" class="btn-primary text-xs py-2 px-4">Save Volume</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Issue Modal -->
        <div v-if="showIssueModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4">
            <div class="bg-white rounded-xl max-w-md w-full p-6 shadow-xl space-y-4">
                <h3 class="text-base font-bold text-gray-900">Add Issue to Volume {{ selectedVolume?.number }}</h3>
                <form @submit.prevent="submitIssue" class="space-y-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Issue Number *</label>
                        <input v-model="issueForm.number" type="text" required placeholder="e.g. 1 or Special Issue 1" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Issue Title (Optional)</label>
                        <input v-model="issueForm.title" type="text" placeholder="e.g. Advances in Applied Science" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publication Date</label>
                        <input v-model="issueForm.published_at" type="date" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>
                    <div class="flex items-center gap-2">
                        <input v-model="issueForm.is_current" type="checkbox" id="is_current" class="rounded border-gray-300 text-navy-700 focus:ring-navy-700" />
                        <label for="is_current" class="text-xs font-medium text-gray-700">Set as Current Journal Issue</label>
                    </div>

                    <div class="flex justify-end gap-2 pt-2">
                        <button type="button" @click="showIssueModal = false" class="btn-secondary text-xs py-2 px-4">Cancel</button>
                        <button type="submit" :disabled="issueForm.processing" class="btn-primary text-xs py-2 px-4">Save Issue</button>
                    </div>
                </form>
            </div>
        </div>
    </AdminLayout>
</template>
