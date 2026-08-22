<script setup>
import { ref } from 'vue';
import { Head, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    requests: {
        type: Object,
        required: true,
    },
    services: {
        type: Array,
        default: () => [],
    },
    staffMembers: {
        type: Array,
        default: () => [],
    },
    filters: {
        type: Object,
        default: () => ({ status: '', service_id: '' }),
    },
});

const selectedStatus = ref(props.filters?.status || '');
const selectedServiceId = ref(props.filters?.service_id || '');

const handleFilter = () => {
    router.get(route('admin.services.index'), {
        status: selectedStatus.value,
        service_id: selectedServiceId.value,
    }, { preserveState: true, replace: true });
};

const updateStatus = (req, newStatus) => {
    router.post(route('admin.services.update_status', req.id), {
        status: newStatus,
        assigned_to: req.assigned_to,
    });
};

const assignStaff = (req, staffId) => {
    router.post(route('admin.services.update_status', req.id), {
        status: req.status === 'submitted' ? 'assigned' : req.status,
        assigned_to: staffId,
    });
};
</script>

<template>
    <Head title="Publishing Services & Proofreading Orders — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">Publishing Services & Proofreading Requests</h1>
                    <p class="text-xs text-gray-500">Track client inquiries, proofreading orders, manuscript editing, and staff assignments.</p>
                </div>
            </div>
        </template>

        <div class="space-y-6">
            <!-- Filters -->
            <KdCard padding="tight">
                <form @submit.prevent="handleFilter" class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <select
                            v-model="selectedServiceId"
                            class="w-full bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="">All Services</option>
                            <option v-for="s in services" :key="s.id" :value="s.id">
                                {{ s.title }}
                            </option>
                        </select>
                    </div>

                    <div>
                        <select
                            v-model="selectedStatus"
                            class="w-full bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="">All Statuses</option>
                            <option value="submitted">Submitted</option>
                            <option value="assigned">Assigned</option>
                            <option value="in_progress">In Progress</option>
                            <option value="quality_check">Quality Check</option>
                            <option value="completed">Completed</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>

                    <div class="flex gap-2">
                        <button type="submit" class="btn-secondary text-xs py-2 px-5">Filter</button>
                    </div>
                </form>
            </KdCard>

            <!-- Orders Table -->
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Client & Contact</th>
                                <th class="px-6 py-4">Requested Service</th>
                                <th class="px-6 py-4">Message / Requirements</th>
                                <th class="px-6 py-4">Assigned Staff</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="requests.data.length === 0">
                                <td colspan="6" class="px-6 py-12 text-center text-gray-500">
                                    No service inquiries found.
                                </td>
                            </tr>

                            <tr v-for="req in requests.data" :key="req.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900 text-sm">{{ req.name }}</div>
                                    <div class="text-gray-500">{{ req.email }}</div>
                                    <div v-if="req.phone" class="text-gray-400 text-[11px]">{{ req.phone }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs font-semibold text-navy-800">
                                    {{ req.service?.title || 'Proofreading' }}
                                </td>

                                <td class="px-6 py-4 text-xs max-w-xs">
                                    <div class="line-clamp-2 text-gray-700">{{ req.message }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <select
                                        :value="req.assigned_to || ''"
                                        @change="assignStaff(req, $event.target.value)"
                                        class="bg-white border border-gray-200 rounded px-2 py-1 text-xs"
                                    >
                                        <option value="">Unassigned</option>
                                        <option v-for="staff in staffMembers" :key="staff.id" :value="staff.id">
                                            {{ staff.name }}
                                        </option>
                                    </select>
                                </td>

                                <td class="px-6 py-4">
                                    <select
                                        :value="req.status"
                                        @change="updateStatus(req, $event.target.value)"
                                        class="text-xs font-semibold rounded px-2 py-1 border capitalize"
                                        :class="{
                                            'bg-blue-50 text-blue-800 border-blue-200': req.status === 'submitted',
                                            'bg-amber-50 text-amber-800 border-amber-200': req.status === 'assigned',
                                            'bg-purple-50 text-purple-800 border-purple-200': req.status === 'in_progress',
                                            'bg-indigo-50 text-indigo-800 border-indigo-200': req.status === 'quality_check',
                                            'bg-emerald-50 text-emerald-800 border-emerald-200': req.status === 'completed',
                                            'bg-rose-50 text-rose-800 border-rose-200': req.status === 'cancelled'
                                        }"
                                    >
                                        <option value="submitted">Submitted</option>
                                        <option value="assigned">Assigned</option>
                                        <option value="in_progress">In Progress</option>
                                        <option value="quality_check">Quality Check</option>
                                        <option value="completed">Completed</option>
                                        <option value="cancelled">Cancelled</option>
                                    </select>
                                </td>

                                <td class="px-6 py-4 text-right text-xs text-gray-400">
                                    {{ new Date(req.created_at).toLocaleDateString() }}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div v-if="requests.links && requests.links.length > 3" class="p-4 border-t border-gray-200 flex justify-center">
                    <div class="flex gap-1">
                        <template v-for="(link, i) in requests.links" :key="i">
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
