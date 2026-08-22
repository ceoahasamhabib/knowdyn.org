<script setup>
import { computed } from 'vue';
import { Head, Link, usePage } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const page = usePage();
const user = computed(() => page.props.auth?.user);
const theme = computed(() => page.props.theme || {});

const cards = [
    {
        title: 'Submit Manuscript',
        desc: 'Submit your research paper, monograph, or review to any of our 5 international indexed journals.',
        href: '/submissions/new',
        icon: '📝',
        btnText: 'Start Submission →',
        color: 'from-blue-600 to-indigo-600',
    },
    {
        title: 'Academic Webmail',
        desc: 'Access your official in-app scholarly email dashboard or apply for a personalized domain mailbox.',
        href: '/webmail',
        icon: '✉️',
        btnText: 'Open Webmail →',
        color: 'from-rose-500 to-pink-600',
    },
    {
        title: 'Peer Review Portal',
        desc: 'Review assigned manuscripts, provide double-blind evaluations, and support scientific rigor.',
        href: '/dashboard/reviews',
        icon: '🔍',
        btnText: 'Review Queue →',
        color: 'from-emerald-600 to-teal-600',
    },
    {
        title: 'Author Track & Revisions',
        desc: 'Track editorial status, upload revision files, and respond to reviewer feedback.',
        href: '/dashboard/submissions',
        icon: '📊',
        btnText: 'My Submissions →',
        color: 'from-purple-600 to-indigo-600',
    },
];
</script>

<template>
    <Head title="Scholar Dashboard — Knowledge Dynamics" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                <div>
                    <h1 class="text-xl font-bold text-slate-900 font-sans">
                        Welcome back, {{ user?.name }} 👋
                    </h1>
                    <p class="text-xs text-slate-500 mt-0.5">
                        Researcher Cockpit & Academic Publishing Workspace
                    </p>
                </div>
                <div class="flex items-center gap-3">
                    <Link
                        href="/submissions/new"
                        class="px-4 py-2 text-xs font-bold text-white rounded-lg shadow-sm transition flex items-center gap-2"
                        :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                    >
                        <span>+</span> Submit New Paper
                    </Link>
                </div>
            </div>
        </template>

        <div class="space-y-8">
            <!-- 1. Scholar Hero Banner -->
            <div class="relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-950 via-slate-900 to-indigo-950 p-6 sm:p-8 text-white shadow-lg">
                <div class="relative z-10 max-w-2xl space-y-3">
                    <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/10 text-rose-300 text-xs font-bold tracking-wide backdrop-blur-md border border-white/10">
                        <span class="w-2 h-2 rounded-full bg-rose-400 animate-pulse"></span>
                        Academic Excellence & Open Access
                    </div>
                    <h2 class="text-2xl sm:text-3xl font-extrabold tracking-tight font-serif">
                        Publish Your Discoveries with Global Impact
                    </h2>
                    <p class="text-xs sm:text-sm text-slate-300 leading-relaxed">
                        Fast double-blind peer review, automated Crossref DOI registration, and full compliance with CC BY 4.0 Open Access mandates.
                    </p>
                </div>

                <!-- Subtle Decorative Shapes -->
                <div class="absolute -right-12 -bottom-12 w-64 h-64 rounded-full bg-indigo-500/10 blur-3xl pointer-events-none"></div>
                <div class="absolute right-20 -top-12 w-48 h-48 rounded-full bg-rose-500/10 blur-3xl pointer-events-none"></div>
            </div>

            <!-- 2. Interactive Feature Action Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <div
                    v-for="card in cards"
                    :key="card.title"
                    class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs hover:shadow-md transition duration-200 flex flex-col justify-between group"
                >
                    <div class="space-y-3">
                        <div class="w-10 h-10 rounded-xl bg-slate-100 flex items-center justify-center text-lg shadow-xs group-hover:scale-110 transition">
                            {{ card.icon }}
                        </div>
                        <h3 class="text-sm font-bold text-slate-900 group-hover:text-indigo-600 transition">
                            {{ card.title }}
                        </h3>
                        <p class="text-xs text-slate-500 leading-relaxed">
                            {{ card.desc }}
                        </p>
                    </div>

                    <div class="pt-5 border-t border-slate-100 mt-4">
                        <Link
                            :href="card.href"
                            class="text-xs font-bold text-indigo-600 hover:text-indigo-700 flex items-center gap-1.5 transition"
                        >
                            {{ card.btnText }}
                        </Link>
                    </div>
                </div>
            </div>

            <!-- 3. Resource & Quick Reference Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Submission Guidelines -->
                <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-4">
                    <h4 class="text-xs font-bold uppercase tracking-wider text-slate-900 flex items-center gap-2">
                        📖 Author Resources
                    </h4>
                    <ul class="space-y-2.5 text-xs text-slate-600">
                        <li>
                            <Link href="/guidelines/authors" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> Author Submission Instructions
                            </Link>
                        </li>
                        <li>
                            <Link href="/guidelines/editorial-policies" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> Publication Ethics & Plagiarism Rules
                            </Link>
                        </li>
                        <li>
                            <Link href="/guidelines/open-access" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> Open Access & CC BY Licensing
                            </Link>
                        </li>
                        <li>
                            <Link href="/services" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> Fast-Track & English Proofreading
                            </Link>
                        </li>
                    </ul>
                </div>

                <!-- Academic Journals -->
                <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-4">
                    <h4 class="text-xs font-bold uppercase tracking-wider text-slate-900 flex items-center gap-2">
                        📚 Indexed Journals
                    </h4>
                    <ul class="space-y-2.5 text-xs text-slate-600">
                        <li>
                            <Link href="/journals/ijdms" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> Data & Medical Sciences
                            </Link>
                        </li>
                        <li>
                            <Link href="/journals/jstem" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> STEM & Sustainable Energy
                            </Link>
                        </li>
                        <li>
                            <Link href="/journals/jebs" class="hover:text-indigo-600 transition flex items-center gap-2">
                                <span>→</span> Economics & Social Sciences
                            </Link>
                        </li>
                        <li>
                            <Link href="/journals" class="text-indigo-600 font-bold hover:underline">
                                View all 5 journals →
                            </Link>
                        </li>
                    </ul>
                </div>

                <!-- Quick Help & Support -->
                <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-4">
                    <h4 class="text-xs font-bold uppercase tracking-wider text-slate-900 flex items-center gap-2">
                        💬 Editorial Support
                    </h4>
                    <p class="text-xs text-slate-500 leading-relaxed">
                        Need assistance with a manuscript submission, APC waiver inquiry, or editorial decision?
                    </p>
                    <div class="pt-2">
                        <Link
                            href="/contact"
                            class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-800 text-xs font-bold transition"
                        >
                            Contact Editorial Desk ↗
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
