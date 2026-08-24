<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

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
        description: 'Professional structural and scientific editing to refine your manuscript for tier-1 indexed journals.',
        icon: 'edit',
        color: 'from-indigo-500 to-blue-600',
    },
    {
        title: 'Language Proofreading',
        description: 'Meticulous language, grammar, terminology, and stylistic refinement by native subject experts.',
        icon: 'check',
        color: 'from-emerald-500 to-teal-600',
    },
    {
        title: 'Academic Formatting',
        description: 'APA 7th, Vancouver, Chicago, Harvard, IEEE — precision compliance formatting for any journal style.',
        icon: 'format',
        color: 'from-amber-500 to-orange-600',
    },
    {
        title: 'Journal Publishing & DOI',
        description: 'End-to-end guidance for journal setup, Crossref DOI allocation, and editorial workflow operations.',
        icon: 'publish',
        color: 'from-rose-500 to-pink-600',
    },
];

const reasons = [
    {
        title: 'Gold Open Access',
        description: 'Making research freely accessible worldwide under Creative Commons CC BY 4.0 licenses with full author retention.',
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
        title: 'DOI-Ready Architecture',
        description: 'Instant metadata deposit and persistent Crossref digital object identifier linking for maximum citation impact.',
        icon: 'doi',
        gradient: 'from-rose-500 to-pink-600',
    },
    {
        title: 'Unified Scholar Cockpit',
        description: 'Integrated manuscript submission tracking, reviewer assignment, and official cPanel academic webmail.',
        icon: 'network',
        gradient: 'from-emerald-500 to-teal-600',
    },
];

const topics = [
    'Health Sciences', 'Public Health', 'Clinical Medicine', 'Pharmaceutical Sciences',
    'Food Science & Nutrition', 'Asian Studies', 'Accounting & Finance', 'Business Management',
    'Comparative Religion', 'Biostatistics & Epidemiology', 'Social Sciences', 'Medical Education',
];
</script>

