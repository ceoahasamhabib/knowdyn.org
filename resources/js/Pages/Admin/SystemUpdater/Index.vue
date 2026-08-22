<script setup>
import { ref } from 'vue';
import { Head, useForm, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdButton from '@/Components/KD/KdButton.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    diagnostics: Object,
});

const form = useForm({
    update_zip: null,
});

const isDragging = ref(false);
const fileInput = ref(null);
const selectedFileName = ref('');
const isMigrating = ref(false);
const isClearingCache = ref(false);

const handleFileSelect = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.update_zip = file;
        selectedFileName.value = `${file.name} (${(file.size / (1024 * 1024)).toFixed(2)} MB)`;
    }
};

const handleDrop = (e) => {
    isDragging.value = false;
    const file = e.dataTransfer.files[0];
    if (file && file.name.endsWith('.zip')) {
        form.update_zip = file;
        selectedFileName.value = `${file.name} (${(file.size / (1024 * 1024)).toFixed(2)} MB)`;
    }
};

const submitUpdate = () => {
    if (!form.update_zip) return;
    if (confirm('Are you sure you want to install this update package? The system will create an automatic rollback snapshot before applying files.')) {
        form.post(route('admin.system_updater.upload'), {
            onSuccess: () => {
                form.reset();
                selectedFileName.value = '';
            },
        });
    }
};

const triggerMigrate = () => {
    isMigrating.value = true;
    router.post(route('admin.system_updater.migrate'), {}, {
        onFinish: () => { isMigrating.value = false; },
    });
};

const triggerClearCache = () => {
    isClearingCache.value = true;
    router.post(route('admin.system_updater.clear_cache'), {}, {
        onFinish: () => { isClearingCache.value = false; },
    });
};
</script>

