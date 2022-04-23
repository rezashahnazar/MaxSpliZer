<template>
<div>
  <div class="rvar">
  <div class="row pt-4">
    <div class="col-md-3 rvar-left mb-3 px-3">
      <img class="d-none d-md-inline" src="@/assets/dna.png" alt=""/>
      <h1 id="vp" class="mb-2">MaxSpliZer</h1>
      <span class="subt">Predicting the Effect of </span>
        <span class="font-italic"> LDLR </span>
       <span> Splice Variants</span>
      <br>
      <div class="subt-m mx-auto mb-3 mt-1">
        <span>Based on the maximum entropy model<sup>1</sup></span>
        <span>, According to the ClinGen variant curation expert panel consensus guidelines for LDLR variant classification.<sup>2</sup></span>
        <span> We use </span>
        <a class="subt-link" href="https://mutalyzer.nl/" target="_blank" rel="noopener noreferrer">Mutalyzer v2.0.34</a>
        <span> and </span>
        <a class="subt-link" href="http://hollywood.mit.edu/burgelab/maxent/Xmaxentscan_scoreseq.html" target="_blank" rel="noopener noreferrer">MaxEntScan</a>
        <span> web services to predict the effect.</span>
      </div>
    </div>
    <div class="col-md-9 rvar-right mobile desktop"> 
      <div class="desk-up ">
        <div class="row rvar-form">
          <div class="col-md">
            <!-- <div class="text-center" >
              <h5 class="text-dark mt-2 fw-light">LOCUS: <a class="text-decoration-none" href="https://www.ncbi.nlm.nih.gov/nuccore/NG_009060.1" target="_blank" rel="noopener noreferrer">NG_009060.1 (LDLR)</a></h5>
              <h5 class="text-dark mt-2 fw-light">Transcript: <a class="text-decoration-none" href="https://www.ncbi.nlm.nih.gov/nuccore/NM_000527" target="_blank" rel="noopener noreferrer">NM_000527.5</a></h5>
            </div> -->
            <div v-if="!$store.state.resdata" class="row">
              <div class="dropdown">
                <button
                  class="btn btn-primary dropdown-toggle"
                  type="button"
                  id="dropdownMenuButton"
                  data-mdb-toggle="dropdown"
                  aria-expanded="false"
                >
                  {{cgene ?  cgenecode : 'Choose A gene'}}
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <li><span class="dropdown-item cpointer" @click="setLDLR">NG_009060.1(<i>LDLR</i>)</span></li>
                  <li><span class="dropdown-item cpointer" @click="setFBN">NG_008805.2(<i>FBN1</i>)</span></li>
                </ul>
              </div>
            </div>
            <div v-if="st">
              <form v-if="cgene" class="px-5" @submit.prevent="doLookvar">
                <div class="col col-md-6 mx-auto mobform mt-5">
                  <div class="form-outline mobform mb-5">
                    <input type="text" id="varinput" class="form-control bg-light" v-model="cvcode" autocomplete="on"/>
                    <label class="form-label" for="varinput">Enter a variant in HGVSc format.</label>
                  </div>
                </div>
                <div>
                  <button class="btn btn-primary btn-rounded btn-lg" :disabled="!cvcode">
                    <i class="fas fa-magic"></i>
                    &nbsp;
                    <span class="text-warning">predict</span> 
                    {{ cgenecode }}:{{ cvcode }}
                  </button>
                </div>
              </form>
            </div>
            <div v-else class="pt-2">
              
              <div><button class="my-4 btn btn-secondary btn-lg" @click="doReload">
                <i class="fas fa-redo"></i>
                &nbsp;
                Try again
              </button></div>
              <div v-if="$store.state.resdata==''" class="spinner-grow text-secondary mt-4" role="status">
               <span class="visually-hidden">Loading...</span>
              </div>
              <div class="mt-4" v-if="$store.state.errormsg==1">
                <p class="text-danger">There is a problem with internet connection ...</p>
                
              </div>
            </div>
            
          </div>
        </div>
        <Report />
      </div>
    </div>
  </div>
</div>



