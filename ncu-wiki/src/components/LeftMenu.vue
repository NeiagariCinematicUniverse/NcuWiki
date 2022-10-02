<template>
    <v-navigation-drawer>
        <v-list>
            <v-list-item class="px-2">
                <v-list-item-avatar>
                <v-img src="https://cdn.discordapp.com/attachments/485070483260440581/1025151505143181352/unknown.png"></v-img>
                </v-list-item-avatar>
            </v-list-item>

            <v-list-item link>
                <v-list-item-content>
                    <v-list-item-title class="text-h6">
                        NcuWiki
                    </v-list-item-title>
                </v-list-item-content>
            </v-list-item>
        </v-list>

        <v-divider></v-divider>

        <v-list
            nav
            dense
        >
            <v-list-item link href="/">
                <v-list-item-icon>
                    <v-icon>mdi-home</v-icon>
                </v-list-item-icon>
                <v-list-item-title>Accueil</v-list-item-title>
            </v-list-item>
            <v-list-item link href="/index">
                <v-list-item-icon>
                    <v-icon>mdi-apps</v-icon>
                </v-list-item-icon>
                <v-list-item-title>Index</v-list-item-title>
            </v-list-item>
        </v-list>
        <template v-slot:append>
            <v-dialog v-model="dialog">
                <template v-slot:activator="{ attrs, on }">
                    <v-list
                        nav
                        dense
                    >
                        <v-list-item 
                            link
                            v-bind="attrs"
                            v-on="on"
                        >
                            <v-list-item-icon>
                                <v-icon>mdi-help-circle</v-icon>
                            </v-list-item-icon>
                            <v-list-item-title>Infos</v-list-item-title>
                        </v-list-item>
                    </v-list>
                </template>
                <v-card>
                    <v-card-title>
                        <span class="text-h5">Informations sur le site</span>
                    </v-card-title>
                    <v-card-text id="infoText">
                        Ce site internet a été développé par <a href="https://github.com/RedNeath">RedNeath</a>, en coopération avec tous les membres du Neiagari Cinematic Universe (NCU). Son contenu est quant à lui entièrement rédigé et modéré par l'équipe du NCU.<br>
                        Il n'utilise aucun cookie (c'est rare de nos jours) et est entièrement open-source, disponible <a href="https://github.com/NeiagariCinematicUniverse/NcuWiki">ici</a>
                        <br>
                        <br>
                        Si vous rencontrez des problèmes, n'hésitez pas à les faire parvenir au développeur sur discord ou par mail :<br>
                        D'Ar Heten#1758<br>
                        <a href="mailto:theandre.bourry@ik.me">theandre.bourry@ik.me</a>
                        <br>
                        <br>
                        <br>
                        Bonne navigation !
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn
                            color="blue darken-1"
                            text
                            @click="dialog = false"
                        >
                            C'est parti !
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </template>
    </v-navigation-drawer>
</template>

<script>
    export default {
        data () {
            return {
                dialog: false,
            }
        },
    }
</script>

<style lang="sass">
    .v-dialog
        width: fit-content
        max-width: 65%
    
    #infoText
        text-align: left
</style>