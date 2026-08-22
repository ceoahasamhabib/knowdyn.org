<script setup>
import { ref, computed } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    article: {
        type: Object,
        required: true,
    },
    journals: {
        type: Array,
        default: () => [],
    },
});

const keywordInput = ref('');
const referenceInput = ref('');

const initialAuthors = (props.article.authors && props.article.authors.length > 0)
    ? props.article.authors.map(a => ({
        first_name: a.first_name,
        last_name: a.last_name,
        email: a.email || '',
        affiliation: a.affiliation || '',
        country: a.country || '',
        orcid: a.orcid || '',
        is_corresponding: Boolean(a.is_corresponding),
        sort_order: a.sort_order,
    }))
    : [{ first_name: '', last_name: '', email: '', affiliation: '', country: '', orcid: '', is_corresponding: true, sort_order: 1 }];

const initialKeywords = props.article.keywords ? props.article.keywords.map(k => k.name) : [];
const initialReferences = props.article.references ? props.article.references.map(r => r.reference_text) : [];
const initialIssueId = props.article.issues?.[0]?.id || '';

const form = useForm({
    journal_id: props.article.journal_id,
    issue_id: initialIssueId,
    title: props.article.title,
    slug: props.article.slug,
    abstract: props.article.abstract || '',
    article_type: props.article.article_type || 'original-research',
    doi: props.article.doi || '',
    pages: props.article.pages || '',
    submission_date: props.article.submission_date || '',
    acceptance_date: props.article.acceptance_date || '',
    published_at: props.article.published_at ? props.article.published_at.split('T')[0] : '',
    funding: props.article.funding || '',
    conflict_of_interest: props.article.conflict_of_interest || '',
    ethics_statement: props.article.ethics_statement || '',
    license: props.article.license || 'CC BY 4.0',
    status: props.article.status || 'published',
    authors: initialAuthors,
    keywords: initialKeywords,
    references: initialReferences,
});

const selectedJournal = computed(() => {
    return props.journals.find(j => j.id == form.journal_id);
});

const availableIssues = computed(() => {
    if (!selectedJournal.value?.volumes) return [];
    return selectedJournal.value.volumes.flatMap(v => {
        return (v.issues || []).map(i => ({
            id: i.id,
            label: `Vol. ${v.number} (${v.year}) - Issue ${i.number} ${i.is_current ? '[CURRENT]' : ''}`,
        }));
    });
});

const addAuthor = () => {
    form.authors.push({
        first_name: '',
        last_name: '',
        email: '',
        affiliation: '',
        country: '',
        orcid: '',
        is_corresponding: false,
        sort_order: form.authors.length + 1,
    });
};

const removeAuthor = (index) => {
    form.authors.splice(index, 1);
};

const addKeyword = () => {
    if (keywordInput.value.trim() && !form.keywords.includes(keywordInput.value.trim())) {
        form.keywords.push(keywordInput.value.trim());
        keywordInput.value = '';
    }
};

const removeKeyword = (index) => {
    form.keywords.splice(index, 1);
};

const addReference = () => {
    if (referenceInput.value.trim()) {
        form.references.push(referenceInput.value.trim());
        referenceInput.value = '';
    }
};

const removeReference = (index) => {
    form.references.splice(index, 1);
};

const submit = () => {
    form.put(route('admin.articles.update', props.article.id));
};
</script>

