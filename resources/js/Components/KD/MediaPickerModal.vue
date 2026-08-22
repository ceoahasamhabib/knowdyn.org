<script setup>
import { ref, watch, onMounted } from 'vue';

const props = defineProps({
    modelValue: {
        type: Boolean,
        default: false,
    },
    acceptedTypes: {
        type: String,
        default: 'image', // 'image' | 'pdf' | 'document' | 'all'
    },
    defaultFolder: {
        type: String,
        default: 'all',
    },
    title: {
        type: String,
        default: 'Select Media from Library',
    },
});

const emit = defineEmits(['update:modelValue', 'select']);

const activeTab = ref('browse'); // 'browse' | 'upload'
const loading = ref(false);
const uploading = ref(false);
const files = ref([]);
const selectedFile = ref(null);

const searchQuery = ref('');
const selectedFolder = ref(props.defaultFolder);
const targetUploadFolder = ref(props.defaultFolder === 'all' ? 'general' : props.defaultFolder);

const fileInput = ref(null);

const fetchMedia = async () => {
    loading.value = true;
    try {
        const params = new URLSearchParams({
            json: '1',
            type: props.acceptedTypes,
            folder: selectedFolder.value,
            q: searchQuery.value,
        });
        const res = await fetch(`/admin/media?${params.toString()}`, {
            headers: {
                'Accept': 'application/json',
                'X-Requested-With': 'XMLHttpRequest',
            },
        });
        const data = await res.json();
        files.value = data.files?.data || data.files || [];
    } catch (e) {
        console.error('Failed to fetch media files', e);
    } finally {
        loading.value = false;
    }
};

const handleFolderChange = (folder) => {
    selectedFolder.value = folder;
    fetchMedia();
};

const handleSearch = () => {
    fetchMedia();
};

const selectFile = (file) => {
    selectedFile.value = file;
};

const confirmSelection = () => {
    if (selectedFile.value) {
        emit('select', selectedFile.value);
        closeModal();
    }
};

const closeModal = () => {
    emit('update:modelValue', false);
};

const handleFileUpload = async (e) => {
    const uploadedFiles = e.target.files;
    if (!uploadedFiles || uploadedFiles.length === 0) return;

    uploading.value = true;
    const formData = new FormData();
    for (let i = 0; i < uploadedFiles.length; i++) {
        formData.append('files[]', uploadedFiles[i]);
    }
    formData.append('folder', targetUploadFolder.value);

    try {
        // Fetch CSRF token from document meta or cookies
        const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
        const res = await fetch('/admin/media', {
            method: 'POST',
            body: formData,
            headers: {
                'Accept': 'application/json',
                'X-Requested-With': 'XMLHttpRequest',
                ...(token ? { 'X-CSRF-TOKEN': token } : {}),
            },
        });
        const data = await res.json();
        if (data.files && data.files.length > 0) {
            selectedFile.value = data.files[0];
            activeTab.value = 'browse';
            fetchMedia();
        }
    } catch (e) {
        console.error('Upload failed', e);
    } finally {
        uploading.value = false;
        if (fileInput.value) fileInput.value.value = '';
    }
};

watch(() => props.modelValue, (newVal) => {
    if (newVal) {
        selectedFolder.value = props.defaultFolder;
        fetchMedia();
    } else {
        selectedFile.value = null;
    }
});

onMounted(() => {
    if (props.modelValue) {
        fetchMedia();
    }
});
</script>

