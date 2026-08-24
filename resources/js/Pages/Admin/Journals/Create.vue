<script setup>
import { ref } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';

const activeTab = ref('identity');

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
    contact_email: 'editor@knowdyn.org',
    contact_phone: '',
    website_url: '',
    submission_url: '',
    citescore: '3.5',
    impact_factor: '2.4',
    acceptance_rate: 28,
    review_time_days: 18,
    publication_time_days: 7,
    apc_amount: '$450 USD',
    disciplines_input: 'Clinical Medicine, Public Health, Biomedical Sciences',
    indexing_sources: ['Crossref (DOI Minting)', 'Google Scholar', 'DOAJ (Open Access)', 'COPE (Publication Ethics)', 'Portico Digital Preservation'],
    special_issue_title: '',
    special_issue_deadline: '',
    special_issue_description: '',
    settings: {
        review_model: 'double_blind',
        peer_review_process: 'All submitted manuscripts undergo a double-blind peer review evaluation by at least two independent expert reviewers with average first decision within 18 days.',
        publication_ethics: 'Knowledge Dynamics strictly adheres to the Committee on Publication Ethics (COPE) code of conduct and international research integrity standards.',
        author_guidelines: 'Manuscripts must be original, written in clear academic English, and formatted in accordance with the KD Vancouver/APA reference style.',
        open_access_policy: 'This journal provides immediate open access to all published content under the Creative Commons Attribution 4.0 (CC BY 4.0) license.',
        copyright_notice: 'Authors retain copyright and grant the journal the right of first publication.',
        author_fees: 'Standard APC is $450 USD. Full fee waivers are provided for authors from developing economies.',
    },
});

const availableIndexingPartners = [
    'Crossref (DOI Minting)',
    'Google Scholar',
    'DOAJ (Open Access)',
    'PubMed Central Ready',
    'Scopus Indexed',
    'COPE (Publication Ethics)',
    'Portico Digital Preservation',
    'SHERPA/RoMEO Archiving',
];

const toggleIndexingPartner = (partner) => {
    const idx = form.indexing_sources.indexOf(partner);
    if (idx > -1) {
        form.indexing_sources.splice(idx, 1);
    } else {
        form.indexing_sources.push(partner);
    }
};

const submit = () => {
    const disciplinesArray = form.disciplines_input
        ? form.disciplines_input.split(',').map(s => s.trim()).filter(Boolean)
        : [];

    form.transform((data) => ({
        ...data,
        disciplines: disciplinesArray,
    })).post(route('admin.journals.store'));
};
</script>

