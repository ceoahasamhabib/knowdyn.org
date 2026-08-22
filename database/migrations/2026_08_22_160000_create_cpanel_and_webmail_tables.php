<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('email_account_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('requested_username');
            $table->string('domain')->default('knowdyn.org');
            $table->string('full_email')->unique();
            $table->integer('quota_mb')->default(500);
            $table->enum('status', ['pending', 'approved', 'rejected', 'active', 'suspended'])->default('pending');
            $table->text('password_encrypted')->nullable();
            $table->text('rejection_reason')->nullable();
            $table->text('admin_notes')->nullable();
            $table->timestamp('cpanel_account_created_at')->nullable();
            $table->timestamps();
        });

        Schema::create('webmail_messages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('email_account_request_id')->nullable()->constrained('email_account_requests')->nullOnDelete();
            $table->enum('folder', ['inbox', 'sent', 'drafts', 'trash'])->default('inbox');
            $table->string('from_name')->nullable();
            $table->string('from_email');
            $table->string('to_email');
            $table->string('cc_email')->nullable();
            $table->string('subject');
            $table->longText('body_html')->nullable();
            $table->longText('body_text')->nullable();
            $table->boolean('is_read')->default(false);
            $table->boolean('is_starred')->default(false);
            $table->boolean('has_attachments')->default(false);
            $table->timestamp('sent_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('webmail_messages');
        Schema::dropIfExists('email_account_requests');
    }
};