<template>
    <Head :title="`Edit Article — ${article.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div class="flex items-center gap-3">
                    <Link :href="route('admin.articles.index')" class="text-xs text-gray-500 hover:text-gray-700">
                        ← Articles
                    </Link>
                    <span class="text-gray-300">/</span>
                    <h1 class="text-lg font-bold text-gray-900 truncate max-w-md">Edit: {{ article.title }}</h1>
                </div>

                <Link :href="route('articles.show', article.slug)" target="_blank" class="btn-secondary text-xs py-1.5 px-3">
                    View Public Article ↗
                </Link>
            </div>
        </template>

        <form @submit.prevent="submit" class="max-w-5xl space-y-8">
            <!-- Journal & Issue Placement -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <h2 class="text-base font-bold text-gray-900 border-b border-gray-100 pb-3">Journal & Placement</h2>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Journal *</label>
                        <select
                            v-model="form.journal_id"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option v-for="j in journals" :key="j.id" :value="j.id">
                                {{ j.title }}
                            </option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Assigned Issue</label>
                        <select
                            v-model="form.issue_id"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="">Unassigned (Ahead of Print)</option>
                            <option v-for="issue in availableIssues" :key="issue.id" :value="issue.id">
                                {{ issue.label }}
                            </option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Article Type *</label>
                        <select
                            v-model="form.article_type"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="original-research">Original Research</option>
                            <option value="review-article">Review Article</option>
                            <option value="case-report">Case Report</option>
                            <option value="short-communication">Short Communication</option>
                            <option value="methodology">Methodology Paper</option>
                            <option value="perspective">Perspective / Editorial</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Title & Metadata -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <h2 class="text-base font-bold text-gray-900 border-b border-gray-100 pb-3">Article Metadata</h2>

                <div class="space-y-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Article Title *</label>
                        <input
                            v-model="form.title"
                            type="text"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                        <p v-if="form.errors.title" class="text-xs text-rose-600 mt-1">{{ form.errors.title }}</p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">DOI</label>
                            <input
                                v-model="form.doi"
                                type="text"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Page Numbers</label>
                            <input
                                v-model="form.pages"
                                type="text"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Status</label>
                            <select
                                v-model="form.status"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option value="published">Published</option>
                                <option value="draft">Draft</option>
                                <option value="retracted">Retracted</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Abstract *</label>
                        <textarea
                            v-model="form.abstract"
                            rows="6"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <!-- Keywords -->
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Keywords</label>
                        <div class="flex gap-2 mb-2">
                            <input
                                v-model="keywordInput"
                                @keydown.enter.prevent="addKeyword"
                                type="text"
                                placeholder="Type keyword and press Add or Enter..."
                                class="flex-1 border border-gray-300 rounded-lg px-3 py-1.5 text-sm"
                            />
                            <button type="button" @click="addKeyword" class="btn-secondary text-xs py-1.5 px-3">Add</button>
                        </div>
                        <div class="flex flex-wrap gap-2">
                            <span
                                v-for="(kw, idx) in form.keywords"
                                :key="idx"
                                class="bg-navy-100 text-navy-800 text-xs px-2.5 py-1 rounded-full flex items-center gap-1.5"
                            >
                                {{ kw }}
                                <button type="button" @click="removeKeyword(idx)" class="text-navy-500 hover:text-navy-800">✕</button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Authors Repeater -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="flex items-center justify-between border-b border-gray-100 pb-3">
                    <h2 class="text-base font-bold text-gray-900">Authors & Affiliations</h2>
                    <button type="button" @click="addAuthor" class="btn-secondary text-xs py-1.5 px-3">
                        + Add Another Author
                    </button>
                </div>

                <div class="space-y-6">
                    <div
                        v-for="(author, aIndex) in form.authors"
                        :key="aIndex"
                        class="p-5 rounded-lg border border-gray-200 bg-gray-50/60 space-y-4"
                    >
                        <div class="flex items-center justify-between">
                            <span class="text-xs font-bold text-gray-700 uppercase tracking-wider">Author #{{ aIndex + 1 }}</span>
                            <button
                                v-if="form.authors.length > 1"
                                type="button"
                                @click="removeAuthor(aIndex)"
                                class="text-xs text-rose-600 hover:text-rose-800 font-medium"
                            >
                                Remove Author
                            </button>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                            <div>
                                <label class="block text-xs font-semibold text-gray-600 mb-1">First Name *</label>
                                <input v-model="author.first_name" type="text" required class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm" />
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-gray-600 mb-1">Last Name *</label>
                                <input v-model="author.last_name" type="text" required class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm" />
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-gray-600 mb-1">Email</label>
                                <input v-model="author.email" type="email" class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm" />
                            </div>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                            <div class="sm:col-span-2">
                                <label class="block text-xs font-semibold text-gray-600 mb-1">Affiliation / Institution</label>
                                <input v-model="author.affiliation" type="text" class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm" />
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-gray-600 mb-1">ORCID ID</label>
                                <input v-model="author.orcid" type="text" class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm font-mono" />
                            </div>
                        </div>

                        <div class="flex items-center gap-2">
                            <input v-model="author.is_corresponding" type="checkbox" :id="`edit-corr-${aIndex}`" class="rounded border-gray-300 text-navy-700 focus:ring-navy-700" />
                            <label :for="`edit-corr-${aIndex}`" class="text-xs font-medium text-gray-700">Corresponding Author</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- References List -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <h2 class="text-base font-bold text-gray-900 border-b border-gray-100 pb-3">References</h2>

                <div class="space-y-3">
                    <div class="flex gap-2">
                        <textarea
                            v-model="referenceInput"
                            rows="2"
                            placeholder="Paste reference text..."
                            class="flex-1 border border-gray-300 rounded-lg px-3 py-2 text-sm"
                        ></textarea>
                        <button type="button" @click="addReference" class="btn-secondary text-xs py-2 px-4 self-end">Add Reference</button>
                    </div>

                    <div v-if="form.references.length > 0" class="space-y-2 pt-2">
                        <div
                            v-for="(ref, rIdx) in form.references"
                            :key="rIdx"
                            class="p-3 bg-gray-50 border border-gray-200 rounded text-xs flex items-start justify-between gap-3"
                        >
                            <span><strong class="text-gray-500 mr-1">{{ rIdx + 1 }}.</strong> {{ ref }}</span>
                            <button type="button" @click="removeReference(rIdx)" class="text-rose-600 hover:text-rose-800 shrink-0">✕</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end gap-3">
                <Link :href="route('admin.articles.index')" class="btn-secondary text-xs py-2.5 px-5">
                    Cancel
                </Link>
                <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6">
                    {{ form.processing ? 'Saving...' : 'Update Article' }}
                </button>
            </div>
        </form>
    </AdminLayout>
</template>
