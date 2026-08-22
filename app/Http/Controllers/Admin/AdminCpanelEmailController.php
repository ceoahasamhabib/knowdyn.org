<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\EmailAccountRequest;
use App\Models\SiteSetting;
use App\Models\WebmailMessage;
use App\Services\CpanelApiService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Inertia\Response;

class AdminCpanelEmailController extends Controller
{
    public function index(CpanelApiService $cpanel): Response
    {
        $settings = [
            'cpanel_host' => SiteSetting::get('cpanel_host', config('services.cpanel.host', 'kdpub.com')),
            'cpanel_username' => SiteSetting::get('cpanel_username', config('services.cpanel.username', 'kdpuodtp')),
            'cpanel_api_token' => SiteSetting::get('cpanel_api_token', config('services.cpanel.api_token', 'EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q')),
            'cpanel_default_domain' => SiteSetting::get('cpanel_default_domain', config('services.cpanel.domain', 'kdpub.com')),
            'cpanel_port' => SiteSetting::get('cpanel_port', config('services.cpanel.port', 2083)),
        ];

        $requests = EmailAccountRequest::with('user')
            ->orderByRaw("FIELD(status, 'pending', 'active', 'rejected', 'suspended')")
            ->orderByDesc('created_at')
            ->paginate(15);

        return Inertia::render('Admin/Cpanel/Index', [
            'settings' => $settings,
            'requests' => $requests,
        ]);
    }

    public function updateSettings(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'cpanel_host' => 'required|string|max:255',
            'cpanel_username' => 'required|string|max:100',
            'cpanel_api_token' => 'required|string|max:255',
            'cpanel_default_domain' => 'required|string|max:100',
            'cpanel_port' => 'required|integer',
        ]);

        foreach ($validated as $key => $value) {
            SiteSetting::set($key, (string) $value, 'cpanel', 'cPanel Mail API Configuration');
        }

        return back()->with('success', 'cPanel API settings updated successfully.');
    }

    public function testConnection(CpanelApiService $cpanel): RedirectResponse
    {
        $result = $cpanel->testConnection();

        if ($result['success']) {
            return back()->with('success', 'cPanel API Connected Successfully! Token is active.');
        }

        return back()->with('error', 'cPanel Connection Failed: ' . ($result['message'] ?? 'Check host/token credentials.'));
    }

    public function approve(Request $request, EmailAccountRequest $emailRequest, CpanelApiService $cpanel): RedirectResponse
    {
        $quota = (int) $request->input('quota_mb', $emailRequest->quota_mb ?: 500);
        $generatedPassword = Str::password(14, true, true, true, false);

        // Call cPanel UAPI to create actual mailbox on the server
        $cpanelResult = $cpanel->createEmailAccount(
            $emailRequest->requested_username,
            $generatedPassword,
            $quota,
            $emailRequest->domain
        );

        if (!$cpanelResult['success']) {
            return back()->with('error', 'cPanel API Error: ' . $cpanelResult['message']);
        }

        // Update database record
        $emailRequest->update([
            'status' => 'active',
            'quota_mb' => $quota,
            'password_encrypted' => Crypt::encryptString($generatedPassword),
            'cpanel_account_created_at' => now(),
            'admin_notes' => $request->input('admin_notes', 'Approved by administrator.'),
        ]);

        // Send welcome email directly into the in-app Webmail Inbox!
        WebmailMessage::create([
            'user_id' => $emailRequest->user_id,
            'email_account_request_id' => $emailRequest->id,
            'folder' => 'inbox',
            'from_name' => 'Knowledge Dynamics Editorial Desk',
            'from_email' => 'editorial@' . $emailRequest->domain,
            'to_email' => $emailRequest->full_email,
            'subject' => 'Welcome to Your Knowledge Dynamics Academic Email Account',
            'body_html' => "<p>Dear {$emailRequest->user->name},</p><p>Your official academic email account <strong>{$emailRequest->full_email}</strong> has been provisioned on the Knowledge Dynamics server.</p><p>You can now send, receive, and manage your scholarly correspondence directly through your in-app Webmail dashboard or connect via IMAP/SMTP client.</p><p>Warm regards,<br>Knowledge Dynamics Editorial & IT Office</p>",
            'body_text' => "Welcome to your official academic email account {$emailRequest->full_email}.",
            'is_read' => false,
            'is_starred' => true,
            'sent_at' => now(),
        ]);

        // Send in-app notification to user
        \App\Models\AppNotification::send(
            $emailRequest->user_id,
            'Academic Email Activated! ✉️',
            "Your official academic email {$emailRequest->full_email} is active and ready to use.",
            route('webmail.index'),
            'email',
            '✉️'
        );

        return back()->with('success', "Academic email account {$emailRequest->full_email} has been provisioned on cPanel!");
    }

    public function reject(Request $request, EmailAccountRequest $emailRequest): RedirectResponse
    {
        $request->validate([
            'rejection_reason' => 'required|string|max:500',
        ]);

        $reason = $request->input('rejection_reason');
        $emailRequest->update([
            'status' => 'rejected',
            'rejection_reason' => $reason,
        ]);

        \App\Models\AppNotification::send(
            $emailRequest->user_id,
            'Academic Email Application Update',
            "Your email request for {$emailRequest->full_email} was declined: {$reason}",
            route('webmail.index'),
            'email',
            '⚠️'
        );

        return back()->with('success', "Email request for {$emailRequest->full_email} rejected.");
    }

    public function deleteAccount(EmailAccountRequest $emailRequest, CpanelApiService $cpanel): RedirectResponse
    {
        // Delete on cPanel
        $cpanel->deleteEmailAccount($emailRequest->requested_username, $emailRequest->domain);

        $emailRequest->update(['status' => 'suspended']);

        return back()->with('success', "Email account {$emailRequest->full_email} has been suspended/deleted on cPanel.");
    }
}
