<script setup>
import { ref, computed } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';
import NotificationBell from '@/Components/KD/NotificationBell.vue';

const page = usePage();
const user = computed(() => page.props.auth?.user);
const theme = computed(() => page.props.theme || {});

const sidebarOpen = ref(false);

const isAdmin = computed(() => {
    return user.value?.roles?.some(r => ['super-admin', 'admin', 'editor'].includes(r.name || r));
});

const navigation = computed(() => {
    const items = [
        { name: 'Dashboard', href: '/dashboard', icon: 'dashboard' },
        { name: 'My Submissions', href: '/dashboard/submissions', icon: 'submissions' },
        { name: 'Peer Reviews', href: '/dashboard/reviews', icon: 'reviews' },
        { name: 'Academic Webmail', href: '/webmail', icon: 'email' },
        { name: 'Browse Journals', href: '/journals', icon: 'journals' },
        { name: 'Books & Monographs', href: '/books', icon: 'books' },
        { name: 'Account Profile', href: '/profile', icon: 'profile' },
    ];

    if (isAdmin.value) {
        items.splice(items.length - 1, 0, { name: 'Admin Cockpit', href: '/admin', icon: 'admin' });
    }

    return items;
});

const isCurrent = (href) => {
    if (href === '/dashboard') return page.url === '/dashboard';
    if (href === '/profile') return page.url === '/profile';
    return page.url.startsWith(href);
};
</script>

