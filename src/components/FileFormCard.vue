<template>
    <v-card outlined align="left">
        <v-card-title>{{ cardTitle }}</v-card-title>
        <v-card-text id="ffc-text">
            <p>
                Si vous voulez ajouter un fichier que vous avez édité ailleurs, vous pouver le
                mettre dans ici.<br/>
                <b>Attention</b>, vous perdrez les modifications que vous avez apportées dans les
                zones d'éditions car elles vont être effacées !
            </p>
            <v-file-input
                label="File input"
                color="purple darken-2"
                outlined
                dense
                accept="text/markdown"
                @change="addedFile"
            ></v-file-input>
        </v-card-text>
    </v-card>
</template>

<script>
    export default {
        data: () => ({
            cardTitle: "",
        }),

        props: {
            file: String,
        },

        methods: {
            addedFile: async function(e) {
                if (e == null || e.type !== "text/markdown") {
                    this.$emit('addedFile', "");
                    return;
                }

                let name = e.name.substr(0, e.name.length - 3);
                let content = await e.text();
                this.$emit('addedFile', name, content);
            }
        },

        beforeMount: function() {
            switch (this.file) {
                case "mainPage":
                    this.cardTitle = "Fiche";
                    break;

                case "sidePanel":
                    this.cardTitle = "Panneau de droite";
                    break;
            }
        }
    }
</script>

<style lang="sass">
    #ffc-text
        padding-left: 15px
        padding-right: 15px
</style>