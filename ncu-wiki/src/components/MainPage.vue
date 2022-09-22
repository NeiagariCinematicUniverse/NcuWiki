<template>
    <div 
        id="mainPage"
        align="left"
    >
        <div
            id="content"
        >
            {{ content }}
        </div>
    </div>
</template>

<script>
import { Remarkable } from 'remarkable';

export default {
    props: {
        url: String,
    },

    data: () => ({
        content: null,
    }),

    methods: {
        loadIndex: async function() {
            const md = new Remarkable();
            let page = await import("raw-loader!@/assets/main_pages/index.md");

            this.content = md.render(page.default);
        },

        loadContent: async function() {
            const md = new Remarkable();
            let page = await import("raw-loader!@/assets/main_pages/" + this.url + ".md")
                .catch(err => {
                    console.log(err + 
                        "\nLoaded index instead");
                    this.loadIndex();
                }
            );

            this.content = md.render(page.default);
        }
    },

    mounted: function() {
        this.loadContent();
    }
}
</script>