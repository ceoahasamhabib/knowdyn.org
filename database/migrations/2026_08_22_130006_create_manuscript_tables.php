<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('manuscripts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('journal_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // Submitting author
            $table->string('title', 1000);
            $table->text('abstract')->nullable();
            $table->string('article_type', 50)->default('original-research');
            $table->enum('status', [
                'draft', 'submitted', 'screening', 'editor_assigned',
                'under_review', 'revision_required', 'resubmitted',
                'accepted', 'rejected', 'production', 'published'
            ])->default('draft');
            $table->foreignId('editor_id')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('article_id')->nullable()->constrained()->nullOnDelete();
            $table->text('funding')->nullable();
            $table->text('conflict_of_interest')->nullable();
            $table->text('ethics_statement')->nullable();
            $table->text('cover_letter')->nullable();
            $table->timestamp('submitted_at')->nullable();
            $table->timestamp('decided_at')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('status');
            $table->index(['journal_id', 'status']);
            $table->index('submitted_at');
        });

        Schema::create('manuscript_authors', function (Blueprint $table) {
            $table->id();
            $table->foreignId('manuscript_id')->constrained()->cascadeOnDelete();
            $table->string('first_name', 100);
            $table->string('last_name', 100);
            $table->string('email', 255)->nullable();
            $table->string('affiliation', 500)->nullable();
            $table->string('orcid', 50)->nullable();
            $table->boolean('is_corresponding')->default(false);
            $table->integer('sort_order')->default(0);
        });

        Schema::create('manuscript_files', function (Blueprint $table) {
            $table->id();
            $table->foreignId('manuscript_id')->constrained()->cascadeOnDelete();
            $table->string('file_path', 1000); // Private storage
            $table->string('file_name', 500);
            $table->string('file_type', 50); // manuscript, cover_letter, supplementary
            $table->unsignedBigInteger('file_size')->nullable();
            $table->smallInteger('version')->default(1);
            $table->timestamps();
        });

        Schema::create('manuscript_status_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('manuscript_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('from_status', 50)->nullable();
            $table->string('to_status', 50);
            $table->text('comment')->nullable();
            $table->timestamp('created_at')->useCurrent();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('manuscript_status_history');
        Schema::dropIfExists('manuscript_files');
        Schema::dropIfExists('manuscript_authors');
        Schema::dropIfExists('manuscripts');
    }
};
