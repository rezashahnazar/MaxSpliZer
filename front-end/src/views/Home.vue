<template>
<div class="rvar">
  <div class="row">
    <div class="col-md-3 rvar-left">
      <img class="d-none d-md-inline" src="@/assets/dna.png" alt=""/>
      <h2>Variant Lookup</h2>
      <p>Predict a variant's effect on splicing
      <br>
      <span>based on MAXENT model.</span>
      </p>
    </div>
    <div class="col-md-9 rvar-right mobile desktop"> 
      <div class="">
        <h3 class="rvar-heading text-muted fw-light">Variant Description</h3>
        <div class="row rvar-form">
          <div class="col-md">
            <div class="text-center mb-4" >
              <h3 class="text-dark mt-2">Gene: <a class="text-decoration-none" href="https://www.ncbi.nlm.nih.gov/nuccore/NG_009060.1">NG_009060.1 (LDLR)</a></h3>
              <h5 class="text-dark mt-2">Reference mRNA transcript: <a class="text-decoration-none" href="https://www.ncbi.nlm.nih.gov/nuccore/NM_000527">NM_000527.5</a></h5>
            </div>
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Variant Name in HSGVc format" value="" />
            </div>
            <form action="#" method="post" id="form">
              <div class="col-auto">
                <label class="visually-hidden" for="variant">Variant code</label>
                <div class="input-group">
                  <div class="input-group-text">NG_009060.1(LDLR):c.</div>
                  <input type="text" class="form-control  bg-light" name="variant" placeholder="160del (for example)">
                </div>
              </div>
              <div class="form-text mb-3">Complete a variant name in HGVSc format.</div>
              <input type="submit" value="locate" data-mdb-toggle="popover" class="btn btn-primary btn-rounded ripple-surface px-5">  
            </form>    
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>

export default {
  name: 'Home',
  components: {
    
  }
}
</script>

<style scoped>

.btn{
  border-radius : 25px;
}

.rvar{
    background: -webkit-linear-gradient(270deg, #003da5, #3375e8);
    padding: 3%;
    height:100vh!important;
}
.rvar-left{
    text-align: center;
    color: #fff;
    margin-top: 4%;
}
.rvar-left input{
    border: none;
    border-radius: 1.5rem;
    padding: 2%;
    width: 60%;
    background: #f8f9fa;
    color: #383d41;
    margin-top: 30%;
    cursor: pointer;
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
.rvar-left p{
    font-weight:400 ;
    padding: 12%;
    margin-top: -9%; 
}
.rvar-left span {
  font-weight: 200;
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

</style>