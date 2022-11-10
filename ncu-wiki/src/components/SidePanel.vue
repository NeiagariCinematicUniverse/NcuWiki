<template>
    <v-card
        id="sidePanel"
        elevation="2"
        outlined
        tag="aside"
    >
        <v-card-title>{{ title }}</v-card-title>
        <v-card-text>
            <div id="sidePanelContent">
                <!-- Empty 'cause filled dynamically -->
            </div>
        </v-card-text>
    </v-card>
</template>

<script>
import { Remarkable } from 'remarkable';
const md = new Remarkable();

export default {
    props: {
        url: String,
    },


    data: () => ({
        sidePanel: null,
        title: String,
    }),

    methods: {
        loadSidePanel: async function () {
            let sidePanelMd = await import("raw-loader!@/assets/side_panels/" + this.url + ".md")
                .catch(err => {
                console.log(err +
                    "\nAborted loading side panel");
                document.getElementById("sidePanel").remove();
                document.getElementById("content").removeAttribute("class");
            });
            if (!sidePanelMd) return;
            
            this.sidePanel = md.render(sidePanelMd.default);
            this.title = this.url.replace("_", " ");

            document.getElementById("sidePanelContent").innerHTML = this.sidePanel;
        }
    },
    mounted: function () {
        this.loadSidePanel();
    },
}
</script>

<style lang="sass">
    #sidePanel
        width: 300px
        float: right
        margin-right: 42px

</style>