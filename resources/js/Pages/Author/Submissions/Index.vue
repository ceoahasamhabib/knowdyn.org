<script setup>
import { computed } from 'vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const props = defineProps({
    submissions: {
        type: Object,
        required: true,
    },
});

const statusBadgeClass = (status) => {
    switch (status) {
        case 'submitted':
            return 'bg-blue-50 text-blue-700 border-blue-200';
        case 'screening':
            return 'bg-amber-50 text-amber-700 border-amber-200';
        case 'under_review':
            return 'bg-purple-50 text-purple-700 border-purple-200';
        case 'revision_required':
            return 'bg-orange-50 text-orange-700 border-orange-200';
        case 'accepted':
        case 'published':
            return 'bg-emerald-50 text-emerald-700 border-emerald-200';
        case 'rejected':
            return 'bg-rose-50 text-rose-700 border-rose-200';
        default:
            return 'bg-slate-50 text-slate-700 border-slate-200';
    }
};
</script>

<template>
    <Head title="Author Submissions Portal — Knowledge Dynamics" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                <div>
                    <h1 class="text-xl font-bold text-slate-900">Author Submissions Portal</h1>
                    <p class="text-xs text-slate-500">Track and monitor your peer-reviewed manuscript submissions in real time.</p>
                </div>

                <Link
                    :href="route('manuscripts.create')"
                    class="px-4 py-2 text-xs font-bold text-white rounded-lg shadow-xs flex items-center gap-1.5 transition"
                    :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                >
                    <span>+</span> Submit New Manuscript
                </Link>
            </div>
        </template>

        <div class="space-y-6">
            <!-- Submissions Table Card -->
            <div class="bg-white rounded-2xl border border-slate-200/80 overflow-hidden shadow-xs">
                <div class="p-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                    <span class="text-xs font-bold uppercase tracking-wider text-slate-900">
                        My Research Submissions ({{ (submissions.data || submissions).length || 0 }})
                    </span>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs text-slate-600">
                        <thead class="bg-slate-50 text-[11px] uppercase font-bold text-slate-700 border-b border-slate-200/80">
                            <tr>
                                <th class="px-5 py-3">Tracking Code</th>
                                <th class="px-5 py-3">Manuscript Details</th>
                                <th class="px-5 py-3">Target Journal</th>
                                <th class="px-5 py-3">Status</th>
                                <th class="px-5 py-3">Submitted</th>
                                <th class="px-5 py-3 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            <tr
                                v-for="item in (submissions.data || submissions)"
                                :key="item.id"
                                class="hover:bg-slate-50/80 transition"
                            >
                                <td class="px-5 py-4 font-mono font-bold text-indigo-700 text-xs">
                                    {{ item.tracking_code || `KD-MS-${item.id}` }}
                                </td>
                                <td class="px-5 py-4">
                                    <div class="font-bold text-slate-900 line-clamp-1 text-xs">
                                        {{ item.title }}
                                    </div>
                                    <div class="text-[11px] text-slate-400 font-medium">
                                        {{ item.article_type || 'Original Research' }}
                                    </div>
                                </td>
                                <td class="px-5 py-4 font-medium text-slate-700">
                                    {{ item.journal?.title || 'Knowledge Dynamics Journal' }}
                                </td>
                                <td class="px-5 py-4">
                                    <span :class="['px-2.5 py-1 rounded-full text-[10px] font-bold uppercase tracking-wide border', statusBadgeClass(item.status)]">
                                        {{ item.status?.replace('_', ' ') }}
                                    </span>
                                </td>
                                <td class="px-5 py-4 text-[11px] text-slate-400">
                                    {{ new Date(item.created_at).toLocaleDateString() }}
                                </td>
                                <td class="px-5 py-4 text-right">
                                    <Link
                                        :href="route('author.submissions.show', item.id)"
                                        class="px-3 py-1.5 rounded-lg bg-indigo-50 text-indigo-700 font-bold hover:bg-indigo-100 transition inline-block text-[11px]"
                                    >
                                        View Tracking & Files →
                                    </Link>
                                </td>
                            </tr>

                            <tr v-if="!(submissions.data || submissions) || (submissions.data || submissions).length === 0">
                                <td colspan="6" class="px-6 py-12 text-center text-slate-400 text-xs">
                                    <div class="text-3xl mb-2">📄</div>
                                    <p class="font-medium text-slate-700">No manuscript submissions yet.</p>
                                    <p class="text-[11px] text-slate-400 mt-1">Ready to publish your research? Submit a paper to begin the double-blind peer review process.</p>
                                    <div class="mt-4">
                                        <Link
                                            :href="route('manuscripts.create')"
                                            class="inline-block px-4 py-2 text-xs font-bold text-white rounded-lg shadow-xs"
                                            :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                                        >
                                            Submit Your First Paper →
                                        </Link>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
