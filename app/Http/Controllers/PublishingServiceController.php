<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreServiceRequestRequest;
use App\Models\Service;
use App\Services\PublishingServiceManager;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class PublishingServiceController extends Controller
{
    public function __construct(
        protected PublishingServiceManager $serviceManager
    ) {}

    /**
     * Services Directory (/services)
     */
    public function index(): Response
    {
        $services = $this->serviceManager->getActiveServices();

        return Inertia::render('Public/Services', [
            'services' => $services,
        ]);
    }

    /**
     * Dedicated KD Proofreading Portal (/proofreading)
     */
    public function proofreading(): Response
    {
        $proofreadingService = Service::where('slug', 'kd-proofreading')
            ->orWhere('slug', 'proofreading')
            ->first() ?? Service::first();

        return Inertia::render('Public/Proofreading', [
            'service' => $proofreadingService,
        ]);
    }

    /**
     * Service Detail Page (/services/{slug})
     */
    public function show(string $slug): Response
    {
        $service = $this->serviceManager->getServiceBySlug($slug);

        return Inertia::render('Public/ServiceShow', [
            'service' => $service,
        ]);
    }

    /**
     * Submit Service / Proofreading Request
     */
    public function storeRequest(StoreServiceRequestRequest $request): RedirectResponse
    {
        $this->serviceManager->submitServiceRequest($request->validated(), $request->user());

        return back()->with('success', 'Thank you! Your publishing service inquiry has been received. Our editorial team will review your manuscript specifications and contact you shortly.');
    }
}
