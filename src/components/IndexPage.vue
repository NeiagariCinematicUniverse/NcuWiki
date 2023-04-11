<template>
    <v-card elevation="0">
        <h1>Index</h1>
        <h2 v-if="search">Résultats pour la recherche {{ search }} :</h2>
        <p>Cette page répertorie les différents articles de ce Wiki.</p>
        <v-btn
            v-if="adminMode"
            dark
            color="purple lighten-1"
            block
            elevation="2"
            href="?edit"
            class="mb-4"
        >
            Créer une nouvelle fiche
        </v-btn>
        <v-dialog v-model="dialog" @click:outside="cleanUp">
            <template v-slot:activator="{ attrs, on }">
                <v-list subheader id="indexList">
                    <v-list-item
                        v-for="page in filteredPages"
                        :key="page.name"
                        :href="page.url"
                    >
                        <v-list-item-content>
                            <v-list-item-title v-text="page.name"></v-list-item-title>
                        </v-list-item-content>

                        <v-list-item-action>
                            <v-btn icon @click="downloadPage(page)" href="#">
                                <v-icon color="grey lighten-1">mdi-download</v-icon>
                            </v-btn>
                        </v-list-item-action>
                        
                        <v-list-item-action>
                            <v-btn icon :href="'?edit&' + page.url.substr(1)">
                                <v-icon color="grey lighten-1">mdi-pencil-outline</v-icon>
                            </v-btn>
                        </v-list-item-action>
                        <v-list-item-action v-if="adminMode">
                            <v-btn 
                                icon
                                href="#"
                                v-bind="attrs"
                                v-on="on"
                                @click="selectedPage = page"
                            >
                                <v-icon
                                    color="red lighten-2"
                                >mdi-delete</v-icon>
                            </v-btn>
                        </v-list-item-action>
                    </v-list-item>
                </v-list>
            </template>
            <v-card
                :loading="loading"
            >
                <v-card-title>
                    <span class="text-h5">Vérification d'identité</span>
                </v-card-title>
                <v-window v-model="step">
                    <v-window-item :value="1">
                        <v-card-text id="infoText">
                            <v-alert
                                dense
                                text
                                type="error"
                                v-if="error"
                            >
                                La clé transmise est <strong>invalide !</strong>
                            </v-alert>
                            <p class="infoParaph">
                                Afin de s'assurer que le contenu du site soit contrôlé, vous devez entrer ci-dessous la clé de validation.<br/>
                                Il s'agit d'une chaîne de 256 caractères répartis sur 4 lignes (64 caractères par ligne) générée aléatoirement.
                            </p>
                            <div id="textContainer" align="center">
                                <v-textarea
                                    outlined
                                    no-resize
                                    class="Auth"
                                    v-model="form.validationString"
                                    color="purple darken-2"
                                    name="input-7-4"
                                    label="Clé d'authentification"
                                    required
                                ></v-textarea>
                            </div>
                        </v-card-text>
                        <v-card-actions>
                            <v-btn
                                color="red darken-1"
                                text
                                @click="dialog = false; cleanUp();"
                            >
                                Retour
                            </v-btn>
                            <v-spacer></v-spacer>
                            <v-btn
                                color="blue darken-1"
                                text
                                @click="submit"
                            >
                                Valider
                            </v-btn>
                        </v-card-actions>
                    </v-window-item>
                    
                    <v-window-item :value="2">
                        <v-card-text id="infoText">
                            <v-alert
                                dense
                                text
                                type="error"
                                v-if="error"
                            >
                                La clé transmise est <strong>invalide !</strong>
                            </v-alert>
                            <p class="infoParaph">
                                Un message a bien été envoyé sur le serveur discord concernant ce wiki.<br/>
                                Merci de le rentrer ci-dessous pour attester de la prise de connaissance de l'information par les autres membres.
                            </p>
                            <div id="attestContainer" align="center">
                                <v-textarea
                                    outlined
                                    no-resize
                                    id="attest"
                                    v-model="iPassPhrase"
                                    color="purple darken-2"
                                    name="input-7-4"
                                    label="Clé d'authentification"
                                    required
                                ></v-textarea>
                            </div>
                        </v-card-text>
                        <v-card-actions>
                            <v-btn
                                color="red darken-1"
                                text
                                @click="dialog = false; cleanUp();"
                            >
                                Retour
                            </v-btn>
                            <v-spacer></v-spacer>
                            <v-btn
                                color="blue darken-1"
                                text
                                @click="finalSubmit"
                            >
                                Valider
                            </v-btn>
                        </v-card-actions>
                    </v-window-item>
                </v-window>
            </v-card>
        </v-dialog>
        <p v-if="filteredPages.length == 0">Aucun résultat ne correspond à votre recherche...</p>
        <a id="dlMask" style="visibility: hidden; height: 15px;">{{ pages }}</a>
    </v-card>
