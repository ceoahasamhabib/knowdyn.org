<script setup>
import { ref, computed } from 'vue';
import { Head, Link, useForm, router, usePage } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const props = defineProps({
    emailAccount: {
        type: Object,
        default: null,
    },
    defaultDomain: {
        type: String,
        default: 'kdpub.com',
    },
    currentFolder: {
        type: String,
        default: 'inbox',
    },
    messages: {
        type: Array,
        default: () => [],
    },
    activeMessage: {
        type: Object,
        default: null,
    },
    unreadInboxCount: {
        type: Number,
        default: 0,
    },
    cpanelSsoUrl: {
        type: String,
        default: null,
    },
});

// Application Form
const applyForm = useForm({
    requested_username: '',
});

const submitApplication = () => {
    applyForm.post(route('webmail.apply'), {
        preserveScroll: true,
        onSuccess: () => applyForm.reset(),
    });
};

// Compose Email Modal
const composeOpen = ref(false);
const composeForm = useForm({
    to_email: '',
    cc_email: '',
    subject: '',
    body: '',
});

const openCompose = (replyTo = null, replySubject = '') => {
    composeForm.reset();
    if (replyTo) {
        composeForm.to_email = replyTo;
        composeForm.subject = replySubject.startsWith('Re: ') ? replySubject : `Re: ${replySubject}`;
    }
    composeOpen.value = true;
};

const sendEmail = () => {
    composeForm.post(route('webmail.send'), {
        preserveScroll: true,
        onSuccess: () => {
            composeOpen.value = false;
            composeForm.reset();
        },
    });
};

const selectMessage = (msg) => {
    router.get(route('webmail.index'), {
        folder: props.currentFolder,
        message_id: msg.id,
    }, { preserveState: true, replace: true, preserveScroll: true });
};

const toggleStar = (msg) => {
    router.post(route('webmail.star', msg.id), {}, { preserveScroll: true });
};

const deleteMsg = (msg) => {
    router.delete(route('webmail.delete', msg.id), { preserveScroll: true });
};

const searchQuery = ref('');
const filteredMessages = computed(() => {
    if (!searchQuery.value) return props.messages;
    const q = searchQuery.value.toLowerCase();
    return props.messages.filter(m =>
        (m.subject && m.subject.toLowerCase().includes(q)) ||
        (m.from_name && m.from_name.toLowerCase().includes(q)) ||
        (m.from_email && m.from_email.toLowerCase().includes(q))
    );
});
</script>

