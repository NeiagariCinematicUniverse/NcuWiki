<template>
    <div>
        <v-list>
            <v-list-item class="px-2">
                <v-list-item-avatar>
                    <v-img :src="menuLogo"></v-img>
                </v-list-item-avatar>

                <v-list-item-content>
                    <v-list-item-title class="text-h6">
                        {{ title }}
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
            <v-list-item link href="?index">
                <v-list-item-icon>
                    <v-icon>mdi-apps</v-icon>
                </v-list-item-icon>
                <v-list-item-title>Index</v-list-item-title>
            </v-list-item>
        </v-list>
    </div>
</template>

<script>
export default {
    data: () => ({
        title: process.env.VUE_APP_NAME,
        menuLogo: process.env.VUE_APP_MENU_LOGO,
    })
}
</script>