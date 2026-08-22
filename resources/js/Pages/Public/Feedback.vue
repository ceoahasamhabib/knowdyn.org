<script setup>
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const page = usePage();
const user = page.props.auth?.user;

const form = useForm({
    name: user?.name || '',
    email: user?.email || '',
    subject: '',
    category: 'Website & UI Experience',
    message: '',
});

const submitFeedback = () => {
    form.post(route('feedback.store'), {
        onSuccess: () => {
            form.reset('subject', 'message');
        },
    });
};
</script>

<template>
    <Head>
        <title>Community Feedback & Suggestions — Knowledge Dynamics</title>
        <meta name="description" content="Share your user experience feedback, journal feature suggestions, or editorial ideas to help improve Knowledge Dynamics." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Continuous Improvement</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Community Feedback & Ideas</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        We value feedback from authors, reviewers, librarians, and readers to continuously elevate our scholarly publishing ecosystem.
                    </p>
                </div>
            </div>
        </section>

        <!-- Feedback Form -->
        <section class="section bg-gray-50/60">
            <div class="container-wide max-w-3xl">
                <form @submit.prevent="submitFeedback" class="bg-white rounded-xl border border-gray-200 p-6 md:p-10 shadow-sm space-y-6">
                    <div class="border-b border-gray-100 pb-4">
                        <h2 class="text-xl font-bold text-gray-900">Submit Your Feedback</h2>
                        <p class="text-xs text-gray-500 mt-1">Tell us what you love or how we can make Knowledge Dynamics even better.</p>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Your Name *</label>
                            <input
                                v-model="form.name"
                                type="text"
                                required
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Your Email *</label>
                            <input
                                v-model="form.email"
                                type="email"
                                required
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>

                        <div class="sm:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Feedback Category *</label>
                            <select
                                v-model="form.category"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            >
                                <option value="Website & UI Experience">Website & UI Experience</option>
                                <option value="Manuscript Submission Workflow">Manuscript Submission Workflow</option>
                                <option value="Peer Review Interface">Peer Review Interface</option>
                                <option value="Journal Scope & Editorial Quality">Journal Scope & Editorial Quality</option>
                                <option value="Proofreading & Publishing Services">Proofreading & Publishing Services</option>
                                <option value="Other Suggestions">Other Suggestions</option>
                            </select>
                        </div>

                        <div class="sm:col-span-2">
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Subject / Summary *</label>
                            <input
                                v-model="form.subject"
                                type="text"
                                required
                                placeholder="Brief overview of your suggestion or feedback"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                            />
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Your Message & Recommendations *</label>
                        <textarea
                            v-model="form.message"
                            rows="5"
                            required
                            placeholder="Provide constructive details, suggestions, or bug reports..."
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="flex justify-end pt-4 border-t border-gray-100">
                        <button
                            type="submit"
                            :disabled="form.processing"
                            class="btn-primary text-xs py-2.5 px-8 shadow-sm"
                        >
                            {{ form.processing ? 'Sending...' : 'Send Feedback' }}
                        </button>
                    </div>
                </form>
            </div>
        </section>
    </PublicLayout>
</template>
