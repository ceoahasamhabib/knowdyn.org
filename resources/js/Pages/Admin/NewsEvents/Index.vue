<script setup>
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    items: {
        type: Object,
        required: true,
    },
    filters: {
        type: Object,
        default: () => ({ type: '' }),
    },
});

const deleteItem = (item) => {
    if (confirm(`Delete "${item.title}"?`)) {
        router.delete(route('admin.news_events.destroy', item.id));
    }
};
</script>

<template>
    <Head title="News, Events & Announcements — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">News, Events & Announcements</h1>
                    <p class="text-xs text-gray-500">Publish scholarly announcements, calls for papers, workshops, and symposiums.</p>
                </div>
                <div>
                    <Link :href="route('admin.news_events.create')" class="btn-primary text-xs py-2 px-4 shadow-sm">
                        + Post News / Event
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
                                <th class="px-6 py-4">Title & Category</th>
                                <th class="px-6 py-4">Type</th>
                                <th class="px-6 py-4">Event Date / Deadline</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="items.data.length === 0">
                                <td colspan="5" class="px-6 py-12 text-center text-gray-500">
                                    No news or events posted yet.
                                </td>
                            </tr>

                            <tr v-for="item in items.data" :key="item.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900 text-sm">{{ item.title }}</div>
                                    <div class="text-gray-500 mt-0.5">{{ item.category || 'General' }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span class="bg-navy-50 text-navy-800 font-bold px-2 py-0.5 rounded uppercase text-[10px] border border-navy-100">
                                        {{ item.type }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div v-if="item.event_date" class="font-semibold text-gray-800">{{ item.event_date }}</div>
                                    <div v-if="item.deadline" class="text-rose-700 font-semibold text-[11px]">Deadline: {{ item.deadline }}</div>
                                    <div v-if="!item.event_date && !item.deadline" class="text-gray-400">—</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span v-if="item.is_published" class="text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded font-bold border border-emerald-200">
                                        Published
                                    </span>
                                    <span v-else class="text-gray-500 bg-gray-100 px-2 py-0.5 rounded font-semibold">
                                        Draft
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-right text-xs space-x-2">
                                    <Link :href="route('admin.news_events.edit', item.id)" class="text-navy-700 hover:text-navy-900 font-bold">
                                        Edit
                                    </Link>
                                    <button @click="deleteItem(item)" class="text-rose-600 hover:text-rose-800 font-bold">
                                        Delete
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
