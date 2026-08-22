<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const form = useForm({
    title: '',
    department: 'Health Dynamics Editorial Office',
    type: 'Academic Editorial Role (Part-Time / Remote)',
    summary: '',
    requirements: '',
    is_active: true,
    deadline: 'Open until filled',
});

const submit = () => {
    form.post(route('admin.careers.store'));
};
</script>

<template>
    <Head title="Post Career Opening — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.careers.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Careers
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900">Post Career / Editorial Role</h1>
            </div>
        </template>

        <div class="max-w-4xl mx-auto">
            <form @submit.prevent="submit" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Position Title *</label>
                        <input
                            v-model="form.title"
                            type="text"
                            required
                            placeholder="e.g. Section Editor — Biomedical & Health Sciences"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Department / Journal Office *</label>
                        <input
                            v-model="form.department"
                            type="text"
                            required
                            placeholder="e.g. KD Food Science Nutrition Editorial Office"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Employment / Role Type *</label>
                        <input
                            v-model="form.type"
                            type="text"
                            required
                            placeholder="e.g. Freelance / Remote, Full-Time, Part-Time"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Application Deadline</label>
                        <input
                            v-model="form.deadline"
                            type="text"
                            placeholder="e.g. September 30, 2026 or Continuous"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="flex items-center">
                        <label class="flex items-center gap-2 text-xs font-semibold text-gray-700 cursor-pointer pt-4">
                            <input v-model="form.is_active" type="checkbox" class="rounded text-navy-700 h-4 w-4" />
                            Accept Applications (Active)
                        </label>
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Role Summary *</label>
                        <textarea
                            v-model="form.summary"
                            rows="3"
                            required
                            placeholder="Brief description of responsibilities..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Candidate Requirements</label>
                        <textarea
                            v-model="form.requirements"
                            rows="5"
                            placeholder="• PhD degree requirements, peer review experience, language proficiency..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>
                </div>

                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <Link :href="route('admin.careers.index')" class="btn-secondary text-xs py-2 px-5">Cancel</Link>
                    <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6 shadow-sm">
                        {{ form.processing ? 'Posting...' : 'Post Career Opening' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
