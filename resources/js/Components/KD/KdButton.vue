<script setup>
defineProps({
    variant: {
        type: String,
        default: 'primary',
        validator: v => ['primary', 'secondary', 'ghost', 'danger', 'accent'].includes(v),
    },
    size: {
        type: String,
        default: 'md',
        validator: v => ['sm', 'md', 'lg'].includes(v),
    },
    href: String,
    disabled: Boolean,
    loading: Boolean,
    type: {
        type: String,
        default: 'button',
    },
});

const classes = {
    primary: 'bg-navy-700 text-white hover:bg-navy-600 focus:ring-navy-500',
    secondary: 'bg-white text-navy-700 border border-gray-200 hover:bg-gray-50 hover:border-gray-300 focus:ring-navy-500',
    ghost: 'bg-transparent text-navy-600 hover:bg-navy-50 focus:ring-navy-500',
    danger: 'bg-red-600 text-white hover:bg-red-700 focus:ring-red-500',
    accent: 'bg-academic-500 text-white hover:bg-academic-600 focus:ring-academic-500',
};

const sizes = {
    sm: 'px-3 py-1.5 text-sm',
    md: 'px-4 py-2.5 text-sm',
    lg: 'px-6 py-3 text-base',
};
</script>

<template>
    <component
        :is="href ? 'a' : 'button'"
        :href="href"
        :type="href ? undefined : type"
        :disabled="disabled || loading"
        :class="[
            'btn',
            classes[variant],
            sizes[size],
            { 'opacity-50 cursor-not-allowed': disabled || loading },
        ]"
    >
        <!-- Loading spinner -->
        <svg
            v-if="loading"
            class="animate-spin -ml-1 mr-2 h-4 w-4"
            fill="none"
            viewBox="0 0 24 24"
        >
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
        </svg>
        <slot />
    </component>
</template>
