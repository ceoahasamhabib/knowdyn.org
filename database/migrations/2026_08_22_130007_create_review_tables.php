<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('review_assignments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('manuscript_id')->constrained()->cascadeOnDelete();
            $table->foreignId('reviewer_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('assigned_by')->constrained('users')->cascadeOnDelete();
            $table->enum('status', ['pending', 'accepted', 'declined', 'completed'])->default('pending');
            $table->date('due_date')->nullable();
            $table->timestamp('assigned_at')->useCurrent();
            $table->timestamp('responded_at')->nullable();
            $table->timestamp('completed_at')->nullable();

            $table->index(['manuscript_id', 'status']);
            $table->index('reviewer_id');
        });

        Schema::create('reviews', function (Blueprint $table) {
            $table->id();
            $table->foreignId('review_assignment_id')->unique()->constrained()->cascadeOnDelete();
            $table->enum('recommendation', ['accept', 'minor_revision', 'major_revision', 'reject']);
            $table->text('comments_to_editor')->nullable(); // Confidential
            $table->text('comments_to_author')->nullable();
            $table->tinyInteger('quality_score')->nullable(); // 1-10
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reviews');
        Schema::dropIfExists('review_assignments');
    }
};
