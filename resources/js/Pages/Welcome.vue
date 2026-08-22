<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';

defineProps({
    featuredJournals: { type: Array, default: () => [] },
    latestArticles: { type: Array, default: () => [] },
    featuredResearchers: { type: Array, default: () => [] },
    stats: {
        type: Object,
        default: () => ({
            journals: 0,
            articles: 0,
            researchers: 0,
            projects: 0,
        }),
    },
});

const services = [
    {
        title: 'Manuscript Editing',
        description: 'Comprehensive structural, scientific, and linguistic editing to prepare manuscripts for tier-1 indexed journals.',
        icon: 'edit',
        color: 'from-indigo-500 to-blue-600',
        badge: 'Top Rated',
        badgeClass: 'bg-indigo-50 text-indigo-700 border-indigo-200',
    },
    {
        title: 'Language Proofreading',
        description: 'Rigorous grammar, syntax, terminology, and stylistic refinement by native academic subject experts.',
        icon: 'check',
        color: 'from-emerald-500 to-teal-600',
        badge: 'Certified',
        badgeClass: 'bg-emerald-50 text-emerald-700 border-emerald-200',
    },
    {
        title: 'Academic Formatting',
        description: 'Precision compliance formatting for APA 7th, Vancouver, Chicago, Harvard, IEEE, and custom journal guidelines.',
        icon: 'format',
        color: 'from-amber-500 to-orange-600',
        badge: 'Precision',
        badgeClass: 'bg-amber-50 text-amber-700 border-amber-200',
    },
    {
        title: 'Journal Publishing & DOI',
        description: 'End-to-end editorial ecosystem setup, Crossref DOI allocation, OJS interoperability, and indexing advisory.',
        icon: 'publish',
        color: 'from-rose-500 to-pink-600',
        badge: 'Crossref',
        badgeClass: 'bg-rose-50 text-rose-700 border-rose-200',
    },
];

const reasons = [
    {
        title: 'Gold Open Access',
        description: 'Accelerating global research dissemination under Creative Commons CC BY 4.0 licenses with full author retention.',
        icon: 'open',
        gradient: 'from-blue-500 to-indigo-600',
    },
    {
        title: 'Rigorous Peer Review',
        description: 'Automated double-blind editorial workflow with verified global peer review committees and COPE compliance.',
        icon: 'review',
        gradient: 'from-indigo-500 to-rose-600',
    },
    {
        title: 'Crossref DOI Architecture',
        description: 'Instant metadata deposit and persistent Crossref digital object identifier linking for maximum citation impact.',
        icon: 'doi',
        gradient: 'from-rose-500 to-pink-600',
    },
    {
        title: 'Unified Scholar Cockpit',
        description: 'Integrated manuscript submission tracking, peer review management, and official cPanel academic webmail.',
        icon: 'network',
        gradient: 'from-emerald-500 to-teal-600',
    },
];

const topics = [
    'Health Sciences', 'Public Health', 'Clinical Medicine', 'Pharmaceutical Sciences',
    'Food Science & Nutrition', 'Asian Studies', 'Business & Management', 'Finance & Accounting',
    'Comparative Religion', 'Biostatistics & Epidemiology', 'Social Sciences', 'Medical Education',
];
</script>

