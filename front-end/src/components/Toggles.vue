<template>
    <div class="accordion accordion-flush d-flex row" id="accordionFlushExample">
        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingOne">
            <button
                class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_a_acc , sfalse : !$store.state.resdata.met_a_acc}"
                type="button"
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
                <div v-if="$store.state.resdata.met_a_acc" class=" py-2">
                    <div class="row">
                        <div class="col-sm-6">
                            <span class="fs-italic">Motif: </span>
                            <span class="text-success fw-bold">{{ $store.state.resdata.scen_a_var_acc_motif }}</span>
                        </div>
                        <div class="col-sm-6">
                            <span class="fs-italic">Score: </span>
                            <span class="text-success fw-bold">{{ $store.state.resdata.scen_a_var_acc_motif_score }}</span>
                        </div>
                        <div class="col-sm-6">
                            <span class="fs-italic">Ratio: </span>
                            <span class="text-success fw-bold">{{ $store.state.resdata.scen_a_acc_ratio }}</span>
                        </div>
                    </div>
                </div>
                <div v-else>
                    This variant doesn't meet type A - Acceptor site scenario.
                </div>
            </div>
            </div>
        </div>
        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingTwo">
            <button
                class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_a_don , sfalse : !$store.state.resdata.met_a_don}"
                type="button"
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
                <div v-if="$store.state.resdata.met_a_don" class=" py-2">
                    
                    <div class="row">
                        <div class="col-sm-6">
                            <span class="fs-italic">Motif: </span>
                            <span class="text-success fw-bold">{{ $store.state.resdata.scen_a_var_don_motif }}</span>
                        </div>
                        <div class="col-sm-6">
                            <span class="fs-italic">Score: </span>
                            <span class="text-success fw-bold">{{ $store.state.resdata.scen_a_var_don_motif_score }}</span>
                        </div>
                        <div class="col-sm-6">
                            <span class="fs-italic">Ratio: </span>
                            <span class="text-success fw-bold">{{ $store.state.resdata.scen_a_don_ratio }}</span>
                        </div>
                    </div>
                </div>
                <div v-else>
                    This variant doesn't meet type A - Donnor site scenario.
                </div>
            </div>
            </div>
        </div>
        

        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingThree">
            <button
                class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_b_acc , sfalse : !$store.state.resdata.met_b_acc}"
                type="button"
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
                <div v-if="$store.state.resdata.met_b_acc" class=" py-2">
                    
                    <div class="row">
                        <p v-if="$store.state.resdata.new_ag" class="text-success my-0">
                            This mutation produces new AG by changing 
                            <span class="text-danger">{{$store.state.resdata.scen_b_ref_ag_seq}}</span>
                            into 
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_ag_seq}}</span>
                            It makes a motif with the following sequence:
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_ag_motif}}</span>
                            Altered motif score: 
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_ag_motif_score}}</span>
                            Ratio: <span class="text-danger">{{$store.state.resdata.scen_b_acc_ratio}}</span>
                        </p>
                        <p v-if="!$store.state.resdata.new_ag">
                            This mutation doesn't produce new AG. It changes 
                            <span class="text-danger">{{$store.state.resdata.scen_b_ref_ag_seq}}</span>
                            into 
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_ag_seq}}</span>

                        </p>
                    </div>
                </div>
                <div v-if="!$store.state.resdata.met_b_acc">
                    This variant doesn't meet type B - Acceptor site scenario.
                </div>
            </div>
            </div>
        </div>
        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingFour">
            <button
                class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_b_don , sfalse : !$store.state.resdata.met_b_don}"
                type="button"
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
                <div v-if="$store.state.resdata.met_b_don" class=" py-2">
                    
                    <div class="row">
                        <p v-if="$store.state.resdata.new_gt" class="text-success my-0">
                            This mutation produces new GT by changing 
                            <span class="text-danger">{{$store.state.resdata.scen_b_ref_gt_seq}}</span>
                            into 
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_gt_seq}}</span>
                            It makes a motif with the following sequence:
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_gt_motif}}</span>
                            Altered motif score: 
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_gt_motif_score}}</span>
                            Ratio: <span class="text-danger">{{$store.state.resdata.scen_b_don_ratio}}</span>
                        </p>
                        <p v-if="!$store.state.resdata.new_gt">
                            This mutation doesn't produce new GT. It changes 
                            <span class="text-danger">{{$store.state.resdata.scen_b_ref_gt_seq}}</span>
                            into 
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_gt_seq}}</span>

                        </p>
                    </div>
                </div>
                <div v-if="!$store.state.resdata.met_b_don">
                    This variant doesn't meet type B - Donnor site scenario.
                </div>
            </div>
            </div>
        </div>


        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingFive">
            <button
                class="accordion-button collapsed" :class="{ strue: $store.state.resdata.met_c_acc , sfalse : !$store.state.resdata.met_c_acc}"
                type="button"
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
                type="button"
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
</template>

<script>
    export default {
        name : 'Toggles'
    }
</script>

<style scoped>
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
    margin-bottom:1px;
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
    background-color: #39c0ed;
    color:#2A4484
}
</style>