<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    journals: {
        type: Object,
        required: true,
    },
    filters: {
        type: Object,
        default: () => ({ search: '' }),
    },
});

const searchQuery = ref(props.filters?.search || '');

const handleSearch = () => {
    router.get(route('admin.journals.index'), { search: searchQuery.value }, { preserveState: true, replace: true });
};

const deleteJournal = (journal) => {
    if (confirm(`Are you sure you want to delete "${journal.title}"? This will archive all volumes, issues, and articles linked to it.`)) {
        router.delete(route('admin.journals.destroy', journal.id));
    }
};
</script>

<template>
    <Head title="Manage Journals — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">Journals Management</h1>
                    <p class="text-xs text-gray-500">Configure academic journals, publication frequencies, and editorial scopes.</p>
                </div>
                <Link :href="route('admin.journals.create')" class="btn-primary text-xs py-2 px-4 shrink-0 flex items-center gap-1.5">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    Add New Journal
                </Link>
            </div>
        </template>

        <div class="space-y-6">
            <!-- Search & Filters -->
            <KdCard padding="tight">
                <form @submit.prevent="handleSearch" class="flex flex-col sm:flex-row gap-3">
                    <input
                        v-model="searchQuery"
                        type="text"
                        placeholder="Search by title, short title, or ISSN..."
                        class="flex-1 bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-navy-600"
                    />
                    <button type="submit" class="btn-secondary text-xs py-2 px-4 shrink-0">
                        Filter
                    </button>
                </form>
            </KdCard>

            <!-- Journals Table -->
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Journal</th>
                                <th class="px-6 py-4">ISSN / Frequency</th>
                                <th class="px-6 py-4">Volumes & Issues</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="journals.data.length === 0">
                                <td colspan="5" class="px-6 py-12 text-center text-gray-500">
                                    No journals found in database. Create your first journal using the button above.
                                </td>
                            </tr>

                            <tr v-for="journal in journals.data" :key="journal.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4">
                                    <div class="font-bold text-gray-900 text-base">{{ journal.title }}</div>
                                    <div v-if="journal.short_title" class="text-xs text-gray-500 font-mono">{{ journal.short_title }}</div>
                                    <div class="text-[11px] text-navy-700 font-mono mt-0.5">/journals/{{ journal.slug }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs space-y-1">
                                    <div><span class="text-gray-400">Online:</span> <span class="font-mono font-medium text-gray-800">{{ journal.issn_online || '—' }}</span></div>
                                    <div><span class="text-gray-400">Print:</span> <span class="font-mono font-medium text-gray-800">{{ journal.issn_print || '—' }}</span></div>
                                    <div><span class="text-gray-400">Freq:</span> <span class="font-medium text-gray-700">{{ journal.publication_frequency || 'Quarterly' }}</span></div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="font-medium text-gray-900">{{ journal.volumes_count || 0 }} Volumes</div>
                                    <div class="text-gray-500">{{ journal.articles_count || 0 }} Published Articles</div>
                                    <div class="text-gray-500">{{ journal.editorial_members_count || 0 }} Board Members</div>
                                </td>

                                <td class="px-6 py-4">
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold"
                                        :class="{
                                            'bg-emerald-100 text-emerald-800': journal.status === 'active',
                                            'bg-amber-100 text-amber-800': journal.status === 'inactive',
                                            'bg-gray-100 text-gray-800': journal.status === 'archived'
                                        }"
                                    >
                                        {{ journal.status }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-right space-x-2">
                                    <Link :href="route('admin.journals.edit', journal.id)" class="text-xs font-medium text-navy-700 hover:text-navy-900 underline">
                                        Edit
                                    </Link>
                                    <Link :href="route('admin.journals.volumes.index', journal.id)" class="text-xs font-medium text-academic-700 hover:text-academic-900 underline">
                                        Volumes
                                    </Link>
                                    <Link :href="route('admin.journals.editorial_board.index', journal.id)" class="text-xs font-medium text-emerald-700 hover:text-emerald-900 underline">
                                        Board
                                    </Link>
                                    <button @click="deleteJournal(journal)" class="text-xs font-medium text-rose-600 hover:text-rose-800 underline">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div v-if="journals.links && journals.links.length > 3" class="p-4 border-t border-gray-200 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in journals.links" :key="i">
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
