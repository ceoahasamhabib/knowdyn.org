<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('projects', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // Lead researcher
            $table->string('title', 500);
            $table->string('slug', 500)->unique();
            $table->text('summary')->nullable();
            $table->string('research_area', 255)->nullable();
            $table->enum('status', ['planning', 'active', 'completed', 'on_hold'])->default('planning');
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->string('institution', 500)->nullable();
            $table->string('external_url', 500)->nullable();
            $table->boolean('is_public')->default(true);
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('status');
            if (\Illuminate\Support\Facades\DB::getDriverName() !== 'sqlite') {
                $table->fullText('title');
            }
        });

        Schema::create('project_members', function (Blueprint $table) {
            $table->id();
            $table->foreignId('project_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('role', 100)->nullable();

            $table->unique(['project_id', 'user_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('project_members');
        Schema::dropIfExists('projects');
    }
};
