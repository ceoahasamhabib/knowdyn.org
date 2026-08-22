<script setup>
import { ref, computed } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';

const props = defineProps({
    title: String,
});

const page = usePage();
const user = computed(() => page.props.auth?.user);

const mobileMenuOpen = ref(false);
const activeDropdown = ref(null);

const toggleDropdown = (name) => {
    activeDropdown.value = activeDropdown.value === name ? null : name;
};

const closeDropdowns = () => {
    activeDropdown.value = null;
};

const journalsList = [
    { name: 'Health Dynamics', href: '/journals/health-dynamics' },
    { name: 'KD Food Science Nutrition', href: '/journals/kd-food-science-nutrition' },
    { name: 'KD Asian Studies', href: '/journals/kd-asian-studies' },
    { name: 'KD Accounting, Business, Management, Finance', href: '/journals/kd-accounting-business-management-finance' },
    { name: 'KD Comparative Religion', href: '/journals/kd-comparative-religion' },
];
</script>

<template>
    <div class="min-h-screen flex flex-col bg-slate-50 text-slate-800 font-sans selection:bg-rose-500 selection:text-white" @click="closeDropdowns">
        <!-- ── Desktop Navigation ────────────────────────────── -->
        <header class="sticky top-0 z-50 bg-white/95 backdrop-blur-md border-b border-slate-200/90 shadow-xs" @click.stop>
            <!-- Top Dark Bar with comfortable padding -->
            <div class="hidden lg:block bg-[#050811] text-slate-300 border-b border-slate-800/80">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-between py-2 text-xs">
                    <div class="flex items-center gap-4 text-slate-400">
                        <span class="flex items-center gap-2 font-medium">
                            <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
                            Research • Publish • Discover
                        </span>
                        <span class="text-slate-700">|</span>
                        <span class="text-slate-400 font-medium">ISSN Registered International Academic Publisher</span>
                    </div>
                    <div class="flex items-center gap-5 font-medium">
                        <Link :href="route('proofreading.index')" class="text-rose-400 hover:text-rose-300 font-bold transition">KD Proofreading</Link>
                        <Link :href="route('books.index')" class="text-slate-300 hover:text-white transition">Books</Link>
                        <Link :href="route('news.index')" class="text-slate-300 hover:text-white transition">News & Events</Link>
                        <span class="text-slate-700">|</span>
                        <template v-if="user">
                            <Link :href="route('dashboard')" class="text-white font-bold hover:text-indigo-300 flex items-center gap-2 transition">
                                <span class="w-2 h-2 rounded-full bg-indigo-400"></span>
                                Dashboard ({{ user.name }})
                            </Link>
                        </template>
                        <template v-else>
                            <Link :href="route('login')" class="text-slate-300 hover:text-white transition">Sign In</Link>
                            <Link :href="route('register')" class="text-indigo-400 hover:text-indigo-300 font-bold transition">Register</Link>
                        </template>
                    </div>
                </div>
            </div>

            <!-- Main Navigation Bar -->
            <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex items-center justify-between h-16 lg:h-[72px]">
                    <!-- Brand Logo -->
                    <Link href="/" class="flex items-center gap-3 group shrink-0">
                        <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-md shadow-indigo-500/20 group-hover:scale-105 transition duration-300">
                            <div class="w-full h-full bg-[#0a101f] rounded-[10px] flex items-center justify-center font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-rose-300 text-sm tracking-wider">
                                KD
                            </div>
                        </div>
                        <div>
                            <span class="font-extrabold text-lg lg:text-xl text-slate-900 tracking-tight flex items-center gap-1.5">
                                Knowledge Dynamics
                                <span class="px-1.5 py-0.5 text-[10px] font-bold bg-indigo-50 text-indigo-700 rounded-md border border-indigo-200">
                                    Scholar
                                </span>
                            </span>
                            <span class="block text-[10px] text-slate-500 tracking-wider uppercase font-semibold">
                                Open Access Publishing & Research
                            </span>
                        </div>
                    </Link>

                    <!-- Desktop Mega Menu Items -->
                    <div class="hidden lg:flex items-center gap-1">
                        <!-- About -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('about')"
                                class="px-3.5 py-2 text-xs font-bold uppercase tracking-wider text-slate-700 hover:text-indigo-600 rounded-lg flex items-center gap-1.5 transition"
                            >
                                About
                                <svg class="w-3.5 h-3.5 text-slate-400 group-hover:text-indigo-600 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('about')" class="dropdown-item font-bold text-slate-900">About Knowledge Dynamics</Link>
                                <Link href="/about#mission" class="dropdown-item">Mission, Vision & History</Link>
                                <Link :href="route('contact')" class="dropdown-item">Contact & Editorial Desk</Link>
                            </div>
                        </div>

                        <!-- Publish with us -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('publish')"
                                class="px-3.5 py-2 text-xs font-bold uppercase tracking-wider text-slate-700 hover:text-indigo-600 rounded-lg flex items-center gap-1.5 transition"
                            >
                                Publish With Us
                                <svg class="w-3.5 h-3.5 text-slate-400 group-hover:text-indigo-600 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('manuscripts.create')" class="dropdown-item font-bold text-indigo-600">Submit Manuscript</Link>
                                <Link :href="route('publish.open_access')" class="dropdown-item">Open Access Policy (CC BY 4.0)</Link>
                                <Link :href="route('books.propose')" class="dropdown-item">Publish Book / Monograph</Link>
                                <Link :href="route('proofreading.index')" class="dropdown-item">Language & Proofreading Services</Link>
                            </div>
                        </div>

                        <!-- Journals -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('journals')"
                                class="px-3.5 py-2 text-xs font-bold uppercase tracking-wider text-slate-700 hover:text-indigo-600 rounded-lg flex items-center gap-1.5 transition"
                            >
                                Journals
                                <svg class="w-3.5 h-3.5 text-slate-400 group-hover:text-indigo-600 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu w-72">
                                <div class="px-3 py-1.5 text-[10px] font-bold text-slate-400 uppercase tracking-wider border-b border-slate-100">
                                    Peer-Reviewed Portals
                                </div>
                                <Link v-for="j in journalsList" :key="j.href" :href="j.href" class="dropdown-item font-medium">
                                    {{ j.name }}
                                </Link>
                                <div class="border-t border-slate-100 mt-1 pt-1">
                                    <Link :href="route('journals.index')" class="dropdown-item font-bold text-indigo-600">
                                        View All Journals →
                                    </Link>
                                </div>
                            </div>
                        </div>

                        <!-- Books -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('books')"
                                class="px-3.5 py-2 text-xs font-bold uppercase tracking-wider text-slate-700 hover:text-indigo-600 rounded-lg flex items-center gap-1.5 transition"
                            >
                                Books
                                <svg class="w-3.5 h-3.5 text-slate-400 group-hover:text-indigo-600 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('books.index')" class="dropdown-item font-bold text-slate-900">Academic Books & Monographs</Link>
                                <Link href="/books?format=ebook" class="dropdown-item">eBooks Catalog</Link>
                                <Link :href="route('books.propose')" class="dropdown-item font-medium text-indigo-600">Propose a Book</Link>
                            </div>
                        </div>

                        <!-- KD Proofreading -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('proofreading')"
                                class="px-3.5 py-2 text-xs font-bold uppercase tracking-wider text-rose-600 hover:text-rose-700 rounded-lg flex items-center gap-1.5 transition"
                            >
                                KD Proofreading
                                <svg class="w-3.5 h-3.5 text-rose-400 group-hover:text-rose-600 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu w-64">
                                <Link :href="route('proofreading.index')" class="dropdown-item font-bold text-slate-900">About KD Proofreading</Link>
                                <div class="px-3 py-1 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Services</div>
                                <Link :href="route('proofreading.index')" class="dropdown-item pl-5">Proofreading & Editing</Link>
                                <Link :href="route('services.show', 'academic-translation')" class="dropdown-item pl-5">Translation</Link>
                                <Link :href="route('services.show', 'academic-formatting')" class="dropdown-item pl-5">Formatting</Link>
                                <Link :href="route('services.show', 'plagiarism-screening')" class="dropdown-item pl-5">Similarity Reduction</Link>
                                <Link :href="route('services.show', 'ai-index-reduction')" class="dropdown-item pl-5">AI Index Reduction</Link>
                                <div class="border-t border-slate-100 mt-1 pt-1">
                                    <Link :href="route('proofreading.freelancers')" class="dropdown-item">Our Expert Freelancers</Link>
                                    <Link href="/proofreading#calculator" class="dropdown-item">Service Fee Calculator</Link>
                                    <Link href="/proofreading#submit" class="dropdown-item font-bold text-rose-600">Submit Document →</Link>
                                </div>
                            </div>
                        </div>

                        <!-- News & Events -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('news')"
                                class="px-3.5 py-2 text-xs font-bold uppercase tracking-wider text-slate-700 hover:text-indigo-600 rounded-lg flex items-center gap-1.5 transition"
                            >
                                News & Events
                                <svg class="w-3.5 h-3.5 text-slate-400 group-hover:text-indigo-600 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('news.index')" class="dropdown-item font-bold text-slate-900">Latest News</Link>
                                <Link :href="route('events.index')" class="dropdown-item">Academic Events</Link>
                                <Link :href="route('news.announcements')" class="dropdown-item">Announcements & Calls</Link>
                                <Link :href="route('events.workshops')" class="dropdown-item">Seminars & Workshops</Link>
                                <Link :href="route('careers.index')" class="dropdown-item font-medium text-indigo-600">Careers & Fellowships</Link>
                            </div>
                        </div>
                    </div>

                    <!-- Right CTAs with centered vertical alignment -->
                    <div class="flex items-center gap-3">
                        <Link
                            :href="route('manuscripts.create')"
                            class="hidden sm:inline-flex items-center justify-center gap-2 px-5 py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-bold text-xs shadow-md shadow-indigo-500/25 transition duration-300"
                        >
                            <span>📝</span>
                            <span>Submit Article</span>
                        </Link>

                        <!-- Mobile Toggle -->
                        <button
                            @click="mobileMenuOpen = !mobileMenuOpen"
                            class="lg:hidden p-2.5 text-slate-700 hover:text-slate-900 rounded-xl bg-slate-100 hover:bg-slate-200 transition"
                        >
                            <svg v-if="!mobileMenuOpen" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                            </svg>
                            <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>
            </nav>

            <!-- Mobile Navigation Drawer -->
            <div v-if="mobileMenuOpen" class="lg:hidden border-t border-slate-200 bg-white px-4 py-5 space-y-4 max-h-[80vh] overflow-y-auto shadow-xl">
                <div class="space-y-2">
                    <div class="font-bold text-xs uppercase text-slate-400 tracking-wider">Navigation</div>
                    <Link href="/" class="block text-sm font-bold text-slate-900" @click="mobileMenuOpen = false">Home</Link>
                    <Link :href="route('journals.index')" class="block text-sm text-slate-700" @click="mobileMenuOpen = false">Journals</Link>
                    <Link :href="route('books.index')" class="block text-sm text-slate-700" @click="mobileMenuOpen = false">Books & Monographs</Link>
                    <Link :href="route('proofreading.index')" class="block text-sm text-rose-600 font-bold" @click="mobileMenuOpen = false">KD Proofreading</Link>
                    <Link :href="route('services')" class="block text-sm text-slate-700" @click="mobileMenuOpen = false">Publishing Services</Link>
                    <Link :href="route('news.index')" class="block text-sm text-slate-700" @click="mobileMenuOpen = false">News & Events</Link>
                    <Link :href="route('about')" class="block text-sm text-slate-700" @click="mobileMenuOpen = false">About KD</Link>
                    <Link :href="route('contact')" class="block text-sm text-slate-700" @click="mobileMenuOpen = false">Contact Us</Link>
                </div>

                <div class="pt-3 border-t border-slate-100 flex flex-col gap-2">
                    <Link :href="route('manuscripts.create')" class="py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 to-rose-600 text-white font-bold text-xs text-center shadow-md" @click="mobileMenuOpen = false">
                        Submit Research Manuscript
                    </Link>
                    <Link v-if="!user" :href="route('login')" class="py-2.5 rounded-xl bg-slate-900 text-white font-bold text-xs text-center" @click="mobileMenuOpen = false">
                        Scholar Sign In →
                    </Link>
                </div>
            </div>
        </header>

        <!-- ── Main Content ──────────────────────────────────── -->
        <main class="flex-1">
            <slot />
        </main>

        <!-- ── Ultra-Modern Multi-Column Academic Footer ─────── -->
        <footer class="bg-[#070c18] text-slate-300 relative overflow-hidden selection:bg-rose-500 selection:text-white border-t border-slate-800">
            <!-- Glowing Multi-Color Top Edge Bar -->
            <div class="h-[2px] w-full bg-gradient-to-r from-blue-500 via-indigo-500 to-rose-500"></div>

            <!-- Ambient Radial Glow Effects -->
            <div class="absolute -top-40 -left-40 w-96 h-96 bg-indigo-600/10 rounded-full blur-3xl pointer-events-none"></div>
            <div class="absolute -bottom-40 -right-40 w-96 h-96 bg-rose-600/10 rounded-full blur-3xl pointer-events-none"></div>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 relative z-10">
                <!-- Top Brand Header in Footer -->
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-6 pb-12 mb-12 border-b border-slate-800/80">
                    <div class="flex items-center gap-3.5">
                        <div class="w-11 h-11 rounded-xl bg-gradient-to-br from-indigo-500 via-blue-600 to-rose-600 p-0.5 shadow-lg shadow-indigo-500/20">
                            <div class="w-full h-full bg-[#0a101f] rounded-[10px] flex items-center justify-center font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-rose-300 text-base tracking-wider">
                                KD
                            </div>
                        </div>
                        <div>
                            <span class="text-white font-extrabold text-xl tracking-tight flex items-center gap-2">
                                Knowledge Dynamics
                                <span class="px-2 py-0.5 text-[10px] font-bold bg-indigo-500/20 text-indigo-300 rounded border border-indigo-500/30">
                                    Scholar
                                </span>
                            </span>
                            <div class="text-xs text-slate-400 mt-0.5">International Academic Publishing & Research Ecosystem</div>
                        </div>
                    </div>
                    <div class="flex flex-wrap gap-3">
                        <Link
                            :href="route('manuscripts.create')"
                            class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white font-bold text-xs shadow-md shadow-indigo-500/20 transition"
                        >
                            Submit Article →
                        </Link>
                        <Link
                            :href="route('proofreading.index')"
                            class="px-5 py-2.5 rounded-xl bg-slate-900 hover:bg-slate-800 border border-slate-700 text-white font-bold text-xs transition"
                        >
                            KD Proofreading
                        </Link>
                    </div>
                </div>

                <!-- 7 Columns Grid -->
                <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-7 gap-8 text-xs">
                    <!-- Col 1: About -->
                    <div class="space-y-3">
                        <h4 class="text-white font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-indigo-400">◆</span> About
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('about')" class="hover:text-white hover:translate-x-0.5 inline-block transition">About KD</Link></li>
                            <li><Link href="/about#mission" class="hover:text-white hover:translate-x-0.5 inline-block transition">Mission & Vision</Link></li>
                            <li><Link :href="route('contact')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Contact Us</Link></li>
                        </ul>
                    </div>

                    <!-- Col 2: Publish with us -->
                    <div class="space-y-3">
                        <h4 class="text-white font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-indigo-400">◆</span> Publish
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('manuscripts.create')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Submit Article</Link></li>
                            <li><Link :href="route('publish.open_access')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Open Access Policy</Link></li>
                            <li><Link :href="route('books.propose')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Publish Book</Link></li>
                            <li><Link :href="route('proofreading.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Language Editing</Link></li>
                        </ul>
                    </div>

                    <!-- Col 3: Journals -->
                    <div class="space-y-3">
                        <h4 class="text-white font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-blue-400">◆</span> Journals
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('journals.show', 'health-dynamics')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Health Dynamics</Link></li>
                            <li><Link :href="route('journals.show', 'kd-food-science-nutrition')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Food Science</Link></li>
                            <li><Link :href="route('journals.show', 'kd-asian-studies')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Asian Studies</Link></li>
                            <li><Link :href="route('journals.show', 'kd-accounting-business-management-finance')" class="hover:text-white hover:translate-x-0.5 inline-block transition">KD ABMF</Link></li>
                            <li><Link :href="route('journals.show', 'kd-comparative-religion')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Comparative Religion</Link></li>
                        </ul>
                    </div>

                    <!-- Col 4: Books -->
                    <div class="space-y-3">
                        <h4 class="text-white font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-indigo-400">◆</span> Books
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('books.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Published Books</Link></li>
                            <li><Link href="/books?format=ebook" class="hover:text-white hover:translate-x-0.5 inline-block transition">eBooks Catalog</Link></li>
                            <li><Link :href="route('books.propose')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Propose a Book</Link></li>
                        </ul>
                    </div>

                    <!-- Col 5: KD Proofreading -->
                    <div class="space-y-3">
                        <h4 class="text-rose-400 font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-rose-400">◆</span> Services
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('proofreading.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Proofreading</Link></li>
                            <li><Link :href="route('services.show', 'manuscript-editing')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Manuscript Editing</Link></li>
                            <li><Link :href="route('services.show', 'academic-translation')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Translation</Link></li>
                            <li><Link :href="route('services.show', 'plagiarism-screening')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Similarity Check</Link></li>
                            <li><Link :href="route('services.show', 'ai-index-reduction')" class="hover:text-white hover:translate-x-0.5 inline-block transition">AI Index Reduction</Link></li>
                        </ul>
                    </div>

                    <!-- Col 6: News & Events -->
                    <div class="space-y-3">
                        <h4 class="text-white font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-emerald-400">◆</span> News
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('news.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Press Releases</Link></li>
                            <li><Link :href="route('events.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Conferences</Link></li>
                            <li><Link :href="route('news.announcements')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Announcements</Link></li>
                            <li><Link :href="route('careers.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Careers</Link></li>
                        </ul>
                    </div>

                    <!-- Col 7: Scholar Portal -->
                    <div class="space-y-3">
                        <h4 class="text-white font-extrabold uppercase tracking-wider text-[11px] border-b border-slate-800 pb-2 flex items-center gap-1.5">
                            <span class="text-indigo-400">◆</span> Portal
                        </h4>
                        <ul class="space-y-2 text-slate-400">
                            <li><Link :href="route('login')" class="text-indigo-400 hover:text-indigo-300 font-bold hover:translate-x-0.5 inline-block transition">Scholar Sign In ↗</Link></li>
                            <li><Link :href="route('webmail.index')" class="text-rose-400 hover:text-rose-300 font-bold hover:translate-x-0.5 inline-block transition">cPanel Webmail ↗</Link></li>
                            <li><Link :href="route('guidelines.show', 'authors')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Author Guidelines</Link></li>
                            <li><Link :href="route('guidelines.show', 'editorial-policies')" class="hover:text-white hover:translate-x-0.5 inline-block transition">COPE Ethics</Link></li>
                            <li><Link :href="route('support.index')" class="hover:text-white hover:translate-x-0.5 inline-block transition">Help Desk</Link></li>
                        </ul>
                    </div>
                </div>

                <!-- Bottom Copyright Bar -->
                <div class="mt-14 pt-8 border-t border-slate-800/80 flex flex-col sm:flex-row items-center justify-between text-xs text-slate-500 gap-4">
                    <div class="flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-emerald-400"></span>
                        <span>&copy; {{ new Date().getFullYear() }} Knowledge Dynamics Publishing. All rights reserved.</span>
                    </div>
                    <div class="flex flex-wrap gap-4 text-slate-400">
                        <Link :href="route('publish.open_access')" class="hover:text-white">Open Access (CC BY 4.0)</Link>
                        <span>•</span>
                        <Link :href="route('guidelines.show', 'editorial-policies')" class="hover:text-white">COPE Publishing Ethics</Link>
                        <span>•</span>
                        <Link :href="route('contact')" class="hover:text-white">Editorial Office</Link>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</template>

<style scoped>
.dropdown-menu {
    @apply absolute left-0 top-full mt-1 bg-white border border-slate-200/90 rounded-2xl shadow-xl py-2 hidden group-hover:block z-50 min-w-[220px] transition-all;
}

.dropdown-item {
    @apply block px-4 py-2 text-xs text-slate-700 hover:bg-slate-50 hover:text-indigo-600 transition-colors;
}
</style>
