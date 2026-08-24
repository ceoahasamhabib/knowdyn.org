<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';

const props = defineProps({
    journals: {
        type: Object,
        required: true,
    },
    stats: {
        type: Object,
        default: () => ({ total: 0, active: 0, inactive: 0, archived: 0 }),
    },
    filters: {
        type: Object,
        default: () => ({ search: '', status: '' }),
    },
});

const searchQuery = ref(props.filters?.search || '');
const currentStatus = ref(props.filters?.status || '');

const handleFilter = (status = '') => {
    currentStatus.value = status;
    router.get(route('admin.journals.index'), {
        search: searchQuery.value,
        status: currentStatus.value || undefined,
    }, { preserveState: true, replace: true });
};

const toggleJournalStatus = (journal) => {
    router.post(route('admin.journals.toggle_status', journal.id), {}, {
        preserveScroll: true,
    });
};

const deleteJournal = (journal) => {
    if (confirm(`Are you sure you want to delete "${journal.title}"? This will archive all volumes, issues, and articles linked to it.`)) {
        router.delete(route('admin.journals.destroy', journal.id));
    }
};
</script>

<template>
    <Head title="Manage Academic Journals — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <div class="flex items-center gap-2 mb-1">
                        <span class="px-2.5 py-0.5 text-[10px] font-extrabold uppercase tracking-wider bg-indigo-50 text-indigo-700 rounded-md border border-indigo-200">
                            Academic Publishing Core
                        </span>
                        <span class="text-xs text-slate-400">•</span>
                        <span class="text-xs text-slate-500 font-medium">Journal Registry</span>
                    </div>
                    <h1 class="text-2xl font-black text-slate-900 tracking-tight flex items-center gap-2.5">
                        <span>📚</span> Academic Journals Management
                    </h1>
                </div>

                <div class="flex items-center gap-2.5">
                    <Link
                        :href="route('journals.index')"
                        target="_blank"
                        class="px-4 py-2.5 rounded-xl border border-slate-200 bg-white hover:bg-slate-50 text-slate-700 text-xs font-bold transition shadow-xs flex items-center gap-1.5"
                    >
                        <span>🌐 Public Directory</span>
                        <span class="font-mono text-[10px]">↗</span>
                    </Link>

                    <Link
                        :href="route('admin.journals.create')"
                        class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white text-xs font-black shadow-lg shadow-indigo-500/25 flex items-center gap-1.5 transition cursor-pointer"
                    >
                        <span>➕ Add New Journal</span>
                    </Link>
                </div>
            </div>
        </template>

        <div class="space-y-6 max-w-7xl mx-auto pb-16">
            <!-- 4 Stats Cards -->
            <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
                <div
                    @click="handleFilter('')"
                    class="bg-white p-5 rounded-2xl border cursor-pointer transition shadow-xs"
                    :class="currentStatus === '' ? 'border-indigo-600 ring-2 ring-indigo-600/20 bg-indigo-50/20' : 'border-slate-200 hover:border-slate-300'"
                >
                    <span class="text-[10px] font-extrabold uppercase tracking-wider text-slate-400 block">Total Registered</span>
                    <span class="text-2xl font-black text-slate-900 block mt-1">{{ stats.total || journals.data.length }}</span>
                    <span class="text-[11px] text-slate-500">All registered academic journals</span>
                </div>

                <div
                    @click="handleFilter('active')"
                    class="bg-white p-5 rounded-2xl border cursor-pointer transition shadow-xs"
                    :class="currentStatus === 'active' ? 'border-emerald-600 ring-2 ring-emerald-600/20 bg-emerald-50/20' : 'border-slate-200 hover:border-slate-300'"
                >
                    <span class="text-[10px] font-extrabold uppercase tracking-wider text-emerald-600 block">Published (Live)</span>
                    <span class="text-2xl font-black text-emerald-700 block mt-1">{{ stats.active || 0 }}</span>
                    <span class="text-[11px] text-emerald-600 font-medium">Visible to public & scholars</span>
                </div>

                <div
                    @click="handleFilter('inactive')"
                    class="bg-white p-5 rounded-2xl border cursor-pointer transition shadow-xs"
                    :class="currentStatus === 'inactive' ? 'border-amber-600 ring-2 ring-amber-600/20 bg-amber-50/20' : 'border-slate-200 hover:border-slate-300'"
                >
                    <span class="text-[10px] font-extrabold uppercase tracking-wider text-amber-600 block">Draft / Unpublished</span>
                    <span class="text-2xl font-black text-amber-700 block mt-1">{{ stats.inactive || 0 }}</span>
                    <span class="text-[11px] text-amber-600 font-medium">Under editorial review</span>
                </div>

                <div
                    @click="handleFilter('archived')"
                    class="bg-white p-5 rounded-2xl border cursor-pointer transition shadow-xs"
                    :class="currentStatus === 'archived' ? 'border-slate-600 ring-2 ring-slate-600/20 bg-slate-50' : 'border-slate-200 hover:border-slate-300'"
                >
                    <span class="text-[10px] font-extrabold uppercase tracking-wider text-slate-500 block">Archived</span>
                    <span class="text-2xl font-black text-slate-700 block mt-1">{{ stats.archived || 0 }}</span>
                    <span class="text-[11px] text-slate-500">Historical archive</span>
                </div>
            </div>

            <!-- Search & Filters Toolbar -->
            <div class="bg-white rounded-2xl border border-slate-200 p-4 shadow-xs flex flex-col sm:flex-row items-center justify-between gap-3">
                <form @submit.prevent="handleFilter(currentStatus)" class="flex-1 w-full flex items-center gap-2">
                    <div class="relative flex-1">
                        <span class="absolute left-3.5 top-1/2 -translate-y-1/2 text-slate-400 text-xs">🔍</span>
                        <input
                            v-model="searchQuery"
                            type="text"
                            placeholder="Search by journal title, ISSN, short title, or website URL..."
                            class="w-full pl-9 pr-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                        />
                    </div>
                    <button type="submit" class="px-4 py-2.5 bg-slate-900 hover:bg-slate-800 text-white rounded-xl text-xs font-bold transition">
                        Filter
                    </button>
                </form>

                <div class="flex items-center gap-1.5 overflow-x-auto w-full sm:w-auto">
                    <button
                        type="button"
                        @click="handleFilter('')"
                        class="px-3 py-1.5 rounded-lg text-xs font-semibold transition whitespace-nowrap"
                        :class="currentStatus === '' ? 'bg-slate-900 text-white' : 'text-slate-600 hover:bg-slate-100'"
                    >
                        All
                    </button>
                    <button
                        type="button"
                        @click="handleFilter('active')"
                        class="px-3 py-1.5 rounded-lg text-xs font-semibold transition whitespace-nowrap"
                        :class="currentStatus === 'active' ? 'bg-emerald-600 text-white' : 'text-slate-600 hover:bg-slate-100'"
                    >
                        Published Only
                    </button>
                    <button
                        type="button"
                        @click="handleFilter('inactive')"
                        class="px-3 py-1.5 rounded-lg text-xs font-semibold transition whitespace-nowrap"
                        :class="currentStatus === 'inactive' ? 'bg-amber-600 text-white' : 'text-slate-600 hover:bg-slate-100'"
                    >
                        Drafts
                    </button>
                </div>
            </div>

            <!-- Journals Table -->
            <div class="bg-white rounded-3xl border border-slate-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs text-slate-600">
                        <thead class="bg-slate-50 text-[10px] uppercase font-black text-slate-500 tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-4">Journal & Details</th>
                                <th class="px-6 py-4">Dedicated Website & Portal</th>
                                <th class="px-6 py-4">Metrics & Speed</th>
                                <th class="px-6 py-4">Volumes & Articles</th>
                                <th class="px-6 py-4">Publication Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 font-sans">
                            <tr v-if="journals.data.length === 0">
                                <td colspan="6" class="px-6 py-16 text-center text-slate-500">
                                    <div class="text-3xl mb-2">📚</div>
                                    <p class="font-bold text-slate-800 text-sm">No journals found</p>
                                    <p class="text-xs text-slate-400 mt-1">Try resetting the filters or create a new journal.</p>
                                </td>
                            </tr>

                            <tr
                                v-for="journal in journals.data"
                                :key="journal.id"
                                class="hover:bg-slate-50/80 transition"
                            >
                                <!-- 1. Journal Title & Identifiers -->
                                <td class="px-6 py-4 max-w-xs">
                                    <div class="flex items-start gap-3">
                                        <div class="w-10 h-10 rounded-xl bg-indigo-50 border border-indigo-100 text-indigo-700 font-black text-xs flex items-center justify-center shrink-0">
                                            {{ journal.short_title ? journal.short_title.substring(0, 3).toUpperCase() : 'KD' }}
                                        </div>
                                        <div>
                                            <Link :href="route('admin.journals.edit', journal.id)" class="font-bold text-slate-900 text-sm hover:text-indigo-600 transition line-clamp-1">
                                                {{ journal.title }}
                                            </Link>
                                            <div class="flex items-center gap-2 text-[11px] text-slate-400 font-mono mt-0.5">
                                                <span>Online: <strong class="text-slate-700">{{ journal.issn_online || '—' }}</strong></span>
                                                <span v-if="journal.issn_print">• Print: <strong class="text-slate-700">{{ journal.issn_print }}</strong></span>
                                            </div>
                                            <div class="text-[10px] text-slate-400 mt-0.5">
                                                {{ journal.publication_frequency || 'Quarterly' }} • Est. {{ journal.established_year || '2021' }}
                                            </div>
                                        </div>
                                    </div>
                                </td>

                                <!-- 2. Website & Submission URL -->
                                <td class="px-6 py-4">
                                    <div class="space-y-1.5">
                                        <a
                                            :href="journal.effective_website_url"
                                            target="_blank"
                                            class="inline-flex items-center gap-1.5 text-xs font-bold text-indigo-600 hover:text-indigo-800 bg-indigo-50 hover:bg-indigo-100 px-3 py-1 rounded-lg border border-indigo-200 transition shadow-xs max-w-full truncate"
                                        >
                                            <span>🌐 Visit Website</span>
                                            <span class="font-mono text-[10px]">↗</span>
                                        </a>

                                        <div class="text-[10px] text-slate-400 font-mono truncate max-w-[200px]">
                                            {{ journal.website_url || ('/journals/' + journal.slug) }}
                                        </div>
                                    </div>
                                </td>

                                <!-- 3. Academic Metrics & Speed -->
                                <td class="px-6 py-4">
                                    <div class="space-y-1">
                                        <div class="flex items-center gap-1.5 font-mono text-[11px]">
                                            <span class="px-1.5 py-0.5 bg-indigo-50 text-indigo-800 font-bold rounded">CiteScore {{ journal.citescore || '3.5' }}</span>
                                            <span class="text-slate-400">•</span>
                                            <span class="text-emerald-700 font-bold">{{ journal.acceptance_rate || '28' }}% Acc.</span>
                                        </div>
                                        <div class="text-[10px] text-slate-500 flex items-center gap-1">
                                            <span>⚡ First decision:</span>
                                            <strong class="text-slate-700">{{ journal.review_time_days || '18' }} days</strong>
                                        </div>
                                    </div>
                                </td>

                                <!-- 4. Volumes & Articles -->
                                <td class="px-6 py-4">
                                    <div class="space-y-0.5 text-slate-700 font-medium">
                                        <div><strong>{{ journal.volumes_count || 0 }}</strong> Volumes</div>
                                        <div class="text-slate-500 text-[11px]">{{ journal.articles_count || 0 }} Articles</div>
                                        <div class="text-slate-400 text-[10px]">{{ journal.editorial_members_count || 0 }} Board Members</div>
                                    </div>
                                </td>

                                <!-- 5. Publication Status & Fast Toggle -->
                                <td class="px-6 py-4">
                                    <div class="space-y-2">
                                        <span
                                            class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold"
                                            :class="{
                                                'bg-emerald-50 text-emerald-700 border border-emerald-200': journal.status === 'active',
                                                'bg-amber-50 text-amber-700 border border-amber-200': journal.status === 'inactive',
                                                'bg-slate-100 text-slate-600 border border-slate-200': journal.status === 'archived'
                                            }"
                                        >
                                            <span
                                                class="w-1.5 h-1.5 rounded-full"
                                                :class="{
                                                    'bg-emerald-500 animate-pulse': journal.status === 'active',
                                                    'bg-amber-500': journal.status === 'inactive',
                                                    'bg-slate-400': journal.status === 'archived'
                                                }"
                                            ></span>
                                            <span>{{ journal.status === 'active' ? 'Published' : (journal.status === 'inactive' ? 'Draft' : 'Archived') }}</span>
                                        </span>

                                        <div>
                                            <button
                                                type="button"
                                                @click="toggleJournalStatus(journal)"
                                                class="text-[11px] font-bold underline transition"
                                                :class="journal.status === 'active' ? 'text-amber-600 hover:text-amber-800' : 'text-emerald-600 hover:text-emerald-800'"
                                            >
                                                {{ journal.status === 'active' ? 'Unpublish (Make Draft)' : 'Publish (Go Live)' }}
                                            </button>
                                        </div>
                                    </div>
                                </td>

                                <!-- 6. Action Links -->
                                <td class="px-6 py-4 text-right">
                                    <div class="flex items-center justify-end gap-2">
                                        <Link
                                            :href="route('admin.journals.edit', journal.id)"
                                            class="p-2 rounded-xl hover:bg-slate-100 text-slate-700 font-bold hover:text-indigo-600 transition"
                                            title="Edit Journal & Academic Settings"
                                        >
                                            ✏️ Edit
                                        </Link>

                                        <Link
                                            :href="route('admin.journals.volumes.index', journal.id)"
                                            class="p-2 rounded-xl hover:bg-slate-100 text-slate-700 font-bold hover:text-indigo-600 transition"
                                            title="Manage Volumes and Issues"
                                        >
                                            📂 Volumes
                                        </Link>

                                        <Link
                                            :href="route('admin.journals.editorial_board.index', journal.id)"
                                            class="p-2 rounded-xl hover:bg-slate-100 text-slate-700 font-bold hover:text-indigo-600 transition"
                                            title="Manage Editorial Board"
                                        >
                                            👥 Board
                                        </Link>

                                        <button
                                            type="button"
                                            @click="deleteJournal(journal)"
                                            class="p-2 rounded-xl hover:bg-rose-50 text-rose-600 font-bold transition"
                                            title="Delete Journal"
                                        >
                                            🗑️
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div v-if="journals.links && journals.links.length > 3" class="p-4 border-t border-slate-200 flex justify-center bg-slate-50">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in journals.links" :key="i">
                            <Link
                                v-if="link.url"
                                :href="link.url"
                                v-html="link.label"
                                class="px-3.5 py-1.5 text-xs font-bold rounded-xl border transition"
                                :class="link.active ? 'bg-indigo-600 text-white border-indigo-600' : 'bg-white text-slate-700 border-slate-200 hover:bg-slate-100'"
                            />
                            <span v-else v-html="link.label" class="px-3.5 py-1.5 text-xs rounded-xl border border-slate-200 text-slate-400" />
                        </template>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