<template>
    <Head title="Academic Webmail — Knowledge Dynamics" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div class="flex items-center gap-3">
                    <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-rose-500 to-pink-600 text-white flex items-center justify-center font-bold text-sm shadow-sm">
                        ✉️
                    </div>
                    <div>
                        <h1 class="text-xl font-bold text-slate-900">Institutional Academic Webmail</h1>
                        <p class="text-xs text-slate-500">Official researcher mailbox, scholarly peer correspondence & cPanel Webmail SSO.</p>
                    </div>
                </div>

                <!-- Compact cPanel Webmail SSO Quick Button -->
                <div v-if="emailAccount && emailAccount.status === 'active'" class="flex items-center gap-2">
                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg text-xs font-mono font-bold bg-slate-100 text-slate-800 border border-slate-200">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                        {{ emailAccount.full_email }}
                    </span>

                    <a
                        :href="route('webmail.cpanel_sso')"
                        target="_blank"
                        class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-amber-500 hover:bg-amber-600 text-white font-bold text-xs shadow-2xs transition group"
                        title="1-Click Direct Login to cPanel Roundcube Webmail"
                    >
                        <span>⚡</span>
                        <span>cPanel SSO</span>
                        <span class="text-[10px] text-amber-200 group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition font-mono">↗</span>
                    </a>
                </div>
            </div>
        </template>

        <div class="space-y-6">
            <!-- ════════════════════════════════════════════════════════════ -->
            <!-- SCENARIO 1: USER DOES NOT HAVE ACTIVE EMAIL YET             -->
            <!-- ════════════════════════════════════════════════════════════ -->
            <div v-if="!emailAccount || emailAccount.status !== 'active'" class="space-y-6 max-w-2xl mx-auto">
                <!-- Apply Banner Card -->
                <div class="bg-gradient-to-br from-slate-950 via-slate-900 to-indigo-950 rounded-2xl p-8 text-white shadow-xl relative overflow-hidden">
                    <div class="relative z-10 space-y-4">
                        <div class="inline-block px-3 py-1 rounded-full bg-white/10 text-xs font-bold uppercase tracking-wider text-rose-300 backdrop-blur-md border border-white/10">
                            🎓 Personalized Scholar Email
                        </div>
                        <h2 class="text-2xl sm:text-3xl font-extrabold tracking-tight font-serif">
                            Get Your Official @{{ defaultDomain }} Academic Email
                        </h2>
                        <p class="text-xs sm:text-sm text-slate-300 leading-relaxed">
                            Publishers, editors, and peer reviewers trust verified institutional email accounts. Apply now to activate your personalized mailbox with full Webmail access and 1-Click cPanel SSO integration.
                        </p>
                    </div>

                    <div class="absolute -right-10 -bottom-10 w-48 h-48 rounded-full bg-indigo-500/10 blur-3xl pointer-events-none"></div>
                </div>

                <!-- Status / Application Form Card -->
                <div class="bg-white rounded-2xl border border-slate-200/80 p-6 md:p-8 shadow-xs">
                    <!-- If Pending -->
                    <div v-if="emailAccount && emailAccount.status === 'pending'" class="text-center py-6 space-y-3">
                        <div class="w-12 h-12 rounded-full bg-amber-100 text-amber-700 flex items-center justify-center text-xl mx-auto">
                            ⏳
                        </div>
                        <h3 class="text-base font-bold text-slate-900">Application Submitted — Under Editorial Review</h3>
                        <p class="text-xs text-slate-500 max-w-md mx-auto">
                            You requested <span class="font-mono font-bold text-slate-900">{{ emailAccount.full_email }}</span>. An administrator will review your credentials and provision the server mailbox shortly.
                        </p>
                    </div>

                    <!-- If Rejected -->
                    <div v-else-if="emailAccount && emailAccount.status === 'rejected'" class="space-y-4">
                        <div class="p-4 rounded-xl bg-rose-50 border border-rose-200 text-rose-800 text-xs">
                            <span class="font-bold">Application Declined:</span> {{ emailAccount.rejection_reason || 'Please verify your institutional affiliation.' }}
                        </div>
                        <p class="text-xs text-slate-500">You may re-apply with a different username handle below:</p>
                    </div>

                    <!-- Application Form -->
                    <div v-if="!emailAccount || emailAccount.status === 'rejected'">
                        <form @submit.prevent="submitApplication" class="space-y-4">
                            <div>
                                <label class="block text-xs font-semibold text-slate-700 uppercase tracking-wider mb-1.5">
                                    Desired Username Handle
                                </label>
                                <div class="flex rounded-xl shadow-xs border border-slate-300 overflow-hidden focus-within:ring-2 focus-within:ring-indigo-600 focus-within:border-indigo-600">
                                    <input
                                        v-model="applyForm.requested_username"
                                        type="text"
                                        required
                                        placeholder="e.g. dr.kamal or scholar.rahman"
                                        class="flex-1 min-w-0 border-0 px-4 py-3 text-xs text-slate-900 focus:ring-0 focus:outline-none"
                                    />
                                    <span class="inline-flex items-center px-4 bg-slate-100 text-slate-600 text-xs font-mono font-bold border-l border-slate-300 select-none">
                                        @{{ defaultDomain }}
                                    </span>
                                </div>
                                <p class="text-[11px] text-slate-400 mt-1.5">Letters, numbers, periods, hyphens and underscores allowed.</p>
                            </div>

                            <button
                                type="submit"
                                :disabled="applyForm.processing"
                                class="w-full py-3.5 bg-rose-600 hover:bg-rose-700 text-white rounded-xl font-bold text-xs transition shadow-md flex items-center justify-center gap-2"
                            >
                                {{ applyForm.processing ? 'Submitting Application...' : 'Apply for Academic Email →' }}
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- ════════════════════════════════════════════════════════════ -->
            <!-- SCENARIO 2: ACTIVE GMAIL-STYLE WEBMAIL CLIENT               -->
            <!-- ════════════════════════════════════════════════════════════ -->
            <div v-else class="bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden flex flex-col md:flex-row min-h-[700px]">
                <!-- 1. Left Gmail-Style Sidebar (Folders & Compose) -->
                <aside class="w-full md:w-56 lg:w-60 border-r border-slate-200/80 p-4 bg-slate-50/70 flex flex-col justify-between shrink-0">
                    <div class="space-y-4">
                        <!-- Red Compose Button -->
                        <button
                            @click="openCompose()"
                            class="w-full py-2.5 px-4 bg-rose-600 hover:bg-rose-700 text-white font-bold text-xs rounded-full shadow transition flex items-center justify-center gap-2"
                        >
                            <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                            </svg>
                            Compose Email
                        </button>

                        <!-- Folders Nav -->
                        <nav class="space-y-1 text-xs font-semibold text-slate-700">
                            <Link
                                :href="route('webmail.index', { folder: 'inbox' })"
                                class="flex items-center justify-between px-3 py-2 rounded-lg transition"
                                :class="currentFolder === 'inbox' ? 'bg-slate-900 text-white font-bold' : 'hover:bg-slate-200/60 text-slate-700'"
                            >
                                <span class="flex items-center gap-2.5">
                                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                    </svg>
                                    Inbox
                                </span>
                                <span v-if="unreadInboxCount > 0" class="px-1.5 py-0.5 rounded-full text-[10px] font-bold" :class="currentFolder === 'inbox' ? 'bg-white text-slate-900' : 'bg-rose-600 text-white'">
                                    {{ unreadInboxCount }}
                                </span>
                            </Link>

                            <Link
                                :href="route('webmail.index', { folder: 'starred' })"
                                class="flex items-center justify-between px-3 py-2 rounded-lg transition"
                                :class="currentFolder === 'starred' ? 'bg-slate-900 text-white font-bold' : 'hover:bg-slate-200/60 text-slate-700'"
                            >
                                <span class="flex items-center gap-2.5">
                                    <svg class="w-4 h-4 text-amber-500" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                                    </svg>
                                    Starred
                                </span>
                            </Link>

                            <Link
                                :href="route('webmail.index', { folder: 'sent' })"
                                class="flex items-center justify-between px-3 py-2 rounded-lg transition"
                                :class="currentFolder === 'sent' ? 'bg-slate-900 text-white font-bold' : 'hover:bg-slate-200/60 text-slate-700'"
                            >
                                <span class="flex items-center gap-2.5">
                                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                                    </svg>
                                    Sent Mail
                                </span>
                            </Link>

                            <Link
                                :href="route('webmail.index', { folder: 'trash' })"
                                class="flex items-center justify-between px-3 py-2 rounded-lg transition"
                                :class="currentFolder === 'trash' ? 'bg-slate-900 text-white font-bold' : 'hover:bg-slate-200/60 text-slate-700'"
                            >
                                <span class="flex items-center gap-2.5">
                                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                    </svg>
                                    Trash
                                </span>
                            </Link>
                        </nav>
                    </div>

                    <!-- Compact 1-Click cPanel Webmail SSO & Storage Quota -->
                    <div class="pt-4 border-t border-slate-200 space-y-3 text-xs">
                        <a
                            :href="route('webmail.cpanel_sso')"
                            target="_blank"
                            class="w-full py-1.5 px-2.5 bg-amber-50/80 hover:bg-amber-100/90 text-amber-900 border border-amber-200 rounded-lg font-bold text-[11px] flex items-center justify-between transition group shadow-2xs"
                            title="Direct 1-Click login to cPanel Roundcube Webmail"
                        >
                            <span class="flex items-center gap-1.5">
                                <span class="text-amber-600 text-xs">⚡</span>
                                <span>cPanel Webmail</span>
                            </span>
                            <span class="text-[10px] text-amber-500 group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition font-mono">↗</span>
                        </a>

                        <div>
                            <div class="flex justify-between text-slate-500 mb-1 text-[11px]">
                                <span>Storage</span>
                                <span>15 MB of {{ emailAccount.quota_mb }} MB</span>
                            </div>
                            <div class="w-full bg-slate-200 rounded-full h-1.5">
                                <div class="bg-indigo-600 h-1.5 rounded-full" style="width: 4%"></div>
                            </div>
                        </div>
                    </div>
                </aside>

                <!-- 2. Middle Message List Column -->
                <div class="w-full md:w-72 lg:w-80 border-r border-slate-200/80 flex flex-col shrink-0">
                    <!-- Search Header -->
                    <div class="p-3 border-b border-slate-200/80 bg-slate-50">
                        <div class="relative">
                            <input
                                v-model="searchQuery"
                                type="text"
                                placeholder="Search messages..."
                                class="w-full bg-white border border-slate-300 rounded-lg pl-8 pr-3 py-1.5 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            />
                            <svg class="w-4 h-4 text-slate-400 absolute left-2.5 top-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                        </div>
                    </div>

                    <!-- Message Feed -->
                    <div class="flex-1 overflow-y-auto divide-y divide-slate-100">
                        <div v-if="filteredMessages.length === 0" class="p-8 text-center text-xs text-slate-400">
                            No messages in this folder.
                        </div>

                        <div
                            v-for="msg in filteredMessages"
                            :key="msg.id"
                            @click="selectMessage(msg)"
                            class="p-3.5 hover:bg-indigo-50/50 cursor-pointer transition flex items-start gap-2.5"
                            :class="{
                                'bg-indigo-50/80 border-l-4 border-indigo-700': activeMessage && activeMessage.id === msg.id,
                                'font-bold': !msg.is_read
                            }"
                        >
                            <!-- Star Button -->
                            <button
                                @click.stop="toggleStar(msg)"
                                class="text-slate-300 hover:text-amber-500 pt-0.5 text-xs"
                                :class="{ 'text-amber-500': msg.is_starred }"
                            >
                                ★
                            </button>

                            <div class="flex-1 min-w-0">
                                <div class="flex items-center justify-between text-xs mb-0.5">
                                    <span class="truncate text-slate-900" :class="{ 'font-bold': !msg.is_read }">
                                        {{ msg.from_name || msg.from_email }}
                                    </span>
                                    <span class="text-[10px] text-slate-400 shrink-0 ml-1">
                                        {{ new Date(msg.created_at).toLocaleDateString([], { month: 'short', day: 'numeric' }) }}
                                    </span>
                                </div>
                                <div class="text-xs text-slate-800 truncate" :class="{ 'font-semibold': !msg.is_read }">
                                    {{ msg.subject }}
                                </div>
                                <p class="text-[11px] text-slate-500 truncate mt-0.5 font-normal">
                                    {{ msg.body_text }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 3. Right Reading Pane Column -->
                <div class="flex-1 flex flex-col bg-white overflow-hidden min-w-0">
                    <div v-if="activeMessage" class="flex-1 flex flex-col overflow-y-auto">
                        <!-- Message Actions Toolbar -->
                        <div class="p-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                            <div class="flex items-center gap-2">
                                <button
                                    @click="openCompose(activeMessage.from_email, activeMessage.subject)"
                                    class="px-3 py-1.5 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 rounded-lg text-xs font-bold transition flex items-center gap-1.5"
                                >
                                    <span>↩</span> Reply
                                </button>
                                <button
                                    @click="openCompose('', `Fwd: ${activeMessage.subject}`)"
                                    class="px-3 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-lg text-xs font-bold transition flex items-center gap-1.5"
                                >
                                    <span>↪</span> Forward
                                </button>
                            </div>

                            <div class="flex items-center gap-2">
                                <button
                                    @click="deleteMsg(activeMessage)"
                                    class="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50 transition"
                                    title="Delete Message"
                                >
                                    <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <!-- Message Header -->
                        <div class="p-6 border-b border-slate-100 space-y-4">
                            <h2 class="text-lg font-bold text-slate-900">
                                {{ activeMessage.subject }}
                            </h2>

                            <div class="flex items-center justify-between text-xs text-slate-600">
                                <div class="flex items-center gap-3">
                                    <div class="w-9 h-9 rounded-full bg-gradient-to-br from-indigo-600 to-rose-600 text-white flex items-center justify-center font-bold text-xs shadow-inner">
                                        {{ (activeMessage.from_name || activeMessage.from_email).charAt(0).toUpperCase() }}
                                    </div>
                                    <div>
                                        <div class="font-bold text-slate-900">{{ activeMessage.from_name }}</div>
                                        <div class="text-slate-500 font-mono text-[11px]">&lt;{{ activeMessage.from_email }}&gt;</div>
                                    </div>
                                </div>
                                <div class="text-slate-400 text-[11px]">
                                    {{ new Date(activeMessage.created_at).toLocaleString() }}
                                </div>
                            </div>
                        </div>

                        <!-- Email Body -->
                        <div class="p-6 flex-1 text-xs text-slate-800 leading-relaxed font-serif prose max-w-none whitespace-pre-wrap" v-html="activeMessage.body_html || activeMessage.body_text"></div>
                    </div>

                    <div v-else class="flex-1 flex flex-col items-center justify-center text-slate-400 p-8">
                        <svg class="w-12 h-12 text-slate-200 mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                        </svg>
                        <p class="text-xs">Select an email to read its contents.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- ════════════════════════════════════════════════════════════ -->
        <!-- GMAIL-STYLE COMPOSE EMAIL MODAL                             -->
        <!-- ════════════════════════════════════════════════════════════ -->
        <div v-if="composeOpen" class="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/60 backdrop-blur-sm p-4">
            <div class="bg-white rounded-2xl max-w-2xl w-full shadow-2xl overflow-hidden flex flex-col border border-slate-200">
                <div class="bg-slate-900 text-white px-5 py-3.5 flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider flex items-center gap-2">
                        <span>✉️</span> New Academic Message
                    </span>
                    <button @click="composeOpen = false" class="text-slate-400 hover:text-white text-base">✕</button>
                </div>

                <form @submit.prevent="sendEmail" class="p-6 space-y-4">
                    <div class="space-y-3">
                        <div class="flex items-center border-b border-slate-200 pb-2">
                            <span class="text-xs font-bold text-slate-400 w-16">To:</span>
                            <input
                                v-model="composeForm.to_email"
                                type="email"
                                required
                                placeholder="recipient@domain.org"
                                class="flex-1 border-0 p-0 text-xs focus:ring-0 focus:outline-none text-slate-900"
                            />
                        </div>

                        <div class="flex items-center border-b border-slate-200 pb-2">
                            <span class="text-xs font-bold text-slate-400 w-16">CC:</span>
                            <input
                                v-model="composeForm.cc_email"
                                type="email"
                                placeholder="optional.cc@domain.org"
                                class="flex-1 border-0 p-0 text-xs focus:ring-0 focus:outline-none text-slate-900"
                            />
                        </div>

                        <div class="flex items-center border-b border-slate-200 pb-2">
                            <span class="text-xs font-bold text-slate-400 w-16">Subject:</span>
                            <input
                                v-model="composeForm.subject"
                                type="text"
                                required
                                placeholder="Regarding Manuscript Submission #..."
                                class="flex-1 border-0 p-0 text-xs font-semibold focus:ring-0 focus:outline-none text-slate-900"
                            />
                        </div>
                    </div>

                    <textarea
                        v-model="composeForm.body"
                        rows="8"
                        required
                        placeholder="Write your scholarly email message here..."
                        class="w-full border border-slate-200 rounded-xl p-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none font-serif leading-relaxed"
                    ></textarea>

                    <div class="flex items-center justify-between pt-2">
                        <button
                            type="button"
                            @click="composeOpen = false"
                            class="px-4 py-2 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold transition"
                        >
                            Discard
                        </button>

                        <button
                            type="submit"
                            :disabled="composeForm.processing"
                            class="px-6 py-2.5 bg-rose-600 hover:bg-rose-700 text-white rounded-lg font-bold text-xs shadow-md flex items-center gap-2 transition"
                        >
                            {{ composeForm.processing ? 'Dispatching Message...' : 'Send Email →' }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
