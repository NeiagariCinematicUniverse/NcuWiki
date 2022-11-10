<template>
    <div>
        <v-list>
            <v-list-item class="px-2">
                <v-list-item-avatar>
                    <v-img src="https://cdn.discordapp.com/attachments/485070483260440581/1025151505143181352/unknown.png"></v-img>
                </v-list-item-avatar>

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
    </div>
</template>