<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('journals', function (Blueprint $table) {
            $table->string('website_url', 500)->nullable()->after('website');
            $table->string('submission_url', 500)->nullable()->after('website_url');
            $table->string('citescore', 20)->nullable()->after('issn_online');
            $table->string('impact_factor', 20)->nullable()->after('citescore');
            $table->unsignedSmallInteger('acceptance_rate')->nullable()->after('impact_factor');
            $table->unsignedSmallInteger('review_time_days')->nullable()->after('acceptance_rate');
            $table->unsignedSmallInteger('publication_time_days')->nullable()->after('review_time_days');
            $table->string('apc_amount', 100)->nullable()->after('publication_time_days');
            $table->json('disciplines')->nullable()->after('apc_amount');
            $table->json('indexing_sources')->nullable()->after('disciplines');
            $table->string('special_issue_title', 500)->nullable()->after('indexing_sources');
            $table->date('special_issue_deadline')->nullable()->after('special_issue_title');
            $table->text('special_issue_description')->nullable()->after('special_issue_deadline');
        });
    }

    public function down(): void
    {
        Schema::table('journals', function (Blueprint $table) {
            $table->dropColumn([
                'website_url',
                'submission_url',
                'citescore',
                'impact_factor',
                'acceptance_rate',
                'review_time_days',
                'publication_time_days',
                'apc_amount',
                'disciplines',
                'indexing_sources',
                'special_issue_title',
                'special_issue_deadline',
                'special_issue_description',
            ]);
        });
    }
};
