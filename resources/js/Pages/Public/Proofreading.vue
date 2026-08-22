<script setup>
import { ref, computed } from 'vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    service: {
        type: Object,
        default: null,
    },
});

const page = usePage();
const currentUser = computed(() => page.props.auth?.user);

const wordCount = ref(3000);
const turnaround = ref('standard'); // standard (5-7 days), express (48h), rush (24h)

const ratePerWord = computed(() => {
    switch (turnaround.value) {
        case 'rush': return 0.045; // $0.045/word
        case 'express': return 0.035; // $0.035/word
        default: return 0.025; // $0.025/word
    }
});

const estimatedPrice = computed(() => {
    return Math.round(wordCount.value * ratePerWord.value);
});

const form = useForm({
    service_id: props.service?.id || 1,
    name: currentUser.value?.name || '',
    email: currentUser.value?.email || '',
    phone: '',
    message: '',
});

const submitInquiry = () => {
    form.message = `[Proofreading Inquiry - ${wordCount.value} words, Turnaround: ${turnaround.value}, Est: $${estimatedPrice.value}] \n${form.message}`;
    form.post(route('services.request.store'), {
        onSuccess: () => {
            form.reset('message');
        },
    });
};
</script>

<template>
    <Head>
        <title>KD Proofreading — Professional Academic Language Editing</title>
        <meta name="description" content="Expert English editing and proofreading for academic manuscripts, journal submissions, doctoral theses, and research papers by native PhD editors." />
    </Head>

    <PublicLayout>
        <!-- Hero Section -->
        <section class="bg-navy-800 text-white py-16 md:py-24 relative overflow-hidden">
            <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#38bdf8_1px,transparent_1px)] [background-size:16px_16px]"></div>
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-navy-700/80 text-academic-300 border border-navy-600 mb-4">
                        ★ 100% Publication-Ready Quality Guarantee
                    </span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white leading-tight">
                        KD Proofreading & Academic Language Editing
                    </h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Elevate your research papers to international publication standards. Edited by subject-matter PhD specialists in Medicine, Engineering, Economics, and Social Sciences.
                    </p>
                </div>
            </div>
        </section>

        <!-- Calculator & Service Options -->
        <section class="section bg-gray-50/70">
            <div class="container-wide">
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
                    <!-- Left: Interactive Pricing Calculator -->
                    <div class="lg:col-span-7 space-y-8">
                        <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                            <div class="border-b border-gray-100 pb-4">
                                <h2 class="text-xl font-bold text-gray-900">Instant Estimate & Turnaround Calculator</h2>
                                <p class="text-xs text-gray-500 mt-1">Adjust your manuscript word count and turnaround preference to calculate pricing.</p>
                            </div>

                            <!-- Word Count Slider -->
                            <div class="space-y-3">
                                <div class="flex items-center justify-between">
                                    <label class="text-xs font-bold text-gray-700 uppercase tracking-wider">Manuscript Word Count</label>
                                    <span class="text-lg font-bold text-navy-900 font-mono">{{ Number(wordCount).toLocaleString() }} words</span>
                                </div>
                                <input
                                    v-model.number="wordCount"
                                    type="range"
                                    min="500"
                                    max="20000"
                                    step="250"
                                    class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-navy-700"
                                />
                                <div class="flex justify-between text-[11px] text-gray-400">
                                    <span>500 words</span>
                                    <span>5,000</span>
                                    <span>10,000</span>
                                    <span>20,000 words</span>
                                </div>
                            </div>

                            <!-- Turnaround Options -->
                            <div class="space-y-3">
                                <label class="text-xs font-bold text-gray-700 uppercase tracking-wider block">Turnaround Time</label>
                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                                    <div
                                        @click="turnaround = 'standard'"
                                        :class="['p-4 rounded-lg border cursor-pointer transition text-center', turnaround === 'standard' ? 'border-navy-700 bg-navy-50/60 ring-2 ring-navy-700' : 'border-gray-200 bg-white hover:border-gray-300']"
                                    >
                                        <div class="font-bold text-sm text-gray-900">Standard</div>
                                        <div class="text-xs text-gray-500 mt-0.5">5 – 7 Days</div>
                                        <div class="text-xs font-semibold text-navy-800 mt-2">$0.025 / word</div>
                                    </div>

                                    <div
                                        @click="turnaround = 'express'"
                                        :class="['p-4 rounded-lg border cursor-pointer transition text-center', turnaround === 'express' ? 'border-navy-700 bg-navy-50/60 ring-2 ring-navy-700' : 'border-gray-200 bg-white hover:border-gray-300']"
                                    >
                                        <div class="font-bold text-sm text-gray-900">Express</div>
                                        <div class="text-xs text-gray-500 mt-0.5">48 Hours</div>
                                        <div class="text-xs font-semibold text-navy-800 mt-2">$0.035 / word</div>
                                    </div>

                                    <div
                                        @click="turnaround = 'rush'"
                                        :class="['p-4 rounded-lg border cursor-pointer transition text-center', turnaround === 'rush' ? 'border-navy-700 bg-navy-50/60 ring-2 ring-navy-700' : 'border-gray-200 bg-white hover:border-gray-300']"
                                    >
                                        <div class="font-bold text-sm text-gray-900">Rush Urgent</div>
                                        <div class="text-xs text-gray-500 mt-0.5">24 Hours</div>
                                        <div class="text-xs font-semibold text-navy-800 mt-2">$0.045 / word</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pricing Breakdown Box -->
                            <div class="bg-navy-900 text-white rounded-xl p-5 flex items-center justify-between">
                                <div>
                                    <div class="text-xs text-navy-300">Estimated Total Investment</div>
                                    <div class="text-2xl sm:text-3xl font-bold text-academic-300 font-mono mt-0.5">
                                        ${{ Number(estimatedPrice).toLocaleString() }} <span class="text-xs text-navy-300 font-sans">USD</span>
                                    </div>
                                </div>
                                <div class="text-right text-xs text-navy-300">
                                    <div>✓ Certificate of Editing Included</div>
                                    <div>✓ Unlimited Free Re-checks</div>
                                </div>
                            </div>
                        </div>

                        <!-- What's Included in KD Proofreading -->
                        <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4">
                            <h3 class="text-base font-bold text-gray-900">Comprehensive Editorial Scope</h3>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs text-gray-700">
                                <div class="flex items-start gap-2.5">
                                    <span class="text-emerald-600 font-bold">✓</span>
                                    <span>Grammar, syntax, spelling and academic punctuation precision</span>
                                </div>
                                <div class="flex items-start gap-2.5">
                                    <span class="text-emerald-600 font-bold">✓</span>
                                    <span>Academic tone and formal scientific phrasing enhancement</span>
                                </div>
                                <div class="flex items-start gap-2.5">
                                    <span class="text-emerald-600 font-bold">✓</span>
                                    <span>Discipline-specific terminology and nomenclature accuracy</span>
                                </div>
                                <div class="flex items-start gap-2.5">
                                    <span class="text-emerald-600 font-bold">✓</span>
                                    <span>Target journal style guide formatting (APA, Vancouver, IEEE, Harvard)</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right: Request Submission Form -->
                    <div class="lg:col-span-5">
                        <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6 sticky top-20">
                            <div>
                                <h3 class="text-lg font-bold text-gray-900">Request Proofreading Quote</h3>
                                <p class="text-xs text-gray-500 mt-1">Submit your details and paper specifications to receive a formal quotation.</p>
                            </div>

                            <form @submit.prevent="submitInquiry" class="space-y-4">
                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Your Full Name *</label>
                                    <input
                                        v-model="form.name"
                                        type="text"
                                        required
                                        placeholder="Prof. / Dr. Jane Doe"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Email Address *</label>
                                    <input
                                        v-model="form.email"
                                        type="email"
                                        required
                                        placeholder="jane.doe@university.edu"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Phone / WhatsApp</label>
                                    <input
                                        v-model="form.phone"
                                        type="text"
                                        placeholder="+1 (555) 000-0000"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Subject Area & Instructions</label>
                                    <textarea
                                        v-model="form.message"
                                        rows="3"
                                        required
                                        placeholder="e.g. Biomedical paper for submission to Health Dynamics. Please format references in Vancouver style..."
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    ></textarea>
                                </div>

                                <button
                                    type="submit"
                                    :disabled="form.processing"
                                    class="btn-primary text-xs w-full py-2.5 shadow-sm"
                                >
                                    {{ form.processing ? 'Submitting Quote Request...' : 'Submit Proofreading Request' }}
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
