<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    page: {
        type: Object,
        required: true,
    },
});

const form = useForm({
    title: props.page.title,
    content: props.page.content,
    meta_title: props.page.meta_title || '',
    meta_description: props.page.meta_description || '',
});

const submit = () => {
    form.put(route('admin.guidelines.update', props.page.id));
};
</script>

<template>
    <Head :title="`Edit — ${page.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.guidelines.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Guidelines
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900 truncate max-w-xl">Edit: {{ page.title }}</h1>
            </div>
        </template>

        <div class="max-w-4xl mx-auto">
            <form @submit.prevent="submit" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Page Title *</label>
                        <input
                            v-model="form.title"
                            type="text"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Full Content (Markdown / Text) *</label>
                        <textarea
                            v-model="form.content"
                            rows="14"
                            required
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none font-mono text-xs"
                        ></textarea>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">SEO Meta Title</label>
                        <input
                            v-model="form.meta_title"
                            type="text"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">SEO Meta Description</label>
                        <input
                            v-model="form.meta_description"
                            type="text"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>
                </div>

                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <Link :href="route('admin.guidelines.index')" class="btn-secondary text-xs py-2 px-5">Cancel</Link>
                    <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6 shadow-sm">
                        {{ form.processing ? 'Saving...' : 'Save Policy Changes' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
