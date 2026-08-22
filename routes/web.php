<?php

use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\AdminEditorialBoardController;
use App\Http\Controllers\Admin\AdminJournalController;
use App\Http\Controllers\Admin\AdminVolumeIssueController;
use App\Http\Controllers\JournalController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\PublicController;
use App\Http\Controllers\ResearcherController;
use App\Http\Controllers\ResearcherProfileController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

// ── Public Routes ────────────────────────────────────────────
Route::get('/', [PublicController::class, 'home'])->name('home');
Route::get('/about', [PublicController::class, 'about'])->name('about');
Route::get('/contact', [PublicController::class, 'contact'])->name('contact');
Route::post('/contact', [PublicController::class, 'contactStore'])->name('contact.store');
// Publishing Services & Proofreading
Route::get('/services', [\App\Http\Controllers\PublishingServiceController::class, 'index'])->name('services');
Route::get('/services/{slug}', [\App\Http\Controllers\PublishingServiceController::class, 'show'])->name('services.show');
Route::get('/proofreading', [\App\Http\Controllers\PublishingServiceController::class, 'proofreading'])->name('proofreading.index');
Route::get('/proofreading/freelancers', [\App\Http\Controllers\InformationArchitectureController::class, 'freelancers'])->name('proofreading.freelancers');
Route::post('/services/request', [\App\Http\Controllers\PublishingServiceController::class, 'storeRequest'])->name('services.request.store');

// Publishing Policies & Books
Route::get('/publish/open-access', [\App\Http\Controllers\InformationArchitectureController::class, 'openAccess'])->name('publish.open_access');
Route::get('/publish/books', [\App\Http\Controllers\InformationArchitectureController::class, 'books'])->name('publish.books');
Route::get('/books', [\App\Http\Controllers\InformationArchitectureController::class, 'books'])->name('books.index');
Route::get('/books/propose', [\App\Http\Controllers\InformationArchitectureController::class, 'proposeBook'])->name('books.propose');
Route::post('/books/propose', [\App\Http\Controllers\InformationArchitectureController::class, 'storeBookProposal'])->name('books.propose.store');

// News, Events & Careers
Route::get('/news', [\App\Http\Controllers\InformationArchitectureController::class, 'news'])->name('news.index');
Route::get('/news/announcements', [\App\Http\Controllers\InformationArchitectureController::class, 'news'])->name('news.announcements');
Route::get('/events', [\App\Http\Controllers\InformationArchitectureController::class, 'events'])->name('events.index');
Route::get('/events/workshops', [\App\Http\Controllers\InformationArchitectureController::class, 'events'])->name('events.workshops');
Route::get('/careers', [\App\Http\Controllers\InformationArchitectureController::class, 'careers'])->name('careers.index');

// For Librarians & Guidelines
Route::get('/librarians', [\App\Http\Controllers\InformationArchitectureController::class, 'librarians'])->name('librarians.index');
Route::get('/librarians/faqs', [\App\Http\Controllers\InformationArchitectureController::class, 'librarians'])->name('librarians.faqs');
Route::get('/librarians/catalogue', [\App\Http\Controllers\InformationArchitectureController::class, 'librarians'])->name('librarians.catalogue');
Route::get('/librarians/order-print', [\App\Http\Controllers\InformationArchitectureController::class, 'librarians'])->name('librarians.order_print');
Route::get('/guidelines/{type}', [\App\Http\Controllers\InformationArchitectureController::class, 'guidelines'])->name('guidelines.show');

// Support & Community Feedback
Route::get('/support', [\App\Http\Controllers\InformationArchitectureController::class, 'support'])->name('support.index');
Route::get('/feedback', [\App\Http\Controllers\InformationArchitectureController::class, 'feedback'])->name('feedback.index');
Route::post('/feedback', [\App\Http\Controllers\InformationArchitectureController::class, 'storeFeedback'])->name('feedback.store');

// Journals Public Architecture
Route::get('/journals', [JournalController::class, 'index'])->name('journals.index');
Route::get('/journals/{slug}', [JournalController::class, 'show'])->name('journals.show');
Route::get('/journals/{slug}/issues', [JournalController::class, 'issues'])->name('journals.issues');
Route::get('/journals/{slug}/archive', [JournalController::class, 'archive'])->name('journals.archive');
Route::get('/journals/{slug}/editorial-board', [JournalController::class, 'editorialBoard'])->name('journals.editorial_board');

