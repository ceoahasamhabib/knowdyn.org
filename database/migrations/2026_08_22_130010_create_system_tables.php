<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pages', function (Blueprint $table) {
            $table->id();
            $table->string('title', 255);
            $table->string('slug', 255)->unique();
            $table->longText('content')->nullable();
            $table->boolean('is_published')->default(false);
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->timestamps();
        });

        Schema::create('settings', function (Blueprint $table) {
            $table->id();
            $table->string('group', 100);
            $table->string('key', 100);
            $table->text('value')->nullable();

            $table->unique(['group', 'key']);
        });

        Schema::create('audit_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('action', 100); // create, update, delete, login, etc.
            $table->string('auditable_type', 255)->nullable(); // Polymorphic model
            $table->unsignedBigInteger('auditable_id')->nullable();
            $table->json('old_values')->nullable();
            $table->json('new_values')->nullable();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->timestamp('created_at')->useCurrent();

            $table->index(['auditable_type', 'auditable_id']);
            $table->index('user_id');
            $table->index('action');
            $table->index('created_at');
        });

        Schema::create('legacy_url_mappings', function (Blueprint $table) {
            $table->id();
            $table->string('old_url', 2000);
            $table->string('new_url', 2000);
            $table->smallInteger('status_code')->default(301);
            $table->string('entity_type', 100)->nullable();
            $table->unsignedBigInteger('entity_id')->nullable();
            $table->timestamp('verified_at')->nullable();
            $table->timestamp('created_at')->useCurrent();

            $table->index('old_url');
        });

        Schema::create('doi_records', function (Blueprint $table) {
            $table->id();
            $table->string('doi', 255)->unique();
            $table->string('doiable_type', 255); // Polymorphic
            $table->unsignedBigInteger('doiable_id');
            $table->string('provider', 50)->nullable(); // e.g., crossref
            $table->enum('status', ['pending', 'registered', 'failed'])->default('pending');
            $table->timestamp('registered_at')->nullable();
            $table->timestamps();

            $table->index(['doiable_type', 'doiable_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('doi_records');
        Schema::dropIfExists('legacy_url_mappings');
        Schema::dropIfExists('audit_logs');
        Schema::dropIfExists('settings');
        Schema::dropIfExists('pages');
    }
};
