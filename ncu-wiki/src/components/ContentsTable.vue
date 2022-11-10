<template>
    <v-card
        outlined
        :class="{'deployed': deployed}"
    >
        <v-card-title>
            <v-container class="contentsTitle">
                <v-row>
                    <v-col class="contentsTitle" align="left">
                        <v-icon id="contentsIco">mdi-format-list-numbered</v-icon>        
                        Sommaire
                    </v-col>
                    <v-col class="contentsTitle" align="right">
                        <v-btn 
                            id ="contentsDspl"
                            icon
                            @click="deployed = !deployed"
                        >
                            <v-icon>mdi-chevron-down</v-icon>
                        </v-btn>
                    </v-col>
                </v-row>
            </v-container>
        </v-card-title>
        <v-divider id="contentsDivider"></v-divider>
        <v-card-text id="contentsList">
            <ul id="contentsListRoot" class="contentsList">
                <li v-for="content in this.contents" :key="content.id" :class="{
                        'content-l1': content.level == 1,
                        'content-l2': content.level == 2,
                        'content-l3': content.level == 3,
                        'content-l4': content.level == 4,
                        'content-l5': content.level == 5,
                }">
                    <ContentsTableElementVue :text="content.label" :link="'#' + content.index"/>
                </li>
            </ul>
        </v-card-text>
    </v-card>
</template>

<script>
import ContentsTableElementVue from './ContentsTableElement.vue';

    export default {
        props: {
            contents: [],
        },

        data: () => ({
            deployed: true,
        }),

        methods: {
            moveContentsTable: function() {
                let firstHeader = document.getElementById(this.contents[0].index);
                let contentsTable = document.getElementById("contentsTable");

                console.log(firstHeader);
                console.log(contentsTable);
                document.getElementById("content").insertBefore(contentsTable, firstHeader);
            }
        },

        mounted: function() {
            this.moveContentsTable();
        },

        components: { ContentsTableElementVue }
    }
</script>

<style lang="sass">
    #contentsTable
        margin-top: 30px
        margin-bottom: 30px
        width: fit-content
        height: 67px

        &.deployed
            height: fit-content

            .contentsList
                visibility: visible

            #contentsDivider
                visibility: visible

            #contentsDspl
                transform: rotate(180deg)

    #contentsDivider
        visibility: hidden

    .v-card__text
        padding-left: 5px
        padding-right: 5px

        .contentsList
            list-style-type: none
            visibility: hidden

        #contentsListRoot
            padding-left: 0px !important

        .contentsListElem
            justify-content: left
            padding-left: 9px !important
            padding-right: 9px !important
            font-weight: 400
            text-transform: none
            letter-spacing: 0.012em

    #contentsIco
        margin-right: 3px

    .contentsTitle
        min-width: fit-content
        padding: 5px
</style>