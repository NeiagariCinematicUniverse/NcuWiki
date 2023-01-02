<template>
    <div>
        <h1>Formulaire d'édition</h1>
        <p>Vous pouvez ici déposer ou modifier une fiche. La zone de texte ci-dessous met à jour automatiquement la prévisualisation à droite de la page.</p>

        <v-form
            ref="form"
            @submit.prevent="submit"
        >
            <v-container id="editorAndPreview"
                fluid
                class="pa-0"
            >
                <v-row>
                    <v-col
                        align="center"
                        class="editor"
                        cols="6"
                    >
                        <v-text-field
                            class="fileName"
                            v-model="form.fileName"
                            color="purple darken-2"
                            label="Nom de la fiche"
                            @input="renderPvw()"
                            required
                        ></v-text-field>
                    </v-col>
                </v-row>

                <v-row>
                    <v-col
                        align="center"
                        class="editor"
                        cols="6"
                    >
                        <FileFormCard
                            :file="'mainPage'"
                            @addedFile="updateMainPage"
                        />
                    </v-col>

                    <v-col
                        align="center"
                        class="editor"
                        cols="6"
                    >
                        <FileFormCard
                            :file="'sidePanel'"
                            @addedFile="updateSidePanel"
                        />
                    </v-col>
                </v-row>

                <v-row>
                    <v-col
                        align="center"
                        class="editor"
                        cols="6"
                    >
                        <v-textarea
                            outlined
                            class="Mono"
                            v-model="form.sidePanel"
                            color="purple darken-2"
                            name="input-7-4 sidePanel"
                            label="Zone d'édition du panneau de droite"
                            @input="expandSidePanel(); renderPvw()"
                        ></v-textarea>
                    </v-col>

                    <v-col
                        align="center"
                        class="previewer"
                        cols="6"
                    >
                        <EmbeddedPanel
                            :title="form.fileName"
                            :mdContent="form.sidePanel"
                            ref="embeddedPanel"
                        />
                    </v-col>
                </v-row>

                <v-row>
                    <v-col
                        align="center"
                        class="editor"
                        cols="6"
                    >
                        <v-textarea
                            outlined
                            class="Mono"
                            v-model="form.mainPage"
                            color="purple darken-2"
                            name="input-7-4 mainPage"
                            label="Zone d'édition de la fiche"
                            @input="expandMainPage(); renderPvw();"
                        ></v-textarea>
                    </v-col>
                    
                    <v-col
                        align="left"
                        class="previewer"
                        cols="6"
                    >
                        <EmbeddedPage
                            :title="form.fileName"
                            :mdContent="form.mainPage"
                            :mdPanel="form.sidePanel"
                        />
                    </v-col>
                </v-row>
            </v-container>

            <v-dialog v-model="dialog">
                <template v-slot:activator="{ attrs, on }">
                    <v-btn
                        dark
                        color="purple lighten-1"
                        block
                        elevation="2"
                        v-bind="attrs"
                        v-on="on"
                    >
                        Envoyer
                    </v-btn>
                </template>
                <v-card
                    :loading=loading
                >
                    <v-card-title>
                        <span class="text-h5">Vérification d'identité</span>
                    </v-card-title>
                    <v-card-text id="infoText">
                        <v-alert
                            dense
                            text
                            type="success"
                            v-if="success"
                        >
                            La fiche a été envoyée <strong>avec succès !</strong>
                        </v-alert>
                        <v-alert
                            dense
                            text
                            type="error"
                            v-if="error"
                        >
                            Une <strong>erreur</strong> est survenue lors de <strong>l'envoi de la fiche !</strong>
                        </v-alert>
                        <p>
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
                            @click="dialog = false"
                        >
                            Retour
                        </v-btn>
                        <v-spacer></v-spacer>
                        <v-btn
                            color="blue darken-1"
                            text
                            :href="'?' + form.fileName"
                            v-if="success"
                        >
                            Consulter
                        </v-btn>
                        <v-btn
                            color="blue darken-1"
                            text
                            @click="submit"
                        >
                            Valider
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-form>
    </div>
</template>

<script>
import EmbeddedPage from './EmbeddedPage.vue';
import EmbeddedPanel from './EmbeddedPanel.vue';
import FileFormCard from './FileFormCard.vue';


