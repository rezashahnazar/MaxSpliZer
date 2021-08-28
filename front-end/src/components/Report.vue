<template>
    <div class="report card fullwidth">
        <div v-if="$store.state.resdata.rep_status==3">
            <h1></h1>
            <p class="note note-danger"><strong>Sorry!</strong> 
            {{ $store.state.resdata.war_msg }}
            </p>
        </div>
        <div v-if="$store.state.resdata.rep_status==2">
            
            <p class="note note-success"><strong>Well done!</strong> 
            {{ $store.state.resdata.intp }}
            <div class="card">
                <table class="table align-middle table-responsive border-success">
                    <tbody class="fw-bold">
                        <tr>
                            <th scope="row p-0">Reference ID</th>
                            <td class="text-success p-0">{{ $store.state.resdata.ref_id }}</td>
                        </tr>
                        <tr>
                            <th scope="row p-0">Gene description</th>
                            <td class="text-success p-0 text-break">{{ $store.state.resdata.g_des }}</td>
                        </tr>
                        <tr>
                            <th scope="row p-0">Genomic position</th>
                            <td class="text-success p-0">{{ $store.state.resdata.g_pos }}</td>
                        </tr>
                        <tr>
                            <th scope="row p-0">Reference Allele</th>
                            <td class="text-success p-0">{{ $store.state.resdata.ref_allele }}</td>
                        </tr>
                        <tr>
                            <th scope="row p-0">Altered to</th>
                            <td class="text-success p-0">{{ $store.state.resdata.alt_allele }}</td>
                        </tr>
                    </tbody>
                </table>
                <strong class="px-1">{{ $store.state.resdata.note }}</strong>
            </div>
            </p>
        </div>
        <div class="" v-if="$store.state.resdata.rep_status==1">
            
            <div class="accordion accordion-flush d-flex row" id="accordionFlushExample">
                <div class="accordion-item col-md-6">
                    <h2 class="accordion-header" id="flush-headingOne">
                    <button
                        class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_a_acc , sfalse : !$store.state.resdata.met_a_acc}"
                        type="button" :disabled="!$store.state.resdata.met_a_acc"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#flush-collapseOne"
                        aria-expanded="false"
                        aria-controls="flush-collapseOne"
                        
                    >
                        
                    <div style="pointer-events: none" class="d-inline text-center disabled">Scenario A, Acceptor site:<img src="@/assets/svg/splicingAA.svg" height="38" class="m-2"></div>
                    </button>
                    </h2>
                    <div
                    id="flush-collapseOne"
                    class="accordion-collapse collapse"
                    aria-labelledby="flush-headingOne"
                    data-mdb-parent="#accordionFlushExample"
                    >
                    <div class="accordion-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                        richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
                        brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                        sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch
                        et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt
                        sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat
                        craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't
                        heard of them accusamus labore sustainable VHS.
                    </div>
                    </div>
                </div>
                <div class="accordion-item col-md-6">
                    <h2 class="accordion-header" id="flush-headingTwo">
                    <button
                        class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_a_don , sfalse : !$store.state.resdata.met_a_don}"
                        type="button" :disabled="!$store.state.resdata.met_a_don"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#flush-collapseTwo"
                        aria-expanded="false"
                        aria-controls="flush-collapseTwo"
                    >
                    <div style="pointer-events: none" class="d-inline text-center disabled">Scenario A, Donnor site:<img src="@/assets/svg/splicingAD.svg" height="38" class="m-2"></div>
                    </button>
                    </h2>
                    <div
                    id="flush-collapseTwo"
                    class="accordion-collapse collapse"
                    aria-labelledby="flush-headingTwo"
                    data-mdb-parent="#accordionFlushExample"
                    >
                    <div class="accordion-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                        richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
                        brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                        sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch
                        et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt
                        sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat
                        craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't
                        heard of them accusamus labore sustainable VHS.
                    </div>
                    </div>
                </div>
                

                <div class="accordion-item col-md-6">
                    <h2 class="accordion-header" id="flush-headingThree">
                    <button
                        class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_b_acc , sfalse : !$store.state.resdata.met_b_acc}"
                        type="button" :disabled="!$store.state.resdata.met_b_acc"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#flush-collapseThree"
                        aria-expanded="false"
                        aria-controls="flush-collapseThree"
                    >
                    <div style="pointer-events: none" class="d-inline text-center disabled">Scenario B, Acceptor site:<img src="@/assets/svg/splicingBA.svg" height="38" class="m-2"></div>
                    </button>
                    </h2>
                    <div
                    id="flush-collapseThree"
                    class="accordion-collapse collapse"
                    aria-labelledby="flush-headingThree"
                    data-mdb-parent="#accordionFlushExample"
                    >
                    <div class="accordion-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                        richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
                        brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                        sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch
                        et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt
                        sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat
                        craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't
                        heard of them accusamus labore sustainable VHS.
                    </div>
                    </div>
                </div>
                <div class="accordion-item col-md-6">
                    <h2 class="accordion-header" id="flush-headingFour">
                    <button
                        class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_b_don , sfalse : !$store.state.resdata.met_b_don}"
                        type="button" :disabled="!$store.state.resdata.met_b_don"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#flush-collapseFour"
                        aria-expanded="false"
                        aria-controls="flush-collapseFour"
                    >
                    <div style="pointer-events: none" class="d-inline text-center disabled">Scenario B, Donnor site:<img src="@/assets/svg/splicingBD.svg" height="38" class="m-2"></div>
                    </button>
                    </h2>
                    <div
                    id="flush-collapseFour"
                    class="accordion-collapse collapse"
                    aria-labelledby="flush-headingFour"
                    data-mdb-parent="#accordionFlushExample"
                    >
                    <div class="accordion-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                        richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
                        brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                        sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch
                        et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt
                        sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat
                        craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't
                        heard of them accusamus labore sustainable VHS.
                    </div>
                    </div>
                </div>


                <div class="accordion-item col-md-6">
                    <h2 class="accordion-header" id="flush-headingFive">
                    <button
                        class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_c_acc , sfalse : !$store.state.resdata.met_c_acc}"
                        type="button" :disabled="!$store.state.resdata.met_c_acc"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#flush-collapseFive"
                        aria-expanded="false"
                        aria-controls="flush-collapseFive"
                    >
                    <div style="pointer-events: none" class="d-inline text-center disabled">Scenario C, Acceptor site:<img src="@/assets/svg/splicingCA.svg" height="38" class="m-2"></div>
                    </button>
                    </h2>
                    <div
                    id="flush-collapseFive"
                    class="accordion-collapse collapse"
                    aria-labelledby="flush-headingFive"
                    data-mdb-parent="#accordionFlushExample"
                    >
                    <div class="accordion-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                        richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
                        brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                        sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch
                        et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt
                        sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat
                        craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't
                        heard of them accusamus labore sustainable VHS.
                    </div>
                    </div>
                </div>
                <div class="accordion-item col-md-6">
                    <h2 class="accordion-header" id="flush-headingSix">
                    <button
                        class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_c_don , sfalse : !$store.state.resdata.met_c_don}"
                        type="button" :disabled="!$store.state.resdata.met_c_don"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#flush-collapseSix"
                        aria-expanded="false"
                        aria-controls="flush-collapseSix"
                    >
                    <div style="pointer-events: none" class="d-inline text-center disabled">Scenario C, Donnor site:<img src="@/assets/svg/splicingCD.svg" height="38" class="m-2"></div>
                    </button>
                    </h2>
                    <div
                    id="flush-collapseSix"
                    class="accordion-collapse collapse"
                    aria-labelledby="flush-headingSix"
                    data-mdb-parent="#accordionFlushExample"
                    >
                    <div class="accordion-body">
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry
                        richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor
                        brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                        sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch
                        et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt
                        sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat
                        craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't
                        heard of them accusamus labore sustainable VHS.
                    </div>
                    </div>
                </div>

            
            </div>

            <div class="note note-info text-start mt-4"><strong>Final Report:</strong> 
            <p>{{ $store.state.resdata.Report.slice(1).join("\n") }}</p>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Report'
    }
</script>

<style scoped>
.report{
    margin-left : 10%;
    margin-right:10%;
    background: #ebf0f8;
    white-space:pre-wrap;
    box-shadow : none;
}
.strue{
    background-color: #20c997;
    color:white;
    }
.sfalse{
    background-color: #f93154;
    color:white;
}

.collapsed{
    color:white!important;
}

button:disabled.accordion-button::after{
    display :none;
}
.accordion-item{
    background : none;
    border: none;
}
.accordion-item:last-of-type .accordion-button.collapsed{
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
}
.accordion-button:after{
    background-image: url('~@/assets/svg/arrow-white.svg');
}

.accordion-button:not(.collapsed):after{
    background-image:  url('~@/assets/svg/arrow-blue.svg');
}
.accordion-button:not(.collapsed){
    background-color: #9BB1FF;
    color:#2A4484
}
@media (max-width: 800px) {
  .fullwidth{
    margin-right: 1%;
    margin-left: 1%;
  }
}
</style>