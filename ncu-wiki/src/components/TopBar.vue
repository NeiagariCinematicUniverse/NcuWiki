<template>
    <v-container id="topBar"
        fluid
        class="pa-0"
    >
        <v-row align="center" class="topBar">
            <v-col
                align="right"
                cols="2"
                md="1"
                class="logo"
            >
                <v-img
                    align="left"
                    src="@/assets/logoncu.png"
                    contain
                    max-height="100"
                    max-width="100"
                ></v-img>
            </v-col>

            <v-col
                align="left"
                cols="10"
                md="7"
                class="title"
            >
                <div class="title">
                    <h1>
                        NcuWiki
                    </h1>
                </div>
            </v-col>

            <v-col
                cols="10"
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
                    hide-details="true"
                ></v-text-field>
            </v-col>

            <v-col
                cols="1"
                md="1"
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
        .logo
            padding-right: 0px
            padding-left: 10px
            
        .title
            padding-top: 5px

        .searchColumn
            padding-right: 0px
            margin-top: 10px

            .expanding-search
                transition: max-width 0.3s
                margin-top: 0px !important
                
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
            margin-top: 10px

            .v-btn
                width: 47px
                height: 40px
</style>