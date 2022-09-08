<template>
  <v-app>
    <v-head>
      <TopBar/>
    </v-head>

    <v-main>
    </v-main>
  </v-app>
</template>

<script>
import '@/assets/styles/main.css';
import TopBar from './components/TopBar.vue';

export default {
  name: 'App',

  components: {
    TopBar,
},

  data: () => ({
    //
  }),
};
</script>