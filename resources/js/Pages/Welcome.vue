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
        description: 'Professional editing to refine your manuscript for tier-1 indexed journal submission.',
        icon: 'edit',
    },
    {
        title: 'Proofreading',
        description: 'Meticulous language, grammar, terminology, and stylistic refinement for publication readiness.',
        icon: 'check',
    },
    {
        title: 'Academic Formatting',
        description: 'APA 7th, Vancouver, Chicago, Harvard, IEEE — precision formatting for any journal style.',
        icon: 'format',
    },
    {
        title: 'Journal Publishing Support',
        description: 'End-to-end guidance for journal setup, Crossref DOI indexing, and editorial workflow operations.',
        icon: 'publish',
    },
];

const reasons = [
    { title: 'Open Access', description: 'Making research freely accessible to accelerate scientific discovery.', icon: 'open' },
    { title: 'Rigorous Peer Review', description: 'Double-blind, single-blind, and open review models with expert reviewers.', icon: 'review' },
    { title: 'DOI-Ready Architecture', description: 'Every publication prepared for DOI registration and global discoverability.', icon: 'doi' },
    { title: 'Researcher Network', description: 'Build your academic identity and connect with fellow researchers.', icon: 'network' },
];

const topics = [
    'Health Sciences', 'Public Health', 'Clinical Medicine', 'Pharmacy',
    'Food Science & Nutrition', 'Asian Studies', 'Accounting & Finance', 'Business Management',
    'Comparative Religion', 'Biostatistics & Epidemiology', 'Social Sciences', 'Medical Education',
];
</script>

