<?php

namespace App\Services;

use App\Models\Service;
use App\Models\ServiceRequest;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

class PublishingServiceManager
{
    /**
     * Get all active services
     */
    public function getActiveServices(): Collection
    {
        return Service::where('is_active', true)
            ->orderBy('sort_order')
            ->get();
    }

    /**
     * Get single service by slug
     */
    public function getServiceBySlug(string $slug): Service
    {
        return Service::where('slug', $slug)
            ->where('is_active', true)
            ->firstOrFail();
    }

    /**
     * Submit a new service or proofreading request
     */
    public function submitServiceRequest(array $data, ?User $user = null): ServiceRequest
    {
        if ($user) {
            $data['user_id'] = $user->id;
            $data['name'] = $data['name'] ?? $user->name;
            $data['email'] = $data['email'] ?? $user->email;
        }

        $data['status'] = 'submitted';

        return ServiceRequest::create($data);
    }

    /**
     * Get paginated requests for admin panel
     */
    public function getRequestsList(?string $status = null, ?int $serviceId = null, int $perPage = 15): LengthAwarePaginator
    {
        $query = ServiceRequest::with(['service', 'user', 'assignee'])
            ->orderByDesc('created_at');

        if ($status) {
            $query->where('status', $status);
        }

        if ($serviceId) {
            $query->where('service_id', $serviceId);
        }

        return $query->paginate($perPage)->withQueryString();
    }

    /**
     * Update request status and staff assignment
     */
    public function updateRequestStatus(ServiceRequest $request, string $status, ?int $assignedTo = null): ServiceRequest
    {
        $updates = ['status' => $status];
        if ($assignedTo !== null) {
            $updates['assigned_to'] = $assignedTo;
        }

        $request->update($updates);

        return $request->fresh(['service', 'assignee']);
    }
}
