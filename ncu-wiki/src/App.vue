<template>
  <v-app>
    <v-navigation-drawer
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
    currentPath: window.location.pathname.substring(1),
    darkTheme: null,
  }),

  methods: {
    keepSystemTheme: function() {
      this.darkTheme = window.matchMedia("(prefers-color-scheme: dark)");

      if (this.darkTheme.matches) {
        this.$vuetify.theme.dark = true;
      } else {
        this.$vuetify.theme.dark = false;
      }
      
      this.darkTheme.addEventListener("change", e => {
        if (e.matches) {
          this.$vuetify.theme.dark = true;
        } else {
          this.$vuetify.theme.dark = false;
        }
      });
    }
  },
  created: function() {
    this.keepSystemTheme();
  },
};
</script>

<style lang="sass">
  #app
    color: #2c3e50

    &.theme--dark
      color: white
</style>