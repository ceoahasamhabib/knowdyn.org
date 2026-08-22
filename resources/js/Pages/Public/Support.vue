<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

</script>

<template>
    <Head>
        <title>Help & Support Desk — Knowledge Dynamics</title>
        <meta name="description" content="Find answers to frequent author questions, manuscript submission troubleshooting, peer review guidance, and technical support." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Technical & Editorial Assistance</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Help & Support Desk</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Need assistance with your manuscript submission, reviewer assignment, researcher profile vanity URL, or proofreading order? We are here to help.
                    </p>
                </div>
            </div>
        </section>

        <!-- FAQs & Help Sections -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-4xl space-y-8">
                <div class="bg-white rounded-xl border border-gray-200 p-8 md:p-10 shadow-sm space-y-6">
                    <h2 class="text-xl font-bold text-gray-900">Frequently Asked Questions</h2>

                    <div class="space-y-4 text-xs md:text-sm text-gray-600">
                        <div class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                            <h3 class="font-bold text-gray-900 text-sm">How long does the peer review process take?</h3>
                            <p class="mt-1">Initial editorial screening takes 3–5 days. Double-blind peer review typically concludes within 4–6 weeks from submission.</p>
                        </div>

                        <div class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                            <h3 class="font-bold text-gray-900 text-sm">How can I claim my researcher profile vanity URL?</h3>
                            <p class="mt-1">Register for an account and navigate to Profile Settings. Choose a unique username to claim your permanent <code>knowdyn.org/{username}</code> public profile.</p>
                        </div>

                        <div class="p-4 bg-gray-50 rounded-lg border border-gray-100">
                            <h3 class="font-bold text-gray-900 text-sm">Where can I check the status of my manuscript?</h3>
                            <p class="mt-1">Log in and visit your Author Submissions Dashboard at <code>/dashboard/submissions</code> to view real-time editorial timeline tracking.</p>
                        </div>
                    </div>
                </div>

                <!-- Contact & Feedback CTAs -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm flex flex-col justify-between space-y-4">
                        <div>
                            <h3 class="text-base font-bold text-gray-900">Direct Contact Desk</h3>
                            <p class="text-xs text-gray-500 mt-1">Get in touch directly with our editorial and publishing operations staff.</p>
                        </div>
                        <Link :href="route('contact')" class="btn-primary text-xs w-full py-2 shadow-sm text-center">
                            Contact Editorial Team →
                        </Link>
                    </div>

                    <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm flex flex-col justify-between space-y-4">
                        <div>
                            <h3 class="text-base font-bold text-gray-900">Share Feedback & Suggestions</h3>
                            <p class="text-xs text-gray-500 mt-1">Help us improve the Knowledge Dynamics platform experience.</p>
                        </div>
                        <Link :href="route('feedback.index')" class="btn-secondary text-xs w-full py-2 text-center">
                            Submit Community Feedback →
                        </Link>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
