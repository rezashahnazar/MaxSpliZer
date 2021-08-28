<template>
    <div class="report card fullwidth">
        <div v-if="$store.state.resdata.rep_status==3">
            
            <p class="note note-danger"><strong>Sorry!</strong> 
            {{ $store.state.resdata.war_msg }}
            </p>
        </div>
        <div v-if="$store.state.resdata.rep_status==2">
            
            <p class="note note-success"><strong>Well!</strong> 
            {{ $store.state.resdata.intp }}
            </p>
            
            <Reftable />
            
        </div>
        <div class="" v-if="$store.state.resdata.rep_status==1">
            <p class="note note-success"><strong>Well!</strong> 
            {{ $store.state.resdata.intp }}
            </p>
            <Reftable />
            <br>
            <Toggles />

            <div class="note note-dark text-start mt-4"><strong>Text Report:</strong> 
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