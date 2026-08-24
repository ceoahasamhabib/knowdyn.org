<?php

namespace Database\Seeders;

use App\Models\Article;
use App\Models\ArticleAuthor;
use App\Models\Issue;
use App\Models\Journal;
use App\Models\JournalEditorialMember;
use App\Models\JournalSettings;
use App\Models\Keyword;
use App\Models\User;
use App\Models\Volume;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class JournalSeeder extends Seeder
{
    public function run(): void
    {
        $journalsData = [
            [
                'title' => 'Health Dynamics',
                'short_title' => 'Health Dyn.',
                'slug' => 'health-dynamics',
                'description' => 'A peer-reviewed, open-access multidisciplinary journal publishing high-impact research, clinical insights, and healthcare management innovations.',
                'aims_and_scope' => "Health Dynamics is dedicated to advancing the frontiers of medical sciences, public health policy, epidemiology, biomedical innovations, and healthcare delivery systems.\n\nThe journal welcomes original research papers, systematic reviews, clinical trials, meta-analyses, and methodological advances addressing urgent global healthcare challenges.",
                'issn_print' => '3006-550X',
                'issn_online' => '3006-5518',
                'publisher' => 'Knowledge Dynamics',
                'publication_frequency' => 'Bi-monthly',
                'established_year' => 2021,
                'status' => 'active',
                'is_open_access' => true,
                'contact_email' => 'editor.hd@knowdyn.org',
                'website_url' => 'https://kdpub.com/journals/health-dynamics',
                'submission_url' => '/submit?journal=health-dynamics',
                'citescore' => '3.8',
                'impact_factor' => '2.9',
                'acceptance_rate' => 28,
                'review_time_days' => 18,
                'publication_time_days' => 7,
                'apc_amount' => '$450 USD (Waivers Available)',
                'disciplines' => [
                    'Clinical Medicine',
                    'Public Health & Epidemiology',
                    'Biomedical Engineering',
                    'Healthcare Systems & AI',
                ],
                'indexing_sources' => [
                    'Crossref (DOI Minting)',
                    'Google Scholar',
                    'DOAJ (Open Access)',
                    'PubMed Central Ready',
                    'COPE (Publication Ethics)',
                    'Portico Digital Preservation',
                ],
                'special_issue_title' => 'Special Issue: AI-Driven Precision Diagnostics & Global Health Equity',
                'special_issue_deadline' => '2026-11-30',
                'special_issue_description' => 'Calling for breakthrough contributions on machine learning applications in clinical triage, remote telehealth monitoring, and epidemiology surveillance in resource-limited settings.',
                'sort_order' => 1,
                'settings' => [
                    'review_model' => 'double_blind',
                    'peer_review_process' => 'All manuscripts undergo rigorous double-blind peer review by at least two independent expert reviewers with a typical first decision within 18 days.',
                    'publication_ethics' => 'Health Dynamics strictly adheres to COPE guidelines and ICMJE standards for ethical medical publishing and research integrity.',
                    'author_guidelines' => 'Articles must follow Vancouver referencing style, provide structured abstracts (Background, Methods, Results, Conclusion), and disclose all funding sources.',
                    'open_access_policy' => 'Immediate open access under CC BY 4.0 license.',
                    'copyright_notice' => 'Authors retain copyright without restrictions.',
                    'author_fees' => 'Standard APC is $450 USD. Full fee waivers are provided for authors from low-income developing economies.',
                ],
                'members' => [
                    ['name' => 'Prof. Dr. Sarah Al-Mansoor', 'role' => 'Editor-in-Chief', 'institution' => 'Karolinska Institute', 'country' => 'Sweden', 'orcid' => '0000-0001-5234-9981', 'sort_order' => 1],
                    ['name' => 'Dr. Marcus Vance', 'role' => 'Associate Editor', 'institution' => 'Johns Hopkins University', 'country' => 'United States', 'orcid' => '0000-0002-3984-1102', 'sort_order' => 2],
                    ['name' => 'Dr. Elena Rostova', 'role' => 'Managing Editor', 'institution' => 'University of Zurich', 'country' => 'Switzerland', 'orcid' => '0000-0003-8812-4431', 'sort_order' => 3],
                    ['name' => 'Prof. Hiroshi Tanaka', 'role' => 'Section Editor', 'institution' => 'University of Tokyo', 'country' => 'Japan', 'orcid' => '0000-0002-9901-7764', 'sort_order' => 4],
                ],
                'articles' => [
                    [
                        'title' => 'Epidemiological Surveillance and Digital Healthcare Interventions in Post-Pandemic Systems',
                        'abstract' => 'This study examines systemic health monitoring technologies and community-level data analytics across diverse socioeconomic cohorts, evaluating clinical efficacy and policy adaptability.',
                        'type' => 'original-research',
                        'doi_suffix' => '01',
                    ],
                ]
            ],
            [
                'title' => 'KD Food Science Nutrition',
                'short_title' => 'KD Food Sci. Nutr.',
                'slug' => 'kd-food-science-nutrition',
                'description' => 'Advancing sustainable agricultural food processing, functional nutraceutical bioactives, molecular food safety, and global human nutritional health.',
                'aims_and_scope' => "KD Food Science Nutrition provides a global peer-reviewed forum for groundbreaking discoveries in food biotechnology, nutrient bioavailability, sensory analysis, food chemistry, shelf-life modeling, and sustainable food packaging solutions.",
                'issn_print' => '3007-8812',
                'issn_online' => '3007-8820',
                'publisher' => 'Knowledge Dynamics',
                'publication_frequency' => 'Quarterly',
                'established_year' => 2022,
                'status' => 'active',
                'is_open_access' => true,
                'contact_email' => 'editor.fsn@knowdyn.org',
                'website_url' => 'https://kdpub.com/journals/kd-food-science-nutrition',
                'submission_url' => '/submit?journal=kd-food-science-nutrition',
                'citescore' => '3.2',
                'impact_factor' => '2.4',
                'acceptance_rate' => 34,
                'review_time_days' => 21,
                'publication_time_days' => 8,
                'apc_amount' => '$380 USD',
                'disciplines' => [
                    'Food Biotechnology',
                    'Nutraceuticals & Bioactives',
                    'Sustainable Food Processing',
                    'Food Safety & Toxicology',
                ],
                'indexing_sources' => [
                    'Crossref (DOI Minting)',
                    'Google Scholar',
                    'DOAJ (Open Access)',
                    'COPE (Publication Ethics)',
                    'Portico Digital Preservation',
                ],
                'special_issue_title' => 'Special Issue: Plant-Based Bioactive Proteins and Circular Food Packaging',
                'special_issue_deadline' => '2026-12-15',
                'special_issue_description' => 'Explores innovative green processing technologies, plant extraction protocols, and biodegradable polymers in global supply chains.',
                'sort_order' => 2,
                'settings' => [
                    'review_model' => 'double_blind',
                    'peer_review_process' => 'Independent double-blind peer review by international nutrition and food chemistry scholars.',
                    'publication_ethics' => 'Strict adherence to COPE and food research integrity guidelines.',
                    'author_guidelines' => 'Follow APA 7th Edition style. Detailed nutritional tables and chemical purity analytical standards must be supplied.',
                    'open_access_policy' => 'Open Access under CC BY 4.0.',
                    'copyright_notice' => 'Authors retain copyright without restriction.',
                    'author_fees' => 'Standard APC is $380 USD. Academic discounts apply for affiliated university consortia.',
                ],
                'members' => [
                    ['name' => 'Prof. Dr. Giovanni Rossi', 'role' => 'Editor-in-Chief', 'institution' => 'University of Bologna', 'country' => 'Italy', 'orcid' => '0000-0002-4112-9988', 'sort_order' => 1],
                    ['name' => 'Dr. Lin Wei', 'role' => 'Associate Editor', 'institution' => 'Zhejiang University', 'country' => 'China', 'orcid' => '0000-0003-1288-7734', 'sort_order' => 2],
                    ['name' => 'Dr. Rachel Green', 'role' => 'Editorial Board Member', 'institution' => 'University of Melbourne', 'country' => 'Australia', 'orcid' => '0000-0001-9923-4512', 'sort_order' => 3],
                ],
                'articles' => [
                    [
                        'title' => 'Encapsulation of Bioactive Polyphenols for Enhanced Intestinal Bioavailability and Oxidative Stability',
                        'abstract' => 'This investigation evaluates nano-emulsion and micro-encapsulation formulations to stabilize sensitive dietary polyphenols against thermal degradation during food manufacturing.',
                        'type' => 'original-research',
                        'doi_suffix' => '01',
                    ],
                ]
            ],
            [
                'title' => 'KD Asian Studies',
                'short_title' => 'KD Asian Stud.',
                'slug' => 'kd-asian-studies',
                'description' => 'A premier international journal exploring Asian geopolitical dynamics, socioeconomic transformations, cultural heritage, history, and linguistic evolution.',
                'aims_and_scope' => "KD Asian Studies publishes interdisciplinary scholarship covering East, South, Southeast, and Central Asia. The journal bridges contemporary sociopolitical analysis with historical, archaeological, and literary perspectives.",
                'issn_print' => '3008-1123',
                'issn_online' => '3008-1131',
                'publisher' => 'Knowledge Dynamics',
                'publication_frequency' => 'Bi-annual',
                'established_year' => 2022,
                'status' => 'active',
                'is_open_access' => true,
                'contact_email' => 'editor.as@knowdyn.org',
                'website_url' => 'https://kdpub.com/journals/kd-asian-studies',
                'submission_url' => '/submit?journal=kd-asian-studies',
                'citescore' => '2.7',
                'impact_factor' => '1.9',
                'acceptance_rate' => 31,
                'review_time_days' => 24,
                'publication_time_days' => 10,
                'apc_amount' => 'Fully Sponsored / Free Open Access',
                'disciplines' => [
                    'East & Southeast Asian History',
                    'Geopolitics & International Relations',
                    'Cultural Anthropology & Linguistics',
                    'Socioeconomic Transformations',
                ],
                'indexing_sources' => [
                    'Crossref (DOI Minting)',
                    'Google Scholar',
                    'DOAJ (Open Access)',
                    'COPE (Publication Ethics)',
                    'Portico Digital Preservation',
                ],
                'special_issue_title' => 'Special Issue: Silk Road Digital Humanities & Transnational Cultural Heritage',
                'special_issue_deadline' => '2026-10-31',
                'special_issue_description' => 'Digital archival preservation, 3D photogrammetry of monuments, and cross-cultural trade diplomacy in ancient and modern Asia.',
                'sort_order' => 3,
                'settings' => [
                    'review_model' => 'double_blind',
                    'peer_review_process' => 'Rigorous double-blind peer review by regional specialists and area-studies academics.',
                    'publication_ethics' => 'Full COPE compliance.',
                    'author_guidelines' => 'Chicago Manual of Style (Notes & Bibliography or Author-Date) referencing required.',
                    'open_access_policy' => 'Open Access under CC BY 4.0.',
                    'copyright_notice' => 'Authors retain copyright without restriction.',
                    'author_fees' => 'Zero author processing charges. Publication is fully subsidized by philanthropic foundation grants.',
                ],
                'members' => [
                    ['name' => 'Prof. Kenji Takahashi', 'role' => 'Editor-in-Chief', 'institution' => 'Kyoto University', 'country' => 'Japan', 'orcid' => '0000-0002-8819-2341', 'sort_order' => 1],
                    ['name' => 'Dr. Sunita Sharma', 'role' => 'Managing Editor', 'institution' => 'Jawaharlal Nehru University', 'country' => 'India', 'orcid' => '0000-0001-6542-8890', 'sort_order' => 2],
                    ['name' => 'Dr. Arthur Pendelton', 'role' => 'Editorial Board Member', 'institution' => 'SOAS University of London', 'country' => 'United Kingdom', 'orcid' => '0000-0003-4412-0091', 'sort_order' => 3],
                ],
                'articles' => [
                    [
                        'title' => 'Maritime Trade Networks and Cultural Synthesis Across Southeast Asian Straits (14th–18th Century)',
                        'abstract' => 'Drawing upon multi-lingual port archives and epigraphic materials, this paper reconstructs maritime commercial exchanges and diplomatic networks across pre-colonial Southeast Asia.',
                        'type' => 'review-article',
                        'doi_suffix' => '01',
                    ],
                ]
            ],
            [
                'title' => 'KD Accounting, Business, Management, Finance',
                'short_title' => 'KD ABMF',
                'slug' => 'kd-accounting-business-management-finance',
                'description' => 'Fostering empirical research in corporate governance, financial econometrics, fintech disruptions, organizational management, and ESG sustainability reporting.',
                'aims_and_scope' => "KD ABMF serves corporate leaders, financial economists, and management scholars by publishing rigorous research on capital markets, algorithmic trading, audit quality, executive leadership, and green business models.",
                'issn_print' => '3009-4456',
                'issn_online' => '3009-4464',
                'publisher' => 'Knowledge Dynamics',
                'publication_frequency' => 'Quarterly',
                'established_year' => 2023,
                'status' => 'active',
                'is_open_access' => true,
                'contact_email' => 'editor.abmf@knowdyn.org',
                'website_url' => 'https://kdpub.com/journals/kd-accounting-business-management-finance',
                'submission_url' => '/submit?journal=kd-accounting-business-management-finance',
                'citescore' => '3.5',
                'impact_factor' => '2.6',
                'acceptance_rate' => 26,
                'review_time_days' => 16,
                'publication_time_days' => 6,
                'apc_amount' => '$400 USD',
                'disciplines' => [
                    'Corporate Finance & Governance',
                    'Financial Econometrics & FinTech',
                    'ESG & Sustainable Business',
                    'Strategic Management',
                ],
                'indexing_sources' => [
                    'Crossref (DOI Minting)',
                    'Google Scholar',
                    'DOAJ (Open Access)',
                    'COPE (Publication Ethics)',
                    'Portico Digital Preservation',
                ],
                'special_issue_title' => 'Special Issue: Machine Learning in Quantitative Asset Pricing & ESG Mandates',
                'special_issue_deadline' => '2026-11-15',
                'special_issue_description' => 'Evaluating algorithmic trading risks, predictive analytics in corporate credit defaults, and green bond pricing dynamics.',
                'sort_order' => 4,
                'settings' => [
                    'review_model' => 'double_blind',
                    'peer_review_process' => 'Rigorous double-blind peer review emphasizing methodological rigor and empirical econometric validation.',
                    'publication_ethics' => 'Full COPE compliance.',
                    'author_guidelines' => 'APA 7th Edition or Harvard referencing style. Data replication packages are encouraged.',
                    'open_access_policy' => 'Open Access under CC BY 4.0.',
                    'copyright_notice' => 'Authors retain copyright without restriction.',
                    'author_fees' => 'Standard APC is $400 USD with institutional fee assistance.',
                ],
                'members' => [
                    ['name' => 'Prof. Dr. Michael Sterling', 'role' => 'Editor-in-Chief', 'institution' => 'London School of Economics', 'country' => 'United Kingdom', 'orcid' => '0000-0002-1200-9832', 'sort_order' => 1],
                    ['name' => 'Dr. Fatima Zahra', 'role' => 'Associate Editor', 'institution' => 'INSEAD', 'country' => 'France', 'orcid' => '0000-0003-8821-4329', 'sort_order' => 2],
                    ['name' => 'Dr. Robert Zhang', 'role' => 'Editorial Board Member', 'institution' => 'National University of Singapore', 'country' => 'Singapore', 'orcid' => '0000-0001-9923-0012', 'sort_order' => 3],
                ],
                'articles' => [
                    [
                        'title' => 'ESG Disclosure Transparency, Cost of Equity Capital, and Firm Valuation in Volatile Markets',
                        'abstract' => 'This study empirically evaluates panel data from 1,200 publicly listed firms to quantify the direct impact of standardized ESG reporting on debt yields and firm resilience.',
                        'type' => 'original-research',
                        'doi_suffix' => '01',
                    ],
                ]
            ],
            [
                'title' => 'KD Comparative Religion',
                'short_title' => 'KD Comp. Relig.',
                'slug' => 'kd-comparative-religion',
                'description' => 'A scholarly platform for interfaith dialogues, hermeneutical text studies, sociology of religion, ethics, and contemporary theological discourse.',
                'aims_and_scope' => "KD Comparative Religion fosters rigorous critical scholarship examining religious traditions, historical theology, sacred texts, philosophical ethics, and the role of faith communities in contemporary global society.",
                'issn_print' => '3010-7789',
                'issn_online' => '3010-7797',
                'publisher' => 'Knowledge Dynamics',
                'publication_frequency' => 'Bi-annual',
                'established_year' => 2023,
                'status' => 'active',
                'is_open_access' => true,
                'contact_email' => 'editor.cr@knowdyn.org',
                'website_url' => 'https://kdpub.com/journals/kd-comparative-religion',
                'submission_url' => '/submit?journal=kd-comparative-religion',
                'citescore' => '2.4',
                'impact_factor' => '1.7',
                'acceptance_rate' => 38,
                'review_time_days' => 28,
                'publication_time_days' => 12,
                'apc_amount' => 'Fully Sponsored / Free Open Access',
                'disciplines' => [
                    'Comparative Theology',
                    'Hermeneutics & Sacred Texts',
                    'Sociology of Religion',
                    'Philosophical Ethics & Peace Studies',
                ],
                'indexing_sources' => [
                    'Crossref (DOI Minting)',
                    'Google Scholar',
                    'DOAJ (Open Access)',
                    'COPE (Publication Ethics)',
                    'Portico Digital Preservation',
                ],
                'special_issue_title' => 'Special Issue: Ethics of Artificial Intelligence & Human Dignity Across Religious Traditions',
                'special_issue_deadline' => '2026-12-01',
                'special_issue_description' => 'Engaging philosophical and religious frameworks on computational consciousness, moral agency, and robotic labor.',
                'sort_order' => 5,
                'settings' => [
                    'review_model' => 'double_blind',
                    'peer_review_process' => 'Standard double-blind peer review by international theologians, philosophers, and religious studies scholars.',
                    'publication_ethics' => 'Full COPE compliance.',
                    'author_guidelines' => 'Chicago Manual of Style (Notes & Bibliography) required for text citations and source references.',
                    'open_access_policy' => 'Open Access under CC BY 4.0.',
                    'copyright_notice' => 'Authors retain copyright without restriction.',
                    'author_fees' => 'Zero author processing fees. Fully funded by interfaith academic endowments.',
                ],
                'members' => [
                    ['name' => 'Prof. Dr. Tariq Al-Hashimi', 'role' => 'Editor-in-Chief', 'institution' => 'Oxford University', 'country' => 'United Kingdom', 'orcid' => '0000-0002-3321-7788', 'sort_order' => 1],
                    ['name' => 'Dr. Miriam Cohen', 'role' => 'Associate Editor', 'institution' => 'Hebrew University of Jerusalem', 'country' => 'Israel', 'orcid' => '0000-0001-7721-3490', 'sort_order' => 2],
                    ['name' => 'Prof. Peter Holmgren', 'role' => 'Editorial Board Member', 'institution' => 'Uppsala University', 'country' => 'Sweden', 'orcid' => '0000-0003-1288-0044', 'sort_order' => 3],
                ],
                'articles' => [
                    [
                        'title' => 'Hermeneutics of Mercy: Comparative Textual Exegesis in Abrahamic Ethical Traditions',
                        'abstract' => 'This paper provides a cross-traditional textual analysis of primary scriptural passages and medieval commentaries emphasizing restorative justice and compassion across Judaism, Christianity, and Islam.',
                        'type' => 'original-research',
                        'doi_suffix' => '01',
                    ],
                ]
            ],
        ];

        foreach ($journalsData as $jData) {
            $settings = $jData['settings'];
            $members = $jData['members'];
            $articles = $jData['articles'];
            unset($jData['settings'], $jData['members'], $jData['articles']);

            $journal = Journal::updateOrCreate(
                ['slug' => $jData['slug']],
                $jData
            );

            // Settings
            $journal->settings()->updateOrCreate(
                ['journal_id' => $journal->id],
                $settings
            );

            // Editorial Members
            $journal->editorialMembers()->delete();
            foreach ($members as $m) {
                $journal->editorialMembers()->create($m);
            }

            // Volumes and Issues (Seed 2 volumes, 2 issues each)
            for ($v = 1; $v <= 2; $v++) {
                $year = $journal->established_year + ($v - 1);
                $volume = $journal->volumes()->firstOrCreate(
                    ['journal_id' => $journal->id, 'number' => $v],
                    ['year' => $year, 'title' => "Volume {$v} ({$year})"]
                );

                for ($i = 1; $i <= 2; $i++) {
                    $isCurrent = ($v === 2 && $i === 2);
                    $issue = $volume->issues()->firstOrCreate(
                        ['volume_id' => $volume->id, 'number' => (string) $i],
                        [
                            'title' => "Vol. {$v}, Issue {$i}",
                            'description' => "Published research articles and reviews in Volume {$v}, Issue {$i}.",
                            'published_at' => "{$year}-" . str_pad($i * 6 - 3, 2, '0', STR_PAD_LEFT) . "-15",
                            'is_current' => $isCurrent,
                            'status' => 'published',
                            'sort_order' => $i,
                        ]
                    );

                    // Seed articles for this issue
                    foreach ($articles as $artIndex => $artData) {
                        $slug = Str::slug("{$artData['title']}-{$journal->slug}-v{$v}-i{$i}");
                        $article = Article::updateOrCreate(
                            ['slug' => $slug],
                            [
                                'journal_id' => $journal->id,
                                'title' => "{$artData['title']} (Vol. {$v}, No. {$i})",
                                'abstract' => $artData['abstract'],
                                'article_type' => $artData['type'],
                                'doi' => "10.58421/{$journal->slug}.v{$v}i{$i}.01",
                                'pages' => '1-16',
                                'submission_date' => "{$year}-01-15",
                                'acceptance_date' => "{$year}-02-28",
                                'published_at' => "{$year}-03-15 09:00:00",
                                'status' => 'published',
                                'citation_info' => "{$journal->title} {$year}, {$v}({$i}), 1-16.",
                            ]
                        );

                        if ($article->authors()->count() === 0) {
                            $article->authors()->create([
                                'first_name' => 'Prof. Dr. Sarah',
                                'last_name' => 'Al-Mansoor',
                                'email' => 'sarah.mansoor@knowdyn.org',
                                'affiliation' => 'International Institute of Advanced Studies',
                                'country' => 'Sweden',
                                'orcid' => '0000-0001-5234-9981',
                                'is_corresponding' => true,
                                'sort_order' => 1,
                            ]);
                        }

                        if ($article->references()->count() === 0) {
                            $article->references()->create([
                                'reference_text' => 'Knowledge Dynamics Scholarly Archive. (2024). Methodological and empirical foundations. Knowledge Dynamics Press.',
                                'doi' => '10.58421/ref.2024.01',
                                'sort_order' => 1,
                            ]);
                        }

                        $issue->articles()->syncWithoutDetaching([$article->id => ['sort_order' => 1]]);
                    }
                }
            }
        }
    }
}
