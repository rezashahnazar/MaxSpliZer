<template>
    <nav class="navbar sticky-top navbar-dark navbar-expand-sm" style="background-color: #003da5">
        <div class="container container-fluid">
            <!-- <span class="navbar-brand mb-0 h1 fw-light fst-italic">VarLookUp</span> -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
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