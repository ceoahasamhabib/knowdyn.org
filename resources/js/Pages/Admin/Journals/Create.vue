<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const form = useForm({
    title: '',
    short_title: '',
    slug: '',
    description: '',
    aims_and_scope: '',
    issn_print: '',
    issn_online: '',
    publisher: 'Knowledge Dynamics',
    publication_frequency: 'Quarterly',
    established_year: new Date().getFullYear(),
    status: 'active',
    is_open_access: true,
    contact_email: '',
    settings: {
        review_model: 'double_blind',
        peer_review_process: 'All submitted manuscripts undergo a double-blind peer review evaluation by at least two independent expert reviewers.',
        publication_ethics: 'Knowledge Dynamics adheres to the Committee on Publication Ethics (COPE) code of conduct and best practice guidelines.',
        author_guidelines: 'Manuscripts must be original, written in clear academic English, and formatted in accordance with the KD reference style.',
        open_access_policy: 'This journal provides immediate open access to all published content under the CC BY 4.0 license.',
        copyright_notice: 'Authors retain copyright and grant the journal the non-exclusive right to publish the article.',
    },
});

const submit = () => {
    form.post(route('admin.journals.store'));
};
</script>

<template>
    <Head title="Create Journal — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.journals.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Journals
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-xl font-bold text-gray-900">Add New Academic Journal</h1>
            </div>
        </template>

        <form @submit.prevent="submit" class="max-w-4xl space-y-8">
            <!-- Basic Information -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <h2 class="text-base font-bold text-gray-900 border-b border-gray-100 pb-3">Basic Information</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Journal Full Title *</label>
                        <input
                            v-model="form.title"
                            type="text"
                            required
                            placeholder="e.g. Journal of Knowledge Dynamics & Applied Sciences"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                        <p v-if="form.errors.title" class="text-xs text-rose-600 mt-1">{{ form.errors.title }}</p>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Short Title / Acronym</label>
                        <input
                            v-model="form.short_title"
                            type="text"
                            placeholder="e.g. JKDAS"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Custom Slug (Optional)</label>
                        <input
                            v-model="form.slug"
                            type="text"
                            placeholder="auto-generated-from-title"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                        <p v-if="form.errors.slug" class="text-xs text-rose-600 mt-1">{{ form.errors.slug }}</p>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">ISSN (Online)</label>
                        <input
                            v-model="form.issn_online"
                            type="text"
                            placeholder="e.g. 2971-8821"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">ISSN (Print)</label>
                        <input
                            v-model="form.issn_print"
                            type="text"
                            placeholder="e.g. 2971-8813"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publication Frequency</label>
                        <select
                            v-model="form.publication_frequency"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="Monthly">Monthly</option>
                            <option value="Bi-monthly">Bi-monthly</option>
                            <option value="Quarterly">Quarterly</option>
                            <option value="Semi-annually">Semi-annually</option>
                            <option value="Annually">Annually</option>
                            <option value="Continuous">Continuous Publication</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Established Year</label>
                        <input
                            v-model="form.established_year"
                            type="number"
                            min="1900"
                            :max="new Date().getFullYear() + 1"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Brief Description</label>
                        <textarea
                            v-model="form.description"
                            rows="3"
                            placeholder="High-level overview of the journal..."
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Aims & Scope</label>
                        <textarea
                            v-model="form.aims_and_scope"
                            rows="5"
                            placeholder="Detailed scholarly aims, topics covered, target audience..."
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>
                </div>
            </div>

            <!-- Editorial Policies & Settings -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <h2 class="text-base font-bold text-gray-900 border-b border-gray-100 pb-3">Peer Review & Editorial Policies</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Peer Review Model *</label>
                        <select
                            v-model="form.settings.review_model"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="double_blind">Double Blind (Reviewers & Authors Anonymous)</option>
                            <option value="single_blind">Single Blind (Reviewers Anonymous)</option>
                            <option value="open_review">Open Peer Review</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Journal Status</label>
                        <select
                            v-model="form.status"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="active">Active (Publicly Visible)</option>
                            <option value="inactive">Inactive (Draft/Hidden)</option>
                            <option value="archived">Archived</option>
                        </select>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Peer Review Process Description</label>
                        <textarea
                            v-model="form.settings.peer_review_process"
                            rows="3"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Author Guidelines</label>
                        <textarea
                            v-model="form.settings.author_guidelines"
                            rows="4"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end gap-3">
                <Link :href="route('admin.journals.index')" class="btn-secondary text-xs py-2.5 px-5">
                    Cancel
                </Link>
                <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6">
                    {{ form.processing ? 'Saving...' : 'Create Journal' }}
                </button>
            </div>
        </form>
    </AdminLayout>
</template>
