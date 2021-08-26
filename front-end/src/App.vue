<template>
  <Navbar id="navv" />
  <router-view />
  <Footer />
</template>

<script>
import Navbar from '@/components/Navbar.vue'
import Footer from '@/components/Footer.vue'
export default {
  components: {
    Navbar, Footer
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
  font-weight: 300;
  color: #fff;
}

#navv a.router-link-exact-active {
  font-weight:800;
}

.card{
  border-radius : 10px;
  border: none;
}

@import'~bootstrap/dist/css/bootstrap.css'
</style>
