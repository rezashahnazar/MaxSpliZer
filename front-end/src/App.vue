<template>
  <Navbar id="navv" />
  <router-view />
</template>

<script>
import Navbar from '@/components/Navbar.vue'
export default {
  components: {
    Navbar,
  }
}
</script>

<style>
#app {
  /* font-family: Avenir, Helvetica, Arial, sans-serif; */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}

.navbar-brand {
  color: #b7d3ff!important;
}
#navv a {
  color: #fff;
}

#navv a.router-link-exact-active {
  font-weight: bold;
}

.card{
  border-radius : 10px;
  border: none;
}

@import'~bootstrap/dist/css/bootstrap.css'
</style>