<template>
    <Head>
        <title>Knowledge Dynamics — Global Open Access Academic Publishing & Research</title>
        <meta name="description" content="Knowledge Dynamics is an international academic publisher for peer-reviewed open access journals, books, scholar profiles, and editorial proofreading services." />
        <meta property="og:title" content="Knowledge Dynamics — Research • Publish • Discover" />
        <meta property="og:description" content="Academic publishing platform for journals, research articles, and researcher profiles." />
        <meta property="og:type" content="website" />
    </Head>

    <PublicLayout>
        <!-- ═══════════ 1. HERO SECTION ═══════════ -->
        <section class="relative overflow-hidden bg-gradient-to-br from-[#070c18] via-navy-950 to-navy-900 text-white border-b border-slate-800">
            <!-- Decorative Ambient Glows -->
            <div class="absolute -top-32 -left-32 w-[500px] h-[500px] bg-indigo-600/20 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute -bottom-32 -right-32 w-[500px] h-[500px] bg-rose-600/15 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute inset-0 bg-[linear-gradient(to_right,#ffffff05_1px,transparent_1px),linear-gradient(to_bottom,#ffffff05_1px,transparent_1px)] bg-[size:4rem_4rem] [mask-image:radial-gradient(ellipse_60%_50%_at_50%_50%,#000_70%,transparent_100%)] pointer-events-none"></div>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 py-16 sm:py-20 lg:py-28">
                <div class="max-w-3xl space-y-6">
                    <!-- Eyebrow -->
                    <div class="inline-flex items-center gap-2 bg-gradient-to-r from-indigo-500/20 to-rose-500/20 border border-indigo-500/30 rounded-full px-4 py-1.5 shadow-xs">
                        <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
                        <span class="text-xs font-bold text-indigo-200 tracking-wide whitespace-nowrap">Unified Academic Publishing Platform</span>
                    </div>

                    <!-- Main Headline -->
                    <h1 class="text-3xl sm:text-5xl lg:text-6xl font-black text-white leading-tight tracking-tight">
                        Research <span class="text-indigo-400">•</span> Publish <span class="text-rose-400">•</span> Discover
                    </h1>

                    <!-- Subtitle -->
                    <p class="text-base sm:text-lg text-slate-300 max-w-2xl leading-relaxed font-normal">
                        Knowledge Dynamics is an international open access academic publishing platform empowering scholars with peer-reviewed journals, Crossref DOI allocation, and precision proofreading services.
                    </p>

                    <!-- CTAs with guaranteed single line -->
                    <div class="pt-2 flex flex-wrap items-center gap-3.5">
                        <Link
                            href="/journals"
                            class="px-6 py-3.5 rounded-xl bg-white hover:bg-slate-100 text-slate-900 font-extrabold text-xs sm:text-sm shadow-xl shadow-white/10 transition duration-200 flex items-center justify-center gap-2 whitespace-nowrap"
                        >
                            <span>Explore Journals</span>
                            <span class="font-mono">→</span>
                        </Link>
                        <Link
                            :href="route('manuscripts.create')"
                            class="px-6 py-3.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-xs sm:text-sm shadow-xl shadow-indigo-500/25 transition duration-200 flex items-center justify-center gap-2 whitespace-nowrap"
                        >
                            <span>📝 Submit Manuscript</span>
                        </Link>
                        <Link
                            :href="route('proofreading.index')"
                            class="px-5 py-3.5 rounded-xl text-rose-300 hover:text-rose-200 font-bold text-xs sm:text-sm hover:underline transition flex items-center justify-center gap-1.5 whitespace-nowrap"
                        >
                            <span>KD Proofreading</span>
                            <span>↗</span>
                        </Link>
                    </div>

                    <!-- Quick stats grid -->
                    <div class="pt-6 grid grid-cols-2 sm:grid-cols-4 gap-3 sm:gap-4">
                        <div class="bg-slate-900/80 p-4 rounded-2xl border border-slate-800 backdrop-blur-md shadow-md text-center sm:text-left">
                            <p class="text-2xl sm:text-3xl font-black text-white font-mono">{{ stats.journals || '5+' }}</p>
                            <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5 whitespace-nowrap">Peer Journals</p>
                        </div>
                        <div class="bg-slate-900/80 p-4 rounded-2xl border border-slate-800 backdrop-blur-md shadow-md text-center sm:text-left">
                            <p class="text-2xl sm:text-3xl font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-indigo-300 font-mono">{{ stats.articles || '189+' }}</p>
                            <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5 whitespace-nowrap">Indexed Papers</p>
                        </div>
                        <div class="bg-slate-900/80 p-4 rounded-2xl border border-slate-800 backdrop-blur-md shadow-md text-center sm:text-left">
                            <p class="text-2xl sm:text-3xl font-black text-white font-mono">{{ stats.researchers || '50+' }}</p>
                            <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5 whitespace-nowrap">Global Scholars</p>
                        </div>
                        <div class="bg-slate-900/80 p-4 rounded-2xl border border-slate-800 backdrop-blur-md shadow-md text-center sm:text-left">
                            <p class="text-2xl sm:text-3xl font-black text-rose-400 font-mono">100%</p>
                            <p class="text-[11px] text-slate-400 font-semibold uppercase tracking-wider mt-0.5 whitespace-nowrap">Open Access</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════ 2. FEATURED JOURNALS ═══════════ -->
        <section class="py-20 bg-white border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col sm:flex-row sm:items-end justify-between mb-12 gap-4">
                    <div>
                        <div class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-indigo-50 text-indigo-700 text-xs font-bold uppercase tracking-wider mb-2 border border-indigo-200/80 whitespace-nowrap">
                            <span>📚</span> Peer-Reviewed Portals
                        </div>
                        <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">Official Academic Journals</h2>
                        <p class="text-xs sm:text-sm text-slate-500 mt-1">
                            Double-blind peer-reviewed open access journals with Crossref DOI allocation and COPE ethics.
                        </p>
                    </div>
                    <Link
                        href="/journals"
                        class="inline-flex items-center gap-1 text-xs font-bold text-indigo-600 hover:text-indigo-800 hover:translate-x-1 transition whitespace-nowrap shrink-0"
                    >
                        <span>View All Journals</span>
                        <span class="font-mono">→</span>
                    </Link>
                </div>

                <!-- 5 Journals + 1 Partnership Card (Balanced 6 Cards Grid) -->
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
                                <div class="w-12 h-12 rounded-xl bg-indigo-50 border border-indigo-100 flex items-center justify-center font-bold text-indigo-700 text-lg group-hover:scale-105 transition shrink-0">
                                    📖
                                </div>
                                <span class="px-2.5 py-1 rounded-full text-[10px] font-mono font-bold bg-slate-100 text-slate-700 border border-slate-200 whitespace-nowrap">
                                    ISSN: {{ journal.issn || '3006-5518' }}
                                </span>
                            </div>

                            <div>
                                <h3 class="text-base sm:text-lg font-bold text-slate-900 group-hover:text-indigo-600 transition leading-snug">
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
                                    class="px-2.5 py-0.5 rounded-md text-[10px] font-bold bg-slate-100 text-slate-700 whitespace-nowrap"
                                >
                                    {{ sub }}
                                </span>
                                <span class="px-2 py-0.5 rounded-md text-[10px] font-bold bg-emerald-50 text-emerald-700 border border-emerald-200 whitespace-nowrap">
                                    Open Access
                                </span>
                            </div>
                        </div>

                        <div class="pt-4 mt-4 border-t border-slate-100 flex items-center justify-between gap-2 text-xs font-bold">
                            <a
                                :href="journal.effective_website_url || ('/journals/' + journal.slug)"
                                :target="journal.website_url ? '_blank' : '_self'"
                                class="px-3 py-1.5 rounded-lg bg-indigo-50 hover:bg-indigo-100 text-indigo-700 font-extrabold flex items-center gap-1 transition shadow-xs whitespace-nowrap text-[11px]"
                            >
                                <span>🌐 Journal Website</span>
                                <span class="font-mono text-[10px]">↗</span>
                            </a>
                            <Link :href="`/submit?journal=${journal.slug}`" class="text-slate-500 hover:text-slate-900 whitespace-nowrap text-[11px]">
                                Submit Paper →
                            </Link>
                        </div>
                    </div>

                    <!-- 6th Symmetrical Partnership Card -->
                    <div class="bg-gradient-to-br from-slate-900 to-[#070c18] text-white rounded-2xl border border-slate-800 p-6 shadow-md hover:shadow-2xl hover:-translate-y-1 transition duration-300 flex flex-col justify-between relative overflow-hidden group">
                        <div class="absolute -right-8 -bottom-8 w-40 h-40 bg-indigo-600/20 rounded-full blur-2xl pointer-events-none"></div>

                        <div class="space-y-4 relative z-10">
                            <div class="flex items-start justify-between gap-3">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-md shrink-0">
                                    <div class="w-full h-full bg-[#0a101f] rounded-[10px] flex items-center justify-center text-lg">
                                        🚀
                                    </div>
                                </div>
                                <span class="px-2.5 py-1 rounded-full text-[10px] font-bold bg-indigo-500/20 text-indigo-300 border border-indigo-500/30 whitespace-nowrap">
                                    Partnership
                                </span>
                            </div>

                            <div>
                                <h3 class="text-base sm:text-lg font-bold text-white group-hover:text-indigo-300 transition leading-snug">
                                    Launch or Propose a Journal
                                </h3>
                                <p class="text-xs text-slate-300 mt-2 leading-relaxed">
                                    Partner with Knowledge Dynamics to establish, index, and publish a new peer-reviewed open access academic journal for your institution or society.
                                </p>
                            </div>
                        </div>

                        <div class="pt-5 mt-5 border-t border-slate-800/80 flex items-center justify-between text-xs font-bold relative z-10">
                            <Link :href="route('contact')" class="text-indigo-400 hover:text-indigo-300 flex items-center gap-1 whitespace-nowrap">
                                <span>Get in Touch</span>
                                <span class="font-mono">→</span>
                            </Link>
                            <Link :href="route('books.propose')" class="text-slate-400 hover:text-white whitespace-nowrap">
                                Propose Book
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════ 3. LATEST ARTICLES ═══════════ -->
        <section class="py-20 bg-slate-50 border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex flex-col sm:flex-row sm:items-end justify-between mb-10 gap-4">
                    <div>
                        <div class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-50 text-emerald-700 text-xs font-bold uppercase tracking-wider mb-2 border border-emerald-200/80 whitespace-nowrap">
                            <span>📄</span> Recent Publications
                        </div>
                        <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">Latest Published Articles</h2>
                    </div>
                    <Link href="/articles" class="hidden sm:inline-flex items-center gap-1 text-xs font-bold text-indigo-600 hover:text-indigo-800 transition whitespace-nowrap">
                        <span>View All Articles</span>
                        <span class="font-mono">→</span>
                    </Link>
                </div>

                <div class="space-y-4">
                    <div
                        v-for="(article, i) in (latestArticles.length ? latestArticles : [
                            { title: 'Assessment of knowledge and practice regarding infection control among healthcare workers', journal: 'Health Dynamics', year: 2024, type: 'Original Research', authors: 'Rahman, M.H. et al.' },
                            { title: 'Prevalence of antibiotic resistance patterns in clinical isolates from tertiary hospitals', journal: 'Health Dynamics', year: 2024, type: 'Original Research', authors: 'Karim, S. et al.' },
                            { title: 'Impact of telemedicine on rural healthcare delivery during COVID-19 pandemic', journal: 'Health Dynamics', year: 2024, type: 'Review Article', authors: 'Islam, T. et al.' },
                        ])"
                        :key="i"
                        class="bg-white rounded-2xl p-5 sm:p-6 border border-slate-200/90 shadow-xs hover:shadow-md transition flex flex-col sm:flex-row sm:items-center justify-between gap-4"
                    >
                        <div class="space-y-2 flex-1 min-w-0">
                            <div class="flex items-center gap-2">
                                <span class="px-2 py-0.5 rounded text-[10px] font-bold bg-indigo-50 text-indigo-700 border border-indigo-200 whitespace-nowrap">
                                    {{ article.type }}
                                </span>
                                <span class="text-xs font-mono text-slate-400 whitespace-nowrap">{{ article.year }}</span>
                            </div>
                            <h3 class="text-base font-bold text-slate-900 hover:text-indigo-600 transition cursor-pointer line-clamp-2">
                                {{ article.title }}
                            </h3>
                            <div class="flex flex-wrap items-center gap-3 text-xs text-slate-500">
                                <span>{{ article.authors }}</span>
                                <span>•</span>
                                <span class="font-semibold text-indigo-600">{{ article.journal }}</span>
                            </div>
                        </div>

                        <div class="shrink-0 flex sm:flex-col items-center gap-2">
                            <button class="px-4 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold text-xs flex items-center gap-1.5 transition whitespace-nowrap">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-3.5 h-3.5 text-rose-600"><path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" /></svg>
                                <span>PDF</span>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="mt-8 text-center sm:hidden">
                    <Link href="/articles" class="px-6 py-2.5 rounded-xl bg-slate-900 text-white font-bold text-xs inline-block whitespace-nowrap">
                        View All Articles
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════ 4. PUBLISHING SERVICES ═══════════ -->
        <section class="py-20 bg-white border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center max-w-2xl mx-auto mb-14 space-y-3">
                    <div class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-rose-50 text-rose-700 text-xs font-bold uppercase tracking-wider border border-rose-200/80 whitespace-nowrap">
                        <span>✨</span> KD Proofreading & Services
                    </div>
                    <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">Academic Publishing Services</h2>
                    <p class="text-xs sm:text-sm text-slate-500 leading-relaxed">
                        Expert academic support from manuscript to publication — editing, proofreading, formatting, and journal publishing consultation.
                    </p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div
                        v-for="service in services"
                        :key="service.title"
                        class="bg-slate-50 rounded-2xl p-6 border border-slate-200/90 shadow-xs hover:bg-white hover:shadow-xl hover:-translate-y-1 transition duration-300 flex flex-col justify-between"
                    >
                        <div class="space-y-4">
                            <div class="w-12 h-12 rounded-xl bg-gradient-to-br p-0.5 shadow-md shrink-0" :class="service.color">
                                <div class="w-full h-full bg-white rounded-[10px] flex items-center justify-center text-xl">
                                    {{ service.icon === 'edit' ? '📝' : service.icon === 'check' ? '🔍' : service.icon === 'format' ? '📐' : '🌐' }}
                                </div>
                            </div>
                            <div>
                                <h3 class="text-base font-bold text-slate-900">{{ service.title }}</h3>
                                <p class="text-xs text-slate-500 mt-1.5 leading-relaxed">{{ service.description }}</p>
                            </div>
                        </div>

                        <div class="pt-4 mt-4 border-t border-slate-200/70">
                            <Link :href="route('proofreading.index')" class="text-xs font-bold text-rose-600 hover:text-rose-800 flex items-center gap-1 whitespace-nowrap">
                                <span>Service Details</span>
                                <span class="font-mono">→</span>
                            </Link>
                        </div>
                    </div>
                </div>

                <div class="mt-12 text-center">
                    <Link
                        :href="route('proofreading.index')"
                        class="inline-flex items-center justify-center gap-2 px-8 py-3.5 rounded-xl bg-gradient-to-r from-rose-600 via-pink-600 to-indigo-600 hover:from-rose-500 hover:to-indigo-500 text-white font-extrabold text-xs sm:text-sm shadow-lg shadow-rose-500/25 transition duration-300 whitespace-nowrap"
                    >
                        <span>Calculate Proofreading Fee & Submit</span>
                        <span class="font-mono">→</span>
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════ 5. WHY KNOWLEDGE DYNAMICS ═══════════ -->
        <section class="py-20 bg-slate-50 border-b border-slate-200/80">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center max-w-2xl mx-auto mb-14 space-y-3">
                    <div class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-50 text-emerald-700 text-xs font-bold uppercase tracking-wider border border-emerald-200/80 whitespace-nowrap">
                        <span>🛡️</span> Publication Ethics & Standards
                    </div>
                    <h2 class="text-2xl sm:text-3xl font-extrabold text-slate-900 tracking-tight">Why Choose Knowledge Dynamics</h2>
                    <p class="text-xs sm:text-sm text-slate-500">
                        Built for researchers, reviewers, and institutions who value scientific integrity and worldwide reach.
                    </p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <div
                        v-for="r in reasons"
                        :key="r.title"
                        class="p-6 rounded-2xl bg-white border border-slate-200/90 space-y-4 hover:shadow-lg transition duration-300"
                    >
                        <div class="w-12 h-12 rounded-xl bg-gradient-to-br text-white flex items-center justify-center text-xl shadow-md shrink-0" :class="r.gradient">
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

        <!-- ═══════════ 6. DISCIPLINE TOPICS ═══════════ -->
        <section class="py-16 bg-white border-b border-slate-200/80">
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
                        class="px-4 py-2 rounded-xl bg-slate-50 border border-slate-200 text-slate-700 font-semibold text-xs hover:border-indigo-400 hover:text-indigo-600 hover:bg-white hover:shadow-sm transition duration-200 whitespace-nowrap"
                    >
                        {{ t }}
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════ 7. BOTTOM CTA BANNER ═══════════ -->
        <section class="relative bg-[#070c18] text-white py-20 overflow-hidden">
            <!-- Radiant Background Glows -->
            <div class="absolute -top-20 left-1/4 w-96 h-96 bg-indigo-600/20 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute -bottom-20 right-1/4 w-96 h-96 bg-rose-600/20 rounded-full blur-3xl pointer-events-none"></div>

            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10 space-y-6">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-gradient-to-r from-indigo-500/20 to-rose-500/20 border border-indigo-500/30 text-indigo-300 text-xs font-bold whitespace-nowrap">
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
                        class="px-8 py-3.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-extrabold text-sm shadow-xl shadow-indigo-500/30 transition duration-300 flex items-center justify-center gap-2 whitespace-nowrap"
                    >
                        <span>Submit Manuscript Now</span>
                        <span class="font-mono">→</span>
                    </Link>
                    <Link
                        :href="route('login')"
                        class="px-8 py-3.5 rounded-xl bg-slate-900 hover:bg-slate-800 text-white font-bold text-sm border border-slate-700 shadow-md transition duration-300 flex items-center justify-center gap-2 whitespace-nowrap"
                    >
                        <span>Scholar Sign In</span>
                        <span class="font-mono">↗</span>
                    </Link>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
