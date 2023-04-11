<template>
    <v-card
        id="sidePanel"
        elevation="2"
        outlined
        tag="aside"
    >
        <v-card-title id="SidePanelTitle">{{ title }}</v-card-title>
        <v-tabs center-active centered show-arrows v-model="currentTab">
            <v-tab v-for="pic in this.pics" :key="pic.name">{{ pic.name }}</v-tab>
        </v-tabs>
        <v-tabs-items v-model="currentTab">
            <v-tab-item
                v-for="pic in this.pics"
                :key="pic.name"
            >
                <v-card flat>
                    <v-card-text>
                        <v-img :src="pic.src">
                            <template v-slot:placeholder>
                                <v-row
                                    class="fill-height ma-0"
                                    align="center"
                                    justify="center"
                                >
                                    <v-progress-circular
                                        indeterminate
                                        color="grey lighten-5"
                                    ></v-progress-circular>
                                </v-row>
                            </template>
                        </v-img>
                    </v-card-text>
                </v-card>
            </v-tab-item>
        </v-tabs-items>
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
        currentTab: null,
        pics: [],
    }),

    methods: {
        loadSidePanel: async function () {
            let api = process.env.VUE_APP_API;
            let requestResult = await fetch(api + "side/" + this.url);
            if (requestResult.status != 200) {
                console.log("Code " + requestResult.status +
                    "\nAborted loading side panel");
                document.getElementById("sidePanel").remove();
                document.getElementById("content").removeAttribute("class");
                return;
            }

            let sidePanelMd = (await requestResult.json()).markdown;

            let mdPics = sidePanelMd.split(process.env.VUE_APP_IMAGES_SEPARATOR)[0];
            this.loadTabs(mdPics);
            
            this.sidePanel = md.render(sidePanelMd);
            this.title = decodeURIComponent(this.url).replace(new RegExp(/_/, 'g'), " ");

            document.getElementById("sidePanelContent").innerHTML = this.sidePanel;
        },
        loadTabs: function(mdPics) {
            let mdPicsList = mdPics.split("\n");
            
            for(let i = 0; i < mdPicsList.length - 1; i++) {
                let begName = mdPicsList[i].search("\\[") + 1;
                let endName = mdPicsList[i].search("\\]") - 1;
                let begSrc  = endName + 3;

                //Trying to find the first letter of the link to the image.
                let j = 0;
                while (j < mdPicsList[i].length && mdPicsList[i].at(begSrc + j) !== "h") {
                    j++;
                }
                begSrc = begSrc + j;

                let picName = mdPicsList[i].substr(begName, endName);
                let picSrc  = mdPicsList[i].substr(begSrc);

                //Verifying that we found the picture source:
                if (!picSrc.startsWith("h")) {
                    console.log("Picture link not found... Replaced by the default picture.");
                    picSrc = process.env.VUE_APP_IMAGE_NOT_FOUND;
                }

                this.pics[i] = {
                    name: picName,
                    src: picSrc,
                };
            }
        }
    },
    beforeMount: function () {
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