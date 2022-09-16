<template>
    <v-container id="topBar"
        fluid
        class="pa-0"
    >
        <v-row align="center" class="topBar">
            <v-col
                cols="12"
                md="7"
            >
                <div id="title" class="text-left">
                    <h1>
                        NcuWiki
                    </h1>
                </div>
            </v-col>

            <v-col
                cols="6"
                md="3"
                align="right"
                class="searchColumn alignVertically"
            >
                <v-text-field
                    @focus="deployed = true"
                    @blur="deployed = false"
                    v-model="search"
                    placeholder="Search"
                    prepend-inner-icon="mdi-magnify"
                    class="expanding-search mt-1"
                    :class="{'closed': !deployed && !search}"
                    filled
                    dense
                    clearable
                    solo
                ></v-text-field>
            </v-col>

            <v-col
                cols="4"
                md="2"
                align="left"
                class="themeColumn"
            >
                <v-btn
                    elevation="2"
                    icon
                    large
                    outlined
                    tile
                >
                    <v-icon>mdi-theme-light-dark</v-icon>
                </v-btn>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    export default {
        data: () => ({
            search: null,
            deployed: false
        }),
    }
</script>

<style lang="sass">
    .topBar
        .searchColumn
            padding-right: 0px

            .expanding-search
                transition: max-width 0.3s
                
                .v-input__slot
                    cursor: pointer !important
                    border-top-right-radius: 0px !important
                    border-top-left-radius: 0px !important
                    border-bottom-right-radius: 0px !important
                    border-bottom-left-radius: 0px !important
                    border: thin solid rgba(0, 0, 0, 0.54)

                &.closed
                    max-width: 47px
        
        .themeColumn
            padding-left: 0px
</style>