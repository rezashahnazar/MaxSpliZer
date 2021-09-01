<template>
    <div class="accordion accordion-flush d-flex row" id="accordionFlushToggler">
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
            <div class="row">
                <div style="pointer-events: none" class="text-center disabled col-12">Scenario A, Acceptor site</div>
                <div class="col-12 text-center"><img src="@/assets/svg/aa.svg" height="38" class="m-2"></div>
            </div>
            </button>
            </h2>
            <div
            id="flush-collapseOne"
            class="accordion-collapse collapse"
            aria-labelledby="flush-headingOne"
            data-mdb-parent="#accordionFlushToggler"
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
                    The variant is not located at -20 to +3 bases of canonical acceptor splicing site of any exons.
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
            

            <div class="row">
                <div style="pointer-events: none" class="text-center disabled col-12">Scenario A, Donor site</div>
                <div class="col-12 text-center"><img src="@/assets/svg/ad.svg" height="38" class="m-2"></div>
            </div>
            </button>

            </h2>
            <div
            id="flush-collapseTwo"
            class="accordion-collapse collapse"
            aria-labelledby="flush-headingTwo"
            data-mdb-parent="#accordionFlushToggler"
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
                    The variant is not located at -3 to +6 bases of canonical donor splicing site of any exons.
                </div>
            </div>
            </div>
        </div>
        

        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingThree">
            <button
                class="accordion-button collapsed" 
                :class="[ $store.state.resdata.met_b_acc==1 && $store.state.resdata.new_ag==1 ? 'strue' : 'sfalse', ]"
                type="button"
                data-mdb-toggle="collapse"
                data-mdb-target="#flush-collapseThree"
                aria-expanded="false"
                aria-controls="flush-collapseThree"
            >
            <div class="row">
                <div style="pointer-events: none" class="text-center disabled col-12">Scenario B, Acceptor site</div>
                <div class="col-12 text-center"><img src="@/assets/svg/ba.svg" height="38" class="m-2"></div>
            </div>
            </button>

            
            </h2>
            <div
            id="flush-collapseThree"
            class="accordion-collapse collapse"
            aria-labelledby="flush-headingThree"
            data-mdb-parent="#accordionFlushToggler"
            >
            <div class="accordion-body">
                <div v-if="$store.state.resdata.met_b_acc" class=" py-2">
                    
                    <div class="row">
                        <p v-if="$store.state.resdata.new_ag" class="text-success my-0">
                            Variant is located within the range and creates denovo AG site.
                            Wild type canonical acceptor motif:
                            <span class="text-danger">{{ $store.state.resdata.wt_can_acc_motif }}</span>
                            :
                            <span class="text-danger">{{ $store.state.resdata.wt_can_acc_motif_score }}</span>
                            Variant denovo acceptor motif:
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_ag_motif}}</span>
                            :
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_ag_motif_score}}</span>
                            denovo Var/Wt ratio =
                            <span class="text-danger">{{$store.state.resdata.scen_b_acc_ratio}}</span>
                        </p>
                        <p v-if="!$store.state.resdata.new_ag">
                            The variant is located within the range but does not create denovo AG site.
                        </p>
                    </div>
                </div>
                <div v-if="!$store.state.resdata.met_b_acc">
                    The variant is out of range. No need to studying denovo AG site.
                </div>
            </div>
            </div>
        </div>
        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingFour">
            <button
                class="accordion-button collapsed" :class="[ $store.state.resdata.met_b_don==1 && $store.state.resdata.new_gt==1 ? 'strue' : 'sfalse', ]"
                type="button"
                data-mdb-toggle="collapse"
                data-mdb-target="#flush-collapseFour"
                aria-expanded="false"
                aria-controls="flush-collapseFour"
            >
            <div class="row">
                <div style="pointer-events: none" class="text-center disabled col-12">Scenario B, Donor site</div>
                <div class="col-12 text-center"><img src="@/assets/svg/bd.svg" height="38" class="m-2"></div>
            </div>
            </button>
            
            </h2>
            <div
            id="flush-collapseFour"
            class="accordion-collapse collapse"
            aria-labelledby="flush-headingFour"
            data-mdb-parent="#accordionFlushToggler"
            >
            <div class="accordion-body">
                <div v-if="$store.state.resdata.met_b_don" class=" py-2">
                    
                    <div class="row">
                        <p v-if="$store.state.resdata.new_gt" class="text-success my-0">
                            Variant is located within the range and creates denovo GT site.
                            Wild type canonical donor motif:
                            <span class="text-danger">{{ $store.state.resdata.wt_can_don_motif }}</span>
                            :
                            <span class="text-danger">{{ $store.state.resdata.wt_can_don_motif_score }}</span>
                            Variant denovo donor motif:
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_gt_motif}}</span>
                            :
                            <span class="text-danger">{{$store.state.resdata.scen_b_alt_gt_motif_score}}</span>
                            denovo Var/Wt ratio =
                            <span class="text-danger">{{$store.state.resdata.scen_b_don_ratio}}</span>
                        </p>
                        <p v-if="!$store.state.resdata.new_gt">
                            The variant is located within the range but does not create denovo GT site.
                        </p>
                    </div>
                </div>
                <div v-if="!$store.state.resdata.met_b_don">
                    The variant is out of range. No need to studying denovo GT site.
                </div>
            </div>
            </div>
        </div>


        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingFive">
            <button
                class="accordion-button collapsed" 
                :class="[ $store.state.resdata.met_b_acc==1 && $store.state.resdata.new_ag==0 && $store.state.resdata.scen_c_ag_up + $store.state.resdata.scen_c_ag_down > 0 ? 'strue' : 'sfalse', ]"
                type="button"
                data-mdb-toggle="collapse"
                data-mdb-target="#flush-collapseFive"
                aria-expanded="false"
                aria-controls="flush-collapseFive"
            >

            <div class="row">
                <div style="pointer-events: none" class="text-center disabled col-12">Scenario C, Acceptor site</div>
                <div class="col-12 text-center"><img src="@/assets/svg/ca.svg" height="38" class="m-2"></div>
            </div>
            </button>
            </h2>
            <div
            id="flush-collapseFive"
            class="accordion-collapse collapse"
            aria-labelledby="flush-headingFive"
            data-mdb-parent="#accordionFlushToggler"
            >
            <div class="accordion-body">
                

                <div v-if="$store.state.resdata.scen_c_ag_up" class=" py-2">
                    
                    <div v-if="!$store.state.resdata.new_ag">
                        <div class="row">
                        <p class="text-success my-0">
                            There is an upstram cryptic AG site close enough to the canonical acceptor AG of an exon.
                            The cryptic acceptor motif is originally 
                            <span class="text-danger">{{$store.state.resdata.scen_c_wt_acc_cryp_up_motif}}</span>
                            <span class="text-danger"> (score: {{$store.state.resdata.scen_c_wt_acc_cryp_up_motif_score}})</span>
                            which is altered to 
                            <span class="text-danger">{{$store.state.resdata.scen_c_var_acc_cryp_up_motif}}</span>
                            <span class="text-danger"> (score: {{$store.state.resdata.scen_c_var_acc_cryp_up_motif_score}})</span>
                            . Therefore, "var. cryptic" to "wt. cryptic" ratio is 
                            <span class="text-danger">{{$store.state.resdata.scen_c_acc_up_ratio1}} </span>
                            and "var. cryptic" to "wt. canonical" ratio is 
                            <span class="text-danger">{{$store.state.resdata.scen_c_acc_up_ratio2}}</span>                         
                        </p>
                    </div>
                    <div v-if="$store.state.resdata.new_ag">
                        <p>
                            The variant is within the range but creates a denovo AG. No need to studying nearby AG site.
                        </p>
                    </div>

                    </div>
                </div>
                <div v-if="$store.state.resdata.scen_c_ag_down" class=" py-2">
                    <div v-if="!$store.state.resdata.new_ag">
                        <div class="row">
                            <p class="text-success my-0">
                                There is a downstream cryptic AG site close enough to the canonical acceptor AG of an exon.
                                The cryptic acceptor motif is originally 
                                <span class="text-danger">{{$store.state.resdata.scen_c_wt_acc_cryp_down_motif}}</span>
                                <span class="text-danger"> (score: {{$store.state.resdata.scen_c_wt_acc_cryp_down_motif_score}})</span>
                                which is altered to 
                                <span class="text-danger">{{$store.state.resdata.scen_c_var_acc_cryp_down_motif}}</span>
                                <span class="text-danger"> (score: {{$store.state.resdata.scen_c_var_acc_cryp_down_motif_score}})</span>
                                . Therefore, "var. cryptic" to "wt. cryptic" ratio is 
                                <span class="text-danger">{{$store.state.resdata.scen_c_acc_down_ratio1}} </span>
                                and "var. cryptic" to "wt. canonical" ratio is 
                                <span class="text-danger">{{$store.state.resdata.scen_c_acc_down_ratio2}}</span>                         
                            </p>
                        </div>
                    </div>
                    <div v-if="$store.state.resdata.new_ag">
                        <p>
                            The variant is within the range but creates a denovo AG. No need to studying nearby AG site.
                        </p>
                    </div>
                </div>
                <div v-if="$store.state.resdata.scen_c_ag_up + $store.state.resdata.scen_c_ag_down == 0">
                    There is no AG in downstream (20 Nt) or upstream (3 Nt).
                </div>


            </div>
            </div>
        </div>
        <div class="accordion-item col-md-6">
            <h2 class="accordion-header" id="flush-headingSix">
            <button
                class="accordion-button collapsed" 
                :class="[ $store.state.resdata.met_b_don==1 && $store.state.resdata.new_gt==0 && $store.state.resdata.scen_c_gt_up + $store.state.resdata.scen_c_gt_down > 0 ? 'strue' : 'sfalse', ]"
                type="button"
                data-mdb-toggle="collapse"
                data-mdb-target="#flush-collapseSix"
                aria-expanded="false"
                aria-controls="flush-collapseSix"
            >
            <div class="row">
                <div style="pointer-events: none" class="text-center disabled col-12">Scenario C, Donor site</div>
                <div class="col-12 text-center"><img src="@/assets/svg/cd.svg" height="38" class="m-2"></div>
            </div>
            </button>
            </h2>
            <div
            id="flush-collapseSix"
            class="accordion-collapse collapse"
            aria-labelledby="flush-headingSix"
            data-mdb-parent="#accordionFlushToggler"
            >
            <div class="accordion-body">
                <div v-if="$store.state.resdata.scen_c_gt_up" class=" py-2">
                    <div v-if="!$store.state.resdata.new_gt">
                        <div class="row">
                            <p class="text-success my-0">
                                There is an upstram cryptic GT site close enough to the canonical donor GT of an exon.
                                The cryptic donor motif is originally 
                                <span class="text-danger">{{$store.state.resdata.scen_c_wt_don_cryp_up_motif}}</span>
                                <span class="text-danger"> (score: {{$store.state.resdata.scen_c_wt_don_cryp_up_motif_score}})</span>
                                which is altered to 
                                <span class="text-danger">{{$store.state.resdata.scen_c_var_don_cryp_up_motif}}</span>
                                <span class="text-danger"> (score: {{$store.state.resdata.scen_c_var_don_cryp_up_motif_score}})</span>
                                . Therefore, "var. cryptic" to "wt. cryptic" ratio is 
                                <span class="text-danger">{{$store.state.resdata.scen_c_don_up_ratio1}} </span>
                                and "var. cryptic" to "wt. canonical" ratio is 
                                <span class="text-danger">{{$store.state.resdata.scen_c_don_up_ratio2}}</span>                         
                            </p>
                        </div>
                    </div>
                    <div v-if="$store.state.resdata.new_gt">
                        <p>
                            The variant is within the range but creates a denovo GT. No need to studying nearby GT site.
                        </p>
                    </div>
                </div>
                <div v-if="$store.state.resdata.scen_c_gt_down" class=" py-2">
                    
                    <div v-if="!$store.state.resdata.new_gt">
                        <div class="row">
                        <p class="text-success my-0">
                            There is a downstream cryptic GT site close enough to the canonical donor GT of an exon.
                            The cryptic donor motif is originally 
                            <span class="text-danger">{{$store.state.resdata.scen_c_wt_don_cryp_down_motif}}</span>
                            <span class="text-danger"> (score: {{$store.state.resdata.scen_c_wt_don_cryp_down_motif_score}})</span>
                            which is altered to 
                            <span class="text-danger">{{$store.state.resdata.scen_c_var_don_cryp_down_motif}}</span>
                            <span class="text-danger"> (score: {{$store.state.resdata.scen_c_var_don_cryp_down_motif_score}})</span>
                            . Therefore, "var. cryptic" to "wt. cryptic" ratio is 
                            <span class="text-danger">{{$store.state.resdata.scen_c_don_down_ratio1}} </span>
                            and "var. cryptic" to "wt. canonical" ratio is 
                            <span class="text-danger">{{$store.state.resdata.scen_c_don_down_ratio2}}</span>                         
                        </p>
                    </div>
                    </div>
                    <div v-if="$store.state.resdata.new_gt">
                        <p>
                            The variant is within the range but creates a denovo GT. No need to studying nearby GT site.
                        </p>
                    </div>
                </div>
                <div v-if="$store.state.resdata.scen_c_gt_up + $store.state.resdata.scen_c_gt_down == 0">
                    There is no GT in downstream (3 Nt) or upstream (6 Nt).
                </div>
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