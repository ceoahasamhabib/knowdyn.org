<script setup>
import { ref, computed } from 'vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    journals: {
        type: Array,
        default: () => [],
    },
    initialJournalSlug: {
        type: String,
        default: null,
    },
    user: {
        type: Object,
        default: null,
    },
});

const page = usePage();
const currentUser = computed(() => page.props.auth?.user || props.user);

const currentStep = ref(1);

const matchedJournal = props.journals.find(j => j.slug === props.initialJournalSlug);

const form = useForm({
    journal_id: matchedJournal?.id || props.journals?.[0]?.id || '',
    article_type: 'original-research',
    title: '',
    abstract: '',
    cover_letter: '',
    funding: 'None reported.',
    conflict_of_interest: 'The authors declare no competing interests.',
    ethics_statement: 'Informed consent was obtained from all individual participants included in the study.',
    authors: [
        {
            first_name: currentUser.value?.name?.split(' ')[0] || '',
            last_name: currentUser.value?.name?.split(' ')[1] || '',
            email: currentUser.value?.email || '',
            affiliation: currentUser.value?.affiliation || '',
            country: currentUser.value?.country || '',
            orcid: currentUser.value?.orcid || '',
            is_corresponding: true,
            sort_order: 1,
        },
    ],
    manuscript_file: null,
    supplementary_file: null,
    agree_terms: false,
});

