<template>
    <div class="report card fullwidth" style="margin-top: -3%; margin-bottom: 3%;">
        <div v-if="$store.state.resdata.rep_status==3">
            
            <p class="note note-danger"><strong></strong> 
            {{ $store.state.resdata.war_msg }}
            </p>
        </div>
        <div v-if="$store.state.resdata.rep_status==2">
            
            <p class="note note-danger"><strong></strong> 
            {{ $store.state.resdata.intp }}
            </p>
            
            <Reftable />
            
        </div>
        <div class="" v-if="$store.state.resdata.rep_status==1">
            <p v-if="$store.state.resdata.cano_inv=='NA'" class="note note-success"><strong></strong> 
            {{ $store.state.resdata.intp }}
            </p>
            <p v-if="$store.state.resdata.cano_inv!='NA'" class="note note-danger"><strong>Warning: </strong> 
            The variant affects canonical splicing sites. 
            </p>
            <Reftable />
            <br>
            <Toggles v-if="$store.state.resdata.cano_inv=='NA'" />

            <div v-if="$store.state.resdata.cano_inv!='NA'" class="d-none"><strong>Text Report:</strong> 
            </div>
            <div v-else class="note note-info text-start mt-4"><strong>Text Report:</strong> 
            <p>{{ $store.state.resdata.Report.slice(1).join("\n") }}</p>
            </div>
        </div>
    </div>
</template>

<script>
import Reftable from '@/components/Reftable.vue'
import Toggles from '@/components/Toggles.vue'
    export default {
        name: 'Report',
        components: {
            Reftable, Toggles
        }
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
@media (max-width: 800px) {
  .fullwidth{
    margin-right: 1%;
    margin-left: 1%;
  }
}


</style>