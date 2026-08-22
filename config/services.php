<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Resend, Postmark, AWS, and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'key' => env('POSTMARK_API_KEY'),
    ],

    'resend' => [
        'key' => env('RESEND_API_KEY'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

    'cpanel' => [
        'host' => env('CPANEL_HOST', 'kdpub.com'),
        'username' => env('CPANEL_USERNAME', 'kdpuodtp'),
        'api_token' => env('CPANEL_API_TOKEN', 'EQDJGQU1P0BZN6RXTYZFY6NVL6DZ4C7Q'),
        'domain' => env('CPANEL_DEFAULT_DOMAIN', 'kdpub.com'),
        'port' => env('CPANEL_PORT', 2083),
    ],

];
