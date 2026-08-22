import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue',
    ],

    theme: {
        extend: {
            colors: {
                // Primary brand
                navy: {
                    50: '#EFF3F9',
                    100: '#D7E1EF',
                    200: '#B0C4DE',
                    300: '#7FA0C7',
                    400: '#4E7CB0',
                    500: '#1E4D8C',
                    600: '#183D70',
                    700: '#0F2A4A',
                    800: '#0B1E35',
                    900: '#071320',
                    950: '#040B14',
                },
                // Academic Blue — interactive
                academic: {
                    50: '#EFF6FF',
                    100: '#DBEAFE',
                    200: '#BFDBFE',
                    300: '#93C5FD',
                    400: '#60A5FA',
                    500: '#3B82F6',
                    600: '#2563EB',
                    700: '#1D4ED8',
                    800: '#1E40AF',
                    900: '#1E3A8A',
                },
                // Open Access orange
                'oa-orange': '#F59E0B',
            },
            fontFamily: {
                sans: ['Inter', ...defaultTheme.fontFamily.sans],
                mono: ['JetBrains Mono', ...defaultTheme.fontFamily.mono],
            },
            fontSize: {
                'display': ['2.25rem', { lineHeight: '1.2', fontWeight: '700' }],
            },
            borderRadius: {
                'card': '8px',
            },
            boxShadow: {
                'card': '0 1px 3px rgba(0,0,0,0.08), 0 1px 2px rgba(0,0,0,0.04)',
                'card-hover': '0 4px 12px rgba(0,0,0,0.1)',
                'nav': '0 1px 3px rgba(0,0,0,0.06)',
            },
            screens: {
                'xs': '375px',
            },
        },
    },

    plugins: [forms],
};
