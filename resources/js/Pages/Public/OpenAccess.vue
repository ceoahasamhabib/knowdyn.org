<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

</script>

<template>
    <Head>
        <title>Open Access Statement & Policy — Knowledge Dynamics</title>
        <meta name="description" content="Read the Knowledge Dynamics Open Access policy, Creative Commons CC BY licensing, author self-archiving rights, and APC transparency principles." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Unrestricted Scholarly Dissemination</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Open Access Policy</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Knowledge Dynamics is committed to the universal, barrier-free dissemination of scientific and scholarly research under the Creative Commons Attribution 4.0 International (CC BY 4.0) License.
                    </p>
                </div>
            </div>
        </section>

        <!-- Content Section -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-4xl space-y-8">
                <div class="bg-white rounded-xl border border-gray-200 p-8 md:p-12 shadow-sm space-y-6 text-gray-700 text-sm md:text-base leading-relaxed">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900">1. Immediate Open Access</h2>
                        <p class="mt-2">
                            All research articles, reviews, case reports, and commentaries published across Knowledge Dynamics journals are made immediately and permanently freely accessible online to readers globally without subscription barriers or registration fees.
                        </p>
                    </div>

                    <div class="pt-4 border-t border-gray-100">
                        <h2 class="text-2xl font-bold text-gray-900">2. Licensing & Copyright Terms</h2>
                        <p class="mt-2">
                            Articles are published under the <strong>Creative Commons Attribution 4.0 International (CC BY 4.0)</strong> license. Authors retain full copyright of their intellectual property without restrictions. Anyone is free to:
                        </p>
                        <ul class="list-disc pl-5 mt-3 space-y-1.5 text-xs md:text-sm text-gray-600">
                            <li><strong>Share:</strong> Copy and redistribute the material in any medium or format.</li>
                            <li><strong>Adapt:</strong> Remix, transform, and build upon the material for any purpose, even commercially.</li>
                            <li><strong>Attribution:</strong> Provided appropriate credit is given to the original authors and Knowledge Dynamics as the original publisher with DOI link.</li>
                        </ul>
                    </div>

                    <div class="pt-4 border-t border-gray-100">
                        <h2 class="text-2xl font-bold text-gray-900">3. Self-Archiving & Repository Deposit</h2>
                        <p class="mt-2">
                            Authors are actively encouraged to deposit the final published version (Publisher's PDF) or the Accepted Author Manuscript (AAM) into their university repository, institutional archive, or subject repositories (such as PubMed Central, arXiv, ResearchGate) immediately upon publication without embargo.
                        </p>
                    </div>

                    <div class="pt-6 border-t border-gray-100 flex flex-wrap gap-4 items-center justify-between">
                        <div>
                            <div class="font-bold text-gray-900">Ready to publish your research Open Access?</div>
                            <div class="text-xs text-gray-500">Submit your manuscript today for rigorous double-blind peer review.</div>
                        </div>
                        <Link :href="route('manuscripts.create')" class="btn-primary text-xs py-2 px-6 shadow-sm">
                            Submit Article Now →
                        </Link>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
