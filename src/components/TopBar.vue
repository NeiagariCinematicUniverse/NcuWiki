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
                    :src="logoSource"
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
                    <h1 id="mainTitle">
                        {{ title }}
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
                    class="expanding-search mt-1 topBarButton"
                    :class="{'closed': !deployed && !search}"
                    filled
                    dense
                    clearable
                    solo
                    hide-details="true"
                    @keypress="setSearchValue"
                    @input="emptiedValue"
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
                    @click="$vuetify.theme.dark = !$vuetify.theme.dark"
                    class="topBarButton"
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
            deployed: false,
            title: process.env.VUE_APP_NAME,
            logoSource: process.env.VUE_APP_MAIN_LOGO, 
        }),
        methods: {
            setSearchValue: function(event) {
                if (event.key == "Enter") {
                    this.$emit("validateSearch", this.search);
                }
            },
            emptiedValue: function() {
                if (!this.search) {
                    this.search = "";
                    this.$emit("validateSearch", this.search);
                }
            }
        },
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
                    border-radius: 0px !important
                    box-shadow: unset !important

                &.closed
                    max-width: 47px
        
        .themeColumn
            padding-left: 0px
            margin-top: 10px

            .v-btn
                width: 47px
                height: 40px

    #mainTitle
        color: white

    .topBarButton
        background-color: white
        border-radius: 0px !important
        border: 0px /*thin solid rgba(0, 0, 0, 0.54)*/
        box-shadow: 0px 3px 1px -2px rgb(0 0 0 / 20%), 0px 2px 2px 0px rgb(0 0 0 / 14%), 0px 1px 5px 0px rgb(0 0 0 / 12%)

        &.theme--dark
            background-color: #1E1E1E
            /*border: thin solid white*/
</style>