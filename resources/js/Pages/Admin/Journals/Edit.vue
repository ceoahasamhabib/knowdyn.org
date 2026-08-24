<script setup>
import { ref } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
});

const activeTab = ref('identity');

// Pre-populate disciplines and indexing sources
const rawDisciplines = Array.isArray(props.journal.disciplines)
    ? props.journal.disciplines.join(', ')
    : (props.journal.disciplines || '');

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
    contact_phone: props.journal.contact_phone || '',
    website_url: props.journal.website_url || '',
    submission_url: props.journal.submission_url || '',
    citescore: props.journal.citescore || '3.5',
    impact_factor: props.journal.impact_factor || '2.4',
    acceptance_rate: props.journal.acceptance_rate ?? 28,
    review_time_days: props.journal.review_time_days ?? 18,
    publication_time_days: props.journal.publication_time_days ?? 7,
    apc_amount: props.journal.apc_amount || '$450 USD',
    disciplines_input: rawDisciplines,
    indexing_sources: Array.isArray(props.journal.indexing_sources)
        ? props.journal.indexing_sources
        : ['Crossref (DOI Minting)', 'Google Scholar', 'DOAJ (Open Access)', 'COPE (Publication Ethics)', 'Portico Digital Preservation'],
    special_issue_title: props.journal.special_issue_title || '',
    special_issue_deadline: props.journal.special_issue_deadline || '',
    special_issue_description: props.journal.special_issue_description || '',
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
    // Convert disciplines_input to array
    const disciplinesArray = form.disciplines_input
        ? form.disciplines_input.split(',').map(s => s.trim()).filter(Boolean)
        : [];

    form.transform((data) => ({
        ...data,
        disciplines: disciplinesArray,
    })).put(route('admin.journals.update', props.journal.id));
};
</script>

