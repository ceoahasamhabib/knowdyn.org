<script setup>
import { ref } from 'vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
    members: {
        type: Array,
        default: () => [],
    },
});

const showMemberModal = ref(false);
const editingMember = ref(null);

const form = useForm({
    name: '',
    email: '',
    institution: '',
    country: '',
    role: 'Editor-in-Chief',
    biography: '',
    orcid: '',
    sort_order: 0,
    is_active: true,
});

const openAddMember = () => {
    editingMember.value = null;
    form.reset();
    form.sort_order = props.members.length + 1;
    showMemberModal.value = true;
};

const openEditMember = (member) => {
    editingMember.value = member;
    form.name = member.name;
    form.email = member.email || '';
    form.institution = member.institution || '';
    form.country = member.country || '';
    form.role = member.role || 'Editor-in-Chief';
    form.biography = member.biography || '';
    form.orcid = member.orcid || '';
    form.sort_order = member.sort_order;
    form.is_active = Boolean(member.is_active);
    showMemberModal.value = true;
};

const submitMember = () => {
    if (editingMember.value) {
        form.put(route('admin.editorial_members.update', editingMember.value.id), {
            onSuccess: () => {
                showMemberModal.value = false;
            },
        });
    } else {
        form.post(route('admin.journals.editorial_board.store', props.journal.id), {
            onSuccess: () => {
                showMemberModal.value = false;
            },
        });
    }
};

const deleteMember = (member) => {
    if (confirm(`Remove "${member.name}" from editorial board?`)) {
        router.delete(route('admin.editorial_members.destroy', member.id));
    }
};
</script>

<template>
    <Head :title="`Editorial Board — ${journal.title}`" />

    <AdminLayout>
        <template #header>
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 w-full">
                <div class="flex items-center gap-3">
                    <Link :href="route('admin.journals.edit', journal.id)" class="text-xs text-gray-500 hover:text-gray-700">
                        ← Back to Edit Journal
                    </Link>
                    <span class="text-gray-300">/</span>
                    <h1 class="text-lg font-bold text-gray-900 truncate max-w-md">Editorial Board: {{ journal.short_title || journal.title }}</h1>
                </div>

                <button @click="openAddMember" class="btn-primary text-xs py-2 px-4 flex items-center gap-1.5 shrink-0">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    Add Board Member
                </button>
            </div>
        </template>

        <div class="space-y-6 max-w-5xl">
            <!-- Members Table -->
            <div class="bg-white rounded-xl border border-gray-200 overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-600">
                        <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                            <tr>
                                <th class="px-6 py-4">Member Name & Affiliation</th>
                                <th class="px-6 py-4">Role</th>
                                <th class="px-6 py-4">ORCID</th>
                                <th class="px-6 py-4">Order</th>
                                <th class="px-6 py-4">Status</th>
                                <th class="px-6 py-4 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            <tr v-if="members.length === 0">
                                <td colspan="6" class="px-6 py-12 text-center text-gray-500">
                                    No editorial board members assigned. Add editors and advisory members above.
                                </td>
                            </tr>

                            <tr v-for="member in members" :key="member.id" class="hover:bg-gray-50/80 transition">
                                <td class="px-6 py-4">
                                    <div class="font-bold text-gray-900">{{ member.name }}</div>
                                    <div class="text-xs text-gray-500">{{ member.institution }}<span v-if="member.country">, {{ member.country }}</span></div>
                                    <div v-if="member.email" class="text-[11px] text-gray-400 font-mono">{{ member.email }}</div>
                                </td>

                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-navy-100 text-navy-800">
                                        {{ member.role }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 font-mono text-xs text-gray-700">
                                    {{ member.orcid || '—' }}
                                </td>

                                <td class="px-6 py-4 text-xs font-mono">
                                    {{ member.sort_order }}
                                </td>

                                <td class="px-6 py-4">
                                    <span
                                        class="inline-flex items-center px-2 py-0.5 rounded text-[11px] font-semibold"
                                        :class="member.is_active ? 'bg-emerald-100 text-emerald-800' : 'bg-gray-100 text-gray-600'"
                                    >
                                        {{ member.is_active ? 'Active' : 'Inactive' }}
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-right space-x-3">
                                    <button @click="openEditMember(member)" class="text-xs font-medium text-navy-700 hover:text-navy-900 underline">
                                        Edit
                                    </button>
                                    <button @click="deleteMember(member)" class="text-xs font-medium text-rose-600 hover:text-rose-800 underline">
                                        Remove
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Member Modal -->
        <div v-if="showMemberModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4">
            <div class="bg-white rounded-xl max-w-lg w-full p-6 shadow-xl space-y-4">
                <h3 class="text-base font-bold text-gray-900">
                    {{ editingMember ? 'Edit Board Member' : 'Add Editorial Board Member' }}
                </h3>

                <form @submit.prevent="submitMember" class="space-y-4">
                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Full Name & Titles *</label>
                        <input v-model="form.name" type="text" required placeholder="e.g. Prof. Dr. Sarah Jenkins" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                    </div>

                    <div class="grid grid-cols-2 gap-3">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Role *</label>
                            <select v-model="form.role" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm">
                                <option value="Editor-in-Chief">Editor-in-Chief</option>
                                <option value="Associate Editor">Associate Editor</option>
                                <option value="Managing Editor">Managing Editor</option>
                                <option value="Section Editor">Section Editor</option>
                                <option value="Editorial Board Member">Editorial Board Member</option>
                                <option value="International Advisory Board">International Advisory Board</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Display Order</label>
                            <input v-model="form.sort_order" type="number" min="0" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                        </div>
                    </div>

                    <div class="grid grid-cols-2 gap-3">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Institution</label>
                            <input v-model="form.institution" type="text" placeholder="e.g. Oxford University" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Country</label>
                            <input v-model="form.country" type="text" placeholder="e.g. United Kingdom" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                        </div>
                    </div>

                    <div class="grid grid-cols-2 gap-3">
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">ORCID ID</label>
                            <input v-model="form.orcid" type="text" placeholder="0000-0002-1825-0097" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono" />
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Contact Email</label>
                            <input v-model="form.email" type="email" placeholder="editor@university.edu" class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm" />
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Short Biography / Expertise</label>
                        <textarea v-model="form.biography" rows="3" placeholder="Summary of academic achievements and research focus..." class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm"></textarea>
                    </div>

                    <div class="flex items-center gap-2">
                        <input v-model="form.is_active" type="checkbox" id="member_active" class="rounded border-gray-300 text-navy-700 focus:ring-navy-700" />
                        <label for="member_active" class="text-xs font-medium text-gray-700">Active Editorial Board Member</label>
                    </div>

                    <div class="flex justify-end gap-2 pt-2">
                        <button type="button" @click="showMemberModal = false" class="btn-secondary text-xs py-2 px-4">Cancel</button>
                        <button type="submit" :disabled="form.processing" class="btn-primary text-xs py-2 px-4">
                            {{ editingMember ? 'Update Member' : 'Add Member' }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </AdminLayout>
</template>
