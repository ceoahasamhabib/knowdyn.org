<script setup>
defineProps({
    hover: {
        type: Boolean,
        default: false,
    },
    padding: {
        type: String,
        default: 'normal',
        validator: v => ['none', 'tight', 'normal', 'wide'].includes(v),
    },
});

const paddings = {
    none: '',
    tight: 'p-3 md:p-4',
    normal: 'p-5 md:p-6',
    wide: 'p-6 md:p-8',
};
</script>

<template>
    <div
        :class="[
            'bg-white rounded-card border border-gray-100 shadow-card transition-shadow duration-200',
            hover ? 'hover:shadow-card-hover cursor-pointer' : '',
            paddings[padding],
        ]"
    >
        <slot />
    </div>
</template>
