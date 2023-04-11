<template>
    <div>
        <h1>{{ title }}</h1>
        <p>
            Ce site sert de wiki pour toutes les tueries du NCU. Soyez vigilant, il est très probable qu'il contienne des éléments de spoil. Pour toute question, veuillez contacter un membre de l'équipe d'écriture sur le 
            <a href="https://discord.gg/jt9Vf7Tvsj">serveur discord du NCU</a>.
        </p>

        <p>
            Vous pouvez retrouver l'index qui regroupe tous les articles du wiki en suivant
            <a href="?index">ce lien</a>.
        </p>
    </div>
</template>

<script>
export default {
    data: () => ({
        title: process.env.VUE_APP_HOME_TITLE,
    }),
}
</script>