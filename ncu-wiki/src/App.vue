<template>
  <v-app>
    <v-navigation-drawer
        v-model="drawer"
        app
        permanent
        expand-on-hover
        mini-variant
    >
      <LeftMenu/>
    </v-navigation-drawer>

    <v-main>
      <TopBar/>
      <MainPage
        :url="currentPath"
      ></MainPage>
    </v-main>
  </v-app>
</template>

<script>
import '@/assets/styles/main.css';
import TopBar from './components/TopBar.vue';
import LeftMenu from './components/LeftMenu.vue';
import MainPage from './components/MainPage.vue';

export default {
  name: 'App',

  components: {
    TopBar,
    LeftMenu,
    MainPage
},

  data: () => ({
    currentPath: window.location.pathname.substring(1)
  }),
};
</script>