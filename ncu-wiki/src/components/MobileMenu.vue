<template>
    <v-navigation-drawer
        app
        temporary
        bottom
    >
        <MenuContent/>
        <template v-slot:append>
            <InfoPopUp/>
        </template>
    </v-navigation-drawer>
</template>

<script>
import MenuContent from "./MenuContent.vue";
import InfoPopUp from "./InfoPopUp.vue";
    export default {
    data() {
        return {
            dialog: false,
        };
    },
    components: { MenuContent, InfoPopUp }
}
</script>

<style lang="sass">
    .v-dialog
        width: fit-content
        max-width: 65%
    
    #infoText
        text-align: left

    .v-navigation-drawer

        &.theme--dark
            background-color: #1e1e1e

    .v-navigation-drawer--mini-variant
        .v-navigation-drawer__border
            visibility: hidden
</style>