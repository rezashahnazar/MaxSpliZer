<template>
  <footer class="text-center text-white" style="background-color: rgba( 30, 30 , 30)">
    <div class="container py-3">
      <div id="mayo">
        <span>Developed by 
          <a href="https://ir.linkedin.com/in/seyedmohammad-saadatagah-18b103122" target="_blank" rel="noopener noreferrer">Seyedmohammad Saadatagah </a>
          <span style="white-space-collapsing:discard">(<a href="https://twitter.com/smsaadatagah?lang=en" target="_blank" rel="noopener noreferrer">@smsaadatagah</a>)</span>
           and 
          <a href="https://ir.linkedin.com/in/reza-shahnazar-93537672" target="_blank" rel="noopener noreferrer">Reza Shahnazar </a>
          <span style="white-space-collapsing:discard">(<a href="https://github.com/rezashahnazar" target="_blank" rel="noopener noreferrer">@rezashahnazar</a>)</span>
          &nbsp;
        </span>
        <br>
        <span >
          in
          <a href="https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview" target="_blank" rel="noopener noreferrer">
          Atherosclerosis and Lipid Genomics Laboratory</a>
          under the supervision of 
          <a href="https://www.mayo.edu/research/labs/atherosclerosis-lipid-genomics/overview" target="_blank" rel="noopener noreferrer">
          Dr. Iftikhar Kullo</a>.
          <br>
          &copy; {{theyear}} All rights reserved.
        <br>
        </span>
      </div>
    </div>
    <div class="bg-danger text-light py-2">
      <div class="container fw-300 small">
        <span>DISCLAIMER: THIS WEBSITE DOES NOT PROVIDE MEDICAL ADVICE
        <br>
        The information, including but not limited to, text, graphics, images and other material contained on this website are for informational purposes only.
        </span>
      </div>
    </div>
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


  #mayo{
    font-weight: 400;
  }
</style>