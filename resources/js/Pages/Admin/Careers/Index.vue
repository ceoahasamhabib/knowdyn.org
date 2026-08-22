<script setup>
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    careers: {
        type: Object,
        required: true,
    },
});

const deleteCareer = (c) => {
    if (confirm(`Delete "${c.title}"?`)) {
        router.delete(route('admin.careers.destroy', c.id));
    }
};
</script>

<template>
    <Head title="Careers & Editorial Roles — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">Careers & Editorial Fellowships</h1>
                    <p class="text-xs text-gray-500">Post and manage editorial board appointments, manuscript editors, and freelance proofreaders.</p>
                </div>
                <div>
                    <Link :href="route('admin.careers.create')" class="btn-primary text-xs py-2 px-4 shadow-sm">
                        + Post Position
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
                                <th class="px-6 py-4">Position Title & Department</th>
                                <th class="px-6 py-4">Role Type</th>
                                <th class="px-6 py-4">Application Deadline</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="careers.data.length === 0">
                                <td colspan="5" class="px-6 py-12 text-center text-gray-500">
                                    No career openings posted yet. Click "+ Post Position" to add one.
                                </td>
                            </tr>

                            <tr v-for="c in careers.data" :key="c.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900 text-sm">{{ c.title }}</div>
                                    <div class="text-gray-500 mt-0.5">{{ c.department }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs font-semibold text-academic-700">
                                    {{ c.type }}
                                </td>

                                <td class="px-6 py-4 text-xs font-medium text-gray-700">
                                    {{ c.deadline || 'Continuous' }}
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span v-if="c.is_active" class="text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded font-bold border border-emerald-200">
                                        Active
                                    </span>
                                    <span v-else class="text-gray-500 bg-gray-100 px-2 py-0.5 rounded font-semibold">
                                        Closed
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-right text-xs space-x-2">
                                    <Link :href="route('admin.careers.edit', c.id)" class="text-navy-700 hover:text-navy-900 font-bold">
                                        Edit
                                    </Link>
                                    <button @click="deleteCareer(c)" class="text-rose-600 hover:text-rose-800 font-bold">
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
