<script setup>
import { computed } from 'vue';
import { Head, Link, useForm, usePage } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    service: {
        type: Object,
        required: true,
    },
});

const page = usePage();
const currentUser = computed(() => page.props.auth?.user);

const form = useForm({
    service_id: props.service.id,
    name: currentUser.value?.name || '',
    email: currentUser.value?.email || '',
    phone: '',
    message: '',
});

const submitInquiry = () => {
    form.post(route('services.request.store'), {
        onSuccess: () => {
            form.reset('message');
        },
    });
};
</script>

<template>
    <Head>
        <title>{{ service.title }} — Publishing Services</title>
        <meta name="description" :content="service.description" />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <Link :href="route('services')" class="text-xs font-semibold text-academic-300 hover:text-white transition inline-flex items-center gap-1 mb-3">
                        ← All Publishing Services
                    </Link>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white">{{ service.title }}</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        {{ service.description }}
                    </p>
                </div>
            </div>
        </section>

        <!-- Content & Inquiry Form Grid -->
        <section class="section bg-gray-50/50">
            <div class="container-wide">
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
                    <!-- Left: Details, Features & Process -->
                    <div class="lg:col-span-7 space-y-8">
                        <!-- Key Features -->
                        <div v-if="service.features && service.features.length > 0" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4">
                            <h2 class="text-lg font-bold text-gray-900">What is Included in this Service</h2>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs md:text-sm text-gray-700">
                                <div v-for="(feat, fIdx) in service.features" :key="fIdx" class="flex items-start gap-2.5">
                                    <span class="text-emerald-600 font-bold text-base">✓</span>
                                    <span class="leading-relaxed">{{ feat }}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Service Delivery Process -->
                        <div v-if="service.process" class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4">
                            <h2 class="text-lg font-bold text-gray-900">Our Service Delivery Process</h2>
                            <p class="text-xs md:text-sm text-gray-700 leading-relaxed whitespace-pre-line">{{ service.process }}</p>
                        </div>
                    </div>

                    <!-- Right: Inquiry Form -->
                    <div class="lg:col-span-5">
                        <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6 sticky top-20">
                            <div>
                                <h3 class="text-lg font-bold text-gray-900">Request {{ service.title }}</h3>
                                <p class="text-xs text-gray-500 mt-1">Get in touch with our publishing consultants to get started.</p>
                            </div>

                            <form @submit.prevent="submitInquiry" class="space-y-4">
                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Your Full Name *</label>
                                    <input
                                        v-model="form.name"
                                        type="text"
                                        required
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Email Address *</label>
                                    <input
                                        v-model="form.email"
                                        type="email"
                                        required
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Phone / WhatsApp</label>
                                    <input
                                        v-model="form.phone"
                                        type="text"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    />
                                </div>

                                <div>
                                    <label class="block text-xs font-semibold text-gray-700 uppercase mb-1">Project Details & Requirements *</label>
                                    <textarea
                                        v-model="form.message"
                                        rows="4"
                                        required
                                        placeholder="Describe your journal, manuscript, or publication objectives..."
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-navy-600 focus:outline-none"
                                    ></textarea>
                                </div>

                                <button
                                    type="submit"
                                    :disabled="form.processing"
                                    class="btn-primary text-xs w-full py-2.5 shadow-sm"
                                >
                                    {{ form.processing ? 'Submitting...' : 'Submit Service Request' }}
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
