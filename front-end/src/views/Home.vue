<template>
<div class="rvar">
  <div class="row pt-4">
    <div class="col-md-3 rvar-left mb-2 px-3">
      <img class="d-none d-md-inline" src="@/assets/dna.png" alt=""/>
      <h2>Variant Predictor</h2>
      <p>
      <span class="subt">Predict a variant's effect on splicing</span>
      <br>
      <span class="subt-m">based on MAXENT model.</span>
      </p>
    </div>
    <div class="col-md-9 rvar-right mobile desktop"> 
      <div class="desk-up">
        <!-- <h3 class="rvar-heading text-muted fw-light">Variant Description</h3> -->
        <div class="row rvar-form">
          <div class="col-md">
            <div class="text-center mb-4" >
              <h4 class="text-dark mt-2">Gene: <a class="text-decoration-none" href="https://www.ncbi.nlm.nih.gov/nuccore/NG_009060.1" target="_blank" rel="noopener noreferrer">NG_009060.1 (LDLR)</a></h4>
              <h4 class="text-dark mt-2">Ref. mRNA: <a class="text-decoration-none" href="https://www.ncbi.nlm.nih.gov/nuccore/NM_000527" target="_blank" rel="noopener noreferrer">NM_000527.5</a></h4>
            </div>

            <div v-if="st">
              <form @submit.prevent="lookvar">
                <div class="col col-md-6 mx-auto mt-5">
                  <div class="form-outline mb-4">
                    <input type="text" id="varinput" class="form-control bg-light" v-model="vcode" placeholder="c.15000C>G (for example)" autocomplete="off"/>
                    <label class="form-label" for="varinput">Type a variant name in HGVSc format.</label>
                  </div>
                </div>
                <div>
                  <button class="btn btn-primary btn-rounded btn-lg" :disabled="!vcode">
                    <i class="fas fa-magic"></i>
                    &nbsp;
                    <span class="text-warning">predict</span> 
                    NG_009060.1(LDLR):{{vcode}}
                  </button>
                </div>
              </form>
            </div>
            <div v-else>
              <button class="my-4 btn btn-secondary btn-lg" @click="reload">
                <i class="fas fa-redo"></i>
                &nbsp;
                Try again
              </button>
            </div>
            <div v-for="el in resdata" :key="el">
              <p class="card"> {{ el }} </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Home',
  data(){
    return {
      st : 1,
      vcode : '',
      resdata : ''
    }
  },
  methods: {
    lookvar() {
      this.st = 0
      axios.get("http://localhost:3000/",{
        params : {
          variant : this.vcode
        }
      })
      .then((response)=>{
        this.resdata = response.data
      })
      .catch((error) => {
        console.log(error)
      })
    },
    reload(){
      this.st = 1
      this.vcode = ''
      this. resdata = ''
    }

  }
}

</script>

<style scoped>

.btn{
  border-radius : 25px;
}

.rvar{
    background: -webkit-linear-gradient(270deg, #003da5, #3375e8);
    padding: 0%;
    height:100vh!important;
}
.rvar-left{
    text-align: center;
    color: #fff;
    margin-top: 2%;
}


.rvar-right{
  background: #ebf0f8;
}
@media (max-width: 800px) {
  .mobile {
    border-top-left-radius: 50% 10%;
    border-top-right-radius: 50% 10%;
  }
}
@media (min-width: 801px) {
  .desktop{
    border-top-left-radius: 10% 50%;
    border-bottom-left-radius: 10% 50%;
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
  font-weight: 500;
}
.subt-m{
  font-weight: 100;
  font-style: italic;
}
.rvar-left h2{
  font-weight: 600;
}
.rvar .rvar-form{
    padding: 10%;
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

.rvar-heading{
    text-align: center;
    margin-top: 8%;
    margin-bottom: -15%;
    color: #495057;
}
.row{
  --mdb-gutter-x:0;
}

@media (min-width: 801px) {
  .desk-up{
    margin-top: -10%;
  }
}
</style>