<div class="text-start text-white small fst-italic pb-4 pt-4" style="background-color:#3375e8">  
  <div class="container">
    <span>
    1. Yeo G, Burge CB. Maximum entropy modeling of short sequence motifs with applications to RNA splicing signals. 
    Journal of computational biology. 2004 Mar 1;11(2-3):377-94. </span>
    <a class="subt-link" href="https://doi.org/10.1089/1066527041410418" target="_blank" rel="noopener noreferrer">https://doi.org/10.1089/1066527041410418</a>
    <br>
    <span>
    2. Chora JR, Iacocca MA, Tichy L, Wand H, Kurtz CL, Zimmermann H, Leon A, Williams M, Humphries SE, Hooper AJ, Trinder M. 
    The Clinical Genome Resource (ClinGen) Familial Hypercholesterolemia Variant Curation Expert Panel consensus guidelines for LDLR variant classification. medRxiv. 2021 Jan 1. </span>
    <a class="subt-link" href="https://doi.org/10.1101/2021.03.17.21252755" target="_blank" rel="noopener noreferrer">https://doi.org/10.1101/2021.03.17.21252755</a>
  </div>
</div>



</div>

</template>
 
<script>
import Report from '@/components/Report.vue'
export default {
  name: 'Home',
  data(){
    return{
      cvcode: '' , 
      cgene: '' , 
      cgenecode : ''
    }
  },
  components:{
    Report
  },
  methods: {
    doLookvar(){
      this.$store.dispatch('lookvar')
    },
    doReload(){
      this.$store.commit('reload')
      this.cvcode = ''
      this.cgene = ''
    }, 
    setLDLR(){
      this.cgene = 'LDLR'
      this.cgenecode = 'NG_009060.1(LDLR)'
    } , 
    setFBN(){
      this.cgene = 'FBN'
      this.cgenecode = 'NG_008805.2(FBN1)'
    }
  },
  computed: {
    st(){
      return this.$store.state.st
    }
  },
  watch: {
    cvcode(value){
      this.$store.state.vcode = value
    },
    cgene(value){
      this.$store.state.gene = value
    },
    cgenecode(value){
      this.$store.state.genecode = value
    }
  }
}

</script>

<style scoped>
.cpointer{
  cursor: pointer;
}

.btn{
  border-radius : 25px;
}

.rvar{
    background: -webkit-linear-gradient(270deg, #003da5, #3375e8);
    padding: 0%;
    min-height:100vh!important;
}
.rvar-left{
    text-align: center;
    color: #fff;
    margin-top: 2%;
}

.rvar-right{
  background: #ebf0f8;
  padding-bottom: 30px!important;
}

@media (max-width: 768px) {
  .mobile {
    border-top-left-radius: 50% 10%;
    border-top-right-radius: 50% 10%;
    min-height: 50vh;
  }
  .mobform {
    margin-top: 4vh!important ;
    margin-bottom: 4vh!important;
  }
  .subt-m{
    font-weight: 100;
    font-style: italic;
    font-size:9pt!important;
    line-height: 14pt;
    max-width: 80%!important;
  }
  .subt{
    font-size: 90%;
  }
  #vp{
    font-size: 33pt;
    font-weight: 400;
  }
}
@media (min-width: 769px) {
  .desktop{
    border-top-left-radius: 10% 50%;
    border-bottom-left-radius: 10% 50%;
  }
   .desk-up{
    margin-top: -10%;
  }
  #vp{
    font-size: 5;
    font-weight: 400;
  }
  .subt-m{
  font-weight: 100;
  font-style: italic;
  font-size:85%;
  max-width:80%!important;
}
}

.rvar-left img{
    margin-top: 15%;
    margin-bottom: 5%;
    width: 25%;
    -webkit-animation: mover 2s infinite  alternate;
    animation: mover 1s infinite  alternate;
}
@-webkit-keyframes mover {
    0% { transform: translateY(0); }
    100% { transform: translateY(-20px); }
}
@keyframes mover {
    0% { transform: translateY(0); }
    100% { transform: translateY(-20px); }
}



.subt{
  font-weight: 400;
}


a.subt-link {
  color:#ffc107;
}


.rvar .rvar-form{
    padding-top: 10%;
    padding-bottom: 5%;
    margin-top: 10%;
}
.btnRvar{
    float: right;
    margin-top: 10%;
    border: none;
    border-radius: 1.5rem;
    padding: 2%;
    background: #0062cc;
    color: #fff;
    font-weight: 600;
    width: 50%;
    cursor: pointer;
}

.row{
  --mdb-gutter-x:0;
}


</style>