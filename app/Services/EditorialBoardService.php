<?php

namespace App\Services;

use App\Models\Journal;
use App\Models\JournalEditorialMember;
use Illuminate\Support\Collection;

class EditorialBoardService
{
    /**
     * Get grouped editorial board members for display
     */
    public function getGroupedEditorialBoard(Journal $journal): array
    {
        $members = $journal->editorialMembers()
            ->where('is_active', true)
            ->orderBy('sort_order')
            ->orderBy('name')
            ->get();

        $rolesOrder = [
            'Editor-in-Chief',
            'Associate Editor',
            'Managing Editor',
            'Section Editor',
            'Editorial Board Member',
            'International Advisory Board',
        ];

        $grouped = [];

        foreach ($rolesOrder as $role) {
            $roleMembers = $members->filter(fn ($m) => strcasecmp(trim($m->role), $role) === 0);
            if ($roleMembers->isNotEmpty()) {
                $grouped[$role] = $roleMembers->values();
            }
        }

        // Catch-all for any other custom roles
        $otherMembers = $members->reject(function ($m) use ($rolesOrder) {
            foreach ($rolesOrder as $role) {
                if (strcasecmp(trim($m->role), $role) === 0) {
                    return true;
                }
            }
            return false;
        });

        if ($otherMembers->isNotEmpty()) {
            $grouped['Other Members'] = $otherMembers->values();
        }

        return $grouped;
    }

    /**
     * Add member to editorial board
     */
    public function addMember(Journal $journal, array $data): JournalEditorialMember
    {
        if (!isset($data['sort_order'])) {
            $maxOrder = $journal->editorialMembers()->max('sort_order') ?? 0;
            $data['sort_order'] = $maxOrder + 1;
        }

        return $journal->editorialMembers()->create($data);
    }

    /**
     * Update editorial member
     */
    public function updateMember(JournalEditorialMember $member, array $data): JournalEditorialMember
    {
        $member->update($data);
        return $member->fresh();
    }

    /**
     * Remove editorial member
     */
    public function removeMember(JournalEditorialMember $member): bool
    {
        return $member->delete();
    }

    /**
     * Reorder editorial members
     */
    public function reorderMembers(Journal $journal, array $orderedIds): void
    {
        foreach ($orderedIds as $index => $id) {
            $journal->editorialMembers()->where('id', $id)->update(['sort_order' => $index + 1]);
        }
    }
}