<template>
    <Head title="Add New Academic Journal — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.journals.index')" class="text-xs text-indigo-600 hover:underline font-bold">
                    ← Back to Journals Registry
                </Link>
                <span class="text-slate-300">/</span>
                <h1 class="text-2xl font-black text-slate-900 tracking-tight flex items-center gap-2">
                    <span>➕</span> Register New Academic Journal
                </h1>
            </div>
        </template>

        <div class="max-w-6xl mx-auto space-y-6 pb-20">
            <!-- Navigation Tabs -->
            <div class="flex items-center gap-1 bg-slate-200/70 p-1.5 rounded-2xl overflow-x-auto">
                <button
                    type="button"
                    @click="activeTab = 'identity'"
                    class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                    :class="activeTab === 'identity' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                >
                    <span>🏛️</span> Identity & Scope
                </button>
                <button
                    type="button"
                    @click="activeTab = 'website'"
                    class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                    :class="activeTab === 'website' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                >
                    <span>🌐</span> Dedicated Website & Links
                </button>
                <button
                    type="button"
                    @click="activeTab = 'metrics'"
                    class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                    :class="activeTab === 'metrics' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                >
                    <span>⚡</span> Performance Metrics & APC
                </button>
                <button
                    type="button"
                    @click="activeTab = 'indexing'"
                    class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                    :class="activeTab === 'indexing' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                >
                    <span>🔬</span> Disciplines & Indexing
                </button>
                <button
                    type="button"
                    @click="activeTab = 'policies'"
                    class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                    :class="activeTab === 'policies' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                >
                    <span>📜</span> Policies & Peer Review
                </button>
            </div>

            <form @submit.prevent="submit" class="space-y-6">
                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 1: IDENTITY & SCOPE                                     -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'identity'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>🏛️</span> Basic Identity & Scholarly Scope
                        </h2>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Journal Full Title *</label>
                            <input
                                v-model="form.title"
                                type="text"
                                required
                                placeholder="e.g. Journal of Applied Health & Clinical Informatics"
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-sm font-semibold focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                            <p v-if="form.errors.title" class="text-xs text-rose-600 mt-1">{{ form.errors.title }}</p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Short Title / ISO Abbreviation</label>
                            <input
                                v-model="form.short_title"
                                type="text"
                                placeholder="e.g. J. Appl. Health"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Custom Slug (Optional)</label>
                            <input
                                v-model="form.slug"
                                type="text"
                                placeholder="auto-generated-from-title"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">ISSN (Online)</label>
                            <input
                                v-model="form.issn_online"
                                type="text"
                                placeholder="e.g. 3006-5518"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">ISSN (Print)</label>
                            <input
                                v-model="form.issn_print"
                                type="text"
                                placeholder="e.g. 3006-550X"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Publication Frequency</label>
                            <select
                                v-model="form.publication_frequency"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="Monthly">Monthly</option>
                                <option value="Bi-monthly">Bi-monthly</option>
                                <option value="Quarterly">Quarterly</option>
                                <option value="Bi-annual">Bi-annual</option>
                                <option value="Continuous">Continuous Publication (Rapid)</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Publication Status *</label>
                            <select
                                v-model="form.status"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-bold focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="active">Active / Published (Live to Public)</option>
                                <option value="inactive">Inactive / Draft (Hidden from Public)</option>
                                <option value="archived">Archived (Historical Archive)</option>
                            </select>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Short Overview / Description</label>
                            <textarea
                                v-model="form.description"
                                rows="3"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="Enter an authoritative overview of this journal..."
                            ></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Detailed Aims & Scope</label>
                            <textarea
                                v-model="form.aims_and_scope"
                                rows="5"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="Detail research topics, methodology expectations, and scholarly domain..."
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 2: DEDICATED WEBSITE & SUBMISSION LINKS                 -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'website'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>🌐</span> Dedicated Journal Website & External Portals
                        </h2>
                    </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                Dedicated Journal Website URL (External / Subsite)
                            </label>
                            <input
                                v-model="form.website_url"
                                type="url"
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. https://kdpub.com/journals/my-journal or https://myjournal.org"
                            />
                            <p class="text-[11px] text-slate-400 mt-1">Leave blank to use the default on-platform portal.</p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                Custom Submission Portal URL (Optional)
                            </label>
                            <input
                                v-model="form.submission_url"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. /submit?journal=my-journal"
                            />
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 3: PERFORMANCE METRICS & APC                            -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'metrics'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>⚡</span> Performance Metrics & APC Charges
                        </h2>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">CiteScore (Simulated/Official)</label>
                            <input
                                v-model="form.citescore"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. 3.5"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Impact Factor</label>
                            <input
                                v-model="form.impact_factor"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. 2.4"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Acceptance Rate (%)</label>
                            <input
                                v-model="form.acceptance_rate"
                                type="number"
                                min="1"
                                max="100"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Review Time (Days)</label>
                            <input
                                v-model="form.review_time_days"
                                type="number"
                                min="1"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Online Publication Time (Days)</label>
                            <input
                                v-model="form.publication_time_days"
                                type="number"
                                min="1"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Article Processing Charge (APC)</label>
                            <input
                                v-model="form.apc_amount"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. $450 USD"
                            />
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 4: DISCIPLINES & INDEXING                               -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'indexing'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>🔬</span> Subject Disciplines & Indexing Badges
                        </h2>
                    </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                Subject Disciplines (Comma Separated)
                            </label>
                            <input
                                v-model="form.disciplines_input"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. Health Sciences, Clinical Medicine, Public Health"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-3">
                                Indexing & Preservation Partners
                            </label>
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                                <div
                                    v-for="partner in availableIndexingPartners"
                                    :key="partner"
                                    @click="toggleIndexingPartner(partner)"
                                    class="p-3.5 rounded-xl border cursor-pointer transition flex items-center gap-2.5"
                                    :class="form.indexing_sources.includes(partner) ? 'bg-indigo-50 border-indigo-400 text-indigo-900 font-bold shadow-xs' : 'border-slate-200 hover:bg-slate-50 text-slate-600'"
                                >
                                    <span class="w-4 h-4 rounded-md flex items-center justify-center text-[10px]" :class="form.indexing_sources.includes(partner) ? 'bg-indigo-600 text-white' : 'border border-slate-300'">
                                        {{ form.indexing_sources.includes(partner) ? '✓' : '' }}
                                    </span>
                                    <span class="text-xs">{{ partner }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 5: POLICIES & PEER REVIEW                               -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'policies'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>📜</span> Peer Review Process, Ethics & Guidelines
                        </h2>
                    </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Peer Review Model</label>
                            <select
                                v-model="form.settings.review_model"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="double_blind">Double Blind (Reviewer & Author Anonymous)</option>
                                <option value="single_blind">Single Blind (Reviewer Anonymous)</option>
                                <option value="open_review">Open Peer Review (Public Reports)</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Peer Review Workflow Statement</label>
                            <textarea
                                v-model="form.settings.peer_review_process"
                                rows="3"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            ></textarea>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Author Preparation Guidelines</label>
                            <textarea
                                v-model="form.settings.author_guidelines"
                                rows="4"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- Sticky Bottom Action Bar -->
                <div class="sticky bottom-4 z-30 bg-slate-900/90 backdrop-blur-md rounded-2xl border border-slate-800 px-6 py-4 flex items-center justify-between shadow-2xl text-white">
                    <span class="text-xs font-medium text-slate-300">
                        Fill all relevant academic metadata and register the journal.
                    </span>

                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="px-8 py-3 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-black text-xs uppercase tracking-wider shadow-lg shadow-indigo-500/25 flex items-center gap-2 transition duration-200 disabled:opacity-50 cursor-pointer"
                    >
                        <span v-if="form.processing" class="animate-spin">🌀</span>
                        <span v-else>➕</span>
                        <span>{{ form.processing ? 'Creating Journal...' : 'Register & Create Journal' }}</span>
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