<template>
    <div v-if="modelValue" class="fixed inset-0 z-50 overflow-y-auto" role="dialog" aria-modal="true">
        <!-- Backdrop -->
        <div class="fixed inset-0 bg-slate-950/60 backdrop-blur-sm transition-opacity" @click="closeModal"></div>

        <!-- Modal Dialog -->
        <div class="flex min-h-screen items-center justify-center p-4">
            <div class="relative w-full max-w-4xl bg-white rounded-3xl shadow-2xl border border-slate-200 overflow-hidden flex flex-col max-h-[85vh] animate-in fade-in zoom-in-95 duration-200" @click.stop>
                <!-- Modal Header -->
                <div class="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                    <div class="flex items-center gap-3">
                        <div class="w-9 h-9 rounded-xl bg-indigo-50 text-indigo-600 flex items-center justify-center font-bold text-base shadow-xs border border-indigo-100">
                            📁
                        </div>
                        <div>
                            <h3 class="text-base font-bold text-slate-900">{{ title }}</h3>
                            <p class="text-xs text-slate-500">Pick from existing library assets or upload new images & files.</p>
                        </div>
                    </div>

                    <!-- Tabs & Close -->
                    <div class="flex items-center gap-2">
                        <div class="flex items-center bg-slate-200/80 p-1 rounded-xl text-xs font-bold">
                            <button
                                type="button"
                                @click="activeTab = 'browse'"
                                class="px-3 py-1.5 rounded-lg transition"
                                :class="activeTab === 'browse' ? 'bg-white text-indigo-700 shadow-xs' : 'text-slate-600 hover:text-slate-900'"
                            >
                                🖼️ Browse Library
                            </button>
                            <button
                                type="button"
                                @click="activeTab = 'upload'"
                                class="px-3 py-1.5 rounded-lg transition"
                                :class="activeTab === 'upload' ? 'bg-white text-indigo-700 shadow-xs' : 'text-slate-600 hover:text-slate-900'"
                            >
                                ⬆️ Upload New
                            </button>
                        </div>

                        <button
                            type="button"
                            @click="closeModal"
                            class="p-2 rounded-xl text-slate-400 hover:text-slate-700 hover:bg-slate-100 transition"
                        >
                            ✕
                        </button>
                    </div>
                </div>

                <!-- Modal Body -->
                <div class="flex-1 overflow-y-auto p-6 space-y-4 min-h-[360px]">
                    <!-- TAB 1: BROWSE MEDIA -->
                    <div v-if="activeTab === 'browse'" class="space-y-4">
                        <!-- Filters Bar -->
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 bg-slate-50 p-3 rounded-2xl border border-slate-200/80">
                            <!-- Folder Pills -->
                            <div class="flex items-center gap-1.5 overflow-x-auto text-[11px] font-bold">
                                <button
                                    type="button"
                                    @click="handleFolderChange('all')"
                                    class="px-2.5 py-1 rounded-lg transition whitespace-nowrap"
                                    :class="selectedFolder === 'all' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-white text-slate-600 hover:bg-slate-100 border border-slate-200'"
                                >
                                    All Folders
                                </button>
                                <button
                                    type="button"
                                    @click="handleFolderChange('branding')"
                                    class="px-2.5 py-1 rounded-lg transition whitespace-nowrap"
                                    :class="selectedFolder === 'branding' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-white text-slate-600 hover:bg-slate-100 border border-slate-200'"
                                >
                                    🎨 Branding
                                </button>
                                <button
                                    type="button"
                                    @click="handleFolderChange('journals')"
                                    class="px-2.5 py-1 rounded-lg transition whitespace-nowrap"
                                    :class="selectedFolder === 'journals' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-white text-slate-600 hover:bg-slate-100 border border-slate-200'"
                                >
                                    📖 Journals
                                </button>
                                <button
                                    type="button"
                                    @click="handleFolderChange('books')"
                                    class="px-2.5 py-1 rounded-lg transition whitespace-nowrap"
                                    :class="selectedFolder === 'books' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-white text-slate-600 hover:bg-slate-100 border border-slate-200'"
                                >
                                    📚 Books
                                </button>
                                <button
                                    type="button"
                                    @click="handleFolderChange('general')"
                                    class="px-2.5 py-1 rounded-lg transition whitespace-nowrap"
                                    :class="selectedFolder === 'general' ? 'bg-indigo-600 text-white shadow-xs' : 'bg-white text-slate-600 hover:bg-slate-100 border border-slate-200'"
                                >
                                    📂 General
                                </button>
                            </div>

                            <!-- Search Input -->
                            <div class="relative w-full sm:w-60">
                                <input
                                    v-model="searchQuery"
                                    @input="handleSearch"
                                    type="text"
                                    placeholder="Search filename..."
                                    class="w-full pl-8 pr-3 py-1.5 bg-white border border-slate-200 rounded-xl text-xs focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                                />
                                <span class="absolute left-2.5 top-2 text-slate-400 text-xs">🔍</span>
                            </div>
                        </div>

                        <!-- Grid of Media Files -->
                        <div v-if="loading" class="flex flex-col items-center justify-center py-16 text-slate-400 space-y-2">
                            <span class="animate-spin text-2xl">🌀</span>
                            <span class="text-xs">Loading media assets...</span>
                        </div>

                        <div v-else-if="files.length === 0" class="flex flex-col items-center justify-center py-16 text-center space-y-3 bg-slate-50/50 rounded-2xl border border-dashed border-slate-300">
                            <div class="w-12 h-12 rounded-2xl bg-indigo-50 text-indigo-500 flex items-center justify-center text-xl">
                                📂
                            </div>
                            <div>
                                <h4 class="text-sm font-bold text-slate-800">No media files found</h4>
                                <p class="text-xs text-slate-500 max-w-xs mt-0.5">Switch to the "Upload New" tab to add brand logos, icons, and cover photos.</p>
                            </div>
                            <button
                                type="button"
                                @click="activeTab = 'upload'"
                                class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold shadow-xs transition"
                            >
                                ⬆️ Upload Media File
                            </button>
                        </div>

                        <div v-else class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-3.5">
                            <div
                                v-for="file in files"
                                :key="file.id"
                                @click="selectFile(file)"
                                class="group relative rounded-2xl border cursor-pointer overflow-hidden p-2 flex flex-col justify-between transition-all duration-200"
                                :class="selectedFile?.id === file.id ? 'border-indigo-600 bg-indigo-50/60 ring-2 ring-indigo-600 shadow-md scale-[1.02]' : 'border-slate-200 bg-white hover:border-slate-300 hover:shadow-sm'"
                            >
                                <!-- Thumbnail Preview Area -->
                                <div class="w-full h-24 rounded-xl bg-slate-100 flex items-center justify-center overflow-hidden relative shadow-inner">
                                    <template v-if="file.is_image">
                                        <img :src="file.url" :alt="file.name" class="w-full h-full object-contain p-1 group-hover:scale-105 transition duration-300" />
                                    </template>
                                    <template v-else-if="file.mime_type === 'application/pdf'">
                                        <span class="text-rose-500 font-extrabold text-xs">PDF</span>
                                    </template>
                                    <template v-else>
                                        <span class="text-slate-400 font-extrabold text-xs">FILE</span>
                                    </template>

                                    <!-- Selected Checkmark Badge -->
                                    <div v-if="selectedFile?.id === file.id" class="absolute top-1.5 right-1.5 w-5 h-5 bg-indigo-600 text-white rounded-full flex items-center justify-center text-[10px] font-bold shadow-sm">
                                        ✓
                                    </div>
                                </div>

                                <!-- Metadata -->
                                <div class="mt-2 space-y-0.5">
                                    <p class="text-[11px] font-bold text-slate-800 truncate" :title="file.name">{{ file.name }}</p>
                                    <div class="flex items-center justify-between text-[9px] text-slate-400 font-mono">
                                        <span>{{ file.human_size }}</span>
                                        <span v-if="file.dimensions">{{ file.dimensions }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- TAB 2: UPLOAD NEW FILES -->
                    <div v-else class="space-y-6">
                        <!-- Folder Destination -->
                        <div class="flex items-center gap-3">
                            <label class="text-xs font-bold text-slate-700 uppercase tracking-wider">Target Folder:</label>
                            <select
                                v-model="targetUploadFolder"
                                class="border border-slate-300 rounded-xl px-3 py-1.5 text-xs font-medium focus:ring-2 focus:ring-indigo-600 focus:outline-none"
                            >
                                <option value="general">📂 General Uploads</option>
                                <option value="branding">🎨 Branding & Logos</option>
                                <option value="journals">📖 Journal Covers & Assets</option>
                                <option value="books">📚 Books & Monographs</option>
                                <option value="manuscripts">📄 Manuscript Documents</option>
                            </select>
                        </div>

                        <!-- Drag & Drop Zone -->
                        <div
                            class="border-2 border-dashed border-indigo-200 hover:border-indigo-400 bg-indigo-50/40 hover:bg-indigo-50/70 rounded-3xl p-12 text-center transition flex flex-col items-center justify-center space-y-4 cursor-pointer relative"
                            @click="$refs.fileInput.click()"
                        >
                            <input
                                ref="fileInput"
                                type="file"
                                multiple
                                :accept="acceptedTypes === 'image' ? 'image/*' : '*/*'"
                                @change="handleFileUpload"
                                class="hidden"
                            />

                            <div class="w-16 h-16 rounded-2xl bg-white text-indigo-600 shadow-md border border-indigo-100 flex items-center justify-center text-3xl">
                                ☁️
                            </div>

                            <div>
                                <h4 class="text-base font-bold text-slate-900">Drag & drop files here, or click to browse</h4>
                                <p class="text-xs text-slate-500 mt-1">Supports SVGs, PNGs, JPGs, WebPs, ICOs, and PDFs up to 50MB.</p>
                            </div>

                            <div v-if="uploading" class="flex items-center gap-2 text-indigo-600 font-bold text-xs bg-white px-4 py-2 rounded-xl shadow-xs border border-indigo-100">
                                <span class="animate-spin">🌀</span>
                                <span>Uploading file(s) to Media Library...</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Footer with Selected File Summary & Confirm Button -->
                <div class="px-6 py-4 border-t border-slate-100 bg-slate-50/60 flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <template v-if="selectedFile">
                            <div class="w-10 h-10 rounded-xl bg-white border border-slate-200 p-0.5 overflow-hidden shadow-xs shrink-0 flex items-center justify-center">
                                <img v-if="selectedFile.is_image" :src="selectedFile.url" class="max-h-full max-w-full object-contain" />
                                <span v-else class="text-xs font-bold text-slate-400">FILE</span>
                            </div>
                            <div class="min-w-0">
                                <p class="text-xs font-bold text-slate-900 truncate max-w-xs">{{ selectedFile.name }}</p>
                                <p class="text-[10px] text-slate-400 font-mono">{{ selectedFile.human_size }} • {{ selectedFile.url }}</p>
                            </div>
                        </template>
                        <template v-else>
                            <span class="text-xs text-slate-400">No file selected</span>
                        </template>
                    </div>

                    <div class="flex items-center gap-2.5">
                        <button
                            type="button"
                            @click="closeModal"
                            class="px-4 py-2 rounded-xl border border-slate-300 bg-white hover:bg-slate-100 text-slate-700 text-xs font-bold transition"
                        >
                            Cancel
                        </button>
                        <button
                            type="button"
                            @click="confirmSelection"
                            :disabled="!selectedFile"
                            class="px-6 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold shadow-md shadow-indigo-500/20 transition disabled:opacity-40 disabled:cursor-not-allowed"
                        >
                            Insert Selected Media
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
