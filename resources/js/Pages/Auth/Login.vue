<script setup>
import { ref, computed } from 'vue';
import Checkbox from '@/Components/Checkbox.vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';

const page = usePage();
const theme = computed(() => page.props.theme || {});

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const showPassword = ref(false);

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};

const quickFill = (email, password = 'password') => {
    form.email = email;
    form.password = password;
};
</script>

<template>
    <GuestLayout>
        <Head title="Sign In — Knowledge Dynamics" />

        <div class="space-y-6">
            <!-- Header Title -->
            <div>
                <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-indigo-50 text-indigo-700 text-[11px] font-bold mb-2">
                    <span>🔐</span> Secure Scholar Login
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
                    Welcome back
                </h1>
                <p class="text-xs text-slate-500 mt-1">
                    Sign in to access your manuscript portfolio, review queue, and academic webmail.
                </p>
            </div>

            <!-- Status Alert -->
            <div v-if="status" class="p-3 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-xl text-xs font-semibold flex items-center gap-2">
                <span>✓</span> {{ status }}
            </div>

            <!-- Login Form -->
            <form @submit.prevent="submit" class="space-y-4">
                <!-- Email Field -->
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
                            placeholder="scholar@university.edu or @knowdyn.org"
                            class="w-full pl-10 pr-4 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                        />
                    </div>
                    <InputError class="mt-1.5 text-xs" :message="form.errors.email" />
                </div>

                <!-- Password Field -->
                <div>
                    <div class="flex items-center justify-between mb-1.5">
                        <label for="password" class="block text-xs font-bold text-slate-700 uppercase tracking-wider">
                            Password
                        </label>
                        <Link
                            v-if="canResetPassword"
                            :href="route('password.request')"
                            class="text-xs font-semibold text-indigo-600 hover:text-indigo-800 hover:underline"
                        >
                            Forgot password?
                        </Link>
                    </div>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 text-sm">
                            🔒
                        </div>
                        <input
                            id="password"
                            :type="showPassword ? 'text' : 'password'"
                            v-model="form.password"
                            required
                            autocomplete="current-password"
                            placeholder="••••••••••••"
                            class="w-full pl-10 pr-11 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition shadow-2xs"
                        />
                        <button
                            type="button"
                            @click="showPassword = !showPassword"
                            class="absolute inset-y-0 right-0 pr-3.5 flex items-center text-slate-400 hover:text-slate-600 transition"
                            title="Toggle password visibility"
                        >
                            <span class="text-xs">{{ showPassword ? '🙈' : '👁️' }}</span>
                        </button>
                    </div>
                    <InputError class="mt-1.5 text-xs" :message="form.errors.password" />
                </div>

                <!-- Remember Me -->
                <div class="flex items-center justify-between pt-1">
                    <label class="flex items-center gap-2 cursor-pointer">
                        <Checkbox name="remember" v-model:checked="form.remember" class="rounded border-slate-300 text-indigo-600 shadow-2xs focus:ring-indigo-500" />
                        <span class="text-xs text-slate-600 font-medium">Keep me signed in for 30 days</span>
                    </label>
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
                    <span>{{ form.processing ? 'Verifying Credentials...' : 'Sign In to Portal →' }}</span>
                </button>
            </form>

            <!-- Quick Demo Login Presets -->
            <div class="pt-3 border-t border-slate-100">
                <div class="flex items-center justify-between mb-2">
                    <span class="text-[11px] font-bold text-slate-400 uppercase tracking-wider">Quick Demo Login</span>
                    <span class="text-[10px] text-slate-400 font-mono">Password: password</span>
                </div>
                <div class="grid grid-cols-2 gap-2">
                    <button
                        type="button"
                        @click="quickFill('admin@knowdyn.org')"
                        class="p-2 rounded-lg bg-slate-50 hover:bg-indigo-50 hover:border-indigo-200 border border-slate-200/80 text-left transition group"
                    >
                        <span class="block text-xs font-bold text-slate-800 group-hover:text-indigo-700">👑 Admin / Editor</span>
                        <span class="block text-[10px] text-slate-500 truncate">admin@knowdyn.org</span>
                    </button>
                    <button
                        type="button"
                        @click="quickFill('rahim@university.edu')"
                        class="p-2 rounded-lg bg-slate-50 hover:bg-indigo-50 hover:border-indigo-200 border border-slate-200/80 text-left transition group"
                    >
                        <span class="block text-xs font-bold text-slate-800 group-hover:text-indigo-700">🎓 Author Scholar</span>
                        <span class="block text-[10px] text-slate-500 truncate">rahim@university.edu</span>
                    </button>
                </div>
            </div>

            <!-- Sign Up CTA -->
            <div class="text-center pt-2">
                <p class="text-xs text-slate-600">
                    Don't have a scholar account?
                    <Link :href="route('register')" class="font-bold text-indigo-600 hover:text-indigo-800 hover:underline">
                        Create an account →
                    </Link>
                </p>
            </div>
        </div>
    </GuestLayout>
</template>
