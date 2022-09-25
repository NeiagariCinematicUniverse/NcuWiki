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

        <ContentsTable id="contentsTable"></ContentsTable>
    </div>
</template>

<script>
import { Remarkable } from 'remarkable';
import SidePanel from './SidePanel.vue';
import ContentsTable from './ContentsTable.vue';
const md = new Remarkable();

export default {
    props: {
        url: String,
    },
    data: () => ({
        content: null,
        title: String,
        contents: [],
    }),
    methods: {
        loadIndex: async function () {
            let page = await import("raw-loader!@/assets/main_pages/home.md");
            this.content = await md.render(page.default);
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
            if (!page) return;

            this.content = md.render(page.default);
            this.title = this.url.replace("_", " ");
            document.getElementById("content").innerHTML = this.content;
        },

        identifyHeaders: function() {
            let children = document.getElementById("content").children;
            let h2Counter = 0;
            let h3Counter = 0;
            let h4Counter = 0;
            let h5Counter = 0;
            let h6Counter = 0;

            for (let i = 0; i < children.length; i++) {
                switch (children[i].tagName.toLocaleLowerCase()) {
                    case "h6":
                        h6Counter++;

                        children[i].id = h2Counter + "." + h3Counter + "." + h4Counter + "." + h5Counter + "." + h6Counter;

                        this.contents.push(children[i].id);
                        break;

                    case "h5":
                        h5Counter ++;

                        h6Counter = 0;
                        children[i].id = h2Counter + "." + h3Counter + "." + h4Counter + "." + h5Counter;

                        this.contents.push(children[i].id);
                        break;

                    case "h4":
                        h4Counter++;

                        h6Counter = 0;
                        h5Counter = 0;
                        children[i].id = h2Counter + "." + h3Counter + "." + h4Counter;

                        this.contents.push(children[i].id);
                        break;

                    case "h3":
                        h3Counter++;

                        h6Counter = 0;
                        h5Counter = 0;
                        h4Counter = 0;
                        children[i].id = h2Counter + "." + h3Counter;

                        this.contents.push(children[i].id);
                        break;

                    case "h2":
                        h2Counter++;

                        h6Counter = 0;
                        h5Counter = 0;
                        h4Counter = 0;
                        h3Counter = 0;
                        children[i].id = h2Counter;

                        this.contents.push(children[i].id);
                        break;
                
                    default:
                        break;
                }
            }
        },

        generateContents: function() {
            console.log(this.contents);
            if (this.contents.length == 0) {
                document.getElementById("contentsTable").remove();
                return;
            }

            let firstHeader = document.getElementById(this.contents[0]);
            let contentsTable = document.getElementById("contentsTable");
            
            document.getElementById("content").insertBefore(contentsTable, firstHeader);
            
            //Now, on to the insertion of our contents in the contents list.
            let contentsListRoot = document.getElementById("contentsListRoot");
            let previousLevel = 1;
            let level;

            let html = "";
            
            for (let i = 0; i < this.contents.length; i++) {
                level = this.contents[i].split(".").length;

                while (level - previousLevel > 0) {
                    //console.log(i, level, previousLevel);
                    //We add a level:
                    html += "<ul class=\"contentsList\">";
                    previousLevel++;
                }

                while (level - previousLevel < 0) {
                    //console.log(i, level, previousLevel);
                    //We need to close a level:
                    html += "</ul>";
                    previousLevel--;
                }

                html += `
                    <li>
                        <a href="#` + this.contents[i] + `" class="contentsListElem v-btn v-btn--block v-btn--text theme--light v-size--default">
                            <span class="v-btn__content"> ` + this.contents[i] + `.  ` + document.getElementById(this.contents[i]).innerText +` </span>
                        </a>
                    </li>
                `;

                previousLevel = level;
            }

            contentsListRoot.innerHTML = html;
        }
    },
    mounted: async function () {
        await this.loadContent();
        this.identifyHeaders();
        this.generateContents();
    },
    components: { SidePanel, ContentsTable }
}
</script>