<template>
    <Head>
        <title>Knowledge Dynamics — Global Open Access Academic Publishing & Research</title>
        <meta name="description" content="Knowledge Dynamics is an international academic publisher for peer-reviewed open access journals, books, scholar profiles, and editorial proofreading services." />
        <meta property="og:title" content="Knowledge Dynamics — Research • Publish • Discover" />
        <meta property="og:description" content="Elevating global research with open access journals, verified peer review, and academic proofreading." />
        <meta property="og:type" content="website" />
    </Head>

    <PublicLayout>
        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- 1. HERO SECTION: PREMIUM BALANCED COSMIC DARK SLATE         -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <section class="relative bg-[#070c18] text-white overflow-hidden pt-12 pb-20 lg:pt-20 lg:pb-28 selection:bg-rose-500 selection:text-white border-b border-slate-800/80">
            <!-- Ambient Radial Glow Effects -->
            <div class="absolute -top-32 -left-32 w-[550px] h-[550px] bg-indigo-600/20 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute -bottom-32 -right-32 w-[550px] h-[550px] bg-rose-600/15 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[850px] h-[850px] bg-blue-900/15 rounded-full blur-3xl pointer-events-none"></div>

            <!-- Subtle Grid Pattern Background Mask -->
            <div class="absolute inset-0 bg-[linear-gradient(to_right,#ffffff05_1px,transparent_1px),linear-gradient(to_bottom,#ffffff05_1px,transparent_1px)] bg-[size:4rem_4rem] [mask-image:radial-gradient(ellipse_60%_50%_at_50%_50%,#000_70%,transparent_100%)] pointer-events-none"></div>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                <div class="grid lg:grid-cols-12 gap-12 lg:gap-8 items-center">
                    <!-- Left Hero Content -->
                    <div class="lg:col-span-7 space-y-7 text-center lg:text-left">
                        <!-- Eyebrow Badge -->
                        <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-gradient-to-r from-indigo-500/15 to-rose-500/15 border border-indigo-500/30 text-indigo-300 text-xs font-bold shadow-xs">
                            <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
                            <span>Unified Academic Publishing & Research Cockpit</span>
                        </div>

                        <!-- Main Radiant Headline -->
                        <h1 class="text-4xl sm:text-5xl lg:text-6xl font-black tracking-tight leading-[1.12]">
                            Elevating Global <br class="hidden sm:block" />
                            <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-indigo-300 to-rose-400">
                                Research & Discovery
                            </span>
                        </h1>

                        <!-- Subtitle -->
                        <p class="text-base sm:text-lg text-slate-300 max-w-2xl mx-auto lg:mx-0 leading-relaxed font-normal">
                            Knowledge Dynamics empowers researchers and institutions with peer-reviewed open access journals, Crossref DOI allocation, expert proofreading, and unified institutional webmail.
                        </p>

                        <!-- Action Buttons -->
                        <div class="flex flex-wrap items-center justify-center lg:justify-start gap-3.5 pt-1">
                            <Link
                                :href="route('journals.index')"
                                class="px-6 py-3.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-xs sm:text-sm shadow-xl shadow-indigo-500/25 transition duration-300 flex items-center justify-center gap-2 group"
                            >
                                <span>Explore Journals</span>
                                <span class="group-hover:translate-x-1 transition duration-200 font-mono">→</span>
                            </Link>

                            <Link
                                :href="route('manuscripts.create')"
                                class="px-6 py-3.5 rounded-xl bg-slate-900/90 hover:bg-slate-800 text-white font-bold text-xs sm:text-sm border border-slate-700/90 backdrop-blur-sm shadow-md transition duration-300 flex items-center justify-center gap-2"
                            >
                                <span>📝 Submit Research</span>
                            </Link>

                            <Link
                                :href="route('proofreading.index')"
                                class="px-5 py-3.5 rounded-xl text-rose-300 hover:text-rose-200 font-bold text-xs sm:text-sm hover:underline transition flex items-center justify-center gap-1.5"
                            >
                                <span>KD Proofreading</span>
                                <span>↗</span>
                            </Link>
                        </div>

                        <!-- Live Stats Cards Row -->
                        <div class="pt-4 grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4">
                            <div class="p-4 rounded-2xl bg-slate-900/70 border border-slate-800/90 backdrop-blur-md text-center sm:text-left shadow-lg">
                                <p class="text-2xl sm:text-3xl font-black text-white font-mono">{{ stats.journals || '5+' }}</p>
                                <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5">Peer Journals</p>
                            </div>
                            <div class="p-4 rounded-2xl bg-slate-900/70 border border-slate-800/90 backdrop-blur-md text-center sm:text-left shadow-lg">
                                <p class="text-2xl sm:text-3xl font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-indigo-300 font-mono">{{ stats.articles || '189+' }}</p>
                                <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5">Indexed Papers</p>
                            </div>
                            <div class="p-4 rounded-2xl bg-slate-900/70 border border-slate-800/90 backdrop-blur-md text-center sm:text-left shadow-lg">
                                <p class="text-2xl sm:text-3xl font-black text-white font-mono">{{ stats.researchers || '50+' }}</p>
                                <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5">Global Scholars</p>
                            </div>
                            <div class="p-4 rounded-2xl bg-slate-900/70 border border-slate-800/90 backdrop-blur-md text-center sm:text-left shadow-lg">
                                <p class="text-2xl sm:text-3xl font-black text-rose-400 font-mono">100%</p>
                                <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5">Open Access</p>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Interactive Featured Journal Showcase Card -->
                    <div class="lg:col-span-5 max-w-md mx-auto w-full">
                        <div class="bg-gradient-to-b from-slate-900/90 to-slate-950/95 border border-slate-800/90 rounded-3xl p-6 sm:p-7 shadow-2xl backdrop-blur-xl space-y-5 relative">
                            <div class="flex items-center justify-between border-b border-slate-800/80 pb-4">
                                <div class="flex items-center gap-2.5">
                                    <div class="w-8 h-8 rounded-lg bg-indigo-500/20 text-indigo-400 flex items-center justify-center text-sm">
                                        ⚡
                                    </div>
                                    <div>
                                        <h3 class="text-xs font-bold text-white uppercase tracking-wider">Spotlight Journal</h3>
                                        <p class="text-[10px] text-slate-400 font-mono">ISSN: 3006-5518 (Online)</p>
                                    </div>
                                </div>
                                <span class="px-2 py-0.5 text-[10px] font-extrabold rounded-full bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">
                                    Active Issue
                                </span>
                            </div>

                            <div class="space-y-2.5">
                                <h4 class="text-xl font-black text-white tracking-tight leading-snug">
                                    Health Dynamics
                                </h4>
                                <p class="text-xs text-slate-400 leading-relaxed">
                                    A premier multidisciplinary medical & health sciences journal publishing original investigations, clinical trials, reviews, and public health policies.
                                </p>
                            </div>

                            <!-- Subject Badges -->
                            <div class="flex flex-wrap gap-1.5 pt-1">
                                <span class="px-2.5 py-1 rounded-lg text-[10px] font-bold bg-slate-800/90 text-indigo-300 border border-slate-700">
                                    Public Health
                                </span>
                                <span class="px-2.5 py-1 rounded-lg text-[10px] font-bold bg-slate-800/90 text-blue-300 border border-slate-700">
                                    Clinical Medicine
                                </span>
                                <span class="px-2.5 py-1 rounded-lg text-[10px] font-bold bg-slate-800/90 text-emerald-300 border border-slate-700">
                                    Epidemiology
                                </span>
                            </div>

                            <div class="pt-4 border-t border-slate-800/80 grid grid-cols-2 gap-3">
                                <Link
                                    :href="route('journals.show', 'health-dynamics')"
                                    class="py-2.5 px-3 rounded-xl bg-gradient-to-r from-indigo-600 to-blue-600 hover:from-indigo-500 hover:to-blue-500 text-white font-bold text-xs text-center shadow transition flex items-center justify-center gap-1"
                                >
                                    <span>Read Journal</span>
                                    <span class="font-mono">→</span>
                                </Link>
                                <Link
                                    :href="route('manuscripts.create')"
                                    class="py-2.5 px-3 rounded-xl bg-slate-800 hover:bg-slate-700 border border-slate-700 text-slate-200 font-bold text-xs text-center transition flex items-center justify-center"
                                >
                                    Submit Paper
                                </Link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- 2. FEATURED JOURNALS: 6-CARD BALANCED SYMMETRIC GRID        -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <section class="py-20 bg-white border-b border-slate-200/80 scroll-mt-24" id="journals-section">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-4">
                    <div>
                        <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-indigo-50 text-indigo-700 text-xs font-bold uppercase tracking-wider mb-2 border border-indigo-200/80">
                            <span>📚</span> Peer-Reviewed Portals
                        </div>
                        <h2 class="text-3xl font-extrabold text-slate-900 tracking-tight">
                            Official Academic Journals
                        </h2>
                        <p class="text-sm text-slate-500 mt-1">
                            Double-blind peer-reviewed publications adhering to international COPE standards and Crossref indexing.
                        </p>
                    </div>
                    <Link
                        :href="route('journals.index')"
                        class="inline-flex items-center gap-1.5 text-xs font-extrabold text-indigo-600 hover:text-indigo-800 hover:translate-x-1 transition"
                    >
                        <span>View All Journals</span>
                        <span class="font-mono">→</span>
                    </Link>
                </div>

                <!-- 6 Cards Symmetrical Grid (2 Rows x 3 Columns) -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div
                        v-for="(journal, i) in (featuredJournals.length ? featuredJournals : [
                            { title: 'Health Dynamics', slug: 'health-dynamics', issn: '3006-5518', description: 'A peer-reviewed, open-access journal publishing original research articles, reviews, and case studies across all disciplines of health sciences.', subjects: ['Health Sciences', 'Public Health', 'Clinical Medicine'] },
                            { title: 'KD Food Science & Nutrition', slug: 'kd-food-science-nutrition', issn: '3006-5526', description: 'Dedicated to publishing high-quality fundamental and applied research across food chemistry, dietary health, nutrition, and food biotechnology.', subjects: ['Food Chemistry', 'Clinical Nutrition', 'Biotechnology'] },
                            { title: 'KD Asian Studies', slug: 'kd-asian-studies', issn: '3006-5534', description: 'Promoting interdisciplinary research on Asian history, society, literature, anthropology, politics, and socioeconomic development.', subjects: ['Asian History', 'Anthropology', 'Political Economy'] },
                            { title: 'KD Accounting, Business, Management, Finance', slug: 'kd-accounting-business-management-finance', issn: '3006-5542', description: 'Publishing cutting-edge research in corporate finance, forensic accounting, managerial dynamics, organizational behavior, and fintech.', subjects: ['Accounting', 'Corporate Finance', 'Fintech'] },
                            { title: 'KD Comparative Religion', slug: 'kd-comparative-religion', issn: '3006-5550', description: 'Scholarly forum for rigorous academic inquiry into theological philosophy, interfaith dialogue, religious sociology, and comparative doctrines.', subjects: ['Theology', 'Religious Ethics', 'Sociology'] },
                        ])"
                        :key="i"
                        class="bg-white rounded-2xl border border-slate-200/90 p-6 shadow-xs hover:shadow-xl hover:-translate-y-1 transition duration-300 flex flex-col justify-between group"
                    >
                        <div class="space-y-4">
                            <div class="flex items-start justify-between gap-3">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-indigo-500/10 via-blue-500/10 to-rose-500/10 border border-indigo-100 flex items-center justify-center font-bold text-indigo-700 text-lg group-hover:scale-105 transition">
                                    📖
                                </div>
                                <span class="px-2.5 py-1 rounded-full text-[10px] font-mono font-bold bg-slate-100 text-slate-700 border border-slate-200">
                                    ISSN: {{ journal.issn || '3006-5518' }}
                                </span>
                            </div>

                            <div>
                                <h3 class="text-lg font-bold text-slate-900 group-hover:text-indigo-600 transition">
                                    {{ journal.title }}
                                </h3>
                                <p class="text-xs text-slate-500 line-clamp-3 mt-2 leading-relaxed">
                                    {{ journal.description }}
                                </p>
                            </div>

                            <div class="flex flex-wrap gap-1.5 pt-1">
                                <span
                                    v-for="sub in (journal.subjects || []).slice(0, 3)"
                                    :key="sub"
                                    class="px-2.5 py-0.5 rounded-md text-[10px] font-bold bg-slate-100 text-slate-700"
                                >
                                    {{ sub }}
                                </span>
                                <span class="px-2 py-0.5 rounded-md text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                    Open Access
                                </span>
                            </div>
                        </div>

                        <div class="pt-5 mt-5 border-t border-slate-100 flex items-center justify-between text-xs font-bold">
                            <Link :href="`/journals/${journal.slug}`" class="text-indigo-600 hover:text-indigo-800 flex items-center gap-1">
                                <span>Browse Journal</span>
                                <span class="font-mono">→</span>
                            </Link>
                            <Link :href="route('manuscripts.create')" class="text-slate-400 hover:text-slate-700">
                                Submit Paper
                            </Link>
                        </div>
                    </div>

                    <!-- 6th Symmetrical Card: Launch / Propose a Journal -->
                    <div class="bg-gradient-to-br from-slate-900 to-[#070c18] text-white rounded-2xl border border-slate-800 p-6 shadow-md hover:shadow-2xl hover:-translate-y-1 transition duration-300 flex flex-col justify-between relative overflow-hidden group">
                        <div class="absolute -right-8 -bottom-8 w-40 h-40 bg-indigo-600/20 rounded-full blur-2xl pointer-events-none"></div>

                        <div class="space-y-4 relative z-10">
                            <div class="flex items-start justify-between gap-3">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-md">
                                    <div class="w-full h-full bg-[#0a101f] rounded-[10px] flex items-center justify-center text-lg">
                                        🚀
                                    </div>
                                </div>
                                <span class="px-2.5 py-1 rounded-full text-[10px] font-bold bg-indigo-500/20 text-indigo-300 border border-indigo-500/30">
                                    Partnership
                                </span>
                            </div>

                            <div>
                                <h3 class="text-lg font-bold text-white group-hover:text-indigo-300 transition">
                                    Launch or Propose a Journal
                                </h3>
                                <p class="text-xs text-slate-300 mt-2 leading-relaxed">
                                    Partner with Knowledge Dynamics to establish, index, and publish a new peer-reviewed open access academic journal for your institution or society.
                                </p>
                            </div>
                        </div>

                        <div class="pt-5 mt-5 border-t border-slate-800/80 flex items-center justify-between text-xs font-bold relative z-10">
                            <Link :href="route('contact')" class="text-indigo-400 hover:text-indigo-300 flex items-center gap-1">
                                <span>Get in Touch</span>
                                <span class="font-mono">→</span>
                            </Link>
                            <Link :href="route('books.propose')" class="text-slate-400 hover:text-white">
                                Propose Book
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- 3. PUBLISHING SERVICES & PROOFREADING (COLOR ACCENT CARDS)   -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <section class="py-20 bg-slate-100/70 border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center max-w-2xl mx-auto mb-14 space-y-3">
                    <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-rose-50 text-rose-700 text-xs font-bold uppercase tracking-wider border border-rose-200/80">
                        <span>✨</span> KD Proofreading & Services
                    </div>
                    <h2 class="text-3xl font-extrabold text-slate-900 tracking-tight">
                        Academic Editing & Publishing Support
                    </h2>
                    <p class="text-xs sm:text-sm text-slate-600 leading-relaxed">
                        From manuscript refinement to international Crossref DOI deposits — precision services designed to maximize scholarly publication success.
                    </p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div
                        v-for="service in services"
                        :key="service.title"
                        class="bg-white rounded-2xl p-6 border border-slate-200/80 shadow-xs hover:shadow-xl hover:-translate-y-1 transition duration-300 flex flex-col justify-between"
                    >
                        <div class="space-y-4">
                            <div class="flex items-center justify-between">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br p-0.5 shadow-md" :class="service.color">
                                    <div class="w-full h-full bg-white rounded-[10px] flex items-center justify-center text-xl">
                                        {{ service.icon === 'edit' ? '📝' : service.icon === 'check' ? '🔍' : service.icon === 'format' ? '📐' : '🌐' }}
                                    </div>
                                </div>
                                <span class="px-2 py-0.5 rounded-md text-[10px] font-bold border" :class="service.badgeClass">
                                    {{ service.badge }}
                                </span>
                            </div>

                            <div>
                                <h3 class="text-base font-bold text-slate-900">{{ service.title }}</h3>
                                <p class="text-xs text-slate-500 mt-1.5 leading-relaxed">{{ service.description }}</p>
                            </div>
                        </div>

                        <div class="pt-4 mt-4 border-t border-slate-100">
                            <Link :href="route('proofreading.index')" class="text-xs font-bold text-rose-600 hover:text-rose-800 flex items-center gap-1">
                                <span>Service Details</span>
                                <span class="font-mono">→</span>
                            </Link>
                        </div>
                    </div>
                </div>

                <div class="mt-12 text-center">
                    <Link
                        :href="route('proofreading.index')"
                        class="inline-flex items-center gap-2 px-8 py-3.5 rounded-xl bg-gradient-to-r from-rose-600 via-pink-600 to-indigo-600 hover:from-rose-500 hover:to-indigo-500 text-white font-extrabold text-xs sm:text-sm shadow-lg shadow-rose-500/25 transition duration-300"
                    >
                        <span>Calculate Proofreading Fee & Submit</span>
                        <span class="font-mono">→</span>
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- 4. WHY KNOWLEDGE DYNAMICS (HIGH CONTRAST PILLARS)           -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <section class="py-20 bg-white border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center max-w-2xl mx-auto mb-14 space-y-3">
                    <div class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-emerald-50 text-emerald-700 text-xs font-bold uppercase tracking-wider border border-emerald-200/80">
                        <span>🛡️</span> Publication Ethics & Standards
                    </div>
                    <h2 class="text-3xl font-extrabold text-slate-900 tracking-tight">
                        Why Publish with Knowledge Dynamics
                    </h2>
                    <p class="text-xs sm:text-sm text-slate-500">
                        Built for researchers, reviewers, and institutions who value scientific integrity and worldwide reach.
                    </p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div
                        v-for="r in reasons"
                        :key="r.title"
                        class="p-6 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-4 hover:bg-white hover:shadow-lg transition duration-300"
                    >
                        <div class="w-12 h-12 rounded-xl bg-gradient-to-br text-white flex items-center justify-center text-xl shadow-md" :class="r.gradient">
                            {{ r.icon === 'open' ? '🔓' : r.icon === 'review' ? '⚖️' : r.icon === 'doi' ? '🔗' : '🏛️' }}
                        </div>
                        <div>
                            <h3 class="text-base font-bold text-slate-900">{{ r.title }}</h3>
                            <p class="text-xs text-slate-500 mt-1.5 leading-relaxed">{{ r.description }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- 5. BROWSE BY ACADEMIC DISCIPLINE TAGS                       -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <section class="py-16 bg-slate-50 border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-6">
                <div>
                    <h3 class="text-xs font-bold uppercase tracking-widest text-slate-400 mb-1">Academic Classifications</h3>
                    <h2 class="text-2xl font-extrabold text-slate-900">Explore Research by Discipline</h2>
                </div>

                <div class="flex flex-wrap justify-center gap-2.5 max-w-4xl mx-auto">
                    <Link
                        v-for="t in topics"
                        :key="t"
                        :href="`/search?q=${encodeURIComponent(t)}`"
                        class="px-4 py-2 rounded-xl bg-white border border-slate-200/90 text-slate-700 font-semibold text-xs hover:border-indigo-400 hover:text-indigo-600 hover:shadow-sm hover:scale-105 transition duration-200"
                    >
                        {{ t }}
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- 6. BOTTOM RADIANT CTA BANNER                                -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <section class="relative bg-[#070c18] text-white py-20 overflow-hidden">
            <!-- Radiant Background Glows -->
            <div class="absolute -top-20 left-1/4 w-96 h-96 bg-indigo-600/20 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute -bottom-20 right-1/4 w-96 h-96 bg-rose-600/20 rounded-full blur-3xl pointer-events-none"></div>

            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10 space-y-6">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-gradient-to-r from-indigo-500/20 to-rose-500/20 border border-indigo-500/30 text-indigo-300 text-xs font-bold">
                    🚀 Ready to Publish Your Research?
                </div>

                <h2 class="text-3xl sm:text-4xl font-black text-white tracking-tight leading-tight">
                    Join the Knowledge Dynamics <br />
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-indigo-300 to-rose-400">
                        Global Scholarly Network
                    </span>
                </h2>

                <p class="text-sm text-slate-300 max-w-xl mx-auto leading-relaxed">
                    Submit your original manuscript, request an official institutional cPanel academic email account, and connect with peer editors worldwide.
                </p>

                <div class="flex flex-wrap justify-center gap-4 pt-2">
                    <Link
                        :href="route('manuscripts.create')"
                        class="px-8 py-3.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-sm shadow-xl shadow-indigo-500/30 transition duration-300 flex items-center justify-center gap-2"
                    >
                        <span>Submit Manuscript Now</span>
                        <span class="font-mono">→</span>
                    </Link>
                    <Link
                        :href="route('login')"
                        class="px-8 py-3.5 rounded-xl bg-slate-900 hover:bg-slate-800 text-white font-bold text-sm border border-slate-700 shadow-md transition duration-300 flex items-center justify-center gap-2"
                    >
                        <span>Scholar Sign In</span>
                        <span class="font-mono">↗</span>
                    </Link>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