<template>
    <Head title="Universal System Updater & Maintenance" />

    <AdminLayout>
        <div class="space-y-8">
            <!-- Header Section -->
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <div class="flex items-center gap-3">
                        <h1 class="text-2xl font-bold tracking-tight text-white flex items-center gap-2">
                            <span>⚡</span> Universal Bulletproof System Updater
                        </h1>
                        <KdBadge variant="primary" class="font-mono text-xs">v1.2.0-STABLE</KdBadge>
                    </div>
                    <p class="text-sm text-slate-400 mt-1">
                        Safely deploy code updates, new features, and database migrations via ZIP with zero data loss and automated rollback protection.
                    </p>
                </div>

                <div class="flex items-center gap-3">
                    <button 
                        @click="triggerMigrate" 
                        :disabled="isMigrating"
                        class="px-3.5 py-2 text-xs font-semibold rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-200 border border-slate-700 flex items-center gap-2 transition"
                    >
                        <span>🔄</span> {{ isMigrating ? 'Running Migrations...' : 'Run DB Migrations' }}
                    </button>
                    <button 
                        @click="triggerClearCache" 
                        :disabled="isClearingCache"
                        class="px-3.5 py-2 text-xs font-semibold rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-200 border border-slate-700 flex items-center gap-2 transition"
                    >
                        <span>🧹</span> {{ isClearingCache ? 'Clearing...' : 'Clear All Caches' }}
                    </button>
                </div>
            </div>

            <!-- Diagnostics Metric Cards -->
            <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3.5">
                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-3.5">
                    <div class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">PHP Version</div>
                    <div class="text-base font-bold text-white mt-1 font-mono">{{ diagnostics.php_version }}</div>
                    <div class="text-[10px] text-emerald-400 mt-0.5">● Ready</div>
                </div>

                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-3.5">
                    <div class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Laravel Engine</div>
                    <div class="text-base font-bold text-white mt-1 font-mono">v{{ diagnostics.laravel_version }}</div>
                    <div class="text-[10px] text-emerald-400 mt-0.5">● Optimized</div>
                </div>

                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-3.5">
                    <div class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Database</div>
                    <div class="text-base font-bold text-white mt-1 font-mono">{{ diagnostics.db_tables_count }} Tables</div>
                    <div class="text-[10px] text-emerald-400 mt-0.5">● {{ diagnostics.db_name }}</div>
                </div>

                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-3.5">
                    <div class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">ZipArchive</div>
                    <div class="text-base font-bold text-white mt-1">{{ diagnostics.zip_enabled ? 'Enabled' : 'Missing' }}</div>
                    <div class="text-[10px]" :class="diagnostics.zip_enabled ? 'text-emerald-400' : 'text-rose-400'">
                        {{ diagnostics.zip_enabled ? '● Ready for updates' : '● Extension required' }}
                    </div>
                </div>

                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-3.5">
                    <div class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Max Upload</div>
                    <div class="text-base font-bold text-white mt-1 font-mono">{{ diagnostics.max_upload_size }}</div>
                    <div class="text-[10px] text-slate-400 mt-0.5">Post: {{ diagnostics.post_max_size }}</div>
                </div>

                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-3.5">
                    <div class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Storage Link</div>
                    <div class="text-base font-bold text-white mt-1">{{ diagnostics.storage_writable ? 'Writable' : 'Locked' }}</div>
                    <div class="text-[10px] text-emerald-400 mt-0.5">● Public linked</div>
                </div>
            </div>

            <!-- Bulletproof Safety Pillars -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="bg-blue-950/20 border border-blue-500/20 rounded-2xl p-4 flex items-start gap-3">
                    <span class="text-2xl">🛡️</span>
                    <div>
                        <h4 class="text-sm font-bold text-blue-300">Automated Rollback Snapshot</h4>
                        <p class="text-xs text-slate-400 mt-1 leading-relaxed">
                            Before changing any files, an isolated snapshot of your existing core files is created in storage/app/backups.
                        </p>
                    </div>
                </div>

                <div class="bg-emerald-950/20 border border-emerald-500/20 rounded-2xl p-4 flex items-start gap-3">
                    <span class="text-2xl">🔒</span>
                    <div>
                        <h4 class="text-sm font-bold text-emerald-300">Environment & Upload Immunity</h4>
                        <p class="text-xs text-slate-400 mt-1 leading-relaxed">
                            Your production <code class="text-emerald-400">.env</code> database credentials and user uploaded manuscripts/images are protected and never overwritten.
                        </p>
                    </div>
                </div>

                <div class="bg-purple-950/20 border border-purple-500/20 rounded-2xl p-4 flex items-start gap-3">
                    <span class="text-2xl">🔄</span>
                    <div>
                        <h4 class="text-sm font-bold text-purple-300">Non-Destructive Migrations</h4>
                        <p class="text-xs text-slate-400 mt-1 leading-relaxed">
                            Database migrations only apply new columns and tables. Existing records, authors, and articles remain intact without data loss.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Main ZIP Upload Section -->
            <KdCard class="p-6">
                <h3 class="text-base font-bold text-white flex items-center gap-2">
                    <span>📦</span> Upload New Feature / Update Package (.ZIP)
                </h3>
                <p class="text-xs text-slate-400 mt-1">
                    Upload any updated code archive (.zip). The system will extract it in an isolated staging sandbox, verify payload health, atomically sync files, and apply new migrations.
                </p>

                <form @submit.prevent="submitUpdate" class="mt-6 space-y-4">
                    <div 
                        @dragover.prevent="isDragging = true"
                        @dragleave.prevent="isDragging = false"
                        @drop.prevent="handleDrop"
                        @click="$refs.fileInput.click()"
                        class="border-2 border-dashed rounded-2xl p-8 text-center cursor-pointer transition-all flex flex-col items-center justify-center gap-3"
                        :class="isDragging ? 'border-sky-500 bg-sky-500/10' : 'border-slate-700 hover:border-slate-600 bg-slate-900/40'"
                    >
                        <input 
                            type="file" 
                            ref="fileInput" 
                            @change="handleFileSelect" 
                            accept=".zip" 
                            class="hidden" 
                        />
                        <div class="w-14 h-14 rounded-2xl bg-sky-500/10 border border-sky-500/20 flex items-center justify-center text-2xl text-sky-400">
                            📂
                        </div>
                        <div>
                            <div v-if="selectedFileName" class="text-sm font-bold text-sky-400">
                                Selected: {{ selectedFileName }}
                            </div>
                            <div v-else class="text-sm font-semibold text-white">
                                Drag and drop your update <span class="text-sky-400">.zip</span> file here, or click to browse
                            </div>
                            <p class="text-xs text-slate-500 mt-1">Accepts standard ZIP archives up to 100MB</p>
                        </div>
                    </div>

                    <!-- Progress Bar -->
                    <div v-if="form.progress" class="w-full bg-slate-800 rounded-full h-2.5 overflow-hidden">
                        <div class="bg-sky-500 h-2.5 rounded-full transition-all duration-300" :style="{ width: `${form.progress.percentage}%` }"></div>
                    </div>

                    <div class="flex items-center justify-between pt-2">
                        <div class="text-xs text-slate-400 flex items-center gap-1.5">
                            <span>💡</span> <span>Tip: You can also use the standalone emergency runner at <code class="text-sky-400 font-mono">/installer.php?key=kdpub2026</code></span>
                        </div>

                        <KdButton 
                            type="submit" 
                            variant="primary" 
                            :loading="form.processing"
                            :disabled="!form.update_zip || form.processing"
                            class="px-6"
                        >
                            <span>🚀</span> {{ form.processing ? 'Installing Update...' : 'Install & Apply Update' }}
                        </KdButton>
                    </div>
                </form>
            </KdCard>

            <!-- Update History Log -->
            <KdCard class="p-6">
                <h3 class="text-base font-bold text-white flex items-center gap-2">
                    <span>📜</span> System Update History & Audit Log
                </h3>
                <p class="text-xs text-slate-400 mt-1">Record of updates installed via the Universal System Updater.</p>

                <div class="mt-4 overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse">
                        <thead>
                            <tr class="border-b border-slate-800 text-slate-400 font-semibold uppercase tracking-wider text-[11px]">
                                <th class="py-3 px-3">Date & Time</th>
                                <th class="py-3 px-3">Files Synchronized</th>
                                <th class="py-3 px-3">Database Migrations</th>
                                <th class="py-3 px-3 text-right">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-800/60">
                            <tr v-for="(entry, idx) in diagnostics.history" :key="idx" class="hover:bg-slate-800/30 transition">
                                <td class="py-3 px-3 font-mono text-slate-300">
                                    {{ new Date(entry.timestamp).toLocaleString() }}
                                </td>
                                <td class="py-3 px-3 font-semibold text-white">
                                    {{ entry.files_updated }} files
                                </td>
                                <td class="py-3 px-3 text-slate-400 max-w-md truncate">
                                    {{ entry.migration_summary }}
                                </td>
                                <td class="py-3 px-3 text-right">
                                    <KdBadge variant="success">Completed</KdBadge>
                                </td>
                            </tr>
                            <tr v-if="!diagnostics.history || diagnostics.history.length === 0">
                                <td colspan="4" class="py-6 text-center text-slate-500">
                                    No updates installed yet. The system is operating on initial release.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </KdCard>
        </div>
    </AdminLayout>
</template>
