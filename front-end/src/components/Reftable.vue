<template>
    <div>
        <div class="card">
                <table class="table align-middle table-responsive border-success">
                    <tbody class="fw-bold">
                        <tr class="lowh">
                            <th scope="row p-0">Reference Gene</th>
                            <td class="text-success p-0">{{ $store.state.resdata.ref_id }}</td>
                        </tr>
                        <tr class="lowh">
                            <th scope="row p-0">Genomic description</th>
                            <td class="text-success p-0 text-break">{{ $store.state.resdata.g_des }}</td>
                        </tr>
                        <tr class="lowh">
                            <th scope="row p-0">Genomic position</th>
                            <td class="text-success p-0">{{ $store.state.resdata.g_pos }}</td>
                        </tr>
                        <tr class="lowh">
                            <th scope="row p-0">Reference Allele</th>
                            <td class="text-success p-0">{{ $store.state.resdata.ref_allele }}</td>
                        </tr>
                        <tr class="lowh">
                            <th scope="row p-0">Altered to</th>
                            <td class="text-success p-0">{{ $store.state.resdata.alt_allele }}</td>
                        </tr>
                        <tr class="lowh" v-if="$store.state.resdata.rep_status==1">
                            <th scope="row p-0">Affected exon</th>
                            <td class="text-success p-0">{{ $store.state.resdata.aff_exon }}</td>
                        </tr>
                        <tr class="lowh" v-if="$store.state.resdata.rep_status==1">
                            <th scope="row p-0">Exon Start</th>
                            <td class="text-success p-0">{{ $store.state.resdata.aff_exon_start }}</td>
                        </tr>
                        <tr class="lowh" v-if="$store.state.resdata.rep_status==1">
                            <th scope="row p-0">Exon End</th>
                            <td class="text-success p-0">{{ $store.state.resdata.aff_exon_end }}</td>
                        </tr>
                    </tbody>
                </table>
                <div v-if="$store.state.resdata.rep_status==1">
                    <div class="border-bottom border-success pb-2">
                        <p class="fw-light text-muted">Wild-Type cannonical Acceptor site</p>
                        <div class="row">
                            <div class="col-sm-8 mb-2">
                                <span class="fs-italic">Motif: </span>
                                <span class="text-success fw-bold">{{ $store.state.resdata.wt_can_acc_motif }}</span>
                            </div>
                           <div class="col-sm-4">
                                <span class="fs-italic">Score: </span>
                                <span class="text-success fw-bold">{{ $store.state.resdata.wt_can_acc_motif_score }}</span>
                           </div>
                        </div>
                    </div>
                    <div class="border-bottom border-success pt-3 pb-2">
                        <p class="fw-light text-muted">Wild-Type cannonical Donnor site</p>
                        <div class="row">
                            <div class="col-sm-8 mb-2">
                                <span class="fs-italic">Motif: </span>
                                <span class="text-success fw-bold">{{ $store.state.resdata.wt_can_don_motif }}</span>
                            </div>
                           <div class="col-sm-4">
                                <span class="fs-italic">Score: </span>
                                <span class="text-success fw-bold">{{ $store.state.resdata.wt_can_don_motif_score }}</span>
                           </div>
                        </div>
                    </div>
                    <div class="pt-3">
                        <p class="text-danger" v-if="$store.state.resdata.cano_inv=='NA'">
                            This variant doesn't have any canonical site involvements.
                        </p>
                        <p class="text-danger" v-else>
                            This variant has canonical site involvment.
                        </p>
                    </div>

                </div>
                

                <p class="text-danger px-1 pb-1">{{ $store.state.resdata.note }}</p>
            </div>
            
    </div>
</template>

<script>
    export default {
        name: 'Reftable'
    }
</script>

<style scoped>
@media (min-width: 400px) {
    .lowh {
    line-height: 5px;
    }
}
.card{
    line-height:10px;
}

</style>