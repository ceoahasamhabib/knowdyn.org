<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    assignment: {
        type: Object,
        required: true,
    },
});

const form = useForm({
    recommendation: props.assignment.review?.recommendation || 'accept',
    quality_score: props.assignment.review?.quality_score || 8,
    comments_to_author: props.assignment.review?.comments_to_author || '',
    comments_to_editor: props.assignment.review?.comments_to_editor || '',
});

const submitReview = () => {
    if (confirm('Are you sure you want to submit your final peer review evaluation? This will be delivered to the editorial board.')) {
        form.post(route('reviewer.review.submit', props.assignment.id));
    }
};
</script>

<template>
    <Head :title="`Peer Review Form — ${assignment.manuscript?.title}`" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('reviewer.dashboard')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Dashboard
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900 truncate max-w-xl">Peer Review: {{ assignment.manuscript?.title }}</h1>
            </div>
        </template>

        <div class="max-w-5xl mx-auto space-y-8">
            <!-- Confidential Manuscript Preview -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4">
                <div class="flex items-center justify-between border-b border-gray-100 pb-3">
                    <span class="text-xs font-bold text-navy-800 uppercase tracking-widest">
                        {{ assignment.manuscript?.journal?.title }} • Confidential Manuscript
                    </span>
                    <span class="text-xs text-rose-700 bg-rose-50 px-2.5 py-0.5 rounded-full font-semibold border border-rose-200">
                        Strictly Confidential
                    </span>
                </div>

                <div>
                    <h2 class="text-xl font-bold text-gray-900 leading-snug">{{ assignment.manuscript?.title }}</h2>
                    <p class="text-xs text-gray-500 mt-1 capitalize">Category: {{ (assignment.manuscript?.article_type || 'original-research').replace('-', ' ') }}</p>
                </div>

                <div>
                    <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-1">Abstract</h3>
                    <p class="text-xs md:text-sm text-gray-700 leading-relaxed whitespace-pre-line bg-gray-50 p-4 rounded-lg border border-gray-100">
                        {{ assignment.manuscript?.abstract }}
                    </p>
                </div>

                <!-- Files -->
                <div class="pt-3 border-t border-gray-100">
                    <h3 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2">Manuscript Files</h3>
                    <div v-if="assignment.manuscript?.files && assignment.manuscript.files.length > 0" class="space-y-2">
                        <div v-for="file in assignment.manuscript.files" :key="file.id" class="flex items-center justify-between p-3 bg-gray-50 border border-gray-200 rounded-lg text-xs">
                            <div class="flex items-center gap-2">
                                <svg class="w-4 h-4 text-navy-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                                </svg>
                                <span class="font-bold text-gray-800">{{ file.file_name }}</span>
                            </div>
                            <span class="text-[11px] uppercase bg-gray-200 text-gray-700 px-2 py-0.5 rounded font-semibold">{{ file.file_type }}</span>
                        </div>
                    </div>
                    <div v-else class="text-xs text-gray-400 italic">No files attached.</div>
                </div>
            </div>

            <!-- Review Evaluation Form -->
            <form @submit.prevent="submitReview" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="border-b border-gray-100 pb-4">
                    <h2 class="text-lg font-bold text-gray-900">Review Evaluation & Recommendation</h2>
                    <p class="text-xs text-gray-500 mt-0.5">Please provide your thorough scientific critique, methodology evaluation, and decision recommendation.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Recommendation Decision *</label>
                        <select
                            v-model="form.recommendation"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none font-semibold"
                        >
                            <option value="accept">Accept Without Revision</option>
                            <option value="minor_revision">Accept with Minor Revision</option>
                            <option value="major_revision">Major Revision Required</option>
                            <option value="reject">Reject Manuscript</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Scientific Quality Score (1-10) *</label>
                        <select
                            v-model="form.quality_score"
                            class="w-full border border-gray-300 rounded-lg px-3.5 py-2.5 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option v-for="score in 10" :key="score" :value="score">
                                {{ score }} {{ score >= 9 ? '(Exceptional)' : score >= 7 ? '(Good)' : score >= 5 ? '(Acceptable)' : '(Below Standard)' }}
                            </option>
                        </select>
                    </div>
                </div>

                <div class="space-y-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Comments to the Authors * (Constructive Critique)</label>
                        <textarea
                            v-model="form.comments_to_author"
                            rows="8"
                            required
                            placeholder="Detail your scientific feedback on originality, experimental design, methodology, clarity, and references for the author..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-rose-700 uppercase mb-1">Confidential Comments to the Editor (Not shown to authors)</label>
                        <textarea
                            v-model="form.comments_to_editor"
                            rows="4"
                            placeholder="Provide confidential notes on novelty, potential conflicts, ethical concerns, or priority assessment..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>
                </div>

                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <Link :href="route('reviewer.dashboard')" class="btn-secondary text-xs py-2 px-5">
                        Cancel
                    </Link>
                    <button
                        type="submit"
                        :disabled="form.processing"
                        class="btn-primary text-xs py-2.5 px-8 shadow-sm"
                    >
                        {{ form.processing ? 'Submitting Review...' : 'Submit Peer Review Evaluation' }}
                    </button>
                </div>
            </form>
        </div>
    </AuthenticatedLayout>
</template>