// Articles Public Repository
Route::get('/articles', [\App\Http\Controllers\ArticleController::class, 'index'])->name('articles.index');
Route::get('/articles/{slug}', [\App\Http\Controllers\ArticleController::class, 'show'])->name('articles.show');
Route::get('/articles/{slug}/cite/{format}', [\App\Http\Controllers\ArticleController::class, 'exportCitation'])->name('articles.citation');
Route::get('/articles/{slug}/download', [\App\Http\Controllers\ArticleController::class, 'downloadPdf'])->name('articles.download');

// Researchers
Route::get('/researchers', [ResearcherController::class, 'index'])->name('researchers.index');
Route::get('/researchers/{username}', [ResearcherController::class, 'show'])->name('researchers.show');

// Projects
Route::get('/projects', [ProjectController::class, 'index'])->name('projects.index');
Route::get('/projects/{project}', [ProjectController::class, 'show'])->name('projects.show');

// ── Authenticated Routes ─────────────────────────────────────
Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// Manuscript Submission Portal
Route::get('/submit', [\App\Http\Controllers\ManuscriptSubmissionController::class, 'create'])->name('manuscripts.create');
Route::post('/submit', [\App\Http\Controllers\ManuscriptSubmissionController::class, 'store'])->middleware('auth')->name('manuscripts.store');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Researcher Profile Dashboard
    Route::get('/researcher/profile', [ResearcherProfileController::class, 'edit'])->name('researcher.profile.edit');
    Route::put('/researcher/profile', [ResearcherProfileController::class, 'update'])->name('researcher.profile.update');
    Route::put('/researcher/interests', [ResearcherProfileController::class, 'updateInterests'])->name('researcher.interests.update');
    Route::post('/researcher/affiliations', [ResearcherProfileController::class, 'addAffiliation'])->name('researcher.affiliations.store');
    Route::delete('/researcher/affiliations/{affiliation}', [ResearcherProfileController::class, 'removeAffiliation'])->name('researcher.affiliations.destroy');

    // Author Submissions Dashboard
    Route::get('/dashboard/submissions', [\App\Http\Controllers\Author\AuthorSubmissionController::class, 'index'])->name('author.submissions.index');
    Route::get('/dashboard/submissions/{id}', [\App\Http\Controllers\Author\AuthorSubmissionController::class, 'show'])->name('author.submissions.show');

    // Reviewer Dashboard & Peer Review
    Route::get('/dashboard/reviews', [\App\Http\Controllers\Reviewer\ReviewerDashboardController::class, 'index'])->name('reviewer.dashboard');
    Route::post('/reviewer/assignments/{assignment}/respond', [\App\Http\Controllers\Reviewer\ReviewerDashboardController::class, 'respond'])->name('reviewer.respond');
    Route::get('/reviewer/assignments/{assignment}/review', [\App\Http\Controllers\Reviewer\ReviewerDashboardController::class, 'showReviewForm'])->name('reviewer.review.form');
    Route::post('/reviewer/assignments/{assignment}/review', [\App\Http\Controllers\Reviewer\ReviewerDashboardController::class, 'submitReview'])->name('reviewer.review.submit');

    // Webmail & Academic Email Portal
    Route::get('/webmail', [\App\Http\Controllers\WebmailController::class, 'index'])->name('webmail.index');
    Route::get('/webmail/cpanel-sso', [\App\Http\Controllers\WebmailController::class, 'cpanelSso'])->name('webmail.cpanel_sso');
    Route::post('/webmail/apply', [\App\Http\Controllers\WebmailController::class, 'apply'])->name('webmail.apply');
    Route::post('/webmail/send', [\App\Http\Controllers\WebmailController::class, 'sendMessage'])->name('webmail.send');
    Route::post('/webmail/messages/{message}/star', [\App\Http\Controllers\WebmailController::class, 'toggleStar'])->name('webmail.star');
    Route::delete('/webmail/messages/{message}', [\App\Http\Controllers\WebmailController::class, 'deleteMessage'])->name('webmail.delete');

    // In-App Notification Routes
    Route::post('/notifications/{notification}/read', [\App\Http\Controllers\NotificationController::class, 'markAsRead'])->name('notifications.read');
    Route::post('/notifications/mark-all-read', [\App\Http\Controllers\NotificationController::class, 'markAllAsRead'])->name('notifications.mark_all_read');
});

