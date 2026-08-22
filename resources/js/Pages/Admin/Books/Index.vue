<script setup>
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    books: {
        type: Object,
        required: true,
    },
    pendingProposalsCount: {
        type: Number,
        default: 0,
    },
});

const deleteBook = (book) => {
    if (confirm(`Are you sure you want to delete "${book.title}"?`)) {
        router.delete(route('admin.books.destroy', book.id));
    }
};
</script>

<template>
    <Head title="Academic Books & Monographs — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">Books & Scholarly Monographs</h1>
                    <p class="text-xs text-gray-500">Manage published books, eBooks, ISBNs, and review incoming author book proposals.</p>
                </div>
                <div class="flex items-center gap-3">
                    <Link
                        :href="route('admin.books.proposals')"
                        class="btn-secondary text-xs py-2 px-4 relative"
                    >
                        Author Proposals
                        <span v-if="pendingProposalsCount > 0" class="ml-1.5 px-1.5 py-0.5 text-[10px] font-bold bg-rose-600 text-white rounded-full">
                            {{ pendingProposalsCount }}
                        </span>
                    </Link>
                    <Link :href="route('admin.books.create')" class="btn-primary text-xs py-2 px-4 shadow-sm">
                        + Add Book
                    </Link>
                </div>
            </div>
        </template>

        <div class="space-y-6">
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Title & Author</th>
                                <th class="px-6 py-4">Category</th>
                                <th class="px-6 py-4">ISBN / Year</th>
                                <th class="px-6 py-4">Format</th>
                                <th class="px-6 py-4">Access</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="books.data.length === 0">
                                <td colspan="6" class="px-6 py-12 text-center text-gray-500">
                                    No books found. Click "+ Add Book" to publish a monograph.
                                </td>
                            </tr>

                            <tr v-for="book in books.data" :key="book.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4">
                                    <div class="font-bold text-gray-900 text-sm">{{ book.title }}</div>
                                    <div class="text-xs text-academic-600 font-semibold mt-0.5">By {{ book.author }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span class="bg-navy-50 text-navy-800 font-semibold px-2 py-0.5 rounded border border-navy-100">
                                        {{ book.category }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="font-mono text-gray-800">{{ book.isbn || 'No ISBN' }}</div>
                                    <div class="text-gray-400 text-[11px]">{{ book.year }} • {{ book.pages }} pages</div>
                                </td>

                                <td class="px-6 py-4 text-xs font-medium text-gray-700">
                                    {{ book.format }}
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span v-if="book.is_open_access" class="text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded font-bold border border-emerald-200">
                                        Open Access
                                    </span>
                                    <span v-else class="text-gray-600 bg-gray-100 px-2 py-0.5 rounded font-semibold">
                                        Restricted
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-right text-xs space-x-2">
                                    <Link :href="route('admin.books.edit', book.id)" class="text-navy-700 hover:text-navy-900 font-bold">
                                        Edit
                                    </Link>
                                    <button @click="deleteBook(book)" class="text-rose-600 hover:text-rose-800 font-bold">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div v-if="books.links && books.links.length > 3" class="p-4 border-t border-gray-200 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in books.links" :key="i">
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
