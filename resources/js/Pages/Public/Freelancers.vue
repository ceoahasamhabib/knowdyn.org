<script setup>
import { Head, Link } from '@inertiajs/vue3';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import KdCard from '@/Components/KD/KdCard.vue';

const editors = [
    {
        name: 'Dr. Arthur Sterling, PhD',
        discipline: 'Biomedical & Clinical Sciences',
        degree: 'PhD in Molecular Oncology, University of Cambridge',
        experience: '12+ Years Editorial Experience • 450+ Manuscripts Edited',
        specialization: 'Vancouver/ICMJE style, clinical trials, epidemiology',
    },
    {
        name: 'Dr. Claire Beauchamp, PhD',
        discipline: 'Agricultural & Food Science Nutrition',
        degree: 'PhD in Food Biotechnology, McGill University',
        experience: '9+ Years Editorial Experience • 320+ Manuscripts Edited',
        specialization: 'Bioactive formulation, sensory analysis, APA 7th',
    },
    {
        name: 'Dr. Julian Ross, PhD',
        discipline: 'Economics, Management & Quantitative Finance',
        degree: 'PhD in Financial Econometrics, London School of Economics',
        experience: '11+ Years Editorial Experience • 380+ Manuscripts Edited',
        specialization: 'Empirical econometric models, corporate governance, ESG',
    },
    {
        name: 'Dr. Yasmin Farooq, PhD',
        discipline: 'Comparative Religion, Theology & Philosophy',
        degree: 'PhD in Religious Studies, University of Oxford',
        experience: '8+ Years Editorial Experience • 210+ Monographs & Articles',
        specialization: 'Chicago Notes & Bibliography, textual exegesis, translation',
    },
];
</script>

<template>
    <Head>
        <title>Our Freelance Editors & Proofreaders — Knowledge Dynamics</title>
        <meta name="description" content="Meet our certified PhD native English academic editors, copyeditors, and subject-matter proofreading specialists across KD Proofreading." />
    </Head>

    <PublicLayout>
        <!-- Hero -->
        <section class="bg-navy-800 text-white py-14 md:py-20 relative overflow-hidden">
            <div class="container-wide relative">
                <div class="max-w-3xl">
                    <span class="text-xs font-semibold uppercase tracking-widest text-academic-300">Certified Editorial Talent</span>
                    <h1 class="text-3xl md:text-5xl font-bold tracking-tight text-white mt-2">Our Academic Freelancer Editors</h1>
                    <p class="mt-4 text-navy-200 text-base md:text-lg leading-relaxed">
                        Every KD Proofreading project is assigned to a certified PhD subject-matter specialist with native English proficiency and proven high-impact publication track records.
                    </p>
                    <div class="mt-6">
                        <Link :href="route('proofreading.index')" class="btn-primary text-xs py-2 px-5 shadow-sm">
                            Calculate Proofreading Fees →
                        </Link>
                    </div>
                </div>
            </div>
        </section>

        <!-- Editors Grid -->
        <section class="section bg-gray-50/50">
            <div class="container-wide max-w-5xl space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div
                        v-for="(ed, idx) in editors"
                        :key="idx"
                        class="bg-white rounded-xl border border-gray-200 p-6 md:p-8 shadow-sm space-y-3"
                    >
                        <div class="flex items-center justify-between">
                            <span class="text-[11px] font-bold text-navy-700 bg-navy-50 px-2.5 py-0.5 rounded border border-navy-100 uppercase">
                                {{ ed.discipline }}
                            </span>
                            <span class="text-xs font-bold text-emerald-700">✓ Verified PhD</span>
                        </div>

                        <h3 class="text-lg font-bold text-gray-900">{{ ed.name }}</h3>
                        <p class="text-xs text-academic-600 font-semibold">{{ ed.degree }}</p>
                        <p class="text-xs text-gray-500">{{ ed.experience }}</p>

                        <div class="pt-2 text-xs text-gray-600 border-t border-gray-100">
                            <span class="font-semibold text-gray-800">Specialization:</span> {{ ed.specialization }}
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </PublicLayout>
</template>
