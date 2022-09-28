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
                        Contents
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
                <li>
                    <v-btn
                        class="contentsListElem"
                        text
                        block
                        href="#1"
                    >
                        1.  Apparence
                    </v-btn>
                </li>
                <li>
                    <v-btn
                        class="contentsListElem"
                        text
                        block
                        href="#2"
                    >
                        2.  Personnalité
                    </v-btn>
                </li>
                <ul class="contentsList">
                    <li>
                        <v-btn
                            class="contentsListElem"
                            text
                            block
                            href="#2.1"
                        >
                            2.1.  Difficultés de communication
                        </v-btn>
                    </li>
                    <li>
                        <v-btn
                            class="contentsListElem"
                            text
                            block
                            href="#2.2"
                        >
                            2.2.  Intelligence cognitive & émotionnelle
                        </v-btn>
                    </li>
                </ul>
                <li>
                    <v-btn
                        class="contentsListElem"
                        text
                        block
                        href="#3"
                    >
                        3.  Biographie
                    </v-btn>
                </li>
                <ul class="contentsList">
                    <li>
                        <v-btn
                            class="contentsListElem"
                            text
                            block
                            href="#3.1"
                        >
                            3.1.  Naissance et enfance (~ 2005 à 2020)
                        </v-btn>
                    </li>
                    <li>
                        <v-btn
                            class="contentsListElem"
                            text
                            block
                            href="#3.2"
                        >
                            3.2.  Babel's Curse (2021)
                        </v-btn>
                    </li>
                    <li>
                        <v-btn
                            class="contentsListElem"
                            text
                            block
                            href="#3.3"
                        >
                            3.3.  Post-Tuerie (2021-2025)
                        </v-btn>
                    </li>
                </ul>
            </ul>
        </v-card-text>
    </v-card>
</template>

<script>
    export default {
        data: () => ({
            deployed: true
        }),
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
        padding: 5px
</style>