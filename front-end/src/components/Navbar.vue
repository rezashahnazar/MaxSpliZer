<template>
    <nav class="navbar navbar-expand-md navbar-dark bg-dark shadow-0">
        <div class="container-fluid">
            <button
            class="navbar-toggler"
            type="button"
            data-mdb-toggle="collapse"
            data-mdb-target="#navbarNav"
            aria-controls="navbarNav"
            aria-expanded="false"
            aria-label="Toggle navigation"
            >
            <span class="fas fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item mx-2">
                        <router-link class="nav-link active" to="/">Home</router-link>
                    </li>
                    <li class="nav-item mx-2">
                        <router-link class="nav-link active" to="/howto">Guide</router-link>
                    </li>
                    <li class="nav-item mx-2">
                        <router-link class="nav-link active" to="/docs">Docs</router-link>
                    </li>
                    <li class="nav-item mx-2">
                        <router-link class="nav-link active" to="/contactus">Contact</router-link>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</template>

<script>
    export default {
        name: 'Navbar'
    }
</script>

<style scoped>
nav{
    background-color: #003da5!important;
}
nav a {
  font-weight: 300;
  color: #fff;
}

nav a.router-link-exact-active {
  font-weight:800;
} 

</style>