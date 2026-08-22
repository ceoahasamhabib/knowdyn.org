<?php

namespace App\Http\Controllers;

use App\Models\EmailAccountRequest;
use App\Models\SiteSetting;
use App\Models\WebmailMessage;
use App\Services\CpanelApiService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Inertia\Response;

class WebmailController extends Controller
{
    protected CpanelApiService $cpanelService;

    public function __construct(CpanelApiService $cpanelService)
    {
        $this->cpanelService = $cpanelService;
    }

    public function index(Request $request): Response
    {
        $user = Auth::user();
        $emailAccount = EmailAccountRequest::where('user_id', $user->id)->first();
        $defaultDomain = SiteSetting::get('cpanel_default_domain', 'kdpub.com');

        $currentFolder = $request->query('folder', 'inbox');
        $selectedMessageId = $request->query('message_id');

        $messages = [];
        $unreadInboxCount = 0;
        $activeMessage = null;
        $cpanelSsoUrl = null;

        if ($emailAccount && $emailAccount->status === 'active') {
            $unreadInboxCount = WebmailMessage::where('user_id', $user->id)
                ->where('folder', 'inbox')
                ->where('is_read', false)
                ->count();

            $query = WebmailMessage::where('user_id', $user->id)->orderByDesc('created_at');

            if ($currentFolder === 'starred') {
                $query->where('is_starred', true);
            } else {
                $query->where('folder', $currentFolder);
            }

            $messages = $query->get();

            if ($selectedMessageId) {
                $activeMessage = WebmailMessage::where('user_id', $user->id)
                    ->where('id', $selectedMessageId)
                    ->first();

                if ($activeMessage && !$activeMessage->is_read) {
                    $activeMessage->update(['is_read' => true]);
                }
            } elseif ($messages->isNotEmpty()) {
                $activeMessage = $messages->first();
                if ($activeMessage && !$activeMessage->is_read) {
                    $activeMessage->update(['is_read' => true]);
                }
            }

            // Generate 1-Click cPanel Webmail SSO login URL
            $cpanelSsoUrl = $this->cpanelService->getWebmailLoginUrl($emailAccount->full_email);
        }

        return Inertia::render('Webmail/Index', [
            'emailAccount' => $emailAccount,
            'defaultDomain' => $defaultDomain,
            'currentFolder' => $currentFolder,
            'messages' => $messages,
            'activeMessage' => $activeMessage,
            'unreadInboxCount' => $unreadInboxCount,
            'cpanelSsoUrl' => $cpanelSsoUrl,
        ]);
    }

    public function apply(Request $request): RedirectResponse
    {
        $user = Auth::user();

        $defaultDomain = SiteSetting::get('cpanel_default_domain', 'kdpub.com');

        $validated = $request->validate([
            'requested_username' => 'required|string|min:3|max:40|regex:/^[a-zA-Z0-9._-]+$/',
        ]);

        $username = strtolower(trim($validated['requested_username']));
        $fullEmail = "{$username}@{$defaultDomain}";

        // Check uniqueness
        if (EmailAccountRequest::where('full_email', $fullEmail)->exists()) {
            return back()->with('error', "The email username '{$username}' is already taken. Please choose a different handle.");
        }

        // Check if user already has an active or pending account
        $existing = EmailAccountRequest::where('user_id', $user->id)->first();
        if ($existing && in_array($existing->status, ['pending', 'active'])) {
            return back()->with('error', "You already have an active or pending academic email application.");
        }

        EmailAccountRequest::updateOrCreate(
            ['user_id' => $user->id],
            [
                'requested_username' => $username,
                'domain' => $defaultDomain,
                'full_email' => $fullEmail,
                'quota_mb' => 500,
                'status' => 'pending',
                'rejection_reason' => null,
            ]
        );

        // Notify Admins
        \App\Models\AppNotification::notifyAdmins(
            'New Academic Email Request',
            "User {$user->name} applied for {$fullEmail}.",
            route('admin.cpanel.index'),
            'email',
            '✉️'
        );

        return back()->with('success', "Your application for {$fullEmail} has been submitted! An administrator will review and activate your account.");
    }

