<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const form = useForm({
    title: '',
    author: '',
    isbn: '',
    year: new Date().getFullYear(),
    pages: 300,
    category: 'Medicine & Health',
    format: 'Print & eBook',
    description: '',
    doi: '',
    is_open_access: true,
    sort_order: 0,
});

const submit = () => {
    form.post(route('admin.books.store'));
};
</script>

<template>
    <Head title="Add Book Monograph — Admin" />

    <AdminLayout>
        <template #header>
            <div class="flex items-center gap-3">
                <Link :href="route('admin.books.index')" class="text-xs text-gray-500 hover:text-gray-700">
                    ← Back to Books
                </Link>
                <span class="text-gray-300">/</span>
                <h1 class="text-lg font-bold text-gray-900">Publish New Book Monograph</h1>
            </div>
        </template>

        <div class="max-w-4xl mx-auto">
            <form @submit.prevent="submit" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                <div class="border-b border-gray-100 pb-4">
                    <h2 class="text-base font-bold text-gray-900">Book Monograph Details</h2>
                    <p class="text-xs text-gray-500">Provide bibliographic and scholarly metadata for this publication.</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Book Title *</label>
                        <input
                            v-model="form.title"
                            type="text"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Author(s) / Editor(s) *</label>
                        <input
                            v-model="form.author"
                            type="text"
                            required
                            placeholder="Prof. Dr. Full Name"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">ISBN Number</label>
                        <input
                            v-model="form.isbn"
                            type="text"
                            placeholder="978-3-000-0000-0"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none font-mono"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Discipline Category *</label>
                        <select
                            v-model="form.category"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="Medicine & Health">Medicine & Health</option>
                            <option value="Food Science & Agriculture">Food Science & Agriculture</option>
                            <option value="Asian Studies & History">Asian Studies & History</option>
                            <option value="Business, Economics & Finance">Business, Economics & Finance</option>
                            <option value="Theology & Comparative Religion">Theology & Comparative Religion</option>
                            <option value="Applied Social Sciences">Applied Social Sciences</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publication Format *</label>
                        <select
                            v-model="form.format"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        >
                            <option value="Print & eBook">Print & eBook</option>
                            <option value="eBook Only">eBook Only</option>
                            <option value="Hardcover Print">Hardcover Print</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Publication Year *</label>
                        <input
                            v-model.number="form.year"
                            type="number"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Page Count</label>
                        <input
                            v-model.number="form.pages"
                            type="number"
                            required
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        />
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Digital Object Identifier (DOI)</label>
                        <input
                            v-model="form.doi"
                            type="text"
                            placeholder="10.58421/books.2024.01"
                            class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none font-mono"
                        />
                    </div>

                    <div class="sm:col-span-2">
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Description & Synopsis</label>
                        <textarea
                            v-model="form.description"
                            rows="4"
                            class="w-full border border-gray-300 rounded-lg p-3 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                        ></textarea>
                    </div>

                    <div class="flex items-center gap-2">
                        <input
                            id="is_oa"
                            v-model="form.is_open_access"
                            type="checkbox"
                            class="rounded text-navy-700 focus:ring-navy-600 h-4 w-4"
                        />
                        <label for="is_oa" class="text-xs font-semibold text-gray-700">Open Access Publication (Free to read)</label>
                    </div>
                </div>

                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <Link :href="route('admin.books.index')" class="btn-secondary text-xs py-2 px-5">Cancel</Link>
                    <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2.5 px-6 shadow-sm">
                        {{ form.processing ? 'Publishing...' : 'Publish Book Monograph' }}
                    </button>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>
