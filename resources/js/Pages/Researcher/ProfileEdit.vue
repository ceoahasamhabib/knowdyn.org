<script setup>
import { Head, useForm, router } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';
import KdBadge from '@/Components/KD/KdBadge.vue';
import { ref } from 'vue';

const props = defineProps({
    profile: Object,
    user: Object,
});

// ── Profile Form ──
const profileForm = useForm({
    first_name: props.user?.first_name || '',
    last_name: props.user?.last_name || '',
    username: props.user?.username || '',
    biography: props.profile?.biography || '',
    institution: props.profile?.institution || '',
    department: props.profile?.department || '',
    country: props.profile?.country || '',
    city: props.profile?.city || '',
    orcid: props.profile?.orcid || '',
    google_scholar: props.profile?.google_scholar || '',
    linkedin: props.profile?.linkedin || '',
    website: props.profile?.website || '',
    research_gate: props.profile?.research_gate || '',
    expertise: props.profile?.expertise || '',
    is_public: props.profile?.is_public ?? true,
});

const saveProfile = () => {
    profileForm.put('/researcher/profile', {
        preserveScroll: true,
    });
};

// ── Interests ──
const interestInput = ref('');
const interests = ref((props.profile?.interests || []).map(i => i.interest));

const addInterest = () => {
    const val = interestInput.value.trim();
    if (val && !interests.value.includes(val) && interests.value.length < 20) {
        interests.value.push(val);
        interestInput.value = '';
    }
};

const removeInterest = (index) => {
    interests.value.splice(index, 1);
};

const saveInterests = () => {
    router.put('/researcher/interests', { interests: interests.value }, { preserveScroll: true });
};

// ── Affiliations ──
const showAffForm = ref(false);
const affForm = useForm({
    institution: '',
    department: '',
    position: '',
    country: '',
    start_date: '',
    end_date: '',
    is_current: false,
});

const addAffiliation = () => {
    affForm.post('/researcher/affiliations', {
        preserveScroll: true,
        onSuccess: () => {
            affForm.reset();
            showAffForm.value = false;
        },
    });
};

const removeAffiliation = (id) => {
    if (confirm('Remove this affiliation?')) {
        router.delete(`/researcher/affiliations/${id}`, { preserveScroll: true });
    }
};

// Tab management
const activeTab = ref('profile');
</script>

