<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;
use Spatie\Permission\Models\Role;

class AdminUserController extends Controller
{
    public function index(Request $request): Response
    {
        $search = $request->query('search');
        $role = $request->query('role');

        $query = User::with(['roles', 'researcherProfile'])
            ->orderByDesc('created_at');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%")
                  ->orWhere('username', 'like', "%{$search}%");
            });
        }

        if ($role) {
            $query->whereHas('roles', fn ($q) => $q->where('name', $role));
        }

        $users = $query->paginate(15)->withQueryString();
        $roles = Role::pluck('name');

        return Inertia::render('Admin/Users/Index', [
            'users' => $users,
            'roles' => $roles,
            'filters' => [
                'search' => $search,
                'role' => $role,
            ],
        ]);
    }

    public function edit(User $user): Response
    {
        $roles = Role::pluck('name');
        $userRoles = $user->roles()->pluck('name');

        return Inertia::render('Admin/Users/Edit', [
            'user' => $user->load('researcherProfile'),
            'roles' => $roles,
            'userRoles' => $userRoles,
        ]);
    }

    public function update(Request $request, User $user): RedirectResponse
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $user->id,
            'roles' => 'array',
        ]);

        $user->update($request->only('name', 'email', 'is_active'));

        if ($request->has('roles')) {
            $user->syncRoles($request->input('roles'));

            \App\Models\AppNotification::send(
                $user->id,
                'Account Roles Updated',
                'Your institutional roles and permissions have been updated by an administrator.',
                route('dashboard'),
                'system',
                '🛡️'
            );
        }

        return redirect()->route('admin.users.index')->with('success', 'User updated successfully.');
    }
}