export default {
    data() {
        const defaultForm = Object.freeze({
            fileName: "",
            mainPage: "[commentaire1]: Liens_utiles\n" +
                "[tuerie]: ?Tuerie\n" +
                "\n" +
                "[commentaire2]: Ecriture_du_texte",
            sidePanel: "[commentaire1]: Liens_vers_les_images_(les_noms_des_liens_seront_utilisés_pour_nommer_les_onglets)_:\n" +
                "[Portrait]: https://cdn.discordapp.com/attachments/1046024931139407902/1046025687103983656/Portrait.jpg\n" +
                "\n" +
                "[commentaire2]: Séparateur_indiquant_la_fin_des_images_:\n" +
                "[FEUILLE_VOLANTE]: FinDesPhotos\n" +
                "\n" +
                "[commentaire3]: Liens_utiles_:\n" +
                "[2022]: ?2022\n" +
                "\n" +
                "[commentaire4]: Contenu_du_panneau_de_droite_(ne_pas_utiliser_un_titre_de_niveau_inférieur_à_3)_:",
            validationString: "",
        });
        return {
            form: Object.assign({}, defaultForm),
            loading: false,
            api: "http://localhost:3000/api/", //"https://api.chimura-ryouwasa.top/api/",
            success: false,
            error: false,
            dialog: false,
        };
    },

    props: {
        url: String
    },

    methods: {
        loadMd: async function() {
            if (this.url.split("&").length <= 1) {
                return;
            }
            let parsedRequest = this.url.substring(this.url.indexOf("&") + 1); //Allows pages with & inside their names
            this.form.fileName = parsedRequest;

            let mpRequestResult = await fetch(this.api + "page/" + parsedRequest);
            if (mpRequestResult.status != 200) {
                console.log("Error while loading main page markdown");
                this.form.mainPage = "";
            } else {
                this.form.mainPage = (await mpRequestResult.json()).markdown;
            }

            let spRequestResult = await fetch(this.api + "side/" + parsedRequest);
            if (spRequestResult.status != 200) {
                console.log("Error while loading side panel markdown");
                this.form.sidePanel = "";
            } else {
                this.form.sidePanel = (await spRequestResult.json()).markdown;
            }

            this.renderPvw();
        },

        submit: async function () {
            if (this.success) {
                this.dialog = false;
                //reset the form
                this.success = false;
                this.form.validationString = "";
                return;
            }

            this.loading = true;
            
            let result = await fetch(this.api + "edit/" + this.form.fileName, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(this.form),
            });

            this.success = result.ok;
            this.error = !result.ok;

            this.loading = false;
        },
        expandSidePanel: function () {
            let textArea = document.getElementsByName("input-7-4 sidePanel")[0];

            textArea.style.height = "auto";
            textArea.style.height = textArea.scrollHeight + "px";
        },
        expandMainPage: function () {
            let textArea = document.getElementsByName("input-7-4 mainPage")[0];
            
            textArea.style.height = "auto";
            textArea.style.height = textArea.scrollHeight + "px";
        },
        updateMainPage: function(name, content) {
            if (this.form.fileName === "") this.form.fileName = name;
            this.form.mainPage = content;
            this.renderPvw();
        },
        updateSidePanel: function(name, content) {
            console.log("imported " + name);
            this.form.sidePanel = content;
            this.renderPvw();
        },

        renderPvw: function() {
            this.form.fileName = decodeURIComponent(this.form.fileName).replace(new RegExp(/ /, 'g'), "_");
            EmbeddedPage.methods.renderAgain(this.form.fileName, this.form.mainPage);
            this.$refs.embeddedPanel.renderAgain(this.form.fileName, this.form.sidePanel);
        },
    },
    mounted: async function () {
        await this.loadMd();
        this.expandSidePanel();
        this.expandMainPage();
    },
    components: { EmbeddedPage, EmbeddedPanel, FileFormCard }
}
</script>

<style lang=sass>
    .Mono
        .v-input__slot
            .v-text-field__slot
                textarea
                    font-family: monospace
                    font-size: 14px
                    min-height: 500px
                    line-height: 20px

    .Auth
        height: 105px
        width: 570px

        .v-input__slot
            .v-text-field__slot
                textarea
                    font-family: monospace
                    font-size: 14px
                    line-height: 20px
    
    #textContainer
        height: 150px
        padding: 10px
</style>