<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const props = defineProps({
    journals: {
        type: Array,
        default: () => [],
    },
    activeTab: {
        type: String,
        default: 'overview',
    },
});
</script>

<template>
    <Head>
        <title>Resource Center for Librarians — Knowledge Dynamics</title>
        <meta name="description" content="Library discovery resources, MARC records, KBART metadata, open access licensing, and print subscription orders for university librarians." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Institutional Subscriptions & Discovery</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Resource Center for Librarians</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Knowledge Dynamics supports university and research libraries worldwide with open access content integration, standardized metadata schemas, MARC/KBART files, and institutional print ordering.
                    </p>
                </div>
            </div>
        </section>

        <!-- Content Tabs -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-5xl space-y-8">
                <!-- Journals Catalogue Table -->
                <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-6">
                    <div>
                        <h2 class="text-xl font-bold text-gray-900">Knowledge Dynamics Journal Catalogue</h2>
                        <p class="text-xs text-gray-500 mt-1">Complete bibliographic data, ISSNs, frequency, and indexing status.</p>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-xs md:text-sm text-gray-600">
                            <thead class="bg-gray-50 text-xs uppercase font-bold text-gray-700 border-b border-gray-200">
                                <tr>
                                    <th class="px-4 py-3">Journal Title</th>
                                    <th class="px-4 py-3">Print ISSN</th>
                                    <th class="px-4 py-3">Online ISSN</th>
                                    <th class="px-4 py-3">Frequency</th>
                                    <th class="px-4 py-3">Access Model</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <tr v-for="j in journals" :key="j.slug" class="hover:bg-gray-50/80 transition">
                                    <td class="px-4 py-3.5 font-bold text-navy-900">
                                        <Link :href="route('journals.show', j.slug)" class="hover:text-academic-600">
                                            {{ j.title }}
                                        </Link>
                                    </td>
                                    <td class="px-4 py-3.5 font-mono">{{ j.issn_print || '—' }}</td>
                                    <td class="px-4 py-3.5 font-mono text-navy-700 font-semibold">{{ j.issn_online }}</td>
                                    <td class="px-4 py-3.5">{{ j.publication_frequency }}</td>
                                    <td class="px-4 py-3.5">
                                        <span class="text-[11px] font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded border border-emerald-200">
                                            Open Access (CC BY)
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Librarian FAQs and Print Orders Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Print, ePrint & Reprint FAQs -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4">
                        <h3 class="text-base font-bold text-gray-900">FAQs: Print, ePrint & Institutional Archiving</h3>
                        <div class="space-y-3 text-xs md:text-sm text-gray-600">
                            <div>
                                <h4 class="font-bold text-gray-800">How do we harvest metadata into institutional repositories?</h4>
                                <p class="mt-0.5 text-xs text-gray-500">We support Crossref REST API querying and automated OAI-PMH metadata feeds.</p>
                            </div>
                            <div class="pt-2 border-t border-gray-100">
                                <h4 class="font-bold text-gray-800">Can libraries order custom print compilations?</h4>
                                <p class="mt-0.5 text-xs text-gray-500">Yes, annual bound hardcopy volumes are available on acid-free archival paper with international dispatch.</p>
                            </div>
                            <div class="pt-2 border-t border-gray-100">
                                <h4 class="font-bold text-gray-800">What is the digital preservation policy?</h4>
                                <p class="mt-0.5 text-xs text-gray-500">All content is archived in long-term preservation vaults with permanent DOI resolution.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Order Print & Contact Desk -->
                    <div class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-4 flex flex-col justify-between">
                        <div>
                            <h3 class="text-base font-bold text-gray-900">Order Print Issues & Library Subscriptions</h3>
                            <p class="text-xs text-gray-600 mt-1 leading-relaxed">
                                To establish an institutional print standing order, request sample issues, or receive institutional invoicing, please connect with our Library Relations Department.
                            </p>
                            <div class="mt-4 p-4 bg-navy-50 rounded-lg border border-navy-100 text-xs text-navy-800 space-y-1">
                                <div class="font-bold">Library Relations Office</div>
                                <div>Email: <a href="mailto:librarians@knowdyn.org" class="underline">librarians@knowdyn.org</a></div>
                                <div>Invoicing: Net 30 days for accredited university libraries</div>
                            </div>
                        </div>

                        <Link :href="route('contact')" class="btn-primary text-xs w-full py-2.5 shadow-sm mt-4 text-center">
                            Submit Library Order Request →
                        </Link>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
