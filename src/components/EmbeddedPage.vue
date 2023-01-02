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

                    summary.innerText = "Cette section contient du spoil. Cliquez à vos risques et périls.";
                    spoiler.innerHTML = children[i].innerHTML;
                    spoiler.innerText = spoiler.innerText.substring(2);
                    spoiler.insertBefore(summary, spoiler.firstChild);

                    children[i].parentNode.replaceChild(spoiler, children[i]);
                }
            }
        },

        renderAgain: function(title, mdContent) {
            this.content = md.render(mdContent);

            this.realTitle = title.replace(new RegExp(/_/, 'g'), " ");
            document.getElementById("embeddedPageTitle").innerText = this.realTitle;
            document.getElementById("embeddedContent").innerHTML = this.content;

            this.addSpoilers("!");
        }
    },

    mounted: function () {
        this.loadContent();
        this.addSpoilers("!");
    },
}
</script>