<?php

namespace Database\Seeders;

use App\Models\Service;
use Illuminate\Database\Seeder;

class ServiceSeeder extends Seeder
{
    public function run(): void
    {
        $services = [
            [
                'title' => 'KD Proofreading & Language Editing',
                'slug' => 'kd-proofreading',
                'description' => 'Comprehensive academic English editing and proofreading by native PhD subject specialists. Ensures 100% grammar accuracy, natural academic flow, and adherence to target journal guidelines.',
                'features' => [
                    'Native PhD subject-matter editors',
                    'Grammar, syntax, and punctuation refinement',
                    'Discipline-specific terminology verification',
                    'Target journal guideline alignment (APA, Vancouver, IEEE)',
                    'Official Certificate of Academic Editing',
                    'Free re-editing support for revised submissions',
                ],
                'process' => "1. Submit your manuscript and select turnaround (Standard 5-7d, Express 48h, Rush 24h).\n2. Assigned to a certified PhD editor in your scientific domain.\n3. Detailed two-pass editorial review and track-changes markup.\n4. Quality assurance check by senior managing editor.\n5. Download edited manuscript and official editing certificate.",
                'icon' => 'proofreading',
                'sort_order' => 1,
            ],
            [
                'title' => 'Manuscript Copyediting & Styling',
                'slug' => 'manuscript-editing',
                'description' => 'Structural, developmental, and stylistic editing to enhance manuscript clarity, logical argumentation, and narrative cohesion before submission to high-impact journals.',
                'features' => [
                    'Macro-structural flow and argumentation review',
                    'Abstract and introduction impact optimization',
                    'Clarity and conciseness improvements',
                    'Journal cover letter crafting',
                ],
                'process' => "1. Manuscript submission and target journal evaluation.\n2. In-depth structural and stylistic review by senior editor.\n3. Author query resolution and final delivery.",
                'icon' => 'editing',
                'sort_order' => 2,
            ],
            [
                'title' => 'Academic Translation Services',
                'slug' => 'academic-translation',
                'description' => 'Discipline-specific scholarly translation between English and 15+ major global academic languages by bilingual PhD researchers.',
                'features' => [
                    'Bilingual academic subject-matter translators',
                    'Preservation of nuanced technical terminology',
                    'Two-step translation + native English copyedit',
                    'Quality guarantee for journal peer review',
                ],
                'process' => "1. Upload source language manuscript.\n2. Primary translation by domain expert scholar.\n3. Native English editorial refinement and terminological consistency check.\n4. Final quality inspection and delivery.",
                'icon' => 'translation',
                'sort_order' => 3,
            ],
            [
                'title' => 'Academic Figure & Illustration Formatting',
                'slug' => 'academic-formatting',
                'description' => 'High-resolution graphical abstract design, figure enhancement, statistical chart styling, and typography formatting meeting strict publisher raster (300+ DPI) and vector requirements.',
                'features' => [
                    'Publication-quality 300/600 DPI vector and raster figures',
                    'Custom Graphical Abstract design',
                    'Scientific infographic visualization',
                    'TIFF, EPS, PDF, and high-res PNG export',
                ],
                'process' => "1. Upload draft figures, sketches, or raw datasets.\n2. Scientific illustrator crafts publication-ready graphics.\n3. Author review and unlimited minor revisions.",
                'icon' => 'figures',
                'sort_order' => 4,
            ],
            [
                'title' => 'Similarity Index & Plagiarism Reduction',
                'slug' => 'plagiarism-screening',
                'description' => 'Pre-submission similarity screening and ethical rewording to resolve flagged overlapping passages and ensure high academic integrity without altering empirical findings.',
                'features' => [
                    'Comprehensive similarity index percentage report',
                    'Sentence-by-sentence flagged overlap analysis',
                    'Expert academic rephrasing of duplicate phrases',
                    'Confidential scanning without repository storage',
                ],
                'process' => "1. Upload manuscript file for confidential screening.\n2. Automated scan against global academic databases.\n3. Editorial rephrasing of overlapping text.\n4. Receive similarity report under target journal threshold (< 10-15%).",
                'icon' => 'plagiarism',
                'sort_order' => 5,
            ],
            [
                'title' => 'AI Index & Paraphrasing Reduction',
                'slug' => 'ai-index-reduction',
                'description' => 'Humanizing and academically refining AI-assisted text to remove formulaic syntax, repetitive phrasing, and generic patterns while elevating human scientific voice.',
                'features' => [
                    'Deep editorial rewrite of AI-generated/assisted drafts',
                    'Restoration of natural, authoritative scientific voice',
                    'Verification of factual and citation authenticity',
                    'Pre-submission AI detection screening validation',
                ],
                'process' => "1. Upload manuscript containing AI-drafted sections.\n2. PhD specialist manually rewrites and enriches context.\n3. Rigorous cross-check against AI pattern detectors.\n4. Clean, authentic academic manuscript delivery.",
                'icon' => 'ai-reduction',
                'sort_order' => 6,
            ],
            [
                'title' => 'Research Grant & Publication Consultancy',
                'slug' => 'publication-consultancy',
                'description' => 'Strategic publication planning, journal selection advisory, grant proposal review, and response-to-reviewers rebuttal consultation to maximize research reach and funding success.',
                'features' => [
                    'Aims and scope journal matching matrix',
                    'Grant proposal competitiveness review',
                    'Editorial rebuttal letter strategizing',
                    'Post-publication research impact amplification',
                ],
                'process' => "1. Initial research portfolio assessment.\n2. 1-on-1 strategy session with senior publication consultant.\n3. Actionable roadmap and submission guidance report.",
                'icon' => 'consultancy',
                'sort_order' => 7,
            ],
            [
                'title' => 'Journal Publishing & Hosting Solutions',
                'slug' => 'journal-publishing',
                'description' => 'End-to-end open-access journal publishing infrastructure, editorial workflow management, OJS/custom platform hosting, indexing support, and digital preservation.',
                'features' => [
                    'Full journal setup with custom domain and ISSN',
                    'Automated editorial and peer-review workflows',
                    'DOAJ, Scopus, and WoS indexing readiness',
                    'Long-term archival preservation (Portico/CLOCKSS ready)',
                ],
                'process' => "1. Initial institutional consultation and journal scoping.\n2. Technical setup and editorial board configuration.\n3. Launch, indexing application, and ongoing publishing operations.",
                'icon' => 'journal',
                'sort_order' => 8,
            ],
            [
                'title' => 'DOI & Crossref Metadata Deposit Service',
                'slug' => 'doi-metadata-support',
                'description' => 'Digital Object Identifier (DOI) minting, Crossref XML schema deposit, scholarly metadata enrichment, and citation tracking integration for academic publishers and institutions.',
                'features' => [
                    'Crossref DOI prefix allocation and registration',
                    'Automated XML deposit with rich metadata',
                    'Reference linking and Cited-by tracking',
                    'ORCID auto-update integration',
                ],
                'process' => "1. Connect journal or repository archive.\n2. Automated metadata extraction and schema validation.\n3. Official Crossref deposit and permanent DOI resolution.",
                'icon' => 'doi',
                'sort_order' => 9,
            ],
        ];

        foreach ($services as $svc) {
            Service::updateOrCreate(
                ['slug' => $svc['slug']],
                $svc
            );
        }
    }
}
