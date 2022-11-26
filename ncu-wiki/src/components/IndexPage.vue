<template>
    <div>
        <h1>Index</h1>
        <h2 v-if="this.search">Résultats pour la recherche {{ search }} :</h2>
        <p>Cette page répertorie les différents articles de ce Wiki.</p>
        <ul>
            <li v-for="page in this.filteredPages" :key="page.name">
                <a :href="page.url">{{ page.name }}</a>
            </li>
        </ul>
        <p v-if="this.filteredPages.length == 0">Aucun résultat ne correspond à votre recherche...</p>
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
        loadPages: function() {
            this.pages = [
                {
                    name: "Jaako",
                    url: "/Jaako"
                },
            ];

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
    beforeMount: function() {
        this.loadPages();
        if (!document.title.startsWith("Index")) {
            document.title = "Index - " + document.title;
        }
    }
}
</script>