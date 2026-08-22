<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Service;
use App\Models\ServiceRequest;
use App\Models\User;
use App\Services\PublishingServiceManager;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class AdminServiceController extends Controller
{
    public function __construct(
        protected PublishingServiceManager $serviceManager
    ) {}

    /**
     * Admin Service Inquiries & Orders Queue (/admin/services)
     */
    public function index(Request $request): Response
    {
        $status = $request->input('status');
        $serviceId = $request->input('service_id');

        $requests = $this->serviceManager->getRequestsList($status, $serviceId, 15);
        $services = Service::select('id', 'title', 'slug')->get();
        $staffMembers = User::select('id', 'name', 'email')->get();

        return Inertia::render('Admin/Services/Index', [
            'requests' => $requests,
            'services' => $services,
            'staffMembers' => $staffMembers,
            'filters' => [
                'status' => $status,
                'service_id' => $serviceId,
            ],
        ]);
    }

    /**
     * Update Request Status & Assign Staff
     */
    public function updateStatus(Request $request, ServiceRequest $serviceRequest): RedirectResponse
    {
        $request->validate([
            'status' => 'required|in:submitted,assigned,in_progress,quality_check,completed,cancelled',
            'assigned_to' => 'nullable|exists:users,id',
        ]);

        $status = $request->input('status');
        $this->serviceManager->updateRequestStatus(
            $serviceRequest,
            $status,
            $request->input('assigned_to')
        );

        if ($serviceRequest->user_id) {
            \App\Models\AppNotification::send(
                $serviceRequest->user_id,
                'Service Request Update',
                "Your request for " . ($serviceRequest->service?->title ?? 'editorial service') . " status is now " . ucfirst(str_replace('_', ' ', $status)) . ".",
                route('dashboard'),
                'service',
                '💼'
            );
        }

        return back()->with('success', 'Service request updated successfully.');
    }
}
