<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';

const props = defineProps({
    journal: {
        type: Object,
        required: true,
    },
    groupedBoard: {
        type: Object,
        default: () => ({}),
    },
});
</script>

<template>
    <Head>
        <title>Editorial Board — {{ journal.title }} — Knowledge Dynamics</title>
        <meta name="description" :content="`International editorial board and leadership directory for ${journal.title}.`" />
    </Head>

    <PublicLayout>
        <!-- Header -->
        <section class="bg-navy-800 text-white py-12 border-b border-navy-700">
            <div class="container-wide">
                <nav class="flex items-center gap-2 text-xs text-navy-300 mb-4">
                    <Link :href="route('home')" class="hover:text-white transition">Home</Link>
                    <span>/</span>
                    <Link :href="route('journals.index')" class="hover:text-white transition">Journals</Link>
                    <span>/</span>
                    <Link :href="route('journals.show', journal.slug)" class="hover:text-white transition">{{ journal.short_title || journal.title }}</Link>
                    <span>/</span>
                    <span class="text-white font-medium">Editorial Board</span>
                </nav>

                <h1 class="text-2xl sm:text-4xl font-bold tracking-tight text-white">
                    Editorial Board & Leadership
                </h1>
                <p class="mt-2 text-sm text-navy-200">
                    {{ journal.title }} • Peer Review & Scientific Governance
                </p>
            </div>
        </section>

        <!-- Board Directory -->
        <div class="container-wide py-12">
            <div v-if="Object.keys(groupedBoard).length === 0" class="text-center py-16 bg-white rounded-xl border border-gray-200">
                <p class="text-gray-500">Editorial board details are currently being finalized.</p>
            </div>

            <div v-else class="space-y-12">
                <div
                    v-for="(members, role) in groupedBoard"
                    :key="role"
                    class="space-y-6"
                >
                    <!-- Role Heading -->
                    <div class="flex items-center gap-3 pb-3 border-b-2 border-navy-800">
                        <span class="w-3 h-3 bg-academic-600 rounded-sm"></span>
                        <h2 class="text-xl sm:text-2xl font-bold text-gray-900">
                            {{ role }}
                        </h2>
                        <span class="text-xs font-semibold text-gray-500 bg-gray-100 px-2 py-0.5 rounded-full">
                            {{ members.length }}
                        </span>
                    </div>

                    <!-- Members Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <div
                            v-for="member in members"
                            :key="member.id"
                            class="bg-white rounded-xl border border-gray-200 p-6 shadow-sm hover:shadow-md transition flex flex-col justify-between"
                        >
                            <div>
                                <div class="flex items-start justify-between gap-2 mb-2">
                                    <h3 class="text-base font-bold text-gray-900">
                                        {{ member.name }}
                                    </h3>
                                    <a
                                        v-if="member.orcid"
                                        :href="`https://orcid.org/${member.orcid}`"
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        class="shrink-0 text-emerald-600 hover:text-emerald-700"
                                        title="ORCID Profile"
                                    >
                                        <svg class="w-4 h-4 fill-current" viewBox="0 0 256 256">
                                            <path d="M128 0C57.3 0 0 57.3 0 128s57.3 128 128 128 128-57.3 128-128S198.7 0 128 0zm-38.3 189.6h-21.7V93.3h21.7v96.3zm-10.9-109.4c-6.9 0-12.6-5.6-12.6-12.6s5.6-12.6 12.6-12.6 12.6 5.6 12.6 12.6-5.6 12.6-12.6 12.6zm106.8 62.9c0 26.6-21.6 48.2-48.2 48.2h-36.4V93.3h36.4c26.6 0 48.2 21.6 48.2 48.2v.2zm-21.7 0c0-14.6-11.9-26.5-26.5-26.5h-14.7v53h14.7c14.6 0 26.5-11.9 26.5-26.5z" />
                                        </svg>
                                    </a>
                                </div>

                                <p class="text-xs font-semibold text-navy-700 mb-2">
                                    {{ member.role }}
                                </p>

                                <div class="text-xs text-gray-600 space-y-1">
                                    <p v-if="member.institution" class="font-medium text-gray-800">
                                        {{ member.institution }}
                                    </p>
                                    <p v-if="member.country" class="text-gray-500">
                                        {{ member.country }}
                                    </p>
                                </div>

                                <p v-if="member.biography" class="text-xs text-gray-600 mt-3 pt-3 border-t border-gray-100 line-clamp-3 leading-relaxed">
                                    {{ member.biography }}
                                </p>
                            </div>

                            <div v-if="member.email" class="mt-4 pt-3 border-t border-gray-50 text-[11px] text-gray-500">
                                Contact: <span class="font-mono">{{ member.email }}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </PublicLayout>
</template>
