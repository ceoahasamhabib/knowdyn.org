<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Books & Monographs
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->string('author');
            $table->string('isbn')->nullable();
            $table->integer('year')->default(2024);
            $table->integer('pages')->default(300);
            $table->string('category')->default('Medicine & Health');
            $table->string('format')->default('Print & eBook');
            $table->text('description')->nullable();
            $table->string('doi')->nullable();
            $table->boolean('is_open_access')->default(false);
            $table->string('cover_image')->nullable();
            $table->string('file_path')->nullable();
            $table->integer('sort_order')->default(0);
            $table->timestamps();
        });

        // 2. Book Proposals
        Schema::create('book_proposals', function (Blueprint $table) {
            $table->id();
            $table->string('author_name');
            $table->string('author_email');
            $table->string('institution');
            $table->string('book_title');
            $table->string('subject_discipline');
            $table->string('estimated_word_count')->nullable();
            $table->string('target_completion_date')->nullable();
            $table->text('synopsis_and_toc');
            $table->enum('status', ['pending', 'reviewed', 'accepted', 'declined'])->default('pending');
            $table->text('notes')->nullable();
            $table->timestamps();
        });

        // 3. News, Announcements & Events
        Schema::create('news_events', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->enum('type', ['news', 'event', 'announcement', 'workshop'])->default('news');
            $table->string('category')->nullable();
            $table->text('summary')->nullable();
            $table->longText('content')->nullable();
            $table->string('event_date')->nullable();
            $table->string('location')->nullable();
            $table->string('registration_url')->nullable();
            $table->string('deadline')->nullable();
            $table->boolean('is_featured')->default(false);
            $table->boolean('is_published')->default(true);
            $table->integer('sort_order')->default(0);
            $table->timestamps();
        });

        // 4. Careers & Editorial Fellowships
        Schema::create('careers', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->string('department');
            $table->string('type')->default('Academic Editorial Role');
            $table->text('summary')->nullable();
            $table->longText('requirements')->nullable();
            $table->boolean('is_active')->default(true);
            $table->string('deadline')->nullable();
            $table->timestamps();
        });

        // 5. Guidelines & CMS Pages
        Schema::create('guidelines_pages', function (Blueprint $table) {
            $table->id();
            $table->string('key')->unique(); // authors, editors, reviewers, editorial-policies, open-access, librarians-faqs
            $table->string('title');
            $table->longText('content');
            $table->string('meta_title')->nullable();
            $table->text('meta_description')->nullable();
            $table->timestamps();
        });

        // 6. Site Settings & Scholarly Metadata Config
        Schema::create('site_settings', function (Blueprint $table) {
            $table->id();
            $table->string('key')->unique();
            $table->text('value')->nullable();
            $table->string('group')->default('general'); // general, doi, contact, scholarly
            $table->string('description')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('site_settings');
        Schema::dropIfExists('guidelines_pages');
        Schema::dropIfExists('careers');
        Schema::dropIfExists('news_events');
        Schema::dropIfExists('book_proposals');
        Schema::dropIfExists('books');
    }
};
