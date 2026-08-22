<script setup>
import { Head, Link } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    pages: {
        type: Array,
        default: () => [],
    },
});
</script>

<template>
    <Head title="Guidelines & CMS Policies — Admin" />

    <AdminLayout>
        <template #header>
            <div>
                <h1 class="text-xl font-bold text-gray-900">Guidelines & Publishing Policies</h1>
                <p class="text-xs text-gray-500">Edit author guidelines, COPE ethics statements, reviewer code of conduct, and open access policy pages.</p>
            </div>
        </template>

        <div class="space-y-6">
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <table class="w-full text-left text-sm text-gray-600">
                    <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                        <tr>
                            <th class="px-6 py-4">Page Title & Identifier</th>
                            <th class="px-6 py-4">Public URL</th>
                            <th class="px-6 py-4">Last Updated</th>
                            <th class="px-6 py-4 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <tr v-for="p in pages" :key="p.id" class="hover:bg-gray-50/80 transition">
                            <td class="px-6 py-4">
                                <div class="font-bold text-gray-900 text-sm">{{ p.title }}</div>
                                <div class="text-xs font-mono text-gray-400">key: {{ p.key }}</div>
                            </td>

                            <td class="px-6 py-4 text-xs font-mono text-academic-700">
                                /guidelines/{{ p.key }}
                            </td>

                            <td class="px-6 py-4 text-xs text-gray-400">
                                {{ new Date(p.updated_at).toLocaleDateString() }}
                            </td>

                            <td class="px-6 py-4 text-right text-xs">
                                <Link :href="route('admin.guidelines.edit', p.id)" class="btn-secondary text-xs py-1.5 px-3">
                                    Edit Content →
                                </Link>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </AdminLayout>
</template>
