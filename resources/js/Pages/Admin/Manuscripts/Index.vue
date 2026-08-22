<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    manuscripts: {
        type: Object,
        required: true,
    },
    journals: {
        type: Array,
        default: () => [],
    },
    filters: {
        type: Object,
        default: () => ({ search: '', status: '', journal_id: '' }),
    },
});

const searchQuery = ref(props.filters?.search || '');
const selectedStatus = ref(props.filters?.status || '');
const selectedJournalId = ref(props.filters?.journal_id || '');

const handleFilter = () => {
    router.get(route('admin.manuscripts.index'), {
        search: searchQuery.value,
        status: selectedStatus.value,
        journal_id: selectedJournalId.value,
    }, { preserveState: true, replace: true });
};

const statusBadgeClass = (status) => {
    switch (status) {
        case 'submitted':
            return 'bg-blue-100 text-blue-800';
        case 'screening':
            return 'bg-amber-100 text-amber-800';
        case 'editor_assigned':
            return 'bg-indigo-100 text-indigo-800';
        case 'under_review':
            return 'bg-purple-100 text-purple-800';
        case 'revision_required':
            return 'bg-orange-100 text-orange-800';
        case 'accepted':
            return 'bg-emerald-100 text-emerald-800';
        case 'rejected':
            return 'bg-rose-100 text-rose-800';
        default:
            return 'bg-gray-100 text-gray-800';
    }
};
</script>

<template>
    <Head title="Manuscripts Editorial Queue — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">Manuscripts Editorial Queue</h1>
                    <p class="text-xs text-gray-500">Screen submitted papers, assign handling editors, coordinate peer reviews, and record editorial decisions.</p>
                </div>
            </div>
        </template>

        <div class="space-y-6">
            <!-- Filter Bar -->
            <KdCard padding="tight">
                <form @submit.prevent="handleFilter" class="grid grid-cols-1 sm:grid-cols-4 gap-3">
                    <div class="sm:col-span-2">
                        <input
                            v-model="searchQuery"
                            type="text"
                            placeholder="Search by manuscript title or author..."
                            class="w-full bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <select
                            v-model="selectedJournalId"
                            class="w-full bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="">All Journals</option>
                            <option v-for="j in journals" :key="j.id" :value="j.id">
                                {{ j.short_title || j.title }}
                            </option>
                        </select>
                    </div>

                    <div class="flex gap-2">
                        <select
                            v-model="selectedStatus"
                            class="flex-1 bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="">All Statuses</option>
                            <option value="submitted">Submitted</option>
                            <option value="screening">Screening</option>
                            <option value="editor_assigned">Editor Assigned</option>
                            <option value="under_review">Under Review</option>
                            <option value="revision_required">Revision Required</option>
                            <option value="accepted">Accepted</option>
                            <option value="rejected">Rejected</option>
                        </select>
                        <button type="submit" class="btn-secondary text-xs py-2 px-4 shrink-0">Filter</button>
                    </div>
                </form>
            </KdCard>

            <!-- Manuscripts Queue Table -->
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Manuscript Title</th>
                                <th class="px-6 py-4">Journal & Submitter</th>
                                <th class="px-6 py-4">Handling Editor</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4">Submitted Date</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="manuscripts.data.length === 0">
                                <td colspan="6" class="px-6 py-12 text-center text-gray-500">
                                    No manuscripts in editorial queue.
                                </td>
                            </tr>

                            <tr v-for="ms in manuscripts.data" :key="ms.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 max-w-md">
                                    <div class="font-bold text-gray-900 text-sm leading-snug">{{ ms.title }}</div>
                                    <div class="text-xs text-gray-500 mt-1 capitalize">{{ (ms.article_type || 'original-research').replace('-', ' ') }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-navy-900">{{ ms.journal?.short_title || ms.journal?.title }}</div>
                                    <div class="text-gray-500 mt-0.5">{{ ms.submitter?.name }} ({{ ms.submitter?.email }})</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span v-if="ms.editor" class="font-medium text-gray-800">{{ ms.editor.name }}</span>
                                    <span v-else class="text-amber-600 italic">Unassigned</span>
                                </td>

                                <td class="px-6 py-4">
                                    <span :class="['inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold capitalize', statusBadgeClass(ms.status)]">
                                        {{ ms.status.replace('_', ' ') }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-xs text-gray-500">
                                    {{ ms.submitted_at ? new Date(ms.submitted_at).toLocaleDateString() : 'Draft' }}
                                </td>

                                <td class="px-6 py-4 text-right">
                                    <Link :href="route('admin.manuscripts.show', ms.id)" class="btn-primary text-xs py-1.5 px-3">
                                        Editorial Cockpit →
                                    </Link>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div v-if="manuscripts.links && manuscripts.links.length > 3" class="p-4 border-t border-gray-200 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in manuscripts.links" :key="i">
                            <Link
                                v-if="link.url"
                                :href="link.url"
                                v-html="link.label"
                                class="px-3 py-1 text-xs rounded border"
                                :class="link.active ? 'bg-navy-700 text-white border-navy-700' : 'bg-white text-gray-700 border-gray-200 hover:bg-gray-50'"
                            />
                            <span v-else v-html="link.label" class="px-3 py-1 text-xs rounded border border-gray-200 text-gray-400" />
                        </template>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
