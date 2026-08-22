<script setup>
import { computed } from 'vue';
import { Head, Link, router, usePage } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

const page = usePage();
const theme = computed(() => page.props.theme || {});

const props = defineProps({
    assignments: {
        type: Object,
        required: true,
    },
});

const respond = (assignmentId, accept) => {
    router.post(route('reviewer.respond', assignmentId), {
        accept: accept,
    });
};
</script>

<template>
    <Head title="Peer Reviewer Portal — Knowledge Dynamics" />

    <AuthenticatedLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                <div>
                    <h1 class="text-xl font-bold text-slate-900">Peer Reviewer Portal</h1>
                    <p class="text-xs text-slate-500">Confidential peer review assignments, invitations, and double-blind manuscript evaluations.</p>
                </div>
            </div>
        </template>

        <div class="space-y-8">
            <!-- 1. Pending Review Invitations -->
            <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-4">
                <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                    <div class="flex items-center gap-2">
                        <span class="w-2.5 h-2.5 rounded-full bg-amber-500 animate-pulse"></span>
                        <h2 class="text-xs font-bold uppercase tracking-wider text-slate-900">
                            Pending Review Invitations ({{ assignments.pending?.length || 0 }})
                        </h2>
                    </div>
                </div>

                <div v-if="assignments.pending && assignments.pending.length > 0" class="space-y-4">
                    <div
                        v-for="item in assignments.pending"
                        :key="item.id"
                        class="p-5 rounded-xl border border-amber-200 bg-amber-50/40 flex flex-col md:flex-row md:items-center justify-between gap-4"
                    >
                        <div class="space-y-1.5 max-w-2xl">
                            <span class="text-[10px] font-bold text-slate-800 uppercase tracking-wider bg-amber-100 px-2 py-0.5 rounded-md">
                                {{ item.manuscript?.journal?.title || 'Knowledge Dynamics Journal' }} • {{ item.manuscript?.article_type || 'Research Article' }}
                            </span>
                            <h3 class="text-sm font-bold text-slate-900">{{ item.manuscript?.title }}</h3>
                            <p class="text-xs text-slate-600 line-clamp-2">{{ item.manuscript?.abstract }}</p>
                            <div class="text-[11px] text-slate-500 pt-1">
                                Invited: {{ new Date(item.assigned_at).toLocaleDateString() }} • Target Due Date: {{ item.due_date || '21 days' }}
                            </div>
                        </div>

                        <div class="flex items-center gap-2 shrink-0">
                            <button
                                @click="respond(item.id, true)"
                                class="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white rounded-lg font-bold text-xs shadow-xs transition"
                            >
                                Accept Review ✓
                            </button>
                            <button
                                @click="respond(item.id, false)"
                                class="px-4 py-2 bg-white hover:bg-rose-50 text-rose-600 border border-rose-200 rounded-lg font-bold text-xs transition"
                            >
                                Decline
                            </button>
                        </div>
                    </div>
                </div>

                <div v-else class="text-center py-6 text-xs text-slate-400">
                    No pending review invitations at this time.
                </div>
            </div>

            <!-- 2. Active Review Assignments -->
            <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-4">
                <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                    <div class="flex items-center gap-2">
                        <span class="w-2.5 h-2.5 rounded-full bg-indigo-500"></span>
                        <h2 class="text-xs font-bold uppercase tracking-wider text-slate-900">
                            Active Evaluations in Progress ({{ assignments.in_progress?.length || 0 }})
                        </h2>
                    </div>
                </div>

                <div v-if="assignments.in_progress && assignments.in_progress.length > 0" class="space-y-4">
                    <div
                        v-for="item in assignments.in_progress"
                        :key="item.id"
                        class="p-5 rounded-xl border border-slate-200 hover:border-indigo-300 transition bg-white flex flex-col md:flex-row md:items-center justify-between gap-4 shadow-2xs"
                    >
                        <div class="space-y-1.5 max-w-2xl">
                            <span class="text-[10px] font-bold text-indigo-700 uppercase tracking-wider bg-indigo-50 px-2 py-0.5 rounded-md">
                                {{ item.manuscript?.journal?.title }} • {{ item.manuscript?.article_type }}
                            </span>
                            <h3 class="text-sm font-bold text-slate-900">{{ item.manuscript?.title }}</h3>
                            <p class="text-xs text-slate-500 line-clamp-1">{{ item.manuscript?.abstract }}</p>
                            <div class="text-[11px] text-slate-400">
                                Assigned: {{ new Date(item.assigned_at).toLocaleDateString() }}
                            </div>
                        </div>

                        <div class="shrink-0">
                            <Link
                                :href="route('reviewer.review.form', item.id)"
                                class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-bold text-xs shadow-xs transition inline-block"
                            >
                                Open Review Workspace →
                            </Link>
                        </div>
                    </div>
                </div>

                <div v-else class="text-center py-6 text-xs text-slate-400">
                    No active reviews currently underway.
                </div>
            </div>

            <!-- 3. Completed Reviews History -->
            <div class="bg-white rounded-2xl border border-slate-200/80 p-6 shadow-xs space-y-4">
                <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                    <div class="flex items-center gap-2">
                        <span class="w-2.5 h-2.5 rounded-full bg-emerald-500"></span>
                        <h2 class="text-xs font-bold uppercase tracking-wider text-slate-900">
                            Completed Evaluations ({{ assignments.completed?.length || 0 }})
                        </h2>
                    </div>
                </div>

                <div v-if="assignments.completed && assignments.completed.length > 0" class="divide-y divide-slate-100">
                    <div
                        v-for="item in assignments.completed"
                        :key="item.id"
                        class="py-3.5 flex items-center justify-between text-xs"
                    >
                        <div>
                            <span class="font-bold text-slate-900">{{ item.manuscript?.title }}</span>
                            <span class="text-slate-400 ml-2">({{ item.manuscript?.journal?.title }})</span>
                        </div>
                        <span class="px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wide bg-emerald-50 text-emerald-700 border border-emerald-200">
                            {{ item.status }}
                        </span>
                    </div>
                </div>

                <div v-else class="text-center py-4 text-xs text-slate-400">
                    No completed evaluations yet.
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
