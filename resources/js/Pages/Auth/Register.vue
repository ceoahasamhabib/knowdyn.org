<script setup>
import { ref, computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const showPassword = ref(false);

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    terms: true,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Create Scholar Account — Knowledge Dynamics" />

        <div class="space-y-6">
            <!-- Header -->
            <div>
                <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-emerald-50 text-emerald-700 text-[11px] font-bold mb-2">
                    <span>✨</span> New Scholar Registration
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
                    Create your account
                </h1>
                <p class="text-xs text-slate-500 mt-1">
                    Join the international open-access community to submit papers, participate in peer review, and access academic webmail.
                </p>
            </div>

            <!-- Registration Form -->
            <form @submit.prevent="submit" class="space-y-4">
                <!-- Full Name -->
                <div>
                    <label for="name" class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                        Full Name & Academic Title
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 text-sm">
                            👤
                        </div>
                        <input
                            id="name"
                            type="text"
                            v-model="form.name"
                            required
                            autofocus
                            autocomplete="name"
                            placeholder="e.g. Prof. Sarah Jenkins, Ph.D."
                            class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                        />
                    </div>
                    <InputError class="mt-1.5 text-xs" :message="form.errors.name" />
                </div>

                <!-- Academic Email -->
                <div>
                    <label for="email" class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                        Institutional / Academic Email
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
                            autocomplete="username"
                            placeholder="s.jenkins@cambridge.ac.uk"
                            class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                        />
                    </div>
                    <InputError class="mt-1.5 text-xs" :message="form.errors.email" />
                </div>

                <!-- Password Fields Row -->
                <div class="grid sm:grid-cols-2 gap-4">
                    <!-- Password -->
                    <div>
                        <label for="password" class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                            Password
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 text-sm">
                                🔒
                            </div>
                            <input
                                id="password"
                                :type="showPassword ? 'text' : 'password'"
                                v-model="form.password"
                                required
                                autocomplete="new-password"
                                placeholder="••••••••••••"
                                class="w-full pl-10 pr-10 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                            />
                            <button
                                type="button"
                                @click="showPassword = !showPassword"
                                class="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-slate-600 transition"
                            >
                                <span class="text-xs">{{ showPassword ? '🙈' : '👁️' }}</span>
                            </button>
                        </div>
                        <InputError class="mt-1.5 text-xs" :message="form.errors.password" />
                    </div>

                    <!-- Confirm Password -->
                    <div>
                        <label for="password_confirmation" class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                            Confirm Password
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 text-sm">
                                🔒
                            </div>
                            <input
                                id="password_confirmation"
                                :type="showPassword ? 'text' : 'password'"
                                v-model="form.password_confirmation"
                                required
                                autocomplete="new-password"
                                placeholder="••••••••••••"
                                class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                            />
                        </div>
                        <InputError class="mt-1.5 text-xs" :message="form.errors.password_confirmation" />
                    </div>
                </div>

                <!-- Terms & Open Access Agreement -->
                <div class="p-3 bg-slate-50 rounded-xl border border-slate-200/80 text-[11px] text-slate-600 flex items-start gap-2.5">
                    <span class="text-indigo-600 text-sm shrink-0">📜</span>
                    <p class="leading-relaxed">
                        By registering, you agree to the Knowledge Dynamics <strong>Publication Ethics</strong>, <strong>CC BY 4.0 Open Access Charter</strong>, and <strong>Peer Review Confidentiality</strong> standards.
                    </p>
                </div>

                <!-- Submit Button -->
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
                    <span>{{ form.processing ? 'Registering Scholar Profile...' : 'Complete Registration →' }}</span>
                </button>
            </form>

            <!-- Already Registered -->
            <div class="text-center pt-2 border-t border-slate-100">
                <p class="text-xs text-slate-600">
                    Already registered with Knowledge Dynamics?
                    <Link :href="route('login')" class="font-bold text-indigo-600 hover:text-indigo-800 hover:underline">
                        Sign in here →
                    </Link>
                </p>
            </div>
        </div>
    </GuestLayout>
</template>
