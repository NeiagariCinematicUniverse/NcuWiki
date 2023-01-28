<template>
    <div>
        <h1 id="embeddedPageTitle">{{ realTitle }}</h1>
        <div id="embeddedContent"></div>
    </div>
</template>

<script>
import { Remarkable } from 'remarkable';
const md = new Remarkable();

export default {
    props: {
        title: String,
        mdContent: String,
        mdPanel: String,
    },
    data: () => ({
        realTitle: "",
        content: null,
        contents: [],
        hasHeaders: false,
        isIndex: false,
        isHome: false,
        isEdit: false,
    }),
    methods: {
        loadContent: function () {
            this.content = md.render(this.mdContent);

            this.realTitle = this.title.replace("_", " ");
            document.getElementById("embeddedContent").innerHTML = this.content;
        },

        addSpoilers: function(spoilerTag) {
            let children = document.getElementById("embeddedContent").children;

            for (let i = 0; i < children.length; i++) {
                if (children[i].tagName.toLocaleLowerCase() === "blockquote" &&
                    children[i].innerText.startsWith(spoilerTag)) {
                    
                    let spoiler = document.createElement("details");
                    let summary = document.createElement("summary");

                    summary.innerText = process.env.VUE_APP_SPOILER_WARNING;
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

        renderAgain: function(title, mdContent) {
            this.content = md.render(mdContent);

            this.realTitle = title.replace(new RegExp(/_/, 'g'), " ");
            document.getElementById("embeddedPageTitle").innerText = this.realTitle;
            document.getElementById("embeddedContent").innerHTML = this.content;

            this.addSpoilers(process.env.VUE_APP_SPOILER_TAG);
            this.createHints(document.getElementById("embeddedContent"));
        }
    },

    mounted: function () {
        this.loadContent();
        this.addSpoilers(process.env.VUE_APP_SPOILER_TAG);
    },
}
</script>