</template>

<script>
export default {
    props: {
        search: String,
        adminMode: Boolean,
        delete: Boolean,
        toDel: String,
    },
    data: () => ({
        api: process.env.VUE_APP_API,
        pages: [],
        filteredPages: [],
        dialog: false,
        loading: false,
        error: false,
        form: {
            fileName: "",
            validationString: "",
        },
        selectedPage: null,
        passPhrase: "",
        iPassPhrase: "",
        step: 1,
    }),
    methods: {
        loadPages: async function() {
            this.pages = await (await fetch(this.api + "list")).json();
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
        },

        prepareForDeletion: function() {
            if (this.delete) {
                this.form.fileName = this.toDel;
                this.dialog = true;
            }
        },

        submit: async function() {
            this.loading = true;
            let rapidForm = {
                validationString: this.form.validationString
            }
            
            let result = await fetch(this.api + "check_id", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(rapidForm),
            });

            if (result.ok) {
                //We generate the validation string and we check it is correct
                this.passPhrase = encodeURIComponent( //Just to add a few special characters
                    await (
                        await (
                            await fetch("https://www.random.org/strings/?num=1&len=20&digits=on&upperalpha=on&loweralpha=on&unique=off&format=plain&rnd=new")
                        ).blob()
                    ).text()
                );

                let discordMessage = {
                    content: "**ATTENTION!!**"+
                             "\nQuelqu'un est en train d'essayer de supprimer la page " + this.selectedPage.name + " !"+
                             "\nVoici la clé à copier puis coller dans le champ qui s'est ouvert."+
                             "\n||```"+
                             "\n" + this.passPhrase + "```||"
                }
                await fetch(process.env.VUE_APP_DELETE_WEBHOOK, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(discordMessage)
                });
                this.step++;

            }

            this.error = !result.ok;
            this.loading = false;
        },

        finalSubmit: async function() {
            this.loading = true;

            if (this.passPhrase !== this.iPassPhrase) {
                this.error = true;
                this.loading = false;
                return;
            }

            this.form.fileName = this.selectedPage.url.substr(1);

            await fetch(this.api + "delete/" + this.form.fileName, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(this.form),
            });

            this.dialog = false;
            this.loading = false;

            this.loadPages();
        },

        cleanUp: function() {
            this.dialog = false;
            this.loading = false;
            this.error = false;
            this.form = {
                fileName: "",
                validationString: "",
            };
            this.selectedPage = null;
            this.passPhrase = "";
            this.iPassPhrase = "";
            this.step = 1;
        },

        downloadPage: async function(page) {
            const name = page.url.substr(1);

            let mPageText = await (await (await fetch(this.api + "page/" + name)).json());
            let mPage = new Blob([mPageText.markdown], {type: "text/markdown"});
            let dlUrl = window.URL.createObjectURL(mPage);
            let dlMask = document.getElementById("dlMask");
            dlMask.href = dlUrl;
            dlMask.download = name + "MainPage.md";
            dlMask.click();
            window.URL.revokeObjectURL(dlUrl);

            let mSidePanelText = await (await (await fetch(this.api + "side/" + name)).json());
            let mSidePanel = new Blob([mSidePanelText.markdown], {type: "text/markdown"});
            dlUrl = window.URL.createObjectURL(mSidePanel);
            dlMask.href = dlUrl;
            dlMask.download = name + "SidePanel.md";
            dlMask.click();
            window.URL.revokeObjectURL(dlUrl);
        }
    },
    beforeMount: async function() {
        await this.loadPages();
        if (!document.title.startsWith("Index")) {
            document.title = "Index - " + document.title;
        }

        this.prepareForDeletion();
    }
}
</script>

<style lang="sass">
    #index
        margin-right: 30px

    .infoParaph
        padding-left: 24px
        padding-right: 24px

    #attestContainer
        height: fit-content

        .v-input
            width: 500px

            .v-input__control
                .v-input__slot
                    min-height: 20px
                    height: 50px
    
    .v-list-item--link:before
        border-radius: 5px

    #indexList
        .v-list-item
            height: 48px

</style>