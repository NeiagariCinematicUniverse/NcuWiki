<template>
    <v-card
        id="embeddedPanel"
        elevation="2"
        outlined
    >
        <v-card-title id="embeddedPanelTitle">{{ realTitle }}</v-card-title>
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
            <div id="embeddedPanelContent">
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
        title: String,
        mdContent: String,
    },


    data: () => ({
        realTitle: String,
        embeddedPanel: null,
        currentTab: null,
        pics: [],
    }),

    methods: {
        loadembeddedPanel: async function () {
            let mdPics = this.mdContent.split("[FEUILLE_VOLANTE]: FinDesPhotos")[0];
            this.loadTabs(mdPics);
            
            this.embeddedPanel = md.render(this.mdContent);
            this.realTitle = this.title.replace(new RegExp(/_/, 'g'), " ");

            document.getElementById("embeddedPanelContent").innerHTML = this.embeddedPanel;
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
                    picSrc = "https://cdn.discordapp.com/attachments/485070483260440581/1046015931865911377/unknown.png";
                }

                this.pics[i] = {
                    name: picName,
                    src: picSrc,
                };
            }
        },

        renderAgain: function(title, mdContent) {
            this.realTitle = title.replace(new RegExp(/_/, 'g'), " ");
            let mdPics = mdContent.split("[FEUILLE_VOLANTE]: FinDesPhotos")[0];
            this.pics = [];
            this.currentTab = null;
            this.loadTabs(mdPics);
            
            this.embeddedPanel = md.render(mdContent);

            document.getElementById("embeddedPanelTitle").innerText = this.realTitle;
            document.getElementById("embeddedPanelContent").innerHTML = this.embeddedPanel;
        },
    },
    mounted: function () {
        this.loadembeddedPanel();
    },
}
</script>

<style lang="sass">
    #embeddedPanel
        max-width: 300px
</style>