    public function sendMessage(Request $request): RedirectResponse
    {
        $user = Auth::user();
        
        $validated = $request->validate([
            'to_email' => 'required|email|max:255',
            'cc_email' => 'nullable|email|max:255',
            'subject' => 'required|string|max:255',
            'body' => 'required|string',
        ]);

        // Find or auto-provision active email account for current user
        $account = EmailAccountRequest::where('user_id', $user->id)->where('status', 'active')->first();
        $defaultDomain = SiteSetting::get('cpanel_default_domain', 'kdpub.com');

        if (!$account) {
            $username = Str::slug($user->name, '.') ?: 'scholar';
            $account = EmailAccountRequest::updateOrCreate(
                ['user_id' => $user->id],
                [
                    'requested_username' => $username,
                    'domain' => $defaultDomain,
                    'full_email' => "{$username}@{$defaultDomain}",
                    'quota_mb' => 500,
                    'status' => 'active',
                ]
            );
        }

        // 1. Record in Sender's Sent folder
        WebmailMessage::create([
            'user_id' => $user->id,
            'email_account_request_id' => $account->id,
            'folder' => 'sent',
            'from_name' => $user->name,
            'from_email' => $account->full_email,
            'to_email' => $validated['to_email'],
            'cc_email' => $validated['cc_email'] ?? null,
            'subject' => $validated['subject'],
            'body_html' => nl2br(e($validated['body'])),
            'body_text' => $validated['body'],
            'is_read' => true,
            'sent_at' => now(),
        ]);

        // 2. If recipient is an internal account, deposit immediately into their Inbox!
        $recipientAccount = EmailAccountRequest::where('full_email', $validated['to_email'])
            ->where('status', 'active')
            ->first();

        if ($recipientAccount) {
            WebmailMessage::create([
                'user_id' => $recipientAccount->user_id,
                'email_account_request_id' => $recipientAccount->id,
                'folder' => 'inbox',
                'from_name' => $user->name,
                'from_email' => $account->full_email,
                'to_email' => $validated['to_email'],
                'cc_email' => $validated['cc_email'] ?? null,
                'subject' => $validated['subject'],
                'body_html' => nl2br(e($validated['body'])),
                'body_text' => $validated['body'],
                'is_read' => false,
                'sent_at' => now(),
            ]);
        }

        // 3. Optional SMTP delivery if mail transport is live
        try {
            if (config('mail.mailers.smtp.host') && config('mail.mailers.smtp.host') !== '127.0.0.1') {
                Mail::raw($validated['body'], function ($message) use ($validated, $account, $user) {
                    $message->from($account->full_email, $user->name)
                        ->to($validated['to_email'])
                        ->subject($validated['subject']);

                    if (!empty($validated['cc_email'])) {
                        $message->cc($validated['cc_email']);
                    }
                });
            }
        } catch (\Throwable $e) {
            Log::info("Webmail external SMTP transport skipped: " . $e->getMessage());
        }

        return redirect()->route('webmail.index', ['folder' => 'sent'])
            ->with('success', 'Email message dispatched successfully and recorded in Sent folder!');
    }

    public function cpanelSso(): RedirectResponse
    {
        $user = Auth::user();
        $account = EmailAccountRequest::where('user_id', $user->id)->where('status', 'active')->first();
        
        $email = $account ? $account->full_email : $user->email;
        $url = $this->cpanelService->getWebmailLoginUrl($email);

        return redirect()->away($url);
    }

    public function toggleStar(WebmailMessage $message): RedirectResponse
    {
        if ($message->user_id !== Auth::id()) {
            abort(403);
        }

        $message->update(['is_starred' => !$message->is_starred]);

        return back();
    }

    public function deleteMessage(WebmailMessage $message): RedirectResponse
    {
        if ($message->user_id !== Auth::id()) {
            abort(403);
        }

        if ($message->folder === 'trash') {
            $message->delete();
        } else {
            $message->update(['folder' => 'trash']);
        }

        return back()->with('success', 'Message moved to Trash.');
    }
}