<template>
    <Head :title="`Edit Journal — ${journal.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 w-full">
                <div>
                    <div class="flex items-center gap-2 mb-1">
                        <Link :href="route('admin.journals.index')" class="text-xs text-indigo-600 hover:underline font-bold">
                            ← Journals Registry
                        </Link>
                        <span class="text-slate-300">/</span>
                        <span class="text-xs text-slate-500 font-medium font-mono">{{ journal.slug }}</span>
                    </div>
                    <h1 class="text-2xl font-black text-slate-900 tracking-tight flex items-center gap-2">
                        <span>✏️</span> Edit Journal: {{ journal.title }}
                    </h1>
                </div>

                <!-- Action shortcuts -->
                <div class="flex flex-wrap items-center gap-2">
                    <Link :href="route('admin.journals.volumes.index', journal.id)" class="px-3.5 py-2 rounded-xl bg-white border border-slate-200 hover:bg-slate-50 text-slate-700 text-xs font-bold transition shadow-xs">
                        📂 Volumes & Issues
                    </Link>
                    <Link :href="route('admin.journals.editorial_board.index', journal.id)" class="px-3.5 py-2 rounded-xl bg-white border border-slate-200 hover:bg-slate-50 text-slate-700 text-xs font-bold transition shadow-xs">
                        👥 Editorial Board
                    </Link>
                    <a :href="journal.effective_website_url" target="_blank" class="px-3.5 py-2 rounded-xl bg-indigo-50 border border-indigo-200 hover:bg-indigo-100 text-indigo-700 text-xs font-bold transition shadow-xs flex items-center gap-1">
                        <span>🌐 View Website</span>
                        <span class="font-mono text-[10px]">↗</span>
                    </a>
                </div>
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
                    @click="activeTab = 'cfp'"
                    class="px-4 py-2 rounded-xl text-xs font-bold transition flex items-center gap-2 whitespace-nowrap"
                    :class="activeTab === 'cfp' ? 'bg-white text-indigo-700 shadow-sm' : 'text-slate-600 hover:text-slate-900'"
                >
                    <span>📢</span> Call For Papers (CFP)
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
                            <span>🏛️</span> Journal Identity & Scholarly Scope
                        </h2>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Journal Full Title *</label>
                            <input
                                v-model="form.title"
                                type="text"
                                required
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-sm font-semibold focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Short Title / ISO Abbreviation</label>
                            <input
                                v-model="form.short_title"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. Health Dyn."
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">URL Slug *</label>
                            <input
                                v-model="form.slug"
                                type="text"
                                required
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">ISSN (Online)</label>
                            <input
                                v-model="form.issn_online"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="XXXX-XXXX"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">ISSN (Print)</label>
                            <input
                                v-model="form.issn_print"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="XXXX-XXXX"
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
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Established Year</label>
                            <input
                                v-model="form.established_year"
                                type="number"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Publication Status *</label>
                            <select
                                v-model="form.status"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-bold focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="active">Active / Published (Live to Public)</option>
                                <option value="inactive">Inactive / Draft (Hidden from Public)</option>
                                <option value="archived">Archived (Closed for New Submissions)</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Editorial Contact Email</label>
                            <input
                                v-model="form.contact_email"
                                type="email"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Short Journal Overview / Summary</label>
                            <textarea
                                v-model="form.description"
                                rows="3"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            ></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Detailed Aims & Scholarly Scope</label>
                            <textarea
                                v-model="form.aims_and_scope"
                                rows="6"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
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
                        <p class="text-xs text-slate-500 mt-0.5">Configure custom external domains or subsite URLs for this journal.</p>
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
                                placeholder="e.g. https://kdpub.com/journals/health-dynamics or https://healthdynamics.org"
                            />
                            <p class="text-[11px] text-slate-400 mt-1.5">
                                If left blank, the "Visit Journal Website" button will automatically route to the built-in journal portal (<code class="bg-slate-100 px-1 py-0.5 rounded text-indigo-700">/journals/{{ form.slug || 'slug' }}</code>).
                            </p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">
                                Custom Manuscript Submission Portal URL (Optional)
                            </label>
                            <input
                                v-model="form.submission_url"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-3 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. /submit?journal=health-dynamics or https://manuscripts.external-journal.org"
                            />
                            <p class="text-[11px] text-slate-400 mt-1.5">
                                If left blank, defaults to the built-in manuscript submission pipeline with this journal preselected.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 3: PERFORMANCE METRICS & APC                            -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'metrics'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>⚡</span> Academic Performance Metrics & Article Processing Charges
                        </h2>
                        <p class="text-xs text-slate-500 mt-0.5">Displayed prominently in the Journal Quick Stats bar and public index catalog.</p>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">CiteScore (Simulated/Official)</label>
                            <input
                                v-model="form.citescore"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. 3.8"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Impact Factor</label>
                            <input
                                v-model="form.impact_factor"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. 2.9"
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
                                placeholder="e.g. 28"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Review Time / First Decision (Days)</label>
                            <input
                                v-model="form.review_time_days"
                                type="number"
                                min="1"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. 18"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Acceptance to Online Release (Days)</label>
                            <input
                                v-model="form.publication_time_days"
                                type="number"
                                min="1"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. 7"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Article Processing Charge (APC)</label>
                            <input
                                v-model="form.apc_amount"
                                type="text"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="e.g. $450 USD or Free / Fully Sponsored"
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
                                placeholder="e.g. Clinical Medicine, Public Health, Biomedical Engineering, Health Systems"
                            />
                            <p class="text-[11px] text-slate-400 mt-1">Used for catalog filtering and subject area tagging.</p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-3">
                                Verified Indexing & Abstracting Partners
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
                <!-- TAB 5: CALL FOR PAPERS & SPECIAL ISSUES                     -->
                <!-- ═══════════════════════════════════════════════════════════ -->
                <div v-show="activeTab === 'cfp'" class="bg-white rounded-3xl border border-slate-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-slate-100 pb-4">
                        <h2 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>📢</span> Call For Papers (CFP) & Active Special Issue
                        </h2>
                        <p class="text-xs text-slate-500 mt-0.5">Highlights an active thematic special issue on the journal homepage.</p>
                    </div>

                    <div class="space-y-6">
                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
                            <div class="sm:col-span-2">
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Special Issue Title</label>
                                <input
                                    v-model="form.special_issue_title"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    placeholder="e.g. Special Issue: AI-Driven Precision Diagnostics"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Submission Deadline</label>
                                <input
                                    v-model="form.special_issue_deadline"
                                    type="date"
                                    class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-mono focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Special Issue Description & Scope</label>
                            <textarea
                                v-model="form.special_issue_description"
                                rows="3"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                placeholder="Describe topic scope, guest editors, and special publication conditions..."
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════ -->
                <!-- TAB 6: POLICIES & PEER REVIEW                               -->
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

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Publication Ethics & COPE Compliance</label>
                            <textarea
                                v-model="form.settings.publication_ethics"
                                rows="3"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs leading-relaxed focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            ></textarea>
                        </div>
                    </div>
                </div>

                <!-- Sticky Bottom Action Bar -->
                <div class="sticky bottom-4 z-30 bg-slate-900/90 backdrop-blur-md rounded-2xl border border-slate-800 px-6 py-4 flex items-center justify-between shadow-2xl text-white">
                    <div class="flex items-center gap-3">
                        <span class="w-2.5 h-2.5 rounded-full" :class="form.status === 'active' ? 'bg-emerald-400 animate-pulse' : 'bg-amber-400'"></span>
                        <span class="text-xs font-medium text-slate-300 hidden sm:inline">
                            Status: <strong class="text-white uppercase">{{ form.status }}</strong>
                        </span>
                    </div>

                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="px-8 py-3 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-black text-xs uppercase tracking-wider shadow-lg shadow-indigo-500/25 flex items-center gap-2 transition duration-200 disabled:opacity-50 cursor-pointer"
                    >
                        <span v-if="form.processing" class="animate-spin">🌀</span>
                        <span v-else>💾</span>
                        <span>{{ form.processing ? 'Saving...' : 'Save Journal & Academic Settings' }}</span>
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
