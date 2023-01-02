<template>
    <v-btn
        class="contentsListElem"
        text
        block
        :href="link"
    >
        {{ text }}
    </v-btn>
</template>

<script>
    export default {
        props: {
            link: String,
            text: String
        }
    }
</script>