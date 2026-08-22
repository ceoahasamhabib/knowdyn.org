<script setup>
import { ref, computed } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';

const props = defineProps({
    title: String,
});

const page = usePage();
const user = computed(() => page.props.auth?.user);

const mobileMenuOpen = ref(false);
const searchOpen = ref(false);
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

const mobileNav = [
    { name: 'Home', href: '/', icon: 'home' },
    { name: 'Journals', href: '/journals', icon: 'journal' },
    { name: 'Search', href: '/search', icon: 'search' },
    { name: 'Services', href: '/services', icon: 'services' },
    { name: 'Profile', href: '/login', icon: 'profile' },
];
</script>

<template>
    <div class="min-h-screen flex flex-col bg-white text-gray-800" @click="closeDropdowns">
        <!-- ── Desktop Navigation ────────────────────────────── -->
        <header class="sticky top-0 z-50 bg-white border-b border-gray-200 shadow-sm" @click.stop>
            <!-- Top bar -->
            <div class="hidden lg:block bg-navy-900 text-white">
                <div class="container-wide flex items-center justify-between py-1.5 text-xs">
                    <div class="flex items-center gap-4 text-navy-200">
                        <span>Research • Publish • Discover</span>
                        <span class="text-navy-500">|</span>
                        <span>ISSN Registered International Publisher</span>
                    </div>
                    <div class="flex items-center gap-4">
                        <Link :href="route('proofreading.index')" class="text-academic-300 hover:text-white font-medium">KD Proofreading</Link>
                        <Link :href="route('books.index')" class="text-navy-200 hover:text-white">Books</Link>
                        <Link :href="route('news.index')" class="text-navy-200 hover:text-white">News & Events</Link>
                        <span class="text-navy-600">|</span>
                        <template v-if="user">
                            <Link :href="route('dashboard')" class="text-white font-semibold hover:text-academic-300">Dashboard ({{ user.name }})</Link>
                        </template>
                        <template v-else>
                            <Link :href="route('login')" class="text-navy-100 hover:text-white">Login</Link>
                            <Link :href="route('register')" class="text-navy-100 hover:text-white">Register</Link>
                        </template>
                    </div>
                </div>
            </div>

            <!-- Main Navigation Bar -->
            <nav class="container-wide">
                <div class="flex items-center justify-between h-16 lg:h-[70px]">
                    <!-- Brand Logo -->
                    <Link href="/" class="flex items-center gap-3 shrink-0">
                        <div class="w-9 h-9 lg:w-10 lg:h-10 border-2 border-amber-600 bg-white rounded flex items-center justify-center shadow-sm">
                            <span class="text-navy-900 font-extrabold text-base lg:text-lg font-serif">KD</span>
                        </div>
                        <div>
                            <span class="text-navy-900 font-bold text-lg lg:text-xl tracking-tight font-serif">Knowledge Dynamics</span>
                            <div class="text-[10px] text-gray-500 tracking-wider uppercase font-medium">Academic Publishing</div>
                        </div>
                    </Link>

                    <!-- Desktop Mega Menu Items -->
                    <div class="hidden lg:flex items-center gap-1">
                        <!-- About -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('about')"
                                class="px-3 py-2 text-sm font-semibold text-gray-700 hover:text-navy-900 rounded flex items-center gap-1"
                            >
                                About
                                <svg class="w-3.5 h-3.5 text-gray-400 group-hover:text-navy-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('about')" class="dropdown-item font-semibold text-navy-900">About KD</Link>
                                <Link href="/about#mission" class="dropdown-item">Mission & History</Link>
                                <Link :href="route('contact')" class="dropdown-item">Contact us</Link>
                            </div>
                        </div>

                        <!-- Publish with us -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('publish')"
                                class="px-3 py-2 text-sm font-semibold text-gray-700 hover:text-navy-900 rounded flex items-center gap-1"
                            >
                                Publish with us
                                <svg class="w-3.5 h-3.5 text-gray-400 group-hover:text-navy-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('manuscripts.create')" class="dropdown-item font-semibold text-navy-900">Submit article</Link>
                                <Link :href="route('publish.open_access')" class="dropdown-item">Open access policy</Link>
                                <Link :href="route('books.propose')" class="dropdown-item">Publish book / monograph</Link>
                                <Link :href="route('proofreading.index')" class="dropdown-item">Language & editing services</Link>
                            </div>
                        </div>

                        <!-- Journals -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('journals')"
                                class="px-3 py-2 text-sm font-semibold text-gray-700 hover:text-navy-900 rounded flex items-center gap-1"
                            >
                                Journals
                                <svg class="w-3.5 h-3.5 text-gray-400 group-hover:text-navy-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu w-72">
                                <div class="px-3 py-1.5 text-[11px] font-bold text-gray-400 uppercase tracking-wider border-b border-gray-100">
                                    Official Journals
                                </div>
                                <Link v-for="j in journalsList" :key="j.href" :href="j.href" class="dropdown-item">
                                    {{ j.name }}
                                </Link>
                                <div class="border-t border-gray-100 mt-1 pt-1">
                                    <Link :href="route('journals.index')" class="dropdown-item font-bold text-navy-800">
                                        View All Journals →
                                    </Link>
                                </div>
                            </div>
                        </div>

                        <!-- Books -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('books')"
                                class="px-3 py-2 text-sm font-semibold text-gray-700 hover:text-navy-900 rounded flex items-center gap-1"
                            >
                                Books
                                <svg class="w-3.5 h-3.5 text-gray-400 group-hover:text-navy-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('books.index')" class="dropdown-item font-semibold text-navy-900">Published books</Link>
                                <Link href="/books?format=ebook" class="dropdown-item">eBooks</Link>
                                <Link :href="route('books.propose')" class="dropdown-item font-medium text-academic-700">Propose a book</Link>
                            </div>
                        </div>

                        <!-- KD Proofreading -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('proofreading')"
                                class="px-3 py-2 text-sm font-semibold text-academic-700 hover:text-academic-900 rounded flex items-center gap-1"
                            >
                                KD Proofreading
                                <svg class="w-3.5 h-3.5 text-academic-500 group-hover:text-academic-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu w-64">
                                <Link :href="route('proofreading.index')" class="dropdown-item font-bold text-navy-900">About KD Proofreading</Link>
                                <div class="px-3 py-1 text-[10px] font-bold text-gray-400 uppercase tracking-wider">Services</div>
                                <Link :href="route('proofreading.index')" class="dropdown-item pl-5">Proofreading & Editing</Link>
                                <Link :href="route('services.show', 'academic-translation')" class="dropdown-item pl-5">Translation</Link>
                                <Link :href="route('services.show', 'academic-formatting')" class="dropdown-item pl-5">Formatting</Link>
                                <Link :href="route('services.show', 'plagiarism-screening')" class="dropdown-item pl-5">Similarity reduction</Link>
                                <Link :href="route('services.show', 'ai-index-reduction')" class="dropdown-item pl-5">AI index reduction</Link>
                                <Link :href="route('services.show', 'publication-consultancy')" class="dropdown-item pl-5">Publication consultation</Link>
                                <div class="border-t border-gray-100 mt-1 pt-1">
                                    <Link :href="route('proofreading.freelancers')" class="dropdown-item">Our freelancers</Link>
                                    <Link href="/proofreading#calculator" class="dropdown-item">Service fee calculator</Link>
                                    <Link href="/proofreading#submit" class="dropdown-item font-semibold text-navy-800">Submit document</Link>
                                    <Link :href="route('contact')" class="dropdown-item">Contact us</Link>
                                </div>
                            </div>
                        </div>

                        <!-- News and Events -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('news')"
                                class="px-3 py-2 text-sm font-semibold text-gray-700 hover:text-navy-900 rounded flex items-center gap-1"
                            >
                                News & Events
                                <svg class="w-3.5 h-3.5 text-gray-400 group-hover:text-navy-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu">
                                <Link :href="route('news.index')" class="dropdown-item font-semibold text-navy-900">News</Link>
                                <Link :href="route('events.index')" class="dropdown-item">Events</Link>
                                <Link :href="route('news.announcements')" class="dropdown-item">Announcement</Link>
                                <Link :href="route('events.workshops')" class="dropdown-item">Seminar and Workshop</Link>
                                <Link :href="route('careers.index')" class="dropdown-item font-medium text-navy-800">Career & Fellowships</Link>
                            </div>
                        </div>

                        <!-- More -->
                        <div class="relative group">
                            <button
                                @click="toggleDropdown('more')"
                                class="px-3 py-2 text-sm font-semibold text-gray-700 hover:text-navy-900 rounded flex items-center gap-1"
                            >
                                More
                                <svg class="w-3.5 h-3.5 text-gray-400 group-hover:text-navy-700 transition" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                            <div class="dropdown-menu w-72 right-0 left-auto">
                                <div class="px-3 py-1 text-[11px] font-bold text-gray-400 uppercase tracking-wider">For Librarians</div>
                                <Link :href="route('librarians.faqs')" class="dropdown-item pl-5">FAQs for print, eprint, reprint</Link>
                                <Link :href="route('librarians.catalogue')" class="dropdown-item pl-5">Catalogue</Link>
                                <Link :href="route('librarians.order_print')" class="dropdown-item pl-5">Order print</Link>

                                <div class="px-3 py-1 mt-2 text-[11px] font-bold text-gray-400 uppercase tracking-wider border-t border-gray-100">
                                    For Authors, Editors, Reviewers
                                </div>
                                <Link :href="route('guidelines.show', 'authors')" class="dropdown-item pl-5">Author guidelines</Link>
                                <Link :href="route('guidelines.show', 'editorial-policies')" class="dropdown-item pl-5">Editorial policies</Link>
                                <Link :href="route('guidelines.show', 'reviewers')" class="dropdown-item pl-5">Reviewer Guidelines</Link>

                                <div class="border-t border-gray-100 mt-2 pt-1">
                                    <Link :href="route('support.index')" class="dropdown-item">Help and support</Link>
                                    <Link :href="route('feedback.index')" class="dropdown-item">Feedback</Link>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right CTAs -->
                    <div class="flex items-center gap-2">
                        <Link :href="route('manuscripts.create')" class="hidden lg:inline-flex btn-primary text-xs py-2 px-4 shadow-sm">
                            Submit Article
                        </Link>

                        <!-- Mobile Toggle -->
                        <button
                            @click="mobileMenuOpen = !mobileMenuOpen"
                            class="lg:hidden p-2 text-gray-700 hover:text-navy-900 rounded-md"
                        >
                            <svg v-if="!mobileMenuOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                            </svg>
                            <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>
            </nav>

            <!-- Mobile Navigation Drawer -->
            <div v-if="mobileMenuOpen" class="lg:hidden border-t border-gray-200 bg-white px-4 py-4 space-y-4 max-h-[80vh] overflow-y-auto">
                <div class="space-y-2">
                    <div class="font-bold text-xs uppercase text-gray-400">Main Sections</div>
                    <Link href="/" class="block text-sm font-semibold text-gray-800" @click="mobileMenuOpen = false">Home</Link>
                    <Link :href="route('about')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">About KD</Link>
                    <Link :href="route('journals.index')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">Journals</Link>
                    <Link :href="route('books.index')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">Books & Monographs</Link>
                    <Link :href="route('proofreading.index')" class="block text-sm text-academic-700 font-semibold" @click="mobileMenuOpen = false">KD Proofreading</Link>
                    <Link :href="route('services')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">Publishing Services</Link>
                    <Link :href="route('news.index')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">News & Events</Link>
                    <Link :href="route('librarians.index')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">For Librarians</Link>
                    <Link :href="route('guidelines.show', 'authors')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">Guidelines</Link>
                    <Link :href="route('contact')" class="block text-sm text-gray-700" @click="mobileMenuOpen = false">Contact Us</Link>
                </div>

                <div class="pt-3 border-t border-gray-100">
                    <Link :href="route('manuscripts.create')" class="btn-primary text-xs w-full py-2.5 shadow-sm text-center" @click="mobileMenuOpen = false">
                        Submit Research Manuscript
                    </Link>
                </div>
            </div>
        </header>

        <!-- ── Main Content ──────────────────────────────────── -->
        <main class="flex-1 pb-16 lg:pb-0">
            <slot />
        </main>

        <!-- ── Multi-Column Academic Footer ───────────────────── -->
        <footer class="bg-navy-900 text-navy-100 border-t border-navy-800">
            <div class="container-wide py-14">
                <!-- Top Brand Header in Footer -->
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 pb-8 mb-8 border-b border-navy-800">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 border-2 border-amber-500 bg-white rounded flex items-center justify-center shadow-sm">
                            <span class="text-navy-900 font-extrabold text-base font-serif">KD</span>
                        </div>
                        <div>
                            <span class="text-white font-bold text-xl font-serif">Knowledge Dynamics</span>
                            <div class="text-xs text-navy-400">International Academic Publishing & Research Ecosystem</div>
                        </div>
                    </div>
                    <div class="flex gap-3">
                        <Link :href="route('manuscripts.create')" class="btn-primary text-xs py-2 px-5 shadow-sm">Submit Article</Link>
                        <Link :href="route('proofreading.index')" class="btn-secondary text-xs py-2 px-5 bg-navy-800 border-navy-700 text-white hover:bg-navy-700">KD Proofreading</Link>
                    </div>
                </div>

                <!-- 7 Columns Grid Matching Sitemap -->
                <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-7 gap-8 text-xs">
                    <!-- Col 1: About -->
                    <div class="space-y-3">
                        <h4 class="text-white font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">About</h4>
                        <ul class="space-y-2 text-navy-300">
                            <li><Link :href="route('about')" class="hover:text-white transition">About KD</Link></li>
                            <li><Link href="/about#mission" class="hover:text-white transition">Mission, History</Link></li>
                            <li><Link :href="route('contact')" class="hover:text-white transition">Contact us</Link></li>
                        </ul>
                    </div>

                    <!-- Col 2: Publish with us -->
                    <div class="space-y-3">
                        <h4 class="text-white font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">Publish with us</h4>
                        <ul class="space-y-2 text-navy-300">
                            <li><Link :href="route('manuscripts.create')" class="hover:text-white transition">Submit article</Link></li>
                            <li><Link :href="route('publish.open_access')" class="hover:text-white transition">Open access</Link></li>
                            <li><Link :href="route('books.propose')" class="hover:text-white transition">Publish book</Link></li>
                            <li><Link :href="route('proofreading.index')" class="hover:text-white transition">Language service</Link></li>
                        </ul>
                    </div>

                    <!-- Col 3: Journals -->
                    <div class="space-y-3">
                        <h4 class="text-white font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">Journals</h4>
                        <ul class="space-y-2 text-navy-300">
                            <li><Link :href="route('journals.show', 'health-dynamics')" class="hover:text-white transition">Health Dynamics</Link></li>
                            <li><Link :href="route('journals.show', 'kd-food-science-nutrition')" class="hover:text-white transition">KD Food Science Nutrition</Link></li>
                            <li><Link :href="route('journals.show', 'kd-asian-studies')" class="hover:text-white transition">KD Asian Studies</Link></li>
                            <li><Link :href="route('journals.show', 'kd-accounting-business-management-finance')" class="hover:text-white transition">KD ABMF</Link></li>
                            <li><Link :href="route('journals.show', 'kd-comparative-religion')" class="hover:text-white transition">KD Comparative Religion</Link></li>
                        </ul>
                    </div>

                    <!-- Col 4: Books -->
                    <div class="space-y-3">
                        <h4 class="text-white font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">Books</h4>
                        <ul class="space-y-2 text-navy-300">
                            <li><Link :href="route('books.index')" class="hover:text-white transition">Published books</Link></li>
                            <li><Link href="/books?format=ebook" class="hover:text-white transition">eBooks</Link></li>
                            <li><Link :href="route('books.propose')" class="hover:text-white transition">Propose a book</Link></li>
                        </ul>
                    </div>

                    <!-- Col 5: KD Proofreading -->
                    <div class="space-y-3">
                        <h4 class="text-academic-300 font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">KD Proofreading</h4>
                        <ul class="space-y-2 text-navy-300">
                            <li><Link :href="route('proofreading.index')" class="hover:text-white transition">About us</Link></li>
                            <li><Link :href="route('proofreading.index')" class="hover:text-white transition">Proofreading</Link></li>
                            <li><Link :href="route('services.show', 'manuscript-editing')" class="hover:text-white transition">Editing</Link></li>
                            <li><Link :href="route('services.show', 'academic-translation')" class="hover:text-white transition">Translation</Link></li>
                            <li><Link :href="route('services.show', 'academic-formatting')" class="hover:text-white transition">Formatting</Link></li>
                            <li><Link :href="route('services.show', 'plagiarism-screening')" class="hover:text-white transition">Similarity reduction</Link></li>
                            <li><Link :href="route('services.show', 'ai-index-reduction')" class="hover:text-white transition">AI index reduction</Link></li>
                            <li><Link :href="route('services.show', 'publication-consultancy')" class="hover:text-white transition">Publication consultation</Link></li>
                            <li><Link :href="route('proofreading.freelancers')" class="hover:text-white transition">Our freelancers</Link></li>
                            <li><Link href="/proofreading#calculator" class="hover:text-white transition">Service fee</Link></li>
                            <li><Link href="/proofreading#submit" class="hover:text-white transition">Submit document</Link></li>
                        </ul>
                    </div>

                    <!-- Col 6: News and Events -->
                    <div class="space-y-3">
                        <h4 class="text-white font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">News and Events</h4>
                        <ul class="space-y-2 text-navy-300">
                            <li><Link :href="route('news.index')" class="hover:text-white transition">News</Link></li>
                            <li><Link :href="route('events.index')" class="hover:text-white transition">Events</Link></li>
                            <li><Link :href="route('news.announcements')" class="hover:text-white transition">Announcement</Link></li>
                            <li><Link :href="route('events.workshops')" class="hover:text-white transition">Seminar and Workshop</Link></li>
                            <li><Link :href="route('careers.index')" class="hover:text-white transition">Career</Link></li>
                        </ul>
                    </div>

                    <!-- Col 7: More -->
                    <div class="space-y-3">
                        <h4 class="text-white font-bold uppercase tracking-wider text-[11px] border-b border-navy-800 pb-1.5">More</h4>
                        
                        <div class="font-semibold text-navy-200 mt-2">For Librarians</div>
                        <ul class="space-y-1.5 text-navy-400 pl-1.5">
                            <li><Link :href="route('librarians.faqs')" class="hover:text-white transition">FAQs for print, eprint, reprint</Link></li>
                            <li><Link :href="route('librarians.catalogue')" class="hover:text-white transition">Catalogue</Link></li>
                            <li><Link :href="route('librarians.order_print')" class="hover:text-white transition">Order print</Link></li>
                        </ul>

                        <div class="font-semibold text-navy-200 mt-2">For Authors & Reviewers</div>
                        <ul class="space-y-1.5 text-navy-400 pl-1.5">
                            <li><Link :href="route('guidelines.show', 'authors')" class="hover:text-white transition">Author guidelines</Link></li>
                            <li><Link :href="route('guidelines.show', 'editorial-policies')" class="hover:text-white transition">Editorial policies</Link></li>
                            <li><Link :href="route('guidelines.show', 'reviewers')" class="hover:text-white transition">Reviewer Guidelines</Link></li>
                        </ul>

                        <div class="pt-2 border-t border-navy-800 space-y-1.5">
                            <div><Link :href="route('support.index')" class="hover:text-white transition text-navy-300">Help and support</Link></div>
                            <div><Link :href="route('feedback.index')" class="hover:text-white transition text-navy-300">Feedback</Link></div>
                        </div>
                    </div>
                </div>

                <!-- Bottom Copyright -->
                <div class="mt-12 pt-6 border-t border-navy-800 flex flex-col sm:flex-row items-center justify-between text-xs text-navy-400">
                    <div>&copy; {{ new Date().getFullYear() }} Knowledge Dynamics. All rights reserved. Registered Academic Publisher.</div>
                    <div class="flex gap-4 mt-2 sm:mt-0">
                        <Link :href="route('publish.open_access')" class="hover:text-white">Open Access (CC BY 4.0)</Link>
                        <span>•</span>
                        <Link :href="route('guidelines.show', 'editorial-policies')" class="hover:text-white">COPE Ethics</Link>
                        <span>•</span>
                        <Link :href="route('contact')" class="hover:text-white">Contact</Link>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</template>

<style scoped>
.dropdown-menu {
    @apply absolute left-0 top-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg py-2 hidden group-hover:block z-50 min-w-[200px];
}

.dropdown-item {
    @apply block px-4 py-1.5 text-xs text-gray-700 hover:bg-navy-50 hover:text-navy-900 transition-colors;
}
</style>
