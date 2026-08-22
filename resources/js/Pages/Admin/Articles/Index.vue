<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    articles: {
        type: Object,
        required: true,
    },
    journals: {
        type: Array,
        default: () => [],
    },
    filters: {
        type: Object,
        default: () => ({ search: '', journal_id: '', status: '' }),
    },
});

const searchQuery = ref(props.filters?.search || '');
const selectedJournalId = ref(props.filters?.journal_id || '');
const selectedStatus = ref(props.filters?.status || '');

const handleFilter = () => {
    router.get(route('admin.articles.index'), {
        search: searchQuery.value,
        journal_id: selectedJournalId.value,
        status: selectedStatus.value,
    }, { preserveState: true, replace: true });
};

const deleteArticle = (article) => {
    if (confirm(`Are you sure you want to delete article "${article.title}"?`)) {
        router.delete(route('admin.articles.destroy', article.id));
    }
};
</script>

<template>
    <Head title="Manage Articles — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">Articles Management</h1>
                    <p class="text-xs text-gray-500">Manage published scholarly papers, DOIs, authors, and issue assignments.</p>
                </div>
                <Link :href="route('admin.articles.create')" class="btn-primary text-xs py-2 px-4 shrink-0 flex items-center gap-1.5">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    Publish New Article
                </Link>
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
                            placeholder="Search by title or DOI..."
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
                            <option value="">All Status</option>
                            <option value="published">Published</option>
                            <option value="draft">Draft</option>
                            <option value="retracted">Retracted</option>
                        </select>
                        <button type="submit" class="btn-secondary text-xs py-2 px-4 shrink-0">Filter</button>
                    </div>
                </form>
            </KdCard>

            <!-- Articles Table -->
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Article Title & DOI</th>
                                <th class="px-6 py-4">Journal & Issue</th>
                                <th class="px-6 py-4">Authors</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4">Views/Downloads</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="articles.data.length === 0">
                                <td colspan="6" class="px-6 py-12 text-center text-gray-500">
                                    No articles found. Click "Publish New Article" to add one.
                                </td>
                            </tr>

                            <tr v-for="article in articles.data" :key="article.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 max-w-md">
                                    <div class="font-bold text-gray-900 text-sm leading-snug">{{ article.title }}</div>
                                    <div class="text-xs font-mono text-gray-500 mt-1">{{ article.doi || 'No DOI assigned' }}</div>
                                    <div class="text-[11px] text-navy-700 font-mono mt-0.5">/articles/{{ article.slug }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900">{{ article.journal?.short_title || article.journal?.title || '—' }}</div>
                                    <div v-if="article.issues && article.issues.length > 0" class="text-gray-500 mt-0.5">
                                        Vol. {{ article.issues[0]?.volume?.number || '—' }}, Issue {{ article.issues[0]?.number }}
                                    </div>
                                    <div v-else class="text-amber-600 italic">Unassigned issue</div>
                                </td>

                                <td class="px-6 py-4 text-xs text-gray-600">
                                    <span v-for="(author, aIdx) in (article.authors || [])" :key="author.id">
                                        {{ author.first_name }} {{ author.last_name }}<span v-if="aIdx < article.authors.length - 1">, </span>
                                    </span>
                                </td>

                                <td class="px-6 py-4">
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold"
                                        :class="{
                                            'bg-emerald-100 text-emerald-800': article.status === 'published',
                                            'bg-gray-100 text-gray-800': article.status === 'draft',
                                            'bg-rose-100 text-rose-800': article.status === 'retracted'
                                        }"
                                    >
                                        {{ article.status }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div><span class="font-semibold text-gray-900">{{ article.view_count || 0 }}</span> views</div>
                                    <div><span class="font-semibold text-gray-900">{{ article.download_count || 0 }}</span> downloads</div>
                                </td>

                                <td class="px-6 py-4 text-right space-x-2">
                                    <Link :href="route('admin.articles.edit', article.id)" class="text-xs font-medium text-navy-700 hover:text-navy-900 underline">
                                        Edit
                                    </Link>
                                    <Link :href="route('articles.show', article.slug)" target="_blank" class="text-xs font-medium text-academic-700 hover:text-academic-900 underline">
                                        View ↗
                                    </Link>
                                    <button @click="deleteArticle(article)" class="text-xs font-medium text-rose-600 hover:text-rose-800 underline">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div v-if="articles.links && articles.links.length > 3" class="p-4 border-t border-gray-200 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in articles.links" :key="i">
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
