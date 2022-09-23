<template>
    <div 
        id="mainPage"
        align="left"
    >
        <v-container id="pageContent">
            <v-row id="title">
                <h1>{{ title }}</h1>
            </v-row>
            <v-row>
                <v-col align="left" id="content"
                    cols="20"
                    md="10">
                    <!-- Content added dynamically-->
                    {{ content }}
                </v-col>

                <v-col align="left" id="sidePanel"
                    cols="2"
                    md="2">
                    <SidePanel :url="this.url"></SidePanel>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script>
import { Remarkable } from 'remarkable';
import SidePanel from './SidePanel.vue';
const md = new Remarkable();

export default {
    props: {
        url: String,
    },
    data: () => ({
        content: null,
        title: String,
    }),
    methods: {
        loadIndex: async function () {
            let page = await import("raw-loader!@/assets/main_pages/home.md");
            this.content = md.render(page.default);
            this.title = "Bienvenue sur le wiki du Neiagari Cinematic Universe !";

            document.getElementById("content").innerHTML = this.content;
        },

        loadContent: async function () {
            let page = await import("raw-loader!@/assets/main_pages/" + this.url + ".md")
                .catch(err => {
                console.log(err +
                    "\nLoaded home instead");
                this.loadIndex();
            });
            this.content = md.render(page.default);
            this.title = this.url.replace("_", " ");
            document.getElementById("content").innerHTML = this.content;
        },

        generateContents: function() {
            //document.getElementById("content").appendChild(SidePanel);
        }
    },
    mounted: function () {
        this.loadContent();
        this.generateContents();
    },
    components: { SidePanel }
}
</script>