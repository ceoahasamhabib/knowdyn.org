# Knowledge Dynamics — Route Map

## Public Routes (web)

| Method | URI | Name | Controller |
|---|---|---|---|
| GET | `/` | home | HomeController@index |
| GET | `/journals` | journals.index | JournalController@index |
| GET | `/journals/{slug}` | journals.show | JournalController@show |
| GET | `/journals/{slug}/archive` | journals.archive | JournalController@archive |
| GET | `/journals/{slug}/editorial-board` | journals.editorial | JournalController@editorial |
| GET | `/journals/{slug}/policies` | journals.policies | JournalController@policies |
| GET | `/journals/{slug}/author-guidelines` | journals.guidelines | JournalController@guidelines |
| GET | `/articles` | articles.index | ArticleController@index |
| GET | `/articles/{slug}` | articles.show | ArticleController@show |
| GET | `/articles/{slug}/pdf` | articles.pdf | ArticleController@pdf |
| GET | `/researchers` | researchers.index | ResearcherController@index |
| GET | `/projects` | projects.index | ProjectController@index |
| GET | `/projects/{slug}` | projects.show | ProjectController@show |
| GET | `/services` | services.index | ServiceController@index |
| GET | `/services/{slug}` | services.show | ServiceController@show |
| GET | `/search` | search | SearchController@index |
| GET | `/contact` | contact | PageController@contact |
| GET | `/about` | about | PageController@about |
| GET | `/{username}` | researcher.profile | ResearcherController@show |

## Auth Routes (Breeze)

| Method | URI | Name |
|---|---|---|
| GET | `/login` | login |
| POST | `/login` | - |
| GET | `/register` | register |
| POST | `/register` | - |
| POST | `/logout` | logout |
| GET | `/forgot-password` | password.request |
| POST | `/forgot-password` | password.email |
| GET | `/reset-password/{token}` | password.reset |
| POST | `/reset-password` | password.store |
| GET | `/verify-email` | verification.notice |
| GET | `/verify-email/{id}/{hash}` | verification.verify |

## Authenticated Routes

| Method | URI | Name | Controller |
|---|---|---|---|
| GET | `/dashboard` | dashboard | DashboardController@index |
| GET | `/profile` | profile.edit | ProfileController@edit |
| PATCH | `/profile` | profile.update | ProfileController@update |

## Author Routes (auth + role:author)

| Method | URI | Name | Controller |
|---|---|---|---|
| GET | `/submit` | submissions.create | SubmissionController@create |
| POST | `/submit` | submissions.store | SubmissionController@store |
| GET | `/my-submissions` | submissions.index | SubmissionController@index |
| GET | `/my-submissions/{id}` | submissions.show | SubmissionController@show |

## Editor Routes (auth + role:editor)

| Method | URI | Prefix | Controller |
|---|---|---|---|
| GET | `/editor/dashboard` | editor. | EditorController@dashboard |
| GET | `/editor/manuscripts` | editor. | EditorController@manuscripts |
| GET | `/editor/manuscripts/{id}` | editor. | EditorController@show |

## Reviewer Routes (auth + role:reviewer)

| Method | URI | Prefix | Controller |
|---|---|---|---|
| GET | `/reviewer/dashboard` | reviewer. | ReviewerController@dashboard |
| GET | `/reviewer/assignments` | reviewer. | ReviewerController@assignments |
| GET | `/reviewer/assignments/{id}` | reviewer. | ReviewerController@show |

## Admin Routes (auth + admin middleware)

| Method | URI | Prefix | Controller |
|---|---|---|---|
| GET | `/admin` | admin. | AdminController@dashboard |
| RESOURCE | `/admin/users` | admin.users. | Admin\UserController |
| RESOURCE | `/admin/journals` | admin.journals. | Admin\JournalController |
| RESOURCE | `/admin/articles` | admin.articles. | Admin\ArticleController |
| RESOURCE | `/admin/services` | admin.services. | Admin\ServiceController |
| RESOURCE | `/admin/pages` | admin.pages. | Admin\PageController |
| GET | `/admin/settings` | admin.settings. | Admin\SettingsController |
| GET | `/admin/audit-logs` | admin.audit-logs | Admin\AuditLogController |

## API Routes (future)

| Method | URI | Prefix |
|---|---|---|
| GET | `/api/v1/journals` | api.v1 |
| GET | `/api/v1/articles` | api.v1 |
| GET | `/api/v1/researchers` | api.v1 |
| GET | `/api/v1/search` | api.v1 |
