<script setup>
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    proposals: {
        type: Object,
        required: true,
    },
});

const updateStatus = (prop, status) => {
    router.post(route('admin.books.proposals.update_status', prop.id), {
        status: status,
    });
};
</script>

<template>
    <Head title="Author Book Proposals — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center justify-between w-full">
                <div class="flex items-center gap-3">
                    <Link :href="route('admin.books.index')" class="text-xs text-gray-500 hover:text-gray-700">
                        ← Back to Books
                    </Link>
                    <span class="text-gray-300">/</span>
                    <h1 class="text-lg font-bold text-gray-900">Author Monograph Proposals Queue</h1>
                </div>
            </div>
        </template>

        <div class="space-y-6">
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Author & Affiliation</th>
                                <th class="px-6 py-4">Proposed Title & Scope</th>
                                <th class="px-6 py-4">Discipline & Length</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="proposals.data.length === 0">
                                <td colspan="5" class="px-6 py-12 text-center text-gray-500">
                                    No monograph proposals submitted yet.
                                </td>
                            </tr>

                            <tr v-for="prop in proposals.data" :key="prop.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900 text-sm">{{ prop.author_name }}</div>
                                    <div class="text-gray-500">{{ prop.author_email }}</div>
                                    <div class="text-gray-400 text-[11px] mt-0.5">{{ prop.institution }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs max-w-sm">
                                    <div class="font-bold text-navy-900">{{ prop.book_title }}</div>
                                    <p class="text-gray-600 line-clamp-2 mt-1">{{ prop.synopsis_and_toc }}</p>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="font-semibold text-gray-800">{{ prop.subject_discipline }}</div>
                                    <div class="text-gray-400 text-[11px]">{{ prop.estimated_word_count || 'Est. N/A' }}</div>
                                </td>

                                <td class="px-6 py-4">
                                    <span
                                        class="text-xs font-bold px-2.5 py-0.5 rounded capitalize"
                                        :class="{
                                            'bg-amber-50 text-amber-800 border border-amber-200': prop.status === 'pending',
                                            'bg-blue-50 text-blue-800 border border-blue-200': prop.status === 'reviewed',
                                            'bg-emerald-50 text-emerald-800 border border-emerald-200': prop.status === 'accepted',
                                            'bg-rose-50 text-rose-800 border border-rose-200': prop.status === 'declined'
                                        }"
                                    >
                                        {{ prop.status }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-right text-xs space-x-2">
                                    <button
                                        v-if="prop.status !== 'accepted'"
                                        @click="updateStatus(prop, 'accepted')"
                                        class="text-emerald-700 hover:text-emerald-900 font-bold"
                                    >
                                        Approve
                                    </button>
                                    <button
                                        v-if="prop.status !== 'declined'"
                                        @click="updateStatus(prop, 'declined')"
                                        class="text-rose-600 hover:text-rose-800 font-bold"
                                    >
                                        Decline
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
