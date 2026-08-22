<script setup>
import { ref, computed } from 'vue';
import { usePage, router, Link } from '@inertiajs/vue3';

const page = usePage();
const notifications = computed(() => page.props.notifications || { unread_count: 0, recent: [] });
const isOpen = ref(false);

const markAllRead = () => {
    router.post(route('notifications.mark_all_read'), {}, {
        preserveScroll: true,
        onSuccess: () => {
            isOpen.value = false;
        },
    });
};

const handleNotificationClick = (item) => {
    if (!item.is_read) {
        router.post(route('notifications.read', item.id), {}, {
            preserveScroll: true,
            preserveState: true,
        });
    }
    isOpen.value = false;
    if (item.link) {
        router.visit(item.link);
    }
};

const timeAgo = (dateStr) => {
    if (!dateStr) return '';
    const diffSec = Math.floor((new Date() - new Date(dateStr)) / 1000);
    if (diffSec < 60) return 'Just now';
    if (diffSec < 3600) return `${Math.floor(diffSec / 60)}m ago`;
    if (diffSec < 86400) return `${Math.floor(diffSec / 3600)}h ago`;
    return new Date(dateStr).toLocaleDateString([], { month: 'short', day: 'numeric' });
};
</script>

<template>
    <div class="relative">
        <!-- Bell Trigger Button -->
        <button
            @click="isOpen = !isOpen"
            class="relative p-2 text-slate-500 hover:text-slate-900 rounded-lg hover:bg-slate-100 transition focus:outline-none"
            title="Notifications"
        >
            <!-- SVG Bell Icon -->
            <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
            </svg>

            <!-- Unread Count Badge -->
            <span
                v-if="notifications.unread_count > 0"
                class="absolute -top-0.5 -right-0.5 min-w-[18px] h-[18px] bg-rose-600 text-white rounded-full text-[10px] font-extrabold flex items-center justify-center px-1 shadow-sm animate-pulse border-2 border-white"
            >
                {{ notifications.unread_count > 99 ? '99+' : notifications.unread_count }}
            </span>
        </button>

        <!-- Backdrop overlay to dismiss -->
        <div
            v-if="isOpen"
            @click="isOpen = false"
            class="fixed inset-0 z-40"
        ></div>

        <!-- Notification Popover Dropdown -->
        <Transition
            enter-active-class="transition duration-150 ease-out"
            enter-from-class="transform scale-95 opacity-0"
            enter-to-class="transform scale-100 opacity-100"
            leave-active-class="transition duration-100 ease-in"
            leave-from-class="transform scale-100 opacity-100"
            leave-to-class="transform scale-95 opacity-0"
        >
            <div
                v-if="isOpen"
                class="absolute right-0 mt-2 w-80 sm:w-96 bg-white rounded-2xl shadow-2xl border border-slate-200/90 z-50 overflow-hidden flex flex-col max-h-[480px]"
            >
                <!-- Dropdown Header -->
                <div class="px-4 py-3 border-b border-slate-100 bg-slate-50/80 flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <span class="font-bold text-xs text-slate-900 uppercase tracking-wider">Notifications</span>
                        <span
                            v-if="notifications.unread_count > 0"
                            class="px-2 py-0.5 rounded-full text-[10px] font-bold bg-rose-100 text-rose-700"
                        >
                            {{ notifications.unread_count }} new
                        </span>
                    </div>

                    <button
                        v-if="notifications.unread_count > 0"
                        @click="markAllRead"
                        class="text-[11px] text-indigo-600 hover:text-indigo-800 font-semibold hover:underline"
                    >
                        Mark all as read
                    </button>
                </div>

                <!-- Notification Feed -->
                <div class="flex-1 overflow-y-auto divide-y divide-slate-100">
                    <div
                        v-for="item in notifications.recent"
                        :key="item.id"
                        @click="handleNotificationClick(item)"
                        class="p-3.5 hover:bg-slate-50 cursor-pointer transition flex items-start gap-3 relative group"
                        :class="{ 'bg-indigo-50/40': !item.is_read }"
                    >
                        <!-- Unread Dot Indicator -->
                        <span
                            v-if="!item.is_read"
                            class="absolute left-1.5 top-1/2 -translate-y-1/2 w-1.5 h-1.5 rounded-full bg-indigo-600"
                        ></span>

                        <!-- Icon Avatar -->
                        <div class="w-8 h-8 rounded-xl bg-slate-100 border border-slate-200/60 flex items-center justify-center text-sm shrink-0 shadow-2xs group-hover:scale-105 transition">
                            {{ item.icon || '🔔' }}
                        </div>

                        <!-- Content Details -->
                        <div class="flex-1 min-w-0">
                            <div class="flex items-center justify-between gap-1 mb-0.5">
                                <h4 class="text-xs font-bold text-slate-900 truncate" :class="{ 'font-extrabold': !item.is_read }">
                                    {{ item.title }}
                                </h4>
                                <span class="text-[10px] text-slate-400 shrink-0 font-mono">
                                    {{ timeAgo(item.created_at) }}
                                </span>
                            </div>
                            <p class="text-[11px] text-slate-600 line-clamp-2 leading-relaxed">
                                {{ item.message }}
                            </p>
                        </div>
                    </div>

                    <!-- Empty State -->
                    <div
                        v-if="!notifications.recent || notifications.recent.length === 0"
                        class="py-10 text-center text-slate-400 space-y-2"
                    >
                        <div class="text-2xl">✨</div>
                        <p class="text-xs font-semibold text-slate-700">All caught up!</p>
                        <p class="text-[11px] text-slate-400">You have no new alerts or notifications.</p>
                    </div>
                </div>
            </div>
        </Transition>
    </div>
</template>
