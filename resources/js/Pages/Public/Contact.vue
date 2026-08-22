<script setup>
import { Head, useForm } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const form = useForm({
    name: '',
    email: '',
    subject: '',
    message: '',
});

const submit = () => {
    // Will connect to backend later
    form.post('/contact', {
        preserveScroll: true,
        onSuccess: () => form.reset(),
    });
};

const contactInfo = [
    { label: 'Email', value: 'info@knowledge-dynamics.com', icon: 'email', href: 'mailto:info@knowledge-dynamics.com' },
    { label: 'Support', value: 'support@knowledge-dynamics.com', icon: 'support', href: 'mailto:support@knowledge-dynamics.com' },
    { label: 'Website', value: 'knowledge-dynamics.com', icon: 'web', href: 'https://knowledge-dynamics.com' },
];
</script>

<template>
    <Head>
        <title>Contact Us — Knowledge Dynamics</title>
        <meta name="description" content="Get in touch with Knowledge Dynamics. Contact us for journal inquiries, manuscript submissions, publishing services, or general information." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-700 py-14 md:py-20">
            <div class="container-wide">
                <p class="text-xs font-semibold uppercase tracking-widest text-academic-300 mb-3">Contact</p>
                <h1 class="text-3xl md:text-4xl font-bold text-white">Get in Touch</h1>
                <p class="mt-4 text-navy-200 max-w-xl text-base leading-relaxed">
                    Have a question about journal publishing, manuscript submissions, or our services? We are here to help.
                </p>
            </div>
        </section>

        <section class="section bg-white">
            <div class="container-wide">
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 lg:gap-12">
                    <!-- Contact info sidebar -->
                    <div>
                        <h2 class="text-lg font-semibold text-gray-900 mb-6">Contact Information</h2>
                        <div class="space-y-5">
                            <a v-for="info in contactInfo" :key="info.label" :href="info.href" class="flex items-start gap-3 group">
                                <div class="w-9 h-9 rounded-lg bg-navy-50 flex items-center justify-center shrink-0 group-hover:bg-academic-50 transition-colors">
                                    <svg v-if="info.icon === 'email'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 text-navy-600 group-hover:text-academic-600 transition-colors">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75" />
                                    </svg>
                                    <svg v-if="info.icon === 'support'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 text-navy-600 group-hover:text-academic-600 transition-colors">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M16.712 4.33a9.027 9.027 0 0 1 1.652 1.306c.51.51.944 1.064 1.306 1.652M16.712 4.33l-3.448 4.138m3.448-4.138a9.014 9.014 0 0 0-9.424 0M19.67 7.288l-4.138 3.448m4.138-3.448a9.014 9.014 0 0 1 0 9.424m-4.138-5.976a3.736 3.736 0 0 0-.88-1.388 3.737 3.737 0 0 0-1.388-.88m2.268 2.268a3.765 3.765 0 0 1 0 2.528m-2.268-4.796a3.765 3.765 0 0 0-2.528 0m4.796 4.796c-.181.506-.475.982-.88 1.388a3.736 3.736 0 0 1-1.388.88m2.268-2.268 4.138 3.448m0 0a9.027 9.027 0 0 1-1.306 1.652c-.51.51-1.064.944-1.652 1.306m0 0-3.448-4.138m3.448 4.138a9.014 9.014 0 0 1-9.424 0m5.976-4.138a3.765 3.765 0 0 1-2.528 0m0 0a3.736 3.736 0 0 1-1.388-.88 3.737 3.737 0 0 1-.88-1.388m0 0-4.138 3.448M7.288 19.67a9.014 9.014 0 0 1 0-9.424m4.138 5.976-3.448 4.138m0 0a9.027 9.027 0 0 1-1.652-1.306 9.027 9.027 0 0 1-1.306-1.652m0 0 4.138-3.448M4.33 7.288a9.014 9.014 0 0 0 0 9.424m0-9.424 4.138 3.448m-4.138-3.448A9.027 9.027 0 0 1 5.982 5.982a9.027 9.027 0 0 1 1.306-1.652m0 0 3.448 4.138m-3.448-4.138a9.014 9.014 0 0 1 9.424 0M11.264 10.736a3.765 3.765 0 0 0 0 2.528m0-2.528 4.138-3.448M11.264 13.264l-4.138 3.448" />
                                    </svg>
                                    <svg v-if="info.icon === 'web'" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 text-navy-600 group-hover:text-academic-600 transition-colors">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 0 0 8.716-6.747M12 21a9.004 9.004 0 0 1-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 0 1 7.843 4.582M12 3a8.997 8.997 0 0 0-7.843 4.582m15.686 0A11.953 11.953 0 0 1 12 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0 1 21 12c0 .778-.099 1.533-.284 2.253m0 0A17.919 17.919 0 0 1 12 16.5c-3.162 0-6.133-.815-8.716-2.247m0 0A9.015 9.015 0 0 1 3 12c0-1.605.42-3.113 1.157-4.418" />
                                    </svg>
                                </div>
                                <div>
                                    <p class="text-xs text-gray-400">{{ info.label }}</p>
                                    <p class="text-sm font-medium text-gray-700 group-hover:text-academic-600 transition-colors">{{ info.value }}</p>
                                </div>
                            </a>
                        </div>

                        <div class="mt-8 p-5 bg-navy-50 rounded-lg">
                            <h3 class="text-sm font-semibold text-navy-700 mb-2">Office Hours</h3>
                            <p class="text-sm text-gray-600">Sunday – Thursday: 9 AM – 5 PM (BST)</p>
                            <p class="text-sm text-gray-600">Friday – Saturday: Closed</p>
                        </div>
                    </div>

                    <!-- Contact form -->
                    <div class="lg:col-span-2">
                        <KdCard padding="wide">
                            <h2 class="text-lg font-semibold text-gray-900 mb-6">Send Us a Message</h2>
                            <form @submit.prevent="submit" class="space-y-5">
                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                                    <div>
                                        <label class="form-label" for="contact-name">Full Name</label>
                                        <input id="contact-name" v-model="form.name" type="text" class="form-input" placeholder="Your full name" required />
                                        <p v-if="form.errors.name" class="form-error">{{ form.errors.name }}</p>
                                    </div>
                                    <div>
                                        <label class="form-label" for="contact-email">Email Address</label>
                                        <input id="contact-email" v-model="form.email" type="email" class="form-input" placeholder="you@example.com" required />
                                        <p v-if="form.errors.email" class="form-error">{{ form.errors.email }}</p>
                                    </div>
                                </div>
                                <div>
                                    <label class="form-label" for="contact-subject">Subject</label>
                                    <select id="contact-subject" v-model="form.subject" class="form-input" required>
                                        <option value="">Select a subject</option>
                                        <option>General Inquiry</option>
                                        <option>Journal Publishing</option>
                                        <option>Manuscript Submission</option>
                                        <option>Publishing Services</option>
                                        <option>Proofreading</option>
                                        <option>Technical Support</option>
                                        <option>Partnership</option>
                                        <option>Other</option>
                                    </select>
                                    <p v-if="form.errors.subject" class="form-error">{{ form.errors.subject }}</p>
                                </div>
                                <div>
                                    <label class="form-label" for="contact-message">Message</label>
                                    <textarea id="contact-message" v-model="form.message" class="form-input" rows="5" placeholder="How can we help?" required />
                                    <p v-if="form.errors.message" class="form-error">{{ form.errors.message }}</p>
                                </div>
                                <div class="flex justify-end">
                                    <button type="submit" class="btn-primary btn-lg" :disabled="form.processing">
                                        <svg v-if="form.processing" class="animate-spin -ml-1 mr-2 h-4 w-4" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" /><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" /></svg>
                                        Send Message
                                    </button>
                                </div>
                            </form>
                        </KdCard>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