const selectedJournal = computed(() => {
    return props.journals.find(j => j.id == form.journal_id);
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

const nextStep = () => {
    if (currentStep.value < 5) {
        currentStep.value++;
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
};

const prevStep = () => {
    if (currentStep.value > 1) {
        currentStep.value--;
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
};

const submitManuscript = () => {
    form.post(route('manuscripts.store'), {
        onSuccess: () => {
            // Redirected to author submissions tracker
        },
    });
};
</script>

<template>
    <Head>
        <title>Submit Your Manuscript — Knowledge Dynamics</title>
        <meta name="description" content="Submit your peer-reviewed research manuscript to Knowledge Dynamics open-access journals." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-12 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-2">Author Gateway</p>
                    <h1 class="text-3xl md:text-4xl font-bold tracking-tight text-white">Manuscript Submission Portal</h1>
                    <p class="mt-3 text-navy-200 text-sm md:text-base leading-relaxed">
                        Submit your research paper for peer review across Knowledge Dynamics open-access journals. Follow our 5-step submission workflow.
                    </p>
                </div>
            </div>
        </section>

        <!-- Guest Prompt if not authenticated -->
        <div v-if="!currentUser" class="container-wide max-w-4xl mt-8">
            <div class="bg-amber-50 border border-amber-200 rounded-xl p-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                <div>
                    <h3 class="text-base font-bold text-amber-900">Authentication Required to Submit</h3>
                    <p class="text-xs text-amber-700 mt-1">Please log in or create a researcher account so your manuscript can be linked to your author profile and tracked through peer review.</p>
                </div>
                <div class="flex gap-2 shrink-0">
                    <Link :href="route('login')" class="btn-primary text-xs py-2 px-4">Log In</Link>
                    <Link :href="route('register')" class="btn-secondary text-xs py-2 px-4">Register</Link>
                </div>
            </div>
        </div>

        <!-- Submission Wizard Container -->
        <main class="container-wide max-w-4xl py-10">
            <!-- Step Indicators -->
            <div class="mb-10">
                <div class="flex items-center justify-between relative">
                    <div class="absolute left-0 top-1/2 -translate-y-1/2 h-0.5 bg-gray-200 w-full -z-0"></div>
                    <div
                        v-for="step in [
                            { num: 1, title: 'Journal & Type' },
                            { num: 2, title: 'Title & Abstract' },
                            { num: 3, title: 'Authors' },
                            { num: 4, title: 'Files & Declarations' },
                            { num: 5, title: 'Review & Submit' }
                        ]"
                        :key="step.num"
                        class="relative z-10 flex flex-col items-center gap-1.5 bg-white px-2"
                    >
                        <button
                            type="button"
                            @click="step.num < currentStep ? currentStep = step.num : null"
                            :class="[
                                'w-9 h-9 rounded-full flex items-center justify-center text-xs font-bold transition',
                                currentStep === step.num ? 'bg-navy-800 text-white ring-4 ring-navy-100' :
                                currentStep > step.num ? 'bg-emerald-600 text-white' : 'bg-gray-100 text-gray-400'
                            ]"
                        >
                            <span v-if="currentStep > step.num">✓</span>
                            <span v-else>{{ step.num }}</span>
                        </button>
                        <span class="text-[11px] font-medium hidden sm:inline" :class="currentStep === step.num ? 'text-navy-900 font-bold' : 'text-gray-500'">
                            {{ step.title }}
                        </span>
                    </div>
                </div>
            </div>

            <form @submit.prevent="submitManuscript" class="space-y-8">
                <!-- STEP 1: Journal & Article Type -->
                <div v-show="currentStep === 1" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-4">
                        <h2 class="text-lg font-bold text-gray-900">Step 1: Select Target Journal & Article Type</h2>
                        <p class="text-xs text-gray-500 mt-0.5">Choose the appropriate journal and category matching your manuscript scope.</p>
                    </div>

                    <div class="space-y-5">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Target Journal *</label>
                            <select
                                v-model="form.journal_id"
                                required
                                class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option v-for="j in journals" :key="j.id" :value="j.id">
                                    {{ j.title }} (ISSN: {{ j.issn_online || 'Online' }})
                                </option>
                            </select>
                        </div>

                        <!-- Journal Policies Callout -->
                        <div v-if="selectedJournal?.settings" class="bg-navy-50/70 border border-navy-100 rounded-lg p-4 text-xs text-navy-900 space-y-1.5">
                            <div class="font-bold">Peer Review Model: {{ (selectedJournal.settings.review_model || 'Double Blind').replace('_', ' ') }}</div>
                            <p class="text-navy-700">{{ selectedJournal.settings.peer_review_process }}</p>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Article Category / Type *</label>
                            <select
                                v-model="form.article_type"
                                required
                                class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option value="original-research">Original Research</option>
                                <option value="review-article">Review Article / Systematic Review</option>
                                <option value="case-report">Case Report</option>
                                <option value="short-communication">Short Communication</option>
                                <option value="methodology">Methodology & Protocols</option>
                                <option value="perspective">Perspective / Policy Brief</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex justify-end pt-4">
                        <button type="button" @click="nextStep" class="btn-primary text-xs py-2 px-6">
                            Next: Title & Abstract →
                        </button>
                    </div>
                </div>

                <!-- STEP 2: Title & Abstract -->
                <div v-show="currentStep === 2" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-4">
                        <h2 class="text-lg font-bold text-gray-900">Step 2: Manuscript Title & Abstract</h2>
                        <p class="text-xs text-gray-500 mt-0.5">Enter the full title and structured abstract of your manuscript.</p>
                    </div>

                    <div class="space-y-5">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Manuscript Full Title *</label>
                            <input
                                v-model="form.title"
                                type="text"
                                required
                                placeholder="e.g. Longitudinal Assessment of Clinical Biomarkers in..."
                                class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                            <p v-if="form.errors.title" class="text-xs text-rose-600 mt-1">{{ form.errors.title }}</p>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Abstract *</label>
                            <textarea
                                v-model="form.abstract"
                                rows="7"
                                required
                                placeholder="Provide a structured abstract (Background, Methods, Results, Conclusion)..."
                                class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                            <p class="text-[11px] text-gray-400 mt-1">Recommended length: 200 - 350 words.</p>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Cover Letter to the Editor</label>
                            <textarea
                                v-model="form.cover_letter"
                                rows="4"
                                placeholder="Explain why this manuscript is suitable for the journal and declare novelty..."
                                class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            ></textarea>
                        </div>
                    </div>

                    <div class="flex justify-between pt-4">
                        <button type="button" @click="prevStep" class="btn-secondary text-xs py-2 px-5">
                            ← Back
                        </button>
                        <button type="button" @click="nextStep" class="btn-primary text-xs py-2 px-6">
                            Next: Authors & Affiliations →
                        </button>
                    </div>
                </div>

                <!-- STEP 3: Authors & Affiliations -->
                <div v-show="currentStep === 3" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="flex items-center justify-between border-b border-gray-100 pb-4">
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Step 3: Authors & Affiliations</h2>
                            <p class="text-xs text-gray-500 mt-0.5">List all contributing co-authors in proper publication sequence.</p>
                        </div>
                        <button type="button" @click="addAuthor" class="btn-secondary text-xs py-1.5 px-3">
                            + Add Co-Author
                        </button>
                    </div>

                    <div class="space-y-6">
                        <div
                            v-for="(author, aIdx) in form.authors"
                            :key="aIdx"
                            class="p-5 rounded-lg border border-gray-200 bg-gray-50/70 space-y-4"
                        >
                            <div class="flex items-center justify-between">
                                <span class="text-xs font-bold text-gray-700 uppercase tracking-wider">Author #{{ aIdx + 1 }}</span>
                                <button
                                    v-if="form.authors.length > 1"
                                    type="button"
                                    @click="removeAuthor(aIdx)"
                                    class="text-xs text-rose-600 hover:text-rose-800 font-medium"
                                >
                                    Remove
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
                                    <label class="block text-xs font-semibold text-gray-600 mb-1">Affiliation / University / Hospital</label>
                                    <input v-model="author.affiliation" type="text" placeholder="e.g. Department of Medicine, University of Oxford" class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm" />
                                </div>
                                <div>
                                    <label class="block text-xs font-semibold text-gray-600 mb-1">Country</label>
                                    <input v-model="author.country" type="text" placeholder="e.g. United Kingdom" class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm" />
                                </div>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 items-center">
                                <div>
                                    <label class="block text-xs font-semibold text-gray-600 mb-1">ORCID ID (0000-0000-0000-0000)</label>
                                    <input v-model="author.orcid" type="text" placeholder="0000-0002-1825-0097" class="w-full bg-white border border-gray-300 rounded px-2.5 py-1.5 text-sm font-mono" />
                                </div>
                                <div class="flex items-center gap-2 pt-4">
                                    <input v-model="author.is_corresponding" type="checkbox" :id="`sub-corr-${aIdx}`" class="rounded border-gray-300 text-navy-700 focus:ring-navy-700" />
                                    <label :for="`sub-corr-${aIdx}`" class="text-xs font-medium text-gray-700">Designated Corresponding Author</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-between pt-4">
                        <button type="button" @click="prevStep" class="btn-secondary text-xs py-2 px-5">
                            ← Back
                        </button>
                        <button type="button" @click="nextStep" class="btn-primary text-xs py-2 px-6">
                            Next: Files & Ethics →
                        </button>
                    </div>
                </div>

                <!-- STEP 4: Files Upload & Ethical Declarations -->
                <div v-show="currentStep === 4" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-4">
                        <h2 class="text-lg font-bold text-gray-900">Step 4: Manuscript Files & Ethical Declarations</h2>
                        <p class="text-xs text-gray-500 mt-0.5">Upload your manuscript file and provide required compliance statements.</p>
                    </div>

                    <!-- File Uploads -->
                    <div class="space-y-4">
                        <div class="p-4 border-2 border-dashed border-gray-300 rounded-lg text-center hover:border-navy-500 transition">
                            <svg class="mx-auto h-8 w-8 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5m-13.5-9L12 3m0 0l4.5 4.5M12 3v13.5" />
                            </svg>
                            <label class="block mt-2 text-xs font-bold text-navy-800 cursor-pointer">
                                <span>Upload Primary Manuscript File (PDF, DOCX, DOC)</span>
                                <input
                                    type="file"
                                    @input="form.manuscript_file = $event.target.files[0]"
                                    class="hidden"
                                />
                            </label>
                            <p v-if="form.manuscript_file" class="text-xs text-emerald-600 font-bold mt-1">
                                Selected: {{ form.manuscript_file.name }} ({{ (form.manuscript_file.size / 1024 / 1024).toFixed(2) }} MB)
                            </p>
                            <p v-else class="text-[11px] text-gray-400 mt-1">Single file containing text, figures and tables (max 20MB).</p>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Funding Statement</label>
                            <textarea
                                v-model="form.funding"
                                rows="2"
                                placeholder="State any grant or funding agency support..."
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                            ></textarea>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Conflict of Interest Declaration</label>
                            <textarea
                                v-model="form.conflict_of_interest"
                                rows="2"
                                placeholder="Disclose any financial or non-financial relationships..."
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                            ></textarea>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Ethics & Human/Animal Subjects Statement</label>
                            <textarea
                                v-model="form.ethics_statement"
                                rows="2"
                                placeholder="Institutional review board (IRB) approval number or statement..."
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"
                            ></textarea>
                        </div>
                    </div>

                    <div class="flex justify-between pt-4">
                        <button type="button" @click="prevStep" class="btn-secondary text-xs py-2 px-5">
                            ← Back
                        </button>
                        <button type="button" @click="nextStep" class="btn-primary text-xs py-2 px-6">
                            Next: Final Review →
                        </button>
                    </div>
                </div>

                <!-- STEP 5: Final Review & Submission Confirmation -->
                <div v-show="currentStep === 5" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-4">
                        <h2 class="text-lg font-bold text-gray-900">Step 5: Review & Final Submission</h2>
                        <p class="text-xs text-gray-500 mt-0.5">Please review the details below before submitting to the editorial office.</p>
                    </div>

                    <div class="space-y-4 text-xs">
                        <div class="bg-gray-50 p-4 rounded-lg border border-gray-200 space-y-2">
                            <div><strong class="text-gray-700">Target Journal:</strong> {{ selectedJournal?.title }}</div>
                            <div><strong class="text-gray-700">Article Type:</strong> {{ form.article_type }}</div>
                            <div><strong class="text-gray-700">Manuscript Title:</strong> {{ form.title }}</div>
                        </div>

                        <div class="bg-gray-50 p-4 rounded-lg border border-gray-200 space-y-1">
                            <strong class="text-gray-700 block mb-1">Authors ({{ form.authors.length }}):</strong>
                            <div v-for="(author, idx) in form.authors" :key="idx" class="text-gray-600">
                                {{ idx + 1 }}. {{ author.first_name }} {{ author.last_name }} — {{ author.affiliation || 'No institution listed' }}
                                <span v-if="author.is_corresponding" class="text-academic-700 font-bold">(Corresponding)</span>
                            </div>
                        </div>

                        <!-- Agreement Checkbox -->
                        <div class="pt-3 flex items-start gap-2.5">
                            <input
                                v-model="form.agree_terms"
                                type="checkbox"
                                id="agree_terms"
                                required
                                class="mt-0.5 rounded border-gray-300 text-navy-700 focus:ring-navy-700"
                            />
                            <label for="agree_terms" class="text-xs text-gray-700 leading-relaxed">
                                I confirm that this manuscript is original, has not been published elsewhere, is not under consideration by another journal, and all co-authors have approved this submission in accordance with COPE publication ethics.
                            </label>
                        </div>
                    </div>

                    <div class="flex justify-between pt-4 border-t border-gray-100">
                        <button type="button" @click="prevStep" class="btn-secondary text-xs py-2 px-5">
                            ← Back
                        </button>
                        <button
                            type="submit"
                            :disabled="form.processing || !form.agree_terms"
                            class="btn-primary text-xs py-2.5 px-8 shadow-sm"
                        >
                            {{ form.processing ? 'Submitting Manuscript...' : 'Confirm & Submit Manuscript' }}
                        </button>
                    </div>
                </div>
            </form>
        </main>
    </PublicLayout>
</template>
