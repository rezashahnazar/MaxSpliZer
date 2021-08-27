<template>
    <footer class="text-center text-white" style="background-color:#27251f">

    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    <span id="us">Designed by M. Saadatagah M.D. , R. Shahnazar M.D.</span>
    <br>
    <span id="mayo">
      &copy; {{theyear}} Dr. Kullo's
    <a href="https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview" target="_blank" rel="noopener noreferrer">Atherosclerosis and lipid genomics laboratory</a>
    <br>
      <span class="text-muted">Mayo Foundation for Medical Education and Research (MFMER).
      </span>
    <br>
    </span>
    </div>
  <!-- Copyright -->
  </footer>
</template>

<script>
export default {
    name: 'Footer',
    data() {
      return{
        theyear : new Date().getFullYear()
      }
    }
}
</script>

<style scoped>
  a{
    text-decoration: none;
  }


  #us{
    font-weight: 300;
    font-style: italic;
  }
  #mayo{
    font-weight: 400;
  }
</style>