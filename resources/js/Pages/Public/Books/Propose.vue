<script setup>
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const page = usePage();
const user = page.props.auth?.user;

const form = useForm({
    author_name: user?.name || '',
    author_email: user?.email || '',
    institution: '',
    book_title: '',
    subject_discipline: 'Biomedical & Health Sciences',
    estimated_word_count: '60,000 – 80,000 words',
    target_completion_date: '2027-Q2',
    synopsis_and_toc: '',
});

const submitProposal = () => {
    form.post(route('books.propose.store'), {
        onSuccess: () => {
            form.reset('book_title', 'synopsis_and_toc');
        },
    });
};
</script>

<template>
    <Head>
        <title>Propose a Book or Monograph — Knowledge Dynamics</title>
        <meta name="description" content="Submit your academic book, scholarly monograph, or edited volume proposal to Knowledge Dynamics Press." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <Link :href="route('books.index')" class="text-xs text-academic-300 hover:text-white font-semibold inline-flex items-center gap-1 mb-3">
                        ← Back to Books Catalog
                    </Link>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white">Propose an Academic Book</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Partner with Knowledge Dynamics to publish your research monograph, authored text, or edited reference volume with global indexing and optional Open Access.
                    </p>
                </div>
            </div>
        </section>

        <!-- Form Section -->
        <section class="section bg-gray-50/60">
            <div class="container-wide max-w-4xl">
                <form @submit.prevent="submitProposal" class="bg-white rounded-xl border border-gray-200 p-6 md:p-10 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-4">
                        <h2 class="text-xl font-bold text-gray-900">Book / Monograph Proposal Form</h2>
                        <p class="text-xs text-gray-500 mt-1">Please provide comprehensive information regarding your proposed manuscript for editorial board assessment.</p>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Lead Author / Editor Name *</label>
                            <input
                                v-model="form.author_name"
                                type="text"
                                required
                                placeholder="Prof. / Dr. Full Name"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Institutional Email *</label>
                            <input
                                v-model="form.author_email"
                                type="email"
                                required
                                placeholder="academic@university.edu"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div class="sm:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Primary Institutional Affiliation *</label>
                            <input
                                v-model="form.institution"
                                type="text"
                                required
                                placeholder="Department, Faculty, University Name, Country"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div class="sm:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Proposed Book Title & Subtitle *</label>
                            <input
                                v-model="form.book_title"
                                type="text"
                                required
                                placeholder="e.g. Modern Epistemologies of Health and Public Policy"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Subject Area / Discipline *</label>
                            <select
                                v-model="form.subject_discipline"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option value="Biomedical & Health Sciences">Biomedical & Health Sciences</option>
                                <option value="Food Science & Nutrition">Food Science & Nutrition</option>
                                <option value="Asian Studies & Regional History">Asian Studies & Regional History</option>
                                <option value="Accounting, Business & Finance">Accounting, Business & Finance</option>
                                <option value="Comparative Religion & Theology">Comparative Religion & Theology</option>
                                <option value="Applied Social Sciences & Law">Applied Social Sciences & Law</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Estimated Length</label>
                            <input
                                v-model="form.estimated_word_count"
                                type="text"
                                placeholder="e.g. 70,000 words (8 chapters)"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Book Synopsis, Target Audience & Table of Contents *</label>
                        <textarea
                            v-model="form.synopsis_and_toc"
                            rows="6"
                            required
                            placeholder="Detail the academic contribution, target readership (researchers, graduate students, practitioners), competitive texts, and preliminary chapter outline..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="flex justify-end pt-4 border-t border-gray-100">
                        <button
                            type="submit"
                            :disabled="form.processing"
                            class="btn-primary text-xs py-2.5 px-8 shadow-sm"
                        >
                            {{ form.processing ? 'Submitting Proposal...' : 'Submit Book Proposal' }}
                        </button>
                    </div>
                </form>
            </div>
        </section>
    </PublicLayout>
</template>
