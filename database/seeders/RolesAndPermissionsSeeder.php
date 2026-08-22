<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesAndPermissionsSeeder extends Seeder
{
    public function run(): void
    {
        // Reset cached roles and permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // ── Permissions ────────────────────────────────────────

        // User management
        Permission::findOrCreate('manage users');
        Permission::findOrCreate('view users');

        // Journal management
        Permission::findOrCreate('manage journals');
        Permission::findOrCreate('view journals');

        // Article management
        Permission::findOrCreate('manage articles');
        Permission::findOrCreate('view articles');
        Permission::findOrCreate('publish articles');

        // Manuscript workflow
        Permission::findOrCreate('submit manuscripts');
        Permission::findOrCreate('screen manuscripts');
        Permission::findOrCreate('assign editors');
        Permission::findOrCreate('assign reviewers');
        Permission::findOrCreate('make editorial decisions');
        Permission::findOrCreate('view all manuscripts');
        Permission::findOrCreate('view assigned manuscripts');

        // Review
        Permission::findOrCreate('review manuscripts');

        // Research projects
        Permission::findOrCreate('manage projects');
        Permission::findOrCreate('view projects');

        // Services
        Permission::findOrCreate('manage services');
        Permission::findOrCreate('view service requests');
        Permission::findOrCreate('handle service requests');

        // CMS / Pages
        Permission::findOrCreate('manage pages');

        // Settings
        Permission::findOrCreate('manage settings');

        // Audit
        Permission::findOrCreate('view audit logs');

        // SEO / Migration
        Permission::findOrCreate('manage url mappings');
        Permission::findOrCreate('manage doi records');

        // Researcher profiles
        Permission::findOrCreate('manage own profile');
        Permission::findOrCreate('manage researcher profiles');

        // ── Roles ──────────────────────────────────────────────

        // 1. Super Admin — has ALL permissions via Gate::before
        $superAdmin = Role::findOrCreate('super-admin');

        // 2. Admin — platform-wide admin
        $admin = Role::findOrCreate('admin');
        $admin->givePermissionTo(Permission::all());

        // 3. Journal Manager — manages specific journals
        $journalManager = Role::findOrCreate('journal-manager');
        $journalManager->givePermissionTo([
            'manage journals', 'view journals', 'manage articles',
            'view articles', 'publish articles', 'view all manuscripts',
            'screen manuscripts', 'assign editors', 'assign reviewers',
            'make editorial decisions', 'manage url mappings',
        ]);

        // 4. Editor-in-Chief
        $editorInChief = Role::findOrCreate('editor-in-chief');
        $editorInChief->givePermissionTo([
            'view journals', 'manage articles', 'view articles',
            'publish articles', 'view all manuscripts', 'screen manuscripts',
            'assign editors', 'assign reviewers', 'make editorial decisions',
        ]);

        // 5. Section Editor
        $sectionEditor = Role::findOrCreate('section-editor');
        $sectionEditor->givePermissionTo([
            'view journals', 'view articles', 'view assigned manuscripts',
            'assign reviewers', 'make editorial decisions',
        ]);

        // 6. Reviewer
        $reviewer = Role::findOrCreate('reviewer');
        $reviewer->givePermissionTo([
            'review manuscripts', 'view articles', 'manage own profile',
        ]);

        // 7. Author
        $author = Role::findOrCreate('author');
        $author->givePermissionTo([
            'submit manuscripts', 'view articles', 'manage own profile',
            'manage projects', 'view projects',
        ]);

        // 8. Researcher (no submission, just profile + projects)
        $researcher = Role::findOrCreate('researcher');
        $researcher->givePermissionTo([
            'view articles', 'manage own profile',
            'manage projects', 'view projects',
        ]);

        // 9. Reader (authenticated user, basic access)
        $reader = Role::findOrCreate('reader');
        $reader->givePermissionTo([
            'view articles', 'view journals', 'view projects',
        ]);

        // 10. Proofreader / Service Staff
        $proofreader = Role::findOrCreate('proofreader');
        $proofreader->givePermissionTo([
            'view service requests', 'handle service requests',
            'manage own profile',
        ]);

        // 11. Copyeditor
        $copyeditor = Role::findOrCreate('copyeditor');
        $copyeditor->givePermissionTo([
            'view assigned manuscripts', 'manage own profile',
        ]);

        // 12. Layout Editor
        $layoutEditor = Role::findOrCreate('layout-editor');
        $layoutEditor->givePermissionTo([
            'view assigned manuscripts', 'manage own profile',
        ]);
    }
}
