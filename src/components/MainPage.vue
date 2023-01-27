<template>
    <v-card
        id="mainPage"
        align="left"
    >
        <v-fab-transition v-if="adminMode">
            <v-btn
                id="editButton"
                v-show="(!this.isIndex && !this.isHome && !this.isEdit && !this.isEaster)"
                :href="'?edit&' + url"
                color="grey lighten-1"
                fab
                dark
                small
                absolute
                top
                right
            >
                <v-icon dark>mdi-pencil-outline</v-icon>
            </v-btn>
        </v-fab-transition>
        <v-fab-transition v-if="adminMode">
            <v-btn
                v-show="(!this.isIndex && !this.isHome && !this.isEdit && !this.isEaster)"
                color="red lighten-2"
                fab
                dark
                small
                absolute
                top
                right
                @click="deletePage"
            >
                <v-icon dark>mdi-delete</v-icon>
            </v-btn>
        </v-fab-transition>
        <IndexPage id="index" v-if="this.isIndex" 
            :search="this.search" 
            :admin-mode="this.adminMode"
            :delete="this.delete"
            :to-del="this.toDel"
        ></IndexPage>
        <HomePage id="home" v-if="this.isHome"></HomePage>
        <EditPage id="edit" v-if="this.isEdit" :url="this.url"></EditPage>
        <EasterEgg id="sudoku" v-if="this.isEaster"></EasterEgg>
        <h1 id="pageTitle" v-if="(!this.isIndex && !this.isHome && !this.isEdit &&!this.isEaster)">{{ title }}</h1>
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

        <ContentsTable id="contentsTable" v-if="this.hasHeaders && !this.isIndex && !this.isEaster" :contents="this.contents"></ContentsTable>
    </v-card>
</template>

<script>
import { Remarkable } from 'remarkable';
import SidePanel from './SidePanel.vue';
import ContentsTable from './ContentsTable.vue';
import IndexPage from './IndexPage.vue';
import HomePage from './HomePage.vue';
import EditPage from './EditPage.vue';
import EasterEgg from './EasterEgg.vue';
const md = new Remarkable();

export default {
    props: {
        url: String,
        search: String,
        adminMode: Boolean,
    },
    data: () => ({
        content: null,
        title: String,
        contents: [],
        hasHeaders: false,
        isIndex: false,
        isHome: false,
        isEdit: false,
        isEaster: false,
        delete: false,
        toDel: "",
    }),
    methods: {
        loadContent: async function () {
            let api = process.env.VUE_APP_API;
            
            this.isIndex = (this.url === "index");
            if (this.isIndex) return;

            this.isEdit = (this.url.startsWith("edit"));
            if (this.isEdit) return;

            this.isEaster = (this.url === "sudoku");
            if (this.isEaster) return;

            let requestResult = await fetch(api + "page/" + this.url);
            if (requestResult.status != 200) {
                console.log("Code " + requestResult.status +
                    "\nLoaded home instead");
                this.isHome = true;
                return;
            }
            let page = (await requestResult.json()).markdown;

            this.content = md.render(page);
            this.title = decodeURIComponent(this.url).replace(new RegExp(/_/, 'g'), " ");
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
                    spoiler.innerHTML = spoiler.innerHTML.replace("<p>! ", "<p>");
                    this.createHints(spoiler);
                    spoiler.insertBefore(summary, spoiler.firstChild);

                    children[i].parentNode.replaceChild(spoiler, children[i]);
                }
            }
        },

        createHints: function(htmlElement) {
            let children = htmlElement.children;

            for (let i = 0; i < children.length; i++) {
                if (children[i].tagName.toLocaleLowerCase() === "p" &&
                    children[i].innerHTML.startsWith("<img")) {

                    let hint = document.createElement("p");
                    hint.className = "hint";
                    hint.innerText = children[i].firstChild.getAttribute("alt");

                    if (hint.innerHTML !== "") {
                        htmlElement.insertBefore(hint, htmlElement.children[i + 1]);
                    }
                }
            }
        },

        deletePage: function() {
            this.delete = true;
            this.toDel = this.url;
            let childrenAmt = document.getElementById("content").children.length;
            for (let i = 0; i < childrenAmt; i++) {
                document.getElementById("content").firstChild.remove();
            }
            this.isIndex = true;
        }
    },

    beforeMount: async function () {
        await this.loadContent();
        if (!this.isIndex) {
            this.identifyHeaders();
            this.hasHeaders = (this.contents.length > 0);
            this.addSpoilers("!");
            this.createHints(document.getElementById("content"));
        }
    },

    components: { SidePanel, ContentsTable, IndexPage, HomePage, EditPage, EasterEgg }
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

    #edit
        padding-left: 30px
        padding-bottom: 18px
        padding-top: 18px
        padding-right: 30px

    #editButton
        margin-right: 45px
    
    #sudoku
        padding-left: 30px
        padding-top: 18px
        padding-right: 30px
</style>