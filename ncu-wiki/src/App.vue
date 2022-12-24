<template>
  <v-app>
    <LeftMenu/>
    <MobileMenu/>

    <v-speed-dial
      id="adminButton"
      v-if="this.displayAM"
      v-model="adminMode"
      bottom
      right
      absolute
      fixed
    >
      <template v-slot:activator>
        <v-btn
          v-model="adminMode"
          v-bind:class="{'red darken-2': !adminMode, 'green darken-1': adminMode}"
          dark
          fab
        >
          <v-icon v-if="adminMode">
            mdi-lock
          </v-icon>
          <v-icon v-else>
            mdi-lock-open
          </v-icon>
        </v-btn>
      </template>
    </v-speed-dial>

    <v-main>
      <TopBar v-on:validateSearch="pushSearch"/>
      <MainPage
        :url="currentPath"
        :key="this.search"
        :search="this.search"
        :admin-mode="this.adminMode"
      ></MainPage>
    </v-main>
  </v-app>
</template>

<script>
import '@/assets/styles/main.css';
import TopBar from './components/TopBar.vue';
import LeftMenu from './components/LeftMenu.vue';
import MainPage from './components/MainPage.vue';
import MobileMenu from './components/MobileMenu.vue';

export default {
  name: 'App',

  components: {
    TopBar,
    LeftMenu,
    MainPage,
    MobileMenu
},

  data: () => ({
    currentPath: window.location.search.substring(1),
    darkTheme: null,
    search: null,
    adminMode: false,
    displayAM: false,
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
    },

    pushSearch: function(search) {
      this.search = search;
      this.currentPath = "index";
      this.adminModeDisplay();
      
    },

    adminModeDisplay: function() {
      this.displayAM = (this.currentPath === "index");
    }
  },
  created: function() {
    this.keepSystemTheme();
    this.adminModeDisplay();
  },
};
</script>

<style lang="sass">
  #app
    color: #2c3e50

    &.theme--dark
      color: white
</style>