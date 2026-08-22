<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const form = useForm({
    title: '',
    type: 'news', // 'news', 'event', 'announcement', 'workshop'
    category: 'Publisher News',
    summary: '',
    content: '',
    event_date: '',
    location: '',
    registration_url: '',
    deadline: '',
    is_featured: false,
    is_published: true,
});

const submit = () => {
    form.post(route('admin.news_events.store'));
};
</script>

<template>
    <Head title="Post News / Event — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.news_events.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to News & Events
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900">Post News, Announcement or Event</h1>
            </div>
        </template>

        <div class="max-w-4xl mx-auto">
            <form @submit.prevent="submit" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Title *</label>
                        <input
                            v-model="form.title"
                            type="text"
                            required
                            placeholder="e.g. Call for Papers: Special Issue on Climate Resilient Agriculture"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Content Type *</label>
                        <select
                            v-model="form.type"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="news">News Article</option>
                            <option value="announcement">Announcement / CFP</option>
                            <option value="event">Symposium / Conference</option>
                            <option value="workshop">Seminar & Workshop</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Category Tag</label>
                        <input
                            v-model="form.category"
                            type="text"
                            placeholder="e.g. Special Issue CFP, Workshop"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Event Date (Optional)</label>
                        <input
                            v-model="form.event_date"
                            type="text"
                            placeholder="e.g. October 14–16, 2026"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Location / Venue</label>
                        <input
                            v-model="form.location"
                            type="text"
                            placeholder="e.g. Virtual & Stockholm, Sweden"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Submission Deadline (Optional)</label>
                        <input
                            v-model="form.deadline"
                            type="text"
                            placeholder="e.g. December 31, 2026"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Registration URL</label>
                        <input
                            v-model="form.registration_url"
                            type="url"
                            placeholder="https://..."
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Summary *</label>
                        <textarea
                            v-model="form.summary"
                            rows="3"
                            required
                            placeholder="Brief abstract/summary..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Detailed Content (Markdown/Text)</label>
                        <textarea
                            v-model="form.content"
                            rows="6"
                            placeholder="Detailed text and call for paper specifications..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="flex items-center gap-6 sm:col-span-2">
                        <label class="flex items-center gap-2 text-xs font-semibold text-gray-700 cursor-pointer">
                            <input v-model="form.is_published" type="checkbox" class="rounded text-navy-700 h-4 w-4" />
                            Publish Immediately
                        </label>
                        <label class="flex items-center gap-2 text-xs font-semibold text-gray-700 cursor-pointer">
                            <input v-model="form.is_featured" type="checkbox" class="rounded text-navy-700 h-4 w-4" />
                            Feature on Homepage
                        </label>
                    </div>
                </div>

                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <Link :href="route('admin.news_events.index')" class="btn-secondary text-xs py-2 px-5">Cancel</Link>
                    <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6 shadow-sm">
                        {{ form.processing ? 'Publishing...' : 'Save & Publish' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
