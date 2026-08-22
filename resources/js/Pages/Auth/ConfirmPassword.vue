<script setup>
import { ref, computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, useForm, usePage } from '@inertiajs/vue3';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const showPassword = ref(false);

const form = useForm({
    password: '',
});

const submit = () => {
    form.post(route('password.confirm'), {
        onFinish: () => form.reset(),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Confirm Secure Access — Knowledge Dynamics" />

        <div class="space-y-6">
            <div>
                <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-rose-50 text-rose-700 text-[11px] font-bold mb-2">
                    <span>🛡️</span> Security Confirmation
                </div>
                <h1 class="text-2xl font-extrabold text-slate-900 tracking-tight">
                    Confirm your identity
                </h1>
                <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                    This is a protected editorial zone. Please re-enter your password to confirm your institutional permissions.
                </p>
            </div>

            <form @submit.prevent="submit" class="space-y-4">
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
                            autofocus
                            autocomplete="current-password"
                            placeholder="••••••••••••"
                            class="w-full pl-10 pr-10 py-2.5 rounded-xl border border-slate-200 text-sm text-slate-900 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-indigo-500 shadow-2xs"
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

                <button
                    type="submit"
                    :disabled="form.processing"
                    class="w-full py-3 px-4 rounded-xl text-white font-bold text-sm shadow-md hover:shadow-lg transition duration-200 flex items-center justify-center gap-2 disabled:opacity-50"
                    :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                >
                    <span>{{ form.processing ? 'Verifying...' : 'Confirm & Continue →' }}</span>
                </button>
            </form>
        </div>
    </GuestLayout>
</template>
