<template>
    <v-card
        id="mainPage"
        align="left"
    >
        <h1 id="pageTitle">{{ title }}</h1>
        <SidePanel :url="this.url"></SidePanel>
        <div id="content">
            {{ content }}
        </div>

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

        <ContentsTable id="contentsTable" v-if="this.hasHeaders" :contents="this.contents"></ContentsTable>
    </v-card>
</template>

<script>
import { Remarkable } from 'remarkable';
import SidePanel from './SidePanel.vue';
import ContentsTable from './ContentsTable.vue';
// import { h } from 'vue';
// import { render } from '@vue/runtime-dom';
const md = new Remarkable();

export default {
    props: {
        url: String,
    },
    data: () => ({
        content: null,
        title: String,
        contents: [],
        hasHeaders: false,
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

        // generateContents: function() {
        //     if (this.contents.length == 0) {
        //         document.getElementById("contentsTable").remove();
        //         return;
        //     }

        //     let firstHeader = document.getElementById(this.contents[0]);
        //     let contentsTable = document.getElementById("contentsTable");
            
        //     document.getElementById("content").insertBefore(contentsTable, firstHeader);
            
        //     Now, on to the insertion of our contents in the contents list.
        //     let contentsListRoot = document.getElementById("contentsListRoot");
        //     let previousLevel = 1;
        //     let level;

        //     let html = "";
            
        //     for (let i = 0; i < this.contents.length; i++) {
        //         level = this.contents[i].split(".").length;

        //         while (level - previousLevel > 0) {
        //             We add a level:
        //             html += "<ul class=\"contentsList\">";
        //             previousLevel++;
        //         }

        //         while (level - previousLevel < 0) {
        //             We need to close a level:
        //             html += "</ul>";
        //             previousLevel--;
        //         }

        //         html += `
        //             <li>
        //                 <v-btn
        //                     class="contentsListElem"
        //                     text
        //                     block
        //                     href="#` + this.contents[i] + `"
        //                 >
        //                     ` + this.contents[i] + `.  ` + document.getElementById(this.contents[i]).innerText + `
        //                 </v-btn>
        //             </li>
        //         `;

        //         previousLevel = level;
        //     }

        //     this.renderedContents += 1;

        //     this.renderedContents = createElementVNode('i', {
        //         domProps: {
        //             innerHTML: html
        //         }
        //     })

        //     contentsListRoot.append(elem);
            
        // },

        // generateContentsAlt: function() {
        //     if (this.contents.length == 0) {
        //         document.getElementById("contentsTable").remove();
        //         return;
        //     }

        //     //let firstHeader = document.getElementById(this.contents[0]);

        //     //Now, on to the insertion of our contents in the contents list.
        //     let previousLevel = 0;
        //     let level;
            
        //     let nodes = [
        //         [], //level 1
        //         [], //level 2
        //         [], //level 3
        //         [], //level 4
        //         [], //level 5
        //     ];
            
        //     /*
        //     * To generate the links of the contents table, we are going to iterate on it in reverse.
        //      *
        //      * On each iteration, we'll compare the level of the line to the one of the previous line.
        //      * Considering this, we have three possible cases:
        //      * 1. The level is the same as the previous one. In this case, we'll simply create the
        //      *    node corresponding using the h function and store it in the node list of that level.
        //      * 2. The level is higher than the previous one. In this case, we'll create the node
        //      *    corresponding, just as for the previous case, and we'll add it to the list of nodes
        //      *    of that level.
        //      * 3. The level is lower than the previous one. In this case, for every level between the
        //      *    current and the previous one, we will add a HTML list, so that everything is
        //      *    displayed at the right height. Once that done, we'll create the current node taking
        //      *    all nodes of a higher level and add it to the list of the right level.
        //      */
        //     for (let i = this.contents.length - 1; i >= 0; i--) {
        //         level = this.contents[i].split(".").length - 1;

        //         //case 1&2:
        //         if (level >= previousLevel) {
        //             let text = this.contents[i] + ".  " + document.getElementById(this.contents[i]).innerText;
        //             let link = "#"+this.contents[i];
        //             let node = h(ContentsTableElementVue, { link: link, text: text });

        //             nodes[level].push(node);
        //         }
                
        //         //case 3:
        //         else {
        //             let diff = previousLevel - level;

        //             while (diff > 0) {
        //                 nodes[diff + level - 1].push(h('ul', { class: 'contentsList' }, nodes[diff + level]));
        //                 nodes[diff + level] = [];
        //                 diff--;
        //             }

        //             nodes[level].push(h(ContentsTableElementVue, { link: this.contens[i], text: this.contents[i] + ".  " + document.getElementById(this.contents[i]).innerText }, nodes[level + 1]));
        //         }
        //     }
            
        //     console.log(nodes);
        //     return nodes;
        //}
    },
    // render() {
    //     return this.generateContentsAlt();
    // },
    beforeMount: async function () {
        await this.loadContent();
        this.identifyHeaders();
        this.hasHeaders = (this.contents.length > 0);
        //this.generateContents();
        //render();
    },

    components: { SidePanel, ContentsTable }
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
</style>