<script setup>
import { computed } from 'vue';
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    type: {
        type: String,
        default: 'authors', // 'authors', 'editors', 'reviewers', 'editorial-policies'
    },
});

const title = computed(() => {
    switch (props.type) {
        case 'editors': return 'Editorial Board & Editor Guidelines';
        case 'reviewers': return 'Peer Reviewer Guidelines & Code of Conduct';
        case 'editorial-policies': return 'Publication Ethics & Editorial Policies';
        default: return 'Author Guidelines & Submission Instructions';
    }
});
</script>

<template>
    <Head>
        <title>{{ title }} — Knowledge Dynamics</title>
        <meta name="description" content="Official guidelines, ethical policies, and workflow standards for authors, editors, and peer reviewers across Knowledge Dynamics journals." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Publishing Standards & Ethics</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">{{ title }}</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Knowledge Dynamics adheres strictly to the Committee on Publication Ethics (COPE) Core Practices and international academic publishing integrity principles.
                    </p>
                    <div class="mt-6 flex flex-wrap gap-2">
                        <Link
                            :href="route('guidelines.show', 'authors')"
                            :class="['text-xs py-2 px-4 rounded-lg font-semibold transition', type === 'authors' ? 'bg-white text-navy-800' : 'bg-navy-700 text-navy-200 hover:text-white']"
                        >
                            Author Guidelines
                        </Link>
                        <Link
                            :href="route('guidelines.show', 'editorial-policies')"
                            :class="['text-xs py-2 px-4 rounded-lg font-semibold transition', type === 'editorial-policies' ? 'bg-white text-navy-800' : 'bg-navy-700 text-navy-200 hover:text-white']"
                        >
                            Editorial Policies
                        </Link>
                        <Link
                            :href="route('guidelines.show', 'reviewers')"
                            :class="['text-xs py-2 px-4 rounded-lg font-semibold transition', type === 'reviewers' ? 'bg-white text-navy-800' : 'bg-navy-700 text-navy-200 hover:text-white']"
                        >
                            Reviewer Guidelines
                        </Link>
                        <Link
                            :href="route('guidelines.show', 'editors')"
                            :class="['text-xs py-2 px-4 rounded-lg font-semibold transition', type === 'editors' ? 'bg-white text-navy-800' : 'bg-navy-700 text-navy-200 hover:text-white']"
                        >
                            Editor Guidelines
                        </Link>
                    </div>
                </div>
            </div>
        </section>

        <!-- Content Section -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-4xl">
                <div class="bg-white rounded-xl border border-gray-200 p-8 md:p-12 shadow-sm space-y-8 text-gray-700 text-sm md:text-base leading-relaxed">
                    
                    <!-- Authors Guidelines Content -->
                    <div v-if="type === 'authors'" class="space-y-6">
                        <h2 class="text-2xl font-bold text-gray-900">Manuscript Preparation Guidelines</h2>
                        <p>Authors submitting to Knowledge Dynamics journals must ensure their work is original, unpublished, and not under consideration elsewhere. Submissions must adhere to the following specifications:</p>
                        
                        <div class="space-y-4">
                            <h3 class="text-lg font-bold text-gray-900">1. Manuscript Structure</h3>
                            <ul class="list-disc pl-5 space-y-1.5 text-xs md:text-sm">
                                <li><strong>Title Page:</strong> Concise title, author full names, institutional affiliations, ORCID IDs, and designated corresponding author email.</li>
                                <li><strong>Structured Abstract:</strong> Maximum 250–300 words comprising Background, Methods, Results, and Conclusions.</li>
                                <li><strong>Keywords:</strong> 4 to 6 indexing terms matching MeSH or disciplinary thesauri.</li>
                                <li><strong>Main Body:</strong> Introduction, Methodology / Experimental Procedures, Results, Discussion, and Conclusions.</li>
                                <li><strong>Declarations:</strong> Funding details, Competing Interests, Ethics Approval & Patient Consent, and Data Availability Statement.</li>
                            </ul>
                        </div>

                        <div class="space-y-4">
                            <h3 class="text-lg font-bold text-gray-900">2. Reference Formatting</h3>
                            <p class="text-xs md:text-sm">Vancouver referencing style is required for <em>Health Dynamics</em> and <em>KD Food Science Nutrition</em>. APA 7th Edition style is required for <em>KD Accounting, Business, Management, Finance</em>. Chicago Notes & Bibliography is required for <em>KD Asian Studies</em> and <em>KD Comparative Religion</em>.</p>
                        </div>

                        <div class="pt-4">
                            <Link :href="route('manuscripts.create')" class="btn-primary text-xs py-2.5 px-6 shadow-sm">
                                Proceed to Manuscript Submission Portal →
                            </Link>
                        </div>
                    </div>

                    <!-- Editorial Policies Content -->
                    <div v-else-if="type === 'editorial-policies'" class="space-y-6">
                        <h2 class="text-2xl font-bold text-gray-900">Publication Ethics & COPE Compliance</h2>
                        <p>Knowledge Dynamics upholds zero tolerance for academic malpractice, data falsification, fraudulent authorship, and uncredited intellectual overlap.</p>
                        
                        <div class="space-y-3">
                            <h3 class="text-base font-bold text-gray-900">Authorship Criteria</h3>
                            <p class="text-xs md:text-sm">Authorship must follow ICMJE guidelines: (1) substantial contributions to conception or acquisition/analysis of data, (2) drafting or revising the work critically, (3) final approval of the version to be published, and (4) agreement to be accountable for all aspects of the work.</p>
                        </div>

                        <div class="space-y-3">
                            <h3 class="text-base font-bold text-gray-900">Plagiarism & AI Transparency</h3>
                            <p class="text-xs md:text-sm">All submissions undergo automated similarity screening. Manuscripts exhibiting duplicate phrasing without citation exceeding journal thresholds will be rejected immediately. Generative AI tools cannot be listed as authors; their use must be explicitly declared in the methodology.</p>
                        </div>
                    </div>

                    <!-- Reviewer Guidelines Content -->
                    <div v-else-if="type === 'reviewers'" class="space-y-6">
                        <h2 class="text-2xl font-bold text-gray-900">Peer Reviewer Code of Conduct</h2>
                        <p>Peer reviewers play a pivotal role in ensuring scholarly excellence. Reviewers are expected to maintain strict confidentiality and provide impartial, constructive evaluations within the requested timeline (typically 3 weeks).</p>
                        
                        <div class="space-y-3">
                            <h3 class="text-base font-bold text-gray-900">Confidentiality & Conflict of Interest</h3>
                            <p class="text-xs md:text-sm">Manuscripts under review are strictly confidential. Reviewers must not share drafts or data with third parties. Reviewers must immediately recuse themselves if a conflict of interest exists with the authors or collaborating institutions.</p>
                        </div>
                    </div>

                    <!-- Editor Guidelines Content -->
                    <div v-else class="space-y-6">
                        <h2 class="text-2xl font-bold text-gray-900">Editorial Board Roles & Responsibilities</h2>
                        <p>Editors-in-Chief and Section Editors exercise editorial independence. Decisions to accept or reject are grounded exclusively in academic merit, novelty, scientific validity, and alignment with the journal's stated scope.</p>
                    </div>

                </div>
            </div>
        </section>
    </PublicLayout>
</template>
