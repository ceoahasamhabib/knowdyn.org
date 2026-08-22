<script setup>
import { computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';

const page = usePage();
const theme = computed(() => page.props.theme || {});

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Forgot Password — Knowledge Dynamics" />

        <div class="space-y-6">
            <div>
                <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-amber-50 text-amber-700 text-[11px] font-bold mb-2">
                    <span>🔑</span> Password Recovery
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
                    Reset your password
                </h1>
                <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                    Enter the email address associated with your scholar account, and we will send you a secure password reset link.
                </p>
            </div>

            <!-- Status Alert -->
            <div v-if="status" class="p-3.5 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-xl text-xs font-semibold flex items-center gap-2">
                <span>✓</span> {{ status }}
            </div>

            <form @submit.prevent="submit" class="space-y-4">
                <div>
                    <label for="email" class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                        Academic Email Address
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 text-sm">
                            ✉️
                        </div>
                        <input
                            id="email"
                            type="email"
                            v-model="form.email"
                            required
                            autofocus
                            autocomplete="username"
                            placeholder="scholar@university.edu"
                            class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                        />
                    </div>
                    <InputError class="mt-1.5 text-xs" :message="form.errors.email" />
                </div>

                <button
                    type="submit"
                    :disabled="form.processing"
                    class="w-full py-3 px-4 rounded-xl text-white font-bold text-sm shadow-md hover:shadow-lg transition duration-200 flex items-center justify-center gap-2 disabled:opacity-50"
                    :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                >
                    <svg v-if="form.processing" class="animate-spin h-4 w-4 text-white" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <span>{{ form.processing ? 'Sending Link...' : 'Email Password Reset Link →' }}</span>
                </button>
            </form>

            <div class="text-center pt-2 border-t border-slate-100">
                <Link :href="route('login')" class="text-xs font-semibold text-slate-600 hover:text-slate-900">
                    ← Return to Sign In
                </Link>
            </div>
        </div>
    </GuestLayout>
</template>
