<script setup>
import { computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const props = defineProps({
    status: {
        type: String,
    },
});

const form = useForm({});

const submit = () => {
    form.post(route('verification.send'));
};

const verificationLinkSent = computed(
    () => props.status === 'verification-link-sent',
);
</script>

<template>
    <GuestLayout>
        <Head title="Verify Academic Email — Knowledge Dynamics" />

        <div class="space-y-6">
            <div>
                <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-indigo-50 text-indigo-700 text-[11px] font-bold mb-2">
                    <span>✉️</span> Email Verification
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
                    Check your inbox
                </h1>
                <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                    Thanks for registering! Please click the verification link we just emailed to your institutional inbox to activate full submission and peer review permissions.
                </p>
            </div>

            <div
                class="p-3.5 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-xl text-xs font-semibold flex items-center gap-2"
                v-if="verificationLinkSent"
            >
                <span>✓</span> A fresh verification link has been dispatched to your email address.
            </div>

            <form @submit.prevent="submit" class="space-y-4">
                <button
                    type="submit"
                    :disabled="form.processing"
                    class="w-full py-3 px-4 rounded-xl text-white font-bold text-sm shadow-md hover:shadow-lg transition duration-200 flex items-center justify-center gap-2 disabled:opacity-50"
                    :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                >
                    <span>{{ form.processing ? 'Dispatching Email...' : 'Resend Verification Email →' }}</span>
                </button>
            </form>

            <div class="text-center pt-2 border-t border-slate-100">
                <Link
                    :href="route('logout')"
                    method="post"
                    as="button"
                    class="text-xs font-semibold text-rose-600 hover:text-rose-800 hover:underline"
                >
                    Sign Out & Return Later
                </Link>
            </div>
        </div>
    </GuestLayout>
</template>
