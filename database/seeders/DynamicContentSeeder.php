<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\Career;
use App\Models\GuidelinePage;
use App\Models\NewsEvent;
use App\Models\SiteSetting;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DynamicContentSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Books
        $books = [
            [
                'title' => 'Advanced Methodologies in Public Health Surveillance',
                'slug' => 'advanced-methodologies-in-public-health-surveillance',
                'author' => 'Prof. Dr. Sarah Al-Mansoor',
                'isbn' => '978-3-006-5501-2',
                'year' => 2024,
                'pages' => 384,
                'category' => 'Medicine & Health',
                'format' => 'Print & eBook',
                'description' => 'A comprehensive reference text exploring epidemiological modeling, decentralized healthcare analytics, and predictive pandemic response frameworks.',
                'doi' => '10.58421/books.2024.01',
                'is_open_access' => true,
                'sort_order' => 1,
            ],
            [
                'title' => 'Sustainable Agricultural Systems and Functional Nutrition',
                'slug' => 'sustainable-agricultural-systems-functional-nutrition',
                'author' => 'Prof. Dr. Giovanni Rossi & Dr. Lin Wei',
                'isbn' => '978-3-007-8812-9',
                'year' => 2024,
                'pages' => 450,
                'category' => 'Food Science & Agriculture',
                'format' => 'Print & eBook',
                'description' => 'Fundamental principles of functional bioactives, micro-encapsulation technologies, and green agricultural processing paradigms.',
                'doi' => '10.58421/books.2024.02',
                'is_open_access' => false,
                'sort_order' => 2,
            ],
            [
                'title' => 'Maritime Trade and Cultural Synthesis in Southeast Asia',
                'slug' => 'maritime-trade-cultural-synthesis-southeast-asia',
                'author' => 'Prof. Kenji Takahashi',
                'isbn' => '978-3-008-1123-6',
                'year' => 2023,
                'pages' => 312,
                'category' => 'Asian Studies & History',
                'format' => 'Print & eBook',
                'description' => 'Archival reconstruction of historical mercantile circuits and cross-cultural synthesis across the Straits of Malacca from the 14th to 18th century.',
                'doi' => '10.58421/books.2023.01',
                'is_open_access' => true,
                'sort_order' => 3,
            ],
            [
                'title' => 'Econometric Modeling of ESG Integration and Capital Cost',
                'slug' => 'econometric-modeling-esg-integration-capital-cost',
                'author' => 'Prof. Dr. Michael Sterling',
                'isbn' => '978-3-009-4456-3',
                'year' => 2023,
                'pages' => 290,
                'category' => 'Business, Economics & Finance',
                'format' => 'eBook Only',
                'description' => 'Quantitative econometric frameworks evaluating how non-financial sustainability metrics influence firm debt pricing and equity volatility.',
                'doi' => '10.58421/books.2023.02',
                'is_open_access' => false,
                'sort_order' => 4,
            ],
            [
                'title' => 'Comparative Hermeneutics in Abrahamic Ethical Traditions',
                'slug' => 'comparative-hermeneutics-abrahamic-ethical-traditions',
                'author' => 'Prof. Dr. Tariq Al-Hashimi & Dr. Miriam Cohen',
                'isbn' => '978-3-010-7789-0',
                'year' => 2024,
                'pages' => 340,
                'category' => 'Theology & Comparative Religion',
                'format' => 'Print & eBook',
                'description' => 'Interdisciplinary textual exegesis examining ethical convergence, restorative justice, and peacebuilding principles in sacred texts.',
                'doi' => '10.58421/books.2024.03',
                'is_open_access' => true,
                'sort_order' => 5,
            ],
        ];

        foreach ($books as $b) {
            Book::updateOrCreate(['slug' => $b['slug']], $b);
        }

        // 2. News & Events
        $newsEvents = [
            [
                'title' => 'Call for Papers: Special Issue on Climate Resilient Food Processing Systems',
                'slug' => 'call-for-papers-climate-resilient-food-processing',
                'type' => 'announcement',
                'category' => 'Special Issue CFP',
                'summary' => 'KD Food Science Nutrition invites high-impact original research papers and critical systematic reviews for an upcoming special issue on sustainable food technology.',
                'deadline' => 'December 31, 2026',
                'is_featured' => true,
                'is_published' => true,
            ],
            [
                'title' => 'Knowledge Dynamics Journals Achieve Full Crossref and DOAJ Indexing Compliance',
                'slug' => 'kd-journals-crossref-doaj-indexing-milestone',
                'type' => 'news',
                'category' => 'Publisher News',
                'summary' => 'All five flagship Knowledge Dynamics journals have integrated real-time Crossref DOI deposit schemas and adhere to strict DOAJ open-access criteria.',
                'is_featured' => true,
                'is_published' => true,
            ],
            [
                'title' => 'International Symposium on Decentralized Digital Health & Epidemiology',
                'slug' => 'symposium-decentralized-digital-health-epidemiology-2026',
                'type' => 'event',
                'category' => 'Academic Symposium',
                'summary' => 'A three-day hybrid symposium gathering epidemiologists, public health directors, and biomedical data scientists.',
                'event_date' => 'October 14–16, 2026',
                'location' => 'Virtual & Stockholm, Sweden',
                'registration_url' => 'https://knowdyn.org/events/register/1',
                'is_featured' => true,
                'is_published' => true,
            ],
            [
                'title' => 'Workshop: Writing for High-Impact International Open Access Journals',
                'slug' => 'workshop-writing-for-high-impact-open-access-journals',
                'type' => 'workshop',
                'category' => 'Author Masterclass',
                'summary' => 'Practical masterclass by Knowledge Dynamics Editors-in-Chief on structuring manuscripts, navigating peer review, and responding to reviewer critiques.',
                'event_date' => 'November 05, 2026',
                'location' => 'Interactive Webinar',
                'registration_url' => 'https://knowdyn.org/events/register/2',
                'is_featured' => false,
                'is_published' => true,
            ],
        ];

        foreach ($newsEvents as $ne) {
            NewsEvent::updateOrCreate(['slug' => $ne['slug']], $ne);
        }

        // 3. Careers
        $careers = [
            [
                'title' => 'Section Editor — Biomedical & Health Sciences',
                'slug' => 'section-editor-biomedical-health-sciences',
                'department' => 'Health Dynamics Editorial Office',
                'type' => 'Academic Editorial Role (Part-Time / Remote)',
                'summary' => 'We are seeking an active PhD researcher with a track record of peer-reviewed publications to oversee peer review workflows in epidemiological and clinical sciences.',
                'requirements' => "• PhD in Medicine, Public Health, Epidemiology, or related biomedical discipline.\n• Minimum 5 publications in indexed Q1/Q2 journals.\n• Experience in handling peer review cycles.",
                'is_active' => true,
                'deadline' => 'Open until filled',
            ],
            [
                'title' => 'Managing Editor — Business, Management & Finance',
                'slug' => 'managing-editor-business-management-finance',
                'department' => 'KD ABMF Publishing Group',
                'type' => 'Full-Time / Hybrid',
                'summary' => 'Coordinate editorial peer review cycles, oversee reviewer assignments, and liaise with authors for high-impact empirical business research.',
                'requirements' => "• PhD or Master's degree in Economics, Finance, or Management.\n• Minimum 3 years editorial operations experience.\n• Exceptional communication and project management skills.",
                'is_active' => true,
                'deadline' => 'September 30, 2026',
            ],
            [
                'title' => 'Senior Scientific Proofreader & Academic Copyeditor',
                'slug' => 'senior-scientific-proofreader-copyeditor',
                'department' => 'KD Proofreading Network',
                'type' => 'Freelance / Remote',
                'summary' => 'Native English PhD specialists in STEM, Economics, or Humanities to perform line-by-line language editing, structural styling, and reference validation.',
                'requirements' => "• PhD or MD from an accredited international university.\n• Native English speaker.\n• Demonstrated academic copyediting and proofreading proficiency.",
                'is_active' => true,
                'deadline' => 'Continuous recruitment',
            ],
        ];

        foreach ($careers as $c) {
            Career::updateOrCreate(['slug' => $c['slug']], $c);
        }

        // 4. Guidelines & CMS Pages
        $guidelines = [
            [
                'key' => 'authors',
                'title' => 'Author Guidelines & Submission Instructions',
                'content' => "## 1. Manuscript Preparation\nAuthors submitting to Knowledge Dynamics journals must ensure their work is original, unpublished, and not under consideration elsewhere.\n\n### Required Structure:\n- **Title Page:** Concise title, author full names, affiliations, ORCID IDs, and designated corresponding author.\n- **Structured Abstract:** Maximum 250–300 words comprising Background, Methods, Results, and Conclusions.\n- **Keywords:** 4 to 6 indexing terms matching MeSH or disciplinary thesauri.\n- **Main Text:** Introduction, Methods, Results, Discussion, and Conclusions.\n- **Declarations:** Funding, Competing Interests, Ethics Approval, and Data Availability.\n\n## 2. Reference Formatting\n- Health Dynamics & KD Food Science: Vancouver style.\n- KD Accounting, Business, Management, Finance: APA 7th Edition.\n- KD Asian Studies & KD Comparative Religion: Chicago Notes & Bibliography.",
                'meta_title' => 'Author Guidelines — Knowledge Dynamics',
                'meta_description' => 'Official author submission instructions, referencing style guides, and manuscript structure requirements.',
            ],
            [
                'key' => 'editorial-policies',
                'title' => 'Publication Ethics & Editorial Policies',
                'content' => "## 1. COPE Ethical Compliance\nKnowledge Dynamics upholds zero tolerance for academic malpractice, data falsification, fraudulent authorship, and uncredited intellectual overlap.\n\n## 2. Plagiarism Screening\nAll submissions undergo automated similarity screening. Duplication exceeding journal thresholds without proper citation results in immediate desk rejection.\n\n## 3. Generative AI Transparency\nAI tools cannot be listed as authors. Any AI assistance utilized in drafting or data visualization must be explicitly declared in the Methodology.",
                'meta_title' => 'Publication Ethics & Policies — Knowledge Dynamics',
                'meta_description' => 'COPE compliance standards, plagiarism thresholds, and authorship criteria across Knowledge Dynamics.',
            ],
            [
                'key' => 'reviewers',
                'title' => 'Peer Reviewer Guidelines & Code of Conduct',
                'content' => "## 1. Confidentiality\nManuscripts under review are strictly confidential documents. Reviewers must not share drafts, datasets, or evaluation remarks with third parties.\n\n## 2. Timeliness & Conflict of Interest\nReviewers are expected to submit thorough, constructive evaluations within 3 to 4 weeks. If a personal, financial, or institutional conflict of interest exists, reviewers must immediately recuse themselves.",
                'meta_title' => 'Reviewer Guidelines — Knowledge Dynamics',
                'meta_description' => 'Code of conduct, evaluation criteria, and confidentiality standards for peer reviewers.',
            ],
            [
                'key' => 'editors',
                'title' => 'Editorial Board Roles & Responsibilities',
                'content' => "## 1. Editorial Independence\nEditors-in-Chief and Section Editors exercise complete editorial independence. Decisions to accept or reject are grounded exclusively in academic merit, novelty, and scientific validity.\n\n## 2. Peer Review Oversight\nHandling editors ensure at least two independent double-blind peer reviews are completed before rendering editorial decisions.",
                'meta_title' => 'Editor Guidelines — Knowledge Dynamics',
                'meta_description' => 'Responsibilities, ethical oversight, and decision-making workflows for editorial board members.',
            ],
            [
                'key' => 'open-access',
                'title' => 'Open Access Statement & Policy',
                'content' => "Knowledge Dynamics publishes all journal articles under the Creative Commons Attribution 4.0 International (CC BY 4.0) License. Authors retain copyright without restrictions. Content is immediately and permanently free to access worldwide.",
                'meta_title' => 'Open Access Policy — Knowledge Dynamics',
                'meta_description' => 'Creative Commons CC BY 4.0 licensing, author rights, and self-archiving policies.',
            ],
        ];

        foreach ($guidelines as $g) {
            GuidelinePage::updateOrCreate(['key' => $g['key']], $g);
        }

        // 5. Site Settings
        $settings = [
            ['key' => 'site_name', 'value' => 'Knowledge Dynamics', 'group' => 'general', 'description' => 'Platform name'],
            ['key' => 'publisher_name', 'value' => 'Knowledge Dynamics Publishing', 'group' => 'general', 'description' => 'Official publisher entity'],
            ['key' => 'doi_prefix', 'value' => '10.58421', 'group' => 'doi', 'description' => 'Registered Crossref DOI Prefix'],
            ['key' => 'contact_email', 'value' => 'editorial@kdpub.com', 'group' => 'contact', 'description' => 'Primary editorial contact email'],
            ['key' => 'support_email', 'value' => 'support@kdpub.com', 'group' => 'contact', 'description' => 'Technical support email'],
            ['key' => 'headquarters_address', 'value' => 'Knowledge Dynamics Academic Center, Stockholm, Sweden & London, UK', 'group' => 'contact', 'description' => 'Publishing house address'],
            ['key' => 'crossref_deposit_mode', 'value' => 'automated', 'group' => 'doi', 'description' => 'Crossref XML schema deposit mode'],
            ['key' => 'theme_preset', 'value' => 'oxford-navy', 'group' => 'theme', 'description' => 'Active UI theme preset'],
            ['key' => 'theme_primary_color', 'value' => '#0F2A4A', 'group' => 'theme', 'description' => 'Primary brand color'],
            ['key' => 'theme_accent_color', 'value' => '#BE123C', 'group' => 'theme', 'description' => 'Accent interaction color'],
            ['key' => 'theme_font_sans', 'value' => 'Inter', 'group' => 'theme', 'description' => 'Body typography family'],
            ['key' => 'theme_font_heading', 'value' => 'Playfair Display', 'group' => 'theme', 'description' => 'Editorial heading typography family'],
            ['key' => 'theme_border_radius', 'value' => '12px', 'group' => 'theme', 'description' => 'UI card and element corner radius'],
            ['key' => 'cpanel_host', 'value' => 'kdpub.com', 'group' => 'cpanel', 'description' => 'cPanel Server Hostname'],
            ['key' => 'cpanel_username', 'value' => 'kdpuodtp', 'group' => 'cpanel', 'description' => 'cPanel Account Username'],
            ['key' => 'cpanel_api_token', 'value' => 'EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q', 'group' => 'cpanel', 'description' => 'cPanel UAPI Access Token'],
            ['key' => 'cpanel_default_domain', 'value' => 'kdpub.com', 'group' => 'cpanel', 'description' => 'Default Academic Email Domain'],
            ['key' => 'cpanel_port', 'value' => '2083', 'group' => 'cpanel', 'description' => 'cPanel SSL Port'],
            ['key' => 'cpanel_webmail_port', 'value' => '2096', 'group' => 'cpanel', 'description' => 'cPanel Webmail SSL Port'],
        ];

        foreach ($settings as $s) {
            SiteSetting::updateOrCreate(['key' => $s['key']], $s);
        }

        // 6. Demo Real-Time In-App Notifications
        $adminUser = \App\Models\User::where('email', 'admin@knowdyn.org')->first();
        if ($adminUser) {
            \App\Models\AppNotification::firstOrCreate(
                [
                    'user_id' => $adminUser->id,
                    'title' => 'New Academic Email Request',
                ],
                [
                    'type' => 'email',
                    'message' => 'Prof. S. Rahman submitted an application for s.rahman@knowdyn.org.',
                    'link' => '/admin/cpanel-email',
                    'icon' => '✉️',
                    'is_read' => false,
                ]
            );

            \App\Models\AppNotification::firstOrCreate(
                [
                    'user_id' => $adminUser->id,
                    'title' => 'Manuscript Submission #KD-8821',
                ],
                [
                    'type' => 'manuscript',
                    'message' => 'New paper "Genomic Epidemiology of Infectious Diseases" submitted for editorial screening.',
                    'link' => '/admin/manuscripts',
                    'icon' => '📝',
                    'is_read' => false,
                ]
            );

            \App\Models\AppNotification::firstOrCreate(
                [
                    'user_id' => $adminUser->id,
                    'title' => 'Crossref DOI XML Verified',
                ],
                [
                    'type' => 'system',
                    'message' => 'Automated schema deposit confirmed for Volume 4, Issue 2.',
                    'link' => '/admin/articles',
                    'icon' => '⚡',
                    'is_read' => true,
                    'read_at' => now(),
                ]
            );
        }
    }
}
