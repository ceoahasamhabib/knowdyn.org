<script setup>
import { ref } from 'vue';
import { Head, router, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';

const props = defineProps({
    files: Object,
    stats: Object,
    filters: Object,
});

const currentFolder = ref(props.filters?.folder || 'all');
const currentType = ref(props.filters?.type || 'all');
const searchQuery = ref(props.filters?.q || '');
const currentSort = ref(props.filters?.sort || 'latest');
const viewMode = ref('grid'); // 'grid' | 'list'

const showUploadModal = ref(false);
const showInspectorModal = ref(false);
const activeFile = ref(null);
const selectedIds = ref([]);

const copySuccessMsg = ref('');

const uploadForm = useForm({
    files: [],
    folder: 'general',
});

const applyFilters = () => {
    router.get(
        route('admin.media.index'),
        {
            folder: currentFolder.value,
            type: currentType.value,
            q: searchQuery.value,
            sort: currentSort.value,
        },
        {
            preserveState: true,
            preserveScroll: true,
        }
    );
};

const handleFolderChange = (f) => {
    currentFolder.value = f;
    applyFilters();
};

const handleTypeChange = (t) => {
    currentType.value = t;
    applyFilters();
};

const handleSortChange = () => {
    applyFilters();
};

const handleSearch = () => {
    applyFilters();
};

const openInspector = (file) => {
    activeFile.value = { ...file };
    showInspectorModal.value = true;
};

const copyUrl = (url) => {
    const fullUrl = window.location.origin + url;
    navigator.clipboard.writeText(fullUrl);
    copySuccessMsg.value = 'URL copied to clipboard!';
    setTimeout(() => {
        copySuccessMsg.value = '';
    }, 2500);
};

const toggleSelectFile = (id) => {
    if (selectedIds.value.includes(id)) {
        selectedIds.value = selectedIds.value.filter(item => item !== id);
    } else {
        selectedIds.value.push(id);
    }
};

const selectAll = () => {
    if (selectedIds.value.length === props.files.data.length) {
        selectedIds.value = [];
    } else {
        selectedIds.value = props.files.data.map(f => f.id);
    }
};

const deleteSingle = (file) => {
    if (confirm(`Are you sure you want to permanently delete "${file.name}"?`)) {
        router.delete(route('admin.media.destroy', file.id), {
            preserveScroll: true,
            onSuccess: () => {
                showInspectorModal.value = false;
            },
        });
    }
};

const deleteBulk = () => {
    if (selectedIds.value.length === 0) return;
    if (confirm(`Are you sure you want to permanently delete ${selectedIds.value.length} selected files?`)) {
        router.post(route('admin.media.bulk_destroy'), { ids: selectedIds.value }, {
            preserveScroll: true,
            onSuccess: () => {
                selectedIds.value = [];
            },
        });
    }
};

const updateFileDetails = () => {
    if (!activeFile.value) return;
    router.put(route('admin.media.update', activeFile.value.id), {
        name: activeFile.value.name,
        alt_text: activeFile.value.alt_text,
        folder: activeFile.value.folder,
    }, {
        preserveScroll: true,
        onSuccess: () => {
            showInspectorModal.value = false;
        },
    });
};

const handleUploadSubmit = () => {
    uploadForm.post(route('admin.media.store'), {
        forceFormData: true,
        preserveScroll: true,
        onSuccess: () => {
            uploadForm.reset();
            showUploadModal.value = false;
        },
    });
};
</script>

<template>
    <Head title="Media Library & File Manager — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 w-full">
                <div>
                    <div class="flex items-center gap-2 mb-1">
                        <span class="px-2.5 py-0.5 text-[10px] font-extrabold uppercase tracking-wider bg-indigo-50 text-indigo-700 rounded-md border border-indigo-200">
                            Storage & CDN
                        </span>
                        <span class="text-xs text-slate-400">•</span>
                        <span class="text-xs text-slate-500 font-medium">{{ stats.total_files }} Total Assets ({{ stats.total_size }})</span>
                    </div>
                    <h1 class="text-2xl font-black text-slate-900 tracking-tight flex items-center gap-2.5">
                        <span>📁</span> Media Library & File Manager
                    </h1>
                </div>

                <!-- Action Buttons -->
                <div class="flex items-center gap-3">
                    <button
                        v-if="selectedIds.length > 0"
                        @click="deleteBulk"
                        class="px-4 py-2 rounded-xl bg-rose-50 text-rose-600 border border-rose-200 text-xs font-bold hover:bg-rose-100 transition shadow-xs flex items-center gap-1.5"
                    >
                        <span>🗑️</span> Delete Selected ({{ selectedIds.length }})
                    </button>

                    <button
                        @click="showUploadModal = true"
                        class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-indigo-600 via-blue-600 to-rose-600 hover:from-indigo-500 hover:to-rose-500 text-white text-xs font-extrabold shadow-md shadow-indigo-500/20 flex items-center gap-2 transition cursor-pointer"
                    >
                        <span>⬆️</span> Upload Files
                    </button>
                </div>
            </div>
        </template>

        <div class="max-w-7xl mx-auto space-y-6 pb-16">
            <!-- Toast notification for copy -->
            <div
                v-if="copySuccessMsg"
                class="fixed bottom-6 right-6 z-50 bg-slate-900 text-white text-xs font-bold px-4 py-2.5 rounded-xl shadow-2xl flex items-center gap-2 border border-slate-700 animate-in fade-in"
            >
                <span class="text-emerald-400">✓</span> {{ copySuccessMsg }}
            </div>

            <!-- Top Filter Bar & Folders Navigation -->
            <div class="bg-white rounded-2xl border border-slate-200 p-4 shadow-sm space-y-4">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                    <!-- Folder Pills Navigation -->
                    <div class="flex items-center gap-2 overflow-x-auto text-xs font-bold pb-1 lg:pb-0">
                        <button
                            @click="handleFolderChange('all')"
                            class="px-3 py-1.5 rounded-xl transition whitespace-nowrap flex items-center gap-1.5"
                            :class="currentFolder === 'all' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'"
                        >
                            <span>📁</span> All Files
                            <span class="text-[10px] opacity-75 font-mono">({{ stats.folders?.all || 0 }})</span>
                        </button>

                        <button
                            @click="handleFolderChange('branding')"
                            class="px-3 py-1.5 rounded-xl transition whitespace-nowrap flex items-center gap-1.5"
                            :class="currentFolder === 'branding' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'"
                        >
                            <span>🎨</span> Branding & Logos
                            <span class="text-[10px] opacity-75 font-mono">({{ stats.folders?.branding || 0 }})</span>
                        </button>

                        <button
                            @click="handleFolderChange('journals')"
                            class="px-3 py-1.5 rounded-xl transition whitespace-nowrap flex items-center gap-1.5"
                            :class="currentFolder === 'journals' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'"
                        >
                            <span>📖</span> Journals
                            <span class="text-[10px] opacity-75 font-mono">({{ stats.folders?.journals || 0 }})</span>
                        </button>

                        <button
                            @click="handleFolderChange('books')"
                            class="px-3 py-1.5 rounded-xl transition whitespace-nowrap flex items-center gap-1.5"
                            :class="currentFolder === 'books' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'"
                        >
                            <span>📚</span> Books
                            <span class="text-[10px] opacity-75 font-mono">({{ stats.folders?.books || 0 }})</span>
                        </button>

                        <button
                            @click="handleFolderChange('manuscripts')"
                            class="px-3 py-1.5 rounded-xl transition whitespace-nowrap flex items-center gap-1.5"
                            :class="currentFolder === 'manuscripts' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'"
                        >
                            <span>📄</span> Manuscripts
                            <span class="text-[10px] opacity-75 font-mono">({{ stats.folders?.manuscripts || 0 }})</span>
                        </button>

                        <button
                            @click="handleFolderChange('general')"
                            class="px-3 py-1.5 rounded-xl transition whitespace-nowrap flex items-center gap-1.5"
                            :class="currentFolder === 'general' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'"
                        >
                            <span>📂</span> General
                            <span class="text-[10px] opacity-75 font-mono">({{ stats.folders?.general || 0 }})</span>
                        </button>
                    </div>

                    <!-- Type Filter & View Mode Toggle -->
                    <div class="flex items-center gap-2.5">
                        <div class="flex items-center bg-slate-100 p-1 rounded-xl text-xs font-semibold">
                            <button
                                @click="handleTypeChange('all')"
                                class="px-2.5 py-1 rounded-lg transition"
                                :class="currentType === 'all' ? 'bg-white text-slate-900 shadow-xs' : 'text-slate-600'"
                            >
                                All Types
                            </button>
                            <button
                                @click="handleTypeChange('image')"
                                class="px-2.5 py-1 rounded-lg transition"
                                :class="currentType === 'image' ? 'bg-white text-slate-900 shadow-xs' : 'text-slate-600'"
                            >
                                Images
                            </button>
                            <button
                                @click="handleTypeChange('pdf')"
                                class="px-2.5 py-1 rounded-lg transition"
                                :class="currentType === 'pdf' ? 'bg-white text-slate-900 shadow-xs' : 'text-slate-600'"
                            >
                                PDFs
                            </button>
                        </div>

                        <div class="flex items-center bg-slate-100 p-1 rounded-xl text-xs">
                            <button
                                @click="viewMode = 'grid'"
                                class="p-1.5 rounded-lg transition"
                                :class="viewMode === 'grid' ? 'bg-white text-indigo-600 shadow-xs' : 'text-slate-500'"
                                title="Grid View"
                            >
                                ⊞
                            </button>
                            <button
                                @click="viewMode = 'list'"
                                class="p-1.5 rounded-lg transition"
                                :class="viewMode === 'list' ? 'bg-white text-indigo-600 shadow-xs' : 'text-slate-500'"
                                title="List View"
                            >
                                ☰
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Search & Sort Row -->
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 pt-3 border-t border-slate-100">
                    <div class="relative flex-1 max-w-md">
                        <input
                            v-model="searchQuery"
                            @keyup.enter="handleSearch"
                            type="text"
                            placeholder="Search by filename or title (Press Enter)..."
                            class="w-full pl-9 pr-4 py-2 bg-slate-50 border border-slate-200 rounded-xl text-xs focus:ring-2 focus:ring-indigo-600 focus:bg-white focus:outline-none transition"
                        />
                        <span class="absolute left-3 top-2.5 text-slate-400 text-xs">🔍</span>
                    </div>

                    <div class="flex items-center gap-3">
                        <div class="flex items-center gap-2">
                            <label class="text-xs font-bold text-slate-500 uppercase">Sort:</label>
                            <select
                                v-model="currentSort"
                                @change="handleSortChange"
                                class="bg-slate-50 border border-slate-200 rounded-xl px-3 py-1.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="latest">Latest First</option>
                                <option value="oldest">Oldest First</option>
                                <option value="name_asc">Name (A to Z)</option>
                                <option value="name_desc">Name (Z to A)</option>
                                <option value="size_desc">File Size (Largest)</option>
                                <option value="size_asc">File Size (Smallest)</option>
                            </select>
                        </div>

                        <button
                            v-if="files.data.length > 0"
                            @click="selectAll"
                            class="text-xs font-bold text-indigo-600 hover:text-indigo-800 transition"
                        >
                            {{ selectedIds.length === files.data.length ? 'Deselect All' : 'Select All' }}
                        </button>
                    </div>
                </div>
            </div>

            <!-- Main Files Display -->
            <div v-if="files.data.length === 0" class="bg-white rounded-3xl border border-slate-200 p-16 text-center space-y-4">
                <div class="w-16 h-16 rounded-3xl bg-indigo-50 text-indigo-600 flex items-center justify-center text-2xl mx-auto shadow-sm">
                    📁
                </div>
                <div>
                    <h3 class="text-base font-bold text-slate-800">No media files found</h3>
                    <p class="text-xs text-slate-500 max-w-sm mx-auto mt-1">Upload brand logos, journal issue graphics, book covers, or manuscript PDFs to start organizing.</p>
                </div>
                <button
                    @click="showUploadModal = true"
                    class="px-6 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold shadow-md shadow-indigo-500/20 transition"
                >
                    ⬆️ Upload First File
                </button>
            </div>

            <!-- GRID VIEW -->
            <div v-else-if="viewMode === 'grid'" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-4">
                <div
                    v-for="file in files.data"
                    :key="file.id"
                    class="bg-white rounded-2xl border border-slate-200/90 hover:border-indigo-400 hover:shadow-md transition duration-200 overflow-hidden p-2.5 flex flex-col justify-between group relative"
                    :class="selectedIds.includes(file.id) ? 'ring-2 ring-indigo-600 bg-indigo-50/30' : ''"
                >
                    <!-- Selection Checkbox -->
                    <div class="absolute top-4 left-4 z-10">
                        <input
                            type="checkbox"
                            :checked="selectedIds.includes(file.id)"
                            @change="toggleSelectFile(file.id)"
                            class="rounded border-slate-300 text-indigo-600 focus:ring-indigo-500 w-4 h-4 cursor-pointer"
                        />
                    </div>

                    <!-- Quick Copy URL button on hover -->
                    <button
                        @click.stop="copyUrl(file.url)"
                        class="absolute top-4 right-4 z-10 w-7 h-7 rounded-lg bg-white/90 backdrop-blur-xs text-slate-700 hover:text-indigo-600 shadow-sm flex items-center justify-center text-xs opacity-0 group-hover:opacity-100 transition"
                        title="Copy Public URL"
                    >
                        🔗
                    </button>

                    <!-- Thumbnail Click to Inspect -->
                    <div
                        @click="openInspector(file)"
                        class="w-full h-32 rounded-xl bg-slate-50 border border-slate-100 flex items-center justify-center overflow-hidden cursor-pointer relative"
                    >
                        <img
                            v-if="file.is_image"
                            :src="file.url"
                            :alt="file.name"
                            class="w-full h-full object-contain p-2 group-hover:scale-105 transition duration-300"
                        />
                        <div v-else-if="file.mime_type === 'application/pdf'" class="flex flex-col items-center gap-1">
                            <span class="text-3xl">📄</span>
                            <span class="text-[10px] font-mono font-bold text-rose-600">PDF</span>
                        </div>
                        <div v-else class="flex flex-col items-center gap-1 text-slate-400">
                            <span class="text-3xl">📁</span>
                            <span class="text-[10px] font-mono font-bold uppercase">{{ file.file_name.split('.').pop() }}</span>
                        </div>
                    </div>

                    <!-- Meta Information -->
                    <div class="mt-2.5 space-y-1">
                        <p
                            @click="openInspector(file)"
                            class="text-xs font-bold text-slate-900 truncate hover:text-indigo-600 cursor-pointer"
                            :title="file.name"
                        >
                            {{ file.name }}
                        </p>
                        <div class="flex items-center justify-between text-[10px] text-slate-400 font-mono">
                            <span>{{ file.human_size }}</span>
                            <span class="capitalize px-1.5 py-0.5 bg-slate-100 rounded text-slate-600">{{ file.folder }}</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- LIST VIEW -->
            <div v-else class="bg-white rounded-2xl border border-slate-200 overflow-hidden shadow-sm">
                <table class="w-full text-left text-xs">
                    <thead class="bg-slate-50 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider text-[10px]">
                        <tr>
                            <th class="p-3.5 w-10">
                                <input
                                    type="checkbox"
                                    :checked="selectedIds.length === files.data.length && files.data.length > 0"
                                    @change="selectAll"
                                    class="rounded border-slate-300 text-indigo-600"
                                />
                            </th>
                            <th class="p-3.5">Asset</th>
                            <th class="p-3.5">Folder</th>
                            <th class="p-3.5">MIME Type</th>
                            <th class="p-3.5">Size</th>
                            <th class="p-3.5">Date Added</th>
                            <th class="p-3.5 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        <tr
                            v-for="file in files.data"
                            :key="file.id"
                            class="hover:bg-slate-50/70 transition"
                            :class="selectedIds.includes(file.id) ? 'bg-indigo-50/40' : ''"
                        >
                            <td class="p-3.5">
                                <input
                                    type="checkbox"
                                    :checked="selectedIds.includes(file.id)"
                                    @change="toggleSelectFile(file.id)"
                                    class="rounded border-slate-300 text-indigo-600"
                                />
                            </td>
                            <td class="p-3.5">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 rounded-lg bg-slate-100 border border-slate-200 p-0.5 shrink-0 flex items-center justify-center overflow-hidden">
                                        <img v-if="file.is_image" :src="file.url" class="max-h-full max-w-full object-contain" />
                                        <span v-else class="text-xs font-bold text-slate-400">DOC</span>
                                    </div>
                                    <div class="min-w-0">
                                        <p class="font-bold text-slate-900 truncate max-w-xs hover:text-indigo-600 cursor-pointer" @click="openInspector(file)">
                                            {{ file.name }}
                                        </p>
                                        <p class="text-[10px] text-slate-400 font-mono truncate">{{ file.file_name }}</p>
                                    </div>
                                </div>
                            </td>
                            <td class="p-3.5">
                                <span class="capitalize px-2 py-0.5 bg-slate-100 text-slate-700 rounded-md font-semibold text-[11px]">
                                    {{ file.folder }}
                                </span>
                            </td>
                            <td class="p-3.5 font-mono text-slate-500 text-[11px]">{{ file.mime_type || 'Unknown' }}</td>
                            <td class="p-3.5 font-mono text-slate-600 font-semibold">{{ file.human_size }}</td>
                            <td class="p-3.5 text-slate-500 text-[11px]">{{ new Date(file.created_at).toLocaleDateString() }}</td>
                            <td class="p-3.5 text-right space-x-2">
                                <button
                                    @click="copyUrl(file.url)"
                                    class="px-2.5 py-1 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-lg font-bold text-[11px] transition"
                                >
                                    Copy URL
                                </button>
                                <button
                                    @click="openInspector(file)"
                                    class="px-2.5 py-1 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 rounded-lg font-bold text-[11px] transition"
                                >
                                    Edit
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination Bar -->
            <div v-if="files.links && files.links.length > 3" class="flex items-center justify-center gap-1 pt-4">
                <template v-for="(link, i) in files.links" :key="i">
                    <button
                        v-if="link.url"
                        @click="router.get(link.url, {}, { preserveState: true, preserveScroll: true })"
                        class="px-3 py-1.5 rounded-xl text-xs font-bold transition"
                        :class="link.active ? 'bg-indigo-600 text-white shadow-xs' : 'bg-white border border-slate-200 text-slate-700 hover:bg-slate-50'"
                        v-html="link.label"
                    />
                </template>
            </div>
        </div>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- MODAL: UPLOAD MULTIPLE FILES                                -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <div v-if="showUploadModal" class="fixed inset-0 z-50 overflow-y-auto" role="dialog">
            <div class="fixed inset-0 bg-slate-950/60 backdrop-blur-sm" @click="showUploadModal = false"></div>
            <div class="flex min-h-screen items-center justify-center p-4">
                <div class="relative w-full max-w-xl bg-white rounded-3xl shadow-2xl border border-slate-200 overflow-hidden p-6 md:p-8 space-y-6" @click.stop>
                    <div class="flex items-center justify-between border-b border-slate-100 pb-3">
                        <h3 class="text-base font-extrabold text-slate-900 flex items-center gap-2">
                            <span>⬆️</span> Upload Files to Media Library
                        </h3>
                        <button @click="showUploadModal = false" class="text-slate-400 hover:text-slate-700">✕</button>
                    </div>

                    <form @submit.prevent="handleUploadSubmit" class="space-y-6">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Destination Category:</label>
                            <select
                                v-model="uploadForm.folder"
                                class="w-full border border-slate-300 rounded-xl px-4 py-2.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="general">📂 General Uploads</option>
                                <option value="branding">🎨 Branding & Logos</option>
                                <option value="journals">📖 Journal Covers & Graphics</option>
                                <option value="books">📚 Books & Monographs</option>
                                <option value="manuscripts">📄 Manuscript Documents & PDFs</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1.5">Select Files (Multi-Select Supported):</label>
                            <input
                                type="file"
                                multiple
                                @change="e => uploadForm.files = e.target.files"
                                class="w-full border border-slate-300 rounded-xl p-3 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-xs file:font-bold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100 cursor-pointer"
                            />
                            <p class="text-[10px] text-slate-400 mt-1">Supports SVGs, PNGs, JPGs, WebPs, ICOs, and PDFs up to 50MB each.</p>
                        </div>

                        <div class="flex justify-end gap-3 pt-2">
                            <button
                                type="button"
                                @click="showUploadModal = false"
                                class="px-4 py-2 rounded-xl border border-slate-300 text-xs font-bold text-slate-700 hover:bg-slate-50"
                            >
                                Cancel
                            </button>
                            <button
                                type="submit"
                                :disabled="uploadForm.processing || !uploadForm.files.length"
                                class="px-6 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold shadow-md shadow-indigo-500/20 transition disabled:opacity-50"
                            >
                                {{ uploadForm.processing ? 'Uploading...' : 'Start Upload' }}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!-- DRAWER / MODAL: FILE INSPECTOR & DETAILS                    -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <div v-if="showInspectorModal && activeFile" class="fixed inset-0 z-50 overflow-y-auto" role="dialog">
            <div class="fixed inset-0 bg-slate-950/60 backdrop-blur-sm" @click="showInspectorModal = false"></div>
            <div class="flex min-h-screen items-center justify-center p-4">
                <div class="relative w-full max-w-2xl bg-white rounded-3xl shadow-2xl border border-slate-200 overflow-hidden flex flex-col max-h-[90vh]" @click.stop>
                    <div class="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                        <h3 class="text-sm font-bold text-slate-900 flex items-center gap-2">
                            <span>🔍</span> Asset Inspector & Metadata
                        </h3>
                        <button @click="showInspectorModal = false" class="text-slate-400 hover:text-slate-700">✕</button>
                    </div>

                    <div class="p-6 overflow-y-auto space-y-6">
                        <!-- Preview Card -->
                        <div class="w-full h-48 rounded-2xl bg-slate-900 border border-slate-800 flex items-center justify-center overflow-hidden p-4 relative shadow-inner">
                            <img v-if="activeFile.is_image" :src="activeFile.url" class="max-h-full max-w-full object-contain" />
                            <div v-else class="text-white font-bold text-sm flex items-center gap-2">
                                <span>📄</span> {{ activeFile.file_name }}
                            </div>
                        </div>

                        <!-- Editable Fields -->
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div class="sm:col-span-2">
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Display Title</label>
                                <input
                                    v-model="activeFile.name"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-3.5 py-2 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Target Category</label>
                                <select
                                    v-model="activeFile.folder"
                                    class="w-full border border-slate-300 rounded-xl px-3.5 py-2 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                >
                                    <option value="general">General</option>
                                    <option value="branding">Branding & Logos</option>
                                    <option value="journals">Journals</option>
                                    <option value="books">Books</option>
                                    <option value="manuscripts">Manuscripts</option>
                                </select>
                            </div>

                            <div>
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Image Alt Text (SEO)</label>
                                <input
                                    v-model="activeFile.alt_text"
                                    type="text"
                                    class="w-full border border-slate-300 rounded-xl px-3.5 py-2 text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                    placeholder="Brief description for screen readers"
                                />
                            </div>

                            <!-- Public URL Copy Box -->
                            <div class="sm:col-span-2">
                                <label class="block text-xs font-bold text-slate-700 uppercase tracking-wider mb-1">Direct Storage URL</label>
                                <div class="flex items-center gap-2">
                                    <input
                                        :value="activeFile.url"
                                        readonly
                                        class="flex-1 bg-slate-50 border border-slate-300 rounded-xl px-3.5 py-2 text-xs font-mono text-slate-600"
                                    />
                                    <button
                                        type="button"
                                        @click="copyUrl(activeFile.url)"
                                        class="px-4 py-2 bg-indigo-50 hover:bg-indigo-100 text-indigo-700 rounded-xl text-xs font-bold transition whitespace-nowrap"
                                    >
                                        Copy URL
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Technical Details -->
                        <div class="bg-slate-50 rounded-2xl p-4 border border-slate-200 text-xs space-y-1 font-mono text-slate-600">
                            <div class="flex justify-between"><span>File Size:</span><span class="font-bold text-slate-800">{{ activeFile.human_size }} ({{ activeFile.size }} bytes)</span></div>
                            <div class="flex justify-between"><span>MIME Type:</span><span class="font-bold text-slate-800">{{ activeFile.mime_type }}</span></div>
                            <div v-if="activeFile.dimensions" class="flex justify-between"><span>Dimensions:</span><span class="font-bold text-slate-800">{{ activeFile.dimensions }} px</span></div>
                            <div class="flex justify-between"><span>Upload Date:</span><span class="font-bold text-slate-800">{{ new Date(activeFile.created_at).toLocaleString() }}</span></div>
                        </div>
                    </div>

                    <!-- Inspector Footer -->
                    <div class="px-6 py-4 border-t border-slate-100 bg-slate-50/60 flex items-center justify-between">
                        <button
                            type="button"
                            @click="deleteSingle(activeFile)"
                            class="px-4 py-2 bg-rose-50 hover:bg-rose-100 text-rose-600 border border-rose-200 rounded-xl text-xs font-bold transition"
                        >
                            🗑️ Delete File
                        </button>

                        <div class="flex items-center gap-2">
                            <button
                                type="button"
                                @click="showInspectorModal = false"
                                class="px-4 py-2 rounded-xl border border-slate-300 text-xs font-bold text-slate-700 hover:bg-slate-100"
                            >
                                Close
                            </button>
                            <button
                                type="button"
                                @click="updateFileDetails"
                                class="px-6 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold shadow-md shadow-indigo-500/20 transition"
                            >
                                Save Changes
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
