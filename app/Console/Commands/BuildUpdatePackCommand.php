<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use ZipArchive;
use Illuminate\Support\Facades\File;

class BuildUpdatePackCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'updater:build-pack {--full : Include vendor folder in update pack}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Build a lightweight, bulletproof incremental update .zip package for the Universal Updater';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Building Universal System Update Package...');

        $zipName = 'kdpub_update_pack.zip';
        $outputPath = base_path($zipName);

        if (file_exists($outputPath)) {
            unlink($outputPath);
        }

        $zip = new ZipArchive();
        if ($zip->open($outputPath, ZipArchive::CREATE | ZipArchive::OVERWRITE) !== true) {
            $this->error('Failed to create ZIP archive.');
            return 1;
        }

        $foldersToInclude = [
            'app',
            'bootstrap',
            'config',
            'database/migrations',
            'database/seeders',
            'public/build',
            'resources',
            'routes',
        ];

        if ($this->option('full')) {
            $foldersToInclude[] = 'vendor';
        }

        $filesToInclude = [
            'composer.json',
            'package.json',
        ];

        // Add Folders Recursively
        foreach ($foldersToInclude as $folder) {
            $folderPath = base_path($folder);
            if (!File::exists($folderPath)) continue;

            $this->line("Adding: <comment>{$folder}/</comment>");
            $files = File::allFiles($folderPath);
            foreach ($files as $file) {
                $relativePath = substr($file->getRealPath(), strlen(base_path()) + 1);
                $relativePath = str_replace('\\', '/', $relativePath);
                $zip->addFile($file->getRealPath(), $relativePath);
            }
        }

        // Add Single Files
        foreach ($filesToInclude as $file) {
            $filePath = base_path($file);
            if (File::exists($filePath)) {
                $this->line("Adding: <comment>{$file}</comment>");
                $zip->addFile($filePath, $file);
            }
        }

        $zip->close();

        $sizeKb = round(filesize($outputPath) / 1024, 2);
        $sizeMb = round(filesize($outputPath) / (1024 * 1024), 2);

        $this->newLine();
        $this->info('========================================================');
        $this->info("SUCCESS! Update pack generated:");
        $this->info("File: {$outputPath}");
        $this->info("Size: {$sizeKb} KB ({$sizeMb} MB)");
        $this->info('========================================================');

        return 0;
    }
}
