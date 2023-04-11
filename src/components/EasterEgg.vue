<template>
    <div>
        <h1>SUDOKU</h1>
        <div id="grid" align="center">
            <table id="sdkTable">
                <tr v-for="i in 9" :key="i">
                    <td v-for="j in 9" :key="j">{{ j }}</td>
                </tr>
            </table>
        </div>
    </div>
</template>

<script>
export default {
    
}
</script>

<style lang="sass">
    #sdkTable
        height: 360px
        width: 360px
        text-align: center
</style>