// ── Admin Routes ─────────────────────────────────────────────
Route::middleware(['auth', 'verified', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/', [AdminController::class, 'dashboard'])->name('dashboard');

    // Journals Management
    Route::resource('journals', AdminJournalController::class);

    // Articles Management
    Route::resource('articles', \App\Http\Controllers\Admin\AdminArticleController::class);

    // Manuscripts Editorial Management
    Route::get('/manuscripts', [\App\Http\Controllers\Admin\AdminManuscriptController::class, 'index'])->name('manuscripts.index');
    Route::get('/manuscripts/{manuscript}', [\App\Http\Controllers\Admin\AdminManuscriptController::class, 'show'])->name('manuscripts.show');
    Route::post('/manuscripts/{manuscript}/screening', [\App\Http\Controllers\Admin\AdminManuscriptController::class, 'passScreening'])->name('manuscripts.screening');
    Route::post('/manuscripts/{manuscript}/assign-editor', [\App\Http\Controllers\Admin\AdminManuscriptController::class, 'assignEditor'])->name('manuscripts.assign_editor');
    Route::post('/manuscripts/{manuscript}/decision', [\App\Http\Controllers\Admin\AdminManuscriptController::class, 'makeDecision'])->name('manuscripts.decision');
    Route::post('/manuscripts/{manuscript}/invite-reviewer', [\App\Http\Controllers\Admin\AdminManuscriptController::class, 'inviteReviewer'])->name('manuscripts.invite_reviewer');

    // Services & Proofreading Inquiries Management
    Route::get('/services', [\App\Http\Controllers\Admin\AdminServiceController::class, 'index'])->name('services.index');
    Route::post('/services/{serviceRequest}/status', [\App\Http\Controllers\Admin\AdminServiceController::class, 'updateStatus'])->name('services.update_status');

    // Volumes and Issues Management
    Route::get('/journals/{journal}/volumes-issues', [AdminVolumeIssueController::class, 'index'])->name('journals.volumes.index');
    Route::post('/journals/{journal}/volumes', [AdminVolumeIssueController::class, 'storeVolume'])->name('journals.volumes.store');
    Route::put('/volumes/{volume}', [AdminVolumeIssueController::class, 'updateVolume'])->name('volumes.update');
    Route::delete('/volumes/{volume}', [AdminVolumeIssueController::class, 'destroyVolume'])->name('volumes.destroy');
    Route::post('/volumes/{volume}/issues', [AdminVolumeIssueController::class, 'storeIssue'])->name('volumes.issues.store');
    Route::put('/issues/{issue}', [AdminVolumeIssueController::class, 'updateIssue'])->name('issues.update');
    Route::delete('/issues/{issue}', [AdminVolumeIssueController::class, 'destroyIssue'])->name('issues.destroy');
    Route::post('/issues/{issue}/set-current', [AdminVolumeIssueController::class, 'setCurrentIssue'])->name('issues.set_current');

    // Editorial Board Management
    Route::get('/journals/{journal}/editorial-board', [AdminEditorialBoardController::class, 'index'])->name('journals.editorial_board.index');
    Route::post('/journals/{journal}/editorial-board', [AdminEditorialBoardController::class, 'store'])->name('journals.editorial_board.store');
    Route::put('/editorial-members/{member}', [AdminEditorialBoardController::class, 'update'])->name('editorial_members.update');
    Route::delete('/editorial-members/{member}', [AdminEditorialBoardController::class, 'destroy'])->name('editorial_members.destroy');
    Route::post('/journals/{journal}/editorial-board/reorder', [AdminEditorialBoardController::class, 'reorder'])->name('journals.editorial_board.reorder');

    // Users & Roles Management
    Route::get('/users', [\App\Http\Controllers\Admin\AdminUserController::class, 'index'])->name('users.index');
    Route::get('/users/{user}/edit', [\App\Http\Controllers\Admin\AdminUserController::class, 'edit'])->name('users.edit');
    Route::put('/users/{user}', [\App\Http\Controllers\Admin\AdminUserController::class, 'update'])->name('users.update');

    // Books & Proposals Management
    Route::get('/books/proposals', [\App\Http\Controllers\Admin\AdminBookController::class, 'proposals'])->name('books.proposals');
    Route::post('/books/proposals/{proposal}/status', [\App\Http\Controllers\Admin\AdminBookController::class, 'updateProposalStatus'])->name('books.proposals.update_status');
    Route::resource('books', \App\Http\Controllers\Admin\AdminBookController::class);

    // News, Announcements & Events Management
    Route::resource('news-events', \App\Http\Controllers\Admin\AdminNewsEventController::class)->names('news_events');

    // Careers Management
    Route::resource('careers', \App\Http\Controllers\Admin\AdminCareerController::class)->names('careers');

    // Guidelines & CMS Policies Management
    Route::get('/guidelines', [\App\Http\Controllers\Admin\AdminGuidelineController::class, 'index'])->name('guidelines.index');
    Route::get('/guidelines/{guidelinePage}/edit', [\App\Http\Controllers\Admin\AdminGuidelineController::class, 'edit'])->name('guidelines.edit');
    Route::put('/guidelines/{guidelinePage}', [\App\Http\Controllers\Admin\AdminGuidelineController::class, 'update'])->name('guidelines.update');

    // System Settings & DOI Config
    Route::get('/settings', [\App\Http\Controllers\Admin\AdminSettingController::class, 'index'])->name('settings.index');
    Route::post('/settings', [\App\Http\Controllers\Admin\AdminSettingController::class, 'update'])->name('settings.update');

    // cPanel API & Email Accounts Management
    Route::get('/cpanel-email', [\App\Http\Controllers\Admin\AdminCpanelEmailController::class, 'index'])->name('cpanel.index');
    Route::post('/cpanel-email/settings', [\App\Http\Controllers\Admin\AdminCpanelEmailController::class, 'updateSettings'])->name('cpanel.settings');
    Route::post('/cpanel-email/test-connection', [\App\Http\Controllers\Admin\AdminCpanelEmailController::class, 'testConnection'])->name('cpanel.test_connection');
    Route::post('/cpanel-email/requests/{emailRequest}/approve', [\App\Http\Controllers\Admin\AdminCpanelEmailController::class, 'approve'])->name('cpanel.approve');
    Route::post('/cpanel-email/requests/{emailRequest}/reject', [\App\Http\Controllers\Admin\AdminCpanelEmailController::class, 'reject'])->name('cpanel.reject');
    Route::delete('/cpanel-email/accounts/{emailRequest}', [\App\Http\Controllers\Admin\AdminCpanelEmailController::class, 'deleteAccount'])->name('cpanel.delete_account');

    // Universal System Updater & Maintenance
    Route::get('/system-updater', [\App\Http\Controllers\Admin\AdminSystemUpdaterController::class, 'index'])->name('system_updater.index');
    Route::post('/system-updater/upload', [\App\Http\Controllers\Admin\AdminSystemUpdaterController::class, 'upload'])->name('system_updater.upload');
    Route::post('/system-updater/migrate', [\App\Http\Controllers\Admin\AdminSystemUpdaterController::class, 'migrate'])->name('system_updater.migrate');
    Route::post('/system-updater/clear-cache', [\App\Http\Controllers\Admin\AdminSystemUpdaterController::class, 'clearCache'])->name('system_updater.clear_cache');
    Route::get('/system-updater/health', [\App\Http\Controllers\Admin\AdminSystemUpdaterController::class, 'healthCheck'])->name('system_updater.health');
});

require __DIR__.'/auth.php';

// Vanity Researcher Profile Route: /{username}
Route::get('/{username}', [ResearcherController::class, 'show'])
    ->where('username', '^(?!admin|api|login|register|logout|dashboard|journals|articles|projects|services|search|contact|about|submit|proofreading|researchers|settings|profile|password|verify|email|notifications|home|sitemap|feed|rss|researcher|_debugbar|sanctum).*$')
    ->name('researcher.profile.public');
