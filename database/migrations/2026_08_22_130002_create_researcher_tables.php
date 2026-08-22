<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('researcher_profiles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->unique()->constrained()->cascadeOnDelete();
            $table->text('biography')->nullable();
            $table->string('institution', 500)->nullable();
            $table->string('department', 255)->nullable();
            $table->string('country', 100)->nullable();
            $table->string('city', 100)->nullable();
            $table->string('orcid', 50)->nullable();
            $table->string('google_scholar', 500)->nullable();
            $table->string('linkedin', 500)->nullable();
            $table->string('website', 500)->nullable();
            $table->string('research_gate', 500)->nullable();
            $table->text('expertise')->nullable();
            $table->boolean('is_public')->default(true);
            $table->timestamps();
        });

        Schema::create('researcher_interests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('researcher_profile_id')->constrained()->cascadeOnDelete();
            $table->string('interest', 255);

            $table->index('interest');
        });

        Schema::create('researcher_affiliations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('researcher_profile_id')->constrained()->cascadeOnDelete();
            $table->string('institution', 500);
            $table->string('department', 255)->nullable();
            $table->string('position', 255)->nullable();
            $table->string('country', 100)->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->boolean('is_current')->default(false);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('researcher_affiliations');
        Schema::dropIfExists('researcher_interests');
        Schema::dropIfExists('researcher_profiles');
    }
};
