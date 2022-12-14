<template>
    <div>
        <h1>Index</h1>
        <h2 v-if="search">Résultats pour la recherche {{ search }} :</h2>
        <p>Cette page répertorie les différents articles de ce Wiki.</p>
        <ul>
            <li v-for="page in filteredPages" :key="page.name">
                <a :href="page.url">{{ page.name }}</a>
            </li>
        </ul>
        <p v-if="filteredPages.length == 0">Aucun résultat ne correspond à votre recherche...</p>
        <p id="ytf isn't the list showing w\ this???" style="visibility: hidden; height: 15px;">{{ pages }}</p>
    </div>
</template>

<script>
export default {
    props: {
        search: String,
    },
    data: () => ({
        pages: [],
        filteredPages: [],
    }),
    methods: {
        loadPages: async function() {
            let api = "http://127.0.0.1:3000/api/"; //https://176.31.151.46:3000/api/
            this.pages = await (await fetch(api + "list")).json();
            // [
            //     {
            //         name: "Jaako",
            //         url: "?Jaako"
            //     },
            //     {
            //         name: "Natat",
            //         url: "?Natat"
            //     },
            // ];

            if (this.search) {
                let regexString = ".*" + this.search.toLowerCase() + ".*";
                let regex = new RegExp(regexString);
                let index = 0;

                for (let i = 0; i < this.pages.length; i++) {
                    if (this.pages[i].name.toLowerCase().match(regex)) {
                        this.filteredPages[index] = this.pages[i];
                        index++;
                    }
                }
            } else {
                this.filteredPages = this.pages;
            }
        }
    },
    beforeMount: async function() {
        await this.loadPages();
        if (!document.title.startsWith("Index")) {
            document.title = "Index - " + document.title;
        }
    }
}
</script>