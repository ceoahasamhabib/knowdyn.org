<script setup>
defineProps({
    variant: {
        type: String,
        default: 'primary',
        validator: v => ['primary', 'success', 'warning', 'danger', 'info', 'oa'].includes(v),
    },
    size: {
        type: String,
        default: 'md',
        validator: v => ['sm', 'md'].includes(v),
    },
});

const variants = {
    primary: 'bg-navy-50 text-navy-700',
    success: 'bg-emerald-50 text-emerald-700',
    warning: 'bg-amber-50 text-amber-700',
    danger: 'bg-red-50 text-red-700',
    info: 'bg-sky-50 text-sky-700',
    oa: 'bg-amber-100 text-amber-800 font-semibold',
};

const sizes = {
    sm: 'px-2 py-0.5 text-xs',
    md: 'px-2.5 py-0.5 text-xs',
};
</script>

<template>
    <span
        :class="[
            'inline-flex items-center font-medium rounded-sm',
            variants[variant],
            sizes[size],
        ]"
    >
        <slot />
    </span>
</template>