<template>
    <Head>
        <title>Knowledge Dynamics — Research • Publish • Discover</title>
        <meta name="description" content="Knowledge Dynamics is an academic publishing platform for journals, research articles, researcher profiles, and publishing services. Submit your research today." />
        <meta property="og:title" content="Knowledge Dynamics — Research • Publish • Discover" />
        <meta property="og:description" content="Academic publishing platform for journals, research articles, and researcher profiles." />
        <meta property="og:type" content="website" />
    </Head>

    <PublicLayout>
        <!-- ═══════════ HERO ═══════════ -->
        <section class="relative overflow-hidden bg-gradient-to-br from-navy-800 via-navy-900 to-[#070c18] border-b border-navy-700">
            <!-- Decorative pattern -->
            <div class="absolute inset-0 opacity-[0.05]" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');" />

            <div class="container-wide relative py-16 md:py-24 lg:py-28">
                <div class="max-w-3xl">
                    <!-- Eyebrow -->
                    <div class="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm rounded-full px-4 py-1.5 mb-6 border border-white/15">
                        <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
                        <span class="text-xs font-semibold text-white tracking-wide">Academic Publishing Platform</span>
                    </div>

                    <h1 class="text-3xl sm:text-4xl md:text-5xl lg:text-display font-black text-white leading-tight text-balance">
                        Research <span class="text-academic-400">•</span> Publish <span class="text-academic-400">•</span> Discover
                    </h1>

                    <p class="mt-5 text-base md:text-lg text-slate-200 max-w-2xl leading-relaxed font-normal">
                        Knowledge Dynamics is a modern academic publishing platform for journals, scholarly articles, researcher profiles, and publishing services.
                    </p>

                    <!-- CTAs -->
                    <div class="mt-8 flex flex-wrap gap-3.5">
                        <Link href="/journals" class="btn bg-white text-navy-900 hover:bg-slate-100 focus:ring-white btn-lg font-bold shadow-md">
                            Explore Journals
                        </Link>
                        <Link :href="route('manuscripts.create')" class="btn bg-academic-600 hover:bg-academic-500 text-white focus:ring-academic-400 btn-lg font-bold shadow-md">
                            Submit Your Research
                        </Link>
                    </div>

                    <!-- Quick stats -->
                    <div class="mt-12 grid grid-cols-2 sm:grid-cols-4 gap-4">
                        <div class="text-center sm:text-left bg-white/5 p-4 rounded-xl border border-white/10 backdrop-blur-sm">
                            <p class="text-2xl md:text-3xl font-black text-white font-mono">{{ stats.journals || '5+' }}</p>
                            <p class="text-xs text-slate-300 font-medium mt-0.5">Journals</p>
                        </div>
                        <div class="text-center sm:text-left bg-white/5 p-4 rounded-xl border border-white/10 backdrop-blur-sm">
                            <p class="text-2xl md:text-3xl font-black text-academic-300 font-mono">{{ stats.articles || '189+' }}</p>
                            <p class="text-xs text-slate-300 font-medium mt-0.5">Articles Published</p>
                        </div>
                        <div class="text-center sm:text-left bg-white/5 p-4 rounded-xl border border-white/10 backdrop-blur-sm">
                            <p class="text-2xl md:text-3xl font-black text-white font-mono">{{ stats.researchers || '50+' }}</p>
                            <p class="text-xs text-slate-300 font-medium mt-0.5">Researchers</p>
                        </div>
                        <div class="text-center sm:text-left bg-white/5 p-4 rounded-xl border border-white/10 backdrop-blur-sm">
                            <p class="text-2xl md:text-3xl font-black text-emerald-400 font-mono">100%</p>
                            <p class="text-xs text-slate-300 font-medium mt-0.5">Open Access</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════ FEATURED JOURNALS ═══════════ -->
        <section class="section bg-white">
            <div class="container-wide">
                <div class="section-header flex items-end justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-widest text-academic-600 mb-2">Our Journals</p>
                        <h2 class="text-2xl md:text-3xl font-extrabold text-gray-900">Featured Journals</h2>
                    </div>
                    <Link href="/journals" class="hidden sm:inline-flex items-center gap-1 text-sm font-bold text-academic-600 hover:text-academic-800 transition-colors">
                        View All
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4"><path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" /></svg>
                    </Link>
                </div>

                <!-- 5 Journals Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <KdCard hover padding="none" v-for="(journal, i) in (featuredJournals.length ? featuredJournals : [
                        { title: 'Health Dynamics', slug: 'health-dynamics', issn: '3006-5518', description: 'A peer-reviewed, open-access journal publishing original research articles, reviews, and case studies across all disciplines of health sciences.', subjects: ['Health Sciences', 'Public Health', 'Clinical Medicine'] },
                        { title: 'KD Food Science & Nutrition', slug: 'kd-food-science-nutrition', issn: '3006-5526', description: 'Dedicated to publishing high-quality fundamental and applied research across food chemistry, dietary health, nutrition, and food biotechnology.', subjects: ['Food Chemistry', 'Clinical Nutrition', 'Biotechnology'] },
                        { title: 'KD Asian Studies', slug: 'kd-asian-studies', issn: '3006-5534', description: 'Promoting interdisciplinary research on Asian history, society, literature, anthropology, politics, and socioeconomic development.', subjects: ['Asian History', 'Anthropology', 'Political Economy'] },
                        { title: 'KD Accounting, Business, Management, Finance', slug: 'kd-accounting-business-management-finance', issn: '3006-5542', description: 'Publishing cutting-edge research in corporate finance, forensic accounting, managerial dynamics, organizational behavior, and fintech.', subjects: ['Accounting', 'Corporate Finance', 'Fintech'] },
                        { title: 'KD Comparative Religion', slug: 'kd-comparative-religion', issn: '3006-5550', description: 'Scholarly forum for rigorous academic inquiry into theological philosophy, interfaith dialogue, religious sociology, and comparative doctrines.', subjects: ['Theology', 'Religious Ethics', 'Sociology'] },
                    ])" :key="i">
                        <div class="p-6 flex flex-col justify-between h-full">
                            <div>
                                <div class="flex items-start gap-4">
                                    <div class="w-12 h-12 rounded-lg bg-navy-50 border border-navy-100 flex items-center justify-center shrink-0">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-navy-700">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 6.042A8.967 8.967 0 0 0 6 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 0 1 6 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 0 1 6-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0 0 18 18a8.967 8.967 0 0 0-6 2.292m0-14.25v14.25" />
                                        </svg>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <h3 class="text-base font-bold text-gray-900 leading-snug">{{ journal.title }}</h3>
                                        <p class="text-xs font-mono text-gray-500 mt-1">ISSN: {{ journal.issn }}</p>
                                    </div>
                                </div>
                                <p class="mt-4 text-xs text-gray-600 line-clamp-3 leading-relaxed">{{ journal.description }}</p>
                                <div class="mt-4 flex flex-wrap gap-1.5">
                                    <KdBadge variant="primary" size="sm" v-for="subject in (journal.subjects || []).slice(0, 3)" :key="subject">{{ subject }}</KdBadge>
                                    <KdBadge variant="oa" size="sm">Open Access</KdBadge>
                                </div>
                            </div>
                            <div class="border-t border-gray-100 mt-5 pt-3 flex items-center justify-between">
                                <Link :href="`/journals/${journal.slug}`" class="text-xs font-bold text-academic-700 hover:text-academic-900 transition-colors">
                                    View Journal →
                                </Link>
                                <Link :href="`/journals/${journal.slug}/archive`" class="text-xs text-gray-500 hover:text-gray-700 transition-colors">
                                    Archive
                                </Link>
                            </div>
                        </div>
                    </KdCard>
                </div>
            </div>
        </section>

        <!-- ═══════════ LATEST ARTICLES ═══════════ -->
        <section class="section bg-gray-50 border-t border-gray-200">
            <div class="container-wide">
                <div class="section-header flex items-end justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-widest text-academic-600 mb-2">Recent Publications</p>
                        <h2 class="text-2xl md:text-3xl font-extrabold text-gray-900">Latest Articles</h2>
                    </div>
                    <Link href="/articles" class="hidden sm:inline-flex items-center gap-1 text-sm font-bold text-academic-600 hover:text-academic-800 transition-colors">
                        View All
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="w-4 h-4"><path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" /></svg>
                    </Link>
                </div>

                <div class="space-y-4">
                    <KdCard hover padding="none" v-for="(article, i) in (latestArticles.length ? latestArticles : [
                        { title: 'Assessment of knowledge and practice regarding infection control among healthcare workers', journal: 'Health Dynamics', year: 2024, type: 'Original Research', authors: 'Rahman, M.H. et al.' },
                        { title: 'Prevalence of antibiotic resistance patterns in clinical isolates from tertiary hospitals', journal: 'Health Dynamics', year: 2024, type: 'Original Research', authors: 'Karim, S. et al.' },
                        { title: 'Impact of telemedicine on rural healthcare delivery during COVID-19 pandemic', journal: 'Health Dynamics', year: 2024, type: 'Review Article', authors: 'Islam, T. et al.' },
                    ])" :key="i">
                        <div class="p-5 md:p-6 flex flex-col sm:flex-row gap-4">
                            <div class="flex-1 min-w-0">
                                <div class="flex items-center gap-2 mb-2">
                                    <KdBadge variant="info" size="sm">{{ article.type }}</KdBadge>
                                    <span class="text-xs text-gray-500 font-mono font-medium">{{ article.year }}</span>
                                </div>
                                <h3 class="text-base font-bold text-gray-900 line-clamp-2 hover:text-academic-600 transition-colors cursor-pointer">
                                    {{ article.title }}
                                </h3>
                                <p class="mt-1.5 text-xs text-gray-600">{{ article.authors }}</p>
                                <p class="mt-1 text-xs text-academic-700 font-semibold">{{ article.journal }}</p>
                            </div>
                            <div class="flex sm:flex-col items-center gap-2 sm:justify-center shrink-0">
                                <button class="btn-secondary btn-sm text-xs font-bold">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4"><path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" /></svg>
                                    PDF
                                </button>
                            </div>
                        </div>
                    </KdCard>
                </div>

                <div class="mt-8 text-center sm:hidden">
                    <Link href="/articles" class="btn-secondary font-bold">View All Articles</Link>
                </div>
            </div>
        </section>

        <!-- ═══════════ RESEARCH TOPICS ═══════════ -->
        <section class="section bg-white border-t border-gray-200">
            <div class="container-wide">
                <div class="section-header text-center">
                    <p class="text-xs font-bold uppercase tracking-widest text-academic-600 mb-2">Explore by Discipline</p>
                    <h2 class="text-2xl md:text-3xl font-extrabold text-gray-900">Research Topics</h2>
                </div>

                <div class="flex flex-wrap justify-center gap-2.5 max-w-4xl mx-auto">
                    <Link
                        v-for="topic in topics"
                        :key="topic"
                        :href="`/search?q=${encodeURIComponent(topic)}`"
                        class="px-4 py-2 text-xs font-bold text-navy-700 bg-navy-50 border border-navy-100
                               rounded-full hover:bg-navy-700 hover:text-white
                               transition-all duration-150 shadow-xs"
                    >
                        {{ topic }}
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════ PUBLISHING SERVICES ═══════════ -->
        <section class="section bg-gray-50 border-t border-gray-200">
            <div class="container-wide">
                <div class="section-header text-center">
                    <p class="text-xs font-bold uppercase tracking-widest text-academic-600 mb-2">Our Services</p>
                    <h2 class="text-2xl md:text-3xl font-extrabold text-gray-900">Publishing Services</h2>
                    <p class="mt-3 text-xs sm:text-sm text-gray-600 max-w-xl mx-auto leading-relaxed">
                        Expert academic support from manuscript to publication — editing, proofreading, formatting, and journal publishing consultation.
                    </p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
                    <KdCard hover padding="normal" v-for="service in services" :key="service.title">
                        <div class="w-10 h-10 rounded-lg bg-academic-50 flex items-center justify-center mb-4">
                            <svg v-if="service.icon === 'edit'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-academic-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10" />
                            </svg>
                            <svg v-if="service.icon === 'check'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-academic-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 0 1-1.043 3.296 3.745 3.745 0 0 1-3.296 1.043A3.745 3.745 0 0 1 12 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 0 1-3.296-1.043 3.745 3.745 0 0 1-1.043-3.296A3.745 3.745 0 0 1 3 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 0 1 1.043-3.296 3.746 3.746 0 0 1 3.296-1.043A3.746 3.746 0 0 1 12 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 0 1 3.296 1.043 3.746 3.746 0 0 1 1.043 3.296A3.745 3.745 0 0 1 21 12Z" />
                            </svg>
                            <svg v-if="service.icon === 'format'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-academic-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                            </svg>
                            <svg v-if="service.icon === 'publish'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-academic-600">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 0 0 8.716-6.747M12 21a9.004 9.004 0 0 1-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 0 1 7.843 4.582M12 3a8.997 8.997 0 0 0-7.843 4.582m15.686 0A11.953 11.953 0 0 1 12 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0 1 21 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0 1 12 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 0 1 3 12c0-1.605.42-3.113 1.157-4.418" />
                            </svg>
                        </div>
                        <h3 class="text-base font-bold text-gray-900">{{ service.title }}</h3>
                        <p class="mt-2 text-xs text-gray-600 leading-relaxed">{{ service.description }}</p>
                    </KdCard>
                </div>

                <div class="mt-8 text-center">
                    <Link :href="route('services')" class="btn-primary btn-lg font-bold shadow-md">
                        Explore All Services
                    </Link>
                </div>
            </div>
        </section>

        <!-- ═══════════ WHY KNOWLEDGE DYNAMICS ═══════════ -->
        <section class="section bg-white border-t border-gray-200">
            <div class="container-wide">
                <div class="section-header text-center">
                    <p class="text-xs font-bold uppercase tracking-widest text-academic-600 mb-2">Why Choose Us</p>
                    <h2 class="text-2xl md:text-3xl font-extrabold text-gray-900">Why Knowledge Dynamics</h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 max-w-5xl mx-auto">
                    <div v-for="reason in reasons" :key="reason.title" class="text-center p-5 rounded-2xl bg-gray-50 border border-gray-100">
                        <div class="w-14 h-14 rounded-full bg-navy-50 border border-navy-100 flex items-center justify-center mx-auto mb-4">
                            <svg v-if="reason.icon === 'open'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-navy-700">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 10.5V6.75a4.5 4.5 0 1 1 9 0v3.75M3.75 21.75h10.5a2.25 2.25 0 0 0 2.25-2.25v-6.75a2.25 2.25 0 0 0-2.25-2.25H3.75a2.25 2.25 0 0 0-2.25 2.25v6.75a2.25 2.25 0 0 0 2.25 2.25Z" />
                            </svg>
                            <svg v-if="reason.icon === 'review'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-navy-700">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75m-3-7.036A11.959 11.959 0 0 1 3.598 6 11.99 11.99 0 0 0 3 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285Z" />
                            </svg>
                            <svg v-if="reason.icon === 'doi'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-navy-700">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 3.75H6A2.25 2.25 0 0 0 3.75 6v1.5M16.5 3.75H18A2.25 2.25 0 0 1 20.25 6v1.5m0 9V18A2.25 2.25 0 0 1 18 20.25h-1.5m-9 0H6A2.25 2.25 0 0 1 3.75 18v-1.5M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                            </svg>
                            <svg v-if="reason.icon === 'network'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 text-navy-700">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z" />
                            </svg>
                        </div>
                        <h3 class="text-base font-bold text-gray-900">{{ reason.title }}</h3>
                        <p class="mt-2 text-xs text-gray-600 leading-relaxed">{{ reason.description }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ═══════════ CTA BANNER ═══════════ -->
        <section class="bg-navy-900 border-t border-navy-800">
            <div class="container-wide py-12 md:py-16 text-center">
                <h2 class="text-2xl md:text-3xl font-bold text-white">Ready to Share Your Research?</h2>
                <p class="mt-3 text-slate-300 max-w-lg mx-auto text-sm">
                    Join Knowledge Dynamics and contribute to the global academic community. Submit your manuscript today.
                </p>
                <div class="mt-8 flex flex-wrap justify-center gap-3">
                    <Link :href="route('manuscripts.create')" class="btn bg-white text-navy-900 hover:bg-slate-100 focus:ring-white btn-lg font-bold shadow-md">
                        Submit Research
                    </Link>
                    <Link :href="route('register')" class="btn border-2 border-white/30 text-white hover:bg-white/10 focus:ring-white btn-lg font-bold">
                        Create Account
                    </Link>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