<template>
    <Head title="Researcher Profile — Knowledge Dynamics" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="text-xl font-semibold text-gray-800">Researcher Profile</h2>
        </template>

        <div class="py-6">
            <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">

                <!-- Tabs -->
                <div class="flex gap-1 mb-6 overflow-x-auto">
                    <button
                        v-for="tab in [
                            { id: 'profile', label: 'Profile' },
                            { id: 'interests', label: 'Research Interests' },
                            { id: 'affiliations', label: 'Affiliations' },
                        ]"
                        :key="tab.id"
                        @click="activeTab = tab.id"
                        class="px-4 py-2 text-sm font-medium rounded-lg transition-colors whitespace-nowrap"
                        :class="activeTab === tab.id ? 'bg-navy-700 text-white' : 'text-gray-600 hover:bg-gray-100'"
                    >
                        {{ tab.label }}
                    </button>
                </div>

                <!-- Profile tab -->
                <KdCard padding="wide" v-show="activeTab === 'profile'">
                    <h3 class="text-lg font-semibold text-gray-900 mb-5">Profile Information</h3>
                    <form @submit.prevent="saveProfile" class="space-y-5">
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                            <div>
                                <label class="form-label">First Name</label>
                                <input v-model="profileForm.first_name" type="text" class="form-input" />
                                <p v-if="profileForm.errors.first_name" class="form-error">{{ profileForm.errors.first_name }}</p>
                            </div>
                            <div>
                                <label class="form-label">Last Name</label>
                                <input v-model="profileForm.last_name" type="text" class="form-input" />
                                <p v-if="profileForm.errors.last_name" class="form-error">{{ profileForm.errors.last_name }}</p>
                            </div>
                        </div>

                        <div>
                            <label class="form-label">Username</label>
                            <div class="flex items-center gap-2">
                                <span class="text-sm text-gray-400">knowledge-dynamics.com/</span>
                                <input v-model="profileForm.username" type="text" class="form-input flex-1" placeholder="your-username" />
                            </div>
                            <p v-if="profileForm.errors.username" class="form-error">{{ profileForm.errors.username }}</p>
                        </div>

                        <div>
                            <label class="form-label">Biography</label>
                            <textarea v-model="profileForm.biography" class="form-input" rows="4" placeholder="Tell us about your academic background..." />
                            <p v-if="profileForm.errors.biography" class="form-error">{{ profileForm.errors.biography }}</p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                            <div>
                                <label class="form-label">Institution</label>
                                <input v-model="profileForm.institution" type="text" class="form-input" placeholder="University / Institute" />
                            </div>
                            <div>
                                <label class="form-label">Department</label>
                                <input v-model="profileForm.department" type="text" class="form-input" />
                            </div>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                            <div>
                                <label class="form-label">Country</label>
                                <input v-model="profileForm.country" type="text" class="form-input" />
                            </div>
                            <div>
                                <label class="form-label">City</label>
                                <input v-model="profileForm.city" type="text" class="form-input" />
                            </div>
                        </div>

                        <div>
                            <label class="form-label">ORCID</label>
                            <input v-model="profileForm.orcid" type="text" class="form-input" placeholder="0000-0000-0000-0000" />
                            <p class="text-xs text-gray-400 mt-1">Format: 0000-0000-0000-000X</p>
                            <p v-if="profileForm.errors.orcid" class="form-error">{{ profileForm.errors.orcid }}</p>
                        </div>

                        <div>
                            <label class="form-label">Expertise</label>
                            <textarea v-model="profileForm.expertise" class="form-input" rows="3" placeholder="Your areas of expertise..." />
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                            <div>
                                <label class="form-label">Google Scholar URL</label>
                                <input v-model="profileForm.google_scholar" type="url" class="form-input" />
                            </div>
                            <div>
                                <label class="form-label">LinkedIn URL</label>
                                <input v-model="profileForm.linkedin" type="url" class="form-input" />
                            </div>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                            <div>
                                <label class="form-label">Personal Website</label>
                                <input v-model="profileForm.website" type="url" class="form-input" />
                            </div>
                            <div>
                                <label class="form-label">ResearchGate URL</label>
                                <input v-model="profileForm.research_gate" type="url" class="form-input" />
                            </div>
                        </div>

                        <div class="flex items-center gap-3">
                            <input v-model="profileForm.is_public" type="checkbox" class="rounded border-gray-300 text-navy-600 focus:ring-navy-500" id="is-public" />
                            <label for="is-public" class="text-sm text-gray-700">Make my profile public</label>
                        </div>

                        <div class="flex justify-end pt-2">
                            <button type="submit" class="btn-primary" :disabled="profileForm.processing">
                                Save Profile
                            </button>
                        </div>
                    </form>
                </KdCard>

                <!-- Research Interests tab -->
                <KdCard padding="wide" v-show="activeTab === 'interests'">
                    <h3 class="text-lg font-semibold text-gray-900 mb-5">Research Interests</h3>

                    <div class="flex gap-2 mb-4">
                        <input v-model="interestInput" @keyup.enter="addInterest" type="text" class="form-input flex-1" placeholder="Type an interest and press Enter" />
                        <button @click="addInterest" type="button" class="btn-secondary btn-sm">Add</button>
                    </div>

                    <div class="flex flex-wrap gap-2 mb-6" v-if="interests.length">
                        <span v-for="(interest, i) in interests" :key="i" class="inline-flex items-center gap-1 px-3 py-1.5 rounded-full bg-navy-50 text-navy-700 text-sm">
                            {{ interest }}
                            <button @click="removeInterest(i)" class="ml-1 text-navy-400 hover:text-red-500">
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-3.5 h-3.5"><path d="M6.28 5.22a.75.75 0 0 0-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 1 0 1.06 1.06L10 11.06l3.72 3.72a.75.75 0 1 0 1.06-1.06L11.06 10l3.72-3.72a.75.75 0 0 0-1.06-1.06L10 8.94 6.28 5.22Z" /></svg>
                            </button>
                        </span>
                    </div>

                    <p v-else class="text-sm text-gray-400 mb-6">No research interests added yet.</p>

                    <div class="flex justify-end">
                        <button @click="saveInterests" class="btn-primary">Save Interests</button>
                    </div>
                </KdCard>

                <!-- Affiliations tab -->
                <KdCard padding="wide" v-show="activeTab === 'affiliations'">
                    <div class="flex items-center justify-between mb-5">
                        <h3 class="text-lg font-semibold text-gray-900">Affiliations</h3>
                        <button @click="showAffForm = !showAffForm" class="btn-secondary btn-sm">
                            {{ showAffForm ? 'Cancel' : '+ Add' }}
                        </button>
                    </div>

                    <!-- Add form -->
                    <div v-if="showAffForm" class="p-4 bg-gray-50 rounded-lg mb-6">
                        <form @submit.prevent="addAffiliation" class="space-y-4">
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <div>
                                    <label class="form-label">Institution *</label>
                                    <input v-model="affForm.institution" type="text" class="form-input" required />
                                </div>
                                <div>
                                    <label class="form-label">Position</label>
                                    <input v-model="affForm.position" type="text" class="form-input" placeholder="e.g. Associate Professor" />
                                </div>
                            </div>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <div>
                                    <label class="form-label">Department</label>
                                    <input v-model="affForm.department" type="text" class="form-input" />
                                </div>
                                <div>
                                    <label class="form-label">Country</label>
                                    <input v-model="affForm.country" type="text" class="form-input" />
                                </div>
                            </div>
                            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                                <div>
                                    <label class="form-label">Start Date</label>
                                    <input v-model="affForm.start_date" type="date" class="form-input" />
                                </div>
                                <div>
                                    <label class="form-label">End Date</label>
                                    <input v-model="affForm.end_date" type="date" class="form-input" :disabled="affForm.is_current" />
                                </div>
                                <div class="flex items-end">
                                    <label class="flex items-center gap-2 pb-2">
                                        <input v-model="affForm.is_current" type="checkbox" class="rounded border-gray-300 text-navy-600" />
                                        <span class="text-sm text-gray-700">Current</span>
                                    </label>
                                </div>
                            </div>
                            <div class="flex justify-end">
                                <button type="submit" class="btn-primary btn-sm" :disabled="affForm.processing">Add Affiliation</button>
                            </div>
                        </form>
                    </div>

                    <!-- List -->
                    <div v-if="profile?.affiliations?.length" class="space-y-3">
                        <div v-for="aff in profile.affiliations" :key="aff.id" class="flex items-start justify-between gap-3 p-4 rounded-lg border border-gray-100">
                            <div>
                                <p class="text-sm font-semibold text-gray-900">{{ aff.institution }}</p>
                                <p v-if="aff.position" class="text-xs text-gray-600">{{ aff.position }}</p>
                                <p v-if="aff.department" class="text-xs text-gray-500">{{ aff.department }}</p>
                                <div class="flex items-center gap-2 mt-1">
                                    <KdBadge v-if="aff.is_current" variant="oa" size="sm">Current</KdBadge>
                                    <span v-if="aff.country" class="text-xs text-gray-400">{{ aff.country }}</span>
                                </div>
                            </div>
                            <button @click="removeAffiliation(aff.id)" class="text-xs text-red-500 hover:text-red-700 shrink-0">Remove</button>
                        </div>
                    </div>
                    <p v-else class="text-sm text-gray-400">No affiliations added yet.</p>
                </KdCard>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
