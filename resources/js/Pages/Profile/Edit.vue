<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Account Profile & Security — Knowledge Dynamics" />

    <AuthenticatedLayout>
        <template #header>
            <div>
                <h1 class="text-xl font-bold text-slate-900">Account Profile & Security</h1>
                <p class="text-xs text-slate-500">Manage your researcher profile details, password, and authentication preferences.</p>
            </div>
        </template>

        <div class="max-w-4xl space-y-6">
            <!-- 1. Profile Information Card -->
            <div class="bg-white rounded-2xl border border-slate-200/80 p-6 sm:p-8 shadow-xs">
                <UpdateProfileInformationForm
                    :must-verify-email="mustVerifyEmail"
                    :status="status"
                    class="max-w-xl"
                />
            </div>

            <!-- 2. Security / Password Card -->
            <div class="bg-white rounded-2xl border border-slate-200/80 p-6 sm:p-8 shadow-xs">
                <UpdatePasswordForm class="max-w-xl" />
            </div>

            <!-- 3. Account Termination Card -->
            <div class="bg-white rounded-2xl border border-rose-200/80 p-6 sm:p-8 shadow-xs bg-rose-50/20">
                <DeleteUserForm class="max-w-xl" />
            </div>
        </div>
    </AuthenticatedLayout>
</template>
