<script setup>
import { ref } from 'vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    settings: {
        type: Object,
        required: true,
    },
    requests: {
        type: Object,
        required: true,
    },
});

const settingsForm = useForm({
    cpanel_host: props.settings.cpanel_host,
    cpanel_username: props.settings.cpanel_username,
    cpanel_api_token: props.settings.cpanel_api_token,
    cpanel_default_domain: props.settings.cpanel_default_domain,
    cpanel_port: props.settings.cpanel_port,
});

const saveSettings = () => {
    settingsForm.post(route('admin.cpanel.settings'));
};

const testConnection = () => {
    router.post(route('admin.cpanel.test_connection'));
};

const approveRequest = (req) => {
    if (confirm(`Provision and create "${req.full_email}" on cPanel server?`)) {
        router.post(route('admin.cpanel.approve', req.id), {
            quota_mb: req.quota_mb || 500,
        });
    }
};

const rejectModalOpen = ref(false);
const selectedRequest = ref(null);
const rejectForm = useForm({
    rejection_reason: '',
});

const openRejectModal = (req) => {
    selectedRequest.value = req;
    rejectForm.rejection_reason = '';
    rejectModalOpen.value = true;
};

const submitReject = () => {
    if (!selectedRequest.value) return;
    rejectForm.post(route('admin.cpanel.reject', selectedRequest.value.id), {
        onSuccess: () => {
            rejectModalOpen.value = false;
            selectedRequest.value = null;
        },
    });
};

const deleteAccount = (req) => {
    if (confirm(`Delete/suspend account "${req.full_email}" from cPanel server?`)) {
        router.delete(route('admin.cpanel.delete_account', req.id));
    }
};
</script>

