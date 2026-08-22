<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Add after 'name' column or restructure
            $table->string('first_name', 100)->after('name')->nullable();
            $table->string('last_name', 100)->after('first_name')->nullable();
            $table->string('username', 50)->unique()->after('last_name')->nullable();
            $table->string('phone', 20)->nullable()->after('email_verified_at');
            $table->string('avatar', 500)->nullable()->after('phone');
            $table->enum('status', ['active', 'inactive', 'suspended'])->default('active')->after('avatar');
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['first_name', 'last_name', 'username', 'phone', 'avatar', 'status']);
            $table->dropSoftDeletes();
        });
    }
};