<template>
    <div class="min-h-screen bg-slate-50/70 text-slate-800">
        <!-- Mobile sidebar overlay -->
        <Transition
            enter-active-class="transition-opacity duration-200"
            enter-from-class="opacity-0"
            enter-to-class="opacity-100"
            leave-active-class="transition-opacity duration-200"
            leave-from-class="opacity-100"
            leave-to-class="opacity-0"
        >
            <div v-if="sidebarOpen" class="fixed inset-0 z-40 bg-slate-950/60 backdrop-blur-sm lg:hidden" @click="sidebarOpen = false" />
        </Transition>

        <!-- Unified SaaS Obsidian Sidebar -->
        <aside
            :class="[
                'fixed inset-y-0 left-0 z-50 w-64 bg-[#0a101f] text-slate-300 transition-all duration-300 ease-in-out lg:translate-x-0 border-r border-slate-800/80 flex flex-col justify-between shadow-2xl',
                sidebarOpen ? 'translate-x-0' : '-translate-x-full',
            ]"
        >
            <div>
                <!-- Brand Header -->
                <div class="flex items-center gap-3 px-5 h-16 border-b border-slate-800/80 bg-slate-950/40">
                    <Link href="/dashboard" class="flex items-center gap-3">
                        <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-indigo-500 via-purple-500 to-rose-500 flex items-center justify-center shadow-md">
                            <span class="text-white font-bold text-xs tracking-wider">KD</span>
                        </div>
                        <div class="min-w-0 flex-1">
                            <span class="font-bold text-sm text-white tracking-tight truncate block">Knowledge Dynamics</span>
                            <span class="block text-[9px] font-mono text-indigo-400 font-semibold tracking-widest uppercase">Scholar Workspace</span>
                        </div>
                    </Link>
                </div>

                <!-- Navigation List -->
                <nav class="mt-4 px-3 space-y-1">
                    <Link
                        v-for="item in navigation"
                        :key="item.name"
                        :href="item.href"
                        :class="[
                            'flex items-center gap-3 px-3 py-2 text-xs font-semibold rounded-lg transition-all duration-150 relative group',
                            isCurrent(item.href)
                                ? 'bg-gradient-to-r from-indigo-600/90 to-indigo-700/80 text-white shadow-sm ring-1 ring-white/10 font-bold'
                                : 'text-slate-400 hover:bg-slate-900 hover:text-slate-100',
                        ]"
                        @click="sidebarOpen = false"
                    >
                        <span
                            v-if="isCurrent(item.href)"
                            class="absolute left-0 top-1/2 -translate-y-1/2 w-1 h-4 bg-rose-400 rounded-r-full"
                        ></span>

                        <!-- Dynamic Icons -->
                        <svg class="w-4 h-4 shrink-0 transition" :class="isCurrent(item.href) ? 'text-white' : 'text-slate-400 group-hover:text-slate-200'" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path v-if="item.icon === 'dashboard'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
                            <path v-else-if="item.icon === 'submissions'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            <path v-else-if="item.icon === 'reviews'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                            <path v-else-if="item.icon === 'email'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                            <path v-else-if="item.icon === 'journals'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25" />
                            <path v-else-if="item.icon === 'books'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                            <path v-else-if="item.icon === 'admin'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                            <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                        </svg>

                        <span>{{ item.name }}</span>
                    </Link>
                </nav>
            </div>

            <!-- Bottom User Card & Actions -->
            <div class="p-3 border-t border-slate-800/80 bg-slate-950/50">
                <div class="flex items-center gap-3 p-2 rounded-lg bg-slate-900/60 border border-slate-800">
                    <div class="w-8 h-8 rounded-full bg-gradient-to-tr from-indigo-600 to-rose-600 text-white flex items-center justify-center font-bold text-xs shadow-inner">
                        {{ user?.name?.charAt(0) || 'U' }}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-xs font-bold text-slate-100 truncate">{{ user?.name }}</p>
                        <p class="text-[10px] text-slate-400 font-mono truncate">{{ user?.email }}</p>
                    </div>
                </div>

                <div class="mt-2 flex gap-1.5 text-[11px]">
                    <Link href="/" class="flex-1 text-center font-semibold text-slate-400 hover:text-white py-1.5 rounded-md hover:bg-slate-800 transition">
                        View Site
                    </Link>
                    <Link :href="route('logout')" method="post" as="button" class="flex-1 text-center font-semibold text-rose-400 hover:text-rose-300 py-1.5 rounded-md hover:bg-rose-950/40 transition">
                        Sign Out
                    </Link>
                </div>
            </div>
        </aside>

        <!-- Main Content Area -->
        <div class="lg:pl-64 flex flex-col min-h-screen">
            <!-- Modern SaaS Top Header Bar -->
            <header class="sticky top-0 z-30 bg-white/90 backdrop-blur-md border-b border-slate-200/80 shadow-xs">
                <div class="flex items-center justify-between h-16 px-4 sm:px-6 lg:px-8">
                    <!-- Mobile Hamburger -->
                    <button
                        @click="sidebarOpen = !sidebarOpen"
                        class="lg:hidden p-2 text-slate-500 hover:text-slate-800 rounded-lg hover:bg-slate-100"
                    >
                        <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </button>

                    <!-- Header Slot / Breadcrumbs -->
                    <div class="flex-1 min-w-0 pr-4">
                        <slot name="header">
                            <h1 class="text-base font-bold text-slate-900">Scholar Workspace</h1>
                        </slot>
                    </div>

                    <!-- Right Controls -->
                    <div class="flex items-center gap-3 shrink-0">
                        <!-- In-App Notification Bell Dropdown -->
                        <NotificationBell />

                        <div class="h-4 w-px bg-slate-200 hidden sm:block"></div>

                        <Link
                            href="/submissions/new"
                            class="px-3.5 py-1.5 rounded-lg text-xs font-bold text-white shadow-xs flex items-center gap-1.5 transition"
                            :style="{ backgroundColor: theme.primary_color || '#0F2A4A' }"
                        >
                            <span>+</span> New Submission
                        </Link>

                        <div class="h-4 w-px bg-slate-200 hidden sm:block"></div>

                        <Link
                            :href="route('webmail.index')"
                            class="text-xs font-semibold text-slate-600 hover:text-slate-900 bg-slate-100 hover:bg-slate-200 px-3 py-1.5 rounded-full flex items-center gap-1.5 transition"
                        >
                            <span>✉️</span> Webmail
                        </Link>
                    </div>
                </div>
            </header>

            <!-- Flash Notifications -->
            <div v-if="$page.props.flash?.success" class="max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 pt-4">
                <div class="bg-emerald-50 border border-emerald-200 text-emerald-900 p-3 rounded-xl text-xs font-semibold flex items-center justify-between shadow-xs">
                    <span class="flex items-center gap-2">
                        <span>✓</span> {{ $page.props.flash.success }}
                    </span>
                </div>
            </div>

            <div v-if="$page.props.flash?.error" class="max-w-7xl mx-auto w-full px-4 sm:px-6 lg:px-8 pt-4">
                <div class="bg-rose-50 border border-rose-200 text-rose-900 p-3 rounded-xl text-xs font-semibold flex items-center justify-between shadow-xs">
                    <span class="flex items-center gap-2">
                        <span>⚠️</span> {{ $page.props.flash.error }}
                    </span>
                </div>
            </div>

            <!-- Page Body Content -->
            <main class="flex-1 p-4 sm:p-6 lg:p-8 max-w-7xl w-full mx-auto">
                <slot />
            </main>
        </div>
    </div>
</template>