<template>
    <Head title="cPanel Email API & Mailboxes — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <h1 class="text-xl font-bold text-gray-900">cPanel API & Academic Mail Accounts</h1>
                    <p class="text-xs text-gray-500">Configure Hostinger/cPanel UAPI credentials, manage personalized user emails, and approve mailbox requests.</p>
                </div>
                <div>
                    <button
                        @click="testConnection"
                        class="btn-secondary text-xs py-2 px-4 flex items-center gap-2 border-emerald-300 text-emerald-800 hover:bg-emerald-50"
                    >
                        <span class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></span>
                        Test cPanel API Connection
                    </button>
                </div>
            </div>
        </template>

        <div class="space-y-8">
            <!-- 1. cPanel API Credentials Card -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm">
                <div class="flex items-center justify-between border-b border-gray-100 pb-3 mb-5">
                    <div>
                        <h2 class="text-sm font-bold uppercase tracking-wider text-navy-800 flex items-center gap-2">
                            <svg class="w-4 h-4 text-navy-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                            </svg>
                            cPanel UAPI Configuration
                        </h2>
                        <p class="text-xs text-gray-500">Connects with Hostinger/cPanel to automatically provision academic email accounts.</p>
                    </div>
                </div>

                <form @submit.prevent="saveSettings" class="grid grid-cols-1 sm:grid-cols-3 gap-5">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">cPanel Server Host / URL *</label>
                        <input
                            v-model="settingsForm.cpanel_host"
                            type="text"
                            required
                            placeholder="e.g. cpanel.yourdomain.com or IP"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none font-mono text-xs"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">cPanel Username *</label>
                        <input
                            v-model="settingsForm.cpanel_username"
                            type="text"
                            required
                            placeholder="e.g. knowdyn"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Default Mail Domain *</label>
                        <input
                            v-model="settingsForm.cpanel_default_domain"
                            type="text"
                            required
                            placeholder="e.g. knowdyn.org"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">cPanel API Token *</label>
                        <input
                            v-model="settingsForm.cpanel_api_token"
                            type="text"
                            required
                            placeholder="EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none font-mono text-xs"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">cPanel SSL Port</label>
                        <input
                            v-model.number="settingsForm.cpanel_port"
                            type="number"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="sm:col-span-3 flex justify-end">
                        <button type="submit" :disabled="settingsForm.processing" class="btn-primary text-xs py-2 px-6 shadow-sm">
                            {{ settingsForm.processing ? 'Saving...' : 'Save API Settings' }}
                        </button>
                    </div>
                </form>
            </div>

            <!-- 2. Academic Email Applications & Accounts Table -->
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="px-6 py-4 border-b border-gray-200 bg-gray-50 flex items-center justify-between">
                    <div>
                        <h2 class="text-sm font-bold text-gray-900">Academic Email Requests & Active Mailboxes</h2>
                        <p class="text-xs text-gray-500">Approve user applications to automatically create mailboxes on your cPanel server.</p>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-3.5">User Details</th>
                                <th class="px-6 py-3.5">Requested Email Address</th>
                                <th class="px-6 py-3.5">Quota</th>
                                <th class="px-6 py-3.5">Status</th>
                                <th class="px-6 py-3.5">Applied Date</th>
                                <th class="px-6 py-3.5 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="requests.data.length === 0">
                                <td colspan="6" class="px-6 py-10 text-center text-gray-500">
                                    No email account requests submitted yet.
                                </td>
                            </tr>

                            <tr v-for="req in requests.data" :key="req.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4 text-xs">
                                    <div class="font-bold text-gray-900 text-sm">{{ req.user?.name }}</div>
                                    <div class="text-gray-500">{{ req.user?.email }}</div>
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <div class="font-mono font-bold text-navy-900 text-sm flex items-center gap-1.5">
                                        <svg class="w-4 h-4 text-academic-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                        </svg>
                                        {{ req.full_email }}
                                    </div>
                                </td>

                                <td class="px-6 py-4 text-xs font-semibold text-gray-700">
                                    {{ req.quota_mb }} MB
                                </td>

                                <td class="px-6 py-4 text-xs">
                                    <span
                                        class="px-2.5 py-0.5 rounded font-bold uppercase text-[10px]"
                                        :class="{
                                            'bg-amber-50 text-amber-800 border border-amber-200': req.status === 'pending',
                                            'bg-emerald-50 text-emerald-800 border border-emerald-200': req.status === 'active',
                                            'bg-rose-50 text-rose-800 border border-rose-200': req.status === 'rejected',
                                            'bg-gray-100 text-gray-700': req.status === 'suspended'
                                        }"
                                    >
                                        {{ req.status }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-xs text-gray-400">
                                    {{ new Date(req.created_at).toLocaleDateString() }}
                                </td>

                                <td class="px-6 py-4 text-right text-xs space-x-2">
                                    <!-- Pending actions -->
                                    <template v-if="req.status === 'pending'">
                                        <button
                                            @click="approveRequest(req)"
                                            class="btn-primary text-xs py-1 px-3 bg-emerald-600 hover:bg-emerald-700"
                                        >
                                            Approve & Create
                                        </button>
                                        <button
                                            @click="openRejectModal(req)"
                                            class="text-rose-600 hover:text-rose-800 font-bold"
                                        >
                                            Reject
                                        </button>
                                    </template>

                                    <!-- Active actions -->
                                    <template v-else-if="req.status === 'active'">
                                        <button
                                            @click="deleteAccount(req)"
                                            class="text-rose-600 hover:text-rose-800 font-bold text-xs"
                                        >
                                            Delete / Suspend
                                        </button>
                                    </template>

                                    <template v-else>
                                        <span class="text-gray-400">—</span>
                                    </template>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Reject Modal -->
        <div v-if="rejectModalOpen" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4">
            <div class="bg-white rounded-xl max-w-md w-full p-6 shadow-2xl space-y-4">
                <h3 class="text-base font-bold text-gray-900">Decline Email Request</h3>
                <p class="text-xs text-gray-500">Provide a reason for declining the academic email application for {{ selectedRequest?.full_email }}:</p>

                <textarea
                    v-model="rejectForm.rejection_reason"
                    rows="3"
                    required
                    placeholder="e.g. Please verify your institutional affiliation first..."
                    class="w-full border border-gray-300 rounded-lg p-2.5 text-xs focus:ring-2 focus:ring-navy-600 focus:outline-none"
                ></textarea>

                <div class="flex justify-end gap-2 pt-2">
                    <button @click="rejectModalOpen = false" type="button" class="btn-secondary text-xs py-1.5 px-4">Cancel</button>
                    <button @click="submitReject" type="button" class="btn-primary text-xs py-1.5 px-4 bg-rose-600 hover:bg-rose-700">Decline Request</button>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
