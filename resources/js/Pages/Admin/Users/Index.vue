<script setup>
import { ref } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    users: {
        type: Object,
        required: true,
    },
    roles: {
        type: Array,
        default: () => [],
    },
    filters: {
        type: Object,
        default: () => ({ search: '', role: '' }),
    },
});

const search = ref(props.filters?.search || '');
const role = ref(props.filters?.role || '');

const handleFilter = () => {
    router.get(route('admin.users.index'), {
        search: search.value,
        role: role.value,
    }, { preserveState: true, replace: true });
};
</script>

<template>
    <Head title="Users & Role Permissions — Admin" />

    <AdminLayout>
        <template #header>
            <div>
                <h1 class="text-xl font-bold text-gray-900">Users & Editorial Role Management</h1>
                <p class="text-xs text-gray-500">Manage registered scholars, assign editorial roles (Editors, Reviewers, Proofreaders, Admins).</p>
            </div>
        </template>

        <div class="space-y-6">
            <!-- Search & Filters -->
            <KdCard padding="tight">
                <form @submit.prevent="handleFilter" class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <div>
                        <input
                            v-model="search"
                            type="text"
                            placeholder="Search by name, email or username..."
                            class="w-full bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>
                    <div>
                        <select
                            v-model="role"
                            class="w-full bg-white border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="">All Roles</option>
                            <option v-for="r in roles" :key="r" :value="r">{{ r }}</option>
                        </select>
                    </div>
                    <div>
                        <button type="submit" class="btn-secondary text-xs py-2 px-5">Filter Users</button>
                    </div>
                </form>
            </KdCard>

            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">User & Vanity Handle</th>
                                <th class="px-6 py-4">Email</th>
                                <th class="px-6 py-4">Assigned Roles</th>
                                <th class="px-6 py-4">Registered Date</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-for="u in users.data" :key="u.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900 text-sm">{{ u.name }}</div>
                                    <div v-if="u.username" class="text-academic-700 font-mono">@{{ u.username }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs text-gray-700">
                                    {{ u.email }}
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="flex flex-wrap gap-1">
                                        <span
                                            v-for="r in u.roles"
                                            :key="r.id"
                                            class="bg-navy-50 text-navy-800 border border-navy-200 px-2 py-0.5 rounded font-semibold text-[11px]"
                                        >
                                            {{ r.name }}
                                        </span>
                                        <span v-if="!u.roles || u.roles.length === 0" class="text-gray-400 italic">User</span>
                                    </div>
                                </td>

                                <td class="px-6 py-4 text-xs text-gray-400">
                                    {{ new Date(u.created_at).toLocaleDateString() }}
                                </td>

                                <td class="px-6 py-4 text-right text-xs">
                                    <Link :href="route('admin.users.edit', u.id)" class="text-navy-700 hover:text-navy-900 font-bold">
                                        Edit Roles →
                                    </Link>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
