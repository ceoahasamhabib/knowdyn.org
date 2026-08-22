<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('volumes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('journal_id')->constrained()->cascadeOnDelete();
            $table->smallInteger('number');
            $table->smallInteger('year');
            $table->string('title', 255)->nullable();
            $table->text('description')->nullable();
            $table->timestamps();

            $table->unique(['journal_id', 'number']);
            $table->index('year');
        });

        Schema::create('issues', function (Blueprint $table) {
            $table->id();
            $table->foreignId('volume_id')->constrained()->cascadeOnDelete();
            $table->string('number', 20);
            $table->string('title', 500)->nullable();
            $table->text('description')->nullable();
            $table->string('cover_image', 500)->nullable();
            $table->date('published_at')->nullable();
            $table->boolean('is_current')->default(false);
            $table->enum('status', ['draft', 'published'])->default('draft');
            $table->integer('sort_order')->default(0);
            $table->timestamps();

            $table->index(['volume_id', 'number']);
            $table->index('status');
            $table->index('published_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('issues');
        Schema::dropIfExists('volumes');
    }
};
