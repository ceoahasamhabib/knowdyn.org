<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    user: {
        type: Object,
        required: true,
    },
    roles: {
        type: Array,
        default: () => [],
    },
    userRoles: {
        type: Array,
        default: () => [],
    },
});

const form = useForm({
    name: props.user.name,
    email: props.user.email,
    roles: [...props.userRoles],
});

const toggleRole = (r) => {
    if (form.roles.includes(r)) {
        form.roles = form.roles.filter(x => x !== r);
    } else {
        form.roles.push(r);
    }
};

const submit = () => {
    form.put(route('admin.users.update', props.user.id));
};
</script>

<template>
    <Head :title="`Edit User — ${user.name}`" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.users.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Users
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900 truncate max-w-xl">Manage User & Roles: {{ user.name }}</h1>
            </div>
        </template>

        <div class="max-w-3xl mx-auto">
            <form @submit.prevent="submit" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="border-b border-gray-100 pb-4">
                    <h2 class="text-base font-bold text-gray-900">User Account Information</h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Full Name *</label>
                        <input
                            v-model="form.name"
                            type="text"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Email Address *</label>
                        <input
                            v-model="form.email"
                            type="email"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>
                </div>

                <!-- Roles Assignment Checklist -->
                <div class="space-y-3 pt-4 border-t border-gray-100">
                    <label class="block text-xs font-semibold text-gray-700 uppercase">Assigned Roles & Editorial Privileges</label>
                    <p class="text-xs text-gray-500">Select all roles applicable to this user account.</p>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-2">
                        <div
                            v-for="r in roles"
                            :key="r"
                            @click="toggleRole(r)"
                            class="p-3 rounded-lg border flex items-center gap-3 cursor-pointer transition"
                            :class="form.roles.includes(r) ? 'border-navy-700 bg-navy-50/60 ring-1 ring-navy-700' : 'border-gray-200 hover:border-gray-300'"
                        >
                            <input
                                type="checkbox"
                                :checked="form.roles.includes(r)"
                                @click.stop="toggleRole(r)"
                                class="rounded text-navy-700 h-4 w-4"
                            />
                            <div>
                                <span class="text-xs font-bold text-gray-900">{{ r }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <Link :href="route('admin.users.index')" class="btn-secondary text-xs py-2 px-5">Cancel</Link>
                    <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6 shadow-sm">
                        {{ form.processing ? 'Saving...' : 'Save User & Roles' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
