<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('articles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('journal_id')->constrained()->cascadeOnDelete();
            $table->string('title', 1000);
            $table->string('slug', 1000)->unique();
            $table->text('abstract')->nullable();
            $table->string('article_type', 50)->default('original-research');
            $table->string('doi', 255)->nullable()->unique();
            $table->string('pages', 50)->nullable();
            $table->date('submission_date')->nullable();
            $table->date('acceptance_date')->nullable();
            $table->timestamp('published_at')->nullable();
            $table->text('funding')->nullable();
            $table->text('conflict_of_interest')->nullable();
            $table->text('ethics_statement')->nullable();
            $table->string('license', 100)->nullable();
            $table->text('citation_info')->nullable();
            $table->enum('status', ['draft', 'published', 'retracted'])->default('draft');
            $table->unsignedInteger('view_count')->default(0);
            $table->unsignedInteger('download_count')->default(0);
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('status');
            $table->index('published_at');
            if (\Illuminate\Support\Facades\DB::getDriverName() !== 'sqlite') {
                $table->fullText('title');
                $table->fullText('abstract');
            }
        });

        Schema::create('article_issue', function (Blueprint $table) {
            $table->id();
            $table->foreignId('article_id')->constrained()->cascadeOnDelete();
            $table->foreignId('issue_id')->constrained()->cascadeOnDelete();
            $table->integer('sort_order')->default(0);

            $table->unique(['article_id', 'issue_id']);
        });

        Schema::create('article_authors', function (Blueprint $table) {
            $table->id();
            $table->foreignId('article_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('first_name', 100);
            $table->string('last_name', 100);
            $table->string('email', 255)->nullable();
            $table->string('affiliation', 500)->nullable();
            $table->string('country', 100)->nullable();
            $table->string('orcid', 50)->nullable();
            $table->boolean('is_corresponding')->default(false);
            $table->integer('sort_order')->default(0);

            $table->index('article_id');
        });

        Schema::create('keywords', function (Blueprint $table) {
            $table->id();
            $table->string('name', 255)->unique();
            $table->string('slug', 255)->unique();
        });

        Schema::create('article_keywords', function (Blueprint $table) {
            $table->id();
            $table->foreignId('article_id')->constrained()->cascadeOnDelete();
            $table->foreignId('keyword_id')->constrained()->cascadeOnDelete();

            $table->unique(['article_id', 'keyword_id']);
        });

        Schema::create('article_references', function (Blueprint $table) {
            $table->id();
            $table->foreignId('article_id')->constrained()->cascadeOnDelete();
            $table->text('reference_text');
            $table->string('doi', 255)->nullable();
            $table->integer('sort_order')->default(0);
        });

        Schema::create('article_files', function (Blueprint $table) {
            $table->id();
            $table->foreignId('article_id')->constrained()->cascadeOnDelete();
            $table->string('file_path', 1000);
            $table->string('file_name', 500);
            $table->string('file_type', 50); // pdf, supplementary, etc.
            $table->unsignedBigInteger('file_size')->nullable();
            $table->boolean('is_primary')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('article_files');
        Schema::dropIfExists('article_references');
        Schema::dropIfExists('article_keywords');
        Schema::dropIfExists('keywords');
        Schema::dropIfExists('article_authors');
        Schema::dropIfExists('article_issue');
        Schema::dropIfExists('articles');
    }
};
