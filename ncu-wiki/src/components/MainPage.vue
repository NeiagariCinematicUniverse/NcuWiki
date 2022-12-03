<template>
    <v-card
        id="mainPage"
        align="left"
    >
        <IndexPage id="index" v-if="this.isIndex" :search="this.search"></IndexPage>
        <HomePage id="home" v-if="this.isHome"></HomePage>
        <h1 id="pageTitle" v-if="(!this.isIndex && !this.isHome)">{{ title }}</h1>
        <SidePanel :url="this.url" v-if="!this.isIndex"></SidePanel>
        <div id="content" v-if="!this.isIndex"></div>

        <!-- v-container id="pageContent">
            <v-row id="title">
                <h1>{{ title }}</h1>
            </v-row>
            <v-row>
                <v-col align="left" id="content"
                    cols="20"
                    md="10">
                    <Content added dynamically>
                    {{ content }}
                </v-col>

                <v-col align="left" id="sidePanel"
                    cols="2"
                    md="2">
                    <SidePanel :url="this.url"></SidePanel>
                </v-col>
            </v-row>
        </v-container -->

        <ContentsTable id="contentsTable" v-if="this.hasHeaders && !this.isIndex" :contents="this.contents"></ContentsTable>
    </v-card>
</template>

<script>
import { Remarkable } from 'remarkable';
import SidePanel from './SidePanel.vue';
import ContentsTable from './ContentsTable.vue';
import IndexPage from './IndexPage.vue';
import HomePage from './HomePage.vue';
const md = new Remarkable();

export default {
    props: {
        url: String,
        search: String,
    },
    data: () => ({
        content: null,
        title: String,
        contents: [],
        hasHeaders: false,
        isIndex: false,
        isHome: false,
    }),
    methods: {
        loadContent: async function () {
            console.log(this.$route);
            
            this.isIndex = (this.url === "index");
            if (this.isIndex) return;

            let requestResult = await fetch("https://176.31.151.46:3000/api/page/" + this.url);
            if (requestResult.status != 200) {
                console.log("Code " + requestResult.status +
                    "\nLoaded home instead");
                this.isHome = true;
                return;
            }
            let page = (await requestResult.json()).markdown;

            this.content = md.render(page);
            this.title = this.url.replace("_", " ");
            document.getElementById("content").innerHTML = this.content;
            document.title = this.title + " - " + document.title;
        },

        identifyHeaders: function() {
            let children = document.getElementById("content").children;
            let h2Counter = 0;
            let h3Counter = 0;
            let h4Counter = 0;
            let h5Counter = 0;
            let h6Counter = 0;
            let child;

            for (let i = 0; i < children.length; i++) {
                switch (children[i].tagName.toLocaleLowerCase()) {
                    case "h6":
                        h6Counter++;

                        children[i].id = h2Counter + "." + h3Counter + "." + h4Counter + "." + h5Counter + "." + h6Counter;

                        child = {
                            index: children[i].id,
                            level: 5,
                            label: children[i].id + " - " + children[i].innerText,
                        }
                        this.contents.push(child);
                        break;

                    case "h5":
                        h5Counter ++;

                        h6Counter = 0;
                        children[i].id = h2Counter + "." + h3Counter + "." + h4Counter + "." + h5Counter;

                        child = {
                            index: children[i].id,
                            level: 4,
                            label: children[i].id + " - " + children[i].innerText,
                        }
                        this.contents.push(child);
                        break;

                    case "h4":
                        h4Counter++;

                        h6Counter = 0;
                        h5Counter = 0;
                        children[i].id = h2Counter + "." + h3Counter + "." + h4Counter;

                        child = {
                            index: children[i].id,
                            level: 3,
                            label: children[i].id + " - " + children[i].innerText,
                        }
                        this.contents.push(child);
                        break;

                    case "h3":
                        h3Counter++;

                        h6Counter = 0;
                        h5Counter = 0;
                        h4Counter = 0;
                        children[i].id = h2Counter + "." + h3Counter;

                        child = {
                            index: children[i].id,
                            level: 2,
                            label: children[i].id + " - " + children[i].innerText,
                        }
                        this.contents.push(child);
                        break;

                    case "h2":
                        h2Counter++;

                        h6Counter = 0;
                        h5Counter = 0;
                        h4Counter = 0;
                        h3Counter = 0;
                        children[i].id = h2Counter;

                        child = {
                            index: children[i].id,
                            level: 1,
                            label: children[i].id + " - " + children[i].innerText,
                        }
                        this.contents.push(child);
                        break;
                
                    default:
                        break;
                }
            }
        },

        addSpoilers: function(spoilerTag) {
            let children = document.getElementById("content").children;

            for (let i = 0; i < children.length; i++) {
                if (children[i].tagName.toLocaleLowerCase() === "blockquote" &&
                    children[i].innerText.startsWith(spoilerTag)) {
                    
                    let spoiler = document.createElement("details");
                    let summary = document.createElement("summary");

                    summary.innerText = "Cette section contient du spoil. Cliquez à vos risques et périls.";
                    spoiler.innerHTML = children[i].innerHTML;
                    spoiler.innerText = spoiler.innerText.substring(2);
                    spoiler.insertBefore(summary, spoiler.firstChild);

                    children[i].parentNode.replaceChild(spoiler, children[i]);
                }
            }
        }
    },

    beforeMount: async function () {
        await this.loadContent();
        if (!this.isIndex) {
            this.identifyHeaders();
            this.hasHeaders = (this.contents.length > 0);
            this.addSpoilers("!");
            
        }
    },

    components: { SidePanel, ContentsTable, IndexPage, HomePage, }
}
</script>

<style lang="sass">
    #content
        padding-left: 42px
        padding-right: 42px
        padding-bottom: 30px

    #pageTitle
        padding-left: 30px
        padding-bottom: 18px
        padding-top: 18px

    #index
        padding-left: 30px
        padding-bottom: 18px
        padding-top: 18px

    #home
        padding-left: 30px
        padding-bottom: 18px
        padding-top: 18px
</style>