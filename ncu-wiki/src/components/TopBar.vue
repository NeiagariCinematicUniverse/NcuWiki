<template>
    <v-container id="topBar"
        fluid
        class="pa-0"
    >
        <v-row align="center">
            <v-col
                cols="12"
                sm="6"
            >
                <div id="title" class="text-left">
                    <h1>
                        NcuWiki
                    </h1>
                </div>
            </v-col>

            <v-col
                cols="12"
                sm="6"
            >
                <div id="buttons" class="text-right">
                    <v-btn
                        elevation="2"
                        icon
                        large
                        outlined
                        tile
                    >
                        <v-icon>mdi-magnify</v-icon>
                    </v-btn>
                    <v-btn
                        elevation="2"
                        icon
                        large
                        outlined
                        tile
                    >
                        <v-icon>mdi-theme-light-dark</v-icon>
                    </v-btn>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>