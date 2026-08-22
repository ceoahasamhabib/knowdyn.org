<script setup>
import { ref } from 'vue';
import { Head, useForm, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';

const props = defineProps({
    diagnostics: {
        type: Object,
        required: true,
    },
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
    if (confirm('Are you sure you want to install this update package? The system will create an automatic rollback snapshot in storage/app/backups before applying files.')) {
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
    <Head title="Universal System Updater & Maintenance — Admin" />

    <AdminLayout>
        <!-- Standard Admin Header Slot -->
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div>
                    <div class="flex items-center gap-2.5">
                        <h1 class="text-xl font-bold text-gray-900 flex items-center gap-2">
                            <span class="text-indigo-600">⚡</span> Universal System Updater & Maintenance
                        </h1>
                        <span class="px-2 py-0.5 text-[11px] font-mono font-bold rounded-md bg-emerald-50 text-emerald-700 border border-emerald-200">
                            v2.0-INCREMENTAL
                        </span>
                    </div>
                    <p class="text-xs text-gray-500 mt-0.5">
                        Safely upload lightweight update packages (~600 KB) with zero downtime, automatic rollback snapshots, and automated background migrations.
                    </p>
                </div>

                <div class="flex items-center gap-2">
                    <button 
                        @click="triggerClearCache" 
                        :disabled="isClearingCache"
                        class="px-3.5 py-2 text-xs font-semibold rounded-lg bg-white border border-gray-300 text-gray-700 hover:bg-gray-50 hover:text-indigo-600 flex items-center gap-1.5 shadow-sm transition disabled:opacity-60"
                        title="Purge compiled Blade, route and configuration caches"
                    >
                        <span>🧹</span> {{ isClearingCache ? 'Clearing...' : 'Clear App Cache' }}
                    </button>
                </div>
            </div>
        </template>

        <div class="space-y-6">
            <!-- 1. System Health Diagnostics Grid -->
            <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3.5">
                <div class="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
                    <div class="text-[11px] font-bold text-gray-500 uppercase tracking-wider">PHP Version</div>
                    <div class="text-base font-bold text-gray-900 mt-1 font-mono">{{ diagnostics.php_version }}</div>
                    <div class="text-[11px] text-emerald-600 font-medium mt-0.5 flex items-center gap-1">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Ready
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
                    <div class="text-[11px] font-bold text-gray-500 uppercase tracking-wider">Framework Engine</div>
                    <div class="text-base font-bold text-gray-900 mt-1 font-mono">v{{ diagnostics.laravel_version }}</div>
                    <div class="text-[11px] text-emerald-600 font-medium mt-0.5 flex items-center gap-1">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> {{ diagnostics.app_env }}
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
                    <div class="text-[11px] font-bold text-gray-500 uppercase tracking-wider">Database</div>
                    <div class="text-base font-bold text-gray-900 mt-1">{{ diagnostics.db_tables_count }} Tables</div>
                    <div class="text-[11px] text-emerald-600 font-medium mt-0.5 truncate flex items-center gap-1">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> {{ diagnostics.db_name }}
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
                    <div class="text-[11px] font-bold text-gray-500 uppercase tracking-wider">ZipArchive</div>
                    <div class="text-base font-bold text-gray-900 mt-1">{{ diagnostics.zip_enabled ? 'Available' : 'Missing' }}</div>
                    <div class="text-[11px] font-medium mt-0.5 flex items-center gap-1" :class="diagnostics.zip_enabled ? 'text-emerald-600' : 'text-rose-600'">
                        <span class="w-1.5 h-1.5 rounded-full" :class="diagnostics.zip_enabled ? 'bg-emerald-500' : 'bg-rose-500'"></span>
                        {{ diagnostics.zip_enabled ? 'Ready for ZIP' : 'Required' }}
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
                    <div class="text-[11px] font-bold text-gray-500 uppercase tracking-wider">Max Upload</div>
                    <div class="text-base font-bold text-gray-900 mt-1 font-mono">{{ diagnostics.max_upload_size }}</div>
                    <div class="text-[11px] text-gray-500 font-medium mt-0.5">Post: {{ diagnostics.post_max_size }}</div>
                </div>

                <div class="bg-white rounded-xl border border-gray-200 p-4 shadow-sm">
                    <div class="text-[11px] font-bold text-gray-500 uppercase tracking-wider">Storage Link</div>
                    <div class="text-base font-bold text-gray-900 mt-1">{{ diagnostics.storage_writable ? 'Writable' : 'Locked' }}</div>
                    <div class="text-[11px] text-emerald-600 font-medium mt-0.5 flex items-center gap-1">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Active
                    </div>
                </div>
            </div>

            <!-- 2. Bulletproof Safety Guarantees -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="bg-indigo-50/70 border border-indigo-100 rounded-xl p-4 flex items-start gap-3">
                    <div class="w-9 h-9 rounded-lg bg-indigo-100 text-indigo-700 flex items-center justify-center text-lg shrink-0">
                        🛡️
                    </div>
                    <div>
                        <h4 class="text-xs font-bold text-indigo-950 uppercase tracking-wider">Automated Rollback Snapshot</h4>
                        <p class="text-xs text-indigo-900/80 mt-1 leading-relaxed">
                            A complete pre-update safety backup of existing code is generated in <code class="bg-indigo-100/80 px-1 py-0.5 rounded text-[11px]">storage/app/backups</code> before any files are replaced.
                        </p>
                    </div>
                </div>

                <div class="bg-emerald-50/70 border border-emerald-100 rounded-xl p-4 flex items-start gap-3">
                    <div class="w-9 h-9 rounded-lg bg-emerald-100 text-emerald-700 flex items-center justify-center text-lg shrink-0">
                        🔒
                    </div>
                    <div>
                        <h4 class="text-xs font-bold text-emerald-950 uppercase tracking-wider">Credentials & Upload Immunity</h4>
                        <p class="text-xs text-emerald-900/80 mt-1 leading-relaxed">
                            Your live <code class="bg-emerald-100/80 px-1 py-0.5 rounded text-[11px]">.env</code> database secrets and all uploaded author manuscripts & PDFs are strictly preserved and never overwritten.
                        </p>
                    </div>
                </div>

                <div class="bg-amber-50/70 border border-amber-100 rounded-xl p-4 flex items-start gap-3">
                    <div class="w-9 h-9 rounded-lg bg-amber-100 text-amber-700 flex items-center justify-center text-lg shrink-0">
                        🔄
                    </div>
                    <div>
                        <h4 class="text-xs font-bold text-amber-950 uppercase tracking-wider">Additive Database Migrations</h4>
                        <p class="text-xs text-amber-900/80 mt-1 leading-relaxed">
                            Database migrations only add new columns and tables. Existing users, submissions, and publisher records are never dropped or modified.
                        </p>
                    </div>
                </div>
            </div>

            <!-- 3. ZIP Upload & Installation Card -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm">
                <div class="flex items-center justify-between border-b border-gray-100 pb-3 mb-5">
                    <div>
                        <h2 class="text-sm font-bold uppercase tracking-wider text-gray-900 flex items-center gap-2">
                            <span class="text-indigo-600">📦</span> Upload New Feature / Update Package (.ZIP)
                        </h2>
                        <p class="text-xs text-gray-500 mt-0.5">
                            Upload your code update package (.zip). The engine validates archive integrity, copies payload files atomically, and runs pending database migrations.
                        </p>
                    </div>
                    <span class="text-xs font-medium text-gray-400">Max size: {{ diagnostics.max_upload_size }}</span>
                </div>

                <form @submit.prevent="submitUpdate" class="space-y-4">
                    <div 
                        @dragover.prevent="isDragging = true"
                        @dragleave.prevent="isDragging = false"
                        @drop.prevent="handleDrop"
                        @click="$refs.fileInput.click()"
                        class="border-2 border-dashed rounded-xl p-8 text-center cursor-pointer transition-all flex flex-col items-center justify-center gap-3"
                        :class="isDragging ? 'border-indigo-500 bg-indigo-50/60' : 'border-gray-300 hover:border-indigo-400 bg-gray-50/50'"
                    >
                        <input 
                            type="file" 
                            ref="fileInput" 
                            @change="handleFileSelect" 
                            accept=".zip" 
                            class="hidden" 
                        />
                        <div class="w-12 h-12 rounded-xl bg-indigo-50 border border-indigo-200 text-indigo-600 flex items-center justify-center text-2xl shadow-sm">
                            📁
                        </div>
                        <div>
                            <div v-if="selectedFileName" class="text-sm font-bold text-indigo-600">
                                Selected: {{ selectedFileName }}
                            </div>
                            <div v-else class="text-sm font-semibold text-gray-800">
                                Drag and drop your update <span class="text-indigo-600 font-bold">.zip</span> file here, or click to browse
                            </div>
                            <p class="text-xs text-gray-500 mt-1">Supports standard Laravel and module ZIP archives</p>
                        </div>
                    </div>

                    <!-- Upload Progress -->
                    <div v-if="form.progress" class="w-full bg-gray-100 rounded-full h-2 overflow-hidden">
                        <div class="bg-indigo-600 h-2 rounded-full transition-all duration-300" :style="{ width: `${form.progress.percentage}%` }"></div>
                    </div>

                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-2">
                        <div class="text-xs text-gray-500 flex items-center gap-1.5">
                            <span>💡</span> <span>Emergency fallback runner available at: <code class="font-mono text-indigo-700 bg-indigo-50 px-1.5 py-0.5 rounded border border-indigo-100">/installer.php?key=kdpub2026</code></span>
                        </div>

                        <button 
                            type="submit" 
                            :disabled="!form.update_zip || form.processing"
                            class="px-5 py-2.5 rounded-lg text-xs font-bold text-white bg-indigo-600 hover:bg-indigo-700 shadow-sm transition flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            <span>🚀</span> {{ form.processing ? 'Installing & Applying Update...' : 'Install & Apply Update' }}
                        </button>
                    </div>
                </form>
            </div>

            <!-- 4. Update History & Audit Log -->
            <div class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm">
                <div class="flex items-center justify-between border-b border-gray-100 pb-3 mb-4">
                    <div>
                        <h2 class="text-sm font-bold uppercase tracking-wider text-gray-900 flex items-center gap-2">
                            <span class="text-indigo-600">📜</span> System Update History
                        </h2>
                        <p class="text-xs text-gray-500 mt-0.5">Audit log of update packages applied to this installation.</p>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs border-collapse">
                        <thead>
                            <tr class="bg-gray-50 border-y border-gray-200 text-gray-600 font-bold uppercase tracking-wider text-[11px]">
                                <th class="py-3 px-4">Date & Time</th>
                                <th class="py-3 px-4">Files Synchronized</th>
                                <th class="py-3 px-4">Database Migrations</th>
                                <th class="py-3 px-4 text-right">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <tr v-for="(entry, idx) in diagnostics.history" :key="idx" class="hover:bg-gray-50/80 transition">
                                <td class="py-3.5 px-4 font-mono text-gray-700">
                                    {{ new Date(entry.timestamp).toLocaleString() }}
                                </td>
                                <td class="py-3.5 px-4 font-bold text-gray-900">
                                    {{ entry.files_updated }} files
                                </td>
                                <td class="py-3.5 px-4 text-gray-600 max-w-md truncate">
                                    {{ entry.migration_summary }}
                                </td>
                                <td class="py-3.5 px-4 text-right">
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-[11px] font-bold bg-emerald-100 text-emerald-800">
                                        Completed
                                    </span>
                                </td>
                            </tr>
                            <tr v-if="!diagnostics.history || diagnostics.history.length === 0">
                                <td colspan="4" class="py-8 text-center text-gray-400">
                                    No updates installed yet. The system is operating on initial release version.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
