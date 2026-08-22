<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        $admin1 = User::updateOrCreate(
            ['email' => 'admin@knowledge-dynamics.com'],
            [
                'name' => 'KD Admin',
                'first_name' => 'KD',
                'last_name' => 'Admin',
                'username' => 'kdadmin',
                'password' => Hash::make('password'),
                'email_verified_at' => now(),
                'status' => 'active',
            ]
        );
        $admin1->syncRoles(['super-admin', 'admin']);

        $admin2 = User::updateOrCreate(
            ['email' => 'admin@knowdyn.org'],
            [
                'name' => 'Super Administrator',
                'first_name' => 'Super',
                'last_name' => 'Admin',
                'username' => 'superadmin',
                'password' => Hash::make('password'),
                'email_verified_at' => now(),
                'status' => 'active',
            ]
        );
        $admin2->syncRoles(['super-admin', 'admin']);
    }
}
