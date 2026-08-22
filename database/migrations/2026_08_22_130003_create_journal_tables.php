<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('journals', function (Blueprint $table) {
            $table->id();
            $table->string('title', 500);
            $table->string('slug', 500)->unique();
            $table->string('short_title', 100)->nullable();
            $table->text('description')->nullable();
            $table->text('aims_and_scope')->nullable();
            $table->string('issn_print', 20)->nullable();
            $table->string('issn_online', 20)->nullable();
            $table->string('publisher', 255)->default('Knowledge Dynamics');
            $table->string('publication_frequency', 100)->nullable();
            $table->string('cover_image', 500)->nullable();
            $table->string('thumbnail', 500)->nullable();
            $table->string('contact_email', 255)->nullable();
            $table->string('contact_phone', 50)->nullable();
            $table->string('website', 500)->nullable();
            $table->enum('status', ['active', 'inactive', 'archived'])->default('active');
            $table->boolean('is_open_access')->default(true);
            $table->smallInteger('established_year')->nullable();
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->integer('sort_order')->default(0);
            $table->timestamps();
            $table->softDeletes();

            $table->index('status');
            $table->index('sort_order');
        });

        Schema::create('journal_settings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('journal_id')->unique()->constrained()->cascadeOnDelete();
            $table->text('peer_review_process')->nullable();
            $table->text('publication_ethics')->nullable();
            $table->text('author_guidelines')->nullable();
            $table->text('copyright_notice')->nullable();
            $table->text('privacy_statement')->nullable();
            $table->text('author_fees')->nullable();
            $table->text('open_access_policy')->nullable();
            $table->text('archiving_policy')->nullable();
            $table->text('plagiarism_policy')->nullable();
            $table->text('section_policies')->nullable();
            $table->text('journal_history')->nullable();
            $table->string('review_model', 50)->default('double_blind');
            $table->timestamps();
        });

        Schema::create('journal_editorial_members', function (Blueprint $table) {
            $table->id();
            $table->foreignId('journal_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('name', 255);
            $table->string('email', 255)->nullable();
            $table->string('institution', 500)->nullable();
            $table->string('country', 100)->nullable();
            $table->string('role', 100); // Editor-in-Chief, Managing Editor, etc.
            $table->text('biography')->nullable();
            $table->string('orcid', 50)->nullable();
            $table->integer('sort_order')->default(0);
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->index(['journal_id', 'role']);
            $table->index('sort_order');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('journal_editorial_members');
        Schema::dropIfExists('journal_settings');
        Schema::dropIfExists('journals');
    }
};
