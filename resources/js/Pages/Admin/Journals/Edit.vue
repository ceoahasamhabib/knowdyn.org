<script setup>
import { ref } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
});

const activeTab = ref('info');

const form = useForm({
    title: props.journal.title || '',
    short_title: props.journal.short_title || '',
    slug: props.journal.slug || '',
    description: props.journal.description || '',
    aims_and_scope: props.journal.aims_and_scope || '',
    issn_print: props.journal.issn_print || '',
    issn_online: props.journal.issn_online || '',
    publisher: props.journal.publisher || 'Knowledge Dynamics',
    publication_frequency: props.journal.publication_frequency || 'Quarterly',
    established_year: props.journal.established_year || 2021,
    status: props.journal.status || 'active',
    is_open_access: props.journal.is_open_access ?? true,
    contact_email: props.journal.contact_email || '',
    settings: {
        review_model: props.journal.settings?.review_model || 'double_blind',
        peer_review_process: props.journal.settings?.peer_review_process || '',
        publication_ethics: props.journal.settings?.publication_ethics || '',
        author_guidelines: props.journal.settings?.author_guidelines || '',
        open_access_policy: props.journal.settings?.open_access_policy || '',
        copyright_notice: props.journal.settings?.copyright_notice || '',
        author_fees: props.journal.settings?.author_fees || '',
    },
});

const submit = () => {
    form.put(route('admin.journals.update', props.journal.id));
};
</script>

<template>
    <Head :title="`Edit Journal — ${journal.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div class="flex items-center gap-3">
                    <Link :href="route('admin.journals.index')" class="text-xs text-gray-500 hover:text-gray-700">
                        ← Journals
                    </Link>
                    <span class="text-gray-300">/</span>
                    <h1 class="text-lg font-bold text-gray-900 truncate max-w-md">Edit: {{ journal.title }}</h1>
                </div>

                <div class="flex items-center gap-2">
                    <Link :href="route('admin.journals.volumes.index', journal.id)" class="btn-secondary text-xs py-1.5 px-3">
                        Manage Volumes & Issues
                    </Link>
                    <Link :href="route('admin.journals.editorial_board.index', journal.id)" class="btn-secondary text-xs py-1.5 px-3">
                        Manage Editorial Board
                    </Link>
                    <Link :href="route('journals.show', journal.slug)" target="_blank" class="btn-ghost text-xs py-1.5 px-3">
                        View Public Page ↗
                    </Link>
                </div>
            </div>
        </template>

        <div class="max-w-4xl space-y-6">
            <!-- Tabs -->
            <div class="flex border-b border-gray-200 gap-4 text-xs font-semibold">
                <button
                    @click="activeTab = 'info'"
                    :class="['pb-3 px-1 border-b-2 transition', activeTab === 'info' ? 'border-navy-700 text-navy-900' : 'border-transparent text-gray-500 hover:text-gray-700']"
                >
                    Journal Details & Scope
                </button>
                <button
                    @click="activeTab = 'settings'"
                    :class="['pb-3 px-1 border-b-2 transition', activeTab === 'settings' ? 'border-navy-700 text-navy-900' : 'border-transparent text-gray-500 hover:text-gray-700']"
                >
                    Peer Review & Policies
                </button>
            </div>

            <form @submit.prevent="submit" class="space-y-6">
                <!-- Info Tab -->
                <div v-show="activeTab === 'info'" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Journal Full Title *</label>
                            <input
                                v-model="form.title"
                                type="text"
                                required
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                            <p v-if="form.errors.title" class="text-xs text-rose-600 mt-1">{{ form.errors.title }}</p>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Short Title / Acronym</label>
                            <input
                                v-model="form.short_title"
                                type="text"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Slug (URL)</label>
                            <input
                                v-model="form.slug"
                                type="text"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">ISSN (Online)</label>
                            <input
                                v-model="form.issn_online"
                                type="text"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">ISSN (Print)</label>
                            <input
                                v-model="form.issn_print"
                                type="text"
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
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Status</label>
                            <select
                                v-model="form.status"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option value="active">Active (Published)</option>
                                <option value="inactive">Inactive</option>
                                <option value="archived">Archived</option>
                            </select>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Brief Description</label>
                            <textarea
                                v-model="form.description"
                                rows="3"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Aims & Scope</label>
                            <textarea
                                v-model="form.aims_and_scope"
                                rows="6"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- Settings Tab -->
                <div v-show="activeTab === 'settings'" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Peer Review Model</label>
                            <select
                                v-model="form.settings.review_model"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option value="double_blind">Double Blind</option>
                                <option value="single_blind">Single Blind</option>
                                <option value="open_review">Open Peer Review</option>
                            </select>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Peer Review Workflow Statement</label>
                            <textarea
                                v-model="form.settings.peer_review_process"
                                rows="3"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publication Ethics Statement</label>
                            <textarea
                                v-model="form.settings.publication_ethics"
                                rows="3"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Author Guidelines</label>
                            <textarea
                                v-model="form.settings.author_guidelines"
                                rows="5"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="flex justify-end gap-3">
                    <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6">
                        {{ form.processing ? 'Saving...' : 'Update Journal' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
